Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78CF47B439
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 21:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhLTUMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 15:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhLTUMM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Dec 2021 15:12:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A997C061574
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 12:12:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d205-20020a251dd6000000b0060977416ad4so11936922ybd.16
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 12:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zpZAza14ZqwHFX6vwrTuTSnx+yfWppSvPZqQtLA/NXo=;
        b=adYK6r6OJ0m9jiqdbUK+qZioYfBG8Y9RZ2/MhuY2ji+lXqh6GfpyNqVkZdMejHkijW
         wvb7UiEuOmbDox1uYOcZ2yRr60Rs5fJw9YHKkLk7ImtC28OxaMYG/uPf1dZ7vW8AcT00
         VH3oJ5/aPH2+bd4aiOsm7gVXZNAJx+v/AQ5nPp5ErzlOCwbImYxYV/eYXMOX0lJWSH4v
         2B0hZeNLCOOuCmOwMkt9j2GmooXQuDE8bdWNpnut5GFWDkHfMEFpHhy5HjtljyVA8C9j
         fXtgfnjVEV8bYdJ6d4gURFNw76INjg5sZnG4qKwdf9H1dYYzrMV3TF4mKP9IjNmdHUrP
         6Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zpZAza14ZqwHFX6vwrTuTSnx+yfWppSvPZqQtLA/NXo=;
        b=UXpKvYzeALlGQJK/aICOwhvxjiHwiyU1+E+CpAgX2MKES350A7ytx6gbl8D6/gVlLV
         Nzm+/BLyyWrUM3vttzUXgvwJgpbINxhVPt1UWN44fN9aiDoDvwg2b87febzqJZNHRiXl
         NRtzY57HJvEsPIAn7Ady6WTpnS2XyWFwuSrlU64lVbAigD5Pf8DnvByIMCkRFdtAUwrV
         A2iJg1m7hq9qk8KN6a4+puztHzkYaRSrfu5hr9g08Bxe6xKOexIq5t3oRFRrS9EyB6b1
         qjrgXh29kYl9+YOi9aMpr9NnTH8a66G8MbXxXT6S0VfE4cakrGz01UvjMOkhSmXD6e8N
         9+FA==
X-Gm-Message-State: AOAM531q4QFRKpFQY//k79AgqNhHEtSUIYzJoNZPo0jgXT33zQ/QLYyq
        5AubAp7TqGpvjCJheTe/7xTjCEGW8nE=
X-Google-Smtp-Source: ABdhPJwe/3pyxCROOwNJ4ciTTq/yJw4nOBGAzfCKEFadM0MYpXkKtxgB+pCR6dMQaoU+pqRB+aMvA3agSJI=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:26af:d2de:8de6:dfc9])
 (user=haoluo job=sendgmr) by 2002:a25:d186:: with SMTP id i128mr10919103ybg.602.1640031131846;
 Mon, 20 Dec 2021 12:12:11 -0800 (PST)
Date:   Mon, 20 Dec 2021 12:12:04 -0800
Message-Id: <20211220201204.653248-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH bpf-next] bpf/selftests: Test bpf_d_path on rdonly_mem.
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

The second parameter of bpf_d_path() can only accept writable
memories. rdonly_mem obtained from bpf_per_cpu_ptr() can not
be passed into bpf_d_path for modification. This patch adds
a selftest to verify this behavior.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 22 +++++++++++++-
 .../bpf/progs/test_d_path_check_rdonly_mem.c  | 30 +++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 0a577a248d34..f8d8c5a5dfba 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -9,6 +9,7 @@
 #define MAX_FILES		7
 
 #include "test_d_path.skel.h"
+#include "test_d_path_check_rdonly_mem.skel.h"
 
 static int duration;
 
@@ -99,7 +100,7 @@ static int trigger_fstat_events(pid_t pid)
 	return ret;
 }
 
-void test_d_path(void)
+static void test_d_path_basic(void)
 {
 	struct test_d_path__bss *bss;
 	struct test_d_path *skel;
@@ -155,3 +156,22 @@ void test_d_path(void)
 cleanup:
 	test_d_path__destroy(skel);
 }
+
+static void test_d_path_check_rdonly_mem(void)
+{
+	struct test_d_path_check_rdonly_mem *skel;
+
+	skel = test_d_path_check_rdonly_mem__open_and_load();
+	ASSERT_ERR_PTR(skel, "unexpected load of a prog using d_path to write rdonly_mem\n");
+
+	test_d_path_check_rdonly_mem__destroy(skel);
+}
+
+void test_d_path(void)
+{
+	if (test__start_subtest("basic"))
+		test_d_path_basic();
+
+	if (test__start_subtest("check_rdonly_mem"))
+		test_d_path_check_rdonly_mem();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
new file mode 100644
index 000000000000..c7a9655d5850
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Google */
+
+#include "vmlinux.h"
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+extern const int bpf_prog_active __ksym;
+
+SEC("fentry/security_inode_getattr")
+int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
+	     __u32 request_mask, unsigned int query_flags)
+{
+	char *active;
+	__u32 cpu;
+
+	cpu = bpf_get_smp_processor_id();
+	active = (char *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
+	if (active) {
+		/* FAIL here! 'active' is a rdonly_mem. bpf helpers that
+		 * update its arguments can not write into it.
+		 */
+		bpf_d_path(path, active, sizeof(int));
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1.307.g9b7440fafd-goog

