Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55687139860
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 19:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMSLE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 13:11:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbgAMSLD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 13:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578939062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CnyPPlY6Kv7nU3kCGgPT7acTvati/h0l0qlxzOiyN6I=;
        b=iA/J5bH62Y2DM68lGEPDoB8wgN5uN+IcODxJ8xQq4UC+kzmKFlzT8iBDxme7mhfVpc+9Ax
        W08LXbLqs2bHe1SitWRFMhVFd5sgDyINAU27soRlp1iRpkrYU3BYwLqwLLkMAFM5E4ao95
        9MWa1DEI10QhhlHj1x4Wra3585UBTE4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-qxYYzLo2O92WvNXNkuvt0A-1; Mon, 13 Jan 2020 13:11:00 -0500
X-MC-Unique: qxYYzLo2O92WvNXNkuvt0A-1
Received: by mail-lj1-f199.google.com with SMTP id o9so2279579ljc.6
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 10:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CnyPPlY6Kv7nU3kCGgPT7acTvati/h0l0qlxzOiyN6I=;
        b=rA3E3ICi2VNc8vAxuJ4k0pebCQLasKV+Bkn9Rp4dRopwIASswS/uSSSHH48bRBezMV
         1hcg1ITkd5Ju/BFdhzOsMt+5xkJGmIejN3maUkj3XFuKr1geo9AF5aRmgVyQx2A0pTyF
         mrhUs6OeZUg1YVHfGEh+ewDU8juNk0jvabviSqHA9Y4lxNQaEHNQxmaPD397vsdOUAnj
         tElcEVYnSG4bypQE8ia6eV8nBg3cZ8zc8lTyh9muVh5Gx2ma9r/4OOHXcvyVLOJzh3eA
         586GgAekJYSTW8DYObL/OGA7XTPD197/V68SEqIZe1y/plvHaRhxxQ5k4FzaEtt+F5Ov
         NplA==
X-Gm-Message-State: APjAAAU8wGAxs3Dqo+6XwQ/HnMnA0+oVpGb+veQdTQ23rnZhJXMsOcuC
        7k6teZXazRkfkhuCd5fICiukqldkLyJTqz8tBDTYqzyP1bJ3gSgWXxPEHjOpWdqcUrtUhXAdY94
        TIcQvl9SDTFzZ
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr11643870ljo.153.1578939059214;
        Mon, 13 Jan 2020 10:10:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8F5Fw3Fm4UIbaPKFtvfTtJ8RQTMf/1exvwR2klH2wncSWwz9/Zxcf1luq4nkm6SHfjTYI3g==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr11643848ljo.153.1578939058887;
        Mon, 13 Jan 2020 10:10:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v26sm6354933ljv.92.2020.01.13.10.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:10:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D32941804D6; Mon, 13 Jan 2020 19:10:56 +0100 (CET)
Subject: [PATCH bpf-next v2 2/2] xdp: Use bulking for non-map XDP_REDIRECT and
 consolidate code paths
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Date:   Mon, 13 Jan 2020 19:10:56 +0100
Message-ID: <157893905677.861394.8918679692049579682.stgit@toke.dk>
In-Reply-To: <157893905455.861394.14341695989510022302.stgit@toke.dk>
References: <157893905455.861394.14341695989510022302.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since the bulk queue used by XDP_REDIRECT now lives in struct net_device,
we can re-use the bulking for the non-map version of the bpf_redirect()
helper. This is a simple matter of having xdp_do_redirect_slow() queue the
frame on the bulk queue instead of sending it out with __bpf_tx_xdp().

Unfortunately we can't make the bpf_redirect() helper return an error if
the ifindex doesn't exit (as bpf_redirect_map() does), because we don't
have a reference to the network namespace of the ingress device at the time
the helper is called. So we have to leave it as-is and keep the device
lookup in xdp_do_redirect_slow().

