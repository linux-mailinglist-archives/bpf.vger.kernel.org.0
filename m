Return-Path: <bpf+bounces-27577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C078AF6B0
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD341C2505F
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54513F459;
	Tue, 23 Apr 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLvgix0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537E13EFE4;
	Tue, 23 Apr 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897304; cv=none; b=oRPBOSkYHLULBikqNIf2mIxPjiAIkSayr4zqm0FV5ZlkDAn2mYwzxtT93nXt8xUB4iQMMk4wRvulbGjqPzrOwLbazNm06A7fOhhFxDhK8S1fGmYqA3x9YkMKWtzVBzSEesYOMQveNoZdCWh7U/MD0MwXHoafNIK7nTsx5I49VPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897304; c=relaxed/simple;
	bh=WYvbuboNOGHAGTYL5eAezP0LLrKAAhKuVSJiY613RAw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EEputlIAUfDgbTo8PNL5TFJMvNF52VU+XnfvEstw8gU/mixGzXLODxOszLWAHxRVF+cIrwh6cCBzGo7zdfQrByfMEQ09dkOKSWH3hdUn5ckPdvhESz4qwliI4ZfKd8EApbK/hKv+v3aql7TGFISoGSMltsuLZepgLATV0N7TXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLvgix0o; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a06b12027cso1567176d6.0;
        Tue, 23 Apr 2024 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713897301; x=1714502101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HiLWdjQaV8hb1O52W4MiOT+NWSrI3hsRhd3S7MooKM=;
        b=mLvgix0oFK/Y4jcA2Vz5ZFEswodnVB1nVzf1NCxJw3pv1QRPryaEPGsmRmThBhv4Z8
         24dmD0RkdX4bjC63Mg6vc0dTQZbhXfGdyH8QbgpdGPvbhuW6FpVZhGA48Tygb/CPBGfz
         fzZbR2rPoENLwSV3EGGjAoqdR2Uerzbcxli5ZfPAE1Q16SLHo200HVR3F4qgDkiVTBPP
         EZS7M0ooLb+RjwzP5UoIB2umI/ivp825o3soddPzJyBG9c5vrFrE5+slwm9vbedYvJeX
         MZL9U0zaPbdTlHWHK9p9HnEsLO4FC9KSN72+K/MOQfadIuorq6zzCcQfyfct766iJ15Z
         3Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713897301; x=1714502101;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/HiLWdjQaV8hb1O52W4MiOT+NWSrI3hsRhd3S7MooKM=;
        b=klifJUKnOksIdMAMl628US+1vyzSRFD3EPx1gAXGaJrg0Vexx6Z0ZrCfs21CQeO8+M
         kBn5Ujjg2TbiAh1T2cr4p83n3OFMGQrqgZXS0g5e4HP4Glth8uN9xjiK6J+F0hoKgSq1
         lXyUnd8iOJFbj2vp2a16m3SvLk1FehZwEeFraluzPMpvtZcBBtQTcjv9SOATQwORj7kV
         c/tB2rTflUkDBwGSWu+qdanYuYaIRGn1H8EHYnt65K8S5I52KGGCY9aScw1U4V5Wd1Eu
         KPfB5CBHdpMN6ki10ALh8Juot04TuSpsw8QVZ1pylJtG/oaLK3oCjDMRRlsF2qWdfQ44
         FuSw==
X-Forwarded-Encrypted: i=1; AJvYcCXtVWH6/8JO3zCRW7ZfRZN2nybUL8J/Sc37JUpn+yxn//QpJDaZb5MVxKJ2jmCPovOwwh3RKGpeQXl+GQwV2ojkFYBAn2Vo+ziW4IFTp6nL7qUU7w37B6SkWH9W
X-Gm-Message-State: AOJu0Yz4f0BhYT56+IKHb3JfPshzWz9mGk40Bsb9/w+LQaMOQxSoJpHe
	qwVriLZDduCF6a+0xh4m06rHoBA5HC33iMLYwGsw8Jfb6rfR+Ipx
