Return-Path: <bpf+bounces-41046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F7B991580
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D6E1C21AE1
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608F13DBA0;
	Sat,  5 Oct 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPFP9dQQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8867A0D;
	Sat,  5 Oct 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728120150; cv=none; b=huf4cRqAC/KOu2y71RTd2OFPVH8lMCFQdgyiHW1jSi1rszrown6R6SAAVlr4+ipEJyM/Kcbkoh7lx/WXNDeUWM39wiaEWFmaj104GDbbzhaDth3HKN7awqBEtqRM0uSy1Nq8bzckeuS90fsaW237mnZWv6dt2DhmbFr3BfCu1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728120150; c=relaxed/simple;
	bh=jn1GvEcJ0XpcY7yaZTCuQAQtmtrGEbuMvygRi5wFqHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HCZtl7BHXXZuXr+p8LSkhzn/LLPuzGRZveyi8egqZeYXXIwezMm194Uri7WA60BRdKTvv91qazkntpcQoYEkvSWyzSUOXGXfkaS+++LHuyjX0BoQwVp9jKffX2sk4IDp5d2vMBB8aU5uEKqizt2rFXiTPHo/UMC4wT0JfFDI+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPFP9dQQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccc600466so1513765f8f.1;
        Sat, 05 Oct 2024 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728120147; x=1728724947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBNL0qdzrJKc0pu8ZbalsnWWokUHQrbB6w4+rulqCSc=;
        b=IPFP9dQQ7baDk6HAOmC/bDNSwVaE/0xmM25OcUvPss9cTJ4P9r8v2u4ZAvex9o3qdW
         CuuUT0jN1gPOBImQCOfqTk0GG4V5M4eKZzlt+9V92k/dE4U3QxX7MiBOkU+nN0Li+xlp
         YJYZkgtGlXUgTg8xFcS2VvfBvPGRFWua2TVObm4TkBz/+tudEU0xvnHaM/qLt3akazx/
         LdxlQ4msamQq+w31uHag50LJAJ+bVcrAHZTKZS4XpbyhFPzgHamw86ltSZQra1Fmo8/w
         GfgD0f2p9M3AHMNRlhHnDSgp4nn1nEG2Rtv415oElAlFl5j6v1r8z1tmpTQjlGz4ryvt
         xwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728120147; x=1728724947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBNL0qdzrJKc0pu8ZbalsnWWokUHQrbB6w4+rulqCSc=;
        b=sQpdgZqIFu0HZMSmkaC67y4Gu885UZgfTJ/brmGbAOZeb2u8MPSZyFw6H3VUfMBQdn
         +znZ7/bF10ozGPS5bxWKdYjm8jX4hCUe4QA7JpqLJ+yf7m6Mg35Ut5qRFxhVdhFawU8l
         sT0pjvR3d9GnCu+4plmLbYXMcR24U0GwvKizpDp+D/0AeYFIxengmbg7/o0DY+qocD4h
         tfTz9QiItU4KyV3HvPs8BakTzkxBUllDSz85NF8u7eSO4DaDsYt86cs8oxKTl6BiqGoN
         VulRyux3yBhJ4aY6YNa5PyUPEx/NS4xvmkV0qhezrqF7iXHtaIsoNoh13QHA+/ZYTIAv
         hvXw==
X-Forwarded-Encrypted: i=1; AJvYcCU6R4Y9FRNE8HFht3ZO3ftgOg7UWMHSF+YhwjzBkyb2OODZlPbJiJu6fKVCjYpopBBXWgc=@vger.kernel.org, AJvYcCUbG6wmWPVxcENSZQBx8pshuLthdgpev+8ey0wBHdDJOvkvDb2PCvX7BBVg+fdkkEGMopTdgQ6LntkaD44I@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xUy5VwxqLJTq+cCBadI0zr/nmMiQeSTHeQV/VYogAqjC+bEG
	8SXL5PyMJUAiPE4EQt0MeEXOT1Xq/1bVhO74Hxab6L7MUNkHtQ+0
X-Google-Smtp-Source: AGHT+IGFE84IKUYfL+jNf5bn7gC89qtd9swu/tiPtE9ykuBwPOwBbsNB3YAVgKsK303pOyFguhL+AA==
X-Received: by 2002:a5d:43cc:0:b0:37c:d1eb:5527 with SMTP id ffacd0b85a97d-37d0e74be67mr3538265f8f.31.1728120146599;
        Sat, 05 Oct 2024 02:22:26 -0700 (PDT)
Received: from work.. ([94.200.20.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec63d9sm17725325e9.31.2024.10.05.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 02:22:26 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: elver@google.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	akpm@linux-foundation.org
Cc: vincenzo.frascino@arm.com,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
Subject: [PATCH] mm, kmsan: instrument copy_from_kernel_nofault
Date: Sat,  5 Oct 2024 14:23:16 +0500
Message-Id: <20241005092316.2471810-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported that bpf_probe_read_kernel() kernel helper triggered
KASAN report via kasan_check_range() which is not the expected behaviour
as copy_from_kernel_nofault() is meant to be a non-faulting helper.

Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
copy_from_kernel_nofault() with KMSAN detection of copying uninitilaized
kernel memory. In copy_to_kernel_nofault() we can retain
instrument_write() for the memory corruption instrumentation but before
pagefault_disable().

Added KMSAN and modified KASAN kunit tests and tested on x86_64.

This is the part of PATCH series attempting to properly address bugzilla
issue.

Link: https://lore.kernel.org/linux-mm/CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com/
Suggested-by: Marco Elver <elver@google.com>
Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/kasan/kasan_test_c.c |  8 ++------
 mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
 mm/maccess.c            |  5 +++--
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 0a226ab032d..5cff90f831d 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1954,7 +1954,7 @@ static void rust_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
 }
 
-static void copy_from_to_kernel_nofault_oob(struct kunit *test)
+static void copy_to_kernel_nofault_oob(struct kunit *test)
 {
 	char *ptr;
 	char buf[128];
@@ -1973,10 +1973,6 @@ static void copy_from_to_kernel_nofault_oob(struct kunit *test)
 		KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
 	}
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		copy_from_kernel_nofault(&buf[0], ptr, size));
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		copy_from_kernel_nofault(ptr, &buf[0], size));
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		copy_to_kernel_nofault(&buf[0], ptr, size));
 	KUNIT_EXPECT_KASAN_FAIL(test,
@@ -2057,7 +2053,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
-	KUNIT_CASE(copy_from_to_kernel_nofault_oob),
+	KUNIT_CASE(copy_to_kernel_nofault_oob),
 	KUNIT_CASE(rust_uaf),
 	{}
 };
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 13236d579eb..9733a22c46c 100644
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
index f752f0c0fa3..a91a39a56cf 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -31,8 +31,9 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
+	/* Make sure uninitialized kernel memory isn't copied. */
+	kmsan_check_memory(src, size);
 	pagefault_disable();
-	instrument_read(src, size);
 	if (!(align & 7))
 		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
 	if (!(align & 3))
@@ -63,8 +64,8 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
-	pagefault_disable();
 	instrument_write(dst, size);
+	pagefault_disable();
 	if (!(align & 7))
 		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
 	if (!(align & 3))
-- 
2.34.1


