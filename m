Return-Path: <bpf+bounces-65535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F357FB25359
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF3D9A1F9A
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35BE2FF175;
	Wed, 13 Aug 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G6hlxSL2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425F303CAF
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111233; cv=none; b=l8HCV4s6QWW51HZ9HILrj5GZmAFmOXavm2e5D+kMgZxCvjbfEkQvq1WHf/dbCV7o5v0u0yOW3IqPFqYk+laHjJkgzicIn5Ox04svJsyXXcXD3NP5SW53qoqj/VQFHplL9hClnvEOlHwcaEkQBZ/o/vCYxPm9Qz6RK/G4ocPGxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111233; c=relaxed/simple;
	bh=uAIoi3oE2JAfmyQClW7OLg6ZQbAytpR40I4ZrK0A/Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrLG2xlA22hI/WlhoxsCalxhwT4MTARJGhnMYrAt0WsQrq2rO6nrW6NOkeX5p325pqEAon1r/vpQto5Lc+DcOcMQnWebI3JlAWdEnClblv3U5wu01WXUjWpsX+SLtwmPSUCgzp8ohjL2Y9B4zbYsWkoYMc1fqk8fmAF8glr6Q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G6hlxSL2; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-435de5ccff6so125836b6e.0
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755111231; x=1755716031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TqjUBMBvz3ge0UrPwf2mXPDOUtrqy+wU9/W1Le4cwc=;
        b=G6hlxSL2o7oP+USDyuTE1+DfucCYUV/oR/xRPvpSuryts1PEjeBdXWypG9hllHxrxN
         szFvxMauu1JjuCctWPWR+w71Xgt5T4xGEZPoAPrbdjUCbiVoOfRjREiSC40eAGaa7IqN
         PUrZSESwTAOW4OSOFOnYL9DWOc1NAfZFg3wXIgfHk71zXrrZWF/xm8VFZN1jjj3guRhu
         w1ymHQfzBWI7ye+kZUOYlKGKyZBV+B3oqmRyhZgW3t5Zb25UgtkhsFiYhOu7/cwf2P8d
         yjlRwIGfEWZ67T+PmKlPOVGYL3OZlqe/LqgOdT6mUxH3eDE+Qyyg9XxlaSqLifqVzTjv
         tkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755111231; x=1755716031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TqjUBMBvz3ge0UrPwf2mXPDOUtrqy+wU9/W1Le4cwc=;
        b=Kn9Z7COXyb9vzN8NWA5CI1GyB5mGmBRKoLuEC30oaYxuhLGMNsZG7Rs8BwbbWRPcaJ
         Id069X6HA3u77+dCIBZKN2CCFBXyfwfKp5F8cwZpcyU957iU9+zufKY0ESVN+WJZ7qai
         70g46UdLNTt7raCpU8/O+a0kP516FwoDeasZckxnHV+ATpXXBm4Tk3ELEt/YDzxUilk8
         O3Z+0PAAxpdnbZr0J4icDGrFZ49wvkvQ54GHX2fSyX5QqPmJ7hxpmUHXJSQlkgj9/O0w
         hXdvW/XpGjz866fiYDFTJA+jHOzQ4YuaRu1Oei2HsD0k04DxWuYWX21/7Q6CHbYX76oJ
         SHDA==
X-Forwarded-Encrypted: i=1; AJvYcCX4juX9ObIF7326NrqwvfLOCYn9Ey3Il4EGsLH2Nn5OxCeHGU68SPidPW4zvTCzOXbSP50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rWJgDLH8fBCUVsfYU0HUC3IoT9mJj5ESOhs6Njt8X9aHL0Qw
	kwtzq5OdRcI1o+a3SJEQM7mWzvff5DCCdLWg10nN0GGkW8fiEDvmNwCIfnW9BhhLT/A=
X-Gm-Gg: ASbGncucYfKunGKTZ/o0tDh18je+KFbFGwKiwIh8UQG36sEyDhRokXC+f0/lP0oaI3n
	Rn2YBaznydv8tbsnu6/L8TGsd0DkfYl0kafzj8HHTZM4BUV1/B8kAxeSf+7GZJAXnp96m5YiP8n
	G9UrdjPpNLh1HDJrlYwqJCh7jEC8QL4hO9Y2mph4mg8JO76P7qsa+dSDaACfDH55hXna9MhzM/l
	175VzonisMMrNtqa3BPHiVSsb6Cr01W08iw8scTaIn1Gogy6hZVCx4ZCsdgFo8v1TRVWz5fBQL2
	xogDay8/G+6GX17TiNN3jH3q7d7f5sgmw2ysGOgw3s6YcVZfVV1UaMR4whurhGRUhatBA8xL8Uu
	C4s+q
X-Google-Smtp-Source: AGHT+IH+cxAc1P0YpSjpT5GkMD6yTAL+x39p48U9fLHRa1UvuKJNiSxTcXqK8YDOSg3Bw6mNwWToXw==
X-Received: by 2002:a05:6808:f03:b0:40a:526e:5e7a with SMTP id 5614622812f47-435df7c035bmr175396b6e.23.1755111230876;
        Wed, 13 Aug 2025 11:53:50 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::f:384])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce85684csm777268b6e.18.2025.08.13.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:53:50 -0700 (PDT)
Date: Wed, 13 Aug 2025 13:53:48 -0500
From: Chris Arges <carges@cloudflare.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
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
Message-ID: <aJzfPFCTlc35b2Bp@861G6M3>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJuxY9oTtxSn4qZP@861G6M3>

On 2025-08-12 16:25:58, Chris Arges wrote:
> On 2025-08-12 20:19:30, Dragos Tatulea wrote:
> > On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> > > On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> > > 
> > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > index 482d284a1553..484216c7454d 100644
> > > > --- a/kernel/bpf/devmap.c
> > > > +++ b/kernel/bpf/devmap.c
> > > > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > >          /* If not all frames have been transmitted, it is our
> > > >           * responsibility to free them
> > > >           */
> > > > +       xdp_set_return_frame_no_direct();
> > > >          for (i = sent; unlikely(i < to_send); i++)
> > > >                  xdp_return_frame_rx_napi(bq->q[i]);
> > > > +       xdp_clear_return_frame_no_direct();
> > > 
> > > Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> > > "no_direct" fussing?
> > > 
> > > Wouldn't this be the safest way for this function to call frame completion?
> > > It seems like presuming the calling context is napi is wrong?
> > >
> > It would be better indeed. Thanks for removing my horse glasses!
> > 
> > Once Chris verifies that this works for him I can prepare a fix patch.
> >
> Working on that now, I'm testing a kernel with the following change:
> 
> ---
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 3aa002a47..ef86d9e06 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>          * responsibility to free them
>          */
>         for (i = sent; unlikely(i < to_send); i++)
> -               xdp_return_frame_rx_napi(bq->q[i]);
> +               xdp_return_frame(bq->q[i]);
>  
>  out:
>         bq->count = 0;

This patch resolves the issue I was seeing and I am no longer able to
reproduce the issue. I tested for about 2 hours, when the reproducer usually
takes about 1-2 minutes.

--chris


