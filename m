Return-Path: <bpf+bounces-65560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43BB2557B
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3361894A57
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20992D0C81;
	Wed, 13 Aug 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxQOfXCv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B519E81F;
	Wed, 13 Aug 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120707; cv=none; b=d0C7UJ+WVVTYMpqp7OIJKZ0XKOm1/n5J/xvg8K2Tj3curncl5VFyLP0b9fEArnOhI7pf10AxFD5WYF8FfnSyyXZgcalJZzxTjVuQ1jtAkEjs4SWhIGk7Ewwt7Ttddq4pKMmh9VbG1cO9s7zPiKHfRIRxdMxV7c2ApyJ1JyCLDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120707; c=relaxed/simple;
	bh=XyYrWxlMAulbizJRYI5af0ztfwwasQrmniTZnZDkJNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aolGyhXW2vxeFSB7WLpW3smc9zws9BnVBF46M0pZ6HOpzM7pIyWXqz648WEXnrVYqG4zDYwhLb0vWyWS1wSENVWzcg9+9yULeyO3iwTD1w3LcU6NRsEx7KmQa5RifzLB2KYptcxnMdGOuFkdmFy+zuxHjFqPZg9N1IsWoik1mSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxQOfXCv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4716fb8e74so190411a12.0;
        Wed, 13 Aug 2025 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755120705; x=1755725505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvFsXuCoCb48Cj/HqcV4mksaRsmfBU1A9zSpihdNmFA=;
        b=BxQOfXCvuqSOZx5IG4pmKkeGHxQBNZnOpUHuK9tMGezsAp+aNKHnykjDo1cbOCx/3q
         Ka+Kel+iF5RC4Ev6NjWwYxi/Ry93Qt9E0oiwsoMshUSECkgQcwc0mJrnGU0wHcP1kAjT
         pSaPbl79TbnCJIBP+Z06fZLrPpre5exaOEDNlvdpPDsLCFDY2ib+DhxP/zswFV9wvyCr
         WKAcH86tzeTFbRqZR/98PtdbpS746yVqWNVJNXxwobCNSBEFPtVWi6vAyxC0vmKjAYrU
         OU1OpsbEmJyhInnEYAA6fPNpYzzCH0VjRFWYtKdRfNX4LCG3bejvkn/DqP80BBw5sjwN
         X/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120705; x=1755725505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvFsXuCoCb48Cj/HqcV4mksaRsmfBU1A9zSpihdNmFA=;
        b=IYnRcSYbyp38g0ahvR4Rmlzp6fu0UZc0URfmO/e6IZ163/PSHnLcBJF46+TgbV7iU9
         LuEyerc48Em2M4wYB277jAk6qudI7c2IyKf2qlqNyrZf90yx4RoxmV0x3v9n2AuEWTe9
         NHchXeg3zDvvie96ZshGshp0nrcKJBRll2RCEm2bg0lnnmZdfNqdTtzxScdM9Tj28+Ef
         cJ24K9QPy4s3Hj0IaCKq6YGja94jVEuykRqFdT93Nlghw6/UpREiaHsKYmoiandZFthz
         YfGsMLU/myCYk4gI/lOQF+kpH5xuT828rFn9Aix4nOYZWeSgsEDx+XqG+v8VqYDw67Zg
         k9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmMxF1JK8uJu8G+QlJRDKtk/zzz5tQlUN2FsvLaINvJS9CnHkhSxmB66aLp0u3cEc8ejxaVd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWpJirIm3Ga7U9+YRoPFpngvAiR+/1222F0o/PUOJorbfMZML
	Ei5LtH7+ixbrzffqpdBnAVRWe7UYpj5YswnrNIXCi1P0YkVLjKS5upU=
X-Gm-Gg: ASbGnct5PXaK6kHAzO5fD1o8ksskfrtM54b9H1WKyjgDa3sZTlQlx/6qo4MC6YIwi6F
	p31kdrxrt3JXlDDgvpngJZCLWbUQios76WwYQ/PMU0hBKtV2tsaoK92foE81OTgFoO/CF64vwBE
	kItBVgwe3keoJt3Y4IYk3jhQ0nZHMTTwmH4xfskWcjiF51r0riDo9etxjNj3JWm4XLR/cMVrfVx
	b5Dzy39gB//LfSVEfw3leXvbJevuTC38N2S4bUnzdOm5/y8mbeF+zNOs6pv0cAwodlrC+Eoegng
	0y/L1M/xFESADfGqlKgC+xdo7pIttEV3wyjEKGoV8kpZU9EwESElS6UvM/JDoJN28eu2LCG66G8
	ghEWPQqWAprEwMuve/sb7Nib+NTHXyks1JKVwCylffMflLgklCJLw1G1PbOE=
X-Google-Smtp-Source: AGHT+IHtxGnCsok8hMj7qqz+Ev7qOzgroEJdjc+PVQcY6WbM2q16Isw8aqz9kjGdz0iZwGr1k4QO6A==
X-Received: by 2002:a17:902:da92:b0:243:17a:cd48 with SMTP id d9443c01a7336-2445851f038mr10056145ad.17.1755120704880;
        Wed, 13 Aug 2025 14:31:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef66efsm333227725ad.32.2025.08.13.14.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:31:44 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:31:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v4 bpf] xsk: fix immature cq descriptor production
Message-ID: <aJ0EP7Dzl182WE7i@mini-arch>
References: <20250813171210.2205259-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813171210.2205259-1-maciej.fijalkowski@intel.com>

On 08/13, Maciej Fijalkowski wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Introduce struct xsk_addrs which will carry descriptor count with array
> of addresses taken from processed descriptors that will be carried via
> skb_shared_info::destructor_arg. This way we can refer to it within
> xsk_destruct_skb(). In order to mitigate the overhead that will be
> coming from memory allocations, let us introduce kmem_cache of
> xsk_addrs, but be smart about scalability, as assigning unique cache per
> each socket might be expensive.
> 
> Store kmem_cache as percpu variables with embedded refcounting and let
> the xsk code index it by queue id. In case when a NIC#0 already runs
> copy mode xsk socket on queue #10 and user starts a socket on
> <NIC#1,qid#10> tuple, the kmem_cache is reused. Keep the pointer to
> kmem_cache in xdp_sock to avoid accessing bss in data path.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
> 
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> 
> v1:
> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> v2:
> https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> v3:
> https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> 
> v1->v2:
> * store addrs in array carried via destructor_arg instead having them
>   stored in skb headroom; cleaner and less hacky approach;
> v2->v3:
> * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> * set err when xsk_addrs allocation fails (Dan)
> * change xsk_addrs layout to avoid holes
> * free xsk_addrs on error path
> * rebase
> v3->v4:

[..]

> * have kmem_cache as percpu vars

I wonder whether we're over thinking it and should just have one "global"
kmem cache for xsk subsystem. The mm layer should, presumably,
do all that percpu stuff already internally. Have you seen any perf
issues with that approach?

