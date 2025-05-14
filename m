Return-Path: <bpf+bounces-58247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 798ADAB77E9
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BB67AFA6C
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B829672E;
	Wed, 14 May 2025 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwPrqiFm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A221F0E47;
	Wed, 14 May 2025 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257982; cv=none; b=U6U5yxer5mEQ+3Dgp/JQ0GozWgmcziZXzQGcB10/8ZIL1Fk3DiviaQj5gPJhDGrDGPmuG61XByQRDH5V38wjWKlSEuB+MzuFDxhDWtnCEVCwbh9AWMkMotYa002AFXv6NPVjLoiIBdCEiIDzRHLr6DOdhbJ2HmN/r10cPi6TfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257982; c=relaxed/simple;
	bh=oHrnHkrqzyYWJmEJgmA6mr3tiaYEXhO71LpqQPadZMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N44EJNENdq9t0sTdiqRonAguhkywtEflVn4RRmAi5Y7y2xTr5emeNKSIqSOatT7iQ3FI5QaayTomI6a1J+S6Ydfqq1R4N1C7NHUrct9WQcgIbTJijn0CoOU61/hZfxXIhGBtczQi2jakmpVqrBevVw2QeYTv16q8CrQDSmUX7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwPrqiFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26029C4CEE3;
	Wed, 14 May 2025 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747257981;
	bh=oHrnHkrqzyYWJmEJgmA6mr3tiaYEXhO71LpqQPadZMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AwPrqiFmrlH7DA8KXHltGT0FlM32sqUkPfeLzeEjB7IfRQ+rcTIE94qByvgw2cIGC
	 syT64FUId+MJ2eP5enteINF9kdHf95LWXfyANqO/LLd8SxxqpsyRF8BNfXXmStYCCB
	 NU5x0Y3nUv3usiQDxuAmin6iVdPp6F+72CYgy7OX+sA/Zxkckyps3EwFA0w/bR5DlR
	 IqeAiM6vZEar2Yi9A1PQUNJVsG/xgob1oWDDriAAkaK7DI79EJ4bsHhPUCincMUYpd
	 SfFnW+CvbV0ugy5JI43ol+mXCjE3jTBMN5pnQZQbQHriiRWO3xWRkQDPft+L/2JzkO
	 ljFUlI9l6ceag==
Date: Wed, 14 May 2025 14:26:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <eric.dumazet@gmail.com>, <horms@kernel.org>, <jonesrick@google.com>,
 <ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <weiwan@google.com>
Subject: Re: [PATCH net-next 11/11] tcp: increase tcp_rmem[2] to 32 MB
Message-ID: <20250514142620.63937885@kernel.org>
In-Reply-To: <20250514212210.82672-1-kuniyu@amazon.com>
References: <20250514205348.78733-1-kuniyu@amazon.com>
	<20250514212210.82672-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 14:20:05 -0700 Kuniyuki Iwashima wrote:
> > It seems ACK was not handled by BPF at tc hook on lo.
> > 
> > ACK was not sent or tcp_load_headers() failed to parse it ?
> > both sounds unlikely though.
> > 
> > Will try to reproduce it.  
> 
> I hard-coded the expected TCPOPT_WINDOW to be 7, and this
> series bumps it to 10, so SYN was dropped as invalid.
> 
> This fixes the failure, and I think it's not a blocker.
> 
> ---8<---
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> index eb5cca1fce16..7d5293de1952 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> @@ -294,7 +294,9 @@ static int tcp_validate_sysctl(struct tcp_syncookie *ctx)
>  	    (ctx->ipv6 && ctx->attrs.mss != MSS_LOCAL_IPV6))
>  		goto err;
>  
> -	if (!ctx->attrs.wscale_ok || ctx->attrs.snd_wscale != 7)
> +	if (!ctx->attrs.wscale_ok ||
> +	    !ctx->attrs.snd_wscale ||
> +	    ctx->attrs.snd_wscale >= BPF_SYNCOOKIE_WSCALE_MASK)
>  		goto err;
>  
>  	if (!ctx->attrs.tstamp_ok)

Awesome, could you submit officially? As soon as your fix is in
patchwork I can return Eric's series into the testing branch.

