Return-Path: <bpf+bounces-72886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF42C1D1B0
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D77E134C813
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492435A95F;
	Wed, 29 Oct 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5F8Dcec"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDD357A29
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767962; cv=none; b=A+H9fkufdBBgk96NdHxA3op/8eF+EmEx1XSC2peoQywwkSuQWFmvhSBe1wZhAMza4SaL/jXaP21AFQAHdyNYrTdYOw8N79vrF7P87jPcDPSDBVdBw2rNM2DKX1vl4AQCODa7nytFttA/RNyqzvbS4WHDXMAfoE47o3R+I0OBgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767962; c=relaxed/simple;
	bh=ueTnTOLUwaKJpePfYh2+s3lXTRYCYpbmLclGTWkl0wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i52wXbYzp1576uQ8HAB0g3Ozh9GQ5puMCu+JnEkI8u8rGqHkLMiyIdR6vplXIj9YN5QxODgg05Zxv3jk5N6mgzdOAKwg0C7Wr7XIuL9je8QoqYq8ZRO3qqUoT2ZN0Ij/jL4vlxj0bGLq+qUvrEcbYpqEfyPLcJm9/dM4u+gwXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5F8Dcec; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so8589135e9.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761767959; x=1762372759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8yZz1v715AlMXc/A5J084sC/x+YSGFpgitDdD3oebI=;
        b=K5F8DcecP32BWaJ4wzP/Skc0Dp7HNkUdklObtl3+OvdfsNUThYlazroKkIuacjKtMM
         EI2PPAdxgaSpLxvJIoeslj4tN/5d0lbjTRoX0EnjENYmYtQ8gAD1Cnrhb7gsLFWpIx8C
         2FFbNtaw47rqnUv87iOEMv5FwZDxvcG5bKp++YHUHUbpN7S5ukJkb5PLe39lOz0W23xe
         aIML2eePkHdxkAeGZ8pNtup7FD1u+dfUWGC0bkz6ImrRi2JB4dOdZFFMSmJMgxTX5oko
         jPsFHnl0iRZerMNVldMJm9y5hCfr6jhhPTswMRD+eTJde7MYuH51uVpyfBIMhfhKBG0t
         icCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761767959; x=1762372759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8yZz1v715AlMXc/A5J084sC/x+YSGFpgitDdD3oebI=;
        b=lU+Ka2jXeTsL/ovExfWHgkUy+P0nfxedkwKl4bZtuQuwbLlo0ZPLl63X83TyC13KSj
         KFp3Sx2HHpeYUOu4arV00aoZstPWxrxc9vV9fp+ZwIo14eriB/WI4KjkCOfiextI8SA4
         hB2C2ns2kJbyAQqEg6uTZL68To3ocjX7JtihOmIRr4UfAxD6Ks1vA3VzVyb8MwOKmx0C
         UJ8ngVpRQB8rWD2FAmIUKcA9fPYCU4z1KU85uk9c7wHA3GX4bfIVkq7eucnpsoFbTBXF
         jm/UPu9lNX1mtDlf1hO2QVJT6lwiKymHfbncoMaDrF04nwKy2knkAEECMPtYuSLWzB6V
         T2yQ==
X-Gm-Message-State: AOJu0YxhO60I9+B6TIog/sEwpjIuWq50GZbsnZ+R6XW0THg3FzFDoWaa
	ro4vZDJs3bvuPDB/+KA3CFsFxYC//qh0yaqNDRUg7bMpxta0MclIAzqzDFMC3Q==
X-Gm-Gg: ASbGnctVh+y1WThFZZWC+YtyLqUcIcSsDtdxQxJTfzsph90Akfzni1qNcatKF1WM1/K
	jEiqyhvlZiwxDMIiH8k9sGAMs+e8+Y1UqkHp8UbvkMMgdhycBJAly253vCO9xjlpYLKzAmWZjEb
	TwkqeYwXZnCLlNc2X+57PSFrc5PWFBmtRKw18hjUmhEfQxEW1yQDrkVrN/Sv1UPAA3ESQHm6Xhw
	gYx/tVNkR3xoYJCErQO/A8zJsp0rtjIpZkeUXo3od03Uv4Jqa9uW4MPqX/FTts38MnojqfqzMVL
	DmAzJGcaHH0fLUWyHZp38g0chS53Vcu7PZKnP4lSlUumSYNkUzVs9qtDraL6SYo4BETprQwOwVk
	CvUtNZdvIoGUG3QTZZwXndGaR6R0hKLCWVeTDlYkP6IE279NbOvDrwY6vUZ4BA2JKiqNIyEg=
X-Google-Smtp-Source: AGHT+IHBLS4DibeLplw17yL29UX4nMvdAmJ6Kx27iN3j08nldxSGvgqBGpPDuy6fs7sFGp47pfmRGQ==
X-Received: by 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr6057385e9.3.1761767958401;
        Wed, 29 Oct 2025 12:59:18 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:7e57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728a96897sm302495e9.11.2025.10.29.12.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:59:17 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1] selftests/bpf: fix file_reader test
Date: Wed, 29 Oct 2025 19:59:07 +0000
Message-ID: <20251029195907.858217-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

file_reader/on_open_expect_fault intermittently fails when test_progs
runs tests in parallel, because it expects a page fault on first read.
Another file_reader test running concurrently may have already pulled
the same pages into the page cache, eliminating the fault and causing a
spurious failure.

Make file_reader/on_open_expect_fault read from a file region that does
not overlap with other file_reader tests, so the initial access still
faults even under parallel execution.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/file_reader.c | 6 +++++-
 tools/testing/selftests/bpf/progs/file_reader.c      | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
index 2a034d43b73e..5cde32b35da4 100644
--- a/tools/testing/selftests/bpf/prog_tests/file_reader.c
+++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
@@ -52,7 +52,11 @@ static int initialize_file_contents(void)
 	/* page-align base file address */
 	addr = (void *)((unsigned long)addr & ~(page_sz - 1));
 
-	for (off = 0; off < sizeof(file_contents); off += page_sz) {
+	/*
+	 * Page out range 0..512K, use 0..256K for positive tests and
+	 * 256K..512K for negative tests expecting page faults
+	 */
+	for (off = 0; off < sizeof(file_contents) * 2; off += page_sz) {
 		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
 			       "madvise pageout"))
 			return errno;
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 2585f83b0ce5..166c3ac6957d 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -49,7 +49,7 @@ int on_open_expect_fault(void *c)
 	if (bpf_dynptr_from_file(file, 0, &dynptr))
 		goto out;
 
-	local_err = bpf_dynptr_read(tmp_buf, user_buf_sz, &dynptr, 0, 0);
+	local_err = bpf_dynptr_read(tmp_buf, user_buf_sz, &dynptr, user_buf_sz, 0);
 	if (local_err == -EFAULT) { /* Expect page fault */
 		local_err = 0;
 		run_success = 1;
-- 
2.51.1


