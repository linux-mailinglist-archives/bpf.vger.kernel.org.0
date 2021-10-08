Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F744260E2
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhJHAFm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhJHAFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F591C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r2so1383034pgl.10
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JsHgFTBgeabAyJvdX4vYLSHhV4xO+AEFGqUJs0k0qac=;
        b=iLKGNZHtsvCGozdBCjyjLHHskOWkvuWGG0nHnvwdLZFV9Is1bMr9cTb1FEFKepBk7g
         upgwUvZE2R1KYrvvSrh1NKdncleMZXtcnNAhN06h2BKZzacNfKRilrd/2/al+Q5EwQBO
         ALQTm/y1tZRv3Qo5s5m3bohoF1VraBct4IOtoy+6q33w+SdrzLwlGhwTHEbwXgXmgDFy
         4U3xctwJ9LUUgriGWydDtXvisxEGYKk1bjUZdRKB0ut5Mtc/wEGHUDNdiRl7+OIN5Cge
         5D8e/15VEAYoA/W34EfXI8//40uAC3N641CAzXsss8Ir7/540SE7Cbyo52DsZOG55HuF
         +okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JsHgFTBgeabAyJvdX4vYLSHhV4xO+AEFGqUJs0k0qac=;
        b=php2BEqkRojbvhOkdIHHJwIWyzBIgOm/KSMqO4vVK6W/2zXY9P7o+jjGlO+pIS9Old
         idf+feP30Dxb7UUcNGDQRj72QmXaUrEb+dIWfmaET0DKp51VZt0uaKHOK9CKqMLdRMHj
         7S9nlXTcj4i/IXpy3RJXFAgwWmOovf5GNXIT0AUpPDaqr+wDvNtIU8MvZfEb/FgsOJW/
         1sc4q07FFSdTPFbgVdj9nAbubY9z8j6jGWZnL90ca4Xt/NyaOY3DUKIK+CdQzW0bn3IH
         RpxyUXQootizZG+vxe8d8m4WkCwuCc+q3Wlw+GsJQVSnfW2NLB0KKHcTKNkjMV5zlAYo
         FeGA==
X-Gm-Message-State: AOAM530XyUGCDv3QLKNBa0QjUUT89qdu5k50HJFisBoDrK6WInWXKhfr
        sZ5HJ9v1m9GxYeY2n9XZlTzsPJ3AtabfPg==
X-Google-Smtp-Source: ABdhPJwCwTUlHi0CcntJC1duVDBugquphFh7g7lnI9f/L9YyGYKpSK7SeCZX7UK/NKg/Z/mA9+aDpQ==
X-Received: by 2002:aa7:88d6:0:b0:44c:5c0b:c8a8 with SMTP id k22-20020aa788d6000000b0044c5c0bc8a8mr7202844pff.76.1633651426853;
        Thu, 07 Oct 2021 17:03:46 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id e6sm424746pgf.59.2021.10.07.17.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:46 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 08/10] selftests/bpf: demonstrate use of custom .rodata/.data sections
Date:   Thu,  7 Oct 2021 17:03:07 -0700
Message-Id: <20211008000309.43274-9-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Enhance existing selftests to demonstrate the use of custom
.data/.rodata sections.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/skeleton.c       | 25 +++++++++++++++++++
 .../selftests/bpf/progs/test_skeleton.c       | 10 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/testing/selftests/bpf/prog_tests/skeleton.c
index fe1e204a65c6..f2713eeac076 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -16,10 +16,13 @@ void test_skeleton(void)
 	struct test_skeleton* skel;
 	struct test_skeleton__bss *bss;
 	struct test_skeleton__data *data;
+	struct test_skeleton__data_dyn *data_dyn;
 	struct test_skeleton__rodata *rodata;
+	struct test_skeleton__rodata_dyn *rodata_dyn;
 	struct test_skeleton__kconfig *kcfg;
 	const void *elf_bytes;
 	size_t elf_bytes_sz = 0;
