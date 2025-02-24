Return-Path: <bpf+bounces-52467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A4DA43176
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93288173EA3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176EF20D4F3;
	Mon, 24 Feb 2025 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IFKYNcmw"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CC20CCCC
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441487; cv=none; b=T1lzh1Wvb2y+Kfyv2rXMJlnIKZBzTDNcb7b5wSvCvsZhN2X64i2oPzCWDerMGxozrJ81g99alSbuHbvIBMjMq3SHFS1htzvEBLVKXE/AXSTGUeJmIU/Fby9TzgqfI6oAHo/zvhT2N9aGynoppJTppl6CS99ZqZAmSRfa5YdlKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441487; c=relaxed/simple;
	bh=GaF1LRz0dKGSicZp73OM5lOxkCCqKQwIpcyNR0H/FFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFYeM5Tz3DY/luyHM1KtCl9QkSZBxk9rbPbXSMTAtQq5NExPNpuTbqJHjf9srwEu0p+Kps4Apa/mnKA//ydNj+KUmAaql1qPrGVYD7GwIywpeq+ligSTo2REoAnN4ZfuGabln+FsyFqQzYN8RwQ53IGByOFGBroV6yPuw1OBuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFKYNcmw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740441483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQDc/iqi6YNE3UJRAwWWXXnalLr5oJV2UaPDpRWloZ0=;
	b=IFKYNcmwDJcXARD+Goih/ZFB3Y6a2SfISPk+dZyAy4xUxE1kvXzkgjyZ8jWg/Ei/QqPGPy
	cFiC+bkGFnhmwk19IH1BAxUQykmzGP5W+5IblEbLmFQYfIKNpn45HfUZWgGmV7rn/CH4kt
	SA3o1BhDDi6g2OHrbqhcOYV/rzv6UFw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test bpf_usdt_arg_size() function
Date: Mon, 24 Feb 2025 15:57:56 -0800
Message-ID: <20250224235756.2612606-2-ihor.solodrai@linux.dev>
In-Reply-To: <20250224235756.2612606-1-ihor.solodrai@linux.dev>
References: <20250224235756.2612606-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Update usdt tests to also check for correct behavior of
bpf_usdt_arg_size().

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 11 ++++++++++-
 tools/testing/selftests/bpf/progs/test_usdt.c | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 56ed1eb9b527..495d66414b57 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -45,7 +45,7 @@ static void subtest_basic_usdt(void)
 	LIBBPF_OPTS(bpf_usdt_opts, opts);
 	struct test_usdt *skel;
 	struct test_usdt__bss *bss;
-	int err;
+	int err, i;
 
 	skel = test_usdt__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -75,6 +75,7 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
 	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
 	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
+	ASSERT_EQ(bss->usdt0_arg_size, -ENOENT, "usdt0_arg_size");
 
 	/* auto-attached usdt3 gets default zero cookie value */
 	ASSERT_EQ(bss->usdt3_cookie, 0, "usdt3_cookie");
@@ -86,6 +87,9 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt3_args[0], 1, "usdt3_arg1");
 	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
 	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
+	ASSERT_EQ(bss->usdt3_arg_sizes[0], 4, "usdt3_arg1_size");
+	ASSERT_EQ(bss->usdt3_arg_sizes[1], 8, "usdt3_arg2_size");
+	ASSERT_EQ(bss->usdt3_arg_sizes[2], 8, "usdt3_arg3_size");
 
 	/* auto-attached usdt12 gets default zero cookie value */
 	ASSERT_EQ(bss->usdt12_cookie, 0, "usdt12_cookie");
@@ -104,6 +108,11 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt12_args[10], nums[idx], "usdt12_arg11");
 	ASSERT_EQ(bss->usdt12_args[11], t1.y, "usdt12_arg12");
 
+	int usdt12_expected_arg_sizes[12] = { 4, 4, 8, 8, 4, 8, 8, 8, 4, 2, 2, 1 };
+
+	for (i = 0; i < 12; i++)
+		ASSERT_EQ(bss->usdt12_arg_sizes[i], usdt12_expected_arg_sizes[i], "usdt12_arg_size");
+
 	/* trigger_func() is marked __always_inline, so USDT invocations will be
 	 * inlined in two different places, meaning that each USDT will have
 	 * at least 2 different places to be attached to. This verifies that
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
index 505aab9a5234..096488f47fbc 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -11,6 +11,7 @@ int usdt0_called;
 u64 usdt0_cookie;
 int usdt0_arg_cnt;
 int usdt0_arg_ret;
+int usdt0_arg_size;
 
 SEC("usdt")
 int usdt0(struct pt_regs *ctx)
@@ -26,6 +27,7 @@ int usdt0(struct pt_regs *ctx)
 	usdt0_arg_cnt = bpf_usdt_arg_cnt(ctx);
 	/* should return -ENOENT for any arg_num */
 	usdt0_arg_ret = bpf_usdt_arg(ctx, bpf_get_prandom_u32(), &tmp);
+	usdt0_arg_size = bpf_usdt_arg_size(ctx, bpf_get_prandom_u32());
 	return 0;
 }
 
@@ -34,6 +36,7 @@ u64 usdt3_cookie;
 int usdt3_arg_cnt;
 int usdt3_arg_rets[3];
 u64 usdt3_args[3];
+int usdt3_arg_sizes[3];
 
 SEC("usdt//proc/self/exe:test:usdt3")
 int usdt3(struct pt_regs *ctx)
@@ -50,12 +53,15 @@ int usdt3(struct pt_regs *ctx)
 
 	usdt3_arg_rets[0] = bpf_usdt_arg(ctx, 0, &tmp);
 	usdt3_args[0] = (int)tmp;
+	usdt3_arg_sizes[0] = bpf_usdt_arg_size(ctx, 0);
 
 	usdt3_arg_rets[1] = bpf_usdt_arg(ctx, 1, &tmp);
 	usdt3_args[1] = (long)tmp;
+	usdt3_arg_sizes[1] = bpf_usdt_arg_size(ctx, 1);
 
 	usdt3_arg_rets[2] = bpf_usdt_arg(ctx, 2, &tmp);
 	usdt3_args[2] = (uintptr_t)tmp;
+	usdt3_arg_sizes[2] = bpf_usdt_arg_size(ctx, 2);
 
 	return 0;
 }
@@ -64,12 +70,15 @@ int usdt12_called;
 u64 usdt12_cookie;
 int usdt12_arg_cnt;
 u64 usdt12_args[12];
+int usdt12_arg_sizes[12];
 
 SEC("usdt//proc/self/exe:test:usdt12")
 int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
 		     long a6, __u64 a7, uintptr_t a8, int a9, short a10,
 		     short a11, signed char a12)
 {
+	int i;
+
 	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 
@@ -90,6 +99,11 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
 	usdt12_args[9] = a10;
 	usdt12_args[10] = a11;
 	usdt12_args[11] = a12;
+
+	bpf_for(i, 0, 12) {
+		usdt12_arg_sizes[i] = bpf_usdt_arg_size(ctx, i);
+	}
+
 	return 0;
 }
 
-- 
2.48.1


