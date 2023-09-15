Return-Path: <bpf+bounces-10124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E87A12F5
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 03:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6A61C210DA
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C95A4A;
	Fri, 15 Sep 2023 01:30:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57AEA3C;
	Fri, 15 Sep 2023 01:30:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1892100;
	Thu, 14 Sep 2023 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694741426; x=1726277426;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vq59Wc9diWTW3drYjRR2KmcNzlARGJAYOni6nTlOm9k=;
  b=TeLntBbb7ZZSH+baoYh1CCMnJrZCHbc90KomRmQjHJVGe0js1EMVn87w
   cdrQacitpz2K5kny4+mYY6S1DtuQL+5uqbAVNkjQgpl7ouWjju3BnnEFi
   +IgV4j/kOVmezT8jYkgEE1a3Ucpfc5ouGcS1CbamTk9t3dku8cxfqMXyS
   y2RRkEeh385EIIOZD8NLsmVn8BFqRIz+5S4xf/WkbkdnVtbP5zdzlmHFl
   Bt2Xjx6EszTCME6kmood2Ne8PyyWHciooBJPMWWxf2VtJSrpJWZ3pDDRj
   j3WS8SFD0PxlYFdRtu81Lo76l+z33pV+7sAZffHrWMavKxxFWxvHH7/y/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359387085"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="359387085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 18:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="694542647"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="694542647"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.24.14.106])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 18:30:25 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org,
 willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org,
 yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v2 2/9] xsk: add TX timestamp and TX checksum
 offload support
In-Reply-To: <20230914210452.2588884-3-sdf@google.com>
References: <20230914210452.2588884-1-sdf@google.com>
 <20230914210452.2588884-3-sdf@google.com>
Date: Thu, 14 Sep 2023 18:30:25 -0700
Message-ID: <87edj0dxzi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Stanislav Fomichev <sdf@google.com> writes:

> This change actually defines the (initial) metadata layout
> that should be used by AF_XDP userspace (xsk_tx_metadata).
> The first field is flags which requests appropriate offloads,
> followed by the offload-specific fields. The supported per-device
> offloads are exported via netlink (new xsk-flags).
>
> The offloads themselves are still implemented in a bit of a
> framework-y fashion that's left from my initial kfunc attempt.
> I'm introducing new xsk_tx_metadata_ops which drivers are
> supposed to implement. The drivers are also supposed
> to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
> the right places. Since xsk_tx_metadata_{request,_complete}
> are static inline, we don't incur any extra overhead doing
> indirect calls.
>
> The benefit of this scheme is as follows:
> - keeps all metadata layout parsing away from driver code
> - makes it easy to grep and see which drivers implement what
> - don't need any extra flags to maintain to keep track of what
>   offloads are implemented; if the callback is implemented - the offload
>   is supported (used by netlink reporting code)
>
> Two offloads are defined right now:
> 1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset
> 2. XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
>    area upon completion (tx_timestamp field)
>
> The offloads are also implemented for copy mode:
> 1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
>    might be useful as a reference implementation and for testing
> 2. XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
>    destructor (note I'm reusing hwtstamps to pass metadata pointer)
>
> The struct is forward-compatible and can be extended in the future
> by appending more fields.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 20 +++++++
>  include/linux/netdevice.h               | 27 +++++++++
>  include/linux/skbuff.h                  | 14 ++++-
>  include/net/xdp_sock.h                  | 80 +++++++++++++++++++++++++
>  include/net/xdp_sock_drv.h              | 13 ++++
>  include/net/xsk_buff_pool.h             |  6 ++
>  include/uapi/linux/if_xdp.h             | 40 +++++++++++++
>  include/uapi/linux/netdev.h             | 16 +++++
>  net/core/netdev-genl.c                  | 12 +++-
>  net/xdp/xsk.c                           | 39 ++++++++++++
>  net/xdp/xsk_queue.h                     |  2 +-
>  tools/include/uapi/linux/if_xdp.h       | 54 +++++++++++++++--
>  tools/include/uapi/linux/netdev.h       | 15 +++++
>  13 files changed, 330 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 1c7284fd535b..9002b37b7676 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -42,6 +42,19 @@ name: netdev
>          doc:
>            This feature informs if netdev implements non-linear XDP buffer
>            support in ndo_xdp_xmit callback.
> +  -
> +    type: flags
> +    name: xsk-flags
> +    render-max: true
> +    entries:
> +      -
> +        name: tx-timestamp
> +        doc:
> +          HW timestamping egress packets is supported by the driver.
> +      -
> +        name: tx-checksum
> +        doc:
> +          L3 checksum HW offload is supported by the driver.
>  
>  attribute-sets:
>    -
> @@ -68,6 +81,12 @@ name: netdev
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: xsk-features
> +        doc: Bitmask of enabled AF_XDP features.
> +        type: u64
> +        enum: xsk-flags
> +        enum-as-flags: true
>  
>  operations:
>    list:
> @@ -84,6 +103,7 @@ name: netdev
>              - ifindex
>              - xdp-features
>              - xdp-zc-max-segs
> +            - xsk-features
>        dump:
>          reply: *dev-all
>      -
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0896aaa91dd7..3f02aaa30590 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1647,6 +1647,31 @@ struct net_device_ops {
>  						    struct netlink_ext_ack *extack);
>  };
>  
> +/*
> + * This structure defines the AF_XDP TX metadata hooks for network devices.
> + * The following hooks can be defined; unless noted otherwise, they are
> + * optional and can be filled with a null pointer.
> + *
> + * int (*tmo_request_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame requested egress timestamp.
> + *
> + * int (*tmo_fill_timestamp)(void *priv)
> + *     This function is called when AF_XDP frame, that had requested
> + *     egress timestamp, received a completion. The hook needs to return
> + *     the actual HW timestamp.
> + *
> + * int (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv)
> + *     This function is called when AF_XDP frame requested HW checksum
> + *     offload. csum_start indicates position where checksumming should start.
> + *     csum_offset indicates position where checksum should be stored.
> + *
> + */
> +struct xsk_tx_metadata_ops {
> +	void	(*tmo_request_timestamp)(void *priv);
> +	u64	(*tmo_fill_timestamp)(void *priv);
> +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
> +};
> +
>  /**
>   * enum netdev_priv_flags - &struct net_device priv_flags
>   *
> @@ -1835,6 +1860,7 @@ enum netdev_ml_priv_type {
>   *	@netdev_ops:	Includes several pointers to callbacks,
>   *			if one wants to override the ndo_*() functions
>   *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
> + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
>   *	@ethtool_ops:	Management operations
>   *	@l3mdev_ops:	Layer 3 master device operations
>   *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
> @@ -2091,6 +2117,7 @@ struct net_device {
>  	unsigned long long	priv_flags;
>  	const struct net_device_ops *netdev_ops;
>  	const struct xdp_metadata_ops *xdp_metadata_ops;
> +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
>  	int			ifindex;
>  	unsigned short		gflags;
>  	unsigned short		hard_header_len;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 4174c4b82d13..444d35dcd690 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -566,6 +566,15 @@ struct ubuf_info_msgzc {
>  int mm_account_pinned_pages(struct mmpin *mmp, size_t size);
>  void mm_unaccount_pinned_pages(struct mmpin *mmp);
>  
> +/* Preserve some data across TX submission and completion.
> + *
> + * Note, this state is stored in the driver. Extending the layout
> + * might need some special care.
> + */
> +struct xsk_tx_metadata_compl {
> +	__u64 *tx_timestamp;
> +};
> +
>  /* This data is invariant across clones and lives at
>   * the end of the header data, ie. at skb->end.
>   */
> @@ -578,7 +587,10 @@ struct skb_shared_info {
>  	/* Warning: this field is not always filled in (UFO)! */
>  	unsigned short	gso_segs;
>  	struct sk_buff	*frag_list;
> -	struct skb_shared_hwtstamps hwtstamps;
> +	union {
> +		struct skb_shared_hwtstamps hwtstamps;
> +		struct xsk_tx_metadata_compl xsk_meta;
> +	};
>  	unsigned int	gso_type;
>  	u32		tskey;
>  
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 10993a05d220..c438c614a8d0 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -90,6 +90,74 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
>  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
>  void __xsk_map_flush(void);
>  
> +/**
> + *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
> + *  to perform tx completion in the future.
> + *  @meta: pointer to AF_XDP metadata area
> + *  @compl: pointer to output struct xsk_tx_metadata_to_compl
> + *
> + *  This function should be called by the networking device when
> + *  it prepares AF_XDP egress packet. The value of @compl should be stored
> + *  and passed to xsk_tx_metadata_complete upon TX completion.
> + */
> +static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
> +					    struct xsk_tx_metadata_compl *compl)