Since this leaves less reason to have the non-map redirect code in a
separate function, so we get rid of the xdp_do_redirect_slow() function
entirely. This does lose us the tracepoint disambiguation, but fortunately
the xdp_redirect and xdp_redirect_map tracepoints use the same tracepoint
entry structures. This means both can contain a map index, so we can just
amend the tracepoint definitions so we always emit the xdp_redirect(_err)
tracepoints, but with the map ID only populated if a map is present. This
means we retire the xdp_redirect_map(_err) tracepoints entirely, but keep
the definitions around in case someone is still listening for them.

With this change, the performance of the xdp_redirect sample program goes
from 5Mpps to 8.4Mpps (a 68% increase).

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h        |   13 +++++-
 include/trace/events/xdp.h |  102 +++++++++++++++++++-------------------------
 kernel/bpf/devmap.c        |   31 +++++++++----
 net/core/filter.c          |   86 +++++++------------------------------
 4 files changed, 95 insertions(+), 137 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b14e51d56a82..25c050202536 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -962,7 +962,9 @@ struct sk_buff;
 
 struct bpf_dtab_netdev *__dev_map_lookup_elem(struct bpf_map *map, u32 key);
 struct bpf_dtab_netdev *__dev_map_hash_lookup_elem(struct bpf_map *map, u32 key);
-void __dev_map_flush(void);
+void __dev_flush(void);
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+		    struct net_device *dev_rx);
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
 		    struct net_device *dev_rx);
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
@@ -1071,13 +1073,20 @@ static inline struct net_device  *__dev_map_hash_lookup_elem(struct bpf_map *map
 	return NULL;
 }
 
-static inline void __dev_map_flush(void)
+static inline void __dev_flush(void)
 {
 }
 
 struct xdp_buff;
 struct bpf_dtab_netdev;
 
+static inline
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+		    struct net_device *dev_rx)
+{
+	return 0;
+}
+
 static inline
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
 		    struct net_device *dev_rx)
diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index 72bad13d4a3c..cf568a38f852 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -79,14 +79,27 @@ TRACE_EVENT(xdp_bulk_tx,
 		  __entry->sent, __entry->drops, __entry->err)
 );
 
+#ifndef __DEVMAP_OBJ_TYPE
+#define __DEVMAP_OBJ_TYPE
+struct _bpf_dtab_netdev {
+	struct net_device *dev;
+};
+#endif /* __DEVMAP_OBJ_TYPE */
+
+#define devmap_ifindex(tgt, map)				\
+	(((map->map_type == BPF_MAP_TYPE_DEVMAP ||	\
+		  map->map_type == BPF_MAP_TYPE_DEVMAP_HASH)) ? \
+	  ((struct _bpf_dtab_netdev *)tgt)->dev->ifindex : 0)
+
+
 DECLARE_EVENT_CLASS(xdp_redirect_template,
 
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
-		 int to_ifindex, int err,
-		 const struct bpf_map *map, u32 map_index),
+		 const void *tgt, int err,
+		 const struct bpf_map *map, u32 index),
 
-	TP_ARGS(dev, xdp, to_ifindex, err, map, map_index),
+	TP_ARGS(dev, xdp, tgt, err, map, index),
 
 	TP_STRUCT__entry(
 		__field(int, prog_id)
@@ -103,90 +116,65 @@ DECLARE_EVENT_CLASS(xdp_redirect_template,
 		__entry->act		= XDP_REDIRECT;
 		__entry->ifindex	= dev->ifindex;
 		__entry->err		= err;
-		__entry->to_ifindex	= to_ifindex;
+		__entry->to_ifindex	= map ? devmap_ifindex(tgt, map) :
+						index;
 		__entry->map_id		= map ? map->id : 0;
-		__entry->map_index	= map_index;
+		__entry->map_index	= map ? index : 0;
 	),
 
-	TP_printk("prog_id=%d action=%s ifindex=%d to_ifindex=%d err=%d",
+	TP_printk("prog_id=%d action=%s ifindex=%d to_ifindex=%d err=%d"
+		  " map_id=%d map_index=%d",
 		  __entry->prog_id,
 		  __print_symbolic(__entry->act, __XDP_ACT_SYM_TAB),
 		  __entry->ifindex, __entry->to_ifindex,
-		  __entry->err)
+		  __entry->err, __entry->map_id, __entry->map_index)
 );
 
 DEFINE_EVENT(xdp_redirect_template, xdp_redirect,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
-		 int to_ifindex, int err,
-		 const struct bpf_map *map, u32 map_index),
-	TP_ARGS(dev, xdp, to_ifindex, err, map, map_index)
+		 const void *tgt, int err,
+		 const struct bpf_map *map, u32 index),
+	TP_ARGS(dev, xdp, tgt, err, map, index)
 );
 
 DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
