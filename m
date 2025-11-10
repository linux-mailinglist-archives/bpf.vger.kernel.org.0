Return-Path: <bpf+bounces-74087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E505C4784F
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 16:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DE614EE98B
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56312512E6;
	Mon, 10 Nov 2025 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="S+9sTsuK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0551E492A
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787942; cv=none; b=HoGeqhVAsBe2wI+S0lHICocH3eQKOVXKNlxxf/579SVvYy/CcqiKjtrwgw7BMFumFBAxCuENZydb8BsirS372UjMUthhy6ZtC/FV4nZAEyIfFoiMr4qlu4A72QlEN9B51CKNRtX6uPIAjKH1H8Aie1vIgE6+lk7jt9vHIcN6T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787942; c=relaxed/simple;
	bh=TAuujbCCnA3FJHDvi1YZ6fcC3Z3u5aktjr6jlLdYwCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRR32NbKDLqzWjxL3tjIxvX+0esMu79QvUQYhNudn6E4y6NtLE3APFZ6Z12MrRxtIXYhsJ7IJXm2c41/yzrXTRU6BFWlF0+3/rS15ankH68GYbnshXKGWmEvcfkeQoEaV3Y/hjwE8Rot+gNwaRCU/OXTH1A3UBeor+MfwxXW3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=S+9sTsuK; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id C4FA113F648
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 16:18:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de C4FA113F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762787932; bh=ibl0oJDw4ncCE3552EKUTkStALab7K8p2Wb5JxAi8ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+9sTsuKD0sCrxx/r5bEgvwNJyWU1sRS+0zRgadOjaktXu2DrN8n8dZI0AtRHw3KZ
	 IdPjWHzdOJu5G6/L9qDsb9fRnPqfvq4XyV1NAHT6IBoKiPxTKVbHV7k3E6I2j7MoiD
	 SpSyshJlYjMjrAjyzvvElhtuF7ccSVBXoRzapjfw=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id B85A1120043;
	Mon, 10 Nov 2025 16:18:52 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id AAEB716003F;
	Mon, 10 Nov 2025 16:18:52 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id C0188320090;
	Mon, 10 Nov 2025 16:18:51 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id AF3618004E;
	Mon, 10 Nov 2025 16:18:51 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id ABC38201A6; Mon, 10 Nov 2025 16:18:51 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v4 bpf-next 2/2] bpf: test the proper verification of tail calls
Date: Mon, 10 Nov 2025 16:18:44 +0100
Message-ID: <20251110151844.3630052-3-martin.teichmann@xfel.eu>
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

Four tests are added:

- invalidate_pkt_pointers_by_tail_call checks that one can use the
  packet pointer after a tail call. This was originally possible
  and also poses not problems, but was made impossible by 1a4607ffba35.

- invalidate_pkt_pointers_by_static_tail_call tests a corner case
  found by Eduard Zingerman during the discussion of the original fix,
  which was broken in that fix.

- subprog_result_tail_call tests that precision propagation works
  correctly across tail calls. This did not work before.

- caller_stack_write_tail_call tests that the live stack is correctly
  tracked for a tail call, again a corner case found by Eduard
  Zingerman.

Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 49 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 39 ++++++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 47 ++++++++++++++++++
 3 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index c0e808509268..9cc53eb1a545 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -292,3 +292,52 @@ __naked void syzbot_postorder_bug1(void)
 	"exit;"
 	::: __clobber_all);
 }
+
+struct {
+        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+        __uint(max_entries, 1);
+        __type(key, __u32);
+        __type(value, __u32);
+} map_array SEC(".maps");
+
+SEC("socket")
+__failure __msg("invalid read from stack R2 off=-1024 size=8")
+__naked unsigned long caller_stack_write_tail_call(void)
+{
+        asm volatile (
+	"r6 = r1;"
+	"*(u64 *)(r10 - 8) = -8;"
+        "call %[bpf_get_prandom_u32];"
+        "if r0 != 42 goto 1f;"
+        "goto 2f;"
+  "1:"
+        "*(u64 *)(r10 - 8) = -1024;"
+  "2:"
+        "r1 = r6;"
+        "r2 = r10;"
+        "r2 += -8;"
+        "call write_tail_call;"
+        "r1 = *(u64 *)(r10 - 8);"
+        "r2 = r10;"
+        "r2 += r1;"
+        "r0 = *(u64 *)(r2 + 0);"
+        "exit;"
+        :: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+static __used __naked unsigned long write_tail_call(void)
+{
+        asm volatile (
+        "r6 = r2;"
+        "r2 = %[map_array] ll;"
+        "r3 = 0;"
+        "call %[bpf_tail_call];"
+        "*(u64 *)(r6 + 0) = -16;"
+        "r0 = 0;"
+        "exit;"
+	:
+	: __imm(bpf_tail_call),
+          __imm_addr(map_array)
+        : __clobber_all);
+}
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index ac3e418c2a96..de5ef3152567 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -793,4 +793,51 @@ __naked int stack_slot_aliases_precision(void)
 	);
 }
 
+struct {
+        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+        __uint(max_entries, 1);
+        __type(key, __u32);
+        __type(value, __u32);
+} map_array SEC(".maps");
+
+__naked __noinline __used
+static unsigned long identity_tail_call(void)
+{
+	/* the simplest identity function involving a tail call */
+        asm volatile (
+		"r6 = r2;"
+		"r2 = %[map_array] ll;"
+		"r3 = 0;"
+		"call %[bpf_tail_call];"
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm(bpf_tail_call),
+		  __imm_addr(map_array)
+		: __clobber_all);
+}
+
+SEC("?raw_tp")
+__failure __log_level(2)
+__msg("6: (0f) r1 += r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
+__msg("mark_precise: frame0: parent state regs=r0 stack=:  R0=Pscalar() R6=map_value(map=.data.vals,ks=4,vs=16) R10=fp0")
+__msg("math between map_value pointer and register with unbounded min value is not allowed")
+__naked int subprog_result_tail_call(void)
+{
+	asm volatile (
+		"r2 = 3;"
+		"call identity_tail_call;"
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common
+	);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


