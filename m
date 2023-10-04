Return-Path: <bpf+bounces-11391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE397B8709
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 19:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7D5EC281AA3
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBED1D54E;
	Wed,  4 Oct 2023 17:56:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135661D522
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 17:56:49 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871AA6
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 10:56:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a213b4d0efso323707b3.2
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696442207; x=1697047007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIQ2Katlof4TDab7QrURP6IZ0+Vgk7Aq+k0Yg3eqmJE=;
        b=v3UQU1XyKdjKb/Otzu5zTztweNhNJJv67VMkw6rpSTDhRM9WLKV/7px9ClNu0NAsD2
         M9gauErTeOiJ9cYH+A8qPNFGAq71q9NvuIW8yOhIvQXauyCOg9j5RnFJkXOAL3hoZMvh
         BRh9OoXpHp52kGb3rWAKVgjhqduJM856Szj2mnSIWcNNYd9yHT6C348VFcYf1dcj8VU2
         XA1GRpcatm+4lX31hYXPte6PIWVx4WMt3oB5LVC8qIC0Y5aiD/KuKI161HryzaCXHzxn
         B8pHiPX0y/UacD3mzmjtkI8rU0u4s1NRIJquscw4ZodcT01iTfJrgC0brcAd3n+qEApe
         Zcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696442207; x=1697047007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIQ2Katlof4TDab7QrURP6IZ0+Vgk7Aq+k0Yg3eqmJE=;
        b=fGwMc5y1ObkG89ujR9Rw5QE77+1FHQmbh0d14MZg5uQKa7Ue9h+yMf2Wzw19C0A11i
         1fTk/YH7jHEKR2b72KRbD1nUpnmTM2KyvU5giMi40E0uMmXI74ob4HQPzKJ/gB2k4jec
         +TrL5z/d5z8YaqLpP8G071ksixzkHx04plYmYJY82qjRLgJ84eX35BsZiCggBvsQWwc/
         z154yepNdM28rjS42svEli9Lb6c8aipAT4o8JGmBR2xaJRQN/3NWQs3BvBLY4SnCQ0cp
         ffqNTwc2ZPSkPXpA9k6BhP4zzi0JCkWLsHr1zoslTBbeVWXhoGkq30cQuBlXCYZ965OQ
         91aQ==
X-Gm-Message-State: AOJu0YwVwIe8hK60eSoqU5IAs/53JI/UYX0fv6VTaCnde9vjZqxmzr3k
	px8fFcfhXsCTqy2xLF79GS7OKM8=
X-Google-Smtp-Source: AGHT+IHYP+g9Ciya+5j2G08YCT7g3gYD49/Bu7SmwU/YsQAPf1FlQh0S7hNRUEg3sGRnY7R+m3zmHOY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ad0d:0:b0:58c:7cb1:10f with SMTP id
 l13-20020a81ad0d000000b0058c7cb1010fmr49363ywh.9.1696442206903; Wed, 04 Oct
 2023 10:56:46 -0700 (PDT)
Date: Wed, 4 Oct 2023 10:56:45 -0700
In-Reply-To: <ZR2lNjyyNZO4aQP0@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com> <20231003200522.1914523-3-sdf@google.com>
 <PH0PR11MB583036756C64ED287ECA2344D8CBA@PH0PR11MB5830.namprd11.prod.outlook.com>
 <ZR2lNjyyNZO4aQP0@google.com>
Message-ID: <ZR2nXWne86J7pYQw@google.com>
Subject: Re: [PATCH bpf-next v3 02/10] xsk: add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: yoong.siang.song@intel.com
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "toke@kernel.org" <toke@kernel.org>, 
	"willemb@google.com" <willemb@google.com>, "dsahern@kernel.org" <dsahern@kernel.org>, magnus.karlsson@intel.com, 
	"bjorn@kernel.org" <bjorn@kernel.org>, maciej.fijalkowski@intel.com, 
	"hawk@kernel.org" <hawk@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/04, Stanislav Fomichev wrote:
