Return-Path: <bpf+bounces-35814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049993E286
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830151C21160
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467C27E583;
	Sun, 28 Jul 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/PuKch3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5B7E575;
	Sun, 28 Jul 2024 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128042; cv=none; b=iJttGoIjxQjs2v46XIqoCV1tzjJdk5ULx5eRv4Ud2UXKgyaWEpSfa5JZhX5JPTKsM33WPnjiqcTcLjbv8+o/K493KKl93AYLmwYQXtTkr8RRZXlhTq/e+QwY+9wUvVxWqvsB+M7I0TFyHGXW5q4bWQI8o+BvRLNdAqAMMZvox04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128042; c=relaxed/simple;
	bh=2OzOgLy/UZvh2gLvhNxSvkOxmYkHawd7jnvjoYNRcHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES592Lr45+taRIcj/9YjTwT30z94nXLGWJeTM7NVByZICC0NIBpxgqGTinLGQjO4Yz/LvhGaZfGBgv0WYa6p+xpgHn7O/TDypHK55mL1vKR94R+vdxAzYrgTAD2m5x1zMPnOifAjOWfINg0ZhdUOGZe6y3DlnCEkR2nJtP3Wra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/PuKch3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990B8C32781;
	Sun, 28 Jul 2024 00:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128042;
	bh=2OzOgLy/UZvh2gLvhNxSvkOxmYkHawd7jnvjoYNRcHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/PuKch3oRaBMSeZ2vVS245POBtS/Gw1SAqdcvBsU5hHwyZCjX78ZLYA4eThkTPpo
	 KJ9Hk7RPwqXFYnPxzQXaRxZdnCI5FPQ5ca5laa+WnI09bx7czZ0rn2jrv5tJO9s/Fa
	 6h8nqYB05NzOmyoWTW0kX2uHV6OnLEvNXtCy8htnLIOONFVZI2z07rHOWNf2XgLEFr
	 hIj2wFOLVx0Dy9d7KTSeLZ5jy/3xOmj0/bU9FDKt+BymkpMt1OpeS62bHE1gJd7P8w
	 WtP9uFlAKKtHgWkjb39zdULkqQxjVGLvwj8qk3nno4NpRFTl3lgbBNDTMphEa3ylO+
	 U4lx3X9AqwlLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	kees@kernel.org,
	tandersen@netflix.com,
	mjguzik@gmail.com,
	willy@infradead.org,
	kent.overstreet@linux.dev,
	zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com,
	hca@linux.ibm.com,
	jiri@resnulli.us,
	lorenzo@kernel.org,
	yan@cloudflare.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 10/27] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
Date: Sat, 27 Jul 2024 20:52:53 -0400
Message-ID: <20240728005329.1723272-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e ]

The XDP redirect process is two staged:
- bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
  packet and makes decisions. While doing that, the per-CPU variable
  bpf_redirect_info is used.

- Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
  and it may also access other per-CPU variables like xskmap_flush_list.

At the very end of the NAPI callback, xdp_do_flush() is invoked which
does not access bpf_redirect_info but will touch the individual per-CPU
lists.

The per-CPU variables are only used in the NAPI callback hence disabling
bottom halves is the only protection mechanism. Users from preemptible
context (like cpu_map_kthread_run()) explicitly disable bottom halves
for protections reasons.
Without locking in local_bh_disable() on PREEMPT_RT this data structure
requires explicit locking.

PREEMPT_RT has forced-threaded interrupts enabled and every
NAPI-callback runs in a thread. If each thread has its own data
structure then locking can be avoided.

