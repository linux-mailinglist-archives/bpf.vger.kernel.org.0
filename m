Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBB43A6A4
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhJYWgO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 18:36:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233933AbhJYWgN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:36:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19PMGMVX027756
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Bo/6+jYglVtAxnH0hh4v0nDiiIh6KvxqhBRk86Ja4n8=;
 b=meoCpF3l8apzJvEeYtTqhpRI5PRANIZZ+ncdhsnp4B37oKgpsOlrRB4dgPEAZT0SndLm
 sn827JQR8iqriZjCuUysfM0W3WH7f2RbJ+xXZV9eqp6tB5nEYOVd2aQ6NNqbUTBZcBy/
 ft0J3kNwPXNPK4OkR7TqBQrjcC2lyZTbZeE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3bx4gdrd8m-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:49 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:33:48 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 3C5755DB8D3E; Mon, 25 Oct 2021 15:33:46 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: print subtest status line
Date:   Mon, 25 Oct 2021 15:33:43 -0700
Message-ID: <20211025223345.2136168-3-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025223345.2136168-1-fallentree@fb.com>
References: <20211025223345.2136168-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: jQO57CmlbyWjyD6WBq98nm5vWjxAVfBN
X-Proofpoint-GUID: jQO57CmlbyWjyD6WBq98nm5vWjxAVfBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110250127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch restores behavior that prints one status line for each
subtest executed. It works in both serial mode and parallel mode,  and
all verbosity settings.

The logic around IO hijacking could use some more simplification in the
future.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 56 +++++++++++++++++++-----
 tools/testing/selftests/bpf/test_progs.h |  4 ++
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 1f4a48566991..ff4598126f9d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -100,6 +100,18 @@ static bool should_run(struct test_selector *sel, in=
t num, const char *name)
 	return num < sel->num_set_len && sel->num_set[num];
 }
=20
+static void dump_subtest_status(bool display) {
+	fflush(env.subtest_status_fd);
+	if (display) {
+		if (env.subtest_status_cnt) {
+			env.subtest_status_buf[env.subtest_status_cnt] =3D '\0';
+			fputs(env.subtest_status_buf, stdout);
+		}
+	}
+	rewind(env.subtest_status_fd);
+	fflush(env.subtest_status_fd);
+}
+
 static void dump_test_log(const struct prog_test_def *test, bool failed)
 {
 	if (stdout =3D=3D env.stdout)
@@ -112,12 +124,17 @@ static void dump_test_log(const struct prog_test_de=
f *test, bool failed)
 	fflush(stdout); /* exports env.log_buf & env.log_cnt */
=20
 	if (env.verbosity > VERBOSE_NONE || test->force_log || failed) {
-		if (env.log_cnt) {
-			env.log_buf[env.log_cnt] =3D '\0';
-			fprintf(env.stdout, "%s", env.log_buf);
-			if (env.log_buf[env.log_cnt - 1] !=3D '\n')
-				fprintf(env.stdout, "\n");
-		}
+		dump_subtest_status(false);
+	} else {
+		rewind(stdout);
+		dump_subtest_status(true);
+		fflush(stdout);
+	}
+	if (env.log_cnt) {
+		env.log_buf[env.log_cnt] =3D '\0';
+		fprintf(env.stdout, "%s", env.log_buf);
+		if (env.log_buf[env.log_cnt - 1] !=3D '\n')
+			fprintf(env.stdout, "\n");
 	}
 }
=20
@@ -183,7 +200,12 @@ void test__end_subtest(void)
=20
 	dump_test_log(test, sub_error_cnt);
=20
+	// Print two copies here, one as part of full logs, another one will
+	// only be used if there is no need to show full logs.
 	fprintf(stdout, "#%d/%d %s/%s:%s\n",
+		test->test_num, test->subtest_num, test->test_name, test->subtest_name=
,
+		sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
+	fprintf(env.subtest_status_fd, "#%d/%d %s/%s:%s\n",
 	       test->test_num, test->subtest_num, test->test_name, test->subtes=
t_name,
 	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
=20
@@ -1250,6 +1272,15 @@ static int worker_main(int sock)
=20
 			run_one_test(test_to_run);
=20
+			// discard logs if we don't need them
+			if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cn=
t) {
+				dump_subtest_status(false);
+			} else {
+				rewind(stdout);
+				dump_subtest_status(true);
+				fflush(stdout);
+			}
+
 			stdio_restore();
=20
 			memset(&msg_done, 0, sizeof(msg_done));
@@ -1260,10 +1291,9 @@ static int worker_main(int sock)
 			msg_done.test_done.sub_succ_cnt =3D test->sub_succ_cnt;
 			msg_done.test_done.have_log =3D false;
=20
-			if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cn=
t) {
-				if (env.log_cnt)
-					msg_done.test_done.have_log =3D true;
-			}
+			if (env.log_cnt)
+				msg_done.test_done.have_log =3D true;
+
 			if (send_message(sock, &msg_done) < 0) {
 				perror("Fail to send message done");
 				goto out;
@@ -1357,6 +1387,12 @@ int main(int argc, char **argv)
=20
 	env.stdout =3D stdout;
 	env.stderr =3D stderr;
+	env.subtest_status_fd =3D open_memstream(
+		&env.subtest_status_buf, &env.subtest_status_cnt);
+	if (!env.subtest_status_fd) {
+		perror("Failed to setup env.subtest_status_fd");
+		exit(EXIT_ERR_SETUP_INFRA);
+	}
=20
 	env.has_testmod =3D true;
 	if (!env.list_test_names && load_bpf_testmod()) {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 93c1ff705533..a564215a63b1 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -89,6 +89,10 @@ struct test_env {
 	pid_t *worker_pids; /* array of worker pids */
 	int *worker_socks; /* array of worker socks */
 	int *worker_current_test; /* array of current running test for each wor=
ker */
+
+	FILE* subtest_status_fd; /* fd for printing status line for subtests */
+	char *subtest_status_buf; /* buffer for subtests status */
+	size_t subtest_status_cnt;
 };
=20
 #define MAX_LOG_TRUNK_SIZE 8192
--=20
2.30.2

