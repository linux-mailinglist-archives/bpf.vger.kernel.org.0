Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B102A4BCC28
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 05:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiBTE15 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 19 Feb 2022 23:27:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiBTE15 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 23:27:57 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEAE33E00
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 20:27:37 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21K4RUUi019982
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 20:27:36 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eay4rtr9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 20:27:36 -0800
Received: from twshared10426.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Feb 2022 20:27:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D6D0B11A1CAF9; Sat, 19 Feb 2022 20:27:21 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
Subject: [PATCH v3 bpf-next] selftests/bpf: fix btfgen tests
Date:   Sat, 19 Feb 2022 20:27:20 -0800
Message-ID: <20220220042720.3336684-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: cVmZlPgOyc-83tOGqQFy_3aHFrPIAvqz
X-Proofpoint-GUID: cVmZlPgOyc-83tOGqQFy_3aHFrPIAvqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-19_04,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 clxscore=1034 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202200027
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There turned out to be a few problems with btfgen selftests.

First, core_btfgen tests are failing in BPF CI due to the use of
full-featured bpftool, which has extra dependencies on libbfd, libcap,
etc, which are present in BPF CI's build environment, but those shared
libraries are missing in QEMU image in which test_progs is running.

To fix this problem, use minimal bootstrap version of bpftool instead.
It only depend on libelf and libz, same as libbpf, so doesn't add any
new requirements (and bootstrap bpftool still implementes entire
`bpftool gen` functionality, which is quite convenient).

Second problem is even more interesting. Both core_btfgen and core_reloc
reuse the same set of struct core_reloc_test_case array of test case
definitions. That in itself is not a problem, but btfgen test replaces
test_case->btf_src_file property with the path to temporary file into
which minimized BTF is output by bpftool. This interferes with original
core_reloc tests, depending on order of tests execution (core_btfgen is
run first in sequential mode and skrews up subsequent core_reloc run by
pointing to already deleted temporary file, instead of the original BTF
files) and whether those two runs share the same process (in parallel
mode the chances are high for them to run in two separate processes and
so not interfere with each other).

To prevent this interference, create and use local copy of a test
definition. Mark original array as constant to catch accidental
modifcations. Note that setup_type_id_case_success() and
setup_type_id_case_success() still modify common test_case->output
memory area, but it is ok as each setup function has to re-initialize it
completely anyways. In sequential mode it leads to deterministic and
correct initialization. In parallel mode they will either each have
their own process, or if core_reloc and core_btfgen happen to be run by
the same worker process, they will still do that sequentially within the
worker process. If they are sharded across multiple processes, they
don't really share anything anyways.

Also, rename core_btfgen into core_reloc_btfgen, as it is indeed just
a "flavor" of core_reloc test, not an independent set of tests. So make
it more obvious.

Last problem that needed solving was that location of bpftool differs
between test_progs and test_progs' flavors (e.g., test_progs-no_alu32).
To keep it simple, create a symlink to bpftool both inside
selftests/bpf/ directory and selftests/bpf/<flavor> subdirectory. That
way, from inside core_reloc test, location to bpftool is just "./bpftool".

v2->v3:
  - fix bpftool location relative the test_progs-no_alu32;
v1->v2:
  - fix corruption of core_reloc_test_case.

Cc: Mauricio Vásquez <mauricio@kinvolk.io>
Fixes: 704c91e59fe0 ("selftests/bpf: Test "bpftool gen min_core_btf")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore          |  1 +
 tools/testing/selftests/bpf/Makefile            |  3 ++-
 .../selftests/bpf/prog_tests/core_reloc.c       | 17 +++++++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 1dad8d617da8..a7eead8820a0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+bpftool
 bpf-helpers*
 bpf-syscall*
 test_verifier
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 91ea729990da..fe12b4f5fe20 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -470,6 +470,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 	$$(call msg,BINARY,,$$@)
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
 	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
+	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
 
 endef
 
@@ -555,7 +556,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-	feature								\
+	feature bpftool							\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h no_alu32 bpf_gcc bpf_testmod.ko)
 
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 8fbb40a832d5..f28f75aa9154 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -512,7 +512,7 @@ static int __trigger_module_test_read(const struct core_reloc_test_case *test)
 }
 
 
-static struct core_reloc_test_case test_cases[] = {
+static const struct core_reloc_test_case test_cases[] = {
 	/* validate we can find kernel image and use its BTF for relocs */
 	{
 		.case_name = "kernel",
@@ -843,7 +843,7 @@ static int run_btfgen(const char *src_btf, const char *dst_btf, const char *objp
 	int n;
 
 	n = snprintf(command, sizeof(command),
-		     "./tools/build/bpftool/bpftool gen min_core_btf %s %s %s",
+		     "./bpftool gen min_core_btf %s %s %s",
 		     src_btf, dst_btf, objpath);
 	if (n < 0 || n >= sizeof(command))
 		return -1;
@@ -855,7 +855,7 @@ static void run_core_reloc_tests(bool use_btfgen)
 {
 	const size_t mmap_sz = roundup_page(sizeof(struct data));
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts);
-	struct core_reloc_test_case *test_case;
+	struct core_reloc_test_case *test_case, test_case_copy;
 	const char *tp_name, *probe_name;
 	int err, i, equal, fd;
 	struct bpf_link *link = NULL;
@@ -870,7 +870,10 @@ static void run_core_reloc_tests(bool use_btfgen)
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		char btf_file[] = "/tmp/core_reloc.btf.XXXXXX";
-		test_case = &test_cases[i];
+
+		test_case_copy = test_cases[i];
+		test_case = &test_case_copy;
+
 		if (!test__start_subtest(test_case->case_name))
 			continue;
 
@@ -881,6 +884,7 @@ static void run_core_reloc_tests(bool use_btfgen)
 
 		/* generate a "minimal" BTF file and use it as source */
 		if (use_btfgen) {
+
 			if (!test_case->btf_src_file || test_case->fails) {
 				test__skip();
 				continue;
@@ -989,7 +993,8 @@ static void run_core_reloc_tests(bool use_btfgen)
 			CHECK_FAIL(munmap(mmap_data, mmap_sz));
 			mmap_data = NULL;
 		}
-		remove(btf_file);
+		if (use_btfgen)
+			remove(test_case->btf_src_file);
 		bpf_link__destroy(link);
 		link = NULL;
 		bpf_object__close(obj);
@@ -1001,7 +1006,7 @@ void test_core_reloc(void)
 	run_core_reloc_tests(false);
 }
 
-void test_core_btfgen(void)
+void test_core_reloc_btfgen(void)
 {
 	run_core_reloc_tests(true);
 }
-- 
2.30.2