X-Google-Smtp-Source: AGHT+IF62Qwt6JGagRCz6T9wK89ruUN39TtsigSJte1Aii5NS2nBJ3TAqKMQGIi2Zy6y47RheF7jmw==
X-Received: by 2002:a05:6214:e69:b0:6a0:4756:ce99 with SMTP id jz9-20020a0562140e6900b006a04756ce99mr6817134qvb.21.1713897300995;
        Tue, 23 Apr 2024 11:35:00 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ce406000000b0069b20891f0dsm5377155qvl.30.2024.04.23.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:35:00 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:35:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
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
Message-ID: <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
In-Reply-To: <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
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
Content-Transfer-Encoding: 7bit

> Hi Willem,
> As the discussion, is it OK for the patch below?

Thanks for iterating on this.

I would like the opinion also of the fraglist and UDP GRO experts.
 
Yes, I think both

- protecting skb_segment_list against clearly illegal fraglist packets, and
- blocking BPF from constructing such packets

are worthwhile stable fixes. I believe they should be two separate
patches. Both probably with the same Fixes tag: 3a1296a38d0c
("net: Support GRO/GSO fraglist chaining").

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3a6110ea4009..abc6029c8eef 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1655,6 +1655,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,
> bpf_sp);
>  static inline int __bpf_try_make_writable(struct sk_buff *skb,
>                                           unsigned int write_len)
>  {
> +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> +                       SKB_GSO_FRAGLIST) && (write_len >
> skb_headlen(skb))) {
> +               return -ENOMEM;
> +       }
> +

Indentation looks off, but I agree with the logic.

    if (skb_is_gso(skb) &&
        (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
         (write_len > skb_headlen(skb)))

>         return skb_ensure_writable(skb, write_len);
>  }
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 73b1e0e53534..2e90534c1a1e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4036,9 +4036,11 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>         unsigned int tnl_hlen = skb_tnl_header_len(skb);
>         unsigned int delta_truesize = 0;
>         unsigned int delta_len = 0;
> +       unsigned int mss = skb_shinfo(skb)->gso_size;
>         struct sk_buff *tail = NULL;
>         struct sk_buff *nskb, *tmp;
>         int len_diff, err;
> +       bool err_len = false;
> 
>         skb_push(skb, -skb_network_offset(skb) + offset);
> 
> @@ -4047,6 +4049,14 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>         if (err)
>                 goto err_linearize;
> 
> +       if (mss != GSO_BY_FRAGS && mss != skb_headlen(skb)) {
> +               if (!list_skb) {
> +                       goto err_linearize;

The label no longer truly covers the meaning.

But that is already true since the above (second) jump was added in
commit c329b261afe7 ("net: prevent skb corruption on frag list
segmentation").

Neither needs the kfree_skb_list, as skb->next is not assigned to
until the loop. Can just return ERR_PTR(-EFAULT)?

> +               } else {
> +                       err_len = true;
> +               }
> +       }
> +

Why the branch? Might as well always fail immediately?

>         skb_shinfo(skb)->frag_list = NULL;
> 
>         while (list_skb) {
> @@ -4109,6 +4119,9 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>             __skb_linearize(skb))
>                 goto err_linearize;
> 
> +       if (err_len)
> +               goto err_linearize;
> +
>         skb_get(skb);
> 
>         return skb;
> 
> > > 
> > > > Back to the original report: the issue should already have been
> > fixed
> > > > by commit 876e8ca83667 ("net: fix NULL pointer in
> > skb_segment_list").
> > > > But that commit is in the kernel for which you report the error.
> > > >
> > > > Turns out that the crash is not in skb_segment_list, but later in
> > > > __udpv4_gso_segment_list_csum. Which unconditionally dereferences
> > > > udp_hdr(seg).
> > > >
> > > > The above fix also mentions skb pull as the culprit, but does not
> > > > include a BPF program. If this can be reached in other ways, then
> > we
> > > > do need a stronger test in skb_segment_list, as you propose.
> > > >
> > > > I don't want to narrowly check whether udp_hdr is safe.
> > Essentially,
> > > > an SKB_GSO_FRAGLIST skb layout cannot be trusted at all if even
> > one
> > > > byte would get pulled.



