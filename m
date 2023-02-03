Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839A9689F15
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBCQYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCQYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:24:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0ADA6B93
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:24:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5237CB82AF4
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA83C433EF;
        Fri,  3 Feb 2023 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441444;
        bh=Cya1oZIeLfbhR1VY5zTY3G3huPsGqvBmIZZEPv5Wai0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTKWkVbemCCarsDVinabBI5LzuJhcGtQ665VdxQOF7DJpT5wF92IxRGbPMZ/EPoNe
         ZMhd7FV6s281SSzq9Ph4PdTQruhuH4XHKnwAvhNdEySN7ZbREJvu+4hPhkMCzdwO8V
         l9TjPjL0jMSMI5JGXgvcknYeL7oPHgv0nCHq7fHtThGjRpRRz0ctRvUaCPq22gx4vt
         H3vfIF/qB3u0BtTQG7YKLy0NtlOD7W0RvKIOm2jSw1FfUy9yGNaAOmsAOJRE38Zz+Y
         cHa2ZQj9FWdHduRtWuRnGQM4ns9i9AM7uu+uWr9lGG7a/aq6pSjJKUiQgo8rrWNljC
         0cy1+1AMTFPfA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv3 bpf-next 2/9] selftests/bpf: Move test_progs helpers to testing_helpers object
Date:   Fri,  3 Feb 2023 17:23:29 +0100
Message-Id: <20230203162336.608323-3-jolsa@kernel.org>
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

Moving test_progs helpers to testing_helpers object so they can be
used from test_verifier in following changes.

Also adding missing ifndef header guard to testing_helpers.h header.

Using stderr instead of env.stderr because un/load_bpf_testmod helpers
will be used outside test_progs. Also at the point of calling them
in test_progs the std files are not hijacked yet and stderr is the
same as env.stderr.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c      | 67 +------------------
 tools/testing/selftests/bpf/test_progs.h      |  1 -
 tools/testing/selftests/bpf/testing_helpers.c | 63 +++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h | 10 +++
 4 files changed, 75 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 6d5e3022c75f..39ceb6a1bfc6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -11,7 +11,6 @@
 #include <signal.h>
 #include <string.h>
 #include <execinfo.h> /* backtrace */
-#include <linux/membarrier.h>
 #include <sys/sysinfo.h> /* get_nprocs */
 #include <netinet/in.h>
 #include <sys/select.h>
@@ -616,68 +615,6 @@ int extract_build_id(char *build_id, size_t size)
 	return -1;
 }
 
-static int finit_module(int fd, const char *param_values, int flags)
-{
-	return syscall(__NR_finit_module, fd, param_values, flags);
-}
-
-static int delete_module(const char *name, int flags)
-{
-	return syscall(__NR_delete_module, name, flags);
-}
-
-/*
- * Trigger synchronize_rcu() in kernel.
- */
-int kern_sync_rcu(void)
-{
-	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
-}
-
-static void unload_bpf_testmod(void)
-{
-	if (kern_sync_rcu())
-		fprintf(env.stderr, "Failed to trigger kernel-side RCU sync!\n");
-	if (delete_module("bpf_testmod", 0)) {
-		if (errno == ENOENT) {
-			if (verbose())
-				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
-			return;
-		}
-		fprintf(env.stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
-		return;
-	}
-	if (verbose())
-		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
-}
-
-static int load_bpf_testmod(void)
-{
-	int fd;
-
-	/* ensure previous instance of the module is unloaded */
-	unload_bpf_testmod();
-
-	if (verbose())
-		fprintf(stdout, "Loading bpf_testmod.ko...\n");
-
-	fd = open("bpf_testmod.ko", O_RDONLY);
-	if (fd < 0) {
-		fprintf(env.stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
-		return -ENOENT;
-	}
-	if (finit_module(fd, "", 0)) {
-		fprintf(env.stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
-		close(fd);
-		return -EINVAL;
-	}
-	close(fd);
-
-	if (verbose())
-		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
-	return 0;
-}
-
 /* extern declarations for test funcs */
 #define DEFINE_TEST(name)				\
 	extern void test_##name(void) __weak;		\
@@ -1655,7 +1592,7 @@ int main(int argc, char **argv)
 	env.stderr = stderr;
 
 	env.has_testmod = true;
-	if (!env.list_test_names && load_bpf_testmod()) {
+	if (!env.list_test_names && load_bpf_testmod(verbose())) {
 		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
 		env.has_testmod = false;
 	}
@@ -1754,7 +1691,7 @@ int main(int argc, char **argv)
 	close(env.saved_netns_fd);
 out:
 	if (!env.list_test_names && env.has_testmod)
-		unload_bpf_testmod();
+		unload_bpf_testmod(verbose());
 
 	free_test_selector(&env.test_selector);
 	free_test_selector(&env.subtest_selector);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index d5d51ec97ec8..b9dac3c32712 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -390,7 +390,6 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int extract_build_id(char *build_id, size_t size);
-int kern_sync_rcu(void);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
 int write_sysctl(const char *sysctl, const char *value);
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 9695318e8132..3a9e7e8e5b14 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -8,6 +8,7 @@
 #include <bpf/libbpf.h>
 #include "test_progs.h"
 #include "testing_helpers.h"
+#include <linux/membarrier.h>
 
 int parse_num_list(const char *s, bool **num_set, int *num_set_len)
 {
@@ -229,3 +230,65 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 
 	return bpf_prog_load(type, NULL, license, insns, insns_cnt, &opts);
 }
+
+static int finit_module(int fd, const char *param_values, int flags)
+{
+	return syscall(__NR_finit_module, fd, param_values, flags);
+}
+
+static int delete_module(const char *name, int flags)
+{
+	return syscall(__NR_delete_module, name, flags);
+}
+
+void unload_bpf_testmod(bool verbose)
+{
+	if (kern_sync_rcu())
+		fprintf(stderr, "Failed to trigger kernel-side RCU sync!\n");
+	if (delete_module("bpf_testmod", 0)) {
+		if (errno == ENOENT) {
+			if (verbose)
+				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
+			return;
+		}
+		fprintf(stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		return;
+	}
+	if (verbose)
+		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
+}
+
+int load_bpf_testmod(bool verbose)
+{
+	int fd;
+
+	/* ensure previous instance of the module is unloaded */
+	unload_bpf_testmod(verbose);
+
+	if (verbose)
+		fprintf(stdout, "Loading bpf_testmod.ko...\n");
+
+	fd = open("bpf_testmod.ko", O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		return -ENOENT;
+	}
+	if (finit_module(fd, "", 0)) {
+		fprintf(stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+		close(fd);
+		return -EINVAL;
+	}
+	close(fd);
+
+	if (verbose)
+		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
+	return 0;
+}
+
+/*
+ * Trigger synchronize_rcu() in kernel.
+ */
+int kern_sync_rcu(void)
+{
+	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 6ec00bf79cb5..7356474def27 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -1,5 +1,9 @@
 /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 /* Copyright (C) 2020 Facebook, Inc. */
+
+#ifndef __TESTING_HELPERS_H
+#define __TESTING_HELPERS_H
+
 #include <stdbool.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
@@ -20,3 +24,9 @@ struct test_filter_set;
 int parse_test_list(const char *s,
 		    struct test_filter_set *test_set,
 		    bool is_glob_pattern);
+
+int load_bpf_testmod(bool verbose);
+void unload_bpf_testmod(bool verbose);
+int kern_sync_rcu(void);
+
+#endif /* __TESTING_HELPERS_H */
-- 
2.39.1

