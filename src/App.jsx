import { useState } from 'react';

const tableGroups = {
  customer: {
    name: 'Customer & Household',
    color: '#3B82F6',
    tables: [
      { id: 'customer_mstr', name: 'SAS_CUSTOMER_MSTR_VW', x: 100, y: 100, keys: ['customer_id', 'household_id', 'mstr_customer_id', 'mstr_household_id', 'birth_mmdd', 'sex'] },
      { id: 'customer_bu', name: 'SAS_CUSTOMER_MSTR_BU_VW', x: 100, y: 280, keys: ['customer_id', 'household_id', 'mstr_customer_id', 'business_unit', 'centile_m1', 'centile_m2'] },
      { id: 'household', name: 'SAS_HOUSEHOLD_VW', x: 100, y: 460, keys: ['household_id', 'customer_id', 'birth_mmdd', 'country_code'] },
      { id: 'household_bu', name: 'SAS_HOUSEHOLD_BU_VW', x: 100, y: 640, keys: ['household_id', 'customer_id', 'business_unit', 'centile_m1'] },
      { id: 'suppress', name: 'SAS_CUST_MSTR_SUPPRESS', x: 100, y: 820, keys: ['customer_id', 'business_unit', 'media_type', 'suppress_reason'] }
    ]
  },
  contact: {
    name: 'Contact Information',
    color: '#10B981',
    tables: [
      { id: 'email', name: 'SAS_EMAIL_ADDRESSES_VW', x: 480, y: 100, keys: ['customer_id', 'household_id', 'email_id', 'mstr_customer_id', 'business_unit', 'email_address'] },
      { id: 'phone', name: 'SAS_C_PHONE_VW', x: 480, y: 280, keys: ['customer_id', 'household_id', 'mstr_customer_id', 'business_unit', 'h_phone', 'cell_phone'] },
      { id: 'contact_summ', name: 'SAS_CONTACT_SUMM_MSTR_VW', x: 480, y: 460, keys: ['mstr_customer_id', 'mstr_household_id', 'business_unit', 'promotion_date'] }
    ]
  },
  transaction: {
    name: 'Transactions',
    color: '#F59E0B',
    tables: [
      { id: 'transaction', name: 'SAS_TRANSACTION_VW', x: 860, y: 100, keys: ['customer_id', 'household_id', 'order_id', 'transaction_no', 'mstr_customer_id', 'business_unit', 'sku'] },
      { id: 'tender', name: 'SAS_TRANS_TENDER', x: 860, y: 280, keys: ['customer_id', 'household_id', 'order_id', 'transaction_no', 'mstr_customer_id', 'tender_id'] },
      { id: 'offer', name: 'SAS_OFFER_VW', x: 860, y: 460, keys: ['customer_id', 'household_id', 'order_id', 'promotion_id', 'business_unit', 'discount_code'] }
    ]
  },
  marketing: {
    name: 'Marketing & Promotions',
    color: '#8B5CF6',
    tables: [
      { id: 'promo_history', name: 'SAS_PROMO_HISTORY_VW', x: 480, y: 640, keys: ['customer_id', 'household_id', 'promotion_id', 'mstr_customer_id', 'segment_key'] },
      { id: 'promotion', name: 'SAS_PROMOTION_VW', x: 480, y: 820, keys: ['promotion_id', 'client_promo_id', 'promotion_title', 'in_home_date'] },
      { id: 'email_trans', name: 'SAS_EMAIL_TRANS_VW', x: 480, y: 1000, keys: ['customer_id', 'household_id', 'promotion_id', 'email_id', 'mstr_customer_id', 'action_code'] }
    ]
  },
  reference: {
    name: 'Reference Tables',
    color: '#6B7280',
    tables: [
      { id: 'lookup', name: 'SAS_LOOKUP_VW', x: 1240, y: 100, keys: ['code_id', 'code', 'code_description', 'description'] },
      { id: 'calendar', name: 'SAS_CALENDAR', x: 1240, y: 280, keys: ['exact_day_dt', 'calendar_year', 'fyr', 'fmm', 'fwk'] },
      { id: 'store', name: 'SAS_STORE_DETAIL', x: 1240, y: 460, keys: ['store_number', 'business_unit', 'store_name', 'store_type'] },
      { id: 'sku', name: 'SAS_SKU_XREF_VW', x: 1240, y: 640, keys: ['long_item_number', 'business_unit', 'vendor_style_no', 'label_code'] }
    ]
  },
  analytics: {
    name: 'Analytics & Clickstream',
    color: '#EC4899',
    tables: [
      { id: 'clickstream', name: 'CLICKSTREAM_AGGREGATE_VW', x: 860, y: 640, keys: ['gcd_customer_id', 'gcd_household_id', 'mstr_customer_id', 'fyr', 'fmm', 'fwk'] }
    ]
  },
  salesforce: {
    name: 'Salesforce (SFMC)',
    color: '#14B8A6',
    tables: [
      { id: 'sf_sent', name: 'ENT_RLEU_CWW_Sent', x: 100, y: 1000, keys: ['subscriberkey', 'subscriberid', 'sendid', 'clientid'] },
      { id: 'sf_opens', name: 'ENT_RLEU_CWW_Opens', x: 860, y: 820, keys: ['subscriberkey', 'subscriberid', 'sendid', 'clientid'] },
      { id: 'sf_clicks', name: 'ENT_RLEU_CWW_Clicks', x: 860, y: 1000, keys: ['subscriberkey', 'subscriberid', 'sendid', 'url'] }
    ]
  }
};

