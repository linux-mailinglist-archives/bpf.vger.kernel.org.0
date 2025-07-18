Return-Path: <bpf+bounces-63683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07AB09920
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 03:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A1A1C28143
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A19C17C21C;
	Fri, 18 Jul 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuoU2Ub/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC1135A53;
	Fri, 18 Jul 2025 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752801936; cv=none; b=ZAQZWLceKTMaLuMUFxYbv8Lq5+LU72Dri2ocPvuiEvaN3wtzsUBGmnrv/7bKRa9HduR/2hICP86gBKUMMES1vBk89oO6Uq2Pegbry4hzb2EAf+5l+V0o++nxqMte6F6J+ZJfWzN3nJJ4NWfrRxFIVOch9rgfImlCf6gQSGYxZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752801936; c=relaxed/simple;
	bh=CxMAjD1zroYQplZpLU6sbWSK/9q8dMW0wxkbYj+eLCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evwHKN8QsZ/vdRghMp7pxV578G93KGgVZesF6WAeV/QyJ7mUC23RSbj2KqYh83kpcRG6o6jmK40X5KmMUSdu+q/U7B7HQvjUhHLFwoQZLGKWNwQOw4JNdAN8KG6g1yGD6ToTMegq5LZHtaZoRDF8scgcYXINqvg2HD4P+5JiQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuoU2Ub/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66F1C4CEE3;
	Fri, 18 Jul 2025 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752801936;
	bh=CxMAjD1zroYQplZpLU6sbWSK/9q8dMW0wxkbYj+eLCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZuoU2Ub/3V9GpfWqKdFdWRo0T98iUMvSHK3rOifJW3Daa7SbIW2YBnnwLWB+s3zzi
	 NvLJ9wFbifxIeE4r+a94RObMrDzur4SNZ+uOGLBhT4NpmHn/FMT9AmRKfyeYcY4rO4
	 74Z88C+wadd/AOkT9HFVSaB5T41KICW8e6IVisZNKb+wTDroA6t3zyyckz3O0Li4D7
	 V5iKuOuCVjgp3GvO2UrLMahwIAbVttPfWa+kF5Tsw85q51Ss/80vEKKZnud0EyOksP
	 DTK2xM+WrFdtwhPd/BU1/nb37hLRzPDIVn7R4oxh/Kl/sy4ssG+q37dz5XVrzk1nH7
	 Mh7Zo45fMxeBw==
Date: Thu, 17 Jul 2025 18:25:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250717182534.4f305f8a@kernel.org>
In-Reply-To: <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
	<aGVY2MQ18BWOisWa@mini-arch>
	<b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
	<aGvcb53APFXR8eJb@mini-arch>
	<aG427EcHHn9yxaDv@lore-desk>
	<aHE2F1FJlYc37eIz@mini-arch>
	<aHeKYZY7l2i1xwel@lore-desk>
	<20250716142015.0b309c71@kernel.org>
	<fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 15:08:49 +0200 Jesper Dangaard Brouer wrote:
> Let me explain why it is a bad idea of writing into the RX descriptors.
> The DMA descriptors are allocated as coherent DMA (dma_alloc_coherent).
> This is memory that is shared with the NIC hardware device, which
> implies cache-line coherence.  NIC performance is tightly coupled to
> limiting cache misses for descriptors.  One common trick is to pack more
> descriptors into a single cache-line.  Thus, if we start to write into
> the current RX-descriptor, then we invalidate that cache-line seen from
> the device, and next RX-descriptor (from this cache-line) will be in an
> unfortunate coherent state.  Behind the scene this might lead to some
> extra PCIe transactions.
> 
> By writing to the xdp_frame, we don't have to modify the DMA descriptors
> directly and risk invalidating cache lines for the NIC.

I thought you main use case is redirected packets. In which case it's
the _remote_ end that's writing its metadata, if it's veth it's
obviously not going to be doing it into DMA coherent memory.

The metadata travels between the source and destination in program-
-defined format.

> Thanks for the feedback. I can see why you'd be concerned about adding
> another adhoc scheme or making xdp_frame grow into a "para-skb".
> 
> However, I'd like to frame this as part of a long-term plan we've been
> calling the "mini-SKB" concept. This isn't a new idea, but a
> continuation of architectural discussions from as far back as [2016].

My understanding is that while this was floated as a plan by some,
nobody came up with a clean way of implementing it.

