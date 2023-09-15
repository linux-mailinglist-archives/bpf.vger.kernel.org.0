Return-Path: <bpf+bounces-10154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6997A238A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C02D1C20F30
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE04125AD;
	Fri, 15 Sep 2023 16:25:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668F11CBB
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 16:25:25 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63A3AF
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:25:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1ff5b741cso21409675ad.2
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694795123; x=1695399923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caYAdF+ryD0kwA8cCjPq2MBqIrQhng50FRxXd+yI6AE=;
        b=GXNk0z9a10710owFngbneeEkT6VYfibOXMjuxc4GzpAZipUxffft/t1acKCnCuoApD
         PBN0Ltc9fEsw6RvocGvmCn+EWuGowRYpFMIrxAgpw3m0uu8nTVTQJObvhr42LamEujLM
         YKff4PCLclqnv3ihNByBF6wZyn2oKxB/tm9rI7+KiDlI34BEwNcON+Lc2w9iBXyxH5iG
         HwLDjwO3Z9W0TjxJ/Rt1Utc2N3j25gmbq6P4+oz3AN4Id4snK4fZh3Wvf+CLDf1Ut23M
         GwPsktrXQw1RqoHZBMvdQ5GjQk5/u14QQY3rusmVvsfPnPhNN/vI/Ml6J7C/TaWrEVAE
         BoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694795123; x=1695399923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caYAdF+ryD0kwA8cCjPq2MBqIrQhng50FRxXd+yI6AE=;
        b=vqCqw/D3SUR9VBL9wimltEBtAD2vvve4WhmUz9jBZpTzhcZAX6VJYU1WXhXaE+Lk4q
         OWcQ8uX8NXPb8Hpy8E6ckwi/nazxk1Fg+V4AI93h+JXMGF8AJXaX2oMQJTnug/NfWm+P
         /mqVMFF2OXxDGJUa1YrBU2s5p45kkw2c7tJINDnQYddCOUjXQZfki+sc8t5ylq245/MI
         gFCzvbafrcsYIhrw9jZAhGTqE1jQss8SzLYCejFPYrtyuqUoORcy6WP3gSjc991ym7SA
         iG9IcKalLqlonm74m5sBSdneWIy/cZ6pmJG8A0v8Tin7SRg7dsM8maJBJIAax6HiVnAM
         qw0A==
X-Gm-Message-State: AOJu0Yy/bQnarYg5vMrdI5RRndJlC7D6itNhpi7So1Ll5gtbwG+QeQVr
	2XfXkKyU5Af8bspvTS4q41RlZtm9e0Q5VHbhr/PMBQ==
X-Google-Smtp-Source: AGHT+IEKzV60ZnuywBb1gKHVgR9KDWDuvGDFHhBt5uTekInmTrCfUyNFnujdpvA7lvjBy7afBQLR+5vNV/D5OuNI9sQ=
X-Received: by 2002:a17:902:cecb:b0:1c2:82e:32de with SMTP id
 d11-20020a170902cecb00b001c2082e32demr3094430plg.0.1694795122958; Fri, 15 Sep
 2023 09:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com> <20230914210452.2588884-3-sdf@google.com>
 <87edj0dxzi.fsf@intel.com>
