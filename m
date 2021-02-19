Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5824431FB8A
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 16:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBSPA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 10:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBSPAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 10:00:20 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056EC06178A;
        Fri, 19 Feb 2021 06:59:37 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id v6so21989576ljh.9;
        Fri, 19 Feb 2021 06:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93MG3RPPxpEe+7lNka3rCgS8vELuHzRdkZIKmTfy5JA=;
        b=ErdbHchozmvvmljBR9wIOxjGM1MhuNDwNzMHhjOR17NOU5BwY3ZfTnIm3FXsUW/gP7
         aMJ2YRnKUHtCT8vMjFb0d5t5QDXKdonWv0uBNgkHwSrRh3hnl/HTqByMjHUn4Xs8nnhC
         6Ryh8cGnSssaoxwJj4UM3Pug3/O3NrPyu9u6b/vuyrJ71TurIfhITO9/8/jtDW94w9NW
         YCoHPjsCVV0arZfLzGEBE0NbHSPcRev9X4nAy1GGRzXD7cjDMNv71O5YBT1jjaiHqEvx
         RdHSV5lNUXVqm1eGrZoM6MPVmCsPm164lkP/m94TCr7uUFLD97uK/QSl4TYwNy3/HGl9
         E/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93MG3RPPxpEe+7lNka3rCgS8vELuHzRdkZIKmTfy5JA=;
        b=oAGt1R6cJPpmi2dWO4R3WqKKf3ivlPGdtp5FpN92dqPXR6DIsm6DBHQNBABBeRyhkW
         kBt3TpWl1PmUDJXAvuTtSrLdQvVEbkO5bRXgUorgQyw7wnWO8I7s7dC61so6/a/XjlQJ
         lcZE5L7q1u3p7c7FzFKvqth2ro0cJh6gu+tgX986qmU/DoxV3Oe45iAY4Lrz8BwR0ju9
         Q2zSkrJZLdduSwh9WumFuNvJh/u8eJ2r5XRICGs41Oz9+EDDg1q4jybFghzrbil2gtLW
         /nFicztQ2I/pON4oo4XVuC7/MFs++x979iha/S5WsY7DhVeHHzFs8RclbOPH7DazznVf
         lqWQ==
X-Gm-Message-State: AOAM530dYQgBZDEILl9uWEz6FYWwoPsUpgCHzdvmgQ6ZXcVYzm0YT4eA
        g+wha/ruamkQrHD+o3VLV1I=
X-Google-Smtp-Source: ABdhPJyXQLzKotfdZruCU1QHM11qsLzwRW+5b21/6TjqfQAAu+2nwHBCvhmtUVm5TTkg1EnthP/xNw==
X-Received: by 2002:a2e:5458:: with SMTP id y24mr5865082ljd.20.1613746775882;
        Fri, 19 Feb 2021 06:59:35 -0800 (PST)
Received: from btopel-mobl.ger.intel.com (c213-102-90-208.bredband.comhem.se. [213.102.90.208])
        by smtp.gmail.com with ESMTPSA id d9sm974092lfl.290.2021.02.19.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:59:34 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        maciej.fijalkowski@intel.com, hawk@kernel.org, toke@redhat.com,
        magnus.karlsson@intel.com, john.fastabend@gmail.com,
        kuba@kernel.org, davem@davemloft.net
Subject: [PATCH bpf-next 2/2] bpf, xdp: restructure redirect actions
Date:   Fri, 19 Feb 2021 15:59:22 +0100
Message-Id: <20210219145922.63655-3-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219145922.63655-1-bjorn.topel@gmail.com>
References: <20210219145922.63655-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

The XDP_REDIRECT implementations for maps and non-maps are fairly
similar, but obviously need to take different code paths depending on
if the target is using a map or not. Today, the redirect targets for
XDP either uses a map, or is based on ifindex.

Here, an explicit redirect type is added to bpf_redirect_info, instead
of the actual map. Redirect type, map item/ifindex, and the map_id (if
any) is passed to xdp_do_redirect().

In addition to making the code easier to follow, using an explicit
type in bpf_redirect_info has a slight positive performance impact by
avoiding a pointer indirection for the map type lookup, and instead
use the cacheline for bpf_redirect_info.

Since the actual map is not passed via bpf_redirect_info anymore, the
map lookup is only done in the BPF helper. This means that the
bpf_clear_redirect_map() function can be removed. The actual map item
is RCU protected.

