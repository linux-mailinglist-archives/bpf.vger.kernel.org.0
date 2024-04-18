Return-Path: <bpf+bounces-27150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F299C8AA032
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8052D1F23094
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4023174EC5;
	Thu, 18 Apr 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezqSe059"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DA17108F
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458117; cv=none; b=NADAQiQmHdvkurOBek6fHGPpwAwP7WMLidQ5rKPLUokDc9s+HVT6MlADkvZjyw5aCCfPsqVWyWcM/Zh93bQhUswNN+NO/twmIPOW69YHcLrjGlU9RGuTut27i46xFhlTVEXxXe00dRzoZGjL0hGJufDqdAWtfzyD/FKn2BH1OpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458117; c=relaxed/simple;
	bh=y1t/beTI9nc6z/yEvptNoAHKaz3hYUX2fmRYnplM8Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nW2UpzgnIFxuiC8SHHI3TeTTkMh/kWqOeAJG0AjdsDW0vehwf9cHLkAUR8MjZWS/xgBvK56e27su8BudI8crxdAdBC8zDuNVaoEYYp1jr/YN7kLtgreDF8bU6N6TgEO7FSOJFVX7Pk+sEe4/omdbEvGdzbXCqwEIJ6/kFajG0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezqSe059; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb55942409so509251a34.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713458115; x=1714062915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K6bypWbsyWY0taJNvZ0WSjYUDnqITNJfk3zzp7+6yM=;
        b=ezqSe059GIrxB9sl74bHdHSt3uflKN7BRIBlSoLEzIUyDk8YqXdTAYuXh9Fe0SnWbW
         2YnxnWVVZ/MxloFMJGxFPdqFxS6BIVxaMjE20x5YP9IJuTa3YVu/LRBEEeVJI+mOySnr
         m1WrlZGO82mImshuzivpPOgVwgOOAki1r92UMIkvAs3HW+5PMIdL9g0Z4RyF5VkCVL8B
         Ldkj5cQjkZzrNBG22kMM0p4L2hIHQ1uet8j3WCp2IH9c3UuRDTzjg7Bx+n9BoAomOYaJ
         4BvS83RBej2qxfJ1gbCFPYeEJCKT/6ULWwAej/X7HMogPDnc4YaEe8Jtss8D9yDWoXyH
         +tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713458115; x=1714062915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K6bypWbsyWY0taJNvZ0WSjYUDnqITNJfk3zzp7+6yM=;
        b=qv7mY2B1bkLEY92NUQSjQgy4NmaXlyXfaq1gIri2KY26v9yVjRIjAMcRBb0mp3gABi
         JEjTRYCEvmLihd8Z2OkiVx3zLz/oP1u4Ic1rp8VUsvv7eZSSo4ANfKIJGh9UkjQ/e7iP
         AKdpTzU1T+OpCOpaB2y916Xi+7gJAZqBiliYCeClrbGzRTbE8+dJTL72VcQbMXBn6eCB
         DfmRJTrQzOf6A2Vb5/xR9i+A6k7U3wli8suWICJdTB9nwel//X1NM7SPlU2YJtVqRGsa
         Uo7a5V47wLpXJCh1K16heqDWeHCS3aLl9UfnF4OqvbpUEAJCcgAnwL2G/MO+BvrEn332
         XJdg==
X-Gm-Message-State: AOJu0Yz0XJV4wgc8f4oDNeCitDvY2zWHb+oz11BoKL7lxm/wxivD3IiL
	J1gWG17jwD0nNBFNkm1Anm0tbbvyTecj9aZCga4yep/X+B3ZNNDe8yvDCA==
