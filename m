Return-Path: <bpf+bounces-38464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273DF965088
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D158428125A
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFA81BAEFC;
	Thu, 29 Aug 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kcwI/nRg"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2050.outbound.protection.outlook.com [40.92.90.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD81BAEF1;
	Thu, 29 Aug 2024 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962336; cv=fail; b=hAlVtWy31JGGNVOsSxEKvihp5Fj/Rhrp3EsQYhPDruVSOJ6fUtmp81TD7n/h/eqt81i8jSeE/pm7rQrICV+r1WJsh2jNPUa6imX9IbywHuTblD5jmr6yHxZTMJ+FubkzfR38/nsR1rzzH+JoWZbTYGlHa33x/M9e/OmGFILHO7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962336; c=relaxed/simple;
	bh=mXaUltMQOqY6mOy3v5upBPfZp2TJ2N/EvBax6MVebpE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YZ0uZ+DdRFky2iWfuULLh+N52+Lty44Qw8EK1Eeicu/mBFj1Jtt7Ggn2hVCJQYz3ep5sTG1Dn12E1btXynsrq9fM2jZbgM4IKTaBGvOmYgekSm0qLUpbpwjkT8aldcj7DkoniHeVjYvCSePLPQt8Plg+WDcHH51F9h5XDmj5Lrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kcwI/nRg; arc=fail smtp.client-ip=40.92.90.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL5TdZkEEE0o71YDKGcCWXi2914ym+vSHVEitAvv/DX/YlvUo7bGzGksngbDNDGDc0zYN4plVkrC+51On5oYjqQDEDOYz/VOx/jY8Ug63K39hYjjfRYD9Ix0gGslvG8e/CzpxKSbwtEL0oiUgcWOPIZl1x2wZthZeikW1L894Y0eO1bepmzeczcTi0LFJnTm1N3OAo5SmMGclfpmmROpU+pEvZm0V//6mDBthfK9m2++adYai4o+roOoq2Oe5E+6YLtSX1lB83qCpFEQsqHbyaf8Kg8dEDO4veRhR9R5VaIyFjJlvFG5G1A2miYkgv/cJnd0qJ5LIP4fCuneEn26Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZw/Lw/cxn36AmgX3V4Ar93G+6lP7C8ph2DovvJqq10=;
 b=unZS/+3F+80XtLBbxpHTZh1XastT9o9/fgc6rb8FDWa/d32eg+6xjzYF2XZJKVBAkH/3WDTfbJvMl9XwT5H++tW4degEOQTu6GS1gluGl35lAw07jJzMpiXgSxXzPTc2y2egeYudl8vzRNf5lM40pVLci7iXlfebxvyKdo3cym5jLb28ew7SGZP+rbky+yB9jMzT5vo8W+5zdtfxmnqB2VJqaZOTE6vLmFU+0itQFz1vbUhMueWHgwc0LzuIepL1dXKOnmU982Lt4kTFmVPm0jCRhXH2s6o28Sim3rQ5txokdTDtuIMeF2U8m8SUCacKnxxni/+Fh4J08f800XLeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZw/Lw/cxn36AmgX3V4Ar93G+6lP7C8ph2DovvJqq10=;
 b=kcwI/nRg/gyABaQilh86E6rdekkhquJyfJHGYNl2U5r5b0Blj0kN6YQDIACVxwPByLNLd4JiFJdvybkaaaWftsjNJotlCOIu+S0izKgBEM5rwsGGXlFXsvsKqchHSwnwe3Rr2k63STJzh1DpHDGlct00HDO/YHmH7XAQYMN7ajTkDrVPxIhNdCfSGcXTlV05stSIlgACXYfk8UBlBKxRE7za8+uIBbF2L7y/N5Apvg0T8qp5j1YC9C6oruBmyBkdZQPdeqQBIjHOho9tF0uvgP0Nm1mc8ZL6qLW3yQ0HvZOUjK6RSAZA5sAfVEu6mYDqw9F5F3WadjCk2xtPMAIk6g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10409.eurprd03.prod.outlook.com (2603:10a6:150:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 20:12:10 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 20:12:10 +0000
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
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpf: Make the pointer returned by iter next method valid
Date: Thu, 29 Aug 2024 21:11:17 +0100
Message-ID:
 <AM6PR03MB584869F8B448EA1C87B7CDA399962@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ITCKKKO8MRpVsLi+PvMuhIoOXkvwX773]
