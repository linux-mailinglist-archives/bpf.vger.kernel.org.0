Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857A544ED41
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 20:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhKLTa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 14:30:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43694 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhKLTa0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 14:30:26 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACIjHhD023113
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:27:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=u5+mZ/Fclc0Icu+QBeBDnBoD0/nX1K/BL/AlR6/qqig=;
 b=OsIFlfA0H9VfGyWpc2WxOVYng6HUeY5dEf4+XMEAuYVEMY+BxFoRKiz0CE4+9Wl2GYbg
 zyGJZQcmkLAO3sEpjIoI9xhILuAOqlNoAEPVvXfeZPTEi4VjZ/bLHRev4g73EShjxYHk
 2pbkDTZkhk6owckxf6txO8JdQRqefe+NXkQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k59kkw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:27:35 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 11:25:49 -0800
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id CD1046C8383B; Fri, 12 Nov 2021 11:25:39 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>,
        Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add timing to tests_progs
Date:   Fri, 12 Nov 2021 11:25:35 -0800
Message-ID: <20211112192535.898352-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112192535.898352-1-fallentree@fb.com>
References: <20211112192535.898352-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: c_fF4k86DkCkIyD_4SBkZSD5Ard_F5fp
X-Proofpoint-GUID: c_fF4k86DkCkIyD_4SBkZSD5Ard_F5fp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch adds '--timing' to test_progs. It tracks and print timing
information for each tests, it also prints top 10 slowest tests in the
summary.

Example output:
  $./test_progs --timing -j
  #1 align:OK (16 ms)
  ...
  #203 xdp_bonding:OK (2019 ms)
  #206 xdp_cpumap_attach:OK (3 ms)
  #207 xdp_devmap_attach:OK (4 ms)
  #208 xdp_info:OK (4 ms)
  #209 xdp_link:OK (4 ms)

  Top 10 Slowest tests:
  #48 fexit_stress: 34356 ms
  #160 test_lsm: 29602 ms
  #161 test_overhead: 29190 ms
  #159 test_local_storage: 28959 ms
  #158 test_ima: 28521 ms
  #185 verif_scale_pyperf600: 19524 ms
  #199 vmlinux: 17310 ms
  #154 tc_redirect: 11491 ms (serial)
  #147 task_local_storage: 7612 ms
  #183 verif_scale_pyperf180: 7186 ms
  Summary: 212/973 PASSED, 3 SKIPPED, 0 FAILED

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 125 +++++++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h |   2 +
 2 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 296928948bb9..d4786e1a540f 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -491,6 +491,7 @@ enum ARG_KEYS {
 	ARG_TEST_NAME_GLOB_DENYLIST =3D 'd',
 	ARG_NUM_WORKERS =3D 'j',
 	ARG_DEBUG =3D -1,
+	ARG_TIMING =3D -2,
 };
=20
 static const struct argp_option opts[] =3D {
@@ -516,6 +517,8 @@ static const struct argp_option opts[] =3D {
 	  "Number of workers to run in parallel, default to number of cpus." },
 	{ "debug", ARG_DEBUG, NULL, 0,
 	  "print extra debug information for test_progs." },
+	{ "timing", ARG_TIMING, NULL, 0,
+	  "track and print timing information for each test." },
 	{},
 };
=20
@@ -696,6 +699,9 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 	case ARG_DEBUG:
 		env->debug =3D true;
 		break;
+	case ARG_TIMING:
+		env->timing =3D true;
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -848,6 +854,7 @@ struct test_result {
 	int error_cnt;
 	int skip_cnt;
 	int sub_succ_cnt;
+	__u32 duration_ms;
=20
 	size_t log_cnt;
 	char *log_buf;
@@ -905,9 +912,29 @@ static int recv_message(int sock, struct msg *msg)
 	return ret;
 }
=20
-static void run_one_test(int test_num)
+static __u32 timespec_diff_ms(struct timespec start, struct timespec end=
)
+{
+	struct timespec temp;
+
+	if ((end.tv_nsec - start.tv_nsec) < 0) {
+		temp.tv_sec =3D end.tv_sec - start.tv_sec - 1;
+		temp.tv_nsec =3D 1000000000 + end.tv_nsec - start.tv_nsec;
+	} else {
+		temp.tv_sec =3D end.tv_sec - start.tv_sec;
+		temp.tv_nsec =3D end.tv_nsec - start.tv_nsec;
+	}
+	return (temp.tv_sec * 1000) + (temp.tv_nsec / 1000000);
+}
+
+
+static double run_one_test(int test_num)
 {
 	struct prog_test_def *test =3D &prog_test_defs[test_num];
+	struct timespec start =3D {}, end =3D {};
+	__u32 duration_ms =3D 0;
+
+	if (env.timing)
+		clock_gettime(CLOCK_MONOTONIC, &start);
=20
 	env.test =3D test;
=20
@@ -928,6 +955,13 @@ static void run_one_test(int test_num)
 	restore_netns();
 	if (test->need_cgroup_cleanup)
 		cleanup_cgroup_environment();
+
+	if (env.timing) {
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		duration_ms =3D timespec_diff_ms(start, end);
+	}
+
+	return duration_ms;
 }
