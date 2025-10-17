Return-Path: <bpf+bounces-71188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F185BE7D36
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482CB6E2A77
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60C2D7D2E;
	Fri, 17 Oct 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="roT7fR33"
X-Original-To: bpf@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4F2D97AB;
	Fri, 17 Oct 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693621; cv=fail; b=bpXdwuqwS8v8s1lM3/f3QCoWQVfhzZbsDJvgYKN4eHY4UGUVOqjKhDmu/swlux0bgpnogQgjSw7t0/D9c8scmENyuOV6iL9MDqlxDuvfqEDhV+FVJ26c9Qzd0QV+MlsA3mEpzfhamD3VDD1fOb7JQWjAYNSTkzoQ5iBtbPgTfII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693621; c=relaxed/simple;
	bh=srLStlHNXSXoX68dtxGsmgvum9Ya73GCui53CEVesCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLeHO2kV2gXnEj653O+rtcMK7Mk+R+xkWrXLoazcJ+al7ZqtnXhH/EyldJi0YFcGdzD2qnPUB+hacDmGuZTG2qmQHnYCejHWlhTUbkA+rVAOGwefl4bmh7ghKROIr3SDD3oq7JP9pXNlM0ELbO31vcMuuAC+Hvfp2xNBn/XOSks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=roT7fR33; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYPv1a30/nVkB4p1M44sfIPLeclegawcrZKaA3LCdWjsChUCmLxENphHlMNbmYqpp0RPOgT6Dx3GWtM8FLY8HKEWmd8RO1v5pYM2waL0rpZRV2dqL5XdOO9I8OF61HJ7MMohZW4Rlsu4KvcIQ5GWZJ9N+4NUtp9z9PLXYtDlJicmzyeRSsT3BKlud82E+J0XbcO8xcPGq2DxbkHzt0xVWHAk8dR2OfghvUjW4UJi7u6Y35Oqt2Rez2DCNFtVG86ZdmJcwXlm2ZCf7R10m0LcIjKP9Jmj9nXWbbPbTnhQrkdd7jak8V5KamkmmyoUeQjiNGPjULZ9ZPNBZY6Et5KlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dofWPCrLtYqpPgNqvugTQxTCL3fMHGFZrOu9jXvo3Yk=;
 b=BEtVhdTPjFA0GwbW0bZmx5JgZtfET7TdZo7KnKkaYKhiRpQ9D9WCQrTd2e/3ZsgqkqWn8bt9XmX8BlKmGq1eJVQ1wlhBTFUF9nUUfO91NSIgNPhAVtAebrD+ATYRBfpe/aRCcRk9ejt1nTnOhwz/h5S9VNYnCeFSZouzpAZ9FbVvbtal/3BAXaz993W3LiDyXXdzV4+b6m+yx3IBsPug14Q2/jhIc8ueRDDWYAkwMxBzZwseyqHza1y+axMLpdfH57pJ7YgPNWQnEIJv4lB8NKf/cc67h9nDwCNZ17xyl1cfl3XQmlyH5zfSYtllI60tFRssvk8vklUVitGi1SGWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dofWPCrLtYqpPgNqvugTQxTCL3fMHGFZrOu9jXvo3Yk=;
 b=roT7fR33pd+jshHLvYMbpI1yd4QwbJkSPMTYApFgJuzF1pxtIDXb2kMLAPQUQDIKW6RQt4JDQ1G7nvrJ2g1Ejz/Xct/ssh29LUmhvsMvkXt8We/+XIjdwbdlS80geZQBeic0TSQnkYBp4evGFmdJE/J8RY9f0mKLzADGV5mhww2OkvcPnEVPsbb3yX9V0NI9jGW1LWG/lKaGc/hcukbhA7hZJHHKu0AEY4/KoLE5L4WetNr4T+RoUKCywyIB0V8tfCtvVcFVNvWkU1TH/Bls9UBZu9CO7ibi9D4AF1yWQi+mF8SA8ycI0HeCzhiJNGGPFb/FhNRweDbAVZSLos2CCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:33:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:36 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Date: Fri, 17 Oct 2025 11:25:53 +0200
