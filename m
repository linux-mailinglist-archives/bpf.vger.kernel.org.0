Return-Path: <bpf+bounces-6561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F776B776
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C914F280E4C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA023253D1;
	Tue,  1 Aug 2023 14:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840B253C3
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:29:30 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BDAE5C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:29:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686e0213c0bso3971643b3a.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900168; x=1691504968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JociV+0W2qvJDiMkmz+yQyDz8Am55+TtEw9M0BSr3Js=;
        b=B0P1XO4/4iw5iwQJYg81nd538G/jNedBmJGjWZfXqMuJfwi1xU0rsQm6gapryb4wwN
         GukuH6KYeEfXaPnS4wq9iLsKUlG0DqNMxICNengEVDSrPGix5rl80tTZbRUiXNq0l0gn
         MQCJL1uCRgjjJD4ZWmMi1JkUoQmcmJR8SmeLaNUpzaquLCPmQ/kc13ppvFb0R1XlS7GR
         oaTSTRL8q2accsDi+V+qRIGbGI0HT7u8eldocr8RM8lFsAklFwXr/dqkReA6MZv+s80O
         wpX/+xzZbmurxDrSJTK/YCx3YiY3LNkm6EDD85s1U3Wqo388jI5MOHC8XbEzk8rmidrq
         RD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900168; x=1691504968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JociV+0W2qvJDiMkmz+yQyDz8Am55+TtEw9M0BSr3Js=;
        b=XJCAzq9z9kZA/QVx46Rt7qul88/Tl5U8d/xvaoJEYfm0qTunqSywvZQefX7asGWlWH
         TPR1a4t+kI13wXXYC8Dm48MXowh+rluhvCB+2PQejBDUTfbFyerrV5jbqOC7wlsjyIPN
         WSjzYj+FJ+R7vP/a+jTG8BR++YRkfHNPDv1vr/xTV6qDe/j8kXuQRk0bPEvSa6uosfuA
         yjWEKpu7tEXJOGNK8M2B2lMDUZqb+HF1EWYqK8uJ1V/kw5WivkgjyLy06tgMYMrXl5uP
         ePuBS1u8GkM2lleA8JKppxXgaqEcjHDZbSJy75ruMDnvLQ00ysmgw67jwT9pDbZYoV6N
         M7Gg==
X-Gm-Message-State: ABy/qLZRt6tGoE4X1c6sUfxbxOFGZ0DxXAadJ/qnd6Bp2iGjIngB7KqJ
	/YsqdoAOMrnV58lF81jpGy0=
X-Google-Smtp-Source: APBJJlGUzzFcnABBba1NrLYYNpKjiiIbBiTB+jcyC4uN0V+JXdsU+OEIJuNfMmqjiMTlsDAanAmVHA==
X-Received: by 2002:a05:6a20:1450:b0:132:cd2d:16fd with SMTP id a16-20020a056a20145000b00132cd2d16fdmr12929374pzi.38.1690900168160;
        Tue, 01 Aug 2023 07:29:28 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1409:5400:4ff:fe86:cf7a])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00686a80f431dsm9391491pfo.126.2023.08.01.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:29:27 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/3] bpf: Add bpf_for_each_cpu helper
Date: Tue,  1 Aug 2023 14:29:10 +0000
Message-Id: <20230801142912.55078-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230801142912.55078-1-laoar.shao@gmail.com>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some statistical data is stored in percpu pointers, but the kernel does not
consolidate them into a single value, such as the data stored within struct
psi_group_cpu.

To facilitate obtaining the sum of this data, a new bpf helper called
bpf_for_each_cpu is introduced.

This new helper implements for_each_{possible, present, online}_cpu,
allowing the user to traverse CPUs conveniently. For instance, it enables
walking through the CPUs of a cpuset cgroup when the task is within that cgroup.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 32 +++++++++++++++++++
 kernel/bpf/bpf_iter.c          | 72 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c           |  2 ++
 kernel/bpf/verifier.c          | 29 ++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 32 +++++++++++++++++++
 6 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ceaa8c2..3e63607 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2951,6 +2951,7 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_for_each_cpu_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7fc98f4..e8a0ac7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1663,6 +1663,14 @@ struct bpf_stack_build_id {
 
 } __attribute__((aligned(8)));
 
