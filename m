Return-Path: <bpf+bounces-27158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A580A8AA245
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D6B1F21994
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484817AD71;
	Thu, 18 Apr 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQRW0RMh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C61168B17;
	Thu, 18 Apr 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466080; cv=none; b=C7MlszoPaTEIqVy3irgzyirulViX7j9J/MbRJXMdqPzF31QlqRBfx4/OB157faHvb75yuJINsMJKGzpdW6UHQw5rcpqJgP7BP9S5zvGXbAzXw+9C0KB3IbnrvKI0JelcCuXEPsIkTxyPF7S9XeF7OrYuu1fhPqqGHGAc/7NybW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466080; c=relaxed/simple;
	bh=/+tu1QtFlJWofHUNwDEzFNE8HCAVwWzF7OgMc41tc00=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DaE3V8u1YKZ5OyUa63aMGEnfa/9xEHZxO9zvnJPvMye1K+f9idNeE26W3aaCqZ/B5GfIvXBcnQZV5HmD958ilQQszwsQeu+k79k1A66s7bQYDIvIZf4SJptDRS/+rFQk3+ZlIXku7ftBzf3J2TSyx1DiWih6+0u1ujT9i3T4QoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQRW0RMh; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c730f7f549so434651b6e.3;
        Thu, 18 Apr 2024 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713466078; x=1714070878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z9WReLj2xrkv8imtMaxtB+MgeF3SaMvjoAmAItYIjM=;
        b=bQRW0RMhLkkS5cG9831ITtp1s0ENEyK+KhzWTEYHrklGQuZxz1dh2QDYr1G30X2yR0
         v0tWUeEl9TwVYYbi11pwU7dTMqw67/nHD8g2hsKRjOkMXmD6mw5F756DmKFG8ByVfhv9
         uCgNpWqdbEZIvTagh+ieYSAIt+/mJ3xwukP/Jt8e3DTEhEjgG/KdMEXks38yiBElbusA
         pozoY/0dOki1IbO8tuM4a+d0f0xnTiqkcZNDtFUNigs0UIZg2eQuWVwXCTfUziSeMLBX
         K6hMCcGOAHQn9pYJ3fk8aG/AaBZgEUv7H4R7ajbgykVrcFJXfutIj3GRgpvOcDzi8Mqa
         cF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466078; x=1714070878;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Z9WReLj2xrkv8imtMaxtB+MgeF3SaMvjoAmAItYIjM=;
        b=NLRAsY2g5/qYN1NbelPnzuJctpZ4ltibl3RlK2/E4c1hy0lUQohkxHjIcDbRV9uK3c
         FY4rWxJmHXABO11getG6H1Iyo0MDIPZc71uddTmX2G4duSsCzySBlGN2R4xV8l/LRpuO
         TVXsBpjiX/8v2CH5K2wStLQk/HcDWVMgy4ISRAtpyv0isiGML1zc5cMRVS+UcS0nw6h4
         IoeyPv85NryTHQjh+Aguh+n/XQ3/P+mJbNH40dLXUC9YpEv8O7cS2Z2i84XYWQxuJ2QQ
         qm2mqTzBOMBZ/OmEd/ucM/3dsKENcdDjpyZzdqh5kXYjB7Rey2xs9ORsUxHf1XwBQ1PC
         pZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj7G16ZqPWj7Furz8gw90elRvorpwX5+SIZxKbemxebLm1IzF7EqQ7iCzgh65aG3bNqyieo2E2b+1TlWLTRW3LTHeUB0CvzoNNo44z2O95ziXHqz21mE3Zw5XsHj5G0VQ0sc8tKH2u5iM2rWUFGgFkSihTIQpOlplo
X-Gm-Message-State: AOJu0YzhajEGnbWzkdXUgHeb2c+u0icF6v3xj4RkUi+dVo3gpuHJ+YD0
	yDjPCJe4En/Fbbw9vOY/kuOlvHz6YAe8dnVtu70HUdtnMDne/gDk
X-Google-Smtp-Source: AGHT+IHpHdV89IH4nrE0P2nMcgel2y6lXNZGHvqjwlDO2vx+QjGrQB2mFOZ+g5AbW9vC7IAtpGX2/g==
X-Received: by 2002:aca:1113:0:b0:3c7:963:837a with SMTP id 19-20020aca1113000000b003c70963837amr4155044oir.54.1713466077935;
        Thu, 18 Apr 2024 11:47:57 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id i19-20020ae9ee13000000b0078eca9de099sm859903qkg.134.2024.04.18.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:47:56 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:47:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <66216adc8677c_f648a294aa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240418004308.1009262-2-quic_abchauha@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-2-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v4 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.
> 
> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> extensibilty for other timestamps such as userspace timestamp
> (i.e. SO_TXTIME) set via sock opts.
> 
> As we are renaming the mono_delivery_time to tstamp_type, it makes
> sense to start assigning tstamp_type based on enum defined
> in this commit.
> 
> Earlier we used bool arg flag to check if the tstamp is mono in
> function skb_set_delivery_time, Now the signature of the functions
> accepts tstamp_type to distinguish between mono and real time.
> 
> In future tstamp_type:1 can be extended to support userspace timestamp
> by increasing the bitfield.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

> +/**
> + * tstamp_type:1 can take 2 values each
> + * represented by time base in skb
> + * 0x0 => real timestamp_type
> + * 0x1 => mono timestamp_type
> + */
> +enum skb_tstamp_type {
> +	SKB_CLOCK_REAL,	/* Time base is skb is REALTIME */
> +	SKB_CLOCK_MONO,	/* Time base is skb is MONOTONIC */
> +};
> +

Can drop the comments. These names are self documenting.

>  /**
>   * DOC: Basic sk_buff geometry
>   *
> @@ -819,7 +830,7 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> - *	@mono_delivery_time: When set, skb->tstamp has the
> + *	@tstamp_type: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
>   *		delivery_time at egress.

Is this still correct? I think all egress does now annotate correctly
as SKB_CLOCK_MONO. So when not set it always is SKB_CLOCK_REAL.

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 61119d42b0fd..a062f88c47c3 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1300,7 +1300,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>  	tp = tcp_sk(sk);
>  	prior_wstamp = tp->tcp_wstamp_ns;
>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
> +	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);

Multiple references to CLOCK_MONOTONIC left




