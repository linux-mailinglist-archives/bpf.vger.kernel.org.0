Return-Path: <bpf+bounces-12456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57B7CC8F6
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A862825EF
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D6A2D03B;
	Tue, 17 Oct 2023 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYaDMQhB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A422D02C;
	Tue, 17 Oct 2023 16:37:20 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7077CA4;
	Tue, 17 Oct 2023 09:37:19 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d00415a92so7395566d6.1;
        Tue, 17 Oct 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697560638; x=1698165438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Acry/SkmOO+//pdMk3iso04YDCLFfseKjRwabK+zSS0=;
        b=FYaDMQhBsKqBA4vba4gzub1lsifF/31WU0nSSOlSmMvP6Oi2bgPyN0BLXkC6eKbIHB
         LiYyc2vjDMVQA46woiioannsrEJxsYj8h/6rZXyjBbsQ87YHsIZ1dvHghfIw80ICAHso
         CFmaFgQ0h9kBmqMEAFlT3U7kcNGzMH9oGaVMMAL5JN0q7APVVlX9CgTsOA95jpP15qz3
         NNdzuLkPWubURUM0s/p3rR3M6froky3LVc66V8wBd24h1sZqEsgSke1ETpnr0tj9Trzi
         N1HZ2feBDf+MLw1hCfCiLdnvCIOaxKqI45WtGpWd+/N4ZvKKEoR6WqVhfvkG7muTIhl7
         7Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560638; x=1698165438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Acry/SkmOO+//pdMk3iso04YDCLFfseKjRwabK+zSS0=;
        b=hGhMP9uFckZdWks9/UhriyNN1JVTFybWzFFN1boPoU5rqaLzRfx58YY8G8RMjNR821
         jfT6MrJnrNpkjFnnl0vzATsdop4SXk7K5PqDyyJvRK3xwgXkIXTaXjB3d8b+zmZhBV0j
         ixeSwlrLFHjAnUMsgEqNJhRTrBPngSphLqXWcNVLrOp1+U4G22RytThoN8d6Gf4slDpZ
         RXx2v1VH3cX8wGHzicO/Gd8jivZ8IMryFOW20JHptqJeJuoGC5tVbNAJBdCgQ/hvSVwL
         KRvBGcHIqZ9qACQirpnaz2GoOYz8A5S6p4y+VAATKO7MszEcNWyZBSGTArrtd7JiX4+l
         qyvA==
X-Gm-Message-State: AOJu0Yz3k/Wh4pcOHODNgkVefpbNiXUT4n8yEoIBi+SeTZdwU0dV90jh
	Nw/i8cYG7PqQk1lNOEJYN7U1b+RXYkmB8PfZG5c=
X-Google-Smtp-Source: AGHT+IGTat1ho+DMJZVtLhYHIBuyyy4aKRP3WdLAkSBcaTTNmTkoRlB1b+S0RfQSQd4IZ+QGS6+4PwHvfyk+vVrRMwY=
X-Received: by 2002:a05:6214:4402:b0:66d:169a:a661 with SMTP id
 oj2-20020a056214440200b0066d169aa661mr2949294qvb.4.1697560638502; Tue, 17 Oct
 2023 09:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-8-larysa.zaremba@intel.com> <ZS6yqqMZD1mojQNr@boxer>
In-Reply-To: <ZS6yqqMZD1mojQNr@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 17 Oct 2023 18:37:07 +0200
Message-ID: <CAJ8uoz3Bqtb-F1bpKWKx8bhftJW7g1BEyjxnQZprRv4NxsXi9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 07/18] ice: Support XDP hints in AF_XDP ZC mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>, 
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023 at 18:13, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Oct 12, 2023 at 07:05:13PM +0200, Larysa Zaremba wrote:
> > In AF_XDP ZC, xdp_buff is not stored on ring,
> > instead it is provided by xsk_buff_pool.
> > Space for metadata sources right after such buffers was already reserved
> > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > This makes the implementation rather straightforward.
> >
> > Update AF_XDP ZC packet processing to support XDP hints.
> >
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_xsk.c | 34 ++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index ef778b8e6d1b..6ca620b2fbdd 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -752,22 +752,51 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> >       return ICE_XDP_CONSUMED;
> >  }
> >
> > +/**
> > + * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
> > + * @xdp: xdp_buff used as input to the XDP program
> > + * @eop_desc: End of packet descriptor
> > + * @rx_ring: Rx ring with packet context
> > + *
> > + * In regular XDP, xdp_buff is placed inside the ring structure,
> > + * just before the packet context, so the latter can be accessed
> > + * with xdp_buff address only at all times, but in ZC mode,
> > + * xdp_buffs come from the pool, so we need to reinitialize
> > + * context for every packet.
> > + *
> > + * We can safely convert xdp_buff_xsk to ice_xdp_buff,
> > + * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> > + * right after xdp_buff, for our private use.
> > + * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
> > + */
> > +static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> > +                                union ice_32b_rx_flex_desc *eop_desc,
> > +                                struct ice_rx_ring *rx_ring)
> > +{
> > +     XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> > +     ((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
>
> I will be loud thinking over here, but this could be set in
> ice_fill_rx_descs(), while grabbing xdp_buffs from xsk_pool, should
> minimize the performance overhead.
>
> But then again you address that with static branch in later patch.
>
> OTOH, I was thinking that we could come with xsk_buff_pool API that would
> let drivers assign this at setup time. Similar what is being done with dma
> mappings.
>
> Magnus, do you think it is worth the hassle? Thoughts?

I would measure the overhead of the current assignment and if it is
significant (incurs a cache miss for example), then why not try out
your idea. Usually good not to have to touch things when not needed.

> Or should we advise any other driver that support hints to mimic static
> branch solution?
>
> > +     ice_xdp_meta_set_desc(xdp, eop_desc);
> > +}
> > +
> >  /**
> >   * ice_run_xdp_zc - Executes an XDP program in zero-copy path
> >   * @rx_ring: Rx ring
> >   * @xdp: xdp_buff used as input to the XDP program
> >   * @xdp_prog: XDP program to run
> >   * @xdp_ring: ring to be used for XDP_TX action
> > + * @rx_desc: packet descriptor
> >   *
> >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> >   */
> >  static int
> >  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > -            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> > +            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > +            union ice_32b_rx_flex_desc *rx_desc)
> >  {
> >       int err, result = ICE_XDP_PASS;
> >       u32 act;
> >
> > +     ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
> >       act = bpf_prog_run_xdp(xdp_prog, xdp);
> >
> >       if (likely(act == XDP_REDIRECT)) {
> > @@ -907,7 +936,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> >               if (ice_is_non_eop(rx_ring, rx_desc))
> >                       continue;
> >
> > -             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> > +             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
> > +                                      rx_desc);
> >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> >                       xdp_xmit |= xdp_res;
> >               } else if (xdp_res == ICE_XDP_EXIT) {
> > --
> > 2.41.0
> >

