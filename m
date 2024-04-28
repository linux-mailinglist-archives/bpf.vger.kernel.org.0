Return-Path: <bpf+bounces-28041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4298B4BF3
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300991F21517
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0C6CDDF;
	Sun, 28 Apr 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQCi77Je"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08E653;
	Sun, 28 Apr 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310388; cv=none; b=Cyt0aX7JJ0hpmP2XPhCjYDsLrHWL1Qd19iOvEoHzoY+v1yCmD5hqniBx9rFYB0nRC8aDlfUMkLEPt8o0mEV2Ek6wp4ppePy9L8l/ptA5DF9shdd113V77bEAI4p5Ex1zLWjI8OMXVQvtCHCbTC17qCRl6Em+Yv9SHNpkBuzYAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310388; c=relaxed/simple;
	bh=4khKhLK2YtjMQaB6dRu5O2Syulq912bbNN3/8i9Py1U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eX0K497XgsEGTVN591XxvaLbN2uoO5wyw9bxNinw8emqUqLn4czkWscYvl7sb1DcVhHyMqDbI5EXc5+XGHFEIZBjDc7a35dZhkuvh+ygEbaJuIPO3aaXZ1C2VIDKp6Qv0jpEmRym/KEwKgWPDSQ5QEccj2A3Hudjn5VzNXVFxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQCi77Je; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c8644aa3feso297103b6e.1;
        Sun, 28 Apr 2024 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714310386; x=1714915186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg/J1r0idys6NiEqMRvybp1D6aLsHM8wWTplpRl2ISw=;
        b=HQCi77Je8XxoQVJKUddXscFfEIUKDwpmA39jO9i9UceGh6Z4DaT2+NWn+blxvr6u5h
         67iVzN/YMyTVVG+d+VZ1uoOvghcQxuqLX9kwc9yoIyumlvnBhykPTCwH1GKTXvQOPXnZ
         GqoENzW3CSu96J/xpGt54rxv/xbhfNRIuT03WHjPBGfMOqFlG8z2JQqo5sAEOR89QXCZ
         doH1pyS+xSwievLX+BKeQUW5K1dmSnnh6h83e6Vhu6kzpuYggM23Su9VCm46PNG6/CTe
         k2QQmlgt83ce/F71T0YXAVy4zBuhvb1e2GSCu7bmiGilvp0frn6zvhIkFgK0IRambGER
         arlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714310386; x=1714915186;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fg/J1r0idys6NiEqMRvybp1D6aLsHM8wWTplpRl2ISw=;
        b=fUmVNd/bSGyKol2kwSsnLWVJ0+Pp6ECBbH4qsznJr1bU+gNz/qU6yKSh0brr4PROBO
         zBk/Lu8yrkPiWe9jpW6b4RSw/c4zwu6CjnxCuek6wcupqnLlUTGOPwznt2h1VCKJosby
         UOo8RCfnJ5UuSQ89D8MqFJLibM80265UHfL30nB8bls0z9piuvApB6yfD8z149p/8ccU
         E/UISsgG4xlm7Ep4RGp9fdM0IJ96eGs/zLzzyPX2G9U55PqcBP0MtyxzpOAJqOtLR/jR
         8HB7OXpAcrUOwwXXEhW0unXY2dSCRQsMmi0jnty6Vs/ECT6a+F/k4MNSfajLJggudZP1
         9YJw==
X-Forwarded-Encrypted: i=1; AJvYcCVV7fZXShQndfOD1jLoFimN/m8cZKfCbluvhSdclj4+uA0IJGBAFvf2r8gLfr3owfV0Fi9XN64U7OufRVW802Cm5feFt4wPAScUdfEST5K3J+BwAVdU4A4Al+jQ
X-Gm-Message-State: AOJu0YyoyOOQbfk9LvuAVqspeO0ABh5yxGZnv9PK5tou2XqYlAKKNUaV
	cBJYA7Oo+1w9iujf24S281lNRVXIvRl1yBdSgiOmhWdOAce5mwFO
X-Google-Smtp-Source: AGHT+IGShQJR13FCihzjd0FtG3/fwG2zFgo/oHcnFeT+ErOf2XF478Qgjp3F7roCqNJAhFY/os68Hw==
X-Received: by 2002:a54:4181:0:b0:3c3:c923:4f03 with SMTP id 1-20020a544181000000b003c3c9234f03mr7929375oiy.19.1714310385833;
        Sun, 28 Apr 2024 06:19:45 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id qd13-20020ad4480d000000b0069b75b8633dsm3026506qvb.67.2024.04.28.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 06:19:45 -0700 (PDT)
