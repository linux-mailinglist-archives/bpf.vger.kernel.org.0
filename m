Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FD689F1D
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjBCQY6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjBCQYz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE52A6BB0
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:24:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F12561F6A
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13F6C433EF;
        Fri,  3 Feb 2023 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441476;
        bh=TvD6QRmuzKiP9ZIoeQRLZh6bCBRyg75kVCSuz38wmU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTtMc4pUt/OggHagnKcNiA165dUYKDm/6tLHsSiKPSPC5Qlcx7mCS92uivkascrp/
         et5/cc9iNX14sBZ5XqjET2b3jyBsJ1oFtlGVUziwU18eLVPbCIn+hsnC841Gxvwbwz
         knZ0jLuJPBdUkDAGK5cWmfN5eji56iBiI2TbYJsD0gFGmNjC/KlDO9SbWxs5md0kI0
         geW141/PcSKVPFu60beslqF5WxZ7GsYazAtq6ws63ppgUVaAf9Cahs7OLrDHvvbT0P
         ARYi9N0A+EXW/ti77yP1yUtlILocAMZpNqZmvtIAYahn3P002iXgE1cKKmSjlrHZzk
         Ayg7iSU50++xg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv3 bpf-next 5/9] selftests/bpf: Use un/load_bpf_testmod functions in tests
Date:   Fri,  3 Feb 2023 17:23:32 +0100
Message-Id: <20230203162336.608323-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203162336.608323-1-jolsa@kernel.org>
References: <20230203162336.608323-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
index 3872c36c17d4..030ed157954e 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -241,7 +241,7 @@ static int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-void unload_bpf_testmod(bool verbose)
+int unload_bpf_testmod(bool verbose)
 {
 	if (kern_sync_rcu())
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
@@ -249,13 +249,14 @@ void unload_bpf_testmod(bool verbose)
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
index 7356474def27..713f8e37163d 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -26,7 +26,7 @@ int parse_test_list(const char *s,
 		    bool is_glob_pattern);
 
 int load_bpf_testmod(bool verbose);
-void unload_bpf_testmod(bool verbose);
+int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
 
 #endif /* __TESTING_HELPERS_H */
-- 
2.39.1

