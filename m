Return-Path: <bpf+bounces-44846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F19C8DB1
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1076285645
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1EF13BC26;
	Thu, 14 Nov 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUbS9SaC"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47A1C68F;
	Thu, 14 Nov 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597411; cv=none; b=SVXPWBHDT51bkIPN/vhJognScFLZF8w0ts35Q4GjIgtfVu9SF4Gvlv/pdm0UGWYXCpEXcwgbXfdD5ijFJVRw7qslvuMnC9Gsn2yJLMpLXD4yNgXO+ccI0OYVy4LrYe1xjlRi7HIjzdhqV/xKIrnpT/Y/EuQoU5eHCp93k1pPf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597411; c=relaxed/simple;
	bh=G9gHHmEIOJ8qOfsresv4aabOqWRAIqefGCSXzTHMTKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcXtWmQ487oOK/bu2BUoT6rLDnpSL8ft1yf9BongQLm+fUdQ+ykFgsT/Na65SqirpfdH1If3v1vYD2nEBVt09VsoV6F16uAo9IGXjjRh/9HdytOzuahpI7mHF7LgPMzLP1HLv4J/gCKynhXJBDgSnZ0Bhb9STwp1q5z6Jmk0fG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUbS9SaC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 95FCB13803A7;
	Thu, 14 Nov 2024 10:16:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 Nov 2024 10:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731597408; x=
	1731683808; bh=syqfXqZchG+aofxMgVvogPa0niH6iMJQAZU3h4ASgag=; b=a
	UbS9SaCU6Jz7ebwdNDz/scL+QjveZ4J5J4359OSD9bzyQ9q1BVlm87PDvJTIAOkY
	XV6uidByYev6SLUAG/CDUwfzQXdqpMLnJ9mCkjoyGSn3zRaWtVNzEWmxxz0pGMW8
	XF0dhUw6W3wKeQMBnISl7b9al/6jQwsZRvHuvUj+/xfTykNOqvA3YpKuCZ4HdzA/
	B9wDHaJpZXgQkxMCPfTJxfX7JQk1aToUkt8jzWN1Ku+HhnEa3kxT8NGrjINAbGHx
	yKE79gRMcRCSGJdVMyapH541jvUO+Ex6wf3itO6Tp3d9Z/mpv8aY5i2PqIZMfiT+
	kCsGDEXG5Ypftzea0K89Q==
X-ME-Sender: <xms:YBQ2Z05FsXnTwL1yc-jejLzoddmUGQmmBesv8t509wxukNK6qHT20w>
    <xme:YBQ2Z16ynORccopE6hMHcjMBvMAizs3aVc7pFdsQkVQl3-2-qdc2Vpm1X_ydEoKDB
    e7A8ewJFIOQWEg>
X-ME-Received: <xmr:YBQ2Zze-AAn8jkQsuTy9riR2-K2YLaCKUHDO2NXbrOS8e-jnxzPHKdW_W2_z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepgeehkeduvdeujedvtddvgfdtvdfgvedukedttdet
    veduvdekteevfedtveeujeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvkhhsrghnuggvrh
    drlhhosggrkhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvghmsegurghv
    vghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhkvgesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggr
    nhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsth
    grsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YBQ2Z5LTzdGU_vnB3KdMpDzvgAWRLVTjH08x488ffzkMRsVKdBS0aw>
    <xmx:YBQ2Z4IFlCN-7FmE7wbjCbzsWkk8DHIz1x4ha1IDDGc0hSf7K3Fppw>
    <xmx:YBQ2Z6zAt3N0cLdp1TJp5a46ytvhPYs4WX2284HI0mElxmWrKCE0EQ>
    <xmx:YBQ2Z8IihZX-5Nk3X4J3uViDvo6B_5PNrA0IHeEGdY4EyI2A5UH3ew>
    <xmx:YBQ2Z549KvndPdNI2egnNZueTt4AUbTfROMOJw3rpmwr2aOvpXrZzbK1>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:16:47 -0500 (EST)
Date: Thu, 14 Nov 2024 17:16:44 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/19] xdp: add generic
 xdp_build_skb_from_buff()
