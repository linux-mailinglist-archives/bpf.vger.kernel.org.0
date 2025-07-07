Return-Path: <bpf+bounces-62546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B888AFBAE5
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 20:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C733A7BB3
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B7E264615;
	Mon,  7 Jul 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGc3YHbH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617C1A23B5;
	Mon,  7 Jul 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913652; cv=none; b=rhISqMIaXvgfDPCwWBd/qdgkdRb9aFuf44tlSh06NVkoFP5kMkk+JGWRC98N7CIqRkZjWdvhw/f1pG6DaSjPhU4U1yUtIsj2fWkDRTI+TkJnY82vHoK3Hb9KRvvjmSaCXhLaoJLDQ0xOVF920tJPU7PNzuEg44Bg4cBI8Lk8N1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913652; c=relaxed/simple;
	bh=mfmMFktQD0ZumZuLVBsAXdJ1L/VzNbE3C/RP14EIN7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeDGHM/2/Da19xmjRrhi/YPsh5suPBK3PoMbfVx4wfGx0jNqePVmAFciK+p6Wbc5FGpdLVcsBSULa3CM+Z+jiHn86OaWaksltUlXehRJH9V3d0hzlpekJcXPItAK7Mu5FqQY69ell+caKQz75om1s7Qr/q0o6hg/K0SDnYpFPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGc3YHbH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso4228459b3a.2;
        Mon, 07 Jul 2025 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751913650; x=1752518450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yud3d2OZCuNl+KgLK0mLXVJkuhjTWYvZEX6Yy8M/foQ=;
        b=YGc3YHbHaWCBvY8EDylZmJOCIJQclvXoaCAqzfMQFo3GDW5oMiF53V49kr5UgRYWO1
         mMd9vil1dcccSXY6W1mX3SlZ7N/eWJ+j2AKPFSvVp2zeSxY+acYENLUMDpMUkSeZWIMx
         dCMaJyvxTD1XjOglnaNgHyKqokqKicHbh1tGvCTCr61tdtg0GhQOlmkBc9wAtbM79xzm
         a8gmNRtfuW7eEw8Dp4RfMvqpDc+X+u+ZegnQPUwTYELMcwgH9I5Xxel0TGSzd6/1LkAF
         3EDB1NJeancQfy+thaHWmd6nXmEG+5hc70X9o4rrKCvxz+AaxWtGEeImF9cCid3tZAgO
         gRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913650; x=1752518450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yud3d2OZCuNl+KgLK0mLXVJkuhjTWYvZEX6Yy8M/foQ=;
        b=KLaaFEXqz7WhT7VDzoHxn4TfSgkEU+9jG41yDWg9vOGvqWklUAEpp9XC/lsautofWi
         9fA+aDaWH2ROjjBZdn98xy/82PCjLOy/HBqXU0vB/0cQ+TqBcpUsOuCUrXhEFSmDHSrs
         xdtGGZ4zXTinT0y8vYUxKbHfs/ETtRaDPcJR6ruwG8VgsPPNM62ufGTXMWSB+peXY845
         6b9tlZmnoCqSisTK88eh67uOFDU/SMiuID8Sak+x+y05Q48JxRys2dkm7d7a61FkSpyH
         OX3AU5x2pWrlFfcFoQlz1GoNglugo2jVWaijCIEOuxGKBlCevh4g6ARTV+DsoGsgBBRo
         34qg==
X-Forwarded-Encrypted: i=1; AJvYcCV/yE0DOd5lGQvx0yGUc9UF0+zDKc0PrTgqWYGMxy1bns8G4m6t2HRfr+tky6OsmZ4odtk=@vger.kernel.org, AJvYcCVscTY2G1kKHPPD3eOh+/J0eNvrz/9dt6UsehhdB5320dWIj5I46H+p9AMGupqaI0sfkzLDGyP6@vger.kernel.org
X-Gm-Message-State: AOJu0YxphkyiP1mPsUFlfvQqYDbz9xXi/YM46IKex2Yk37+9Oap9ewog
	/M3xpPx4Wf+/LKawrnKUDaqZYqgtENoyik9spHjmBWY2iweWCqm37em7aVGi
X-Gm-Gg: ASbGnctRVpCN0iZDU4fTNOQ53zwy8IQE0B9OEj0pxzZFnD3f6dToSv4Y04dHdSslZAI
	xHd8Ec9zGbiJqcb+a4deAJOwvy5G+gCbTw/CTCK5xqf2Jk6hVpqE6cJ660bUZm4axA8Kdq13zFk
	DPWcX1fGf+qDG3Wnmp55btiNU3KKE+cM4tnbvernfEWbYy10sO0INkLWU6Zgg1siWiMvgffIv7U
	k3t5I/xo/AKk5t78xsEfvHfQQWn+42qUDIk64AmM/RvBHS6BOLqJN8FpcsS595Ut84AfRUfqRu4
	i0YqZUXebXEjhsLDQbYMUgImMPSXfm3jzN2Z2tioUnK+DDYnMJP+EQw/It5PFnUTJubz4nYuDc2
	blyYktY0VgUQjyPiAsGnVaOM=
