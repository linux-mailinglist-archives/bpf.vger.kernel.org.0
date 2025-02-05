Return-Path: <bpf+bounces-50561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE37A29A3D
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199483A3A5B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C3204589;
	Wed,  5 Feb 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W2VQrPO4"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2040.outbound.protection.outlook.com [40.92.49.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60E1FF1B3;
	Wed,  5 Feb 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784190; cv=fail; b=mccw7d6Hj8cb7Yf4QRnhxAPXiOn3ZOIxSVyiHoiPvzxIuxlDpeSLb2maM+yKP6giCRu4tCTNiYYSb5MYgk6n8MA8CO7cR0ieQ1l6y497L0TzpaS3zpeLp9U3NeDEdNvM93IlZkwedXpCCafx9TkVmVfr6Vm+rkKsjYKJAyOe2Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784190; c=relaxed/simple;
	bh=Gj+qGa29z8Vmsa0UnJw/ZIzFbQtOzub9vu8NDooMDv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYkYB0r3T4wm/OjFwRo+2QJ1+5KdRzX9X1lEbbk9RbpUPWT+gSqB22c2EA1d70XQ912IJy87nMi1kxAo62WqPSxlruw1dfy89vxvxGEmChuNlWhW5dboEPw8oRzxKLJXVUWOCgvjzXLOImmubZkk/T8y87c46FnrCVZCtTOJ7gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W2VQrPO4; arc=fail smtp.client-ip=40.92.49.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wdu3Y/FVvh5bq+z+a+1CH8akASs9wTrKc+zLud3jrIeodn89l/ndafrjRUysRJZ06e3PwuIVr2kU+FbAo6N9hzCXhEK8UlOVeCEvR1Xe2Pevf8E9wTEjSiOUA+U4LLmRsu2fUsAOpC95giozgj4Z8JjUizwUOQnTzhk0Ih2u9yfgRW3z1C0zPXKQAsb+2olzbXBTYonLupACAB6CYOYhQqsOnAyQa9W99iCt+bIePnDA4OEVAvQp9v+emDPAQegq56x37ib7+rqyl5Uy0m02jFd1rSWC0m4mqKTyFm9nGMdaegOD9Ox7Ad3to377wojQeOR0etLg1wbsxxyQuPDxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSe6Da8l0NgzqbxWrykx1TZDOys0Ft08uZJrFyasxM=;
 b=aSVSyUNuOoSJPlo1MLks9P1OWNr/hWevhYoV9At/2BrcUBtAAMcmpHNYZKFqTRL6ar2/0T1xC4SErddXlsKMMcNTR2P8gCITYHSXXwOzT4kr57CPl7V4FFBmW2FfrxaMYJ9qe8uRW1AgfhEdHLER1P62ok4MgeVGIc3JLdffY67SpoOeg0GxgvJy97/5oz5w7mqes1f7rapqNUxqMxRSR+jrNAdZKLaFDtHwRZ7UZCXV7M0nELspAuWkhDeDSqAFTc5ZrPefXDcGFCWYl7YJm6hn1hv8KCNL5dBt6f8ps6/m2BhGdNJ7l01pnRY0gln/iQVw5WAnQ3Qf9/BEEka5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSe6Da8l0NgzqbxWrykx1TZDOys0Ft08uZJrFyasxM=;
 b=W2VQrPO4RH6wL5C0ISUszZKeDH4/IaieJuR9lqFrfEXyvIiDxTSciJQlfglM+qiQbDR92Iev8lDtoCIr2adaWpWjAF2MJVmlXpQ5sBUbvnQjRH+hpx8JBl8ZghO/qNkEgBP1Pszr7wlsEzeBdOkFuaYbyLGwMLo9YBtBI7xM+0/3TpR5imiFmZE1g+ExPZgr6IBOLMo0CjY/vLFce9Z//PdNkrATFl4nY7uEx5tpwB8gakkXNjeagYq7tnNbyxmziblHb7j/2rkGfmPF9bLSBHzOcqj5FQPIKwnnrDsHe1jssUqLb6Ig8XVyI7UoMcLcX/iTsbOIhtl1qqK10c0hMQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB9077.eurprd03.prod.outlook.com (2603:10a6:10:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 19:36:25 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:36:25 +0000
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
Subject: [RFC PATCH bpf-next 7/8] sched_ext: Removed mask-based runtime restrictions on calling kfuncs in different contexts
Date: Wed,  5 Feb 2025 19:30:19 +0000
Message-ID:
 <AM6PR03MB5080B7D540AF618E1269929499F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-7-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: dac3633b-6a73-4293-c0c7-08dd461c60b1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999004|461199028|15080799006|8060799006|19110799003|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VNcV+sGsrjFGireGXypDAzZqA4uyfnV7HaInJEASg31k383oGBiyb8lGwbKo?=
 =?us-ascii?Q?erJqFbPsm+E3NOygKOBTxCV6xnhYS1iUAVQsWhjLkZMCI6WaD1c4Mlmi99by?=
 =?us-ascii?Q?sFsYPwH8oTQuzE78HfijjoUc40gVTJPlelHpxazWQXBeN10LahQ4ERijGFgl?=
 =?us-ascii?Q?1CWmL/4t/38ZwDd4oYZ1T/8rsfQ0DYDI4J+bdlhVKbcV/3jSaF3F19qRi7Et?=
 =?us-ascii?Q?ZRGI7YzSJRJ4op4EFKUuiN9Z2E0TGCyByg6AbIhf0svwQbVt/WrbBOpQqPc1?=
 =?us-ascii?Q?Cjt0UcsY5vxnXHTk246XQ01OAwnkrtpn7Zvl80GofSt6ZtHR+P0HHEWfqRvt?=
 =?us-ascii?Q?2tLHtDIX2YC+wIJstrrHqthPTCa9gfqmH6CtSg/dWDWW3YWluNQ9DlAwgG21?=
 =?us-ascii?Q?T4jKrhn14BNySq4Fa50/BZ55de4ieJW+VpxfZpIJE0X+rBoSvFDaQJBZ7lHc?=
 =?us-ascii?Q?jfb8IcK4937DdlC4iTOPzVniZMChFVVTida6Ehc7+T8tpLBeyRirHAAYfBI2?=
 =?us-ascii?Q?Pal7nZ8dXBfkJK4V2Rm9qFJ7/qgmnj/jURrCpyRiD+nsFTCxID3S9IvQ90+V?=
 =?us-ascii?Q?1WiFFUeMz0M5QnAAlEOoogrCUfm4VuoFpyV9TpVMkXs1VGcBEztkF3XnhCSw?=
 =?us-ascii?Q?cSPvYSV9JrJalgP2aYuTvk3RGUgNNJJz0/bC8TODWMOMO3YBfaxfm5UjQsx4?=
 =?us-ascii?Q?UNT0iFMeCYOk7nMLYRNwsuZgavfj95e1FcR9k1PSwEUKJ7Wy2LTdovir4btM?=
 =?us-ascii?Q?fsd0GZmlOVuFlFJHeqAMjSqq5ipEUVTk0koXG0LAzkvWYk+nt3dK3du4sUDb?=
 =?us-ascii?Q?b5LZNb9vhyvSqiqSdrZQ98oyLo8j4Ui7riUN7Qk6xG0idp2l/TyxQZaSLmgk?=
 =?us-ascii?Q?/ERX+ETQfEC1wgaeqbncT/paLnmdSL9kRIYdfBtHGThIhZHnxAbHy/pmVBpv?=
 =?us-ascii?Q?ZEwJA2zIasIJqVI+myLHJwfRp9REGxtVacOykvdwU8siO67LDvhjffkV0SCs?=
 =?us-ascii?Q?RiilVhZPiLCEdkjnNTcysJEwlgAU7hAtS/jMXnPBres86a0fIN+W4v3Tn4Cc?=
 =?us-ascii?Q?HCIngpWMA+2LnBs8P94T19Zd24AULo4zcrZ77OWLWrsiLsJdwb8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeyhdqqJqp1VCnB29r2DfFiMhW8p8zmhYinDBAqE5LDdoLhxq0UXcvgQSPrK?=
 =?us-ascii?Q?BhmsByVizf8St4HnU2LIKC9cbGx91TIASQ+N1T9/GZ4lR04puTBHLR0WB4TJ?=
 =?us-ascii?Q?klDNfisswYRaDtvAM+2JxgGpBgxY15bDxCfd6byAVeejDija56kT00GWSVAC?=
 =?us-ascii?Q?c0rLxlodHebAVlmiCJ7ONmW8XdV8HJBYN69mflI2X3VLsY+jBE8wtAKEGx2v?=
 =?us-ascii?Q?jbpFs/cGJWQAQAAlha+qs6vN9lOolRadrgE4icHc9oy/VPNoNa/koxq6asYf?=
 =?us-ascii?Q?nuEYc7I9KxlsxMgfZRZT5ofTzWxLTxfgGdx+igqYPQ6agJ9HNoDKGGlo9UbN?=
 =?us-ascii?Q?4/CORjIyC9yYH+cd2XF3nlt6i2wtTn9CJZzhFIDFx73YVmqNSIabXketBI+n?=
 =?us-ascii?Q?ar+qwXGoDfUVW0Um2QYo5hL6qpkThIOjTfexDQN6FwmrQVlQ2lGzmEsRuQ7T?=
 =?us-ascii?Q?2kvtIfowev47KfnecTRo//WmD4OgHI8PPFnbd//FkCn0jv4XvAH1g3grBrt4?=
 =?us-ascii?Q?KGmpSh040xB6a4vXqDafps7SWMSY3zJXB2PHozIag9aWQ/g3iMFTw0fDNxf/?=
 =?us-ascii?Q?2iffP6SZP7x8+N1o7ottlHrdKD1VVR9xQtZvqGfj3a1YE8VrFwbgYQImwd50?=
 =?us-ascii?Q?LJzfzxgJkPSCBXbBBYr5Bs7XHywsQ7dfLN0enTsdW2rLNoQV0UKv/rASltvO?=
 =?us-ascii?Q?2wTtthWDkjkPCTSiIENDtuGyPWNsyH7xM6PppPssrtIeqihMXwhxOTV3S/j3?=
 =?us-ascii?Q?s/cxicNhv7VlcNgsPUjKB9TAZ4G2dBL+Tblm0fYL+gGxgxnnnFt/FKOKOyY/?=
 =?us-ascii?Q?8DdI/i7k/K0gK2w2z7IIvO3qOH+aj83r1YIJT4ebt0uKBrKbBACVAVOZE/i/?=
 =?us-ascii?Q?Ob4Flqpcd553jnu44Ms+6IXzbpSO+p9OQJj5RH+EBKTuJ1Xm3Gq8E8WTkikT?=
 =?us-ascii?Q?cb46T8kYS3PXO3LaapGb5AWmp+0oW/k6MQKAqdB6ftGb6heeSyXb/Izz8jGd?=
 =?us-ascii?Q?L1JgP6+qFfoVI3SOSdcxstroDB1Yl/QIGyJgpwS9PIlpDYNpyWrRRSP7UGqq?=
 =?us-ascii?Q?FLz/mlegONhouukFakg7RQlHncCnXzprEO051bcTZljSwI8sTFXVxG1hRVj0?=
 =?us-ascii?Q?EjueCl/OpVtgd/8BQDak5MAWIQlFHzzlm+Y3R/F6EFcUomjuVGNX4iKvXj3B?=
 =?us-ascii?Q?ge+pg/4hxLoN0QVnF3QbEkWNVpMDmlr5ta2M696IQ9rA/38LDI9xGsR2BKVU?=
 =?us-ascii?Q?1LKZGKkHTniMbLmn08aJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac3633b-6a73-4293-c0c7-08dd461c60b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:36:25.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9077

