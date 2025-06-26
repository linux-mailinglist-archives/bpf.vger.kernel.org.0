Return-Path: <bpf+bounces-61629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D5EAE9361
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 02:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE434170DB8
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357D15B0EC;
	Thu, 26 Jun 2025 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxYkyVRi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF052F1FEE;
	Thu, 26 Jun 2025 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750897495; cv=none; b=OUUIcZJkDqjm4I3tpgfTANZ8ccwRst0ssgLTQJ8ShVCyBNDm1h2LFklKk30efYAMbbzkFdFhdJuQU9Rw071vMFW/3DxZgFxTnJ//YsMqfbqvkxVsxNh9ygPF9a9t23RzC8J5NJWv5SyO1/31YdRiK5vupvO/R3469S7fOVdYQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750897495; c=relaxed/simple;
	bh=3RUBDXcCOOdlEWGj394RlJKkuphbNDVZPadUh0UHBNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuT+Tk3PFAgqlxEARS4Sj7QMIu6h5IkYeEIV+9Qo+/Bysrsv8EO6WywzHSDGncxy/gdegLL7ctGFvHyBs9ND0Vnr8wagCHeaK/aOKU+DT3+SI6lGuXWZtWkBvmipnE+KzMi0bcXZmFkAWhM9HtMbUE4IaZomVQMF8wI1YJzYe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxYkyVRi; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da82c6c5d4so3564005ab.1;
        Wed, 25 Jun 2025 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750897493; x=1751502293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DpDcu8odICYcSvPG11YgRezz0sdLDRgeHofe1ELDoU=;
        b=JxYkyVRiWHXBBYCr3SShKWyM29q9FUnRpYjAfchNV2rwRTIbgiSVc2totr5aU6W9cn
         ngVq6SMGFMkWIO2xIC4spUkvcENFazVtLQxcIep/hmh11RjmaHnMgg7p4nDdfNUl9Fog
         459fP3gk/QqRPjGSvwavLOo1GbPzXEeb8Mpd5BCkBKWoRRT6LTV/6EaJq/+YVu+V7M8y
         nYIVEqSpQnc5E4J2ez2soZEvihvzdiTHaBRSFUb92OVy5kBIdteWHOdquIgYD+kKRKYq
         V+35rdTAxp271BdS3JWGHI1KH4c8tAru0VdJFmXJ9/uOSN2dWVlDvIj5Xf8ZtBjaE0Gv
         QdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750897493; x=1751502293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DpDcu8odICYcSvPG11YgRezz0sdLDRgeHofe1ELDoU=;
        b=Uyql8qbdHoBqQI5z62TvJ+3oIwPbl4rCbSqW2fJplH03PWdLrKxbi4vKTDliQI8DWR
         cAX/XZ1xlGt3OBdoJQmkvGXU8aCh+1idVKHusk1QLc1cECuLC6RiHaLeyGKZpb5367sO
         2KXkQdkSUZT6rpQpV6xHNZV+jou1M1144Zx/oPReoqCBp9mo8QNSwT9CEL9H4T2l0NIK
         17rOjBeeq07o01SzJoZOaWlaqJpc0BGkLgHGVYX/3n0LfxWqY3J/5CefcRzpX2DJvbSc
         I+csxOH4QOVdB+Z6G4JDgHPwDhibyDGBFgUOB4dLr72q8FjGY5KkgiAeP/AO4bNeAk8g
         cTeg==
X-Forwarded-Encrypted: i=1; AJvYcCUPnQwQqTBL6Xg2YAo5dH8mw8H3EAMed4CYwhRxfm7XDk6gRDHcV809ZoMFuJ/DoW4ead0=@vger.kernel.org, AJvYcCVyEsoMHXf5bAl2majzblRPxfTa8fxXnEOvUyunZJMduEotkge0j66cacqsAYjvXEhKfXNiHXyf@vger.kernel.org, AJvYcCWFu363SXdHZFDv/gEabQb89+/r/NK6OcH+MLOxDYnbTUOHqqoKy6WfQy4hrY+ZMUCijbRc8BXLVI1yvjpq@vger.kernel.org
X-Gm-Message-State: AOJu0YxIq4C6veJqSxdA7RRC84zNNteTElk74Rh/oTBUJF2vVIWvjcxN
	AKl0qmX/10RF30VeMj4xNwb7C8ilHoG4Rmc9mUx2I7Udxd+jcJrEfeeSfv4Z7S+UPoMnSL1Hbfa
	yYibd3rdle0G5ONvnfn15ImGzmT4Y5mlsdyow+0k=
