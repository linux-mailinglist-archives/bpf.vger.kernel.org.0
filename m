Return-Path: <bpf+bounces-43907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C19BBBAB
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F74E1F22548
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED71C728E;
	Mon,  4 Nov 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZvz4INt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198E1C4A35
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740807; cv=none; b=Objoum4XIX/v7oPMT6VrQpxnANP0sm3bCUhM+u49V1WQ1Xl0a+DkMjGRlNgGgHIFzSU6QaVwJ8upZoBtnhQprtPVs3oWoZNUe7mrKX8ExUoph5scyAZwkji+9cT1HntTuEllZsaNoLSafnOpEsEbvWeVKxt3rNTtx+48QSoQPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740807; c=relaxed/simple;
	bh=Z7cjYP4QsJ+BnSybtlL9J3lZJch4NFK3KHDaT+DIv2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDprSgUWX22l1TMZUsrm+/pLzah+5i9PbUXuVmzfC/M2kh2waDaMqiKGGw28IwOBy57YWU9CpgZSb5hwtp3FbR6wJAC2KGYT1k4Ed1oHaHkM5SeGwoWTS/8fOvvMeQYJm2Xujoe4cSVv8YCB9j0KBMQM9o7kdtp6mm1rDibBlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZvz4INt; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43161c0068bso36910625e9.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730740804; x=1731345604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKjo4C91lJow98z/oVtRJU91AWJCekjTvJvHVKnrk48=;
        b=EZvz4INtfE21dsyvbAQVVIrOMpui4kKAV3wtb2/uHlAQ9qmQGzW86EdzYOWDuj4jVc
         NlpkcyQCnoQ7EHUJVypA1qAoVaUGNICuAZtGivUM574cVH0E3oEYpEzWO5+bsH0difAw
         n0TymZcOTq0GPWQ2WQMKQYf3ptyWgOb5z1/UqNn+nk03kv9wIx0JjsTFXqPGzPwWV3C2
         qRev4O4i6oGhx8ZI3nq0Z5z2v3MDrkTLmdI8gjUd9AktCEZ5JAZ9NtUZv96LljdxugOb
         fDKjUy1jtkRstqBtQC0i9JI2Ymv4QtAsjRKiJB97SBQjZ76wn6UVfle3onKe9OvYQ2JT
         ZJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740804; x=1731345604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKjo4C91lJow98z/oVtRJU91AWJCekjTvJvHVKnrk48=;
        b=KON/bypHGQi35G+OwQe+OCEMow53oDTACNERlcAMl/yUEmZ71X+Tvgq63DDiSqjeJi
         joGlBLAqPjcLG+zV0bnHx+n1kNDSSNFMjuh6UFOFpWcJ+qeEKpZtFhNnpMNDG8045lmB
         SPHbvod6FT3eZai1po9zp9T7EcSZIUBTnK7fImK4k33V1CiZhlS+cgvkiUJmJjXCjy0Z
         ZESRPJGjFRizUvsDX+V+gWzvb8qPkL1EBl6qFRIlQL5tuT2xS0Ncy5D2kIQEwOzuFLg+
         MeYknB6Y1HPQpBC4oAR3fHqi7Z+KmOtDvMzxqhJ+jr2lqEHSqcwOYV9kcppDEuOKER+z
         AB1g==
X-Gm-Message-State: AOJu0YzbABotxtazfa0OGntg4tv3OI+JLoZzynZ/tF9R015557J7ct/7
	R1xtzxrmsyLFeEgFNHzgQQoHImZhWFjiuDmGLXrql1SZn2qWytAcR2Uhfu/t2DlIYg==
X-Google-Smtp-Source: AGHT+IEZKeqkkUGCLUMaE/qg9hrO04MPsBveh5QKCWN2sIBZnwVbD0DZpvz7UokRjyzhnyClyCa1gQ==
X-Received: by 2002:a05:600c:3ca1:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-4328327db85mr105674485e9.22.1730740803659;
        Mon, 04 Nov 2024 09:20:03 -0800 (PST)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ac37csm160092025e9.10.2024.11.04.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:20:03 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Clean up open-coded gettid syscall invocations
Date: Mon,  4 Nov 2024 09:19:58 -0800
Message-ID: <20241104171959.2938862-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104171959.2938862-1-memxor@gmail.com>
References: <20241104171959.2938862-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11099; h=from:subject; bh=Z7cjYP4QsJ+BnSybtlL9J3lZJch4NFK3KHDaT+DIv2g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnKQEyQsPqgdVUAcCuiGXMUyrvEVUgepUBVsp9DlEp nQlMGT+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZykBMgAKCRBM4MiGSL8RysQKD/ 91QvsLOdrjGoVKPAadlTO7L4hz19NG9d2QR6AlA5ns7Vbyl0OdiTbM7hts/xu9CWnARksTj/gpsf6E 2k7vRg90+TAdP4HdLdYZ9oGFeR8fDa7OjaC+coY1xDNFZpbGBceWQ/ERPyL0EKvAduIxjdujVHqgxr 1gSuI9iVAKEdJB+g7GlvI+8P4ZlUZN7BX4rdn/RQmi48MWD/TgEdyZZXVkCwG1ZGMb5k7kzkG6oIWP gQNHa/L0v4tSp6+on2358gb7AflkM+8qVqYeXgzw+KF5TU7VIDYM+YT2cANWtpbW+r/QI1lYy3hQnS 30Xzht8VUb3IESQ7IFOFl4o5IAWrnDmXSkCvEDiFErErgvpMsUDAJyOHaYiMR1VTV7p29k4K67cqDk jf/Xy5sdMmadlaVYMEFdBBJxogdkG+lK0Nn6OxhzRc/CENkVpdysJ2RfrESPuH3dZUg3J4WkNBwX5n w1C7kN7T6u/uMSrZuHrF1RpLInD0viGdfEwDdAJv6H9M02hkp0TVhRt36Pjt1wiJSpS1VMe0/Lks5R pAIBwa8RfLq6OQAZ3RKY6oqRnCcIZkqnu5hZATbaNUa3u8WG92Xe75TQAQW37w2Eqtbbn1Yvzg7gZ0 mRakn9AeyykWeWjSyJFbiSkbQDNZvTL1cqAOtK68ggWXC83Svd2Uws+T8d7Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Availability of the gettid definition across glibc versions supported by
BPF selftests is not certain. Currently, all users in the tree open-code
syscall to gettid. Convert them to a common macro definition.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
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


