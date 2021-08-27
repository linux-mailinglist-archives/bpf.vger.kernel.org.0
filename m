Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC63FA1BC
	for <lists+bpf@lfdr.de>; Sat, 28 Aug 2021 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhH0XOE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Aug 2021 19:14:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232252AbhH0XOE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Aug 2021 19:14:04 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17RN8sK8013985
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 16:13:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=iSbBmvN20EH37ifNr1eT7G0V6EdOzQVFVuFF2oqaxRo=;
 b=Zvn3kQZ51yDIfT3YyrSOIoIpnw9XjO0KmiTpIciMovLpTO+Jc9V9j7o9vB6uSz5vTGSh
 qLnB2Lk/SGoSWL6s21X5eBig+yUTCGu707prv7pv7Epd/71HHc+PRX33kvPmegSicoAD
 HWXEjTJlIA68OJTaYVcEpF1USq3YZuIlqUQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3apmvtq4vc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 16:13:14 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 27 Aug 2021 16:13:13 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 29C032B99AFC; Fri, 27 Aug 2021 16:13:08 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>
Subject: [RFC 1/1] selftests/bpf: Add parallelism to test_progs
Date:   Fri, 27 Aug 2021 16:13:07 -0700
Message-ID: <20210827231307.3787723-2-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210827231307.3787723-1-fallentree@fb.com>
References: <20210827231307.3787723-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: FJStnRF57ffvxPbZLw2Ymmcfe2uPjteb
X-Proofpoint-GUID: FJStnRF57ffvxPbZLw2Ymmcfe2uPjteb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_07:2021-08-27,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=969 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch adds "-p" parameter to test_progs, which will spawn workers an=
d
distribute tests evenly among all workers, speeding up execution.

"-p" mode is optional, and works with all existing test selection mechani=
sm,
including "-l".

Each worker print its own summary and exit with its own status, the main
process will collect all status together and exit with a overall status.
---
 tools/testing/selftests/bpf/test_progs.c | 94 ++++++++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h |  3 +
 2 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index cc1cd240445d..740698360526 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -474,6 +474,7 @@ enum ARG_KEYS {
 	ARG_LIST_TEST_NAMES =3D 'l',
 	ARG_TEST_NAME_GLOB_ALLOWLIST =3D 'a',
 	ARG_TEST_NAME_GLOB_DENYLIST =3D 'd',
+	ARG_NUM_WORKERS =3D 'p',
 };
=20
 static const struct argp_option opts[] =3D {
@@ -494,7 +495,9 @@ static const struct argp_option opts[] =3D {
 	{ "allow", ARG_TEST_NAME_GLOB_ALLOWLIST, "NAMES", 0,
 	  "Run tests with name matching the pattern (supports '*' wildcard)." }=
,
 	{ "deny", ARG_TEST_NAME_GLOB_DENYLIST, "NAMES", 0,
-	  "Don't run tests with name matching the pattern (supports '*' wildcar=
d)." },
+	    "Don't run tests with name matching the pattern (supports '*' wildc=
ard)." },
+	{ "workers", ARG_NUM_WORKERS, "WORKERS", 0,
+	  "Number of workers to run in parallel, default to 1." },
 	{},
 };
=20
@@ -661,6 +664,13 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
 	case ARG_LIST_TEST_NAMES:
 		env->list_test_names =3D true;
 		break;
+	case ARG_NUM_WORKERS:
+		env->workers =3D atoi(arg);
+		if (!env->workers) {
+			fprintf(stderr, "Invalid worker number, must be bigger than 1.");
+			return -1;
+		}
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -694,6 +704,10 @@ static void stdio_hijack(void)
 	}
=20
 	stderr =3D stdout;
+
+	/* force line buffering on stdio, so they interleave naturally. */
+	setvbuf(stdout, NULL, _IOLBF, 8192);
+	setvbuf(stderr, NULL, _IOLBF, 8192);
 #endif
 }
=20
@@ -798,14 +812,74 @@ int main(int argc, char **argv)
 		return -1;
 	}
=20
-	save_netns();
-	stdio_hijack();
 	env.has_testmod =3D true;
 	if (!env.list_test_names && load_bpf_testmod()) {
 		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will=
 be skipped.\n");
 		env.has_testmod =3D false;
 	}