X-ClientProxiedBy: LO4P123CA0217.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::6) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240829201117.25056-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bf9d14-d9d0-42b7-bad0-08dcc866dd02
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|461199028|19110799003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	zUQmB4QdBN5XDo+ZXOUC4dR+E40cNKbwHaS6fA+qu1zmVQy/p+39woRSZdZACflf+v6r0iTH4n6ep1BnFBFiwPgN33vOd76PtqPaejt8YZj91udp+1AjM/65nOo6jpeQnTzizYlcLe8iuFyKH2s54Lsd9ClHINxbELAS6RfoIBAm4ySjNI22y2C2jSmqPZgpvjdQO3VUMSYN/1+wMSQSdl0C1FW/yUtMSvZ4t2rv/t+wQVyYH9I8WQioOzTFEtWh2iWCj8h5qFe/5ET5d1mrfhKUeUGCtAroYOGHZrmFokyxE9IkvUj8+9m2i/XHrAisSWFapiWC6xh9xvFWIVGhUQ8pkwCDtBG6qsjZRvPX0vjUoamYWGXfB8gbA0KRHZe8wTVMkeeyznOF0URlYVl4dDbI5AQSMD4KpQnxP1gg4365slGxQMAY8CFsx0NgERsaBQerABm9bEzmD3c4BAA8Z0JiQIKcYzg0xpQFYTFOcDYrpRP06BuUOkZqzxvBJqunxUCqHKe9kQAIEEV7fU8JifossSmPhVJU/wNDLdSKmImqeYFuTcfsa5FXUM2HMBOhacA4UWw2AAmmNPm2CDBntiXxc3XOtTq3EEda2pnJJcbFcCa5Xp2Lx/7HHX9sezEZ0woBlN0BQLaiAfq/hOFnyzP7HzMRwuKBxgNuPdfOkRabR107Gc1qZ6JWTuWiNmxjzlGpvGgdm4J7BYItOdjq3g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6GwBDZUBwqcbi0Vepn3q6LyKvM3EMykVSOhJDRHjWURReXIz/8wFomPl0dyC?=
 =?us-ascii?Q?OGiC3JpW20058lbCrzlfDAOf/Ts580OUSrwGBVq1tiiE96B6zY5QG5dd5JcP?=
 =?us-ascii?Q?xRh5FlhwT90OMjNqWLT9VckdyP6b11X3qR9k2UWDANqXVUDXRFmESiljBl4I?=
 =?us-ascii?Q?YOHeHeYnOTKQT+AdmH3xmRZIz8e5Uimh0eYWfUhzeYe6wP8XQL2Wx2J9+m5e?=
 =?us-ascii?Q?OAG2ifw4QdRS8CFD2EoJxF6iibi0TeM2BG+ckW0vKzZw9UfCzpij4FYlYkIp?=
 =?us-ascii?Q?VpDU88PUXiKmZZx0eu1wZwduzNMMyg2Tvsq4XECXbUEHLyw9GD23Cd27Lmk/?=
 =?us-ascii?Q?3rRrWIyd2yaH1lPbgbk2zNHAt+7/24YR4UnC1qISD6GhQCJqm+n4/AE9kG1h?=
 =?us-ascii?Q?pLTwIZSWJrq4RCEADb8/FBowVxfHidPeKX1B9MAhjlWViIcpnZljQn6rGVaK?=
 =?us-ascii?Q?o1WIbT/jOFLEMcbw1ZzJMHdG65vtvbr0s8U9u1SuXAGeVnbdA8CWqAAJTPPN?=
 =?us-ascii?Q?u7OYGUTc6pUd0pnG35CGOIt9XB3ASFXn/gaBptZI0MpBBdev9pSkfw64frHC?=
 =?us-ascii?Q?ByIF1Gmvqo1grkDiwnMV0SmX7NA/RpTymcTXN13E+OBZ/lEbARjxBcMgkrfu?=
 =?us-ascii?Q?37CvHEZsEnawBazsgSGgzCNU5CW3raiwndX1acRvYodmVaBKzuTPsH/5AjGJ?=
 =?us-ascii?Q?jcBZXnDWPByDW+aWn+fyBEun9l/ryZ26nUOPyuWOXYp01frVFyGIE6Z2pwpW?=
 =?us-ascii?Q?SLw/oz8BxoWOKXpUIdLc5sqJ5EMwCUEXuUWIwYMKP/+YZVtmP0tRnyybuAFu?=
 =?us-ascii?Q?W580BU7fHj6xuCaS1+D8jBU4ayXziBC2unFSDTqZfTUlbwG4Z+5If7CgY3U2?=
 =?us-ascii?Q?z3b+w33QgUV5PliyQntK2Ar3IBX+sRNTdA1czrJFaVCeTEAMSqa+tQ1s9ViE?=
 =?us-ascii?Q?LYnX1K2SXnXUhOK/6+A5f4ujdQ6ovcX+DoZ6inUNW6a20Hs+24XVuIrGcwJR?=
 =?us-ascii?Q?trKhAqgXOWuIjlMNGXY1tmjmYh0QMCgkTF8qMKvj4+XOLlLjb5mlG5+Dbc53?=
 =?us-ascii?Q?sNjcF89kp1ScOQsy9t3aKVsTxT5JuXwQv9+9AdR6CjNJLjceG4FsrAXo72jU?=
 =?us-ascii?Q?uy8SZchoJ9eYan0gBKA1P5AcL44DxIpOnT63LAN9J9QYiUVwYyWJDCVpFCjP?=
 =?us-ascii?Q?RsxLdfYe+WjJX73BYl/4hu1AlCluPOW35oBIjX5jkjE2JMbBtNgeNWRbFOwT?=
 =?us-ascii?Q?XithSAanpMAaKqTcH8p4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bf9d14-d9d0-42b7-bad0-08dcc866dd02
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 20:12:10.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10409