-		 int to_ifindex, int err,
-		 const struct bpf_map *map, u32 map_index),
-	TP_ARGS(dev, xdp, to_ifindex, err, map, map_index)
+		 const void *tgt, int err,
+		 const struct bpf_map *map, u32 index),
+	TP_ARGS(dev, xdp, tgt, err, map, index)
 );
 
 #define _trace_xdp_redirect(dev, xdp, to)		\
-	 trace_xdp_redirect(dev, xdp, to, 0, NULL, 0);
+	 trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to);
 
 #define _trace_xdp_redirect_err(dev, xdp, to, err)	\
-	 trace_xdp_redirect_err(dev, xdp, to, err, NULL, 0);
+	 trace_xdp_redirect_err(dev, xdp, NULL, err, NULL, to);
+
+#define _trace_xdp_redirect_map(dev, xdp, to, map, index)		\
+	 trace_xdp_redirect(dev, xdp, to, 0, map, index);
 
-DEFINE_EVENT_PRINT(xdp_redirect_template, xdp_redirect_map,
+#define _trace_xdp_redirect_map_err(dev, xdp, to, map, index, err)	\
+	 trace_xdp_redirect_err(dev, xdp, to, err, map, index);
+
+/* not used anymore, but kept around so as not to break old programs */
+DEFINE_EVENT(xdp_redirect_template, xdp_redirect_map,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
-		 int to_ifindex, int err,
-		 const struct bpf_map *map, u32 map_index),
-	TP_ARGS(dev, xdp, to_ifindex, err, map, map_index),
-	TP_printk("prog_id=%d action=%s ifindex=%d to_ifindex=%d err=%d"
-		  " map_id=%d map_index=%d",
-		  __entry->prog_id,
-		  __print_symbolic(__entry->act, __XDP_ACT_SYM_TAB),
-		  __entry->ifindex, __entry->to_ifindex,
-		  __entry->err,
-		  __entry->map_id, __entry->map_index)
+		 const void *tgt, int err,
+		 const struct bpf_map *map, u32 index),
+	TP_ARGS(dev, xdp, tgt, err, map, index)
 );
 
-DEFINE_EVENT_PRINT(xdp_redirect_template, xdp_redirect_map_err,
+DEFINE_EVENT(xdp_redirect_template, xdp_redirect_map_err,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
-		 int to_ifindex, int err,
-		 const struct bpf_map *map, u32 map_index),
-	TP_ARGS(dev, xdp, to_ifindex, err, map, map_index),
-	TP_printk("prog_id=%d action=%s ifindex=%d to_ifindex=%d err=%d"
-		  " map_id=%d map_index=%d",
-		  __entry->prog_id,
-		  __print_symbolic(__entry->act, __XDP_ACT_SYM_TAB),
-		  __entry->ifindex, __entry->to_ifindex,
-		  __entry->err,
-		  __entry->map_id, __entry->map_index)
+		 const void *tgt, int err,
+		 const struct bpf_map *map, u32 index),
+	TP_ARGS(dev, xdp, tgt, err, map, index)
 );
 