+	int i;
 
 	skel = test_skeleton__open();
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
@@ -30,7 +33,12 @@ void test_skeleton(void)
 
 	bss = skel->bss;
 	data = skel->data;
+	data_dyn = skel->data_dyn;
 	rodata = skel->rodata;
+	rodata_dyn = skel->rodata_dyn;
+
+	ASSERT_STREQ(bpf_map__name(skel->maps.rodata_dyn), ".rodata.dyn", "rodata_dyn_name");
+	ASSERT_STREQ(bpf_map__name(skel->maps.data_dyn), ".data.dyn", "data_dyn_name");
 
 	/* validate values are pre-initialized correctly */
 	CHECK(data->in1 != -1, "in1", "got %d != exp %d\n", data->in1, -1);
@@ -46,6 +54,12 @@ void test_skeleton(void)
 	CHECK(rodata->in.in6 != 0, "in6", "got %d != exp %d\n", rodata->in.in6, 0);
 	CHECK(bss->out6 != 0, "out6", "got %d != exp %d\n", bss->out6, 0);
 
+	ASSERT_EQ(rodata_dyn->in_dynarr_sz, 0, "in_dynarr_sz");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(rodata_dyn->in_dynarr[i], -(i + 1), "in_dynarr");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(data_dyn->out_dynarr[i], i + 1, "out_dynarr");
+
 	/* validate we can pre-setup global variables, even in .bss */
 	data->in1 = 10;
 	data->in2 = 11;
@@ -53,6 +67,10 @@ void test_skeleton(void)
 	bss->in4 = 13;
 	rodata->in.in6 = 14;
 
+	rodata_dyn->in_dynarr_sz = 4;
+	for (i = 0; i < 4; i++)
+		rodata_dyn->in_dynarr[i] = i + 10;
+
 	err = test_skeleton__load(skel);
 	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
 		goto cleanup;
@@ -64,6 +82,10 @@ void test_skeleton(void)
 	CHECK(bss->in4 != 13, "in4", "got %lld != exp %lld\n", bss->in4, 13LL);
 	CHECK(rodata->in.in6 != 14, "in6", "got %d != exp %d\n", rodata->in.in6, 14);
 
+	ASSERT_EQ(rodata_dyn->in_dynarr_sz, 4, "in_dynarr_sz");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(rodata_dyn->in_dynarr[i], i + 10, "in_dynarr");
+
 	/* now set new values and attach to get them into outX variables */
 	data->in1 = 1;
 	data->in2 = 2;
@@ -93,6 +115,9 @@ void test_skeleton(void)
 	CHECK(bss->kern_ver != kcfg->LINUX_KERNEL_VERSION, "ext2",
 	      "got %d != exp %d\n", bss->kern_ver, kcfg->LINUX_KERNEL_VERSION);
 
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(data_dyn->out_dynarr[i], i + 10, "out_dynarr");
+
 	elf_bytes = test_skeleton__elf_bytes(&elf_bytes_sz);
 	ASSERT_OK_PTR(elf_bytes, "elf_bytes");
 	ASSERT_GE(elf_bytes_sz, 0, "elf_bytes_sz");
diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
index 441fa1c552c8..47a7e76866c4 100644
--- a/tools/testing/selftests/bpf/progs/test_skeleton.c
+++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
@@ -40,9 +40,16 @@ int kern_ver = 0;
 
 struct s out5 = {};
 
+const volatile int in_dynarr_sz SEC(".rodata.dyn");
+const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
+
+int out_dynarr[4] SEC(".data.dyn") = { 1, 2, 3, 4 };
+
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
 {
+	int i;
+
 	out1 = in1;
 	out2 = in2;
 	out3 = in3;
@@ -53,6 +60,9 @@ int handler(const void *ctx)
 	bpf_syscall = CONFIG_BPF_SYSCALL;
 	kern_ver = LINUX_KERNEL_VERSION;
 
+	for (i = 0; i < in_dynarr_sz; i++)
+		out_dynarr[i] = in_dynarr[i];
+
 	return 0;
 }
 
-- 
2.30.2

