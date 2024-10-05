Return-Path: <bpf+bounces-41059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BC99186B
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E471F228BE
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A1158A18;
	Sat,  5 Oct 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT+j8cz7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA131CF96;
	Sat,  5 Oct 2024 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146854; cv=none; b=KHV9StBw7imvj0na6EKXh0UKF64jBwHu6tQjUyZwNbLwzVmrKhjaSRyH8wEIBs8agg0xeegRUfFWqg/j/nMShmSY8ul2BV7HwEpUXuJo49BiDHgiX1+9a7v3HZaIDZ6gB6Rbnp0PuxRDrBF/2CBlmRERKoR7UPynV6nsItXD52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146854; c=relaxed/simple;
	bh=V7UMIoZwYQLXrsyOW/y0872ptmIBcpXxOWMRbWdm/1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pd+X2qsKksBcAb43KNVTmJFZtdO7NC+AUp0MBn23LBztxzZFnsCnxu5wQMZNtaHlykWu9ILg3Xp88dAHSs4X1oeucEuKDagK98OFpL2NMbAClmnpJFV5vWpp/bhikiOa5AtbVJJfMwoGDilw98F+EWPacFxM1kKdKNUrdx42V7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT+j8cz7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so27113395e9.3;
        Sat, 05 Oct 2024 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728146851; x=1728751651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6F6OyhiHlCOdmPRfgY5RV4ZY7u4wQoO0FaQWpwh0ps=;
        b=YT+j8cz7oQi4e+LnOMu0wwx/09my6L5+Upxiz9GXUB5VCC/oTEVUrfyH9xuV9Nl8i6
         xDMXQ0DZkkJueMz/vYVAgSl/X4fUYgVPv+r7WKH03s/ugUjmNmxtMWfoJsCrJgJSPwDx
         rmOlKFL7MavBX41idakjGQSOrQOdn1MXRA2xMfvnUMi6dK/4xDbcnubQJAo2ceWSnmyN
         EvNgEWAzq1Zhay1keN/WsaDrbGcvhSyviO1n8XY8m8LVc9OCEmV/fAjVHGkU5HW19Vo7
         lofBWxAwaHCAKHP8W6rawm5GfEs1VBt07ba4ar2g6vln7mC7CBeujeB31gI06GsPt3sB
         NjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146851; x=1728751651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6F6OyhiHlCOdmPRfgY5RV4ZY7u4wQoO0FaQWpwh0ps=;
        b=QuG+vj/mnGTDldVpggp+iOwMd/1LHkiK8pflXWY5FV9Jwrm3/pyQY5SgUEHfd3tpfc
         6a4rg3UzrT1ZWw8v80V8YEzXB3iTDVw939MS9EmdeUFSxGFxVIciHkvBtNmbJaBJsT0R
         5ZVgOvqsBeE8vLwc7n9SOVEEvpNJ8XfK4JlO9NOEC+APlaQ60w60V5BF/YIymvaOrbsp
         buPyAOD5Nzpi8nU+pyjTeH+BmIl5/3QWCm9rtapy+uD7+HutLq9dMyO1jTSPOcDxf2Ln
         AlA+EJJX3qaJ5z1wXyTMtd6ZZeo8Z85/7BUiW+papM3HOAyd6eApei/u8t/Z9X2aJsX+
         HUbg==
X-Forwarded-Encrypted: i=1; AJvYcCUyRzk/RRgVRUguckI+mf7QVMSzuOEqMdyRPXV1P+sSiHpaXdtiqOxdui28hchmxCRQG49sGMn10RVPPeOY@vger.kernel.org, AJvYcCWvD5oQxhh0LVsu/q+I1w57wCByMXELbMqe96OBTwiW5KflcUTR+YF7v7m6Xmt/OLZuso8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiA8ESoUIV2bicAsqdyrBdCrUvib4Mm1o7u7a1vxksmZLIlJdo
	lWHIuPlyPvEb5C3HcM1vWup+Sp/ZUA84WZnFEnkqUKXTTikZ1Tzv
X-Google-Smtp-Source: AGHT+IGRMhdyR88SHH/XDkMpaLLrsydDkJXOsVYXtgoQI2RKA50PHZ8fgkrTQjY0KvtWK5o2wiVCdA==
X-Received: by 2002:a05:600c:1f82:b0:42c:b750:19f3 with SMTP id 5b1f17b1804b1-42f859be4cdmr52608925e9.0.1728146850889;
        Sat, 05 Oct 2024 09:47:30 -0700 (PDT)
