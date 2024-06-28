Return-Path: <bpf+bounces-33358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B763591BCA5
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4E8B23018
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963CC155C9A;
	Fri, 28 Jun 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtEhO7xP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0xzfPCf"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183562A02;
	Fri, 28 Jun 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570629; cv=none; b=k21YEIlasdG+30W+Zzpzsq3+XLM6FCTUtLrqPIJEh/Nh/5OUTeCYXc09GPujD8PXTD66f1zixxo9u8YzG+9uLjZTheNjdZCY1YEqxm5UhriCpWQggSTJAwYpep2F4Eg8sWGzROIAE9Uw0eiKjeIjbKYIbAuWqGk2BLynq4JFuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570629; c=relaxed/simple;
	bh=casdKhOv3LH1KZNTSVGBljTf8Uf2uLkPZ8M8hgrNh/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7wO6Q2JE1h4zW8D65yvjJ/CqqvLDtw+x+VZoXSM3Hohh8Qq/TOnqW2pwK1ApfxD+6lshqhQmbQ3x/AfCZzE9xH/yfr0g4/Golo4b+bCtwjKpqwg/JBY471PlEvKylpfu1uADBU4Q7sZy3xIAB1dOrVe0L99CT58pKcA5hTG0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtEhO7xP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0xzfPCf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719570625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K1H7GEeHE3speKRjA8Nt6QPosNQittkkORcQKP4oBM=;
	b=ZtEhO7xP1qAtxan1hplngmHivRt/ucmizGQJIM1utCDIa3l3xlC30MO9tMqfpML1730B9Q
	XEk3vi6DRNSDOx5ON+wAxZOnQC+JN8unVDzFxnNYtonVmnD2n/tUtF/TZGaHcH5M3Mjv9v
	6xSinUye8yQXi+RT9Is6L92npVFepjb832gzfMiIuqykq0SiRQd6V1AghyE2shm1vrlnzS
	gEdTHjaq4ne2aoZxZFeccoQRnCCtlef6u9+4oGSFMUYok6eCxS0zK1LmftThPRkQqNtgN/
	g+UuzYqnUnYzhR3d30pRF7Lfkya3C+5KTI8USEzsvYQwyvfr8F5wwm8EdMWWHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719570625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K1H7GEeHE3speKRjA8Nt6QPosNQittkkORcQKP4oBM=;
	b=v0xzfPCfJzCxWCuIT2Za0428gbZZN167IJxRpWrByvQ3nLiPJgNp1SUCUMINeHf1zM+9/4
	pmLDGyylTSecyHCw==
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
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
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 2/3] net: Optimize xdp_do_flush() with bpf_net_context infos.
Date: Fri, 28 Jun 2024 12:18:55 +0200
Message-ID: <20240628103020.1766241-3-bigeasy@linutronix.de>
In-Reply-To: <20240628103020.1766241-1-bigeasy@linutronix.de>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Every NIC driver utilizing XDP should invoke xdp_do_flush() after
processing all packages. With the introduction of the bpf_net_context
logic the flush lists (for dev, CPU-map and xsk) are lazy initialized
only if used. However xdp_do_flush() tries to flush all three of them so
all three lists are always initialized and the likely empty lists are
"iterated".
Without the usage of XDP but with CONFIG_DEBUG_NET the lists are also
initialized due to xdp_do_check_flushed().

Jakub suggest to utilize the hints in bpf_net_context and avoid invoking
the flush function. This will also avoiding initializing the lists which
are otherwise unused.

Introduce bpf_net_ctx_get_all_used_flush_lists() to return the
individual list if not-empty. Use the logic in xdp_do_flush() and
xdp_do_check_flushed(). Remove the not needed .*_check_flush().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/bpf.h    | 10 ++++------
 include/linux/filter.h | 27 +++++++++++++++++++++++++++
 include/net/xdp_sock.h | 14 ++------------
 kernel/bpf/cpumap.c    | 13 +------------
 kernel/bpf/devmap.c    | 13 +------------
 net/core/filter.c      | 33 +++++++++++++++++++++++++--------
 net/xdp/xsk.c          | 13 +------------
 7 files changed, 61 insertions(+), 62 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a834f4b761bc5..f5c6bc9093a6b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2494,7 +2494,7 @@ struct sk_buff;
 struct bpf_dtab_netdev;
 struct bpf_cpu_map_entry;
