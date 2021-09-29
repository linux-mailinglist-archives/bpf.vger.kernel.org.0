Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41441BD6E
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 05:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbhI2Dbq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 23:31:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35460 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243349AbhI2Dbq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 23:31:46 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SM2GD7029081
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 20:30:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=xxyXBtLFlaDvXgtPB9efuwFpfhNbW9tujO822tjJ2Hs=;
 b=ARCkobavGTkwKup0y0ihkgQaveDj2soVGbYAPipL/sxHdhzOKP2Nc3IpilnFN81pNwOB
 fCFp+LU2jIAA2oHZ6nJ8Mu1VlA9xb9jd1lPlSZtGBgC9s2BMdyyNwr7Q2uMhZQLcQ0mK
 6fDeAvH5WgcX2HrB/jWO+Pl9L5UCpcaAa90= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcbfespqt-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 20:30:05 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 20:30:02 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 485F06A0395; Tue, 28 Sep 2021 20:30:00 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2] selftests/bpf: fix probe_user test failure with clang build kernel
Date:   Tue, 28 Sep 2021 20:30:00 -0700
Message-ID: <20210929033000.3711921-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: tsECoRAuLsWhXcYTo9yri45lxCjP_JK0
X-Proofpoint-GUID: tsECoRAuLsWhXcYTo9yri45lxCjP_JK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_01,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=667 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290020
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
instead. Note that x86_64, arm64 and s390 have syscall wrappers and they =
have
to be handled specially.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/probe_user.c     |  4 +--
 .../selftests/bpf/progs/test_probe_user.c     | 28 +++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

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
index 89b3532ccc75..8812a90da4eb 100644
--- a/tools/testing/selftests/bpf/progs/test_probe_user.c
+++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
@@ -8,13 +8,37 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
=20
+#if defined(__TARGET_ARCH_x86)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__x64_"
+#elif defined(__TARGET_ARCH_s390)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__s390x_"
+#elif defined(__TARGET_ARCH_arm64)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__arm64_"
+#else
+#define SYSCALL_WRAPPER 0
+#define SYS_PREFIX ""
+#endif
+
 static struct sockaddr_in old;
=20
-SEC("kprobe/__sys_connect")
+SEC("kprobe/" SYS_PREFIX "sys_connect")
 int BPF_KPROBE(handle_sys_connect)
 {
-	void *ptr =3D (void *)PT_REGS_PARM2(ctx);
+#if SYSCALL_WRAPPER =3D=3D 1
+	struct pt_regs *real_regs;
+#endif
 	struct sockaddr_in new;
+	void *ptr;
+
+#if SYSCALL_WRAPPER =3D=3D 0
+	ptr =3D (void *)PT_REGS_PARM2(ctx);
+#else
+	real_regs =3D (struct pt_regs *)PT_REGS_PARM1(ctx);
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), &PT_REGS_PARM2(real_regs));
+#endif
=20
 	bpf_probe_read_user(&old, sizeof(old), ptr);
 	__builtin_memset(&new, 0xab, sizeof(new));
--=20
2.30.2

