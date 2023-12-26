Return-Path: <bpf+bounces-18680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8581E927
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 20:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F067A1C20A8C
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7B1851;
	Tue, 26 Dec 2023 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7fIU3wW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A51852
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1202797a12.0
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617917; x=1704222717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqGqNfgb2xyAqgoJbpnRLIKIuvnvCgyDMMFdyncOT7w=;
        b=W7fIU3wWbo8UVb1HH9EEDEiP8RleR/GdjavvFE9yAn8i7VeChmNplZHKq1GkilJBxB
         nY7uzKf6V9dwaL9CHxkM91rPfIhPsqxx8WqE09J+qWKVyeeFHV6PwHuzUpeAxLNhRMnT
         aao7VvtJ/JM6OPqewlJZP/7FOQq043izpHK6hYiT1KX/xWF5mVjrMEzwT+q8AkorTXxu
         1FKxH7PomSl3o94ZLLukGAlITjMgjE0CNoS0WqXX55U5ZWGc3v5qLduwxVbDoD/BHcwV
         71NH805MkWxnjBHTbLyQbLtfe9mSFLXCLZ3ipVaKqw63VCelHxojxCz1Rho7Xw5kLPkb
         z3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617917; x=1704222717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqGqNfgb2xyAqgoJbpnRLIKIuvnvCgyDMMFdyncOT7w=;
        b=r9w38REfJeAmX82YFxYl8bzm8iwwnjwAxJbqWDBx+n2exmQbBCFylgpnn+/L6PF0Kb
         F27pPIlhXdDolyZfUeEe+9oum1yv66vOKJ1knU05h0SszMWhe4hgZYIxjq44TuVG0A9o
         ruOoojwjGv7pUQ+QFj7bnRSxfpbId0IOVm0HvH2kD/w+f2tskmtNxFC6kYRhfJIDwiVi
         q//czWV8nCt/OJqZkleB/1FJvCUNGd34iUylxQNwxwPZT49WoamwNcPxLOCIkOtAKzp1
         bI8lO6FREK911qmZCBiOObdvFuBBNGls3hMi2+KhPRuF6Q3HmxfcpRau4mEcNwaIPhdW
         FP6A==
X-Gm-Message-State: AOJu0Yw8Qk7Zcu1BB8pZmpD6Q8y0b97gjmHbpAYxu0NTnBA/Rb1c8ggM
	pWPmEnMFSaJ1/0xYGI6HACGrA9efLrM=
X-Google-Smtp-Source: AGHT+IGY6JbVaExxgnPmVvZoTYv11HYi4iOF3GSAGcJm/z+q4T+NkPePVrCZ8poiZQla/Xl4P5j9Kg==
X-Received: by 2002:a17:902:ced2:b0:1d0:98d8:955c with SMTP id d18-20020a170902ced200b001d098d8955cmr2917152plg.124.1703617916765;
        Tue, 26 Dec 2023 11:11:56 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:bc9b])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001d0cfd7f6b9sm10463530plj.54.2023.12.26.11.11.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Dec 2023 11:11:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/6] selftests/bpf: Attempt to build BPF programs with -Wsign-compare
Date: Tue, 26 Dec 2023 11:11:43 -0800
Message-Id: <20231226191148.48536-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

GCC's -Wall includes -Wsign-compare while clang does not.
Since BPF programs are built with clang we need to add this flag explicitly
to catch problematic comparisons like:

  int i = -1;
  unsigned int j = 1;
  if (i < j) // this is false.

  long i = -1;
  unsigned int j = 1;
  if (i < j) // this is true.

C standard for reference:

- If either operand is unsigned long the other shall be converted to unsigned long.

- Otherwise, if one operand is a long int and the other unsigned int, then if a
long int can represent all the values of an unsigned int, the unsigned int
shall be converted to a long int; otherwise both operands shall be converted to
unsigned long int.

- Otherwise, if either operand is long, the other shall be converted to long.

- Otherwise, if either operand is unsigned, the other shall be converted to unsigned.

Unfortunately clang's -Wsign-compare is very noisy.
It complains about (s32)a == (u32)b which is safe and doen't have surprising behavior.