Currently we cannot pass the pointer returned by iter next method as
argument to KF_TRUSTED_ARGS or KF_RCU kfuncs, because the pointer
returned by iter next method is not "valid".

This patch sets the pointer returned by iter next method to be valid.

This is based on the fact that if the iterator is implemented correctly,
then the pointer returned from the iter next method should be valid.

This does not make NULL pointer valid. If the iter next method has
KF_RET_NULL flag, then the verifier will ask the ebpf program to
check NULL pointer.

KF_RCU_PROTECTED iterator is a special case, the pointer returned by
iter next method should only be valid within RCU critical section,
so it should be with MEM_RCU, not PTR_TRUSTED.

Another special case is bpf_iter_num_next, which returns a pointer with
base type PTR_TO_MEM. PTR_TO_MEM should not be combined with type flag
PTR_TRUSTED (PTR_TO_MEM already means the pointer is valid).

The pointer returned by iter next method of other types of iterators
is with PTR_TRUSTED.

In addition, this patch adds get_iter_from_state to help us get the
current iterator from the current state.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v3 -> v4: Eliminate the != PTR_TO_MEM part.

v2 -> v3: Move modifications to check_kfunc_call. Handle PTR_TO_MEM case
and add corresponding test case. Add get_iter_from_state.

v1 -> v2: Handle KF_RCU_PROTECTED case and add corresponding test cases.

 kernel/bpf/verifier.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f32e3b9bb4e5..f1d764384305 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8148,6 +8148,15 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_st,
+						 struct bpf_kfunc_call_arg_meta *meta)
+{
+	int iter_frameno = meta->iter.frameno;
+	int iter_spi = meta->iter.spi;
+
+	return &cur_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -8232,12 +8241,10 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
-	int iter_frameno = meta->iter.frameno;
-	int iter_spi = meta->iter.spi;
 
 	BTF_TYPE_EMIT(struct bpf_iter);
 
-	cur_iter = &env->cur_state->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+	cur_iter = get_iter_from_state(cur_st, meta);
 
 	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
 	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
@@ -8265,7 +8272,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		if (!queued_st)
 			return -ENOMEM;
 
-		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
 		if (prev_st)
@@ -12853,6 +12860,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+
+			if (is_iter_next_kfunc(&meta)) {
+				struct bpf_reg_state *cur_iter;
+
+				cur_iter = get_iter_from_state(env->cur_state, &meta);
+
+				if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
+					regs[BPF_REG_0].type |= MEM_RCU;
+				else
+					regs[BPF_REG_0].type |= PTR_TRUSTED;
+			}
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.39.2


