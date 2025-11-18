Return-Path: <bpf+bounces-74972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC65C69A93
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A77A02B863
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07653559F3;
	Tue, 18 Nov 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="zAOzhpAC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233D30E822
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473534; cv=none; b=Fm7xogv7DoS9A8WEHX7xcIvPQDhvwFRpANrs09BCR4iNwOAKJWqw5rzmo7ve+rOVsfba9WXB4Hg5D4fNY9org5/l+aYhsDEDHVaYgg1941fdSaPWHDHcuLeWdfGUC/k1LDyN5bu4IXdn77Jsgx/LaIcJYGCotzed/B4L9Ak/Y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473534; c=relaxed/simple;
	bh=vbE5K4Y746+sHwqO28XZSBD4PdqpNRk4xBnN2bP1N6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfsjhaACBceY2JWc3pboaCl8XsU0Z7mcOE0LV70dhIzGjhPlG6mXfsqQUeXrluRtaURWKoQbdxAcqREbyPUa2hgSsKdWaPOxKFgFhuAI9oV+e4Zd3SGmya2S9plHzUQGLKTqMKfMXuxM92DcPdiaSozGijSEqWJ15fXbVcWp7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=zAOzhpAC; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id C326E11F99C
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:40:01 +0100 (CET)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 1A60511F749
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:39:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 1A60511F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763473194; bh=ah4vA3D3uUt2djqAovafZOm4YSoqWrMvwdl0gIqpAA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zAOzhpACvBs0mzq6HwKn5OiFMcagc5bF8SLh5GXcZxFvAxarcGPkvedvI4fBxsgon
	 KfDyLg5Cqb+YWMAfao3CNagVakCzC+OqFN1fJBkRCFQB6v3gmmyrkpml+RwqiBEM+x
	 yrBk0RBcJHzzpsyD+jAs8wDTa05k96aMM9TO6vao=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 0D41C120043;
	Tue, 18 Nov 2025 14:39:54 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id F3F8216003F;
	Tue, 18 Nov 2025 14:39:53 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 3051E160058;
	Tue, 18 Nov 2025 14:39:53 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 23D2080046;
	Tue, 18 Nov 2025 14:39:53 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 1EF95201AE; Tue, 18 Nov 2025 14:39:53 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v5 bpf-next 2/4] bpf: test the proper verification of tail calls
Date: Tue, 18 Nov 2025 14:39:42 +0100
Message-ID: <20251118133944.979865-3-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three tests are added:

- invalidate_pkt_pointers_by_tail_call checks that one can use the
  packet pointer after a tail call. This was originally possible
  and also poses not problems, but was made impossible by 1a4607ffba35.

- invalidate_pkt_pointers_by_static_tail_call tests a corner case
  found by Eduard Zingerman during the discussion of the original fix,
  which was broken in that fix.

- subprog_result_tail_call tests that precision propagation works
  correctly across tail calls. This did not work before.

Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
---
 .../selftests/bpf/progs/verifier_sock.c       | 39 ++++++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 47 +++++++++++++++++++
 2 files changed, 84 insertions(+), 2 deletions(-)

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


