Return-Path: <bpf+bounces-21851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D76853402
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890AA1C284B7
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804CB5F847;
	Tue, 13 Feb 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rnfSd7Av";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PFBLS0T"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F760262;
	Tue, 13 Feb 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836381; cv=none; b=qGbWn+ornWwkbmtkiF4TfyO199RsO6aKlOGDiWL6nn5fU7g+hAANH1yX0FdjflfGwa54Zi2VqwJkXzBMfFY/QEfbF0l7ZXDscSfsGBot+9i+iXD0vikWPGAPSWksNAfveg8OD5IP5w1svmKzNLBy5k7lnw/70NMAWHEd62x0C4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836381; c=relaxed/simple;
	bh=kL9KqkXTHvUHMnaXqKIVDdQjzRwQqUJRxoYWUz4peAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7vC2QAO91q1IV33hzeKIGb8UGbt0HGWGqvksWgMGAJauO1yWSelkju3wCIDa3IHDiKyHm6LRzwoOB/BckyG/ReRzRNJKsJD5rK6RaK/7yyLH7tPnDPuwySgfhW5euuOmQX8LUNIVW4EQnbhJvmJSfwuuMzX+QHyXtTqH7k1M8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rnfSd7Av; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PFBLS0T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707836376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d680AwFIQIXhd6f1Ksxh1Y9XQpKH2erDG1L+AL6aebM=;
	b=rnfSd7AvXiFULxS4BTuCgRcpOTNt+dGqhMkr37uws2MNXvPk1YEOfjLZhvXL28vVUK4QmA
	2DSvezH4vdMImY7EqII1Tl2MqXFgDHJc8ibp/QIpjn0RKbwHHq53s9+1yjmsY9JcjC8V3v
	whvGmqDMzzgcqeR7v5rC0gswmB3UVt05ZsrhxEeNde+IyVIyXwOo+oitkz+km9XsOnq5sG
	MvpBuNhJZUyuxW50DZrJ4GOuqOmI9dpDAzVVN3PcPnhg2OnfLNe0vl1BgnrdLvA/SAVMvY
	CoN+9FDcC4Gvir+3D8Oi8olJlCprKPlQn1iEPTIJfPYis1iGKmV6vlQwv/oZmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707836376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d680AwFIQIXhd6f1Ksxh1Y9XQpKH2erDG1L+AL6aebM=;
	b=0PFBLS0T3+r/RXBx+TYvpza22J8rvKEW2fOd2Es3MX8sCv8/waWOhRsC5GJ25s+PWdNJgo
	MjMgGB2njWyJoKDw==
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
Date: Tue, 13 Feb 2024 15:58:52 +0100
Message-ID: <20240213145923.2552753-2-bigeasy@linutronix.de>
In-Reply-To: <20240213145923.2552753-1-bigeasy@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
requires explicit locking to avoid corruption if preemption occurs.

PREEMPT_RT has forced-threaded interrupts enabled and every
NAPI-callback runs in a thread. If each thread has its own data
structure then locking can be avoided and data corruption is also avoided.

Create a struct bpf_xdp_storage which contains struct bpf_redirect_info.
Define the variable on stack, use xdp_storage_set() to set a pointer to
it in task_struct of the current task. Use the __free() annotation to
automatically reset the pointer once function returns. Use a pointer which =
can
be used by the __free() annotation to avoid invoking the callback the point=
er
is NULL. This helps the compiler to optimize the code.
The xdp_storage_set() can nest. For instance local_bh_enable() in
bpf_test_run_xdp_live() may run NET_RX_SOFTIRQ/ net_rx_action() which
also uses xdp_storage_set(). Therefore only the first invocations
updates the per-task pointer.
Use xdp_storage_get_ri() as a wrapper to retrieve the current struct
bpf_redirect_info.

