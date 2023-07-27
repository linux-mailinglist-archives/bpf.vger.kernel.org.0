Return-Path: <bpf+bounces-6091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC617658CE
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 18:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4511C21396
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559D8F6F;
	Thu, 27 Jul 2023 16:34:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188E2712A
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 16:34:43 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241A3582
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 09:34:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b107so11890927b3.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475672; x=1691080472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2wnygM7MIusbGo2m1Zs9M+OgJsgRaKyw0VCsBVXffw=;
        b=YqmXBdRAc8mjDcLYv0aS25cODDci8fkh5RBrh6hQQ1ZwxcTMmrS72sVT8hschN2YjD
         hhOUYWHn4+Cy1BzFHFwcr2YuwZef+EeDLbv6sN8Jc5LMvYCT4vcgKKdIRbl9ZcVtkV+C
         YJojX8U57xD8jgY4UcJEcqrjd+rnZTES1Ih1P1vV4txP3K6ranANB79Vzh6/kK46/qGk
         U2Wr1vVB7e2tyiDoPj2LOzcXQd7qVlrFlXDX6MNjClgD02G/pTtG9aZMnubAiRubJgvj
         KtQlbUlNp+ykrp+ZgFGH5/s79NQtjtSWyVLgvjvg8E6ecGtAs9ebYmGV5QNIVQ6xWoK9
         gvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475672; x=1691080472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2wnygM7MIusbGo2m1Zs9M+OgJsgRaKyw0VCsBVXffw=;
        b=gGv9dbfCa/Mws30N57YQo97h/+J4S/2ZL4rs5BAnsVlxV7lX1B87cyQDXXN4YOme5c
         a0NUf0ubO0L+KTWprpoKz2D3WNwTMPY/2Jh1PeCKnlzShf5T+5YRpoddQyK8wPan6KgW
         92Cc7yrUeYKfAluAdleofEJGhw96QGfkHIja05pE9Bj+sLikr57xZ0UPClSBunWgok4t
         6vc6lpYpc+TX+xYn8capcXwcdhaPIBjpNXthP1OXHd+18XugW1ncDtMjHheig3UPk3z6
         DxOsMCS/Y92gGv0+ZKiD59g8BtkahVPuJC4yNuSjoLaA8R5jdkxYbFlzn+v+5Zwxwdu1
         fcQg==
X-Gm-Message-State: ABy/qLZH/FgbUQmlcbuY3eKF5pR5FOhobM6BpovTEQQP7u3VHgOmthJl
	7jvbgNDfbZvEqvfm7fMeNV/dFSg=
X-Google-Smtp-Source: APBJJlERUQoE3E9Gg1Uz7deSmH9cWSH4/rFnKUo2C3gNiKyffPhqC5m4DHj1PXhNalpO8GaBC5dL5mw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b621:0:b0:56d:647:664b with SMTP id
 u33-20020a81b621000000b0056d0647664bmr48653ywh.5.1690475671890; Thu, 27 Jul
 2023 09:34:31 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:34:30 -0700
In-Reply-To: <cce9db50-8c9d-ea97-cb88-171fa46cc064@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com> <20230724235957.1953861-3-sdf@google.com>
 <383cc1ce-3c87-4b80-9e70-e0c10a7c1dcc@redhat.com> <ZMGPMIpeBsfs4/8L@google.com>
 <cce9db50-8c9d-ea97-cb88-171fa46cc064@redhat.com>
Message-ID: <ZMKclgdh4OVHEkJE@google.com>
Subject: Re: [xdp-hints] [RFC net-next v4 2/8] xsk: add TX timestamp and TX
 checksum offload support
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, 
	willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/27, Jesper Dangaard Brouer wrote:
