Return-Path: <bpf+bounces-21941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C0854161
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEFC28D38F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C28F6D;
	Wed, 14 Feb 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNNwl34O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BB79E4
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876529; cv=none; b=BEYR8amrzpTIzmnIfQDtcI/nFLkirnbnXSJhRxHxL0unywijJSvzCOksk6C2EnrFdrRj2fCjBR593wDD7XRQgB43EPiTRR8p/Nq1MXP/4V48QnYWSK8Ojcj1CXwnMMNSyKRSqPbfPdHcj25Ory44AAtoy6X7O0CKJx6kBi29qwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876529; c=relaxed/simple;
	bh=rAijJx3F0NAnIP754tBz6sHGDAXUutn7JktKIRBgJvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCQ2n+S/62Z6yTQNLQ7fhtrxwJBzAsFG2ZGADoG8eRNY+E2I8xSkOFqyik5BW+aTMdg6SiODQNBrNYYEVHQNvnjspcI59UEj3l9vvvSM8SdNSgIm5ofHSqCJQN7Q7VdYKjRbNvE3LTb/r4EKsTT94sv/qxJNJE/edS2ErUYyJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNNwl34O; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4366890276.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707876526; x=1708481326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjN4u8nYemxSER4RxMIvQTe+Q2rce+eGYsiG4eAZVsA=;
        b=FNNwl34OESSG9xYohFTVIa6GfVb06LW+Yo9mNHairhh8CMAcWqS/C/nHX3evx2uXlc
         EaYe5TwcLm9ogvR7hEr2rJvASo9dkcMEQUbypfyY6GDTr4cpFXcDSw0+Zib1z4XwOLC6
         wZEVi7ls0ENylDV+TbK/iue3ryOo+jgmMmq9/rqZvTV8kpxOPDEpR92eUoKT/QIOjccq
         TyGahKVlyjB4irjzJHemMpwZCNqnt9x2sZLGkgge8IfEh732DUf7BqrOoqBdAw+VorFa
         rZTVcAnCyi0F2yQ0k5KdDlZJvlmEfAwAoE+8NNQZSaqfSZDTYXdyuC8MD5U5vwBq865t
         FvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707876526; x=1708481326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjN4u8nYemxSER4RxMIvQTe+Q2rce+eGYsiG4eAZVsA=;
        b=fag2AP/DmKGpc+hPquJtIka6EsEJ1z1T00dkGNZnIz+wIMFvSZsRSUvhP/7+mAg3tz
         g9SkE50LysCGCKYYqzLl2+yM2yMbqmgdmLjCken4XaYbSNE2nUxvV9sqc0jh72YcZfNh
         3IoBhM0T+tUEznczdzMvDfWz/GZNcZYwY2lVmcglahVk6ry1Mr6Wj4fbWNRMZIRPqftr
         4x5LwoQwREszaNJg3hWgo95CETAOoCjJMNJg/96FeEoSe9VNsOGAS+G+aKF2TwzBWajC
         z8D0T/NCH6WxTGHLH2K2CavXlKHhuBqR7crNuvnbK5NsuHy1eLRmCXbT6gCqOM9qNzni
         NARw==
X-Gm-Message-State: AOJu0YxlFoj185oGIc3kXbL7B2SkUCW23PF24fStL6v6GBVvJQGObLXw
	CeaXQ059Bd89+9k2ptRjF6yGbhGQ7tMSLHNV/TRcOrBFxfiAre1kepxwrplK
X-Google-Smtp-Source: AGHT+IHvTmaHxhL1QH4tLx478bVVp1NhvjQKyeXBxuuwhnMn5MkflaFZixae96felph3ouN1woIpOw==
X-Received: by 2002:a25:830f:0:b0:dc6:ff32:aae2 with SMTP id s15-20020a25830f000000b00dc6ff32aae2mr740019ybk.63.1707876526415;
        Tue, 13 Feb 2024 18:08:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWul3cXbALI3eSgizH1yAmVHrzADpv+DRVvWbei0CXb3ArOd2reYl1UHGOzv7bjD6crRcO4aIr2IN57wF7KLSN9zJltejXsQ2cdGONrHWi4qyX/ziWrhS4vDz4KsW2DwxIj97lArOP7mWAAma3h8ZdvlxdLujYupQxcLapgZIemV0on3/8aXNEEF7TIuYb/73zMsdxHvimFQRU5ZBY0F9ogsiqpXWcfNNXuQTe4kWwQH9IGdqNqrQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:966f:7edc:e6e6:cd97])
        by smtp.gmail.com with ESMTPSA id s17-20020a258311000000b00dc2310abe8bsm1894752ybk.38.2024.02.13.18.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 18:08:46 -0800 (PST)
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
Subject: [RFC bpf-next v2 3/3] selftests/bpf: Test if shadow variables work.
Date: Tue, 13 Feb 2024 18:08:36 -0800
Message-Id: <20240214020836.1845354-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214020836.1845354-1-thinker.li@gmail.com>
References: <20240214020836.1845354-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Change the value of fields, including scalar types and function pointers,
and check if the struct_ops map works as expected.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c      |  6 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h      |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c      | 16 ++++++++++++----
 .../selftests/bpf/progs/struct_ops_module.c      |  8 ++++++++
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 66787e99ba1b..96fb0f44a390 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -539,6 +539,10 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
 {
+	if (member->offset == offsetof(struct bpf_testmod_ops, data) * 8) {
+		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
+		return 1;
+	}
 	return 0;
 }
 
@@ -559,7 +563,7 @@ static int bpf_dummy_reg(void *kdata)
 	 * initialized, so we need to check for NULL.
 	 */
 	if (ops->test_2)
-		ops->test_2(4, 3);
+		ops->test_2(4, ops->data);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index c3b0cf788f9f..428efd65cafd 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,7 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	int data;
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 8d833f0c7580..68d91b769ca0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -32,17 +32,20 @@ static void check_map_info(struct bpf_map_info *info)
 
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
+	bpf_program__set_autoload(skel->progs.test_2, false);
+
 	err = struct_ops_module__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_module_load"))
 		goto cleanup;
@@ -56,8 +59,13 @@ static void test_struct_ops_load(void)
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
+	ASSERT_EQ(skel->bss->test_2_result, 20, "test_2_result");
 
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


