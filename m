Return-Path: <bpf+bounces-4621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE274DD1D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5571C20B14
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC514A84;
	Mon, 10 Jul 2023 18:12:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0114268
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:12:51 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F31E128
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:12:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666e87eff0eso8173704b3a.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689012769; x=1691604769;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0MeHDC/akvIf+bHXEWk4FVeiaTKOF3ffh6AweNKcpI=;
        b=ahQeQBONn8Ijr5YeGF7qQVB6ZL/aQt6jLWQZu6lmSzuppcyOE5Gtdb60XvKTrxl16F
         Watdm6/FVEeIK96oSIcpiev1hdeqpPfP5b/vfu0UnHiuX4eszX7Sl/RtL896qAkBnu9a
         bDNI80Wb8O9z0mKHAMaFM1pw19Pdo0Kya5THVSwNWzYqL7dZEpeqxcmgaVnY/5bt1a55
         jwCxz6WWHMZTo0zy4uPq4ZdgdUI+hSiH1CRieVh5PDwPC558sWLTWsWY/CgKGMPajcFF
         0zo+RFAGmH4hEbFXNfuVPmtE0BGzk6cHEhPLtg7gS5TggwLrq2rlB7Mz8PSz+jPSOCrk
         LjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012769; x=1691604769;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0MeHDC/akvIf+bHXEWk4FVeiaTKOF3ffh6AweNKcpI=;
        b=bfO5E1dWSUtSaORBySqBL2dBCErevUW41lutFdJOzwQUW/zqBSqBbBcYg063KPWV3j
         fz5XJJ20Ry9z+lQC2R9Rk3r32nyLpckS8jKYzmU4mcv3LYvNkojuCAvwH4V1L74QYjS8
         jodePd63pQKYFd3aF+WXNNm/Ag8tt/0D+bfII11Pr5bgwEvOABcTXedn9O3UxyCWKsl+
         H+dklIpisjTOsPj+Z//tunvZN3jljCQqHvxrdc3cfKuIpU+e6DDW2deZ0XTJauNKuYlw
         +2oB3n1NcMwE4OA41anlEVTedVVmDONSrdPtif7jK1JdSVcBd3yAOF2KBJS+8RO2kXXw
         BayQ==
X-Gm-Message-State: ABy/qLaZOaCgf8HRGs5Nz+Abm67hcDxLgvkeUdSXbbIjO0nZIToRlkRu
	X8y6QWVn5bgVJohZLTWlNbaVDJw=
X-Google-Smtp-Source: APBJJlHM8AaC3fpA2xtl3T/LBlw0vPcYGO+v+noqPk7LNK9RQbdOFxeJYJ42WCGA012qEHRA1toRMq8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:808:b0:682:5748:2e88 with SMTP id
 m8-20020a056a00080800b0068257482e88mr18147936pfk.0.1689012768691; Mon, 10 Jul
 2023 11:12:48 -0700 (PDT)
Date: Mon, 10 Jul 2023 11:12:46 -0700
In-Reply-To: <ZKwohzanCVIFwrxN@lincoln>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-7-larysa.zaremba@intel.com> <ZKWo0BbpLfkZHbyE@google.com>
 <ZKbOQzj1jtDeaaMp@lincoln> <CAKH8qBvrSJF0HppJ9OVF5wRDP-qV6uVfkWBvPR9=-SpRoyvDJQ@mail.gmail.com>
 <ZKwohzanCVIFwrxN@lincoln>
Message-ID: <ZKxKHvCvSakljJjQ@google.com>
Subject: Re: [PATCH bpf-next v2 06/20] ice: Support HW timestamp hint
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/10, Larysa Zaremba wrote:
> On Thu, Jul 06, 2023 at 09:39:29AM -0700, Stanislav Fomichev wrote:
> > On Thu, Jul 6, 2023 at 7:27=E2=80=AFAM Larysa Zaremba <larysa.zaremba@i=
ntel.com> wrote:
> > >
> > > On Wed, Jul 05, 2023 at 10:30:56AM -0700, Stanislav Fomichev wrote:
> > > > On 07/03, Larysa Zaremba wrote:
> > > > > Use previously refactored code and create a function
> > > > > that allows XDP code to read HW timestamp.
> > > > >
> > > > > Also, move cached_phctime into packet context, this way this data=
 still
