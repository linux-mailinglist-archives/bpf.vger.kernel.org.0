Return-Path: <bpf+bounces-13050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38277D3F7C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 20:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA7BB20D3C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4AF2135C;
	Mon, 23 Oct 2023 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gVQymOw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC11A724
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 18:46:50 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AAEFD
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:46:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a528c2c8bso4456763276.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698086807; x=1698691607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWCt7fVifu9lSRwvkCzaL8k9JM3Sqd8iOqTHPjTp+Z8=;
        b=0gVQymOw39zXiMSQfLo9sMYGpYHiFi1O/RCTGGAlo6stYJu+F/AHL9PQkdIxWSLHZ5
         VeEgHHMOHwyDgc6Uful/8rcks2qL4aoIfgQjI4Mbqk1vr1gCqYlDphq6Y14P/TfNEJff
         xVDk90bAlRQNgBH6P7HTPiyBMU/2LciIG7SKKHFAPf0Npfq7pThgRiUy2mt1feNnU0PC
         Xrj6oHoSidDeOojcSxtNVhHxOnLiV4WSanM8o/7DHqgx8SSqM3QiD4s08jZ1U0IabrMi
         elIjW0OpQszH40Df3NoUlp8ZxNLVTLojcpYc9jU5wGPVIKEpXewXaFcG7mgqhicxkL8/
         vP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086807; x=1698691607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWCt7fVifu9lSRwvkCzaL8k9JM3Sqd8iOqTHPjTp+Z8=;
        b=gHC0ciCRLtVtjr8LxE+E4LB5Y7yzAF9fezW5t7LKRK9AeAmBmP348h/aB6ZkjIehL0
         SUbTZIw1vXQbdLBUwklGIs/IXLjmPSqz3dmcwKjME9EFo0LcPnq7wN1hGNZ1BeiVVTQV
         21Yf/wQRAYV0iHm5gkhUCrxBY/NJj5BNxRJ/pc0Rxw4R1MZl4NJ3QDrcXsTkMhtpV6NF
         4cJ/dVUomeTqIlwyBDfEEajOfqDsMLD+wYWmd9jxVT3S8xqV6mkyrXN98TqQtVF+Y0VK
         gpxr+c/p9uxaG4uXReSW9mzCJjYLytIBLIQ1LelRsGYzjNyB0GtWEvk051klhrdsXtDL
         qbMw==
X-Gm-Message-State: AOJu0YyNpTpVa5tsx6JBreHnxRvghQ+nEyqDzUec8wF+uX2zm3UvzFQT
	0Noz5/eHlM8Ms/jGYVlCnLj6Joo=
X-Google-Smtp-Source: AGHT+IHVcMG7X5PXY5nV8TbWav2pfkXl0AU0B4K3H28H7klf2hO78/4IOCsT2NNurl+37A28QdkmVt4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:374e:0:b0:d9a:425c:f5c with SMTP id
 e75-20020a25374e000000b00d9a425c0f5cmr183992yba.1.1698086807648; Mon, 23 Oct
 2023 11:46:47 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:46:46 -0700
In-Reply-To: <20231023111209.2278899c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com> <20231019174944.3376335-3-sdf@google.com>
 <20231020180411.2a9f573d@kernel.org> <ZTarsV4UT-sQ14uI@google.com> <20231023111209.2278899c@kernel.org>
Message-ID: <ZTa_lr8W__wVcqVH@google.com>
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

