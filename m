Return-Path: <bpf+bounces-59902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29CAD078F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918F4189146F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86892289E24;
	Fri,  6 Jun 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwyMUiGt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC271DF24F
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231384; cv=none; b=DuZrAb+rDzd0U/pIyoyNfA7v+F6WUpbrlRP2gdPSWo73KUH+9RxkOteiZswocBgy0uR+8KL0leCEBQxgFPsQBPgDP8NXS9u7tFCllZTL2mfiDBmHoAsOwjC+q6FHDIfRldWHGmQJH53IYNtFPWEOtdtluEBv8LRSK5p8vNA3+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231384; c=relaxed/simple;
	bh=ibZ/pXjsXnJfTxrGojJsxb2yIsofXWUoZqqINf7C1mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEv4LY9Rp9SkTl07/g4BGvjtJ/EeR0MSzNn4s78vC89xHYuk7t7SC0fbqGPtYRIlbz0f96mLLIyZmH2B+45rjTWrCQgWOeMDvo5gq1VdUm767LGFPLaQTFhX/dL+7iYLiOYCu0SwzgViQ1478gjeIEkmE10WCRoeB+6FKpraZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwyMUiGt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso755a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749231381; x=1749836181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl4rTtpucK40LHC2+iC2J8rO9G79cIPz4dOeykqh3e8=;
        b=NwyMUiGtzncClqEBKfMRr4bs6UqMkGOOHNfzCeZhvo+6fgkphsRK/YzXwVfk86pMRI
         4DYhpsJ5u8SG6AtIIH/e/YbRzJzvBuihVEZFwZgdRtK32tyI1x9uNAlgYlr2ppzt909K
         3Rhwn67C7aOVkCmSg/qCE+yZmuV7wFnYY3QDkC/XqNdXbSxmtRjIgtXJHlm0IruF0wkQ
         9J2YK4eav0yzDou2nGSOKjT+3AGLqsF866fPjUyzb6OwHjQvx2PWpCmTKUmygqL9xIZN
         bArjRAGRiL/bhdwrj+DQnrXWTmApQ9kOuChwRlbYHwEh7yafy/fdgeGKCexYeIENz43P
         uwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749231381; x=1749836181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl4rTtpucK40LHC2+iC2J8rO9G79cIPz4dOeykqh3e8=;
        b=TabuCGcCb8PpMJu+CwYqDhN4PZjhpTYdTJfSyMP7LzFFMnVyKo8MhQmUUa94jfNl6e
         KlJoFdRR8iSqx3bctWVP3sVyepPAbFzFmrlcHLPMukbkhRFnxp0lGNdIn3diPJOGTEaI
         yXuErUMB4CF3MfNLOC81fIsIbgRxgwS51vu0rftiSgQ5eWsbki4OMzjR2HY5hjBYfJfH
         bDAQ8ZqxVBasCwLpUx47WAkRd+bVQzdCjZODlAMWx9aYRiEZVNNh9sQ2yyOga0vsrH9q
         CzdvH0mjokVeBpueJtXxXhRxW4VYZT9XWBPmYpQfjkE6qhBRqTZruS6Suo/3kaEd5Xbq
         QYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHhK2ewT3F4MFTtXsOEtV/B02Qbi4SsJiSM18aRBj4gA1TVa8ggUSrNvN2xps97nw2dFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDDzp8v+1rbi2CVtHA10Dx5hLLO9VXa2b/SVaLbp+qfBCCnmi
	tsa4UuHxtIDTCZC7qhg2YXS/dFsmoDWS7ZCF0SKY8tFQUjnrBlptquygH3XElY/7pbiENePyiH/
	mrgEbAA5t2yIjBxE3HMOkk/CP3xiWPK/4jBYXc0oQ
X-Gm-Gg: ASbGncsXaWGngjPRd0jAamFP1xANnbDf94fa/5xGzDKKI32dbm4+jGbmfPStVeGeYbF
	1GJyozku5uP92vmtBLfwDKOjO/ulG0vuOhJE1ASoTDG/0roPOvDx3TPq7lh2S4kRHntaPVwYrTo
	44N5f2KL3ISxHLuBUDx4w+hiYeuRu+tVqH+qd/DoDQGDH42OJsQAOCQ0pMXams0NfghzH35lTrK
	10p
X-Google-Smtp-Source: AGHT+IETGwpaakC/78l7PTlE6xzbDp9M49kfLW27GKe7s70jAX6nYZ1GTzF3AtnRQ3MmA3isFbwSmTpBklREE4ctV+o=
X-Received: by 2002:a05:6402:175c:b0:606:efc1:949b with SMTP id
 4fb4d7f45d1cf-607793bc04bmr102799a12.3.1749231380477; Fri, 06 Jun 2025
 10:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604210604.257036-1-kuba@kernel.org> <CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
 <20250605062234.1df7e74a@kernel.org> <CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
 <20250605070131.53d870f6@kernel.org> <684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
 <20250605173142.1c370506@kernel.org> <CANP3RGfXNrL7b+BPUCPc_=iiExtxZVxLhpQR=vyzgksuuLYkeA@mail.gmail.com>
 <20250606101106.133cb314@kernel.org>
