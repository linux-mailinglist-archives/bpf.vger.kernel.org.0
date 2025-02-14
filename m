Return-Path: <bpf+bounces-51599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE10CA366B5
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DE17A10A1
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737E1C84B7;
	Fri, 14 Feb 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cD6pF8Ap"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011032.outbound.protection.outlook.com [52.103.33.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDC1519AB;
	Fri, 14 Feb 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564001; cv=fail; b=XqLXuD+vxsZ4A5DcVQg9hvLO0sm/fUgeLMaMM4PrdrJ3TDbfRBMvYuwn0/9i1unV6KdOmrVHmsWuWpMSFs07oOOoO9xJdAnNR2GmxA2Q61I8kJRhQ4A9CdVEM2WeIKxPm1frnwc38YMJXPGgvlZkv5M8oWIpof6rTgnyoRqQ/Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564001; c=relaxed/simple;
	bh=0e8xQRHW3DcdTEoz3jvxqKrMWf9PuR4t00eCPxc/T8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aL19tXCCKvKjJ63pqCYUSXp5i4PrPzfCYnSgc2rkqRakjokwvfaWTju5sTZC8p3FhI1g7EoSGH6Y9zJrtxHO7Nd/vO1ZOtEEHFmBNOM5Y8T5Fst09zngHh0JBS+h60vHvvXKjc6w5hHCtMAvYT9i58OJyxo84wEnCsO4VQ/tkcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cD6pF8Ap; arc=fail smtp.client-ip=52.103.33.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JymqPghAsN9Xe0LTiFY3Jqe7NjijzJsB5I151+2v2lmxPCup0x1SbaE2itAIjpqeW8pGiksPEmabXAcZ7+XIvTPQWphHZl3Tc14dwM0oavXwFcirrNTBb+YNXMi0S/OQcoHOGcT0N3O0K14wUwrFZooOnrzAoQg0i/4mUchjs6po2YqNVzv/7iMVmP5/Z3nkSSXzZ6o/GnFOOvvU1jiqdowoW7L9k1CVWh/x7+ef0dFHK/c/BGAqlgnYUCsFu/9Yd6yZ476ymiGGkJw0ZLeyxZqqniVXHYguXYlI2dCq/4MQl/XY4SP0beRDUq52zkpo8flX3v9A51MdHdr08X5VsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8RzG6hNBPzT3DnO5qeDp85e0CBrvieEIAVWu+qcCfs=;
 b=kHndJAE91pve7wZBPnUb3nt8zMuwDr4B+8PoxHiqXo0EVDZsesiRom8YKDw2feNy/jgxZYoY3m/8lnLbLb7EMCc9KvUofFX91/C3/mSXq7gfOji7TLfKnCKaPKiA2n4rs1pYOMBCyxZXmIS8wt/epOcWGnFJTQoYkWlNG6NN4g4pych4VSZ/2CC6Gc9vBlM/6PnFVPOT+vNktkrVwBJQ6rzsXM2M+1p5lOjtCI/3duZZoh1Ikb227aAXIlvJKtqIecq+KLlo8KLqpnXWWSDf2qun4WQ1AANkpYOCnXiBKfwKB51PPlHIgezV2xPr9QNmqzeYKcEKU2cn7uUxdzbv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8RzG6hNBPzT3DnO5qeDp85e0CBrvieEIAVWu+qcCfs=;
 b=cD6pF8Ap69bAw6Om3+ZfPFOe4NlUvmeUy3AIwW9ISa1PHiG/Yre6leXTjZOAGYVMibQ4sSxCXsTMxsG40t4HlmDvJFEyuXy8RU+7v8jBhIRWWM49DG0HD5XNaXD9zbVDVLm6Fd1crf9IwgHvT+29FJlBpxSJEpGIP80k+0iGuJrhWptJTO4hq+I60VlbVHeqCA9vaq2yuCt4SDpX6MBtKlwlzn4eOK+0Mv7QV726OBSVjK6pHdI6tzVtEoQNGu/vulYa8bHaD+sfJ892tLw/bO+SVXbpgwDXL57v2gDaVU5NCvUFq+NEWX7ms0UCbtJyMQjLZtPDYhmVrzTgcvJ7gg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9931.eurprd03.prod.outlook.com (2603:10a6:20b:643::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:13:16 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:13:16 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 3/5] sched_ext: Add scx_kfunc_ids_ops_context for unified filtering of context-sensitive SCX kfuncs