Received: from work.. ([94.200.20.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec71aesm26481515e9.33.2024.10.05.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 09:47:30 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: elver@google.com,
	akpm@linux-foundation.org
Cc: andreyknvl@gmail.com,
	bpf@vger.kernel.org,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com,
	vincenzo.frascino@arm.com
Subject: [PATCH v2 1/1] mm, kasan, kmsan: copy_from/to_kernel_nofault
Date: Sat,  5 Oct 2024 21:48:13 +0500
Message-Id: <20241005164813.2475778-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241005164813.2475778-1-snovitoll@gmail.com>
References: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
 <20241005164813.2475778-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kernel
memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
the memory corruption.

syzbot reported that bpf_probe_read_kernel() kernel helper triggered
KASAN report via kasan_check_range() which is not the expected behaviour
as copy_from_kernel_nofault() is meant to be a non-faulting helper.

Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
copy_from_kernel_nofault() with KMSAN detection of copying uninitilaized
kernel memory. In copy_to_kernel_nofault() we can retain
instrument_write() for the memory corruption instrumentation but before
pagefault_disable().

copy_to_kernel_nofault() is tested on x86_64 and arm64 with
CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
kunit test currently fails. Need more clarification on it
- currently, disabled in kunit test.

Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
Suggested-by: Marco Elver <elver@google.com>
Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
v2:
	- squashed previous submitted in -mm tree 2 patches based on Linus tree
---
 mm/kasan/kasan_test_c.c | 27 +++++++++++++++++++++++++++
 mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
 mm/maccess.c            |  7 +++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..5cff90f831db 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1954,6 +1954,32 @@ static void rust_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
 }
 
+static void copy_to_kernel_nofault_oob(struct kunit *test)
+{
+	char *ptr;
+	char buf[128];
+	size_t size = sizeof(buf);
+
+	/* Not detecting fails currently with HW_TAGS */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
+
+	ptr = kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
+
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
+		/* Check that the returned pointer is tagged. */
+		KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
+		KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+	}
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(&buf[0], ptr, size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(ptr, &buf[0], size));
+	kfree(ptr);
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -2027,6 +2053,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(copy_to_kernel_nofault_oob),
 	KUNIT_CASE(rust_uaf),
 	{}
 };
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 13236d579eba..9733a22c46c1 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -640,6 +640,22 @@ static void test_unpoison_memory(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+static void test_copy_from_kernel_nofault(struct kunit *test)
+{
+	long ret;
+	char buf[4], src[4];
+	size_t size = sizeof(buf);
+
+	EXPECTATION_UNINIT_VALUE_FN(expect, "copy_from_kernel_nofault");
+	kunit_info(
+		test,
+		"testing copy_from_kernel_nofault with uninitialized memory\n");
+
+	ret = copy_from_kernel_nofault((char *)&buf[0], (char *)&src[0], size);
+	USE(ret);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
 static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_uninit_kmalloc),
 	KUNIT_CASE(test_init_kmalloc),
@@ -664,6 +680,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_long_origin_chain),
 	KUNIT_CASE(test_stackdepot_roundtrip),
 	KUNIT_CASE(test_unpoison_memory),
+	KUNIT_CASE(test_copy_from_kernel_nofault),
 	{},
 };
 
diff --git a/mm/maccess.c b/mm/maccess.c
index 518a25667323..a91a39a56cfd 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 
 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__get_kernel_nofault(dst, src, type, err_label);		\
+		__get_kernel_nofault(dst, src, type, err_label);	\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -31,6 +31,8 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
+	/* Make sure uninitialized kernel memory isn't copied. */
+	kmsan_check_memory(src, size);
 	pagefault_disable();
 	if (!(align & 7))
 		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
@@ -49,7 +51,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 
 #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__put_kernel_nofault(dst, src, type, err_label);		\
+		__put_kernel_nofault(dst, src, type, err_label);	\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -62,6 +64,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
+	instrument_write(dst, size);
 	pagefault_disable();
 	if (!(align & 7))
 		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
-- 
2.34.1


