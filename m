Return-Path: <bpf+bounces-527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E33702E73
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254BD1C20A5F
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02FC8FC;
	Mon, 15 May 2023 13:39:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59980C8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E13C433D2;
	Mon, 15 May 2023 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157943;
	bh=ns3+Z1RKTiIfNy2jCTdnNy/ra8qt03E1jNnrb5U+Yi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjgBMSBS3tn35HV8mAlJxb8xHmhZR0A2fFvV6yXWuTkh/lpjjdjt/St5IkUf8ceuf
	 h8myqM0gWsZP5Du7yeSXI4bWG92RKAlFdP5p7Sq4oKnUdI0rT7/lM6WueC2A4lDBuU
	 k0xq3Q7T8sLeBE4pSE+/yQwvKqfoGXYPB3MRvouskbHaBFt1o/ZR57KlOuMbgT5HH0
	 h9vA4LKeoqRnmHh4/DbOixIBc3cAsVc5x9v0CjJvn1Qa1ntn/zAjSufEmqeP/zZRSJ
	 IQU+VlkVkfkUFSdDUJqwaa+YVCN6I9RDCpNLRTbo3hWMvXdkQyKJylbdPwHIlg6Vqz
	 9DrRncArgLvIw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 06/10] selftests/bpf: Use un/load_bpf_testmod functions in tests
Date: Mon, 15 May 2023 15:37:52 +0200
Message-Id: <20230515133756.1658301-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have un/load_bpf_testmod helpers in testing_helpers.h,
we can use it in other tests and save some lines.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_mod_race.c   | 34 +++----------------
 .../selftests/bpf/prog_tests/module_attach.c  | 12 +++----
 tools/testing/selftests/bpf/testing_helpers.c |  7 ++--
 tools/testing/selftests/bpf/testing_helpers.h |  2 +-
 4 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
index a4d0cc9d3367..fe2c502e5089 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
@@ -11,6 +11,7 @@
 #include "ksym_race.skel.h"
 #include "bpf_mod_race.skel.h"
 #include "kfunc_call_race.skel.h"
+#include "testing_helpers.h"
 
 /* This test crafts a race between btf_try_get_module and do_init_module, and
  * checks whether btf_try_get_module handles the invocation for a well-formed
@@ -44,35 +45,10 @@ enum bpf_test_state {
 
 static _Atomic enum bpf_test_state state = _TS_INVALID;
 
-static int sys_finit_module(int fd, const char *param_values, int flags)
-{
-	return syscall(__NR_finit_module, fd, param_values, flags);
-}
-
-static int sys_delete_module(const char *name, unsigned int flags)
-{
-	return syscall(__NR_delete_module, name, flags);
-}
-
-static int load_module(const char *mod)
-{
-	int ret, fd;
-
-	fd = open("bpf_testmod.ko", O_RDONLY);
-	if (fd < 0)
-		return fd;
-
-	ret = sys_finit_module(fd, "", 0);
-	close(fd);
-	if (ret < 0)
-		return ret;
-	return 0;
-}
-
 static void *load_module_thread(void *p)
 {
 
-	if (!ASSERT_NEQ(load_module("bpf_testmod.ko"), 0, "load_module_thread must fail"))
+	if (!ASSERT_NEQ(load_bpf_testmod(false), 0, "load_module_thread must fail"))
 		atomic_store(&state, TS_MODULE_LOAD);
 	else
 		atomic_store(&state, TS_MODULE_LOAD_FAIL);
@@ -124,7 +100,7 @@ static void test_bpf_mod_race_config(const struct test_config *config)
 	if (!ASSERT_NEQ(fault_addr, MAP_FAILED, "mmap for uffd registration"))
 		return;
 
-	if (!ASSERT_OK(sys_delete_module("bpf_testmod", 0), "unload bpf_testmod"))
+	if (!ASSERT_OK(unload_bpf_testmod(false), "unload bpf_testmod"))
 		goto end_mmap;
 
 	skel = bpf_mod_race__open();
@@ -202,8 +178,8 @@ static void test_bpf_mod_race_config(const struct test_config *config)
 	bpf_mod_race__destroy(skel);
 	ASSERT_OK(kern_sync_rcu(), "kern_sync_rcu");
 end_module:
-	sys_delete_module("bpf_testmod", 0);
-	ASSERT_OK(load_module("bpf_testmod.ko"), "restore bpf_testmod");
+	unload_bpf_testmod(false);
+	ASSERT_OK(load_bpf_testmod(false), "restore bpf_testmod");
 end_mmap:
 	munmap(fault_addr, 4096);
 	atomic_store(&state, _TS_INVALID);
diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 7fc01ff490db..f53d658ed080 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <stdbool.h>
 #include "test_module_attach.skel.h"
+#include "testing_helpers.h"
 
 static int duration;
 
@@ -32,11 +33,6 @@ static int trigger_module_test_writable(int *val)
 	return 0;
 }
 
-static int delete_module(const char *name, int flags)
-{
-	return syscall(__NR_delete_module, name, flags);
-}
-
 void test_module_attach(void)
 {
 	const int READ_SZ = 456;
@@ -93,21 +89,21 @@ void test_module_attach(void)
 	if (!ASSERT_OK_PTR(link, "attach_fentry"))
 		goto cleanup;
 
-	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
+	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
 	bpf_link__destroy(link);
 
 	link = bpf_program__attach(skel->progs.handle_fexit);
 	if (!ASSERT_OK_PTR(link, "attach_fexit"))
 		goto cleanup;
 
-	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
+	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
 	bpf_link__destroy(link);
 
 	link = bpf_program__attach(skel->progs.kprobe_multi);
 	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
 		goto cleanup;
 
-	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
+	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
 	bpf_link__destroy(link);
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index e01d7a62306c..8d994884c7b4 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -338,7 +338,7 @@ static int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-void unload_bpf_testmod(bool verbose)
+int unload_bpf_testmod(bool verbose)
 {
 	if (kern_sync_rcu())
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
@@ -346,13 +346,14 @@ void unload_bpf_testmod(bool verbose)
 		if (errno == ENOENT) {
 			if (verbose)
 				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
-			return;
+			return -1;
 		}
 		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
-		return;
+		return -1;
 	}
 	if (verbose)
 		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
+	return 0;
 }
 
 int load_bpf_testmod(bool verbose)
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 02e8c4efd028..5312323881b6 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -30,7 +30,7 @@ int parse_test_list_file(const char *path,
 
 __u64 read_perf_max_sample_freq(void);
 int load_bpf_testmod(bool verbose);
-void unload_bpf_testmod(bool verbose);
+int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
 
 #endif /* __TESTING_HELPERS_H */
-- 
2.40.1


