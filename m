Return-Path: <bpf+bounces-23226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B886EDD2
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D516B23C81
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D2B647;
	Sat,  2 Mar 2024 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2zzQrm3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FEB65E
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342393; cv=none; b=ZASq2JOKgzINSfFrElB7btJtHuWv8bkvi2BJL/WEaj+IKnltKBXxed5QrL5elYFSjDrlTX7oaMQYmVwNK1iGxMkH69G16ls23Cj0i8pr8piIdDkmwPM6BfteAsZ6GbeD6ba4XoLHspJoX4icXqT+1TVa4O/ZsyNwU9SG+mxJIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342393; c=relaxed/simple;
	bh=jf+vsu+WTgpWncreUvkd4YwjOt524czFATGH3sZASXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boqc97ufbNqMdOxs3Pf74QJBZsYSaUyalcxkHkBWEd7AVVO9/NDMeQum6Ic1rZRaZjM8oQttOxawOjc6pH647VvhR+LVaQQQuhutK0frA/J+Iv68P45ggYfM7nDQzf5y1rQaPqs1SeAn3NEuGgFo482Rknjq/Re2SFy8/lhbg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2zzQrm3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so34416431fa.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342390; x=1709947190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoIIx7zO7cBbHKnaF/of+NRm8ozsyHhYrXh6nCT3IOQ=;
        b=c2zzQrm3dUssBezI6KR8vbtGKb4c2YJEjeM4LNtPQutwFgOwKKTBi4aH9ap2+0UhL4
         bm/ifgxiwfYWxhkyAH+LMHH9NpBC+t9sGYv7nNiq3SE7pT4zNrOyLix+/rgFUEYIrF0P
         Bzubk+dzNbgMCrzJccgd1Lg/DVfVIxmnmbkbv8EjBj92W9rtPSqMuHv8u4tfRGwVDFtj
         CBVTSUjVXd2z+3PofMnTNSBsv7BW+JZvcVsjeAj4jZ6r5Z+JlEq3skzLAGTagqJclyEE
         JiA4wIdz8Axyz7I9tf/lAN3ZRPHKT3w0Mcc4wmjMQuD2LqtsGPPqiF44V8ATDEVMEQ7b
         IwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342390; x=1709947190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoIIx7zO7cBbHKnaF/of+NRm8ozsyHhYrXh6nCT3IOQ=;
        b=vjI446jvP4RCG+27PQ1zINMW3K3KngYxNAREymrclJQDIqCqfl0m9qugVtp1NdmgVj
         2Hm92uc+qEmrZUtkY15TgCQhUZy3+di2CL5TcLW1btt4sd6sonk0daQGLZ0q0ubO6VW0
         Y3oxXEY46qVw97MVQGUovwfI/EfYdXOr6a145SXgRQ7bOMD6E4W+aceCdxpPluOqlYZC
         wSHepZw0XxaRY4+5N8Z7HdLdyW8jKHW8Zo5co31cM4BrzjEaEEXA2RjNoJxSvBDz91EW
         vI/XzRvSvO9f0k56ctkx3OYNODgY6dnsILA/bQ/eZ4fNL1WHd0P3oP3u9F8jQCa7xhw+
         0ROA==
X-Gm-Message-State: AOJu0Ywo19xslyuXPIA9HdNXnElHsynsLSsto47Z2XtiEkcVfUXkoT4C
	UPOptmgAMf159hkkEDPU/j3bIiqP5XczOyg209fMECMyElBaltP7J6ePT4uj
X-Google-Smtp-Source: AGHT+IHniwdpCZhLKsblktjUUWQ7ZV6Vp0ANSs5Bbu2pG55014pHnZD78TRkFfAI/VFZEgi5pULvhA==
X-Received: by 2002:a2e:8e91:0:b0:2d3:158a:4ce4 with SMTP id z17-20020a2e8e91000000b002d3158a4ce4mr2248827ljk.26.1709342389761;
        Fri, 01 Mar 2024 17:19:49 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:49 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 13/15] selftests/bpf: test case for SEC("?.struct_ops")
Date: Sat,  2 Mar 2024 03:19:18 +0200
Message-ID: <20240302011920.15302-14-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that "?.struct_ops" and "?.struct_ops.link" section names define
struct_ops maps with autocreate == false after open.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/struct_ops_autocreate.c    | 58 +++++++++++++++++--
 .../bpf/progs/struct_ops_autocreate.c         | 10 ++++
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
index 765b0ec6383a..d5295ff2e925 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -33,10 +33,24 @@ static void cant_load_full_object(void)
 	struct_ops_autocreate__destroy(skel);
 }
 
+static int check_test_1_link(struct struct_ops_autocreate *skel, struct bpf_map *map)
+{
+	struct bpf_link *link;
+	int err;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		return -1;
+
+	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
+	err = ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+	bpf_link__destroy(link);
+	return err;
+}
+
 static void can_load_partial_object(void)
 {
 	struct struct_ops_autocreate *skel;
-	struct bpf_link *link = NULL;
 	int err;
 
 	skel = struct_ops_autocreate__open();
@@ -57,15 +71,45 @@ static void can_load_partial_object(void)
 	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
 		goto cleanup;
 
-	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+	check_test_1_link(skel, skel->maps.testmod_1);
+
+cleanup:
+	struct_ops_autocreate__destroy(skel);
+}
+
+static void optional_maps(void)
+{
+	struct struct_ops_autocreate *skel;
+	int err;
+
+	skel = struct_ops_autocreate__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open"))
+		return;
+
+	err  = !ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_1),
+			    "default autocreate for testmod_1");
+	err |= !ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_2),
+			    "default autocreate for testmod_2");
+	err |= !ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_map),
+			     "default autocreate for optional_map");
+	err |= !ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_map2),
+			    "default autocreate for optional_map2");
+	if (err)
 		goto cleanup;
 
-	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+	err  = bpf_map__set_autocreate(skel->maps.testmod_1, false);
+	err |= bpf_map__set_autocreate(skel->maps.testmod_2, false);
+	err |= bpf_map__set_autocreate(skel->maps.optional_map2, true);
+	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
+		goto cleanup;
+
+	err = struct_ops_autocreate__load(skel);
+	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	check_test_1_link(skel, skel->maps.optional_map2);
 
 cleanup:
-	bpf_link__destroy(link);
 	struct_ops_autocreate__destroy(skel);
 }
 
@@ -75,4 +119,6 @@ void test_struct_ops_autocreate(void)
 		cant_load_full_object();
 	if (test__start_subtest("can_load_partial_object"))
 		can_load_partial_object();
+	if (test__start_subtest("optional_maps"))
+		optional_maps();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
index 294d48bb8e3c..703ad8a2914f 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
@@ -40,3 +40,13 @@ struct bpf_testmod_ops___v2 testmod_2 = {
 	.test_1 = (void *)test_1,
 	.does_not_exist = (void *)test_2
 };
+
+SEC("?.struct_ops")
+struct bpf_testmod_ops___v1 optional_map = {
+	.test_1 = (void *)test_1,
+};
+
+SEC("?.struct_ops.link")
+struct bpf_testmod_ops___v1 optional_map2 = {
+	.test_1 = (void *)test_1,
+};
-- 
2.43.0


