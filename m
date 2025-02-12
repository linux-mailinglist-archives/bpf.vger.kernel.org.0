Return-Path: <bpf+bounces-51253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA68A327A1
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841F31889847
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13C20E6F6;
	Wed, 12 Feb 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TADpJbOK"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BD520E6F2
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368437; cv=none; b=iEOkxfrWzOFPzXgMENjgY1VQKIvCVW2lAE3RvysbUhF5wjtKDlyHSQteQY59RjR5InA10mt0jjJ62RodBfaCoGB8+om1E2fmJpOj+cBXJlBspUBjJjxX0F6Isn8a+36AaenLPbDzJE1QoKulBixLXjMUHaR46eFodNBDEzaSey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368437; c=relaxed/simple;
	bh=rYMDTx81ClVZh4KVVOcev4D4s8V8RRxkauyC9ofF8u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoETVJsjV0aqLMO8is8L6ViM7ZHyXF/S5ulkfdx6urhTGGC62DXnngxlYNJheComx5PPwKiZiGy8YCMG3tPyKPGjcN8FZe3VB2aOWwR0mGrm+l3jIMiwcLgu2sC3LLIptpioVWTlUha4e2f+NMAW2/+h0ddrc4C4LiFiooiAkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TADpJbOK; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=pnFk5
	rBF9Pjf2pE6kKC+wFv07jJsIPsZWYieX5n47fU=; b=TADpJbOK6U/iDWJri4sH4
	uDJaKa9l/amXI1S+9XV8zlc8yuvKOMYciIrurt70p01en5EuY6W4w8u5qRqrsGBi
	cckX5v945Zw+svNlCfKaojFntyBoTrLPZtCvBkNRpGAOXqHdcp4/TttH2M8ioshT
	/eJX2SIBng1c7fMPXT+yrg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD37x+9p6xn5UW6Lg--.513S4;
	Wed, 12 Feb 2025 21:53:11 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v1 2/2] bpf/selftest: add selftest for may_goto
Date: Wed, 12 Feb 2025 21:52:51 +0800
Message-ID: <20250212135251.85487-3-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212135251.85487-1-mrpre@163.com>
References: <20250212135251.85487-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD37x+9p6xn5UW6Lg--.513S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF13Kr13GrW3CF1xJFyfCrg_yoW8Xw4Dp3
	4kWasxu3WkJw1Iga4xAFyDWFyrJa1kXr45CrWftr1FyF4Dtr92grWIkFyDJrWYyrZ3Zw43
	ZFWIy39xGw48J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVbytUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxfxp2esn1lwawAAsM

Add test case to ensure normal operation when may_goto exists and the
stack size has already reached 512.

./test_progs -t verifier_stack_ptr
...
verifier_stack_ptr/PTR_TO_STACK max stack size > 512:OK
verifier_stack_ptr/PTR_TO_STACK max stack size 512 with may_goto:OK
...

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 417c61cd4b19..b2e84714e1bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -481,4 +481,37 @@ l1_%=:	r0 = 42;					\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("PTR_TO_STACK max stack size > 512")
+__failure __msg("invalid write to stack R1 off=-520 size=8")
+__naked void stack_check_size_gt_512(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -520;"
+	"r0 = 42;"
+	"*(u64*)(r1 + 0) = r0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_MAY_GOTO
+SEC("socket")
+__description("PTR_TO_STACK max stack size 512 with may_goto")
+__success
+__retval(42)
+__naked void stack_check_size_512_with_may_goto(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -512;"
+	"r0 = 42;"
+	"*(u32*)(r1 + 0) = r0;"
+	"may_goto end;"
+	"r2 = 100;"
+"end:	exit;"
+	::: __clobber_all);
+}
+#endif
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


