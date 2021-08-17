Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21933EF27A
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 21:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhHQTJz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 15:09:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhHQTJy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 15:09:54 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HJ6b0k018486
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:09:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4FkMjJcOyKJQhSfVrcvcRhHJ9skNpOqtZADTYBp+las=;
 b=IOkyqMbPZhs5qeYmEqkiN+2OhtCseySKdGmLCoCXhw4rSkMW8MK8xnXMNsiXxMiRH7/E
 vbPr7mTPWJwh32eWj/D2vVdAI9GW+/aCVeWinUZX5IVSfNqgm9FJY25WQlAl03EXvqbG
 7f/Swae6zZIP6ydGhcJafMqgGSt/yAdgfhU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3afqeya05p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:09:21 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 12:09:20 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 0E917606B1B2; Tue, 17 Aug 2021 12:09:18 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: replace CHECK with ASSERT_* macros in send_signal.c
Date:   Tue, 17 Aug 2021 12:09:18 -0700
Message-ID: <20210817190918.3186400-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817190912.3185813-1-yhs@fb.com>
References: <20210817190912.3185813-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: XvnECC0t43OniCI3mypxoY2Fx40Vmi6j
X-Proofpoint-GUID: XvnECC0t43OniCI3mypxoY2Fx40Vmi6j
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace CHECK in send_signal.c with ASSERT_* macros as
ASSERT_* macros are generally preferred. There is no
funcitonality change.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 45 +++++++++----------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
index 023cc532992d..41e158ae888e 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -10,29 +10,25 @@ static void sigusr1_handler(int signum)
 }
