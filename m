Return-Path: <bpf+bounces-4281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB874A25B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 18:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6848328139F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883BAD5D;
	Thu,  6 Jul 2023 16:40:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A3AD2F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:40:01 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB25173F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 09:39:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2657d405ad5so191949a91.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688661581; x=1691253581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFy2sjaEwaWlr8ZFbISMj3FN8c+npy3dEaCsuZ+EXi8=;
        b=Q08SZSmLnQT8bNfn4a7Jr+dSMyW4kVEHqfVTJR50XZZ6bNvmskh0vu72ia8LgZV+dU
         H0fQS4cPVGg0pLPVJg1A6o8ndN+k9FMnchZkqc4LCMXwLUtJKxoPSQWZLEUj/CR+WSY8
         ziu92xfwnWLdnt5sBBEQxq34an98jZhI2MwP+UBhN7xNfBNOzfWUJ/U2k8iqUK9iQEAX
         LFKYkZWRXgv4qdSGYDkCOdd/PZE/qrR6mRSSrkI6IOLsrPLs3d4c1AXWW3nnDfJD9vmu
         5BKArkME8wRvzUpIiXwlD0gYmS1+fA2NHAEzbm4EM7lXOAhZE/uF4WlWVEkceiv/n5xg
         JMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688661581; x=1691253581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFy2sjaEwaWlr8ZFbISMj3FN8c+npy3dEaCsuZ+EXi8=;
        b=V0ZE/RLo4CncVuP1mnJb5X4J4nQukuFtOVFWZxdvEiNZYFdr9niYwMtkbLwiyi/LV0
         pbBSmNS7u2TBfIqz0HtnNMlG5EktQrbosciiFiZdKwa7Imh8W7S+KLiDnyMC4+C2dHU/
         A8kWesj76xyHO75/dshGlKzfP6P6bzLJ3Y+7Zvx9RwtyesDTABKkafksDpX3ktbZ3l4g
         pwn45NIUry8vfz11viQPnlTF/hxDXQ8P3dzj4Rh4gYGb1bzBJXk1TEaygdKjOcFOTc8R
         N/ZqZmcglxLjAj700VhytCUoyHzmxwz6JLkS579R1JtTTVYm9dipKyFyRyW1olC2rr41
         oE4A==
X-Gm-Message-State: ABy/qLa5Yd+g1/EknOFDG5yM5JVPXElIUtzXFky4qZi0xJlTGaUjhnQ3
	uIBFL8yOPF9cW/PB+077H5+yIlE537pMYqw/p1v+Ug==
X-Google-Smtp-Source: APBJJlGxUyUS0b83U/yKCVVN4bkrkm2QxeNINcqDwjo2nBPGtJQYFu7VEBw7V7z1pmIAPuZ4MzTOhy9w4TRUTU7lcZo=
X-Received: by 2002:a17:90b:1e0f:b0:263:e804:3988 with SMTP id
 pg15-20020a17090b1e0f00b00263e8043988mr2342464pjb.1.1688661581507; Thu, 06
 Jul 2023 09:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-7-larysa.zaremba@intel.com> <ZKWo0BbpLfkZHbyE@google.com>
 <ZKbOQzj1jtDeaaMp@lincoln>
