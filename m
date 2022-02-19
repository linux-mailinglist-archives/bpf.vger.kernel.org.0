Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B24BC837
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiBSLiT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 06:38:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiBSLiR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 06:38:17 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08148E44
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:57 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id ik27so394419plb.0
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vE0Pk8iuVgzEW9ySyWCAdArlIr+6NZualphBZ7vyEFM=;
        b=S+/rNJv2N3+9lwyAhLuYEz8aOCyoP1toHo8EmPgKKyPaigOCWio7frofNGIdsH5WJL
         5c/MKpDGVl+5brn73ABy2fZGo8KYhFXTXi/FnK5qMz9uNZARGv0WCkHoB9MvddytLV/c
         k2fNBE8a7k09sBtk6oEH/c6U5tX5V1B4zQOSUJGnelDTxB5hvIklgDCiY+po1/jku/AZ
         6arXDecv5Q147j8k6N/BUnD5Nq8IAYrgVS1RK/So6pZncjZ8L8OMuZLvdMUtONio7loJ
         vXPjV23FxePCR0N8CDmd1X8ByvmZkzPMnAh9HnpdJG9rLDjDj3lmpwB8LTGuQXkEP4tc
         PYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vE0Pk8iuVgzEW9ySyWCAdArlIr+6NZualphBZ7vyEFM=;
        b=0IKD97x91NG5W7B3NHn8cvY/SY8lEXJpSOtYH/mdNktZreIFe7nRp5t4c6iCDdz4Z/
         DYlK28nP1SXxSpUIUE02FMHwalJI9FZbBmLN2QPp0na40L+0GXi7C+vAt7ieGvwXZoKB
         mnF3I8oG8vhSHqclswO9YgxdYBJ1bQIFdvoYZK5WVtgbQjZKTfUdN/kk/V4IWeEnuAWe
         79J9XyMdFezF8PLpq4cTcg7KQ/hvd1oLUQ3gAcpuNxcymx2QCQkXKIYuo8/g8B71bzbg
         QHYHqYZbMnrU0OHJ6LX8H5ig5T8Gxna82vgnq86tf8dHPTUgNd0sxX+JhY62d0RuWu4k
         3NSg==
X-Gm-Message-State: AOAM533RrWzWK8B6Oyp++hG09GDE0DAG2aToGJ3syMPk79138GMaxl3o
        Cf+ohMdzU0UgldL/1cCEy1sF/A837nQ=
X-Google-Smtp-Source: ABdhPJxknGPiYk/icD5Da1nv0h+Ts/PD+dQiRvcaApiu2lUx3FsUQKlexYSgK/OnaYzhNuJq57WUCg==
X-Received: by 2002:a17:90a:bd87:b0:1bb:f758:5d47 with SMTP id z7-20020a17090abd8700b001bbf7585d47mr2388256pjr.88.1645270676943;
        Sat, 19 Feb 2022 03:37:56 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id 75sm13319564pga.12.2022.02.19.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:37:56 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 3/5] bpf: Use bpf_ptr_is_invalid for all helpers taking PTR_TO_BTF_ID
