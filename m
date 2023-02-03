Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3D688DDF
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 04:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBCDS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 22:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjBCDS4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 22:18:56 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B2C530DC;
        Thu,  2 Feb 2023 19:18:46 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id n13so3969771plf.11;
        Thu, 02 Feb 2023 19:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoGM7XRz0NZ0b6mw+q1l4grA9yKTex8169ZS160dcgc=;
        b=LAYoO2jHuYh9BSeeauAsVBpKHu3MDRm6RHxQMurlHAQknWS6gvHda8E9DnSvxHbqZ5
         kR2HddgphBX7H8unFVpIRIYHhvscbjlLVZRTmZEsw+CTJbyQjnxGFVdVxxu/MqHcMxte
         pPGbeSjP39vX0dlIBIivxysmr0xdXFrLtLPLxQgvvRIZT96iZgiflgG7ao3nGzu8xszE
         z/mTipwcKnLswdz9LN+39Q8Qrvq8EUVForGIX8vYyeNDAl8r9O7PCh7R0zKD20peFV7A
         dkEd9rjpXr/M+1hPJKTKncrdcxA33vzKuDsGtJWQY6MJgKgEFQxLh/H7vx1GwrneZzQ4
         CnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoGM7XRz0NZ0b6mw+q1l4grA9yKTex8169ZS160dcgc=;
        b=iPqz/RmfoeOHHINvnmqLNtRXz9zOlWFd5Yy4l8N6oYcKFrW78oRj3rKMpAhl3o/I+w
         DfTN8EAU3DEkfbfOdKVDJpDLTV/CWmKfwNo+XnlB0ANUeXFifAKp/kY6zTAsvabGx5Xu
         aI/LoksNFUz0Vp7To8XRJDw3J+AUuLJPzHxtM037IkIoG9UdcXXCHrh8ept+cALw9tJ9
         /Ylp3I4Ejhi0sHIAALNfqkppoXJw+E7hrMUaKi8pG0O1D+UNnb8Y6+IVy6Z6P1uai8px
         MPGI0mVv5twgwQFL41W0SUNrb49QraTo2RUT6tFxWD4AtuiN0NqHRAIDag8i5Qp+y731
         1C9g==
X-Gm-Message-State: AO0yUKXGxVNdtd+OiEdo0IRWSemcXyiZAPoRvFn3MqdgEllXOqddUtdj
        tbQelr9TuETs56GtEeuUsd4=
X-Google-Smtp-Source: AK7set+fh9niTzV6bNDk2mIMsd5eSjfHj1yS6Gdv/GTiSy5CKm/sFxd6l/89OtbIJEajFZp+tG36Cg==
X-Received: by 2002:a17:902:e888:b0:196:2949:3ca7 with SMTP id w8-20020a170902e88800b0019629493ca7mr10454960plg.7.1675394325544;
        Thu, 02 Feb 2023 19:18:45 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001899c2a0ae0sm416009pld.40.2023.02.02.19.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 19:18:45 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode
Date:   Fri,  3 Feb 2023 11:17:42 +0800
Message-Id: <20230203031742.1730761-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203031742.1730761-1-imagedong@tencent.com>
References: <20230203031742.1730761-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

Add the testing for kprobe/uprobe attaching in legacy and perf mode.
And the testing passed:

./test_progs -t attach_probe
$5       attach_probe:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9566d9d2f6ee..5f6212ac0b6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -23,15 +23,22 @@ static noinline void trigger_func3(void)
 	asm volatile ("");
 }
 