In-Reply-To: <ZKbOQzj1jtDeaaMp@lincoln>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 6 Jul 2023 09:39:29 -0700
Message-ID: <CAKH8qBvrSJF0HppJ9OVF5wRDP-qV6uVfkWBvPR9=-SpRoyvDJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/20] ice: Support HW timestamp hint
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 7:27=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> On Wed, Jul 05, 2023 at 10:30:56AM -0700, Stanislav Fomichev wrote:
> > On 07/03, Larysa Zaremba wrote:
> > > Use previously refactored code and create a function
> > > that allows XDP code to read HW timestamp.
> > >
> > > Also, move cached_phctime into packet context, this way this data sti=
ll
> > > stays in the ring structure, just at the different address.
> > >
> > > HW timestamp is the first supported hint in the driver,
> > > so also add xdp_metadata_ops.
> > >
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
> > >  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
> > >  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
> > >  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
> > >  drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +-
> > >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 24 +++++++++++++++++=
++
> > >  7 files changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ether=
net/intel/ice/ice.h
> > > index 4ba3d99439a0..7a973a2229f1 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > @@ -943,4 +943,6 @@ static inline void ice_clear_rdma_cap(struct ice_=
pf *pf)
> > >     set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
> > >     clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> > >  }
> > > +
> > > +extern const struct xdp_metadata_ops ice_xdp_md_ops;
> > >  #endif /* _ICE_H_ */
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/n=
et/ethernet/intel/ice/ice_ethtool.c
> > > index 8d5cbbd0b3d5..3c3b9cbfbcd3 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > @@ -2837,7 +2837,7 @@ ice_set_ringparam(struct net_device *netdev, st=
ruct ethtool_ringparam *ring,
> > >             /* clone ring and setup updated count */
> > >             rx_rings[i] =3D *vsi->rx_rings[i];
> > >             rx_rings[i].count =3D new_rx_cnt;
> > > -           rx_rings[i].cached_phctime =3D pf->ptp.cached_phc_time;
> > > +           rx_rings[i].pkt_ctx.cached_phctime =3D pf->ptp.cached_phc=
_time;
> > >             rx_rings[i].desc =3D NULL;
> > >             rx_rings[i].rx_buf =3D NULL;
> > >             /* this is to allow wr32 to have something to write to
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/e=
thernet/intel/ice/ice_lib.c
> > > index 00e3afd507a4..eb69b0ac7956 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > @@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *=
vsi)
> > >             ring->netdev =3D vsi->netdev;
> > >             ring->dev =3D dev;
> > >             ring->count =3D vsi->num_rx_desc;
> > > -           ring->cached_phctime =3D pf->ptp.cached_phc_time;
> > > +           ring->pkt_ctx.cached_phctime =3D pf->ptp.cached_phc_time;
> > >             WRITE_ONCE(vsi->rx_rings[i], ring);
> > >     }
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/=
ethernet/intel/ice/ice_main.c
> > > index 93979ab18bc1..f21996b812ea 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -3384,6 +3384,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
> > >
> > >     netdev->netdev_ops =3D &ice_netdev_ops;
> > >     netdev->udp_tunnel_nic_info =3D &pf->hw.udp_tunnel_nic;
> > > +   netdev->xdp_metadata_ops =3D &ice_xdp_md_ops;
> > >     ice_set_ethtool_ops(netdev);
> > >
> > >     if (vsi->type !=3D ICE_VSI_PF)
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/e=
thernet/intel/ice/ice_ptp.c
> > > index a31333972c68..70697e4829dd 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > @@ -1038,7 +1038,7 @@ static int ice_ptp_update_cached_phctime(struct=
 ice_pf *pf)
> > >             ice_for_each_rxq(vsi, j) {
> > >                     if (!vsi->rx_rings[j])
> > >                             continue;
> > > -                   WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, syst=
ime);
> > > +                   WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phcti=
me, systime);
> > >             }
> > >     }
> > >     clear_bit(ICE_CFG_BUSY, pf->state);
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/=
ethernet/intel/ice/ice_txrx.h
> > > index d0ab2c4c0c91..4237702a58a9 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > @@ -259,6 +259,7 @@ enum ice_rx_dtype {
> > >
> > >  struct ice_pkt_ctx {
> > >     const union ice_32b_rx_flex_desc *eop_desc;
> > > +   u64 cached_phctime;
> > >  };
> > >
> > >  struct ice_xdp_buff {
> > > @@ -354,7 +355,6 @@ struct ice_rx_ring {
> > >     struct ice_tx_ring *xdp_ring;
> > >     struct xsk_buff_pool *xsk_pool;
> > >     dma_addr_t dma;                 /* physical address of ring */
> > > -   u64 cached_phctime;
> > >     u16 rx_buf_len;
> > >     u8 dcb_tc;                      /* Traffic class of ring */
> > >     u8 ptp_rx;
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/=
net/ethernet/intel/ice/ice_txrx_lib.c
> > > index beb1c5bb392a..463d9e5cbe05 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > @@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp=
_ring, unsigned int xdp_res,
> > >                     spin_unlock(&xdp_ring->tx_lock);
> > >     }
> > >  }
> > > +
> > > +/**
> > > + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> > > + * @ctx: XDP buff pointer
> > > + * @ts_ns: destination address
> > > + *
> > > + * Copy HW timestamp (if available) to the destination address.
> > > + */
> > > +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> > > +{
> > > +   const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > > +   u64 cached_time;
> > > +
> > > +   cached_time =3D READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);
> >
> > I believe we have to have something like the following here:
> >
> > if (!ts_ns)
> >       return -EINVAL;
> >
> > IOW, I don't think verifier guarantees that those pointer args are
> > non-NULL.
>
> Oh, that's a shame.
>
> > Same for the other ice kfunc you're adding and veth changes.
> >
> > Can you also fix it for the existing veth kfuncs? (or lmk if you prefer=
 me
> > to fix it).
>
> I think I can send fixes for RX hash and timestamp in veth separately, be=
fore
> v3 of this patchset, code probably doesn't intersect.
>
> But argument checks in kfuncs are a little bit a gray area for me, whethe=
r they
> should be sent to stable tree or not?

Add a Fixes tag and they will get into the stable trees automatically I bel=
ieve?

