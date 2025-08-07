Return-Path: <bpf+bounces-65218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F7B1DBEC
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680D91AA1543
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD6272805;
	Thu,  7 Aug 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HZjUotyy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BE194A65
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585145; cv=none; b=qsnf5LPBw7m19LkhczBZ+Y+XLW5ksKSHbJy+j/COyxHvNeJg0ITXXsc/ugJJ0RFPWmdnd/aIuekFdfd3tcCCvFzN0ucwIeXmeWwZ/Enpo0gI5mVNaqecVZ5yaqvt8VTTHG0FQ45KXIkKoUgBMepVfVb+8P3nmISwKRaiyKKollU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585145; c=relaxed/simple;
	bh=CnCcxSc5PyfZpc2RaREPR93y6r5jTf/jZooMWVREm6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h79d9f2GPVeoTyjFbv4pWT7eQohrkBIXYDYT9Ofn2j1UD4jovXgzSETi9zdxXUAPfo7V1rUwJ2kF1n4N95qapVkDv/TWGACPKHY/fDfzuy7cdyawSMgmIcgXtaYy5vbG9Lu8rtwVxNTT851tZpdpzQLcEDsggVQEBlEwhdSV1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HZjUotyy; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-433f78705b3so907285b6e.2
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754585143; x=1755189943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSPhIT8x221qe9Xtn++QCR/NM+n6LYzd3EnXHKIl8rI=;
        b=HZjUotyy4QfMHoakY6sOTCcI/cCKM453RDgUQXATVAIgLB33jvsuNnq/r+H9KpMm0Z
         FT4/IhkdXOhwiPc+aqxkWBDtYMQMCw3UjVGc1yiIrTEIciYcjULmwqePXHqEFdDGfMBS
         S5NidSrCszfU5kozHWRF35ChvvkIab8A6oO3QONgTG/ibgZboEszVdJHNYyN9XCqTLkt
         xN10YWaFZ1ftXV2FSFonJiGpxXK6XDZEB2cziNlTFq5cuOL0BhRuJDMMSaB0OmZ0MfoT
         AqRQ0Dpy7BAzIzqFJ2xLBsH3fu+XV7neqJQ4lYiv1kSkjGo0k1xZ9RFf1JsUtd/QbL5O
         3k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754585143; x=1755189943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSPhIT8x221qe9Xtn++QCR/NM+n6LYzd3EnXHKIl8rI=;
        b=OhYTqANHDfM7b0VJ4HujJS3Yv1AA46aVlbreCoXQvCUrIzGT3mtrLkn9i2fec5rP8C
         I7HMwZKJ0rooeM6hsGK4oYgCE/jYfXqGFhYtRQYMGf3GUAjBj3aymKWNQc8aZ0LI0N7k
         er4oqdIlXuAYEQ1xLnqVlolMhBatmvMEWGJbD3jVCUJGalOYDV0CkaBx/mFCWiu6CcXH
         0XkFQ4rsNKU+J/rWxSf7HImnrnoQMxOV5IZAPV+QS0kGhiOm7sYLM60wWhyuFcbJY9Pp
         vwHaPQN+w1TCR4p3pAaLUiFwOGjLTSJ+dsYRCxfBJhSiUpLtBqAFWZznRYM/q/Td54Fm
         HOMw==
X-Forwarded-Encrypted: i=1; AJvYcCWESIqoQjxOZScwjVBymIV0cIKB0ih0WY4A99euOfSxkC2uheD9zJSSuUmaMnXkDt3oP2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqdVFA6qeii3t8vcQpPq8i0Q4ctkzNGM+AnDcCZKv2tJBp7i2
	TODDMOuGoF6Ga6JbuVjhvKAFJtosDfDu1t0MW6QYtRnCZ0MtcTdqY+DXtQH9Wj2on3k=
X-Gm-Gg: ASbGncvI3+RS2jOC4KE3hpqX7KU0M5nQsR8ZbcZ/esdfoyytlDROsvybqAeEUeH0aT2
	Utx+OsMJM7WhUY+QzVIcnL0w1NPcvQ67s63nrHf08+y7bLDPsym7p42PgX4U6nUMAEAgjcw8XQX
	EjXNaB2P26F+anD3Cut0EWgX42bxB2xv8K0ue/uKZ7uf96E6bZx4tdwnNMcgkuC4/V42tFEgpd+
	UqZGVw87QQQVMO1FYBzn+tk4kW2sW+ZqCU/bGw30NXGziURjsKGvcTJDXFB27SKY0R4WrSysOff
	Esk0ar0NAyvbaPcPjAVk/Jc6N4m8i9Upq3Ah9jyem+JJdCqk5DAJa6VBP8tvMoUwPYj1ppbFqh1
	vnONWDg==
X-Google-Smtp-Source: AGHT+IEoPnNiQABRJDDD+catLqplRdC9PpEz+vHd9z1lMFuvZdMmuQHXf9lqya9dZt+r1C+IumFskA==
X-Received: by 2002:a05:6808:1929:b0:434:8f2:d95 with SMTP id 5614622812f47-4357c616d71mr3729812b6e.33.1754585142979;
        Thu, 07 Aug 2025 09:45:42 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::22d:91])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30b93b644d9sm3171722fac.30.2025.08.07.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 09:45:42 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:45:40 -0500
From: Chris Arges <carges@cloudflare.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com,
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Rzeznik <arzeznik@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <aJTYNG1AroAnvV31@861G6M3>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>

On 2025-07-24 17:01:16, Dragos Tatulea wrote:
> On Wed, Jul 23, 2025 at 01:48:07PM -0500, Chris Arges wrote:
> > 
> > Ok, we can reproduce this problem!
> > 
> > I tried to simplify this reproducer, but it seems like what's needed is:
> > - xdp program attached to mlx5 NIC
> > - cpumap redirect
> > - device redirect (map or just bpf_redirect)
> > - frame gets turned into an skb
> > Then from another machine send many flows of UDP traffic to trigger the problem.
> > 
> > I've put together a program that reproduces the issue here:
> > - https://github.com/arges/xdp-redirector
> >
> Much appreciated! I fumbled around initially, not managing to get
> traffic to the xdp_devmap stage. But further debugging revealed that GRO
> needs to be enabled on the veth devices for XDP redir to work to the
> xdp_devmap. After that I managed to reproduce your issue.
> 
> Now I can start looking into it.
> 

Dragos,

There was a similar reference counting issue identified in:
https://lore.kernel.org/all/20250801170754.2439577-1-kuba@kernel.org/

Part of the commit message mentioned:
> Unfortunately for fbnic since commit f7dc3248dcfb ("skbuff: Optimization
> of SKB coalescing for page pool") core _may_ actually take two extra
> pp refcounts, if one of them is returned before driver gives up the bias
> the ret < 0 check in page_pool_unref_netmem() will trigger.

In order to help debug the mlx5 issue caused by xdp redirection, I built a
kernel with commit f7dc3248dcfb reverted, but unfortunately I was still able
to reproduce the issue.

I am happy to try some other experiments, or if there are other ideas you have.

Thanks,
--chris

