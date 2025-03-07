Return-Path: <bpf+bounces-53610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D55A572A5
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D77189AA8B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537CA2517B4;
	Fri,  7 Mar 2025 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XRue4RwZ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C3254858;
	Fri,  7 Mar 2025 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377931; cv=fail; b=CajtYjoaUY5vIt6F+q/n4WA1CDotZVipFbliMYzI0OlMtvd1jBOKWqO6fJp3hAsxyslZrPOfBZefXCA+nW8tfJA0+g8juA0AHmS2Ut98obqV0xMBjl7piep18r9Qeonxe0YK5SqxV0yA8MUSg4Y8b6FLLbuMLLJetYUAnwPSdVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377931; c=relaxed/simple;
	bh=l4U67mnX8/AcgOXB4FTI6U1Vl7ikbUK4X5QFXCvD6pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLrAlwFPe+zhUTD8SG3sikzIKeBsI2RorTskSMiJeGQ0qkhhg2PoFsaF1btwED3Yg548Re1l+ULTzGpaWlbRFDREtcXNyo4R3s8ZgkuX/p9wQHnH07lLQB7BQaM881W9H7/0VvZ+94PX3N4arkC/9rC6Oa0XA7HLZgFIKeN/Nlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XRue4RwZ; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cExvhQaGVy1W0XaB5iVFyR3yw21xJxKbc1XcLzyVOC4KON8tSjYBK8q0RLfd//vlgb9rp660IlIlDGyZVtQUUTnkwl/dQQwv2gWfXl7EBY0gemT9xfVLNBZvRJ2oVI7sSCAUNct3r4yzH7Pg72GpfCr+twRcRG4onBHz4q5KpBGOqLMBf+Hvj2YdNfVbM9X7sUNxeY3SuaNoqu4p7c6znC33iBN2CqzCL6yloQnxipveVJHykGmWj2zOwVJkI8+ctlRKmHeeiB9ZotNfkZWxGPJUtySbgwxhazrpQgxke7dXCYla6hP1ATE5PbIm8vbkDHlBa6dI2M8tlbVv5qq7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aizTxRzg8eQp7PehOruQ1Tzd1iafLXSPqO+uqHxR8xs=;
 b=NhnHte4MW8K7hR+WxbP4D3SqY8GYWoRmbqYkqfAjtGGV9kB/gaN8eFo2UuN582OTY2RXWT7mfVJKTxKz8v8y8Mpu5kWG3hXq6cAeo9tBZk+y984ItRcYkamYdau9pMy85ibZZvVoN0of8AkQOkDmHuv7LjGA9ivAdRpRZOCLDdWV61rEeWaP7lO7ZXMgXMH0s635mceTNjsVc5FKKHOBNKJ4a9F6A2MjThXgmJa1ZGGjEVW0QwTPFseqIFOW2EIkrNfRNRMVB+S8eoC1zYrE2eohoxm3ej67UFqyY33Fg+xJytSok3PzW5vvPXhl1QTOLd6rOFQ+KaedlSZa0xDAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aizTxRzg8eQp7PehOruQ1Tzd1iafLXSPqO+uqHxR8xs=;
 b=XRue4RwZTM7jX2Pj2XcCZGMc/p7ZrPjJi2RMA4BUAiCCVwC3ybPGhsETxZ0RKsTdaRvwM59ASfk0KwMWxKB7OFg2MPZiZ/WesypMgwwNYeGUi6lCVS3Ny753uNAZQewKw8mzSDbrG8Cc0u2KZ6Xf8yJwVnWppK7mfwrWySz1++Nr4vz+Fp4Ag2s687JgH0DGMufbHno1cv4rBUfbzGfnXsNzVwv/CtpPLvvg//A0SkEMy1oBF2wXDeDkMJqLfSI5A4x/lG0DoSLDlbdPrgfxDc1RQi+nGolOrl6dAsVr0d6qz6WbCfY2Ar0IHHOD/keGEWtWzwosiOLyQBwt5nPhGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:05:28 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:05:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched_ext: idle: Refactor scx_select_cpu_dfl()
