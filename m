Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D14BC36D
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 01:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiBSAag (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 19:30:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiBSAaf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 19:30:35 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B78E4D31
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 16:30:17 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21INNxfu018189
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 16:30:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=sMRymh4dHRRtLhPfrYkIEwMbQ2OjYukZD+coZ6Zf5Do=;
 b=GaN3bTzxxTImx42VbcUrCa2R3udc14Kq6xF/88I70UAMj0YT9s001HcmGPUNRzsep+I3
 udkOssW+knHbmviGD3DxvBuVav9aMkC4j8uNy5UK+2Y+0bBI5eSxSRui/68pSVuM3yKf
 IUWEl+mvKnhVE+a0KuXP5PF9o88BfcKjduc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9yf302tp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 16:30:16 -0800
Received: from twshared33837.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 16:30:15 -0800
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id A5F3531D4BCE; Fri, 18 Feb 2022 16:30:08 -0800 (PST)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] Improve BPF test stability (related to perf events and scheduling)
Date:   Fri, 18 Feb 2022 16:30:04 -0800
Message-ID: <20220219003004.1085072-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: micSOyYFNZ49Mnl2mUfDa_RiJa0SnoUO
X-Proofpoint-ORIG-GUID: micSOyYFNZ49Mnl2mUfDa_RiJa0SnoUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_10,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202190000
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
 tools/testing/selftests/bpf/prog_tests/find_vma.c  |  5 ++---
 .../selftests/bpf/prog_tests/perf_branches.c       |  4 ++--
 tools/testing/selftests/bpf/prog_tests/perf_link.c |  2 +-
 .../testing/selftests/bpf/prog_tests/send_signal.c | 14 ++++++++++----
 5 files changed, 16 insertions(+), 11 deletions(-)

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
index b74b3c0c555a..acc41223a112 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -30,7 +30,7 @@ static int open_pe(void)
 	attr.type =3D PERF_TYPE_HARDWARE;
 	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CL=
OEXEC);
=20
 	return pfd >=3D 0 ? pfd : -errno;
@@ -57,7 +57,7 @@ static void test_find_vma_pe(struct find_vma *skel)
 	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
 		goto cleanup;
=20
-	for (i =3D 0; i < 1000000; ++i)
+	for (i =3D 0; i < 1000000000; ++i)
 		++j;
=20
 	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
@@ -108,7 +108,6 @@ void serial_test_find_vma(void)
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
index 776916b61c40..841217bd1df6 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -4,11 +4,12 @@
 #include <sys/resource.h>
 #include "test_send_signal_kern.skel.h"
=20
-int sigusr1_received =3D 0;
+int sigusr1_received;
+volatile int volatile_variable;
=20
 static void sigusr1_handler(int signum)
 {
-	sigusr1_received++;
+	sigusr1_received =3D 1;
 }
=20
 static void test_send_signal_common(struct perf_event_attr *attr,
@@ -42,7 +43,9 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 		int old_prio;
=20
 		/* install signal handler and notify parent */
+		errno =3D 0;
 		signal(SIGUSR1, sigusr1_handler);
+		ASSERT_OK(errno, "signal");
=20
 		close(pipe_c2p[0]); /* close read */
 		close(pipe_p2c[1]); /* close write */
@@ -63,9 +66,12 @@ static void test_send_signal_common(struct perf_event_=
attr *attr,
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
 		/* wait a little for signal handler */
-		sleep(1);
+		for (int i =3D 0; i < 1000000000; i++)
+			volatile_variable++;
=20
 		buf[0] =3D sigusr1_received ? '2' : '0';
+		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
+
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
=20
 		/* wait for parent notification and exit */
@@ -110,9 +116,9 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
 	ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
=20
 	/* trigger the bpf send_signal */
+	skel->bss->signal_thread =3D signal_thread;
 	skel->bss->pid =3D pid;
 	skel->bss->sig =3D SIGUSR1;
-	skel->bss->signal_thread =3D signal_thread;
=20
 	/* notify child that bpf program can send_signal now */
 	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
--=20
2.30.2