The bpf_redirect_info flags member is not used by XDP, and not
read/written any more. The map member is only written to when
required/used, and not unconditionally.

rfc->v1: Use map_id, and remove bpf_clear_redirect_map(). (Toke)

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 include/linux/filter.h     |  11 ++-
 include/trace/events/xdp.h |  66 +++++++++------
 kernel/bpf/cpumap.c        |   1 -
 kernel/bpf/devmap.c        |   1 -
 net/core/filter.c          | 162 ++++++++++++++++---------------------
 net/xdp/xskmap.c           |   1 -
 6 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1dedcf66b694..1f3cf2a1e116 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -646,11 +646,20 @@ struct bpf_redirect_info {
 	u32 flags;
 	u32 tgt_index;
 	void *tgt_value;
-	struct bpf_map *map;
+	u32 map_id;
+	u32 tgt_type;
 	u32 kern_flags;
 	struct bpf_nh_params nh;
 };
 
+enum xdp_redirect_type {
+	XDP_REDIR_UNSET,
+	XDP_REDIR_DEV_IFINDEX,
+	XDP_REDIR_DEV_MAP,
+	XDP_REDIR_CPU_MAP,
+	XDP_REDIR_XSK_MAP,
+};
+
 DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
 
 /* flags for bpf_redirect_info kern_flags */
diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index 76a97176ab81..538321735447 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -86,19 +86,15 @@ struct _bpf_dtab_netdev {
 };
 #endif /* __DEVMAP_OBJ_TYPE */
 
-#define devmap_ifindex(tgt, map)				\
-	(((map->map_type == BPF_MAP_TYPE_DEVMAP ||	\
-		  map->map_type == BPF_MAP_TYPE_DEVMAP_HASH)) ? \
-	  ((struct _bpf_dtab_netdev *)tgt)->dev->ifindex : 0)
-
 DECLARE_EVENT_CLASS(xdp_redirect_template,
 
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
 		 const void *tgt, int err,
-		 const struct bpf_map *map, u32 index),
+		 enum xdp_redirect_type type,
+		 const struct bpf_redirect_info *ri),
 
-	TP_ARGS(dev, xdp, tgt, err, map, index),
+	TP_ARGS(dev, xdp, tgt, err, type, ri),
 
 	TP_STRUCT__entry(
 		__field(int, prog_id)
@@ -111,14 +107,30 @@ DECLARE_EVENT_CLASS(xdp_redirect_template,
 	),
 
 	TP_fast_assign(
+		u32 ifindex = 0, map_id = 0, index = ri->tgt_index;
+
+		switch (type) {
+		case XDP_REDIR_DEV_MAP:
+			ifindex = ((struct _bpf_dtab_netdev *)tgt)->dev->ifindex;
+			fallthrough;
+		case XDP_REDIR_CPU_MAP:
+		case XDP_REDIR_XSK_MAP:
+			map_id = ri->map_id;
+			break;
+		case XDP_REDIR_DEV_IFINDEX:
+			ifindex = (u32)(long)tgt;
+			break;
+		default:
+			break;
+		}
+
 		__entry->prog_id	= xdp->aux->id;
 		__entry->act		= XDP_REDIRECT;
 		__entry->ifindex	= dev->ifindex;
 		__entry->err		= err;
-		__entry->to_ifindex	= map ? devmap_ifindex(tgt, map) :
-						index;
-		__entry->map_id		= map ? map->id : 0;
-		__entry->map_index	= map ? index : 0;
+		__entry->to_ifindex	= ifindex;
+		__entry->map_id		= map_id;
+		__entry->map_index	= index;
 	),
 
 	TP_printk("prog_id=%d action=%s ifindex=%d to_ifindex=%d err=%d"
@@ -133,45 +145,49 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
 		 const void *tgt, int err,
-		 const struct bpf_map *map, u32 index),
-	TP_ARGS(dev, xdp, tgt, err, map, index)
+		 enum xdp_redirect_type type,
+		 const struct bpf_redirect_info *ri),
+	TP_ARGS(dev, xdp, tgt, err, type, ri)
 );
 
 DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
 		 const void *tgt, int err,
