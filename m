Return-Path: <bpf+bounces-40014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0497AABC
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 06:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73CAB238D8
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 04:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3244085D;
	Tue, 17 Sep 2024 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAUrAFcU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2E2905;
	Tue, 17 Sep 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726547215; cv=none; b=VAmOI/oj5m/o77R1nMOlzKphIWowIfhG9iz4ntZPAHBISWqzbSFN51tKuGoZdkeFC8JLrbV19Ksz9KFOPkziQEv/IzuhXd/N2xzPg7dxfkuofezOd39dniBYxuIMWaYjufezSCFF+zl1QLASfEaiNTdRF9eK2h2fXDkwI9I9FeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726547215; c=relaxed/simple;
	bh=4ZFZc9C2fBPRpspSfYhuXwhE6eMkHz2Vj8rrsEUo4c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S62ZEjHCHLd2LbtRfSztvE5aMJG1hpVDR8gFHsreWvEOce8zq1xUy+BbhGVa/f4czijiUjY3xpxrsRJPmwE/xDjX6r4HEWGAabYoZVAU59UB6YiOUjGSF+EhsxcqUJcODaKLDNOkbctvuOPem9Nkvdy9HrZ1D4tWwrpOQ/Vuhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAUrAFcU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ddcce88701so17092407b3.1;
        Mon, 16 Sep 2024 21:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726547212; x=1727152012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK5OvXUfL0mdyUzKxKKdl/JIXJEJP8SVVNlRoZdQOtU=;
        b=kAUrAFcUYeBWvsZXsWVx5U6jjCwzS+I+q/tdXVTJ9d1eeT+ONcF7TJXHdAIifnB3CY
         TI5gmwWFa6Y5VvBupCI9KReju0JS8xg1cS3dJNm5Nw1xGbWnM91ZC8y6Kb7ARmYHNsZV
         99fR2ngAYQuVWklSSRSmgfZdQBHF3YdE2MUe7i3MHqMwGebgT262YQ17HhcasOByIWaz
         WbBfZ0vz+Pqas8RAJ0o6vfm+c7yW5Kees7Uka49N99bmDUzPtqF6pO2Da1F2rJ81MJCP
         bz80JtY9+t2RAN5z0YZomlhcQIsVL+6tg5gYXOp6V92dCrNSQYwAmLxhJYMz87m5N2i0
         ZuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726547212; x=1727152012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK5OvXUfL0mdyUzKxKKdl/JIXJEJP8SVVNlRoZdQOtU=;
        b=Tz+PJ+FRdCQbmymOruJQQ942ktTr8ddPEy4F3qcBJK2OS2eFFbJTDRKM+Hl4/PbLMJ
         WkP9twG8URzZLuHmEzVhOlo/fCmlqYyJqW2RyNSszx8Alag9n/v2giw3OU8LuSOh/V/g
         OqDvL+DaQ4/IXLfydXYIU9Jtj8CYkhv59vnU6Ubm58J6NF5IIDPA9oJJXRy/NFLNaTm1
         iGXQRKcfqosuQFibJQYOyEqnXMVdlQT9/EHpOj+HfP0a/iT7iDwDluXh17x01DYOPqUO
         k7QgHjJXxhjUJsdCcfNH6QUZaV4ibBUiQRsGEY4FmrsUXRKQXSM9HNssDWWwB+i1tWs9
         p1sg==
X-Forwarded-Encrypted: i=1; AJvYcCUZMrU3ZACrhNwnjGNdp17HgvWXf21mUwJ39kDr4jY5LpoF4SNpSQa3OpCz6LwXI81LRiQ=@vger.kernel.org, AJvYcCVrtIso5qMwi/vuoLH47c1FlyNlLXBDO86Shzt6H+I47VsvfgOdjaVRDUUSQv5yKKUrigu3hLxc@vger.kernel.org
X-Gm-Message-State: AOJu0YzPxmNbmdrCqfIbI84yH78sJjLc7OvkaFP/5j+Qh/x/8uL+3/km
	Fsb0r0HStiuVndTyTEFWTPS0zE4bYwMvnlWxSCc/09aVuEfzr2OqkZhr09qLHvklkixpXUDTMOq
	mkAWBP1S5j7UQvs3h2cr5a1kq/jI=