Currently, kfunc filters already support filtering based on struct_ops
context information.

The BPF verifier can check context-sensitive kfuncs before the SCX
program is run, avoiding runtime overhead.

Therefore we no longer need mask-based runtime restrictions.

This patch removes the mask-based runtime restrictions.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/sched/ext.h |  24 ----
 kernel/sched/ext.c        | 232 ++++++++------------------------------
 2 files changed, 50 insertions(+), 206 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1d70a9867fb1..867c24b88ace 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -96,29 +96,6 @@ enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
 };
 
-/*
- * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
- * everywhere and the following bits track which kfunc sets are currently
- * allowed for %current. This simple per-task tracking works because SCX ops
- * nest in a limited way. BPF will likely implement a way to allow and disallow
- * kfuncs depending on the calling context which will replace this manual
- * mechanism. See scx_kf_allow().
- */
-enum scx_kf_mask {
-	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
-	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
-	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
-	/* ops.dequeue (in REST) may be nested inside DISPATCH */
-	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
-	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
-	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
-	SCX_KF_REST		= 1 << 4, /* other rq-locked operations */
-
-	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
-				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
-	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
-};
-
 enum scx_dsq_lnode_flags {
 	SCX_DSQ_LNODE_ITER_CURSOR = 1 << 0,
 
@@ -146,7 +123,6 @@ struct sched_ext_entity {
 	u32			weight;
 	s32			sticky_cpu;
 	s32			holding_cpu;
-	u32			kf_mask;	/* see scx_kf_mask above */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 955fb0f5fc5e..d2182f5e2b28 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1043,19 +1043,6 @@ static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 		return -(long)jiffies_to_msecs(now - at);
 }
 
-/* if the highest set bit is N, return a mask with bits [N+1, 31] set */
-static u32 higher_bits(u32 flags)
-{
-	return ~((1 << fls(flags)) - 1);
-}
-
-/* return the mask with only the highest bit set */
-static u32 highest_bit(u32 flags)
-{
-	int bit = fls(flags);
-	return ((u64)1 << bit) >> 1;
-}
-
 static bool u32_before(u32 a, u32 b)
 {
 	return (s32)(a - b) < 0;
@@ -1071,51 +1058,12 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
 	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
 }
 
-/*
- * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
- * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
- * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
- * whether it's running from an allowed context.
- *
- * @mask is constant, always inline to cull the mask calculations.
- */
-static __always_inline void scx_kf_allow(u32 mask)
-{
-	/* nesting is allowed only in increasing scx_kf_mask order */
-	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
-		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
-		  current->scx.kf_mask, mask);
-	current->scx.kf_mask |= mask;
-	barrier();
-}
+#define SCX_CALL_OP(op, args...)	scx_ops.op(args)
 