Date: Fri,  7 Mar 2025 21:01:04 +0100
Message-ID: <20250307200502.253867-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307200502.253867-1-arighi@nvidia.com>
References: <20250307200502.253867-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6d25b5-5fc9-42e2-9641-08dd5db36814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BfbmO8nLf7JiLSMuG9J+8++qDOV54MwnQZUt1NDEk8+LHM2s+/ixpb/DTGbo?=
 =?us-ascii?Q?fCzzTB0W88YcN0qAAWm5Y8Xtvy34s48z18z8i2vjOeMXs0/B+/FU2NUWgaJq?=
 =?us-ascii?Q?EBMzWBQlNf9/Ho+DzXNwGs+FFMP4OvOPFoFLeW/DJdyO6DZ3x/cK8VQwWswk?=
 =?us-ascii?Q?AfKfXMqy0ewnBkvUe1vI32pU5ck9rzagJeWoOWofWkw5ePUPMopUPBJPfF44?=
 =?us-ascii?Q?8fWnW80qU66SXDcf0+o1LWTnedGDijL5KNEgliHL+b8f9C1DQpA5/OTxgNKI?=
 =?us-ascii?Q?3BMMnowLMk5l6sj4hZF5TEJBjDWF+B5Erv3zSUUWDJnBx1kOxmQwbipVWcmH?=
 =?us-ascii?Q?hBqbZxoKtY5E/HpYoU7jLN9/VPe2cvnjUoil2zq0I5vhWVi5zDryzqJ1tKRs?=
 =?us-ascii?Q?4TIPp1OCmZQWGADorgTRRQdCMC4E73mesGwHTg0eFsqVd42Ht7GVv4zg3+QU?=
 =?us-ascii?Q?Jaef28mnFsp/qgAPCzekE4w21oylbw91+eB5Awv/CL8oXc8+8gjrAD45Y/f5?=
 =?us-ascii?Q?AQUc7W+nALWCPcC/V/wUPJxdV3BWfipHGZAN3RhobUHXW1jq+I6CELPt82PS?=
 =?us-ascii?Q?OKDGyI+QxKr7BoQTgn7zLnb2qhtJVgDsCZASOvtYrbNINlsbAfr/hqQ30LzA?=
 =?us-ascii?Q?hDbRtaxMTaxWXbGRmW6dNGTMLtKxfE2oVypwWInuUI4iah0K8M+zi5Xu9l10?=
 =?us-ascii?Q?O0d+TsLi8JFuik/CC/TvX0JUBPKLv70qeQfQbX6XC/DM9X1h6ne4PDScRqHE?=
 =?us-ascii?Q?LAE9MUW3nZ58cO6BVAWAcM6nN1SZINBGmf1J39ne/BFXrezdXooJekL1fUZe?=
 =?us-ascii?Q?FaXLdDpMwyvBUZz2sjoOm/JGXpehupcgsU8W5TrGjzIYSXkLtPbeduFJ5coy?=
 =?us-ascii?Q?yFo+62uxXDrfxaDViXuBpxH6hDYSRTwUemHllnPA2tBv5aci9IPmoXtOTD0i?=
 =?us-ascii?Q?t/xQb2p/B2Lek2Gd41J9PB0on7NF7/jxkT1KtXFSr0gulZmSkJRt49+Rn9Hl?=
 =?us-ascii?Q?mjy9cYNiS9RZZC1F6MOPxEOoqTBdFzfFueQqIU0IUAPqTekgbsCN+aZ18NeH?=
 =?us-ascii?Q?247S8Fa1djpLi23Jv0GpDKLj5bDCrYQA+VsJq71D+Op9b+vsr+zLT6OwXoVD?=
 =?us-ascii?Q?5D0AkE4Y37jQ1TZr6cPPRgFFwHvglmxcJdKBu5xDRBdfur+dC3yikJMwMO6A?=
 =?us-ascii?Q?6uUhJ1MLe34UMTB1voEnUhpMTRsYxn3RS+UvsEx6fge7831BHhTdD46H//w/?=
 =?us-ascii?Q?ZcvZN4oxb44N8+1fXcZWPToRgefJqVn8U3AD5zFiT6wsdUpGStBeLgQcKvhH?=
 =?us-ascii?Q?oM7ZKrEkiczesjIb6xZO9wW5Ps4d/aUla6FRNhV5SEEqSWFNLfynA9Gwsq1T?=
 =?us-ascii?Q?KHJPvNKV7eYh/ZDrfw5z3DnnBX6Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wbFw7ohDjR8P7Y5ulHna6t9a3aCYiMuG/a0f2YRSDYxNm+deOz5u3uNzBNc?=
 =?us-ascii?Q?xQNi9007356EMOqolp9S6YtPMfVPdZmQS0JP849Z7fA4atuMLbP+/EdQnvF8?=
 =?us-ascii?Q?Rw357TTFwuKBVCBHcILpExQcWPNFLhzawIn03bWbv+rhwulk0NlgMrEW1Lmq?=
 =?us-ascii?Q?92sb/cOb9C5Lv3oETgCUGQk7mqJGYhS7BC3HnlSDZ2qSiVtncOly9w6s+DXT?=
 =?us-ascii?Q?2h7FnjWE5O5z+BuFl8Mtd0KsUPrhQRHRMC/HE3hB2oQNGQg2OgYPr8qmjytQ?=
 =?us-ascii?Q?o2LhdSVC28nIwquHnmPMEDLmtZzAc/EHg2YEono3TTtvn0FUk6xXmltLQDRp?=
 =?us-ascii?Q?xQxGFYrxNdCUeCt5nMbVUtemhqpVJ2UeCZoSPysq7Y8eNkktOTkMZYnX+NlP?=
 =?us-ascii?Q?AqXdSmIOA6A6h8kSbFP0FPrM8QGf0TXoeZbnQJsGjpboBzoArlsWifHeuheI?=
 =?us-ascii?Q?hBTyY+hxRgX/UZrxCQs08jNZWgYqKgFp9JyWsXlQ+CcV240sXpx56JybFoGJ?=
 =?us-ascii?Q?hmEDNjmHuTVbga88Z7eJcav4Ij0cr8aiJdM7LE8As0hNlFb8qTzU+lBXTmlZ?=
 =?us-ascii?Q?QcAyc0Fs/zsVPMXdsfMkbC59wBhPBvcbPbo7BEWCeH4PLdRx9dmIMT1BL/g2?=
 =?us-ascii?Q?OsdJS5IL0Ew8N4PZlVK4KZ1GGZPPI9DKg6AtIbkXgyPbLGEaFS2j6Se48c4H?=
 =?us-ascii?Q?GBQPPWSZe5WvKo78irAVQNPVQm0BNT+H51bPsp9IuontcGwzs2EIt4KhtDfQ?=
 =?us-ascii?Q?OX3utsf17HS1mlUNb/LsnsMzXkzkvcSqKB3xuNKEbqfkJb0IwozYhctWcoAG?=
 =?us-ascii?Q?k3xSci11x7Xa5DhpEncsTBQ2xFkuvaJE71sUhCUG3DnmQaffQGiUeEVGluTL?=
 =?us-ascii?Q?6TArTotGTSgOLRI76DiIBMgqs8/oNWXBYVFnVdioQFGE915xpC4iqJnt/E1j?=
 =?us-ascii?Q?MHsmKNBF8DkNFoCQnUEysgTQRDyYoqWnFkQpPVswGJ6/zVO1jO3/dLmcr+ph?=
 =?us-ascii?Q?Of2MHFuDO0tQ8ypwQQQaI6c80r8dvCpjMYAzu3dMQvDu5K7SWVi6NOczwSPO?=
 =?us-ascii?Q?gGnQxWFKFYGmnVRS9TnbA9W5v7WFVCzoGUnoKMS40Z1uQsoEPnaQLVJWUaU+?=
 =?us-ascii?Q?n1s94rfMOSobQUB3nOSos4Vx27LD5o2GGugxPDI78AT3OQPx50t/SEIOP5WU?=
 =?us-ascii?Q?Nydfs3eVfLj+uw9N+z2vg6Iig2PD5Md6/oDaLCLK06B/zL5fuSKnbQcVXOna?=
 =?us-ascii?Q?iPeO2l6cRbpISKpdJ4ZtMM4cmHs61rKC4bxvsO/yBuvkt963BWEoELJbnfMG?=
 =?us-ascii?Q?3SjoQdxYhCdm8kSLLGIyzL3Oxk8vo7evTRQVES1vYZOr+2FRDq3KtTrUq5ME?=
 =?us-ascii?Q?mdGK+j6pgf9jHYsCR2mUeC1BFkQl6IA7jlB/HdhPFjP+1mMTA+N2vUkVBy2A?=
 =?us-ascii?Q?qdls+BPL6lFBw+9mxyoj1dxC4XB2p+BmT3MVb/TaPfd1JDPtZjLOaKVG2Hm2?=
 =?us-ascii?Q?g1nc8r0fVFl/+z+rs++o092t35d5fmmk8k4tCrxBHPpHe2QhHxFamp9FhGMG?=
 =?us-ascii?Q?DKibQdUV17+PWChwTiHuEwiLG0fYWda03a2xkU9e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6d25b5-5fc9-42e2-9641-08dd5db36814
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:05:28.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiujEsIQTI2Imysb3i7g70TLKJDGAbuFP+4Uz6s+pwEE5t9TAd7TlWVWWrbdpiNZ03Qwtl8mPXnKZ7u7O18S4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Make scx_select_cpu_dfl() more consistent with the other idle-related
APIs by returning a negative value when an idle CPU isn't found.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  9 +++++----
 kernel/sched/ext_idle.c | 38 +++++++++++++++++++-------------------
 kernel/sched/ext_idle.h |  2 +-
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5cd878bbd0e39..8c9f36baf7dfd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3393,16 +3393,17 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		else
 			return prev_cpu;
 	} else {
-		bool found;
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, &found);
-		p->scx.selected_cpu = cpu;
-		if (found) {
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+		if (cpu >= 0) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
 			__scx_add_event(SCX_EV_ENQ_SLICE_DFL, 1);
+		} else {
+			cpu = prev_cpu;
 		}
