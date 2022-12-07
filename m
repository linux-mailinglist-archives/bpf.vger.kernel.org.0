Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AE64623E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLGURB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 7 Dec 2022 15:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGUQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:16:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE0AE0F3
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:16:58 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7EnHmY029123
        for <bpf@vger.kernel.org>; Wed, 7 Dec 2022 12:16:58 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3makaax25y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:16:58 -0800
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 7 Dec 2022 12:16:57 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5AA942310A1C9; Wed,  7 Dec 2022 12:16:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] selftests/bpf: add generic BPF program tester-loader
Date:   Wed, 7 Dec 2022 12:16:47 -0800
Message-ID: <20221207201648.2990661-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 199ITDQuSAdXcT3Kb8oHcW90RIaVCjFT
X-Proofpoint-GUID: 199ITDQuSAdXcT3Kb8oHcW90RIaVCjFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's become a common pattern to have a collection of small BPF programs
in one BPF object file, each representing one test case. On user-space
side of such tests we maintain a table of program names and expected
failure or success, along with optional expected verifier log message.

This works, but each set of tests reimplement this mundane code over and
over again, which is a waste of time for anyone trying to add a new set
of tests. Furthermore, it's quite error prone as it's way too easy to miss
some entries in these manually maintained test tables (as evidences by
dynptr_fail tests, in which ringbuf_release_uninit_dynptr subtest was
accidentally missed; this is fixed in next patch).

So this patch implements generic test_loader, which accepts skeleton
name and handles the rest of details: opens and loads BPF object file,
making sure each program is tested in isolation. Optionally each test
case can specify expected BPF verifier log message. In case of failure,
tester makes sure to report verifier log, but it also reports verifier
log in verbose mode unconditionally.

Now, the interesting deviation from existing custom implementations is
the use of btf_decl_tag attribute to specify expected-to-fail vs
expected-to-succeed markers and, optionally, expected log message
directly next to BPF program source code, eliminating the need to
manually create and update table of tests.

We define few macros wrapping btf_decl_tag with a convention that all
values of btf_decl_tag start with "comment:" prefix, and then utilizing
a very simple "just_some_text_tag" or "some_key_name=<value>" pattern to
define things like expected success/failure, expected verifier message,
extra verifier log level (if necessary). This approach is demonstrated
by next patch in which two existing sets of failure tests are converted.

Tester supports both expected-to-fail and expected-to-succeed programs,
though this patch set didn't convert any existing expected-to-succeed
programs yet, as existing tests couple BPF program loading with their
further execution through attach or test_prog_run. One way to allow
testing scenarios like this would be ability to specify custom callback,
executed for each successfully loaded BPF program. This is left for
follow up patches, after some more analysis of existing test cases.

This test_loader is, hopefully, a start of a test_verifier-like runner,
but integrated into test_progs infrastructure. It will allow much better
"user experience" of defining low-level verification tests that can take
advantage of all the libbpf-provided nicety features on BPF side: global
variables, declarative maps, etc.  All while having a choice of defining
it in C or as BPF assembly (through __attribute__((naked)) functions and
using embedded asm), depending on what makes most sense in each
particular case. This will be explored in follow up patches as well.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile         |   2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h |   5 +
 tools/testing/selftests/bpf/test_loader.c    | 233 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h     |  33 +++
 4 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_loader.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 997b3bd10cbf..c22c43bbee19 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -527,7 +527,7 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c
+			 cap_helpers.c test_loader.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 5bb11fe595a4..4a01ea9113bf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,6 +2,11 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
 
