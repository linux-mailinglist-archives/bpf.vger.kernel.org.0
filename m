Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D834419A40
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhI0RHx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 13:07:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235870AbhI0RHB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Sep 2021 13:07:01 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18REfGjh014710
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 10:05:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JcS2FBvBEsjaB+NsqvmAA0dOLzzQXKPFt9XxAl66HBQ=;
 b=hq8yV5qt5s296Pw079YuiIYAOHrYXvWNFvjagYUTIBx7s/vpCubdPbRuG4rajwHglSan
 yhdMzl7/XWD+ksTXUhripHggi6ik4cNlhnZ7DPAUyDpcM0BqNgwbme6rwzvozFxEx+DQ
 R1NPmLYAcW8m3xZoYB8RkFR5ZBSMjPlTyXI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3bbfdf99nu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 10:05:22 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 27 Sep 2021 10:05:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B93D95BC9F9; Mon, 27 Sep 2021 10:05:19 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix probe_user test failure with clang build kernel
Date:   Mon, 27 Sep 2021 10:05:19 -0700
Message-ID: <20210927170519.806505-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ZU439hhbnsdpPSblaqnXGsyo_Qxwk7dI
X-Proofpoint-GUID: ZU439hhbnsdpPSblaqnXGsyo_Qxwk7dI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_07,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=787 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

clang build kernel failed the selftest probe_user.
  $ ./test_progs -t probe_user
  $ ...
  $ test_probe_user:PASS:get_kprobe_res 0 nsec
  $ test_probe_user:FAIL:check_kprobe_res wrong kprobe res from probe rea=
d: 0.0.0.0:0
  $ #94 probe_user:FAIL

The test attached to kernel function __sys_connect(). In net/socket.c, we=
 have
  int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrle=
n)
  {
        ......
  }
  ...
  SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
                  int, addrlen)
  {
        return __sys_connect(fd, uservaddr, addrlen);
  }

The gcc compiler (8.5.0) does not inline __sys_connect() in syscall entry
function. But latest clang trunk did the inlining. So the bpf program
is not triggered.

To make the test more reliable, let us kprobe the syscall entry function
instead. But x86_64, arm64 and s390 has syscall wrapper and they have
to be handled specially. I also changed the test to use vmlinux.h and COR=
E
to accommodate relocatable pt_regs structure, similar to
samples/bpf/test_probe_write_user_kern.c.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/probe_user.c     |  4 +--
 .../selftests/bpf/progs/test_probe_user.c     | 30 +++++++++++++++----
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/=
testing/selftests/bpf/prog_tests/probe_user.c
index 95bd12097358..52fe157e2a90 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -3,7 +3,7 @@
=20
 void test_probe_user(void)
 {
-	const char *prog_name =3D "kprobe/__sys_connect";
+	const char *prog_name =3D "handle_sys_connect";
 	const char *obj_file =3D "./test_probe_user.o";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
 	int err, results_map_fd, sock_fd, duration =3D 0;
@@ -18,7 +18,7 @@ void test_probe_user(void)
 	if (!ASSERT_OK_PTR(obj, "obj_open_file"))
 		return;
=20
-	kprobe_prog =3D bpf_object__find_program_by_title(obj, prog_name);
+	kprobe_prog =3D bpf_object__find_program_by_name(obj, prog_name);
 	if (CHECK(!kprobe_prog, "find_probe",
 		  "prog '%s' not found\n", prog_name))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/=
testing/selftests/bpf/progs/test_probe_user.c
index 89b3532ccc75..9b3ddbf6289d 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -1,21 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-#include <linux/ptrace.h>
-#include <linux/bpf.h>
-
-#include <netinet/in.h>
+#include "vmlinux.h"
=20
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_tracing.h>
=20
+#if defined(__TARGET_ARCH_x86)
+volatile const int syscall_wrapper =3D 1;
+#define SYS_PREFIX "__x64_"
+#elif defined(__TARGET_ARCH_s390)
+volatile const int syscall_wrapper =3D 1;
+#define SYS_PREFIX "__s390x_"
+#elif defined(__TARGET_ARCH_arm64)
+volatile const int syscall_wrapper =3D 1;
+#define SYS_PREFIX "__arm64_"
+#else
+volatile const int syscall_wrapper =3D 0;
+#endif
+
 static struct sockaddr_in old;
=20
-SEC("kprobe/__sys_connect")
+SEC("kprobe/" SYS_PREFIX "sys_connect")
 int BPF_KPROBE(handle_sys_connect)
 {
-	void *ptr =3D (void *)PT_REGS_PARM2(ctx);
+	void *ptr;
 	struct sockaddr_in new;
=20
+	if (syscall_wrapper =3D=3D 0) {
+		ptr =3D (void *)PT_REGS_PARM2_CORE(ctx);
+	} else {
+		struct pt_regs *real_regs =3D (struct pt_regs *)PT_REGS_PARM1_CORE(ctx=
);
+		ptr =3D (void *)PT_REGS_PARM2_CORE(real_regs);
+	}
+
 	bpf_probe_read_user(&old, sizeof(old), ptr);
 	__builtin_memset(&new, 0xab, sizeof(new));
 	bpf_probe_write_user(ptr, &new, sizeof(new));
--=20
2.30.2

