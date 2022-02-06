Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02934AAF84
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiBFNl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 08:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbiBFNl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 08:41:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71163C06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 05:41:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so2805787pja.3
        for <bpf@vger.kernel.org>; Sun, 06 Feb 2022 05:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VC8SYIAd4q7Hmh+VRltIAWKqtVfFsTW1HXHhsOD2AY8=;
        b=n2cZ+Lg3XJ1lrx3lwWeGTMERMLBiuPerhqGrba0JLOlukvhaUgPLVS2dz8FfJ6ez4n
         jm8pk8Eh7UNvqESQObBPxTefW4ioDfZUOcGe+nj8P8UOmLC2nlWsEsqycyonMcSFSUY2
         lDI8O1PSBfYtezxI0YN4dIe83VxQriYFQDGKv+el7loF6YtBQfMfeBUon9jGaDDeT9JQ
         4veH/iS/vFTWj8nIQ2jENsiPo2tyICbczIxfrrbfOQXcW7e+vCNs6JnGf0pY99pmvjLs
         47LE/KlbV0GGL7bnqIxdQBSbEtg3jjwGMMBOIT6l0tHTm5nG5L77W5jy0GhcshR+ZTTO
         iltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VC8SYIAd4q7Hmh+VRltIAWKqtVfFsTW1HXHhsOD2AY8=;
        b=hL6oZ+Fdl2MZQbORzCgVBxQUYhPMh/ErFdYfkmFYZ5AlHu+NULcZli1F1/0fnJCrDw
         8JLQUXLP9RtTUhv72gzV2OxjmLnySL95BOf5pODNk8gGCsYP7cPS5bKqEe+giIU8SlZN
         +KsV5wpkBYRetDTRuNZnJYBtv9w05z7/RhgP1Ll2RjClEWB3yjuG7EX+qKw8HSjy2VHx
         +OTI1xs9BhWt4W2Wd3Gl8LAoyUDG8xeZpU4QyJhPk6mry9ZYdfpJ/s4KshZ3BQ7/C8O0
         z+hg3l3j9xQ+x0bJMc7FPytUCfelQaePL9h1M3kVEoEJjVFdu7mBynmhMt8KUZlUIc8P
         0/Qw==
X-Gm-Message-State: AOAM5311EC2vO8/kevitOAjPbCG68QYIuFxfzSLFaKTuwZx2U9QINF48
        SOL+G/6u42R51iU1cvAJscdr28vcjFCOYZKu
X-Google-Smtp-Source: ABdhPJx+7+zZXbCSSS9RIdRRlAfnZYTAUjGXKmA9ONocQ+m2NIeNdu/kA/uNGCP5pchjEpBgiaRhRA==
X-Received: by 2002:a17:902:b692:: with SMTP id c18mr12500854pls.85.1644154884848;
        Sun, 06 Feb 2022 05:41:24 -0800 (PST)
Received: from chenhengqi-X1.. ([113.64.186.12])
        by smtp.gmail.com with ESMTPSA id e17sm8500982pfv.101.2022.02.06.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:41:24 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test BPF_KPROBE_SYSCALL macro
Date:   Sun,  6 Feb 2022 21:40:51 +0800
Message-Id: <20220206134051.721574-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206134051.721574-1-hengqi.chen@gmail.com>
References: <20220206134051.721574-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests for the newly added BPF_KPROBE_SYSCALL macro.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../selftests/bpf/prog_tests/kprobe_syscall.c | 37 +++++++++++++++++++
 .../selftests/bpf/progs/test_kprobe_syscall.c | 34 +++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kprobe_syscall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
new file mode 100644
index 000000000000..0ac89c987024
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Hengqi Chen */
+
+#include <test_progs.h>
+#include <sys/prctl.h>
+#include "test_kprobe_syscall.skel.h"
+
+void test_kprobe_syscall(void)
+{
+	struct test_kprobe_syscall *skel;
+	int err;
+
+	skel = test_kprobe_syscall__open();
+	if (!ASSERT_OK_PTR(skel, "test_kprobe_syscall__open"))
+		return;
+
+	skel->rodata->my_pid = getpid();
+
+	err = test_kprobe_syscall__load(skel);
+	if (!ASSERT_OK(err, "test_kprobe_syscall__load"))
+		goto cleanup;
+
+	err = test_kprobe_syscall__attach(skel);
+	if (!ASSERT_OK(err, "test_kprobe_syscall__attach"))
+		goto cleanup;
+
+	prctl(1, 2, 3, 4, 5);
+
+	ASSERT_EQ(skel->bss->option, 1, "BPF_KPROBE_SYSCALL failed");
+	ASSERT_EQ(skel->bss->arg2, 2, "BPF_KPROBE_SYSCALL failed");
+	ASSERT_EQ(skel->bss->arg3, 3, "BPF_KPROBE_SYSCALL failed");
+	ASSERT_EQ(skel->bss->arg4, 4, "BPF_KPROBE_SYSCALL failed");
+	ASSERT_EQ(skel->bss->arg5, 5, "BPF_KPROBE_SYSCALL failed");
+
+cleanup:
+	test_kprobe_syscall__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
new file mode 100644
index 000000000000..abd59c3d5b59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+const volatile pid_t my_pid = 0;
+int option = 0;
+unsigned long arg2 = 0;
+unsigned long arg3 = 0;
+unsigned long arg4 = 0;
+unsigned long arg5 = 0;
+
+SEC("kprobe/" SYS_PREFIX "sys_prctl")
+int BPF_KPROBE_SYSCALL(prctl_enter, int opt, unsigned long a2,
+		       unsigned long a3, unsigned long a4, unsigned long a5)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	option = opt;
+	arg2 = a2;
+	arg3 = a3;
+	arg4 = a4;
+	arg5 = a5;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
--
2.30.2
