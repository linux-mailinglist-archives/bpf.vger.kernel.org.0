Return-Path: <bpf+bounces-34296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE992C4F2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68EC1F232D2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5050218561C;
	Tue,  9 Jul 2024 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt028Hqg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118818786F
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557801; cv=none; b=dZ3qmrajhjb/+2Xd2/vKNIBLhkaraNpsuHzoh39F+kQ5ted9fHkqfM+B9HVcYUkBWha8xhKOYoW8VkKRP+rHGmoYcKpEAlKISgFTdfijjFNn6gUhbL+5rHzkmR8lMuFzEqgOha7cJgC67Hfnkt5jXBH2Q/9mfMe+mTBfqrfh5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557801; c=relaxed/simple;
	bh=1A5WSb+MzjCnjVF4/c2tdeCraVnxcv1jVhPhwXpE8lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGC+5GZKyK3Gw7dFNa6U56yOO+n87DGwy9yvHaD5x3wiDhkKnRHg/MI6+pHIq5Th3sOzmvhQN7xVLIpyhms8eWxlP3rbu7KL8Qx3UFYU9UjGtoQSynquSXu2t8Lfw6wCBM4IcTnP2CeJBrOKP07jxyuThr/Tf+UTtjkunGqZAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt028Hqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654B3C3277B;
	Tue,  9 Jul 2024 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557801;
	bh=1A5WSb+MzjCnjVF4/c2tdeCraVnxcv1jVhPhwXpE8lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wt028HqgxLOKt5zz/lK5ao7VAcxkUmwgMpwgEwMPvEEggwl59q8jO5svpZJ8hbkFx
	 BKaGg0vmaFz5Fly9J0B7bod4W4EizaXdLrK344fPeT2T36LrHegYqWAI/zF1OJ9ww9
	 ctWeICRmp9npg26uia5KwNvAiZI/m3zVaVtot/I1GY1Hkj5iCWrhPuJGbBEa8zqIPK
	 wUKPflZAtvwzs99iJ+zTrQUlA6khFJr4Sf22H44C1J+f4oSzkbESLP+2EqNMK1yYvo
	 jZye98EkiT4jw74KvDO01IQhrCVunu+95I3qVKbvqHsEwT0wRUZXDKpsOtHATRLEK4
	 AZ8CDvPhjFMtw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 09/10] bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers
Date: Tue,  9 Jul 2024 13:42:44 -0700
Message-ID: <20240709204245.3847811-10-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709204245.3847811-1-andrii@kernel.org>
References: <20240709204245.3847811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sleepable implementations of bpf_get_stack() and
bpf_get_task_stack() helpers and allow them to be used from sleepable
BPF program (e.g., sleepable uprobes).

Note, the stack trace IPs capturing itself is not sleepable (that would
need to be a separate project), only build ID fetching is sleepable and
thus more reliable, as it will wait for data to be paged in, if
necessary. For that we make use of sleepable build_id_parse()
implementation.

Now that build ID related internals in kernel/bpf/stackmap.c can be used
both in sleepable and non-sleepable contexts, we need to add additional
rcu_read_lock()/rcu_read_unlock() protection around fetching
perf_callchain_entry, but with the refactoring in previous commit it's
now pretty straightforward. We make sure to do rcu_read_unlock (in
sleepable mode only) right before stack_map_get_build_id_offset() call
which can sleep. By that time we don't have any more use of
perf_callchain_entry.

Note, bpf_get_task_stack() will fail for user mode if task != current.
And for kernel mode build ID are irrelevant. So in that sense adding
sleepable bpf_get_task_stack() implementation is a no-op. It feel right
to wire this up for symmetry and completeness, but I'm open to just
dropping it until we support `user && crosstask` condition.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h      |  2 +
 kernel/bpf/stackmap.c    | 90 ++++++++++++++++++++++++++++++++--------
 kernel/trace/bpf_trace.c |  5 ++-
 3 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 960780ef04e1..1c28bc9a34e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3182,7 +3182,9 @@ extern const struct bpf_func_proto bpf_get_current_uid_gid_proto;
 extern const struct bpf_func_proto bpf_get_current_comm_proto;
 extern const struct bpf_func_proto bpf_get_stackid_proto;
 extern const struct bpf_func_proto bpf_get_stack_proto;
+extern const struct bpf_func_proto bpf_get_stack_sleepable_proto;
 extern const struct bpf_func_proto bpf_get_task_stack_proto;
+extern const struct bpf_func_proto bpf_get_task_stack_sleepable_proto;
 extern const struct bpf_func_proto bpf_get_stackid_proto_pe;
 extern const struct bpf_func_proto bpf_get_stack_proto_pe;
 extern const struct bpf_func_proto bpf_sock_map_update_proto;
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 6457222b0b46..3615c06b7dfa 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -124,6 +124,12 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, bool may_fault)
+{
+	return may_fault ? build_id_parse(vma, build_id, NULL)
+			 : build_id_parse_nofault(vma, build_id, NULL);
+}
+
 /*
  * Expects all id_offs[i].ip values to be set to correct initial IPs.
  * They will be subsequently:
@@ -135,7 +141,7 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
  *     BPF_STACK_BUILD_ID_IP.
  */
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u32 trace_nr, bool user)
+					  u32 trace_nr, bool user, bool may_fault)
 {
 	int i;
 	struct mmap_unlock_irq_work *work = NULL;
@@ -166,7 +172,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			goto build_id_valid;
 		}
 		vma = find_vma(current->mm, ip);
