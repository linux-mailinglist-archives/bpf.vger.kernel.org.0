Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA637955D
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhEJRYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhEJRYG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C52C061574;
        Mon, 10 May 2021 10:23:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 1so12529782qtb.0;
        Mon, 10 May 2021 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZ7jgh8n9Ewl7aTtjcfWvHPosfSycLeUWDUFaOitHlw=;
        b=gW8vw40vlqTZ2jCM73vqolZZWkLgjI6c84c2tdzyF63+bw928QLCYtR1cCbArh3pRd
         7ovyWIfbukHuJpC8I7uocQczXzzhiM37478tup8wGcHa9YA6ProL07kpILxau+hPNc2Z
         XDp/teyLZrcVl4lsg+9NSwJqpwBAUX0gLRB6kbiNAO863Ay4jolZ1LpvwD876Jp4HEOD
         31q0MFGgavZgCRlU9YO2QgQTRKL6A0uRlzJ5H/pklh1oGZrW6huBhC5bux0ofYfwvL30
         Bgw/sm8wtwEFGGwfu06ZqEyz5XOu4GOGvDUi5Tt/UKSV84Ip3fEBKpELlDAhLuiORzgr
         3A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZ7jgh8n9Ewl7aTtjcfWvHPosfSycLeUWDUFaOitHlw=;
        b=XhQzDKk8726Nh2RgoQPfLwPKxl4SPlO1Hil7wABIDy2Rq634bGXBDVe77bi7Cda6Ge
         ZU8ywIWn2rmUNPghSwBuD+zycf0h6rJbszoJeod8U/vbGJ8CEIqhXwkFa4uLFmuOWTZP
         koI9AMbo6tetqG97ev/M7C8VY84z3/Mx+2CGdE7VkUUb3uHoKBu1qxy+r2NNRJ/zu1by
         IjhAWQJamDkE6LIMl25z/PGLsy+2AdxOKLylPTmRoe1i2QEq2g7G/TBF+9WTfaWFEeQX
         WxdJtB/TK5Pp27k4XFwHKsuZbDLVAuzphDYrxMsU2ZCvltXU7U4YmXvS8fNfZD3ln4rs
         EOjw==
X-Gm-Message-State: AOAM530WRflZvQ/vBtY5a+1+2CrpHeUv4IXwmOXwiIoMlt2WmolIA2ig
        Y2IL+eraMNkoukv9oDGMzCLA63NK8QjOwfxh
X-Google-Smtp-Source: ABdhPJym19kE/RMpadgsTPFOwNJudsn2Uv/1tnLrQ9Li4RWoca5YsWzywFdeZDE6mOLLRD3fnk6emA==
X-Received: by 2002:a05:622a:10e:: with SMTP id u14mr23252254qtw.229.1620667379628;
        Mon, 10 May 2021 10:22:59 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:22:59 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux.dev, bpf@vger.kernel.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: [RFC PATCH bpf-next seccomp 05/12] samples/bpf: Add eBPF seccomp sample programs
Date:   Mon, 10 May 2021 12:22:42 -0500
Message-Id: <5f7c10074e10f994f3984a564531d5d9285d53eb.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sargun Dhillon <sargun@sargun.me>

This adds a sample program that uses seccomp-eBPF, called
test_seccomp. It shows the simple ability to code seccomp filters
in C.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Link: https://lists.linux-foundation.org/pipermail/containers/2018-February/038573.html
Co-developed-by: Jinghao Jia <jinghao7@illinois.edu>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
[YiFei: change from bpf_load to libbpf]
Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 samples/bpf/Makefile            |  3 ++
 samples/bpf/test_seccomp_kern.c | 41 +++++++++++++++++++++++++++
 samples/bpf/test_seccomp_user.c | 49 +++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 samples/bpf/test_seccomp_kern.c
 create mode 100644 samples/bpf/test_seccomp_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 45ceca4e2c70..d49e7f91eba6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -55,6 +55,7 @@ tprogs-y += task_fd_query
 tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += test_seccomp
 
 # Libbpf dependencies
 LIBBPF = $(TOOLS_PATH)/lib/bpf/libbpf.a
@@ -113,6 +114,7 @@ task_fd_query-objs := task_fd_query_user.o $(TRACE_HELPERS)
 xdp_sample_pkts-objs := xdp_sample_pkts_user.o
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
+test_seccomp-objs := test_seccomp_user.o
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -174,6 +176,7 @@ always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
 always-y += xdpsock_kern.o
+always-y += test_seccomp_kern.o
 
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
diff --git a/samples/bpf/test_seccomp_kern.c b/samples/bpf/test_seccomp_kern.c
new file mode 100644
index 000000000000..efd42f47d9c4
--- /dev/null
+++ b/samples/bpf/test_seccomp_kern.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <uapi/linux/seccomp.h>
+#include <uapi/linux/bpf.h>
+#include <uapi/linux/unistd.h>
+#include <uapi/linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <uapi/linux/audit.h>
+
+#if defined(__x86_64__)
+#define ARCH	AUDIT_ARCH_X86_64
+#elif defined(__i386__)
+#define ARCH	AUDIT_ARCH_I386
+#else
+#endif
+
+#ifdef ARCH
+/* Returns EPERM when trying to close fd 999 */
+SEC("seccomp")
+int bpf_prog1(struct seccomp_data *ctx)
+{
+	/*
+	 * Make sure this BPF program is being run on the same architecture it
+	 * was compiled on.
+	 */
+	if (ctx->arch != ARCH)
+		return SECCOMP_RET_ERRNO | EPERM;
+	if (ctx->nr == __NR_close && ctx->args[0] == 999)
+		return SECCOMP_RET_ERRNO | EPERM;
+
+	return SECCOMP_RET_ALLOW;
+}
+#else
+#warning Architecture not supported -- Blocking all syscalls
+SEC("seccomp")
+int bpf_prog1(struct seccomp_data *ctx)
+{
+	return SECCOMP_RET_ERRNO | EPERM;
+}
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_seccomp_user.c b/samples/bpf/test_seccomp_user.c
new file mode 100644
index 000000000000..ba17e18666b9
--- /dev/null
+++ b/samples/bpf/test_seccomp_user.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include <bpf/libbpf.h>
+#include <errno.h>
+#include <linux/bpf.h>
+#include <linux/seccomp.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <strings.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	struct bpf_object *obj;
+	char filename[256];
+	int prog_fd;
+
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+
+	if (bpf_prog_load(filename, BPF_PROG_TYPE_SECCOMP, &obj, &prog_fd))
+		exit(EXIT_FAILURE);
+	if (prog_fd < 0) {
+		fprintf(stderr, "ERROR: no program found: %s\n",
+			strerror(prog_fd));
+		exit(EXIT_FAILURE);
+	}
+
+	/* set new_new_privs so non-privileged users can attach filters */
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		perror("prctl(NO_NEW_PRIVS)");
+		exit(EXIT_FAILURE);
+	}
+
+	if (syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
+		    SECCOMP_FILTER_FLAG_EXTENDED, &prog_fd)) {
+		perror("seccomp");
+		exit(EXIT_FAILURE);
+	}
+
+	close(111);
+	assert(errno == EBADF);
+	close(999);
+	assert(errno == EPERM);
+
+	printf("close syscall successfully filtered\n");
+	return 0;
+}
-- 
2.31.1

