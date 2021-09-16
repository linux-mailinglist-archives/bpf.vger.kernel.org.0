Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8440D206
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 05:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhIPD2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 23:28:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36114 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234141AbhIPD2K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 23:28:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3xcu008470
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 20:26:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TrKswyabFGPYNZBn76sPJSHWYELV/bI2weYucbHYYRE=;
 b=CQTVOxDvRZ6jwZknCj4LN64GryCrIknmC1SUPFlJ0ncHm64P2Odj8HvWqGGvuKC4hyL1
 eCRmxJ9ZREybT2WpS03+R8aStiiEyKfl/7ZoJBGOrZ8CPDfvsEWlOwyoRYcNWM6Pcjyo
 okpyFFGQzmNAm0R0KEOCt8CqbGM0XlQSnAI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3dkwejnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 20:26:51 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 20:26:49 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id D40453A34B04; Wed, 15 Sep 2021 20:26:42 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH v5 bpf-next 3/3] selftests/bpf: pin some tests to worker 0
Date:   Wed, 15 Sep 2021 20:26:41 -0700
Message-ID: <20210916032641.1413293-4-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916032641.1413293-1-fallentree@fb.com>
References: <20210916032641.1413293-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: y2Pcl6Db2YqKdeTrJJEM_efdV9sefG0E
X-Proofpoint-ORIG-GUID: y2Pcl6Db2YqKdeTrJJEM_efdV9sefG0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_01,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxlogscore=787 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch modify some tests to provide serial_test_name() instead of
test_name() to indicate it must run on worker 0. On encountering these te=
sts,
all other threads will wait on a conditional variable, which worker 0 wil=
l
signal once the tests has finished running.

Additionally, before running the test, thread 0 also check and wait until=
 all
other threads has finished their current work, to make sure the pinned te=
st
really are the only test running in the system.

After this change, all tests should pass in '-j' mode.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |   2 +-
 .../bpf/prog_tests/select_reuseport.c         |   2 +-
 .../testing/selftests/bpf/prog_tests/timer.c  |   2 +-
 .../selftests/bpf/prog_tests/xdp_bonding.c    |   2 +-
 .../selftests/bpf/prog_tests/xdp_link.c       |   2 +-
 tools/testing/selftests/bpf/test_progs.c      | 112 ++++++++++++++----
 6 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_obj_id.c
index 284d5921c345..eb8eeebe6935 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -3,7 +3,7 @@
=20
 #define nr_iters 2
=20
-void test_bpf_obj_id(void)
+void serial_test_bpf_obj_id(void)
 {
 	const __u64 array_magic_value =3D 0xfaceb00c;
 	const __u32 array_key =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/=
tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 4efd337d6a3c..b5a0b7ed4310 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -858,7 +858,7 @@ void test_map_type(enum bpf_map_type mt)
 	cleanup();
 }
