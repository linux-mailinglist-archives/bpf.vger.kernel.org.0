Return-Path: <bpf+bounces-21354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491984BA40
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FF31F26F0E
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5413473D;
	Tue,  6 Feb 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9Ez7Kfu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5596133407;
	Tue,  6 Feb 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235005; cv=none; b=HfMlwO2t3p9PJEvpTfJZAA0fRxvHCMxF6/zDT7MHkMVEWviZzs6OMZ8s3Iv4v3kgBbIV0/4ZSBMbHrvCmJds4ozKcqtbvc71QBI0alFB7RkUNpp80hOGTDdPBLZAwnjQ12tiaGm6AisHB5bVYK6Nbq89lK81NGzQiQEt62P3x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235005; c=relaxed/simple;
	bh=Cf3fx9/dTuzAp7zRtOrJFon6FFKH+gZ32Cz9TPwfJaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1QBZvptNzTjld1Vafqc6RhpTH3QnRnaEiZQFzD4A+aM7ZBEmh9BhTpdCh3xSBVN4eWT0xtJh04o/ril5fH4xSRKAbINI2aPPOypKnWYmtgLKs3Mrj7DX0XyNBKaCPxjq/acj2B4ANKf38FXuewyB0W+UwTL00fZVeDxUCysbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9Ez7Kfu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c7e7f9945so13385316d6.0;
        Tue, 06 Feb 2024 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707235002; x=1707839802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG69KzxuKhie8vTgQUQq9i8+BamIA+lRTWMTWZGWeu8=;
        b=O9Ez7KfukZLVFaTrmTHrP9c8Xdv+pwRh9terH+nDGiYSzyLLLUbPKoCEnoooiYbrAq
         24n8zO8Crpc7wg2QP1AAWBKY5ZRkOdaruUrK3SIwWO7mDR0xvZtPEktcSXxZ/cHyXN+i
         YoVuQjSNbH31ISAlzbP2wo03ImHcUl2vN6fyDLFR0xN6Wo/vtNns5DkW6x9fP37YKQU/
         2kD7GDZStAQjBFz+lytq6ve8rw9ZHlX4kSr399YCptqjRBTOv/WWyFABBmcWbfYwemt+
         eG3ZRIe0Wagt0ccqq9sNeK4Lbel7YR4+L8ESd7cQEQI2o8mQvR5nfdXkx/p0NZqS7t7S
         CdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235002; x=1707839802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG69KzxuKhie8vTgQUQq9i8+BamIA+lRTWMTWZGWeu8=;
        b=jdv1O31t8FmU8imUlTNnkYrAJavmWg3PZGgpTyt7SVP9bamm5n26MYx5aRtFxfFKKJ
         A6Re51kfeWv8mpZmvaxTJebBQfccR6K7jcIZ7tyxbIszqjwOUPxkfLZaUfQT+/Orz7U6
         inf8ZqmCY78nWWleuYhb09hRmCRXIaqx4eOmWqH6qzRN1cRDLK+bzLA+bqrCnpkNuOfw
         udirT1KVB4DvRT2FtOR5+pcXBFTO+hYWbb8bhNw7zoD+djCT0En31a6Im4y5F0zeCRei
         urPBh0JyQCh1IjQ+vHiNOr9zLogSKuTb0gOiNt+OmHBpiRJ7p6f8/9qtALqswau42Jue
         nVuw==
X-Gm-Message-State: AOJu0YxGZgLbp8uZxmEc+xKouTQjjFJHRmQg+svglyL1GmPwiKpGbuv5
	/cn+AU5s07tzFJH+zJzdbu0WZINPgU+aXqQK7YeY2v6AfSb0ykuACQrAdpAJto4UJFeiuEj/WHv
	sxkOsWOAN8uZpfRiLNHWAYM+VfjQ=
X-Google-Smtp-Source: AGHT+IFHUm9sKcVf5znGACsC+ZJJyAi8/kgfvnevwiPOBfIbxGhlknaXHJ21MGm5aeWvjNsm0xgjPxhEgBBjqURWOvk=
X-Received: by 2002:ad4:5049:0:b0:68c:b046:db72 with SMTP id
 m9-20020ad45049000000b0068cb046db72mr2638314qvq.4.1707235002552; Tue, 06 Feb
 2024 07:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205123011.22036-1-magnus.karlsson@gmail.com>
 <87le7zvz1o.fsf@toke.dk> <CAJ8uoz03-AcOwMj3-20ritbYQT9CSJMQ8oz6OuhyE-U=2F7+Gg@mail.gmail.com>
 <ZcJNUyUV_Z-GkFBV@lore-desk>
In-Reply-To: <ZcJNUyUV_Z-GkFBV@lore-desk>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 6 Feb 2024 16:56:31 +0100
Message-ID: <CAJ8uoz38b8vXc=4J9Pww1FZ+GHS4L45NuJWtmd5wzyYxqgAzZQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, j.vosburgh@gmail.com, 
	andy@greyhouse.net, hawk@kernel.org, john.fastabend@gmail.com, 
	edumazet@google.com, bpf@vger.kernel.org, 
	Prashant Batra <prbatra.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Feb 2024 at 16:16, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > On Mon, 5 Feb 2024 at 14:08, Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
> > >
> > > Magnus Karlsson <magnus.karlsson@gmail.com> writes:
> > >
> > > > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > > >
> > > > Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
> > > > bonding driver does not support XDP and AF_XDP in zero-copy mode ev=
en
> > > > if the real NIC drivers do.
> > > >
> > > > Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
> > > > Reported-by: Prashant Batra <prbatra.mail@gmail.com>
> > > > Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6=
XkMTamhp68O-h_-rLg@mail.gmail.com/T/
> > > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > > ---
> > > >  drivers/net/bonding/bond_main.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c
> > > > index 4e0600c7b050..79a37bed097b 100644
> > > > --- a/drivers/net/bonding/bond_main.c
> > > > +++ b/drivers/net/bonding/bond_main.c
> > > > @@ -1819,6 +1819,8 @@ void bond_xdp_set_features(struct net_device =
*bond_dev)
> > > >       bond_for_each_slave(bond, slave, iter)
> > > >               val &=3D slave->dev->xdp_features;
> > > >
> > > > +     val &=3D ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > > > +
> > > >       xdp_set_features_flag(bond_dev, val);
> > > >  }
> > > >
> > > > @@ -5910,8 +5912,10 @@ void bond_setup(struct net_device *bond_dev)
> > > >               bond_dev->features |=3D BOND_XFRM_FEATURES;
> > > >  #endif /* CONFIG_XFRM_OFFLOAD */
> > > >
> > > > -     if (bond_xdp_check(bond))
> > > > +     if (bond_xdp_check(bond)) {
> > > >               bond_dev->xdp_features =3D NETDEV_XDP_ACT_MASK;
> > > > +             bond_dev->xdp_features &=3D ~NETDEV_XDP_ACT_XSK_ZEROC=
OPY;
> > > > +     }
> > >
> > > Shouldn't we rather drop this assignment completely? It makes no sens=
e
> > > to default to all features, it should default to none...
> >
> > Good point. Seems the bond device defaults to supporting everything
> > before a device is bonded to it, but I might have misunderstood
> > something. Lorenzo, could you enlighten us please?
>
> ack, I agree we can get rid of it since the xdp features will be calculat=
ed
> again as soon as a new device is added to the bond.

Thanks. Will spin a v2.

> Regards,
> Lorenzo
>
> >
> > Thanks: Magnus
> >
> > > -Toke
> > >

