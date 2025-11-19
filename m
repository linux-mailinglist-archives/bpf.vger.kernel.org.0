Return-Path: <bpf+bounces-75087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91138C6FED1
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 1509029363
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41002E5B09;
	Wed, 19 Nov 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="20cONReL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B2261B9A
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568250; cv=none; b=XLntEr8Du8qaNFeAMD+9Jgu2AmHBKUuCGSAAgp6ljHeYZYKesbBBOuDHb5rxPK8hGsBaVGOL0gqCc4pE17NVGiDZ+fqrabsa/Wr+fiTMR2C4Nsqad1ihMqmXPEKZiwkcRHRc2W1Phms9QJqu0n86lysuOLheQh2mgj+EfNheNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568250; c=relaxed/simple;
	bh=l2mSRC284W2cN4M+Eu659LwgoQnQU69a/3/wXDK4y38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpCARN054iftq4KtkdH+hLxMfXBg2AIqyW4wrmluu1SIZUfvVwwhJ31FVUq/sAY42AqpYWoNbl06DqHC3vYQz7UWAG+jS0CCOINX14wz/9Q67rxnVbsDxizemepKgQ5AQo9QFnp4gc/1kkRBDs4F9qoKWwzBiqq+vTYnoO49AMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=20cONReL; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 685FE13F655
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 17:04:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 685FE13F655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763568246; bh=Rk30RL8hww40hEHD2u7r+FaPMJutyW0a25spn/WQmBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=20cONReLDv3T6ROzzd7QPsduQ11g8XmCe+biMoflOgOsjfVvCVkTDFy5zl62m1ZO8
	 eIE4ajVFZJQZdpIL5A8AIftneTzsUg3J9pQR0RpwnTasO9lGG9I6poN+FwC5dSaKCn
	 9JVC5f/lL8jp4ncb8cFX+QxyUfY5/qT8u7TIpbtc=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 5D02F120043;
	Wed, 19 Nov 2025 17:04:06 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 50BF316003F;
	Wed, 19 Nov 2025 17:04:06 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 88B493200B3;
	Wed, 19 Nov 2025 17:04:05 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 79BB080046;
	Wed, 19 Nov 2025 17:04:05 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 75C0A201AE; Wed, 19 Nov 2025 17:04:05 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v6 bpf-next 4/4] bpf: test the correct stack liveness of tail calls
Date: Wed, 19 Nov 2025 17:03:55 +0100
Message-ID: <20251119160355.1160932-5-martin.teichmann@xfel.eu>
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

From: Eduard Zingerman <eddyz87@gmail.com>

A new test is added: caller_stack_write_tail_call tests that the live
stack is correctly tracked for a tail call.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
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