-static void scx_kf_disallow(u32 mask)
-{
-	barrier();
-	current->scx.kf_mask &= ~mask;
-}
-
-#define SCX_CALL_OP(mask, op, args...)						\
-do {										\
-	if (mask) {								\
-		scx_kf_allow(mask);						\
-		scx_ops.op(args);						\
-		scx_kf_disallow(mask);						\
-	} else {								\
-		scx_ops.op(args);						\
-	}									\
-} while (0)
-
-#define SCX_CALL_OP_RET(mask, op, args...)					\
+#define SCX_CALL_OP_RET(op, args...)						\
 ({										\
 	__typeof__(scx_ops.op(args)) __ret;					\
-	if (mask) {								\
-		scx_kf_allow(mask);						\
-		__ret = scx_ops.op(args);					\
-		scx_kf_disallow(mask);						\
-	} else {								\
-		__ret = scx_ops.op(args);					\
-	}									\
+	__ret = scx_ops.op(args);						\
 	__ret;									\
 })
 
@@ -1130,74 +1078,36 @@ do {										\
  * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
  * the specific task.
  */
-#define SCX_CALL_OP_TASK(mask, op, task, args...)				\
+#define SCX_CALL_OP_TASK(op, task, args...)					\
 do {										\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task;					\
-	SCX_CALL_OP(mask, op, task, ##args);					\
+	SCX_CALL_OP(op, task, ##args);						\
 	current->scx.kf_tasks[0] = NULL;					\
 } while (0)
 
-#define SCX_CALL_OP_TASK_RET(mask, op, task, args...)				\
+#define SCX_CALL_OP_TASK_RET(op, task, args...)					\
 ({										\
 	__typeof__(scx_ops.op(task, ##args)) __ret;				\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task;					\
-	__ret = SCX_CALL_OP_RET(mask, op, task, ##args);			\
+	__ret = SCX_CALL_OP_RET(op, task, ##args);				\
 	current->scx.kf_tasks[0] = NULL;					\
 	__ret;									\
 })
 
-#define SCX_CALL_OP_2TASKS_RET(mask, op, task0, task1, args...)			\
+#define SCX_CALL_OP_2TASKS_RET(op, task0, task1, args...)			\
 ({										\
 	__typeof__(scx_ops.op(task0, task1, ##args)) __ret;			\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task0;					\
 	current->scx.kf_tasks[1] = task1;					\
-	__ret = SCX_CALL_OP_RET(mask, op, task0, task1, ##args);		\
+	__ret = SCX_CALL_OP_RET(op, task0, task1, ##args);			\
 	current->scx.kf_tasks[0] = NULL;					\
 	current->scx.kf_tasks[1] = NULL;					\
 	__ret;									\
 })
 
-/* @mask is constant, always inline to cull unnecessary branches */
-static __always_inline bool scx_kf_allowed(u32 mask)
-{
-	if (unlikely(!(current->scx.kf_mask & mask))) {
-		scx_ops_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
-			      mask, current->scx.kf_mask);
-		return false;
-	}
-
-	/*
-	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
-	 * DISPATCH must not be called if we're running DEQUEUE which is nested
-	 * inside ops.dispatch(). We don't need to check boundaries for any
-	 * blocking kfuncs as the verifier ensures they're only called from
-	 * sleepable progs.
-	 */
-	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
-		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
-		scx_ops_error("cpu_release kfunc called from a nested operation");
-		return false;
-	}
-
-	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
-		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
-		scx_ops_error("dispatch kfunc called from a nested operation");
-		return false;
-	}
-
-	return true;
-}
-
 /* see SCX_CALL_OP_TASK() */
-static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
-							struct task_struct *p)
+static __always_inline bool scx_kf_allowed_on_arg_tasks(struct task_struct *p)
 {
-	if (!scx_kf_allowed(mask))
-		return false;
-
 	if (unlikely((p != current->scx.kf_tasks[0] &&
 		      p != current->scx.kf_tasks[1]))) {
 		scx_ops_error("called on a task not being operated on");
@@ -1207,11 +1117,6 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
 	return true;
 }
 
-static bool scx_kf_allowed_if_unlocked(void)
-{
-	return !current->scx.kf_mask;
-}
-
 /**
  * nldsq_next_task - Iterate to the next task in a non-local DSQ
  * @dsq: user dsq being interated
@@ -2027,7 +1932,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
 
-	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
+	SCX_CALL_OP_TASK(enqueue, p, enq_flags);
 
 	*ddsp_taskp = NULL;
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -2122,7 +2027,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	add_nr_running(rq, 1);
 
 	if (SCX_HAS_OP(runnable) && !task_on_rq_migrating(p))
-		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
+		SCX_CALL_OP_TASK(runnable, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
@@ -2153,7 +2058,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 		BUG();
 	case SCX_OPSS_QUEUED:
 		if (SCX_HAS_OP(dequeue))
-			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
+			SCX_CALL_OP_TASK(dequeue, p, deq_flags);
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -2202,11 +2107,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	 */
 	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
 		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, false);
+		SCX_CALL_OP_TASK(stopping, p, false);
 	}
 
 	if (SCX_HAS_OP(quiescent) && !task_on_rq_migrating(p))
-		SCX_CALL_OP_TASK(SCX_KF_REST, quiescent, p, deq_flags);
+		SCX_CALL_OP_TASK(quiescent, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
@@ -2226,7 +2131,7 @@ static void yield_task_scx(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
+		SCX_CALL_OP_2TASKS_RET(yield, p, NULL);
 	else
 		p->scx.slice = 0;
 }
@@ -2236,7 +2141,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 	struct task_struct *from = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
+		return SCX_CALL_OP_2TASKS_RET(yield, from, to);
 	else
 		return false;
 }
@@ -2763,7 +2668,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * emitted in switch_class().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(cpu_acquire, cpu_of(rq), NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -2808,8 +2713,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	do {
 		dspc->nr_tasks = 0;
 
-		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
-			    prev_on_scx ? prev : NULL);
+		SCX_CALL_OP(dispatch, cpu_of(rq), prev_on_scx ? prev : NULL);
 
 		flush_dispatch_buf(rq);
 
@@ -2929,7 +2833,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
+		SCX_CALL_OP_TASK(running, p);
 
 	clr_task_runnable(p, true);
 
@@ -3010,8 +2914,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 				.task = next,
 			};
 
-			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
-				    cpu_release, cpu_of(rq), &args);
+			SCX_CALL_OP(cpu_release, cpu_of(rq), &args);
 		}
 		rq->scx.cpu_released = true;
 	}
@@ -3024,7 +2927,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
+		SCX_CALL_OP_TASK(stopping, p, true);
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
@@ -3602,8 +3505,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		WARN_ON_ONCE(*ddsp_taskp);
 		*ddsp_taskp = p;
 
-		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
-					   select_cpu, p, prev_cpu, wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(select_cpu, p, prev_cpu, wake_flags);
 		*ddsp_taskp = NULL;
 		if (ops_cpu_valid(cpu, "from ops.select_cpu()"))
 			return cpu;
@@ -3641,8 +3543,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
-				 (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void reset_idle_masks(void)
@@ -3708,7 +3609,7 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 * managed by put_prev_task_idle()/set_next_task_idle().
 	 */
 	if (SCX_HAS_OP(update_idle) && do_notify && !scx_rq_bypassing(rq))
-		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
+		SCX_CALL_OP(update_idle, cpu_of(rq), idle);
 
 	/*
 	 * Update the idle masks:
@@ -3739,9 +3640,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 		update_selcpu_topology();
 
 	if (online && SCX_HAS_OP(cpu_online))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
+		SCX_CALL_OP(cpu_online, cpu);
 	else if (!online && SCX_HAS_OP(cpu_offline))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_offline, cpu);
+		SCX_CALL_OP(cpu_offline, cpu);
 	else
 		scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 			     "cpu %d going %s, exiting scheduler", cpu,
@@ -3851,7 +3752,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(tick)) {
-		SCX_CALL_OP(SCX_KF_REST, tick, curr);
+		SCX_CALL_OP(tick, curr);
 	}
 
 	if (!curr->scx.slice)
@@ -3928,7 +3829,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 			.fork = fork,
 		};
 
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init_task, p, &args);
+		ret = SCX_CALL_OP_RET(init_task, p, &args);
 		if (unlikely(ret)) {
 			ret = ops_sanitize_err("init_task", ret);
 			return ret;
@@ -3985,11 +3886,11 @@ static void scx_ops_enable_task(struct task_struct *p)
 	p->scx.weight = sched_weight_to_cgroup(weight);
 
 	if (SCX_HAS_OP(enable))
-		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p);
+		SCX_CALL_OP_TASK(enable, p);
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
 }
 
 static void scx_ops_disable_task(struct task_struct *p)
@@ -3998,7 +3899,7 @@ static void scx_ops_disable_task(struct task_struct *p)
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(disable))
-		SCX_CALL_OP(SCX_KF_REST, disable, p);
+		SCX_CALL_OP(disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
@@ -4027,7 +3928,7 @@ static void scx_ops_exit_task(struct task_struct *p)
 	}
 
 	if (SCX_HAS_OP(exit_task))
-		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
+		SCX_CALL_OP(exit_task, p, &args);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
@@ -4136,7 +4037,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
 }
 
 static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
@@ -4152,8 +4053,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
-				 (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
@@ -4245,8 +4145,7 @@ int scx_tg_online(struct task_group *tg)
 			struct scx_cgroup_init_args args =
 				{ .weight = tg->scx_weight };
 
-			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
-					      tg->css.cgroup, &args);
+			ret = SCX_CALL_OP_RET(cgroup_init, tg->css.cgroup, &args);
 			if (ret)
 				ret = ops_sanitize_err("cgroup_init", ret);
 		}
@@ -4267,7 +4166,7 @@ void scx_tg_offline(struct task_group *tg)
 	percpu_down_read(&scx_cgroup_rwsem);
 
 	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, tg->css.cgroup);
+		SCX_CALL_OP(cgroup_exit, tg->css.cgroup);
 	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
 
 	percpu_up_read(&scx_cgroup_rwsem);
@@ -4300,8 +4199,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 			continue;
 
 		if (SCX_HAS_OP(cgroup_prep_move)) {
-			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_prep_move,
-					      p, from, css->cgroup);
+			ret = SCX_CALL_OP_RET(cgroup_prep_move, p, from, css->cgroup);
 			if (ret)
 				goto err;
 		}
@@ -4314,8 +4212,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 err:
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
-				    p->scx.cgrp_moving_from, css->cgroup);
+			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
 
@@ -4346,8 +4243,7 @@ void scx_move_task(struct task_struct *p)
 	 * cgrp_moving_from set.
 	 */
 	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
-		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
-			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
+		SCX_CALL_OP_TASK(cgroup_move, p, p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
 }
 
@@ -4366,8 +4262,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
-				    p->scx.cgrp_moving_from, css->cgroup);
+			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
 out_unlock:
@@ -4380,8 +4275,7 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 	if (scx_cgroup_enabled && tg->scx_weight != weight) {
 		if (SCX_HAS_OP(cgroup_set_weight))
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
-				    tg_cgrp(tg), weight);
+			SCX_CALL_OP(cgroup_set_weight, tg_cgrp(tg), weight);
 		tg->scx_weight = weight;
 	}
 
@@ -4571,7 +4465,7 @@ static void scx_cgroup_exit(void)
 			continue;
 		rcu_read_unlock();
 
-		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
+		SCX_CALL_OP(cgroup_exit, css->cgroup);
 
 		rcu_read_lock();
 		css_put(css);
@@ -4614,8 +4508,7 @@ static int scx_cgroup_init(void)
 			continue;
 		rcu_read_unlock();
 
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
-				      css->cgroup, &args);
+		ret = SCX_CALL_OP_RET(cgroup_init, css->cgroup, &args);
 		if (ret) {
 			css_put(css);
 			scx_ops_error("ops.cgroup_init() failed (%d)", ret);
@@ -5078,7 +4971,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	}
 
 	if (scx_ops.exit)
-		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
+		SCX_CALL_OP(exit, ei);
 
 	cancel_delayed_work_sync(&scx_watchdog_work);
 
@@ -5284,7 +5177,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 
 	if (SCX_HAS_OP(dump_task)) {
 		ops_dump_init(s, "    ");
-		SCX_CALL_OP(SCX_KF_REST, dump_task, dctx, p);
+		SCX_CALL_OP(dump_task, dctx, p);
 		ops_dump_exit();
 	}
 
@@ -5330,7 +5223,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 
 	if (SCX_HAS_OP(dump)) {
 		ops_dump_init(&s, "");
-		SCX_CALL_OP(SCX_KF_UNLOCKED, dump, &dctx);
+		SCX_CALL_OP(dump, &dctx);
 		ops_dump_exit();
 	}
 
@@ -5387,7 +5280,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(dump_cpu)) {
 			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(SCX_KF_REST, dump_cpu, &dctx, cpu, idle);
+			SCX_CALL_OP(dump_cpu, &dctx, cpu, idle);
 			ops_dump_exit();
 		}
 
