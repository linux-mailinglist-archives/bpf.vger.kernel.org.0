Return-Path: <bpf+bounces-28537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D88BB341
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97B5288A69
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2256215B132;
	Fri,  3 May 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onJPdjEj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="st7aW3ad"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345515357D;
	Fri,  3 May 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761016; cv=none; b=Y0Nts+wdCTEkIRxxy4Rkn82CyFw0607/QBbkxOReALjDcNphPoiHqKweQyjcsbCbNc3r/klxECGIkWQsdHaf2OgXeTrm0TUBm38kC20RGicXBAOlNwY2O27U9aZiiK1dQKXHi0btHqRlZkAEeERqbpVde8PtAmT367JCofM8wmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761016; c=relaxed/simple;
	bh=jKPBdTZBWfXKshm2xN+edmAIDX4Stlo1qSApKaQRygs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uzhl4cSbsiDRHIg7h8QBU5sq6mfhRLaE/xRyYHINjx2zjNFfbq0ZRhhEqZhG8Xbkczxy5+63xqHBvPRRhA3wn+sAY8Mf+suF5JPwJPl+xnb9DqPrf43wSe3P+vXA/djbzaF5vFrzd4aDLAhArQbHSjjtyEKHBGZrAvZea/9iqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onJPdjEj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=st7aW3ad; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+z76MrGFwu7LZiEGuHxi2dOAcDWW4QXJPxN3zJkFME=;
	b=onJPdjEj8jL9KimRcOxbquuqcoC8IDUTUVVSg3pas9glgEQ63DVInmbdSVJtCdAfAloK42
	BoV0vM5pDD7J74hDyAmKqMKnSvhcnHb90sICGa54jwxWHUQA1I1hQav7ISUu41eb7kzqQs
	vTCuWCXPu/FkGopYxm50a5d/EAakHk3PE8tG5eoC7rPoKOF5fK+zwrf/xZF+G5ZLVqaMyC
	CQfMpayieLJX5Z0kIPRzIXkeOTSvvShTLuOlB7AqsUSS5ZSF9bGL81CCwAwOTL71HMuVzU
	e+VNwTyzUuckcw0JYiJ499LepdN6wM683ChSv9AhEndRJrZM037udNAfaLGmXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+z76MrGFwu7LZiEGuHxi2dOAcDWW4QXJPxN3zJkFME=;
	b=st7aW3adoCnUVLRXDCTB32glVy1tRQv03nxp/lZlBsionKm79y9/AUeiyo7lLCgrdh6mAt
	3BIDabzJm/iCIoCA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH net-next 14/15] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
Date: Fri,  3 May 2024 20:25:18 +0200
Message-ID: <20240503182957.1042122-15-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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
it. Use the __free() annotation to automatically reset the pointer once
function returns.
The bpf_net_ctx_set() may nest. For instance a function can be used from
within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
NET_TX_SOFTIRQ which does not. Therefore only the first invocations
updates the pointer.
Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
bpf_redirect_info.

On PREEMPT_RT the pointer to bpf_net_context is saved task's
task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
variable (which is always NODE-local memory). Using always the
bpf_net_context approach has the advantage that there is almost zero
differences between PREEMPT_RT and non-PREEMPT_RT builds.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 96 ++++++++++++++++++++++++++++++++++++++---
 include/linux/sched.h  |  5 +++
 kernel/bpf/cpumap.c    |  3 ++
 kernel/fork.c          |  3 ++
 net/bpf/test_run.c     | 11 ++++-
 net/core/dev.c         | 19 +++++++-
 net/core/filter.c      | 98 ++++++++++++++++++++++++++----------------
 net/core/lwt_bpf.c     |  3 ++
 8 files changed, 191 insertions(+), 47 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index d5fea03cb6e61..bdd69bd81df45 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -744,7 +744,83 @@ struct bpf_redirect_info {
 	struct bpf_nh_params nh;
 };
