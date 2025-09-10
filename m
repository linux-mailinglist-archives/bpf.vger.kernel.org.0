Return-Path: <bpf+bounces-68046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E982B51FAB
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DC7B2CC7
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1A338F55;
	Wed, 10 Sep 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkwCLKSF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C6313526;
	Wed, 10 Sep 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527499; cv=none; b=t8/mV7Xamzqtgywu7qq5aF3+pYBb26ps3iFhrZNoyy+Xd/4KT/a0JeSfwsSwv8aQvHTeJHJKNi45BWWaHU0rgl3H1WiCq7CcB14KnLVgNWvjwudsiaCIWd8oSMoSnRDcv7JwjEkY2Wk1b0M7nmCVIvxsLz9k0+4Gein0AB+0QvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527499; c=relaxed/simple;
	bh=UU8Zai8Oyugg4pSPBAAJXMcwSEAmFB98dKoF7Ro/rMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0bCvJqSGAvlHAuFONS+6va4sbdFaMaC5C/4O2UcP1ix14cHLobzUe01hkr6KyrjlXr33l/piWZKbodyGKPKDzj2zwQUCWpTS/T1U5gkt0dcKFZyB2XiToqoSAc2DcUkoWE/9jGzeCmpqOp8alCGgH/L4Gg47doqoJPU31FISxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkwCLKSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672F6C4CEEB;
	Wed, 10 Sep 2025 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527498;
	bh=UU8Zai8Oyugg4pSPBAAJXMcwSEAmFB98dKoF7Ro/rMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IkwCLKSFsBEYiTlUBKXzqtB8ooF+qiwxplmHZNiDWdgQWZtk0LEgOABQvpo8WJep8
	 TJvybq0NOQIUmiRttgbW+0FSOwXaWy8FAgEi71MacOX0kruOfHm1AHYnca+EZk3jvM
	 X/pOXLf5c4iv6KOGFw6kP88mbd3xpJZr3xqFyjVqGTua32tGGpyG+Aer3IQ2sUB+qQ
	 USj3NlAq1iM0+kga+cZpxcbIdkxH7pLick1bCZa5N/6xRwnZgYaS8CLEzjaKVBPY6u
	 E0oA20EtsJAPhGWt2DFL2O/tbAL1cnnohgEum6ucduDbxD8WCtC6W6ySglbkSHFt1m
	 +C6dNI85d11ZA==
Date: Wed, 10 Sep 2025 11:04:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 stfomichev@gmail.com, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 noren@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp
 data
Message-ID: <20250910110457.152b0460@kernel.org>
In-Reply-To: <CAMB2axPLuQ75_JSqkR43-UVBUi9Yj7juHFLCkDvSLPL445SZew@mail.gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
	<20250905173352.3759457-4-ameryhung@gmail.com>
	<20250908185447.233963c5@kernel.org>
	<CAMB2axPLuQ75_JSqkR43-UVBUi9Yj7juHFLCkDvSLPL445SZew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 11:17:52 -0400 Amery Hung wrote:
> > Larger note: I wonder if we should support "shifting the buffer down"
> > if there's insufficient tailroom. XDP has rather copious headroom,
> > but tailroom may be pretty tight, and it may depend on the length of
> > the headers. So if there's not enough tailroom but there's enough
> > headroom -- should we try to memmove the existing headers?  
> 
> I think it should. If users want to reserve space for metadata, they
> can check the headroom before pulling data.
> 
> If the kfunc does not do memmove(), users are still able to do so in
> XDP programs through bpf_xdp_adjust_head() and memmove(), but it feels
> less easy to use IMO.

Actually, I don't think adjust_head() would even work. The program can
adjust head and memmove() the header, but there's no way to "punch out"
the end of the head buffer. We can only grow and shrink start of packet
and end of packet. After adjust_head + memmove in the prog buffer would
look something like:

  _ _ _ _ __________ _____ _ _ _ _      ________
   hroom |  headers | old | troom      |  frag0 |
  - - - - ---------- ----- - - - -      --------

and the program has no way to "free" the "old" to let pull grab data
from frag0 in its place...

skb pull helper can allocate a completely fresh buffer, but IDK if
drivers are ready to have the head buffer swapped under their feet.
So I think that best we can do is have the pull() helper aromatically
memmove the headers.

