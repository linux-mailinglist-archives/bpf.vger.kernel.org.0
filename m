Return-Path: <bpf+bounces-60894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DEEADE41A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 08:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6BD3A34C7
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E12586EC;
	Wed, 18 Jun 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE1SWuzX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED21FF7B3;
	Wed, 18 Jun 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229990; cv=none; b=e9y6RHaNVdOZIqwNH0X9zs69tuV6fUvAK1N202mMbHUMA+XnXXU9es+RUn/T77uwUAxqIhEoH7lb/xFp54aofbm9OVf5a5r/vM5ssjjnGRq8TAdiOV3hYyMLsFo73GLlpss6yxmJrI6fbQNxsafWhD++RuzzSWpBYbGtkgM5wqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229990; c=relaxed/simple;
	bh=tgVG2WpIp6l5iSHtTYoJpxfchin4wnASWx7ei0hEnwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHT8R3GqjI13Qg9VgpysjdFIH043gjnW62BGekM3vfCD+qzsW760A3EBIvAWaesPCj2yp92hSuCRfrDfqJtyXe/EtDpIciUnQg+EW37zid2NRCoX0JJGFaL630EmtPEth21NPUBOi3wc+2OxENqI2pvc06c8VVoJKjhz34HwXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE1SWuzX; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3dc8265b9b5so57658685ab.1;
        Tue, 17 Jun 2025 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750229988; x=1750834788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic8LKy9ADhzEP6S+OIsJXOEbT/AR9cuzJIG/8ySLhAk=;
        b=mE1SWuzXiVYM+7kRZHs1HrUpnDhmtPH4dg67dZQEhUmAA7EYhQFfnFWBs7ySvMD1EE
         MVIGx382SRTjESmYmNxBWUG60PANGNoPDH0SvGDOiqvDXIGf5mAK0UFbYF3x6bYkn82I
         SW00EL7LjaFtgqG6gLuqsyz0uHsabwCRBCAnYtTnFf7SdcGJ0tc0qSIYdWCNwhJLIVeG
         1xXj0MuVRcPYxCZpQklNc2/1lftPhw1qGqD91WToQDyOlO+mCAdN0UU+0K1PxDb/TW9m
         9HHREM7qjPxOfJCW6mE0dxdEON80Xv5v1Gml/EchbEbEVoGOjggLjLl0xUxb+mVHJBoE
         hmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750229988; x=1750834788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic8LKy9ADhzEP6S+OIsJXOEbT/AR9cuzJIG/8ySLhAk=;
        b=TbhUtdLp/6kRZ1z2MT6fo1GPfn7qa63fSGjhVhucYyVX3AJ5WbK41dQsB6cfa+4mm2
         VY9+OtGfXcI69rNDdVGTxSYPnmIKjvaBRyvk1ZWVa6k8Z01QovZynHwDnZfVfZtfFSRC
         BFUpo5LeJsJ3RCA3z2sGRuTRslcwhAQoTZVaM9cJmbUJ/NNgMUS+R0Ap2cUCWMacuBBQ
         EF9StK3173UydD9zr+w8HisOxBG+96zrnVZpSKOLiijLl9UBc1UWKMPavCOKg7ECAetH
         BxOq7Usy4lX1mWH4UROLBzPEy7DR1nNHfbF4C7rrx/5+kLMaeKkAUM++t117x2LZ1SnX
         C3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCViQvpRAkR20PHodBQnWP37SsFHsquwDiXUOcCGr+Tf+fdjCHaahZWJZR1NABrc/rt8G/9D2LQh@vger.kernel.org, AJvYcCWGl+dq4GHqVnj51ABTCaAKildc2UtRiCvKDWrVQXw41PASnC+HRZG632fePxVGnnnlhu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NV5/YRnv6n60sJDS/CMty8eURrAS3WydsM+EXx8PeqzrXNrf
	+RgdhRuUF7qeeRfAR/HkZQAfTlHLa+fRFq3PH/KuthDoEufO2umefIMerm/ZmAJv0Qa9H5WRDKa
	iZn0LOwIKnrl4wgnRvahUlDQgewT50d8=
X-Gm-Gg: ASbGncv+NDVmByR116YnA6mLJYyxU2WBanol/GoHU2dz3PKpYo5+5HiUtl8cGxQAxot
	B2P1M5+p6LgMBjMAHcMujE1BwKhtQLBDGsawRxsPE5n3IvGmuZZ4MlOIgDfbANgkSTRct3vEnoq
	L3MRLrK9fUA0KE3Sya7l4Z0Ldgmc5QZ+BtOqfDFJnVeL0=
