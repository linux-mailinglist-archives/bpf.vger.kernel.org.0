Return-Path: <bpf+bounces-46806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04A9F027F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373FB188440A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A942A92;
	Fri, 13 Dec 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iblInRZw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530D846F;
	Fri, 13 Dec 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734055891; cv=none; b=eD7LHlohXeyx00QdIl4R/1L/zRHMsFDvOLmX/ILLQIfr2rfmPbTry/SCPtbmiiuGpvqUxlYrbHa/ZTJ9dRSVjNg7ehgbwKO5hvhuehP4pDOoMeUIOjlSfAoXiVyQrsqiSIBwALG8tcKsydoW6Blyw3x3BEqrrLCxJzwouHeYkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734055891; c=relaxed/simple;
	bh=MCm3XtnbsE1H2aeVlhuGSuuBQRvpkl0io+wcdYVc0ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPYOw4F8qh4h5R1tAYtKCw1AwMGoIA+CaR15BVpklRnud0XVxU+C0tBu3kzVMfH5pFGF81ykZoimz/6OU8ORf9yjiEDveZ0zLEGFFBm7HukjX2wZ1WCcudv2KwjIcnApvhD5zOXd1Uw0SzmSSo72zNM0a5UYSQuOLrK7T9bHqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iblInRZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2721AC4CECE;
	Fri, 13 Dec 2024 02:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734055891;
	bh=MCm3XtnbsE1H2aeVlhuGSuuBQRvpkl0io+wcdYVc0ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iblInRZwn9weLIHdDCy3jIZbhY/hDHqQ4axl5kEF/xs63yQGPDZ5uHX2Zr5AMwS4U
	 1Oubb4ajZPQoeE/HMZcZ3aEzvV8Iagj2IRmVrl+YIH1pMUkmXW08W3XhfkEIIOSNzH
	 +yO18CebZmciLwkM4Zl0jAsxoaGVf/TSQicJ0ItbTZUEhNQGOqWIDMSnDvyfyUr44Q
	 u3Tfp43IawQOYQ/fCTzoU985byTKYEaFL8jOnDu22WMnH4JbcywHWgWfa2VBnFpp7l
	 UHW/vRM+5lWGA8QqWaZZdkxIZAHMhF/N60G7zT+fQCabdggJq169TNR+qTPcGPxCuD
	 Q2c++WgKESFzg==
Date: Thu, 12 Dec 2024 18:11:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, Casey
 Schaufler <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] xdp: add generic
 xdp_build_skb_from_buff()
Message-ID: <20241212181129.7156d39b@kernel.org>
In-Reply-To: <20241211172649.761483-6-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
	<20241211172649.761483-6-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 18:26:42 +0100 Alexander Lobakin wrote:
> +	if (rxq->mem.type == MEM_TYPE_PAGE_POOL && is_page_pool_compiled_in())
> +		skb_mark_for_recycle(skb);

I feel like the check for mem.type is unnecessary. I can't think of 
a driver that would build a skb out of pp pages, and not own pp
refs on those pages. Setting pp_recycle on non-pp skb should be safe,
even if slightly wasteful.

Also:

static inline void skb_mark_for_recycle(struct sk_buff *skb)
{
#ifdef CONFIG_PAGE_POOL
	skb->pp_recycle = 1;
#endif
}

You don't have to check if PP is complied in explicitly.

