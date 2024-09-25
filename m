Return-Path: <bpf+bounces-40299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E154D985BEC
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A199028773C
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038661C9DFB;
	Wed, 25 Sep 2024 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGVsAYro"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948F1C8FDE;
	Wed, 25 Sep 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265200; cv=none; b=BgSwL+lvkKHDR10hgc+Ja2xyTM2UubtueJEx6U9LKnmeYK89C7+HjOy3EGg/ygo7ml9hC0va/Z5WSyQ7jO7Ttjc31QSG+AEknJuWvG5WonFylWlr9Zlym7YPRqF1URhA2yZofVDJsiwbrSmMU0l7v9jnQJ9KOyDuJIiGsqxJcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265200; c=relaxed/simple;
	bh=AJKGa4seFwf7BNn2mymUTwSgrHFAiwrq59tF22yxf3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlBuIrDVukk6u5G81plF3PsP7WGHSiiLYPRDcoo81kOZeSIvb6yBTWY+KCcGoEIvylNKKwEyQ4rg9Xh8DtL9E4HQfB8u1JRT7992PgZRqfQPK3k7FvdfsNSdIc7SEsfLPLAVIQTX204FEx6Duj45IpTA26aC7uTpcjNo7oDGLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGVsAYro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534C7C4CECD;
	Wed, 25 Sep 2024 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265200;
	bh=AJKGa4seFwf7BNn2mymUTwSgrHFAiwrq59tF22yxf3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGVsAYro5FU9GsmZB0f520/I+C8jUORolnDGWwz0zLxHh5G7Pr25F+9d9wyDqyHP0
	 viNhcg3gU10VJBtB/2rMQzjouUfwds6WCR2sTL/FiyJ7aoq/APXRtyQ3cBU+5WCDOt
	 UltU06RNkbjxe3r/eHQQa5U4oG9EsWlNR5/F6Ejso9rFzZEL+1CcoZY2cMyA7H0cVb
	 bu9HOywwm17CSnJBKFEcbu2p+VzeTjYaP8s4njy/FOVsu/l2B75pHeCYZ/H/eoYm/t
	 0+yhR/NKPMC1hj2tixN69lOVDlha9QXG8mcJcOkaxDVtEnogjOB0sXD9IMXHZk3FpB
	 uCYFek5I5W5ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juntong Deng <juntong.deng@outlook.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 236/244] bpf: Make the pointer returned by iter next method valid
Date: Wed, 25 Sep 2024 07:27:37 -0400
Message-ID: <20240925113641.1297102-236-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Juntong Deng <juntong.deng@outlook.com>

[ Upstream commit 4cc8c50c9abcb2646a7a4fcef3cea5dcb30c06cf ]

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
Link: https://lore.kernel.org/r/AM6PR03MB584869F8B448EA1C87B7CDA399962@AM6PR03MB5848.eurprd03.prod.outlook.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8520095ca030..3b20c3e614e19 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7987,6 +7987,15 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
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
@@ -8071,12 +8080,10 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
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
@@ -8104,7 +8111,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		if (!queued_st)
 			return -ENOMEM;
 
-		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
 		if (prev_st)
@@ -12671,6 +12678,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
2.43.0