-		 const struct bpf_map *map, u32 index),
-	TP_ARGS(dev, xdp, tgt, err, map, index)
+		 enum xdp_redirect_type type,
+		 const struct bpf_redirect_info *ri),
+	TP_ARGS(dev, xdp, tgt, err, type, ri)
 );
 
 #define _trace_xdp_redirect(dev, xdp, to)				\
-	 trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to)
+	trace_xdp_redirect(dev, xdp, NULL, 0, XDP_REDIR_DEV_IFINDEX, NULL)
 
 #define _trace_xdp_redirect_err(dev, xdp, to, err)			\
-	 trace_xdp_redirect_err(dev, xdp, NULL, err, NULL, to)
+	trace_xdp_redirect_err(dev, xdp, NULL, err, XDP_REDIR_DEV_IFINDEX, NULL)
 
-#define _trace_xdp_redirect_map(dev, xdp, to, map, index)		\
-	 trace_xdp_redirect(dev, xdp, to, 0, map, index)
+#define _trace_xdp_redirect_map(dev, xdp, to, type, ri)		\
+	trace_xdp_redirect(dev, xdp, to, 0, type, ri)
 
-#define _trace_xdp_redirect_map_err(dev, xdp, to, map, index, err)	\
-	 trace_xdp_redirect_err(dev, xdp, to, err, map, index)
+#define _trace_xdp_redirect_map_err(dev, xdp, to, type, ri, err)	\
+	trace_xdp_redirect_err(dev, xdp, to, err, type, ri)
 
 /* not used anymore, but kept around so as not to break old programs */
 DEFINE_EVENT(xdp_redirect_template, xdp_redirect_map,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
 		 const void *tgt, int err,
-		 const struct bpf_map *map, u32 index),
-	TP_ARGS(dev, xdp, tgt, err, map, index)
+		 enum xdp_redirect_type type,
+		 const struct bpf_redirect_info *ri),
+	TP_ARGS(dev, xdp, tgt, err, type, ri)
 );
 
 DEFINE_EVENT(xdp_redirect_template, xdp_redirect_map_err,
 	TP_PROTO(const struct net_device *dev,
 		 const struct bpf_prog *xdp,
 		 const void *tgt, int err,
-		 const struct bpf_map *map, u32 index),
-	TP_ARGS(dev, xdp, tgt, err, map, index)
+		 enum xdp_redirect_type type,
+		 const struct bpf_redirect_info *ri),
+	TP_ARGS(dev, xdp, tgt, err, type, ri)
 );
 
 TRACE_EVENT(xdp_cpumap_kthread,
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a4d2cb93cd69..b7f4d22f5c8d 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -543,7 +543,6 @@ static void cpu_map_free(struct bpf_map *map)
 	 * complete.
 	 */
 
-	bpf_clear_redirect_map(map);
 	synchronize_rcu();
 
 	/* For cpu_map the remote CPUs can still be using the entries
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 37ac4cde9713..b5681a98020d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -197,7 +197,6 @@ static void dev_map_free(struct bpf_map *map)
 	list_del_rcu(&dtab->list);
 	spin_unlock(&dev_map_lock);
 
-	bpf_clear_redirect_map(map);
 	synchronize_rcu();
 
 	/* Make sure prior __dev_map_entry_free() have completed. */
diff --git a/net/core/filter.c b/net/core/filter.c
index fd64d768e16a..56074b88d7e2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3919,23 +3919,6 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-static int __bpf_tx_xdp_map(struct net_device *dev_rx, void *fwd,
-			    struct bpf_map *map, struct xdp_buff *xdp)
-{
-	switch (map->map_type) {
-	case BPF_MAP_TYPE_DEVMAP:
-	case BPF_MAP_TYPE_DEVMAP_HASH:
-		return dev_map_enqueue(fwd, xdp, dev_rx);
-	case BPF_MAP_TYPE_CPUMAP:
-		return cpu_map_enqueue(fwd, xdp, dev_rx);
-	case BPF_MAP_TYPE_XSKMAP:
-		return __xsk_map_redirect(fwd, xdp);
-	default:
-		return -EBADRQC;
-	}
-	return 0;
-}
-
 void xdp_do_flush(void)
 {
 	__dev_flush();
@@ -3944,55 +3927,45 @@ void xdp_do_flush(void)
 }
 EXPORT_SYMBOL_GPL(xdp_do_flush);
 
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
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
-	struct bpf_map *map = READ_ONCE(ri->map);
-	u32 index = ri->tgt_index;
+	enum xdp_redirect_type type = ri->tgt_type;
 	void *fwd = ri->tgt_value;
 	int err;
 
-	ri->tgt_index = 0;
-	ri->tgt_value = NULL;
-	WRITE_ONCE(ri->map, NULL);
+	ri->tgt_type = XDP_REDIR_UNSET;
 
-	if (unlikely(!map)) {
-		fwd = dev_get_by_index_rcu(dev_net(dev), index);
+	switch (type) {
+	case XDP_REDIR_DEV_IFINDEX:
+		fwd = dev_get_by_index_rcu(dev_net(dev), (u32)(long)fwd);
 		if (unlikely(!fwd)) {
 			err = -EINVAL;
-			goto err;
+			break;
 		}
-
 		err = dev_xdp_enqueue(fwd, xdp, dev);
-	} else {
-		err = __bpf_tx_xdp_map(dev, fwd, map, xdp);
+		break;
+	case XDP_REDIR_DEV_MAP:
+		err = dev_map_enqueue(fwd, xdp, dev);
+		break;
+	case XDP_REDIR_CPU_MAP:
+		err = cpu_map_enqueue(fwd, xdp, dev);
+		break;
+	case XDP_REDIR_XSK_MAP:
+		err = __xsk_map_redirect(fwd, xdp);
+		break;
+	default:
+		err = -EBADRQC;
 	}
 
 	if (unlikely(err))
 		goto err;
 
-	_trace_xdp_redirect_map(dev, xdp_prog, fwd, map, index);
+	_trace_xdp_redirect_map(dev, xdp_prog, fwd, type, ri);
 	return 0;
 err:
-	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map, index, err);
+	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, type, ri, err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(xdp_do_redirect);
@@ -4001,41 +3974,40 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct xdp_buff *xdp,
 				       struct bpf_prog *xdp_prog,
-				       struct bpf_map *map)
+				       void *fwd,
+				       enum xdp_redirect_type type)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
-	u32 index = ri->tgt_index;
-	void *fwd = ri->tgt_value;
-	int err = 0;
-
-	ri->tgt_index = 0;
-	ri->tgt_value = NULL;
-	WRITE_ONCE(ri->map, NULL);
+	int err;
 
