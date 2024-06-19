Return-Path: <bpf+bounces-32499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C50490E467
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 09:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C13286549
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE821369AA;
	Wed, 19 Jun 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wElN8yQ2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpwSOEP6"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20D81740;
	Wed, 19 Jun 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781811; cv=none; b=AmWDcsF5UJ3PZbQOWJuf1NQ40auL3SKy97SRt4frHObePib7hvyTKorLj/tf5qNLrLXLtrtDWa6wQ9vP3u/KwYW9gqnIxB8fgKXyTCOUkrKT5N3McVf5INzTMsA8AkDVebykfWVmArFZdrJvXt97YP/B+Kuwa0iyv8W3Bs/8e5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781811; c=relaxed/simple;
	bh=MQ1X0kWyvoXqdefQgvzTMflJbGoz/TUqWgwpzOUwac4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Phf/TxojymHkgfrEo0Sq3nXWR/RtnP4u6j2qMqsVm1Dn9UGKtzSKJ/jsnmNJDsvJRQCSUkH5XpuYCPSmMk5MbLqZ1XmD3oZSgJKfIGEs4+Ywg0La4EXMEMCeB0Sf1OH3cqmvl3S/Lv/TILrnUmPyTa8JncCnMyLbPZE0OEtBp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wElN8yQ2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpwSOEP6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718781808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmCvPE662v26Z3j7exwM14/a24AGn3PFdv2kkWMmd24=;
	b=wElN8yQ2Dpdt2N2Ho+ytJRARCHzeri2UH0P7uWk0oZFoNP2tovABt3J2sZsJp3dMDnr0i7
	cUsAvR6XRNx7EZ42AeeqbvLmRAiEjiWKaWaKMdsNdehB31IpvIGl1byZePQOSOAOnWtC7w
	XJm04j88ztGVe6lH4U31850M87WTuNz5ed/doY7EVSrHf10lOe1d41d7Sqo5rmPAj3ya8x
	49p+tdp+bjrdEttlCF1f1itVFEPAjLhaqUJAVXCoRGTfiqsLWudS1Q+qlULfXov9JcZUa0
	Y0zZs9CJCqVQdqo1y5L1BsL1cffZZB8BodvSeF/+KJwskPcAo0q2+/x5t/Ihcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718781808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmCvPE662v26Z3j7exwM14/a24AGn3PFdv2kkWMmd24=;
	b=ZpwSOEP6Bf4i55o1KuBz/Ni12UEKvSGTNWtzESnMqdn3P8EBGXGFOJLQiGz3+X56r1CnKN
	pA3QFSVo/tjOj5Aw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [PATCH v8 net-next 14/15] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
Date: Wed, 19 Jun 2024 09:17:05 +0200
Message-ID: <20240619072253.504963-15-bigeasy@linutronix.de>
In-Reply-To: <20240619072253.504963-1-bigeasy@linutronix.de>
References: <20240619072253.504963-1-bigeasy@linutronix.de>
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
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 56 ++++++++++++++++++++++++++++++++++--------
 include/linux/sched.h  |  3 +++
 kernel/bpf/cpumap.c    |  3 +++
 kernel/bpf/devmap.c    |  9 ++++++-
 kernel/fork.c          |  1 +
 net/bpf/test_run.c     | 11 ++++++++-
 net/core/dev.c         | 26 +++++++++++++++++++-
 net/core/filter.c      | 44 +++++++++------------------------
 net/core/lwt_bpf.c     |  3 +++
 9 files changed, 111 insertions(+), 45 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b02aea291b7e8..0a7f6e4a00b60 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -733,21 +733,59 @@ struct bpf_nh_params {
 	};
 };
=20
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
=20
-DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
+struct bpf_net_context {
+	struct bpf_redirect_info ri;
+};
=20
-/* flags for bpf_redirect_info kern_flags */
-#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
+static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_conte=
xt *bpf_net_ctx)
+{
+	struct task_struct *tsk =3D current;
+
+	if (tsk->bpf_net_context !=3D NULL)
+		return NULL;
+	bpf_net_ctx->ri.kern_flags =3D 0;
+
+	tsk->bpf_net_context =3D bpf_net_ctx;
+	return bpf_net_ctx;
+}
+
+static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
+{
+	if (bpf_net_ctx)
+		current->bpf_net_context =3D NULL;
+}
+
+static inline struct bpf_net_context *bpf_net_ctx_get(void)
+{
+	return current->bpf_net_context;
+}
+
+static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
+		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
+		bpf_net_ctx->ri.kern_flags |=3D BPF_RI_F_RI_INIT;
+	}
+
+	return &bpf_net_ctx->ri;
+}
=20
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
@@ -1018,25 +1056,23 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_p=
rog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
=20
-void bpf_clear_redirect_map(struct bpf_map *map);
-
 static inline bool xdp_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
 	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline void xdp_set_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
 	ri->kern_flags |=3D BPF_RI_F_RF_NO_DIRECT;
 }
