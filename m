Return-Path: <bpf+bounces-22361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBFC85CD6A
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B729D284E58
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C3613A;
	Wed, 21 Feb 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRrD3yGt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3A46A4
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478632; cv=none; b=SuDA0mjzqlrQfucun1zeMx1yvEX8mddP0xlhcvRkepwNBoMqLhh4xeJKEGbmGUciLdMlv5G0Nury9YFqBm3y3Aaiu2YsMr4OQAvtqvY9fa92hJDNeE1bJpJDakrizYIiIOl1C3Yqb7rdfhoI7PTUKgMtnTNk18cLGhe4jAw3S6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478632; c=relaxed/simple;
	bh=kY+MSlkBXyBkmnvb+NaTneZsRI1XZ8ED3i+XLagur6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cangqc72Qb3nIrOqG/GBZ6TvCVrC1IkM0l+1Lkmt/utMKa5nKFN7V7nGQPTX7GPZ5gkvHeCxHHyjr9HZsocUMQjRCLrzbt+b9/IC69emIipLxMFuUvE3DkhHUl0RihqBFtkekDmWVvCqWj8HxZzyWJrlaiBCp8rRuh50oF1hQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRrD3yGt; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607c5679842so832577b3.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478629; x=1709083429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvyBlmzvCQZn7YJtlhRv6cuFksnihPgBjQqmVbCumoc=;
        b=ZRrD3yGtZo98Xf3JbMUUUqMd/CPQXbYjryFxkfXEUITy/rOxE3DRIwZPusCz2Gw7Ub
         2x4RplXU2YzSiKBag3DZcpOYTJhrkgnMoH2SwDRrbYi0Twp97WWTJ7JtUjaXQejoQyqb
         dd1FxqzwnC4sR9xIJpp1pQuqOg2VAFeY1+7GdLqD0xBnd97EB9aV9LKA1OaqJ3VrDmX4
         zAzfYgSmMww/RJZ8xruhPzrA27HRvUjRMVrWohUmNGskHrrqiep/oPGIrykZezjNB8lb
         jOi2O72MO+7BMiDt+bwVxcgS6tGc+keNG+gVODBYWQHPDwV5I8irYCfigL90r+aVavKX
         kVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478629; x=1709083429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvyBlmzvCQZn7YJtlhRv6cuFksnihPgBjQqmVbCumoc=;
        b=sy1TwUH2h3BgqdAzu6gi0iS3yG/oQKRYG2Z+TzwhZVw/7ZJcnboQ6uFqN3mDYM+kOs
         +3q4B3PnFEu4G9TXzyCNCEIKfp9H6zwpWAmgC84L521slR8ao00Czz8Hh2B6PoiTU6D+
         oN6KzsbRq+Qs3FHCRa1kvB3dPKllQYW3WYgVX2RV0c1psv2+HtK5tV7N26K6s04CoVgV
         M7i0vZ9vNMpdNe/zjA2S/QjpGbeOXoSqkTt56FteEmzEzEU56fy+ciwwfQ4YuCyI/suh
         PmMjT39m4LV1XfNvIkRSoNrwqIGVYXxXpUfnH5DLwcVsao7tB/GLvpNk2QyfbRDnoUf7
         QRVQ==
X-Gm-Message-State: AOJu0Ywuxc/684BqJWsyTDsKTFgGcthd3QhHiEoKvC41yXTydDpftQ+7
	qeExNHR6G1FZTx2pMz1YhcejIiiz6hpIUPH5HWDW9vo8JbBZD0ZajCA8x5Yq
X-Google-Smtp-Source: AGHT+IFgZahGMCpbLqQc3T2Si/LISxsJxS9aTOaGhqOVCNel/kre5aomCauEsBdYgbJRM1fR1KSSTA==
X-Received: by 2002:a81:bc51:0:b0:608:7a9c:9a82 with SMTP id b17-20020a81bc51000000b006087a9c9a82mr1053596ywl.47.1708478628851;
        Tue, 20 Feb 2024 17:23:48 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id j64-20020a0de043000000b00607ef065781sm2396801ywe.138.2024.02.20.17.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 17:23:48 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Test if shadow types work correctly.
