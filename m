Return-Path: <bpf+bounces-75086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDBDC6FEC8
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5504D296FE
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864B327BF4;
	Wed, 19 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="GwYB3TeP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC682BD5B4
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568250; cv=none; b=SSG8cmbUpTQhJrlq8ZezBpwSJEdEYfMG+iMlCgMVy9zdUwIYSdtXK8dsHFExTMUtRPrpUROQTCGcv3pJ+Hp5yeQmcSKk9i994C6CAtzYTR+uveTYP11GIPonKn8Kwvp3mPwxq0ue/cARqltGG2xSEx6dmgg1OXjIKfOjwHqlYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568250; c=relaxed/simple;
	bh=GWeBz6TJ1v/24gYA0zHfBPnnQwbo+TPzQx0lLndT89o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBNzCs2T95koQGvuImRGm7Oz/1ua3iPKbk2X6MWZD1iqHPzepExW2n46u7WcL4c3BJrMIc3azAcEzQJJnJlsIqdZPtFiUXOiAh0dYR74h4rvUlBd9UARsPg4xgLuuUsdPb8m+DV+Cj0GtGLq/ZphEUixg+IXn8pkdqRd4Ahou9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=GwYB3TeP; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 6E8D211F752
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 17:04:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 6E8D211F752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763568241; bh=01YdGcmleXlPCX8EF2Ac0bGpMP+BVLDHCQA4vetRxkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwYB3TePRtdRDxY3uZlwDzYJpDeABbGcgSOAnMJK/oh/hJBVJU2iJDkMhR2/wvPec
	 0eTXfBicVCPAxYjaGyGUGYLrPOA7/5bqtx6aP1DEuj60JssLbTpXu+3YzboPga7a5u
	 vmgZNoy2JL8BEgOQuV7TY6fkdFl8J7d1iRb+YiLc=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 60E48120043;
	Wed, 19 Nov 2025 17:04:01 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 53B4F40044;
	Wed, 19 Nov 2025 17:04:01 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id C551C100034;
	Wed, 19 Nov 2025 17:04:00 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id AE5A520044;
	Wed, 19 Nov 2025 17:04:00 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id AAA1B201AE; Wed, 19 Nov 2025 17:04:00 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v6 bpf-next 2/4] bpf: test the proper verification of tail calls
Date: Wed, 19 Nov 2025 17:03:53 +0100
Message-ID: <20251119160355.1160932-3-martin.teichmann@xfel.eu>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 39 +++++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 53 +++++++++++++++++++
 2 files changed, 90 insertions(+), 2 deletions(-)

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
index ac3e418c2a96..61886ed554de 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -793,4 +793,57 @@ __naked int stack_slot_aliases_precision(void)
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
+__msg("13: (85) call bpf_tail_call#12")
+__msg("mark_precise: frame1: last_idx 13 first_idx 0 subseq_idx -1 ")
+__msg("returning from callee:")
+__msg("frame1: R0=scalar() R6=3 R10=fp0")
+__msg("to caller at 4:")
+__msg("R0=scalar() R6=map_value(map=.data.vals,ks=4,vs=16) R10=fp0")
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