Create a struct bpf_net_context which contains struct bpf_redirect_info.
Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
it, bpf_net_ctx_clear() removes it again.
The bpf_net_ctx_set() may nest. For instance a function can be used from
within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
NET_TX_SOFTIRQ which does not. Therefore only the first invocations
updates the pointer.
Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
bpf_redirect_info. The returned data structure is zero initialized to
ensure nothing is leaked from stack. This is done on first usage of the
struct. bpf_net_ctx_set() sets bpf_redirect_info::kern_flags to 0 to
note that initialisation is required. First invocation of
bpf_net_ctx_get_ri() will memset() the data structure and update
bpf_redirect_info::kern_flags.
bpf_redirect_info::nh is excluded from memset because it is only used
once BPF_F_NEIGH is set which also sets the nh member. The kern_flags is
moved past nh to exclude it from memset.

The pointer to bpf_net_context is saved task's task_struct. Using
always the bpf_net_context approach has the advantage that there is
almost zero differences between PREEMPT_RT and non-PREEMPT_RT builds.

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20240620132727.660738-15-bigeasy@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h | 56 ++++++++++++++++++++++++++++++++++--------
 include/linux/sched.h  |  3 +++
 kernel/bpf/cpumap.c    |  3 +++
 kernel/bpf/devmap.c    |  9 ++++++-
 kernel/fork.c          |  1 +
 net/bpf/test_run.c     | 11 ++++++++-
 net/core/dev.c         | 29 +++++++++++++++++++++-
 net/core/filter.c      | 44 +++++++++------------------------
 net/core/lwt_bpf.c     |  3 +++
 9 files changed, 114 insertions(+), 45 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5669da513cd7c..b2dc932fdc35e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -733,21 +733,59 @@ struct bpf_nh_params {
 	};
 };
 
+/* flags for bpf_redirect_info kern_flags */
+#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
+#define BPF_RI_F_RI_INIT	BIT(1)
+
 struct bpf_redirect_info {
 	u64 tgt_index;
 	void *tgt_value;
 	struct bpf_map *map;
 	u32 flags;
-	u32 kern_flags;
 	u32 map_id;
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
+	u32 kern_flags;
 };
 
-DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
+struct bpf_net_context {
+	struct bpf_redirect_info ri;
+};
 
-/* flags for bpf_redirect_info kern_flags */
-#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
+static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
+{
+	struct task_struct *tsk = current;
+
+	if (tsk->bpf_net_context != NULL)
+		return NULL;
+	bpf_net_ctx->ri.kern_flags = 0;
+
+	tsk->bpf_net_context = bpf_net_ctx;
+	return bpf_net_ctx;
+}
+
+static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
+{
+	if (bpf_net_ctx)
+		current->bpf_net_context = NULL;
+}
+
+static inline struct bpf_net_context *bpf_net_ctx_get(void)
+{
+	return current->bpf_net_context;
+}
+
+static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
+		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_RI_INIT;
+	}
+
+	return &bpf_net_ctx->ri;
+}
 
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
@@ -1018,25 +1056,23 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
 
-void bpf_clear_redirect_map(struct bpf_map *map);
-
 static inline bool xdp_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
 }
 
 static inline void xdp_set_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	ri->kern_flags |= BPF_RI_F_RF_NO_DIRECT;
 }
 
 static inline void xdp_clear_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	ri->kern_flags &= ~BPF_RI_F_RF_NO_DIRECT;
 }
@@ -1592,7 +1628,7 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
 						   u64 flags, const u64 flag_mask,
 						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	const u64 action_mask = XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
 
 	/* Lower bits of the flags are used as return code on lookup failure */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a5f4b48fca184..6d7170259a538 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -53,6 +53,7 @@ struct bio_list;
 struct blk_plug;
 struct bpf_local_storage;
 struct bpf_run_ctx;
+struct bpf_net_context;
 struct capture_control;
 struct cfs_rq;
 struct fs_struct;
@@ -1506,6 +1507,8 @@ struct task_struct {
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
 #endif
+	/* Used by BPF for per-TASK xdp storage */
+	struct bpf_net_context		*bpf_net_context;
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	unsigned long			lowest_stack;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a8e34416e960f..66974bd027109 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -240,12 +240,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 				int xdp_n, struct xdp_cpumap_stats *stats,
 				struct list_head *list)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int nframes;
 
 	if (!rcpu->prog)
 		return xdp_n;
 
 	rcu_read_lock_bh();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	nframes = cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
 
