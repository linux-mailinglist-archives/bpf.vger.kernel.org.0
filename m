Return-Path: <bpf+bounces-9620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB2979A10D
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 03:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BCF1C2084A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 01:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85B1857;
	Mon, 11 Sep 2023 01:51:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF817C8
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 01:51:34 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE83126
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bf0decd032so3136393a34.0
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694397092; x=1695001892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s3FM8z55w4IXSrPLPtNQy2dtZSbGLmjGtyLV20M5T8=;
        b=igKOjwr6nQQdJ/qhGkJWmLka3ZVFJ8RqA9zHcSyFRcbRPEzmYk1o4MOY0UZ6pjWwA+
         s+rDFhgYcOn+Lk1YXlurmpFeq+g84koOTbIvtlSXR7uFZq8qhOtrbxdiNseEHL9j7NEa
         a/WenL6SVp23Kvd8V8DWDUbcWJ9X7/DwCfSol50FPtZK2/ffbuKrl6ENRiWB0CoWkFjq
         eEs9ilEUUvcoO34AFYMJqRF6QPjp16bDQl7VqQwUM4urQwHibOArHSgFGH+s9y2S/Agu
         MwbOMt7u7Sc7x85l9fLgHdIX2TD5TK2cENt8O9qKi9FXPEQTwEfXfM7pGWZbIvykHtXS
         0miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694397092; x=1695001892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s3FM8z55w4IXSrPLPtNQy2dtZSbGLmjGtyLV20M5T8=;
        b=Cjoy3uXqpjZvvnz3XBErf0ncnmNLwzRLalYuWnQyMjz11ddwRiecNcyzbj8joTpSfZ
         kqVuckYpkGOKhVLdSAVwbEg1OvMPGh3VNYeAnxQshmRl2pqBMSaRwUkfy/4xnca0ck59
         EtnoBp7T//ZbiCbG6ysDfEQkfm3XpZGtjCHD3h+m8cTz3BuxuaFhcLH+O8oVbfTW5thP
         CVVlfy0nHO9OWA+al8ZQy/ZGUAEViOQR5jWx3QPQfEyMZnmta8jgZdhHnphyqeTakivt
         xA9iyc6TQ6068xwGYnkzJTKyAX16WfKXoJCBGgZeGPeQrpGW+qjwzg9c8HT47avx6/eJ
         oewg==
X-Gm-Message-State: AOJu0Yw0ywuOOI6xf7OC8SwZJSCBTGO9j97U7yz/YtMRscbONnxGp4Ps
	odvlNayyv9lgHk5/iQvDIFfGSuY9tf38Uw==
X-Google-Smtp-Source: AGHT+IF2gco3QX0wS3HeFyFar1Rr1a+qarscLWH2ZONmmV9NOYJ75gspSloWLfDkE0RXxvS5A1vy9g==
X-Received: by 2002:a05:6830:22e7:b0:6bd:b10:c321 with SMTP id t7-20020a05683022e700b006bd0b10c321mr8312677otc.10.1694397092406;
        Sun, 10 Sep 2023 18:51:32 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id z14-20020a63b04e000000b0056365ee8603sm4375699pgo.67.2023.09.10.18.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 18:51:31 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for symbol versioning for uprobe
Date: Mon, 11 Sep 2023 01:50:52 +0000
Message-Id: <20230911015052.72975-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230911015052.72975-1-hengqi.chen@gmail.com>
References: <20230911015052.72975-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This exercises the newly added dynsym symbol versioning logics.
Now we accept symbols in form of func, func@LIB_VERSION or
func@@LIB_VERSION.

The test rely on liburandom_read.so. For liburandom_read.so, we have:

    $ nm -D liburandom_read.so
                     w __cxa_finalize@GLIBC_2.17
                     w __gmon_start__
                     w _ITM_deregisterTMCloneTable
                     w _ITM_registerTMCloneTable
    0000000000000000 A LIBURANDOM_READ_1.0.0
    0000000000000000 A LIBURANDOM_READ_2.0.0
    000000000000081c T urandlib_api@@LIBURANDOM_READ_2.0.0
    0000000000000814 T urandlib_api@LIBURANDOM_READ_1.0.0
    0000000000000824 T urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0
    0000000000000824 T urandlib_api_sameoffset@@LIBURANDOM_READ_2.0.0
    000000000000082c T urandlib_read_without_sema@@LIBURANDOM_READ_1.0.0
    00000000000007c4 T urandlib_read_with_sema@@LIBURANDOM_READ_1.0.0
    0000000000011018 D urandlib_read_with_sema_semaphore@@LIBURANDOM_READ_1.0.0

