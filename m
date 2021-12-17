Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84488478159
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhLQAcY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAcX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:32:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C5BC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w9-20020a25c709000000b00608a9489fc1so1404426ybe.20
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/MG5YQtsaSkmidXeOEiwWJdYKs4oaM9NPSp5uL3anXg=;
        b=rZETsL2y1AeSX3U4LQHhaNnCZfwF6NM4LgCpTzC5IdKALSqjuazNSBseO4T17B8Wku
         99Z9lp2Gt06SiYJ/d2N9QixRO+wieqHHnzJYcbH36LpKaAkQCAkidAeS8h5Lqii+1LJ+
         ITvSwapBSjs6dRiWQFLrFYrAyVG3QKbwB5XD1F+lQdqEUI/jxhEp2Sm1hSckx1Y1Fi3h
         ptIiXG9wE1nOC4iYpKawUXRg2+C/XuILNxRifhh2POnpxSPDA9Z0bGegClo05pMM/FQ1
         KEvGCAhAMgD3PnqlDFzY+HBjRFlQ4CvKVTGXs5xlamYgKNkgIaOCtAl2gNPxIknZFnqz
         RMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/MG5YQtsaSkmidXeOEiwWJdYKs4oaM9NPSp5uL3anXg=;
        b=IrU6xNQVm3/CIcmoIipw+aXsFQnvmofDzPlzaP3Nw3+iIjqHmYeGk0ZujetP+5bmi2
         RciF3eCU3O2xf8cMe9PkAjWHUDxrbENJcMC8D1pOH6hexObFDY34U+0nBrph4VWAD3dz
         K8G8Lx07JjCneRw+/5a7n6j2vVY2Knd3YMz35BqTRYnljlk0pF6KO2EYx3G9gaPPJ8b3
         Sporqt5IYqbrcmYYpul0cPyHQO8c8yjZlRxDHshLN8tLyAD7IZ4pQE7RvQcTEz/+pWBy
         EE7dfoPLswzji8uieRftBsCuGVj+O8e4eVLiwPrRFxV53LwpWUeHiRmAsUbsc8QSXx+3
         0bDA==
X-Gm-Message-State: AOAM530YK/CM9O+SLHgQEI3uAGShH++Mwi94UssNJIBIoGsYqv5Zbo6D
        T4X0sJvouyy56fcGniNZftfVNDK0Bg8=
X-Google-Smtp-Source: ABdhPJyh2hMJnT6HzIYGSmvVh+4XqOj7vkbFrUq3vYpgjmd9fOrqWqu0eY8h9F7Dsw44ur4ay/uFqftdHks=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9064:adcd:ab38:7d29])
 (user=haoluo job=sendgmr) by 2002:a25:1343:: with SMTP id 64mr885936ybt.574.1639701142675;
 Thu, 16 Dec 2021 16:32:22 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:31:52 -0800
In-Reply-To: <20211217003152.48334-1-haoluo@google.com>
Message-Id: <20211217003152.48334-10-haoluo@google.com>
Mime-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH bpf-next v2 9/9] bpf/selftests: Test PTR_TO_RDONLY_MEM
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
2.34.1.173.g76aa8bc2d0-goog

