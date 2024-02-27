Return-Path: <bpf+bounces-22791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F0E86A0FE
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61E21C2472C
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98DA14EFD8;
	Tue, 27 Feb 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHM63m/v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9358134B1
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066796; cv=none; b=EZzEUenv0ul+0TMZyqYPHNk7xmdIex6VUQymOf+7b6xKtEdSYndAfH8ZqCW6R85/ydPaaMdQc1m9LU638EcDrXOkNP+lKY9d+RlHBJmM+OaZZsIBLKdfaEnPjYm0aZKNxdY2a8xnW1oXGl5BycxoZharQKlAqvTbk73r2Nn1/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066796; c=relaxed/simple;
	bh=0AuSwfw14n0kaj/ajCbSsEi+4AfinuiC4BPDCRWxqjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0n5HMs1G3uZ9me0c8xu5CvXDAESQO18MuG0LwYJP+CsP2uRQPFUrMF8Z4Dmf6o2XGhOpWCIr9tFYq6Eldpy5JG4xL7eDL3pkmt+AHVetlPBh03G2e7hDiq4GBfX6wzOJlzJexSo28OWWs0EGbm8tLMTTGwZ9W/5Jackezy/HbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHM63m/v; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56533e30887so5486180a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066793; x=1709671593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg81NkrF2MG3shbswEhvkPBxiUXCqbyJB/br8WJz2/I=;
        b=KHM63m/v1yAaTqnSEEqhmZJpz+X6HKWa+c7wUZ+EWB0l8dBcssoTgalcquQjwicE8R
         plo0ZV39q1nNFnhs8oOT1o/A2iE/GBvmbrwHkBt2a4npwPJz0pbgWTBM29/SeMVs8XOk
         6pUaSgXR/1hjiH8bxfEwpnCgmCtLiGn6PlXbVyaKIwh3cWSXASCpVWxJLo1INiBQiGX2
         hTG/fNGaL/hvwcNplueWlUGEiH/veP8+orLqE4oAR9gpYnBetyaEyLLKpOrV7Zk9ZzW/
         A5eG9HWpshD4+b+bIZ3OQ88l5AyOY6o2Pezf8mLBwRUcKrQ7BOwKrOyauZbsZX+sSf7B
         J7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066793; x=1709671593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg81NkrF2MG3shbswEhvkPBxiUXCqbyJB/br8WJz2/I=;
        b=Z+idY6IaVlktAC92hWTB1RwyvFFjfQt97F3p4XpftHXn/MRTCnm3l42xpiFYR88Ema
         JuBmB3K71oiTzYNtIAZKMEEXp8QyMwCWjqrKgQut9nMPfytj8Ma66EKnrV347wug3suL
         OuOmGbSoNNWyHq6YJnf36bXKzOf0LkvFfFgsLsF5vuXKG+at2yYPGQxPlLgTat/s0yf7
         TwuSqjdBRXRWJWHatFJRJFRQCQ1DlNNMiApoRgKLL3y9LLO3yG8FTnnRLyv/ijc5UU32
         u0FedkQKayrd6ARFFrYjFK+ttUrIm6msmBOESAI30be4kF+Zw/iKFypFjekzVapxiqzv
         ZTJA==
X-Gm-Message-State: AOJu0YxI3S2SPLfOI3hjPKRbpKf+1sNoN+QkIJMfR1cZKgw3E5NQi6Ac
	SbBV2ydkDDRdjB//Lv+SbhMDrG+iTOidsN1rh1JD8O0Em4u8j+90ZMo0JGaQxrI=
X-Google-Smtp-Source: AGHT+IFxHQhGm+RgXWhvAbwB+FloHm5JB5I1XCV+ISW62pF1z4NUpW3oYp3BO0d4J8nxlnwMR5kv+A==
X-Received: by 2002:a17:906:ecb4:b0:a43:1940:c7f8 with SMTP id qh20-20020a170906ecb400b00a431940c7f8mr5147462ejb.31.1709066792939;
        Tue, 27 Feb 2024 12:46:32 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:32 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 4/8] selftests/bpf: test struct_ops map definition with type suffix
Date: Tue, 27 Feb 2024 22:45:52 +0200
Message-ID: <20240227204556.17524-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend struct_ops_module test case to check if it is possible to use
'___' suffixes for struct_ops type specification.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 32 +++++++++++++------
 .../selftests/bpf/progs/struct_ops_module.c   | 21 +++++++++++-
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 66787e99ba1b..0d8437e05f64 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -555,6 +555,7 @@ static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
+	ops->test_1();
 	/* Some test cases (ex. struct_ops_maybe_null) may not have test_2
 	 * initialized, so we need to check for NULL.
 	 */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 8d833f0c7580..7bc80d2755f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -30,12 +30,30 @@ static void check_map_info(struct bpf_map_info *info)
 	close(fd);
 }
 
+static int attach_ops_and_check(struct struct_ops_module *skel,
+				struct bpf_map *map,
+				int expected_test_2_result)
+{
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(map);
+	ASSERT_OK_PTR(link, "attach_test_mod_1");
+	if (!link)
+		return -1;
+
+	/* test_{1,2}() would be called from bpf_dummy_reg() in bpf_testmod.c */
+	ASSERT_EQ(skel->bss->test_1_result, 0xdeadbeef, "test_1_result");
+	ASSERT_EQ(skel->bss->test_2_result, expected_test_2_result, "test_2_result");
+
+	bpf_link__destroy(link);
+	return 0;
+}
+
 static void test_struct_ops_load(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct struct_ops_module *skel;
 	struct bpf_map_info info = {};
-	struct bpf_link *link;
 	int err;
 	u32 len;
 
@@ -53,15 +71,11 @@ static void test_struct_ops_load(void)
 	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
 		goto cleanup;
 
-	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
-	ASSERT_OK_PTR(link, "attach_test_mod_1");
-
-	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
-
-	bpf_link__destroy(link);
-
 	check_map_info(&info);
+	if (!attach_ops_and_check(skel, skel->maps.testmod_1, 7))
+		goto cleanup;
+	if (!attach_ops_and_check(skel, skel->maps.testmod_2, 12))
+		goto cleanup;
 
 cleanup:
 	struct_ops_module__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index b78746b3cef3..e91426dc51af 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -7,12 +7,14 @@
 
 char _license[] SEC("license") = "GPL";
 
+int test_1_result = 0;
 int test_2_result = 0;
 
 SEC("struct_ops/test_1")
 int BPF_PROG(test_1)
 {
-	return 0xdeadbeef;
+	test_1_result = 0xdeadbeef;
+	return 0;
 }
 
 SEC("struct_ops/test_2")
@@ -27,3 +29,20 @@ struct bpf_testmod_ops testmod_1 = {
 	.test_2 = (void *)test_2,
 };
 
+SEC("struct_ops/test_2")
+void BPF_PROG(test_2_v2, int a, int b)
+{
+	test_2_result = a * b;
+}
+
+struct bpf_testmod_ops___v2 {
+	int (*test_1)(void);
+	void (*test_2)(int a, int b);
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___v2 testmod_2 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2_v2,
+};
-- 
2.43.0


