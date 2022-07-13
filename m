Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60107572B1B
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiGMBx3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 12 Jul 2022 21:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGMBx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:53:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA5D4BD0
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:26 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26CLjetg024565
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:25 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h9h5es1na-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:25 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 18:53:24 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 173711C4081EA; Tue, 12 Jul 2022 18:53:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
Date:   Tue, 12 Jul 2022 18:53:04 -0700
Message-ID: <20220713015304.3375777-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713015304.3375777-1-andrii@kernel.org>
References: <20220713015304.3375777-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5_y5mpNb2Z_aILqWpOQ6-JZJ3VuDQgb4
X-Proofpoint-GUID: 5_y5mpNb2Z_aILqWpOQ6-JZJ3VuDQgb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert few selftest that used plain SEC("kprobe") with arch-specific
syscall wrapper prefix to ksyscall/kretsyscall and corresponding
BPF_KSYSCALL macro. test_probe_user.c is especially benefiting from this
simplification.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/bpf_syscall_macro.c   |  6 ++---
 .../selftests/bpf/progs/test_attach_probe.c   | 15 +++++------
 .../selftests/bpf/progs/test_probe_user.c     | 27 +++++--------------
 3 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index 05838ed9b89c..e1e11897e99b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -64,9 +64,9 @@ int BPF_KPROBE(handle_sys_prctl)
 	return 0;
 }
 
-SEC("kprobe/" SYS_PREFIX "sys_prctl")
-int BPF_KPROBE_SYSCALL(prctl_enter, int option, unsigned long arg2,
-		       unsigned long arg3, unsigned long arg4, unsigned long arg5)
+SEC("ksyscall/prctl")
+int BPF_KSYSCALL(prctl_enter, int option, unsigned long arg2,
+		 unsigned long arg3, unsigned long arg4, unsigned long arg5)
 {
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
 
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index f1c88ad368ef..a1e45fec8938 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017 Facebook
 
-#include <linux/ptrace.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include <stdbool.h>
+#include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 
 int kprobe_res = 0;
@@ -31,8 +30,8 @@ int handle_kprobe(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
-int BPF_KPROBE(handle_kprobe_auto)
+SEC("ksyscall/nanosleep")
+int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __kernel_timespec *rem)
 {
 	kprobe2_res = 11;
 	return 0;
@@ -56,11 +55,11 @@ int handle_kretprobe(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kretprobe/" SYS_PREFIX "sys_nanosleep")
-int BPF_KRETPROBE(handle_kretprobe_auto)
+SEC("kretsyscall/nanosleep")
+int BPF_KRETPROBE(handle_kretprobe_auto, int ret)
 {
 	kretprobe2_res = 22;
-	return 0;
+	return ret;
 }
 
 SEC("uprobe")
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
index 702578a5e496..8e1495008e4d 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -1,35 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#include <linux/ptrace.h>
-#include <linux/bpf.h>
-
-#include <netinet/in.h>
-
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 
 static struct sockaddr_in old;
 
-SEC("kprobe/" SYS_PREFIX "sys_connect")
-int BPF_KPROBE(handle_sys_connect)
+SEC("ksyscall/connect")
+int BPF_KSYSCALL(handle_sys_connect, int fd, struct sockaddr_in *uservaddr, int addrlen)
 {
-#if SYSCALL_WRAPPER == 1
-	struct pt_regs *real_regs;
-#endif
 	struct sockaddr_in new;
-	void *ptr;
-
-#if SYSCALL_WRAPPER == 0
-	ptr = (void *)PT_REGS_PARM2(ctx);
-#else
-	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
-	bpf_probe_read_kernel(&ptr, sizeof(ptr), &PT_REGS_PARM2(real_regs));
-#endif
 
-	bpf_probe_read_user(&old, sizeof(old), ptr);
+	bpf_probe_read_user(&old, sizeof(old), uservaddr);
 	__builtin_memset(&new, 0xab, sizeof(new));
-	bpf_probe_write_user(ptr, &new, sizeof(new));
+	bpf_probe_write_user(uservaddr, &new, sizeof(new));
 
 	return 0;
 }
-- 
2.30.2

