Return-Path: <bpf+bounces-61191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3FAE201C
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1993B08F5
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A12E6106;
	Fri, 20 Jun 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOIM6B/x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB61E3DDE;
	Fri, 20 Jun 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437082; cv=none; b=ToD9gBYDfpa6lYxsETIQ3cSxEETK4FcE1CRajpxNiKQPYIQQc497BTVkFuopQ8jSI4Misrgsme4sEKgaw1IYU/7jBceFVau/Crmc3pxZpzUrwm7S6SZHkPDA1uKaGXI28OEL4t52qEL3FVaU6lwYVFJ8oLCKXjhOluj/ai1Thho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437082; c=relaxed/simple;
	bh=4sbsZqCE1rF5yVWqpkpQtPHXStY+RErWV7DDGxcLf1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRraEZUZsxSyOgYnhWBrZpc71Fh3PewbubtXxOHDhd1pNaTOSM+Pwj34+YIYOMTf3RTLvfh+0lnF76jaS3lavrtN6OyXD2JpUyltWpxNoSiqBkI5Klto6uEOo9rGNnMExPgYItywugtW6oTyn8XeyiY27jCItKrR7/dy+NdDy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOIM6B/x; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so21546955ab.2;
        Fri, 20 Jun 2025 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750437080; x=1751041880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/tDM88fXj8xDHAIPia+OJT6RdpVlLQreMkpCm8cOPQ=;
        b=GOIM6B/xEL5/EMoImEm46WTYHJnZRIhahmGpkDizVaSFtDgNUi3X+u8l0xv76/JZm4
         LzI8YNWynT1BBGUxO3pCxHz1aaxZCZ4RBjX2iueCKyMixxIn1kxof/whsVWDj2UrMBqV
         G4EWtyoSte1FGVifLCecxdvh0XpZFJDaU6tVgwG/2NtbJVKukQF7WVTTT2gnDxtqnECg
         Sspj8gIBpQUO6vJtPM36s3eWF2DH4eBRIll2IEA3nkZSxRYaXomJ+qlfhf+tQk0yj5qa
         Cg1g0hG75daL1smccsv8pkqAG2PvgS5WOgM5SsXjNWPtmhSkohWEOyvMI3c6Y8Ka3O5g
         loDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750437080; x=1751041880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/tDM88fXj8xDHAIPia+OJT6RdpVlLQreMkpCm8cOPQ=;
        b=EvkQUYHDyc6aNBAv0uFqNRfIMX3LqF3usqzBwERf7+CNEQq0strkYx3kyvf79MAVYy
         Ue1Lg+kshZltoDW0v5IjYhi/mY4CBM3f3f406tpgSLovwviDJL4B3b7DcSUOXitMwLHF
         TpwQrFJQaYO1pvuTJPMegtXNV0ZD7qlRCZGo0qPzkNTsCwsW+SZIGxocDRgehfiNRve8
         +oDYfNYvd67jal0T9rNv25aEWHcmvUOv9aczoDoAQfKwAD96epAhuFZLel/rz2iwgzFw
         5pKgqTPMFxh/eccA/Cm9KNNUNTKYibuVGfNEGAaOW/z6PqCWOBFMxxfuWmyigF8l+LT4
         LT6w==
X-Forwarded-Encrypted: i=1; AJvYcCX8RlvOutM5RGulJKHdnLcOEoZrzKhj4hAYZ1m7yqTS4L4Pqw1frOV0BXwUv+98g1aGJYLw50G4@vger.kernel.org, AJvYcCXlOfOuXPvCznY6spBwi37n4g05AKvUv/ZRv6Sp1/wOFWwRmGgR1WY0chomcJVIYk4/4cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx445hK8e47vjje98zTZnAJGJiSrpvz5+BpRgHH/v/0a7doEfWN
	HBn+zzGW7mdORKXT7J2AZrhIkzfyJnGn2F2Sg5cwTBAJIV6UawPLtk24SHRUpYKLudtCpg1uu99
	nibtcwxuPksecmoE/pXhpLe0HH+ilSCc=
X-Gm-Gg: ASbGncv1+M10inNJ4NKDAxNJy/8unWGmMeVtVsrS5CMvRMaBTQO3a8PaTCaFTuprWO2
	P4b0E71oLbM91en6cbwPcv68DCnKC1rVnljTPyb4dJblIw8Hvuhq+PLAIELnPVPzgkBWA/Qnt//
	dZ4uQn45llr6FOjVI7YDCLjmMrMnUAKqeKaKwxIr+6VrI=
X-Google-Smtp-Source: AGHT+IHJnt2i2lvBYHJBVnl0qdHEV9posPH8w6ycM4Ze1lIfPrq1yv4klS/0hZ0BLXuE2bMxeYTTqXxlcSqn8x2JMi4=
X-Received: by 2002:a05:6e02:398a:b0:3dd:b7da:5256 with SMTP id
 e9e14a558f8ab-3de38cb9723mr41197085ab.19.1750437080052; Fri, 20 Jun 2025
 09:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <aFVvcgJpw5Cnog2O@mini-arch>
In-Reply-To: <aFVvcgJpw5Cnog2O@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 21 Jun 2025 00:30:43 +0800
X-Gm-Features: AX0GCFsc15In70xYN_6jABjzOR8CXb-eXGd8Z7kFnBj4RoF2KREH7pUsxmW8F0k
Message-ID: <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 10:25=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/19, Jakub Kicinski wrote:
> > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,=
 struct xdp_desc *desc)
> > >     rcu_read_lock();
> > >  again:
> > >     list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > -           if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > > +           int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > +
> > > +           if (xs->tx_budget_spent >=3D max_budget) {
> > >                     budget_exhausted =3D true;
> > >                     continue;
> > >             }
> > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> > >  static int __xsk_generic_xmit(struct sock *sk)
> > >  {
> > >     struct xdp_sock *xs =3D xdp_sk(sk);
> > > -   u32 max_batch =3D TX_BATCH_SIZE;
> > > +   u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> >
> > Hm, maybe a question to Stan / Willem & other XSK experts but are these
> > two max values / code paths really related? Question 2 -- is generic
> > XSK a legit optimization target, legit enough to add uAPI?
>
> 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
> whether we want to affect zc case given the fact that Jason seemingly
> cares about copy mode is a good question.

Allow me to ask the similar question that you asked me before: even though =
I
didn't see the necessity to set the max budget for zc mode (just
because I didn't spot it happening), would it be better if we separate
both of them because it's an uAPI interface. IIUC, if the setsockopt
is set, we will not separate it any more in the future?

We can keep using the hardcoded value (32) in the zc mode like
before and __only__ touch the copy mode? Later if someone or I found
the significance of making it tunable, then another parameter of
setsockopt can be added? Does it make sense?

Thanks,
Jason

>
> 2) I do find it surprising as well. Recent busy polling patches were
> also using/targeting copy mode. But from my pow, if people use it, I see
> no reason to make it more usable.

