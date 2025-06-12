Return-Path: <bpf+bounces-60540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8FAD7E9E
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497A23A3701
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA32E1730;
	Thu, 12 Jun 2025 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD0A/v97"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052E153BD9;
	Thu, 12 Jun 2025 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768748; cv=none; b=jVo2ocwLNbqlTp2SpCTxrHiFDfA1gwNGM18pjK2VYjmiRwsfvPdShjC29WGHy+8Qqan4KHNKsdL9b4g8eUgY6+b5o1qY8/TZ6FsD4DGgSktfsUDtdXaxRVCP8T5k6P/I457kaC7D9/Pgz2wy25tr5zeNEbvb+76Xzzwm0a898VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768748; c=relaxed/simple;
	bh=jMlxmZZTo6rTWsBUudaRKPlf+d5/G0AfKjYQwml7YHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BR9nx8qrCxiclZsv6oJChAHkO0QDwa6PFqbNoS12lbnu6Xap152DIQYrv2DHJ+a80i4rzMjTivl135OPT3buUysX3YYOOCsXNepo9g1sZKBNUk85IeoJ7MJH9+QZ+IBjXOxZDLG41RCutl/nqH5a6/e+hY1vx1QxGoCkf2/X63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD0A/v97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014C8C4CEEA;
	Thu, 12 Jun 2025 22:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749768748;
	bh=jMlxmZZTo6rTWsBUudaRKPlf+d5/G0AfKjYQwml7YHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lD0A/v97SwM7Ga6ASEYxETAyNTwLSdN9s3YarAstt4LKd3yaRfck6VrPAmTsB1fCJ
	 7ngZQ/kF6eslIdK8f1HF4+o1Jofu7ii0hMbI17a3FGvvxqwgPIsgD4e+9jM6jsf7g3
	 UceH90Za5OPGojj1WUxg+hALC5Np95bcXQ3NJ73PNS0n+lZHr2XDxHdpTOtEY+9u9u
	 DHzzIyj0fXgkemhBSFp1HpglGlxbmHRAkpESftpqd4wMHfVqqY6phJRLPrDuuOmRNs
	 ygTAkQkpCdhUirmI4qmoboVN2wPS4c7tJyOC3k2fdM5CM9a/LuYw06T6m+aPX+uMFs
	 QDhbVW8dmozgg==
Date: Thu, 12 Jun 2025 15:52:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "hawk@kernel.org" <hawk@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>, Leon Romanovsky
 <leonro@nvidia.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "horms@kernel.org" <horms@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal
 Pressman <gal@nvidia.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 10/12] net/mlx5e: Implement queue mgmt ops
 and single channel swap
Message-ID: <20250612155226.770f0676@kernel.org>
In-Reply-To: <CAHS8izOG+LoJ-GvyRu6zSVCUvoW4VzYX5CEdDhCdVLimOSP0KQ@mail.gmail.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
	<20250609145833.990793-11-mbloch@nvidia.com>
	<CAHS8izOX8t-Xu+mseiRBvLDYmk6G+iH=tX6t4SWY2TKBau7r-Q@mail.gmail.com>
	<9107e96e488a741c79e0f5de33dd73261056c033.camel@nvidia.com>
	<CAHS8izOG+LoJ-GvyRu6zSVCUvoW4VzYX5CEdDhCdVLimOSP0KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 13:44:44 -0700 Mina Almasry wrote:
> > On Wed, 2025-06-11 at 22:33 -0700, Mina Almasry wrote:  
> > > Is this really better than maintaining uniformity of behavior between
> > > the drivers that support the queue mgmt api and just doing the
> > > mlx5e_deactivate_priv_channels and mlx5e_close_channel in the stop
> > > like core sorta expects?
> > >
> > > We currently use the ndos to restart a queue, but I'm imagining in
> > > the
> > > future we can expand it to create queues on behalf of the queues. The
> > > stop queue API may be reused in other contexts, like maybe to kill a
> > > dynamically created devmem queue or something, and this specific
> > > driver may stop working because stop actually doesn't do anything?
> > >  
> >
> > The .ndo_queue_stop operation doesn't make sense by itself for mlx5,
> > because the current mlx5 architecture is to atomically swap in all of
> > the channels.
> > The scenario you are describing, with a hypothetical ndo_queue_stop for
> > dynamically created devmem queues would leave all of the queues stopped
> > and the old channel deallocated in the channel array. Worse problems
> > would happen in that state than with today's approach, which leaves the
> > driver in functional state.
> >
> > Perhaps Saeed can add more details to this?  
> 
> I see, so essentially mlx5 supports restarting a queue but not
> necessarily stopping and starting a queue as separate actions?
> 
> If so, can maybe the comment on the function be reworded to more
> strongly indicate that this is a limitation? Just asking because
> future driver authors interested in implementing the queue API will
> probably look at one of mlx5/gve/bnxt to see what an existing
> implementation looks like, and I would rather them follow bnxt/gve
> that is more in line with core's expectations if possible. But that's
> a minor concern; I'm fine with this patch.
> 
> FWIW this may break in the future if core decides to add code that
> actually uses the stop operation as a 'stop', not as a stepping stone
> to 'restart', but I'm not sure we can do anything about that if it's a
> driver limitation.

Agreed, would be good to add a TODO and follow up on this.
It will bite us sooner or later. I suppose state_lock may
need to be dropped in favor of the netdev instance lock first?

I'm disappointed that mlx5 once again disrupts all rings to restart 
a single one. But all existing drivers seem to do this, so I guess
it'd be unfair to push back based on just that :|

