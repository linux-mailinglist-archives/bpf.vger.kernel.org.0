Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3F46AE5F
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357504AbhLFX0T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358318AbhLFX0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC9C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:49 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so876353pjl.5
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DS9REKjwMQccvyyKCOSA2Wsg1MClasCUZcJZtt6eYk4=;
        b=C+5khPsRKM03DwWQ+5Rljxic3sJj2tOGyah77+UJ1iq9nP/k/D0RTkspyYAAgt8fwb
         9f1m1rFDBXYYv+Yb3ememiaQJ8d8o/Or3YTFPPwtIbPw6qt5h2lchpWcsdsRxqcSVAgj
         inKR7YYpDg1DBL8+HZvQITstCzYxCXnombaQBrVAMxLZRG//PZUXoLlWvAa5mqwKIio6
         H9mcNDlbVI+jQaFfyFpAMvsB3WHwPwGr/LLjPoCa30y2NdRY6PorhmwQPNi9SqS5rn+5
         DZSMCJLbAyvY1o4Gh+7i26wOx05VFiMe+4nkJQPO2RxbD/EcuXkqJT6+dRM7fqxXLR7p
         V9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DS9REKjwMQccvyyKCOSA2Wsg1MClasCUZcJZtt6eYk4=;
        b=t2bT6ft9PM6uV7AExcRIakEA7lc1Q9JUQcTEHNeR0+0Dl99Vx8p3kfNqmKNU873A1f
         bbivbvfzGsKLmi/aFxw53rvasOVyTIo60HnbgV1KjuqiB6iF3zXpo7rFOEkRRSiw4o0/
         4T0iK8KpEY3zERFdjlCfhwCzRm9ysXRG0gH6aJ3mtd7ZVyQyW2EV85O5VXRRPahM9VHV
         n6bW2Mz9LM3UcfAdRHeMOjhAY9cTehOws4967AEo2nrJen3IwRC2u40qmMV0C+Syoecy
         l0MPR6KoecZsD0+nrCV8WJBlBI46IctLIVFra2/CkmK4Xhur+LX1l7aHozASopSJ6c5h
         QtoQ==
X-Gm-Message-State: AOAM5309eMJ6oZCeY4AZyDC3D1pADQaIL+jNVdGeDdSCcRyws6eJGBTF
        FM/oHTnH80SCgfYX16b0XmXGnZgjPJs=
X-Google-Smtp-Source: ABdhPJw7FYhkklGSD7FHfx3Mv0KmR9OhiRkR01o4uazvB6QPL2sW9AfIBZB98jA/ltNb5JilCpomX3nMKt0=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a63:4a1a:: with SMTP id x26mr20936169pga.62.1638832969309;
 Mon, 06 Dec 2021 15:22:49 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:27 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-10-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 9/9] bpf/selftests: Test PTR_TO_RDONLY_MEM
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
2.34.1.400.ga245620fadb-goog

