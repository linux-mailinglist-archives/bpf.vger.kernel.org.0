Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F51522602
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiEJVCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiEJVCS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:02:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12934268EBD
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:18 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AJH8QK014394
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iZsOHRvgL5PWCUAfF/SrBmDyVmWKwdWIM4SHpyqMs+I=;
 b=oMPp60tgTZtAScOjE82roCjjtBw5Z9dZSNdGwrt88X3jYSInW2uwcTj67Yr8IcnVpDh/
 n815Z1m8vqN/K7eODjQSbonE/Gbaypxb38N9oDhSM07PqltcQw/+txTNl5hjfWigixrP
 eOV4jGVzcJ2CkSULUWvoxse3sWU8aBXE5Jc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyx2n0scg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:02:17 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 14:02:16 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 59E0832F2037; Tue, 10 May 2022 13:59:44 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v8 5/5] selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret/lsm.
Date:   Tue, 10 May 2022 13:59:23 -0700
Message-ID: <20220510205923.3206889-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510205923.3206889-1-kuifeng@fb.com>
References: <20220510205923.3206889-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6qA8hyPoTVpP00D4I2RM95OUSyn8uNHp
X-Proofpoint-ORIG-GUID: 6qA8hyPoTVpP00D4I2RM95OUSyn8uNHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure BPF cookies are correct for fentry/fexit/fmod_ret/lsm.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 89 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 52 +++++++++--
 2 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index 923a6139b2d8..83ef55e3caa4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -4,8 +4,11 @@
 #include <pthread.h>
 #include <sched.h>
 #include <sys/syscall.h>
+#include <sys/mman.h>
 #include <unistd.h>
 #include <test_progs.h>
+#include <network_helpers.h>
+#include <bpf/btf.h>
 #include "test_bpf_cookie.skel.h"
 #include "kprobe_multi.skel.h"
=20
@@ -410,6 +413,88 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link);
 }
=20
+static void tracing_subtest(struct test_bpf_cookie *skel)
+{
+	__u64 cookie;
+	int prog_fd;
+	int fentry_fd =3D -1, fexit_fd =3D -1, fmod_ret_fd =3D -1;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+
+	skel->bss->fentry_res =3D 0;
+	skel->bss->fexit_res =3D 0;
+
+	cookie =3D 0x10000000000000L;
+	prog_fd =3D bpf_program__fd(skel->progs.fentry_test1);
+	link_opts.tracing.cookie =3D cookie;
+	fentry_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY, &link_opts)=
;
+	if (!ASSERT_GE(fentry_fd, 0, "fentry.link_create"))
+		goto cleanup;
+
+	cookie =3D 0x20000000000000L;
+	prog_fd =3D bpf_program__fd(skel->progs.fexit_test1);
+	link_opts.tracing.cookie =3D cookie;
+	fexit_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_FEXIT, &link_opts);
+	if (!ASSERT_GE(fexit_fd, 0, "fexit.link_create"))
+		goto cleanup;
+
+	cookie =3D 0x30000000000000L;
+	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
+	link_opts.tracing.cookie =3D cookie;
+	fmod_ret_fd =3D bpf_link_create(prog_fd, 0, BPF_MODIFY_RETURN, &link_op=
ts);
+	if (!ASSERT_GE(fmod_ret_fd, 0, "fmod_ret.link_create"))
+		goto cleanup;
+
+	prog_fd =3D bpf_program__fd(skel->progs.fentry_test1);
+	bpf_prog_test_run_opts(prog_fd, &opts);
+
+	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
+	bpf_prog_test_run_opts(prog_fd, &opts);
+
+	ASSERT_EQ(skel->bss->fentry_res, 0x10000000000000L, "fentry_res");
+	ASSERT_EQ(skel->bss->fexit_res, 0x20000000000000L, "fexit_res");
+	ASSERT_EQ(skel->bss->fmod_ret_res, 0x30000000000000L, "fmod_ret_res");
+
+cleanup:
+	if (fentry_fd >=3D 0)
+		close(fentry_fd);
+	if (fexit_fd >=3D 0)
+		close(fexit_fd);
+	if (fmod_ret_fd >=3D 0)
+		close(fmod_ret_fd);
+}
+
+int stack_mprotect(void);
+
+static void lsm_subtest(struct test_bpf_cookie *skel)
+{
+	__u64 cookie;
+	int prog_fd;
+	int lsm_fd =3D -1;
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+
+	skel->bss->lsm_res =3D 0;
+
+	cookie =3D 0x90000000000090L;
+	prog_fd =3D bpf_program__fd(skel->progs.test_int_hook);
+	link_opts.tracing.cookie =3D cookie;
+	lsm_fd =3D bpf_link_create(prog_fd, 0, BPF_LSM_MAC, &link_opts);
+	if (!ASSERT_GE(lsm_fd, 0, "lsm.link_create"))
+		goto cleanup;
+
+	stack_mprotect();
+	if (!ASSERT_EQ(errno, EPERM, "stack_mprotect"))
+		goto cleanup;
+
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->lsm_res, 0x90000000000090L, "fentry_res");
+
+cleanup:
+	if (lsm_fd >=3D 0)
+		close(lsm_fd);
+}
+
 void test_bpf_cookie(void)
 {
 	struct test_bpf_cookie *skel;
@@ -432,6 +517,10 @@ void test_bpf_cookie(void)
 		tp_subtest(skel);
 	if (test__start_subtest("perf_event"))
 		pe_subtest(skel);
+	if (test__start_subtest("trampoline"))
+		tracing_subtest(skel);
+	if (test__start_subtest("lsm"))
+		lsm_subtest(skel);
=20
 	test_bpf_cookie__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/=
testing/selftests/bpf/progs/test_bpf_cookie.c
index 0e2222968918..22d0ac8709b4 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -4,18 +4,23 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <errno.h>
=20
 int my_tid;
=20
-int kprobe_res;
-int kprobe_multi_res;
-int kretprobe_res;
-int uprobe_res;
-int uretprobe_res;
-int tp_res;
-int pe_res;
+__u64 kprobe_res;
+__u64 kprobe_multi_res;
+__u64 kretprobe_res;
+__u64 uprobe_res;
+__u64 uretprobe_res;
+__u64 tp_res;
+__u64 pe_res;
+__u64 fentry_res;
+__u64 fexit_res;
+__u64 fmod_ret_res;
+__u64 lsm_res;
=20
-static void update(void *ctx, int *res)
+static void update(void *ctx, __u64 *res)
 {
 	if (my_tid !=3D (u32)bpf_get_current_pid_tgid())
 		return;
@@ -82,4 +87,35 @@ int handle_pe(struct pt_regs *ctx)
 	return 0;
 }
=20
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_test1, int a)
+{
+	update(ctx, &fentry_res);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(fexit_test1, int a, int ret)
+{
+	update(ctx, &fexit_res);
+	return 0;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret_test, int _a, int *_b, int _ret)
+{
+	update(ctx, &fmod_ret_res);
+	return 1234;
+}
+
+SEC("lsm/file_mprotect")
+int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
+	     unsigned long reqprot, unsigned long prot, int ret)
+{
+	if (my_tid !=3D (u32)bpf_get_current_pid_tgid())
+		return ret;
+	update(ctx, &lsm_res);
+	return -EPERM;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