Message-ID: <20251017093214.70029-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec2ceaf-674d-499b-5dc1-08de0d603ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A13vgb36ZgfdE0DN8TKWUTgWBLPcOy8PnUgniGgqMFOYL4dFGEIFDKuw3lOI?=
 =?us-ascii?Q?oUlVmRvBEL6OPGtQmZSDDN5fCjecZIBjPgCckksCUr+FiFncr/5LwHpIREZk?=
 =?us-ascii?Q?jNU84/Ki7LTYzxwRZ2Aanx3rhWRozRvJRtHKf2yfp6mQ0wVuJKz0IgeuFN0G?=
 =?us-ascii?Q?p55C2mUBYVU7uxcGs78etTCwzE4o96gYVLhBFSCRMGsQXgrOYAQGKn0enmQ3?=
 =?us-ascii?Q?uX62VXWKeEcZh2TtZTOn9Q5qH/Jvh+30AsvsvDaeWZFylQxuO9e5g5x15Olh?=
 =?us-ascii?Q?EY5E9ffE+YHjmE5K0PxB7yVxCn1xxPOfgkvDV5cAphy/A82y/nYHLV/Dp/f8?=
 =?us-ascii?Q?S8TySs9YeVIEga8h/nDyPZo5PX16y7wEiH4V06MaiHiiX3EVOHUIgIVenor3?=
 =?us-ascii?Q?DlgRwpcT88l9vSF8lCCra1gRJN3FDrCW52XSgWjjk9XlkAIN3A4TrlY6E5tj?=
 =?us-ascii?Q?FTYO5EY3jFe+D6tb6mn9VS637HzIspuuROaAcVfB1kZeXlRcfuqHbsDpUkRK?=
 =?us-ascii?Q?oDW46FUA0vIH0iz+3oic69KODC69qtFF8nH47a2Z61JL1ZWnf+8EElLLLHg9?=
 =?us-ascii?Q?uhD/Bk3W3l8EJPC/HZfoR0WEpQTvW9I6xb4Y4UV0vDVFgOdui0fG+iL2eEe3?=
 =?us-ascii?Q?XxYL5PIl/NDTd5PUoYDqPprkDYfFIiljXa3c6HZIn2vvxRX95Zk5UbGoZ/40?=
 =?us-ascii?Q?0C4pvXd+y7K5j2JifneH3H5HPpnAaIdlOneElm8UA0OW0Xsncz0RVmXvoZQY?=
 =?us-ascii?Q?DLxsPKK7NMyC2FAitbVGssTu1sXv/mpHVbYIr1mZS/QwIJO8UjsTU1JqxxRp?=
 =?us-ascii?Q?skIhblxdujduIMRZI7w2kcPhM5HAm7d2Ov9UxiPxPXRz99fx3juo530b6p0N?=
 =?us-ascii?Q?4HvvriBWKrOCnvuanne5q//iVGBH9iWOVZNDJhtV0Lj3lA0I6iUBACCay+S+?=
 =?us-ascii?Q?giccYpk5PGRMqdePL5KYhmYf7LODbBiFH7W/QjzaDHdmkSLIA/sBwrEU1sq0?=
 =?us-ascii?Q?QXi45O7gpbAZvKbCZzuWWCiej7vdo/LCYP9NaNXptjGWFcUwJ1XKs/JPdKJz?=
 =?us-ascii?Q?P2siwZUCn0jCWeO12MGHANSFaq8T+1o77dlmgGvpbh9dsAB5Ep8POdc6j84M?=
 =?us-ascii?Q?6ll2kTs3Y7tHnMoqtyrEJ1wSmyyres000u+4zqex6Qm9KQm5yVyIcl1k7Mlw?=
 =?us-ascii?Q?c6nnuY+WsYFzXd7p4NteZz6EreD9PeoCY/Ma6X9ay1MDcZfjQBfXVUil0Gr4?=
 =?us-ascii?Q?+YbciDIDUduOQ+KEr5qBWK2DfcioCAnjjPbqjGi6yziafjZnVhq+z7YgRd0f?=
 =?us-ascii?Q?g4Rbj56nXXkyqj3ENDIjlRWEco/vGBuPqKyrJPDxQb40nZzMgsiw7bT/E4aD?=
 =?us-ascii?Q?ngcHrRqCN/sAN/NpXZYNZWNT7lBzFYNDqJaQzNEceEx9yE0Mwxun3IhCkxtY?=
 =?us-ascii?Q?sWKsxWyRxFdMFw/KaQ4BV+IBmBrNFOU1KN9/pVEXUt3nkpJ5onvPSGab3xYI?=
 =?us-ascii?Q?DJ3M03iC+/2KUdE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtPjcYX+j2Qt5ru3on4MIun/pFdwxOntFTg7+2nrs8NEa7h7lnL/sgLiEb5S?=
 =?us-ascii?Q?Y1WzdKrFcrwBJZa90PQo4yAMRzj2QKNDwZn82/l9S0THXN/inNp8I+DihA6U?=
 =?us-ascii?Q?PUimmXz5/DXq/uOZAGHvz65cVnPk/Q2xh9R2HkBmb7LSRjKd83Mv2ED4vHtO?=
 =?us-ascii?Q?BroeeACCXV8rNCJxCKvxmFccA7/xKimWxPTrvl6m9MBIGopUJ23HZNi+SmW6?=
 =?us-ascii?Q?tcp49krWZCbCxo5uoZGlu9/Sek3HoUkC+QUS7zwMgzSl8sy0Prsvxrm/Nd1o?=
 =?us-ascii?Q?4zgX6DkZwWkjqi9GtopPPz7T71YkJiolIgpXq/hSqVwy3P4M/qSstEyNh0wC?=
 =?us-ascii?Q?hzwAcAaGhZ0Y5aHKgwuFfQwX4yulWL9vGTeJcY7vdgmeJ51bGmD88wOHybek?=
 =?us-ascii?Q?jXghZBwnHs4HKN7CLyZfb2WUk9bbzI+sUO0TqYj92B9vGCqGVTjV47ehPHBB?=
 =?us-ascii?Q?7KcA2E3PBnzQjOvj8gmTLNzEe076Av1D5wS9VSp/E580jtbw61x4N0f4d0qg?=
 =?us-ascii?Q?5UzkY4H/QdfhGQKlGmjVLXej92llYasRD2q5DcbWh0/WHwJSvFArOsS05dl7?=
 =?us-ascii?Q?5R3jvxRtAm9WGN27pJSjk8c4uEIsYt5lDL93OVjM2ZhltaaknruNi9XGnbHa?=
 =?us-ascii?Q?86qb28aL75hfyQ3jbSVghdUQt6SyKwOSiCQVx3hRv027K/X5nDkUF7al20cE?=
 =?us-ascii?Q?PM8YM853lIaprlWEocIzsdwqyv0zXqqaWZOMkl6FW5FiKzwVxM0iI9udaNNx?=
 =?us-ascii?Q?oU68C65CtoGFxBgFI3xdRCGPYO3IBB+zoHnyL+Mtqaz6Bi9zK5a3NmOEUYNW?=
 =?us-ascii?Q?d9xUcr6P3VmV6/c0Wgyyn9nhGA6NU//bpYwe3VsI8O3711yH9g7IQkaWWLBH?=
 =?us-ascii?Q?jn4p0IbcgrgBjfeXfZTeeySAVPfuWuqwF5jufcr2YVy5K1f6SGxyyOWoqntU?=
 =?us-ascii?Q?CIt+SSC/BP+7fMFlMKLsIOgYhVc+7AJ6Bu6BFDdMdr5ITWPqfG9l2h2KE7WD?=
 =?us-ascii?Q?IEaiKDdM2J3mu7ZECNDi6BRqU4fNBnngBhBzxddumNJ+mfV8FSWODacVSN7A?=
 =?us-ascii?Q?TFNpKV60Ky0wScln7vC/bt6zyyHYUAvawyuhKhee8ck6h1iIGSI5O2ZcLSTb?=
 =?us-ascii?Q?IwfhieNzvQkCbRtqTP+o6qOFwoPVMlFon0+HQxiS2ef1xEuAQoceABz/STJm?=
 =?us-ascii?Q?4dIAmIlrXa6fiWCrHmmiaPTW92s3Hs0cXjxLxVneEGATUORQnwf/1tk1NmNS?=
 =?us-ascii?Q?YXvKlMooreI71lgKSNsoltYZ3vICC7V5wMJpaKaczWlBZCxYxiXq44kAwPbA?=
 =?us-ascii?Q?cRxAzgcTqYMRuDjfNB8g7gYPQF2U5DmUT4hIlh4ofPiYev4ogw/KkpfAOxRJ?=
 =?us-ascii?Q?zzgiBuFUEzw0o5L5HO4rblYu4xtUiioM5I8z7TSpb5KeLCAtyT+39/oM8JGv?=
 =?us-ascii?Q?UHv20YBWsQIbYStgf3tTTKEBzYHXQ3NwIyebSAQ7UbHtlKfI/6M4Vp0xg082?=
 =?us-ascii?Q?b5vewlnbpCpSx4XkcMI/zGTfj6YzoKU8JOUBXvsgvTikYfGzzVMFVUVIwXOj?=
 =?us-ascii?Q?G4HjWad3FJ233OrIxIoBS+DP/J88p6uqvevssBql?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec2ceaf-674d-499b-5dc1-08de0d603ef7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:35.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHTiA4lJNJcXw9AfrC8u1zI+thB8tNs4yGdZlh8LYBNx5LetPcYrO2rzfpF/HWjWNSuLVdCR+zNvbQXq0LH6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

