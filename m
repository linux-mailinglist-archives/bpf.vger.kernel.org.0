Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D354F4F214C
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiDECwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 4 Apr 2022 22:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiDECvv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:51:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6537A348A4E
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:59:25 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234NPDWY001074
        for <bpf@vger.kernel.org>; Mon, 4 Apr 2022 16:42:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f857x2d8a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 16:42:37 -0700
Received: from twshared20084.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 4 Apr 2022 16:42:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C99981661B53B; Mon,  4 Apr 2022 16:42:17 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v3 bpf-next 7/7] selftests/bpf: add urandom_read shared lib and USDTs
Date:   Mon, 4 Apr 2022 16:42:02 -0700
Message-ID: <20220404234202.331384-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404234202.331384-1-andrii@kernel.org>
References: <20220404234202.331384-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hWVs7HEV5oTYeiA-gdauu67bssXgF-kY
X-Proofpoint-ORIG-GUID: hWVs7HEV5oTYeiA-gdauu67bssXgF-kY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend urandom_read helper binary to include USDTs of 4 combinations:
semaphore/semaphoreless (refcounted and non-refcounted) and based in
executable or shared library. We also extend urandom_read with ability
to report it's own PID to parent process and wait for parent process to
ready itself up for tracing urandom_read. We utilize popen() and
underlying pipe properties for proper signaling.

Once urandom_read is ready, we add few tests to validate that libbpf's
USDT attachment handles all the above combinations of semaphore (or lack
of it) and static or shared library USDTs. Also, we validate that libbpf
handles shared libraries both with PID filter and without one (i.e., -1
for PID argument).

Having the shared library case tested with and without PID is important
because internal logic differs on kernels that don't support BPF
cookies. On such older kernels, attaching to USDTs in shared libraries
without specifying concrete PID doesn't work in principle, because it's
impossible to determine shared library's load address to derive absolute
IPs for uprobe attachments. Without absolute IPs, it's impossible to
perform correct look up of USDT spec based on uprobe's absolute IP (the
only kind available from BPF at runtime). This is not the problem on
newer kernels with BPF cookie as we don't need IP-to-ID lookup because
BPF cookie value *is* spec ID.

So having those two situations as separate subtests is good because
libbpf CI is able to test latest selftests against old kernels (e.g.,
4.9 and 5.5), so we'll be able to disable PID-less shared lib attachment
for old kernels, but will still leave PID-specific one enabled to validate
this legacy logic is working correctly.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  11 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c | 108 ++++++++++++++++++
 .../selftests/bpf/progs/test_urandom_usdt.c   |  70 ++++++++++++
 .../selftests/bpf/progs/test_usdt_multispec.c |   2 -
 tools/testing/selftests/bpf/urandom_read.c    |  63 +++++++++-
 .../testing/selftests/bpf/urandom_read_aux.c  |   9 ++
 .../testing/selftests/bpf/urandom_read_lib1.c |  13 +++
 .../testing/selftests/bpf/urandom_read_lib2.c |   8 ++
 8 files changed, 275 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_urandom_usdt.c
 create mode 100644 tools/testing/selftests/bpf/urandom_read_aux.c
 create mode 100644 tools/testing/selftests/bpf/urandom_read_lib1.c
 create mode 100644 tools/testing/selftests/bpf/urandom_read_lib2.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0f8c55dfd844..bafdc5373a13 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -168,9 +168,15 @@ $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
-$(OUTPUT)/urandom_read: urandom_read.c
+$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
+	$(call msg,LIB,,$@)
+	$(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
+
+$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $< $(LDLIBS) -Wl,--build-id=sha1 -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c,$^)			       \
+		  liburandom_read.so $(LDLIBS)	       			       \
+		  -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
@@ -493,6 +499,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 btf_helpers.c flow_dissector_load.h		\
 			 cap_helpers.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
+		       $(OUTPUT)/liburandom_read.so			\
 		       ima_setup.sh					\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 0677c9bfd40b..a71f51bdc08d 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -6,6 +6,7 @@
 #include "../sdt.h"
 
 #include "test_usdt.skel.h"
