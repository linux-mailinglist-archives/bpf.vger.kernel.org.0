Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB5374E0E
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEFDqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhEFDqK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D345C06174A
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m190so3832671pga.2
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=66YyDh7hEAXPcvN6e7SkZC1xmYIt1dtHaCoNVNXYSHI=;
        b=EcC6e6h0PPLE0JZZpiy79VKcRGVgE3Uy65Q2s9phJRV+W7e10gXE9U2bg/0bjXvRv5
         l4Qv7hVnHC6p/iJU6c8jiPwROi/D8WEX1YqDz+QQPCVHLoXeH2SPhfiqyJiIYxHA4eKl
         6EJgm3LWAIHjzApQRVsz2L9Po+Zy6PHmjsbuajSbd7b87AqewW80helF30gPfOdupNau
         FQNtwMaHlDNSZ5ftivUyBUBX8OyFZeRzdqH4scAAH3qKog9+cfPpM9YOFF3uHClCGr6D
         a7hYx8ZQdITCorc3cY9V8WtZw+hifMZHsbqS+l2enPOMNYC5pq9CFo/YCrYDTjq7JpFQ
         8+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=66YyDh7hEAXPcvN6e7SkZC1xmYIt1dtHaCoNVNXYSHI=;
        b=Ap8pyCD+9ARnVnmXxBDfzCFipSNNHLKJ1jF5i0zr/zc3Tzbv5PB1XsTxzTMdIZ+Tbq
         1xU9NoY9rRY6yiQe9ITXvISPR7FMv8za8D5BwbQEtR+q+vOjnL6k8Ny0PBxcNSQVk5UX
         m4AS7IqmfhXJf6cLHMcLjBxM0h8eE7+87IzZEFZnm1I5JJpQELTnxsq9ohD6RgGmNYuA
         TdXwFVQEaSF8EeBYZHjedEeLnoU0fC439VRAPHLoKg69wGhd+fi+HgHvd62YluBLeP5Y
         klD0pvK2Bp0d8xhtganGvj3MAzmAXowq9As6BH9mAyGuyi+/F5w8eeIDNHVeN3fLqyEs
         OFzg==
X-Gm-Message-State: AOAM531dZKtWwwa+RPv6LW5sEPTp5egH++C0eICW9Ll7i8ZFPd0z1tjU
        4kx/iU8NWgPF4y1srWSE48exyQg/jIg=
X-Google-Smtp-Source: ABdhPJzDtQ+7Kw7NQuZiZj0YWXrWkzJTmvlCcmxvPLCUYjCEOL1r9BDgZBkZ4Jo/VsR9nG7su1aLKQ==
X-Received: by 2002:aa7:8c59:0:b029:28e:9093:cd4d with SMTP id e25-20020aa78c590000b029028e9093cd4dmr2260127pfd.25.1620272711769;
        Wed, 05 May 2021 20:45:11 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:11 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 03/17] bpf: Prepare bpf syscall to be used from kernel and user space.
Date:   Wed,  5 May 2021 20:44:51 -0700
Message-Id: <20210506034505.25979-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

With the help from bpfptr_t prepare relevant bpf syscall commands
to be used from kernel and user space.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   |   8 +--
 kernel/bpf/bpf_iter.c |  13 ++---
 kernel/bpf/syscall.c  | 113 +++++++++++++++++++++++++++---------------
 kernel/bpf/verifier.c |  34 +++++++------
 net/bpf/test_run.c    |   2 +-
 5 files changed, 104 insertions(+), 66 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 04a2bf41ae72..7fd53380c981 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -22,6 +22,7 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
+#include <linux/bpfptr.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -1428,7 +1429,7 @@ struct bpf_iter__bpf_map_elem {
 int bpf_iter_reg_target(const struct bpf_iter_reg *reg_info);
 void bpf_iter_unreg_target(const struct bpf_iter_reg *reg_info);
 bool bpf_iter_prog_supported(struct bpf_prog *prog);
-int bpf_iter_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_prog *prog);
 int bpf_iter_new_fd(struct bpf_link *link);
 bool bpf_link_is_iter(struct bpf_link *link);
 struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop);
@@ -1459,7 +1460,7 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 int bpf_fd_htab_map_lookup_elem(struct bpf_map *map, void *key, u32 *value);
 
 int bpf_get_file_flag(int flags);
-int bpf_check_uarg_tail_zero(void __user *uaddr, size_t expected_size,
+int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 			     size_t actual_size);
 
 /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
@@ -1479,8 +1480,7 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 }
 
 /* verify correctness of eBPF program */
