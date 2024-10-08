Return-Path: <bpf+bounces-41292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B094699579B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C9D1C21067
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4148213EE8;
	Tue,  8 Oct 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I88iF8oG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE191E0DCC;
	Tue,  8 Oct 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415704; cv=none; b=kznmgG0AKlfCAzQ1KqeVp2F4GRqpq3JeUaAM2JDEisnfJCYvE8MwG53J/1YHpxZ4wwg7Zq7Gf2V07pnPcevb4jv2z7AOc8tWsZDJVSow642blrW6WFrG96a+Fo6SFX4xnS9H+fdOBJQpHEjl25eS18UElpk68F/BTxVqTuUgsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415704; c=relaxed/simple;
	bh=mah6H/whdiV6xjgfX3wDOws0rxmB0h2kpbnCzErC0Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGu1HnN/E1xDjZrbXWrwIoe5ITs5f9dvuEi+4fvb1O2iq0lc/blhp63uar5BZSBRmfg68aRIwKDqXBQJn21u9PBjqAOS7emAe0BBva56vBtZPam5NCF0QUJv4XI6MZqel7vfwIhXBi/3FYcENTPe55zz8NSxbDc1AnM405+i9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I88iF8oG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d325beee2so503371f8f.2;
        Tue, 08 Oct 2024 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728415701; x=1729020501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YU80h+e3WqJR9RRP2zzYoIrqiryuhlMCUmmaZXckb4=;
        b=I88iF8oGYyhWjqkjWJ1hXRPIu8XH5Beqyknqygqdlb/AbU/1Ogah3hCchWDtylFQTX
         YAnxoRg7fTzoEwy/QU5lOPVZja8yrWWZHZM+KGf40ulkz/g1NeLgntstfqc0lx/TO3ae
         gRM/fBI6B1vfHEpu2wSzOMDwN8sU0eTXzP3kBN7Me6YXeJYo2cTSYjisgPvPE/7wkWjW
         fvgZ98oPu28InNTCkwPbGsg5f7Z3eTSzHo5AVOwbh2AMsAiQR0RtgU5bqc0V9XZMXbwg
         KOZsuJT/mL+e2QODdQ/dpi+L+EP8F+2KH9JB269DEBOh+Aw0HSIErKBFxpAEjjpwTzJX
         FJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728415701; x=1729020501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YU80h+e3WqJR9RRP2zzYoIrqiryuhlMCUmmaZXckb4=;
        b=RH9OxR6ctXcKoHdnUOT1lrWlU4pXOZTCtroGTWl/6/cqBQhxhaxVubsAfZrVaEZIbB
         wSDi0GTA4E6VR920bi0eXOXzdXd8YxTbV1ebdmbe1kISHvy2nW/4JhfC5iwmopEPLFer
         qLSGLusDA0V8Vy7o7QbxXhCYw38iLQjUlFrLJXIO2NeEK8No+1LtELDU+KsD0VIBSBu9
         4UvIEp/JkIX8H/zi0JYVl0mO7zyEk5EuI1AonYCySkwC9tWAMnHdYBxxKxWvHB5qTZuN
         hYuGedh2cPQWYB4DT6n/MZE5cJQkhm41WyXqzYL33y3eZkRpgUzmhFvVwiVjFm9VTUXR
         zd5g==
X-Forwarded-Encrypted: i=1; AJvYcCVkIam63STtonwz5E0LXmp+VxrIPYr4QFGd1Kp6oz4Yse+WREn7V9lqP+pK/PzYirFa4toyqzfPMqfbMpgF@vger.kernel.org, AJvYcCXrbxqxv9BYgvOWadPDuLNHPsOJJ1A35FmDFpLpNlxhAKDDunnU2Hm+xspZpkOFR3nan18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsd3tvNaF0Olfl21tQNYEuCGF2PP4W98/DjFa0Sr1YpMBi5Y5
	luldxlwUo6FVzXvM4K6fFeBqUrIgdC1GM+hSPISpMdUUZdiEyK5AaQc+6aR2
X-Google-Smtp-Source: AGHT+IF+l2nCX8ohR0udWzU8vUvvwxVBA+1g+7Q7QLi0/L6ruBDHyuNFJFp5VVyOjrIYQ/Vkpg4eAw==
X-Received: by 2002:a05:6000:4590:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-37d0e6dad03mr8291114f8f.9.1728415700750;
        Tue, 08 Oct 2024 12:28:20 -0700 (PDT)
Received: from work.. ([94.200.20.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d39ea2eacsm181675f8f.15.2024.10.08.12.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 12:28:20 -0700 (PDT)
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
Subject: [PATCH v4] mm, kasan, kmsan: copy_from/to_kernel_nofault
Date: Wed,  9 Oct 2024 00:29:10 +0500
Message-Id: <20241008192910.2823726-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
References: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
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
kunit test currently fails. Need more clarification on it
- currently, disabled in kunit test.

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
- replaced Suggested-By with Reviewed-By: Marco Elver
---
 mm/kasan/kasan_test_c.c | 27 +++++++++++++++++++++++++++
 mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
 mm/maccess.c            | 10 ++++++++--
 3 files changed, 52 insertions(+), 2 deletions(-)

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


