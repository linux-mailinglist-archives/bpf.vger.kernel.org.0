Return-Path: <bpf+bounces-65094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9529BB1BD9B
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 01:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23B51673A3
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 23:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69E2BDC24;
	Tue,  5 Aug 2025 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV++HVao"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C623C8AA;
	Tue,  5 Aug 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438057; cv=none; b=YiKkEY9oEfAqXB0GQZPUjdhaHlo5WTXGktlXFXYM9YjkYBGV0oywc9mCFrwoxexW+uOODTdYr6UAQBjZ9pRx6iZisDanwujwYdHW0xb9cBKSb3fNIzKpS9EEf1VRXd65yKEV4REVVSW32+EpRzjlyYygeBJuOt7xqFpkz6bNi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438057; c=relaxed/simple;
	bh=7X9W3We3NWsmY4+eufCtinLLAGXHGhJ5FW/kGMQbtPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwXet49caF+fV7xxsm9ATZhogI5B46CAz9MBvNbZHKAxJCVCTCWpud4mc9+g6SqS/NXTR9nw+0zlsxkASy4a0t+WSkCEY1w227Lc3Kr8dJhzRw+mr7llJuLXHW07zR+VvkqkbXiIH7pmFQLoRbUNeU+2OfYEAzYmG/nj6Ln3wXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV++HVao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC31C4CEF0;
	Tue,  5 Aug 2025 23:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754438056;
	bh=7X9W3We3NWsmY4+eufCtinLLAGXHGhJ5FW/kGMQbtPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YV++HVaomwhS7PiSRdY+TWh8cEcAh6VOJfdA3SdtEuGw0YYhE+TbkaDYgnPeWbCOR
	 tqvDMMx2p7PIoM4STIxgye9b8PCMxbnM/WQZfo5lkaHuqPJ2SrBKZ6f9b5yKMeAwHP
	 beN2YprFySqA2ut7+bSED319ff7+BM9/ReQYi57jBR8vNDHdWoGfKxFODhJmPO4xoX
	 NRVZOlPtMI8fLUaJwo+ekTFWG6cGlb4y9a9d3O+hqNuY8YWVIOP4LA2Ebi1NsHCo5q
	 AuiApcVgl0wL3MzukEnE8x34Pmnja3tu9yp0YBRJiJlkBP3snUWAuVh5Wp0CFSSt3L
	 703oUiTWUGVEQ==
Date: Tue, 5 Aug 2025 16:54:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250805165414.032db0b1@kernel.org>
In-Reply-To: <aJIEvK0CU_BqqgPQ@lore-rh-laptop>
References: <aHeKYZY7l2i1xwel@lore-desk>
	<20250716142015.0b309c71@kernel.org>
	<fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
	<20250717182534.4f305f8a@kernel.org>
	<ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
	<20250721181344.24d47fa3@kernel.org>
	<aIdWjTCM1nOjiWfC@lore-desk>
	<20250728092956.24a7d09b@kernel.org>
	<aIvdlJts5JQLuzLE@lore-rh-laptop>
	<20250801134045.4344cb44@kernel.org>
	<aJIEvK0CU_BqqgPQ@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Aug 2025 15:18:52 +0200 Lorenzo Bianconi wrote:
> > I was thinking of doing the SET on the veth side. Basically the
> > metadata has to be understood by the stack only at the xdp->skb
> > transition point. So we can delay the SET until that moment, carrying
> > the information in program-specific format.  
> 
> ack, I am fine to delay the translation of the HW metadata from a HW
> specific format (the one contained in the DMA descriptor) to the network one
> when they are consumed to create the SKB (the veth driver in this case) but I
> guess we need to copy the info contained in the DMA descriptor into a buffer
> that is still valid when veth driver consumes them since the DMA descriptor
> can be no longer available at that time. Do you agree or am I missing
> something?

That's right, we need to carry the metadata we need with the packet
(in an XDP program-specific md prepend, presumably).