Date: Tue, 20 Feb 2024 17:23:29 -0800
Message-Id: <20240221012329.1387275-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221012329.1387275-1-thinker.li@gmail.com>
References: <20240221012329.1387275-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Change the values of fields, including scalar types and function pointers,
and check if the struct_ops map works as expected.

The test changes the field "test_2" of "testmod_1" from the pointer to
test_2() to pointer to test_3() and the field "data" to 13. The function
test_2() and test_3() both compute a new value for "test_2_result", but in
different way. By checking the value of "test_2_result", it ensures the
struct_ops map works as expected with changes through shadow types.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 11 ++++++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  8 ++++++++
 .../bpf/prog_tests/test_struct_ops_module.c   | 19 +++++++++++++++----
 .../selftests/bpf/progs/struct_ops_module.c   |  8 ++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 66787e99ba1b..098ddd067224 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -539,6 +539,15 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
 {
+	if (member->offset == offsetof(struct bpf_testmod_ops, data) * 8) {
+		/* For data fields, this function has to copy it and return
+		 * 1 to indicate that the data has been handled by the
+		 * struct_ops type, or the verifier will reject the map if
+		 * the value of the data field is not zero.
+		 */
+		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
+		return 1;
+	}
 	return 0;
 }
 
@@ -559,7 +568,7 @@ static int bpf_dummy_reg(void *kdata)
 	 * initialized, so we need to check for NULL.
 	 */
 	if (ops->test_2)
-		ops->test_2(4, 3);
+		ops->test_2(4, ops->data);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index c3b0cf788f9f..971458acfac3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,14 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+
+	/* The following fields are used to test shadow copies. */
+	char onebyte;
+	struct {
+		int a;
+		int b;
+	} unsupported;
+	int data;
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 8d833f0c7580..7d6facf46ebb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -32,17 +32,23 @@ static void check_map_info(struct bpf_map_info *info)
 
 static void test_struct_ops_load(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct struct_ops_module *skel;
 	struct bpf_map_info info = {};
 	struct bpf_link *link;
 	int err;
 	u32 len;
 
-	skel = struct_ops_module__open_opts(&opts);
+	skel = struct_ops_module__open();
 	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
 		return;
 
+	skel->struct_ops.testmod_1->data = 13;
+	skel->struct_ops.testmod_1->test_2 = skel->progs.test_3;
+	/* Since test_2() is not being used, it should be disabled from
+	 * auto-loading, or it will fail to load.
+	 */
+	bpf_program__set_autoload(skel->progs.test_2, false);
+
 	err = struct_ops_module__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_module_load"))
 		goto cleanup;
@@ -56,8 +62,13 @@ static void test_struct_ops_load(void)
 	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
 	ASSERT_OK_PTR(link, "attach_test_mod_1");
 
-	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
+	/* test_3() will be called from bpf_dummy_reg() in bpf_testmod.c
+	 *
+	 * In bpf_testmod.c it will pass 4 and 13 (the value of data) to
+	 * .test_2.  So, the value of test_2_result should be 20 (4 + 13 +
+	 * 3).
+	 */
+	ASSERT_EQ(skel->bss->test_2_result, 20, "check_shadow_variables");
 
 	bpf_link__destroy(link);
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index b78746b3cef3..25952fa09348 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -21,9 +21,17 @@ void BPF_PROG(test_2, int a, int b)
 	test_2_result = a + b;
 }
 
+SEC("struct_ops/test_3")
+int BPF_PROG(test_3, int a, int b)
+{
+	test_2_result = a + b + 3;
+	return a + b + 3;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_1 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
+	.data = 0x1,
 };
 
-- 
2.34.1