+		p->scx.selected_cpu = cpu;
 
 		if (rq_bypass)
 			__scx_add_event(SCX_EV_BYPASS_DISPATCH, 1);
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 16981456ec1ed..4f8a6e46a37a4 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -418,15 +418,13 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
 	s32 cpu;
 
-	*found = false;
-
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -465,7 +463,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (cpus_share_cache(cpu, prev_cpu) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
-			goto cpu_found;
+			goto out_unlock;
 		}
 
 		/*
@@ -487,7 +485,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
-				goto cpu_found;
+				goto out_unlock;
 		}
 	}
 
@@ -502,7 +500,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (cpumask_test_cpu(prev_cpu, idle_cpumask(node)->smt) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu)) {
 			cpu = prev_cpu;
-			goto cpu_found;
+			goto out_unlock;
 		}
 
 		/*
@@ -511,7 +509,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (llc_cpus) {
 			cpu = pick_idle_cpu_in_node(llc_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
-				goto cpu_found;
+				goto out_unlock;
 		}
 
 		/*
@@ -520,7 +518,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		if (numa_cpus) {
 			cpu = pick_idle_cpu_in_node(numa_cpus, node, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
-				goto cpu_found;
+				goto out_unlock;
 		}
 
 		/*
@@ -533,7 +531,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 */
 		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