X-Google-Smtp-Source: AGHT+IFJujNJfsjLdz6+oDqP3asNL9dMW4qhf/8p2vrP5kxp98FHHFuPjoA9KaoacJeuj5iIMjIOBLfYuummjOALWrk=
X-Received: by 2002:a05:690c:6904:b0:6dd:ba98:5c3d with SMTP id
 00721157ae682-6ddba985da6mr69383937b3.14.1726547212198; Mon, 16 Sep 2024
 21:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916055011.16655-1-jiwonaid0@gmail.com> <05707e9e-08ac-4ee1-b910-883f8b4b2636@blackwall.org>
In-Reply-To: <05707e9e-08ac-4ee1-b910-883f8b4b2636@blackwall.org>
From: =?UTF-8?B?6rmA7KeA7JuQ?= <jiwonaid0@gmail.com>
Date: Tue, 17 Sep 2024 13:26:41 +0900
Message-ID: <CAKaoOqc4PMobrxo-Sz5-1RTG-Qkf+GjDnqyp0zbEUmyDtFu5Zw@mail.gmail.com>
Subject: Re: [PATCH net] bondig: Add bond_xdp_check for bond_xdp_xmit in bond_main.c
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: jv@jvosburgh.net, andy@greyhouse.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	joamaki@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:48=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 16/09/2024 08:50, Jiwon Kim wrote:
> > Add bond_xdp_check to ensure the bond interface is in a valid state.
> >
> > syzbot reported WARNING in bond_xdp_get_xmit_slave.
> > In bond_xdp_get_xmit_slave, the comment says
> > /* Should never happen. Mode guarded by bond_xdp_check() */.
> > However, it does not check the status when entering bond_xdp_xmit.
> >
> > Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc187823a52ed505b2257
> > Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driv=
er")
> > Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
>
> How did you figure the problem is there? Did you take any time to actuall=
y
> understand it? This patch doesn't fix anything, the warning can be easily
> triggered with it. The actual fix is to remove that WARN_ON() altogether
> and downgrade the netdev_err() to a ratelimited version. The reason is th=
at
> we can always get to a state where at least 1 bond device has xdp program
> installed which increases bpf_master_redirect_enabled_key and another bon=
d
> device which uses xdpgeneric, then install an ebpf program that simply
> returns ACT_TX on xdpgeneric bond's slave and voila - you get the warning=
.
>
> setup is[1]:
>  $ ip l add veth0 type veth peer veth1
>  $ ip l add veth3 type veth peer veth4
>  $ ip l add bond0 type bond mode 6 # <- transmit-alb mode, unsupported by=
 xdp
>  $ ip l add bond1 type bond # <- rr mode by default, supported by xdp
>  $ ip l set veth0 master bond1
>  $ ip l set bond1 up
>  $ ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx # <- we need =
xdpdrv program to increase the static key, more below
>  $ ip l set veth3 master bond0
>  $ ip l set bond0 up
>  $ ip l set veth4 up
>  $ ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx # <- now we'l=
l hit the codepath we need after veth3 Rx's a packet
>
>
> If you take the time to look at the call stack and the actual code, you'l=
l
> see it goes something like (for the xdpgeneric bond slave, veth3):
> ...
> bpf_prog_run_generic_xdp() for veth3
>  -> bpf_prog_run_xdp()
>    -> __bpf_prog_run() # return ACT_TX
>      -> xdp_master_redirect() # called because we have ACT_TX && netif_is=
_bond_slave(xdp->rxq->dev)
>        -> master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp); # and =
here we go, WARN_ON()
>
> I've had a patch for awhile now about this and have taken the time to loo=
k into it.
> I guess it's time to dust it off and send it out for review. :)
>
> Thanks,
>  Nik

Hi Nikolay,

Thank you for taking the time to provide a detailed setup and call
stack analysis.
Would you be handling the new patch? If you don't mind, may I revise
this patch to

- Replace with net_ratelimit()
- Remove the WARN_ON()
- Update the comment appropriately

Thanks again for your insights and patience.

Sincerely,

Jiwon Kim