> On 10/04, Song, Yoong Siang wrote:
> > On Wednesday, October 4, 2023 4:05 AM Stanislav Fomichev <sdf@google.com> wrote:
> > >This change actually defines the (initial) metadata layout that should be used by
> > >AF_XDP userspace (xsk_tx_metadata).
> > >The first field is flags which requests appropriate offloads, followed by the offload-
> > >specific fields. The supported per-device offloads are exported via netlink (new
> > >xsk-flags).
> > >
> > >The offloads themselves are still implemented in a bit of a framework-y fashion
> > >that's left from my initial kfunc attempt.
> > >I'm introducing new xsk_tx_metadata_ops which drivers are supposed to
> > >implement. The drivers are also supposed to call
> > >xsk_tx_metadata_request/xsk_tx_metadata_complete in the right places. Since
> > >xsk_tx_metadata_{request,_complete}
> > >are static inline, we don't incur any extra overhead doing indirect calls.
> > >
> > >The benefit of this scheme is as follows:
> > >- keeps all metadata layout parsing away from driver code
> > >- makes it easy to grep and see which drivers implement what
> > >- don't need any extra flags to maintain to keep track of what
> > >  offloads are implemented; if the callback is implemented - the offload
> > >  is supported (used by netlink reporting code)
> > >
> > >Two offloads are defined right now:
> > >1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset 2.
> > >XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
> > >   area upon completion (tx_timestamp field)
> > >
> > >The offloads are also implemented for copy mode:
> > >1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
> > >   might be useful as a reference implementation and for testing 2.
> > >XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
> > >   destructor (note I'm reusing hwtstamps to pass metadata pointer)
> > >
> > >The struct is forward-compatible and can be extended in the future by appending
> > >more fields.
> > >
> > >Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > >---
> > > Documentation/netlink/specs/netdev.yaml | 19 ++++++
> > > include/linux/netdevice.h               | 27 +++++++++
> > > include/linux/skbuff.h                  | 14 ++++-
> > > include/net/xdp_sock.h                  | 80 +++++++++++++++++++++++++
> > > include/net/xdp_sock_drv.h              | 13 ++++
> > > include/net/xsk_buff_pool.h             |  6 ++
> > > include/uapi/linux/if_xdp.h             | 40 +++++++++++++
> > > include/uapi/linux/netdev.h             | 16 +++++
> > > net/core/netdev-genl.c                  | 12 +++-
> > > net/xdp/xsk.c                           | 39 ++++++++++++
> > > net/xdp/xsk_queue.h                     |  2 +-
> > > tools/include/uapi/linux/if_xdp.h       | 54 +++++++++++++++--
> > > tools/include/uapi/linux/netdev.h       | 16 +++++
> > > tools/net/ynl/generated/netdev-user.c   | 19 ++++++
> > > tools/net/ynl/generated/netdev-user.h   |  3 +
> > > 15 files changed, 352 insertions(+), 8 deletions(-)
> > >
> > >diff --git a/Documentation/netlink/specs/netdev.yaml
> > >b/Documentation/netlink/specs/netdev.yaml
> > >index c46fcc78fc04..3735c26c8646 100644
> > >--- a/Documentation/netlink/specs/netdev.yaml
> > >+++ b/Documentation/netlink/specs/netdev.yaml
> > >@@ -55,6 +55,19 @@ name: netdev
> > >         name: hash
> > >         doc:
> > >           Device is capable of exposing receive packet hash via
> > >bpf_xdp_metadata_rx_hash().
> > >+  -
> > >+    type: flags
> > >+    name: xsk-flags
> > >+    render-max: true
> > >+    entries:
> > >+      -
> > >+        name: tx-timestamp
> > >+        doc:
> > >+          HW timestamping egress packets is supported by the driver.
> > >+      -
> > >+        name: tx-checksum
> > >+        doc:
> > >+          L3 checksum HW offload is supported by the driver.
> > >
> > > attribute-sets:
> > >   -
> > >@@ -88,6 +101,11 @@ name: netdev
> > >         type: u64
> > >         enum: xdp-rx-metadata
> > >         enum-as-flags: true
> > >+      -
> > >+        name: xsk-features
> > >+        doc: Bitmask of enabled AF_XDP features.
> > >+        type: u64
> > >+        enum: xsk-flags
> > >
> > > operations:
> > >   list:
> > >@@ -105,6 +123,7 @@ name: netdev
> > >             - xdp-features
> > >             - xdp-zc-max-segs
> > >             - xdp-rx-metadata-features
> > >+            - xsk-features
> > >       dump:
> > >         reply: *dev-all
> > >     -
> > >diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h index
> > >7e520c14eb8c..0e1cb026cbe5 100644
> > >--- a/include/linux/netdevice.h
> > >+++ b/include/linux/netdevice.h
> > >@@ -1650,6 +1650,31 @@ struct net_device_ops {
> > > 						    struct netlink_ext_ack
> > >*extack);  };
> > >
> > >+/*
> > >+ * This structure defines the AF_XDP TX metadata hooks for network devices.
> > >+ * The following hooks can be defined; unless noted otherwise, they are
> > >+ * optional and can be filled with a null pointer.
> > >+ *
> > >+ * int (*tmo_request_timestamp)(void *priv)
> 
> [..]
>  
> > Should be "void" instead of "int"
> > 
> > >+ *     This function is called when AF_XDP frame requested egress timestamp.
> > >+ *
> > >+ * int (*tmo_fill_timestamp)(void *priv)
> > 
> > Should be "u64" instead of "int"
> > 
> > >+ *     This function is called when AF_XDP frame, that had requested
> > >+ *     egress timestamp, received a completion. The hook needs to return
> > >+ *     the actual HW timestamp.
> > >+ *
> > >+ * int (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv)
> > 
> > Should be "void" instead of "int"
> 
> Oh, good catch, will update these doc entries!
> 
> > >+ *     This function is called when AF_XDP frame requested HW checksum
> > >+ *     offload. csum_start indicates position where checksumming should start.
> > >+ *     csum_offset indicates position where checksum should be stored.
> > >+ *
> > >+ */
> > >+struct xsk_tx_metadata_ops {
> > >+	void	(*tmo_request_timestamp)(void *priv);
> > >+	u64	(*tmo_fill_timestamp)(void *priv);
> > >+	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void
> > >*priv);
> > >+};
> > >+
> > > /**
> > >  * enum netdev_priv_flags - &struct net_device priv_flags
> > >  *
> > >@@ -1838,6 +1863,7 @@ enum netdev_ml_priv_type {
> > >  *	@netdev_ops:	Includes several pointers to callbacks,
> > >  *			if one wants to override the ndo_*() functions
> > >  *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
> > >+ *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX
> > >metadata callbacks.
> > >  *	@ethtool_ops:	Management operations
> > >  *	@l3mdev_ops:	Layer 3 master device operations
> > >  *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
> > >@@ -2097,6 +2123,7 @@ struct net_device {
> > > 	unsigned long long	priv_flags;
> > > 	const struct net_device_ops *netdev_ops;
> > > 	const struct xdp_metadata_ops *xdp_metadata_ops;
> > >+	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
> > > 	int			ifindex;
> > > 	unsigned short		gflags;
> > > 	unsigned short		hard_header_len;
> > >diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h index
> > >4174c4b82d13..444d35dcd690 100644
> > >--- a/include/linux/skbuff.h
> > >+++ b/include/linux/skbuff.h
> > >@@ -566,6 +566,15 @@ struct ubuf_info_msgzc {  int
> > >mm_account_pinned_pages(struct mmpin *mmp, size_t size);  void
> > >mm_unaccount_pinned_pages(struct mmpin *mmp);
> > >
> > >+/* Preserve some data across TX submission and completion.
> > >+ *
> > >+ * Note, this state is stored in the driver. Extending the layout
> > >+ * might need some special care.
> > >+ */
> > >+struct xsk_tx_metadata_compl {
> > >+	__u64 *tx_timestamp;
> > >+};
> > >+
> > > /* This data is invariant across clones and lives at
> > >  * the end of the header data, ie. at skb->end.
> > >  */
> > >@@ -578,7 +587,10 @@ struct skb_shared_info {
> > > 	/* Warning: this field is not always filled in (UFO)! */
> > > 	unsigned short	gso_segs;
> > > 	struct sk_buff	*frag_list;
> > >-	struct skb_shared_hwtstamps hwtstamps;
> > >+	union {
> > >+		struct skb_shared_hwtstamps hwtstamps;
> > >+		struct xsk_tx_metadata_compl xsk_meta;
> > >+	};
> > > 	unsigned int	gso_type;
> > > 	u32		tskey;
> > >
> > >diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h index
> > >caa1f04106be..29427a69784d 100644
> > >--- a/include/net/xdp_sock.h
> > >+++ b/include/net/xdp_sock.h
> > >@@ -92,6 +92,74 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff
> > >*xdp);  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);  void
> > >__xsk_map_flush(void);
> > >
> > >+/**
> > >+ *  xsk_tx_metadata_to_compl - Save enough relevant metadata
> > >+information
> > >+ *  to perform tx completion in the future.
> > >+ *  @meta: pointer to AF_XDP metadata area
> > >+ *  @compl: pointer to output struct xsk_tx_metadata_to_compl
> > >+ *
> > >+ *  This function should be called by the networking device when
> > >+ *  it prepares AF_XDP egress packet. The value of @compl should be
> > >+stored
> > >+ *  and passed to xsk_tx_metadata_complete upon TX completion.
> > >+ */
> > >+static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
> > >+					    struct xsk_tx_metadata_compl
> > >*compl) {
> > >+	if (!meta)
> > >+		return;
> > >+
> > >+	if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> > >+		compl->tx_timestamp = &meta->completion.tx_timestamp;
> > >+	else
> > >+		compl->tx_timestamp = NULL;
> > >+}
> > >+
> > >+/**
> > >+ *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> > >+ *  and call appropriate xsk_tx_metadata_ops operation.
> > >+ *  @meta: pointer to AF_XDP metadata area
> > >+ *  @ops: pointer to struct xsk_tx_metadata_ops
> > >+ *  @priv: pointer to driver-private aread
> > >+ *
> > >+ *  This function should be called by the networking device when
> > >+ *  it prepares AF_XDP egress packet.
> > >+ */
> > >+static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
> > >+					   const struct xsk_tx_metadata_ops
> > >*ops,
> > >+					   void *priv)
> > >+{
> > >+	if (!meta)
> > >+		return;
> > >+
> > >+	if (ops->tmo_request_timestamp)
> > >+		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> > >+			ops->tmo_request_timestamp(priv);
> > >+
> > >+	if (ops->tmo_request_checksum)
> > >+		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
> > >+			ops->tmo_request_checksum(meta->csum_start, meta-
> > >>csum_offset,
> > >+priv); }
> > >+
> > >+/**
> > >+ *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at
> > >+completion
> > >+ *  and call appropriate xsk_tx_metadata_ops operation.
> > >+ *  @compl: pointer to completion metadata produced from
> > >+xsk_tx_metadata_to_compl
> > >+ *  @ops: pointer to struct xsk_tx_metadata_ops
> > >+ *  @priv: pointer to driver-private aread
> > >+ *
> > >+ *  This function should be called by the networking device upon
> > >+ *  AF_XDP egress completion.
> > >+ */
> > >+static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl
> > >*compl,
> > >+					    const struct xsk_tx_metadata_ops
> > >*ops,
> > >+					    void *priv)
> > >+{
> > >+	if (!compl)
> > >+		return;
> > >+
> > >+	*compl->tx_timestamp = ops->tmo_fill_timestamp(priv); }
> > >+
> > > #else
> > >
> > > static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp) @@ -
> > >108,6 +176,18 @@ static inline void __xsk_map_flush(void)  {  }
> > >
> > >+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata *meta,
> > >+					   const struct xsk_tx_metadata_ops
> > >*ops,
> > >+					   void *priv)
> > >+{
> > >+}
> > >+
> > >+static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl
> > >*compl,
> > >+					    const struct xsk_tx_metadata_ops
> > >*ops,
> > >+					    void *priv)
> > >+{
> > >+}
> > >+
> > > #endif /* CONFIG_XDP_SOCKETS */
> > >
> > > #endif /* _LINUX_XDP_SOCK_H */
> > >diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h index
> > >1f6fc8c7a84c..e2558ac3e195 100644
> > >--- a/include/net/xdp_sock_drv.h
> > >+++ b/include/net/xdp_sock_drv.h
> > >@@ -165,6 +165,14 @@ static inline void *xsk_buff_raw_get_data(struct
> > >xsk_buff_pool *pool, u64 addr)
> > > 	return xp_raw_get_data(pool, addr);
> > > }
> > >
> > >+static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct
> > >+xsk_buff_pool *pool, u64 addr) {
> > >+	if (!pool->tx_metadata_len)
> > >+		return NULL;
> > >+
> > >+	return xp_raw_get_data(pool, addr) - pool->tx_metadata_len; }
> > >+
> > > static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct
> > >xsk_buff_pool *pool)  {
> > > 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
> > >@@ -324,6 +332,11 @@ static inline void *xsk_buff_raw_get_data(struct
> > >xsk_buff_pool *pool, u64 addr)
> > > 	return NULL;
> > > }
> > >
> > >+static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct
> > >+xsk_buff_pool *pool, u64 addr) {
> > >+	return NULL;
> > >+}
> > >+
> > > static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct
> > >xsk_buff_pool *pool)  {  } diff --git a/include/net/xsk_buff_pool.h
> > >b/include/net/xsk_buff_pool.h index 1985ffaf9b0c..97f5cc10d79e 100644
> > >--- a/include/net/xsk_buff_pool.h
> > >+++ b/include/net/xsk_buff_pool.h
> > >@@ -33,6 +33,7 @@ struct xdp_buff_xsk {
> > > };
> > >
> > > #define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct
> > >xdp_buff_xsk, cb))
> > >+#define XSK_TX_COMPL_FITS(t) BUILD_BUG_ON(sizeof(struct
> > >+xsk_tx_metadata_compl) > sizeof(t))
> > >
> > > struct xsk_dma_map {
> > > 	dma_addr_t *dma_pages;
> > >@@ -234,4 +235,9 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb)
> > > 	return xskb->orig_addr + (offset <<
> > >XSK_UNALIGNED_BUF_OFFSET_SHIFT);  }
> > >
> > >+static inline bool xp_tx_metadata_enabled(const struct xsk_buff_pool
> > >+*pool) {
> > >+	return pool->tx_metadata_len > 0;
> > >+}
> > >+
> > > #endif /* XSK_BUFF_POOL_H_ */
> > >diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h index
> > >2ecf79282c26..ecfd67988283 100644
> > >--- a/include/uapi/linux/if_xdp.h
> > >+++ b/include/uapi/linux/if_xdp.h
> > >@@ -106,6 +106,43 @@ struct xdp_options {  #define
> > >XSK_UNALIGNED_BUF_ADDR_MASK \
> > > 	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> > >
> > >+/* Request transmit timestamp. Upon completion, put it into
> > >+tx_timestamp
> > >+ * field of struct xsk_tx_metadata.
> > >+ */
> > >+#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
> 
> [..]
> 
> > Suggestion from checkpatch.pl:
> > CHECK: Prefer using the BIT macro
> > 
> > >+
> > >+/* Request transmit checksum offload. Checksum start position and
> > >+offset
> > >+ * are communicated via csum_start and csum_offset fields of struct
> > >+ * xsk_tx_metadata.
> > >+ */
> > >+#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
> > 
> > Suggestion from checkpatch.pl:
> > CHECK: Prefer using the BIT macro
> > 
> > >+
> > >+/* Force checksum calculation in software. Can be used for testing or
> > >+ * working around potential HW issues. This option causes performance
> > >+ * degradation and only works in XDP_COPY mode.
> > >+ */
> > >+#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> > 
> > Suggestion from checkpatch.pl:
> > CHECK: Prefer using the BIT macro
> 
> Will do! Hopefully nothing breaks, let me check...

Yeah, looks like this part is not happy, doesn't look like BIT() is
exported to UAPI, per:

check for #defines like: 1 << <digit> that could be BIT(digit), it is not exported to uapi

So I'll revert to << like in the rest of this file.

