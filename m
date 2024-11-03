Return-Path: <bpf+bounces-43842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509129BA777
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757551C20A44
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D377188580;
	Sun,  3 Nov 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OncvpCpb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A813635E
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730659312; cv=none; b=AbdMvtQDNFrE02Dz/9DRVyFQDJjuG2yQ/j6wBt0OhcBx6OpttxIj0nLUfHx86hOt+d4Gvnm52Uu/TALcnVpo6EjQSwDQpY9qby70yDZiWdUGnDOYknTgQTym/jCtobeMc78T1xUevY4XcM7Lji3WVnQZ/7AARLAqstOCEoaBlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730659312; c=relaxed/simple;
	bh=4TC1yU3e4RGM8kF2syon9apKtBSaDYZsSpnbvTnzZe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXxplYXVSz3CliTOMrnU4n3xL0hNGBHWf1qY0I6BAkS0Ad2+EhIiOhFNiW2+Rle2EwIo7pGSp9Jeh5ynNlHyazcosDEIwMkxUBg5F1sePxxuIsMJTSwFO9E3gjSSJtQT+5yfh9f2nCwsaYjw2mYnhKTSChqlLlizu+AD9FrhzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OncvpCpb; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-431616c23b5so20304985e9.0
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730659309; x=1731264109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdDCA9pAsJOtB4LaqR7u/qy6gL7EX715yP6s02c/72o=;
        b=OncvpCpbo7spfzRYM1FiiSqVc9UmgYR7HJ54UpyGZCuFuAuTnAou1ydmtHeCPRSZ4q
         2C8NAaqYjpmbY+Mn+isl1ZnmwbaUvT/uRx1acL1RQWE1ZHHSM8GJD9S9Oo1AYlvC64lA
         Lq1HlN44uAwJ83R35LjsfKSHb4ZZKNIw87sYttRIzhBl9+KS+9qjvqdcMntOKJ/6PED3
         TpAG/eklcDIngsUNnPntMkp7o08aIiubC2ocBiULyOmH8aK2lZm7bhfXHNFz9KLb9VM/
         ucwQFdrIy9riOsdJznc+KKGw3cSbj71/2gCBZW1nwvjFj9/o/JwXGLQXzS2xt/j5ftX1
         RMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730659309; x=1731264109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdDCA9pAsJOtB4LaqR7u/qy6gL7EX715yP6s02c/72o=;
        b=bQ8vggIvwrbvOeLSaOmJ9b1+q23teQZ/mPFvTXMhmuK6P/khOEnu0PTY2RTVyoRdJa
         J27f7svQtKjmWB2TKDVTN8vTiAFgC4fZrWRpopVst1YAVNoBVXWBgvKEutUBsQDzC1+m
         PsotNOKHGSvv6ZuV1SaCNx6ChMFNXeprMfkZxTIfDJihqCJqUJFYkpvn6LypYVeAZ0o0
         t5jNbdgxH5Y57yYONO6v2q9GX9ekwMtfoG8+GW0gFrHWVr0hCSJEsnKHZSoeQHbnc/rN
         DwOi0bW4OW/rPyCF0ciKL5st94YIcxgRzvQDFlZFiWFT0DcKCDMyE9UKYvr+PXAisn29
         Ra8g==
X-Gm-Message-State: AOJu0YzWlfsrF97femad//ndbHw/gIRCWtgRdWzygUIG3Q16YeKRmMKN
	H6i1d9roAcJrvoW5Mym0TOjnJNMz0MDOQnt+4VKKinlrhHZZ/Jkv31h3Lgs/Cke4pQ==
X-Google-Smtp-Source: AGHT+IGeL3z5tG9fikR1BTqJmOLQRs2dx+vBooiILu2v2TJvgfi/0Y/+sC5m/Xz7WUoD4IcIUiaqFQ==
X-Received: by 2002:a05:600c:1c26:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-4327daa3649mr97578305e9.8.1730659308613;
        Sun, 03 Nov 2024 10:41:48 -0800 (PST)
