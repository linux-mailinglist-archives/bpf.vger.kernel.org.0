Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35BE42464D
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhJFS6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbhJFS6U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196FAJT5023038
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4Fj6ZL0XHynbp8ctRCOhtof7kfYurkRC90e2c2g2abU=;
 b=EB183jB0CZ9TfQe7l4da20+v/atns+ywDTWZaZeIPmwZth4ABXe8ZIhcgqmGTURGk0uW
 lWWxAs3yzOo/KdYpZFeQJa9C55dfYKBV0g7ll9dcmcAPyNWNuSPMABtQqLIfQN4GXi9i
 8KDg3QhDI99mQgi4SBUys7ptedhIAd2G9Qg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhe6q9yjr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:28 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:27 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 197844BDB5AF; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 02/14] selftests/bpf: Allow some tests to be executed in sequence
Date:   Wed, 6 Oct 2021 11:56:07 -0700
Message-ID: <20211006185619.364369-3-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: EWGYaikOIqSPxF_3u-JWidmEP2Vsas3z
X-Proofpoint-GUID: EWGYaikOIqSPxF_3u-JWidmEP2Vsas3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=855 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch allows tests to define serial_test_name() instead of
test_name(), and this will make test_progs execute those in sequence
after all other tests finished executing concurrently.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 60 +++++++++++++++++++++---
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 51e18d8df7f2..4e2028189471 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -50,6 +50,7 @@ struct prog_test_def {
 	const char *test_name;
 	int test_num;
 	void (*run_test)(void);
+	void (*run_serial_test)(void);
 	bool force_log;
 	int error_cnt;
 	int skip_cnt;
@@ -455,14 +456,17 @@ static int load_bpf_testmod(void)
 }
=20
 /* extern declarations for test funcs */
-#define DEFINE_TEST(name) extern void test_##name(void);
+#define DEFINE_TEST(name)				\
+	extern void test_##name(void) __weak;		\
+	extern void serial_test_##name(void) __weak;
 #include <prog_tests/tests.h>
 #undef DEFINE_TEST
=20
 static struct prog_test_def prog_test_defs[] =3D {
-#define DEFINE_TEST(name) {		\
-	.test_name =3D #name,		\
-	.run_test =3D &test_##name,	\
+#define DEFINE_TEST(name) {			\
+	.test_name =3D #name,			\
+	.run_test =3D &test_##name,		\
+	.run_serial_test =3D &serial_test_##name,	\
 },
 #include <prog_tests/tests.h>
 #undef DEFINE_TEST
@@ -902,7 +906,10 @@ static void run_one_test(int test_num)
=20
 	env.test =3D test;
=20
-	test->run_test();
+	if (test->run_test)
+		test->run_test();
+	else if (test->run_serial_test)
+		test->run_serial_test();
=20
 	/* ensure last sub-test is finalized properly */
 	if (test->subtest_name)
@@ -952,7 +959,7 @@ void *dispatch_thread(void *ctx)
 			pthread_mutex_unlock(&current_test_lock);
 		}
=20
-		if (!test->should_run)
+		if (!test->should_run || test->run_serial_test)
 			continue;
=20
 		/* run test through worker */
@@ -1129,6 +1136,40 @@ static int server_main(void)
 	free(env.worker_current_test);
 	free(data);
=20
+	/* run serial tests */
+	save_netns();
+
+	for (int i =3D 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *test =3D &prog_test_defs[i];
+		struct test_result *result =3D &test_results[i];
+
+		if (!test->should_run || !test->run_serial_test)
+			continue;
+
+		stdio_hijack();
+
+		run_one_test(i);
+
+		stdio_restore();
+		if (env.log_buf) {
+			result->log_cnt =3D env.log_cnt;
+			result->log_buf =3D strdup(env.log_buf);
+
+			free(env.log_buf);
+			env.log_buf =3D NULL;
+			env.log_cnt =3D 0;
+		}
+		restore_netns();
+
+		fprintf(stdout, "#%d %s:%s\n",
+			test->test_num, test->test_name,
+			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
+
+		result->error_cnt =3D test->error_cnt;
+		result->skip_cnt =3D test->skip_cnt;
+		result->sub_succ_cnt =3D test->sub_succ_cnt;
+	}
+
 	/* generate summary */
 	fflush(stderr);
 	fflush(stdout);
@@ -1326,6 +1367,13 @@ int main(int argc, char **argv)
 			test->should_run =3D true;
 		else
 			test->should_run =3D false;
+
+		if ((test->run_test =3D=3D NULL && test->run_serial_test =3D=3D NULL) =
||
+		    (test->run_test !=3D NULL && test->run_serial_test !=3D NULL)) {
+			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test=
_%sl() defined.\n",
+				test->test_num, test->test_name, test->test_name, test->test_name);
+			exit(EXIT_ERR_SETUP_INFRA);
+		}
 	}
=20
 	/* ignore workers if we are just listing */
--=20
2.30.2

