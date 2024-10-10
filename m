Return-Path: <bpf+bounces-41567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA5998739
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4673B21695
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670F1C9B8A;
	Thu, 10 Oct 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGtN7zz1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E91BE245;
	Thu, 10 Oct 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565837; cv=none; b=qqTUEgWZAKw0qhYl+vd6yk5Tb9z65aQo8JFwD8BCIQllqK+7ueyHO10EEYtz8mh8/zDC+SkamNtJA5IWit+PVG0Xh70yS6tBTQreSAWy0eIB502il1hqUzl28VheklrL5/ex1ZgcUtewLDbpab783dHPMzZ2cJevxnyvBoOsNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565837; c=relaxed/simple;
	bh=V7rlYtEOSBJZbMLM+XCRqd3wjCVwsdK1hiCC9dC62wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5IYuOCaLuGy9Md6yoaDZwybXCvXXOS0yGsdkCsf2ug/uh2lgQR30KivD4bgbOo6WWtj+ooY5WcStjqH7JHcrAEz657qZaE+tNTt8zcYdLdnJiTqAWc0gAnc42D10c3ycO6NLLBoMbd+9N2R3SVcd6dzFbxh/KsgxMTacmpUyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGtN7zz1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so862506e87.1;
        Thu, 10 Oct 2024 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728565834; x=1729170634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuJiu2A9K3F7RxlNpRBbTBdPuLTp339ni2HcpWnX9u0=;
        b=CGtN7zz13ib0fuZsB210eonPntFEM1EQe9hK8y09i7eU37FyH9p3g4xuRkXlomU4kT
         jFB/vmzeXivJmepwdgL11vJmY5TcJLUHvCdjqX5ggma4Gkh0gcJTgpDXqVyhLVNTTrlP
         EqomtInoYGfcrvmZx2qMtAFxYvaOq+L457ECrJpAz1HlVnizzJzFFz1FKy2YgZXf7ayD
         HmZ/x4dVDKDv2aG5TMk6AduCM8ZmvBOJgRzpK7ncIvFaNXqeclibKPfvxUBf5hz+K3Uq
         Kw5/CCrSlIpfWkKHcQJr8+FsISslikk+sgYC0wOX3X/GfB6b+cby9yylh8GcaAAzvkpD
         1nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565834; x=1729170634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuJiu2A9K3F7RxlNpRBbTBdPuLTp339ni2HcpWnX9u0=;
        b=HTSgsq8JQl3Gjjz0puOWiYLtZHqIqZLlbHhG3/N8T3cmGo8Gc0tmvUhO0q4hl3j66x
         ruveIe92yQukflYunhawOuWWzQDyyA3BaIIi9fxuLphPk57DkXaTyzGk9+INiEGEkTGN
         7iWuHw4x6Y7c7Btg5Bd+R+tRktpsYb7IH/2jqlHq00qzJ4s8kplMPGPCQ+jiwIA6SPFS
         DarpO0XnbLnB8NjVkIdvvPKrGJpZt2k6k8SWn/wPlHuJhx7dCo1m4eS8BSXH9zIoVWH6
         NLpGcehL9k+pocLFgTk85HzUKlY3/Dl9LfTACRRI2JOKvTqqzO/ugBozutNu4SarQLDe
         DZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKuppuZFpjMefd6QCsP9+but1oJGJnB/TuUVlVR23AaMHNK1exiUDEHkkLq9ES5NppSVM=@vger.kernel.org, AJvYcCWKrj9wqKZsTiBPx85pZr30intrX5imO0V/mg/ybYnGV9m3i2osQOvVQH2nk/jes8OEKV5/KTdmq05AF0+C@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfuU3uA+ta5L7zcGDnUhc7mUnGl823b9FNWIU4aO3+Es4cHY9
	O6ksBgkuPrR/Xo7GXfCyzUgHjk1OebieguVc/whLbZASw/y4NcdZ
X-Google-Smtp-Source: AGHT+IHotmSx4lEVD7Vq09kHOuUrD8kLvlKE58bqQ/6ks9ovPPFH5W+V24e63oyTtG9WOJ6NWDRz/w==
X-Received: by 2002:a05:6512:3d10:b0:539:933c:51c6 with SMTP id 2adb3069b0e04-539c9895961mr1182236e87.29.1728565833803;
        Thu, 10 Oct 2024 06:10:33 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8d800esm248596e87.126.2024.10.10.06.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:10:33 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: elver@google.com
Cc: akpm@linux-foundation.org,
	andreyknvl@gmail.com,
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
Subject: [PATCH v5] mm, kasan, kmsan: copy_from/to_kernel_nofault
Date: Thu, 10 Oct 2024 18:11:30 +0500
Message-Id: <20241010131130.2903601-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANpmjNNPnEMBxF1-Lr_BACmPYxOTRa=k6Vwi=EFR=BED=G8akg@mail.gmail.com>
References: <CANpmjNNPnEMBxF1-Lr_BACmPYxOTRa=k6Vwi=EFR=BED=G8akg@mail.gmail.com>
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
Suggested-by: Marco Elver <elver@google.com>
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
---
 mm/kasan/kasan_test_c.c | 37 +++++++++++++++++++++++++++++++++++++
 mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
 mm/maccess.c            | 10 ++++++++--
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..cb6ad84641ec 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1954,6 +1954,42 @@ static void rust_uaf(struct kunit *test)
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
+	kfree(ptr);
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -2027,6 +2063,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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