+#include "test_urandom_usdt.skel.h"
 
 int lets_test_this(int);
 
@@ -304,10 +305,117 @@ static void subtest_multispec_usdt(void)
 	test_usdt__destroy(skel);
 }
 
+static FILE *urand_spawn(int *pid)
+{
+	FILE *f;
+
+	/* urandom_read's stdout is wired into f */
+	f = popen("./urandom_read 1 report-pid", "r");
+	if (!f)
+		return NULL;
+
+	if (fscanf(f, "%d", pid) != 1) {
+		pclose(f);
+		return NULL;
+	}
+
+	return f;
+}
+
+static int urand_trigger(FILE **urand_pipe)
+{
+	int exit_code;
+
+	/* pclose() waits for child process to exit and returns their exit code */
+	exit_code = pclose(*urand_pipe);
+	*urand_pipe = NULL;
+
+	return exit_code;
+}
+
+static void subtest_urandom_usdt(bool auto_attach)
+{
+	struct test_urandom_usdt *skel;
+	struct test_urandom_usdt__bss *bss;
+	struct bpf_link *l;
+	FILE *urand_pipe = NULL;
+	int err, urand_pid = 0;
+
+	skel = test_urandom_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	urand_pipe = urand_spawn(&urand_pid);
+	if (!ASSERT_OK_PTR(urand_pipe, "urand_spawn"))
+		goto cleanup;
+
+	bss = skel->bss;
+	bss->urand_pid = urand_pid;
+
+	if (auto_attach) {
+		err = test_urandom_usdt__attach(skel);
+		if (!ASSERT_OK(err, "skel_auto_attach"))
+			goto cleanup;
+	} else {
+		l = bpf_program__attach_usdt(skel->progs.urand_read_without_sema,
+					     urand_pid, "./urandom_read",
+					     "urand", "read_without_sema", NULL);
+		if (!ASSERT_OK_PTR(l, "urand_without_sema_attach"))
+			goto cleanup;
+		skel->links.urand_read_without_sema = l;
+
+		l = bpf_program__attach_usdt(skel->progs.urand_read_with_sema,
+					     urand_pid, "./urandom_read",
+					     "urand", "read_with_sema", NULL);
+		if (!ASSERT_OK_PTR(l, "urand_with_sema_attach"))
+			goto cleanup;
+		skel->links.urand_read_with_sema = l;
+
+		l = bpf_program__attach_usdt(skel->progs.urandlib_read_without_sema,
+					     urand_pid, "./liburandom_read.so",
+					     "urandlib", "read_without_sema", NULL);
+		if (!ASSERT_OK_PTR(l, "urandlib_without_sema_attach"))
+			goto cleanup;
+		skel->links.urandlib_read_without_sema = l;
+
+		l = bpf_program__attach_usdt(skel->progs.urandlib_read_with_sema,
+					     urand_pid, "./liburandom_read.so",
+					     "urandlib", "read_with_sema", NULL);
+		if (!ASSERT_OK_PTR(l, "urandlib_with_sema_attach"))
+			goto cleanup;
+		skel->links.urandlib_read_with_sema = l;
+
+	}
+
+	/* trigger urandom_read USDTs */
+	ASSERT_OK(urand_trigger(&urand_pipe), "urand_exit_code");
+
+	ASSERT_EQ(bss->urand_read_without_sema_call_cnt, 1, "urand_wo_sema_cnt");
+	ASSERT_EQ(bss->urand_read_without_sema_buf_sz_sum, 256, "urand_wo_sema_sum");
+
+	ASSERT_EQ(bss->urand_read_with_sema_call_cnt, 1, "urand_w_sema_cnt");
+	ASSERT_EQ(bss->urand_read_with_sema_buf_sz_sum, 256, "urand_w_sema_sum");
+
+	ASSERT_EQ(bss->urandlib_read_without_sema_call_cnt, 1, "urandlib_wo_sema_cnt");
+	ASSERT_EQ(bss->urandlib_read_without_sema_buf_sz_sum, 256, "urandlib_wo_sema_sum");
+
+	ASSERT_EQ(bss->urandlib_read_with_sema_call_cnt, 1, "urandlib_w_sema_cnt");
+	ASSERT_EQ(bss->urandlib_read_with_sema_buf_sz_sum, 256, "urandlib_w_sema_sum");
+
+cleanup:
+	if (urand_pipe)
+		pclose(urand_pipe);
+	test_urandom_usdt__destroy(skel);
+}
+
 void test_usdt(void)
 {
 	if (test__start_subtest("basic"))
 		subtest_basic_usdt();
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
+	if (test__start_subtest("urand_auto_attach"))
+		subtest_urandom_usdt(true /* auto_attach */);
+	if (test__start_subtest("urand_pid_attach"))
+		subtest_urandom_usdt(false /* auto_attach */);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_urandom_usdt.c b/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
new file mode 100644
index 000000000000..3539b02bd5f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+int urand_pid;
+
+int urand_read_without_sema_call_cnt;
+int urand_read_without_sema_buf_sz_sum;
+
+SEC("usdt/./urandom_read:urand:read_without_sema")
+int BPF_USDT(urand_read_without_sema, int iter_num, int iter_cnt, int buf_sz)
+{
+	if (urand_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urand_read_without_sema_call_cnt, 1);
+	__sync_fetch_and_add(&urand_read_without_sema_buf_sz_sum, buf_sz);
+
+	return 0;
+}
+
+int urand_read_with_sema_call_cnt;
+int urand_read_with_sema_buf_sz_sum;
+
+SEC("usdt/./urandom_read:urand:read_with_sema")
+int BPF_USDT(urand_read_with_sema, int iter_num, int iter_cnt, int buf_sz)
+{
+	if (urand_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urand_read_with_sema_call_cnt, 1);
+	__sync_fetch_and_add(&urand_read_with_sema_buf_sz_sum, buf_sz);
+
+	return 0;
+}
+
+int urandlib_read_without_sema_call_cnt;
+int urandlib_read_without_sema_buf_sz_sum;
+
+SEC("usdt/./liburandom_read.so:urandlib:read_without_sema")
+int BPF_USDT(urandlib_read_without_sema, int iter_num, int iter_cnt, int buf_sz)
+{
+	if (urand_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urandlib_read_without_sema_call_cnt, 1);
+	__sync_fetch_and_add(&urandlib_read_without_sema_buf_sz_sum, buf_sz);
+
+	return 0;
+}
+
+int urandlib_read_with_sema_call_cnt;
+int urandlib_read_with_sema_buf_sz_sum;
+
+SEC("usdt/./liburandom_read.so:urandlib:read_with_sema")
+int BPF_USDT(urandlib_read_with_sema, int iter_num, int iter_cnt, int buf_sz)
+{
+	if (urand_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&urandlib_read_with_sema_call_cnt, 1);
+	__sync_fetch_and_add(&urandlib_read_with_sema_buf_sz_sum, buf_sz);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
index 3a090681f981..aa6de32b50d1 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
@@ -26,8 +26,6 @@ int BPF_USDT(usdt_100, int x)
 	__sync_fetch_and_add(&usdt_100_called, 1);
 	__sync_fetch_and_add(&usdt_100_sum, x);
 
-	bpf_printk("X is %d, sum is %d", x, usdt_100_sum);
-
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/selftests/bpf/urandom_read.c
index db781052758d..e92644d0fa75 100644
--- a/tools/testing/selftests/bpf/urandom_read.c
+++ b/tools/testing/selftests/bpf/urandom_read.c
@@ -1,32 +1,85 @@
+#include <stdbool.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <signal.h>
+
+#define _SDT_HAS_SEMAPHORES 1
+#include "sdt.h"
+
+#define SEC(name) __attribute__((section(name), used))
 
 #define BUF_SIZE 256
 
+/* defined in urandom_read_aux.c */
+void urand_read_without_sema(int iter_num, int iter_cnt, int read_sz);
+/* these are coming from urandom_read_lib{1,2}.c */
+void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz);
+void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz);
+
+unsigned short urand_read_with_sema_semaphore SEC(".probes");
+
 static __attribute__((noinline))
 void urandom_read(int fd, int count)
 {
-       char buf[BUF_SIZE];
-       int i;
+	char buf[BUF_SIZE];
+	int i;
+
+	for (i = 0; i < count; ++i) {
+		read(fd, buf, BUF_SIZE);
+
+		/* trigger USDTs defined in executable itself */
+		urand_read_without_sema(i, count, BUF_SIZE);
+		STAP_PROBE3(urand, read_with_sema, i, count, BUF_SIZE);
 
-       for (i = 0; i < count; ++i)
-               read(fd, buf, BUF_SIZE);
+		/* trigger USDTs defined in shared lib */
+		urandlib_read_without_sema(i, count, BUF_SIZE);
+		urandlib_read_with_sema(i, count, BUF_SIZE);
+	}
+}
+
+static volatile bool parent_ready;
+
+static void handle_sigpipe(int sig)
+{
+	parent_ready = true;
 }
 
 int main(int argc, char *argv[])
 {
 	int fd = open("/dev/urandom", O_RDONLY);
 	int count = 4;
+	bool report_pid = false;
 
 	if (fd < 0)
 		return 1;
 
-	if (argc == 2)
+	if (argc >= 2)
 		count = atoi(argv[1]);
+	if (argc >= 3) {
+		report_pid = true;
+		/* install SIGPIPE handler to catch when parent closes their
+		 * end of the pipe (on the other side of our stdout)
+		 */
+		signal(SIGPIPE, handle_sigpipe);
+	}
+
+	/* report PID and wait for parent process to send us "signal" by
+	 * closing stdout
+	 */
+	if (report_pid) {
+		while (!parent_ready) {
+			fprintf(stdout, "%d\n", getpid());
+			fflush(stdout);
+		}
+		/* at this point stdout is closed, parent process knows our
+		 * PID and is ready to trace us
+		 */
+	}
 
 	urandom_read(fd, count);
 
diff --git a/tools/testing/selftests/bpf/urandom_read_aux.c b/tools/testing/selftests/bpf/urandom_read_aux.c
new file mode 100644
index 000000000000..6132edcfea74
--- /dev/null
+++ b/tools/testing/selftests/bpf/urandom_read_aux.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include "sdt.h"
+
+void urand_read_without_sema(int iter_num, int iter_cnt, int read_sz)
+{
+	/* semaphore-less USDT */
+	STAP_PROBE3(urand, read_without_sema, iter_num, iter_cnt, read_sz);
+}
diff --git a/tools/testing/selftests/bpf/urandom_read_lib1.c b/tools/testing/selftests/bpf/urandom_read_lib1.c
new file mode 100644
index 000000000000..86186e24b740
--- /dev/null
+++ b/tools/testing/selftests/bpf/urandom_read_lib1.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#define _SDT_HAS_SEMAPHORES 1
+#include "sdt.h"
+
+#define SEC(name) __attribute__((section(name), used))
+
+unsigned short urandlib_read_with_sema_semaphore SEC(".probes");
+
+void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz)
+{
+	STAP_PROBE3(urandlib, read_with_sema, iter_num, iter_cnt, read_sz);
+}
diff --git a/tools/testing/selftests/bpf/urandom_read_lib2.c b/tools/testing/selftests/bpf/urandom_read_lib2.c
new file mode 100644
index 000000000000..9d401ad9838f
--- /dev/null
+++ b/tools/testing/selftests/bpf/urandom_read_lib2.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include "sdt.h"
+
+void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz)
+{
+	STAP_PROBE3(urandlib, read_without_sema, iter_num, iter_cnt, read_sz);
+}
-- 
2.30.2

