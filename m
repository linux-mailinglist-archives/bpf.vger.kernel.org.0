Return-Path: <bpf+bounces-50900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A2BA2DCBD
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 12:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD05D164E0B
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDB184540;
	Sun,  9 Feb 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gytcrkJ6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32624336A;
	Sun,  9 Feb 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099030; cv=none; b=K9/Ku6IPfczklJCgXDEwvPCyFfImQPsW692vY/ImJI23nceOcW+COP862mpMU7uz1NvO28G0iJITYcAwRt0goyiRWdN+OEmhOuHMqbzZj526S0yBS+Zw8xg8WO7E0TvJ2/sRT3ZPcraoyI0nVjnrDFRWQT5w3LuLBHG8oVfhWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099030; c=relaxed/simple;
	bh=oz60or5wEgOb6d5kH7bybDsl98IrVud/6z5jFUnuKls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqPMBt/HgXmy0SoGWfFHIkRLwhXqzOr4GFP3Zdr+PrsH2zUuxus6YobAIxEkjr0nNZIFaCwVBue9Fm3TPc/AwYO8wELTKzng8yt2SAABxrw+97ilznOe2mdl5DcLqAD/ifPkjMvmW4U9cWLGO5euzW/oPLbFqdlHoGzPBnOkmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gytcrkJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B1CC4CEDD;
	Sun,  9 Feb 2025 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739099030;
	bh=oz60or5wEgOb6d5kH7bybDsl98IrVud/6z5jFUnuKls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gytcrkJ6Z1E/G+YNuNMhXFJBib42JqkrK+yhrggW2h+m+LPKbzXArP0J74xLu1Wtx
	 78XuGzSe9EREjLXrqwt96GjVwMdOhe9xNFxeaDg19HQ9MXXRR9OoJdY1jPTYJJbgFq
	 tY/f0/rSXtrZl9E/Ck2fooHhlIGzOFof3zbzHvPQrbqHWtvUuT8WG5UhGtzxf/FdSn
	 r3rTGnWff5j+30c/jsUCyLluHlbsgoZBPdr4u8qjAbzurXbANc1D/VTYSeQCA7ZVVT
	 P/UylASA6Sw29TetKBHAjlBSrY+Nl2tzvWmJU9pPK+qGqaBvI3JAr4rqKHGyO+QnwJ
	 lEtN0/aqqJnrg==
Date: Sun, 9 Feb 2025 11:03:44 +0000
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
Message-ID: <20250209110344.GA554665@kernel.org>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-5-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206182630.3914318-5-aleksander.lobakin@intel.com>

On Thu, Feb 06, 2025 at 07:26:29PM +0100, Alexander Lobakin wrote:
> Currently, when your driver supports XSk Tx metadata and you want to
> send an XSk frame, you need to do the following:
> 
> * call external xsk_buff_raw_get_dma();
> * call inline xsk_buff_get_metadata(), which calls external
>   xsk_buff_raw_get_data() and then do some inline checks.
> 
> This effectively means that the following piece:
> 
> addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
> 
> is done twice per frame, plus you have 2 external calls per frame, plus
> this:
> 
> 	meta = pool->addrs + addr - pool->tx_metadata_len;
> 	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> 
> is always inlined, even if there's no meta or it's invalid.
> 
> Add xsk_buff_raw_get_ctx() (xp_raw_get_ctx() to be precise) to do that
> in one go. It returns a small structure with 2 fields: DMA address,
> filled unconditionally, and metadata pointer, non-NULL only if it's
> present and valid. The address correction is performed only once and
> you also have only 1 external call per XSk frame, which does all the
> calculations and checks outside of your hotpath. You only need to
> check `if (ctx.meta)` for the metadata presence.
> To not copy any existing code, derive address correction and getting
> virtual and DMA address into small helpers. bloat-o-meter reports no
> object code changes for the existing functionality.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Hi Alexander,

I think that this patch needs to be accompanied by at least one
patch that uses xsk_buff_raw_get_ctx() in a driver.

Also, as this seems to be an optimisation, some performance data would
be nice too.

Which brings me to my last point. I'd always understood that
returning a struct was discouraged due to performance implications.
Perhaps that information is out of date, doesn't apply because
the returned struct is so small in this case, or just plain wrong.
But I'd appreciate it if you could add some colour to this.

