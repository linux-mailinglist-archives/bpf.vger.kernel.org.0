Return-Path: <bpf+bounces-41237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E7994520
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 12:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5D11C2399D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F61B81CC;
	Tue,  8 Oct 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZoPcBQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025B19067C;
	Tue,  8 Oct 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382482; cv=none; b=dqDkOXGL/Rbi9XqltmnIbbXkgcW1pUZSg8o7krsi/8ctl+ePAWyUg5+eJyZMWWWug6rxozm2kWlSygjPfocFdpPfZm/nVvpc4zpus1VpKydoVYO5f3gutJWC/+74HHRhckVUItZ+d0Oyt5cZ+vET9dpNd0s47ljqYpmyB77ILd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382482; c=relaxed/simple;
	bh=TUqU4rRtqBHAmFV5UzRNB/U1p3wPjrjfJRAziwSvtxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ev61Kf/PLUrVe7a0ZALdpx8PXRiWxy71O7IZEBbX/HTv3jTRbLaRbu+TAP3AAS83H1snncVq35tqKF8p/S3M2UmBdUXor213h9I5vJs24hGMpnZi0LB0NPKWVBIhyxzUxHtNcN9nAgNGahaz5Rq76cWW/0RsY4bgW/Logq6dsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZoPcBQZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so48670835e9.0;
        Tue, 08 Oct 2024 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728382479; x=1728987279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imn45k5J9wM19h9i9/RuyLoAF2diDSxFA12TsgI6H5w=;
        b=MZoPcBQZoPDRcIbxRIVYiX+IiSHzxWXtgA3tX5JJMMpA/Z5xtVLfHF0Of3tHvSmYcf
         UVR/YxXTAl/u30vn0VHizdIM6ul+/DTMYKahj0NgrFpWlztZFnSMdfp3rtgHTzgOKcab
         e08h+5RXZZz8iH+q94YFoiB8WVx16IVR8Q+r4hTWAEnQ3PbSBzZXICATQQiBWCVgj2iJ
         FwDw/SygXQ3+Ddac7laW7iNu1BMh0MRm51VEy9pCKl5aKyA8SrTVsBST21W3WqMtKwii
         RAqQwolwGHEUO1gVsNFJ2qK0O15MPbcrAp8XyNBc4+Rs3S+j4jIpMNs2QXR/lD1vzPnZ
         R0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728382479; x=1728987279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Imn45k5J9wM19h9i9/RuyLoAF2diDSxFA12TsgI6H5w=;
        b=gWtdnCpfCEZx4kYtuvWH1c99gmYLndyLbbBr2cgPllmulaGtV5YuFvTexNVq9XU/XE
         R10cUV1nPamgJoAg7e1BDwpU4CsPoDZAMWf+teM2SWs70A4LQgaegzzb2TAFSJJy9xzx
         2inoPQ6Wm/ynHNPXOmsb6v59deMN8vWw18KoHnGTJXgDA+bGm2/McK3nC6if1v3cXRkQ
         Fe/dMaK0lqxBZOtdQr/s/w4w1lKK7XC6MHPTDrBV80jsJBU/PMWuH8yJbCWu80WSJTVK
         JRwwpZ9tF1+nxQdQlyvlb/OfpJtWk49I6+LoKgatnlyMcWe+wYqVsPL8ucOXx60BQaYO
         ZQpA==
X-Forwarded-Encrypted: i=1; AJvYcCVLZ+GIrw41hYp2r9kha+BTVjRjtVVmwrMENP7Nh0ivytQqxLw5zc8mhHKyl9yUEbDypROX/TP6cs+tSNsO@vger.kernel.org, AJvYcCWIXj4w4SUXgBEnqHYP30RhdDcjupbJOw3uR1ESMUo3nrYqCqENqC6XZp4ZHuucJigmbtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwr4wS+UbLXHaFaKwABZn7+sWubbxQ9NNAOsPJhq25S7DsLQgB
	XmiRtUAIXD2ZpO7raezoDMtBDv4vau4lD5LFEkJvd7rBRgAPcP8i
X-Google-Smtp-Source: AGHT+IFUHFdsSTKRxb8639sVgXceTyFTrRE4SGLmq/ZsJV2CO1ZElzEx8lFPPP5n/dq949hi8/BBKA==
X-Received: by 2002:a05:600c:4f14:b0:42b:a88f:f872 with SMTP id 5b1f17b1804b1-42f85af5387mr96155965e9.32.1728382479035;
        Tue, 08 Oct 2024 03:14:39 -0700 (PDT)
Received: from work.. ([94.200.20.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e89624sm103790585e9.12.2024.10.08.03.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:14:38 -0700 (PDT)
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
Subject: [PATCH v3] mm, kasan, kmsan: copy_from/to_kernel_nofault
Date: Tue,  8 Oct 2024 15:15:26 +0500
Message-Id: <20241008101526.2591147-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACzwLxh1yWXQZ4LAO3gFMjK8KPDFfNOR6wqWhtXyucJ0+YXurw@mail.gmail.com>
References: <CACzwLxh1yWXQZ4LAO3gFMjK8KPDFfNOR6wqWhtXyucJ0+YXurw@mail.gmail.com>
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


