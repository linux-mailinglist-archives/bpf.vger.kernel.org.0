Return-Path: <bpf+bounces-37276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE19537B2
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D34D1C2550B
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129891B375F;
	Thu, 15 Aug 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI2dR1Pz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2A1A4F0F;
	Thu, 15 Aug 2024 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737284; cv=none; b=ZeDNnXZbxiIgZnfEgaRkIHo3jR0uQLAONi3y1taHDmQv/IAg5tR3HeDIpcmtkixY9/+E8O6GC2v8Iv0rQ/9MDs8fpzn+Azn/GuydCdJ7i+hAk3a6+oGZ/iZvGc6bU1CUF0/8DuAhQuoWqF9sw164fE1Rah1QMJmY4bdLOORcBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737284; c=relaxed/simple;
	bh=8fxD0SycfeG1dlS20JGKOC5Kh4/oDqEslSOmZnRUIVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbZxCM+uTIUa0lri0uvQjFXPDHZ6fI98GbiP3W682tF/gHgefhFnGOAKWhT4aKFdp1jX4KMly8Tuvy+RXvgFF7QogLa4d/aom1SCo1y6fKMgNzXZ1Lf5+hSADrF5sT/gJM427Te3btYf/PDnFgIY9xVBlFofh1+9wyGy3fnzSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI2dR1Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAB5C4AF09;
	Thu, 15 Aug 2024 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737284;
	bh=8fxD0SycfeG1dlS20JGKOC5Kh4/oDqEslSOmZnRUIVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rI2dR1PzQUeM1RP4ybWzRG+tetOuN9ad/hL8WdZuoldo1+7/SO39+Aqn2yVy5pJAm
	 r4m8KW8QGAlqED8d4spSbbvpDCLdWuSQuKdg0fG0oGg8TX1TyWTxPQOsM4MuSSVK4d
	 JnFVE11k9gE4NnsEpnNuBJdyF0oO8pEgREQCjtmXX4a9xFshT+5g9E9niFvLcpsAEb
	 iBb+gw4abGmxJ/UgZPCyuj91z+6EnnsLqAXDdbcV1h0H5VAsBfeOTv2UP+JszzDRNn
	 KfrV7acvEruBVRIvONCphHKUQ7ztJH39dXILdV5bfgZDbIecGG/DxlSQDNZjX7/fXS
	 PKG4cwD7j0N0Q==
Date: Thu, 15 Aug 2024 16:54:39 +0100
From: Simon Horman <horms@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: bpf-next experiment
Message-ID: <20240815155439.GM632411@kernel.org>
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>

On Wed, Aug 14, 2024 at 12:32:00PM -0700, Alexei Starovoitov wrote:
> Hi All,
> 
> Couple years ago folks suggested that bpf-next should be
> a separate pull request to increase subsystem visibility.
> Back then we rejected the idea since many networking related
> changes required bpf core changes. Things are different now.
> bpf kfuncs can be added independently by various subsystems,
> verifier additions are mainly driven by sched-ext,
> so it's time to give it a shot. It's an experiment.
> If things don't work out as expected we will go back to
> the old model of feeding bpf trees through net/net-next trees.
> 
> So here is the plan:
> 
> 1. bpf fixes go directly to Linus (skipping net tree) and
> net/bpf trees are fast forwarded afterwards as usual.
> 
> 2. Non-networking bpf commits land in bpf-next/master branch.
> It will form bpf-next PR during the merge window.
> 
> 3. Networking related commits (like XDP) land in bpf-next/net branch.
> They will be PR-ed to net-next and ffwded from net-next
> as we do today. All these patches will get to mainline
> via net-next PR.

Hi Alexei,

Nice plan :)

I wonder if, bpf-next/net-next might be a more intuitive name, as the
proposed branch is closely related to net-next.

OTOH, mabey one '-next', as per your proposal, is enough :)

> 
> 4. bpf-next/master and bpf-next/net branches are manually
> merged into bpf-next/for-next branch.
> This step achieves two objectives:
> - bpf maintainers watch for conflicts between /master and /net
> - Stephen Rothwell continues taking /for-next branch into linux-next
> as usual
> 
> bpf CI will run tests against 4 trees (instead of 2):
> bpf, bpf-next/master, bpf-next/net, bpf-next/for-next.
> This is wip. Watch for more "Checks" in patchwork.
> 
> By the merge window in September we will reassess
> the situation and if it's still worth doing we will
> proceed with PR formed from bpf-next/master.
> If not, we will PR bpf-next/master into net-next and
> call it a failed experiment.
> 
> We feel that there are more positives to this process
> than headaches, so fingers crossed.
> 