From: Joel Fernandes <joelagnelf@nvidia.com>

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also provided later to verify:

./runner -t rt_stall
===== START =====
TEST: rt_stall
DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
OUTPUT:
TAP version 13
1..1
ok 1 PASS: CFS task got more than 4.00% of runtime

[ arighi: drop ->balance() now that pick_task() has an rf argument ]

Cc: Luigi De Matteis <ldematteis123@gmail.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/core.c     |  3 +++
 kernel/sched/deadline.c |  2 +-
 kernel/sched/ext.c      | 51 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h    |  2 ++
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 096e8d03d85e7..31a9c9381c63f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8679,6 +8679,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0680e0186577a..3c1fd2190949e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1504,7 +1504,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * The fair server (sole dl_server) does not account for real-time
 	 * workload because it is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index adff739b396ce..bc2aaa3236fd4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -881,6 +881,9 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -1388,6 +1391,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	if (rq->scx.nr_running == 1) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
+
+		/* Start dl_server if this is the first task being enqueued */
+		dl_server_start(&rq->ext_server);
+	}
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+
+	/* Stop the server if this was the last task */
+	if (rq->scx.nr_running == 0)
+		dl_server_stop(&rq->ext_server);
+
 	return true;
 }
 
@@ -2987,6 +3004,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
 	scx_disable_task(p);
