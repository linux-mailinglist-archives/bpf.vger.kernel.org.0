Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32ED486B7A
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbiAFUza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244011AbiAFUza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 15:55:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73CC061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 12:55:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b10-20020a251b0a000000b0060a7fbb7a64so7266064ybb.23
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PLwFzwVKyZlW3ZKQNxOkvPuZCJ9ocPN5UB5wn/16Lv0=;
        b=ED/KaK+5CblB/9GEsaq1HKe0k+rlCYrQlE2WCBtwxWJ9X7XTU+P3Ys8bpaWfNpW88U
         +Fmu6Cqo8BLasWnjTK9YMmPMhM0AlK7EVDTYgQxeF8nivKpsU+W0d5yFGp37eQXtwDOq
         5KvXbFDXVVovfu0WB8Ib6UFQWPA3GBn43SkVQE859NegypLTiEbp8ksgsB8kLcNxuqPJ
         Wair27WlrOHGaWyDuf4T92j9QoVhSZKW35IAQikPFC4s0CMbw9mINPjy6WjSpTM06GrM
         L+q3S0eY3QHPUf8RmKr5nQr7wkJ+G7j6VmmHZxz33g9xkVft8ugkSVcg3A8zw/k53JXs
         TODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PLwFzwVKyZlW3ZKQNxOkvPuZCJ9ocPN5UB5wn/16Lv0=;
        b=JW6FIL+oDDKmW+ZAxnfA2apNZB/IG3KN8bV2Ad1cTcFuy475xHOQlQiMECYLlsRABf
         5heyY073tbj7b1xg5wx19yrzgtGI07qpT8nP9oRShWa70tABe3+bPnJ5w8AYdQCmZTL+
         BJ8jKE+c5i4fTXGteQM3aanz2xYJkhWOiiTUP7Bxjn9sAFa2+7xnmGjM+N1RLkdDaMYU
         dUcX1jDBdFXCZ9on88pPbexc+/BaGTE+uncIHf82G+nbBO6o4Z3AfD4Lx1VTgy8GD4aq
         nx0Ag8+S1oDTvKOCYxDd7mLnTSMV4FPRJRg0ojUBqBWHP0dtXGYBsKUmrTi1nfQFHDS8
         qUJA==
X-Gm-Message-State: AOAM533BU6nhnbkKOEYjjjBZSyEZatRqU5pfFuV5XbqJTz1qIhKOTVWn
        nZzzFHT0YaaaFFesWHW0xYNxCvuCIeA=
X-Google-Smtp-Source: ABdhPJxw5gybO7P7b54vYJ3NooLiQDMv3W1J7QVjI9K/GOzSdyHDK9DXWz3AuKJcAR+3kA0ggQrV1JWlLqs=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:3a2:a76c:b77f:b671])
 (user=haoluo job=sendgmr) by 2002:a25:aa02:: with SMTP id s2mr67009543ybi.119.1641502529102;
 Thu, 06 Jan 2022 12:55:29 -0800 (PST)
Date:   Thu,  6 Jan 2022 12:55:25 -0800
Message-Id: <20220106205525.2116218-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH bpf-next v2] bpf/selftests: Test bpf_d_path on rdonly_mem.
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
memories. Rdonly_mem obtained from bpf_per_cpu_ptr() can not
be passed into bpf_d_path for modification. This patch adds
a selftest to verify this behavior.

Signed-off-by: Hao Luo <haoluo@google.com>
---
Changelog since v1:
 - remove duplicated vmlinux.h (Yonghong)
 - use 'void *' as type of 'active' (Andrii)
 - use codename instead of descriptive sentense in ASSERT_ERR_PTR's
   error message. (Andrii)

 .../testing/selftests/bpf/prog_tests/d_path.c | 22 ++++++++++++++-
 .../bpf/progs/test_d_path_check_rdonly_mem.c  | 28 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 0a577a248d34..42bf4272bb5e 100644
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
+	ASSERT_ERR_PTR(skel, "unexpected_load_overwriting_rdonly_mem\n");
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
index 000000000000..27c27cff6a3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
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
+	void *active;
+	__u32 cpu;
+
+	cpu = bpf_get_smp_processor_id();
+	active = (void *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
+	if (active) {
+		/* FAIL here! 'active' points to readonly memory. bpf helpers
+		 * that update its arguments can not write into it.
+		 */
+		bpf_d_path(path, active, sizeof(int));
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1.448.ga2b2bfdf31-goog