X-Google-Smtp-Source: AGHT+IE1gmpuqMY5p4RMu7AMPSIrUH5rXM11eVlzEyLrBgoQgcWfRblXzxdahn/Q2p8GPHGecKfEEQ==
X-Received: by 2002:a05:6a00:986:b0:748:3385:a4a with SMTP id d2e1a72fcca58-74ce66d56c3mr17960816b3a.23.1751913649717;
        Mon, 07 Jul 2025 11:40:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce4180e47sm9916142b3a.103.2025.07.07.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:40:49 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:40:48 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	netdev@vger.kernel.org, magnus.karlsson@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
Message-ID: <aGwUsDK0u3vegaYq@mini-arch>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
 <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com>
 <aGvibV5TkUBEmdWV@mini-arch>
 <a113fe79-fa76-4952-81e4-f011147de8a3@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a113fe79-fa76-4952-81e4-f011147de8a3@intel.com>

On 07/07, Alexander Lobakin wrote:
> From: Stanislav Fomichev <stfomichev@gmail.com>
> Date: Mon, 7 Jul 2025 08:06:21 -0700
> 
> > On 07/07, Alexander Lobakin wrote:
> >> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >> Date: Sat,  5 Jul 2025 15:55:12 +0200
> >>
> >>> Eryk reported an issue that I have put under Closes: tag, related to
> >>> umem addrs being prematurely produced onto pool's completion queue.
> >>> Let us make the skb's destructor responsible for producing all addrs
> >>> that given skb used.
> >>>
> >>> Commit from fixes tag introduced the buggy behavior, it was not broken
> >>> from day 1, but rather when xsk multi-buffer got introduced.
> >>>
> >>> Introduce a struct which will carry descriptor count with array of
> >>> addresses taken from processed descriptors that will be carried via
> >>> skb_shared_info::destructor_arg. This way we can refer to it within
> >>> xsk_destruct_skb().
> >>>
> >>> To summarize, behavior is changed from:
> >>> - produce addr to cq, increase cq's cached_prod
> >>> - increment descriptor count and store it on
> >>> - (xmit and rest of path...)
> >>>   skb_shared_info::destructor_arg
> >>> - use destructor_arg on skb destructor to update global state of cq
> >>>   producer
> >>>
> >>> to the following:
> >>> - increment cq's cached_prod
> >>> - increment descriptor count, save xdp_desc::addr in custom array and
> >>>   store this custom array on skb_shared_info::destructor_arg
> >>> - (xmit and rest of path...)
> >>> - use destructor_arg on skb destructor to walk the array of addrs and
> >>>   write them to cq and finally update global state of cq producer
> >>>
> >>> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> >>> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> >>> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> >>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >>> ---
> >>> v1:
> >>> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> >>>
> >>> v1->v2:
> >>> * store addrs in array carried via destructor_arg instead having them
> >>>   stored in skb headroom; cleaner and less hacky approach;
> >>
> >> Might look cleaner, but what about the performance given that you're
> >> adding a memory allocation?
> >>
> >> (I realize that's only for the skb mode, still)
> >>
> >> Yeah we anyway allocate an skb and may even copy the whole frame, just
> >> curious.
> >> I could recommend using skb->cb for that, but its 48 bytes would cover
> >> only 6 addresses =\
> 
> BTW isn't num_descs from that new structure would be the same as
> shinfo->nr_frags + 1 (or just nr_frags for xsk_build_skb_zerocopy())?

So you're saying we don't need to store it? Agreed. But storing the rest
in cb still might be problematic with kconfig-configurable MAX_SKB_FRAGS?

> > Can we pre-allocate an array of xsk_addrs during xsk_bind (the number of
> > xsk_addrs is bound by the tx ring size)? Then we can remove the alloc on tx
> > and replace it with some code to manage that pool of xsk_addrs..
> 
> Nice idea BTW.
> 
> We could even use system per-cpu Page Pools to allocate these structs*
> :D It wouldn't waste 1 page per one struct as PP is frag-aware and has
> API for allocating only a small frag.
> 
> Headroom stuff was also ok to me: we either way allocate a new skb, so
> we could allocate it with a bit bigger headroom and put that table there
> being sure that nobody will overwrite it (some drivers insert special
> headers or descriptors in front of the actual skb->data).
> 
> [*] Offtop: we could also use system PP to allocate skbs in
> xsk_build_skb() just like it's done in xdp_build_skb_from_zc() +
> xdp_copy_frags_from_zc() -- no way to avoid memcpy(), but the payload
> buffers would be recycled then.

Or maybe kmem_cache_alloc_node with a custom cache is good enough?
Headroom also feels ok if we store the whole xsk_addrs struct in it.

