Return-Path: <bpf+bounces-54032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59653A60DC7
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436A61892CD8
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020881F1303;
	Fri, 14 Mar 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="beKqw4RO"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB321EF0B9;
	Fri, 14 Mar 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945734; cv=fail; b=g87hVeoV7P7nB9hgGhoVxps1SbjAo/g5Jw4m4NCtPWGpv1Zepc9u5cTM6k+lflE582lOBqKl/SPeTfu8XN1V10Rvt9MAQfD7ATCy6qbeXqPOx8uLT5d0PLp0e6rkkwyE9DLzzSokAifMoSrADzZal5FrlLGzMQcXb6Pj+sOfRbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945734; c=relaxed/simple;
	bh=R13jwkuZ0Dj86K5nCS317BddN0NK56835Y0kdOJ5S08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ogpIVWzCK3mNWWnko5/q4qu5FohqQVX+dC++/hz+x9MjZGLR4rstx6/TwN6UukIKu46RQcD/IPR1G43YSjmgcnyWW++e9MXH2APURnkqYfAQwiLnBRc/TdoWLvlxUh8NHa0nSfet9zzLN2dbnm+97Y2CR2qQOBYGmlcmoFVLm4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=beKqw4RO; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es4G5UcrGnXF4LtgMFeGQr/Si2cplkjp8iJTtLjJiQlqN/GD+M+VDJ4mPS/s3GKRwvC+ksBEY1v4IFQELUPbxh3UK0G8uPyCSq9yzOW/2E1wcesEjzX+cRcssl7Yg22akLcvQrgcuS+1ed36JfmtbbWsmWpgZkTpQvGJls5AF4ekkgXTCBUwkcwJ0sUbxK9d5AKFCBK4YU/UKTqQ5WCf+cYki4/iygxGtRUNqPwIi0qljrHwoq7LDS/ch9GX2mfLMfZQCv2vxA+PIEDFJPvKSXW70WJKgZA1Q7Km7b7OP5FcXHew42d5aBcgTWZukaD3vhxaD5jeNxf+1+cIx+spBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRou4w4PAlHHzr5GTM3lO0oFYjmQgKqjXBWlNu9jecU=;
 b=ksKYJ4O3huEjny720h8HNb2i0HIamQsfLFjKV26BTVVmetOeUVniuSdV2SC+ED4vpzs0e1zduBcwaGx5I973xMnZX6SnFgXgLcs0MSqc0GlSxpHzOex7pd3A0Hes1tldSu8bfDv4YRAoG4mNMZhp8R8Ky0x6devuUQWDsK8O+w4h7E5gJci6KapdLsHRhf62Dwckr5ekzYY+0zqTZgAsYGX8Vv31Ss4xPSLhcTQ7cJTqKHYshgt1G/Pazw/iWVtDUPeQuuu/jwQ7873f93L/5oySYRXWwNr29XV8jws0k+ILuE5NT5fT92riyLqc816SEpsNa6puXzpvwIQTtlUqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRou4w4PAlHHzr5GTM3lO0oFYjmQgKqjXBWlNu9jecU=;
 b=beKqw4ROEqT5avp1OxUkeYBoXN4QOSx4i9WAs+oybXaPv6B+tuBQDyHi+jo/LdtgRbfZXk/8h+TtHCSGvtAH0MpUpkWXijm/zwXpUyWyCCcefylD1P9wRPc2vSEUDnAK6BCC4Z+SApZcXX3PNS8FmHRiBRikopzefARS8ZTFq3DespDkI435LbAa52vHP+3gWZHhi8HGR3wBF+E2TIGQKeCdU0nKDsLV8Mml5s1Zc9n5cxUJ4F5nfTMHU+ep/k0o+9cPdE+bY7qRJTtIcR2nrBn2a5qALPhL/wgzdqqb/uwm16oqOemwLVfovrH07uxgUWqNbrv18jX8cezcFZiIzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:48:49 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 09:48:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] sched_ext: idle: Honor idle flags in the built-in idle selection policy