=20
 static void test_send_signal_common(struct perf_event_attr *attr,
-				    bool signal_thread,
-				    const char *test_name)
+				    bool signal_thread)
 {
 	struct test_send_signal_kern *skel;
 	int pipe_c2p[2], pipe_p2c[2];
 	int err =3D -1, pmu_fd =3D -1;
-	__u32 duration =3D 0;
 	char buf[256];
 	pid_t pid;
=20
-	if (CHECK(pipe(pipe_c2p), test_name,
-		  "pipe pipe_c2p error: %s\n", strerror(errno)))
+	if (!ASSERT_OK(pipe(pipe_c2p), "pipe_c2p"))
 		return;
=20
-	if (CHECK(pipe(pipe_p2c), test_name,
-		  "pipe pipe_p2c error: %s\n", strerror(errno))) {
+	if (!ASSERT_OK(pipe(pipe_p2c), "pipe_p2c")) {
 		close(pipe_c2p[0]);
 		close(pipe_c2p[1]);
 		return;
 	}
=20
 	pid =3D fork();
-	if (CHECK(pid < 0, test_name, "fork error: %s\n", strerror(errno))) {
+	if (!ASSERT_GE(pid, 0, "fork")) {
 		close(pipe_c2p[0]);
 		close(pipe_c2p[1]);
 		close(pipe_p2c[0]);
@@ -48,19 +44,19 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
 		close(pipe_p2c[1]); /* close write */
=20
 		/* notify parent signal handler is installed */
-		CHECK(write(pipe_c2p[1], buf, 1) !=3D 1, "pipe_write", "err %d\n", -er=
rno);
+		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
=20
 		/* make sure parent enabled bpf program to send_signal */
-		CHECK(read(pipe_p2c[0], buf, 1) !=3D 1, "pipe_read", "err %d\n", -errn=
o);
+		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
 		/* wait a little for signal handler */
 		sleep(1);
=20
 		buf[0] =3D sigusr1_received ? '2' : '0';
-		CHECK(write(pipe_c2p[1], buf, 1) !=3D 1, "pipe_write", "err %d\n", -er=
rno);
+		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
=20
 		/* wait for parent notification and exit */
-		CHECK(read(pipe_p2c[0], buf, 1) !=3D 1, "pipe_read", "err %d\n", -errn=
o);
+		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
 		close(pipe_c2p[1]);
 		close(pipe_p2c[0]);
@@ -71,20 +67,19 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
 	close(pipe_p2c[0]); /* close read */
=20
 	skel =3D test_send_signal_kern__open_and_load();
-	if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n=
"))
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		goto skel_open_load_failure;
=20
 	if (!attr) {
 		err =3D test_send_signal_kern__attach(skel);
-		if (CHECK(err, "skel_attach", "skeleton attach failed\n")) {
+		if (!ASSERT_OK(err, "skel_attach")) {
 			err =3D -1;
 			goto destroy_skel;
 		}
 	} else {
 		pmu_fd =3D syscall(__NR_perf_event_open, attr, pid, -1,
 				 -1 /* group id */, 0 /* flags */);
-		if (CHECK(pmu_fd < 0, test_name, "perf_event_open error: %s\n",
-			strerror(errno))) {
+		if (!ASSERT_GE(pmu_fd, 0, "perf_event_open")) {
 			err =3D -1;
 			goto destroy_skel;
 		}
@@ -96,7 +91,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 	}
=20
 	/* wait until child signal handler installed */
-	CHECK(read(pipe_c2p[0], buf, 1) !=3D 1, "pipe_read", "err %d\n", -errno=
);
+	ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
=20
 	/* trigger the bpf send_signal */
 	skel->bss->pid =3D pid;
@@ -104,21 +99,21 @@ static void test_send_signal_common(struct perf_even=
t_attr *attr,
 	skel->bss->signal_thread =3D signal_thread;
=20
 	/* notify child that bpf program can send_signal now */
-	CHECK(write(pipe_p2c[1], buf, 1) !=3D 1, "pipe_write", "err %d\n", -err=
no);
+	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
=20
 	/* wait for result */
 	err =3D read(pipe_c2p[0], buf, 1);
-	if (CHECK(err < 0, test_name, "reading pipe error: %s\n", strerror(errn=
o)))
+	if (!ASSERT_GE(err, 0, "reading pipe"))
 		goto disable_pmu;
-	if (CHECK(err =3D=3D 0, test_name, "reading pipe error: size 0\n")) {
+	if (!ASSERT_GT(err, 0, "reading pipe error: size 0")) {
 		err =3D -1;
 		goto disable_pmu;
 	}
=20
-	CHECK(buf[0] !=3D '2', test_name, "incorrect result\n");
+	ASSERT_EQ(buf[0], '2', "incorrect result");
=20
 	/* notify child safe to exit */
-	CHECK(write(pipe_p2c[1], buf, 1) !=3D 1, "pipe_write", "err %d\n", -err=
no);
+	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
=20
 disable_pmu:
 	close(pmu_fd);
@@ -132,7 +127,7 @@ static void test_send_signal_common(struct perf_event=
_attr *attr,
=20
 static void test_send_signal_tracepoint(bool signal_thread)
 {
-	test_send_signal_common(NULL, signal_thread, "tracepoint");
+	test_send_signal_common(NULL, signal_thread);
 }
=20
 static void test_send_signal_perf(bool signal_thread)
@@ -143,7 +138,7 @@ static void test_send_signal_perf(bool signal_thread)
 		.config =3D PERF_COUNT_SW_CPU_CLOCK,
 	};
=20
-	test_send_signal_common(&attr, signal_thread, "perf_sw_event");
+	test_send_signal_common(&attr, signal_thread);
 }
=20
 static void test_send_signal_nmi(bool signal_thread)
@@ -172,7 +167,7 @@ static void test_send_signal_nmi(bool signal_thread)
 		close(pmu_fd);
 	}
=20
-	test_send_signal_common(&attr, signal_thread, "perf_hw_event");
+	test_send_signal_common(&attr, signal_thread);
 }
=20
 void test_send_signal(void)
--=20
2.30.2

