Return-Path: <bpf+bounces-524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CB4702E6F
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C334D28061B
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C07C8FA;
	Mon, 15 May 2023 13:38:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDABC8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93370C433EF;
	Mon, 15 May 2023 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157912;
	bh=19BL65JkXmfx8FRmoZ9Rv1lQgRVgLZNKLgZfWPFSsbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNgxUd6iJ37W1Z8N450fZCzFppdQUWwn9DFMvNAptFcMMqAc/LTCT6H5fCfmxDeTQ
	 7i5gXH2rht0VQnZH5lMQJZWGXRPix0dI08vph7vW9udUMlHtKAhcXDBdZxG9IyddMV
	 EWRo85GSG9ewmAC5lL6cQ35zzfmGQoK0vmzytYig0R2632c2lKANc+xQcBhA9JfinF
	 QNIymgwPEZq84n8pd6GG5ngbry23mJmevPcuvUFI8Yj0RevD2E11xegVznTDjWZ+J5
	 h8nnxRw5GD5a1OVF2Ullf/fvpSavb4DLJW4FLMyMyKBht1/3HqDvph7yiZ8FmMicRg
	 6zBbvxrUNnZTQ==
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
Subject: [PATCHv4 bpf-next 03/10] selftests/bpf: Move test_progs helpers to testing_helpers object
Date: Mon, 15 May 2023 15:37:49 +0200
Message-Id: <20230515133756.1658301-4-jolsa@kernel.org>
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

Moving test_progs helpers to testing_helpers object so they can be
used from test_verifier in following changes.

Also adding missing ifndef header guard to testing_helpers.h header.

Using stderr instead of env.stderr because un/load_bpf_testmod helpers
will be used outside test_progs. Also at the point of calling them
in test_progs the std files are not hijacked yet and stderr is the
same as env.stderr.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c      | 67 +------------------
 tools/testing/selftests/bpf/test_progs.h      |  1 -
 tools/testing/selftests/bpf/testing_helpers.c | 63 +++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  9 +++
 4 files changed, 74 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 793689dcc170..cebe62d29f8d 100644
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
@@ -629,68 +628,6 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 	return err;
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
@@ -1720,7 +1657,7 @@ int main(int argc, char **argv)
 	env.stderr = stderr;
 
 	env.has_testmod = true;
-	if (!env.list_test_names && load_bpf_testmod()) {
+	if (!env.list_test_names && load_bpf_testmod(verbose())) {
 		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
 		env.has_testmod = false;
 	}
@@ -1819,7 +1756,7 @@ int main(int argc, char **argv)
 	close(env.saved_netns_fd);
 out:
 	if (!env.list_test_names && env.has_testmod)
-		unload_bpf_testmod();
+		unload_bpf_testmod(verbose());
 
 	free_test_selector(&env.test_selector);
 	free_test_selector(&env.subtest_selector);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 0ed3134333d4..77bd492c6024 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -405,7 +405,6 @@ static inline void *u64_to_ptr(__u64 ptr)
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
-int kern_sync_rcu(void);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
 int write_sysctl(const char *sysctl, const char *value);
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index dc9595ade8de..648c7d3eb319 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -9,6 +9,7 @@
 #include <bpf/libbpf.h>
 #include "test_progs.h"
 #include "testing_helpers.h"
+#include <linux/membarrier.h>
 
 int parse_num_list(const char *s, bool **num_set, int *num_set_len)
 {
@@ -326,3 +327,65 @@ __u64 read_perf_max_sample_freq(void)
 	fclose(f);
 	return sample_freq;
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
index 98f09bbae86f..02e8c4efd028 100644
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
@@ -25,3 +29,8 @@ int parse_test_list_file(const char *path,
 			 bool is_glob_pattern);
 
 __u64 read_perf_max_sample_freq(void);
+int load_bpf_testmod(bool verbose);
+void unload_bpf_testmod(bool verbose);
+int kern_sync_rcu(void);
+
+#endif /* __TESTING_HELPERS_H */
-- 
2.40.1