Date: Fri, 14 Mar 2025 10:45:33 +0100
Message-ID: <20250314094827.167563-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314094827.167563-1-arighi@nvidia.com>
References: <20250314094827.167563-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e234a0-8306-4afe-a7b1-08dd62dd6bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3m7+c2MwXz/zAT8lh0D7q6+dnfin6PbI28xiA/ZSY0WjCI3wK5UMJUGVnZRU?=
 =?us-ascii?Q?2Em5B+yviZm7gk1vR6oJoMP1dC+ZCQUHSoJ1pPSg22wl9qdKDoowGs3hd/xX?=
 =?us-ascii?Q?ybdkOm7o63MBe1lDyVauoNoKbOKbCcJd4SeNGW3r4ki0fx0GWV6jGsJ0VTnI?=
 =?us-ascii?Q?VyadF0V3zpOrhxsaj3Ivpmnhet6vdhJUgGXRvcLd/Pc7pboXymSB5B/PY9lS?=
 =?us-ascii?Q?OCP7yoK38VEoQDNC/GvwVPT9hJizx6TigUNWqxpqjJWuzlxUF2JI91OOEilH?=
 =?us-ascii?Q?j493Iq125ar24c1xQDp4wAh8BMUJZP4vMfp6wKSoiTbXKqbYZ7SVyahdIrnc?=
 =?us-ascii?Q?bFUyfqrPRX8KPt+ivS19aF6Y0TJGrjQO43zHoUMqPhO/E1FCQCdahJF8Pwjb?=
 =?us-ascii?Q?IsiJ5+bTiigHHfBRZcyqYIZ7+nYo7TjRp72/9BMUb7Pk7a5gpK38yQN6wsLH?=
 =?us-ascii?Q?AzbcIsHvm6ONxrEKJVuI+VS/nasyu8Z8ejSuMT3cax6kzrpCoRth62BA1HJM?=
 =?us-ascii?Q?oGbK6p/RQ/4JT8jXY6WQcX31ygG2nCSLFlTVVDrTEkHXDFe7a8qPvPakML7m?=
 =?us-ascii?Q?ZUnBg6zMGBDc+hugOgrB9OTPcfSiMRlnA2g67jthnt92uTbHdao5fQQ9VFq0?=
 =?us-ascii?Q?WNz+UwKI5ilvyRoIiDqsfvpeujoKXTwUF7baHZt9LlFHAqnlugFW0YsM2MxO?=
 =?us-ascii?Q?pVvwAM4WTc8Fcz3x2qe2KzZXd0PyXf0ijoXix1L4HqYCHjXv5fcGuaLKg4cd?=
 =?us-ascii?Q?P2x/7CTvVJXRroCx4MP9Rmnz9xMJH30kR9IP5/C8df+lnvn+6ALgw/vUohvL?=
 =?us-ascii?Q?pxuBoN0k8xhzFu/fCnCBEjNHsT81oyxG3CwKYyGri1JlqXvjbleT3SWsKfD8?=
 =?us-ascii?Q?uPgliudC9k/FFYGQDxoBOONxBfZ+rQjSsHjPgy2f9vni3fdeeVcD6wzAvVQ6?=
 =?us-ascii?Q?RbF/yp7asHBtlkE8ERg0N3nSNEV+DHckO6MJqMhKi9HTZhTF4asHe5JZzg3G?=
 =?us-ascii?Q?OUgvagQ4nTRUuW3QMAAUxS4DcVFHF5V6ZN39NdPKIXLPWncaJoyIhFLGgocH?=
 =?us-ascii?Q?zlcPAW4g0EVMkp+Bml6XJSp8MfvZaTCBGEGoF803DaWFkZx9O/y/DfVzsLNn?=
 =?us-ascii?Q?cLhF/qE4VvC7H9tcruwAtQaxW1WsQNeoX2IYPif1kqWM8kKgq9dmrqWy0mhA?=
 =?us-ascii?Q?dltYJ7C02RMF+8QH0K49uATf7nG5EhNZ/h7y246eZaluhYMwGkHX/B5K5Sjd?=
 =?us-ascii?Q?KmsdUhIgadVYYqL7/ip0cmT/9fOPMZ+fjmphBOKlYZDc3VxQggwPi5GtI+CH?=
 =?us-ascii?Q?H6LZR64hjjP3kXNChHdqzQNfOG9+bXdxcSrq+oeS/vbG3tS4kdwJHsQGWkzQ?=
 =?us-ascii?Q?djwB93NSgcdm63sgbJZ1WJxlCDju?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1DXC4vSl+g8C/Eogb5LJmdt9DQtWku+KBKUBk+fqwEblXylvlmZwtu0qmSF?=
 =?us-ascii?Q?u7cWM/uCACEkTg6pJLRDn68N38Vx/fAvRqePIfu1HDMD31b4Ie7jhynbY/6U?=
 =?us-ascii?Q?Y1oRF4avzIfGJ90x8f9CAVptDnCvl6naUiFSOGpHXsUIy+B3Kp7N9v04OFEG?=
 =?us-ascii?Q?mrdlNjwXGhDFr1KCcn7njw4NO85Hrf5VJnpwPCO0ryG8ygjps3mJJxY/r3yn?=
 =?us-ascii?Q?NMBs7JaK8/Fkrp5Kvqfw7K3vUwttISO/1rVLVwKQ0UB5KBGyjtMBQkQWYdgT?=
 =?us-ascii?Q?qu74c/SOrI9Emy8BMC7Sh3lwEPI03UYwr+xNt3w8H22LZ30JxzQ3hId3liGk?=
 =?us-ascii?Q?Pdgm/Cwpd1+WdTq2CnpossZIadX72NzxsGEBDM8cd+VmBuuU33h9RKNtqcL+?=
 =?us-ascii?Q?lWNzSQuzA4EHMjwZkJ5VFobxXwpXzlG0uM8Jz/cfrKITaFD6dyLqjMfrbXdW?=
 =?us-ascii?Q?yBuM+mg2TvQfVNJnQysb2lRSq8IMqnGxxYBzWZjCEkZRPaaNDDeoCoB4MAgE?=
 =?us-ascii?Q?JZAnUqGk4mIEewmfHJnPcJ0xVNd0Hh+ENEDPxspdWxXgpzOYWdfOwXqUoPOe?=
 =?us-ascii?Q?GfygwfM7Tx0SOwrj1sdm6u8S6lGXqDGX92fSmzAVc2T2f0KSbpH+Z/CkQHGg?=
 =?us-ascii?Q?SxOEuzhVtGqlpb7ZMloHjkIu9ze8Ntu0CphgnHrLYrBw46AfkEMtsLhebCYz?=
 =?us-ascii?Q?yCjCJKOxC6fd0GILIWyxpyHv0MLhEJpAawueEJZ99P+23IjF5k/PW0Ij81GV?=
 =?us-ascii?Q?FMWeNskJp0eePjCe2f6GHmjlGzI95XSE5UC34dC5S6g2+Wqy65XbHYkAaHTg?=
 =?us-ascii?Q?6xHXafbgqxNg56OyCgpetqp9/WsPflhsyyDzoEV3fAJHSaSj3N2aOqTwrMfV?=
 =?us-ascii?Q?Zu/QCNg0rgViJ37rNQac/0tMhnSM3c11vA27V1I5bmNNFvH/DvVii3Q2izTb?=
 =?us-ascii?Q?jLtDlDCyZ8Fe4GKTbWgUB9BxkOa1jthEbxhnv8zdvMHhvR4uLTxEVo5EnULx?=
 =?us-ascii?Q?edcTJ2WB/Hx9VxtHYVQC3BKx8zCwnwvrl2lq7YsiEY3V9+JboaP0TA0vN6xg?=
 =?us-ascii?Q?+e9AoTRZ3GT9pAW/t3q1bL8C9qfspy+POES67lo6QpjgTU+mCcDDvv5zPj2V?=
 =?us-ascii?Q?vp+weGve/dOKw8LcQLYwspoDa0IBdro8NDsbR/m1e6+pkI1XOgCBV7qHWOUv?=
 =?us-ascii?Q?FssPOgXSoZYRUNjWaVLutqHrQfO86sLqTOYuOePDQxugHPwCQk/Ci/S5dRkp?=
 =?us-ascii?Q?faA+pAT4g+XI4cqUrW+BMo8liqXOWj2nw89wk69ZjOcvQPEA/07VI/PLnkaw?=
 =?us-ascii?Q?qYtkghEH5TYIkhegS6kC8YD/PgMeNS63G4iufXZnP1W/UQrNkZUlADNRxCQ/?=
 =?us-ascii?Q?DpninmvJxb1uuR/FebSS5h7mpvPxnrTjv9YUx58qSwS3ajF2PcKyzBtkyc9M?=
 =?us-ascii?Q?6VxkPo83wj51KiDEXuzejJLYZbByu7jXP1l6iep8MhGTOJEjOn+8nIQHKSlY?=
 =?us-ascii?Q?P4ms99hKQrQIT0+Oil4AUK6F/fbszQVCmqpxZxcSUXldWBoSAdEJtxR/xdXU?=
 =?us-ascii?Q?+kRd5VkYC6i+NBhuAkkn8EWEW5/v8OLAqIlCwh2Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e234a0-8306-4afe-a7b1-08dd62dd6bc9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:48:49.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cr4Z9mxSffpAs9F5qN0CFo4CMXyAGlbnZ6SQlplYkqkxgg7SsQdEVixiksGxMnk3nAuS1/HjPRSHMZGAUuq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