-	if (map->map_type == BPF_MAP_TYPE_DEVMAP ||
-	    map->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+	switch (type) {
+	case XDP_REDIR_DEV_MAP: {
 		struct bpf_dtab_netdev *dst = fwd;
 
 		err = dev_map_generic_redirect(dst, skb, xdp_prog);
 		if (unlikely(err))
 			goto err;
-	} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
+		break;
+	}
+	case XDP_REDIR_XSK_MAP: {
 		struct xdp_sock *xs = fwd;
 
 		err = xsk_generic_rcv(xs, xdp);
 		if (err)
 			goto err;
 		consume_skb(skb);
-	} else {
+		break;
+	}
+	default:
 		/* TODO: Handle BPF_MAP_TYPE_CPUMAP */
 		err = -EBADRQC;
 		goto err;
 	}
 
-	_trace_xdp_redirect_map(dev, xdp_prog, fwd, map, index);
+	_trace_xdp_redirect_map(dev, xdp_prog, fwd, type, ri);
 	return 0;
 err:
-	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map, index, err);
+	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, type, ri, err);
 	return err;
 }
 
@@ -4043,29 +4015,31 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
-	struct bpf_map *map = READ_ONCE(ri->map);
-	u32 index = ri->tgt_index;
-	struct net_device *fwd;
+	enum xdp_redirect_type type = ri->tgt_type;
+	void *fwd = ri->tgt_value;
 	int err = 0;
 
-	if (map)
-		return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog,
-						   map);
-	ri->tgt_index = 0;
-	fwd = dev_get_by_index_rcu(dev_net(dev), index);
-	if (unlikely(!fwd)) {
-		err = -EINVAL;
-		goto err;
-	}
+	ri->tgt_type = XDP_REDIR_UNSET;
+	ri->tgt_value = NULL;
 