One of my systems didn't have the config XDP_SOCKETS enabled, and found
some issues:

This function is not defined when XDP_SOCKETS is disabled, got a
compilation error.

> +{
> +	if (!meta)
> +		return;
> +
> +	if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> +		compl->tx_timestamp = &meta->completion.tx_timestamp;
> +	else
> +		compl->tx_timestamp = NULL;
> +}
> +
> +/**
> + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> + *  and call appropriate xsk_tx_metadata_ops operation.
> + *  @meta: pointer to AF_XDP metadata area
> + *  @ops: pointer to struct xsk_tx_metadata_ops
> + *  @priv: pointer to driver-private aread
> + *
> + *  This function should be called by the networking device when
> + *  it prepares AF_XDP egress packet.
> + */
> +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
> +					   const struct xsk_tx_metadata_ops *ops,
> +					   void *priv)
> +{
> +	if (!meta)
> +		return;
> +
> +	if (ops->tmo_request_timestamp)
> +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> +			ops->tmo_request_timestamp(priv);
> +
> +	if (ops->tmo_request_checksum)
> +		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
> +			ops->tmo_request_checksum(meta->csum_start, meta->csum_offset, priv);
> +}
> +
> +/**
> + *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at completion
> + *  and call appropriate xsk_tx_metadata_ops operation.
> + *  @compl: pointer to completion metadata produced from xsk_tx_metadata_to_compl
> + *  @ops: pointer to struct xsk_tx_metadata_ops
> + *  @priv: pointer to driver-private aread
> + *
> + *  This function should be called by the networking device upon
> + *  AF_XDP egress completion.
> + */
> +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
> +					    const struct xsk_tx_metadata_ops *ops,
> +					    void *priv)
> +{
> +	if (!compl)
> +		return;
> +
> +	*compl->tx_timestamp = ops->tmo_fill_timestamp(priv);
> +}
> +
>  #else
>  
>  static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
> @@ -106,6 +174,18 @@ static inline void __xsk_map_flush(void)
>  {
>  }
>  
> +static inline void xsk_tx_metadata_request(struct xsk_tx_metadata *meta,
> +					   const struct xsk_tx_metadata_ops *ops,
> +					   void *priv)
> +{
> +}
> +
> +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_comp *compl,

typo here: should be 'struct xsk_tx_metadata_compl'.

Just so you are aware of these (very) minor issues for the next version.

I enabled XDP_SOCKETS and will take a better look.


Cheers,
-- 
Vinicius