@@ -5607,7 +5500,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	cpus_read_lock();
 
 	if (scx_ops.init) {
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
+		ret = SCX_CALL_OP_RET(init);
 		if (ret) {
 			ret = ops_sanitize_err("init", ret);
 			cpus_read_unlock();
@@ -6383,9 +6276,6 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
 
-	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
-		goto prev_cpu;
-
 #ifdef CONFIG_SMP
 	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
 #endif
@@ -6450,9 +6340,6 @@ static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
 
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 {
-	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
-		return false;
-
 	lockdep_assert_irqs_disabled();
 
 	if (unlikely(!p)) {
@@ -6637,9 +6524,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	bool in_balance;
 	unsigned long flags;
 
-	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
-		return false;
-
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
@@ -6722,9 +6606,6 @@ __bpf_kfunc_start_defs();
  */
 __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
 {
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return 0;
-
 	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
 }
 
@@ -6738,9 +6619,6 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return;
-
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
@@ -6766,9 +6644,6 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
-		return false;
-
 	flush_dispatch_buf(dspc->rq);
 
 	dsq = find_user_dsq(dsq_id);
@@ -6980,9 +6855,6 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 	struct rq *rq;
 	struct task_struct *p, *n;
 
-	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
-		return 0;
-
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
@@ -7769,7 +7641,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 	struct task_group *tg = p->sched_task_group;
 	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
 
-	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
+	if (!scx_kf_allowed_on_arg_tasks(p))
 		goto out;
 
 	cgrp = tg_cgrp(tg);
@@ -7891,10 +7763,6 @@ static int __init scx_init(void)
 	 *
 	 * Some kfuncs are context-sensitive and can only be called from
 	 * specific SCX ops. They are grouped into BTF sets accordingly.
-	 * Unfortunately, BPF currently doesn't have a way of enforcing such
-	 * restrictions. Eventually, the verifier should be able to enforce
-	 * them. For now, register them the same and make each kfunc explicitly
-	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_select_cpu)) ||
-- 
2.39.5


