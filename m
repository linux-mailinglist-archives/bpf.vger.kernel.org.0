Return-Path: <bpf+bounces-21852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BF853404
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A501C28511
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A766027E;
	Tue, 13 Feb 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NtTUW+qY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHC7ouPt"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD625F876;
	Tue, 13 Feb 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836382; cv=none; b=dU0a6jKsN7NiPMZbeg1YtcY0bAyABsvsffIZ1ropRIM3gkv/84/bkU4AITehyUOVjpVg7vVi1/SVsqDZ8nNEO767/Q0FINxblnzqwP7SdJE1B9CXfpkb/4A9UEvqAuZH2Xj8+1C+zPXgCJkiwvPhdw0FY01rMHl+jMnsDNxSKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836382; c=relaxed/simple;
	bh=wjiwkF+i767m6mSZALI0ZQpRF080pIQxsoW8OMLvcFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsaTLdRZJs2z2DPHx1lOY+jP3KBWvvKTEQpwGnteG3IMN6q1LjuruACTg07UivFQEIdUdR7SwAnnMee7ny6mpfFPcENdYBQH4Hv7x6HK4CMe1y+Z4XJ0KkiF5UONUc3FSpm7Lqw2a0g2EaljMCdZWbkkcSf0FK+k/EjQjrNLy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NtTUW+qY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHC7ouPt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707836378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxJiYWx6lJWHWIj1ASGVWEOAkQaT3yBq0qvrAEz2ajw=;
	b=NtTUW+qYOjYivPBUtaQNVlXIGt6qgRrs2bOiXMQKQDJTOL8NvCTNsv5cjmVITti0/k2qvt
	hHvWRyco6ON8p7hdHdRNaLZatZWVgY/IZ/PcfWOUxqVABmJHhSd8V2JiIIhGhptDs2ndHY
	g8/pT/fTB2njZ+USvF3b8CeKR9cht3j1sEJH6ACB7US1MRm3j1Pry6Vub2ykZwoxWLRskU
	MxWsVug8A2B2VR0v3QHfVm+bi0I+shOvoSYtJKcqZSO3r6VblZg/G4f1fIdUi8+Qphpnqi
	0WGpThbDmoaOP2KLqNBYbksPVqrHF/ioBCMTRyVvRNLGHwODRTxlXS6IQPtlMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707836378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxJiYWx6lJWHWIj1ASGVWEOAkQaT3yBq0qvrAEz2ajw=;
	b=uHC7ouPtWT6+A4K2T/63OLuuin25fIWcbrIPNiEkHEpTT5zKYM4fzPqjFny36RuE3Fyp9c
	46AdCN95JKtowUAQ==
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
Subject: [PATCH RFC net-next 2/2] net: Move per-CPU flush-lists to bpf_xdp_storage on PREEMPT_RT.
Date: Tue, 13 Feb 2024 15:58:53 +0100
Message-ID: <20240213145923.2552753-3-bigeasy@linutronix.de>
In-Reply-To: <20240213145923.2552753-1-bigeasy@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The per-CPU flush lists are accessed from within the NAPI callback
(xdp_do_flush() for instance). They are subject to the same problem as stru=
ct
bpf_redirect_info.

Add the per-CPU lists cpu_map_flush_list, dev_map_flush_list and
xskmap_map_flush_list to struct bpf_xdp_storage. Add wrappers for the
access. Use it only on PREEMPT_RT, keep the per-CPU lists on
non-PREEMPT_RT builds.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c    | 33 ++++++++++++++++++++++++++-------
 kernel/bpf/devmap.c    | 33 ++++++++++++++++++++++++++-------
 net/xdp/xsk.c          | 33 +++++++++++++++++++++++++++------
 4 files changed, 113 insertions(+), 20 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 97c9be9cabfd6..231ecdc431a00 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -725,6 +725,9 @@ static inline struct bpf_redirect_info *xdp_storage_get=
_ri(void)
=20
 struct bpf_xdp_storage {
 	struct bpf_redirect_info ri;
+	struct list_head cpu_map_flush_list;
+	struct list_head dev_map_flush_list;
+	struct list_head xskmap_map_flush_list;
 };
=20
 static inline struct bpf_xdp_storage *xdp_storage_set(struct bpf_xdp_stora=
ge *xdp_store)
@@ -734,6 +737,9 @@ static inline struct bpf_xdp_storage *xdp_storage_set(s=
truct bpf_xdp_storage *xd
 	tsk =3D current;
 	if (tsk->bpf_xdp_storage !=3D NULL)
 		return NULL;
+	INIT_LIST_HEAD(&xdp_store->cpu_map_flush_list);
+	INIT_LIST_HEAD(&xdp_store->dev_map_flush_list);
+	INIT_LIST_HEAD(&xdp_store->xskmap_map_flush_list);
 	tsk->bpf_xdp_storage =3D xdp_store;
 	return xdp_store;
 }
@@ -764,6 +770,34 @@ static inline struct bpf_redirect_info *xdp_storage_ge=
t_ri(void)
 		return NULL;
 	return &xdp_store->ri;
 }
