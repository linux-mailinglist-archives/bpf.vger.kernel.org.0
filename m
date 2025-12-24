Return-Path: <bpf+bounces-77427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B4CDD09C
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0837300EA27
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D93633FE02;
	Wed, 24 Dec 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL58cvfp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3933EAFD
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604338; cv=none; b=E0nf314OfQ/D5+tmBgfgllMS8ynmZkDnAFtle0CZ/xaqfpynX8OD/7PZABbtIq7mWv0+hid6nBOjgHZkjKVRrRMv1quTn/EHNBw+Iw+pgWGL73CVk1QeKjJeYkSLI53sPs1JyTpNMsiauQiACut+THgJLMQnvsaUWCfOfebM4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604338; c=relaxed/simple;
	bh=YnDtZD2Q9JyXrydEMjdLN4AycfI2UjH7H3yFvsQ+P3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFUm8nekk3pbumfCtQKImX4D3um4yPEwgAkgVvaQt3LjxaFoMKj/WwsiVmY/eAcv/DdeCDED8GPSHEk5xtdpuQz6D4MwmLkQSumuFNzUjEWGwBRZEyTbC7+rxs5YeRyzfEJskl1Dj2D5zI/5ay8V+Lbe8q3ziv8g//JquHlNqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL58cvfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79AFC4CEF7;
	Wed, 24 Dec 2025 19:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604337;
	bh=YnDtZD2Q9JyXrydEMjdLN4AycfI2UjH7H3yFvsQ+P3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IL58cvfp0sBPmv2Wg12Jk9JT14ONXSZRDasdV9kSXzW5JBrAH09K7QzkD7BHPQlSl
	 lCzPThct8IRrQaPfK1ui7MOp5BVqbOCO9o8/gn2xagv8EqlzgHR26rPYyWpZQwKZ87
	 fCPBwVLcSFdeWSQctoWg6/x67LGtMM4akU/P0CZKvBZs/kVxCCm906vApQjRGuUBBa
	 A9/aGknKJL9/rlWZ2UWN1Tkd5X6iXYoeMKAFtOvYB96USGs4jTbrvj6d9IWzQi+WjI
	 adnD10TiXKFOuBjnF0wDJTTwo76Deo2KafXbemxHD7Aab12l0bPyB31jNUy1mVlEdJ
	 ROeBnkIgujC3Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/7] bpf: Remove redundant KF_TRUSTED_ARGS flag from all kfuncs
Date: Wed, 24 Dec 2025 11:24:32 -0800
Message-ID: <20251224192448.3176531-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224192448.3176531-1-puranjay@kernel.org>
References: <20251224192448.3176531-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that KF_TRUSTED_ARGS is the default for all kfuncs, remove the
explicit KF_TRUSTED_ARGS flag from all kfunc definitions and remove the
flag itself.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 fs/bpf_fs_kfuncs.c                            | 13 ++++++------
 fs/verity/measure.c                           |  2 +-
 include/linux/btf.h                           |  3 +--
 kernel/bpf/arena.c                            |  6 +++---
 kernel/bpf/cpumask.c                          |  2 +-
 kernel/bpf/helpers.c                          | 20 +++++++++----------
 kernel/bpf/map_iter.c                         |  2 +-
 kernel/sched/ext.c                            |  8 ++++----
 mm/bpf_memcontrol.c                           | 10 +++++-----
 net/core/filter.c                             | 10 +++++-----
 net/core/xdp.c                                |  2 +-
 net/netfilter/nf_conntrack_bpf.c              |  8 ++++----
 net/netfilter/nf_flow_table_bpf.c             |  2 +-
 net/netfilter/nf_nat_bpf.c                    |  2 +-
 net/sched/bpf_qdisc.c                         | 12 +++++------
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 20 +++++++++----------
 16 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 5ace2511fec5..a15d31690e0b 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -359,14 +359,13 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
-BTF_ID_FLAGS(func, bpf_get_task_exe_file,
-	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_path_d_path)
+BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 388734132f01..6a35623ebdf0 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -162,7 +162,7 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *di
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(fsverity_set_ids)
-BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_get_fsverity_digest)
 BTF_KFUNCS_END(fsverity_set_ids)
 
 static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..691f09784933 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -34,7 +34,7 @@
  *
  * And the following kfunc:
  *
