Return-Path: <bpf+bounces-73803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81705C3A608
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 11:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCFE1A46952
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E632EC080;
	Thu,  6 Nov 2025 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="x90QYBLu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179292E7F3E
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426379; cv=none; b=VVSNAPFUtIzaZgh6i457uQBPq0x80NtKVETacRpkkVDNs0PkFT6kEczB93fo4bOK0A7jNciS0FOlNon3ww9g9Bo3B9lO22o2MT9N4n+B5WpfxRCg1O88+m+T/Cuyz+VYaGVrF7ZmAmC7sOirgO29XDLLG0cDZB2t2/N8LtQzLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426379; c=relaxed/simple;
	bh=MLBwo9RpCJlbsGdVD/SOnAbNgflLxpXS9nP6ZYnbK6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCUqiRCwxfaMz0c5CpXOv8NFWE1L71a2/nrPVLrowIc5KEd5T0yWFJeCvI+KjYBcIqMfPQsJM3EBEF4Vxo7RRV6XRAqO/sNN68dGUXidDahu9n1/HPwTXdvR/9ksAp4KT0UvC2Nkwy6n89p3Bp0D0FE2ruBZEnDbHSElzI7ggkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=x90QYBLu; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 119CC11F749
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:52:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 119CC11F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762426374; bh=SH1Rf/3jUhb/Yuzw6mxVWPrHivlOeO/ZfECNxEol03I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x90QYBLuStKX/FUUID+k7hxh3jp4FvENbq+m+z4fJLc8Ro7omIfe2ugnA7eNWbAEX
	 35ylNLqtcHWveLhXHRHfe2Mc6rNCidRN30McML45QUcgPxYj1k9MWuh3rCBRQZ7v25
	 VDPFYOU6CjPpujAVqjnzJ1vItRYlYKxH4XK7wXjc=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 052FC20056;
	Thu,  6 Nov 2025 11:52:54 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id EE6E340044;
	Thu,  6 Nov 2025 11:52:53 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 07E17160059;
	Thu,  6 Nov 2025 11:52:53 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id EFA632004C;
	Thu,  6 Nov 2025 11:52:52 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id EC07F201A9; Thu,  6 Nov 2025 11:52:52 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v4 bpf-next 1/2] bpf: properly verify tail call behavior
Date: Thu,  6 Nov 2025 11:52:37 +0100
Message-ID: <20251106105238.2926962-2-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c571ab7af853a3f775be3a518f99ec809f49797f.camel@gmail.com>
References: <c571ab7af853a3f775be3a518f99ec809f49797f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A successful ebpf tail call does not return to the caller, but to the
caller-of-the-caller, often just finishing the ebpf program altogether.

Any restrictions that the verifier needs to take into account - notably
the fact that the tail call might have modified packet pointers - are to
be checked on the caller-of-the-caller. Checking it on the caller made
the verifier refuse perfectly fine programs that would use the packet
pointers after a tail call, which is no problem as this code is only
executed if the tail call was unsuccessful, i.e. nothing happened.

This patch simulates the behavior of a tail call in the verifier. A
conditional jump to the code after the tail call is added for the case
of an unsucessful tail call, and a return to the caller is simulated for
a successful tail call.

For the successful case we assume that the tail call returns an int,
as tail calls are currently only allowed in functions that return and
int. We always assume that the tail call modified the packet pointers,
as we do not know what the tail call did.

For the unsuccessful case we know nothing happened, so we do not need to
add new constraints.

Fixes: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet pointers")
Link: https://lore.kernel.org/bpf/20251029105828.1488347-1-martin.teichmann@xfel.eu/
Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1268fa075d4c..7a817777fbb3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4411,6 +4411,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					     bt_reg_mask(bt));
 				return -EFAULT;
 			}
+			if (insn->src_reg == BPF_REG_0 && insn->imm == BPF_FUNC_tail_call
+			    && subseq_idx - idx != 1) {
+				if (bt_subprog_enter(bt))
+					return -EFAULT;
+			}
 		} else if (opcode == BPF_EXIT) {
 			bool r0_precise;
 
@@ -11034,6 +11039,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	bool in_callback_fn;
 	int err;
 
+	err = bpf_update_live_stack(env);
+	if (err)
+		return err;
+
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
 	if (r0->type == PTR_TO_STACK) {
@@ -11940,6 +11949,25 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		env->prog->call_get_func_ip = true;
 	}
 
+	if (func_id == BPF_FUNC_tail_call) {
+		if (env->cur_state->curframe) {
+			struct bpf_verifier_state *branch;
+
+			mark_reg_scratched(env, BPF_REG_0);
+			branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+			if (IS_ERR(branch))
+				return PTR_ERR(branch);
+			clear_all_pkt_pointers(env);
+			mark_reg_unknown(env, regs, BPF_REG_0);
+			err = prepare_func_exit(env, &env->insn_idx);
+			if (err)
+				return err;
+			env->insn_idx--;
+		} else {
+			changes_data = false;
+		}
+	}
+
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
@@ -20110,9 +20138,6 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		return PROCESS_BPF_EXIT;
 
 	if (env->cur_state->curframe) {
-		err = bpf_update_live_stack(env);
-		if (err)
-			return err;
 		/* exit from nested function */
 		err = prepare_func_exit(env, &env->insn_idx);
 		if (err)
-- 
2.43.0


