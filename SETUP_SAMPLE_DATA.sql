-- ================================================
-- Employee Tracking Portal: Sample Data Setup
-- ================================================
-- Execute this in Supabase SQL Editor to add sample users and tasks
-- URL: https://supabase.com/dashboard/project/ftzpjtvyrrnjjcvrtsab/sql/new

-- STEP 1: Add Sample User Profiles
INSERT INTO public.user_profiles (id, email, full_name, organization_id, department, role, status, created_at, updated_at)
VALUES
  ('b1c2d3e4-5678-90ab-cdef-123456789001', 
   'sarah.jenkins@redeemedenterprises.com', 
   'Sarah Jenkins', 
   (SELECT id FROM public.organizations WHERE name = 'Redeemed Enterprises' LIMIT 1), 
   'Operations', 'manager', 'active', NOW(), NOW()),
  ('b1c2d3e4-5678-90ab-cdef-123456789002', 
   'mike.rodriguez@heinepropane.com', 
   'Mike Rodriguez', 
   (SELECT id FROM public.organizations WHERE name = 'Heine Propane' LIMIT 1), 
   'Field Service', 'employee', 'active', NOW(), NOW()),
  ('b1c2d3e4-5678-90ab-cdef-123456789003', 
   'jennifer.kim@redeemedenterprises.com', 
   'Jennifer Kim', 
   (SELECT id FROM public.organizations WHERE name = 'Redeemed Enterprises' LIMIT 1), 
   'IT', 'employee', 'active', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- STEP 2: Add Sample Tasks (assigned to admin: 9b0b95c9-8007-462f-bac8-80abadb5307c)
INSERT INTO public.tasks (title, description, assigned_to, organization_id, status, priority, due_date, created_at, updated_at)
VALUES
  ('Complete Q4 Safety Compliance Report', 
   'Finalize and submit quarterly safety compliance documentation for all field operations. Include incident reports, training records, and equipment inspections.',
   '9b0b95c9-8007-462f-bac8-80abadb5307c',
   (SELECT id FROM public.organizations WHERE name = 'Redeemed Enterprises' LIMIT 1),
   'completed', 'high', (NOW() - INTERVAL '5 days'), NOW() - INTERVAL '10 days', NOW()),
   
  ('Review Tank Inventory for Heine Propane', 
   'Audit current propane tank inventory across all Heine locations. Verify counts match system records and identify any discrepancies.',
   '9b0b95c9-8007-462f-bac8-80abadb5307c',
   (SELECT id FROM public.organizations WHERE name = 'Heine Propane' LIMIT 1),
   'in_progress', 'urgent', (NOW() + INTERVAL '2 days'), NOW() - INTERVAL '3 days', NOW()),
   
  ('Update Emergency Response Procedures', 
   'Review and update emergency response protocols for propane leak scenarios. Coordinate with local fire departments for approval.',
   '9b0b95c9-8007-462f-bac8-80abadb5307c',
   (SELECT id FROM public.organizations WHERE name = 'Redeemed Enterprises' LIMIT 1),
   'pending', 'high', (NOW() - INTERVAL '2 days'), NOW() - INTERVAL '7 days', NOW()),
   
  ('Schedule Vehicle Maintenance for Fleet', 
   'Coordinate quarterly maintenance for all delivery vehicles. Priority for trucks due for DOT inspections.',
   '9b0b95c9-8007-462f-bac8-80abadb5307c',
   (SELECT id FROM public.organizations WHERE name = 'Parafour' LIMIT 1),
   'in_progress', 'medium', (NOW() + INTERVAL '7 days'), NOW() - INTERVAL '1 day', NOW()),
   
  ('Prepare Annual Budget Forecast', 
   'Create preliminary budget projections for next fiscal year. Include capital expenditures for new equipment and facility upgrades.',
   '9b0b95c9-8007-462f-bac8-80abadb5307c',
   (SELECT id FROM public.organizations WHERE name = 'Redeemed Enterprises' LIMIT 1),
   'pending', 'low', (NOW() + INTERVAL '14 days'), NOW(), NOW());

-- STEP 3: Verification
SELECT 
  'Setup Complete!' as status,
  (SELECT COUNT(*) FROM public.user_profiles) as total_users,
  (SELECT COUNT(*) FROM public.tasks WHERE assigned_to = '9b0b95c9-8007-462f-bac8-80abadb5307c') as admin_tasks;

-- Expected output:
-- total_users: 4 (1 admin + 3 new employees)
-- admin_tasks: 5
