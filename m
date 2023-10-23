Return-Path: <bpf+bounces-13043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6AF7D3D64
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249741C203E0
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A441200AE;
	Mon, 23 Oct 2023 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVLW8a4H"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AD12B7F
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:21:57 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77651EE
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:21:55 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9e1b431d0so23261025ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698081715; x=1698686515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/B8lageGMlr9qUG/KlHIRLTO+L0Q69aSFsg/BovmTxk=;
        b=zVLW8a4HWSFi01B36kF2Xs7YfGDuph9fHf6PTKUx87pmcgPXaCcXFEjgOMy/vzVJcY
         HnxMW4aCEk47R/ikYzwH8x83DoPTvGHnHvYmq+q64WglT8Gkf8gDvaD+HOBQeEh7ak1B
         ESEmpJ2T4WyvEmA9nLHU0BvtDPaaA2u/4rpFvMjEDa4PiyfCH3Kjz9YUEx3sJu3c35L1
         gZ+6YS5S572xvUlHZnPW695tUxr8p+vd4hQc7UE3WYscsP4BEf67iX5SV6HWy6IPLQJB
         FvsEZQyT67RqWi1LsOQeOIk4pWIQl7bG9LnHVxDWvdLAL6I8SAnp1wksFULyvNs3Gj1A
         W4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081715; x=1698686515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/B8lageGMlr9qUG/KlHIRLTO+L0Q69aSFsg/BovmTxk=;
        b=xMzfPX0xujyKqxLHmDIVxvtFDA/RF9E4up3b2jbaXmdfNS07pUlYXsePB9sd+IMTOo
         JlOBtzXZIRKcZLYoNGIWNq3kmol8SbmlUS6h5/1+M+P0p5THmoh/et+16dNSeGnMAli3
         XCWJsXE2bnfimw8Zc2do7q67U5cr50PjmXCwW5ZBk+4tekM22BTGfrpJ90Qm6ra7+INw
         0Nc4ZrURcfgYp2ispTbS124f6uWSbwkB0RhmUkR5qk+eIRkSuDqHh6NZuwHkTW79zmd+
         VI3R3XnUBe9IVIiMGgBeFhk7m1933K1wyfLiug+yuZcBgl71BBTgXTE/nD3wR4xnpDKC
         cQQA==
X-Gm-Message-State: AOJu0Yx3Uv8dhH/dmYAp3QmVokUJFRnJehzDWBfi0KaGVoPVHYrGxka3
	ZzuuENXMJRxAm7zGO6ewYTvTwGs=
X-Google-Smtp-Source: AGHT+IFKjYhxdkK+MF/cAYrA5yautwocYEWjQfJGCaxzpBQlEwcsM5B9nN/miZXqgukOUHGRKsh+0o8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:654d:b0:1c9:d366:8f11 with SMTP id
 d13-20020a170902654d00b001c9d3668f11mr167418pln.7.1698081714824; Mon, 23 Oct
 2023 10:21:54 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:21:53 -0700
In-Reply-To: <20231020180411.2a9f573d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-3-sdf@google.com>
 <20231020180411.2a9f573d@kernel.org>
Message-ID: <ZTarsV4UT-sQ14uI@google.com>
Subject: Re: [PATCH bpf-next v4 02/11] xsk: Add TX timestamp and TX checksum
 offload support
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 10/20, Jakub Kicinski wrote:
> On Thu, 19 Oct 2023 10:49:35 -0700 Stanislav Fomichev wrote:
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > index 14511b13f305..22d2649a34ee 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -55,6 +55,19 @@ name: netdev
> >          name: hash
> >          doc:
> >            Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
> > +  -
> > +    type: flags
> > +    name: xsk-flags
> > +    render-max: true
> 
> I don't think you're using the MAX, maybe don't render it.
> IDK what purpose it'd serve for feature flag enums.

I was gonna say 'to iterate over every possible bit', but we are using
that 'xxx > 1U << i' implementation (which you also found a bug in).

I can drop it, but the question is: should I drop it from the rest as
well? xdp-act and xdp-rx-metadata have it.

> > +/*
> > + * This structure defines the AF_XDP TX metadata hooks for network devices.
> 
> s/This structure defines the //
> 
> > + * The following hooks can be defined; unless noted otherwise, they are
> > + * optional and can be filled with a null pointer.
> > + *
> > + * void (*tmo_request_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame requested egress timestamp.
> 
> s/This function is // in many places

SG for this and the one above.

> > + * u64 (*tmo_fill_timestamp)(void *priv)
> > + *     This function is called when AF_XDP frame, that had requested
> > + *     egress timestamp, received a completion. The hook needs to return
> > + *     the actual HW timestamp.
> > + *
> > + * void (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv)
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
> 
> Could you move the definition of the struct to include/net/xdp_sock.h ?
> netdevice.h doesn't need it.

Let me try..

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
> 
> Reuse of enum netdev_xsk_flags is not an option?

It is an option, but probably better to keep them separate? Netlink is
for observability, and here have a tighter control over the defines and
UAPI (and the don't have to map 1:1 as in the case of
XDP_TX_METADATA_CHECKSUM_SW, for example).

> > +/* Force checksum calculation in software. Can be used for testing or
> > + * working around potential HW issues. This option causes performance
> > + * degradation and only works in XDP_COPY mode.
> > + */
> > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
> 
> Is there a need for this to be on packet-by-packet basis?
> HW issues should generally be fixed by the driver, is there 
> any type of problem in particular you have in mind here?

No, not really, do you think it makes sense to move it to a setsockopt
or something? We'd still have to check it on a per-packet case
though (from xsk_sock), so not sure it is strictly better?

Regarding HW issues: I don't have a good problem in mind, but I
think having a SW path is useful. It least it was useful for me
during developing (to compare the checksum) and I hope it will be
useful for other people as well (mostly as well during development).
Because the API is still a bit complicated and requires getting
pseudo header csum right. Plus the fact that csum_offset is an
offset from csum_start was not super intuitive to me.

> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index fe61f85bcf33..5d889c2425fd 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -14,6 +14,7 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> >  		   const struct genl_info *info)
> >  {
> >  	u64 xdp_rx_meta = 0;
> > +	u64 xsk_features = 0;
> 
> rev xmas tree? :)

Oops.

> > +			meta = buffer - xs->pool->tx_metadata_len;
> > +
> > +			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {
> 
> Do we need to worry about reserved / unsupported meta->flags ?

I don't think so, probably not worth the cycles to check for the
unsupported bits? Or do you think it makes sense to clearly return
an error here and this extra check won't actually affect anything?

