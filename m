Return-Path: <bpf+bounces-5885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144676270C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073C2281A3D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717526B68;
	Tue, 25 Jul 2023 22:52:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DB8BE1
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 22:52:36 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E64225
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 15:52:08 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563ab574cb5so1132607a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690325469; x=1690930269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zOfKpqjOastbFEpt+fyAh6q/7AUofpML+STl3gX9oJU=;
        b=Q6aSkFSUgZ9P0X08Wx+THwFc3/ggonwikyYhmMxg/nPU9SAveYcsQixCPx60gpOGpF
         ET2YGa67n80/e7v1StRYLGrzE1fOe7MHZKAvL2MqFy+GUzLSp3K+3jF4eo1iOjE4JhqI
         e1H2hX8XE+jPlr0dPBqheYJa27ySZkQ2lkkrqCzfG6T5yyHXeqebklIA/0kEFGMeCenY
         HZJuQi7krXwYk7iC5oEziJZBmfDptNzXy/LTGX0TfYm3DTuxXDWDdsClmS/Ugs2bbOQs
         LUs2TCmiQpfwOUMe1rLSkkhOmCP4PE/MLy+Im3SqxhK902h9r3LNZwxFJ/2qlvDe8ksW
         xlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690325469; x=1690930269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOfKpqjOastbFEpt+fyAh6q/7AUofpML+STl3gX9oJU=;
        b=PjxOgosoPujdgUpEXhawPK+HOyFriXCwN/8EomZ2U8hg5WVCpkEUc5DWs83Ss2ukxM
         6C3grulEWcGynytYpudpwOClLWHzg0HwS0WDRmo+qjBt0WeDlrhKVv0wMx1d7ZmSdmrj
         yvAmYySPRG8K33sDZT5ENGGE6OQgsa+8tmaBtPHH7L7W/8Jqf16ZZpwMYDeAGGGsib+4
         J19E6ms5hswemrrC2Sk36KFblxlzlp6E8Czd4OX/36FFhg7DZu8YG3z3ao3TCc0F512D
         5bhthTEDqgQjT6R8XF/KjFT6aqr2udElbS+RpfletyGCqEOeEsb27j3rCQcJPW9Ow/CM
         jJ9w==
X-Gm-Message-State: ABy/qLZlbbyDyHREslncDhN7hhPGMyQzR4dYq+N3WZE+oiI+nTU6+Gxw
	MbgqYMBqA7StNoLZPwLq3Ifk3PY=
X-Google-Smtp-Source: APBJJlE2j4max+SigB2QdD1LYbqpwdjYOabRZO+/ORgManMjbsUS6RaDrJZv4wwa4fs0oD8poEvCbag=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7b0f:0:b0:560:63a2:d39e with SMTP id
 w15-20020a637b0f000000b0056063a2d39emr2847pgc.0.1690324750889; Tue, 25 Jul
 2023 15:39:10 -0700 (PDT)
Date: Tue, 25 Jul 2023 15:39:09 -0700
In-Reply-To: <64c0369eadbd5_3fe1bc2940@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-3-sdf@google.com>
 <64c0369eadbd5_3fe1bc2940@willemb.c.googlers.com.notmuch>
