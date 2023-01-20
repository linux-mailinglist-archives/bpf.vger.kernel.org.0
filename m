Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5C675EA7
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjATUKN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjATUKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:10:12 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0042BAF33
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:09 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KDitfm030730
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:09 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6tvvna5m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:10:08 -0800
Received: from twshared22340.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:10:07 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DFBB525B4B237; Fri, 20 Jan 2023 12:10:04 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 24/25] selftests/bpf: add 6-argument syscall tracing test
Date:   Fri, 20 Jan 2023 12:09:13 -0800
Message-ID: <20230120200914.3008030-25-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vC-Krt58bK0ULmyVecfkM2nNHvvcMVh8
X-Proofpoint-GUID: vC-Krt58bK0ULmyVecfkM2nNHvvcMVh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out splice() is one of the syscalls that's using current maximum
number of arguments (six). This is perfect for testing, so extend
bpf_syscall_macro selftest to also trace splice() syscall, using
BPF_KSYSCALL() macro. This makes sure all the syscall argument register
definitions are correct.

Tested-by: Alan Maguire <alan.maguire@oracle.com> # arm64
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com> # s390x
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/test_bpf_syscall_macro.c   | 17 ++++++++++++
 .../selftests/bpf/progs/bpf_syscall_macro.c   | 26 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
index c381faaae741..2900c5e9a016 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2022 Sony Group Corporation */
+#define _GNU_SOURCE
+#include <fcntl.h>
 #include <sys/prctl.h>
 #include <test_progs.h>
 #include "bpf_syscall_macro.skel.h"
@@ -13,6 +15,8 @@ void test_bpf_syscall_macro(void)
 	unsigned long exp_arg3 = 13;
 	unsigned long exp_arg4 = 14;
 	unsigned long exp_arg5 = 15;
+	loff_t off_in, off_out;
+	ssize_t r;
 
 	/* check whether it can open program */
 	skel = bpf_syscall_macro__open();
@@ -33,6 +37,7 @@ void test_bpf_syscall_macro(void)
 
 	/* check whether args of syscall are copied correctly */
 	prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
+
 #if defined(__aarch64__) || defined(__s390__)
 	ASSERT_NEQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
 #else
@@ -68,6 +73,18 @@ void test_bpf_syscall_macro(void)
 	ASSERT_EQ(skel->bss->arg4_syscall, exp_arg4, "BPF_KPROBE_SYSCALL_arg4");
 	ASSERT_EQ(skel->bss->arg5_syscall, exp_arg5, "BPF_KPROBE_SYSCALL_arg5");
 
+	r = splice(-42, &off_in, 42, &off_out, 0x12340000, SPLICE_F_NONBLOCK);
+	err = -errno;
+	ASSERT_EQ(r, -1, "splice_res");
+	ASSERT_EQ(err, -EBADF, "splice_err");
+
+	ASSERT_EQ(skel->bss->splice_fd_in, -42, "splice_arg1");
+	ASSERT_EQ(skel->bss->splice_off_in, (__u64)&off_in, "splice_arg2");
+	ASSERT_EQ(skel->bss->splice_fd_out, 42, "splice_arg3");
+	ASSERT_EQ(skel->bss->splice_off_out, (__u64)&off_out, "splice_arg4");
+	ASSERT_EQ(skel->bss->splice_len, 0x12340000, "splice_arg5");
+	ASSERT_EQ(skel->bss->splice_flags, SPLICE_F_NONBLOCK, "splice_arg6");
+
 cleanup:
 	bpf_syscall_macro__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index e1e11897e99b..1a476d8ed354 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -81,4 +81,30 @@ int BPF_KSYSCALL(prctl_enter, int option, unsigned long arg2,
 	return 0;
 }
 
+__u64 splice_fd_in;
+__u64 splice_off_in;
+__u64 splice_fd_out;
+__u64 splice_off_out;
+__u64 splice_len;
+__u64 splice_flags;
+
+SEC("ksyscall/splice")
+int BPF_KSYSCALL(splice_enter, int fd_in, loff_t *off_in, int fd_out,
+		 loff_t *off_out, size_t len, unsigned int flags)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != filter_pid)
+		return 0;
+
+	splice_fd_in = fd_in;
+	splice_off_in = (__u64)off_in;
+	splice_fd_out = fd_out;
+	splice_off_out = (__u64)off_out;
+	splice_len = len;
+	splice_flags = flags;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.30.2