=20
 struct dispatch_data {
@@ -999,6 +1033,7 @@ static void *dispatch_thread(void *ctx)
 			result->error_cnt =3D msg_test_done.test_done.error_cnt;
 			result->skip_cnt =3D msg_test_done.test_done.skip_cnt;
 			result->sub_succ_cnt =3D msg_test_done.test_done.sub_succ_cnt;
+			result->duration_ms =3D msg_test_done.test_done.duration_ms;
=20
 			/* collect all logs */
 			if (msg_test_done.test_done.have_log) {
@@ -1023,6 +1058,8 @@ static void *dispatch_thread(void *ctx)
 			}
 			/* output log */
 			{
+				char buf[255] =3D {};
+
 				pthread_mutex_lock(&stdout_output_lock);
=20
 				if (result->log_cnt) {
@@ -1032,9 +1069,15 @@ static void *dispatch_thread(void *ctx)
 						fprintf(stdout, "\n");
 				}
=20
-				fprintf(stdout, "#%d %s:%s\n",
+				if (env.timing) {
+					snprintf(buf, sizeof(buf), " (%u ms)", result->duration_ms);
+					buf[sizeof(buf) - 1] =3D '\0';
+				}
+
+				fprintf(stdout, "#%d %s:%s%s\n",
 					test->test_num, test->test_name,
-					result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
+					result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"),
+					buf);
=20
 				pthread_mutex_unlock(&stdout_output_lock);
 			}
@@ -1092,6 +1135,57 @@ static void print_all_error_logs(void)
 	}
 }
=20
+struct item {
+	int id;
+	__u32 duration_ms;
+};
+
+static int rcompitem(const void *a, const void *b)
+{
+	__u32 val_a =3D ((struct item *)a)->duration_ms;
+	__u32 val_b =3D ((struct item *)b)->duration_ms;
+
+	if (val_a > val_b)
+		return -1;
+	if (val_a < val_b)
+		return 1;
+	return 0;
+}
+
+static void print_slow_tests(void)
+{
+	int i;
+	struct item items[ARRAY_SIZE(prog_test_defs)] =3D {};
+
+	for (i =3D 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *test =3D &prog_test_defs[i];
+		struct test_result *result =3D &test_results[i];
+
+		if (!test->tested || !result->duration_ms)
+			continue;
+
+		items[i].id =3D i;
+		items[i].duration_ms =3D result->duration_ms;
+	}
+	qsort(&items[0], ARRAY_SIZE(items), sizeof(items[0]), rcompitem);
+
+	fprintf(stdout, "\nTop 10 Slowest tests:\n");
+
+	for (i =3D 0; i < 10; i++) {
+		struct item *v =3D &items[i];
+		struct prog_test_def *test;
+
+		if (!v->duration_ms)
+			break;
+
+		test =3D &prog_test_defs[v->id];
+		fprintf(stdout, "#%d %s: %u ms%s\n",
+			test->test_num, test->test_name, v->duration_ms,
+			test->run_serial_test !=3D NULL ? " (serial)" : "");
+	}
+}
+
+
 static int server_main(void)
 {
 	pthread_t *dispatcher_threads;
@@ -1149,13 +1243,15 @@ static int server_main(void)
 	for (int i =3D 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test =3D &prog_test_defs[i];
 		struct test_result *result =3D &test_results[i];
+		char buf[255] =3D {};
+		__u32 duration_ms =3D 0;
=20
 		if (!test->should_run || !test->run_serial_test)
 			continue;
=20
 		stdio_hijack();
=20
-		run_one_test(i);
+		duration_ms =3D run_one_test(i);
=20
 		stdio_restore();
 		if (env.log_buf) {
@@ -1168,13 +1264,20 @@ static int server_main(void)
 		}
 		restore_netns();
=20
-		fprintf(stdout, "#%d %s:%s\n",
+		if (env.timing) {
+			snprintf(buf, sizeof(buf), " (%u ms)", duration_ms);
+			buf[sizeof(buf) - 1] =3D '\0';
+		}
+
+		fprintf(stdout, "#%d %s:%s%s\n",
 			test->test_num, test->test_name,
-			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
+			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"),
+			buf);
=20
 		result->error_cnt =3D test->error_cnt;
 		result->skip_cnt =3D test->skip_cnt;
 		result->sub_succ_cnt =3D test->sub_succ_cnt;
+		result->duration_ms =3D duration_ms;
 	}
=20
 	/* generate summary */
@@ -1200,6 +1303,9 @@ static int server_main(void)
=20
 	print_all_error_logs();
=20
+	if (env.timing)
+		print_slow_tests();
+
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
@@ -1236,6 +1342,7 @@ static int worker_main(int sock)
 			int test_to_run;
 			struct prog_test_def *test;
 			struct msg msg_done;
+			__u32 duration_ms =3D 0;
=20
 			test_to_run =3D msg.do_test.test_num;
 			test =3D &prog_test_defs[test_to_run];
@@ -1248,7 +1355,7 @@ static int worker_main(int sock)
=20
 			stdio_hijack();
=20
-			run_one_test(test_to_run);
+			duration_ms =3D run_one_test(test_to_run);
=20
 			stdio_restore();
=20
@@ -1258,6 +1365,7 @@ static int worker_main(int sock)
 			msg_done.test_done.error_cnt =3D test->error_cnt;
 			msg_done.test_done.skip_cnt =3D test->skip_cnt;
 			msg_done.test_done.sub_succ_cnt =3D test->sub_succ_cnt;
+			msg_done.test_done.duration_ms =3D duration_ms;
 			msg_done.test_done.have_log =3D false;
=20
 			if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cn=
t) {
@@ -1486,6 +1594,9 @@ int main(int argc, char **argv)
=20
 	print_all_error_logs();
=20
+	if (env.timing)
+		print_slow_tests();
+
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 93c1ff705533..16b8c0a9ba5f 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -64,6 +64,7 @@ struct test_env {
 	bool verifier_stats;
 	bool debug;
 	enum verbosity verbosity;
+	bool timing;
=20
 	bool jit_enabled;
 	bool has_testmod;
@@ -109,6 +110,7 @@ struct msg {
 			int sub_succ_cnt;
 			int error_cnt;
 			int skip_cnt;
+			__u32 duration_ms;
 			bool have_log;
 		} test_done;
 		struct {
--=20
2.30.2

