Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C685060E8
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 02:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiDSA2W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 18 Apr 2022 20:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiDSA2V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 20:28:21 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00FA22B33
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 17:25:40 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23J0G4dl022087
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 17:25:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fhhusr660-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 17:25:39 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:25:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8BCB318315817; Mon, 18 Apr 2022 17:24:58 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: use non-autoloaded programs in few tests
Date:   Mon, 18 Apr 2022 17:24:51 -0700
Message-ID: <20220419002452.632125-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419002452.632125-1-andrii@kernel.org>
References: <20220419002452.632125-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9os5oHPZfdHTpQGO-CkOuebPPM-RNf8N
X-Proofpoint-ORIG-GUID: 9os5oHPZfdHTpQGO-CkOuebPPM-RNf8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Take advantage of new libbpf feature for declarative non-autoloaded BPF
program SEC() definitions in few test that test single program at a time
out of many available programs within the single BPF object.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/helper_restricted.c        | 10 +++-----
 .../bpf/prog_tests/reference_tracking.c       | 23 ++++++-----------
 .../selftests/bpf/prog_tests/test_strncmp.c   | 25 +++----------------
 .../selftests/bpf/progs/strncmp_test.c        |  8 +++---
 .../bpf/progs/test_helper_restricted.c        | 16 ++++++------
 .../selftests/bpf/progs/test_sk_lookup_kern.c | 18 ++++++-------
 6 files changed, 35 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/helper_restricted.c b/tools/testing/selftests/bpf/prog_tests/helper_restricted.c