+enum bpf_cpu_mask_type {
+	CPU_MASK_UNSPEC = 0,
+	CPU_MASK_POSSIBLE = 1,
+	CPU_MASK_ONLINE = 2,
+	CPU_MASK_PRESENT = 3,
+	CPU_MASK_TASK = 4, /* cpu mask of a task */
+};
+
 /* The description below is an attempt at providing documentation to eBPF
  * developers about the multiple available eBPF helper functions. It can be
  * parsed and used to produce a manual page. The workflow is the following,
@@ -5609,6 +5617,29 @@ struct bpf_stack_build_id {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_for_each_cpu(void *callback_fn, void *callback_ctx, const void *pcpu_ptr, u32 type, u32 target)
+ *	Description
+ *		Walk the percpu pointer **pcpu_ptr** with the callback **callback_fn** function.
+ *		The **callback_fn** should be a static function and the **callback_ctx** should
+ *		be a pointer to the stack.
+ *		The **callback_ctx** is the context parameter.
+ *		The **type** and **tartet** specify which CPUs to walk. If **target** is specified,
+ *		it will get the cpumask from the associated target.
+ *
+ *		long (\*callback_fn)(u32 cpu, void \*ctx, const void \*ptr);
+ *
+ *		where **cpu** is the current cpu in the walk, the **ctx** is the **callback_ctx**,
+ *		and the **ptr** is the address of **pcpu_ptr** on current cpu.
+ *
+ *		If **callback_fn** returns 0, the helper will continue to the next
+ *		loop. If return value is 1, the helper will skip the rest of
+ *		the loops and return. Other return values are not used now,
+ *		and will be rejected by the verifier.
+ *
+ *	Return
+ *		The number of CPUs walked, **-EINVAL** for invalid **type**, **target** or
+ *		**pcpu_ptr**.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5823,6 +5854,7 @@ struct bpf_stack_build_id {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(for_each_cpu, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 96856f1..e588a14 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -6,6 +6,8 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/btf.h>
+#include <linux/cpumask.h>
 
 struct bpf_iter_target_info {
 	struct list_head list;
@@ -777,6 +779,76 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_for_each_cpu, void *, callback_fn, void *, callback_ctx,
+	   const void *, pcpu_ptr, u32, type, u32, target)
+{
+	bpf_callback_t callback = (bpf_callback_t)callback_fn;
+	struct task_struct *task = NULL;
+	const cpumask_t *mask;
+	const void *ptr;
+	u64 ret;
+	u32 cpu;
+
+	if (!pcpu_ptr)
+		return -EINVAL;
+
+	if ((type != CPU_MASK_TASK && target) || (type == CPU_MASK_TASK && !target))
+		return -EINVAL;
+
+	switch (type) {
+	case CPU_MASK_POSSIBLE:
+		mask = cpu_possible_mask;
+		break;
+	case CPU_MASK_ONLINE:
+		mask = cpu_online_mask;
+		break;
+	case CPU_MASK_PRESENT:
+		mask = cpu_present_mask;
+		break;
+	case CPU_MASK_TASK:
+		rcu_read_lock();
+		task = get_pid_task(find_vpid(target), PIDTYPE_PID);
+		rcu_read_unlock();
+		if (!task)
+			return -EINVAL;
+		mask = task->cpus_ptr;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for_each_cpu(cpu, mask) {
+		ptr = per_cpu_ptr((const void __percpu *)pcpu_ptr, cpu);
+		if (!ptr) {
+			if (task)
+				put_task_struct(task);
+			return cpu + 1;
+		}
+
+		ret = callback((u64)cpu, (u64)(long)callback_ctx, (u64)(long)ptr, 0, 0);
+		if (ret) {
+			if (task)
+				put_task_struct(task);
+			return cpu + 1;
+		}
+	}
+
+	if (task)
+		put_task_struct(task);
+	return cpu;
+}
+
+const struct bpf_func_proto bpf_for_each_cpu_proto = {
+	.func		= bpf_for_each_cpu,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_FUNC,
+	.arg2_type	= ARG_PTR_TO_STACK_OR_NULL,
+	.arg3_type	= ARG_PTR_TO_PERCPU_BTF_ID,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 struct bpf_iter_num_kern {
 	int cur; /* current value, inclusive */
 	int end; /* final value, exclusive */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56ce500..06f624e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1768,6 +1768,8 @@ static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offse
 	case BPF_FUNC_get_current_ancestor_cgroup_id:
 		return &bpf_get_current_ancestor_cgroup_id_proto;
 #endif