X-Google-Smtp-Source: AGHT+IG4sA+tSzXhzH6920XbdlyJFBdiEHib5aMbWXvprJfXzEBUzzbMoOU1NPsvyCH78EYuZM3r7w==
X-Received: by 2002:a05:6830:59:b0:6ea:20b5:f3cc with SMTP id d25-20020a056830005900b006ea20b5f3ccmr3553878otp.32.1713458114668;
        Thu, 18 Apr 2024 09:35:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6fe6:94b6:ddee:aa05])
        by smtp.gmail.com with ESMTPSA id i5-20020a9d53c5000000b006e695048ad8sm376391oth.66.2024.04.18.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:35:14 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: open a pinned path of a struct_ops link.
Date: Thu, 18 Apr 2024 09:35:09 -0700
Message-Id: <20240418163509.719335-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418163509.719335-1-thinker.li@gmail.com>
References: <20240418163509.719335-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that a pinned path of a struct_ops link can be opened to obtain a
file descriptor, which applications can then utilize to update the link.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  6 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 56 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 39ad96a18123..c4acd4ec630c 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -579,6 +579,11 @@ static void bpf_dummy_unreg(void *kdata)
 {
 }
 
+static int bpf_dummy_update(void *kdata, void *old_kdata)
+{
+	return bpf_dummy_reg(kdata);
+}
+
 static int bpf_testmod_test_1(void)
 {
 	return 0;
@@ -606,6 +611,7 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.init_member = bpf_testmod_ops_init_member,
 	.reg = bpf_dummy_reg,
 	.unreg = bpf_dummy_unreg,
+	.update = bpf_dummy_update,
 	.cfi_stubs = &__bpf_testmod_ops,
 	.name = "bpf_testmod_ops",
 	.owner = THIS_MODULE,
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 7cf2b9ddd3e1..47b965c4c3e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -160,6 +160,60 @@ static void test_struct_ops_incompatible(void)
 	struct_ops_module__destroy(skel);
 }
 
+/* Applications should be able to open a pinned path of a struct_ops link
+ * to get a file descriptor of the link and to update the link through the
+ * file descriptor.
+ */
+static void test_struct_ops_pinning_and_open(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_update_opts, opts);
+	struct struct_ops_module *skel;
+	int err, link_fd = -1, map_fd;
+	struct bpf_link *link;
+
+	/* Create and pin a struct_ops link */
+	skel = struct_ops_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	err = bpf_link__pin(link, "/sys/fs/bpf/test_struct_ops_pinning");
+	if (!ASSERT_OK(err, "bpf_link__pin"))
+		goto cleanup;
+
+	/* Open the pinned path */
+	link_fd = open("/sys/fs/bpf/test_struct_ops_pinning", O_RDONLY);
+	bpf_link__unpin(link);
+	if (!ASSERT_GE(link_fd, 0, "open_pinned"))
+		goto cleanup;
+
+	skel->bss->test_1_result = 0;
+	skel->bss->test_2_result = 0;
+
+	map_fd = bpf_map__fd(skel->maps.testmod_1);
+	if (!ASSERT_GE(map_fd, 0, "map_fd"))
+		goto cleanup;
+
+	/* Update the link. test_1 and test_2 should be called again. */
+	err = bpf_link_update(link_fd, map_fd, &opts);
+	if (!ASSERT_OK(err, "bpf_link_update"))
+		goto cleanup;
+
+	/* Check if test_1 and test_2 have been called */
+	ASSERT_EQ(skel->bss->test_1_result, 0xdeadbeef,
+		  "bpf_link_update_test_1_result");
+	ASSERT_EQ(skel->bss->test_2_result, 5,
+		  "bpf_link_update_test_2_result");
+
+cleanup:
+	close(link_fd);
+	bpf_link__destroy(link);
+	struct_ops_module__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
@@ -168,5 +222,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_not_zeroed();
 	if (test__start_subtest("test_struct_ops_incompatible"))
 		test_struct_ops_incompatible();
+	if (test__start_subtest("test_struct_ops_pinning_and_open"))
+		test_struct_ops_pinning_and_open();
 }
 
-- 
2.34.1