=20
-DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
+struct bpf_net_context {
+	struct bpf_redirect_info ri;
+};
+
+#ifndef CONFIG_PREEMPT_RT
+DECLARE_PER_CPU(struct bpf_net_context *, bpf_net_context);
+
+static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_conte=
xt *bpf_net_ctx)
+{
+	struct bpf_net_context *ctx;
+
+	ctx =3D this_cpu_read(bpf_net_context);
+	if (ctx !=3D NULL)
+		return NULL;
+	this_cpu_write(bpf_net_context, bpf_net_ctx);
+	return bpf_net_ctx;
+}
+
+static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
+{
+	struct bpf_net_context *ctx;
+
+	ctx =3D this_cpu_read(bpf_net_context);
+	if (ctx !=3D bpf_net_ctx)
+		return;
+	this_cpu_write(bpf_net_context, NULL);
+}
+
+static inline struct bpf_net_context *bpf_net_ctx_get(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D this_cpu_read(bpf_net_context);
+
+	WARN_ON_ONCE(!bpf_net_ctx);
+	return bpf_net_ctx;
+}
+
+#else
+
+static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_conte=
xt *bpf_net_ctx)
+{
+	struct task_struct *tsk =3D current;
+
+	if (tsk->bpf_net_context !=3D NULL)
+		return NULL;
+	tsk->bpf_net_context =3D bpf_net_ctx;
+	return bpf_net_ctx;
+}
+
+static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
+{
+	struct task_struct *tsk =3D current;
+
+	if (tsk->bpf_net_context !=3D bpf_net_ctx)
+		return;
+	tsk->bpf_net_context =3D NULL;
+}
+
+static inline struct bpf_net_context *bpf_net_ctx_get(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D current->bpf_net_context;
+
+	WARN_ON_ONCE(!bpf_net_ctx);
+	return bpf_net_ctx;
+}
+
+#endif
+
+static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!bpf_net_ctx)
+		return NULL;
+	return &bpf_net_ctx->ri;
+}
+
+DEFINE_FREE(bpf_net_ctx_clear, struct bpf_net_context *, if (_T) bpf_net_c=
tx_clear(_T));
=20
 /* flags for bpf_redirect_info kern_flags */
 #define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
@@ -1021,23 +1097,27 @@ void bpf_clear_redirect_map(struct bpf_map *map);
=20
 static inline bool xdp_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
+	if (!ri)
+		return false;
 	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline void xdp_set_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	ri->kern_flags |=3D BPF_RI_F_RF_NO_DIRECT;
+	if (ri)
+		ri->kern_flags |=3D BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline void xdp_clear_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	ri->kern_flags &=3D ~BPF_RI_F_RF_NO_DIRECT;
+	if (ri)
+		ri->kern_flags &=3D ~BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
@@ -1591,9 +1671,11 @@ static __always_inline long __bpf_xdp_redirect_map(s=
truct bpf_map *map, u64 inde
 						   u64 flags, const u64 flag_mask,
 						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	const u64 action_mask =3D XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
=20
+	if (!ri)
+		return XDP_ABORTED;
 	/* Lower bits of the flags are used as return code on lookup failure */
 	if (unlikely(flags & ~(action_mask | flag_mask)))
 		return XDP_ABORTED;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6779d3b8f2578..26324fb0e532d 100644
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
@@ -1504,6 +1505,10 @@ struct task_struct {
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	/* Used by BPF for per-TASK xdp storage */
+	struct bpf_net_context		*bpf_net_context;
+#endif
=20
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	unsigned long			lowest_stack;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a8e34416e960f..66974bd027109 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -240,12 +240,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_en=
try *rcpu, void **frames,
 				int xdp_n, struct xdp_cpumap_stats *stats,
 				struct list_head *list)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int nframes;
=20
 	if (!rcpu->prog)
 		return xdp_n;
=20
 	rcu_read_lock_bh();
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
=20
 	nframes =3D cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
=20
@@ -255,6 +257,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entr=
y *rcpu, void **frames,
 	if (unlikely(!list_empty(list)))
 		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
=20
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
=20
 	return nframes;
diff --git a/kernel/fork.c b/kernel/fork.c
index aebb3e6c96dc6..82c16c22d960c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2355,6 +2355,9 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx =3D NULL;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	p->bpf_net_context =3D  NULL;
+#endif
=20
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval =3D sched_fork(clone_flags, p);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f6aad4ed2ab2f..600cc8e428c1a 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -283,9 +283,10 @@ static int xdp_recv_frames(struct xdp_frame **frames, =
int nframes,
 static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *=
prog,
 			      u32 repeat)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int err =3D 0, act, ret, i, nframes =3D 0, batch_sz;
 	struct xdp_frame **frames =3D xdp->frames;
+	struct bpf_redirect_info *ri;
 	struct xdp_page_head *head;
 	struct xdp_frame *frm;
 	bool redirect =3D false;
@@ -295,6 +296,8 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp=
, struct bpf_prog *prog,
 	batch_sz =3D min_t(u32, repeat, xdp->batch_size);
=20
 	local_bh_disable();
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
+	ri =3D bpf_net_ctx_get_ri();
 	xdp_set_return_frame_no_direct();
=20
 	for (i =3D 0; i < batch_sz; i++) {
@@ -359,6 +362,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp=
, struct bpf_prog *prog,
 	}
=20
 	xdp_clear_return_frame_no_direct();
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 	return err;
 }
