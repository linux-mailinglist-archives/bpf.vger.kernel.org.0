Return-Path: <bpf+bounces-26443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8E89FAF1
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98F928BA62
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B98016E869;
	Wed, 10 Apr 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXma+fnC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89A16192F;
	Wed, 10 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761347; cv=none; b=klTypVn4vvCxAuJzLyG9FfJHSRZSUCqQAVXneAtIjZjP87Y7b4kf0hJbRz1mIiT+CubCRHL5lx5q8q6upsvQPw6bKL2zwL6DkTvqDgsZ8TsVP1JxxpoNzFJRAO/WwjiwXjjEIzV44DvVW2uyAhHxlSDhJrJx6eOb1r8eugdCkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761347; c=relaxed/simple;
	bh=IOowjB6zmv7LWIIHnvL4MTPFjatrAlEyg+PbmUZJMpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5mG68GW0VsA++1jUgyQhJ1u3iO3+rmJusFcUy+QVArmpMM4pyUICeqBVIK72/Dnxr1+t2ZUt63CW9LaTBznG+C7s9FPnRbWzIhKHlzZ/33nfn5oOqtDVl/bK0uKPKfyIObKrOxCsqVp2qkhPyw71gOE38d8WFavE7V5QDRVROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXma+fnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B563C43390;
	Wed, 10 Apr 2024 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712761347;
	bh=IOowjB6zmv7LWIIHnvL4MTPFjatrAlEyg+PbmUZJMpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gXma+fnCrP+8JcafhxFRa8FwqmzMRCM6LT9J47FvXt3BW8mZFWTBRpAU3xsGFCDQW
	 OjWGzbMYCxYOZme9arf3D++/Dj+aAjbdfiyEcrhamdQTpGekuevl5GpW2loZwGooQK
	 3f+jYvPaMLEQZ8FRE3npnk/eQiPY9X9Z+vh0zdFDOA7ZjVkL644A792E+F6KEMp51C
	 5098qAjwdTTAmTriGVmyjqlxkVyi2Dljg79fZ4aISlWHf5LzbC2UwzmHbvjpUgw4dO
	 Xvt2GRE9TR4FACx0cvbn8pTfnWDoxmG36K0J6sjNBr5yPAdybjZjnkXJWI8PQEmuIj
	 SSHZg/INvS7bQ==
Date: Wed, 10 Apr 2024 08:02:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Ratheesh Kannoth <rkannoth@marvell.com>, Naveen
 Mamindlapalli <naveenm@marvell.com>, danishanwar@ti.com,
 yuehaibing@huawei.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH net-next v8 3/3] net: ethernet: ti: am65-cpsw: Add
 minimal XDP support
Message-ID: <20240410080225.2e024f7c@kernel.org>
In-Reply-To: <9cb903df-3e83-409a-aa4b-218742804cc6@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
	<20240223-am65-cpsw-xdp-basic-v8-3-f3421b58da09@baylibre.com>
	<20240409174928.58a7c3f0@kernel.org>
	<9cb903df-3e83-409a-aa4b-218742804cc6@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 16:02:00 +0200 Julien Panis wrote:
> > You shouldn't build the skb upfront any more. Give the page to the HW,
> > once HW sends you a completion - build the skbs. If build fails
> > (allocation failure) just give the page back to HW. If it succeeds,
> > however, you'll get a skb which is far more likely to be cache hot.  
> 
> Not sure I get this point.
> 
> "Give the page to the HW" = Do you mean that I should dma_map_single()
> a full page (|PAGE_SIZE|) in am65_cpsw_nuss_rx_push() ?

Yes, I think so. I think that's what you effectively do now anyway,
you just limit the len and wrap it in an skb. But
am65_cpsw_nuss_rx_push() will effectively get that page back from
skb->data and map it.