=20
-void test_select_reuseport(void)
+void serial_test_select_reuseport(void)
 {
 	saved_tcp_fo =3D read_int_sysctl(TCP_FO_SYSCTL);
 	if (saved_tcp_fo < 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testi=
ng/selftests/bpf/prog_tests/timer.c
index 25f40e1b9967..bbd074d407fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -39,7 +39,7 @@ static int timer(struct timer *timer_skel)
 	return 0;
 }
=20
-void test_timer(void)
+void serial_test_timer(void)
 {
 	struct timer *timer_skel =3D NULL;
 	int err;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools=
/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 370d220288a6..bb6e0d0c5f79 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -468,7 +468,7 @@ static struct bond_test_case bond_test_cases[] =3D {
 	{ "xdp_bonding_xor_layer34", BOND_MODE_XOR, BOND_XMIT_POLICY_LAYER34, }=
,
 };
=20
-void test_xdp_bonding(void)
+void serial_test_xdp_bonding(void)
 {
 	libbpf_print_fn_t old_print_fn;
 	struct skeletons skeletons =3D {};
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/te=
sting/selftests/bpf/prog_tests/xdp_link.c
index 46eed0a33c23..983ab0b47d30 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -6,7 +6,7 @@
=20
 #define IFINDEX_LO 1
=20
-void test_xdp_link(void)
+void serial_test_xdp_link(void)
 {
 	__u32 duration =3D 0, id1, id2, id0 =3D 0, prog_fd1, prog_fd2, err;
 	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts, .old_fd =3D -1);
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 77ed9204cc4a..c980ed766947 100644
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
@@ -457,14 +458,17 @@ static int load_bpf_testmod(void)
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
@@ -835,6 +839,7 @@ void sigint_handler(int signum) {
 static int current_test_idx =3D 0;
 static pthread_mutex_t current_test_lock;
 static pthread_mutex_t stdout_output_lock;
+static pthread_cond_t wait_for_worker0 =3D PTHREAD_COND_INITIALIZER;
=20
 struct test_result {
 	int error_cnt;
@@ -901,7 +906,10 @@ static void run_one_test(int test_num) {
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
@@ -925,6 +933,11 @@ static const char *get_test_name(int idx)
 	return test->test_name;
 }
=20
+static inline bool is_serial_test(int idx)
+{
+	return prog_test_defs[idx].run_serial_test !=3D NULL;
+}
+
 struct dispatch_data {
 	int worker_id;
 	int sock_fd;
@@ -943,6 +956,8 @@ void *dispatch_thread(void *ctx)
 		struct prog_test_def *test;
 		struct test_result *result;
=20
+		env.worker_current_test[data->worker_id] =3D -1;
+
 		/* grab a test */
 		{
 			pthread_mutex_lock(&current_test_lock);
@@ -954,15 +969,42 @@ void *dispatch_thread(void *ctx)
=20
 			test =3D &prog_test_defs[current_test_idx];
 			test_to_run =3D current_test_idx;
-			current_test_idx++;
=20
-			pthread_mutex_unlock(&current_test_lock);
-		}
+			test =3D &prog_test_defs[test_to_run];
=20
-		if (!test->should_run) {
-			continue;
-		}
+			if (!test->should_run) {
+				current_test_idx++;
+				pthread_mutex_unlock(&current_test_lock);
+				goto next;
+			}
+
+			if (is_serial_test(current_test_idx)) {
+				if (data->worker_id !=3D 0) {
+					if (env.debug)
+						fprintf(stderr, "[%d]: Waiting for thread 0 to finish serialized t=
est: %d.\n",
+							data->worker_id, current_test_idx + 1);
+					/* wait for worker 0 to pick this job up and finish */
+					pthread_cond_wait(&wait_for_worker0, &current_test_lock);
+					pthread_mutex_unlock(&current_test_lock);
+					goto next;
+				} else {
+					/* wait until all other worker has parked */
+					for (int i =3D 1; i < env.workers; i++) {
+						if (env.worker_current_test[i] !=3D -1) {
+							if (env.debug)
+								fprintf(stderr, "[%d]: Waiting for other threads to finish curre=
nt test...\n", data->worker_id);
+							pthread_mutex_unlock(&current_test_lock);
+							usleep(1 * 1000 * 1000);
+							goto next;
+						}
+					}
+				}
+			} else {
+				current_test_idx++;
+			}
=20
+			pthread_mutex_unlock(&current_test_lock);
+		}
=20
 		/* run test through worker */
 		{
@@ -1035,6 +1077,14 @@ void *dispatch_thread(void *ctx)
 			}
=20
 		} /* wait for test done */
+
+		/* unblock all other dispatcher threads */
+		if (is_serial_test(test_to_run) && data->worker_id =3D=3D 0) {
+			current_test_idx++;
+			pthread_cond_broadcast(&wait_for_worker0);
+		}
+next:
+	continue;
 	} /* while (true) */
 error:
 	if (env.debug)
@@ -1060,16 +1110,19 @@ static int server_main(void)
 {
 	pthread_t *dispatcher_threads;
 	struct dispatch_data *data;
+	int all_finished =3D false;
=20
 	dispatcher_threads =3D calloc(sizeof(pthread_t), env.workers);
 	data =3D calloc(sizeof(struct dispatch_data), env.workers);
=20
 	env.worker_current_test =3D calloc(sizeof(int), env.workers);
+
 	for (int i =3D 0; i < env.workers; i++) {
 		int rc;
=20
 		data[i].worker_id =3D i;
 		data[i].sock_fd =3D env.worker_socks[i];
+		env.worker_current_test[i] =3D -1;
 		rc =3D pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &=
data[i]);
 		if (rc < 0) {
 			perror("Failed to launch dispatcher thread");
@@ -1078,19 +1131,28 @@ static int server_main(void)
 	}
=20
 	/* wait for all dispatcher to finish */
-	for (int i =3D 0; i < env.workers; i++) {
-		while (true) {
-			struct timespec timeout =3D {
-				.tv_sec =3D time(NULL) + 5,
-				.tv_nsec =3D 0
-			};
-			if (pthread_timedjoin_np(dispatcher_threads[i], NULL, &timeout) !=3D =
ETIMEDOUT)
-				break;
-			if (env.debug)
-				fprintf(stderr, "Still waiting for thread %d (test %d).\n",
-					i,  env.worker_current_test[i] + 1);
+	while (!all_finished) {
+		all_finished =3D true;
+		for (int i =3D 0; i < env.workers; i++) {
+			if (!dispatcher_threads[i])
+				continue;
+
+			if (pthread_tryjoin_np(dispatcher_threads[i], NULL) =3D=3D EBUSY) {
+				all_finished =3D false;
+				if (!env.debug) continue;
+				if (env.worker_current_test[i] =3D=3D -1)
+					fprintf(stderr, "Still waiting for thread %d (blocked by thread 0).=
\n", i);
+				else
+					fprintf(stderr, "Still waiting for thread %d (test #%d:%s).\n",
+						i, env.worker_current_test[i] + 1,
+						get_test_name(env.worker_current_test[i]));
+			} else {
+				dispatcher_threads[i] =3D 0;
+			}
 		}
+		usleep(10 * 1000 * 1000);
 	}
+
 	free(dispatcher_threads);
 	free(env.worker_current_test);
 	free(data);
@@ -1326,6 +1388,12 @@ int main(int argc, char **argv)
 			test->should_run =3D true;
 		else
 			test->should_run =3D false;
+
+		if (test->run_test =3D=3D NULL && test->run_serial_test =3D=3D NULL) {
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

