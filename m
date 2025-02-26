Return-Path: <bpf+bounces-52603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21115A452BE
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AB61723C2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 02:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DE2163BC;
	Wed, 26 Feb 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IUCxd0zP"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EF2153DF
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535558; cv=none; b=UGZN/qFFX5P8i2OSGV/egbt32VrhW084A99/e00ZLVezQfXCe/rQiOrqMGVxjs2/+rFdT4vY42+BD2sc/SEqSPI609PuUAeMfkIOEdzwwG5OL+LDtfD1D+QejQbSIt7Hw7SuKvHugt94pI/n8rlOjM8fMCpfpQ7B/nIi9G1KrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535558; c=relaxed/simple;
	bh=iJOCQ8aw1IEykjklMH8GAkpCx4MPH93Uc2wtN4rI0vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmV/+N1cX6Q9+sqJiV2nZUx8OwKWeKXdyp83beTe2ennkHWFnQfTYronj07iNS9WCk5ZPeWnxXVZgmPxameCxZ2k/9bc3cgnjR1juduv1rchtGQzNOq2brtrUcPHvLpCaY1ABWSGJKZeNICYnm7Ad8oVH42+rIVZ2wmX5ohCGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IUCxd0zP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 10:05:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740535544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2InZiHRdM6XrQyr0YXK7Ye34C5iSC5C9RMH5yQmJxxA=;
	b=IUCxd0zP7R51JXgOtxvV2udhm6CEgmd8Z2BCG+EpuzyFL6qbp1kIvparpihw+HU3g1VEh5
	INKn2YrOf7L8wf8kIzpU13KvfUd3zTlJbTuPxyO+GOPE5OC29pNAij+MkM7HQDGAdpmBoA
	HaeZ++Sns+Lg/nQMEMGV+1V2XN+Xx6Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: horms@kernel.org, kuba@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, ricardo@marliere.net, 
	viro@zeniv.linux.org.uk, dmantipov@yandex.ru, aleksander.lobakin@intel.com, 
	linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, mrpre@163.com, 
	syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next 1/1] ppp: Fix KMSAN warning by initializing
 2-byte header
Message-ID: <ktitxr3td73rdoqpum2dntizbxn6di73sptx5mqrp5hppfjaqk@crugooi3shdf>
References: <20250225144004.277169-1-jiayuan.chen@linux.dev>
 <20250225144004.277169-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225144004.277169-2-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 10:40:04PM +0800, Jiayuan Chen wrote:
>   * An instance of /dev/ppp can be associated with either a ppp
>   * interface unit or a ppp channel.  In both cases, file->private_data
> @@ -1762,10 +1766,15 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
>  
>  	if (proto < 0x8000) {
>  #ifdef CONFIG_PPP_FILTER
> -		/* check if we should pass this packet */
> -		/* the filter instructions are constructed assuming
> -		   a four-byte PPP header on each packet */
> -		*(u8 *)skb_push(skb, 2) = 1;
> +		/* Check if we should pass this packet.
> +		 * The filter instructions are constructed assuming
> +		 * a four-byte PPP header on each packet. The first byte
> +		 * indicates the direction, and the second byte is meaningless,
> +		 * but we still need to initialize it to prevent crafted BPF
> +		 * programs from reading them which would cause reading of
> +		 * uninitialized data.
> +		 */
> +		*(u16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
>  		if (ppp->pass_filter &&
>  		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
>  			if (ppp->debug & 1)
> -- 
> 2.47.1
>
My apologize, it will raise Sparse check WARNING:
  drivers/net/ppp/ppp_generic.c:1777:42: warning: incorrect type in assignment (different base types)
  drivers/net/ppp/ppp_generic.c:1777:42:    expected unsigned short [usertype]
  drivers/net/ppp/ppp_generic.c:1777:42:    got restricted __be16 [usertype]

A new revision is here, all check passed:
https://lore.kernel.org/all/20250226013658.891214-1-jiayuan.chen@linux.dev/

pw-bot: cr 

