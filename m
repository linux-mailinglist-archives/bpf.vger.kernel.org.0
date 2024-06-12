Return-Path: <bpf+bounces-31963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3D90598D
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AA82841B5
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1C195808;
	Wed, 12 Jun 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtNQ+hnj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g22PdosN"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A189185096;
	Wed, 12 Jun 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211809; cv=none; b=Bb3RO1gQq/HF1szGBFnFILsaK8LU4imYgj4RuD928yWy+UZ8jXvziRIPIh02p0zOzyQBdHPKlmEYt28JWnpxXBU9YiK4dgNLO07/T42wEMa4g6WQBfqBNffXEce+TIq8I/cSKhJ8Emm/JRyIw7qME5Lgi8n3/kF79OborC7WTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211809; c=relaxed/simple;
	bh=O+k/lODCH7svZwTNDxIAPFqoX+udqz84Z2kbuhFRg8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGsWfcPxMr+Uxw2Z71y1Ushjbg9MCugQrbpqsdBrngGNcMVq4fy0ZxUwbeJIz16RaOUlUrzP4k2IC8oZ5dS3Pxk/4LtQqXWCUGQcT9xzDENzlGuuF0Tj0WqOUkOPA9zOT4xHbFFWJPcWUVAJYTT5qENNnqosKa1FPQLIAAzwTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtNQ+hnj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g22PdosN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718211801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95NQzYoB4Er/GsWCvEgALkY1ARP5FCX6Mw0YbhA77Yk=;
	b=rtNQ+hnjv/5ILBGabeIna70dAOzG3w+U3DSJd9mh99//KJe6tDqHNh8cbfXY98PnCrJ6NY
	xtEGV1RMHpnwjKbw6cA2SEzScSAPrF5IInY8UwLYKMGgHOAW35hmkzFPcU0evbOOEz3GT4
	WmOESJ45H88OPwrX7RLfnZjPJqENKfXQlNuzWoP9W1rfQkMFP2oHdOd43thoqJVJGfpw8h
	SO0z1ubaycWtjdpCWJjc18wt3fbee0I5isDrpW/V4LZhoVoA+Wyi5HEeTmnrjPA5Hq/hR8
	dEJ1qKFjNFZ5kJjlJmxhn6IhtF3WYbfIRi+EiFi6WBDePhqx5r/yN9UTbj0RMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718211801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95NQzYoB4Er/GsWCvEgALkY1ARP5FCX6Mw0YbhA77Yk=;
	b=g22PdosNsyf3CIX/N8wj1YYCUAGx+uK+d1jdGuUwprApSf0TdihPzkE1WTcMX2zE1ZcXqQ
	uUV06GwavX3SAuAA==
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 15/15] net: Move per-CPU flush-lists to bpf_net_context on PREEMPT_RT.
Date: Wed, 12 Jun 2024 18:44:41 +0200
Message-ID: <20240612170303.3896084-16-bigeasy@linutronix.de>
In-Reply-To: <20240612170303.3896084-1-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The per-CPU flush lists, which are accessed from within the NAPI callback
(xdp_do_flush() for instance), are per-CPU. There are subject to the
same problem as struct bpf_redirect_info.

Add the per-CPU lists cpu_map_flush_list, dev_map_flush_list and
xskmap_map_flush_list to struct bpf_net_context. Add wrappers for the
access. The lists initialized on first usage (similar to
bpf_net_ctx_get_ri()).

Cc: "Bj=C3=B6rn T=C3=B6pel" <bjorn@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c    | 19 +++----------------
 kernel/bpf/devmap.c    | 11 +++--------
 net/xdp/xsk.c          | 12 ++++--------
 4 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0a7f6e4a00b60..c0349522de8fb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -736,6 +736,9 @@ struct bpf_nh_params {
 /* flags for bpf_redirect_info kern_flags */
 #define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
 #define BPF_RI_F_RI_INIT	BIT(1)
+#define BPF_RI_F_CPU_MAP_INIT	BIT(2)
+#define BPF_RI_F_DEV_MAP_INIT	BIT(3)
+#define BPF_RI_F_XSK_MAP_INIT	BIT(4)
=20
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -750,6 +753,9 @@ struct bpf_redirect_info {
=20
 struct bpf_net_context {
 	struct bpf_redirect_info ri;
+	struct list_head cpu_map_flush_list;
+	struct list_head dev_map_flush_list;
+	struct list_head xskmap_map_flush_list;
 };
=20
 static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_conte=
xt *bpf_net_ctx)
@@ -787,6 +793,42 @@ static inline struct bpf_redirect_info *bpf_net_ctx_ge=
t_ri(void)
 	return &bpf_net_ctx->ri;
 }