- *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+ *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE)
  *
  * All invocations to the kfunc must pass the unmodified, unwalked task:
  *
@@ -66,7 +66,6 @@
  *	return 0;
  * }
  */
-#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc takes either rcu or trusted pointer arguments */
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 456ac989269d..2274319a95e6 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -890,9 +890,9 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
-BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_ARENA_RET | KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 9876c5fe6c2a..b8c805b4b06a 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -477,7 +477,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_cpumask_first, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_first_zero, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_first_and, KF_RCU)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..2c15f77c74db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4427,7 +4427,7 @@ BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
 #ifdef CONFIG_BPF_EVENTS
-BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_send_signal_task)
 #endif
 #ifdef CONFIG_KEYS
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
@@ -4467,14 +4467,14 @@ BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
 #ifdef CONFIG_CGROUPS
-BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 #endif
-BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
@@ -4510,8 +4510,8 @@ BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
 BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
 BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
 #endif
 #ifdef CONFIG_DMA_SHARED_BUFFER
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
@@ -4536,10 +4536,10 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_vprintk_impl)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
+BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_KFUNCS_END(common_btf_ids)
 
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 9575314f40a6..261a03ea73d3 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -214,7 +214,7 @@ __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_map_iter_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_map_sum_elem_count)
 BTF_KFUNCS_END(bpf_map_iter_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94164f2dec6d..fd5423428dde 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7229,9 +7229,9 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_exit_bstr)
+BTF_ID_FLAGS(func, scx_bpf_error_bstr)
+BTF_ID_FLAGS(func, scx_bpf_dump_bstr)
 BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
@@ -7250,7 +7250,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
 BTF_ID_FLAGS(func, scx_bpf_now)
-BTF_ID_FLAGS(func, scx_bpf_events, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_events)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index e8fa7f5855f9..716df49d7647 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -166,11 +166,11 @@ BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
 
-BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_mem_cgroup_usage, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
 
 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 616e0520a0bb..d43df98e1ded 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12438,11 +12438,11 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 }
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
@@ -12455,11 +12455,11 @@ BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
-BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
-BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
@@ -12554,7 +12554,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_sock_destroy)
 BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
 
 static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9100e160113a..fee6d080ee85 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -964,7 +964,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
-#define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
+#define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 BTF_KFUNCS_END(xdp_metadata_kfunc_ids)
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 308e47c2aeaa..c02e1c943847 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -518,10 +518,10 @@ BTF_ID_FLAGS(func, bpf_skb_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_skb_ct_lookup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_ct_insert_entry, KF_ACQUIRE | KF_RET_NULL | KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ct_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_ct_set_timeout)
+BTF_ID_FLAGS(func, bpf_ct_change_timeout)
+BTF_ID_FLAGS(func, bpf_ct_set_status)
+BTF_ID_FLAGS(func, bpf_ct_change_status)
 BTF_KFUNCS_END(nf_ct_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
index 4a5f5195f2d2..cbd5b97a6329 100644
--- a/net/netfilter/nf_flow_table_bpf.c
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -105,7 +105,7 @@ __diag_pop()
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(nf_ft_kfunc_set)
-BTF_ID_FLAGS(func, bpf_xdp_flow_lookup, KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_xdp_flow_lookup, KF_RET_NULL)
 BTF_KFUNCS_END(nf_ft_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_flow_kfunc_set = {
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 481be15609b1..f9dd85ccea01 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -55,7 +55,7 @@ __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(nf_nat_kfunc_set)
-BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_ct_set_nat_info)
 BTF_KFUNCS_END(nf_nat_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_bpf_nat_kfunc_set = {
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..b9771788b9b3 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -271,14 +271,14 @@ __bpf_kfunc void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(qdisc_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_skb_get_hash)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_qdisc_bstats_update, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
+BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
+BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
+BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
+BTF_ID_FLAGS(func, bpf_qdisc_bstats_update)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 90c4b1a51de6..1c41d03bd5a1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -693,9 +693,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_release_test, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test)
+BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test)
 BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test, KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test_nostruct, KF_RET_NULL | KF_RCU_PROTECTED)
@@ -1158,7 +1158,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
@@ -1172,12 +1172,12 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
+BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
+BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
-- 
2.47.3


