Return-Path: <bpf+bounces-74968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8BC69A28
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CC8D3672DF
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2FF352F96;
	Tue, 18 Nov 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="utywu+Wu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E5230BE9
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473206; cv=none; b=rppRqINepU1KNnEDuxnyQC+MB+cwx90rnMqzGH3zWYJq3/s4hFsod01FPfK6wO+Oh1OIUUzCxAYKwXcE4OjQsA5H2rFVQfF0XCWGqY4Z1tdnbc20kn8zY9vAKN6Ls2/94knfsAnfBIAtur6TI61i1BEvzOVwbyhbSAjAUQ2y1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473206; c=relaxed/simple;
	bh=NS41Xio2hAgS89KLxg55zssCbcnq7Cgf8uFGseERGPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRgsSej0asagwm4l1p7i/uY/jYVktJmYeAgzmkKjAbx8f25kubJeXiMxZLH9tkTnJ+q+vGxRMNVe68azTNrNSdcDh7vx15AW6tcFjRdAPgpD0PzKf6sEI40yGRnjfLk5RwhSkgQbgCBsRgEqgjMI2CopmkPLRNdWmS3XM18fLg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=utywu+Wu; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 6719813F648
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:39:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 6719813F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763473195; bh=iv4pq12xhHafbpdqIXFvlQ0FWY0LrzepuheKHZNVCy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utywu+WuQwuWmNKXYor+cJlZ89oR6IBx3l6818dnnpffQyU6MLDm4i+ggYrrwOKw3
	 CxhVQ0sMederFsH3ugITgsgB5YzukX1DeAIhdM0pD6PIrP6ai06c6v81urotjbn4Qs
	 1l+LRDY+CigRuprCzSjxCrdm1SE0s2T69rKtrbhk=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 5A982120043;
	Tue, 18 Nov 2025 14:39:55 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 4E70340044;
	Tue, 18 Nov 2025 14:39:55 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id D9918320093;
	Tue, 18 Nov 2025 14:39:54 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id C80EE2004C;
	Tue, 18 Nov 2025 14:39:54 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id C4B45201AE; Tue, 18 Nov 2025 14:39:54 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v5 bpf-next 4/4] bpf: test the correct stack liveness of tail calls
Date: Tue, 18 Nov 2025 14:39:44 +0100
Message-ID: <20251118133944.979865-5-martin.teichmann@xfel.eu>
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

A new test is added: caller_stack_write_tail_call tests that the live
stack is correctly tracked for a tail call.
---
 .../selftests/bpf/progs/verifier_live_stack.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index c0e808509268..2de105057bbc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -292,3 +292,53 @@ __naked void syzbot_postorder_bug1(void)
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
+__flag(BPF_F_TEST_STATE_FREQ)
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
-- 
2.43.0