-		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
+		if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
@@ -257,7 +263,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
 		for (i = 0; i < trace_nr; i++)
 			id_offs[i].ip = ips[i];
-		stack_map_get_build_id_offset(id_offs, trace_nr, user);
+		stack_map_get_build_id_offset(id_offs, trace_nr, user, false /* !may_fault */);
 		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
 		if (hash_matches && bucket->nr == trace_nr &&
 		    memcmp(bucket->data, new_bucket->data, trace_len) == 0) {
@@ -398,7 +404,7 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
 
 static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
-			    void *buf, u32 size, u64 flags)
+			    void *buf, u32 size, u64 flags, bool may_fault)
 {
 	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
@@ -416,8 +422,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (kernel && user_build_id)
 		goto clear;
 
-	elem_size = (user && user_build_id) ? sizeof(struct bpf_stack_build_id)
-					    : sizeof(u64);
+	elem_size = user_build_id ? sizeof(struct bpf_stack_build_id) : sizeof(u64);
 	if (unlikely(size % elem_size))
 		goto clear;
 
@@ -438,6 +443,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (sysctl_perf_event_max_stack < max_depth)
 		max_depth = sysctl_perf_event_max_stack;
 
+	if (may_fault)
+		rcu_read_lock(); /* need RCU for perf's callchain below */
+
 	if (trace_in)
 		trace = trace_in;
 	else if (kernel && task)
@@ -445,28 +453,35 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else
 		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 					   crosstask, false);
-	if (unlikely(!trace))
-		goto err_fault;
 
-	if (trace->nr < skip)
+	if (unlikely(!trace) || trace->nr < skip) {
+		if (may_fault)
+			rcu_read_unlock();
 		goto err_fault;
+	}
 
 	trace_nr = trace->nr - skip;
 	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-	if (user && user_build_id) {
+	if (user_build_id) {
 		struct bpf_stack_build_id *id_offs = buf;
 		u32 i;
 
 		for (i = 0; i < trace_nr; i++)
 			id_offs[i].ip = ips[i];
-		stack_map_get_build_id_offset(buf, trace_nr, user);
 	} else {
 		memcpy(buf, ips, copy_len);
 	}
 
+	/* trace/ips should not be dereferenced after this point */
+	if (may_fault)
+		rcu_read_unlock();
+
+	if (user_build_id)
+		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
+
 	if (size > copy_len)
 		memset(buf + copy_len, 0, size - copy_len);
 	return copy_len;
@@ -481,7 +496,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size,
 	   u64, flags)
 {
-	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags);
+	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
 }
 
 const struct bpf_func_proto bpf_get_stack_proto = {
@@ -494,8 +509,24 @@ const struct bpf_func_proto bpf_get_stack_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
-	   u32, size, u64, flags)
+BPF_CALL_4(bpf_get_stack_sleepable, struct pt_regs *, regs, void *, buf, u32, size,
+	   u64, flags)
+{
+	return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, true /* may_fault */);
+}
+
+const struct bpf_func_proto bpf_get_stack_sleepable_proto = {
+	.func		= bpf_get_stack_sleepable,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_ANYTHING,
+};
+
+static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
+				 u64 flags, bool may_fault)
 {
 	struct pt_regs *regs;
 	long res = -EINVAL;
@@ -505,12 +536,18 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
 
 	regs = task_pt_regs(task);
 	if (regs)
-		res = __bpf_get_stack(regs, task, NULL, buf, size, flags);
+		res = __bpf_get_stack(regs, task, NULL, buf, size, flags, may_fault);
 	put_task_stack(task);
 
 	return res;
 }
 
+BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
+	   u32, size, u64, flags)
+{
+	return __bpf_get_task_stack(task, buf, size, flags, false /* !may_fault */);
+}
+
 const struct bpf_func_proto bpf_get_task_stack_proto = {
 	.func		= bpf_get_task_stack,
 	.gpl_only	= false,
@@ -522,6 +559,23 @@ const struct bpf_func_proto bpf_get_task_stack_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_get_task_stack_sleepable, struct task_struct *, task, void *, buf,
+	   u32, size, u64, flags)
+{
+	return __bpf_get_task_stack(task, buf, size, flags, true /* !may_fault */);
+}
+
+const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
+	.func		= bpf_get_task_stack_sleepable,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
@@ -533,7 +587,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	__u64 nr_kernel;
 
 	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
-		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags);
+		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -553,7 +607,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 		__u64 nr = trace->nr;
 
 		trace->nr = nr_kernel;
-		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags);
+		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
 
 		/* restore nr */
 		trace->nr = nr;
@@ -565,7 +619,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 			goto clear;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags);
+		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
 	}
 	return err;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..c3845470f56d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1598,7 +1598,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_jiffies64:
 		return &bpf_jiffies64_proto;
 	case BPF_FUNC_get_task_stack:
-		return &bpf_get_task_stack_proto;
+		return prog->sleepable ? &bpf_get_task_stack_sleepable_proto
+				       : &bpf_get_task_stack_proto;
 	case BPF_FUNC_copy_from_user:
 		return &bpf_copy_from_user_proto;
 	case BPF_FUNC_copy_from_user_task:
@@ -1654,7 +1655,7 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stackid:
 		return &bpf_get_stackid_proto;
 	case BPF_FUNC_get_stack:
-		return &bpf_get_stack_proto;
+		return prog->sleepable ? &bpf_get_stack_sleepable_proto : &bpf_get_stack_proto;
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 	case BPF_FUNC_override_return:
 		return &bpf_override_return_proto;
-- 
2.43.0