=20
-void __dev_flush(void);
+void __dev_flush(struct list_head *flush_list);
 int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
@@ -2507,7 +2507,7 @@ int dev_map_redirect_multi(struct net_device *dev, st=
ruct sk_buff *skb,
 			   struct bpf_prog *xdp_prog, struct bpf_map *map,
 			   bool exclude_ingress);
=20
-void __cpu_map_flush(void);
+void __cpu_map_flush(struct list_head *flush_list);
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
 int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
@@ -2644,8 +2644,6 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, voi=
d *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
=20
-bool dev_check_flush(void);
-bool cpu_map_check_flush(void);
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -2738,7 +2736,7 @@ static inline struct bpf_token *bpf_token_get_from_fd=
(u32 ufd)
 	return ERR_PTR(-EOPNOTSUPP);
 }
=20
-static inline void __dev_flush(void)
+static inline void __dev_flush(struct list_head *flush_list)
 {
 }
=20
@@ -2784,7 +2782,7 @@ int dev_map_redirect_multi(struct net_device *dev, st=
ruct sk_buff *skb,
 	return 0;
 }
=20
-static inline void __cpu_map_flush(void)
+static inline void __cpu_map_flush(struct list_head *flush_list)
 {
 }
=20
diff --git a/include/linux/filter.h b/include/linux/filter.h
index c0349522de8fb..02ddcfdf94c46 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -829,6 +829,33 @@ static inline struct list_head *bpf_net_ctx_get_xskmap=
_flush_list(void)
 	return &bpf_net_ctx->xskmap_map_flush_list;
 }
=20
+static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head *=
*lh_map,
+							struct list_head **lh_dev,
+							struct list_head **lh_xsk)
+{
+	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
+	u32 kern_flags =3D bpf_net_ctx->ri.kern_flags;
+	struct list_head *lh;
+
+	*lh_map =3D *lh_dev =3D *lh_xsk =3D NULL;
+
+	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
+		return;
+
+	lh =3D &bpf_net_ctx->dev_map_flush_list;
+	if (kern_flags & BPF_RI_F_DEV_MAP_INIT && !list_empty(lh))
+		*lh_dev =3D lh;
+
+	lh =3D &bpf_net_ctx->cpu_map_flush_list;
+	if (kern_flags & BPF_RI_F_CPU_MAP_INIT && !list_empty(lh))
+		*lh_map =3D lh;
+
+	lh =3D &bpf_net_ctx->xskmap_map_flush_list;
+	if (IS_ENABLED(CONFIG_XDP_SOCKETS) &&
+	    kern_flags & BPF_RI_F_XSK_MAP_INIT && !list_empty(lh))
+		*lh_xsk =3D lh;
+}
+
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
  * lwt, ...). Subsystems allowing direct data access must (!)
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3d54de168a6d9..bfe625b55d55d 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -121,7 +121,7 @@ struct xsk_tx_metadata_ops {
=20
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
-void __xsk_map_flush(void);
+void __xsk_map_flush(struct list_head *flush_list);
=20
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
@@ -206,7 +206,7 @@ static inline int __xsk_map_redirect(struct xdp_sock *x=
s, struct xdp_buff *xdp)
 	return -EOPNOTSUPP;
 }
=20
-static inline void __xsk_map_flush(void)
+static inline void __xsk_map_flush(struct list_head *flush_list)
 {
 }
=20
@@ -228,14 +228,4 @@ static inline void xsk_tx_metadata_complete(struct xsk=
_tx_metadata_compl *compl,
 }
=20
 #endif /* CONFIG_XDP_SOCKETS */
-
-#if defined(CONFIG_XDP_SOCKETS) && defined(CONFIG_DEBUG_NET)
-bool xsk_map_check_flush(void);
-#else
-static inline bool xsk_map_check_flush(void)
-{
-	return false;
-}
-#endif
-
 #endif /* _LINUX_XDP_SOCK_H */
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 068e994ed781a..4acf90cd79eb4 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -757,9 +757,8 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *=
rcpu,
 	return ret;
 }
