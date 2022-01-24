Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B64E4981EF
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiAXOUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 09:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiAXOUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 09:20:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A94C06173B
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:20:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l16so16629941pjl.4
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87p3l3fxuGIq9G+G6eKvm0G/7xNycGNVbKaNr8vrvmY=;
        b=AYK6Ml4bcyxBZ6NR1VRZMiuIhOXbJOCkdhZfgVo0QNOnr/V7s7fcyVhrBh0F369MWw
         sZVvB4y/tvF9geTBsz8ydp5YuoAXTS56/eVylcGvQvj0Faj6AyHyvgbJclg4hCGpXUOf
         b+FYoXj06t6CFUF7Fz0OSM1kNmuqLMohMBUMn6U1FRo6S6is5/N9j5ObDon+n2PMcnPm
         I4+yAfOLvvZTkxLAmSO6TwNEme5PFICrw+vxkkFzJaw25i1+b7iuSAi3RewLZhtvFOJI
         GoXZFAz70RNNwxvXvGTxBylSN0a93qfpszqYMzmMggiR0UWcvvtkh10zG2WDYBHEocA2
         Hftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=87p3l3fxuGIq9G+G6eKvm0G/7xNycGNVbKaNr8vrvmY=;
        b=VqzxTIWZ3e9PmNi6jCW5me04pECxe55+bYhqC7ztr7oQEj5n0WAJhDZ3wk/0Xy2Q5Q
         G3L8f1tDXUbGl80KImGdFPHYx+gSt0DCkTxbyM06gfU/WY/Mt+PoJRaFT/jzQpOeaWkH
         Hbf/osL30nXppN6XsdJgDOW1gFaLz+FNuX6cBbIpgfDpbBPf8FyvUSPB9aj61LR11NWM
         31XMsKXYA503aVdU9uR0YTR4ZmhiA+sMd1OR0KMNz1oCbGDqU7PdJRUIXgO3sVYlsn0U
         yBQce2QT837hdsgjiweRA6e+2AXw9u5i6CpkDDvHlsIwydXii5UJibG87riyE7YMlYMI
         NlVQ==
X-Gm-Message-State: AOAM530Etzu4bgleOUeP7F9BGmVLsUg5BrrZLNkoLexas2py+FXaJfW3
        3OjR5BsMPEwwch8kl003xn8=
X-Google-Smtp-Source: ABdhPJwMbIxwd8ugqJstFYUmTvfl1cu//h1u2oOHc52naa2GSQG91otmsGwe4xMwegHZXegwRd/SHg==
X-Received: by 2002:a17:903:1c8:b0:14b:6b63:b3fa with SMTP id e8-20020a17090301c800b0014b6b63b3famr492633plh.156.1643034003351;
        Mon, 24 Jan 2022 06:20:03 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. ([240d:1a:2e0:8a00:d1c2:4b2a:8ba8:7b43])
        by smtp.gmail.com with ESMTPSA id 13sm15629855pfm.161.2022.01.24.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 06:20:03 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v5 3/3] libbpf: Add a test to confirm PT_REGS_PARM4_SYSCALL
Date:   Mon, 24 Jan 2022 23:16:22 +0900
Message-Id: <20220124141622.4378-4-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141622.4378-1-Kenta.Tada@sony.com>
References: <20220124141622.4378-1-Kenta.Tada@sony.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest to verify the behavior of PT_REGS_xxx
and the CORE variant.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 .../bpf/prog_tests/test_bpf_syscall_macro.c   | 63 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_syscall_macro.c   | 64 +++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
new file mode 100644
index 000000000000..f5f4c8adf539
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022 Sony Group Corporation */
+#include <sys/prctl.h>
+#include <test_progs.h>
+#include "bpf_syscall_macro.skel.h"
+
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
+#else
+	ASSERT_EQ(skel->bss->arg4_cx, exp_arg4, "syscall_arg4_from_cx");
+#endif
+	ASSERT_EQ(skel->bss->arg4, exp_arg4, "syscall_arg4");
+	ASSERT_EQ(skel->bss->arg5, exp_arg5, "syscall_arg5");
+
+	/* check whether args of syscall are copied correctly for CORE variants */
+	ASSERT_EQ(skel->bss->arg1_core, exp_arg1, "syscall_arg1_core_variant");
+	ASSERT_EQ(skel->bss->arg2_core, exp_arg2, "syscall_arg2_core_variant");
+	ASSERT_EQ(skel->bss->arg3_core, exp_arg3, "syscall_arg3_core_variant");
+	/* it cannot copy arg4 when uses PT_REGS_PARM4_CORE on x86_64 */
+#ifdef __x86_64__
+	ASSERT_NEQ(skel->bss->arg4_core_cx, exp_arg4, "syscall_arg4_from_cx_core_variant");
+#else
+	ASSERT_EQ(skel->bss->arg4_core_cx, exp_arg4, "syscall_arg4_from_cx_core_variant");
+#endif
+	ASSERT_EQ(skel->bss->arg4_core, exp_arg4, "syscall_arg4_core_variant");
+	ASSERT_EQ(skel->bss->arg5_core, exp_arg5, "syscall_arg5_core_variant");
+
+cleanup:
+	bpf_syscall_macro__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
new file mode 100644
index 000000000000..cfeccd85f40e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022 Sony Group Corporation */
+#include <vmlinux.h>
+
+#include <bpf/bpf_core_read.h>
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
+int arg1_core = 0;
+unsigned long arg2_core = 0;
+unsigned long arg3_core = 0;
+unsigned long arg4_core_cx = 0;
+unsigned long arg4_core = 0;
+unsigned long arg5_core = 0;
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
+	/* test for PT_REGS_PARM */
+	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
+	bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1), &PT_REGS_PARM1_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg4_cx, sizeof(orig_arg4_cx), &PT_REGS_PARM4(real_regs));
+	bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4), &PT_REGS_PARM4_SYSCALL(real_regs));
+	bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5), &PT_REGS_PARM5_SYSCALL(real_regs));
+	/* copy all actual args and the wrong arg4 on x86_64 */
+	arg1 = orig_arg1;
+	arg2 = orig_arg2;
+	arg3 = orig_arg3;
+	arg4_cx = orig_arg4_cx;
+	arg4 = orig_arg4;
+	arg5 = orig_arg5;
+
+	/* test for the CORE variant of PT_REGS_PARM */
+	arg1_core = PT_REGS_PARM1_CORE_SYSCALL(real_regs);
+	arg2_core = PT_REGS_PARM2_CORE_SYSCALL(real_regs);
+	arg3_core = PT_REGS_PARM3_CORE_SYSCALL(real_regs);
+	arg4_core_cx = PT_REGS_PARM4_CORE(real_regs);
+	arg4_core = PT_REGS_PARM4_CORE_SYSCALL(real_regs);
+	arg5_core = PT_REGS_PARM5_CORE_SYSCALL(real_regs);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.32.0