Message-ID: <ZzYUXPq_KtjpNffW@shredder>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241113152442.4000468-13-aleksander.lobakin@intel.com>
 <ZzYR2ZJ1mGRq12VL@shredder>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzYR2ZJ1mGRq12VL@shredder>

On Thu, Nov 14, 2024 at 05:06:06PM +0200, Ido Schimmel wrote:
> Looks good (no objections to the patch), but I have a question. See
> below.
> 
> On Wed, Nov 13, 2024 at 04:24:35PM +0100, Alexander Lobakin wrote:
> > The code which builds an skb from an &xdp_buff keeps multiplying itself
> > around the drivers with almost no changes. Let's try to stop that by
> > adding a generic function.
> > Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
> > using napi_build_skb() and make use of the available xdp_rxq pointer to
> > assign the Rx queue index. In case of PP-backed buffer, mark the skb to
> > be recycled, as every PP user's been switched to recycle skbs.
> > 
> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> > ---
> >  include/net/xdp.h |  1 +
> >  net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> > 
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 4c19042adf80..b0a25b7060ff 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
> >  void xdp_warn(const char *msg, const char *func, const int line);
> >  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
> >  
> > +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
> >  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
> >  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
> >  					   struct sk_buff *skb,
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index b1b426a9b146..3a9a3c14b080 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
> >  }
> >  EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
> >  
> > +/**
> > + * xdp_build_skb_from_buff - create an skb from an &xdp_buff
> > + * @xdp: &xdp_buff to convert to an skb
> > + *
> > + * Perform common operations to create a new skb to pass up the stack from
> > + * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
> > + * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
> > + * Rx queue index, protocol and update frags info.
> > + *
> > + * Return: new &sk_buff on success, %NULL on error.
> > + */
> > +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
> > +{
> > +	const struct xdp_rxq_info *rxq = xdp->rxq;
> > +	const struct skb_shared_info *sinfo;
> > +	struct sk_buff *skb;
> > +	u32 nr_frags = 0;
> > +	int metalen;
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp))) {
> > +		sinfo = xdp_get_shared_info_from_buff(xdp);
> > +		nr_frags = sinfo->nr_frags;
> > +	}
> > +
> > +	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> > +	if (unlikely(!skb))
> > +		return NULL;
> > +
> > +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > +	__skb_put(skb, xdp->data_end - xdp->data);
> > +
> > +	metalen = xdp->data - xdp->data_meta;
> > +	if (metalen > 0)
> > +		skb_metadata_set(skb, metalen);
> > +
> > +	if (is_page_pool_compiled_in() && rxq->mem.type == MEM_TYPE_PAGE_POOL)
> > +		skb_mark_for_recycle(skb);
> > +
> > +	skb_record_rx_queue(skb, rxq->queue_index);
> > +
> > +	if (unlikely(nr_frags)) {
> > +		u32 tsize;
> > +
> > +		tsize = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
> > +		xdp_update_skb_shared_info(skb, nr_frags,
> > +					   sinfo->xdp_frags_size, tsize,
> > +					   xdp_buff_is_frag_pfmemalloc(xdp));
> > +	}
> > +
> > +	skb->protocol = eth_type_trans(skb, rxq->dev);
> 
> The device we are working with has more ports (net devices) than Rx
> queues, so each queue can receive packets from different net devices.
> Currently, each Rx queue has its own NAPI instance and its own page
> pool. All the Rx NAPI instances are initialized using the same dummy net
> device which is allocated using alloc_netdev_dummy().
> 
> What are our options with regards to the XDP Rx queue info structure? As
> evident by this patch, it does not seem valid to register one such
> structure per Rx queue and pass the dummy net device. Would it be valid
> to register one such structure per port (net device) and pass zero for
> the queue index and NAPI ID?

Actually, this does not seem to be valid either as we need to associate
an XDP Rx queue info with the correct page pool :/

> 
> To be clear, I understand it is not a common use case.
> 
> Thanks
> 
> > +
> > +	return skb;
> > +}
> > +EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
> > +
> >  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
> >  					   struct sk_buff *skb,
> >  					   struct net_device *dev)
> > -- 
> > 2.47.0
> > 
> > 

