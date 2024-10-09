Return-Path: <bpf+bounces-41405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B502996BAC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59D71F22F49
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE544194C96;
	Wed,  9 Oct 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd0+Bjwv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990E192D80;
	Wed,  9 Oct 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479985; cv=none; b=MN3Gqj41eLBFOrlCeVAFN/5Wv18U1KSTPZ1Bu/6QmLK/3Z5v9WlAbVzQtxv1ZD4btzxj2CM5g8eWooVLPo5N1djMecZwJG5L2QYIQ2oTPBW1L4LyT6EgUV5JTaDz336Y0JEKq2QM18SQVq7P8dd0sqUDwU9vydvgGMWYK7sVq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479985; c=relaxed/simple;
	bh=U4r8YN8Gee/nvEHqOgvidqcjMfAmZOOkkzoVo6nHmSg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gmctTBYUD6pOnUfI61dJR8sHZnbpOjES8YbXOjrhkIrKspopfbrHLNBB7zKTBdBmNLGR/fIX4v1CaqoLjnRXytrAhNWuAW1lhnRlO7pBP6J3B+cZxxiYjnqKVCap/zqMqmA6eUZ1nwgOSc01U+0ly93mFLVcIs4f9G9AIvvsmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd0+Bjwv; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e7aec9e15fso3300477eaf.3;
        Wed, 09 Oct 2024 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728479983; x=1729084783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhOa+LsDZ1mhvBT8mVnTQcKnROdr7jYO5W8Pum+Xs20=;
        b=Wd0+Bjwv6zdWTKnrUxuzECXvEUa1uI4bWPcvJOOjGg8FFaVjnNva02m2zpQVo5YwFM
         ZVvMf9/sg4y0E5f5MuJmZd4Fr6mpvlIAc6lFDVRautd1Wdwo5fDCrSPrIUcR+TfVjw9z
         Gx7+wl27bYiBD4/YuxtFWiBJTOkeJmD1hw6LR3v/9QkYR2nBIm/VTmkX9rVE7JFHJKeE
         V8YcTeVVt+yTLMW/ASgWXj2YGNxjtyUjramPCeUeJPe5FMXYvqDZlaZBeldO7FC9KHh8
         Yo3JR8WoFvD6Jzwv3U23KAABVzfIRtT/6rTDz+vErRflOBeEAH3viDQLxmSEg3G+3Fw5
         8CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479983; x=1729084783;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JhOa+LsDZ1mhvBT8mVnTQcKnROdr7jYO5W8Pum+Xs20=;
        b=wmn409Q1p0cPnDEsPO3xXQEfd/qMYBeLw++aBYVueMAmmPCmJzOu+g0lYuUG9JzQEC
         XFpugYxJPx8O4T0lihNbHHfz8n8X6BvaZwoJnwf+Nfm5UxTmgEhKhM+Rb+TbJO82fFUP
         CFrAenjaWyLt3sHIAoBXX0TVqbD3YpAb/d65AgJCnmx5mC08BxwOoYmM750x6Oi9t5h1
         eeJxGNzCHg2CCifLcau1CxTktvLR8l+fmiJRC1HMFdN9De5rPhREntssDpInB5vvLwB/
         hidHy6x4NVhdcitVfNkotaYmnlqttzckHv6US1ECZIRugyOEoH5gP14H2sor1h7JhfiC
         H17g==
X-Forwarded-Encrypted: i=1; AJvYcCVi1/smZyB7E6XK0QelDLspzh/L3S9zPnnp1GjXGKEs/IW/I1WqsOrdYz5i0ooAFEarL+g=@vger.kernel.org, AJvYcCWyMvHPkls680VNnDg+R+QCMU0KMicbfIwItvCOXJelHl3xx2mGHtmqxdPDG8ETRYQZj+IYW3yd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+NS9AwnG8xOsmtPoAr6kcGF4FWQDVTtAUJ5q4vFWHjPZD63F
	0Tfux90R9f/5HBvIqJUQIldmlYvJtrqP0jtZWRwDufAU3cMpERJS
X-Google-Smtp-Source: AGHT+IEauNbb5DqGMhjnqtSFTAlw1lnjsEJDPeqNB6DFtJqf09EGdJYVYq0RuK+AtsaKiT55ne/QrA==
X-Received: by 2002:a05:6358:914a:b0:1b8:3283:ec6e with SMTP id e5c5f4694b2df-1c3081e7294mr37808855d.24.1728479982615;
        Wed, 09 Oct 2024 06:19:42 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7561e5besm452589485a.20.2024.10.09.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:19:41 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:19:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670682ed93e9c_1cca3129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoA_HwCYG+_DtdRHNL-L07RYqQfxY+pmT2fUvs-N1HYV9g@mail.gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-7-kerneljasonxing@gmail.com>
 <6705804318fa1_1a41992941a@willemb.c.googlers.com.notmuch>
 <CAL+tcoA_HwCYG+_DtdRHNL-L07RYqQfxY+pmT2fUvs-N1HYV9g@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] net-timestamp: add tx OPT_ID_TCP support for
 bpf case
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> > > from each sendmsg. We only set the socket once like how we use
> > > setsockopt() with OPT_ID|OPT_ID_TCP flags.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/core/skbuff.c | 16 +++++++++++++---
> > >  net/ipv4/tcp.c    | 19 +++++++++++++++----
> > >  2 files changed, 28 insertions(+), 7 deletions(-)
> > >
> >
> > > @@ -491,10 +491,21 @@ static u32 bpf_tcp_tx_timestamp(struct sock *=
sk)
> > >       if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> > >               return 0;
> > >
> > > +     /* We require users to set both OPT_ID and OPT_ID_TCP flags
> > > +      * together here, or else the key might be inaccurate.
> > > +      */
> > > +     if (flags & SOF_TIMESTAMPING_OPT_ID &&
> > > +         flags & SOF_TIMESTAMPING_OPT_ID_TCP &&
> > > +         !(sk->sk_tsflags & (SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTA=
MPING_OPT_ID_TCP))) {
> > > +             atomic_set(&sk->sk_tskey, (tcp_sk(sk)->write_seq - co=
pied));
> > > +             sk->sk_tsflags |=3D (SOF_TIMESTAMPING_OPT_ID | SOF_TI=
MESTAMPING_OPT_ID_TCP);
> >
> > So user and BPF admin conflict on both sk_tsflags and sktskey?
> >
> > I think BPF resetting this key, or incrementing it, may break user
> > expectations.
> =

> Yes, when it comes to OPT_ID and OPT_ID_TCP, conflict could happen.
> The reason why I don't use it like BPF_SOCK_OPS_TS_SCHED_OPT_CB flags
> (which is set along with each last skb) is that OPT_ID logic is a
> little bit complex. If we want to avoid touching sk_tsflags field in
> struct sock, we have to re-implement a similiar logic as you've
> already done in these years.

One option may be to only allow BPF to use sk_tsflags and sk_tskey if
sk_tsflags is not set by the user, and to fail user access to these
fields later.

That enforces mutual exclusion between either user or admin
timestamping.

Of course, it may still break users if BPF is first, but the user
socket tries to enable it later. So an imperfect solution.

Ideally the two would use separate per socket state. I don't know
all the options the various BPF hooks may have for this.