> 
> 
> On 26/07/2023 23.25, Stanislav Fomichev wrote:
> > On 07/26, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 25/07/2023 01.59, Stanislav Fomichev wrote:
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index 11652e464f5d..8b40c80557aa 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -1660,6 +1660,31 @@ struct xdp_metadata_ops {
> > > >    			       enum xdp_rss_hash_type *rss_type);
> > > >    };
> > > > +/*
> > > > + * This structure defines the AF_XDP TX metadata hooks for network devices.
> > > > + * The following hooks can be defined; unless noted otherwise, they are
> > > > + * optional and can be filled with a null pointer.
> > > > + *
> > > > + * int (*tmo_request_timestamp)(void *priv)
> > > > + *     This function is called when AF_XDP frame requested egress timestamp.
> > > > + *
> > > > + * int (*tmo_fill_timestamp)(void *priv)
> > > > + *     This function is called when AF_XDP frame, that had requested
> > > > + *     egress timestamp, received a completion. The hook needs to return
> > > > + *     the actual HW timestamp.
> > > > + *
> > > > + * int (*tmo_request_timestamp)(u16 csum_start, u16 csum_offset, void *priv)
> > > > + *     This function is called when AF_XDP frame requested HW checksum
> > > > + *     offload. csum_start indicates position where checksumming should start.
> > > > + *     csum_offset indicates position where checksum should be stored.
> > > > + *
> > > > + */
> > > > +struct xsk_tx_metadata_ops {
> > > > +	void	(*tmo_request_timestamp)(void *priv);
> > > > +	u64	(*tmo_fill_timestamp)(void *priv);
> > > > +	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
> > > > +};
> > > > +
> > > >    /**
> > > >     * enum netdev_priv_flags - &struct net_device priv_flags
> > > >     *
> > > > @@ -1844,6 +1869,7 @@ enum netdev_ml_priv_type {
> > > >     *	@netdev_ops:	Includes several pointers to callbacks,
> > > >     *			if one wants to override the ndo_*() functions
> > > >     *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
> > > > + *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
> > > >     *	@ethtool_ops:	Management operations
> > > >     *	@l3mdev_ops:	Layer 3 master device operations
> > > >     *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
> > > > @@ -2100,6 +2126,7 @@ struct net_device {
> > > >    	unsigned long long	priv_flags;
> > > >    	const struct net_device_ops *netdev_ops;
> > > >    	const struct xdp_metadata_ops *xdp_metadata_ops;
> > > > +	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
> > > >    	int			ifindex;
> > > >    	unsigned short		gflags;
> > > >    	unsigned short		hard_header_len;
> > > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > index faaba050f843..5febc1a5131e 100644
> > > > --- a/include/linux/skbuff.h
> > > > +++ b/include/linux/skbuff.h
> > > > @@ -581,7 +581,10 @@ struct skb_shared_info {
> > > >    	/* Warning: this field is not always filled in (UFO)! */
> > > >    	unsigned short	gso_segs;
> > > >    	struct sk_buff	*frag_list;
> > > > -	struct skb_shared_hwtstamps hwtstamps;
> > > > +	union {
> > > > +		struct skb_shared_hwtstamps hwtstamps;
> > > > +		struct xsk_tx_metadata *xsk_meta;
> > > > +	};
> > > >    	unsigned int	gso_type;
> > > >    	u32		tskey;
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index 467b9fb56827..288fa58c4665 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> > > >    int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
> > > >    void __xsk_map_flush(void);
> > > > +/**
> > > > + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> > > > + *  and call appropriate xsk_tx_metadata_ops operation.
> > > > + *  @meta: pointer to AF_XDP metadata area
> > > > + *  @ops: pointer to struct xsk_tx_metadata_ops
> > > > + *  @priv: pointer to driver-private aread
> > > > + *
> > > > + *  This function should be called by the networking device when
> > > > + *  it prepares AF_XDP egress packet.
> > > > + */
> > > > +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
> > > > +					   const struct xsk_tx_metadata_ops *ops,
> > > > +					   void *priv)
> > > 
> > > (As you mentioned) this gets inlined in drivers for performance.
> > > 
> > > > +{
> > > > +	if (!meta)
> > > > +		return;
> > > > +
> > > > +	if (ops->tmo_request_timestamp)
> > > > +		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> > > > +			ops->tmo_request_timestamp(priv);
> > > 
> > > We still have the overhead of function pointer call.
> > > With RETPOLINE this is costly.
> > > 
> > > Measured on my testlab CPU E5-1650 v4 @ 3.60GHz
> > >   Type:function_call_cost:  3 cycles(tsc) 1.010 ns
> > >   Type:func_ptr_call_cost: 30 cycles(tsc) 8.341 ns
> > > 
> > > Given this get inlined in drivers, perhaps we can add some
> > > INDIRECT_CALL_1 macros to avoid these indirect calls?
> > 
> > I'm assuming that the compiler is smart enough to resolve these const
> > struct ops definitions as long as they are in the same file.
> > 
> > At least here is what I see for mlx5e_xmit_xdp_frame_mpwqe: those
> > indirect jumps are resolved and the calls themselves are unrolled.
> > TBF, I don't have retpolines enabled in the config, but I don't think
> > it will bring indirect jumps back? Am I missing anything?
> > 
> 
> I tried this with CONFIG_RETPOLINE and same results.
> The compiler is smart and inlines the call to mlx5e_xsk_request_checksum().
> This is great, no need for crazy INDIRECT_CALL_1 macros :-)

Perfect, thanks for checking!
 
> > 
> > 0000000000001930 <mlx5e_xmit_xdp_frame_mpwqe>:
> > ; mlx5e_xmit_xdp_frame_mpwqe():
> > ; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:436
> [...]
> > ; ./drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:381
> > ; 	stats->mpwqe++;
> >      1b4a: 49 ff 44 24 08               	incq	0x8(%r12)
> > ; ././include/net/xdp_sock.h:107
> 
> How do you get objdump to add these file:line annotations?
> 
> I use:
>  objdump -rS --visualize-jumps=color -Mintel | less -R

I use llvm tools (and complier), so I did:

llvm-objdump -r -S -l --disassemble xxx.o

Most likely it's that -l option? man objdump seems to have it..

