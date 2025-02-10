Return-Path: <bpf+bounces-51050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D596A2FB5F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BA53A3456
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F31F3D53;
	Mon, 10 Feb 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IavPoqK0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1AC264609;
	Mon, 10 Feb 2025 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221611; cv=none; b=fffj1BhHBXH9yBYh2z6ysDj+vUOHMXD+ABuOJJd+6Ts91U4Tu8vAlviVd+zQQssOMNWhIaCGh1XYE7H8b+CLiKNIVhobFAMoK9owWimrgE9kT4QZEMM2wKWc0X4DjPjAF06V5w6hKTw/qpWie1nnqrHm+742zfgdIrGmXW1ijEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221611; c=relaxed/simple;
	bh=x9CElAtQ0gtGOwR03vTgP1lvYWMnrMShZxXLOLMsbVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1Q2TrQd8PZgzzDkRnROgInet6q9Yglk+glibQIwB5zORDOSf77L1NfFx51xTwbhmDEVqej/reUtxDI2kgcsUkciOJTg/FhVqeQBg3blHfkqNFeh+8jtnZJ2DIWa1S9H54pHLzfE8vCqZyUipwAHtwmells1Usz2scfVQvKkXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IavPoqK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CBFC4CED1;
	Mon, 10 Feb 2025 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739221611;
	bh=x9CElAtQ0gtGOwR03vTgP1lvYWMnrMShZxXLOLMsbVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IavPoqK0pDgL9Ui5Pm91IuBLE1O7qd1FyAfNPwiWPsJjdLuvRZhHRUIT/1ORJE6eN
	 SAYCABsLn+Aqu/onar5XaL9opalKnnFpjharmlGjhTvRo0dCwHoQI+Y/mYYQwC9Lbx
	 /aX1IDfEqkIhAgaXC8/7CcWWI9muQODdm0VUCFkkEWpVJFuynxBT+a9hWn/ZLeaSmg
	 3jzyYea3EzEDzKRciC/V2uesgiQLVsqKPPFtJ4OTUQRrKsCvlb0k1Iz25psOtzKy1+
	 iSPUFSu91sl6sX/y6qXG5bBa2dJPe+Ik2HSJXr+aeHK2AJrqZPsR3uDTQCDN5boBL7
	 8XN/bwsKhAjmg==
Date: Mon, 10 Feb 2025 21:06:45 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] xsk: add helper to get &xdp_desc's DMA and
 meta pointer in one go
Message-ID: <20250210210645.GE554665@kernel.org>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-5-aleksander.lobakin@intel.com>
 <20250209110344.GA554665@kernel.org>
 <6d247107-5a9a-4ac7-8364-2619fce0c310@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d247107-5a9a-4ac7-8364-2619fce0c310@intel.com>

On Mon, Feb 10, 2025 at 05:00:36PM +0100, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Sun, 9 Feb 2025 11:03:44 +0000
> 
> > On Thu, Feb 06, 2025 at 07:26:29PM +0100, Alexander Lobakin wrote:
> >> Currently, when your driver supports XSk Tx metadata and you want to
> >> send an XSk frame, you need to do the following:
> >>
> >> * call external xsk_buff_raw_get_dma();
> >> * call inline xsk_buff_get_metadata(), which calls external
> >>   xsk_buff_raw_get_data() and then do some inline checks.
> >>
> >> This effectively means that the following piece:
> >>
> >> addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
> >>
> >> is done twice per frame, plus you have 2 external calls per frame, plus
> >> this:
> >>
> >> 	meta = pool->addrs + addr - pool->tx_metadata_len;
> >> 	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> >>
> >> is always inlined, even if there's no meta or it's invalid.
> >>
> >> Add xsk_buff_raw_get_ctx() (xp_raw_get_ctx() to be precise) to do that
> >> in one go. It returns a small structure with 2 fields: DMA address,
> >> filled unconditionally, and metadata pointer, non-NULL only if it's
> >> present and valid. The address correction is performed only once and
> >> you also have only 1 external call per XSk frame, which does all the
> >> calculations and checks outside of your hotpath. You only need to
> >> check `if (ctx.meta)` for the metadata presence.
> >> To not copy any existing code, derive address correction and getting
> >> virtual and DMA address into small helpers. bloat-o-meter reports no
> >> object code changes for the existing functionality.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > Hi Alexander,
> > 
> > I think that this patch needs to be accompanied by at least one
> > patch that uses xsk_buff_raw_get_ctx() in a driver.
> 
> This mini-series is the final part of my Chapter III, which was all
> about prereqs in order to add libeth_xdp and then XDP for idpf.
> This helper will be used in the next series (Chapter IV) I'll send once
> this lands.

Understood. If it's going to be used in chapter IV then, given
that we've made it to chapter II, that is fine by me.

> > Also, as this seems to be an optimisation, some performance data would
> > be nice too.
> 
> -1 Kb of object code which has an unrolled-by-8 loop which used this
> function each iteration. I don't remember the perf numbers since it was
> a year ago and since then I've been using this helper only, but it was
> something around a couple procent (which is several hundred Kpps when it
> comes to XSk).

Thanks. It might be worth including some of that information in the commit
message, but I don't feel strongly about it.

> 
> > 
> > Which brings me to my last point. I'd always understood that
> > returning a struct was discouraged due to performance implications.
> 
> Rather stack usage, not perf implications. Compound returns are used
> heavily throughout the kernel code when sizeof(result) <= 16 bytes.
> Here it's also 16 bytes. Just the same as one __u128. Plus this function
> doesn't recurse, so the stack won't blow up.

Also understood. It seems my assumptions were somewhat wrong.
So I have no objections to this approach.

> > Perhaps that information is out of date, doesn't apply because
> > the returned struct is so small in this case, or just plain wrong.
> > But I'd appreciate it if you could add some colour to this.
> 
> Moreover, the function is global, not inline, so passing a pointer here
> instead of returning a struct may even behave worse in this case.
> 
> (and we'll save basically only 8 bytes on the stack, which I don't
>  believe is worth it).
> 
> Thanks,
> Olek
> 