+/* attach point for legacy uprobe */
+static noinline void trigger_func4(void)
+{
+	asm volatile ("");
+}
+
 static char test_data[] = "test_data";
 
 void test_attach_probe(void)
 {
+	ssize_t uprobe_offset, uprobe4_offset, ref_ctr_offset;
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
 	struct bpf_link *kprobe_link, *kretprobe_link;
 	struct bpf_link *uprobe_link, *uretprobe_link;
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
 	struct test_attach_probe* skel;
-	ssize_t uprobe_offset, ref_ctr_offset;
 	struct bpf_link *uprobe_err_link;
 	bool legacy;
 	char *mem;
@@ -86,6 +93,25 @@ void test_attach_probe(void)
 		goto cleanup;
 	skel->links.handle_kretprobe = kretprobe_link;
 
+	/* manual-attach kprobe in legacy mode */
+	opts.retprobe = false;
+	opts.mode = PROBE_MODE_LEGACY;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe_legacy,
+						      SYS_NANOSLEEP_KPROBE_NAME,
+						      &opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_legacy"))
+		goto cleanup;
+	skel->links.handle_kprobe_legacy = kprobe_link;
+
+	/* manual-attach kprobe in perf mode */
+	opts.mode = PROBE_MODE_PERF;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe_perf,
+						      SYS_NANOSLEEP_KPROBE_NAME,
+						      &opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_perf"))
+		goto cleanup;
+	skel->links.handle_kprobe_perf = kprobe_link;
+
 	/* auto-attachable kprobe and kretprobe */
 	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
 	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
@@ -110,6 +136,32 @@ void test_attach_probe(void)
 	if (!legacy)
 		ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
 
+	uprobe4_offset = get_uprobe_offset(&trigger_func4);
+	if (!ASSERT_GE(uprobe4_offset, 0, "uprobe4_offset"))
+		goto cleanup;
+
+	uprobe_opts.mode = PROBE_MODE_LEGACY;
+	uprobe_opts.ref_ctr_offset = 0;
+	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_legacy,
+						      0 /* self pid */,
+						      "/proc/self/exe",
+						      uprobe4_offset,
+						      &uprobe_opts);
+	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe_legacy"))
+		goto cleanup;
+	skel->links.handle_uprobe_legacy = uprobe_link;
+
+	uprobe_opts.mode = PROBE_MODE_PERF;
+	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
+	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_perf,
+						      0 /* self pid */,
+						      "/proc/self/exe",
+						      uprobe_offset,
+						      &uprobe_opts);
+	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe_perf"))
+		goto cleanup;
+	skel->links.handle_uprobe_perf = uprobe_link;
+
 	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
 	uprobe_opts.retprobe = true;
 	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
@@ -207,11 +259,18 @@ void test_attach_probe(void)
 	/* trigger & validate sleepable uprobe attached by name */
 	trigger_func3();
 
+	/* trigger & validate uprobe in legacy mode */
+	trigger_func4();
+
 	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
 	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
+	ASSERT_EQ(skel->bss->kprobe3_res, 3, "check_kprobe_legacy_res");
+	ASSERT_EQ(skel->bss->kprobe4_res, 4, "check_kprobe_perf_res");
 	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
 	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
 	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
+	ASSERT_EQ(skel->bss->uprobe2_res, 4, "check_uprobe_legacy_res");
+	ASSERT_EQ(skel->bss->uprobe3_res, 5, "check_uprobe_perf_res");
 	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
 	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
 	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res");
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index a1e45fec8938..6674deea5686 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -9,9 +9,13 @@
 
 int kprobe_res = 0;
 int kprobe2_res = 0;
+int kprobe3_res = 0;
+int kprobe4_res = 0;
 int kretprobe_res = 0;
 int kretprobe2_res = 0;
 int uprobe_res = 0;
+int uprobe2_res = 0;
+int uprobe3_res = 0;
 int uretprobe_res = 0;
 int uprobe_byname_res = 0;
 int uretprobe_byname_res = 0;
@@ -30,6 +34,20 @@ int handle_kprobe(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("kprobe")
+int handle_kprobe_legacy(struct pt_regs *ctx)
+{
+	kprobe3_res = 3;
+	return 0;
+}
+
+SEC("kprobe")
+int handle_kprobe_perf(struct pt_regs *ctx)
+{
+	kprobe4_res = 4;
+	return 0;
+}
+
 SEC("ksyscall/nanosleep")
 int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __kernel_timespec *rem)
 {
@@ -69,6 +87,20 @@ int handle_uprobe(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("uprobe")
+int handle_uprobe_legacy(struct pt_regs *ctx)
+{
+	uprobe2_res = 4;
+	return 0;
+}
+
+SEC("uprobe")
+int handle_uprobe_perf(struct pt_regs *ctx)
+{
+	uprobe3_res = 5;
+	return 0;
+}
+
 SEC("uretprobe")
 int handle_uretprobe(struct pt_regs *ctx)
 {
-- 
2.39.0