+#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
+#define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
+#define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
+
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
new file mode 100644
index 000000000000..679efb3aa785
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <stdlib.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define str_has_pfx(str, pfx) \
+	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
+
+#define TEST_LOADER_LOG_BUF_SZ 1048576
+
+#define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
+#define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
+#define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
+
+struct test_spec {
+	const char *name;
+	bool expect_failure;
+	const char *expect_msg;
+	int log_level;
+};
+
+static int tester_init(struct test_loader *tester)
+{
+	if (!tester->log_buf) {
+		tester->log_buf_sz = TEST_LOADER_LOG_BUF_SZ;
+		tester->log_buf = malloc(tester->log_buf_sz);
+		if (!ASSERT_OK_PTR(tester->log_buf, "tester_log_buf"))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void test_loader_fini(struct test_loader *tester)
+{
+	if (!tester)
+		return;
+
+	free(tester->log_buf);
+}
+
+static int parse_test_spec(struct test_loader *tester,
+			   struct bpf_object *obj,
+			   struct bpf_program *prog,
+			   struct test_spec *spec)
+{
+	struct btf *btf;
+	int func_id, i;
+
+	memset(spec, 0, sizeof(*spec));
+
+	spec->name = bpf_program__name(prog);
+
+	btf = bpf_object__btf(obj);
+	if (!btf) {
+		ASSERT_FAIL("BPF object has no BTF");
+		return -EINVAL;
+	}
+
+	func_id = btf__find_by_name_kind(btf, spec->name, BTF_KIND_FUNC);
+	if (func_id < 0) {
+		ASSERT_FAIL("failed to find FUNC BTF type for '%s'", spec->name);
+		return -EINVAL;
+	}
+
+	for (i = 1; i < btf__type_cnt(btf); i++) {
+		const struct btf_type *t;
+		const char *s;
+
+		t = btf__type_by_id(btf, i);
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		if (t->type != func_id || btf_decl_tag(t)->component_idx != -1)
+			continue;
+
+		s = btf__str_by_offset(btf, t->name_off);
+		if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
+			spec->expect_failure = true;
+		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
+			spec->expect_failure = false;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
+			spec->expect_msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
+		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
+			errno = 0;
+			spec->log_level = strtol(s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1, NULL, 0);
+			if (errno) {
+				ASSERT_FAIL("failed to parse test log level from '%s'", s);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void prepare_case(struct test_loader *tester,
+			 struct test_spec *spec,
+			 struct bpf_object *obj,
+			 struct bpf_program *prog)
+{
+	int min_log_level = 0;
+
+	if (env.verbosity > VERBOSE_NONE)
+		min_log_level = 1;
+	if (env.verbosity > VERBOSE_VERY)
+		min_log_level = 2;
+
+	bpf_program__set_log_buf(prog, tester->log_buf, tester->log_buf_sz);
+
+	/* Make sure we set at least minimal log level, unless test requirest
+	 * even higher level already. Make sure to preserve independent log
+	 * level 4 (verifier stats), though.
+	 */
+	if ((spec->log_level & 3) < min_log_level)
+		bpf_program__set_log_level(prog, (spec->log_level & 4) | min_log_level);
+	else
+		bpf_program__set_log_level(prog, spec->log_level);
+
+	tester->log_buf[0] = '\0';
+}
+
+static void emit_verifier_log(const char *log_buf, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
+}
+
+static void validate_case(struct test_loader *tester,
+			  struct test_spec *spec,
+			  struct bpf_object *obj,
+			  struct bpf_program *prog,
+			  int load_err)
+{
+	if (spec->expect_msg) {
+		char *match;
+
+		match = strstr(tester->log_buf, spec->expect_msg);
+		if (!ASSERT_OK_PTR(match, "expect_msg")) {
+			/* if we are in verbose mode, we've already emitted log */
+			if (env.verbosity == VERBOSE_NONE)
+				emit_verifier_log(tester->log_buf, true /*force*/);
+			fprintf(stderr, "EXPECTED MSG: '%s'\n", spec->expect_msg);
+			return;
+		}
+	}
+}
+
+/* this function is forced noinline and has short generic name to look better
+ * in test_progs output (in case of a failure)
+ */
+static noinline
+void run_subtest(struct test_loader *tester,
+		 const char *skel_name,
+		 skel_elf_bytes_fn elf_bytes_factory)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, open_opts, .object_name = skel_name);
+	struct bpf_object *obj = NULL, *tobj;
+	struct bpf_program *prog, *tprog;
+	const void *obj_bytes;
+	size_t obj_byte_cnt;
+	int err;
+
+	if (tester_init(tester) < 0)
+		return; /* failed to initialize tester */
+
+	obj_bytes = elf_bytes_factory(&obj_byte_cnt);
+	obj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, &open_opts);
+	if (!ASSERT_OK_PTR(obj, "obj_open_mem"))
+		return;
+
+	bpf_object__for_each_program(prog, obj) {
+		const char *prog_name = bpf_program__name(prog);
+		struct test_spec spec;
+
+		if (!test__start_subtest(prog_name))
+			continue;
+
+		/* if we can't derive test specification, go to the next test */
+		err = parse_test_spec(tester, obj, prog, &spec);
+		if (!ASSERT_OK(err, "parse_test_spec"))
+			continue;
+
+		tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, &open_opts);
+		if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
+			continue;
+
+		bpf_object__for_each_program(tprog, tobj)
+			bpf_program__set_autoload(tprog, false);
+
+		bpf_object__for_each_program(tprog, tobj) {
+			/* only load specified program */
+			if (strcmp(bpf_program__name(tprog), prog_name) == 0) {
+				bpf_program__set_autoload(tprog, true);
+				break;
+			}
+		}
+
+		prepare_case(tester, &spec, tobj, tprog);
+
+		err = bpf_object__load(tobj);
+		if (spec.expect_failure) {
+			if (!ASSERT_ERR(err, "unexpected_load_success")) {
+				emit_verifier_log(tester->log_buf, false /*force*/);
+				goto tobj_cleanup;
+			}
+		} else {
+			if (!ASSERT_OK(err, "unexpected_load_failure")) {
+				emit_verifier_log(tester->log_buf, true /*force*/);
+				goto tobj_cleanup;
+			}
+		}
+
+		emit_verifier_log(tester->log_buf, false /*force*/);
+		validate_case(tester, &spec, tobj, tprog, err);
+
+tobj_cleanup:
+		bpf_object__close(tobj);
+	}
+
+	bpf_object__close(obj);
+}
+
+void test_loader__run_subtests(struct test_loader *tester,
+			       const char *skel_name,
+			       skel_elf_bytes_fn elf_bytes_factory)
+{
+	/* see comment in run_subtest() for why we do this function nesting */
+	run_subtest(tester, skel_name, elf_bytes_factory);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index b090996daee5..3f058dfadbaf 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TEST_PROGS_H
+#define __TEST_PROGS_H
+
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
@@ -210,6 +213,12 @@ int test__join_cgroup(const char *path);
 #define CHECK_ATTR(condition, tag, format...) \
 	_CHECK(condition, tag, tattr.duration, format)
 
+#define ASSERT_FAIL(fmt, args...) ({					\
+	static int duration = 0;					\
+	CHECK(false, "", fmt"\n", ##args);				\
+	false;								\
+})
+
 #define ASSERT_TRUE(actual, name) ({					\
 	static int duration = 0;					\
 	bool ___ok = (actual);						\
@@ -397,3 +406,27 @@ int write_sysctl(const char *sysctl, const char *value);
 #endif
 
 #define BPF_TESTMOD_TEST_FILE "/sys/kernel/bpf_testmod"
+
+struct test_loader {
+	char *log_buf;
+	size_t log_buf_sz;
+
+	struct bpf_object *obj;
+};
+
+typedef const void *(*skel_elf_bytes_fn)(size_t *sz);
+
+extern void test_loader__run_subtests(struct test_loader *tester,
+				      const char *skel_name,
+				      skel_elf_bytes_fn elf_bytes_factory);
+
+extern void test_loader_fini(struct test_loader *tester);
+
+#define RUN_TESTS(skel) ({						       \
+	struct test_loader tester = {};					       \
+									       \
+	test_loader__run_subtests(&tester, #skel, skel##__elf_bytes);	       \
+	test_loader_fini(&tester);					       \
+})
+
+#endif /* __TEST_PROGS_H */
-- 
2.30.2

