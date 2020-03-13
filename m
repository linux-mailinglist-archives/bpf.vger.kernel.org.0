Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410F61841E5
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 08:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgCMH4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 03:56:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgCMH4y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Mar 2020 03:56:54 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02D7ur6H000629
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 00:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=apdkTRdS36pEnQXpekfeIDuIrhimxFve17Pm8QCuaBw=;
 b=FmmMGEvFN4PvAVMu7lzfxIOB9j9HmtQS/ZRyE6Hs42wpfC06RCthtdgZxaK4wLjhzooW
 g+HbyT5D28SW6dYle5qeVIgwFMejJXHd99WoscI6B/XzYJDnefQv+SE84j1UD9wR7+e0
 aF1ZWBciwzHIqIFqGV9/jBeco7ZUaV5tv9I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqt7xjwgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 00:56:52 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 00:56:19 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 670D12EC2DC7; Fri, 13 Mar 2020 00:56:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/4] selftests/bpf: add vmlinux.h selftest exercising tracing of syscalls
Date:   Fri, 13 Mar 2020 00:54:41 -0700
Message-ID: <20200313075442.4071486-5-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313075442.4071486-1-andriin@fb.com>
References: <20200313075442.4071486-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_03:2020-03-11,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 suspectscore=8
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130044
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add vmlinux.h generation to selftest/bpf's Makefile. Use it from newly added
test_vmlinux to trace nanosleep syscall using 5 different types of programs:
  - tracepoint;
  - raw tracepoint;
  - raw tracepoint w/ direct memory reads (tp_btf);
  - kprobe;
  - fentry.

These programs are realistic variants of real-life tracing programs,
excercising vmlinux.h's usage with tracing applications.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/Makefile          |  7 +-
 .../selftests/bpf/prog_tests/vmlinux.c        | 43 ++++++++
 .../selftests/bpf/progs/test_vmlinux.c        | 98 +++++++++++++++++++
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vmlinux.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_vmlinux.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index da4389dde9f7..3bbda8eb57aa 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -135,7 +135,7 @@ VMLINUX_BTF_PATHS := $(if $(O),$(O)/vmlinux)				\
 		     ../../../../vmlinux				\
 		     /sys/kernel/btf/vmlinux				\
 		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF:= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+VMLINUX_BTF := $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(OUTPUT)/runqslower: $(BPFOBJ)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
@@ -176,6 +176,10 @@ $(BUILD_DIR)/libbpf $(BUILD_DIR)/bpftool $(INCLUDE_DIR):
 	$(call msg,MKDIR,,$@)
 	mkdir -p $@
 
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) | $(BPFTOOL) $(INCLUDE_DIR)
+	$(call msg,GEN,,$@)
+	$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+
 # Get Clang's default includes on this system, as opposed to those seen by
 # '-target bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
@@ -284,6 +288,7 @@ $(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs := y
 $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
 		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
+		     $$(INCLUDE_DIR)/vmlinux.h				\
 		     $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
 					  $(TRUNNER_BPF_CFLAGS),	\
diff --git a/tools/testing/selftests/bpf/prog_tests/vmlinux.c b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
new file mode 100644
index 000000000000..04939eda1325
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_vmlinux.skel.h"
+
+#define MY_TV_NSEC 1337
+
+static void nsleep()
+{
+	struct timespec ts = { .tv_nsec = MY_TV_NSEC };
+
+	(void)nanosleep(&ts, NULL);
+}
+
+void test_vmlinux(void)
+{
+	int duration = 0, err;
+	struct test_vmlinux* skel;
+	struct test_vmlinux__bss *bss;
+
+	skel = test_vmlinux__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+	bss = skel->bss;
+
+	err = test_vmlinux__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger everything */
+	nsleep();
+
+	CHECK(!bss->tp_called, "tp", "not called\n");
+	CHECK(!bss->raw_tp_called, "raw_tp", "not called\n");
+	CHECK(!bss->tp_btf_called, "tp_btf", "not called\n");
+	CHECK(!bss->kprobe_called, "kprobe", "not called\n");
+	CHECK(!bss->fentry_called, "fentry", "not called\n");
+
+cleanup:
+	test_vmlinux__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
new file mode 100644
index 000000000000..5cc2bf8011b0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include "vmlinux.h"
+#include <asm/unistd.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#define MY_TV_NSEC 1337
+
+bool tp_called = false;
+bool raw_tp_called = false;
+bool tp_btf_called = false;
+bool kprobe_called = false;
+bool fentry_called = false;
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int handle__tp(struct trace_event_raw_sys_enter *args)
+{
+	struct __kernel_timespec *ts;
+
+	if (args->id != __NR_nanosleep)
+		return 0;
+
+	ts = (void *)args->args[0];
+	if (BPF_CORE_READ(ts, tv_nsec) != MY_TV_NSEC)
+		return 0;
+
+	tp_called = true;
+	return 0;
+}
+
+static bool __always_inline handle_probed(struct pt_regs *regs, long id)
+{
+	struct __kernel_timespec *ts;
+
+	if (id != __NR_nanosleep)
+		return false;
+
+	ts = (void *)PT_REGS_PARM1_CORE(regs);
+	if (BPF_CORE_READ(ts, tv_nsec) != MY_TV_NSEC)
+		return false;
+
+	return true;
+}
+
+SEC("raw_tp/sys_enter")
+int BPF_PROG(handle__raw_tp, struct pt_regs *regs, long id)
+{
+	struct __kernel_timespec *ts;
+
+	if (id != __NR_nanosleep)
+		return 0;
+
+	ts = (void *)PT_REGS_PARM1_CORE(regs);
+	if (BPF_CORE_READ(ts, tv_nsec) != MY_TV_NSEC)
+		return 0;
+
+	raw_tp_called = true;
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
+{
+	struct __kernel_timespec *ts;
+
+	if (id != __NR_nanosleep)
+		return 0;
+
+	ts = (void *)PT_REGS_PARM1_CORE(regs);
+	if (BPF_CORE_READ(ts, tv_nsec) != MY_TV_NSEC)
+		return 0;
+
+	tp_btf_called = true;
+	return 0;
+}
+
+SEC("kprobe/hrtimer_nanosleep")
+int BPF_KPROBE(handle__kprobe,
+	       ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+{
+	if (rqtp == MY_TV_NSEC)
+		kprobe_called = true;
+	return 0;
+}
+
+SEC("fentry/hrtimer_nanosleep")
+int BPF_PROG(handle__fentry,
+	       ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+{
+	if (rqtp == MY_TV_NSEC)
+		fentry_called = true;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.17.1