-	err = xdp_ok_fwd_dev(fwd, skb->len);
-	if (unlikely(err))
-		goto err;
+	if (type == XDP_REDIR_DEV_IFINDEX) {
+		fwd = dev_get_by_index_rcu(dev_net(dev), (u32)(long)fwd);
+		if (unlikely(!fwd)) {
+			err = -EINVAL;
+			goto err;
+		}
 
-	skb->dev = fwd;
-	_trace_xdp_redirect(dev, xdp_prog, index);
-	generic_xdp_tx(skb, xdp_prog);
-	return 0;
+		err = xdp_ok_fwd_dev(fwd, skb->len);
+		if (unlikely(err))
+			goto err;
+
+		skb->dev = fwd;
+		_trace_xdp_redirect(dev, xdp_prog, index);
+		generic_xdp_tx(skb, xdp_prog);
+		return 0;
+	}
+
+	return xdp_do_generic_redirect_map(dev, skb, xdp, xdp_prog, fwd, type);
 err:
 	_trace_xdp_redirect_err(dev, xdp_prog, index, err);
 	return err;
@@ -4078,10 +4052,9 @@ BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 	if (unlikely(flags))
 		return XDP_ABORTED;
 
-	ri->flags = flags;
-	ri->tgt_index = ifindex;
-	ri->tgt_value = NULL;
-	WRITE_ONCE(ri->map, NULL);
+	ri->tgt_type = XDP_REDIR_DEV_IFINDEX;
+	ri->tgt_index = 0;
+	ri->tgt_value = (void *)(long)ifindex;
 
 	return XDP_REDIRECT;
 }
@@ -4096,7 +4069,8 @@ static const struct bpf_func_proto bpf_xdp_redirect_proto = {
 
 static __always_inline s64 __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifindex, u64 flags,
 						  void *lookup_elem(struct bpf_map *map,
-								    u32 key))
+								    u32 key),
+						  enum xdp_redirect_type type)
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 
@@ -4105,35 +4079,39 @@ static __always_inline s64 __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifind
 
 	ri->tgt_value = lookup_elem(map, ifindex);
 	if (unlikely(!ri->tgt_value)) {
-		WRITE_ONCE(ri->map, NULL);
+		ri->tgt_type = XDP_REDIR_UNSET;
 		return flags;
 	}
 
-	ri->flags = flags;
 	ri->tgt_index = ifindex;
-	WRITE_ONCE(ri->map, map);
+	ri->tgt_type = type;
+	ri->map_id = map->id;
 
 	return XDP_REDIRECT;
 }
 
 BPF_CALL_3(bpf_xdp_redirect_devmap, struct bpf_map *, map, u32, ifindex, u64, flags)
 {
-	return __bpf_xdp_redirect_map(map, ifindex, flags, __dev_map_lookup_elem);
+	return __bpf_xdp_redirect_map(map, ifindex, flags, __dev_map_lookup_elem,
+				      XDP_REDIR_DEV_MAP);
 }
 
 BPF_CALL_3(bpf_xdp_redirect_devmap_hash, struct bpf_map *, map, u32, ifindex, u64, flags)
 {
-	return __bpf_xdp_redirect_map(map, ifindex, flags, __dev_map_hash_lookup_elem);
+	return __bpf_xdp_redirect_map(map, ifindex, flags, __dev_map_hash_lookup_elem,
+				      XDP_REDIR_DEV_MAP);
 }
 
 BPF_CALL_3(bpf_xdp_redirect_cpumap, struct bpf_map *, map, u32, ifindex, u64, flags)
 {
-	return __bpf_xdp_redirect_map(map, ifindex, flags, __cpu_map_lookup_elem);
+	return __bpf_xdp_redirect_map(map, ifindex, flags, __cpu_map_lookup_elem,
+				      XDP_REDIR_CPU_MAP);
 }
 
 BPF_CALL_3(bpf_xdp_redirect_xskmap, struct bpf_map *, map, u32, ifindex, u64, flags)
 {
-	return __bpf_xdp_redirect_map(map, ifindex, flags, __xsk_map_lookup_elem);
+	return __bpf_xdp_redirect_map(map, ifindex, flags, __xsk_map_lookup_elem,
+				      XDP_REDIR_XSK_MAP);
 }
 
 bpf_func_proto_func get_xdp_redirect_func(enum bpf_map_type map_type)
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 113fd9017203..c285d3dd04ad 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -87,7 +87,6 @@ static void xsk_map_free(struct bpf_map *map)
 {
 	struct xsk_map *m = container_of(map, struct xsk_map, map);
 
-	bpf_clear_redirect_map(map);
 	synchronize_net();
 	bpf_map_area_free(m);
 }
-- 
2.27.0