index e1de5f80c3b2..0354f9b82c65 100644
--- a/tools/testing/selftests/bpf/prog_tests/helper_restricted.c
+++ b/tools/testing/selftests/bpf/prog_tests/helper_restricted.c
@@ -6,11 +6,10 @@
 void test_helper_restricted(void)
 {
 	int prog_i = 0, prog_cnt;
-	int duration = 0;
 
 	do {
 		struct test_helper_restricted *test;
-		int maybeOK;
+		int err;
 
 		test = test_helper_restricted__open();
 		if (!ASSERT_OK_PTR(test, "open"))
@@ -21,12 +20,11 @@ void test_helper_restricted(void)
 		for (int j = 0; j < prog_cnt; ++j) {
 			struct bpf_program *prog = *test->skeleton->progs[j].prog;
 
-			maybeOK = bpf_program__set_autoload(prog, prog_i == j);
-			ASSERT_OK(maybeOK, "set autoload");
+			bpf_program__set_autoload(prog, true);
 		}
 
-		maybeOK = test_helper_restricted__load(test);
-		CHECK(!maybeOK, test->skeleton->progs[prog_i].name, "helper isn't restricted");
+		err = test_helper_restricted__load(test);
+		ASSERT_ERR(err, "load_should_fail");
 
 		test_helper_restricted__destroy(test);
 	} while (++prog_i < prog_cnt);
diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index 873323fb18ba..739d2ea6ca55 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -1,21 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 
-static void toggle_object_autoload_progs(const struct bpf_object *obj,
-					 const char *name_load)
-{
-	struct bpf_program *prog;
-
-	bpf_object__for_each_program(prog, obj) {
-		const char *name = bpf_program__name(prog);
-
-		if (!strcmp(name_load, name))
-			bpf_program__set_autoload(prog, true);
-		else
-			bpf_program__set_autoload(prog, false);
-	}
-}
-
 void test_reference_tracking(void)
 {
 	const char *file = "test_sk_lookup_kern.o";
@@ -39,6 +24,7 @@ void test_reference_tracking(void)
 		goto cleanup;
 
 	bpf_object__for_each_program(prog, obj_iter) {
+		struct bpf_program *p;
 		const char *name;
 
 		name = bpf_program__name(prog);
@@ -49,7 +35,12 @@ void test_reference_tracking(void)
 		if (!ASSERT_OK_PTR(obj, "obj_open_file"))
 			goto cleanup;
 
-		toggle_object_autoload_progs(obj, name);
+		/* all programs are not loaded by default, so just set
+		 * autoload to true for the single prog under test
+		 */
+		p = bpf_object__find_program_by_name(obj, name);
+		bpf_program__set_autoload(p, true);
+
 		/* Expect verifier failure if test name has 'err' */
 		if (strncmp(name, "err_", sizeof("err_") - 1) == 0) {
 			libbpf_print_fn_t old_print_fn;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_strncmp.c b/tools/testing/selftests/bpf/prog_tests/test_strncmp.c
index b57a3009465f..7ddd6615b7e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_strncmp.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_strncmp.c
@@ -44,16 +44,12 @@ static void strncmp_full_str_cmp(struct strncmp_test *skel, const char *name,
 static void test_strncmp_ret(void)
 {
 	struct strncmp_test *skel;
-	struct bpf_program *prog;
 	int err, got;
 
 	skel = strncmp_test__open();
 	if (!ASSERT_OK_PTR(skel, "strncmp_test open"))
 		return;
 
-	bpf_object__for_each_program(prog, skel->obj)
-		bpf_program__set_autoload(prog, false);
-
 	bpf_program__set_autoload(skel->progs.do_strncmp, true);
 
 	err = strncmp_test__load(skel);
@@ -91,18 +87,13 @@ static void test_strncmp_ret(void)
 static void test_strncmp_bad_not_const_str_size(void)
 {
 	struct strncmp_test *skel;
-	struct bpf_program *prog;
 	int err;
 
 	skel = strncmp_test__open();
 	if (!ASSERT_OK_PTR(skel, "strncmp_test open"))
 		return;
 
-	bpf_object__for_each_program(prog, skel->obj)
-		bpf_program__set_autoload(prog, false);
-
-	bpf_program__set_autoload(skel->progs.strncmp_bad_not_const_str_size,
-				  true);
+	bpf_program__set_autoload(skel->progs.strncmp_bad_not_const_str_size, true);
 
 	err = strncmp_test__load(skel);
 	ASSERT_ERR(err, "strncmp_test load bad_not_const_str_size");
@@ -113,18 +104,13 @@ static void test_strncmp_bad_not_const_str_size(void)
 static void test_strncmp_bad_writable_target(void)
 {
 	struct strncmp_test *skel;
-	struct bpf_program *prog;
 	int err;
 
 	skel = strncmp_test__open();
 	if (!ASSERT_OK_PTR(skel, "strncmp_test open"))
 		return;
 
-	bpf_object__for_each_program(prog, skel->obj)
-		bpf_program__set_autoload(prog, false);
-
-	bpf_program__set_autoload(skel->progs.strncmp_bad_writable_target,
-				  true);
+	bpf_program__set_autoload(skel->progs.strncmp_bad_writable_target, true);
 
 	err = strncmp_test__load(skel);
 	ASSERT_ERR(err, "strncmp_test load bad_writable_target");
@@ -135,18 +121,13 @@ static void test_strncmp_bad_writable_target(void)
 static void test_strncmp_bad_not_null_term_target(void)
 {
 	struct strncmp_test *skel;
-	struct bpf_program *prog;
 	int err;
 
 	skel = strncmp_test__open();
 	if (!ASSERT_OK_PTR(skel, "strncmp_test open"))
 		return;
 
-	bpf_object__for_each_program(prog, skel->obj)
-		bpf_program__set_autoload(prog, false);
-
-	bpf_program__set_autoload(skel->progs.strncmp_bad_not_null_term_target,
-				  true);
+	bpf_program__set_autoload(skel->progs.strncmp_bad_not_null_term_target, true);
 
 	err = strncmp_test__load(skel);
 	ASSERT_ERR(err, "strncmp_test load bad_not_null_term_target");
diff --git a/tools/testing/selftests/bpf/progs/strncmp_test.c b/tools/testing/selftests/bpf/progs/strncmp_test.c
index 900d930d48a8..769668feed48 100644
--- a/tools/testing/selftests/bpf/progs/strncmp_test.c
+++ b/tools/testing/selftests/bpf/progs/strncmp_test.c
@@ -19,7 +19,7 @@ unsigned int no_const_str_size = STRNCMP_STR_SZ;
 
 char _license[] SEC("license") = "GPL";
 
-SEC("tp/syscalls/sys_enter_nanosleep")
+SEC("?tp/syscalls/sys_enter_nanosleep")
 int do_strncmp(void *ctx)
 {
 	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
@@ -29,7 +29,7 @@ int do_strncmp(void *ctx)
 	return 0;
 }
 
-SEC("tp/syscalls/sys_enter_nanosleep")
+SEC("?tp/syscalls/sys_enter_nanosleep")
 int strncmp_bad_not_const_str_size(void *ctx)
 {
 	/* The value of string size is not const, so will fail */
@@ -37,7 +37,7 @@ int strncmp_bad_not_const_str_size(void *ctx)
 	return 0;
 }
 
-SEC("tp/syscalls/sys_enter_nanosleep")
+SEC("?tp/syscalls/sys_enter_nanosleep")
 int strncmp_bad_writable_target(void *ctx)
 {
 	/* Compared target is not read-only, so will fail */
@@ -45,7 +45,7 @@ int strncmp_bad_writable_target(void *ctx)
 	return 0;
 }
 
-SEC("tp/syscalls/sys_enter_nanosleep")
+SEC("?tp/syscalls/sys_enter_nanosleep")
 int strncmp_bad_not_null_term_target(void *ctx)
 {
 	/* Compared target is not null-terminated, so will fail */
diff --git a/tools/testing/selftests/bpf/progs/test_helper_restricted.c b/tools/testing/selftests/bpf/progs/test_helper_restricted.c
index 68d64c365f90..20ef9d433b97 100644
--- a/tools/testing/selftests/bpf/progs/test_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/test_helper_restricted.c
@@ -56,7 +56,7 @@ static void spin_lock_work(void)
 	}
 }
 
-SEC("raw_tp/sys_enter")
+SEC("?raw_tp/sys_enter")
 int raw_tp_timer(void *ctx)
 {
 	timer_work();
@@ -64,7 +64,7 @@ int raw_tp_timer(void *ctx)
 	return 0;
 }
 
-SEC("tp/syscalls/sys_enter_nanosleep")
+SEC("?tp/syscalls/sys_enter_nanosleep")
 int tp_timer(void *ctx)
 {
 	timer_work();
@@ -72,7 +72,7 @@ int tp_timer(void *ctx)
 	return 0;
 }
 
-SEC("kprobe/sys_nanosleep")
+SEC("?kprobe/sys_nanosleep")
 int kprobe_timer(void *ctx)
 {
 	timer_work();
@@ -80,7 +80,7 @@ int kprobe_timer(void *ctx)
 	return 0;
 }
 
-SEC("perf_event")
+SEC("?perf_event")
 int perf_event_timer(void *ctx)
 {
 	timer_work();
@@ -88,7 +88,7 @@ int perf_event_timer(void *ctx)
 	return 0;
 }
 
-SEC("raw_tp/sys_enter")
+SEC("?raw_tp/sys_enter")
 int raw_tp_spin_lock(void *ctx)
 {
 	spin_lock_work();
@@ -96,7 +96,7 @@ int raw_tp_spin_lock(void *ctx)
 	return 0;
 }
 
-SEC("tp/syscalls/sys_enter_nanosleep")
+SEC("?tp/syscalls/sys_enter_nanosleep")
 int tp_spin_lock(void *ctx)
 {
 	spin_lock_work();
@@ -104,7 +104,7 @@ int tp_spin_lock(void *ctx)
 	return 0;
 }
 
-SEC("kprobe/sys_nanosleep")
+SEC("?kprobe/sys_nanosleep")
 int kprobe_spin_lock(void *ctx)
 {
 	spin_lock_work();
@@ -112,7 +112,7 @@ int kprobe_spin_lock(void *ctx)
 	return 0;
 }
 
-SEC("perf_event")
+SEC("?perf_event")
 int perf_event_spin_lock(void *ctx)
 {
 	spin_lock_work();
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
index 40f161480a2f..b502e5c92e33 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
@@ -52,7 +52,7 @@ static struct bpf_sock_tuple *get_tuple(void *data, __u64 nh_off,
 	return result;
 }
 
-SEC("tc")
+SEC("?tc")
 int sk_lookup_success(struct __sk_buff *skb)
 {
 	void *data_end = (void *)(long)skb->data_end;
@@ -78,7 +78,7 @@ int sk_lookup_success(struct __sk_buff *skb)
 	return sk ? TC_ACT_OK : TC_ACT_UNSPEC;
 }
 
-SEC("tc")
+SEC("?tc")
 int sk_lookup_success_simple(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -90,7 +90,7 @@ int sk_lookup_success_simple(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("tc")
+SEC("?tc")
 int err_use_after_free(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -105,7 +105,7 @@ int err_use_after_free(struct __sk_buff *skb)
 	return family;
 }
 
-SEC("tc")
+SEC("?tc")
 int err_modify_sk_pointer(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -120,7 +120,7 @@ int err_modify_sk_pointer(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("tc")
+SEC("?tc")
 int err_modify_sk_or_null_pointer(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -134,7 +134,7 @@ int err_modify_sk_or_null_pointer(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("tc")
+SEC("?tc")
 int err_no_release(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -143,7 +143,7 @@ int err_no_release(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("tc")
+SEC("?tc")
 int err_release_twice(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -155,7 +155,7 @@ int err_release_twice(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("tc")
+SEC("?tc")
 int err_release_unchecked(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -172,7 +172,7 @@ void lookup_no_release(struct __sk_buff *skb)
 	bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple), BPF_F_CURRENT_NETNS, 0);
 }
 
-SEC("tc")
+SEC("?tc")
 int err_no_release_subcall(struct __sk_buff *skb)
 {
 	lookup_no_release(skb);
-- 
2.30.2

