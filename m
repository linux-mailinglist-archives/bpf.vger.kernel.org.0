Return-Path: <bpf+bounces-74086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7421C4790C
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84031421D4D
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131D22580F3;
	Mon, 10 Nov 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="wZn728GP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0A248F77
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787940; cv=none; b=Js0wMSlE2QTgzC2KIeV4Q5bD3NvCKzUpDsnXNS+9crYVEef4a5T+05cRGP5kQeUDQd7DTEiLipDgO/X3WJ5xDPAJUdiEL/rNyaKqFDahGHF59MtxN4EonQ1CgRYmXJgE6VaBM5mszV5SIL+GvaiNsK0E8FFhaHKkzfs7S3tzgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787940; c=relaxed/simple;
	bh=kye5DnTFAAQIU4K62j4i5UzfriuhnRyP/Xpz7vebdQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpHjZXKb4LwyZRPHMqyyhttB3Zq+U9hXI+Igc9nE1Yo4EcPaHvoAmVVVvjuVt25cHvb53zQ7xI9aX6mMqGuXNRwYavsD/9jXfAk7YpAzpCJU+ut2Rjl5h4dGnYXRjqgS1066QWe6zFVv2+7TGW4VVsTrHe1D5O3RPRLidValwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=wZn728GP; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id A03AD11F74C
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 16:18:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de A03AD11F74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762787930; bh=DFj+OFGGK8S65xvKMiYtGacUYa7c1sUCrkSidbAriV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wZn728GPYt8qCi1Zbyd+xx/cKcwSK0XJLI48FOlIN8SjylpU5A3dcioUD72064lJJ
	 zgKSqW9fCk+0YgrNyjA7Wejm9Wlt9tQD00v2FO3mJXNqVCmWYadeeT36IUog9PqS04
	 o4gAr/oad79M+gP/lKO73ZHamXTLIH8QDQQgXgGo=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 93FF820056;
	Mon, 10 Nov 2025 16:18:50 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 8598540044;
	Mon, 10 Nov 2025 16:18:50 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id D3A34100035;
	Mon, 10 Nov 2025 16:18:49 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id BBADA20044;
	Mon, 10 Nov 2025 16:18:49 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id B75A9201A6; Mon, 10 Nov 2025 16:18:49 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v4 bpf-next 1/2] bpf: properly verify tail call behavior
Date: Mon, 10 Nov 2025 16:18:43 +0100
Message-ID: <20251110151844.3630052-2-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
References: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
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
---
 kernel/bpf/liveness.c |  4 ++++
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index a7240013fd9d..54f4772d990c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -500,6 +500,10 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 	if (opcode_info->can_jump)
 		succ->items[succ->cnt++] = idx + bpf_jmp_offset(insn) + 1;
 
+	if (unlikely(insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg == 0
+		     && insn->imm == BPF_FUNC_tail_call))
+		succ->items[succ->cnt++] = idx;
+
 	return succ;
 }
 
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


