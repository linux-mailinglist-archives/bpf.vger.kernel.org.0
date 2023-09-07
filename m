Return-Path: <bpf+bounces-9432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC8797896
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7E0281A84
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50552134CC;
	Thu,  7 Sep 2023 16:49:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393D4C7C
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:49:23 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA0D1FD5
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 09:49:00 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7927f241772so50465239f.1
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694105285; x=1694710085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFTyNpM7yAvE7umrFRNXGK4VqMg2wT15/J42PJIZjWk=;
        b=YEHAhoJUZl+tP9+QtL8eIgarfPZod9CUBBUmM8FvVKVxvLTpm6cwCSXoYG2T45x1vG
         vSH+9y79jT8AvX3CSM+1zlp0ct1Jmr0f+VZmNobp6AKaM+TJtOb017ocjOz0RnzaZmwH
         d3lwp4z6964PK2h/ThBhMpm/dOKb4AYMU6SxYJ5XEKCs9qCyeCxqfrCVlEmldKFlvePN
         Bt2rukDtRgSorCfAHX420txLt2e7KLP5bu7jo2d+PvR+q2aHDzy1ybLbyTcOrvami8Uf
         Wcw+CzKyZlE0Ul+Dj8Cq8QYb78Fl/vVSat4HI9M+e8HnkIpDp4XYBV+NSneqKCbB2FGd
         BQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105285; x=1694710085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFTyNpM7yAvE7umrFRNXGK4VqMg2wT15/J42PJIZjWk=;
        b=BFei3r9EK3tH/0gp2ay5rwpOdAjd/whVjfo4w9+5X6s4z/n27PL09LeLo7Sl2tkB+N
         ov1jxMg8Q5jA+frDX1UVQbPdx7CwnaldR97id788khLmJuNxbSPw1uB36JAXTSEVR7Sx
         l3YTP980FyxEJvd+O95nK5YDNOnq7OPRLDVeex6tLRs58TAnYxLRSsVo4+SUbxtRSLFR
         imCvU8DkPIJOFJTAxymByNLjTpXqOMnN2zbhWaaITqYB4oVs8msbHKa9OpYiLIF2yH3d
         Vr7Ss3VUupB4X4i9LrgfCGjdcp9rMj9DjsN/q0NvjU3zYKgmX7qY0PIW3WxMRq8NkWP5
         5AAg==
X-Gm-Message-State: AOJu0Yx0toDUyxPvpZSDbEmsNvcw6jA1+7En9ZrFpZuIS1XrTD5Z0s27
	j6ZtH9OO6OAXiogRzCyU+u7ryH8gdSf6P4JQoz9U7XHRDxBcAVfApfRtIA==
X-Google-Smtp-Source: AGHT+IFVXK1irbxzXO8CRqUEV4PhxNxRhGrZ3jC0Oo8gFa/nAhDym68ODzwQwY9xK229KAYNL+iNYAgidGBtiQ/rr0U=
X-Received: by 2002:a17:90a:b013:b0:26f:5d72:8de3 with SMTP id
 x19-20020a17090ab01300b0026f5d728de3mr119822pjq.20.1694104405601; Thu, 07 Sep
 2023 09:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com> <ZPX4ftTJiJ+Ibbdd@boxer>
 <ZPYdve6E467wewgP@lincoln> <ZPdq/7oDhwKu8KFF@boxer> <ZPncfkACKhPFU0PU@lincoln>
In-Reply-To: <ZPncfkACKhPFU0PU@lincoln>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 7 Sep 2023 09:33:14 -0700
Message-ID: <CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com>
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, 
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>, 
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 7:27=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> On Tue, Sep 05, 2023 at 07:53:03PM +0200, Maciej Fijalkowski wrote:
> > On Mon, Sep 04, 2023 at 08:11:09PM +0200, Larysa Zaremba wrote:
> > > On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> > > > On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > > > > In order to use XDP hints via kfuncs we need to put
> > > > > RX descriptor and ring pointers just next to xdp_buff.
> > > > > Same as in hints implementations in other drivers, we achieve
> > > > > this through putting xdp_buff into a child structure.
> > > >
> > > > Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp=
_buff
> > > > if i'm reading this right.
> > > >
> > >
> > > ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_b=
uff could
> > > replace pointer to xdp_buff, but not in reverse).
> > >
> > > > >
> > > > > Currently, xdp_buff is stored in the ring structure,
> > > > > so replace it with union that includes child structure.
> > > > > This way enough memory is available while existing XDP code
> > > > > remains isolated from hints.
> > > > >
> > > > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > > > 64 bytes (single cache line). To place it at the start of a cache=
 line,
> > > > > move 'next' field from CL1 to CL3, as it isn't used often. This s=
till
> > > > > leaves 128 bits available in CL3 for packet context extensions.
> > > >
> > > > I believe ice_xdp_buff will be beefed up in later patches, so what =
is the
> > > > point of moving 'next' ? We won't be able to keep ice_xdp_buff in a=
 single
> > > > CL anyway.
> > > >
> > >
> > > It is to at least keep xdp_buff and descriptor pointer (used for ever=
y hint) in
> > > a single CL, other fields are situational.
> >
> > Right, something must be moved...still, would be good to see perf
> > before/after :)
> >
> > >
> > > > >
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 +++++++++++++=
+++---
> > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> > > > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/=
net/ethernet/intel/ice/ice_txrx.c
> > > > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *r=
x_ring, const unsigned int size)
> > > > >   * @xdp_prog: XDP program to run
> > > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > > >   * @rx_buf: Rx buffer to store the XDP action
> > > > > + * @eop_desc: Last descriptor in packet to read metadata from
> > > > >   *
> > > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > > >   */
> > > > >  static void
> > > > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > >             struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ri=
ng,
> > > > > -           struct ice_rx_buf *rx_buf)
> > > > > +           struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc=
 *eop_desc)
> > > > >  {
> > > > >         unsigned int ret =3D ICE_XDP_PASS;
> > > > >         u32 act;
> > > > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, stru=
ct xdp_buff *xdp,
> > > > >         if (!xdp_prog)
> > > > >                 goto exit;
> > > > >
> > > > > +       ice_xdp_meta_set_desc(xdp, eop_desc);
> > > >
> > > > I am currently not sure if for multi-buffer case HW repeats all the
> > > > necessary info within each descriptor for every frag? IOW shouldn't=
 you be
> > > > using the ice_rx_ring::first_desc?
> > > >
> > > > Would be good to test hints for mbuf case for sure.
> > > >
> > >
> > > In the skb path, we take metadata from the last descriptor only, so t=
his should
> > > be fine. Really worth testing with mbuf though.
>
> I retract my promise to test this with mbuf, as for now hints and mbuf ar=
e not
> supposed to go together [0].

Hm, I don't think it's intentional. I don't see why mbuf and hints
can't coexist.
Anything pops into your mind? Otherwise, can change that mask to be
~(BPF_F_XDP_DEV_BOUND_ONLY|BPF_F_XDP_HAS_FRAGS) as part of the series
(or separately, up to you).

> Making sure they can co-exist peacefully can be a topic for another serie=
s.
> For now I just can just say with high confidence that in case of multi-bu=
ffer
> frames, we do have all the supported metadata in the EoP descriptor.
>
> [0] https://elixir.bootlin.com/linux/v6.5.2/source/kernel/bpf/offload.c#L=
234
>
> >
> > Ok, thanks!
> >