X-Gm-Gg: ASbGncuV11xnh7Dg72NjJ/bFXq41/oY3gYHVr0W0x/LgHnqR+QJpl/rvvAErd97bdEX
	Jevp3CaZKPEic3PjLrbJHW74Nk26/yJQAnIWs6DYa20ItVoXMGByqILnMjvoO4gNQAC1/ml8GFz
	Zx/aTUSaUQ1aZf4fJkoJmbKdh0SrTOjRzGVWfhyQ/H5g==
X-Google-Smtp-Source: AGHT+IHtHZaMbuHXKnztiu9cs2xdpESBu0dN6VQeV3lqpz2a3TdX5SwmtdYGOSge9cKK8qiIbygUpjoUG8TS68we2io=
X-Received: by 2002:a05:6e02:1a82:b0:3df:2cd1:f61b with SMTP id
 e9e14a558f8ab-3df327de62cmr62782435ab.0.1750897492975; Wed, 25 Jun 2025
 17:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <685af3b1.a00a0220.2e5631.0091.GAE@google.com> <CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>
 <aFwQZhpWIxVLJ1Ui@mini-arch> <CAL+tcoCmiT9XXUVGwcT1NB6bLVK69php-oH+9UL+mH6_HYxGhA@mail.gmail.com>
 <aFwZ5WWj835sDGpS@mini-arch> <aFxgg4rCQ8tfM9dw@mini-arch> <20250625140357.6203d0af@kernel.org>
 <aFyIRxuBrpRsB0iF@mini-arch>
In-Reply-To: <aFyIRxuBrpRsB0iF@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 26 Jun 2025 08:24:16 +0800
X-Gm-Features: Ac12FXzGwQs2zmklf2_XcL1cpsjKfoR8Pt8xDZ7LtAzluD81WRF_rGvoLqid8-c
Message-ID: <CAL+tcoDkgcBfFsHRzjNCm-VYq8-bV+VjPm259+qu548GurZggA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (3)
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	syzbot <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com>, andrii@kernel.org, 
	ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jonathan.lemon@gmail.com, linux-kernel@vger.kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:37=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 06/25, Jakub Kicinski wrote:
> > On Wed, 25 Jun 2025 13:48:03 -0700 Stanislav Fomichev wrote:
> > > > > I'm still learning the af_xdp. Sure, I'm interested in it, just a=
 bit
> > > > > worried if I'm capable of completing it. I will try then.
> > > >
> > > > SG, thanks! If you need more details lmk, but basically we need to =
reorder
> > > > netdev_lock_ops() and mutex_lock(lock: &xs->mutex)+XSK_READY check.
> > > > And similarly for cleanup (out_unlock/out_release) path.
> > >
> > > Jakub just told me that I'm wrong and it looks similar to commit
> > > f0433eea4688 ("net: don't mix device locking in dev_close_many()
> > > calls"). So this is not as easy as flipping the lock ordering :-(
> >
> > I don't think registering a netdev from NETDEV_UP even of another
> > netdev is going to play way with instance locks and lockdep.
> > This is likely a false positive but if syzbot keeps complaining
> > we could:
> >
> > diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> > index 995a7207bdf8..f357a7ac70ac 100644
> > --- a/drivers/net/wan/lapbether.c
> > +++ b/drivers/net/wan/lapbether.c
> > @@ -81,7 +81,7 @@ static struct lapbethdev *lapbeth_get_x25_dev(struct =
net_device *dev)
> >
> >  static __inline__ int dev_is_ethdev(struct net_device *dev)
> >  {
> > -       return dev->type =3D=3D ARPHRD_ETHER && strncmp(dev->name, "dum=
my", 5);
> > +       return dev->type =3D=3D ARPHRD_ETHER && !netdev_need_ops_lock(d=
ev);
> >  }
> >
> > IDK what the dummy hack is there for, it's been like that since
> > git begun..
>
> Agreed. The driver itlself looks interesting. IIUC, when loaded, it
> unconditionally creates virtual netdev for any eth device in the init
> ns. A bit surprised that syzbot enables it, none of my machines have it
> enabled.

Interesting case I find. Thank you both for the detailed explanation :)

Thanks,
Jason

