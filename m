Return-Path: <bpf+bounces-27016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88508A79D4
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 02:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6161C22435
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 00:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09863B8;
	Wed, 17 Apr 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuUNoCnP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BB524F
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313521; cv=none; b=mgvP0sG66nxDx2f3vHT03Ci7qievLH57LzBOyFR6ciQiH1JjA6IesmKombuHuiNo/ajZnQce06zV0cCIoXGaem56fH/mke9olrPMpkN0K9VcwlSHC4SyheHXhK/ovMo09x7ljVY9fK4JynEHiSMDB2N5L2nyKhyqTLNCoRmYUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313521; c=relaxed/simple;
	bh=y1t/beTI9nc6z/yEvptNoAHKaz3hYUX2fmRYnplM8Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCZTzojQ9bYWQb2UCceHvxdJjAvQV2rc88g2GGe4l6YDBJCU1SMIMxOa5Wd8Iy44tqM6yIV0pEcMjqGDWR92KXZqz/x7tbUyrWN1FO+cLGCB0SK+N2YwF0+3eE4PtEbd8nUrZb0qAZpjapb1lnL3V6Ng06XfFBpDTJUYJUc61/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuUNoCnP; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61af74a010aso10911637b3.0
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 17:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713313519; x=1713918319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K6bypWbsyWY0taJNvZ0WSjYUDnqITNJfk3zzp7+6yM=;
        b=SuUNoCnP3oaQuPrcx9+kKBV7PzlA3z1wnUzfgwHACFVlU/kB9YCrFfi2tlj62/G0/d
         tEF/2TWyoqRFOSZtUwB7aZmKApsIZMptQVL71eD3oBW4ZeSlxacJJCvLZmPLMLfyP32P
         H/VGMPm6ZUuJK+dIYwPJGz0tMhZg14Z5p/J96GjX4xH/n2mokHNgfvNYPm56emDLXTLu
         RLkM/oIF+s+XEHevLyJaY0QpLAzVRD0p5ZbtFyB8um6PVeL+X5JuXhe2bhslGCEyb6Jj
         05cTmQNcRFXTaQGsjEiecyR/izKfQbulW2Sja99UALEv0w3UV+plwyQ3Y4H0/JlBox1t
         te9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313519; x=1713918319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K6bypWbsyWY0taJNvZ0WSjYUDnqITNJfk3zzp7+6yM=;
        b=n7GzUABTxlrSKlX0EFmDdrPCWFoQr6d6MdqZlftlx/LKmNj0kCtybr6nF8RHB+YqLj
         K93X6KCNmUe8okJ3+FJD26bVYJk54d6e724lYXSDVl9gpkD3hyE/cXYgKA3chaUOcaUI
         PQHe53BWPVFdNmyyqWwbz++8wjcWAB3enZyB2ce0ECGyhYYtlpj6a57JgrwJzHesZt/B
         jWA6Fyay7f1NaoDv63fcyqx0/ke2twb/ApHDt//mHEVe8Y/+K4XxIJWeE5s3qq0cx4CJ
         wq1eT+AckgcACiFCFB+FEWaxZTKCQrB1INjn9azVcxhfifOmaArPqWwq63xSGenw/5i7
         LjnQ==
X-Gm-Message-State: AOJu0Yx90VdrfEmeEiiYcx9DEGPhdgNM0L+PS+tXic3W2dua1e+oRbEY
	Zb3Iy1s8JQGUG+eveKkum3cjnhDGwATur7BrgOXleQvJuY9SMBn0snJ/sg==
X-Google-Smtp-Source: AGHT+IHPWrX6WVU3liocqamfkB7zAr17Ix2KEHs6V2DB2j9B584c57KI83CfKOt4zmMV3k6iJQ1cQA==
X-Received: by 2002:a0d:cc4d:0:b0:61a:ee20:25ee with SMTP id o74-20020a0dcc4d000000b0061aee2025eemr3611687ywd.22.1713313518927;
        Tue, 16 Apr 2024 17:25:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2bf6:8300:76f:3cae])
        by smtp.gmail.com with ESMTPSA id z79-20020a814c52000000b00617e3ac0deesm2792555ywa.86.2024.04.16.17.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 17:25:18 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: open a pinned path of a struct_ops link.
Date: Tue, 16 Apr 2024 17:25:13 -0700
Message-Id: <20240417002513.1534535-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417002513.1534535-1-thinker.li@gmail.com>
References: <20240417002513.1534535-1-thinker.li@gmail.com>
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


