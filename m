Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E738012E
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhENAhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhENAhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1015C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 10so23320769pfl.1
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1nCX7Cs5FfjDZ4ZcCcif+1FZpC8X4EFEefee+Csxd8=;
        b=gdhz81dTOSf25hMq9vrLFo/au+2f5JPVtgbmXm+9gUIc80Lr2S7i56DMV9dT5v9woA
         v7euAbqITMmwYMUzduhbSKeyA0b3Wec8+JmPtt0Nutv4ptIqVG+Cw7vvDsItpHnPcT8f
         WdsJdz0B+ixEv9VsHkfYsR5Kp24qiWxakJRsbEM3W+FYiJ1t6WnY4Wtrn+0jcl7kJ2JD
         a2lMqAvXezfudKOXspNAj5lXmn5Yhe05VT9015BStmf/24LbjT8m5T2pOuZgjZZrzqzM
         Y+ZC/7N/8gXYNXFZ4/wjvjkHRjEOGLnlwDPe0ZrtBhqT++EVO4Q2W6WcxPancch+mbiX
         Z/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J1nCX7Cs5FfjDZ4ZcCcif+1FZpC8X4EFEefee+Csxd8=;
        b=bzKT+OmpZ21iGrWdbdrkIR7PeK/QzLwkI+IS3yK9UDp+IjnVIiLTuXYs8GyRTVVfq/
         MgKD5mrlJQR6SLDApYylsWNSNgz1m+Xu7r7H3zSAc9Kr06cXqm7eZG4Y1pwGyXCo025W
         licZxPb+9CRpojGdd0WJ0NLIrRh75YLrIrFf1jodC5k0sT9dG4hUjdKYyPMoxWMvCtNJ
         uSuMPOpIg6xslQ8mkjuJEDKQgXPNRYRbUnWOfXnZZ9Y/Ax2ToVmUbGtYELVydjkbOC9W
         IPopRMOBHLKx31wr6Uql3RXkxR0ePQ31wCwLoTPutXFIauEt6q+gx11BQq/2d0hexiKG
         lRew==
X-Gm-Message-State: AOAM532JYq+jxGbg+yDASwJcDEOD0WrhzTMsqYCDBiJiJ/N3XpoArkvM
        aDSZsaHaYJc7kf/KuKBiw5U=
X-Google-Smtp-Source: ABdhPJyIHZnOASt+hzDzpp4nekBtLvN6ZW/pDG0PYXrhVZf4K16+iry5qgVXiVPwUngyPQMOViJC7g==
X-Received: by 2002:a63:5245:: with SMTP id s5mr44298275pgl.234.1620952597264;
        Thu, 13 May 2021 17:36:37 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:36 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 05/21] selftests/bpf: Test for syscall program type
Date:   Thu, 13 May 2021 17:36:07 -0700
Message-Id: <20210514003623.28033-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

bpf_prog_type_syscall is a program that creates a bpf map,
updates it, and loads another bpf program using bpf_sys_bpf() helper.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/syscall.c        | 52 ++++++++++++++
 tools/testing/selftests/bpf/progs/syscall.c   | 71 +++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/syscall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/testing/selftests/bpf/prog_tests/syscall.c
new file mode 100644
index 000000000000..1badd37148a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "syscall.skel.h"
+
+struct args {
+	__u64 log_buf;
+	__u32 log_size;
+	int max_entries;
+	int map_fd;
+	int prog_fd;
+};
+
+void test_syscall(void)
+{
+	static char verifier_log[8192];
+	struct args ctx = {
+		.max_entries = 1024,
+		.log_buf = (uintptr_t) verifier_log,
+		.log_size = sizeof(verifier_log),
+	};
+	struct bpf_prog_test_run_attr tattr = {
+		.ctx_in = &ctx,
+		.ctx_size_in = sizeof(ctx),
+	};
+	struct syscall *skel = NULL;
+	__u64 key = 12, value = 0;
+	int err;
+
+	skel = syscall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	tattr.prog_fd = bpf_program__fd(skel->progs.bpf_prog);
+	err = bpf_prog_test_run_xattr(&tattr);
+	ASSERT_EQ(err, 0, "err");
+	ASSERT_EQ(tattr.retval, 1, "retval");
+	ASSERT_GT(ctx.map_fd, 0, "ctx.map_fd");
+	ASSERT_GT(ctx.prog_fd, 0, "ctx.prog_fd");
+	ASSERT_OK(memcmp(verifier_log, "processed", sizeof("processed") - 1),
+		  "verifier_log");
+
+	err = bpf_map_lookup_elem(ctx.map_fd, &key, &value);
+	ASSERT_EQ(err, 0, "map_lookup");
+	ASSERT_EQ(value, 34, "map lookup value");
+cleanup:
+	syscall__destroy(skel);
+	if (ctx.prog_fd > 0)
+		close(ctx.prog_fd);
+	if (ctx.map_fd > 0)
+		close(ctx.map_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
new file mode 100644
index 000000000000..865b5269ecbb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <linux/stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <../../../tools/include/linux/filter.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct args {
+	__u64 log_buf;
+	__u32 log_size;
+	int max_entries;
+	int map_fd;
+	int prog_fd;
+};
+
+SEC("syscall")
+int bpf_prog(struct args *ctx)
+{
+	static char license[] = "GPL";
+	static struct bpf_insn insns[] = {
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	static union bpf_attr map_create_attr = {
+		.map_type = BPF_MAP_TYPE_HASH,
+		.key_size = 8,
+		.value_size = 8,
+	};
+	static union bpf_attr map_update_attr = { .map_fd = 1, };
+	static __u64 key = 12;
+	static __u64 value = 34;
+	static union bpf_attr prog_load_attr = {
+		.prog_type = BPF_PROG_TYPE_XDP,
+		.insn_cnt = sizeof(insns) / sizeof(insns[0]),
+	};
+	int ret;
+
+	map_create_attr.max_entries = ctx->max_entries;
+	prog_load_attr.license = (long) license;
+	prog_load_attr.insns = (long) insns;
+	prog_load_attr.log_buf = ctx->log_buf;
+	prog_load_attr.log_size = ctx->log_size;
+	prog_load_attr.log_level = 1;
+
+	ret = bpf_sys_bpf(BPF_MAP_CREATE, &map_create_attr, sizeof(map_create_attr));
+	if (ret <= 0)
+		return ret;
+	ctx->map_fd = ret;
+	insns[3].imm = ret;
+
+	map_update_attr.map_fd = ret;
+	map_update_attr.key = (long) &key;
+	map_update_attr.value = (long) &value;
+	ret = bpf_sys_bpf(BPF_MAP_UPDATE_ELEM, &map_update_attr, sizeof(map_update_attr));
+	if (ret < 0)
+		return ret;
+
+	ret = bpf_sys_bpf(BPF_PROG_LOAD, &prog_load_attr, sizeof(prog_load_attr));
+	if (ret <= 0)
+		return ret;
+	ctx->prog_fd = ret;
+	return 1;
+}
-- 
2.30.2

