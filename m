Return-Path: <bpf+bounces-72669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4FC17F3F
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82EF1C286F1
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984A2D839A;
	Wed, 29 Oct 2025 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4kW6trY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB0248176;
	Wed, 29 Oct 2025 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702796; cv=none; b=ld8zywf+bfwjgNFakmEZur29StdOS+FvR6ir0hvAudVaqmIIXEgKak4aFnpxT8B4G2hVw51wLq98REVie/54YdS+yPFXk/oz2/dnmvvMddOhhHllph9edCrmYoorXcfykhRO0N2gj8mjR30xvrGY0eCc4scL1DofV2/zJcBQhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702796; c=relaxed/simple;
	bh=tY2c6NjA5+Sk9Tdpn18jcSFDKBACGQ7NeJaqRR/JFxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbAS3rLXt2ns4pUIVs2g9glZb3+ZXcYqgRxnLO+7yirSiuuMVl/rFAeqRvxFDpn4WulfX0/8eb5RmGA531b/9eWmn9LZdOZqqnNKTlSTJKOOTsA7Xo+QbR3S/BLwXKnEDiq3QQ0ErYp+GmxEDZYo5fAbVZhe8ACxpZu6UThTfWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4kW6trY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64773C4CEE7;
	Wed, 29 Oct 2025 01:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761702796;
	bh=tY2c6NjA5+Sk9Tdpn18jcSFDKBACGQ7NeJaqRR/JFxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4kW6trYvX6IXFW+O8/OQr9KM9ZVIcBYKyeEiZL53Bn9Mo7nue9Qe41YCn1zFxrrh
	 jsxCNd3MNywTTxIsdslY2nYxrBt2c7MZHYiDvbuxHhERQXPzkMxfKdiuC/N8JUezLo
	 rrPJsGPHZSYrBFhiFXXkVc3YiDY77C8Opw1R7Difil9Lic/ytPszan1Nt4P+YjFhH4
	 UAyR7WvnMX0rQPjFia69O4Eo+vs6I00+TvkHAYyzWDiiz/t77YaIIwT8UJwx74AAVV
	 r4o6kkaYL1x6jnoeiYeFpEcIY/Y1Nl9vf5Eyk5oMx4ZF+lJ58msQTOuVIddhtHZbmj
	 QT7VPS9A87A3A==
Date: Tue, 28 Oct 2025 18:53:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
 ilias.apalodimas@linaro.org, toke@redhat.com, lorenzo@kernel.org,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v4 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <20251028185314.1ad62578@kernel.org>
In-Reply-To: <11142984-9bbe-4611-bbe7-fa5494036b8f@kernel.org>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
	<20251027121318.2679226-2-maciej.fijalkowski@intel.com>
	<11142984-9bbe-4611-bbe7-fa5494036b8f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 09:08:52 +0100 Jesper Dangaard Brouer wrote:
> > +	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_head_page(xdp->data)) ?
> > +				MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;  
> 
> We are slowly killing performance with these paper cuts.  The
> information we are looking for should be available via skb->pp_recycle,
> but instead we go lookup the page to deref that memory.  And plus the
> virt_to_head_page() is more expensive than virt_to_page().
> 
> Why don't we check skb->pp_recycle first, and then fall-back to checking
> the page to catch the mentioned problems?

I still think _all_ frags which may end up here are from the per CPU PP
since we CoW the skbs. So:

	DEBUG_NET_WARN_ON_ONCE(!skb->pp_recycle);
	xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;

? It is legal to have pp and non-pp frags in a single skb AFAIK.

