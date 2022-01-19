Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9BC493AE9
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354629AbiASNN6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 08:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354705AbiASNN4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 08:13:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF21C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:13:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n8so2136533plc.3
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmaBEaX++UIWHIh/lxN/0DDC/EtFdzvemvkG1wwj2XM=;
        b=nwfjwgw6RRjbpG47cS8Jk62H8Qx+pWgJYpUiQUewlUqr+cRIxUfENOmuWRvjlOilJW
         7FA/rXYCs7w70HHhDDgFK62q9eNvGNNeor/Cyv+ZDVVDncbjuGKerm6gZz5270Bgs1EY
         j2JkQEUvmsL+ejHhubW3bbjJg5aQZ7W2/fMu/k5yOK+zj5akPLxcfSfoT3UMR51OQUz1
         dt9g3uiJf6APBkNlkTBbYZa7PagZLkTj/mdbd3AZ0v8QCMvwAvTKOitHBAaWWrNVwE0d
         AXUlZZedHys2nmlxAu2C2GFIUZHQ+56vn8+Ot4anjpe3CPJvbEbhbL1/jQCwxkjRHobt
         ErDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cmaBEaX++UIWHIh/lxN/0DDC/EtFdzvemvkG1wwj2XM=;
        b=snuEhVFKrdBOdxYHJmfGE4GeJljmsFlt89ekUu3mIUEvkhtHY4cXCcF9dLAmN/lek0
         vp7f9S5EjX8MhwuRdlGsNsxJGieM6ggvzzTvFDXegdP5X1DdkEOTVORZxZEQqSq89SgN
         BtlzwbbPNAR9ntnZ2EFssZvtWdL5Idx5K1eBw31KuHZcVPgVt+2UMrh3TDAx01vBm9MN
         rQYI6Za7WthOeR/zqY+utMgbOSqTls3puhih7vWG0c0EM5pLCr/sT5lct4ubrNYSZwZA
         XhR0izUWgesnaigw/xTu28kma3XTKSl083R1UvkC4FwoTvwiWEP6l+eubfmKkFTr8bwJ
         JGmw==
X-Gm-Message-State: AOAM530S+ZCDVMUdtP4l0cRj5H8mLAIPHYQra0aoz05KOvXFbK0F8Kim
        5ms7nJUsCAWmPzegalcgWlg=
X-Google-Smtp-Source: ABdhPJwPUgcShAmDFppI6xbiI4vh35EDF/qG4Ko+0eJOazBBUd91osfY/5NLHuXLJZ6b98Vn+qYtsQ==
X-Received: by 2002:a17:902:7fc8:b0:14a:e403:2f18 with SMTP id t8-20020a1709027fc800b0014ae4032f18mr6461468plb.45.1642598035600;
        Wed, 19 Jan 2022 05:13:55 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. (fpa446d38e.knge002.ap.nuro.jp. [164.70.211.142])
        by smtp.gmail.com with ESMTPSA id v13sm3603208pjd.13.2022.01.19.05.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:13:55 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v4 3/3] libbpf: Add a test to confirm PT_REGS_PARM4_SYSCALL
Date:   Wed, 19 Jan 2022 22:12:09 +0900
Message-Id: <20220119131209.36092-4-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119131209.36092-1-Kenta.Tada@sony.com>
References: <20220119131209.36092-1-Kenta.Tada@sony.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest to verify the behavior of PT_REGS_xxx.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 .../bpf/prog_tests/test_bpf_syscall_macro.c   | 49 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_syscall_macro.c   | 51 +++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
new file mode 100644
index 000000000000..2f725393195b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022 Sony Group Corporation */
+#include <sys/prctl.h>
+#include <test_progs.h>
+#include "bpf_syscall_macro.skel.h"
+
+//void serial_bpf_syscall_macro(void)
+void test_bpf_syscall_macro(void)
+{
+	struct bpf_syscall_macro *skel = NULL;
+	int err;
+	int exp_arg1 = 1001;
+	unsigned long exp_arg2 = 12;
+	unsigned long exp_arg3 = 13;
+	unsigned long exp_arg4 = 14;
+	unsigned long exp_arg5 = 15;
+
+	/* check whether it can open program */
+	skel = bpf_syscall_macro__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_syscall_macro__open"))
+		return;
+
+	skel->rodata->filter_pid = getpid();
+
+	/* check whether it can load program */
+	err = bpf_syscall_macro__load(skel);
+	if (!ASSERT_OK(err, "bpf_syscall_macro__load"))
+		goto cleanup;
+
+	/* check whether it can attach kprobe */
+	err = bpf_syscall_macro__attach(skel);
+	if (!ASSERT_OK(err, "bpf_syscall_macro__attach"))
+		goto cleanup;
+
+	/* check whether args of syscall are copied correctly */
+	prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
+	ASSERT_EQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
+	ASSERT_EQ(skel->bss->arg2, exp_arg2, "syscall_arg2");
+	ASSERT_EQ(skel->bss->arg3, exp_arg3, "syscall_arg3");
+	/* it cannot copy arg4 when uses PT_REGS_PARM4 on x86_64 */
+#ifdef __x86_64__
+	ASSERT_NEQ(skel->bss->arg4_cx, exp_arg4, "syscall_arg4_from_cx");
+#endif
+	ASSERT_EQ(skel->bss->arg4, exp_arg4, "syscall_arg4");
+	ASSERT_EQ(skel->bss->arg5, exp_arg5, "syscall_arg5");
+
+cleanup:
+	bpf_syscall_macro__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
new file mode 100644
index 000000000000..5a7063de27c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022 Sony Group Corporation */
+#include <linux/bpf.h>
+#include <linux/ptrace.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+int arg1 = 0;
+unsigned long arg2 = 0;
+unsigned long arg3 = 0;
+unsigned long arg4_cx = 0;
+unsigned long arg4 = 0;
+unsigned long arg5 = 0;
+
+const volatile pid_t filter_pid = 0;
+
+SEC("kprobe/" SYS_PREFIX "sys_prctl")
+int BPF_KPROBE(handle_sys_prctl)
+{
+	struct pt_regs *real_regs;
+	int orig_arg1;
+	unsigned long orig_arg2, orig_arg3, orig_arg4_cx, orig_arg4, orig_arg5;
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != filter_pid)
+		return 0;
+
+	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
+	bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1), &PT_REGS_PARM1_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg4_cx, sizeof(orig_arg4_cx), &PT_REGS_PARM4(real_regs));
+	bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4), &PT_REGS_PARM4_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5), &PT_REGS_PARM5_SYSCALL(real_regs));
+
+	/* copy all actual args and the wrong arg4 on x86_64 */
+	arg1 = orig_arg1;
+	arg2 = orig_arg2;
+	arg3 = orig_arg3;
+	arg4_cx = orig_arg4_cx;
+	arg4 = orig_arg4;
+	arg5 = orig_arg5;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.32.0

