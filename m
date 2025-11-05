Return-Path: <bpf+bounces-73679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4EEC372CA
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67F884F5D9F
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ABC338F26;
	Wed,  5 Nov 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="fyALSd2B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14F32ED3B
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364471; cv=none; b=S8xwLwGxE95uy+lqHvp5zyyhh/5rEMzcpf5GKDOfwm5pMq22PBvQBubsvgnlyzPzst1iVQktS9rCqEAmHA0I+efDg3tw6Wp/3EQQHV9PCoGBphz/OFEf+DT5nBo8ftJT4jSVEx6usfvY4q52i2Dq6HVY4UI6qAVK5T28AUvQQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364471; c=relaxed/simple;
	bh=3vktiMCqiHhUi0g/nv7LeafEFneCQxPYl/+ZNm9Uo2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvKuu0rY8+Jccare/iysOuK5Cyd3ZT8REtHvKQvglPb79aDtcVAvWXXrrarT0IshcR2Z3y4WvQiAz8+DHEor38CCQ7Tyvf9uV/LtvTiOQ4Y/5aHJngo54tE0v2n+IVw2fSNZkW1WGV6PIm1cJLWLfbjm9Wom7AGM1HjJizmgi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=fyALSd2B; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 7E70911F746
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:41:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 7E70911F746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762364465; bh=1G3xtRorofAB3lhrMiIpO61+B83oowjplyu5fcxOOc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyALSd2BxQezzaMvCVEAxoVVPVyPOYPsqnhjjhKy7POFvZvx2AKhwNcW+Xs5EnyHI
	 jgnTF7WLmmOgH49NJ/3CL0n08gbbHJT0tXdCyWq74EH6yUxq169iCoIbmUFx0UBXhW
	 65CODXoRHD2/ykTPRnoUXAG/dPnI1SKAoTiSdo+4=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 71F7620056;
	Wed,  5 Nov 2025 18:41:05 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 64EE440044;
	Wed,  5 Nov 2025 18:41:05 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id D5147320093;
	Wed,  5 Nov 2025 18:41:04 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id C36CC2004C;
	Wed,  5 Nov 2025 18:41:04 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id BEFA3201A9; Wed,  5 Nov 2025 18:41:04 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v3 bpf-next 1/2] bpf: properly verify tail call behavior
Date: Wed,  5 Nov 2025 18:40:30 +0100
Message-ID: <20251105174031.2801707-2-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
References: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
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
 kernel/bpf/verifier.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e4928846e763..b9e54acbd74e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11005,6 +11005,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	bool in_callback_fn;
 	int err;
 
+	err = bpf_update_live_stack(env);
+	if (err)
+		return err;
+
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
 	if (r0->type == PTR_TO_STACK) {
@@ -11911,6 +11915,25 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -19876,9 +19899,6 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
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


