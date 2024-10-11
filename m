Return-Path: <bpf+bounces-41704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD72C999B57
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 05:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4DD1C21731
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6461F4FC4;
	Fri, 11 Oct 2024 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSkwKNf/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C367E782;
	Fri, 11 Oct 2024 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618738; cv=none; b=j++FCKYouaI+Tm4IveBPLkLLQJhJEuHYLxs3I8ksH/8CMCZlUsxepjx/U5cmjjb+FGvUwgP4KL5U3GyY/N2oFz/84Kxkrd2ZD7LcX3HMScTl9HFMh0C1qEpAbygcaTrIrIg+gQo20abW9dLq7+ImnAnuVg7tiigzQThKn/k0qSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618738; c=relaxed/simple;
	bh=ruQpuYSaf+eaZ5jhbvk3a5VjGkI+q+JIi0BpRfUCd40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIEsLN63uLuowKbkH+fz911W2pVu9n9rWl4FcHwob9NFVE2lhQt7n5vPIU5y9clf0wwMuXKpdHHJBVFAGhsoOrPSXY3Yo5rbnaj2uDQDLx/9LnXEdixf9mDAjFexbK6OQV4thaDwp0XXOPK57CqTqEwddWBlzR0B3ZE9C4/ZGhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSkwKNf/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so25307961fa.1;
        Thu, 10 Oct 2024 20:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728618734; x=1729223534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0fnDdAXdFFiAdPLRHXqXwWbKuYcXlWeTLq43KdMa6k=;
        b=mSkwKNf/ZFesRf0eagrwzrKIBNS603NUKqFKjxFJSRlwB2frEJiDo6fjIwRKlh1CI6
         nKQWJblBpEJNKFMRP4pFSqM2soANFVoVOgyoQWZrHKWNm+qUSNXJZZruAjWuJwHaT+w5
         QuYTtlkqTlTn7AyfkCelCShoBBDDf7dKsH/8Y6Y1AhAgbSWOEqfjA3aORu1jvjGsNGsk
         LzcBY8O/WgtddglqXrnPAdsYkwCB7w5Ak5obAIcaGVl4BlpltOh18Y2/wGh1ogRD2oZ2
         boFHIIogPBvYVC83zyqejTrQpFVmqpVPnGNZ9vLQMpq7n8MAaamPekuKi1XdrDGpF/Xe
         Sk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728618734; x=1729223534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0fnDdAXdFFiAdPLRHXqXwWbKuYcXlWeTLq43KdMa6k=;
        b=orimnV23lfKTYsVMHl3ZhtQajuJoR5RaRXj244PhXj0Jx505nb22fdLNvywG9AZGfk
         KcuStbrdQsSHckSYP5uBX9OSpTsIOhxsZGQEymh1Y6n8p2BF3pi/QZ1b/BwwuDvuyFZJ
         h9yh5j+zO51O1dZLHOf3G8MUE6CKjQQHLWBdi8hMWy1Xg9jEdRGJC6pAGuITrQdS4Fvv
         oGpifMURqT85B9e2EzRKTtVmKklKmt/uit2FZJQLvFIasecZEhbuPvjCMB2uWiDXiR8a
         Z7o45G9+KI7OgwlD44iV0Ij+kauwWjDvmPEn3Jc+wN3Y3+Oq1PuWS4woeDv4W91dAz0Z
         SbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYdfTDSzzOvR/+Nz6VP4kyR9ltB0yfBxMIDjSM8+itGmRxDJdoe4nWLGXjMS/GQlQA7H8=@vger.kernel.org, AJvYcCWas3+ieXNZnOvMRkugru8yqOEAlj6+sDKJ5lYZvWPmvYkWCYeUD+XnPUH+HNcsdE6coLD0l1lMRZNU/Jf7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GVR9lsHNXW9DClqCaJZtCpvTC4jCB15vtF4uyn1b7pbyJIW2
	kaNPyKrMqhCSPsLGSD8NyLJ0UNrEi95AXbA3KhwKfc5qImOppM4K