@@ -394,6 +398,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog,=
 struct xdp_buff *ctx,
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time, bool xdp)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog_array_item item =3D {.prog =3D prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
@@ -419,10 +424,14 @@ static int bpf_test_run(struct bpf_prog *prog, void *=
ctx, u32 repeat,
 	do {
 		run_ctx.prog_item =3D &item;
 		local_bh_disable();
+		bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
+
 		if (xdp)
 			*retval =3D bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval =3D bpf_prog_run(prog, ctx);
+
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, time));
 	bpf_reset_run_ctx(old_ctx);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1503883ce15a4..26e524544942d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4031,11 +4031,15 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(skb->dev->tcx_ingres=
s);
+	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) =3D NULL;
 	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_INGRESS;
+	struct bpf_net_context __bpf_net_ctx;
 	int sch_ret;
=20
 	if (!entry)
 		return skb;
+
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 	if (*pt_prev) {
 		*ret =3D deliver_skb(skb, *pt_prev, orig_dev);
 		*pt_prev =3D NULL;
@@ -4086,13 +4090,17 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
 static __always_inline struct sk_buff *
 sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
+	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) =3D NULL;
 	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_EGRESS;
+	struct bpf_net_context __bpf_net_ctx;
 	int sch_ret;
=20
 	if (!entry)
 		return skb;
=20
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
+
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -6357,13 +6365,15 @@ static void __napi_busy_loop(unsigned int napi_id,
 		      bool (*loop_end)(void *, unsigned long),
 		      void *loop_end_arg, unsigned flags, u16 budget)
 {
+	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) =3D NULL;
 	unsigned long start_time =3D loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
+	struct bpf_net_context __bpf_net_ctx;
 	void *have_poll_lock =3D NULL;
 	struct napi_struct *napi;
=20
 	WARN_ON_ONCE(!rcu_read_lock_held());
-
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 restart:
 	napi_poll =3D NULL;
=20
@@ -6834,6 +6844,7 @@ static int napi_thread_wait(struct napi_struct *napi)
=20
 static void napi_threaded_poll_loop(struct napi_struct *napi)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
 	unsigned long last_qs =3D jiffies;
=20
@@ -6842,6 +6853,8 @@ static void napi_threaded_poll_loop(struct napi_struc=
t *napi)
 		void *have;
=20
 		local_bh_disable();
+		bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
+
 		sd =3D this_cpu_ptr(&softnet_data);
 		sd->in_napi_threaded_poll =3D true;