Received: from localhost (fwdproxy-cln-002.fbsv.net. [2a03:2880:31ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327bb7a1e0sm121966735e9.0.2024.11.03.10.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 10:41:48 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Clean up open-coded gettid syscall invocations
Date: Sun,  3 Nov 2024 10:41:43 -0800
Message-ID: <20241103184144.3765700-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241103184144.3765700-1-memxor@gmail.com>
References: <20241103184144.3765700-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11056; h=from:subject; bh=4TC1yU3e4RGM8kF2syon9apKtBSaDYZsSpnbvTnzZe4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ8PP2T4I/UA+33WRmB3afdg2m3HG/LOh0yO2GiXD FqXhnAOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyfDzwAKCRBM4MiGSL8Ryqs1EA Cg2CxT7w5gtNQA1UNMXf0hAsIdWbzzWnQYOzovpiLECkd7xS6hLUIH431AMSKFOpZEXQvBmYOcYHVd cvK/kg1CsMcE9cWb7/reYOIm3xRQTQl3CNvT/l46LY1HAHKRctfeF+Fmk0mpEETDIxzBfXW4NE7EpE Y+svkHTlKSQ7c22PP+djM22OR5NaYZP5K59n9pMeG18gs/O3xwO1PWQ8U1LkBcX9MQm1Ku7GUTNaRz RMuCv4trAObKClv6A3JvPJLWyiueG5FfwQakx8ZboR2AStc6y0FBdWn35wrSDyYcapje66VFOZpxo8 GbXxeaKPZITjpf9/O0HG95XKMu6P4worfT5YC2JqEntou5FAC41N9I6Ou0yq7yIhvJ6tcAEw1etw4x DwLHDYyBYl4NiAz06KioB0XNYBtjBPZ2fJeMNnW4sHQRY3bID98fRFOv78QHEb97wZgXOuYodSCXPQ vydRtPojaMsg/y1Kyg4TfOmE8c1xazABOi2y8pKgd2JualOI8i8E2rVDYIuu/HqzFA875sV51hP7Mv inVAazHlKiAUzrYAct8ZZgzn01vLlGMpIaXDCt37RHT0IZ1J7JXRkwiCMBhlL2zmE3j5k2ns1KrQ1Z Ai43rgWvBXZNUeW1gXUup/FnZkn9fT492x7nQv8Yyd9gp9ETe69CX2caRC3A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Availability of the gettid definition across glibc versions supported by
BPF selftests is not certain. Currently, all users in the tree open-code
syscall to gettid. Convert them to a common macro definition.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_trigger.c     |  3 ++-
 tools/testing/selftests/bpf/bpf_util.h                 |  9 +++++++++
 .../testing/selftests/bpf/map_tests/task_storage_map.c |  3 ++-
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c      |  6 +++---
 .../selftests/bpf/prog_tests/cgrp_local_storage.c      | 10 +++++-----
 tools/testing/selftests/bpf/prog_tests/core_reloc.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/linked_funcs.c  |  2 +-
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c     |  2 +-
 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c |  4 ++--
 .../selftests/bpf/prog_tests/task_local_storage.c      | 10 +++++-----
 .../selftests/bpf/prog_tests/uprobe_multi_test.c       |  2 +-
 12 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 2ed0ef6f21ee..32e9f194d449 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -4,6 +4,7 @@
 #include <argp.h>
 #include <unistd.h>
 #include <stdint.h>
+#include "bpf_util.h"
 #include "bench.h"
 #include "trigger_bench.skel.h"
 #include "trace_helpers.h"
@@ -72,7 +73,7 @@ static __always_inline void inc_counter(struct counter *counters)
 	unsigned slot;
 
 	if (unlikely(tid == 0))
-		tid = syscall(SYS_gettid);
+		tid = sys_gettid();
 
 	/* multiplicative hashing, it's fast */
 	slot = 2654435769U * tid;
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 10587a29b967..feff92219e21 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <syscall.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 
 static inline unsigned int bpf_num_possible_cpus(void)
@@ -59,4 +60,12 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 #endif
 
+/* Availability of gettid across glibc versions is hit-and-miss, therefore
+ * fallback to syscall in this macro and use it everywhere.
+ */
+#ifndef sys_gettid
+#define sys_gettid() syscall(SYS_gettid)
+#endif
+
+
 #endif /* __BPF_UTIL__ */
diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
index 7d050364efca..62971dbf2996 100644
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
@@ -12,6 +12,7 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
+#include "bpf_util.h"
 #include "test_maps.h"
 #include "task_local_storage_helpers.h"
 #include "read_bpf_task_storage_busy.skel.h"
@@ -115,7 +116,7 @@ void test_task_storage_map_stress_lookup(void)
 	CHECK(err, "attach", "error %d\n", err);
 
 	/* Trigger program */
-	syscall(SYS_gettid);
+	sys_gettid();
 	skel->bss->pid = 0;
 
 	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 070c52c312e5..6befa870434b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -690,7 +690,7 @@ void test_bpf_cookie(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->my_tid = syscall(SYS_gettid);
+	skel->bss->my_tid = sys_gettid();
 
 	if (test__start_subtest("kprobe"))
 		kprobe_subtest(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9006549a1294..b8e1224cfd19 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
 		  "pthread_create");
 
-	skel->bss->tid = syscall(SYS_gettid);
+	skel->bss->tid = sys_gettid();
 
 	do_dummy_read_opts(skel->progs.dump_task, opts);
 
@@ -255,10 +255,10 @@ static void *run_test_task_tid(void *arg)
 	union bpf_iter_link_info linfo;
 	int num_unknown_tid, num_known_tid;
 
-	ASSERT_NEQ(getpid(), syscall(SYS_gettid), "check_new_thread_id");
+	ASSERT_NEQ(getpid(), sys_gettid(), "check_new_thread_id");
 
 	memset(&linfo, 0, sizeof(linfo));
-	linfo.task.tid = syscall(SYS_gettid);
+	linfo.task.tid = sys_gettid();
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 	test_task_common(&opts, 0, 1);
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 747761572098..9015e2c2ab12 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -63,14 +63,14 @@ static void test_tp_btf(int cgroup_fd)
 	if (!ASSERT_OK(err, "map_delete_elem"))
 		goto out;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	err = cgrp_ls_tp_btf__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
-	syscall(SYS_gettid);
-	syscall(SYS_gettid);
+	sys_gettid();
+	sys_gettid();
 
 	skel->bss->target_pid = 0;
 
@@ -154,7 +154,7 @@ static void test_recursion(int cgroup_fd)
 		goto out;
 
 	/* trigger sys_enter, make sure it does not cause deadlock */
-	syscall(SYS_gettid);
+	sys_gettid();
 
 out:
 	cgrp_ls_recursion__destroy(skel);
@@ -224,7 +224,7 @@ static void test_yes_rcu_lock(__u64 cgroup_id)
 		return;
 
 	CGROUP_MODE_SET(skel);
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.yes_rcu_lock, true);
 	err = cgrp_ls_sleepable__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 26019313e1fc..1c682550e0e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -1010,7 +1010,7 @@ static void run_core_reloc_tests(bool use_btfgen)
 	struct data *data;
 	void *mmap_data = NULL;
 
-	my_pid_tgid = getpid() | ((uint64_t)syscall(SYS_gettid) << 32);
+	my_pid_tgid = getpid() | ((uint64_t)sys_gettid() << 32);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		char btf_file[] = "/tmp/core_reloc.btf.XXXXXX";
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
index cad664546912..fa639b021f7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
@@ -20,7 +20,7 @@ void test_linked_funcs(void)
 	bpf_program__set_autoload(skel->progs.handler1, true);
 	bpf_program__set_autoload(skel->progs.handler2, true);
 
-	skel->rodata->my_tid = syscall(SYS_gettid);
+	skel->rodata->my_tid = sys_gettid();
 	skel->bss->syscall_id = SYS_getpgid;
 
 	err = linked_funcs__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index c29787e092d6..761ce24bce38 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -23,7 +23,7 @@ static int get_pid_tgid(pid_t *pid, pid_t *tgid,
 	struct stat st;
 	int err;
 
-	*pid = syscall(SYS_gettid);
+	*pid = sys_gettid();
 	*tgid = getpid();
 
 	err = stat("/proc/self/ns/pid", &st);
diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index a1f7e7378a64..ebe0c12b5536 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -21,7 +21,7 @@ static void test_success(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.get_cgroup_id, true);
 	bpf_program__set_autoload(skel->progs.task_succ, true);
@@ -58,7 +58,7 @@ static void test_rcuptr_acquire(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.task_acquire, true);
 	err = rcu_read_lock__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 00cc9d0aee5d..60f474d965a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -31,14 +31,14 @@ static void test_sys_enter_exit(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	err = task_local_storage__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
-	syscall(SYS_gettid);
-	syscall(SYS_gettid);
+	sys_gettid();
+	sys_gettid();
 
 	/* 3x syscalls: 1x attach and 2x gettid */
 	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
@@ -107,7 +107,7 @@ static void test_recursion(void)
 
 	/* trigger sys_enter, make sure it does not cause deadlock */
 	skel->bss->test_pid = getpid();
-	syscall(SYS_gettid);
+	sys_gettid();
 	skel->bss->test_pid = 0;
 	task_ls_recursion__detach(skel);
 
@@ -262,7 +262,7 @@ static void test_uptr_basic(void)
 	__u64 ev_dummy_data = 1;
 	int err;
 
-	my_tid = syscall(SYS_gettid);
+	my_tid = sys_gettid();
 	parent_task_fd = sys_pidfd_open(my_tid, 0);
 	if (!ASSERT_OK_FD(parent_task_fd, "parent_task_fd"))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2c39902b8a09..619b31cd24a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -125,7 +125,7 @@ static void *child_thread(void *ctx)
 	struct child *child = ctx;
 	int c = 0, err;
 
-	child->tid = syscall(SYS_gettid);
+	child->tid = sys_gettid();
 
 	/* let parent know we are ready */
 	err = write(child->c2p[1], &c, 1);
-- 
2.43.5