+
+	/*
+	 * After class switch, if the DL server is still active, restart it so
+	 * that DL timers will be queued, in case SCX switched to higher class.
+	 */
+	if (dl_server_active(&rq->ext_server)) {
+		dl_server_stop(&rq->ext_server);
+		dl_server_start(&rq->ext_server);
+	}
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
@@ -6498,8 +6524,8 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
  * schedutil cpufreq governor chooses the target frequency.
  *
- * The actual performance level chosen, CPU grouping, and the overhead and
- * latency of the operations are dependent on the hardware and cpufreq driver in
+ * The actual performance level chosen, CPU grouping, and the overhead and latency
+ * of the operations are dependent on the hardware and cpufreq driver in
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
@@ -6874,6 +6900,27 @@ BTF_ID_FLAGS(func, scx_bpf_now)
 BTF_ID_FLAGS(func, scx_bpf_events, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
+/*
+ * Select the next task to run from the ext scheduling class.
+ */
+static struct task_struct *
+ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+{
+	return pick_task_scx(dl_se->rq, rf);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_pick_task);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fa2fb64c1f3bf..55f8fbb306517 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -415,6 +415,7 @@ extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p,
 		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1153,6 +1154,7 @@ struct rq {
 #endif
 
 	struct sched_dl_entity	fair_server;
+	struct sched_dl_entity	ext_server;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.51.0