-#ifndef __DEVMAP_OBJ_TYPE
-#define __DEVMAP_OBJ_TYPE
-struct _bpf_dtab_netdev {
-	struct net_device *dev;
-};
-#endif /* __DEVMAP_OBJ_TYPE */
-
-#define devmap_ifindex(fwd, map)				\
-	((map->map_type == BPF_MAP_TYPE_DEVMAP ||		\
-	  map->map_type == BPF_MAP_TYPE_DEVMAP_HASH) ?		\
-	  ((struct _bpf_dtab_netdev *)fwd)->dev->ifindex : 0)
-
-#define _trace_xdp_redirect_map(dev, xdp, fwd, map, idx)		\
-	 trace_xdp_redirect_map(dev, xdp, devmap_ifindex(fwd, map),	\
-				0, map, idx)
-
-#define _trace_xdp_redirect_map_err(dev, xdp, fwd, map, idx, err)	\
-	 trace_xdp_redirect_map_err(dev, xdp, devmap_ifindex(fwd, map),	\
-				    err, map, idx)
-
 TRACE_EVENT(xdp_cpumap_kthread,
 
 	TP_PROTO(int map_id, unsigned int processed,  unsigned int drops,
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 030d125c3839..db32272c4f77 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -81,7 +81,7 @@ struct bpf_dtab {
 	u32 n_buckets;
 };
 
-static DEFINE_PER_CPU(struct list_head, dev_map_flush_list);
+static DEFINE_PER_CPU(struct list_head, dev_flush_list);
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
 
@@ -357,16 +357,16 @@ static int bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	goto out;
 }
 
-/* __dev_map_flush is called from xdp_do_flush_map() which _must_ be signaled
+/* __dev_flush is called from xdp_do_flush_map() which _must_ be signaled
  * from the driver before returning from its napi->poll() routine. The poll()
  * routine is called either from busy_poll context or net_rx_action signaled
  * from NET_RX_SOFTIRQ. Either way the poll routine must complete before the
  * net device can be torn down. On devmap tear down we ensure the flush list
  * is empty before completing to ensure all flush operations have completed.
  */
-void __dev_map_flush(void)
+void __dev_flush(void)
 {
-	struct list_head *flush_list = this_cpu_ptr(&dev_map_flush_list);
+	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
 	struct xdp_dev_bulk_queue *bq, *tmp;
 
 	rcu_read_lock();
@@ -398,7 +398,7 @@ static int bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		      struct net_device *dev_rx)
 
 {
-	struct list_head *flush_list = this_cpu_ptr(&dev_map_flush_list);
+	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
 	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
 
 	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
@@ -419,10 +419,9 @@ static int bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	return 0;
 }
 
-int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
-		    struct net_device *dev_rx)
+static inline int _xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+			       struct net_device *dev_rx)
 {
-	struct net_device *dev = dst->dev;
 	struct xdp_frame *xdpf;
 	int err;
 
@@ -440,6 +439,20 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
 	return bq_enqueue(dev, xdpf, dev_rx);
 }
 
+int dev_xdp_enqueue(struct net_device *dev, struct xdp_buff *xdp,
+		    struct net_device *dev_rx)
+{
+	return _xdp_enqueue(dev, xdp, dev_rx);
+}
+
+int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_buff *xdp,
+		    struct net_device *dev_rx)
+{
+	struct net_device *dev = dst->dev;
+
+	return _xdp_enqueue(dev, xdp, dev_rx);
+}
+
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 			     struct bpf_prog *xdp_prog)
 {
@@ -762,7 +775,7 @@ static int __init dev_map_init(void)
 	register_netdevice_notifier(&dev_map_notifier);
 
 	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(dev_map_flush_list, cpu));
