Return-Path: <bpf+bounces-21297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967DC84B1A6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 10:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5218B285B16
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788DE12D75C;
	Tue,  6 Feb 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQUQ0wxW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8212C7E1;
	Tue,  6 Feb 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213354; cv=none; b=czriAPE3D0/w9dmokpvlUm21H3Dcoblv6ni/u+Dd6kgqFsrSV1KHGXEXehVQCTyjq2fTOc5cI9RJk5H29YQN8Nmf7pmiE5bfsJqvRf5N0aKwFl6N1G941akZORDKZfzGRaOYyILpu5bZj22T6vK7mBoTsEeMMN1kT1Qn5NiELno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213354; c=relaxed/simple;
	bh=9+W6XW1DT0/xcjV67vvB8Afk3ehs/LbVHwL1MPz6W1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j83QtOoGIl/jKKvGzHLMcXxKKtSND3w+28h69ETRZZy5AuA7TFScyFTL8fzwtHWgJdYSomK08R3f6Lpml1JacD9lTdsEMt6mCyt1WvJI3cEUlPVwz7MqQQQqiNF788dS1Jq/atQsOZq5zCaU2QMsizUDh8vUsvTF1lgAuo036Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQUQ0wxW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68155fca099so17541906d6.1;
        Tue, 06 Feb 2024 01:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707213351; x=1707818151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6paK/6xBJ4EAsIC2x+yrHqNaN5F8qhKNNYWgufdQ5lQ=;
        b=lQUQ0wxWojDzle8Ff/SfP0m3S+kZRiWWX+2C9rc6miV+g+ybE2uz40XuMvzQy/3A7S
         36dW2nzrC3f1Vp0N/A9WNT4V3IIvok9XvvU5gRtj5Hp//mOOLBRLpiJAwSVwe6cfoECp
         N6YfJqR/wKYHVhD71YLa+oyhr+TWSUTpfw/YjSHdjJ14YifUkMiaOXm01YO8QGJCJmh1
         3EAqCDV5SOsljD9Z2Tr5OCuYoTo1mSExr6MOk1aiigHIOTjl+09gUlHddE+MqvBG/Q6P
         Rc9wSkuvt3fGVhO0SOKPAUHQDfJYMBdqAcp5UyWOiK+APBFeC7bSpqr0PGpM69r9VO+W
         7aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213351; x=1707818151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6paK/6xBJ4EAsIC2x+yrHqNaN5F8qhKNNYWgufdQ5lQ=;
        b=X+aXZhwyUkUqxBZmWc/Kt2j7NX6W6GzboojMHikW7mxdDLliZmCOaaRiHPu9GE+0ii
         NT81DL1z8i59cUC+UXD4q7AReI8YKOZGVDhf+JzQoPsYmMpDtQjC5bC+JsYO0wgPufld
         Q+aIRhfOZglq5PHnEEqHpdgevpMCUWL7iG6hbOCTZ+3LJRlkxTOU/NaGZvvmIxX0xwCV
         COmHV33PWg9erAFhxGt5zJDwOtBrNqJJdz4vaY6hS/LZAxBeIZ8pMigzxnlyK6ga8JxB
         HTkJ3CIsct+sG5E3dR8QhTH9pSl5FUS/EiqvCaMlFS6PTJrOSN/94FqxwAv2Ua1yEu2K
         mMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzYYfoUOO1dufQgLaOFFo5GiH5fn43kEJWeKPFJKiEqw1M7PK2PxLMLd0ZQF6TE13dxNBjuUWfZzODi7oLj0VgKOJxcC7UdlhRFQy95ZgTa1ArIaIm0sqGMa7k
X-Gm-Message-State: AOJu0Yy270t1HIiLiTv75Gsv2XEoIieNb2CBy67oHojVAPdf/7co4Lcc
	rVpU7deltx46ckmfBaf51NH2RO4PMz4dwBgbUYPjCcPPFY9evH0eEPzPtLRjBLg9eImGBkRDHCh
	NQYn/sE++B9E5Qca48yhmN1ofqTk=
X-Google-Smtp-Source: AGHT+IF+oK5GAVDZ/icb/MBqJdtul50E1qWgJqqyPzsae5dVKtB8IgM2EPsrwVjw+GLN49FOGy8/8BAOJ1+Klr3uk44=
X-Received: by 2002:a05:6214:5490:b0:68c:b761:39b0 with SMTP id
 lg16-20020a056214549000b0068cb76139b0mr281717qvb.5.1707213351275; Tue, 06 Feb
 2024 01:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205123011.22036-1-magnus.karlsson@gmail.com> <87le7zvz1o.fsf@toke.dk>
In-Reply-To: <87le7zvz1o.fsf@toke.dk>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 6 Feb 2024 10:55:39 +0100
Message-ID: <CAJ8uoz03-AcOwMj3-20ritbYQT9CSJMQ8oz6OuhyE-U=2F7+Gg@mail.gmail.com>
Subject: Re: [PATCH net] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, j.vosburgh@gmail.com, 
	andy@greyhouse.net, hawk@kernel.org, john.fastabend@gmail.com, 
	edumazet@google.com, bpf@vger.kernel.org, 
	Prashant Batra <prbatra.mail@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Feb 2024 at 14:08, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com> wrote:
>
> Magnus Karlsson <magnus.karlsson@gmail.com> writes:
>
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
> > bonding driver does not support XDP and AF_XDP in zero-copy mode even
> > if the real NIC drivers do.
> >
> > Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
> > Reported-by: Prashant Batra <prbatra.mail@gmail.com>
> > Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6XkMT=
amhp68O-h_-rLg@mail.gmail.com/T/
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index 4e0600c7b050..79a37bed097b 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -1819,6 +1819,8 @@ void bond_xdp_set_features(struct net_device *bon=
d_dev)
> >       bond_for_each_slave(bond, slave, iter)
> >               val &=3D slave->dev->xdp_features;
> >
> > +     val &=3D ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > +
> >       xdp_set_features_flag(bond_dev, val);
> >  }
> >
> > @@ -5910,8 +5912,10 @@ void bond_setup(struct net_device *bond_dev)
> >               bond_dev->features |=3D BOND_XFRM_FEATURES;
> >  #endif /* CONFIG_XFRM_OFFLOAD */
> >
> > -     if (bond_xdp_check(bond))
> > +     if (bond_xdp_check(bond)) {
> >               bond_dev->xdp_features =3D NETDEV_XDP_ACT_MASK;
> > +             bond_dev->xdp_features &=3D ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > +     }
>
> Shouldn't we rather drop this assignment completely? It makes no sense
> to default to all features, it should default to none...

Good point. Seems the bond device defaults to supporting everything
before a device is bonded to it, but I might have misunderstood
something. Lorenzo, could you enlighten us please?

Thanks: Magnus

> -Toke
>

