Return-Path: <bpf+bounces-23217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E028186EDC9
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEE11F23F58
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3A7483;
	Sat,  2 Mar 2024 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hirxtFR4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A463CB
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342383; cv=none; b=Y7+3LXcXHlvLM/47Htnc5sYTB9+/5PDKCCinh7ek1ywp/SVsOthYhYX79lv7umBLJbK5mCmhACzWISiyMVHgWmUMLMjZWEXvGgWVHPBAcPsuo3ws4k8el0XxFaY1XziYm70vZAbYNTh6x1Wrn6DHvwPXoYjhy3axD0A8hPU+0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342383; c=relaxed/simple;
	bh=cEPnyfFWBE9D0OLMyGcbpMzkO4Je1leH8rHBZdxQL3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cra5CbkYWxCpIi8sS6a3YbZH3VHG5miRQRE94kxlp7SqwMl6/BhAmC1uen35/BmDoevd40DD3/W7go7M7Mm7dvPoCR5/Ztu4ZaegarDopbTTjEDf3h/pxuN24+ORT84n1QaeReCTdn1QrQiQpwUWsUyUfYkOlh6RWblJZ+XUM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hirxtFR4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso28743701fa.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342379; x=1709947179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC9tgxkqjgWUVRZpjwzr6XxoNQs3LWLYSDd6/trJreM=;
        b=hirxtFR4WmthJ0eNkHUrWZIr23mwXwmx56aaguD0KBHAs3BRTZUuZbQ1YEBB+gNiiP
         Fd8yPK9Yv/a4399Rhbupi0sebMfwAVHMEBoUXKDgsbb2H5yh96dkGpliFeptRKgG1Q9Q
         cUoI0k5N3qkUil68inqtikxXX7UVerxFpx8lY03uuGoacqGsrUOg98XZ1zChI65nDNbR
         vPoX3UaJPkX19+7++a5P4sywGqHSJ1vmGrQvWdFNB6+25J+2oOZcpMB53UGVSaRaqpS0
         0r4QlHURwHNLnLgT7h3nGNBFGYFNuBKXXZ+2cEj/laaDZsHWuaGSQrGmVzVzFgnWMgJq
         N+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342379; x=1709947179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC9tgxkqjgWUVRZpjwzr6XxoNQs3LWLYSDd6/trJreM=;
        b=pk4YpDv++ZvibLAq8e82zGEuOU1tg6oWc5Ml1+2LbzlrYrZKm9giSIOHpw8TpCsYaf
         6d6LENmKy9dMWbSS8ul7J6OiyRU8C1FtOnBs1aV++OZB6J4kA03xJJOFT50DE2Md9r3Q
         mSgS9VQk3oprU9OtC8hHo8cVQi3S8thbXzETxWufFWNEwXmE0CL+aZjltXHLy7oxRd5v
         XZuTpRAJ8C6pfp6NkRb6+YDIyf6Sp1Q9d/RyMGMCMRGxB8v+5Tkg2SkCeOeNaQ4K3b2P
         AVe20IiY4HtCxzlGJCBDPFOgh1H6093BHqLv1DuzAGIw+TBRxxXZjAI+wtWBEzsbHGol
         L7uA==
X-Gm-Message-State: AOJu0YxeT7zBZSPJgMjWx2p0NhZsH34cFGwyQfrA/bzyIvrAvTGdqRm/
	Wp86Cdw6nOQVSb2GYmRmkHq0DVP777/UmvraVhzxIof762WrqGoOjaU6Cbmj
X-Google-Smtp-Source: AGHT+IGDwsRcMl80cox7tlRmbE5Hp/iOrshPsijxzmXPV3cf2wbffYzRT8DqFihAC4bSGTsSSWUODg==
X-Received: by 2002:a05:651c:224:b0:2d2:bd9:f100 with SMTP id z4-20020a05651c022400b002d20bd9f100mr2282445ljn.20.1709342379288;
        Fri, 01 Mar 2024 17:19:39 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:38 -0800 (PST)
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
Subject: [PATCH bpf-next v2 04/15] selftests/bpf: test struct_ops map definition with type suffix
Date: Sat,  2 Mar 2024 03:19:09 +0200
Message-ID: <20240302011920.15302-5-eddyz87@gmail.com>
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

Extend struct_ops_module test case to check if it is possible to use
'___' suffixes for struct_ops type specification.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 33 ++++++++++++++-----
 .../selftests/bpf/progs/struct_ops_module.c   | 21 +++++++++++-
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 098ddd067224..b9ff88e3d463 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -564,6 +564,7 @@ static int bpf_dummy_reg(void *kdata)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
+	ops->test_1();
 	/* Some test cases (ex. struct_ops_maybe_null) may not have test_2
 	 * initialized, so we need to check for NULL.
 	 */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 7d6facf46ebb..ee5372c7f2c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -30,11 +30,29 @@ static void check_map_info(struct bpf_map_info *info)
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
 	struct struct_ops_module *skel;
 	struct bpf_map_info info = {};
-	struct bpf_link *link;
 	int err;
 	u32 len;
 
@@ -59,20 +77,17 @@ static void test_struct_ops_load(void)
 	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
 		goto cleanup;
 
-	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
-	ASSERT_OK_PTR(link, "attach_test_mod_1");
-
+	check_map_info(&info);
 	/* test_3() will be called from bpf_dummy_reg() in bpf_testmod.c
 	 *
 	 * In bpf_testmod.c it will pass 4 and 13 (the value of data) to
 	 * .test_2.  So, the value of test_2_result should be 20 (4 + 13 +
 	 * 3).
 	 */
-	ASSERT_EQ(skel->bss->test_2_result, 20, "check_shadow_variables");
-
-	bpf_link__destroy(link);
-
-	check_map_info(&info);
+	if (!attach_ops_and_check(skel, skel->maps.testmod_1, 20))
+		goto cleanup;
+	if (!attach_ops_and_check(skel, skel->maps.testmod_2, 12))
+		goto cleanup;
 
 cleanup:
 	struct_ops_module__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 25952fa09348..026cabfa7f1f 100644
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
@@ -35,3 +37,20 @@ struct bpf_testmod_ops testmod_1 = {
 	.data = 0x1,
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