For `urandlib_api`, specifying `urandlib_api` will cause a conflict because
there are two symbols named urandlib_api and both are global bind.
For `urandlib_api_sameoffset`, there are also two symbols in the .so, but
both are at the same offset and essentially they refer to the same function
so no conflict.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |  5 +-
 .../testing/selftests/bpf/liburandom_read.map | 15 +++
 .../testing/selftests/bpf/prog_tests/uprobe.c | 95 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_uprobe.c | 61 ++++++++++++
 tools/testing/selftests/bpf/urandom_read.c    |  9 ++
 .../testing/selftests/bpf/urandom_read_lib1.c | 41 ++++++++
 6 files changed, 224 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..47365161b6fc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -196,11 +196,12 @@ endif
 
 # Filter out -static for liburandom_read.so and its dependent targets so that static builds
 # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
-$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
+$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
 	$(call msg,LIB,,$@)
 	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
-		     $^ $(filter-out -static,$(LDLIBS))	     \
+		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
+		     -Wl,--version-script=liburandom_read.map \
 		     -fPIC -shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
diff --git a/tools/testing/selftests/bpf/liburandom_read.map b/tools/testing/selftests/bpf/liburandom_read.map
new file mode 100644
index 000000000000..38a97a419a04
--- /dev/null
+++ b/tools/testing/selftests/bpf/liburandom_read.map
@@ -0,0 +1,15 @@
+LIBURANDOM_READ_1.0.0 {
+	global:
+		urandlib_api;
+		urandlib_api_sameoffset;
+		urandlib_read_without_sema;
+		urandlib_read_with_sema;
+		urandlib_read_with_sema_semaphore;
+	local:
+		*;
+};
+
+LIBURANDOM_READ_2.0.0 {
+	global:
+		urandlib_api;
+} LIBURANDOM_READ_1.0.0;
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
new file mode 100644
index 000000000000..cf3e0e7a64fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Hengqi Chen */
+
+#include <test_progs.h>
+#include "test_uprobe.skel.h"
+
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
+		errno = EINVAL;
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
+void test_uprobe(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct test_uprobe *skel;
+	FILE *urand_pipe = NULL;
+	int urand_pid = 0, err;
+
+	skel = test_uprobe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	urand_pipe = urand_spawn(&urand_pid);
+	if (!ASSERT_OK_PTR(urand_pipe, "urand_spawn"))
+		goto cleanup;
+
+	skel->bss->my_pid = urand_pid;
+
+	/* Manual attach uprobe to urandlib_api
+	 * There are two `urandlib_api` symbols in .dynsym section:
+	 *   - urandlib_api@LIBURANDOM_READ_1.0.0
+	 *   - urandlib_api@@LIBURANDOM_READ_2.0.0
+	 * Both are global bind and would cause a conflict if user
+	 * specify the symbol name without a version suffix
+	 */
+	uprobe_opts.func_name = "urandlib_api";
+	skel->links.test4 = bpf_program__attach_uprobe_opts(skel->progs.test4,
+							    urand_pid,
+							    "./liburandom_read.so",
+							    0 /* offset */,
+							    &uprobe_opts);
+	if (!ASSERT_ERR_PTR(skel->links.test4, "urandlib_api_attach_conflict"))
+		goto cleanup;
+
+	uprobe_opts.func_name = "urandlib_api@LIBURANDOM_READ_1.0.0";
+	skel->links.test4 = bpf_program__attach_uprobe_opts(skel->progs.test4,
+							    urand_pid,
+							    "./liburandom_read.so",
+							    0 /* offset */,
+							    &uprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.test4, "urandlib_api_attach_ok"))
+		goto cleanup;
+
+	/* Auto attach 3 u[ret]probes to urandlib_api_sameoffset */
+	err = test_uprobe__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger urandom_read */
+	ASSERT_OK(urand_trigger(&urand_pipe), "urand_exit_code");
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "urandlib_api_sameoffset");
+	ASSERT_EQ(skel->bss->test2_result, 1, "urandlib_api_sameoffset@v1");
+	ASSERT_EQ(skel->bss->test3_result, 3, "urandlib_api_sameoffset@@v2");
+	ASSERT_EQ(skel->bss->test4_result, 1, "urandlib_api");
+
+cleanup:
+	if (urand_pipe)
+		pclose(urand_pipe);
+	test_uprobe__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe.c b/tools/testing/selftests/bpf/progs/test_uprobe.c
new file mode 100644
index 000000000000..896c88a4960d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_uprobe.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+pid_t my_pid = 0;
+
+int test1_result = 0;
+int test2_result = 0;
+int test3_result = 0;
+int test4_result = 0;
+
+SEC("uprobe/./liburandom_read.so:urandlib_api_sameoffset")
+int BPF_UPROBE(test1)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	test1_result = 1;
+	return 0;
+}
+
+SEC("uprobe/./liburandom_read.so:urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0")
+int BPF_UPROBE(test2)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	test2_result = 1;
+	return 0;
+}
+
+SEC("uretprobe/./liburandom_read.so:urandlib_api_sameoffset@@LIBURANDOM_READ_2.0.0")
+int BPF_URETPROBE(test3, int ret)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	test3_result = ret;
+	return 0;
+}
+
+SEC("uprobe")
+int BPF_UPROBE(test4)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	test4_result = 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/selftests/bpf/urandom_read.c
index e92644d0fa75..b28e910a8fbb 100644
--- a/tools/testing/selftests/bpf/urandom_read.c
+++ b/tools/testing/selftests/bpf/urandom_read.c
@@ -21,6 +21,11 @@ void urand_read_without_sema(int iter_num, int iter_cnt, int read_sz);
 void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz);
 void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz);
 
