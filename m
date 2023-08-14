Return-Path: <bpf+bounces-7762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A113277BF87
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 20:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A638281184
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7DBCA6E;
	Mon, 14 Aug 2023 18:05:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCACA43
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 18:05:25 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAAB10F4
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 11:05:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-564ef63a010so3883196a12.0
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692036319; x=1692641119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dcp1L3zFcyKn19jEWG25mKgp7jPhJr/6G2z6GZ7IzE=;
        b=kW+7tt015gIa1gGv6tX0gGrCoYMR3vIoMhjrl7XxnFCl9FXqvzol5QlHy5+4s7N/60
         P6pm+44PRXnfxm2GXYF83OXQ1AXWGJe4hjKtcHH6vYxPdZbY5jMD+G4I3Ph/+/oldbpG
         TCOsthrVHEUVasQVrrfXuU+TrApVuSj6OrAgFw0Re5RZ+vaJ4g+lYBm4r8iEeaS+6Zjx
         TH2rvfsgfpisbyB/5vQvnvYqYwWYDSiW7S5fuPt/m1V2ITfj8QzX/CgZB5hEG8vZ6Luf
         uVtmFjQWjAe8CB3rpAfvaRgIDiYqpk+d6R0u7kJXYgDt3m1as0p8YxzbYFH8+Up9yyTW
         YrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036319; x=1692641119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dcp1L3zFcyKn19jEWG25mKgp7jPhJr/6G2z6GZ7IzE=;
        b=B53ESBVjrs/9UEyQS6RGTpSoXupWxS+ktgHKuLjBneVFcXw6UzRFJc/sIDo7iNQb4D
         ilTHtuWhK73CJIJh2NXZChzCy2vFMQW4MH7rWd+/xTlOmooejaTLkRRPUWpEV6kbpWcA
         GY7ovyaiPkSsI1cEi/VIZqZ41V5elYidvepLqcNnIT9XnHXlnhD/jrrIpi9gp2yNYoRL
         aGJkCE5vUD3q9S+E1OGtC7Qmzy70lQuc8L3803Qc1ShZfFK+d9kIZ3cYc3tMytmK/c0c
         vcHos8rsE0cdTNoC/hL5hRJMRPggdvtWERCGH4tXJvCWiZgOcHU4jyCqGfxEhz0zYfSm
         /lJA==
X-Gm-Message-State: AOJu0Yxjdpi4P421qh6xrplYx4sdN1lNNto8xL7MhiRIXweTLVRnM2V4
	8r1VZ3uQadR5BDhgtQMAgNsY0+VV319xkLEkCrNdEQ==
X-Google-Smtp-Source: AGHT+IF46j9NoeBt3K8/VwCQ0W4IZ1OTuPgGyxmjRtX/Zv8q51eju4jsQ8lvNiBtF4g+QBzLjU4ofRn9JBbi6pJDfgM=
X-Received: by 2002:a17:90b:388a:b0:26b:455b:8d61 with SMTP id
 mu10-20020a17090b388a00b0026b455b8d61mr7556655pjb.22.1692036318924; Mon, 14
 Aug 2023 11:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com> <20230809165418.2831456-3-sdf@google.com>
 <ZNoJenzKXW5QSR3E@boxer>