+	case BPF_FUNC_for_each_cpu:
+		return &bpf_for_each_cpu_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71473c1..cd6d0a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -549,7 +549,8 @@ static bool is_callback_calling_function(enum bpf_func_id func_id)
 	       func_id == BPF_FUNC_timer_set_callback ||
 	       func_id == BPF_FUNC_find_vma ||
 	       func_id == BPF_FUNC_loop ||
-	       func_id == BPF_FUNC_user_ringbuf_drain;
+	       func_id == BPF_FUNC_user_ringbuf_drain ||
+	       func_id == BPF_FUNC_for_each_cpu;
 }
 
 static bool is_async_callback_calling_function(enum bpf_func_id func_id)
@@ -9028,6 +9029,28 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_for_each_cpu_callback_state(struct bpf_verifier_env *env,
+					   struct bpf_func_state *caller,
+					   struct bpf_func_state *callee,
+					   int insn_idx)
+{
+	/* long bpf_for_each_cpu(bpf_callback_t callback_fn, void *callback_ctx,
+	 *                       const void *pc, u32 type, u64 flags)
+	 * callback_fn(u64 cpu, void *callback_ctx, const void *pc);
+	 */
+	callee->regs[BPF_REG_1].type = SCALAR_VALUE;
+	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_2];
+	callee->regs[BPF_REG_3] = caller->regs[BPF_REG_3];
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+
+	callee->in_callback_fn = true;
+	callee->callback_ret_range = tnum_range(0, 1);
+	return 0;
+}
+
 static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 					 struct bpf_func_state *caller,
 					 struct bpf_func_state *callee,
@@ -9625,6 +9648,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_user_ringbuf_callback_state);
 		break;
+	case BPF_FUNC_for_each_cpu:
+		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_for_each_cpu_callback_state);
+		break;
 	}
 
 	if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7fc98f4..e8a0ac7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1663,6 +1663,14 @@ struct bpf_stack_build_id {
 
 } __attribute__((aligned(8)));
 
+enum bpf_cpu_mask_type {
+	CPU_MASK_UNSPEC = 0,
+	CPU_MASK_POSSIBLE = 1,
+	CPU_MASK_ONLINE = 2,
+	CPU_MASK_PRESENT = 3,
+	CPU_MASK_TASK = 4, /* cpu mask of a task */
+};
+
 /* The description below is an attempt at providing documentation to eBPF
  * developers about the multiple available eBPF helper functions. It can be
  * parsed and used to produce a manual page. The workflow is the following,
@@ -5609,6 +5617,29 @@ struct bpf_stack_build_id {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_for_each_cpu(void *callback_fn, void *callback_ctx, const void *pcpu_ptr, u32 type, u32 target)
+ *	Description
+ *		Walk the percpu pointer **pcpu_ptr** with the callback **callback_fn** function.
+ *		The **callback_fn** should be a static function and the **callback_ctx** should
+ *		be a pointer to the stack.
+ *		The **callback_ctx** is the context parameter.
+ *		The **type** and **tartet** specify which CPUs to walk. If **target** is specified,
+ *		it will get the cpumask from the associated target.
+ *
+ *		long (\*callback_fn)(u32 cpu, void \*ctx, const void \*ptr);
+ *
+ *		where **cpu** is the current cpu in the walk, the **ctx** is the **callback_ctx**,
+ *		and the **ptr** is the address of **pcpu_ptr** on current cpu.
+ *
+ *		If **callback_fn** returns 0, the helper will continue to the next
+ *		loop. If return value is 1, the helper will skip the rest of
+ *		the loops and return. Other return values are not used now,
+ *		and will be rejected by the verifier.
+ *
+ *	Return
+ *		The number of CPUs walked, **-EINVAL** for invalid **type**, **target** or
+ *		**pcpu_ptr**.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5823,6 +5854,7 @@ struct bpf_stack_build_id {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(for_each_cpu, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
1.8.3.1