+
+static inline struct list_head *xdp_storage_get_cpu_map_flush_list(void)
+{
+	struct bpf_xdp_storage *xdp_store =3D xdp_storage_get();
+
+	if (!xdp_store)
+		return NULL;
+	return &xdp_store->cpu_map_flush_list;
+}
+
+static inline struct list_head *xdp_storage_get_dev_flush_list(void)
+{
+	struct bpf_xdp_storage *xdp_store =3D xdp_storage_get();
+
+	if (!xdp_store)
+		return NULL;
+	return &xdp_store->dev_map_flush_list;
+}
+
+static inline struct list_head *xdp_storage_get_xskmap_flush_list(void)
+{
+	struct bpf_xdp_storage *xdp_store =3D xdp_storage_get();
+
+	if (!xdp_store)
+		return NULL;
+	return &xdp_store->xskmap_map_flush_list;
+}
+
 #endif
 DEFINE_FREE(xdp_storage_clear, struct bpf_xdp_storage *, if (_T) xdp_stora=
ge_clear(_T));
=20
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index c40ae831ab1a6..ec5be37399c82 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -78,8 +78,30 @@ struct bpf_cpu_map {
 	struct bpf_cpu_map_entry __rcu **cpu_map;
 };
=20
+#ifndef CONFIG_PREEMPT_RT
 static DEFINE_PER_CPU(struct list_head, cpu_map_flush_list);
=20
+static struct list_head *xdp_storage_get_cpu_map_flush_list(void)
+{
+	return this_cpu_ptr(&cpu_map_flush_list);
+}
+
+static void init_cpu_map_flush_list(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		INIT_LIST_HEAD(&per_cpu(cpu_map_flush_list, cpu));
+}
+
+#else
+
+static void init_cpu_map_flush_list(void)
+{
+}
+
+#endif
+
 static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 {
 	u32 value_size =3D attr->value_size;
@@ -703,7 +725,7 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
  */
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *x=
dpf)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list =3D xdp_storage_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq =3D this_cpu_ptr(rcpu->bulkq);
=20
 	if (unlikely(bq->count =3D=3D CPU_MAP_BULK_SIZE))
@@ -755,7 +777,7 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *=
rcpu,
=20
 void __cpu_map_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list =3D xdp_storage_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq, *tmp;
=20
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -769,7 +791,7 @@ void __cpu_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool cpu_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&cpu_map_flush_list)))
+	if (list_empty(xdp_storage_get_cpu_map_flush_list()))
 		return false;
 	__cpu_map_flush();
 	return true;
@@ -778,10 +800,7 @@ bool cpu_map_check_flush(void)
=20
 static int __init cpu_map_init(void)
 {
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(cpu_map_flush_list, cpu));
+	init_cpu_map_flush_list();
 	return 0;
 }
=20
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e77..c1af5d9d60381 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -83,7 +83,29 @@ struct bpf_dtab {
 	u32 n_buckets;
 };
=20
+#ifndef CONFIG_PREEMPT_RT
 static DEFINE_PER_CPU(struct list_head, dev_flush_list);
+
+static struct list_head *xdp_storage_get_dev_flush_list(void)
+{
+	return this_cpu_ptr(&dev_flush_list);
+}
+
+static void init_dev_flush_list(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		INIT_LIST_HEAD(&per_cpu(dev_flush_list, cpu));
+}
+
+#else
+
+static void init_dev_flush_list(void)
+{
+}
+#endif
+
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
=20
@@ -407,7 +429,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, =
u32 flags)
  */
 void __dev_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D xdp_storage_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq, *tmp;
=20
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -421,7 +443,7 @@ void __dev_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool dev_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&dev_flush_list)))
+	if (list_empty(xdp_storage_get_dev_flush_list()))
 		return false;
 	__dev_flush();
 	return true;
@@ -452,7 +474,7 @@ static void *__dev_map_lookup_elem(struct bpf_map *map,=
 u32 key)
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list =3D xdp_storage_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq =3D this_cpu_ptr(dev->xdp_bulkq);
=20
 	if (unlikely(bq->count =3D=3D DEV_MAP_BULK_SIZE))
@@ -1155,15 +1177,12 @@ static struct notifier_block dev_map_notifier =3D {
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
+	init_dev_flush_list();
 	return 0;
 }
=20
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b78c0e095e221..3050739cfe1e0 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -35,8 +35,30 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
=20
+#ifndef CONFIG_PREEMPT_RT
 static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
=20
+static struct list_head *xdp_storage_get_xskmap_flush_list(void)
+{
+	return this_cpu_ptr(&xskmap_flush_list);
+}
+
+static void init_xskmap_flush_list(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		INIT_LIST_HEAD(&per_cpu(xskmap_flush_list, cpu));
+}
+
+#else
+
+static void init_xskmap_flush_list(void)
+{
+}
+
+#endif
+
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -372,7 +394,7 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff=
 *xdp)
=20
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D xdp_storage_get_xskmap_flush_list();
 	int err;
=20
 	err =3D xsk_rcv(xs, xdp);
@@ -387,7 +409,7 @@ int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_=
buff *xdp)
=20
 void __xsk_map_flush(void)
 {
-	struct list_head *flush_list =3D this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list =3D xdp_storage_get_xskmap_flush_list();
 	struct xdp_sock *xs, *tmp;
=20
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
@@ -399,7 +421,7 @@ void __xsk_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool xsk_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&xskmap_flush_list)))
+	if (list_empty(xdp_storage_get_xskmap_flush_list()))
 		return false;
 	__xsk_map_flush();
 	return true;
@@ -1770,7 +1792,7 @@ static struct pernet_operations xsk_net_ops =3D {
=20
 static int __init xsk_init(void)
 {
-	int err, cpu;
+	int err;
=20
 	err =3D proto_register(&xsk_proto, 0 /* no slab */);
 	if (err)
@@ -1788,8 +1810,7 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
=20
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(xskmap_flush_list, cpu));
+	init_xskmap_flush_list();
 	return 0;
=20
 out_pernet:
--=20
2.43.0