Enable passing idle flags (%SCX_PICK_IDLE_*) to scx_select_cpu_dfl(),
to enforce strict selection criteria, such as selecting an idle CPU
strictly within @prev_cpu's node or choosing only a fully idle SMT core.

This functionality will be exposed through a dedicated kfunc in a
separate patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  2 +-
 kernel/sched/ext_idle.c | 41 ++++++++++++++++++++++++++++++-----------
 kernel/sched/ext_idle.h |  2 +-
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index db5bc4d57dba4..1756fbb8a668f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3396,7 +3396,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		bool found;
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, &found);
 		p->scx.selected_cpu = cpu;
 		if (found) {
 			p->scx.slice = SCX_SLICE_DFL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 15e9d1c8b2815..16981456ec1ed 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -418,7 +418,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
@@ -455,12 +455,13 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
 	if (wake_flags & SCX_WAKE_SYNC) {
-		cpu = smp_processor_id();
+		int waker_node;
 
 		/*
 		 * If the waker's CPU is cache affine and prev_cpu is idle,
 		 * then avoid a migration.
 		 */
+		cpu = smp_processor_id();
 		if (cpus_share_cache(cpu, prev_cpu) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
@@ -480,9 +481,11 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
+		waker_node = cpu_to_node(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
-		    !cpumask_empty(idle_cpumask(cpu_to_node(cpu))->cpu)) {
+		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
+		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -521,15 +524,25 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 		}
 
 		/*
-		 * Search for any full idle core usable by the task.
+		 * Search for any full-idle core usable by the task.
 		 *
-		 * If NUMA aware idle selection is enabled, the search will
+		 * If the node-aware idle CPU selection policy is enabled
+		 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
+
+		/*
+		 * Give up if we're strictly looking for a full-idle SMT
+		 * core.
+		 */
+		if (flags & SCX_PICK_IDLE_CORE) {
+			cpu = prev_cpu;
+			goto out_unlock;
+		}
 	}
 
 	/*
@@ -560,18 +573,24 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool
 
 	/*
 	 * Search for any idle CPU usable by the task.
+	 *
+	 * If the node-aware idle CPU selection policy is enabled
+	 * (%SCX_OPS_BUILTIN_IDLE_PER_NODE), the search will always begin
+	 * in prev_cpu's node and proceed to other nodes in order of
+	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
 	if (cpu >= 0)
 		goto cpu_found;
 
-	rcu_read_unlock();
-	return prev_cpu;
+	cpu = prev_cpu;
+	goto out_unlock;
 
 cpu_found:
+	*found = true;
+out_unlock:
 	rcu_read_unlock();
 
-	*found = true;
 	return cpu;
 }
 
@@ -810,7 +829,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
+	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, is_idle);
 #endif
 
 prev_cpu:
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 68c4307ce4f6f..5c1db6b315f7a 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,7 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *found);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


