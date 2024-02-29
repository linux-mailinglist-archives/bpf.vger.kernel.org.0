Return-Path: <bpf+bounces-23071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7B86D25D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C74B28243E
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0899C12F5AC;
	Thu, 29 Feb 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pc4ZdhSf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IB9gaWR9"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593C1096F;
	Thu, 29 Feb 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231490; cv=none; b=SyLGvWhmCUl16avdq/UlBO45ZIqKUEUnlUlysA7AmzG0X/p+J/60xMZdXGqg+XCNI6+B7rR7hqNxG0Eqxlm8rir9uJ31t61x3UZPUs2jTjmlMxLwEWYhdQzGqNV0MTR+H4UrtZXnlAsLJhMvjhjnOyBUwgbg/L0E72h0ZKtFDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231490; c=relaxed/simple;
	bh=EYSd9abP2PmOgKABRE3F5UZ4zyrOB2q8dkqNJRJUlZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHPsAXDGDWe96yht9+mDN1urBESVL8qr/7CtxCqWP/ZSRkt3Ecr9JVMBJ+YxSmsBL0N6hdfI1Da3jTO/C4F3TvNUESaCCLeWI53cesmAXT0lN7Qst+kpYQOTgIcWc8pEA8STIVyTHiyGz3Svtj8zGAfFgBvfuuPa1YgX7jnxax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pc4ZdhSf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IB9gaWR9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709231486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdpXNGFVbsC5pkQy2lXsam+HP1edF7uuBU134UjdZcs=;
	b=Pc4ZdhSfVYZj1Q1iT+TRloa59hTSGh24kGA2OnrxZo6ReCWTUv/NC5v+qDJ8rxt6cjOXzF
	1qqjeHp2zOBcPc+JgKsZeLURDv/N/h/Z8l33pVPhZb5GN2k1UfwtYyrXtSHcym+zNpMEA1
	NkZO0+I+1DbOv5WVc5rMUp7O0sPD0t0RpZ3Pqx8ZfSofxJXsJe34pcOgdahkpdBzzX5onZ
	Mpy1DENmt64Bqi+FkjrbKYWg1JZ5NasdQFftkH8eHrIzS4j2V8uIe/5Y6WW9QlE6gDA6vk
	BZsoUp/d4Y4oBnOqhas50ZOA6DOHtHZ3qlVVvEVNK3a0NNYKEPOFxigWQsY2cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709231486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdpXNGFVbsC5pkQy2lXsam+HP1edF7uuBU134UjdZcs=;
	b=IB9gaWR92mQ09yWm/GpCsMQvsEyXXQED3ISSLGZcMfVeRKzLJFCG2l9ooqyHZ0DwkHElzo
	MUPaUoixypYkwTCQ==
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
Subject: [PATCH RFC v2 net-next 2/2] net: Move per-CPU flush-lists to bpf_net_context on PREEMPT_RT.
Date: Thu, 29 Feb 2024 19:17:56 +0100
Message-ID: <20240229183109.646865-3-bigeasy@linutronix.de>
In-Reply-To: <20240229183109.646865-1-bigeasy@linutronix.de>
References: <20240229183109.646865-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The per-CPU flush lists, which are accessed from within the NAPI callback
(xdp_do_flush() for instance), are per-CPU. There are subject to the
same problem as struct bpf_redirect_info.

Add the per-CPU lists cpu_map_flush_list, dev_map_flush_list and
xskmap_map_flush_list to struct bpf_net_context. Add wrappers for the
access.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c    | 24 ++++++++----------------
 kernel/bpf/devmap.c    | 16 ++++++++--------
 net/xdp/xsk.c          | 19 +++++++++++--------
 4 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6d065991f9e9c..41c3dbbc4d163 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -706,6 +706,9 @@ struct bpf_redirect_info {
=20
 struct bpf_net_context {
 	struct bpf_redirect_info ri;
+	struct list_head cpu_map_flush_list;
+	struct list_head dev_map_flush_list;
+	struct list_head xskmap_map_flush_list;
 };
=20
 #ifndef CONFIG_PREEMPT_RT
@@ -718,6 +721,10 @@ static inline struct bpf_net_context *bpf_net_ctx_set(=
struct bpf_net_context *bp
 	ctx =3D this_cpu_read(bpf_net_context);
 	if (ctx !=3D NULL)
 		return NULL;
+	INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+	INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+	INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+
 	this_cpu_write(bpf_net_context, bpf_net_ctx);
 	return bpf_net_ctx;
 }
@@ -748,6 +755,10 @@ static inline struct bpf_net_context *bpf_net_ctx_set(=
struct bpf_net_context *bp
=20
 	if (tsk->bpf_net_context !=3D NULL)
 		return NULL;
+	INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+	INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+	INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+
 	tsk->bpf_net_context =3D bpf_net_ctx;
 	return bpf_net_ctx;
 }
@@ -780,6 +791,33 @@ static inline struct bpf_redirect_info *bpf_net_ctx_ge=
t_ri(void)
 	return &bpf_net_ctx->ri;
 }