In-Reply-To: <20250606101106.133cb314@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 6 Jun 2025 19:36:09 +0200
X-Gm-Features: AX0GCFtsFMbc2iPM7V7_jO6OBxXtwW3waSVt6NewQZvFmRU11Bll8cN36Dp-3bU
Message-ID: <CANP3RGdcR_5WfHRF1NtzMZL3+44nC7wfJQOa+nt2qXgcOWKdBg@mail.gmail.com>
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, martin.lau@linux.dev, 
	daniel@iogearbox.net, john.fastabend@gmail.com, eddyz87@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, willemb@google.com, 
	william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 6 Jun 2025 11:40:31 +0200 Maciej =C5=BBenczykowski wrote:
> > Hopefully this is helpful?
>
> So IIUC this is what we should do?
> Cover the cases where we are 99% sure dropping dst is right without
> being overeager ?
>
> ---->8-----
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 327ca73f9cd7..d5917d6446f2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3401,18 +3401,24 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *=
, skb, __be16, proto,
>          * care of stores.
>          *
>          * Currently, additional options and extension header space are
>          * not supported, but flags register is reserved so we can adapt
>          * that. For offloads, we mark packet as dodgy, so that headers
>          * need to be verified first.
>          */
>         ret =3D bpf_skb_proto_xlat(skb, proto);
> +       if (ret)
> +               return ret;
> +
>         bpf_compute_data_pointers(skb);
> -       return ret;
> +       if (skb_valid_dst(skb))
> +               skb_dst_drop(skb);
> +
> +       return 0;
>  }
>
>  static const struct bpf_func_proto bpf_skb_change_proto_proto =3D {
>         .func           =3D bpf_skb_change_proto,
>         .gpl_only       =3D false,
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>         .arg2_type      =3D ARG_ANYTHING,
> @@ -3549,16 +3555,19 @@ static int bpf_skb_net_grow(struct sk_buff *skb, =
u32 off, u32 len_diff,
>
>                 /* Match skb->protocol to new outer l3 protocol */
>                 if (skb->protocol =3D=3D htons(ETH_P_IP) &&
>                     flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
>                         skb->protocol =3D htons(ETH_P_IPV6);
>                 else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>                          flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
>                         skb->protocol =3D htons(ETH_P_IP);
> +
> +               if (skb_valid_dst(skb))
> +                       skb_dst_drop(skb);
>         }
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>
>                 /* Header must be checked, and gso_segs recomputed. */
>                 shinfo->gso_type |=3D gso_type;
>                 shinfo->gso_segs =3D 0;
> @@ -3576,16 +3585,17 @@ static int bpf_skb_net_grow(struct sk_buff *skb, =
u32 off, u32 len_diff,
>         }
>
>         return 0;
>  }
>
>  static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff=
,
>                               u64 flags)
>  {
> +       bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
>         int ret;
>
>         if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
>                                BPF_F_ADJ_ROOM_DECAP_L3_MASK |
>                                BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>                 return -EINVAL;
>
>         if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
> @@ -3598,23 +3608,28 @@ static int bpf_skb_net_shrink(struct sk_buff *skb=
, u32 off, u32 len_diff,
>         ret =3D skb_unclone(skb, GFP_ATOMIC);
>         if (unlikely(ret < 0))
>                 return ret;
>
>         ret =3D bpf_skb_net_hdr_pop(skb, off, len_diff);
>         if (unlikely(ret < 0))
>                 return ret;
>
> -       /* Match skb->protocol to new outer l3 protocol */
> -       if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> -           flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> -               skb->protocol =3D htons(ETH_P_IPV6);
> -       else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> -                flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> -               skb->protocol =3D htons(ETH_P_IP);
> +       if (decap) {
> +               /* Match skb->protocol to new outer l3 protocol */
> +               if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> +                   flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> +                       skb->protocol =3D htons(ETH_P_IPV6);
> +               else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> +                        flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> +                       skb->protocol =3D htons(ETH_P_IP);
> +
> +               if (skb_valid_dst(skb))
> +                       skb_dst_drop(skb);
> +       }
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>
>                 /* Due to header shrink, MSS can be upgraded. */
>                 if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>                         skb_increase_gso_size(shinfo, len_diff);
>

This looks reasonable to me... not that I feel very qualified to make
that statement ;-)