X-Google-Smtp-Source: AGHT+IEAW28eFuOPmtmfXSAzLWk/IkC2pjcweE5PedYIFfXG8JPaXh6Rl4cs13/i7D91l3qju92wOcJNZpa7gR63lmo=
X-Received: by 2002:a05:6e02:3786:b0:3dd:b7ea:c3d9 with SMTP id
 e9e14a558f8ab-3de07c412e4mr191358095ab.7.1750229988278; Tue, 17 Jun 2025
 23:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch> <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
 <aFGp8tXaL7NCORhk@mini-arch> <CAL+tcoAQ8xVXRmnjafgGWYDWy_FYuA=P4_Tzmh1zUkna2BF+nA@mail.gmail.com>
In-Reply-To: <CAL+tcoAQ8xVXRmnjafgGWYDWy_FYuA=P4_Tzmh1zUkna2BF+nA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 18 Jun 2025 14:59:10 +0800
X-Gm-Features: AX0GCFsGBi18MS7iY09IUCwohHB77XBAlmYnARMYi3s3FsN46eNYvk73rkH8Qlo
Message-ID: <CAL+tcoAtJJ4ZO464UaeLUi8jt1RQr7Lg7fk6vdKPPe6fdw_gZQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 8:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Jun 18, 2025 at 1:46=E2=80=AFAM Stanislav Fomichev <stfomichev@gm=
ail.com> wrote:
> >
> > On 06/17, Jason Xing wrote:
> > > Hi Stanislav,
> > >
> > > On Tue, Jun 17, 2025 at 9:11=E2=80=AFAM Stanislav Fomichev <stfomiche=
v@gmail.com> wrote:
> > > >
> > > > On 06/17, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Introduce a control method in the xsk path to let users have the =
chance
> > > > > to tune it manually.
> > > >
> > > > Can you expand more on why the defaults don't work for you?
> > >
> > > We use a user-level tcp stack with xsk to transmit packets that have
> > > higher priorities than other normal kernel tcp flows. It turns out
> > > that enlarging the number can minimize times of triggering sendto
> > > sysctl, which contributes to faster transmission. it's very easy to
> > > hit the upper bound (namely, 32) if you log the return value of
> > > sendto. I mentioned a bit about this in the second patch, saying that
> > > we can have a similar knob already appearing in the qdisc layer.
> > > Furthermore, exposing important parameters can help applications
> > > complete their AI/auto-tuning to judge which one is the best fit in
> > > their production workload. That is also one of the promising
> > > tendencies :)
> > >
> > > >
> > > > Also, can we put these settings into the socket instead of (global/=
ns)
> > > > sysctl?
> > >
> > > As to MAX_PER_SOCKET_BUDGET, it seems not easy to get its
> > > corresponding netns? I have no strong opinion on this point for now.
>
> To add to that, after digging into this part, I realized that we're
> able to use sock_net(sk)->core.max_tx_budget directly to finish the
> namespace stuff because xsk_create() calls sk_alloc() which correlates
> its netns in the sk->sk_net. Sounds reasonable?

Updated patch here:
https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.co=
m/

Please review :0

Thanks,
Jason

>
> >
> > I'm suggesting something along these lines (see below). And then add
> > some way to configure it (plus, obviously, set the default value
> > on init). There is also a question on whether you need separate
> > values for MAX_PER_SOCKET_BUDGET and TX_BATCH_SIZE, and if yes,
>
> For now, actually I don't see a specific reason to separate them, so
> let me use a single one in V2. My use case only expects to see the
> TX_BATCH_SIZE adjustment.
>
> > then why.
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72c000c0ae5f..fb2caec9914d 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -424,7 +424,7 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, s=
truct xdp_desc *desc)
> >         rcu_read_lock();
> >  again:
> >         list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > -               if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > +               if (xs->tx_budget_spent >=3D xs->max_tx_budget) {
>
> If we implement it like this, xs->max_tx_budget has to read a
> per-netns from somewhere and then initialize it. The core problem
> still remains: where to store the per netns value.
>
> Do you think using the aforementioned sock_net(sk)->core.max_tx_budget
> is possible?
>
> Thanks,
> Jason
>
> >                         budget_exhausted =3D true;
> >                         continue;
> >                 }
> > @@ -779,7 +779,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >  static int __xsk_generic_xmit(struct sock *sk)
> >  {
> >         struct xdp_sock *xs =3D xdp_sk(sk);
> > -       u32 max_batch =3D TX_BATCH_SIZE;
> >         bool sent_frame =3D false;
> >         struct xdp_desc desc;
> >         struct sk_buff *skb;
> > @@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                 goto out;
> >
> >         while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> > -               if (max_batch-- =3D=3D 0) {
> > +               if (xs->max_tx_budget-- =3D=3D 0) {
> >                         err =3D -EAGAIN;
> >                         goto out;
> >                 }

