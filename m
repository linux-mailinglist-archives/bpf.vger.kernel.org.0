Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB25696FE
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiGGAln convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 6 Jul 2022 20:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiGGAlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 20:41:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF92DAA2
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 17:41:41 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 266L6iZo008800
        for <bpf@vger.kernel.org>; Wed, 6 Jul 2022 17:41:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h4ubnsyha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 17:41:41 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 6 Jul 2022 17:41:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7D7C31BFE3629; Wed,  6 Jul 2022 17:41:26 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH RFC bpf-next 3/3] selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in selftests
Date:   Wed, 6 Jul 2022 17:41:18 -0700
Message-ID: <20220707004118.298323-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707004118.298323-1-andrii@kernel.org>
References: <20220707004118.298323-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: i0eM7Ua77d6pYfqObIq6gYwIDGXBYAWg
X-Proofpoint-ORIG-GUID: i0eM7Ua77d6pYfqObIq6gYwIDGXBYAWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_14,2022-06-28_01,2022-06-22_01
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
 .../selftests/bpf/progs/test_attach_probe.c   |  6 ++---
 .../selftests/bpf/progs/test_probe_user.c     | 27 +++++--------------
 3 files changed, 12 insertions(+), 27 deletions(-)

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
index f1c88ad368ef..3f776b2eca1b 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -31,8 +31,8 @@ int handle_kprobe(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
-int BPF_KPROBE(handle_kprobe_auto)
+SEC("ksyscall/nanosleep")
+int BPF_KSYSCALL(handle_kprobe_auto)
 {
 	kprobe2_res = 11;
 	return 0;
@@ -56,7 +56,7 @@ int handle_kretprobe(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kretprobe/" SYS_PREFIX "sys_nanosleep")
+SEC("kretsyscall/nanosleep")
 int BPF_KRETPROBE(handle_kretprobe_auto)
 {
 	kretprobe2_res = 22;
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