@@ -255,6 +257,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (unlikely(!list_empty(list)))
 		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
 
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
 
 	return nframes;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 7f3b34452243c..fbfdfb60db8d7 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -196,7 +196,14 @@ static void dev_map_free(struct bpf_map *map)
 	list_del_rcu(&dtab->list);
 	spin_unlock(&dev_map_lock);
 
-	bpf_clear_redirect_map(map);
+	/* bpf_redirect_info->map is assigned in __bpf_xdp_redirect_map()
+	 * during NAPI callback and cleared after the XDP redirect. There is no
+	 * explicit RCU read section which protects bpf_redirect_info->map but
+	 * local_bh_disable() also marks the beginning an RCU section. This
+	 * makes the complete softirq callback RCU protected. Thus after
+	 * following synchronize_rcu() there no bpf_redirect_info->map == map
+	 * assignment.
+	 */
 	synchronize_rcu();
 
 	/* Make sure prior __dev_map_entry_free() have completed. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d83..f314bdd7e6108 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2355,6 +2355,7 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx = NULL;
 #endif
+	p->bpf_net_context =  NULL;
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 36ae54f57bf57..a6d7f790cdda8 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -283,9 +283,10 @@ static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
 static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 			      u32 repeat)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int err = 0, act, ret, i, nframes = 0, batch_sz;
 	struct xdp_frame **frames = xdp->frames;
+	struct bpf_redirect_info *ri;
 	struct xdp_page_head *head;
 	struct xdp_frame *frm;
 	bool redirect = false;
@@ -295,6 +296,8 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	batch_sz = min_t(u32, repeat, xdp->batch_size);
 
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
 	xdp_set_return_frame_no_direct();
 
 	for (i = 0; i < batch_sz; i++) {
@@ -359,6 +362,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	}
 
 	xdp_clear_return_frame_no_direct();
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 	return err;
 }
@@ -394,6 +398,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time, bool xdp)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
@@ -419,10 +424,14 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	do {
 		run_ctx.prog_item = &item;
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 		if (xdp)
 			*retval = bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval = bpf_prog_run(prog, ctx);
+
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, time));
 	bpf_reset_run_ctx(old_ctx);
diff --git a/net/core/dev.c b/net/core/dev.c
index 2b4819b610b8a..195aa4d488bec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4029,10 +4029,13 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
+
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	if (*pt_prev) {
 		*ret = deliver_skb(skb, *pt_prev, orig_dev);
 		*pt_prev = NULL;
@@ -4061,10 +4064,12 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 			break;
 		}
 		*ret = NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_RX_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4074,8 +4079,10 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -4085,11 +4092,14 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -4105,10 +4115,12 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret = NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_XMIT_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4118,8 +4130,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -6301,6 +6315,7 @@ enum {
 static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	bool skip_schedule = false;
 	unsigned long timeout;
 	int rc;
@@ -6318,6 +6333,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	clear_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state);
 
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
@@ -6340,6 +6356,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	netpoll_poll_unlock(have_poll_lock);
 	if (rc == budget)
 		__busy_poll_stop(napi, skip_schedule);
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 }
 
@@ -6349,6 +6366,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 {
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	void *have_poll_lock = NULL;
 	struct napi_struct *napi;
 
@@ -6367,6 +6385,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		int work = 0;
 
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		if (!napi_poll) {
 			unsigned long val = READ_ONCE(napi->state);
 
@@ -6397,6 +6416,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
 		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
 		if (!loop_end || loop_end(loop_end_arg, start_time))
@@ -6824,6 +6844,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 
 static void napi_threaded_poll_loop(struct napi_struct *napi)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
 	unsigned long last_qs = jiffies;
 
@@ -6832,6 +6853,8 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		void *have;
 
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 		sd = this_cpu_ptr(&softnet_data);
 		sd->in_napi_threaded_poll = true;
 
@@ -6847,6 +6870,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 			net_rps_action_and_irq_enable(sd);
 		}
 		skb_defer_free_flush(sd);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
 		if (!repoll)
@@ -6872,10 +6896,12 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies +
 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int budget = READ_ONCE(net_hotdata.netdev_budget);
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 start:
 	sd->in_net_rx_action = true;
 	local_irq_disable();
@@ -6928,7 +6954,8 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 		sd->in_net_rx_action = false;
 
 	net_rps_action_and_irq_enable(sd);
-end:;
+end:
+	bpf_net_ctx_clear(bpf_net_ctx);
 }
 
 struct netdev_adjacent {
diff --git a/net/core/filter.c b/net/core/filter.c
index 9933851c685e7..c0f350b963272 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2476,9 +2476,6 @@ static const struct bpf_func_proto bpf_clone_redirect_proto = {
 	.arg3_type      = ARG_ANYTHING,
 };
 
-DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
-EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
-
 static struct net_device *skb_get_peer_dev(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -2491,7 +2488,7 @@ static struct net_device *skb_get_peer_dev(struct net_device *dev)
 
 int skb_do_redirect(struct sk_buff *skb)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct net *net = dev_net(skb->dev);
 	struct net_device *dev;
 	u32 flags = ri->flags;
@@ -2524,7 +2521,7 @@ int skb_do_redirect(struct sk_buff *skb)
 
 BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return TC_ACT_SHOT;
@@ -2545,7 +2542,7 @@ static const struct bpf_func_proto bpf_redirect_proto = {
 
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags))
 		return TC_ACT_SHOT;
@@ -2567,7 +2564,7 @@ static const struct bpf_func_proto bpf_redirect_peer_proto = {
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, params,
 	   int, plen, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely((plen && plen < sizeof(*params)) || flags))
 		return TC_ACT_SHOT;
@@ -4293,30 +4290,13 @@ void xdp_do_check_flushed(struct napi_struct *napi)
 }
 #endif
 
-void bpf_clear_redirect_map(struct bpf_map *map)
-{
-	struct bpf_redirect_info *ri;
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		ri = per_cpu_ptr(&bpf_redirect_info, cpu);
-		/* Avoid polluting remote cacheline due to writes if
-		 * not needed. Once we pass this test, we need the
-		 * cmpxchg() to make sure it hasn't been changed in
-		 * the meantime by remote CPU.
-		 */
-		if (unlikely(READ_ONCE(ri->map) == map))
-			cmpxchg(&ri->map, map, NULL);
-	}
-}
-
 DEFINE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
 EXPORT_SYMBOL_GPL(bpf_master_redirect_enabled_key);
 
 u32 xdp_master_redirect(struct xdp_buff *xdp)
 {
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct net_device *master, *slave;
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 
 	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
 	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
@@ -4388,7 +4368,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 			map = READ_ONCE(ri->map);
 
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err = -ENOENT;
@@ -4433,7 +4413,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
@@ -4447,7 +4427,7 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect);
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
@@ -4464,7 +4444,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       enum bpf_map_type map_type, u32 map_id,
 				       u32 flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct bpf_map *map;
 	int err;
 
@@ -4476,7 +4456,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 			map = READ_ONCE(ri->map);
 
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err = -ENOENT;
@@ -4518,7 +4498,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
@@ -4554,7 +4534,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags))
 		return XDP_ABORTED;
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 4a0797f0a154b..5350dce2e52d6 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -38,6 +38,7 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int ret;
 
 	/* Migration disable and BH disable are needed to protect per-cpu
@@ -45,6 +46,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 	 */
 	migrate_disable();
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
 
@@ -77,6 +79,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		break;
 	}
 
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 	migrate_enable();
 
-- 
2.43.0


