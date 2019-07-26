Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF1772E0
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2019 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfGZUiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jul 2019 16:38:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727614AbfGZUiP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Jul 2019 16:38:15 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QKTUGZ018378
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2019 13:38:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=fLoRhno6RwpCjun1BNHfUU7//P9rDYuCkz5e5ugkH3A=;
 b=ZeMw0cPRB/w2QHyT6OVtUmYGa6z/yfdwjpRE/18Uaw0xoliQgzWNRgMZ/2zVtNL0/7RN
 j/Zxm7Bbi0aWzJIYQYxLQfY993sOTjIheJM18bGtCemUc/LEN4b4wgRdrLvVskiDHpGI
 4zZeFsPc6cJZgIPJ26UbeyJxvV6g8URf1Yg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u07510bnu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2019 13:38:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Jul 2019 13:38:08 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 0974C861663; Fri, 26 Jul 2019 13:38:03 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 5/9] selftest/bpf: centralize libbpf logging management for test_progs
Date:   Fri, 26 Jul 2019 13:37:43 -0700
Message-ID: <20190726203747.1124677-6-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726203747.1124677-1-andriin@fb.com>
References: <20190726203747.1124677-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260234
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make test_progs test runner own libbpf logging. Also introduce two
levels of verbosity: -v and -vv. First one will be used in subsequent
patches to enable test log output always. Second one increases verbosity
level of libbpf logging further to include debug output as well.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |  6 +++-
 .../bpf/prog_tests/reference_tracking.c       | 15 +++-------
 tools/testing/selftests/bpf/test_progs.c      | 29 +++++++++++++++++++
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index e1b55261526f..2c4d9ef099b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -70,10 +70,11 @@ void test_bpf_verif_scale(void)
 	const char *cg_sysctl[] = {
 		"./test_sysctl_loop1.o", "./test_sysctl_loop2.o",
 	};
+	libbpf_print_fn_t old_print_fn = NULL;
 	int err, i;
 
 	if (verifier_stats)
-		libbpf_set_print(libbpf_debug_print);
+		old_print_fn = libbpf_swap_print(libbpf_debug_print);
 
 	err = check_load("./loop3.o", BPF_PROG_TYPE_RAW_TRACEPOINT);
 	printf("test_scale:loop3:%s\n", err ? (error_cnt--, "OK") : "FAIL");
@@ -97,4 +98,7 @@ void test_bpf_verif_scale(void)
 
 	err = check_load("./test_seg6_loop.o", BPF_PROG_TYPE_LWT_SEG6LOCAL);
 	printf("test_scale:test_seg6_loop:%s\n", err ? "FAIL" : "OK");
+
+	if (verifier_stats)
+		libbpf_set_print(old_print_fn);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index 5633be43828f..c9a6ef809bd1 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -1,15 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 
-static int libbpf_debug_print(enum libbpf_print_level level,
-			      const char *format, va_list args)
-{
-	if (level == LIBBPF_DEBUG)
-		return 0;
-
-	return vfprintf(stderr, format, args);
-}
-
 void test_reference_tracking(void)
 {
 	const char *file = "./test_sk_lookup_kern.o";
@@ -36,9 +27,11 @@ void test_reference_tracking(void)
 
 		/* Expect verifier failure if test name has 'fail' */
 		if (strstr(title, "fail") != NULL) {
-			libbpf_set_print(NULL);
+			libbpf_print_fn_t old_print_fn;
+
+			old_print_fn = libbpf_swap_print(NULL);
 			err = !bpf_program__load(prog, "GPL", 0);
-			libbpf_set_print(libbpf_debug_print);
+			libbpf_set_print(old_print_fn);
 		} else {
 			err = bpf_program__load(prog, "GPL", 0);
 		}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 6e04b9f83777..94b6951b90b3 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -186,6 +186,8 @@ enum ARG_KEYS {
 	ARG_TEST_NUM = 'n',
 	ARG_TEST_NAME = 't',
 	ARG_VERIFIER_STATS = 's',
+
+	ARG_VERBOSE = 'v',
 };
 	
 static const struct argp_option opts[] = {
@@ -195,6 +197,8 @@ static const struct argp_option opts[] = {
 	  "Run tests with names containing NAME" },
 	{ "verifier-stats", ARG_VERIFIER_STATS, NULL, 0,
 	  "Output verifier statistics", },
+	{ "verbose", ARG_VERBOSE, "LEVEL", OPTION_ARG_OPTIONAL,
+	  "Verbose output (use -vv for extra verbose output)" },
 	{},
 };
 
@@ -202,12 +206,22 @@ struct test_env {
 	int test_num_selector;
 	const char *test_name_selector;
 	bool verifier_stats;
+	bool verbose;
+	bool very_verbose;
 };
 
 static struct test_env env = {
 	.test_num_selector = -1,
 };
 
+static int libbpf_print_fn(enum libbpf_print_level level,
+			   const char *format, va_list args)
+{
+	if (!env.very_verbose && level == LIBBPF_DEBUG)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
 	struct test_env *env = state->input;
@@ -229,6 +243,19 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case ARG_VERIFIER_STATS:
 		env->verifier_stats = true;
 		break;
+	case ARG_VERBOSE:
+		if (arg) {
+			if (strcmp(arg, "v") == 0) {
+				env->very_verbose = true;
+			} else {
+				fprintf(stderr,
+					"Unrecognized verbosity setting ('%s'), only -v and -vv are supported\n",
+					arg);
+				return -EINVAL;
+			}
+		}
+		env->verbose = true;
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -255,6 +282,8 @@ int main(int argc, char **argv)
 	if (err)
 		return err;
 
+	libbpf_set_print(libbpf_print_fn);
+
 	srand(time(NULL));
 
 	jit_enabled = is_jit_enabled();
-- 
2.17.1