Date:   Sat, 19 Feb 2022 17:07:42 +0530
Message-Id: <20220219113744.1852259-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220219113744.1852259-1-memxor@gmail.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19415; h=from:subject; bh=ceM0+LkqrFQv9arPvIduUj8ze1cLwlcN0I1ah3s2l1M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiENZ6FEH9nbdnGGFW/Eb+e4xtFdxu2GCBU8sUM9hv xD5o1kSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYhDWegAKCRBM4MiGSL8RyoKlD/ 9qZd6xak8ofKrsCg9WKX74h2+7Hh/ZzGba+KQJwojm18H+eK4wMLTnkQoc2DIqjDVAvhqSoPEfKv5T McSXHQCIGMgF6IDT5hUN2BjnBHrKDqNVaDxE79imwxlnU2sqhZEWxzJMgzZwsVT0YqjCJCGW9V0c4x 28kk/4VU/NPH0tHPcaypTqcHTLQvvBZO0p4kgX3BXjbNU5BbvpbBvI8CEv15htYVgaailb906pZ4A0 vlr2afWSrglVU3aE7AEBBROOvfkhaoeroPXbVnqxQmZoSEpha0JfLtOQ5Icut/Ew834GxZlm0M3x6f KGRI8tuFDi7I2W2OWyv7j66ouUUVgoqcO93McC78KJYdei1EvzfoyUc5aAI3IRJbhlURL7iuJu5PML ogjwpe6A47LeFAwocpiZYqbYi4MFjmEyHIklfoIXXHNBSwtpsExuMVpIhHXTzcu8KqOI+z/iCUN9ax +V1xfwccjrPIc2uMr1qSnMPW+x/clPLzZ1G/2UYEpqWZjZoyHDEOS2KphDkyWlLMFn+Po80B8TWlJi oC3u3WtY05GI1Z6SPDMPoTqTHjzQqXqiyTVkdSP6t4F6Ap3v58/WOBQBBtpsdbtZyIZzyzILkij+tX pXeQ6f6ERRHUSEIx1SMolDk/1x1b7WoSQQSw/Xj9Ici+nRcqr4S2HjS6Ztbg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch all helpers accepting ARG_PTR_TO_BTF_ID to use bpf_ptr_is_invalid
to check NULL or invalid pointers formed in the program.