-			goto cpu_found;
+			goto out_unlock;
 
 		/*
 		 * Give up if we're strictly looking for a full-idle SMT
@@ -550,7 +548,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 */
 	if (scx_idle_test_and_clear_cpu(prev_cpu)) {
 		cpu = prev_cpu;
-		goto cpu_found;
+		goto out_unlock;
 	}
 
 	/*
@@ -559,7 +557,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	if (llc_cpus) {
 		cpu = pick_idle_cpu_in_node(llc_cpus, node, 0);
 		if (cpu >= 0)
-			goto cpu_found;
+			goto out_unlock;
 	}
 
 	/*
@@ -568,7 +566,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	if (numa_cpus) {
 		cpu = pick_idle_cpu_in_node(numa_cpus, node, 0);
 		if (cpu >= 0)
-			goto cpu_found;
+			goto out_unlock;
 	}
 
 	/*
@@ -581,13 +579,8 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 */
 	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
 	if (cpu >= 0)
-		goto cpu_found;
+		goto out_unlock;
 
-	cpu = prev_cpu;
-	goto out_unlock;
-
-cpu_found:
-	*found = true;
 out_unlock:
 	rcu_read_unlock();
 
@@ -819,6 +812,9 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+#ifdef CONFIG_SMP
+	s32 cpu;
+#endif
 	if (!ops_cpu_valid(prev_cpu, NULL))
 		goto prev_cpu;
 
@@ -829,7 +825,11 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0, is_idle);
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+	if (cpu >= 0) {
+		*is_idle = true;
+		return cpu;
+	}
 #endif
 
 prev_cpu:
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 5c1db6b315f7a..511cc2221f7a8 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,7 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags, bool *found);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