+
+	/* launch workers if requested */
+	env.worker_index =3D -1; /* main process */
+	if (env.workers) {
+		env.worker_pids =3D calloc(sizeof(__pid_t), env.workers);
+		fprintf(stdout, "Launching %d workers.\n", env.workers);
+		for(int i =3D 0; i < env.workers; i++) {
+			__pid_t pid =3D fork();
+			if (pid < 0) {
+				perror("Failed to fork worker");
+				return -1;
+			} else if (pid !=3D 0) {
+				env.worker_pids[i] =3D pid;
+			} else {
+				env.worker_index =3D i;
+				fprintf(stdout, "[%d] worker launched with pid %d.\n", i, getpid());
+				break;
+			}
+		}
+	}
+
+	/* If we have worker, here is the rest of the main process */
+	if (env.workers && env.worker_index =3D=3D -1)  {
+		int abnormal_exit_cnt =3D 0;
+		for(int i =3D 0; i < env.workers; i++) {
+			int status;
+			assert(waitpid(env.worker_pids[i], &status, 0) =3D=3D env.worker_pids=
[i]);
+			if (WIFEXITED(status)) {
+				switch (WEXITSTATUS(status)) {
+				case EXIT_SUCCESS:
+					env.succ_cnt++;
+					break;
+					case EXIT_FAILURE:
+					env.fail_cnt++;
+					break;
+					case EXIT_NO_TEST:
+					env.skip_cnt++;
+					break;
+				}
+			} else {
+				abnormal_exit_cnt++;
+				env.fail_cnt++;
+			}
+		}
+		fprintf(stdout, "Worker Summary: %d SUCCESS, %d FAILED, %d IDLE",
+			env.succ_cnt, env.fail_cnt, env.skip_cnt);
+		fprintf(stdout, "\n");
+
+		goto main_out;
+	}
+
+	/* no worker, or inside each worker process */
+	// sigaction(SIGSEGV, &sigact, NULL); /* set crash handler again */
+
+	save_netns();
+	stdio_hijack();
+
 	for (i =3D 0; i < prog_test_cnt; i++) {
+		/* skip tests not assigned to this worker */
+		if (env.workers) {
+			if (i % env.workers !=3D env.worker_index)
+				continue;
+		}
 		struct prog_test_def *test =3D &prog_test_defs[i];
=20
 		env.test =3D test;
@@ -821,6 +895,8 @@ int main(int argc, char **argv)
 		}
=20
 		if (env.list_test_names) {
+			if (env.worker_index !=3D -1)
+				fprintf(env.stdout, "[%d] ", env.worker_index);
 			fprintf(env.stdout, "%s\n", test->test_name);
 			env.succ_cnt++;
 			continue;
@@ -835,6 +911,8 @@ int main(int argc, char **argv)
=20
 		dump_test_log(test, test->error_cnt);
=20
+		if (env.worker_index !=3D -1)
+			fprintf(env.stdout, "[%d] ", env.worker_index);
 		fprintf(env.stdout, "#%d %s:%s\n",
 			test->test_num, test->test_name,
 			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
@@ -850,8 +928,6 @@ int main(int argc, char **argv)
 		if (test->need_cgroup_cleanup)
 			cleanup_cgroup_environment();
 	}
-	if (!env.list_test_names && env.has_testmod)
-		unload_bpf_testmod();
 	stdio_restore();
=20
 	if (env.get_test_cnt) {
@@ -862,17 +938,23 @@ int main(int argc, char **argv)
 	if (env.list_test_names)
 		goto out;
=20
+	if (env.worker_index !=3D -1)
+		fprintf(env.stdout, "[%d] ", env.worker_index);
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
 out:
+	close(env.saved_netns_fd);
+main_out:
+	if (env.worker_index =3D=3D -1)
+		if (!env.list_test_names && env.has_testmod)
+			unload_bpf_testmod();
 	free_str_set(&env.test_selector.blacklist);
 	free_str_set(&env.test_selector.whitelist);
 	free(env.test_selector.num_set);
 	free_str_set(&env.subtest_selector.blacklist);
 	free_str_set(&env.subtest_selector.whitelist);
 	free(env.subtest_selector.num_set);
-	close(env.saved_netns_fd);
=20
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt =3D=3D 0)
 		return EXIT_NO_TEST;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index c8c2bf878f67..c55274a3b767 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -82,6 +82,9 @@ struct test_env {
 	int skip_cnt; /* skipped tests */
=20
 	int saved_netns_fd;
+	int workers; /* number of worker process */
+	__pid_t *worker_pids; /* array of worker pids */
+	int worker_index;
 };
=20
 extern struct test_env env;
--=20
2.30.2

