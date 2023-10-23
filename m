Return-Path: <bpf+bounces-13046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FD7D3EB3
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D641C20B17
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB5E21366;
	Mon, 23 Oct 2023 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n90t6WbH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137D21340;
	Mon, 23 Oct 2023 18:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C4EC433C8;
	Mon, 23 Oct 2023 18:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698084730;
	bh=GW9UQ6EHFPmshL/qVWAbYEnuG1iB/9yD9/xjWaONT0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n90t6WbHB5spdTBUGRiLxo1B6q7BldlK4KG9cH3+oGOtd//VT4aSmGLMXzJFJeW/U
	 vJcGbBqPxOzYQ8DAVfJjxX3BAsF5PtWt43BSwDenU7QbgnsEbiJYEFJtbD3JhvsJXN
	 5JvC9kbgpW5BzTrKsb3ZGJrwJeAbVqXm5unH0m8qpYOn3eyd30rV2Mx8VAufYI9CI9
	 uEQEKNs58xo5MUoBr0n7TT8AVvvJTVQkWfymP/fVKlljH6ECeRMudP4SqOPzAUxg4m
	 7c1Xsv5IYrkx+dTcoktUHHQz6KDE/VVPvP1XSOgPSKxv1MDEfzrrH6/pUv+55jwEx9
	 Ci0f+23s/kraw==
Date: Mon, 23 Oct 2023 11:12:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 02/11] xsk: Add TX timestamp and TX checksum
 offload support
Message-ID: <20231023111209.2278899c@kernel.org>
In-Reply-To: <ZTarsV4UT-sQ14uI@google.com>
References: <20231019174944.3376335-1-sdf@google.com>
	<20231019174944.3376335-3-sdf@google.com>
	<20231020180411.2a9f573d@kernel.org>
	<ZTarsV4UT-sQ14uI@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 10:21:53 -0700 Stanislav Fomichev wrote:
> On 10/20, Jakub Kicinski wrote:
> > On Thu, 19 Oct 2023 10:49:35 -0700 Stanislav Fomichev wrote:  
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > index 14511b13f305..22d2649a34ee 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -55,6 +55,19 @@ name: netdev
> > >          name: hash
> > >          doc:
> > >            Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
> > > +  -
> > > +    type: flags
> > > +    name: xsk-flags
> > > +    render-max: true  
> > 
> > I don't think you're using the MAX, maybe don't render it.
> > IDK what purpose it'd serve for feature flag enums.  
> 
> I was gonna say 'to iterate over every possible bit', but we are using
> that 'xxx > 1U << i' implementation (which you also found a bug in).
> 
> I can drop it, but the question is: should I drop it from the rest as
> well? xdp-act and xdp-rx-metadata have it.

The xdp-act one looks used. xdp-rx-metadata looks unused, so you could
drop. But up to you if you want to clean it up.

> > > +/* Request transmit timestamp. Upon completion, put it into tx_timestamp
> > > + * field of struct xsk_tx_metadata.
> > > + */
> > > +#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
> > > +
> > > +/* Request transmit checksum offload. Checksum start position and offset
> > > + * are communicated via csum_start and csum_offset fields of struct
> > > + * xsk_tx_metadata.
> > > + */
> > > +#define XDP_TX_METADATA_CHECKSUM		(1 << 1)  
> > 
> > Reuse of enum netdev_xsk_flags is not an option?  
> 
> It is an option, but probably better to keep them separate? Netlink is
> for observability, and here have a tighter control over the defines and
> UAPI (and the don't have to map 1:1 as in the case of
> XDP_TX_METADATA_CHECKSUM_SW, for example).

The duplication is rather apparent, and they are flags so compiler
can't help us catch misuses of one set vs the other.

If you prefer to keep the separate defines - I'd rename them to tie 
them to the field more strongly. Specifically they should have the
word "flags" in them?

XDP_TXMD_FLAGS_TIMESTAMP
XDP_TXMD_FLAGS_CHECKSUM

maybe?

> > > +/* Force checksum calculation in software. Can be used for testing or
> > > + * working around potential HW issues. This option causes performance
> > > + * degradation and only works in XDP_COPY mode.
> > > + */
> > > +#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)  
> > 
> > Is there a need for this to be on packet-by-packet basis?
> > HW issues should generally be fixed by the driver, is there 
> > any type of problem in particular you have in mind here?  
> 
> No, not really, do you think it makes sense to move it to a setsockopt
> or something? We'd still have to check it on a per-packet case
> though (from xsk_sock), so not sure it is strictly better?

Setsockopt or just ethtool -K $ifc tx off ? And check device features?
Maybe I'm overly sensitive but descriptor bits are usually super
precious :)

> Regarding HW issues: I don't have a good problem in mind, but I
> think having a SW path is useful. It least it was useful for me
> during developing (to compare the checksum) and I hope it will be
> useful for other people as well (mostly as well during development).
> Because the API is still a bit complicated and requires getting
> pseudo header csum right. Plus the fact that csum_offset is an
> offset from csum_start was not super intuitive to me.

Okay, I'm not strongly opposed, I just wanted to flag it.
If nobody else feels the same way, and you like the separate bit - 
perfectly fine by me.

> > > +			meta = buffer - xs->pool->tx_metadata_len;
> > > +
> > > +			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {  
> > 
> > Do we need to worry about reserved / unsupported meta->flags ?  
> 
> I don't think so, probably not worth the cycles to check for the
> unsupported bits? Or do you think it makes sense to clearly return
> an error here and this extra check won't actually affect anything?

Hm, it is uAPI, isn't it? We try to validate anything kernel gets these
days, why would the flags be different? Shouldn't be more than 2 cycles.