const relationships = [
  { from: 'customer_mstr', to: 'customer_bu' },
  { from: 'customer_mstr', to: 'household' },
  { from: 'household', to: 'household_bu' },
  { from: 'customer_mstr', to: 'email' },
  { from: 'customer_mstr', to: 'phone' },
  { from: 'customer_mstr', to: 'transaction' },
  { from: 'transaction', to: 'tender' },
  { from: 'transaction', to: 'offer' },
  { from: 'customer_mstr', to: 'promo_history' },
  { from: 'promotion', to: 'promo_history' },
  { from: 'email', to: 'email_trans' },
  { from: 'customer_mstr', to: 'clickstream' },
  { from: 'transaction', to: 'sku' }
];

function App() {
  const [selectedTable, setSelectedTable] = useState(null);
  const [zoom, setZoom] = useState(1);

  const getTablePosition = (tableId) => {
    for (const group of Object.values(tableGroups)) {
      const table = group.tables.find(t => t.id === tableId);
      if (table) return { x: table.x, y: table.y };
    }
    return { x: 0, y: 0 };
  };

  const handleZoomIn = () => setZoom(Math.min(zoom + 0.1, 2));
  const handleZoomOut = () => setZoom(Math.max(zoom - 0.1, 0.5));
  const handleResetZoom = () => setZoom(1);

  return (
    <div style={{ display: 'flex', flexDirection: 'column', height: '100vh', background: '#f9fafb' }}>
      {/* Header */}
      <div style={{ background: 'white', padding: '16px', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div>
          <h1 style={{ fontSize: '24px', fontWeight: 'bold', color: '#1f2937' }}>Redshift Database Schema</h1>
          <p style={{ fontSize: '14px', color: '#6b7280' }}>Data Container Entity Relationship Diagram</p>
        </div>
        <div style={{ display: 'flex', gap: '8px' }}>
          <button onClick={handleZoomIn} style={{ padding: '8px 16px', background: '#3b82f6', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>Zoom In</button>
          <button onClick={handleZoomOut} style={{ padding: '8px 16px', background: '#3b82f6', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>Zoom Out</button>
          <button onClick={handleResetZoom} style={{ padding: '8px 16px', background: '#6b7280', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>Reset</button>
        </div>
      </div>

      {/* Legend */}
      <div style={{ background: 'white', borderBottom: '1px solid #e5e7eb', padding: '12px', display: 'flex', flexWrap: 'wrap', gap: '16px', fontSize: '14px' }}>
        {Object.entries(tableGroups).map(([key, group]) => (
          <div key={key} style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <div style={{ width: '16px', height: '16px', borderRadius: '4px', backgroundColor: group.color }}></div>
            <span style={{ color: '#374151' }}>{group.name}</span>
          </div>
        ))}
        <div style={{ marginLeft: '16px', color: '#6b7280', fontStyle: 'italic' }}>Click tables to see all key fields</div>
      </div>

      {/* Canvas */}
      <div style={{ flex: 1, overflow: 'auto', padding: '32px' }}>
        <svg width="1700" height="1250" style={{ transform: `scale(${zoom})`, transformOrigin: 'top left' }}>
          {/* Draw relationships */}
          {relationships.map((rel, idx) => {
            const from = getTablePosition(rel.from);
            const to = getTablePosition(rel.to);
            return (
              <line
                key={idx}
                x1={from.x + 180}
                y1={from.y + 50}
                x2={to.x}
                y2={to.y + 50}
                stroke="#CBD5E0"
                strokeWidth="2"
                strokeDasharray="5,5"
              />
            );
          })}

          {/* Draw tables */}
          {Object.entries(tableGroups).map(([groupKey, group]) =>
            group.tables.map((table) => {
              const displayKeys = selectedTable === table.id ? table.keys : table.keys.slice(0, 3);
              const boxHeight = 50 + displayKeys.length * 18;

              return (
                <g
                  key={table.id}
                  onClick={() => setSelectedTable(table.id === selectedTable ? null : table.id)}
                  style={{ cursor: 'pointer' }}
                >
                  <rect
                    x={table.x}
                    y={table.y}
                    width="340"
                    height={boxHeight}
                    fill="white"
                    stroke={group.color}
                    strokeWidth={selectedTable === table.id ? 3 : 2}
                    rx="5"
                  />
                  <rect
                    x={table.x}
                    y={table.y}
                    width="340"
                    height="30"
                    fill={group.color}
                    rx="5"
                  />
                  <text
                    x={table.x + 170}
                    y={table.y + 20}
                    textAnchor="middle"
                    fill="white"
                    fontSize="12"
                    fontWeight="bold"
                  >
                    {table.name}
                  </text>

                  {displayKeys.map((key, idx) => (
                    <text
                      key={idx}
                      x={table.x + 10}
                      y={table.y + 48 + idx * 18}
                      fill="#374151"
                      fontSize="11"
                      fontFamily="monospace"
                    >
                      🔑 {key}
                    </text>
                  ))}

                  {!selectedTable && table.keys.length > 3 && (
                    <text
                      x={table.x + 10}
                      y={table.y + boxHeight - 8}
                      fill="#9CA3AF"
                      fontSize="10"
                      fontStyle="italic"
                    >
                      + {table.keys.length - 3} more fields...
                    </text>
                  )}
                </g>
              );
            })
          )}
        </svg>
      </div>

      {/* Footer */}
      <div style={{ background: 'white', borderTop: '1px solid #e5e7eb', padding: '16px', fontSize: '14px' }}>
        <div style={{ display: 'flex', gap: '16px' }}>
          <div style={{ flex: 1 }}>
            <h3 style={{ fontWeight: 'bold', color: '#1f2937', marginBottom: '8px' }}>Database Overview</h3>
            <p style={{ color: '#6b7280' }}>
              This diagram shows {Object.values(tableGroups).reduce((sum, g) => sum + g.tables.length, 0)} main tables 
              organized into {Object.keys(tableGroups).length} functional groups. 
              Key fields are displayed for each table (🔑 = primary/foreign key).
              {selectedTable && ' Click outside to deselect.'}
            </p>
          </div>
          <div style={{ background: '#f9fafb', padding: '12px', borderRadius: '4px', color: '#6b7280' }}>
            <strong>Key Relationships:</strong><br />
            • customer_id / household_id link individuals and households<br />
            • mstr_customer_id consolidates customer records<br />
            • order_id connects transactions<br />
            • promotion_id links marketing campaigns
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
