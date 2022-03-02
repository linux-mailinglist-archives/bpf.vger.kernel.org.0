Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900134CB14B
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiCBV2h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245290AbiCBV2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:28:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924443ED5
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 13:27:51 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMkLX000437
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 13:27:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=kpQ4gmwbrChFMiE9c2+r/yPMeROptpRN+ErlXjcWUuU=;
 b=cleZkmNB+BpQ2XOde6nwZF9bjlHF4OKAmdAVfQDOgwP/zk+rUwSmTp9fXTKwCmD2SNAw
 M/0Z8TbixSukMbnV+CWBSw1rYjRLARaZpZrIeapbzfQVyqwAlyhlbfq/rz+bo4zB2dtW
 5rWji6MOfABJP4c8a7s78Gq/ztOCoVwmLeg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej7jgw5u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 13:27:51 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 13:27:48 -0800
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id B23113A15985; Wed,  2 Mar 2022 13:27:41 -0800 (PST)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Mykola Lysenko <mykolal@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v3 bpf-next] Improve BPF test stability (related to perf events and scheduling)
Date:   Wed, 2 Mar 2022 13:27:35 -0800
Message-ID: <20220302212735.3412041-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gRMafdL6QV27Iuwj4Fbz3glheN42RiFG
X-Proofpoint-ORIG-GUID: gRMafdL6QV27Iuwj4Fbz3glheN42RiFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020089
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In send_signal, replace sleep with dummy cpu intensive computation
to increase probability of child process being scheduled. Add few
more asserts.

In find_vma, reduce sample_freq as higher values may be rejected in
some qemu setups, remove usleep and increase length of cpu intensive
computation.

In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
higher values may be rejected in some qemu setups

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
 .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
 .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
 .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
 .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
 .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
 6 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index cd10df6cd0fc..0612e79a9281 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/te=
sting/selftests/bpf/prog_tests/find_vma.c
index b74b3c0c555a..7cf4feb6464c 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -30,12 +30,20 @@ static int open_pe(void)
 	attr.type =3D PERF_TYPE_HARDWARE;
 	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CL=
OEXEC);
=20
 	return pfd >=3D 0 ? pfd : -errno;
 }
=20
+static bool find_vma_pe_condition(struct find_vma *skel)
+{
+	return skel->bss->found_vm_exec =3D=3D 0 ||
+		skel->data->find_addr_ret !=3D 0 ||
+		skel->data->find_zero_ret =3D=3D -1 ||
+		strcmp(skel->bss->d_iname, "test_progs") !=3D 0;
+}
+
 static void test_find_vma_pe(struct find_vma *skel)
 {
 	struct bpf_link *link =3D NULL;
@@ -57,7 +65,7 @@ static void test_find_vma_pe(struct find_vma *skel)
 	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
 		goto cleanup;
=20
-	for (i =3D 0; i < 1000000; ++i)
+	for (i =3D 0; i < 1000000000 && find_vma_pe_condition(skel); ++i)
 		++j;
=20
 	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
@@ -108,7 +116,6 @@ void serial_test_find_vma(void)
 	skel->bss->addr =3D (__u64)(uintptr_t)test_find_vma_pe;
=20
 	test_find_vma_pe(skel);
-	usleep(100000); /* allow the irq_work to finish */
 	test_find_vma_kprobe(skel);
=20
 	find_vma__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
index 12c4f45cee1a..bc24f83339d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -110,7 +110,7 @@ static void test_perf_branches_hw(void)
 	attr.type =3D PERF_TYPE_HARDWARE;
 	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
 	attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANC=
H_ANY;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
@@ -151,7 +151,7 @@ static void test_perf_branches_no_hw(void)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_link.c
index ede07344f264..224eba6fef2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -39,7 +39,7 @@ void serial_test_perf_link(void)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
index 776916b61c40..def50f1c5c31 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -4,11 +4,11 @@
 #include <sys/resource.h>
 #include "test_send_signal_kern.skel.h"
=20
-int sigusr1_received =3D 0;
+static int sigusr1_received;
=20
 static void sigusr1_handler(int signum)
 {
-	sigusr1_received++;
+	sigusr1_received =3D 1;
 }
=20
 static void test_send_signal_common(struct perf_event_attr *attr,
@@ -40,9 +40,10 @@ static void test_send_signal_common(struct perf_event_=
attr *attr,
=20
 	if (pid =3D=3D 0) {
 		int old_prio;
+		volatile int j =3D 0;
=20
 		/* install signal handler and notify parent */
-		signal(SIGUSR1, sigusr1_handler);
+		ASSERT_NEQ(signal(SIGUSR1, sigusr1_handler), SIG_ERR, "signal");
=20
 		close(pipe_c2p[0]); /* close read */
 		close(pipe_p2c[1]); /* close write */
@@ -63,9 +64,11 @@ static void test_send_signal_common(struct perf_event_=
attr *attr,
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
 		/* wait a little for signal handler */
-		sleep(1);
+		for (int i =3D 0; i < 100000000 && !sigusr1_received; i++)
+			j /=3D i + 1;
=20
 		buf[0] =3D sigusr1_received ? '2' : '0';
+		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
=20
 		/* wait for parent notification and exit */
@@ -93,7 +96,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 			goto destroy_skel;
 		}
 	} else {
-		pmu_fd =3D syscall(__NR_perf_event_open, attr, pid, -1,
+		pmu_fd =3D syscall(__NR_perf_event_open, attr, pid, -1 /* cpu */,
 				 -1 /* group id */, 0 /* flags */);
 		if (!ASSERT_GE(pmu_fd, 0, "perf_event_open")) {
 			err =3D -1;
@@ -110,9 +113,9 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
 	ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
=20
 	/* trigger the bpf send_signal */
-	skel->bss->pid =3D pid;
-	skel->bss->sig =3D SIGUSR1;
 	skel->bss->signal_thread =3D signal_thread;
+	skel->bss->sig =3D SIGUSR1;
+	skel->bss->pid =3D pid;
=20
 	/* notify child that bpf program can send_signal now */
 	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/=
tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index b4233d3efac2..92354cd72044 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -10,7 +10,7 @@ static __always_inline int bpf_send_signal_test(void *c=
tx)
 {
 	int ret;
=20
-	if (status !=3D 0 || sig =3D=3D 0 || pid =3D=3D 0)
+	if (status !=3D 0 || pid =3D=3D 0)
 		return 0;
=20
 	if ((bpf_get_current_pid_tgid() >> 32) =3D=3D pid) {
--=20
2.30.2

