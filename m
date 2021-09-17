Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3B40F1E7
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 08:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhIQGLx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 17 Sep 2021 02:11:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232726AbhIQGLx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 02:11:53 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GJ00jn019273
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 23:10:32 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4bpnua6h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 23:10:31 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 23:10:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1778C4392FD0; Thu, 16 Sep 2021 23:10:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/9] selftests/bpf: normalize SEC("classifier") usage
Date:   Thu, 16 Sep 2021 23:10:13 -0700
Message-ID: <20210917061020.821711-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917061020.821711-1-andrii@kernel.org>
References: <20210917061020.821711-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: iSYfsCuXnvXwX2wjk5SusTnV8iZLEzHL
X-Proofpoint-ORIG-GUID: iSYfsCuXnvXwX2wjk5SusTnV8iZLEzHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_03,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1034 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert all SEC("classifier*") uses to strict SEC("classifier") with no
extra characters. In reference_tracking selftests also drop the usage of
broken bpf_program__load(). Along the way switch from ambiguous searching by
program title (section name) to non-ambiguous searching by name in some
selftests, getting closer to completely removing
bpf_object__find_program_by_title().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/reference_tracking.c       | 29 +++++++---
 .../selftests/bpf/prog_tests/sk_assign.c      |  2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 58 +++++++++----------
 .../testing/selftests/bpf/progs/skb_pkt_end.c |  2 +-
 tools/testing/selftests/bpf/progs/tailcall1.c |  5 +-
 tools/testing/selftests/bpf/progs/tailcall2.c | 21 ++++---
 tools/testing/selftests/bpf/progs/tailcall3.c |  5 +-
 tools/testing/selftests/bpf/progs/tailcall4.c |  5 +-
 tools/testing/selftests/bpf/progs/tailcall5.c |  5 +-
 tools/testing/selftests/bpf/progs/tailcall6.c |  4 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf1.c   |  5 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |  5 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf3.c   |  9 ++-
 .../selftests/bpf/progs/tailcall_bpf2bpf4.c   | 13 ++---
 .../bpf/progs/test_btf_skc_cls_ingress.c      |  2 +-
 .../selftests/bpf/progs/test_cls_redirect.c   |  2 +-
 .../selftests/bpf/progs/test_global_data.c    |  2 +-
 .../selftests/bpf/progs/test_global_func1.c   |  2 +-
 .../selftests/bpf/progs/test_global_func3.c   |  2 +-
 .../selftests/bpf/progs/test_global_func5.c   |  2 +-
 .../selftests/bpf/progs/test_global_func6.c   |  2 +-
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 .../selftests/bpf/progs/test_pkt_access.c     |  2 +-
 .../selftests/bpf/progs/test_pkt_md_access.c  |  4 +-
 .../selftests/bpf/progs/test_sk_assign.c      |  3 +-
 .../selftests/bpf/progs/test_sk_lookup_kern.c | 37 ++++++------
 .../selftests/bpf/progs/test_skb_helpers.c    |  2 +-
 .../selftests/bpf/progs/test_sockmap_update.c |  2 +-
 .../selftests/bpf/progs/test_tc_neigh.c       |  6 +-
 .../selftests/bpf/progs/test_tc_neigh_fib.c   |  6 +-
 .../selftests/bpf/progs/test_tc_peer.c        | 10 ++--
 31 files changed, 127 insertions(+), 129 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index 4e91f4d6466c..e7bb757343ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -24,27 +24,38 @@ void test_reference_tracking(void)
 		goto cleanup;
 
 	bpf_object__for_each_program(prog, obj) {
-		const char *title;
+		const char *name;
+		struct bpf_object *test_obj;
+		struct bpf_program *test_prog;
 
 		/* Ignore .text sections */
-		title = bpf_program__section_name(prog);
-		if (strstr(title, ".text") != NULL)
+		name = bpf_program__name(prog);
+		if (!test__start_subtest(name))
 			continue;
 
-		if (!test__start_subtest(title))
-			continue;
+		test_obj = bpf_object__open_file(file, &open_opts);
+		if (!ASSERT_OK_PTR(test_obj, "test_obj"))
+			goto cleanup;
+
+		/* disable all but the chosen program */
+		bpf_object__for_each_program(test_prog, test_obj) {
+			if (strcmp(bpf_program__name(test_prog), name))
+				bpf_program__set_autoload(test_prog, false);
+		}
 
 		/* Expect verifier failure if test name has 'err' */
-		if (strstr(title, "err_") != NULL) {
+		if (strncmp(name, "err_", sizeof("err_") - 1) == 0) {
 			libbpf_print_fn_t old_print_fn;
 
 			old_print_fn = libbpf_set_print(NULL);
-			err = !bpf_program__load(prog, "GPL", 0);
+			err = !bpf_object__load(test_obj);
 			libbpf_set_print(old_print_fn);
 		} else {
-			err = bpf_program__load(prog, "GPL", 0);
+			err = bpf_object__load(test_obj);
 		}
-		CHECK(err, title, "\n");
+		ASSERT_OK(err, name);
+
+		bpf_object__close(test_obj);
 	}
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 3a469099f30d..7ad3262ea339 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -48,7 +48,7 @@ configure_stack(void)
 		return false;
 	sprintf(tc_cmd, "%s %s %s %s", "tc filter add dev lo ingress bpf",
 		       "direct-action object-file ./test_sk_assign.o",
-		       "section classifier/sk_assign_test",
+		       "section classifier",
 		       (env.verbosity < VERBOSE_VERY) ? " 2>/dev/null" : "verbose");
 	if (CHECK(system(tc_cmd), "BPF load failed;",
 		  "run with -vv for more info\n"))
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 7bf3a7a97d7b..9825f1f7bfcc 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -21,7 +21,7 @@ static void test_tailcall_1(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -38,9 +38,9 @@ static void test_tailcall_1(void)
 		goto out;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -70,9 +70,9 @@ static void test_tailcall_1(void)
 	      err, errno, retval);
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -92,9 +92,9 @@ static void test_tailcall_1(void)
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
 		j = bpf_map__def(prog_array)->max_entries - 1 - i;
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", j);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", j);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -159,7 +159,7 @@ static void test_tailcall_2(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -176,9 +176,9 @@ static void test_tailcall_2(void)
 		goto out;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -233,7 +233,7 @@ static void test_tailcall_count(const char *which)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -249,7 +249,7 @@ static void test_tailcall_count(const char *which)
 	if (CHECK_FAIL(map_fd < 0))
 		goto out;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier/0");
+	prog = bpf_object__find_program_by_name(obj, "classifier_0");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -329,7 +329,7 @@ static void test_tailcall_4(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -354,9 +354,9 @@ static void test_tailcall_4(void)
 		return;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -417,7 +417,7 @@ static void test_tailcall_5(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -442,9 +442,9 @@ static void test_tailcall_5(void)
 		return;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -503,7 +503,7 @@ static void test_tailcall_bpf2bpf_1(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -521,9 +521,9 @@ static void test_tailcall_bpf2bpf_1(void)
 
 	/* nop -> jmp */
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -587,7 +587,7 @@ static void test_tailcall_bpf2bpf_2(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -603,7 +603,7 @@ static void test_tailcall_bpf2bpf_2(void)
 	if (CHECK_FAIL(map_fd < 0))
 		goto out;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier/0");
+	prog = bpf_object__find_program_by_name(obj, "classifier_0");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -665,7 +665,7 @@ static void test_tailcall_bpf2bpf_3(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -682,9 +682,9 @@ static void test_tailcall_bpf2bpf_3(void)
 		goto out;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
@@ -762,7 +762,7 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	if (CHECK_FAIL(err))
 		return;
 
-	prog = bpf_object__find_program_by_title(obj, "classifier");
+	prog = bpf_object__find_program_by_name(obj, "entry");
 	if (CHECK_FAIL(!prog))
 		goto out;
 
@@ -779,9 +779,9 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 		goto out;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (CHECK_FAIL(!prog))
 			goto out;
 
diff --git a/tools/testing/selftests/bpf/progs/skb_pkt_end.c b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
index 7f2eaa2f89f8..e8e7f3b89509 100644
--- a/tools/testing/selftests/bpf/progs/skb_pkt_end.c
+++ b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
@@ -25,7 +25,7 @@ static INLINE struct iphdr *get_iphdr(struct __sk_buff *skb)
 	return ip;
 }
 
-SEC("classifier/cls")
+SEC("classifier")
 int main_prog(struct __sk_buff *skb)
 {
 	struct iphdr *ip = NULL;
diff --git a/tools/testing/selftests/bpf/progs/tailcall1.c b/tools/testing/selftests/bpf/progs/tailcall1.c
index 7115bcefbe8a..3820ab77d0c0 100644
--- a/tools/testing/selftests/bpf/progs/tailcall1.c
+++ b/tools/testing/selftests/bpf/progs/tailcall1.c
@@ -11,8 +11,8 @@ struct {
 } jmp_table SEC(".maps");
 
 #define TAIL_FUNC(x) 				\
-	SEC("classifier/" #x)			\
-	int bpf_func_##x(struct __sk_buff *skb)	\
+	SEC("classifier")			\
+	int classifier_##x(struct __sk_buff *skb)	\
 	{					\
 		return x;			\
 	}
@@ -45,4 +45,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall2.c b/tools/testing/selftests/bpf/progs/tailcall2.c
index 0431e4fe7efd..9d4e4701a597 100644
--- a/tools/testing/selftests/bpf/progs/tailcall2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall2.c
@@ -10,35 +10,35 @@ struct {
 	__uint(value_size, sizeof(__u32));
 } jmp_table SEC(".maps");
 
-SEC("classifier/0")
-int bpf_func_0(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_0(struct __sk_buff *skb)
 {
 	bpf_tail_call_static(skb, &jmp_table, 1);
 	return 0;
 }
 
-SEC("classifier/1")
-int bpf_func_1(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_1(struct __sk_buff *skb)
 {
 	bpf_tail_call_static(skb, &jmp_table, 2);
 	return 1;
 }
 
-SEC("classifier/2")
-int bpf_func_2(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_2(struct __sk_buff *skb)
 {
 	return 2;
 }
 
-SEC("classifier/3")
-int bpf_func_3(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_3(struct __sk_buff *skb)
 {
 	bpf_tail_call_static(skb, &jmp_table, 4);
 	return 3;
 }
 
-SEC("classifier/4")
-int bpf_func_4(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_4(struct __sk_buff *skb)
 {
 	bpf_tail_call_static(skb, &jmp_table, 3);
 	return 4;
@@ -56,4 +56,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall3.c b/tools/testing/selftests/bpf/progs/tailcall3.c
index 910858fe078a..423e6809a6da 100644
--- a/tools/testing/selftests/bpf/progs/tailcall3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall3.c
@@ -12,8 +12,8 @@ struct {
 
 int count = 0;
 
-SEC("classifier/0")
-int bpf_func_0(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_0(struct __sk_buff *skb)
 {
 	count++;
 	bpf_tail_call_static(skb, &jmp_table, 0);
@@ -28,4 +28,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall4.c b/tools/testing/selftests/bpf/progs/tailcall4.c
index bd4be135c39d..82bf8713f1bb 100644
--- a/tools/testing/selftests/bpf/progs/tailcall4.c
+++ b/tools/testing/selftests/bpf/progs/tailcall4.c
@@ -13,8 +13,8 @@ struct {
 int selector = 0;
 
 #define TAIL_FUNC(x)				\
-	SEC("classifier/" #x)			\
-	int bpf_func_##x(struct __sk_buff *skb)	\
+	SEC("classifier")			\
+	int classifier_##x(struct __sk_buff *skb)	\
 	{					\
 		return x;			\
 	}
@@ -30,4 +30,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall5.c b/tools/testing/selftests/bpf/progs/tailcall5.c
index adf30a33064e..6925ef193cc5 100644
--- a/tools/testing/selftests/bpf/progs/tailcall5.c
+++ b/tools/testing/selftests/bpf/progs/tailcall5.c
@@ -13,8 +13,8 @@ struct {
 int selector = 0;
 
 #define TAIL_FUNC(x)				\
-	SEC("classifier/" #x)			\
-	int bpf_func_##x(struct __sk_buff *skb)	\
+	SEC("classifier")			\
+	int classifier_##x(struct __sk_buff *skb)	\
 	{					\
 		return x;			\
 	}
@@ -37,4 +37,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall6.c b/tools/testing/selftests/bpf/progs/tailcall6.c
index 0f4a811cc028..8505981c7f2d 100644
--- a/tools/testing/selftests/bpf/progs/tailcall6.c
+++ b/tools/testing/selftests/bpf/progs/tailcall6.c
@@ -12,8 +12,8 @@ struct {
 
 int count, which;
 
-SEC("classifier/0")
-int bpf_func_0(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_0(struct __sk_buff *skb)
 {
 	count++;
 	if (__builtin_constant_p(which))
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf1.c
index 0103f3dd9f02..ce7886c9207b 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf1.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf1.c
@@ -10,8 +10,8 @@ struct {
 } jmp_table SEC(".maps");
 
 #define TAIL_FUNC(x) 				\
-	SEC("classifier/" #x)			\
-	int bpf_func_##x(struct __sk_buff *skb)	\
+	SEC("classifier")			\
+	int classifier_##x(struct __sk_buff *skb)	\
 	{					\
 		return x;			\
 	}
@@ -35,4 +35,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
index 3cc4c12817b5..bbe350b2ba45 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
@@ -22,8 +22,8 @@ int subprog_tail(struct __sk_buff *skb)
 
 int count = 0;
 
-SEC("classifier/0")
-int bpf_func_0(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_0(struct __sk_buff *skb)
 {
 	count++;
 	return subprog_tail(skb);
@@ -38,4 +38,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
index 0d5482bea6c9..fc00e26502d5 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
@@ -33,16 +33,16 @@ int subprog_tail(struct __sk_buff *skb)
 	return skb->len * 2;
 }
 
-SEC("classifier/0")
-int bpf_func_0(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_0(struct __sk_buff *skb)
 {
 	volatile char arr[128] = {};
 
 	return subprog_tail2(skb);
 }
 
-SEC("classifier/1")
-int bpf_func_1(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_1(struct __sk_buff *skb)
 {
 	volatile char arr[128] = {};
 
@@ -58,4 +58,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
index e89368a50b97..01e95a5c0bb8 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
@@ -50,21 +50,21 @@ int subprog_tail(struct __sk_buff *skb)
 	return skb->len;
 }
 
-SEC("classifier/1")
-int bpf_func_1(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_1(struct __sk_buff *skb)
 {
 	return subprog_tail_2(skb);
 }
 
-SEC("classifier/2")
-int bpf_func_2(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_2(struct __sk_buff *skb)
 {
 	count++;
 	return subprog_tail_2(skb);
 }
 
-SEC("classifier/0")
-int bpf_func_0(struct __sk_buff *skb)
+SEC("classifier")
+int classifier_0(struct __sk_buff *skb)
 {
 	return subprog_tail_1(skb);
 }
@@ -76,4 +76,3 @@ int entry(struct __sk_buff *skb)
 }
 
 char __license[] SEC("license") = "GPL";
-int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
index 9a6b85dd52d2..56aa9389a6c8 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
@@ -145,7 +145,7 @@ static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
-SEC("classifier/ingress")
+SEC("classifier")
 int cls_ingress(struct __sk_buff *skb)
 {
 	struct ipv6hdr *ip6h;
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index e2a5acc4785c..f1f7213f6170 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -928,7 +928,7 @@ static INLINING verdict_t process_ipv6(buf_t *pkt, metrics_t *metrics)
 	}
 }
 
-SEC("classifier/cls_redirect")
+SEC("classifier")
 int cls_redirect(struct __sk_buff *skb)
 {
 	metrics_t *metrics = get_global_metrics();
diff --git a/tools/testing/selftests/bpf/progs/test_global_data.c b/tools/testing/selftests/bpf/progs/test_global_data.c
index 1319be1c54ba..3f435a27f183 100644
--- a/tools/testing/selftests/bpf/progs/test_global_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_data.c
@@ -68,7 +68,7 @@ static struct foo struct3 = {
 		bpf_map_update_elem(&result_##map, &key, var, 0);	\
 	} while (0)
 
-SEC("classifier/static_data_load")
+SEC("classifier")
 int load_static_data(struct __sk_buff *skb)
 {
 	static const __u64 bar = ~0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
index 880260f6d536..2511f9391da9 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -38,7 +38,7 @@ int f3(int val, struct __sk_buff *skb, int var)
 	return skb->ifindex * val * var;
 }
 
-SEC("classifier/test")
+SEC("classifier")
 int test_cls(struct __sk_buff *skb)
 {
 	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 86f0ecb304fc..84ef0df0adf7 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -54,7 +54,7 @@ int f8(struct __sk_buff *skb)
 }
 #endif
 
-SEC("classifier/test")
+SEC("classifier")
 int test_cls(struct __sk_buff *skb)
 {
 #ifndef NO_FN8
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tools/testing/selftests/bpf/progs/test_global_func5.c
index 260c25b827ef..70e660084aed 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -24,7 +24,7 @@ int f3(int val, struct __sk_buff *skb)
 	return skb->ifindex * val;
 }
 
-SEC("classifier/test")
+SEC("classifier")
 int test_cls(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func6.c b/tools/testing/selftests/bpf/progs/test_global_func6.c
index 69e19c64e10b..c886f91bb560 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func6.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func6.c
@@ -24,7 +24,7 @@ int f3(int val, struct __sk_buff *skb)
 	return skb->ifindex * val;
 }
 
-SEC("classifier/test")
+SEC("classifier")
 int test_cls(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func7.c b/tools/testing/selftests/bpf/progs/test_global_func7.c
index 309b3f6136bd..23bb224f8d1a 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func7.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func7.c
@@ -10,7 +10,7 @@ void foo(struct __sk_buff *skb)
 	skb->tc_index = 0;
 }
 
-SEC("classifier/test")
+SEC("classifier")
 int test_cls(struct __sk_buff *skb)
 {
 	foo(skb);
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index 852051064507..b10c473aba26 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -97,7 +97,7 @@ int test_pkt_write_access_subprog(struct __sk_buff *skb, __u32 off)
 	return 0;
 }
 
-SEC("classifier/test_pkt_access")
+SEC("classifier")
 int test_pkt_access(struct __sk_buff *skb)
 {
 	void *data_end = (void *)(long)skb->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
index 610c74ea9f64..a770f3562b9d 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
@@ -7,8 +7,6 @@
 #include <linux/pkt_cls.h>
 #include <bpf/bpf_helpers.h>
 
-int _version SEC("version") = 1;
-
 #if  __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define TEST_FIELD(TYPE, FIELD, MASK)					\
 	{								\
@@ -27,7 +25,7 @@ int _version SEC("version") = 1;
 	}
 #endif
 
-SEC("classifier/test_pkt_md_access")
+SEC("classifier")
 int test_pkt_md_access(struct __sk_buff *skb)
 {
 	TEST_FIELD(__u8,  len, 0xFF);
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 1ecd987005d2..dfc81c18deff 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -36,7 +36,6 @@ struct {
 	.pinning = PIN_GLOBAL_NS,
 };
 
-int _version SEC("version") = 1;
 char _license[] SEC("license") = "GPL";
 
 /* Fill 'tuple' with L3 info, and attempt to find L4. On fail, return NULL. */
@@ -159,7 +158,7 @@ handle_tcp(struct __sk_buff *skb, struct bpf_sock_tuple *tuple, bool ipv4)
 	return ret;
 }
 
-SEC("classifier/sk_assign_test")
+SEC("classifier")
 int bpf_sk_assign_test(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple *tuple, ln = {0};
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
index 8249075f088f..5b2642c21bae 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
@@ -15,7 +15,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-int _version SEC("version") = 1;
 char _license[] SEC("license") = "GPL";
 
 /* Fill 'tuple' with L3 info, and attempt to find L4. On fail, return NULL. */
@@ -53,8 +52,8 @@ static struct bpf_sock_tuple *get_tuple(void *data, __u64 nh_off,
 	return result;
 }
 
-SEC("classifier/sk_lookup_success")
-int bpf_sk_lookup_test0(struct __sk_buff *skb)
+SEC("classifier")
+int sk_lookup_success(struct __sk_buff *skb)
 {
 	void *data_end = (void *)(long)skb->data_end;
 	void *data = (void *)(long)skb->data;
@@ -79,8 +78,8 @@ int bpf_sk_lookup_test0(struct __sk_buff *skb)
 	return sk ? TC_ACT_OK : TC_ACT_UNSPEC;
 }
 
-SEC("classifier/sk_lookup_success_simple")
-int bpf_sk_lookup_test1(struct __sk_buff *skb)
+SEC("classifier")
+int sk_lookup_success_simple(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
@@ -91,8 +90,8 @@ int bpf_sk_lookup_test1(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/err_use_after_free")
-int bpf_sk_lookup_uaf(struct __sk_buff *skb)
+SEC("classifier")
+int err_use_after_free(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
@@ -106,8 +105,8 @@ int bpf_sk_lookup_uaf(struct __sk_buff *skb)
 	return family;
 }
 
-SEC("classifier/err_modify_sk_pointer")
-int bpf_sk_lookup_modptr(struct __sk_buff *skb)
+SEC("classifier")
+int err_modify_sk_pointer(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
@@ -121,8 +120,8 @@ int bpf_sk_lookup_modptr(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/err_modify_sk_or_null_pointer")
-int bpf_sk_lookup_modptr_or_null(struct __sk_buff *skb)
+SEC("classifier")
+int err_modify_sk_or_null_pointer(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
@@ -135,8 +134,8 @@ int bpf_sk_lookup_modptr_or_null(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/err_no_release")
-int bpf_sk_lookup_test2(struct __sk_buff *skb)
+SEC("classifier")
+int err_no_release(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 
@@ -144,8 +143,8 @@ int bpf_sk_lookup_test2(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/err_release_twice")
-int bpf_sk_lookup_test3(struct __sk_buff *skb)
+SEC("classifier")
+int err_release_twice(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
@@ -156,8 +155,8 @@ int bpf_sk_lookup_test3(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/err_release_unchecked")
-int bpf_sk_lookup_test4(struct __sk_buff *skb)
+SEC("classifier")
+int err_release_unchecked(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
@@ -173,8 +172,8 @@ void lookup_no_release(struct __sk_buff *skb)
 	bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple), BPF_F_CURRENT_NETNS, 0);
 }
 
-SEC("classifier/err_no_release_subcall")
-int bpf_sk_lookup_test5(struct __sk_buff *skb)
+SEC("classifier")
+int err_no_release_subcall(struct __sk_buff *skb)
 {
 	lookup_no_release(skb);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_skb_helpers.c b/tools/testing/selftests/bpf/progs/test_skb_helpers.c
index bb3fbf1a29e3..e17bb3a039e3 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_helpers.c
@@ -14,7 +14,7 @@ struct {
 
 char _license[] SEC("license") = "GPL";
 
-SEC("classifier/test_skb_helpers")
+SEC("classifier")
 int test_skb_helpers(struct __sk_buff *skb)
 {
 	struct task_struct *task;
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
index 9d0c9f28cab2..6ac05bd5b827 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
@@ -24,7 +24,7 @@ struct {
 	__type(value, __u64);
 } dst_sock_hash SEC(".maps");
 
-SEC("classifier/copy_sock_map")
+SEC("classifier")
 int copy_sock_map(void *ctx)
 {
 	struct bpf_sock *sk;
diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
index 0c93d326a663..03145db5da2e 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
@@ -70,7 +70,7 @@ static __always_inline bool is_remote_ep_v6(struct __sk_buff *skb,
 	return v6_equal(ip6h->daddr, addr);
 }
 
-SEC("classifier/chk_egress")
+SEC("classifier")
 int tc_chk(struct __sk_buff *skb)
 {
 	void *data_end = ctx_ptr(skb->data_end);
@@ -83,7 +83,7 @@ int tc_chk(struct __sk_buff *skb)
 	return !raw[0] && !raw[1] && !raw[2] ? TC_ACT_SHOT : TC_ACT_OK;
 }
 
-SEC("classifier/dst_ingress")
+SEC("classifier")
 int tc_dst(struct __sk_buff *skb)
 {
 	__u8 zero[ETH_ALEN * 2];
@@ -108,7 +108,7 @@ int tc_dst(struct __sk_buff *skb)
 	return bpf_redirect_neigh(IFINDEX_SRC, NULL, 0, 0);
 }
 
-SEC("classifier/src_ingress")
+SEC("classifier")
 int tc_src(struct __sk_buff *skb)
 {
 	__u8 zero[ETH_ALEN * 2];
diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c b/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
index f7ab69cf018e..c3d1d1f38232 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
@@ -75,7 +75,7 @@ static __always_inline int fill_fib_params_v6(struct __sk_buff *skb,
 	return 0;
 }
 
-SEC("classifier/chk_egress")
+SEC("classifier")
 int tc_chk(struct __sk_buff *skb)
 {
 	void *data_end = ctx_ptr(skb->data_end);
@@ -143,13 +143,13 @@ static __always_inline int tc_redir(struct __sk_buff *skb)
 /* these are identical, but keep them separate for compatibility with the
  * section names expected by test_tc_redirect.sh
  */
-SEC("classifier/dst_ingress")
+SEC("classifier")
 int tc_dst(struct __sk_buff *skb)
 {
 	return tc_redir(skb);
 }
 
-SEC("classifier/src_ingress")
+SEC("classifier")
 int tc_src(struct __sk_buff *skb)
 {
 	return tc_redir(skb);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index fe818cd5f010..7d0256d7db82 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -16,31 +16,31 @@ volatile const __u32 IFINDEX_DST;
 static const __u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
 static const __u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
 
-SEC("classifier/chk_egress")
+SEC("classifier")
 int tc_chk(struct __sk_buff *skb)
 {
 	return TC_ACT_SHOT;
 }
 
-SEC("classifier/dst_ingress")
+SEC("classifier")
 int tc_dst(struct __sk_buff *skb)
 {
 	return bpf_redirect_peer(IFINDEX_SRC, 0);
 }
 
-SEC("classifier/src_ingress")
+SEC("classifier")
 int tc_src(struct __sk_buff *skb)
 {
 	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
-SEC("classifier/dst_ingress_l3")
+SEC("classifier")
 int tc_dst_l3(struct __sk_buff *skb)
 {
 	return bpf_redirect(IFINDEX_SRC, 0);
 }
 
-SEC("classifier/src_ingress_l3")
+SEC("classifier")
 int tc_src_l3(struct __sk_buff *skb)
 {
 	__u16 proto = skb->protocol;
-- 
2.30.2