Some helpers missed checking for NULL when taking PTR_TO_BTF_ID, those
are also marked as fixed along with others that need updating due to the
new convention.

Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
Fixes: eb411377aed9 ("bpf: Add bpf_seq_printf_btf helper")
Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
Fixes: dd6e10fbd9fb ("bpf: Add bpf_task_pt_regs() helper")
Fixes: f307fa2cb4c9 ("bpf: Introduce bpf_sk_{, ancestor_}cgroup_id helpers")
Fixes: 4de16969523c ("bpf: enable event output helper also for xdp types")
Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing programs")
Fixes: 3cee6fb8e69e ("bpf: tcp: Support bpf_(get|set)sockopt in bpf tcp iter")
Fixes: a5fa25adf03d ("bpf: Change bpf_sk_release and bpf_sk_*cgroup_id to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Fixes: c0df236e1394 ("bpf: Change bpf_tcp_*_syncookie to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Fixes: af7ec1383361 ("bpf: Add bpf_skc_to_tcp6_sock() helper")
Fixes: 478cfbdf5f13 ("bpf: Add bpf_skc_to_{tcp, tcp_timewait, tcp_request}_sock() helpers")
Fixes: 0d4fad3e57df ("bpf: Add bpf_skc_to_udp6_sock() helper")
Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
Fixes: 4f19cab76136 ("bpf: Add a bpf_sock_from_file helper")
Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
Fixes: 3f6719c7b62f ("bpf: Add bpf_bprm_opts_set helper")
Fixes: 27672f0d280a ("bpf: Add a BPF helper for getting the IMA hash of an inode")
Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            | 18 ++++++------
 kernel/bpf/bpf_inode_storage.c |  4 +--
 kernel/bpf/bpf_lsm.c           |  4 ++-
 kernel/bpf/bpf_task_storage.c  |  4 +--
 kernel/bpf/stackmap.c          |  3 ++
 kernel/bpf/task_iter.c         |  2 +-
 kernel/trace/bpf_trace.c       | 12 ++++++++
 net/core/bpf_sk_storage.c      |  9 +++---
 net/core/filter.c              | 52 +++++++++++++++++++++-------------
 net/ipv4/bpf_tcp_ca.c          |  4 +--
 10 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 17d4bbf69cb6..83deca7afc88 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -495,12 +495,12 @@ enum bpf_reg_type {
 	 * Further, when passed into helpers the helpers can not, without
 	 * additional context, assume the value is non-null.
 	 *
-	 * All BPF helpers must use IS_PTR_TO_BTF_ID_ERR_OR_NULL when accepting
-	 * a PTR_TO_BTF_ID or PTR_TO_BTF_ID_OR_NULL from a BPF program.
-	 * Likewise, unstable kfuncs must do the same. This is because while
-	 * PTR_TO_BTF_ID may be NULL at runtime, a pointer to the embedded
-	 * object can be formed by adding the offset to the member, and then
-	 * passing verifier checks because verifier thinks that:
+	 * All BPF helpers must use 'bpf_ptr_is_invalid' when accepting a
+	 * PTR_TO_BTF_ID or PTR_TO_BTF_ID_OR_NULL from a BPF program. Likewise,
+	 * unstable kfuncs must do the same. This is because while PTR_TO_BTF_ID
+	 * may be NULL at runtime, a pointer to the embedded object can be
+	 * formed by adding the offset to the member, and then passing verifier
+	 * checks because verifier thinks that:
 	 *
 	 * (struct file *)ptr + offsetof(struct file, f_path) == (struct path *)
 	 *
@@ -509,8 +509,8 @@ enum bpf_reg_type {
 	 * pointer case for PTR_TO_BTF_ID reg state, it will allow passing
 	 * NULL + offset, which won't be rejected because it is not NULL.
 	 *
-	 * Hence, the IS_PTR_TO_BTF_ID_ERR_OR_NULL macro is needed to provide
-	 * safety for both NULL and this 'non-NULL but invalid pointer case'.
+	 * Hence, the 'bpf_ptr_is_invalid' macro is needed to provide safety for
+	 * both NULL and this 'non-NULL but invalid pointer case'.
 	 */
 	PTR_TO_BTF_ID,
 	/* PTR_TO_BTF_ID_OR_NULL points to a kernel struct that has not
@@ -537,7 +537,7 @@ enum bpf_reg_type {
 };
 static_assert(__BPF_REG_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 
-#define IS_PTR_TO_BTF_ID_ERR_OR_NULL(p) ((unsigned long)(p) < PAGE_SIZE)
+#define bpf_ptr_is_invalid(p) (unlikely((unsigned long)(p) < PAGE_SIZE))
 
 /* The information passed from prog-specific *_is_valid_access
  * back to the verifier.
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e29d9e3d853e..b36b1609789e 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -183,7 +183,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	 * bpf_local_storage_update expects the owner to have a
 	 * valid storage pointer.
 	 */
-	if (!inode || !inode_storage_ptr(inode))
+	if (bpf_ptr_is_invalid(inode) || !inode_storage_ptr(inode))
 		return (unsigned long)NULL;
 
 	sdata = inode_storage_lookup(inode, map, true);
@@ -208,7 +208,7 @@ BPF_CALL_2(bpf_inode_storage_delete,
 	   struct bpf_map *, map, struct inode *, inode)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (!inode)
+	if (bpf_ptr_is_invalid(inode))
 		return -EINVAL;
 
 	/* This helper must only called from where the inode is guaranteed
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 9e4ecc990647..c60e06a5b79d 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -58,7 +58,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 
 BPF_CALL_2(bpf_bprm_opts_set, struct linux_binprm *, bprm, u64, flags)
 {
-	if (flags & ~BPF_F_BRPM_OPTS_MASK)
+	if (bpf_ptr_is_invalid(bprm) || flags & ~BPF_F_BRPM_OPTS_MASK)
 		return -EINVAL;
 
 	bprm->secureexec = (flags & BPF_F_BPRM_SECUREEXEC);
@@ -78,6 +78,8 @@ static const struct bpf_func_proto bpf_bprm_opts_set_proto = {
 
 BPF_CALL_3(bpf_ima_inode_hash, struct inode *, inode, void *, dst, u32, size)
 {
+	if (bpf_ptr_is_invalid(inode))
+		return -EINVAL;
 	return ima_inode_hash(inode, dst, size);
 }
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 5da7bed0f5f6..85bca62fc1e1 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -235,7 +235,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
 		return (unsigned long)NULL;
 
-	if (!task)
+	if (bpf_ptr_is_invalid(task))
 		return (unsigned long)NULL;
 
 	if (!bpf_task_storage_trylock())
@@ -264,7 +264,7 @@ BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 	int ret;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (!task)
+	if (bpf_ptr_is_invalid(task))
 		return -EINVAL;
 
 	if (!bpf_task_storage_trylock())
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 22c8ae94e4c1..6eb4be83f04d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -474,6 +474,9 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
 	struct pt_regs *regs;
 	long res = -EINVAL;
 
+	if (bpf_ptr_is_invalid(task))
+		return -EINVAL;
+
 	if (!try_get_task_stack(task))
 		return -EFAULT;
 
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index d94696198ef8..ec27de5e75f4 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -595,7 +595,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	if (flags)
 		return -EINVAL;
 
-	if (!task)
+	if (bpf_ptr_is_invalid(task))
 		return -ENOENT;
 
 	mm = task->mm;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 21aa30644219..6ea6ded8f9fc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -468,6 +468,9 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 	int err, num_args;
 	u32 *bin_args;
 
+	if (bpf_ptr_is_invalid(m))
+		return -EINVAL;
+
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
 	    (data_len && !data))
 		return -EINVAL;
@@ -500,6 +503,8 @@ static const struct bpf_func_proto bpf_seq_printf_proto = {
 
 BPF_CALL_3(bpf_seq_write, struct seq_file *, m, const void *, data, u32, len)
 {
+	if (bpf_ptr_is_invalid(m))
+		return -EINVAL;
 	return seq_write(m, data, len) ? -EOVERFLOW : 0;
 }
 
@@ -520,6 +525,9 @@ BPF_CALL_4(bpf_seq_printf_btf, struct seq_file *, m, struct btf_ptr *, ptr,
 	s32 btf_id;
 	int ret;
 
+	if (bpf_ptr_is_invalid(m))
+		return -EINVAL;
+
 	ret = bpf_btf_printf_prepare(ptr, btf_ptr_size, flags, &btf, &btf_id);
 	if (ret)
 		return ret;
@@ -769,6 +777,8 @@ const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 
 BPF_CALL_1(bpf_task_pt_regs, struct task_struct *, task)
 {
+	if (bpf_ptr_is_invalid(task))
+		return -EINVAL;
 	return (unsigned long) task_pt_regs(task);
 }
 
@@ -894,6 +904,8 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 	long len;
 	char *p;
 
+	if (bpf_ptr_is_invalid(path))
+		return -EINVAL;
 	if (!sz)
 		return 0;
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d9c37fd10809..836f43b160a8 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -261,7 +261,8 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	struct bpf_local_storage_data *sdata;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
+	if (bpf_ptr_is_invalid(sk) ||
+	    !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
 		return (unsigned long)NULL;
 
 	sdata = bpf_sk_storage_lookup(sk, map, true);
@@ -292,7 +293,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (!sk || !sk_fullsock(sk))
+	if (bpf_ptr_is_invalid(sk) || !sk_fullsock(sk))
 		return -EINVAL;
 
 	if (refcount_inc_not_zero(&sk->sk_refcnt)) {
@@ -421,7 +422,7 @@ BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
 	   void *, value, u64, flags)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (in_hardirq() || in_nmi())
+	if (bpf_ptr_is_invalid(sk) || in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
 
 	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
@@ -431,7 +432,7 @@ BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
 	   struct sock *, sk)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (in_hardirq() || in_nmi())
+	if (bpf_ptr_is_invalid(sk) || in_hardirq() || in_nmi())
 		return -EPERM;
 
 	return ____bpf_sk_storage_delete(map, sk);
diff --git a/net/core/filter.c b/net/core/filter.c
index 9eb785842258..a578df364273 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4516,7 +4516,7 @@ static inline u64 __bpf_sk_cgroup_id(struct sock *sk)
 	struct cgroup *cgrp;
 
 	sk = sk_to_full_sk(sk);
-	if (!sk || !sk_fullsock(sk))
+	if (bpf_ptr_is_invalid(sk) || !sk_fullsock(sk))
 		return 0;
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
@@ -4542,7 +4542,7 @@ static inline u64 __bpf_sk_ancestor_cgroup_id(struct sock *sk,
 	struct cgroup *cgrp;
 
 	sk = sk_to_full_sk(sk);
-	if (!sk || !sk_fullsock(sk))
+	if (bpf_ptr_is_invalid(sk) || !sk_fullsock(sk))
 		return 0;
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
@@ -4569,6 +4569,7 @@ static const struct bpf_func_proto bpf_skb_ancestor_cgroup_id_proto = {
 
 BPF_CALL_1(bpf_sk_cgroup_id, struct sock *, sk)
 {
+	/* __bpf_sk_cgroup_id does bpf_ptr_is_invalid check */
 	return __bpf_sk_cgroup_id(sk);
 }
 
@@ -4581,6 +4582,7 @@ static const struct bpf_func_proto bpf_sk_cgroup_id_proto = {
 
 BPF_CALL_2(bpf_sk_ancestor_cgroup_id, struct sock *, sk, int, ancestor_level)
 {
+	/* __bpf_sk_ancestor_cgroup_id does bpf_ptr_is_invalid check */
 	return __bpf_sk_ancestor_cgroup_id(sk, ancestor_level);
 }
 
@@ -4607,7 +4609,7 @@ BPF_CALL_5(bpf_xdp_event_output, struct xdp_buff *, xdp, struct bpf_map *, map,
 
 	if (unlikely(flags & ~(BPF_F_CTXLEN_MASK | BPF_F_INDEX_MASK)))
 		return -EINVAL;
-	if (unlikely(!xdp ||
+	if (unlikely(bpf_ptr_is_invalid(xdp) ||
 		     xdp_size > (unsigned long)(xdp->data_end - xdp->data)))
 		return -EFAULT;
 
@@ -4678,7 +4680,7 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
 
 BPF_CALL_1(bpf_get_socket_ptr_cookie, struct sock *, sk)
 {
-	return sk ? sock_gen_cookie(sk) : 0;
+	return !bpf_ptr_is_invalid(sk) ? sock_gen_cookie(sk) : 0;
 }
 
 const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
@@ -5015,7 +5017,7 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 static int _bpf_getsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
-	if (!sk_fullsock(sk))
+	if (bpf_ptr_is_invalid(sk) || !sk_fullsock(sk))
 		goto err_clear;
 
 	sock_owned_by_me(sk);
@@ -5114,6 +5116,9 @@ static int _bpf_getsockopt(struct sock *sk, int level, int optname,
 BPF_CALL_5(bpf_sk_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (bpf_ptr_is_invalid(sk))
+		return -EINVAL;
+
 	if (level == SOL_TCP && optname == TCP_CONGESTION) {
 		if (optlen >= sizeof("cdg") - 1 &&
 		    !strncmp("cdg", optval, optlen))
@@ -5137,6 +5142,7 @@ const struct bpf_func_proto bpf_sk_setsockopt_proto = {
 BPF_CALL_5(bpf_sk_getsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	/* _bpf_getsockopt does bpf_ptr_is_invalid check */
 	return _bpf_getsockopt(sk, level, optname, optval, optlen);
 }
 
@@ -6373,7 +6379,7 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
-	if (sk && sk_is_refcounted(sk))
+	if (!bpf_ptr_is_invalid(sk) && sk_is_refcounted(sk))
 		sock_gen_put(sk);
 	return 0;
 }
@@ -6764,7 +6770,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 	u32 cookie;
 	int ret;
 
-	if (unlikely(!sk || th_len < sizeof(*th)))
+	if (unlikely(bpf_ptr_is_invalid(sk) || th_len < sizeof(*th)))
 		return -EINVAL;
 
 	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
@@ -6831,7 +6837,8 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 	u32 cookie;
 	u16 mss;
 
-	if (unlikely(!sk || th_len < sizeof(*th) || th_len != th->doff * 4))
+	if (unlikely(bpf_ptr_is_invalid(sk) || th_len < sizeof(*th) ||
+		     th_len != th->doff * 4))
 		return -EINVAL;
 
 	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
@@ -6895,7 +6902,7 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 
 BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 {
-	if (!sk || flags != 0)
+	if (bpf_ptr_is_invalid(sk) || flags != 0)
 		return -EINVAL;
 	if (!skb_at_tc_ingress(skb))
 		return -EOPNOTSUPP;
@@ -10737,8 +10744,8 @@ BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
 	 * trigger an explicit type generation here.
 	 */
 	BTF_TYPE_EMIT(struct tcp6_sock);
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
-	    sk->sk_family == AF_INET6)
+	if (!bpf_ptr_is_invalid(sk) && sk_fullsock(sk) &&
+	    sk->sk_protocol == IPPROTO_TCP && sk->sk_family == AF_INET6)
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
@@ -10754,7 +10761,7 @@ const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
 
 BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
+	if (!bpf_ptr_is_invalid(sk) && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
@@ -10776,13 +10783,15 @@ BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
 	BTF_TYPE_EMIT(struct inet_timewait_sock);
 	BTF_TYPE_EMIT(struct tcp_timewait_sock);
 
+	if (bpf_ptr_is_invalid(sk))
+		return (unsigned long)NULL;
 #ifdef CONFIG_INET
-	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_TIME_WAIT)
+	if (sk->sk_prot == &tcp_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
 #endif
 
 #if IS_BUILTIN(CONFIG_IPV6)
-	if (sk && sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_TIME_WAIT)
+	if (sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
 #endif
 
@@ -10799,13 +10808,15 @@ const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto = {
 
 BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 {
+	if (bpf_ptr_is_invalid(sk))
+		return (unsigned long)NULL;
 #ifdef CONFIG_INET
-	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_NEW_SYN_RECV)
+	if (sk->sk_prot == &tcp_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
 #endif
 
 #if IS_BUILTIN(CONFIG_IPV6)
-	if (sk && sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_NEW_SYN_RECV)
+	if (sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
 #endif
 
@@ -10826,8 +10837,9 @@ BPF_CALL_1(bpf_skc_to_udp6_sock, struct sock *, sk)
 	 * trigger an explicit type generation here.
 	 */
 	BTF_TYPE_EMIT(struct udp6_sock);
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_UDP &&
-	    sk->sk_type == SOCK_DGRAM && sk->sk_family == AF_INET6)
+	if (!bpf_ptr_is_invalid(sk) && sk_fullsock(sk) &&
+	    sk->sk_protocol == IPPROTO_UDP && sk->sk_type == SOCK_DGRAM &&
+	    sk->sk_family == AF_INET6)
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
@@ -10847,7 +10859,7 @@ BPF_CALL_1(bpf_skc_to_unix_sock, struct sock *, sk)
 	 * trigger an explicit type generation here.
 	 */
 	BTF_TYPE_EMIT(struct unix_sock);
-	if (sk && sk_fullsock(sk) && sk->sk_family == AF_UNIX)
+	if (!bpf_ptr_is_invalid(sk) && sk_fullsock(sk) && sk->sk_family == AF_UNIX)
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
@@ -10863,6 +10875,8 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_proto = {
 
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
+	if (bpf_ptr_is_invalid(file))
+		return (unsigned long)NULL;
 	return (unsigned long)sock_from_file(file);
 }
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index de610cb83694..e5f2f0fe46be 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -144,7 +144,8 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 
 BPF_CALL_2(bpf_tcp_send_ack, struct tcp_sock *, tp, u32, rcv_nxt)
 {
-	/* bpf_tcp_ca prog cannot have NULL tp */
+	if (bpf_ptr_is_invalid(tp))
+		return -EINVAL;
 	__tcp_send_ack((struct sock *)tp, rcv_nxt);
 	return 0;
 }
@@ -152,7 +153,6 @@ BPF_CALL_2(bpf_tcp_send_ack, struct tcp_sock *, tp, u32, rcv_nxt)
 static const struct bpf_func_proto bpf_tcp_send_ack_proto = {
 	.func		= bpf_tcp_send_ack,
 	.gpl_only	= false,
-	/* In case we want to report error later */
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &tcp_sock_id,
-- 
2.35.1