=20
+static inline struct list_head *bpf_net_ctx_get_cpu_map_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_CPU_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |=3D BPF_RI_F_CPU_MAP_INIT;
+	}
+
+	return &bpf_net_ctx->cpu_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_dev_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_DEV_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |=3D BPF_RI_F_DEV_MAP_INIT;
+	}
+
+	return &bpf_net_ctx->dev_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_XSK_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |=3D BPF_RI_F_XSK_MAP_INIT;
+	}
+
+	return &bpf_net_ctx->xskmap_map_flush_list;
+}
+
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
  * lwt, ...). Subsystems allowing direct data access must (!)
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 66974bd027109..068e994ed781a 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -79,8 +79,6 @@ struct bpf_cpu_map {
 	struct bpf_cpu_map_entry __rcu **cpu_map;
 };
=20
-static DEFINE_PER_CPU(struct list_head, cpu_map_flush_list);
-
 static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 {
 	u32 value_size =3D attr->value_size;
@@ -709,7 +707,7 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
  */
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *x=
dpf)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq =3D this_cpu_ptr(rcpu->bulkq);
=20
 	if (unlikely(bq->count =3D=3D CPU_MAP_BULK_SIZE))
@@ -761,7 +759,7 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *=
rcpu,
=20
 void __cpu_map_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq, *tmp;
=20
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -775,20 +773,9 @@ void __cpu_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool cpu_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&cpu_map_flush_list)))
+	if (list_empty(bpf_net_ctx_get_cpu_map_flush_list()))
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
index fbfdfb60db8d7..317ac2d66ebd1 100644
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
@@ -415,7 +414,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, =
u32 flags)
  */
 void __dev_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq, *tmp;
=20
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -429,7 +428,7 @@ void __dev_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool dev_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&dev_flush_list)))
+	if (list_empty(bpf_net_ctx_get_dev_flush_list()))
 		return false;
 	__dev_flush();
 	return true;
@@ -460,7 +459,7 @@ static void *__dev_map_lookup_elem(struct bpf_map *map,=
 u32 key)
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq =3D this_cpu_ptr(dev->xdp_bulkq);
=20
 	if (unlikely(bq->count =3D=3D DEV_MAP_BULK_SIZE))
@@ -1160,15 +1159,11 @@ static struct notifier_block dev_map_notifier =3D {
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
index 7d1c0986f9bb3..ed062e0383896 100644
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
@@ -372,7 +370,7 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff=
 *xdp)
=20
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	int err;
=20
 	err =3D xsk_rcv(xs, xdp);
@@ -387,7 +385,7 @@ int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_=
buff *xdp)
=20
 void __xsk_map_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	struct xdp_sock *xs, *tmp;
=20
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
@@ -399,7 +397,7 @@ void __xsk_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool xsk_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&xskmap_flush_list)))
+	if (list_empty(bpf_net_ctx_get_xskmap_flush_list()))
 		return false;
 	__xsk_map_flush();
 	return true;
@@ -1772,7 +1770,7 @@ static struct pernet_operations xsk_net_ops =3D {
=20
 static int __init xsk_init(void)
 {
-	int err, cpu;
+	int err;
=20
 	err =3D proto_register(&xsk_proto, 0 /* no slab */);
 	if (err)
@@ -1790,8 +1788,6 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
=20
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(xskmap_flush_list, cpu));
 	return 0;
=20
 out_pernet:
--=20
2.45.1


