Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D64629B9
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhK3Bdb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbhK3Bdb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F3C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:13 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x30-20020a637c1e000000b00324ab629735so9389283pgc.17
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tIo4NQB2J6g4Hf4krhnrfGGhfKr0Xa56iI/vDDUeAes=;
        b=DNaqCXZP8B8MXG4PEHZeXsBTvQeMrY9vaWvfCSkSgjTm8GBdqdwRWiZvjq6TMMJh8A
         3qaxICZLOiu+g50Bbl3TEw7ucGyi41prne1qNGUfx75lm3j2F77sXmharSLyTJEcwtau
         a53YEU4roq+UDyi4lVphLFZhvNQIfUF1SRJhjTuFUXQlVm+lEj7Osvy3OHNqZeuoIwjl
         wFMnn8LieyN+q3DTC3dSInWgm7fJ8aVFgU6rPsEF5iOxNKQuqcMbBJHsF4cpPEpA2ofd
         dntYBDGpcEOZ+Idt97rgMnixTxG7cwG/fRqiArsi/YDeViWBAY7D9451L8H6JWAJOQRh
         5S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tIo4NQB2J6g4Hf4krhnrfGGhfKr0Xa56iI/vDDUeAes=;
        b=jOlNR/0lqihKn7hcU018gOTfrkpzFb66LRh+XhY3NzgSNeRJpnQfAEOy8iMOo45t2e
         uU6Hmc5rcCfTtL8845OGr2zfCFajQDXNsI2WNgruAqJ2jz49wiPR0ycqH7/NgT7UqNgL
         8cJJGyJg39vkXivaORQndkK7MN1i0R54YoJcPWOkxEKP4wdF3HjJElRA3/hHpnNVXEYb
         GlmJJe12pdBmPbIxTLVe/mCzkPMdwiTGxZ+hGVvEBE8eAp2Xxzzsady+T9uUFZ+xk5sB
         9mt/+puUbFVXzsJdnMVbzFpz8/DlfDWSXNmlPX+koAxMnzSWxdEvIY9KeIvl0E9FgZ/5
         Z1Kg==
X-Gm-Message-State: AOAM532q6J09xkIVO7EdQrEXHXXHgFnGbGsiyDiyY9IyrBNX/2/xuLKy
        3UOdtCPy1V1F5gvLE/8d58rkVzCykr4=
X-Google-Smtp-Source: ABdhPJwIvkaB2Fty1cJ8q967Bd8/XFgGEHDortfiP1AFvG3gyebbNY0V8QHabRnXlgri2k4Er97XHp0GDRg=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:a17:902:d4cf:b0:141:d36c:78f6 with SMTP id
 o15-20020a170902d4cf00b00141d36c78f6mr64989837plg.56.1638235812579; Mon, 29
 Nov 2021 17:30:12 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:48 -0800
In-Reply-To: <20211130012948.380602-1-haoluo@google.com>
Message-Id: <20211130012948.380602-10-haoluo@google.com>
Mime-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 9/9] bpf/selftests: Test PTR_TO_RDONLY_MEM
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test verifies that a ksym of non-struct can not be directly
updated.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 +++++++++
 .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index 79f6bd1e50d6..f6933b06daf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -8,6 +8,7 @@
 #include "test_ksyms_btf_null_check.skel.h"
 #include "test_ksyms_weak.skel.h"
 #include "test_ksyms_weak.lskel.h"
+#include "test_ksyms_btf_write_check.skel.h"
 
 static int duration;
 
@@ -137,6 +138,16 @@ static void test_weak_syms_lskel(void)
 	test_ksyms_weak_lskel__destroy(skel);
 }
 
+static void test_write_check(void)
+{
+	struct test_ksyms_btf_write_check *skel;
+
+	skel = test_ksyms_btf_write_check__open_and_load();
+	ASSERT_ERR_PTR(skel, "unexpected load of a prog writing to ksym memory\n");
+
+	test_ksyms_btf_write_check__destroy(skel);
+}
+
 void test_ksyms_btf(void)
 {
 	int percpu_datasec;
@@ -167,4 +178,7 @@ void test_ksyms_btf(void)
 
 	if (test__start_subtest("weak_ksyms_lskel"))
 		test_weak_syms_lskel();
+
+	if (test__start_subtest("write_check"))
+		test_write_check();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
new file mode 100644
index 000000000000..2180c41cd890
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+
+extern const int bpf_prog_active __ksym; /* int type global var. */
+
+SEC("raw_tp/sys_enter")
+int handler(const void *ctx)
+{
+	int *active;
+	__u32 cpu;
+
+	cpu = bpf_get_smp_processor_id();
+	active = (int *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
+	if (active) {
+		/* Kernel memory obtained from bpf_{per,this}_cpu_ptr
+		 * is read-only, should _not_ pass verification.
+		 */
+		/* WRITE_ONCE */
+		*(volatile int *)active = -1;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.0.384.gca35af8252-goog