Date: Fri, 14 Feb 2025 20:09:27 +0000
Message-ID:
 <AM6PR03MB5080D59AD7DD5B59E1FB14E599FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214200929.190827-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c57dcb6-e266-44da-4131-08dd4d340472
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|15080799006|8060799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXp5lC5PgICo2Lu4AT5yQdo/0izl5BwXfw7BiLFcuBTGdFzE2QL/7GSn48dp?=
 =?us-ascii?Q?NUtWU2pO7VVex+6Q3ovERI+v/vWBYrwHa6Zi21PrIpCN1HA9KZjlK0izuNoE?=
 =?us-ascii?Q?c7+KRTbmISi0zHnfY336Ql+87Z8cLI22y5U3ZhzJezgAnAhLwAwKK/RSHPFb?=
 =?us-ascii?Q?uop06tAg8o+OJjOMO03V46waTKWLb5VcJNs6Q4t52I8UfKDCEb4aHLumG1hW?=
 =?us-ascii?Q?ws7xND7KTH3sjDTHDW4zdC15s3X0Dhr+lAl7G0kWFu1YKt4zYKcCCbYlB6kV?=
 =?us-ascii?Q?HIK6ECI+/LJsG0mmaJjvS5p3P876W6d0iX4K86IfdlxeKVzGc90DmJVY8Kyg?=
 =?us-ascii?Q?/ZZJbvN10n02wUDgHC0nRBEys3hS5GJwz6Te1yk9Lh8UWr2uLgpvHLlaI3rI?=
 =?us-ascii?Q?+UB1O0HcfCm22htqIn94FdLMam33OBkPJVaDTOC+FOoOzG4ducoX4gclOhXQ?=
 =?us-ascii?Q?xfNjHb7+SSF3WrI1Fe3Eis2T/3PySqnWA7rK8D0LGcSVK13XAcgxzxPNoRlJ?=
 =?us-ascii?Q?sFrGd6s+vz4XMNs9pUd9WZkjcwIVh0lTH/leSZIH4HinxNzwIPUjC494FAxp?=
 =?us-ascii?Q?/twJ13l1fmwPAEQcWvHjIxUb0z1uwK01lQucQEU93u7GQfakLhtsm7MMbmw+?=
 =?us-ascii?Q?DJH44YojjHIlBgfKu1oSObPyjhUtUlcn83csqxL9QtqC5yjjrWTiTxsjWp+b?=
 =?us-ascii?Q?AkUFcH5N1wCfu/cCzN6HXQ8rK3vzxsXKT2bf5asBLmNHs4YXRqF/h+Wf/TbB?=
 =?us-ascii?Q?rLq8fQuIg+0E/XYvfFd4xr8Gt1xTdizz8v/YNrnoWsXw1fYWFK39ILyzZZl2?=
 =?us-ascii?Q?wVqu72LQDGpM3VELMGAo4LTPtfrB22smuGVBdw6YJyO8iImqNcW+DSzhWO0x?=
 =?us-ascii?Q?Am/jyoCmKfqxk/ZNDblTUOyScpW70DcsMSJN4H+GEODmlh2WWFqzHywpAEoE?=
 =?us-ascii?Q?+9nK8yI80cUi2eMmS1yr7IWAsbMecKFCFK/+z+m7yhiGjXGhZiHNy+JGy7Ve?=
 =?us-ascii?Q?+dwQmgfV1eC0mvRkgKhB/aQrHk3X4JVAS7fWn3Xr5UuyJIodNoYPoFzfy7qW?=
 =?us-ascii?Q?v2cy6ZYBjYbLs4Vrgj7BnQKhO0yfGg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WR+XH8c6auNJdFaiUv2B7uuzb6EcOEEiKQoj+Iji5GEalqX0oQj9D2IyngIY?=
 =?us-ascii?Q?7FRmYRTdBkFJ9pugg7xtYaeyo4nfC2CAdePqWGzvmdTM3OxFUa+hbqezzmlp?=
 =?us-ascii?Q?oPkm9vjq4R+6S7VAtP2Ii/5k96IW5uw7QwtIVYrBjQ7DOtpqd5iM6H00NsT1?=
 =?us-ascii?Q?Q6IfH7aRHXRiY8N0qUsjkUKXUu+xvHwbRy5a/4/8AHAnT58saQja1DpQSpow?=
 =?us-ascii?Q?bkuiU1hYj1NF3viQSjw66RFCpCXN+zJC0+a0DgC2WJmozFrlcrfac5zzmiil?=
 =?us-ascii?Q?vMFjdRGgIwDSxki1EQkMisX/Hljw9XLAnDWbgfhlPX0VM4d6/Su+NieYZKs1?=
 =?us-ascii?Q?tqf+kDmtP9AGesl/S1Uv3KTAkBYH2p0D+WxEhStl+dSWzfynm9q6aR749BQD?=
 =?us-ascii?Q?LMZuYGv+4G3fb2NdshboFrug6P3c/ISdwf9oQAYlzuTwS8BFvN/Y4nRQTxx6?=
 =?us-ascii?Q?JtCU6RhTnPVUMBiKh4vcsuxXmNxfUxbGZPrTXnHwgW49EGW2dwanTzqAC5qe?=
 =?us-ascii?Q?CJuH1hMLtrxumDhAqRaIan8t5iSJyOW1xQUp0hEc4DkOuD3FZUid6uokX2FJ?=
 =?us-ascii?Q?ykvKGvdTzihVhsMfM3Eb2jez81T/nYQTfur6++38qwbBe9SoQPlew7Z7p3AB?=
 =?us-ascii?Q?jvKK3KEKilRpHaZrihvQd8mg0AiGQF0WfzoJAcZ6BRaZ7/x7Mqqb9duvId4x?=
 =?us-ascii?Q?VUP0nKQxOQLAYEyD08LCFYabPFKpbEm48GF5FcSkEIiYmK+23n/pQSaVaXqn?=
 =?us-ascii?Q?/17zxLHtwfkmSoX1oXfjZqonSDF2cPSBDAght4h+RVlL4ZqCum7FLcYaVz3g?=
 =?us-ascii?Q?BRmk/yL4WfDUTDqlvh2nibe9GUGimrjXvVqub/Gbcdaq23LDOqQOTRQmfCor?=
 =?us-ascii?Q?/fIJg/CzDjEobSmGCggSwkdlENp86TDLmX/uyHY0zYUfzNBFu9Rtktd3rs6r?=
 =?us-ascii?Q?vIqfpG1PNhZ/Po9MYtA2+LASP74e4Eu1O0/VD9NoSSnzCx7FkYie1+v5xNX0?=
 =?us-ascii?Q?o04JsYUyzpQMVS5mGYLHGcMDmuA0/JtiHtnTkw+t3UVGe+eUH/E0m57SgbNf?=
 =?us-ascii?Q?rWfIlgobgHj4gL1wrO+lEq02AOcG9BiUFHAXCP5JH9h46E/lZlZiO5IC49Tj?=
 =?us-ascii?Q?pzTaYXhiYUisKVa6JJpUNUlVEGG2nIa7YDD4cn3VZADtF61M0Bz8i1Z9XMW1?=
 =?us-ascii?Q?bJwBMJt8XmDmhEkCET65ccI0Kw4NmNmyGsIa36eB9vBAUgxSFen8S14/DHuV?=
 =?us-ascii?Q?bMWotPGKPuvMm3UmJwru?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c57dcb6-e266-44da-4131-08dd4d340472
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:13:16.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9931

