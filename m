Return-Path: <bpf+bounces-27612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878A8AFDD7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255EE287BA3
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AE0C13D;
	Wed, 24 Apr 2024 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLsyMWyY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBD748A
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922132; cv=none; b=nAteJBlX6cBHT/ZpNwbSkypPQ8hlZxwl5ZeNzirCuJH2GqM9XeM4hgu1Hww3jQcOi566pTx+O3ZhZ1YaVBCyLfvOqoixVHK/i9H0vtqTsEzkmNr/uaxo9xV4MgU4FUKMdzkqbWzO06uhuKcz+uVXce7Wqxf0aADhQc5CBrQYq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922132; c=relaxed/simple;
	bh=lt/4KEcxgi+dKSugUo/CCet1gqH6ovg9L/1Flx+HRXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKtblzYnxED/b71NcebXVpyI4glyp2u67R9Yud0DExNnycIPYSghnjLO9LwoTf1QFtRYW47c7LI6SaCRWEZLwdFuNd3ukwCIzaJEGSC/wZ0BqfLi3LZgb3k0TXs4vCa+xjlT6pNVVkZ6Kov5rq2RciIY1m0YQm7LvIKSIAXIWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLsyMWyY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so6665791b3a.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 18:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713922130; x=1714526930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c88AZSJbjLbncPcEf4x9ksfVi3C2muY6xU8IDwdukyU=;
        b=eLsyMWyYMYDDw7yxNjNGhnio05VBpImBvAAV5rYLC5hNmzfh1zEtAG2Jxqna/kJ/O5
         nlhpuiDURgdtkD1EvxT8bF9cYofq4hNXbdoSxygw8Dtji5WNLcgMHZ6SBhFlnJ8ZTZJe
         MPUdDzpHkrthH1M+o/nKfnQY/cdTJwRgayOX9duE0knd1XZT1sRDdyT4hc3GZdFKuxHg
         oHAdjleL82TOo2fXhfAy1G1WRHyJlSwBNrZU4FTKdu1LgQ4pz6iDR1lvwk9i27vIkHSc
         K3wl66SdVAiQ25s/Oglhnaq58vsk6JTrlD01dAVUMFPNZjWw49w61rgW3pDm5XQ5brQ0
         IwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922130; x=1714526930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c88AZSJbjLbncPcEf4x9ksfVi3C2muY6xU8IDwdukyU=;
        b=C18bsyOAElPf4MvL+fxqWtLdE4U7wMEunCxKw8fgTbhhTzRJde/sHIOcKVPZK59Lh+
         L2LXV7aU8LT5dset2Vyu8NtJHv9819Egce5aPpxOUazJkNvwMp6ILM+inx0DJNbZf2gW
         p+mY37N41CIuYcbb8UI9vn+1tIwvFfxLqZCxFrcnG0z2dB5PZA8jxsKneMA5JYEUCiqS
         PQSHX8dZghIWDyYHvOZb/7S3USlrXqPcp865YAV5qLw4gP+fjNRjazR7mnBaMbw2NcYZ
         k2XQEBNVHkbv6DH7CNtMsrrDdE98k2AhVsddhjIDH5c6yClO87e3n562glVTXeC55e75
         S+Rw==
X-Gm-Message-State: AOJu0Yywhaa1Pnx26d/xuJmPSGDoZ/pDZcs8gZ0nqynXInR8+pSEDGAq
	M9anBShGpHWaMbRMznCJGOY6W6EJHPz+M99QhGJTiyV47Oj7/Xa6luW1Ew==
X-Google-Smtp-Source: AGHT+IH64742sJcngCd9nDwpmR+R9gQ3XqAE85uzPYbwX29ssCfCBBi3kPYZO43+SQtd2ENG0aFLBg==
X-Received: by 2002:a05:6a00:194b:b0:6ef:a0fe:c478 with SMTP id s11-20020a056a00194b00b006efa0fec478mr1616306pfk.34.1713922130242;
        Tue, 23 Apr 2024 18:28:50 -0700 (PDT)
Received: from badger.vs.shawcable.net ([2604:3d08:9880:5900:1fa0:b3a5:f828:f414])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm10271007pfb.4.2024.04.23.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:28:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jemarch@gnu.org,
	thinker.li@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: do not pass NULL for non-nullable params in dummy_st_ops
Date: Tue, 23 Apr 2024 18:28:19 -0700
Message-Id: <20240424012821.595216-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424012821.595216-1-eddyz87@gmail.com>
References: <20240424012821.595216-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dummy_st_ops.test_2 and dummy_st_ops.test_sleepable do not have their
'state' parameter marked as nullable. Update dummy_st_ops.c to avoid
passing NULL for such parameters, as the next patch would allow kernel
to enforce this restriction.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c    | 7 +++++--
 tools/testing/selftests/bpf/progs/dummy_st_ops_success.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index f43fcb13d2c4..dd926c00f414 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -98,7 +98,8 @@ static void test_dummy_init_ptr_arg(void)
 
 static void test_dummy_multiple_args(void)
 {
-	__u64 args[5] = {0, -100, 0x8a5f, 'c', 0x1234567887654321ULL};
+	struct bpf_dummy_ops_state st = { 7 };
+	__u64 args[5] = {(__u64)&st, -100, 0x8a5f, 'c', 0x1234567887654321ULL};
 	LIBBPF_OPTS(bpf_test_run_opts, attr,
 		.ctx_in = args,
 		.ctx_size_in = sizeof(args),
@@ -115,6 +116,7 @@ static void test_dummy_multiple_args(void)
 	fd = bpf_program__fd(skel->progs.test_2);
 	err = bpf_prog_test_run_opts(fd, &attr);
 	ASSERT_OK(err, "test_run");
+	args[0] = 7;
 	for (i = 0; i < ARRAY_SIZE(args); i++) {
 		snprintf(name, sizeof(name), "arg %zu", i);
 		ASSERT_EQ(skel->bss->test_2_args[i], args[i], name);
@@ -125,7 +127,8 @@ static void test_dummy_multiple_args(void)
 
 static void test_dummy_sleepable(void)
 {
-	__u64 args[1] = {0};
+	struct bpf_dummy_ops_state st;
+	__u64 args[1] = {(__u64)&st};
 	LIBBPF_OPTS(bpf_test_run_opts, attr,
 		.ctx_in = args,
 		.ctx_size_in = sizeof(args),
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
index cc7b69b001aa..ec0c595d47af 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
@@ -34,7 +34,7 @@ SEC("struct_ops/test_2")
 int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1, unsigned short a2,
 	     char a3, unsigned long a4)
 {
-	test_2_args[0] = (unsigned long)state;
+	test_2_args[0] = state->val;
 	test_2_args[1] = a1;
 	test_2_args[2] = a2;
 	test_2_args[3] = a3;
-- 
2.34.1