+		INIT_LIST_HEAD(&per_cpu(dev_flush_list, cpu));
 	return 0;
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 42fd17c48c5f..f023f3a8f351 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3458,58 +3458,6 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-static int __bpf_tx_xdp(struct net_device *dev,
-			struct bpf_map *map,
-			struct xdp_buff *xdp,
-			u32 index)
-{
-	struct xdp_frame *xdpf;
-	int err, sent;
-
-	if (!dev->netdev_ops->ndo_xdp_xmit) {
-		return -EOPNOTSUPP;
-	}
-
-	err = xdp_ok_fwd_dev(dev, xdp->data_end - xdp->data);
-	if (unlikely(err))
-		return err;
-
-	xdpf = convert_to_xdp_frame(xdp);
-	if (unlikely(!xdpf))
-		return -EOVERFLOW;
-
-	sent = dev->netdev_ops->ndo_xdp_xmit(dev, 1, &xdpf, XDP_XMIT_FLUSH);
-	if (sent <= 0)
-		return sent;
-	return 0;
-}
-
-static noinline int
-xdp_do_redirect_slow(struct net_device *dev, struct xdp_buff *xdp,
-		     struct bpf_prog *xdp_prog, struct bpf_redirect_info *ri)
-{
-	struct net_device *fwd;
-	u32 index = ri->tgt_index;
-	int err;
-
-	fwd = dev_get_by_index_rcu(dev_net(dev), index);
-	ri->tgt_index = 0;
-	if (unlikely(!fwd)) {
-		err = -EINVAL;
-		goto err;
-	}
-
-	err = __bpf_tx_xdp(fwd, NULL, xdp, 0);
-	if (unlikely(err))
-		goto err;
-
-	_trace_xdp_redirect(dev, xdp_prog, index);
-	return 0;
-err:
-	_trace_xdp_redirect_err(dev, xdp_prog, index, err);
-	return err;
-}
-
 static int __bpf_tx_xdp_map(struct net_device *dev_rx, void *fwd,
 			    struct bpf_map *map, struct xdp_buff *xdp)
 {
@@ -3529,7 +3477,7 @@ static int __bpf_tx_xdp_map(struct net_device *dev_rx, void *fwd,
 
 void xdp_do_flush_map(void)
 {
-	__dev_map_flush();
+	__dev_flush();
 	__cpu_map_flush();
 	__xsk_map_flush();
 }
@@ -3568,10 +3516,11 @@ void bpf_clear_redirect_map(struct bpf_map *map)
 	}
 }
 
-static int xdp_do_redirect_map(struct net_device *dev, struct xdp_buff *xdp,
-			       struct bpf_prog *xdp_prog, struct bpf_map *map,
-			       struct bpf_redirect_info *ri)
+int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
+		    struct bpf_prog *xdp_prog)
 {
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_map *map = READ_ONCE(ri->map);
 	u32 index = ri->tgt_index;
 	void *fwd = ri->tgt_value;
 	int err;
@@ -3580,7 +3529,18 @@ static int xdp_do_redirect_map(struct net_device *dev, struct xdp_buff *xdp,
 	ri->tgt_value = NULL;
 	WRITE_ONCE(ri->map, NULL);
 
-	err = __bpf_tx_xdp_map(dev, fwd, map, xdp);
+	if (unlikely(!map)) {
+		fwd = dev_get_by_index_rcu(dev_net(dev), index);
+		if (unlikely(!fwd)) {
+			err = -EINVAL;
+			goto err;
+		}
+
+		err = dev_xdp_enqueue(fwd, xdp, dev);
+	} else {
+		err = __bpf_tx_xdp_map(dev, fwd, map, xdp);
+	}
+
 	if (unlikely(err))
 		goto err;
 
@@ -3590,18 +3550,6 @@ static int xdp_do_redirect_map(struct net_device *dev, struct xdp_buff *xdp,
 	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map, index, err);
 	return err;
 }
-
-int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
-		    struct bpf_prog *xdp_prog)
-{
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
-	struct bpf_map *map = READ_ONCE(ri->map);
-
-	if (likely(map))
-		return xdp_do_redirect_map(dev, xdp, xdp_prog, map, ri);
-
-	return xdp_do_redirect_slow(dev, xdp, xdp_prog, ri);
-}
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
 
 static int xdp_do_generic_redirect_map(struct net_device *dev,