This patch fixes some of the issues. It needs a follow up to fix the rest.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                      | 1 +
 .../selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c    | 2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c    | 2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tasks.c        | 2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c   | 2 +-
 .../selftests/bpf/progs/cgroup_getset_retval_setsockopt.c | 2 +-
 tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c     | 2 +-
 tools/testing/selftests/bpf/progs/cpumask_success.c       | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                 | 4 ++--
 tools/testing/selftests/bpf/progs/linked_funcs1.c         | 2 +-
 tools/testing/selftests/bpf/progs/linked_funcs2.c         | 2 +-
 tools/testing/selftests/bpf/progs/linked_list.c           | 2 +-
 tools/testing/selftests/bpf/progs/local_storage.c         | 2 +-
 tools/testing/selftests/bpf/progs/lsm.c                   | 2 +-
 tools/testing/selftests/bpf/progs/normal_map_btf.c        | 2 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h          | 4 ++--
 tools/testing/selftests/bpf/progs/sockopt_inherit.c       | 2 +-
 tools/testing/selftests/bpf/progs/sockopt_multi.c         | 2 +-
 tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_bpf_ma.c           | 2 +-
 .../testing/selftests/bpf/progs/test_core_reloc_kernel.c  | 2 +-
 .../testing/selftests/bpf/progs/test_core_reloc_module.c  | 8 ++++----
 tools/testing/selftests/bpf/progs/test_fsverity.c         | 2 +-
 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c  | 2 +-
 25 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 617ae55c3bb5..fd15017ed3b1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -383,6 +383,7 @@ CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
 	     -I$(abspath $(OUTPUT)/../usr/include)
+# TODO: enable me -Wsign-compare
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 	       -Wno-compare-distinct-pointer-types
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c
index feaaa2b89c57..5014a17d6c02 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c
@@ -20,7 +20,7 @@ struct {
 } hashmap1 SEC(".maps");
 
 /* will set before prog run */
-volatile const __u32 num_cpus = 0;
+volatile const __s32 num_cpus = 0;
 
 /* will collect results during prog run */
 __u32 key_sum_a = 0, key_sum_b = 0, key_sum_c = 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
index dd923dc637d5..423b39e60b6f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
@@ -35,7 +35,7 @@ SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
 		return 0;
 
 	file = vma->vm_file;
-	if (task->tgid != pid) {
+	if (task->tgid != (pid_t)pid) {
 		if (one_task)
 			one_task_error = 1;
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
index 96131b9a1caa..6cbb3393f243 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
@@ -22,7 +22,7 @@ int dump_task(struct bpf_iter__task *ctx)
 		return 0;
 	}
 
-	if (task->pid != tid)
+	if (task->pid != (pid_t)tid)
 		num_unknown_tid++;
 	else
 		num_known_tid++;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c
index 400fdf8d6233..dbf61c44acac 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c
@@ -45,7 +45,7 @@ int dump_bpf_map(struct bpf_iter__bpf_map *ctx)
 	}
 
 	/* fill seq_file buffer */
-	for (i = 0; i < print_len; i++)
+	for (i = 0; i < (int)print_len; i++)
 		bpf_seq_write(seq, &seq_num, sizeof(seq_num));
 
 	return ret;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
index b7fa8804e19d..45a0e9f492a9 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
@@ -11,7 +11,7 @@
 __u32 invocations = 0;
 __u32 assertion_error = 0;
 __u32 retval_value = 0;
-__u32 page_size = 0;
+__s32 page_size = 0;
 
 SEC("cgroup/setsockopt")
 int get_retval(struct bpf_sockopt *ctx)
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
index facedd8b8250..5e282c16eadc 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
@@ -15,7 +15,7 @@ struct {
 	__type(value, long);
 } map_a SEC(".maps");
 
-__u32 target_pid;
+__s32 target_pid;
 __u64 cgroup_id;
 int target_hid;
 bool is_cgroup1;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index fc3666edf456..7a1e64c6c065 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -332,7 +332,7 @@ SEC("tp_btf/task_newtask")
 int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
-	u32 cpu;
+	int cpu;
 
 	if (!is_test_task())
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 3aca3dc145b5..fe971992e635 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -6,7 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
 
 static volatile int zero = 0;
 