+int urandlib_api(void);
+__asm__(".symver urandlib_api_old,urandlib_api@LIBURANDOM_READ_1.0.0");
+int urandlib_api_old(void);
+int urandlib_api_sameoffset(void);
+
 unsigned short urand_read_with_sema_semaphore SEC(".probes");
 
 static __attribute__((noinline))
@@ -83,6 +88,10 @@ int main(int argc, char *argv[])
 
 	urandom_read(fd, count);
 
+	urandlib_api();
+	urandlib_api_old();
+	urandlib_api_sameoffset();
+
 	close(fd);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/urandom_read_lib1.c b/tools/testing/selftests/bpf/urandom_read_lib1.c
index 86186e24b740..403b0735e223 100644
--- a/tools/testing/selftests/bpf/urandom_read_lib1.c
+++ b/tools/testing/selftests/bpf/urandom_read_lib1.c
@@ -11,3 +11,44 @@ void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz)
 {
 	STAP_PROBE3(urandlib, read_with_sema, iter_num, iter_cnt, read_sz);
 }
+
+/* Symbol versioning is different between static and shared library.
+ * Properly versioned symbols are needed for shared library, but
+ * only the symbol of the new version is needed for static library.
+ * Starting with GNU C 10, use symver attribute instead of .symver assembler
+ * directive, which works better with GCC LTO builds.
+ */
+#if defined(__GNUC__) && __GNUC__ >= 10
+
+#define DEFAULT_VERSION(internal_name, api_name, version) \
+	__attribute__((symver(#api_name "@@" #version)))
+#define COMPAT_VERSION(internal_name, api_name, version) \
+	__attribute__((symver(#api_name "@" #version)))
+
+#else
+
+#define COMPAT_VERSION(internal_name, api_name, version) \
+	asm(".symver " #internal_name "," #api_name "@" #version);
+#define DEFAULT_VERSION(internal_name, api_name, version) \
+	asm(".symver " #internal_name "," #api_name "@@" #version);
+
+#endif
+
+COMPAT_VERSION(urandlib_api_v1, urandlib_api, LIBURANDOM_READ_1.0.0)
+int urandlib_api_v1(void)
+{
+	return 1;
+}
+
+DEFAULT_VERSION(urandlib_api_v2, urandlib_api, LIBURANDOM_READ_2.0.0)
+int urandlib_api_v2(void)
+{
+	return 2;
+}
+
+COMPAT_VERSION(urandlib_api_sameoffset, urandlib_api_sameoffset, LIBURANDOM_READ_1.0.0)
+DEFAULT_VERSION(urandlib_api_sameoffset, urandlib_api_sameoffset, LIBURANDOM_READ_2.0.0)
+int urandlib_api_sameoffset(void)
+{
+	return 3;
+}
-- 
2.34.1