This is only done on PREEMPT_RT. The !PREEMPT_RT builds keep using the
per-CPU variable instead. This should also work for !PREEMPT_RT but
isn't needed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 79 ++++++++++++++++++++++++++++++++++++---
 include/linux/sched.h  |  5 +++
 kernel/bpf/cpumap.c    |  2 +
 kernel/fork.c          |  3 ++
 net/bpf/test_run.c     |  9 ++++-
 net/core/dev.c         | 17 +++++++++
 net/core/filter.c      | 85 +++++++++++++++++++++++++++++++-----------
 net/core/lwt_bpf.c     |  3 ++
 8 files changed, 174 insertions(+), 29 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 68fb6c8142fec..97c9be9cabfd6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -704,8 +704,69 @@ struct bpf_redirect_info {
 	struct bpf_nh_params nh;
 };
=20
+#ifndef CONFIG_PREEMPT_RT
 DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
=20
+struct bpf_xdp_storage { };
+
+static inline struct bpf_xdp_storage *xdp_storage_set(struct bpf_xdp_stora=
ge *xdp_store)
+{
+	return NULL;
+}
+
+static inline void xdp_storage_clear(struct bpf_xdp_storage *xdp_store) { }
+
+static inline struct bpf_redirect_info *xdp_storage_get_ri(void)
+{
+	return this_cpu_ptr(&bpf_redirect_info);
+}
+
+#else
+
+struct bpf_xdp_storage {
+	struct bpf_redirect_info ri;
+};
+
+static inline struct bpf_xdp_storage *xdp_storage_set(struct bpf_xdp_stora=
ge *xdp_store)
+{
+	struct task_struct *tsk;
+
+	tsk =3D current;
+	if (tsk->bpf_xdp_storage !=3D NULL)
+		return NULL;
+	tsk->bpf_xdp_storage =3D xdp_store;
+	return xdp_store;
+}
+
+static inline void xdp_storage_clear(struct bpf_xdp_storage *xdp_store)
+{
+	struct task_struct *tsk;
+
+	tsk =3D current;
+	if (tsk->bpf_xdp_storage !=3D xdp_store)
+		return;
+	tsk->bpf_xdp_storage =3D NULL;
+}
+
+static inline struct bpf_xdp_storage *xdp_storage_get(void)
+{
+	struct bpf_xdp_storage *xdp_store =3D current->bpf_xdp_storage;
+
+	WARN_ON_ONCE(!xdp_store);
+	return xdp_store;
+}
+
+static inline struct bpf_redirect_info *xdp_storage_get_ri(void)
+{
+	struct bpf_xdp_storage *xdp_store =3D xdp_storage_get();
+
+	if (!xdp_store)
+		return NULL;
+	return &xdp_store->ri;
+}
+#endif
+DEFINE_FREE(xdp_storage_clear, struct bpf_xdp_storage *, if (_T) xdp_stora=
ge_clear(_T));
+
 /* flags for bpf_redirect_info kern_flags */
 #define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
=20
@@ -974,23 +1035,27 @@ void bpf_clear_redirect_map(struct bpf_map *map);
=20
 static inline bool xdp_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
=20
+	if (!ri)
+		return false;
 	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline void xdp_set_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
