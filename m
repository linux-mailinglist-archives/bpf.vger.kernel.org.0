Return-Path: <bpf+bounces-61179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF53AE1EB9
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3276A504B
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59992C17B2;
	Fri, 20 Jun 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAC0VUtK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA792C17A3;
	Fri, 20 Jun 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433154; cv=none; b=ZkLadge881q7m8TomrC1MIwlY8Malz1YHbB761VNzQr13aLVHnO91R+/uwsPtLmLTH5xtVgzIviK3cBDqZEQxFXAm6zWMnjRpaI2QxMU2fxsbD1B3Ji/sawqYO7MzdaGiOVD4yUXN3K9FXrIaPzN1zzJxURmsQLnfMspC7BxHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433154; c=relaxed/simple;
	bh=RE15CXp7q9MDNu7TbG536xtXK0Ad6j2FShs9YlwKdvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBGLYnNFQoTTDlkx+xjZKplm4VnKTNiCLh6yK/AwNsxGCDMo3kFwRqU1w8MELqiZZyr4T1OfdPC8IXWh1nu0MgUOyssTNbYzKA1bUgtAX42EfBuPBBfeyovsSJvB/HpxQuqAbloDqhQvN5Sp16BdKtg3GCI5g5h136EBqHXp3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAC0VUtK; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3de1875bf9dso19836685ab.2;
        Fri, 20 Jun 2025 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750433151; x=1751037951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtZXr39TfTn5a2u1fSGPytD48GF3NjVL7E0wKZncWfE=;
        b=DAC0VUtKBX6op2/gXuUqnTBFaMbAq0gngqSy+GEJ4JjU0b2SP+gPX+d1EDMaesdgPP
         5F3lgtTuRYHhyBSZA1RRJMhpCDygezAtO7SXEkWt41aoDU/4FCdv1iQErr3diV8HIojS
         zF+ishheeKv8UGA4tWOtKDyrrNYvWWktzqVg/QyJt7u9rdmQAqIaUG0skAE4cmOt1PBj
         bpnrzfahU5j25X+8kn0tYQSPPTG+cFpxyvxeaxRa+nfs426Agee+5OID9sOmpjp6QAQn
         JKR6MqVWgNN+GvBhJUX81ge0xr7uPgz11gZ31xh1lODN3P+H7tHCXf1RQjkX/jqL+Y/y
         5fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750433151; x=1751037951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtZXr39TfTn5a2u1fSGPytD48GF3NjVL7E0wKZncWfE=;
        b=mkuOqyqIQo5/EGPlpbi4gQfPI1w/jJeiNJXOzW77mFduBgRUL1UylgnzXx1t78/ZVz
         e2QJbhpGtagDvUJsr+lPu67+L4HucF7J+IIWsohP9hjnWRiP7g4ik3ScAXsZYeqdo8do
         Zpbkr8GTcpTF8oKnl0PiO9pfD9ODNZ+yBHcVAB5Qyci9Yyz6kCK8h+GVmUsnfkZZ5tHv
         486SlAoYE0IKi7vv+rqFYUEVZnbdO5mBxietE8GqqRPMZcSSxPYQtVB/NSVOn+DCoBa2
         wpl7L8y6ghGsohgJPASzoYMOlzRAopPIW30v4OgsJJbJcdI1fHEGlakogoF7zkwF+AMy
         cmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhNvw6qAy9AvtUL4LGamqiIyoi2EQLwsyqvauUGOMT25mnW247k3GUxrPQqOfyscErmyrJLl+1@vger.kernel.org, AJvYcCXiCY/yxa+1q4RYwF+XyNWecQusO8XKvtegXBpJTPpouaTwGXv4nXBHfLgh/ek+sfxj0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fZ7sIwzytzyK3bxNeZZeVyq3L2H3mRxdFS1X99hguIJHF4LE
	jizR5bUdmKdFKuOP9tJ6NrhsIsgo9M9WcFh6tR0QVT7Q/21VDSUfP57KdwT0kdHJuyuTbWfVcvP
	1uUuL+H17drqACcKDmW1hx/U5qG23tlQ=
X-Gm-Gg: ASbGncs/ym/5K/qfGyWQPme1NAWKYw1vWDql/14HXxghYOZZvBerW4IuiK6h6ba3Pi8
	rrzunZZFjowAurJFF4to73se08IYkrcKT1Wgjbmtau/TaxubOdFgx9Euk1t4bGgiQ8xw8xF7v8o
	b5Ur13gmDKFIT3VU/OEbJ87q7he7f4SINU5HJfoPGVmA==
X-Google-Smtp-Source: AGHT+IFQ5yarmqVdQ+VBfX5TrdXJ24OTL/cWjQB7+hYPemti4GB3FDnXMmTbHwz9a8WFen4PF+JiIM62OIFDmhXKszQ=
X-Received: by 2002:a05:6e02:1f88:b0:3dc:857c:c61e with SMTP id
 e9e14a558f8ab-3de38cc89femr37624175ab.15.1750433151418; Fri, 20 Jun 2025
 08:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619093641.70700-1-kerneljasonxing@gmail.com> <aFVr60tw3QJopcOo@mini-arch>
In-Reply-To: <aFVr60tw3QJopcOo@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Jun 2025 23:25:15 +0800
X-Gm-Features: AX0GCFsD-OOwvIzX1kNIDvE-lCLmAKdoN5M1-G_BBE3A1mUXMziagY33YJ4jYz8
Message-ID: <CAL+tcoBLAMWXjBz9BYb84MmJxGztHFOLbqZL-YX0s7ykBjNT7g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: xsk: update tx queue consumer immdiately
 after transmission
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 10:10=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 06/19, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For afxdp, the return value of sendto() syscall doesn't reflect how man=
y
> > descs handled in the kernel. One of use cases is that when user-space
> > application tries to know the number of transmitted skbs and then decid=
es
> > if it continues to send, say, is it stopped due to max tx budget?
> >
> > The following formular can be used after sending to learn how many
> > skbs/descs the kernel takes care of:
> >
> >   tx_queue.consumers_before - tx_queue.consumers_after
> >
> > Prior to the current patch, the consumer of tx queue is not immdiately
> > updated at the end of each sendto syscall, which leads the consumer
> > value out-of-dated from the perspective of user space. So this patch
> > requires store operation to pass the cached value to the shared value
> > to handle the problem.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 7c47f665e9d1..3288ab2d67b4 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -856,6 +856,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> >       }
> >
> >  out:
> > +     __xskq_cons_release(xs->tx);
> > +
> >       if (sent_frame)
> >               if (xsk_tx_writeable(xs))
> >                       sk->sk_write_space(sk);
>
> So for the "good" case we are going to write the cons twice? From
> xskq_cons_peek_desc and from here? Maybe make this __xskq_cons_release
> conditional ('if (err)')?

One unlikely exception:
xskq_cons_peek_desc()->xskq_cons_read_desc()->xskq_cons_is_valid_desc()->re=
turn
false;
?

There are still two possible 'return false' in xskq_cons_peek_desc()
while so far I didn't spot a single one happening.

Admittedly, your suggestion covers the majority of normal good ones. I
can adjust it as you said.

>
> I also wonder whether we should add a test for that? Should be easy to
> verify by sending more than 32 packets. Is there a place in
> tools/testing/selftests/bpf/xskxceiver.c to add that?

Well, sorry, if it's not required, please don't force me to do so :S
The patch is only one simple update of the consumer that is shared
between user-space and kernel.

Thanks,
Jason

