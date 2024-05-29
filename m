Return-Path: <bpf+bounces-30856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3738D3C9C
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11DCB26F02
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1EE1C68B1;
	Wed, 29 May 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqMgYRrP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q+CJ7f0x"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5781A0B08;
	Wed, 29 May 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000185; cv=none; b=XQkjmLmpHwpEbXg7ar9Fq/kYFi/l+2kM39D9yrLlBStWYIPHO1TRzwC2TgOwcohlu7UDXyjLS5q2fmypm1ACI3q8SA4LwNM1C50pC0KAE3JrebErkCZrQGi1cvn4twFbd5BUofQ3bL+s7Mgi5mI4xndKNCwxlTrxW2UTq89E/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000185; c=relaxed/simple;
	bh=K+N7SScThVDvFeOZ74YnMYdDplqfJcdqL7SNISd4pK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciz42QNHNsp5xl6DvHqXqk4sFcb27/tNneFC/uvGR8BQp+UOa9Z/WfI2fuK/YcdCpUF6MJYK1uLc3B6zAJcmsO2nzoPB3Kp01BBt+RwtEWhd6xI2crnvaPqr6DGg5q5XgkviTwM5LgxFuBZtEBkyNvrTlzCNJAtJqEgRJd56FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqMgYRrP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q+CJ7f0x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5Jik/z8apqNPvVA8Qi90r3XumHNfaJX3DcXJHJQJHI=;
	b=aqMgYRrP64DXOPYtPPQCSWCqPFMeMTjwo5GFvoJXNLlvkR/r1KxZgxYAR9XgTB/C6h4wEM
	4/SzMjLdBa8SujwpQ2i2tU48Lrz6JQLWaLOE+BB4uHD3L24/LYjakkogordVvvOpilffnD
	CKI+3wG9PqbLGBXhOpvqfcOcx9+Z8ppXux66gfAOfccoTcs1JI5CYZ2Z5wQJSHVmeWzAN+
	8yNktZExpm39+A2PfJUur5nRjMM/HOsxKx/G4ZAbSjphPqGmhRfGvNt+QaVLtQMertEkEE
	ADeDpbKVrAyz9TDs6U2El0bN1PYa4QVJT/Sy5N+wZpOfANfhD+nS97x23yUNFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5Jik/z8apqNPvVA8Qi90r3XumHNfaJX3DcXJHJQJHI=;
	b=Q+CJ7f0xbTjRfywlvsqTb7BHffgDbBdhPdcv4zOq00FSoxJw5/FGIagrFYl+oloRl9nzLs
	jCogmtNgyx8r/BBg==
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
Subject: [PATCH v3 net-next 15/15] net: Move per-CPU flush-lists to bpf_net_context on PREEMPT_RT.
Date: Wed, 29 May 2024 18:02:38 +0200
Message-ID: <20240529162927.403425-16-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
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
access.

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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 32 ++++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c    | 19 +++----------------
 kernel/bpf/devmap.c    | 11 +++--------
 net/xdp/xsk.c          | 12 ++++--------
 4 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a0d0ea356f925..f94115d154890 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -746,6 +746,9 @@ struct bpf_redirect_info {
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
@@ -754,6 +757,14 @@ static inline struct bpf_net_context *bpf_net_ctx_set(=
struct bpf_net_context *bp
=20
 	if (tsk->bpf_net_context !=3D NULL)
 		return NULL;
+
+	if (IS_ENABLED(CONFIG_BPF_SYSCALL)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+	}
+	if (IS_ENABLED(CONFIG_XDP_SOCKETS))
+		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+
 	tsk->bpf_net_context =3D bpf_net_ctx;
 	return bpf_net_ctx;
 }
@@ -776,6 +787,27 @@ static inline struct bpf_redirect_info *bpf_net_ctx_ge=
t_ri(void)
 	return &bpf_net_ctx->ri;
 }
=20
+static inline struct list_head *bpf_net_ctx_get_cpu_map_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	return &bpf_net_ctx->cpu_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_dev_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	return &bpf_net_ctx->dev_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+
+	return &bpf_net_ctx->xskmap_map_flush_list;
+}
+
 DEFINE_FREE(bpf_net_ctx_clear, struct bpf_net_context *, bpf_net_ctx_clear=
(_T));
=20
 /* flags for bpf_redirect_info kern_flags */
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
index 4e2cdbb5629f2..9a66ac78a22ad 100644
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
@@ -408,7 +407,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, =
u32 flags)
  */
 void __dev_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq, *tmp;
=20
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -422,7 +421,7 @@ void __dev_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool dev_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&dev_flush_list)))
+	if (list_empty(bpf_net_ctx_get_dev_flush_list()))
 		return false;
 	__dev_flush();
 	return true;
@@ -453,7 +452,7 @@ static void *__dev_map_lookup_elem(struct bpf_map *map,=
 u32 key)
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq =3D this_cpu_ptr(dev->xdp_bulkq);
=20
 	if (unlikely(bq->count =3D=3D DEV_MAP_BULK_SIZE))
@@ -1156,15 +1155,11 @@ static struct notifier_block dev_map_notifier =3D {
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
index 727aa20be4bde..8b0b557408fc2 100644
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
@@ -375,7 +373,7 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff=
 *xdp)
=20
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	int err;
=20
 	err =3D xsk_rcv(xs, xdp);
@@ -390,7 +388,7 @@ int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_=
buff *xdp)
=20
 void __xsk_map_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	struct xdp_sock *xs, *tmp;
=20
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
@@ -402,7 +400,7 @@ void __xsk_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool xsk_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&xskmap_flush_list)))
+	if (list_empty(bpf_net_ctx_get_xskmap_flush_list()))
 		return false;
 	__xsk_map_flush();
 	return true;
@@ -1775,7 +1773,7 @@ static struct pernet_operations xsk_net_ops =3D {
=20
 static int __init xsk_init(void)
 {
-	int err, cpu;
+	int err;
=20
 	err =3D proto_register(&xsk_proto, 0 /* no slab */);
 	if (err)
@@ -1793,8 +1791,6 @@ static int __init xsk_init(void)
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


