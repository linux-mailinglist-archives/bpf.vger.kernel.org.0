Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2D335E2FC
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhDMPe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 11:34:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344718AbhDMPe7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 11:34:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DFOU25001124
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8Z1oGsX70NGexGAJRKH7/XKFlXP5jOpdlrbpZc5s5pE=;
 b=SMKtgKeDWTTQEyK9jAt71VOgKmU8CzqVCS8BOJRRssAPy3gQMzf5SvlW95t+JeEoXNaw
 DVsScDm8sTwliMjf/QO3V00UNqh5+lN+6ZXpqpYLAWaqsEebon8vKXlBKEkQGClt0Jz/
 bv5uITkkZ7NWm7OOKIj3H3WRtjO0d40gLSI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37w9dgsp6p-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:39 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 08:34:34 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E37C5161F592; Tue, 13 Apr 2021 08:34:29 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: silence clang compilation warnings
Date:   Tue, 13 Apr 2021 08:34:29 -0700
Message-ID: <20210413153429.3029377-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413153408.3027270-1-yhs@fb.com>
References: <20210413153408.3027270-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VhzQ8RVJ87Gov3pbK64IcqDEUeM0iVKj
X-Proofpoint-ORIG-GUID: VhzQ8RVJ87Gov3pbK64IcqDEUeM0iVKj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_09:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With clang compiler:
  make -j60 LLVM=3D1 LLVM_IAS=3D1  <=3D=3D=3D compile kernel
  make -j60 -C tools/testing/selftests/bpf LLVM=3D1 LLVM_IAS=3D1
Some linker flags are not used/effective for some binaries and
we have warnings like:
  warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]

We also have warnings like:
  .../selftests/bpf/prog_tests/ns_current_pid_tgid.c:74:57: note: treat t=
he string as an argument to avoid this
        if (CHECK(waitpid(cpid, &wstatus, 0) =3D=3D -1, "waitpid", strerr=
or(errno)))
                                                               ^
                                                               "%s",
  .../selftests/bpf/test_progs.h:129:35: note: expanded from macro 'CHECK=
'
        _CHECK(condition, tag, duration, format)
                                         ^
  .../selftests/bpf/test_progs.h:108:21: note: expanded from macro '_CHEC=
K'
                fprintf(stdout, ##format);                              \
                                  ^
The first warning can be silenced with clang option -Wno-unused-command-l=
ine-argument.
For the second warning, source codes are modified as suggested by the com=
piler
to silence the warning. Since gcc does not support the option
-Wno-unused-command-line-argument and the warning only happens with clang
compiler, the option -Wno-unused-command-line-argument is enabled only wh=
en
clang compiler is used.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile                         | 5 +++++
 tools/testing/selftests/bpf/prog_tests/fexit_sleep.c         | 4 ++--
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index dcc2dc1f2a86..c45ae13b88a0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -28,6 +28,11 @@ CFLAGS +=3D -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_C=
FLAGS)		\
 	  -Dbpf_load_program=3Dbpf_test_load_program
 LDLIBS +=3D -lcap -lelf -lz -lrt -lpthread
=20
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS +=3D -Wno-unused-command-line-argument
+endif
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_lp=
m_map test_progs \
 	test_verifier_log test_dev_cgroup \
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c b/tools=
/testing/selftests/bpf/prog_tests/fexit_sleep.c
index 6c4d42a2386f..ccc7e8a34ab6 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
@@ -39,7 +39,7 @@ void test_fexit_sleep(void)
 		goto cleanup;
=20
 	cpid =3D clone(do_sleep, child_stack + STACK_SIZE, CLONE_FILES | SIGCHL=
D, fexit_skel);
-	if (CHECK(cpid =3D=3D -1, "clone", strerror(errno)))
+	if (CHECK(cpid =3D=3D -1, "clone", "%s\n", strerror(errno)))
 		goto cleanup;
=20
 	/* wait until first sys_nanosleep ends and second sys_nanosleep starts =
*/
@@ -65,7 +65,7 @@ void test_fexit_sleep(void)
 	/* kill the thread to unwind sys_nanosleep stack through the trampoline=
 */
 	kill(cpid, 9);
=20
-	if (CHECK(waitpid(cpid, &wstatus, 0) =3D=3D -1, "waitpid", strerror(err=
no)))
+	if (CHECK(waitpid(cpid, &wstatus, 0) =3D=3D -1, "waitpid", "%s\n", stre=
rror(errno)))
 		goto cleanup;
 	if (CHECK(WEXITSTATUS(wstatus) !=3D 0, "exitstatus", "failed"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 31a3114906e2..2535788e135f 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -68,10 +68,10 @@ static void test_ns_current_pid_tgid_new_ns(void)
 	cpid =3D clone(test_current_pid_tgid, child_stack + STACK_SIZE,
 		     CLONE_NEWPID | SIGCHLD, NULL);
=20
-	if (CHECK(cpid =3D=3D -1, "clone", strerror(errno)))
+	if (CHECK(cpid =3D=3D -1, "clone", "%s\n", strerror(errno)))
 		return;
=20
-	if (CHECK(waitpid(cpid, &wstatus, 0) =3D=3D -1, "waitpid", strerror(err=
no)))
+	if (CHECK(waitpid(cpid, &wstatus, 0) =3D=3D -1, "waitpid", "%s\n", stre=
rror(errno)))
 		return;
=20
 	if (CHECK(WEXITSTATUS(wstatus) !=3D 0, "newns_pidtgid", "failed"))
--=20
2.30.2