=20
 static inline void xdp_clear_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
 	ri->kern_flags &=3D ~BPF_RI_F_RF_NO_DIRECT;
 }
@@ -1592,7 +1628,7 @@ static __always_inline long __bpf_xdp_redirect_map(st=
ruct bpf_map *map, u64 inde
 						   u64 flags, const u64 flag_mask,
 						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	const u64 action_mask =3D XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
=20
 	/* Lower bits of the flags are used as return code on lookup failure */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5187486c25222..5ff5e65a46277 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -54,6 +54,7 @@ struct bio_list;
 struct blk_plug;
 struct bpf_local_storage;
 struct bpf_run_ctx;
+struct bpf_net_context;
 struct capture_control;
 struct cfs_rq;
 struct fs_struct;
@@ -1509,6 +1510,8 @@ struct task_struct {
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
 #endif
+	/* Used by BPF for per-TASK xdp storage */
+	struct bpf_net_context		*bpf_net_context;
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
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 7f3b34452243c..fbfdfb60db8d7 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -196,7 +196,14 @@ static void dev_map_free(struct bpf_map *map)
 	list_del_rcu(&dtab->list);
 	spin_unlock(&dev_map_lock);
=20
-	bpf_clear_redirect_map(map);
+	/* bpf_redirect_info->map is assigned in __bpf_xdp_redirect_map()
+	 * during NAPI callback and cleared after the XDP redirect. There is no
+	 * explicit RCU read section which protects bpf_redirect_info->map but
+	 * local_bh_disable() also marks the beginning an RCU section. This
+	 * makes the complete softirq callback RCU protected. Thus after
+	 * following synchronize_rcu() there no bpf_redirect_info->map =3D=3D map
+	 * assignment.
+	 */
 	synchronize_rcu();
=20
 	/* Make sure prior __dev_map_entry_free() have completed. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d83..f314bdd7e6108 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2355,6 +2355,7 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx =3D NULL;
 #endif
+	p->bpf_net_context =3D  NULL;
=20
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval =3D sched_fork(clone_flags, p);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 36ae54f57bf57..a6d7f790cdda8 100644
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
index 42ac76524e84e..1e0ce68c78b48 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4045,10 +4045,13 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
 {
 	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(skb->dev->tcx_ingres=
s);
 	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_INGRESS;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
=20
 	if (!entry)
 		return skb;
+
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 	if (*pt_prev) {
 		*ret =3D deliver_skb(skb, *pt_prev, orig_dev);
 		*pt_prev =3D NULL;
@@ -4077,10 +4080,12 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
 			break;
 		}
 		*ret =3D NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret =3D NET_RX_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4090,8 +4095,10 @@ sch_handle_ingress(struct sk_buff *skb, struct packe=
t_type **pt_prev, int *ret,
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret =3D NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
=20
 	return skb;
 }
@@ -4101,11 +4108,14 @@ sch_handle_egress(struct sk_buff *skb, int *ret, st=
ruct net_device *dev)
 {
 	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_EGRESS;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
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
@@ -4121,10 +4131,12 @@ sch_handle_egress(struct sk_buff *skb, int *ret, st=
ruct net_device *dev)
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret =3D NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret =3D NET_XMIT_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4134,8 +4146,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, str=
uct net_device *dev)
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret =3D NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
=20
 	return skb;
 }
@@ -6373,6 +6387,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 {
 	unsigned long start_time =3D loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	void *have_poll_lock =3D NULL;
 	struct napi_struct *napi;
=20
@@ -6391,6 +6406,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		int work =3D 0;
=20
 		local_bh_disable();
+		bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 		if (!napi_poll) {
 			unsigned long val =3D READ_ONCE(napi->state);
=20
@@ -6421,6 +6437,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
 		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
=20
 		if (!loop_end || loop_end(loop_end_arg, start_time))
@@ -6848,6 +6865,7 @@ static int napi_thread_wait(struct napi_struct *napi)
=20
 static void napi_threaded_poll_loop(struct napi_struct *napi)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
 	unsigned long last_qs =3D jiffies;
=20
@@ -6856,6 +6874,8 @@ static void napi_threaded_poll_loop(struct napi_struc=
t *napi)
 		void *have;
=20
 		local_bh_disable();
+		bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
+
 		sd =3D this_cpu_ptr(&softnet_data);
 		sd->in_napi_threaded_poll =3D true;
=20
@@ -6871,6 +6891,7 @@ static void napi_threaded_poll_loop(struct napi_struc=
t *napi)
 			net_rps_action_and_irq_enable(sd);
 		}
 		skb_defer_free_flush(sd);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
=20
 		if (!repoll)
@@ -6896,10 +6917,12 @@ static __latent_entropy void net_rx_action(struct s=
oftirq_action *h)
 	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
 	unsigned long time_limit =3D jiffies +
 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int budget =3D READ_ONCE(net_hotdata.netdev_budget);
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
=20
+	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
 start:
 	sd->in_net_rx_action =3D true;
 	local_irq_disable();
@@ -6952,7 +6975,8 @@ static __latent_entropy void net_rx_action(struct sof=
tirq_action *h)
 		sd->in_net_rx_action =3D false;
=20
 	net_rps_action_and_irq_enable(sd);
-end:;
+end:
+	bpf_net_ctx_clear(bpf_net_ctx);
 }
=20
 struct netdev_adjacent {
diff --git a/net/core/filter.c b/net/core/filter.c
index fbcfd563dccfd..f40b8393dd58f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2478,9 +2478,6 @@ static const struct bpf_func_proto bpf_clone_redirect=
_proto =3D {
 	.arg3_type      =3D ARG_ANYTHING,
 };
=20
-DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
-EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
-
 static struct net_device *skb_get_peer_dev(struct net_device *dev)
 {
 	const struct net_device_ops *ops =3D dev->netdev_ops;
@@ -2493,7 +2490,7 @@ static struct net_device *skb_get_peer_dev(struct net=
_device *dev)
=20
 int skb_do_redirect(struct sk_buff *skb)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	struct net *net =3D dev_net(skb->dev);
 	struct net_device *dev;
 	u32 flags =3D ri->flags;
@@ -2526,7 +2523,7 @@ int skb_do_redirect(struct sk_buff *skb)
=20
 BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return TC_ACT_SHOT;
@@ -2547,7 +2544,7 @@ static const struct bpf_func_proto bpf_redirect_proto=
 =3D {
=20
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
 	if (unlikely(flags))
 		return TC_ACT_SHOT;
@@ -2569,7 +2566,7 @@ static const struct bpf_func_proto bpf_redirect_peer_=
proto =3D {
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, par=
ams,
 	   int, plen, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
 	if (unlikely((plen && plen < sizeof(*params)) || flags))
 		return TC_ACT_SHOT;
@@ -4295,30 +4292,13 @@ void xdp_do_check_flushed(struct napi_struct *napi)
 }
 #endif
=20
-void bpf_clear_redirect_map(struct bpf_map *map)
-{
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
-}
-
 DEFINE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
 EXPORT_SYMBOL_GPL(bpf_master_redirect_enabled_key);
=20
 u32 xdp_master_redirect(struct xdp_buff *xdp)
 {
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	struct net_device *master, *slave;
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
=20
 	master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
 	slave =3D master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
@@ -4390,7 +4370,7 @@ static __always_inline int __xdp_do_redirect_frame(st=
ruct bpf_redirect_info *ri,
 			map =3D READ_ONCE(ri->map);
=20
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err =3D -ENOENT;
@@ -4435,7 +4415,7 @@ static __always_inline int __xdp_do_redirect_frame(st=
ruct bpf_redirect_info *ri,
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type =3D ri->map_type;
=20
 	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
@@ -4449,7 +4429,7 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect);
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type =3D ri->map_type;
=20
 	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
@@ -4466,7 +4446,7 @@ static int xdp_do_generic_redirect_map(struct net_dev=
ice *dev,
 				       enum bpf_map_type map_type, u32 map_id,
 				       u32 flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	struct bpf_map *map;
 	int err;
=20
@@ -4478,7 +4458,7 @@ static int xdp_do_generic_redirect_map(struct net_dev=
ice *dev,
 			map =3D READ_ONCE(ri->map);
=20
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err =3D -ENOENT;
@@ -4520,7 +4500,7 @@ static int xdp_do_generic_redirect_map(struct net_dev=
ice *dev,
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type =3D ri->map_type;
 	void *fwd =3D ri->tgt_value;
 	u32 map_id =3D ri->map_id;
@@ -4556,7 +4536,7 @@ int xdp_do_generic_redirect(struct net_device *dev, s=
truct sk_buff *skb,
=20
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
=20
 	if (unlikely(flags))
 		return XDP_ABORTED;
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
2.45.2