-int bpf_check(struct bpf_prog **fp, union bpf_attr *attr,
-	      union bpf_attr __user *uattr);
+int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 931870f9cf56..2d4fbdbb194e 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -473,15 +473,16 @@ bool bpf_link_is_iter(struct bpf_link *link)
 	return link->ops == &bpf_iter_link_lops;
 }
 
-int bpf_iter_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
+			 struct bpf_prog *prog)
 {
-	union bpf_iter_link_info __user *ulinfo;
 	struct bpf_link_primer link_primer;
 	struct bpf_iter_target_info *tinfo;
 	union bpf_iter_link_info linfo;
 	struct bpf_iter_link *link;
 	u32 prog_btf_id, linfo_len;
 	bool existed = false;
+	bpfptr_t ulinfo;
 	int err;
 
 	if (attr->link_create.target_fd || attr->link_create.flags)
@@ -489,18 +490,18 @@ int bpf_iter_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 
 	memset(&linfo, 0, sizeof(union bpf_iter_link_info));
 
-	ulinfo = u64_to_user_ptr(attr->link_create.iter_info);
+	ulinfo = make_bpfptr(attr->link_create.iter_info, uattr.is_kernel);
 	linfo_len = attr->link_create.iter_info_len;
-	if (!ulinfo ^ !linfo_len)
+	if (bpfptr_is_null(ulinfo) ^ !linfo_len)
 		return -EINVAL;
 
-	if (ulinfo) {
+	if (!bpfptr_is_null(ulinfo)) {
 		err = bpf_check_uarg_tail_zero(ulinfo, sizeof(linfo),
 					       linfo_len);
 		if (err)
 			return err;
 		linfo_len = min_t(u32, linfo_len, sizeof(linfo));
-		if (copy_from_user(&linfo, ulinfo, linfo_len))
+		if (copy_from_bpfptr(&linfo, ulinfo, linfo_len))
 			return -EFAULT;
 	}
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b1e7352919cb..28387fe149ba 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -72,11 +72,10 @@ static const struct bpf_map_ops * const bpf_map_types[] = {
  * copy_from_user() call. However, this is not a concern since this function is
  * meant to be a future-proofing of bits.
  */
-int bpf_check_uarg_tail_zero(void __user *uaddr,
+int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 			     size_t expected_size,
 			     size_t actual_size)
 {
-	unsigned char __user *addr = uaddr + expected_size;
 	int res;
 
 	if (unlikely(actual_size > PAGE_SIZE))	/* silly large */
@@ -85,7 +84,12 @@ int bpf_check_uarg_tail_zero(void __user *uaddr,
 	if (actual_size <= expected_size)
 		return 0;
 
-	res = check_zeroed_user(addr, actual_size - expected_size);
+	if (uaddr.is_kernel)
+		res = memchr_inv(uaddr.kernel + expected_size, 0,
+				 actual_size - expected_size) == NULL;
+	else
+		res = check_zeroed_user(uaddr.user + expected_size,
+					actual_size - expected_size);
 	if (res < 0)
 		return res;
 	return res ? 0 : -E2BIG;
@@ -1004,6 +1008,17 @@ static void *__bpf_copy_key(void __user *ukey, u64 key_size)
 	return NULL;
 }
 
+static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
+{
+	if (key_size)
+		return memdup_bpfptr(ukey, key_size);
+
+	if (!bpfptr_is_null(ukey))
+		return ERR_PTR(-EINVAL);
+
+	return NULL;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
 
@@ -1074,10 +1089,10 @@ static int map_lookup_elem(union bpf_attr *attr)
 
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
-static int map_update_elem(union bpf_attr *attr)
+static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
-	void __user *ukey = u64_to_user_ptr(attr->key);
-	void __user *uvalue = u64_to_user_ptr(attr->value);
+	bpfptr_t ukey = make_bpfptr(attr->key, uattr.is_kernel);
+	bpfptr_t uvalue = make_bpfptr(attr->value, uattr.is_kernel);
 	int ufd = attr->map_fd;
 	struct bpf_map *map;
 	void *key, *value;
@@ -1103,7 +1118,7 @@ static int map_update_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1123,7 +1138,7 @@ static int map_update_elem(union bpf_attr *attr)
 		goto free_key;
 
 	err = -EFAULT;
-	if (copy_from_user(value, uvalue, value_size) != 0)
+	if (copy_from_bpfptr(value, uvalue, value_size) != 0)
 		goto free_value;
 
 	err = bpf_map_update_value(map, f, key, value, attr->flags);
@@ -2076,7 +2091,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 /* last field in 'union bpf_attr' used by this command */
 #define	BPF_PROG_LOAD_LAST_FIELD attach_prog_fd
 
-static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -2101,8 +2116,9 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 		return -EPERM;
 
 	/* copy eBPF program license from user space */
-	if (strncpy_from_user(license, u64_to_user_ptr(attr->license),
-			      sizeof(license) - 1) < 0)
+	if (strncpy_from_bpfptr(license,
+				make_bpfptr(attr->license, uattr.is_kernel),
+				sizeof(license) - 1) < 0)
 		return -EFAULT;
 	license[sizeof(license) - 1] = 0;
 
@@ -2186,8 +2202,9 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	prog->len = attr->insn_cnt;
 
 	err = -EFAULT;
-	if (copy_from_user(prog->insns, u64_to_user_ptr(attr->insns),
-			   bpf_prog_insn_size(prog)) != 0)
+	if (copy_from_bpfptr(prog->insns,
+			     make_bpfptr(attr->insns, uattr.is_kernel),
+			     bpf_prog_insn_size(prog)) != 0)
 		goto free_prog_sec;
 
 	prog->orig_prog = NULL;
@@ -3423,7 +3440,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	u32 ulen;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(uinfo, sizeof(info), info_len);
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
 	if (err)
 		return err;
 	info_len = min_t(u32, sizeof(info), info_len);
@@ -3702,7 +3719,7 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	u32 info_len = attr->info.info_len;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(uinfo, sizeof(info), info_len);
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
 	if (err)
 		return err;
 	info_len = min_t(u32, sizeof(info), info_len);
@@ -3745,7 +3762,7 @@ static int bpf_btf_get_info_by_fd(struct file *file,
 	u32 info_len = attr->info.info_len;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(uinfo, sizeof(*uinfo), info_len);
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(*uinfo), info_len);
 	if (err)
 		return err;
 
@@ -3762,7 +3779,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
 	u32 info_len = attr->info.info_len;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(uinfo, sizeof(info), info_len);
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
 	if (err)
 		return err;
 	info_len = min_t(u32, sizeof(info), info_len);
@@ -4023,13 +4040,14 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-static int tracing_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
+				   struct bpf_prog *prog)
 {
 	if (attr->link_create.attach_type != prog->expected_attach_type)
 		return -EINVAL;
 
 	if (prog->expected_attach_type == BPF_TRACE_ITER)
-		return bpf_iter_link_attach(attr, prog);
+		return bpf_iter_link_attach(attr, uattr, prog);
 	else if (prog->type == BPF_PROG_TYPE_EXT)
 		return bpf_tracing_prog_attach(prog,
 					       attr->link_create.target_fd,
@@ -4038,7 +4056,7 @@ static int tracing_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *
 }
 
 #define BPF_LINK_CREATE_LAST_FIELD link_create.iter_info_len
-static int link_create(union bpf_attr *attr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type ptype;
 	struct bpf_prog *prog;
@@ -4057,7 +4075,7 @@ static int link_create(union bpf_attr *attr)
 		goto out;
 
 	if (prog->type == BPF_PROG_TYPE_EXT) {
-		ret = tracing_bpf_link_attach(attr, prog);
+		ret = tracing_bpf_link_attach(attr, uattr, prog);
 		goto out;
 	}
 
@@ -4078,7 +4096,7 @@ static int link_create(union bpf_attr *attr)
 		ret = cgroup_bpf_link_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_TRACING:
-		ret = tracing_bpf_link_attach(attr, prog);
+		ret = tracing_bpf_link_attach(attr, uattr, prog);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
@@ -4366,7 +4384,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
 
-SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
+static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
 	int err;
@@ -4381,7 +4399,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 
 	/* copy attributes from user space, may be less than sizeof(bpf_attr) */
 	memset(&attr, 0, sizeof(attr));
-	if (copy_from_user(&attr, uattr, size) != 0)
+	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
 	err = security_bpf(cmd, &attr, size);
@@ -4396,7 +4414,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 		err = map_lookup_elem(&attr);
 		break;
 	case BPF_MAP_UPDATE_ELEM:
-		err = map_update_elem(&attr);
+		err = map_update_elem(&attr, uattr);
 		break;
 	case BPF_MAP_DELETE_ELEM:
 		err = map_delete_elem(&attr);
@@ -4423,21 +4441,21 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 		err = bpf_prog_detach(&attr);
 		break;
 	case BPF_PROG_QUERY:
-		err = bpf_prog_query(&attr, uattr);
+		err = bpf_prog_query(&attr, uattr.user);
 		break;
 	case BPF_PROG_TEST_RUN:
-		err = bpf_prog_test_run(&attr, uattr);
+		err = bpf_prog_test_run(&attr, uattr.user);
 		break;
 	case BPF_PROG_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr,
+		err = bpf_obj_get_next_id(&attr, uattr.user,
 					  &prog_idr, &prog_idr_lock);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr,
+		err = bpf_obj_get_next_id(&attr, uattr.user,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr,
+		err = bpf_obj_get_next_id(&attr, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
 	case BPF_PROG_GET_FD_BY_ID:
@@ -4447,7 +4465,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 		err = bpf_map_get_fd_by_id(&attr);
 		break;
 	case BPF_OBJ_GET_INFO_BY_FD:
-		err = bpf_obj_get_info_by_fd(&attr, uattr);
+		err = bpf_obj_get_info_by_fd(&attr, uattr.user);
 		break;
 	case BPF_RAW_TRACEPOINT_OPEN:
 		err = bpf_raw_tracepoint_open(&attr);
@@ -4459,26 +4477,26 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 		err = bpf_btf_get_fd_by_id(&attr);
 		break;
 	case BPF_TASK_FD_QUERY:
-		err = bpf_task_fd_query(&attr, uattr);
+		err = bpf_task_fd_query(&attr, uattr.user);
 		break;
 	case BPF_MAP_LOOKUP_AND_DELETE_ELEM:
 		err = map_lookup_and_delete_elem(&attr);
 		break;
 	case BPF_MAP_LOOKUP_BATCH:
-		err = bpf_map_do_batch(&attr, uattr, BPF_MAP_LOOKUP_BATCH);
+		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_LOOKUP_BATCH);
 		break;
 	case BPF_MAP_LOOKUP_AND_DELETE_BATCH:
-		err = bpf_map_do_batch(&attr, uattr,
+		err = bpf_map_do_batch(&attr, uattr.user,
 				       BPF_MAP_LOOKUP_AND_DELETE_BATCH);
 		break;
 	case BPF_MAP_UPDATE_BATCH:
-		err = bpf_map_do_batch(&attr, uattr, BPF_MAP_UPDATE_BATCH);
+		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_UPDATE_BATCH);
 		break;
 	case BPF_MAP_DELETE_BATCH:
-		err = bpf_map_do_batch(&attr, uattr, BPF_MAP_DELETE_BATCH);
+		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr);
+		err = link_create(&attr, uattr);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);
@@ -4487,7 +4505,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 		err = bpf_link_get_fd_by_id(&attr);
 		break;
 	case BPF_LINK_GET_NEXT_ID:
-		err = bpf_obj_get_next_id(&attr, uattr,
+		err = bpf_obj_get_next_id(&attr, uattr.user,
 					  &link_idr, &link_idr_lock);
 		break;
 	case BPF_ENABLE_STATS:
@@ -4510,6 +4528,11 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	return err;
 }
 
+SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
+{
+	return __sys_bpf(cmd, USER_BPFPTR(uattr), size);
+}
+
 static bool syscall_prog_is_valid_access(int off, int size,
 					 enum bpf_access_type type,
 					 const struct bpf_prog *prog,
@@ -4524,7 +4547,19 @@ static bool syscall_prog_is_valid_access(int off, int size,
 
 BPF_CALL_3(bpf_sys_bpf, int, cmd, void *, attr, u32, attr_size)
 {
-	return -EINVAL;
+	switch (cmd) {
+	case BPF_MAP_CREATE:
+	case BPF_MAP_UPDATE_ELEM:
+	case BPF_MAP_FREEZE:
+	case BPF_PROG_LOAD:
+		break;
+	/* case BPF_PROG_TEST_RUN:
+	 * is not part of this list to prevent recursive test_run
+	 */
+	default:
+		return -EINVAL;
+	}
+	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size);
 }
 
 const struct bpf_func_proto bpf_sys_bpf_proto = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8fd552c16763..c1d037f5ea62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9432,7 +9432,7 @@ static int check_abnormal_return(struct bpf_verifier_env *env)
 
 static int check_btf_func(struct bpf_verifier_env *env,
 			  const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  bpfptr_t uattr)
 {
 	const struct btf_type *type, *func_proto, *ret_type;
 	u32 i, nfuncs, urec_size, min_size;
@@ -9441,7 +9441,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	struct bpf_func_info_aux *info_aux = NULL;
 	struct bpf_prog *prog;
 	const struct btf *btf;
-	void __user *urecord;
+	bpfptr_t urecord;
 	u32 prev_offset = 0;
 	bool scalar_return;
 	int ret = -ENOMEM;
@@ -9469,7 +9469,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	prog = env->prog;
 	btf = prog->aux->btf;
 
-	urecord = u64_to_user_ptr(attr->func_info);
+	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
 	min_size = min_t(u32, krec_size, urec_size);
 
 	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL | __GFP_NOWARN);
@@ -9487,13 +9487,15 @@ static int check_btf_func(struct bpf_verifier_env *env,
 				/* set the size kernel expects so loader can zero
 				 * out the rest of the record.
 				 */
-				if (put_user(min_size, &uattr->func_info_rec_size))
+				if (copy_to_bpfptr_offset(uattr,
+							  offsetof(union bpf_attr, func_info_rec_size),
+							  &min_size, sizeof(min_size)))
 					ret = -EFAULT;
 			}
 			goto err_free;
 		}
 
-		if (copy_from_user(&krecord[i], urecord, min_size)) {
+		if (copy_from_bpfptr(&krecord[i], urecord, min_size)) {
 			ret = -EFAULT;
 			goto err_free;
 		}
@@ -9545,7 +9547,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 		}
 
 		prev_offset = krecord[i].insn_off;
-		urecord += urec_size;
+		bpfptr_add(&urecord, urec_size);
 	}
 
 	prog->aux->func_info = krecord;
@@ -9577,14 +9579,14 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 
 static int check_btf_line(struct bpf_verifier_env *env,
 			  const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  bpfptr_t uattr)
 {
 	u32 i, s, nr_linfo, ncopy, expected_size, rec_size, prev_offset = 0;
 	struct bpf_subprog_info *sub;
 	struct bpf_line_info *linfo;
 	struct bpf_prog *prog;
 	const struct btf *btf;
-	void __user *ulinfo;
+	bpfptr_t ulinfo;
 	int err;
 
 	nr_linfo = attr->line_info_cnt;
@@ -9610,7 +9612,7 @@ static int check_btf_line(struct bpf_verifier_env *env,
 
 	s = 0;
 	sub = env->subprog_info;
-	ulinfo = u64_to_user_ptr(attr->line_info);
+	ulinfo = make_bpfptr(attr->line_info, uattr.is_kernel);
 	expected_size = sizeof(struct bpf_line_info);
 	ncopy = min_t(u32, expected_size, rec_size);
 	for (i = 0; i < nr_linfo; i++) {
@@ -9618,14 +9620,15 @@ static int check_btf_line(struct bpf_verifier_env *env,
 		if (err) {
 			if (err == -E2BIG) {
 				verbose(env, "nonzero tailing record in line_info");
-				if (put_user(expected_size,
-					     &uattr->line_info_rec_size))
+				if (copy_to_bpfptr_offset(uattr,
+							  offsetof(union bpf_attr, line_info_rec_size),
+							  &expected_size, sizeof(expected_size)))
 					err = -EFAULT;
 			}
 			goto err_free;
 		}
 
-		if (copy_from_user(&linfo[i], ulinfo, ncopy)) {
+		if (copy_from_bpfptr(&linfo[i], ulinfo, ncopy)) {
 			err = -EFAULT;
 			goto err_free;
 		}
@@ -9677,7 +9680,7 @@ static int check_btf_line(struct bpf_verifier_env *env,
 		}
 
 		prev_offset = linfo[i].insn_off;
-		ulinfo += rec_size;
+		bpfptr_add(&ulinfo, rec_size);
 	}
 
 	if (s != env->subprog_cnt) {
@@ -9699,7 +9702,7 @@ static int check_btf_line(struct bpf_verifier_env *env,
 
 static int check_btf_info(struct bpf_verifier_env *env,
 			  const union bpf_attr *attr,
-			  union bpf_attr __user *uattr)
+			  bpfptr_t uattr)
 {
 	struct btf *btf;
 	int err;
@@ -13278,8 +13281,7 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf_vmlinux;
 }
 
-int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
-	      union bpf_attr __user *uattr)
+int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index a6972d7ddf80..aa47af349ba8 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -409,7 +409,7 @@ static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
 		return ERR_PTR(-ENOMEM);
 
 	if (data_in) {
-		err = bpf_check_uarg_tail_zero(data_in, max_size, size);
+		err = bpf_check_uarg_tail_zero(USER_BPFPTR(data_in), max_size, size);
 		if (err) {
 			kfree(data);
 			return ERR_PTR(err);
-- 
2.30.2

