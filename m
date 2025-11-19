Return-Path: <bpf+bounces-75085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5ECC6FEC5
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9A7D728BB9
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2112EBDCD;
	Wed, 19 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="aWDqPSy4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE115A85A
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568250; cv=none; b=SAZTUwoLpJtbKykE9aG6HxhJN6FNzXZTW77tEF9i1NxmMU1aqeOuLLiyIbjIZxLeebvbkdTOmH+wffqQfY1nOKlguZsUB55RqxR2Z2VwikEni4cOt2vQrosGXqrqnT7qWNWsvT4zRSnJO16v9taQgPGmrJ3dSig2OoqmAqbuSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568250; c=relaxed/simple;
	bh=qJdOPE5FNuU3srjiKSLukuT2A2hUqofLL26JIk/I33I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4hQl3iYYhWnwiaGO/ud+M4Qr6b657bl4cNQZiaZuJc6lun64RKs2qaosFtwZIV/p+aUssAPwT2ZtgtbDKCui4x3foyDqjsHxzuEkjjWkldOdX9HShQnRhDBsuZ03TQpDndnCMC6BdT6cLI/n/LKkRtQFGXypXOF7rgh3egq24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=aWDqPSy4; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 4016F13F653
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 17:04:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 4016F13F653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763568240; bh=t2rSCeOOC8PD6LNPkNeu7KUbArtQUsty0kJb+21ZFD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWDqPSy4S0WBpc6zdIdYk7/fNjYQ0oVHAFgHQhbQeBzEgR6ziREFDkyXAVOJ2iXHv
	 +cGviATqcZt3zKYgKFCCxj+XnljFG7gIvLcUSJu0NRG0K7YxUkSwoG4zpWJmblGbh2
	 4emsSgfoHNIzxiKcyJxXRDV5DQkq+ANhSoe3V6BQ=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 339D7120043;
	Wed, 19 Nov 2025 17:04:00 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 27DD116003F;
	Wed, 19 Nov 2025 17:04:00 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 45051160058;
	Wed, 19 Nov 2025 17:03:59 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 35C9420044;
	Wed, 19 Nov 2025 17:03:59 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 31EF7201AE; Wed, 19 Nov 2025 17:03:59 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v6 bpf-next 1/4] bpf: properly verify tail call behavior
Date: Wed, 19 Nov 2025 17:03:52 +0100
Message-ID: <20251119160355.1160932-2-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <622f4e7645e426ae180e4511877eb90ceb1b1063.camel@gmail.com>
References: <622f4e7645e426ae180e4511877eb90ceb1b1063.camel@gmail.com>
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

This approach also allows to check other problems that may occur with
tail calls, namely we are now able to check that precision is properly
propagated into subprograms using tail calls, as well as checking the
live slots in such a subprogram.

Fixes: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet pointers")
Link: https://lore.kernel.org/bpf/20251029105828.1488347-1-martin.teichmann@xfel.eu/
Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..117a2b1cf87c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4438,6 +4438,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
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
 
@@ -11064,6 +11069,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	bool in_callback_fn;
 	int err;
 
+	err = bpf_update_live_stack(env);
+	if (err)
+		return err;
+
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
 	if (r0->type == PTR_TO_STACK) {
@@ -11970,6 +11979,25 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -20140,9 +20168,6 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
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