In-Reply-To: <87edj0dxzi.fsf@intel.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 15 Sep 2023 09:25:11 -0700
Message-ID: <CAKH8qBtQf9g8Ye7QZ5+s2j+srJEkBwy3GAXPwPaxVeoc056C_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/9] xsk: add TX timestamp and TX checksum
 offload support
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 6:30=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Hi,
>
> Stanislav Fomichev <sdf@google.com> writes:
>
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
> >  Documentation/netlink/specs/netdev.yaml | 20 +++++++
> >  include/linux/netdevice.h               | 27 +++++++++
> >  include/linux/skbuff.h                  | 14 ++++-
> >  include/net/xdp_sock.h                  | 80 +++++++++++++++++++++++++
> >  include/net/xdp_sock_drv.h              | 13 ++++
> >  include/net/xsk_buff_pool.h             |  6 ++
> >  include/uapi/linux/if_xdp.h             | 40 +++++++++++++
> >  include/uapi/linux/netdev.h             | 16 +++++
> >  net/core/netdev-genl.c                  | 12 +++-
> >  net/xdp/xsk.c                           | 39 ++++++++++++
> >  net/xdp/xsk_queue.h                     |  2 +-
> >  tools/include/uapi/linux/if_xdp.h       | 54 +++++++++++++++--
> >  tools/include/uapi/linux/netdev.h       | 15 +++++
> >  13 files changed, 330 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index 1c7284fd535b..9002b37b7676 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -42,6 +42,19 @@ name: netdev
> >          doc:
> >            This feature informs if netdev implements non-linear XDP buf=
fer
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
> > @@ -84,6 +103,7 @@ name: netdev
> >              - ifindex
> >              - xdp-features
> >              - xdp-zc-max-segs
> > +            - xsk-features
> >        dump:
> >          reply: *dev-all
> >      -
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
> > index 4174c4b82d13..444d35dcd690 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -566,6 +566,15 @@ struct ubuf_info_msgzc {
> >  int mm_account_pinned_pages(struct mmpin *mmp, size_t size);
> >  void mm_unaccount_pinned_pages(struct mmpin *mmp);
> >
> > +/* Preserve some data across TX submission and completion.
> > + *
> > + * Note, this state is stored in the driver. Extending the layout
> > + * might need some special care.
> > + */
> > +struct xsk_tx_metadata_compl {
> > +     __u64 *tx_timestamp;
> > +};
> > +
> >  /* This data is invariant across clones and lives at
> >   * the end of the header data, ie. at skb->end.
> >   */
> > @@ -578,7 +587,10 @@ struct skb_shared_info {
> >       /* Warning: this field is not always filled in (UFO)! */
> >       unsigned short  gso_segs;
> >       struct sk_buff  *frag_list;
> > -     struct skb_shared_hwtstamps hwtstamps;
> > +     union {
> > +             struct skb_shared_hwtstamps hwtstamps;
> > +             struct xsk_tx_metadata_compl xsk_meta;
> > +     };
> >       unsigned int    gso_type;
> >       u32             tskey;
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 10993a05d220..c438c614a8d0 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -90,6 +90,74 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_=
buff *xdp);
> >  int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
> >  void __xsk_map_flush(void);
> >
> > +/**
> > + *  xsk_tx_metadata_to_compl - Save enough relevant metadata informati=
on
> > + *  to perform tx completion in the future.
> > + *  @meta: pointer to AF_XDP metadata area
> > + *  @compl: pointer to output struct xsk_tx_metadata_to_compl
> > + *
> > + *  This function should be called by the networking device when
> > + *  it prepares AF_XDP egress packet. The value of @compl should be st=
ored
> > + *  and passed to xsk_tx_metadata_complete upon TX completion.
> > + */
> > +static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *me=
ta,
> > +                                         struct xsk_tx_metadata_compl =
*compl)
>
> One of my systems didn't have the config XDP_SOCKETS enabled, and found
> some issues:
>
> This function is not defined when XDP_SOCKETS is disabled, got a
> compilation error.
>
> > +{
> > +     if (!meta)
> > +             return;
> > +
> > +     if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
> > +             compl->tx_timestamp =3D &meta->completion.tx_timestamp;
> > +     else
> > +             compl->tx_timestamp =3D NULL;
> > +}
> > +
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
> > +                     ops->tmo_request_timestamp(priv);
> > +
> > +     if (ops->tmo_request_checksum)
> > +             if (meta->flags & XDP_TX_METADATA_CHECKSUM)
> > +                     ops->tmo_request_checksum(meta->csum_start, meta-=
>csum_offset, priv);
> > +}
> > +
> > +/**
> > + *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at completi=
on
> > + *  and call appropriate xsk_tx_metadata_ops operation.
> > + *  @compl: pointer to completion metadata produced from xsk_tx_metada=
ta_to_compl
> > + *  @ops: pointer to struct xsk_tx_metadata_ops
> > + *  @priv: pointer to driver-private aread
> > + *
> > + *  This function should be called by the networking device upon
> > + *  AF_XDP egress completion.
> > + */
> > +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_com=
pl *compl,
> > +                                         const struct xsk_tx_metadata_=
ops *ops,
> > +                                         void *priv)
> > +{
> > +     if (!compl)
> > +             return;
> > +
> > +     *compl->tx_timestamp =3D ops->tmo_fill_timestamp(priv);
> > +}
> > +
> >  #else
> >
> >  static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff=
 *xdp)
> > @@ -106,6 +174,18 @@ static inline void __xsk_map_flush(void)
> >  {
> >  }
> >
> > +static inline void xsk_tx_metadata_request(struct xsk_tx_metadata *met=
a,
> > +                                        const struct xsk_tx_metadata_o=
ps *ops,
> > +                                        void *priv)
> > +{
> > +}
> > +
> > +static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_com=
p *compl,
>
> typo here: should be 'struct xsk_tx_metadata_compl'.
>
> Just so you are aware of these (very) minor issues for the next version.
>
> I enabled XDP_SOCKETS and will take a better look.

Thank you, will take a look. There are a bunch of bot build errors
that look similar as well.