In-Reply-To: <ZNoJenzKXW5QSR3E@boxer>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 14 Aug 2023 11:05:07 -0700
Message-ID: <CAKH8qBvf+4YjdFOM6P62p3Z1eo0D92UNyBO2rKVCh1id35iMAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] xsk: add TX timestamp and TX checksum
 offload support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 4:01=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Aug 09, 2023 at 09:54:11AM -0700, Stanislav Fomichev wrote:
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
> > - don't need any extra flags to maintain to keep track of what
> >   offloads are implemented; if the callback is implemented - the offloa=
d
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
> >  Documentation/netlink/specs/netdev.yaml | 20 +++++++++
> >  include/linux/netdevice.h               | 27 +++++++++++
> >  include/linux/skbuff.h                  |  5 ++-
> >  include/net/xdp_sock.h                  | 60 +++++++++++++++++++++++++
> >  include/net/xdp_sock_drv.h              | 13 ++++++
> >  include/net/xsk_buff_pool.h             |  5 +++
> >  include/uapi/linux/if_xdp.h             | 35 +++++++++++++++
> >  include/uapi/linux/netdev.h             | 16 +++++++
> >  net/core/netdev-genl.c                  | 12 ++++-
> >  net/xdp/xsk.c                           | 41 +++++++++++++++++
> >  net/xdp/xsk_queue.h                     |  2 +-
> >  tools/include/uapi/linux/if_xdp.h       | 50 ++++++++++++++++++---
> >  tools/include/uapi/linux/netdev.h       | 15 +++++++
> >  13 files changed, 293 insertions(+), 8 deletions(-)
> >
>
> [...]
>
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 0896aaa91dd7..3f02aaa30590 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1647,6 +1647,31 @@ struct net_device_ops {
> >                                                   struct netlink_ext_ac=
k *extack);
> >  };
> >
> > +/*
> > + * This structure defines the AF_XDP TX metadata hooks for network dev=
ices.
> > + * The following hooks can be defined; unless noted otherwise, they ar=
e
> > + * optional and can be filled with a null pointer.
> > + *
> > + * int (*tmo_request_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame requested egress time=
stamp.
> > + *
> > + * int (*tmo_fill_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame, that had requested
> > + *     egress timestamp, received a completion. The hook needs to retu=
rn
> > + *     the actual HW timestamp.
> > + *
> > + * int (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *=
priv)
> > + *     This function is called when AF_XDP frame requested HW checksum
> > + *     offload. csum_start indicates position where checksumming shoul=
d start.
> > + *     csum_offset indicates position where checksum should be stored.
> > + *
> > + */
> > +struct xsk_tx_metadata_ops {
> > +     void    (*tmo_request_timestamp)(void *priv);
> > +     u64     (*tmo_fill_timestamp)(void *priv);
> > +     void    (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, =
void *priv);
> > +};
> > +
> >  /**
> >   * enum netdev_priv_flags - &struct net_device priv_flags
> >   *
> > @@ -1835,6 +1860,7 @@ enum netdev_ml_priv_type {
> >   *   @netdev_ops:    Includes several pointers to callbacks,
> >   *                   if one wants to override the ndo_*() functions
> >   *   @xdp_metadata_ops:      Includes pointers to XDP metadata callbac=
ks.
> > + *   @xsk_tx_metadata_ops:   Includes pointers to AF_XDP TX metadata c=
allbacks.
> >   *   @ethtool_ops:   Management operations
> >   *   @l3mdev_ops:    Layer 3 master device operations
> >   *   @ndisc_ops:     Includes callbacks for different IPv6 neighbour
> > @@ -2091,6 +2117,7 @@ struct net_device {
> >       unsigned long long      priv_flags;
> >       const struct net_device_ops *netdev_ops;
> >       const struct xdp_metadata_ops *xdp_metadata_ops;
> > +     const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
> >       int                     ifindex;
> >       unsigned short          gflags;
> >       unsigned short          hard_header_len;
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 16a49ba534e4..5d73d5df67fb 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -579,7 +579,10 @@ struct skb_shared_info {
> >       /* Warning: this field is not always filled in (UFO)! */
> >       unsigned short  gso_segs;
> >       struct sk_buff  *frag_list;
> > -     struct skb_shared_hwtstamps hwtstamps;
> > +     union {
> > +             struct skb_shared_hwtstamps hwtstamps;
> > +             struct xsk_tx_metadata *xsk_meta;
> > +     };
> >       unsigned int    gso_type;
> >       u32             tskey;
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 467b9fb56827..288fa58c4665 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -90,6 +90,54 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_=
buff *xdp);
> >  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
> >  void __xsk_map_flush(void);
> >
> > +/**
> > + *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submissio=
n
> > + *  and call appropriate xsk_tx_metadata_ops operation.
> > + *  @meta: pointer to AF_XDP metadata area
> > + *  @ops: pointer to struct xsk_tx_metadata_ops
> > + *  @priv: pointer to driver-private aread
> > + *
> > + *  This function should be called by the networking device when
> > + *  it prepares AF_XDP egress packet.
> > + */
> > +static inline void xsk_tx_metadata_request(const struct xsk_tx_metadat=
a *meta,
> > +                                        const struct xsk_tx_metadata_o=
ps *ops,
> > +                                        void *priv)
> > +{
> > +     if (!meta)
> > +             return;
> > +
> > +     if (ops->tmo_request_timestamp)
> > +             if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
>
> We should have a copy of flags or any other things that we read multiple
> times from metadata in order to avoid potential attacks from user space.
> An example of that is the fact that timestamp metadata handling is two
> step process, meaning to fill the timestamp you have to request it in the
> first place. If user space would set XDP_TX_METADATA_TIMESTAMP after
> sending but before completing we would crash the kernel potentially.
>
> We could also move the responsibility of handling that issue to driver
> programmers but IMHO that would be harder to implement, hence we think
> handling it in core would be better.

Hmm, very good point. I believe we only care about the timestamp
address for the completion, right? Not the rest of the metadata field.
So saving/passing that single pointer might be good enough..
For copy mode I think I can abuse skb_shared_info the same way I'm
adding new xsk_meta (IOW, store tx_timestamp ptr instead of overall
xsk_meta pointer).
For the native mode, not sure how we could implement that in the
generic fashion? Let me play with it and see if I can provide some
helpers for the drivers..