=20
@@ -6857,6 +6870,7 @@ static void napi_threaded_poll_loop(struct napi_struc=
t *napi)
 			net_rps_action_and_irq_enable(sd);
 		}
 		skb_defer_free_flush(sd);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
=20
 		if (!repoll)
@@ -6879,13 +6893,16 @@ static int napi_threaded_poll(void *data)
=20
 static __latent_entropy void net_rx_action(struct softirq_action *h)
 {
+	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear);
 	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
 	unsigned long time_limit =3D jiffies +
 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
 	int budget =3D READ_ONCE(net_hotdata.netdev_budget);
+	struct bpf_net_context __bpf_net_ctx;
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
=20
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 start:
 	sd->in_net_rx_action =3D true;
 	local_irq_disable();
diff --git a/net/core/filter.c b/net/core/filter.c
index e95b235a1e4f4..90afa393d0648 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2475,8 +2475,10 @@ static const struct bpf_func_proto bpf_clone_redirec=
t_proto =3D {
 	.arg3_type      =3D ARG_ANYTHING,
 };
=20
-DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
-EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
+#ifndef CONFIG_PREEMPT_RT
+DEFINE_PER_CPU(struct bpf_net_context *, bpf_net_context);
+EXPORT_PER_CPU_SYMBOL_GPL(bpf_net_context);
+#endif
=20
 static struct net_device *skb_get_peer_dev(struct net_device *dev)
 {
@@ -2490,11 +2492,15 @@ static struct net_device *skb_get_peer_dev(struct n=
et_device *dev)
=20
 int skb_do_redirect(struct sk_buff *skb)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
 	struct net *net =3D dev_net(skb->dev);
+	struct bpf_redirect_info *ri;
 	struct net_device *dev;
-	u32 flags =3D ri->flags;
+	u32 flags;
=20
+	ri =3D bpf_net_ctx_get_ri();
+	if (!ri)
+		goto out_drop;
+	flags =3D ri->flags;
 	dev =3D dev_get_by_index_rcu(net, ri->tgt_index);
 	ri->tgt_index =3D 0;
 	ri->flags =3D 0;
@@ -2523,9 +2529,9 @@ int skb_do_redirect(struct sk_buff *skb)
=20
 BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
+	if (unlikely((flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)) || !r=
i))
 		return TC_ACT_SHOT;
=20
 	ri->flags =3D flags;