> > > > > stays in the ring structure, just at the different address.
> > > > >
> > > > > HW timestamp is the first supported hint in the driver,
> > > > > so also add xdp_metadata_ops.
> > > > >
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
> > > > >  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
> > > > >  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
> > > > >  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
> > > > >  drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +-
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 24 +++++++++++++=
++++++
> > > > >  7 files changed, 31 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/e=
thernet/intel/ice/ice.h
> > > > > index 4ba3d99439a0..7a973a2229f1 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > > > @@ -943,4 +943,6 @@ static inline void ice_clear_rdma_cap(struct =
ice_pf *pf)
> > > > >     set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
> > > > >     clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> > > > >  }
> > > > > +
> > > > > +extern const struct xdp_metadata_ops ice_xdp_md_ops;
> > > > >  #endif /* _ICE_H_ */
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drive=
rs/net/ethernet/intel/ice/ice_ethtool.c
> > > > > index 8d5cbbd0b3d5..3c3b9cbfbcd3 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > > > @@ -2837,7 +2837,7 @@ ice_set_ringparam(struct net_device *netdev=
, struct ethtool_ringparam *ring,
> > > > >             /* clone ring and setup updated count */
> > > > >             rx_rings[i] =3D *vsi->rx_rings[i];
> > > > >             rx_rings[i].count =3D new_rx_cnt;
> > > > > -           rx_rings[i].cached_phctime =3D pf->ptp.cached_phc_tim=
e;
> > > > > +           rx_rings[i].pkt_ctx.cached_phctime =3D pf->ptp.cached=
_phc_time;
> > > > >             rx_rings[i].desc =3D NULL;
> > > > >             rx_rings[i].rx_buf =3D NULL;
> > > > >             /* this is to allow wr32 to have something to write t=
o
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/n=
et/ethernet/intel/ice/ice_lib.c
> > > > > index 00e3afd507a4..eb69b0ac7956 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > > @@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_v=
si *vsi)
> > > > >             ring->netdev =3D vsi->netdev;
> > > > >             ring->dev =3D dev;
> > > > >             ring->count =3D vsi->num_rx_desc;
> > > > > -           ring->cached_phctime =3D pf->ptp.cached_phc_time;
> > > > > +           ring->pkt_ctx.cached_phctime =3D pf->ptp.cached_phc_t=
ime;
> > > > >             WRITE_ONCE(vsi->rx_rings[i], ring);
> > > > >     }
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/=
net/ethernet/intel/ice/ice_main.c
> > > > > index 93979ab18bc1..f21996b812ea 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > > > @@ -3384,6 +3384,7 @@ static void ice_set_ops(struct ice_vsi *vsi=
)
> > > > >
> > > > >     netdev->netdev_ops =3D &ice_netdev_ops;
> > > > >     netdev->udp_tunnel_nic_info =3D &pf->hw.udp_tunnel_nic;
> > > > > +   netdev->xdp_metadata_ops =3D &ice_xdp_md_ops;
> > > > >     ice_set_ethtool_ops(netdev);
> > > > >
> > > > >     if (vsi->type !=3D ICE_VSI_PF)
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/n=
et/ethernet/intel/ice/ice_ptp.c
> > > > > index a31333972c68..70697e4829dd 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > > > @@ -1038,7 +1038,7 @@ static int ice_ptp_update_cached_phctime(st=
ruct ice_pf *pf)
> > > > >             ice_for_each_rxq(vsi, j) {
> > > > >                     if (!vsi->rx_rings[j])
> > > > >                             continue;
> > > > > -                   WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, =
systime);
> > > > > +                   WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_p=
hctime, systime);
> > > > >             }
> > > > >     }
> > > > >     clear_bit(ICE_CFG_BUSY, pf->state);
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/=
net/ethernet/intel/ice/ice_txrx.h
> > > > > index d0ab2c4c0c91..4237702a58a9 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > > > > @@ -259,6 +259,7 @@ enum ice_rx_dtype {
> > > > >
> > > > >  struct ice_pkt_ctx {
> > > > >     const union ice_32b_rx_flex_desc *eop_desc;
> > > > > +   u64 cached_phctime;
> > > > >  };
> > > > >
> > > > >  struct ice_xdp_buff {
> > > > > @@ -354,7 +355,6 @@ struct ice_rx_ring {
> > > > >     struct ice_tx_ring *xdp_ring;
> > > > >     struct xsk_buff_pool *xsk_pool;
> > > > >     dma_addr_t dma;                 /* physical address of ring *=
/
> > > > > -   u64 cached_phctime;
> > > > >     u16 rx_buf_len;
> > > > >     u8 dcb_tc;                      /* Traffic class of ring */
> > > > >     u8 ptp_rx;
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/driv=
ers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > index beb1c5bb392a..463d9e5cbe05 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > @@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring =
*xdp_ring, unsigned int xdp_res,
> > > > >                     spin_unlock(&xdp_ring->tx_lock);
> > > > >     }
> > > > >  }
> > > > > +
> > > > > +/**
> > > > > + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> > > > > + * @ctx: XDP buff pointer
> > > > > + * @ts_ns: destination address
> > > > > + *
> > > > > + * Copy HW timestamp (if available) to the destination address.
> > > > > + */
> > > > > +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns=
)
> > > > > +{
> > > > > +   const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > > > > +   u64 cached_time;
> > > > > +
> > > > > +   cached_time =3D READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);
> > > >
> > > > I believe we have to have something like the following here:
> > > >
> > > > if (!ts_ns)
> > > >       return -EINVAL;
> > > >
> > > > IOW, I don't think verifier guarantees that those pointer args are
> > > > non-NULL.
> > >
> > > Oh, that's a shame.
> > >
> > > > Same for the other ice kfunc you're adding and veth changes.
> > > >
> > > > Can you also fix it for the existing veth kfuncs? (or lmk if you pr=
efer me
> > > > to fix it).
> > >
> > > I think I can send fixes for RX hash and timestamp in veth separately=
, before
> > > v3 of this patchset, code probably doesn't intersect.
> > >
> > > But argument checks in kfuncs are a little bit a gray area for me, wh=
ether they
> > > should be sent to stable tree or not?
> >=20
> > Add a Fixes tag and they will get into the stable trees automatically I=
 believe?
>=20
> What about declaring XDP hints kfuncs with
>=20
> BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
>=20
> instead of BTF_ID_FLAGS(func, name, 0)
> ?
>=20
> I have tested this just now and xdp_metadata passes just fine (so both st=
ack=20
> and data_meta destination pointers work), but if I replace &timestamp wit=
h NULL,
> verifier rejects the program with a descriptive message "Possibly NULL po=
inter=20
> passed to trusted arg1", so it serves our purpose. I do not see many ways=
 this=20
> could limit the users, but it definitely benefits driver developers.
>=20
> The only concern I see is that if we ever decide to allow NULL arguments =
for=20
> kfuncs, we'd need to add support for a "_or_null" suffix [0]. But it does=
n't=20
> sound too hard?
>=20
> I have dug into this, because adding
>=20
> if (unlikely(!hash || &rss_type))
> 	return -EINVAL;
>=20
> or something similar to every .xmo_ handler in existence starts to look u=
gly.
>=20
> [0]=20
> https://lore.kernel.org/lkml/20230120054441.arj5h6yrnh5jsrgr@MacBook-Pro-=
6.local.dhcp.thefacebook.com/

SG! Let's add KF_TRUSTED_ARGS. That is munch nicer indeed!

