Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7A409D40
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbhIMTkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 15:40:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242192AbhIMTkc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 15:40:32 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DH3k70027733
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 12:39:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LUpdezofHAcX6ebpNw1fDf59yQYEvBNFN7zZfxYjuCM=;
 b=FEkXsiYNdtfFhFdX4exT1yvyj1/bUe4zaXiHIzMt+lGQxOlnUW2ATPqgl++1tBWKgXug
 QxGoxMLmC5MWk26dO6OAGGz/HIIJ5Ipgk0Clv5lZ3fj84pKc+tTpcPVOuWHoJCmJvWK8
 DXUoOgrTRlL5lcYlldGNfzHwu4ZwhmvRNIU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1vwnwfhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 12:39:16 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 12:39:15 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 76DB537AD02C; Mon, 13 Sep 2021 12:39:07 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH v4 bpf-next 3/3] selftests/bpf: pin some tests to worker 0
Date:   Mon, 13 Sep 2021 12:39:06 -0700
Message-ID: <20210913193906.2813357-3-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913193906.2813357-1-fallentree@fb.com>
References: <20210913193906.2813357-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: SrEU75M_VCPawzUlE5qMRU5_Fdf8VHsO
X-Proofpoint-GUID: SrEU75M_VCPawzUlE5qMRU5_Fdf8VHsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch adds a simple name list to pin some tests that fail to run in
parallel to worker 0. On encountering these tests, all other threads will=
 wait
on a conditional variable, which worker 0 will signal once the tests has
finished running.

Additionally, before running the test, thread 0 also check and wait until=
 all
other threads has finished their work, to make sure the pinned test reall=
y are
the only test running in the system.

After this change, all tests should pass in '-j' mode.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 109 ++++++++++++++++++++---
 1 file changed, 97 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index f0eeb17c348d..dc72b3f526a6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -18,6 +18,16 @@
 #include <sys/socket.h>
 #include <sys/un.h>
=20
+char *TESTS_MUST_SERIALIZE[] =3D {
+	"netcnt",
+	"select_reuseport",
+	"sockmap_listen",
+	"tc_redirect",
+	"xdp_bonding",
+	"xdp_info",
+	NULL,
+};
+
 /* Adapted from perf/util/string.c */
 static bool glob_match(const char *str, const char *pat)
 {
@@ -821,6 +831,7 @@ void crash_handler(int signum)
=20
 int current_test_idx =3D 0;
 pthread_mutex_t current_test_lock;
+pthread_cond_t wait_for_worker0 =3D PTHREAD_COND_INITIALIZER;
=20
 struct test_result {
 	int error_cnt;
@@ -887,6 +898,29 @@ struct dispatch_data {
 	int sock;
 };
=20
+static const char *get_test_name(int idx)
+{
+	struct prog_test_def *test;
+
+	test =3D &prog_test_defs[idx];
+	return test->test_name;
+}
+
+bool is_test_must_serialize(int idx)
+{
+	struct prog_test_def *test;
+	char **p;
+
+	test =3D &prog_test_defs[idx];
+	p =3D &TESTS_MUST_SERIALIZE[0];
+	while (*p !=3D NULL) {
+		if (strcmp(*p, test->test_name) =3D=3D 0)
+			return true;
+		p++;
+	}
+	return false;
+}
+
 void *dispatch_thread(void *_data)
 {
 	struct dispatch_data *data;
@@ -901,6 +935,8 @@ void *dispatch_thread(void *_data)
 		struct prog_test_def *test;
 		struct test_result *result;
=20
+		env.worker_current_test[data->idx] =3D -1;
+
 		/* grab a test */
 		{
 			pthread_mutex_lock(&current_test_lock);
@@ -909,8 +945,31 @@ void *dispatch_thread(void *_data)
 				pthread_mutex_unlock(&current_test_lock);
 				goto done;
 			}
+
 			test_to_run =3D current_test_idx;
-			current_test_idx++;
+
+			if (is_test_must_serialize(current_test_idx)) {
+				if (data->idx !=3D 0) {
+					fprintf(stderr, "[%d]: Waiting for thread 0 to finish serialized te=
st: %d.\n",
+						data->idx, current_test_idx + 1);
+					/* wait for worker 0 to pick this job up and finish */
+					pthread_cond_wait(&wait_for_worker0, &current_test_lock);
+					pthread_mutex_unlock(&current_test_lock);
+					goto next;
+				} else {
+					/* wait until all other worker has parked */
+					for (int i =3D 1; i < env.workers; i++) {
+						if (env.worker_current_test[i] !=3D -1) {
+							fprintf(stderr, "[%d]: Waiting for other threads to finish curren=
t test...\n", data->idx);
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
 			pthread_mutex_unlock(&current_test_lock);
 		}
@@ -975,7 +1034,15 @@ void *dispatch_thread(void *_data)
 				fclose(log_fd);
 				log_fd =3D NULL;
 			}
+		} /* wait for test done */
+
+		/* unblock all other dispatcher threads */
+		if (is_test_must_serialize(test_to_run) && data->idx =3D=3D 0) {
+			current_test_idx++;
+			pthread_cond_broadcast(&wait_for_worker0);
 		}
+next:
+	continue;
 	} /* while (true) */
 error:
 	fprintf(stderr, "[%d]: Protocol/IO error: %s", data->idx, strerror(errn=
o));
@@ -997,16 +1064,19 @@ int server_main(void)
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
 		data[i].idx =3D i;
 		data[i].sock =3D env.worker_socks[i];
+		env.worker_current_test[i] =3D -1;
 		rc =3D pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &=
data[i]);
 		if (rc < 0) {
 			perror("Failed to launch dispatcher thread");
@@ -1015,17 +1085,27 @@ int server_main(void)
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
-			fprintf(stderr, "Still waiting for thread %d (test %d).\n", i,  env.w=
orker_current_test[i] + 1);
+	while (!all_finished) {
+		all_finished =3D true;
+		for (int i =3D 0; i < env.workers; i++) {
+			if (!dispatcher_threads[i])
+				continue;
+
+			if (pthread_tryjoin_np(dispatcher_threads[i], NULL) =3D=3D EBUSY) {
+				all_finished =3D false;
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
@@ -1100,8 +1180,11 @@ int worker_main(int sock)
=20
 			test_to_run =3D msg.u.message_do_test.num;
=20
-			fprintf(stderr, "[%d]: Running test %d.\n",
-				env.worker_index, test_to_run + 1);
+			if (env.verbosity > VERBOSE_NONE)
+				fprintf(stderr, "[%d]: #%d:%s running.\n",
+					env.worker_index,
+					test_to_run + 1,
+					get_test_name(test_to_run));
=20
 			test =3D &prog_test_defs[test_to_run];
=20
@@ -1172,6 +1255,8 @@ int worker_main(int sock)
 				env.log_buf =3D NULL;
 				env.log_cnt =3D 0;
 			}
+			fprintf(stderr, "[%d]: #%d:%s done.\n",
+				env.worker_index, test_to_run + 1, get_test_name(test_to_run));
 			break;
 		} /* case MSG_DO_TEST */
 		default:
--=20
2.30.2