Date: Sun, 28 Apr 2024 09:19:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "maze@google.com" <maze@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "yan@cloudflare.com" <yan@cloudflare.com>
Message-ID: <662e4cf0a7ba0_2b6e752941c@willemb.c.googlers.com.notmuch>
In-Reply-To: <afa6e302244a87c2a834fcc31d48b377e19a34a2.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
 <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
 <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
 <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
 <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
 <662cfd6db06df_28b9852949a@willemb.c.googlers.com.notmuch>
 <afa6e302244a87c2a834fcc31d48b377e19a34a2.camel@mediatek.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> On Sat, 2024-04-27 at 09:28 -0400, Willem de Bruijn wrote:
> >  	 =

> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  =

> > Daniel Borkmann wrote:
> > > On 4/26/24 11:52 AM, Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > > [...]
> > > >>>  From 301da5c9d65652bac6091d4cd64b751b3338f8bb Mon Sep 17
> > 00:00:00
> > > >> 2001
> > > >>> From: Shiming Cheng <shiming.cheng@mediatek.com>
> > > >>> Date: Wed, 24 Apr 2024 13:42:35 +0800
> > > >>> Subject: [PATCH net] net: prevent BPF pulling SKB_GSO_FRAGLIST
> > skb
> > > >>>
> > > >>> A SKB_GSO_FRAGLIST skb can't be pulled data
> > > >>> from its fraglist as it may result an invalid
> > > >>> segmentation or kernel exception.
> > > >>>
> > > >>> For such structured skb we limit the BPF pulling
> > > >>> data length smaller than skb_headlen() and return
> > > >>> error if exceeding.
> > > >>>
> > > >>> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")=

> > > >>> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > >>> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > >>> ---
> > > >>>   net/core/filter.c | 5 +++++
> > > >>>   1 file changed, 5 insertions(+)
> > > >>>
> > > >>> diff --git a/net/core/filter.c b/net/core/filter.c
> > > >>> index 8adf95765cdd..8ed4d5d87167 100644
> > > >>> --- a/net/core/filter.c
> > > >>> +++ b/net/core/filter.c
> > > >>> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct
> > bpf_scratchpad,
> > > >>> bpf_sp);
> > > >>>   static inline int __bpf_try_make_writable(struct sk_buff
> > *skb,
> > > >>>     unsigned int write_len)
> > > >>>   {
> > > >>> +if (skb_is_gso(skb) &&
> > > >>> +    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> > > >>> +     write_len > skb_headlen(skb)) {
> > > >>> +return -ENOMEM;
> > > >>> +}
> > > >>>   return skb_ensure_writable(skb, write_len);
> > > =

> > > Dumb question, but should this guard be more generically part of
> > skb_ensure_writable()
> > > internals, presumably that would be inside pskb_may_pull_reason(),
> > or only if we ever
> > > see more code instances similar to this?
> > =

> > Good point. Most callers of skb_ensure_writable correctly pull only
> > headers, so wouldn't cause this problem. But it also adds coverage to=

> > things like tc pedit.
> =

> Updated:
> =

> From 3be30b8cf6e629f2615ef4eafe3b2a1c0d68c530 Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Sun, 28 Apr 2024 15:03:12 +0800
> Subject: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
> =

> BPF or TC callers may pull in a length longer than skb_headlen()
> for a SKB_GSO_FRAGLIST skb. The data in fraglist will be pulled
> into the linear space. However it destroys the skb's structure
> and may result in an invalid segmentation or kernel exception.
> =

> So we should add protection to stop the operation and return
> error to remind callers.
> =

> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  include/linux/skbuff.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> =

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 9d24aec064e8..3eef65b3db24 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2740,6 +2740,12 @@ pskb_may_pull_reason(struct sk_buff *skb,
> unsigned int len)


pskb_may_pull is called in far too many locations. Daniel's
suggestion was to amend skb_ensure_writable

Please start sending the patches as regular patches. They are close
enough to review normally.

>  	if (unlikely(len > skb->len))
>  		return SKB_DROP_REASON_PKT_TOO_SMALL;
>  =

> +	if (skb_is_gso(skb) &&
> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> +	     write_len > skb_headlen(skb)) {
> +		return SKB_DROP_REASON_NOMEM;
> +	}
> +
>  	if (unlikely(!__pskb_pull_tail(skb, len - skb_headlen(skb))))
>  		return SKB_DROP_REASON_NOMEM;
>  =

> -- =

> 2.18.0