=20
+static inline struct list_head *bpf_net_ctx_get_cpu_map_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!bpf_net_ctx)
+		return NULL;
+	return &bpf_net_ctx->cpu_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_dev_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!bpf_net_ctx)
+		return NULL;
+	return &bpf_net_ctx->dev_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!bpf_net_ctx)
+		return NULL;
+	return &bpf_net_ctx->xskmap_map_flush_list;
+}
+
 DEFINE_FREE(bpf_net_ctx_clear, struct bpf_net_context *, if (_T) bpf_net_c=
tx_clear(_T));
=20
 /* flags for bpf_redirect_info kern_flags */
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 6d140f0769d4c..59677cea28e18 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -78,8 +78,6 @@ struct bpf_cpu_map {
 	struct bpf_cpu_map_entry __rcu **cpu_map;
 };
=20
-static DEFINE_PER_CPU(struct list_head, cpu_map_flush_list);
-
 static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 {
 	u32 value_size =3D attr->value_size;
@@ -703,7 +701,7 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
  */
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *x=
dpf)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq =3D this_cpu_ptr(rcpu->bulkq);
=20
 	if (unlikely(bq->count =3D=3D CPU_MAP_BULK_SIZE))
@@ -755,9 +753,12 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry =
*rcpu,
=20
 void __cpu_map_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq, *tmp;
=20
+	if (!flush_list)
+		return;
+
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
 		bq_flush_to_queue(bq);
=20
@@ -769,20 +770,11 @@ void __cpu_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool cpu_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&cpu_map_flush_list)))
+	struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
+
+	if (!flush_list || list_empty(bpf_net_ctx_get_cpu_map_flush_list()))
 		return false;
 	__cpu_map_flush();
 	return true;
 }
 #endif
-
-static int __init cpu_map_init(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(cpu_map_flush_list, cpu));
-	return 0;
-}
-
-subsys_initcall(cpu_map_init);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e77..463f3c5eaa895 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -83,7 +83,6 @@ struct bpf_dtab {
 	u32 n_buckets;
 };
=20
-static DEFINE_PER_CPU(struct list_head, dev_flush_list);
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
=20
@@ -407,9 +406,12 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq,=
 u32 flags)
  */
 void __dev_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq, *tmp;
=20
+	if (!flush_list)
+		return;
+
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
 		bq_xmit_all(bq, XDP_XMIT_FLUSH);
 		bq->dev_rx =3D NULL;
@@ -421,7 +423,9 @@ void __dev_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool dev_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&dev_flush_list)))
+	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
+
+	if (!flush_list || list_empty(bpf_net_ctx_get_dev_flush_list()))
 		return false;
 	__dev_flush();
 	return true;
@@ -452,7 +456,7 @@ static void *__dev_map_lookup_elem(struct bpf_map *map,=
 u32 key)
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq =3D this_cpu_ptr(dev->xdp_bulkq);
=20
 	if (unlikely(bq->count =3D=3D DEV_MAP_BULK_SIZE))
@@ -1155,15 +1159,11 @@ static struct notifier_block dev_map_notifier =3D {
=20
 static int __init dev_map_init(void)
 {
-	int cpu;
-
 	/* Assure tracepoint shadow struct _bpf_dtab_netdev is in sync */
 	BUILD_BUG_ON(offsetof(struct bpf_dtab_netdev, dev) !=3D
 		     offsetof(struct _bpf_dtab_netdev, dev));
 	register_netdevice_notifier(&dev_map_notifier);
=20
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(dev_flush_list, cpu));
 	return 0;
 }
=20
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b78c0e095e221..7a130d0871de1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -35,8 +35,6 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
=20
-static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -372,9 +370,12 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buf=
f *xdp)
=20
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	int err;
=20
+	if (!flush_list)
+		return -EINVAL;
+
 	err =3D xsk_rcv(xs, xdp);
 	if (err)
 		return err;
@@ -387,9 +388,11 @@ int __xsk_map_redirect(struct xdp_sock *xs, struct xdp=
_buff *xdp)
=20
 void __xsk_map_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	struct xdp_sock *xs, *tmp;
=20
+	if (!flush_list)
+		return;
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
 		xsk_flush(xs);
 		__list_del_clearprev(&xs->flush_node);
@@ -399,7 +402,9 @@ void __xsk_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool xsk_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&xskmap_flush_list)))
+	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
+
+	if (!flush_list || list_empty(flush_list))
 		return false;
 	__xsk_map_flush();
 	return true;
@@ -1770,7 +1775,7 @@ static struct pernet_operations xsk_net_ops =3D {
=20
 static int __init xsk_init(void)
 {
-	int err, cpu;
+	int err;
=20
 	err =3D proto_register(&xsk_proto, 0 /* no slab */);
 	if (err)
@@ -1788,8 +1793,6 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
=20
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(xskmap_flush_list, cpu));
 	return 0;
=20
 out_pernet:
--=20
2.43.0