@@ -2544,9 +2550,9 @@ static const struct bpf_func_proto bpf_redirect_proto=
 =3D {
=20
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	if (unlikely(flags))
+	if (unlikely(flags || !ri))
 		return TC_ACT_SHOT;
=20
 	ri->flags =3D BPF_F_PEER;
@@ -2566,9 +2572,9 @@ static const struct bpf_func_proto bpf_redirect_peer_=
proto =3D {
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, par=
ams,
 	   int, plen, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	if (unlikely((plen && plen < sizeof(*params)) || flags))
+	if (unlikely((plen && plen < sizeof(*params)) || flags || !ri))
 		return TC_ACT_SHOT;
=20
 	ri->flags =3D BPF_F_NEIGH | (plen ? BPF_F_NEXTHOP : 0);
@@ -4294,19 +4300,17 @@ void xdp_do_check_flushed(struct napi_struct *napi)
=20
 void bpf_clear_redirect_map(struct bpf_map *map)
 {
-	struct bpf_redirect_info *ri;
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		ri =3D per_cpu_ptr(&bpf_redirect_info, cpu);
-		/* Avoid polluting remote cacheline due to writes if
-		 * not needed. Once we pass this test, we need the
-		 * cmpxchg() to make sure it hasn't been changed in
-		 * the meantime by remote CPU.
-		 */
-		if (unlikely(READ_ONCE(ri->map) =3D=3D map))
-			cmpxchg(&ri->map, map, NULL);
-	}
+	/* ri->map is assigned in __bpf_xdp_redirect_map() from within a eBPF
+	 * program/ during NAPI callback. It is used during
+	 * xdp_do_generic_redirect_map()/ __xdp_do_redirect_frame() from the
+	 * redirect callback afterwards. ri->map is cleared after usage.
+	 * The path has no explicit RCU read section but the local_bh_disable()
+	 * is also a RCU read section which makes the complete softirq callback
+	 * RCU protected. This in turn makes ri->map RCU protocted and it is
+	 * sufficient to wait a grace period to ensure that no "ri->map =3D=3D ma=
p"
+	 * exist.  dev_map_free() removes the map from the list and then
+	 * invokes synchronize_rcu() after calling this function.
+	 */
 }
=20
 DEFINE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
@@ -4315,11 +4319,14 @@ EXPORT_SYMBOL_GPL(bpf_master_redirect_enabled_key);
 u32 xdp_master_redirect(struct xdp_buff *xdp)
 {
 	struct net_device *master, *slave;
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri;
=20
 	master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
 	slave =3D master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
 	if (slave && slave !=3D xdp->rxq->dev) {
+		ri =3D bpf_net_ctx_get_ri();
+		if (!ri)
+			return XDP_ABORTED;
 		/* The target device is different from the receiving device, so
 		 * redirect it to the new device.
 		 * Using XDP_REDIRECT gets the correct behaviour from XDP enabled
@@ -4432,10 +4439,12 @@ static __always_inline int __xdp_do_redirect_frame(=
struct bpf_redirect_info *ri,
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
-	enum bpf_map_type map_type =3D ri->map_type;
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
+	if (!ri)
+		return -EINVAL;
+
+	if (ri->map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
=20
 	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
@@ -4446,10 +4455,12 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect);
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
-	enum bpf_map_type map_type =3D ri->map_type;
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
+	if (!ri)
+		return -EINVAL;
+
+	if (ri->map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
=20
 	return __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);
@@ -4463,10 +4474,13 @@ static int xdp_do_generic_redirect_map(struct net_d=
evice *dev,
 				       enum bpf_map_type map_type, u32 map_id,
 				       u32 flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	struct bpf_map *map;
 	int err;
=20
+	if (!ri)
+		return -EINVAL;
+
 	switch (map_type) {
 	case BPF_MAP_TYPE_DEVMAP:
 		fallthrough;
@@ -4517,13 +4531,21 @@ static int xdp_do_generic_redirect_map(struct net_d=
evice *dev,
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
-	enum bpf_map_type map_type =3D ri->map_type;
-	void *fwd =3D ri->tgt_value;
-	u32 map_id =3D ri->map_id;
-	u32 flags =3D ri->flags;
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
+	enum bpf_map_type map_type;
+	u32 map_id;
+	void *fwd;
+	u32 flags;
 	int err;
=20
+	if (!ri)
+		return -EINVAL;
+
+	map_type =3D ri->map_type;
+	fwd =3D ri->tgt_value;
+	map_id =3D ri->map_id;
+	flags =3D ri->flags;
+
 	ri->map_id =3D 0; /* Valid map id idr range: [1,INT_MAX[ */
 	ri->flags =3D 0;
 	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
@@ -4553,9 +4575,9 @@ int xdp_do_generic_redirect(struct net_device *dev, s=
truct sk_buff *skb,
=20
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
-	if (unlikely(flags))
+	if (unlikely(flags || !ri))
 		return XDP_ABORTED;
=20
 	/* NB! Map type UNSPEC and map_id =3D=3D INT_MAX (never generated
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index a94943681e5aa..afb05f58b64c5 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -38,12 +38,14 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct l=
wtunnel_state *lwt)
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int ret;
=20
 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
 	 * BPF prog and skb_do_redirect().
 	 */
 	local_bh_disable();
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 	bpf_compute_data_pointers(skb);
 	ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
=20
@@ -76,6 +78,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lw=
t_prog *lwt,
 		break;
 	}
=20
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
=20
 	return ret;
--=20
2.43.0