@@ -676,7 +676,7 @@ static __noinline int sum(struct bpf_iter_num *it, int *arr, __u32 n)
 
 	while ((t = bpf_iter_num_next(it))) {
 		i = *t;
-		if (i >= n)
+		if ((__u32)i >= n)
 			break;
 		sum += arr[i];
 	}
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs1.c b/tools/testing/selftests/bpf/progs/linked_funcs1.c
index c4b49ceea967..cc79dddac182 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs1.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs1.c
@@ -8,7 +8,7 @@
 #include "bpf_misc.h"
 
 /* weak and shared between two files */
-const volatile int my_tid __weak;
+const volatile __u32 my_tid __weak;
 long syscall_id __weak;
 
 int output_val1;
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs2.c b/tools/testing/selftests/bpf/progs/linked_funcs2.c
index 013ff0645f0c..942cc5526ddf 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs2.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs2.c
@@ -68,7 +68,7 @@ int BPF_PROG(handler2, struct pt_regs *regs, long id)
 {
 	static volatile int whatever;
 
-	if (my_tid != (u32)bpf_get_current_pid_tgid() || id != syscall_id)
+	if (my_tid != (s32)bpf_get_current_pid_tgid() || id != syscall_id)
 		return 0;
 
 	/* make sure we have CO-RE relocations in main program */
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 84d1777a9e6c..26205ca80679 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -6,7 +6,7 @@
 #include "bpf_experimental.h"
 
 #ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
 #endif
 
 #include "linked_list.h"
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index bc8ea56671a1..e5e3a8b8dd07 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -13,7 +13,7 @@ char _license[] SEC("license") = "GPL";
 
 #define DUMMY_STORAGE_VALUE 0xdeadbeef
 
-int monitored_pid = 0;
+__u32 monitored_pid = 0;
 int inode_storage_result = -1;
 int sk_storage_result = -1;
 int task_storage_result = -1;
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index fadfdd98707c..0c13b7409947 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -92,7 +92,7 @@ int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
 	if (ret != 0)
 		return ret;
 
-	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+	__s32 pid = bpf_get_current_pid_tgid() >> 32;
 	int is_stack = 0;
 
 	is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
diff --git a/tools/testing/selftests/bpf/progs/normal_map_btf.c b/tools/testing/selftests/bpf/progs/normal_map_btf.c
index 66cde82aa86d..a45c9299552c 100644
--- a/tools/testing/selftests/bpf/progs/normal_map_btf.c
+++ b/tools/testing/selftests/bpf/progs/normal_map_btf.c
@@ -36,7 +36,7 @@ int add_to_list_in_array(void *ctx)
 	struct node_data *new;
 	int zero = 0;
 
-	if (done || (u32)bpf_get_current_pid_tgid() != pid)
+	if (done || (int)bpf_get_current_pid_tgid() != pid)
 		return 0;
 
 	value = bpf_map_lookup_elem(&array, &zero);
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 897061930cb7..ba99d17dac54 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -132,7 +132,7 @@ struct {
 } disallowed_exec_inodes SEC(".maps");
 
 #ifndef ARRAY_SIZE
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+#define ARRAY_SIZE(arr) (int)(sizeof(arr) / sizeof(arr[0]))
 #endif
 
 static INLINE bool IS_ERR(const void* ptr)
@@ -645,7 +645,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {
 		struct var_kill_data_t* past_kill_data = &arr_struct->array[i];
 
-		if (past_kill_data != NULL && past_kill_data->kill_target_pid == tpid) {
+		if (past_kill_data != NULL && past_kill_data->kill_target_pid == (pid_t)tpid) {
 			bpf_probe_read_kernel(kill_data, sizeof(*past_kill_data),
 					      past_kill_data);
 			void* payload = kill_data->payload;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_inherit.c b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
index c8f59caa4639..a3434b840928 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
@@ -9,7 +9,7 @@ char _license[] SEC("license") = "GPL";
 #define CUSTOM_INHERIT2			1
 #define CUSTOM_LISTENER			2
 
-__u32 page_size = 0;
+__s32 page_size = 0;
 
 struct sockopt_inherit {
 	__u8 val;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_multi.c b/tools/testing/selftests/bpf/progs/sockopt_multi.c
index 96f29fce050b..db67278e12d4 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_multi.c
@@ -5,7 +5,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-__u32 page_size = 0;
+__s32 page_size = 0;
 
 SEC("cgroup/getsockopt")
 int _getsockopt_child(struct bpf_sockopt *ctx)
diff --git a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
index dbe235ede7f3..83753b00a556 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
@@ -9,7 +9,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-__u32 page_size = 0;
+__s32 page_size = 0;
 
 SEC("cgroup/setsockopt")
 int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
index 069db9085e78..b78f4f702ae0 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
@@ -21,7 +21,7 @@ const unsigned int data_sizes[] = {16, 32, 64, 96, 128, 192, 256, 512, 1024, 204
 const volatile unsigned int data_btf_ids[ARRAY_SIZE(data_sizes)] = {};
 
 int err = 0;
-int pid = 0;
+u32 pid = 0;
 
 #define DEFINE_ARRAY_WITH_KPTR(_size) \
 	struct bin_data_##_size { \
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
index a17dd83eae67..ee4a601dcb06 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
@@ -53,7 +53,7 @@ int test_core_kernel(void *ctx)
 	struct task_struct *task = (void *)bpf_get_current_task();
 	struct core_reloc_kernel_output *out = (void *)&data.out;
 	uint64_t pid_tgid = bpf_get_current_pid_tgid();
-	uint32_t real_tgid = (uint32_t)pid_tgid;
+	int32_t real_tgid = (int32_t)pid_tgid;
 	int pid, tgid;
 
 	if (data.my_pid_tgid != pid_tgid)
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_module.c b/tools/testing/selftests/bpf/progs/test_core_reloc_module.c
index f59f175c7baf..bcb31ff92dcc 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_module.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_module.c
@@ -43,8 +43,8 @@ int BPF_PROG(test_core_module_probed,
 #if __has_builtin(__builtin_preserve_enum_value)
 	struct core_reloc_module_output *out = (void *)&data.out;
 	__u64 pid_tgid = bpf_get_current_pid_tgid();
-	__u32 real_tgid = (__u32)(pid_tgid >> 32);
-	__u32 real_pid = (__u32)pid_tgid;
+	__s32 real_tgid = (__s32)(pid_tgid >> 32);
+	__s32 real_pid = (__s32)pid_tgid;
 
 	if (data.my_pid_tgid != pid_tgid)
 		return 0;
@@ -77,8 +77,8 @@ int BPF_PROG(test_core_module_direct,
 #if __has_builtin(__builtin_preserve_enum_value)
 	struct core_reloc_module_output *out = (void *)&data.out;
 	__u64 pid_tgid = bpf_get_current_pid_tgid();
-	__u32 real_tgid = (__u32)(pid_tgid >> 32);
-	__u32 real_pid = (__u32)pid_tgid;
+	__s32 real_tgid = (__s32)(pid_tgid >> 32);
+	__s32 real_pid = (__s32)pid_tgid;
 
 	if (data.my_pid_tgid != pid_tgid)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_fsverity.c b/tools/testing/selftests/bpf/progs/test_fsverity.c
index 3975495b75c8..9e0f73e8189c 100644
--- a/tools/testing/selftests/bpf/progs/test_fsverity.c
+++ b/tools/testing/selftests/bpf/progs/test_fsverity.c
@@ -38,7 +38,7 @@ int BPF_PROG(test_file_open, struct file *f)
 		return 0;
 	got_fsverity = 1;
 
-	for (i = 0; i < sizeof(digest); i++) {
+	for (i = 0; i < (int)sizeof(digest); i++) {
 		if (digest[i] != expected_digest[i])
 			return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
index eacda9fe07eb..4cfa42aa9436 100644
--- a/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
+++ b/tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c
@@ -29,7 +29,7 @@ int BPF_PROG(unix_listen, struct socket *sock, int backlog)
 	len = unix_sk->addr->len - sizeof(short);
 	path[0] = '@';
 	for (i = 1; i < len; i++) {
-		if (i >= sizeof(struct sockaddr_un))
+		if (i >= (int)sizeof(struct sockaddr_un))
 			break;
 
 		path[i] = unix_sk->addr->name->sun_path[i];
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
index 5baaafed0d2d..3abf068b8446 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
@@ -38,7 +38,7 @@ int xdp_redirect(struct xdp_md *xdp)
 	if (payload + 1 > data_end)
 		return XDP_ABORTED;
 
-	if (xdp->ingress_ifindex != ifindex_in)
+	if (xdp->ingress_ifindex != (__u32)ifindex_in)
 		return XDP_ABORTED;
 
 	if (metadata + 1 > data)
-- 
2.34.1