Message-ID: <ZMBPDe+IhvTQnKQa@google.com>
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/25, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > This change actually defines the (initial) metadata layout
> > that should be used by AF_XDP userspace (xsk_tx_metadata).
> > The first field is flags which requests appropriate offloads,
> > followed by the offload-specific fields. The supported per-device
> > offloads are exported via netlink (new xsk-flags).
> > 
> > The offloads themselves are still implemented in a bit of a
> > framework-y fashion that's left from my initial kfunc attempt.
> > I'm introducing new xsk_tx_metadata_ops which drivers are
> > supposed to implement. The drivers are also supposed
> > to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
> > the right places. Since xsk_tx_metadata_{request,_complete}
> > are static inline, we don't incur any extra overhead doing
> > indirect calls.
> > 
> > The benefit of this scheme is as follows:
> > - keeps all metadata layout parsing away from driver code
> > - makes it easy to grep and see which drivers implement what
> > - don't need any extra flags to maintain to keep track of that
> >   offloads are implemented; if the callback is implemented - the offload
> >   is supported (used by netlink reporting code)
> > 
> > Two offloads are defined right now:
> > 1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset
> > 2. XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
> >    area upon completion (tx_timestamp field)
> > 
> > The offloads are also implemented for copy mode:
> > 1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
> >    might be useful as a reference implementation and for testing
> > 2. XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
> >    destructor (note I'm reusing hwtstamps to pass metadata pointer)
> > 
> > The struct is forward-compatible and can be extended in the future
> > by appending more fields.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  Documentation/netlink/specs/netdev.yaml | 19 ++++++++
> >  include/linux/netdevice.h               | 27 +++++++++++
> >  include/linux/skbuff.h                  |  5 ++-
> >  include/net/xdp_sock.h                  | 60 +++++++++++++++++++++++++
> >  include/net/xdp_sock_drv.h              | 13 ++++++
> >  include/uapi/linux/if_xdp.h             | 35 +++++++++++++++
> >  include/uapi/linux/netdev.h             | 15 +++++++
> >  net/core/netdev-genl.c                  | 12 ++++-
> >  net/xdp/xsk.c                           | 38 ++++++++++++++++
> >  net/xdp/xsk_queue.h                     |  2 +-
> >  tools/include/uapi/linux/if_xdp.h       | 50 ++++++++++++++++++---
> >  11 files changed, 268 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > index e41015310a6e..bf9c1cc32614 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -42,6 +42,19 @@ name: netdev
> >          doc:
> >            This feature informs if netdev implements non-linear XDP buffer
> >            support in ndo_xdp_xmit callback.
> > +  -
> > +    type: flags
> > +    name: xsk-flags
> > +    render-max: true
> > +    entries:
> > +      -
> > +        name: tx-timestamp
> > +        doc:
> > +          HW timestamping egress packets is supported by the driver.
> > +      -
> > +        name: tx-checksum
> > +        doc:
> > +          L3 checksum HW offload is supported by the driver.
> >  
> >  attribute-sets:
> >    -
> > @@ -68,6 +81,12 @@ name: netdev
> >          type: u32
> >          checks:
> >            min: 1
> > +      -
> > +        name: xsk-features
> > +        doc: Bitmask of enabled AF_XDP features.
> > +        type: u64
> > +        enum: xsk-flags
> > +        enum-as-flags: true
> >  
> >  operations:
> >    list:
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 11652e464f5d..8b40c80557aa 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1660,6 +1660,31 @@ struct xdp_metadata_ops {
> >  			       enum xdp_rss_hash_type *rss_type);
> >  };
> >  
> > +/*
> > + * This structure defines the AF_XDP TX metadata hooks for network devices.
> > + * The following hooks can be defined; unless noted otherwise, they are
> > + * optional and can be filled with a null pointer.
> > + *
> > + * int (*tmo_request_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame requested egress timestamp.
> > + *
> > + * int (*tmo_fill_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame, that had requested
> > + *     egress timestamp, received a completion. The hook needs to return
> > + *     the actual HW timestamp.
> > + *
> > + * int (*tmo_request_timestamp)(u16 csum_start, u16 csum_offset, void *priv)
> > + *     This function is called when AF_XDP frame requested HW checksum
> > + *     offload. csum_start indicates position where checksumming should start.
> > + *     csum_offset indicates position where checksum should be stored.
> > + *
> > + */
> > +struct xsk_tx_metadata_ops {
> > +	void	(*tmo_request_timestamp)(void *priv);
> > +	u64	(*tmo_fill_timestamp)(void *priv);
> > +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
> > +};
> > +
> >  /**
> >   * enum netdev_priv_flags - &struct net_device priv_flags
> >   *
> > @@ -1844,6 +1869,7 @@ enum netdev_ml_priv_type {
> >   *	@netdev_ops:	Includes several pointers to callbacks,
> >   *			if one wants to override the ndo_*() functions
> >   *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
> > + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
> >   *	@ethtool_ops:	Management operations
> >   *	@l3mdev_ops:	Layer 3 master device operations
> >   *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
> > @@ -2100,6 +2126,7 @@ struct net_device {
> >  	unsigned long long	priv_flags;
> >  	const struct net_device_ops *netdev_ops;
> >  	const struct xdp_metadata_ops *xdp_metadata_ops;
> > +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
> >  	int			ifindex;
> >  	unsigned short		gflags;
> >  	unsigned short		hard_header_len;
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index faaba050f843..5febc1a5131e 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -581,7 +581,10 @@ struct skb_shared_info {
> >  	/* Warning: this field is not always filled in (UFO)! */
> >  	unsigned short	gso_segs;
> >  	struct sk_buff	*frag_list;
> > -	struct skb_shared_hwtstamps hwtstamps;
> > +	union {
> > +		struct skb_shared_hwtstamps hwtstamps;
> > +		struct xsk_tx_metadata *xsk_meta;
> > +	};
> >  	unsigned int	gso_type;
> >  	u32		tskey;
> >  
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 467b9fb56827..288fa58c4665 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> >  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
> >  void __xsk_map_flush(void);
> >  
> > +/**
> > + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> > + *  and call appropriate xsk_tx_metadata_ops operation.
> > + *  @meta: pointer to AF_XDP metadata area
> > + *  @ops: pointer to struct xsk_tx_metadata_ops
> > + *  @priv: pointer to driver-private aread
> > + *
> > + *  This function should be called by the networking device when
> > + *  it prepares AF_XDP egress packet.
> > + */
> > +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
> > +					   const struct xsk_tx_metadata_ops *ops,
> > +					   void *priv)
> > +{
> > +	if (!meta)
> > +		return;
> > +
> > +	if (ops->tmo_request_timestamp)
> > +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> > +			ops->tmo_request_timestamp(priv);
> > +
> > +	if (ops->tmo_request_checksum)
> > +		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
> > +			ops->tmo_request_checksum(meta->csum_start, meta->csum_offset, priv);
> > +}
> > +
> > +/**
> > + *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at completion
> > + *  and call appropriate xsk_tx_metadata_ops operation.
> > + *  @meta: pointer to AF_XDP metadata area
> > + *  @ops: pointer to struct xsk_tx_metadata_ops
> > + *  @priv: pointer to driver-private aread
> > + *
> > + *  This function should be called by the networking device upon
> > + *  AF_XDP egress completion.
> > + */
> > +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata *meta,
> > +					    const struct xsk_tx_metadata_ops *ops,
> > +					    void *priv)
> > +{
> > +	if (!meta)
> > +		return;
> > +
> > +	if (ops->tmo_fill_timestamp)
> > +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> > +			meta->tx_timestamp = ops->tmo_fill_timestamp(priv);
> > +}
> > +
> >  #else
> >  
> >  static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
> > @@ -106,6 +154,18 @@ static inline void __xsk_map_flush(void)
> >  {
> >  }
> >  
> > +static inline void xsk_tx_metadata_request(struct xsk_tx_metadata *meta,
> > +					   const struct xsk_tx_metadata_ops *ops,
> > +					   void *priv)
> > +{
> > +}
> > +
> > +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata *meta,
> > +					    const struct xsk_tx_metadata_ops *ops,
> > +					    void *priv)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_XDP_SOCKETS */
> >  
> >  #endif /* _LINUX_XDP_SOCK_H */
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 1f6fc8c7a84c..e2558ac3e195 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -165,6 +165,14 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
> >  	return xp_raw_get_data(pool, addr);
> >  }
> >  
> > +static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> > +{
> > +	if (!pool->tx_metadata_len)
> > +		return NULL;
> > +
> > +	return xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
> > +}
> > +
> >  static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
> >  {
> >  	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
> > @@ -324,6 +332,11 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
> >  	return NULL;
> >  }
> >  
> > +static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> > +{
> > +	return NULL;
> > +}
> > +
> >  static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
> >  {
> >  }
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index b37b50102e1c..b9b1b2c4108a 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -106,6 +106,38 @@ struct xdp_options {
> >  #define XSK_UNALIGNED_BUF_ADDR_MASK \
> >  	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> >  
> > +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
> > + * field of struct xsk_tx_metadata.
> > + */
> > +#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
> > +
> > +/* Request transmit checksum offload. Checksum start position and offset
> > + * are communicated via csum_start and csum_offset fields of struct
> > + * xsk_tx_metadata.
> > + */
> > +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
> > +
> > +/* Force checksum calculation in software. Can be used for testing or
> > + * working around potential HW issues. This option causes performance
> > + * degradation and only works in XDP_COPY mode.
> > + */
> > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> > +
> > +struct xsk_tx_metadata {
> > +	__u32 flags;
> > +
> > +	/* XDP_TX_METADATA_CHECKSUM */
> > +
> > +	/* Offset from desc->addr where checksumming should start. */
> > +	__u16 csum_start;
> > +	/* Offset from csum_start where checksum should be stored. */
> > +	__u16 csum_offset;
> > +
> > +	/* XDP_TX_METADATA_TIMESTAMP */
> > +
> > +	__u64 tx_timestamp;
> > +};
> > +
> >  /* Rx/Tx descriptor */
> >  struct xdp_desc {
> >  	__u64 addr;
> > @@ -122,4 +154,7 @@ struct xdp_desc {
> >   */
> >  #define XDP_PKT_CONTD (1 << 0)
> >  
> > +/* TX packet carries valid metadata. */
> > +#define XDP_TX_METADATA (1 << 1)
> > +
> >  #endif /* _LINUX_IF_XDP_H */
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index bf71698a1e82..cf1e11c76339 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -37,11 +37,26 @@ enum netdev_xdp_act {
> >  	NETDEV_XDP_ACT_MASK = 127,
> >  };
> >  
> > +/**
> > + * enum netdev_xsk_flags
> > + * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
> > + *   by the driver.
> > + * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
> > + *   driver.
> > + */
> > +enum netdev_xsk_flags {
> > +	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
> > +	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
> > +
> > +	NETDEV_XSK_FLAGS_MASK = 3,
> > +};
> > +
> >  enum {
> >  	NETDEV_A_DEV_IFINDEX = 1,
> >  	NETDEV_A_DEV_PAD,
> >  	NETDEV_A_DEV_XDP_FEATURES,
> >  	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> > +	NETDEV_A_DEV_XSK_FEATURES,
> >  
> >  	__NETDEV_A_DEV_MAX,
> >  	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 65ef4867fc49..9e8c1f3caf36 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -12,15 +12,25 @@ static int
> >  netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> >  		   u32 portid, u32 seq, int flags, u32 cmd)
> >  {
> > +	u64 xsk_flags = 0;
> >  	void *hdr;
> >  
> >  	hdr = genlmsg_put(rsp, portid, seq, &netdev_nl_family, flags, cmd);
> >  	if (!hdr)
> >  		return -EMSGSIZE;
> >  
> > +	if (netdev->xsk_tx_metadata_ops) {
> > +		if (netdev->xsk_tx_metadata_ops->tmo_fill_timestamp)
> > +			xsk_flags |= NETDEV_XSK_FLAGS_TX_TIMESTAMP;
> > +		if (netdev->xsk_tx_metadata_ops->tmo_request_checksum)
> > +			xsk_flags |= NETDEV_XSK_FLAGS_TX_CHECKSUM;
> > +	}
> > +
> >  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
> >  	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_FEATURES,
> > -			      netdev->xdp_features, NETDEV_A_DEV_PAD)) {
> > +			      netdev->xdp_features, NETDEV_A_DEV_PAD) ||
> > +	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XSK_FEATURES,
> > +			      xsk_flags, NETDEV_A_DEV_PAD)) {
> >  		genlmsg_cancel(rsp, hdr);
> >  		return -EINVAL;
> >  	}
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 81106e4d6e0f..9a5c4e63898d 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -542,6 +542,15 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
> >  
> >  static void xsk_destruct_skb(struct sk_buff *skb)
> >  {
> > +	struct xsk_tx_metadata *meta = skb_shinfo(skb)->xsk_meta;
> > +
> > +	if (meta) {
> > +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP) {
> > +			/* sw completion timestamp, not a real one */
> > +			meta->tx_timestamp = ktime_get_tai_fast_ns();
> > +		}
> > +	}
> > +
> >  	xsk_cq_submit_locked(xdp_sk(skb->sk), xsk_get_num_desc(skb));
> >  	sock_wfree(skb);
> >  }
> > @@ -626,6 +635,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >  static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  				     struct xdp_desc *desc)
> >  {
> > +	struct xsk_tx_metadata *meta = NULL;
> >  	struct net_device *dev = xs->dev;
> >  	struct sk_buff *skb = xs->skb;
> >  	int err;
> > @@ -678,12 +688,40 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  
> >  			skb_add_rx_frag(skb, nr_frags, page, 0, len, 0);
> >  		}
> > +
> > +		if (desc->options & XDP_TX_METADATA) {
> > +			if (unlikely(xs->tx_metadata_len == 0)) {
> > +				err = -EINVAL;
> > +				goto free_err;
> > +			}
> > +
> > +			meta = buffer - xs->tx_metadata_len;
> > +
> > +			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {
> > +				if (unlikely(meta->csum_start + meta->csum_offset +
> > +					     sizeof(__sum16) > len)) {
> > +					err = -EINVAL;
> > +					goto free_err;
> > +				}
> > +
> > +				skb->csum_start = hr + meta->csum_start;
> > +				skb->csum_offset = meta->csum_offset;
> > +				skb->ip_summed = CHECKSUM_PARTIAL;
> > +
> > +				if (unlikely(meta->flags & XDP_TX_METADATA_CHECKSUM_SW)) {
> > +					err = skb_checksum_help(skb);
> > +					if (err)
> > +						goto free_err;
> > +				}
> > +			}
> > +		}
> >  	}
> >  
> >  	skb->dev = dev;
> >  	skb->priority = xs->sk.sk_priority;
> >  	skb->mark = xs->sk.sk_mark;
> >  	skb->destructor = xsk_destruct_skb;
> > +	skb_shinfo(skb)->xsk_meta = meta;
> >  	xsk_set_destructor_arg(skb);
> >  
> >  	return skb;
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index c74a1372bcb9..6f2d1621c992 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -137,7 +137,7 @@ static inline bool xskq_cons_read_addr_unchecked(struct xsk_queue *q, u64 *addr)
> >  
> >  static inline bool xp_unused_options_set(u32 options)
> >  {
> > -	return options & ~XDP_PKT_CONTD;
> > +	return options & ~(XDP_PKT_CONTD | XDP_TX_METADATA);
> >  }
> >  
> >  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
> > diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> > index 73a47da885dc..b9b1b2c4108a 100644
> > --- a/tools/include/uapi/linux/if_xdp.h
> > +++ b/tools/include/uapi/linux/if_xdp.h
> > @@ -26,11 +26,11 @@
> >   */
> >  #define XDP_USE_NEED_WAKEUP (1 << 3)
> >  /* By setting this option, userspace application indicates that it can
> > - * handle multiple descriptors per packet thus enabling xsk core to split
> > + * handle multiple descriptors per packet thus enabling AF_XDP to split
> >   * multi-buffer XDP frames into multiple Rx descriptors. Without this set
> > - * such frames will be dropped by xsk.
> > + * such frames will be dropped.
> >   */
> > -#define XDP_USE_SG     (1 << 4)
> > +#define XDP_USE_SG	(1 << 4)
> >  
> >  /* Flags for xsk_umem_config flags */
> >  #define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
> > @@ -69,6 +69,7 @@ struct xdp_mmap_offsets {
> >  #define XDP_UMEM_COMPLETION_RING	6
> >  #define XDP_STATISTICS			7
> >  #define XDP_OPTIONS			8
> > +#define XDP_TX_METADATA_LEN		9
> >  
> >  struct xdp_umem_reg {
> >  	__u64 addr; /* Start of packet data area */
> > @@ -105,6 +106,38 @@ struct xdp_options {
> >  #define XSK_UNALIGNED_BUF_ADDR_MASK \
> >  	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> >  
> > +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
> > + * field of struct xsk_tx_metadata.
> > + */
> > +#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
> > +
> > +/* Request transmit checksum offload. Checksum start position and offset
> > + * are communicated via csum_start and csum_offset fields of struct
> > + * xsk_tx_metadata.
> > + */
> > +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
> > +
> > +/* Force checksum calculation in software. Can be used for testing or
> > + * working around potential HW issues. This option causes performance
> > + * degradation and only works in XDP_COPY mode.
> > + */
> > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> 
> Not sure how useful this is, especially if only for copy mode.

Seems useful at least as a reference implementation? But I'm happy
to drop. It's used only in the tests for now. I was using it to
verify csum_offset/start field values.

> > +struct xsk_tx_metadata {
> > +	__u32 flags;
> > +
> > +	/* XDP_TX_METADATA_CHECKSUM */
> > +
> > +	/* Offset from desc->addr where checksumming should start. */
> > +	__u16 csum_start;
> > +	/* Offset from csum_start where checksum should be stored. */
> > +	__u16 csum_offset;
> > +
> > +	/* XDP_TX_METADATA_TIMESTAMP */
> > +
> > +	__u64 tx_timestamp;
> > +};
> 
> Is this structure easily extensible for future offloads,
> such as USO?

We can append more field. What do we need for USO? Something akin
to gso_size/gso_segs/gso_type ?

