Return-Path: <bpf+bounces-64925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C826B18836
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259B64E0233
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0FE20C00E;
	Fri,  1 Aug 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImQd93tY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1315539A;
	Fri,  1 Aug 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080685; cv=none; b=eH+xLyNUX4ZSKt1YnxQxHc3XlPvYOQJ8n84EwOY+TGP221RKVvwSglpj/h8vDu2OtZ5jJj14sQRyCEdDvPaTyEmcDb2EZLFsGip/vimDglzJgu1meupyRwZ0AcMpMVuyBMxvqyko2ChK9uexW7PBW66Lr/wYYrIJ6bIOb5LTIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080685; c=relaxed/simple;
	bh=8bc+CVO1+yckD3iTqRfIfC9xptHV9H2IE7gf9C/W1Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csjNl0+BLRoqImHp3ek+p2bVn/J0BkDXAhIn9vWfTFl9QhMba+FeJglxxGtAmpJwx6/s6S3rllVOCb3LaMAp8w78mlgPmk9Lc+gtYvZn1W+K2ezK+Jmb2oT80MR7Ws5VWk9JvPkNlSEvM23qcnUTweB2wjulXYlzQ/uTvMBdWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImQd93tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728C7C4CEE7;
	Fri,  1 Aug 2025 20:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754080685;
	bh=8bc+CVO1+yckD3iTqRfIfC9xptHV9H2IE7gf9C/W1Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ImQd93tY8pJPIcvnqAKlX0U1rT6x4Jj48gsVcfu6rsGBAsuEPaRuuPQHQsua0den1
	 5V/pqmghJ2zW2gk5e266Y13L5T5VSHWktzvnDbLJq/d6cEPlfNcwIL2fBXzbE+I4Rl
	 KdOWFQ1cVQdiobtqPGcHpL/cF6+feN/L3DH5A+qbTlW13BWquDgWr2vsDVtZO6Mx+S
	 xL5zRcy5hpOtGitRVFx0MTltTVmnEAhEjHzHiHdoMGZcCd6bsZPq3XbTD54NDQyIQd
	 5KPoRC7m1bv6d5PlZNR195llDSQkLMYTCirwZT/I6b90x8oO+u2vh63FebUTb4j9MH
	 GrsVdc1CFu0bg==
Date: Fri, 1 Aug 2025 13:38:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, sdf@fomichev.me, kernel-team@cloudflare.com,
 arthur@arthurfabre.com, jakub@cloudflare.com, Jesse Brandeburg
 <jbrandeburg@cloudflare.com>, Andrew Rzeznik <arzeznik@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250801133803.7570a6fd@kernel.org>
In-Reply-To: <21f4ee22-84f0-4d5e-8630-9a889ca11e31@kernel.org>
References: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
	<aGvcb53APFXR8eJb@mini-arch>
	<aG427EcHHn9yxaDv@lore-desk>
	<aHE2F1FJlYc37eIz@mini-arch>
	<aHeKYZY7l2i1xwel@lore-desk>
	<20250716142015.0b309c71@kernel.org>
	<fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
	<20250717182534.4f305f8a@kernel.org>
	<ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
	<20250721181344.24d47fa3@kernel.org>
	<aIdWjTCM1nOjiWfC@lore-desk>
	<20250728092956.24a7d09b@kernel.org>
	<b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
	<4eaf6d02-6b4e-4713-a8f8-6b00a031d255@linux.dev>
	<21f4ee22-84f0-4d5e-8630-9a889ca11e31@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 18:27:07 +0200 Jesper Dangaard Brouer wrote:
> > iirc, a xdp prog can be attached to a cpumap. The skb can be created by 
> > that xdp prog running on the remote cpu. It should be like a xdp prog 
> > returning a XDP_PASS + an optional skb. The xdp prog can set some fields 
> > in the skb. Other than setting fields in the skb, something else may be 
> > also possible in the future, e.g. look up sk, earlier demux ...etc.
> 
> I have strong reservations about having the BPF program itself trigger
> the SKB allocation. I believe this would fundamentally break the
> performance model that makes cpumap redirect so effective.

See, I have similar concerns about growing struct xdp_frame.

That's why the guiding principle for me would be to make sure that 
the features we add, beyond "classic XDP" as needed by DDoS, are
entirely optional. And if we include the goal of moving skb allocation
out of the driver to the xdp_frame growth, the drivers will sooner or
later unconditionally populate the xdp_frame. Decreasing performance
of "classic XDP"?

> The key to XDP's high performance lies in processing a bulk of
> xdp_frames in a tight loop to amortize costs. The existing cpumap code
> on the remote CPU is already highly optimized for this: it performs bulk
> allocation of SKBs and uses careful prefetching to hide the memory
> latency. Allowing a BPF program to sometimes trigger a heavyweight SKB
> alloc+init (4 cache-line misses) would bypass all these existing
> optimizations. It would introduce significant jitter into the pipeline
> and disrupt the entire bulk-processing model we rely on for performance.
>
> This performance is not just theoretical; 

Somewhat off-topic for the architecture, I think, but do you happen 
to have any real life data for that? IIRC the "listification" was a
moderate success for the skb path.. Or am I misreading and you have
other benefits of a tight processing loop in mind?