On 10/23, Jakub Kicinski wrote:
> On Mon, 23 Oct 2023 10:21:53 -0700 Stanislav Fomichev wrote:
> > On 10/20, Jakub Kicinski wrote:
> > > On Thu, 19 Oct 2023 10:49:35 -0700 Stanislav Fomichev wrote:  
> > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > > index 14511b13f305..22d2649a34ee 100644
> > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > @@ -55,6 +55,19 @@ name: netdev
> > > >          name: hash
> > > >          doc:
> > > >            Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
> > > > +  -
> > > > +    type: flags
> > > > +    name: xsk-flags
> > > > +    render-max: true  
> > > 
> > > I don't think you're using the MAX, maybe don't render it.
> > > IDK what purpose it'd serve for feature flag enums.  
> > 
> > I was gonna say 'to iterate over every possible bit', but we are using
> > that 'xxx > 1U << i' implementation (which you also found a bug in).
> > 
> > I can drop it, but the question is: should I drop it from the rest as
> > well? xdp-act and xdp-rx-metadata have it.
> 
> The xdp-act one looks used. xdp-rx-metadata looks unused, so you could
> drop. But up to you if you want to clean it up.

Ok. I'll cleanup xdp-rx-metadata in the same path. Might we worth it
to limit copy-paste spread..
 
> > > > +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
> > > > + * field of struct xsk_tx_metadata.
> > > > + */
> > > > +#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
> > > > +
> > > > +/* Request transmit checksum offload. Checksum start position and offset
> > > > + * are communicated via csum_start and csum_offset fields of struct
> > > > + * xsk_tx_metadata.
> > > > + */
> > > > +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)  
> > > 
> > > Reuse of enum netdev_xsk_flags is not an option?  
> > 
> > It is an option, but probably better to keep them separate? Netlink is
> > for observability, and here have a tighter control over the defines and
> > UAPI (and the don't have to map 1:1 as in the case of
> > XDP_TX_METADATA_CHECKSUM_SW, for example).
> 
> The duplication is rather apparent, and they are flags so compiler
> can't help us catch misuses of one set vs the other.
> 
> If you prefer to keep the separate defines - I'd rename them to tie 
> them to the field more strongly. Specifically they should have the
> word "flags" in them?
> 
> XDP_TXMD_FLAGS_TIMESTAMP
> XDP_TXMD_FLAGS_CHECKSUM
> 
> maybe?

Sg, will rename.

> > > > +/* Force checksum calculation in software. Can be used for testing or
> > > > + * working around potential HW issues. This option causes performance
> > > > + * degradation and only works in XDP_COPY mode.
> > > > + */
> > > > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)  
> > > 
> > > Is there a need for this to be on packet-by-packet basis?
> > > HW issues should generally be fixed by the driver, is there 
> > > any type of problem in particular you have in mind here?  
> > 
> > No, not really, do you think it makes sense to move it to a setsockopt
> > or something? We'd still have to check it on a per-packet case
> > though (from xsk_sock), so not sure it is strictly better?
> 
> Setsockopt or just ethtool -K $ifc tx off ? And check device features?
> Maybe I'm overly sensitive but descriptor bits are usually super
> precious :)

Good point on the descriptor bits. Let me try to move to a setsockopt.

> > Regarding HW issues: I don't have a good problem in mind, but I
> > think having a SW path is useful. It least it was useful for me
> > during developing (to compare the checksum) and I hope it will be
> > useful for other people as well (mostly as well during development).
> > Because the API is still a bit complicated and requires getting
> > pseudo header csum right. Plus the fact that csum_offset is an
> > offset from csum_start was not super intuitive to me.
> 
> Okay, I'm not strongly opposed, I just wanted to flag it.
> If nobody else feels the same way, and you like the separate bit - 
> perfectly fine by me.
> 
> > > > +			meta = buffer - xs->pool->tx_metadata_len;
> > > > +
> > > > +			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {  
> > > 
> > > Do we need to worry about reserved / unsupported meta->flags ?  
> > 
> > I don't think so, probably not worth the cycles to check for the
> > unsupported bits? Or do you think it makes sense to clearly return
> > an error here and this extra check won't actually affect anything?
> 
> Hm, it is uAPI, isn't it? We try to validate anything kernel gets these
> days, why would the flags be different? Shouldn't be more than 2 cycles.

Yeah, agreed, worst case we can have some static_branch to disable it.
But fair point that unlikely we'll see it cause any issues.

