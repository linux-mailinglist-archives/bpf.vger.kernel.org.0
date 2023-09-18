Return-Path: <bpf+bounces-10248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B0A7A409F
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 07:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86712281441
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4C5382;
	Mon, 18 Sep 2023 05:50:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91004C94
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 05:50:47 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D695812C
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fb5bd8f02so3734008b3a.0
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695016243; x=1695621043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5Sb3+8Uafy88927NawdLniY68hliwCTAVrfcJRIBIQ=;
        b=io+JIJGH0D7D/XjIcYU6ztuS9tWwHzsUZJ+OUTlhtuu8MU9atm7V3ECmjqGnTxRfw6
         eanZ084LZOGD6+LOmKDvW0L7ETISlJFeIRtddqV+sd5s1bFOlctLUEw0aCI5+4sU1nQw
         /WZkBQ0zfcyopu9EGnLZGqx7z2zJMhXlbM8Xs9Ba2cf5jl9zmlFU0fM+w+5w8ljb5bln
         AqjFoiClYwvbiLSNNZyudiCtuLktNUOhk8SUB3cJXijxIGRNcoEYkTjfO7BxEchBsCsU
         667+f9gvy7EuLpm9cRyB3oCTfyMq79Mwm81oppvOhiGpo8wJuzoyXjnOL1RDCotbKBtH
         P3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016243; x=1695621043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5Sb3+8Uafy88927NawdLniY68hliwCTAVrfcJRIBIQ=;
        b=pQ8bovm7H9NNGWLh3tSzPbAIiXjC5d5A/Dsj4Z+HsHTiuc2YCjQDHBGoS8FB0tn6bZ
         55+Hxyn6J1fa+hefqD+TFgU8tinNWnUzvb+RhNwbdeD5agui31AhjPrLEWnKdv/zanmr
         IH7lS0/6lNnkgf0yp/KmeKgGucphjueCbb3lWbhBtyH1rdeM/QChJNOctz8ppuKibqjP
         I6YMFcRFoeAbmJn5gwxi804yF1z4BGdg9UqbmEIzzsO3cWxQR8adhzbhVhRJ1/NRTPi3
         mrUPpv98rTlji18SeYguUZ6q5tmc269j6PKKDQBxlmcpVDKVh+xlHOBoQhHhgn2sEKB/
         LFhw==
X-Gm-Message-State: AOJu0Yyt/fre1fKT9YHeOLLRcALaYyM4tWKsZJjQTazY1PiLyOp7g9Ub
	L91ougsyn+ms4Px/yQ1XEz+CL0Avy5+25w==
X-Google-Smtp-Source: AGHT+IHzR1cPsyM3GB0o3RGpI53Xb0WvxcYgbEsYGllwJcGOE0xk35erhBoV3sRYyZifaF+TwBO6ww==
X-Received: by 2002:a05:6a00:845:b0:690:3abc:8043 with SMTP id q5-20020a056a00084500b006903abc8043mr8064115pfk.8.1695016243075;
        Sun, 17 Sep 2023 22:50:43 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id i15-20020aa787cf000000b006877a17b578sm6374496pfo.40.2023.09.17.22.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 22:50:42 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Add tests for symbol versioning for uprobe
Date: Mon, 18 Sep 2023 02:48:13 +0000
Message-Id: <20230918024813.237475-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918024813.237475-1-hengqi.chen@gmail.com>
References: <20230918024813.237475-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
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
 tools/testing/selftests/bpf/urandom_read.c    | 15 ++-
 .../testing/selftests/bpf/urandom_read_lib1.c | 22 +++++
 6 files changed, 209 insertions(+), 4 deletions(-)
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
index e92644d0fa75..4ed795655b9f 100644
--- a/tools/testing/selftests/bpf/urandom_read.c
+++ b/tools/testing/selftests/bpf/urandom_read.c
@@ -11,6 +11,9 @@
 #define _SDT_HAS_SEMAPHORES 1
 #include "sdt.h"
 
+#define SHARED 1
+#include "bpf/libbpf_internal.h"
+
 #define SEC(name) __attribute__((section(name), used))
 
 #define BUF_SIZE 256
@@ -21,10 +24,14 @@ void urand_read_without_sema(int iter_num, int iter_cnt, int read_sz);
 void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz);
 void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz);
 
+int urandlib_api(void);
+COMPAT_VERSION(urandlib_api_old, urandlib_api, LIBURANDOM_READ_1.0.0)
+int urandlib_api_old(void);
+int urandlib_api_sameoffset(void);
+
 unsigned short urand_read_with_sema_semaphore SEC(".probes");
 
-static __attribute__((noinline))
-void urandom_read(int fd, int count)
+static noinline void urandom_read(int fd, int count)
 {
 	char buf[BUF_SIZE];
 	int i;
@@ -83,6 +90,10 @@ int main(int argc, char *argv[])
 
 	urandom_read(fd, count);
 
+	urandlib_api();
+	urandlib_api_old();
+	urandlib_api_sameoffset();
+
 	close(fd);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/urandom_read_lib1.c b/tools/testing/selftests/bpf/urandom_read_lib1.c
index 86186e24b740..8c1356d8b4ee 100644
--- a/tools/testing/selftests/bpf/urandom_read_lib1.c
+++ b/tools/testing/selftests/bpf/urandom_read_lib1.c
@@ -3,6 +3,9 @@
 #define _SDT_HAS_SEMAPHORES 1
 #include "sdt.h"
 
+#define SHARED 1
+#include "bpf/libbpf_internal.h"
+
 #define SEC(name) __attribute__((section(name), used))
 
 unsigned short urandlib_read_with_sema_semaphore SEC(".probes");
@@ -11,3 +14,22 @@ void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz)
 {
 	STAP_PROBE3(urandlib, read_with_sema, iter_num, iter_cnt, read_sz);
 }
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


