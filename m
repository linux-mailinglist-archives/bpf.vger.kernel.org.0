Return-Path: <bpf+bounces-73431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF5C31414
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 14:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D68874F8266
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50460325714;
	Tue,  4 Nov 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="zlAP6LPk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5721D585
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263058; cv=none; b=G8dxyi4Jag1RLXvwBiii+y5p2S5vehxRXJIZa32ImG6j+dXhfA0c/UGsgF3rEkBdMkMWBWE1aHmDVduRkfviGod1bG58np4X5y405DUzAFwferqPJlWQc6ABFvVaKvE14oMNO3tiw5mBwlqbsp9+U0np/efLB4VvgKG3AVWDZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263058; c=relaxed/simple;
	bh=Uq1MXrr742jdEAtLGli++IWy3BudiLWW1PDF5goV7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv5hcDgDszpkz37plbbqr8V3y47WeWgVx1Z4QDV0OuEjCzIyiL6KDSPwGdvKgywbONySnWYDPz9Z2YWtiPYbevnbT6CYv6OS3vczso0z/QOlkN9NaGpAUz/6dDdlplcC7K29lGxaSCHAwOnaiNqQtjAuOUuXEktpkBXwJOrFhWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=zlAP6LPk; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 9CD5D11F81C
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 14:30:48 +0100 (CET)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 1244C13F648
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 14:30:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 1244C13F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762263041; bh=bs9MrGdoyMEXQCE7tWU4GcYgJAaAACSlj27k+qOnpjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zlAP6LPk2zjKyT7f5Z7rrarFk2or1Gq2VT4jj5meIghHaL3KVNLvBlIzL2yjgSkSp
	 DPr/6Uk/zgoVnStE5+EMl7eCtZYkK9N3QYEfRT2xVm6g3p7FZV5yhAkMR0wfi/nEUN
	 Jt6iBaZxORkg6icafBifAqRKKhyyc1lj18ENsvTk=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 058E7120043;
	Tue,  4 Nov 2025 14:30:41 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id E74DE40047;
	Tue,  4 Nov 2025 14:30:40 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 132B3100034;
	Tue,  4 Nov 2025 14:30:40 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id E6AED20044;
	Tue,  4 Nov 2025 14:30:39 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id E03D3201A9; Tue,  4 Nov 2025 14:30:39 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v2 bpf] bpf: properly verify tail call behavior
Date: Tue,  4 Nov 2025 14:30:04 +0100
Message-ID: <20251104133004.2559222-1-martin.teichmann@xfel.eu>
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
add new constraints. Some test are added, notably one corner case found
by Eduard Zingerman.

Fixes: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet pointers")
Link: https://lore.kernel.org/bpf/20251029105828.1488347-1-martin.teichmann@xfel.eu/
Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
---
 kernel/bpf/verifier.c                         | 25 ++++++++++--
 .../selftests/bpf/progs/verifier_sock.c       | 39 ++++++++++++++++++-
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e4928846e763..9a091e0f2f07 100644
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
@@ -11911,6 +11915,24 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		env->prog->call_get_func_ip = true;
 	}
 
+	if (func_id == BPF_FUNC_tail_call) {
+		if (env->cur_state->curframe) {
+			struct bpf_verifier_state *branch;
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
@@ -19876,9 +19898,6 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		return PROCESS_BPF_EXIT;
 
 	if (env->cur_state->curframe) {
-		err = bpf_update_live_stack(env);
-		if (err)
-			return err;
 		/* exit from nested function */
 		err = prepare_func_exit(env, &env->insn_idx);
 		if (err)
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 2b4610b53382..a2132c72d3b8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1117,10 +1117,17 @@ int tail_call(struct __sk_buff *sk)
 	return 0;
 }
 
-/* Tail calls invalidate packet pointers. */
+static __noinline
+int static_tail_call(struct __sk_buff *sk)
+{
+	bpf_tail_call_static(sk, &jmp_table, 0);
+	return 0;
+}
+
+/* Tail calls in sub-programs invalidate packet pointers. */
 SEC("tc")
 __failure __msg("invalid mem access")
-int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
+int invalidate_pkt_pointers_by_global_tail_call(struct __sk_buff *sk)
 {
 	int *p = (void *)(long)sk->data;
 
@@ -1131,4 +1138,32 @@ int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+/* Tail calls in static sub-programs invalidate packet pointers. */
+SEC("tc")
+__failure __msg("invalid mem access")
+int invalidate_pkt_pointers_by_static_tail_call(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	static_tail_call(sk);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
+/* Direct tail calls do not invalidate packet pointers. */
+SEC("tc")
+__success
+int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	bpf_tail_call_static(sk, &jmp_table, 0);
+	*p = 42; /* this is NOT unsafe: tail calls don't return */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