X-Google-Smtp-Source: AGHT+IG2r9G8kehETMTOGptVXRccibX8e8/dju6uDVYVxfbmv/ZQsTG+3vVhfke6Bb1PYxuY3HOZUQ==
X-Received: by 2002:a05:6512:3a91:b0:539:9135:698c with SMTP id 2adb3069b0e04-539c9881bc8mr1605719e87.16.1728618733895;
        Thu, 10 Oct 2024 20:52:13 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539df2fe2d5sm36383e87.61.2024.10.10.20.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:52:13 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org,
	bpf@vger.kernel.org,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com,
	vincenzo.frascino@arm.com
Subject: [PATCH v6] mm, kasan, kmsan: copy_from/to_kernel_nofault
Date: Fri, 11 Oct 2024 08:53:10 +0500
Message-Id: <20241011035310.2982017-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZfs6bwdxkKPWWdNCjFH6H6hs0pFjaic12=HgB4b=Vv-xw@mail.gmail.com>
References: <CA+fCnZfs6bwdxkKPWWdNCjFH6H6hs0pFjaic12=HgB4b=Vv-xw@mail.gmail.com>
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
instrument_write() explicitly for the memory corruption instrumentation.

copy_to_kernel_nofault() is tested on x86_64 and arm64 with
CONFIG_KASAN_SW_TAGS. On arm64 with CONFIG_KASAN_HW_TAGS,
kunit test currently fails. Need more clarification on it.

Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
Reviewed-by: Marco Elver <elver@google.com>
Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
v2:
- squashed previous submitted in -mm tree 2 patches based on Linus tree
v3:
- moved checks to *_nofault_loop macros per Marco's comments
- edited the commit message
v4:
- replaced Suggested-by with Reviewed-by
v5:
- addressed Andrey's comment on deleting CONFIG_KASAN_HW_TAGS check in
  mm/kasan/kasan_test_c.c
- added explanatory comment in kasan_test_c.c
- added Suggested-by: Marco Elver back per Andrew's comment.
v6:
- deleted checks KASAN_TAG_MIN, KASAN_TAG_KERNEL per Andrey's comment.
- added empty line before kfree.
---
 mm/kasan/kasan_test_c.c | 34 ++++++++++++++++++++++++++++++++++
 mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
 mm/maccess.c            | 10 ++++++++--
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..716f2cac9708 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1954,6 +1954,39 @@ static void rust_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
 }
 
+static void copy_to_kernel_nofault_oob(struct kunit *test)
+{
+	char *ptr;
+	char buf[128];
+	size_t size = sizeof(buf);
+
+	/* This test currently fails with the HW_TAGS mode.
+	 * The reason is unknown and needs to be investigated. */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
+
+	ptr = kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
+
+	/*
+	* We test copy_to_kernel_nofault() to detect corrupted memory that is
+	* being written into the kernel. In contrast, copy_from_kernel_nofault()
+	* is primarily used in kernel helper functions where the source address
+	* might be random or uninitialized. Applying KASAN instrumentation to
+	* copy_from_kernel_nofault() could lead to false positives.
+	* By focusing KASAN checks only on copy_to_kernel_nofault(),
+	* we ensure that only valid memory is written to the kernel,
+	* minimizing the risk of kernel corruption while avoiding
+	* false positives in the reverse case.
+	*/
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(&buf[0], ptr, size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(ptr, &buf[0], size));
+
+	kfree(ptr);
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -2027,6 +2060,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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
index 518a25667323..3ca55ec63a6a 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -13,9 +13,14 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 	return true;
 }
 
+/*
+ * The below only uses kmsan_check_memory() to ensure uninitialized kernel
+ * memory isn't leaked.
+ */
 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__get_kernel_nofault(dst, src, type, err_label);		\
+		__get_kernel_nofault(dst, src, type, err_label);	\
+		kmsan_check_memory(src, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -49,7 +54,8 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 
 #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__put_kernel_nofault(dst, src, type, err_label);		\
+		__put_kernel_nofault(dst, src, type, err_label);	\
+		instrument_write(dst, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
-- 
2.34.1


