Return-Path: <bpf+bounces-38383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC319964222
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FBC283BFF
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318C18DF91;
	Thu, 29 Aug 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qtb05jqg"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2040.outbound.protection.outlook.com [40.92.58.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E818C939;
	Thu, 29 Aug 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928345; cv=fail; b=X2ZudPebi75/sx2JIYz41dhjgD5htoZ/H/h24F2TGFXeZ8coQ10ZGEoRH9UhKh+oeEnqLuh1kYxA0ehBToPCH+2xPo1N7IYOZwUyw1NB8MxLw4BH1aJ62+nl7DX7hLG8BjZXmYWwHv20J3uXIunDGVCaMwEZJ9rUg+NGU4l6rT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928345; c=relaxed/simple;
	bh=SsU5TiSazmIsIGTL502aPX8RKWwfURI4jhsLqsNlafs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H46TXMAuHiki1svMUPHGBlH4z7i4wtlYe1KUXPT8SXJXyUI+LyCcY6ROnzs07PWHm7KkSyj1TjcGgSIGXBBfyV9IRF8Qij+6MjULnYOCqjo8D1aBwXqfPope7VWjwpwbr+dna0d2MoTjDNyvt/pIZtGpT6AHy4qEjpceoNMkTkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qtb05jqg; arc=fail smtp.client-ip=40.92.58.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzfOdVYcH6vyyWRjL4h7D4by+IpfGN/PmaEndhRv9t1ex2IVBo+0lDbM1V304DYihLGp7o37H9Ag9PeDW7Ln1PkLVYo467Dgy/e1jETx+fDSnvjg8bK7jPd5x0hZPV/RJKtuXUBQBDpnJYtxh7Eu8A7Oz7CWfINmzEpQicOxjyhgUoK7ZHjR2akxC3ooHCAVaoIBywtGjSAllyIDYAtBK2C8rXEvTT/3jEfnBgJJW4FPiLB0IAzyaUO0r9EJJkohqDBwEz5e0bhU+ZJBsUEfwSPoym7aYTy4nxKi5zXDIHf79qOxT3QM7n94C2/O0Lx3oZww1PNyVr0Gnfr5H/dzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKtAnvN5Q8nw1TcGbnd42A7HAqg+l0BRyJgDP1K2ivs=;
 b=rWdw4sPmSRSqBAxALwuvFyf7SPGprIZL967nZvvfVc0Ho16MtvnEKiQ2iZFEp0JxVtk/O3BnACngvfjjbeOZeYLBopRdO13cs30sl2aI7qqM73+Sw4GkMLvQHm6GzGGg5qgMktOWLh1RHCsY8DvcDJGqZAk0iAa7hqVWNT7uweh/PIYLsur5qABha3sVL0A2zXo4bJGbG29/FWz8qnbpQwfORHiXnniStOg7m26kw1Wq13DERj4/UGrtfwTfcc+bhCyKiJ7U7jgB7lPvNIXxxCK07q+2B0rgdAOuRDSKsr26uE+cqKlJ2OyriXpdJlWne24j5ppIbKZyGDmOfF+wSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKtAnvN5Q8nw1TcGbnd42A7HAqg+l0BRyJgDP1K2ivs=;
 b=Qtb05jqgQIbM1qyKs0DSg24uimhSgQbZV+/vtyEQAAlYas4XnWQ985ZTrTNIaCJzWR4rJM9FXFxCMXDjaxDzOML6IOjIHVEQGSlkf/8FaVFmhyI1ebchBcf77RZtrDLfHMISSFQXAIvKobMaujMnXI2XgVNnwdN0lNhoF/aYgNZ169kpO7qJ0hBx6m9RvVR6eFjGkEsPR021Qh/i8G3kLO/pCR3vqYQvrdl+veisCmyUV564AY6GEHAj5FsI9So9rJiHW9vLi+s14wbh35ZKpXDvo7x/VjX8rmu2+l20yGnh4fPXPaALa54S6USugGl5RCp4BK0M3TETGp5uZZ7/tQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DU0PR03MB9125.eurprd03.prod.outlook.com (2603:10a6:10:464::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 10:45:40 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 10:45:40 +0000
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
Subject: [PATCH bpf-next v3 1/2] bpf: Make the pointer returned by iter next method valid
Date: Thu, 29 Aug 2024 11:44:48 +0100
Message-ID:
 <AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [aSHynv4Qu2AjAaYQrRnDG2vKLmEasP5m]
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240829104448.10473-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DU0PR03MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: ad212cb0-a006-4917-95a0-08dcc817b854
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799006|5072599009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	q7KEb6zTffpZXbrJkmL/IZG943dCEF154brD3SM/AB7JWzdtIwahEEREfwxWniB7SU0IZU3NTGZhQAFzI7e0GmSgQVROGxIWc9cJ8lgrGroAXg4MxEnrcMX23cyvWqk4RDhu1PLi731+Z/nFYCaQuSb+ZotGXXIsP6xem+hvJLHLli+jLpY07befeYGli3iENngU5zl9jfEmXMvr7ah91TKYuCoWmYIZ0iR4Q5iYsdwY1628IqWTFx1oiCkBCcFDeZUObfCDisAQarqsz4xPFKHszuAOtK0I1Phd4cWAYsmAY+ZCs/pjqtMAIKuY9FjxuS+Pi6UFa99BGkp5e3L8nhlH3XY3pMOijTsj2S/qgMxpl2X9hlzSCr+Z3YoIEMz6vqqiZRF3+VweVsnON2qtyhyIbh+7JfTOVPvZMtZAZ+CIDuAf7CbfikN/sf2oKK8dROKAZwyoC3uojd1I53PO5JGOAA0s0cPWneIa1ADtLBERxm30etBSWQRJifc6x4yqsXJfbjGBnNXBScbbR4JFz7+jxUX2/oLZiU2z4yz2L+R+itYNybk785MjyUHM33L0Pez9kZkTahAW1Xp27p1/sQATiBDVdXkfJY+Dzqz7iHNHQWVbnU/keMRHS3ZbowmiVJF9m63DUZV91mqmxFdJXj3FazNFPPQfHxINoRKIvXKsUpiMI4GFDyFh2RSW+OybpcuDcUGa68+mcGSaCiTWlw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mn5LEr/iYeznO07AzrBYVYnZlBWhBd0WO6q6hSC6aBPdC9KjJogPlO5v+PQa?=
 =?us-ascii?Q?5jNC9TMKI25znhtP0AklORq01k91baX17s8xmjk7KZiU9XSNmyZmGE5X667H?=
 =?us-ascii?Q?rR5gvLaKLBmG3eTlGpUPkhtODua8U8V+EKvZp1ZU2rRB6J8sJdKkn05OieCQ?=
 =?us-ascii?Q?X4KbbRqguaGBDEf4MfprjvH3xX2ABvsvWkCdV1DpPQVLAKoleltL6xF4YqOK?=
 =?us-ascii?Q?9AS51dwF2AQdLzPSu2p2r282mBNl1IJo5u3OSEgXJFRnujBNUYTXB3kHjBJN?=
 =?us-ascii?Q?b8FPqE0JkecFmBFJZCS5lgscUcP0WYsrPETFfTG/G3Y/w10lFdNCgL/yXss9?=
 =?us-ascii?Q?tKOp4xjcRJW2ZwP+WqKEVjcneLNq3gfSfB864OXahXGPfPWzGvcWdiTJNM6n?=
 =?us-ascii?Q?J6ctgzo+9Mc1GCjHB+nGNYxxf+cqUZG0jO7Pj1m8Vx3pk91cF93bAhhA/gRT?=
 =?us-ascii?Q?WnOXRc27PsOb44v4c34JUhr0c7MeBZRqaEfbHV04D/q0Ho82O9dm0oT1yvW/?=
 =?us-ascii?Q?DzkBwWMCTCPrrD9NlKbUfIePy76TRc2pcS7wrYQ6ukwe2efoL/o124PyvUZG?=
 =?us-ascii?Q?wOeTYEmA06rm5tHa73Gm+63OVWX7CMSw/k318mnLc6/VsMF/hRFyem9YCASH?=
 =?us-ascii?Q?QM00D6lAee5bv53w8F1OcT7pssNHyIhhPIecwr38sun5CdaaPoZeC6NB7BZM?=
 =?us-ascii?Q?Sjc5jDH19bzQUi2nWFikNCBqD1n7yMmIaz/X26IG4qDxq3AmBc1X0LaebKCI?=
 =?us-ascii?Q?LO64wciIqc9nPoaBawJ9TNzaxwJi8to4DY6LCMpycK56haJIk4tHfgOz1DU6?=
 =?us-ascii?Q?Mke63oViyl7qcqE7mgcv7+VSnIpCBsb2NsCPOh7HuFEuAPlmJGZJHYVGcX43?=
 =?us-ascii?Q?lB+Xu/XCZAS42vm1YU265rvKczWxjb5iRWHfKxN+8fPssA8g4gZ8Fmxkyj5b?=
 =?us-ascii?Q?hcahyBTdJ03y6jg5zK70fEN0kvWozvH3e2ipfy99nuakvNmr5KDJCsze27Cw?=
 =?us-ascii?Q?jgEmz4uiczKd0WgQUkaNiFUJCNJ6ngIVXYQ+WzFg3V/HfzXFjgEkKJ+sRhlk?=
 =?us-ascii?Q?fO6Imjrakizy2FORC+K/F5cDZAOnTfy8Hx+XESZVI5LufmFYtjaRM/ew4E6H?=
 =?us-ascii?Q?rrfzA8wbV23cEG2L6LeX4K+O8bUi4HHFDUeBij3Ujl8l7MPqcdqsafii6zSQ?=
 =?us-ascii?Q?0HZ4LUsRYKWY+mpyj+cpBnWk20jXk/1b4f4bTNmPFJe+Q+zYQC4GZmDRnj+w?=
 =?us-ascii?Q?5/IEKrkDHBP7ttnsZ+wu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad212cb0-a006-4917-95a0-08dcc817b854
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:45:40.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9125

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
v2 -> v3: Move modifications to check_kfunc_call. Handle PTR_TO_MEM case
and add corresponding test case. Add get_iter_from_state.

v1 -> v2: Handle KF_RCU_PROTECTED case and add corresponding test cases

 kernel/bpf/verifier.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f32e3b9bb4e5..bc146671742c 100644
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
@@ -12860,6 +12867,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
+
+		if (is_iter_next_kfunc(&meta) && base_type(regs[BPF_REG_0].type) != PTR_TO_MEM) {
+			struct bpf_reg_state *cur_iter = get_iter_from_state(env->cur_state, &meta);
+
+			if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
+				regs[BPF_REG_0].type |= MEM_RCU;
+			else
+				regs[BPF_REG_0].type |= PTR_TRUSTED;
+		}
+
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
 			int id = acquire_reference_state(env, insn_idx);
-- 
2.39.2