=20
-	ri->kern_flags |=3D BPF_RI_F_RF_NO_DIRECT;
+	if (ri)
+		ri->kern_flags |=3D BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline void xdp_clear_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
=20
-	ri->kern_flags &=3D ~BPF_RI_F_RF_NO_DIRECT;
+	if (ri)
+		ri->kern_flags &=3D ~BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
@@ -1544,9 +1609,11 @@ static __always_inline long __bpf_xdp_redirect_map(s=
truct bpf_map *map, u64 inde
 						   u64 flags, const u64 flag_mask,
 						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
 	const u64 action_mask =3D XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
=20
+	if (!ri)
+		return XDP_ABORTED;
 	/* Lower bits of the flags are used as return code on lookup failure */
 	if (unlikely(flags & ~(action_mask | flag_mask)))
 		return XDP_ABORTED;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 111f388d65323..179ea10ae1fd1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -53,6 +53,7 @@ struct bio_list;
 struct blk_plug;
 struct bpf_local_storage;
 struct bpf_run_ctx;
+struct bpf_xdp_storage;
 struct capture_control;
 struct cfs_rq;
 struct fs_struct;
@@ -1501,6 +1502,10 @@ struct task_struct {
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	/* Used by BPF for per-TASK xdp storage */
+	struct bpf_xdp_storage		*bpf_xdp_storage;
+#endif
=20
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	unsigned long			lowest_stack;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8a0bb80fe48a3..c40ae831ab1a6 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -261,10 +261,12 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_en=
try *rcpu, void **frames,
=20
 static int cpu_map_kthread_run(void *data)
 {
+	struct bpf_xdp_storage xdp_store __cleanup(xdp_storage_clear);
 	struct bpf_cpu_map_entry *rcpu =3D data;
=20
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
+	xdp_storage_set(&xdp_store);
=20
 	/* When kthread gives stop order, then rcpu have been disconnected
 	 * from map, thus no new packets can enter. Remaining in-flight
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d944e92a43ff..0d8eb8d20963e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2462,6 +2462,9 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx =3D NULL;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	p->bpf_xdp_storage =3D  NULL;
+#endif
=20
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval =3D sched_fork(clone_flags, p);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd9193740178..50902d5254115 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -281,7 +281,7 @@ static int xdp_recv_frames(struct xdp_frame **frames, i=
nt nframes,
 static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *=
prog,
 			      u32 repeat)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri;
 	int err =3D 0, act, ret, i, nframes =3D 0, batch_sz;
 	struct xdp_frame **frames =3D xdp->frames;
 	struct xdp_page_head *head;
@@ -293,6 +293,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp=
, struct bpf_prog *prog,
 	batch_sz =3D min_t(u32, repeat, xdp->batch_size);
=20
 	local_bh_disable();
+	ri =3D xdp_storage_get_ri();
 	xdp_set_return_frame_no_direct();
=20
 	for (i =3D 0; i < batch_sz; i++) {
@@ -365,8 +366,10 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog=
, struct xdp_buff *ctx,
 				 u32 repeat, u32 batch_size, u32 *time)
=20
 {
+	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
 	struct xdp_test_data xdp =3D { .batch_size =3D batch_size };
 	struct bpf_test_timer t =3D { .mode =3D NO_MIGRATE };
+	struct bpf_xdp_storage __xdp_store;
 	int ret;
=20
 	if (!repeat)
@@ -376,6 +379,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog,=
 struct xdp_buff *ctx,
 	if (ret)
 		return ret;
=20
+	xdp_store =3D xdp_storage_set(&__xdp_store);
 	bpf_test_timer_enter(&t);
 	do {
 		xdp.frame_cnt =3D 0;
@@ -392,7 +396,9 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog,=
 struct xdp_buff *ctx,
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time, bool xdp)
 {
+	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
 	struct bpf_prog_array_item item =3D {.prog =3D prog};
+	struct bpf_xdp_storage __xdp_store;
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
 	struct bpf_test_timer t =3D { NO_MIGRATE };
@@ -412,6 +418,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ct=
x, u32 repeat,
 	if (!repeat)
 		repeat =3D 1;
=20
+	xdp_store =3D xdp_storage_set(&__xdp_store);
 	bpf_test_timer_enter(&t);
 	old_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
 	do {
diff --git a/net/core/dev.c b/net/core/dev.c
index de362d5f26559..c3f7d2a6b6134 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3988,11 +3988,15 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(skb->dev->tcx_ingres=
s);
+	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
 	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_INGRESS;
+	struct bpf_xdp_storage __xdp_store;
 	int sch_ret;
=20
 	if (!entry)
 		return skb;
+
+	xdp_store =3D xdp_storage_set(&__xdp_store);
 	if (*pt_prev) {
 		*ret =3D deliver_skb(skb, *pt_prev, orig_dev);
 		*pt_prev =3D NULL;
@@ -4044,12 +4048,16 @@ static __always_inline struct sk_buff *
 sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egress);
+	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
 	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_EGRESS;
+	struct bpf_xdp_storage __xdp_store;
 	int sch_ret;
=20
 	if (!entry)
 		return skb;
=20
+	xdp_store =3D xdp_storage_set(&__xdp_store);
+
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -6240,10 +6248,13 @@ void napi_busy_loop(unsigned int napi_id,
 		    void *loop_end_arg, bool prefer_busy_poll, u16 budget)
 {
 	unsigned long start_time =3D loop_end ? busy_loop_current_time() : 0;
+	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
+	struct bpf_xdp_storage __xdp_store;
 	void *have_poll_lock =3D NULL;
 	struct napi_struct *napi;
=20
+	xdp_store =3D xdp_storage_set(&__xdp_store);
 restart:
 	napi_poll =3D NULL;
=20
@@ -6716,10 +6727,13 @@ static void skb_defer_free_flush(struct softnet_dat=
a *sd)
=20
 static int napi_threaded_poll(void *data)
 {
+	struct bpf_xdp_storage xdp_store __cleanup(xdp_storage_clear);
 	struct napi_struct *napi =3D data;
 	struct softnet_data *sd;
 	void *have;
=20
+	xdp_storage_set(&xdp_store);
+
 	while (!napi_thread_wait(napi)) {
 		for (;;) {
 			bool repoll =3D false;
@@ -6753,13 +6767,16 @@ static int napi_threaded_poll(void *data)
=20
 static __latent_entropy void net_rx_action(struct softirq_action *h)
 {
+	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
 	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
 	unsigned long time_limit =3D jiffies +
 		usecs_to_jiffies(READ_ONCE(netdev_budget_usecs));
 	int budget =3D READ_ONCE(netdev_budget);
+	struct bpf_xdp_storage __xdp_store;
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
=20
+	xdp_store =3D xdp_storage_set(&__xdp_store);
 start:
 	sd->in_net_rx_action =3D true;
 	local_irq_disable();
diff --git a/net/core/filter.c b/net/core/filter.c
index eb8d5a0a0ec8f..5721acb15d40f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2473,8 +2473,10 @@ static const struct bpf_func_proto bpf_clone_redirec=
t_proto =3D {
 	.arg3_type      =3D ARG_ANYTHING,
 };
=20
+#ifndef CONFIG_PREEMPT_RT
 DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
 EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
+#endif
=20
 static struct net_device *skb_get_peer_dev(struct net_device *dev)
 {
@@ -2488,11 +2490,15 @@ static struct net_device *skb_get_peer_dev(struct n=
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
+	ri =3D xdp_storage_get_ri();
+	if (!ri)
+		goto out_drop;
+	flags =3D ri->flags;
 	dev =3D dev_get_by_index_rcu(net, ri->tgt_index);
 	ri->tgt_index =3D 0;
 	ri->flags =3D 0;
@@ -2521,9 +2527,9 @@ int skb_do_redirect(struct sk_buff *skb)
=20
 BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
=20
-	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
+	if (unlikely((flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)) || !r=
i))
 		return TC_ACT_SHOT;
=20
 	ri->flags =3D flags;
@@ -2542,9 +2548,9 @@ static const struct bpf_func_proto bpf_redirect_proto=
 =3D {
=20
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
=20
-	if (unlikely(flags))
+	if (unlikely(flags || !ri))
 		return TC_ACT_SHOT;
=20
 	ri->flags =3D BPF_F_PEER;
@@ -2564,9 +2570,9 @@ static const struct bpf_func_proto bpf_redirect_peer_=
proto =3D {
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, par=
ams,
 	   int, plen, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
=20
-	if (unlikely((plen && plen < sizeof(*params)) || flags))
+	if (unlikely((plen && plen < sizeof(*params)) || flags || !ri))
 		return TC_ACT_SHOT;
=20
 	ri->flags =3D BPF_F_NEIGH | (plen ? BPF_F_NEXTHOP : 0);
@@ -4292,6 +4298,7 @@ void xdp_do_check_flushed(struct napi_struct *napi)
=20
 void bpf_clear_redirect_map(struct bpf_map *map)
 {
+#ifndef CONFIG_PREEMPT_RT
 	struct bpf_redirect_info *ri;
 	int cpu;
=20
@@ -4305,6 +4312,19 @@ void bpf_clear_redirect_map(struct bpf_map *map)
 		if (unlikely(READ_ONCE(ri->map) =3D=3D map))
 			cmpxchg(&ri->map, map, NULL);
 	}
+#else
+	/* ri->map is assigned in __bpf_xdp_redirect_map() from within a eBPF
+	 * program/ during NAPI callback. It is used during
+	 * xdp_do_generic_redirect_map()/ __xdp_do_redirect_frame() from the
+	 * redirect callback afterwards. ri->map is cleared after usage.
+	 * The path has no explicit RCU read section but the local_bh_disable()
+	 * is also a RCU read section which makes the complete softirq callback
+	 * RCU protected. This in turn makes ri->map RCU protocted and it is
+	 * sufficient to wait a grace period to ensure that no "ri->map =3D=3D ma=
p"
+	 * exist. dev_map_free() removes the map from the list and then
+	 * invokes synchronize_rcu() after calling this function.
+	 */
+#endif
 }
=20
 DEFINE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
@@ -4313,11 +4333,14 @@ EXPORT_SYMBOL_GPL(bpf_master_redirect_enabled_key);
 u32 xdp_master_redirect(struct xdp_buff *xdp)
 {
 	struct net_device *master, *slave;
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri;
=20
 	master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
 	slave =3D master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
 	if (slave && slave !=3D xdp->rxq->dev) {
+		ri =3D xdp_storage_get_ri();
+		if (!ri)
+			return XDP_ABORTED;
 		/* The target device is different from the receiving device, so
 		 * redirect it to the new device.
 		 * Using XDP_REDIRECT gets the correct behaviour from XDP enabled
@@ -4419,10 +4442,13 @@ static __always_inline int __xdp_do_redirect_frame(=
struct bpf_redirect_info *ri,
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
-	enum bpf_map_type map_type =3D ri->map_type;
+	struct bpf_redirect_info *ri;
=20
-	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
+	ri =3D xdp_storage_get_ri();
+	if (!ri)
+		return -EINVAL;
+
+	if (ri->map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
=20
 	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
@@ -4433,10 +4459,13 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect);
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
-	enum bpf_map_type map_type =3D ri->map_type;
+	struct bpf_redirect_info *ri;
=20
-	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
+	ri =3D xdp_storage_get_ri();
+	if (!ri)
+		return -EINVAL;
+
+	if (ri->map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
=20
 	return __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);
@@ -4450,10 +4479,14 @@ static int xdp_do_generic_redirect_map(struct net_d=
evice *dev,
 				       void *fwd,
 				       enum bpf_map_type map_type, u32 map_id)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
 	struct bpf_map *map;
 	int err;
=20
+	if (!ri) {
+		err =3D -EINVAL;
+		goto err;
+	}
 	switch (map_type) {
 	case BPF_MAP_TYPE_DEVMAP:
 		fallthrough;
@@ -4495,12 +4528,20 @@ static int xdp_do_generic_redirect_map(struct net_d=
evice *dev,
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
-	enum bpf_map_type map_type =3D ri->map_type;
-	void *fwd =3D ri->tgt_value;
-	u32 map_id =3D ri->map_id;
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
+	enum bpf_map_type map_type;
+	void *fwd;
+	u32 map_id;
 	int err;
=20
+	if (!ri) {
+		err =3D -EINVAL;
+		goto err;
+	}
+	map_type =3D ri->map_type;
+	fwd =3D ri->tgt_value;
+	map_id =3D ri->map_id;
+
 	ri->map_id =3D 0; /* Valid map id idr range: [1,INT_MAX[ */
 	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
=20
@@ -4529,9 +4570,9 @@ int xdp_do_generic_redirect(struct net_device *dev, s=
truct sk_buff *skb,
=20
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D xdp_storage_get_ri();
=20
-	if (unlikely(flags))
+	if (unlikely(flags || !ri))
 		return XDP_ABORTED;
=20
 	/* NB! Map type UNSPEC and map_id =3D=3D INT_MAX (never generated
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index a94943681e5aa..54690b85f1fe6 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -38,12 +38,15 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct l=
wtunnel_state *lwt)
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
+	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
+	struct bpf_xdp_storage __xdp_store;
 	int ret;
=20
 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
 	 * BPF prog and skb_do_redirect().
 	 */
 	local_bh_disable();
+	xdp_store =3D xdp_storage_set(&__xdp_store);
 	bpf_compute_data_pointers(skb);
 	ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
=20
--=20
2.43.0