=20
-void __cpu_map_flush(void)
+void __cpu_map_flush(struct list_head *flush_list)
 {
-	struct list_head *flush_list =3D bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq, *tmp;
=20
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -769,13 +768,3 @@ void __cpu_map_flush(void)
 		wake_up_process(bq->obj->kthread);
 	}
 }
-
-#ifdef CONFIG_DEBUG_NET
-bool cpu_map_check_flush(void)
-{
-	if (list_empty(bpf_net_ctx_get_cpu_map_flush_list()))
-		return false;
-	__cpu_map_flush();
-	return true;
-}
-#endif
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 317ac2d66ebd1..9ca47eaacdd5e 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -412,9 +412,8 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, =
u32 flags)
  * driver before returning from its napi->poll() routine. See the comment =
above
  * xdp_do_flush() in filter.c.
  */
-void __dev_flush(void)
+void __dev_flush(struct list_head *flush_list)
 {
-	struct list_head *flush_list =3D bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq, *tmp;
=20
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -425,16 +424,6 @@ void __dev_flush(void)
 	}
 }
=20
-#ifdef CONFIG_DEBUG_NET
-bool dev_check_flush(void)
-{
-	if (list_empty(bpf_net_ctx_get_dev_flush_list()))
-		return false;
-	__dev_flush();
-	return true;
-}
-#endif
-
 /* Elements are kept alive by RCU; either by rcu_read_lock() (from syscall=
) or
  * by local_bh_disable() (from XDP calls inside NAPI). The
  * rcu_read_lock_bh_held() below makes lockdep accept both.
diff --git a/net/core/filter.c b/net/core/filter.c
index eb1c4425c06f3..403d23faf22e1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4277,22 +4277,39 @@ static const struct bpf_func_proto bpf_xdp_adjust_m=
eta_proto =3D {
  */
 void xdp_do_flush(void)
 {
-	__dev_flush();
-	__cpu_map_flush();
-	__xsk_map_flush();
+	struct list_head *lh_map, *lh_dev, *lh_xsk;
+
+	bpf_net_ctx_get_all_used_flush_lists(&lh_map, &lh_dev, &lh_xsk);
+	if (lh_dev)
+		__dev_flush(lh_dev);
+	if (lh_map)
+		__cpu_map_flush(lh_map);
+	if (lh_xsk)
+		__xsk_map_flush(lh_xsk);
 }
 EXPORT_SYMBOL_GPL(xdp_do_flush);
=20
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
 void xdp_do_check_flushed(struct napi_struct *napi)
 {
-	bool ret;
+	struct list_head *lh_map, *lh_dev, *lh_xsk;
+	bool missed =3D false;
=20
-	ret =3D dev_check_flush();
-	ret |=3D cpu_map_check_flush();
-	ret |=3D xsk_map_check_flush();
+	bpf_net_ctx_get_all_used_flush_lists(&lh_map, &lh_dev, &lh_xsk);
+	if (lh_dev) {
+		__dev_flush(lh_dev);
+		missed =3D true;
+	}
+	if (lh_map) {
+		__cpu_map_flush(lh_map);
+		missed =3D true;
+	}
+	if (lh_xsk) {
+		__xsk_map_flush(lh_xsk);
+		missed =3D true;
+	}
=20
-	WARN_ONCE(ret, "Missing xdp_do_flush() invocation after NAPI by %ps\n",
+	WARN_ONCE(missed, "Missing xdp_do_flush() invocation after NAPI by %ps\n",
 		  napi->poll);
 }
 #endif
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ed062e0383896..de9c0322bc294 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -383,9 +383,8 @@ int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_=
buff *xdp)
 	return 0;
 }
=20
-void __xsk_map_flush(void)
+void __xsk_map_flush(struct list_head *flush_list)
 {
-	struct list_head *flush_list =3D bpf_net_ctx_get_xskmap_flush_list();
 	struct xdp_sock *xs, *tmp;
=20
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
@@ -394,16 +393,6 @@ void __xsk_map_flush(void)
 	}
 }
=20
-#ifdef CONFIG_DEBUG_NET
-bool xsk_map_check_flush(void)
-{
-	if (list_empty(bpf_net_ctx_get_xskmap_flush_list()))
-		return false;
-	__xsk_map_flush();
-	return true;
-}
-#endif
-
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
 	xskq_prod_submit_n(pool->cq, nb_entries);
--=20
2.45.2