This patch adds scx_kfunc_ids_ops_context for unified filtering of
context-sensitive SCX kfuncs.

Currently we need to rely on kfunc id sets to group context-sensitive
SCX kfuncs.

If we add filters to each group kfunc id set separately, it will be
cumbersome. A better approach would be to use different kfunc id sets
for grouping purposes and filtering purposes.

scx_kfunc_ids_ops_context is a kfunc id set for filtering purposes,
which contains all context-sensitive SCX kfuncs and implements filtering
rules for different contexts in the filter (by searching the kfunc id
sets used for grouping purposes).

Now we only need to register scx_kfunc_ids_ops_context, no longer need
to register multiple context-sensitive kfunc id sets.

In addition, this patch adds the SCX_MOFF_IDX macro to facilitate the
calculation of idx based on moff.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 115 +++++++++++++++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 957a125b129f..d5eb82eada9c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7,6 +7,7 @@
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
+#define SCX_MOFF_IDX(moff)	(moff / sizeof(void (*)(void)))
 
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
@@ -6449,11 +6450,6 @@ BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_select_cpu,
-};
-
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 {
 	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
@@ -6611,11 +6607,6 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_enqueue_dispatch,
-};
-
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
@@ -6931,11 +6922,6 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_dispatch,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -6998,11 +6984,6 @@ BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
 BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
 BTF_KFUNCS_END(scx_kfunc_ids_cpu_release)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_cpu_release,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -7035,11 +7016,6 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_unlocked,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -7770,6 +7746,83 @@ __bpf_kfunc u64 scx_bpf_now(void)
 
 __bpf_kfunc_end_defs();
 
+BTF_KFUNCS_START(scx_kfunc_ids_ops_context)
+/* scx_kfunc_ids_select_cpu */
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+/* scx_kfunc_ids_enqueue_dispatch */
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
+/* scx_kfunc_ids_dispatch */
+BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
+BTF_ID_FLAGS(func, scx_bpf_consume)
+/* scx_kfunc_ids_cpu_release */
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
+/* scx_kfunc_ids_unlocked */
+BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+/* Intersection of scx_kfunc_ids_dispatch and scx_kfunc_ids_unlocked */
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_ops_context)
+
+static int scx_kfunc_ids_ops_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff, flags;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_SYSCALL &&
+	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return 0;
+
+	/* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
+
+	moff = prog->aux->attach_st_ops_member_off;
+	flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
+
+	if ((flags & SCX_OPS_KF_UNLOCKED) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_CPU_RELEASE) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_DISPATCH) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_ENQUEUE) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_SELECT_CPU) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id))
+		return 0;
+
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set scx_kfunc_set_ops_context = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_ops_context,
+	.filter			= scx_kfunc_ids_ops_context_filter,
+};
+
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
@@ -7823,17 +7876,9 @@ static int __init scx_init(void)
 	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_select_cpu)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_enqueue_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_cpu_release)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_unlocked)) ||
+					     &scx_kfunc_set_ops_context)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
-					     &scx_kfunc_set_unlocked)) ||
+					     &scx_kfunc_set_ops_context)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_any)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
-- 
2.39.5


