Return-Path: <bpf+bounces-40066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A597BDAB
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 16:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B221C221E5
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61418B473;
	Wed, 18 Sep 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMedvZJR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D118A6DB;
	Wed, 18 Sep 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668458; cv=none; b=OQ1ph/K01g9gXEEBiIyMqnS3inQMi2jn8PztEQJInPr3dNY1qe5Z7UwXS9rHXt4zhYbrRDDHNjsm74ZtTeHNx0d4ajEP8d6xYKi6DDaD6PdoDkeN0A1BErNITE8ChbS4Uhd2+7S94wminwaGECoBpF7z2kY0MNhroex9wagz5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668458; c=relaxed/simple;
	bh=0VL0a3WZNBu3lnikVkXDU/US1Zxg3JW7usdy+pnkQys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5DBLZKZtRfiP3M1EjDzi0MhWTEF42em2I++TighCZwScGExuS6SD1JSvEqM6lcA+q+7w+AZ5H8BxtNgVGykEX6Blqu145NyU/z5MJP6RKaMp1R+JGMSc4BjOT8swW/2xVCrsG5yggX8JuySSp7qs+L2ZRR/Wxg2puK7R5kFHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMedvZJR; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b747f2e2b7so54835087b3.3;
        Wed, 18 Sep 2024 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726668456; x=1727273256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jghMkTEcbjlD4OE1ywGj7BxBKpwmV/lECXNj48rxHA=;
        b=HMedvZJRJjwZYgQSDOlMh3VXVk3AIMEfVAX7ygyZL84jr0dwCEdNe5KcohILtFhvGL
         GGer+KpvS6hZIAQhnIWnIsbNHO0+G8u6VCt0KdJ7+nLJ2wXXPaRgFZ7HHVriA5/b1ZHS
         sYvfU3Ja8iE4yIIF7mzFr/4TT44jABFi8jjUEC7zf+IgEOyFoXF+rqm8qxv7rZRJ2d4I
         RPMNHYQaxOVZdC3casEtNw0S0aoMOp93Rqo0Kfjz/c0pQS57/ONiRHJtt9X44aR5jRn+
         h2jqFJ5XR9IsXCcecen3U/RiRUOINQBVLhPctE4IBMa/VkKtgPxO/plLXyIezHolS0rM
         9/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726668456; x=1727273256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jghMkTEcbjlD4OE1ywGj7BxBKpwmV/lECXNj48rxHA=;
        b=O85VlNMmKbdGWVPp2+y9V8vQt6sjyGo6ai98wPSE28pO8HwaLMFHbzRwY8ygNBPLIU
         4m1xfJm29kwcngNJTaE7PgjTZTQM4wT4w9MGE+04rbhEh+RDqtgL9zE2R6y+cOsLCtsP
         fqPVeVjX/y3VeMNoDjhu17hHiTx9TnzxtVGV/g8G6pe3qdp6VtO5kP9F8XLIeXdkGIk1
         dOKCJ1Sw1EwA5Yl5RS630jUC1QVTN/0XokiFLJ5vZsXzSO3v5CJV69pK+QP9M03PYrpf
         RPBkcAx3Yty9Q8LZJ/3nKktFWpGKxNgIsqKd1jq47eCEitA84zjuNwCiR4yHlkqB+xIF
         w78w==
X-Forwarded-Encrypted: i=1; AJvYcCV4OoKonqTkl077m0wQF1rVv155Tak17hlCqxTUYvxM6THVDY3HF9/ANdsjZl8ZGH08aSE=@vger.kernel.org, AJvYcCWJTNAPNYB2hXInEh9k/OcziqAYLxll5lbVS4PKmkQXO8beYx27Ucd2ijXDtAIhdR9RFEU21PD1l4Uuqvop@vger.kernel.org, AJvYcCWqFpmee7xHRYduMOYZuVwv5To4et/An5ouL3U2LPiJNBSbUx35aDFRyjXcsk2gSR83CKfqi4sV@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxbEdlepiW4+Hcgk4kB7tVfVeqFSVGRKHuJ+yi5ggLUyu/lA9
	L1TA6haVh0I1cyokK3n/5Jkqag6f72nNFiCJ3ggEAYqWrFyfka/66tH6EVgJiRHV692EZhBN3G7
	pNsaQmJz8jXzzlxwIsdA6pobaQX1lC268
X-Google-Smtp-Source: AGHT+IEPYZ/AGU3WeOEb8yIO/jp0/diGMF4lCbfcmFw62ZeScK7svyOFn5uIVh2cTML4YNoOIYkBwlfIF/cW4XgHBGE=
X-Received: by 2002:a05:690c:6305:b0:6db:e213:580b with SMTP id
 00721157ae682-6dbe21359camr105883427b3.36.1726668455897; Wed, 18 Sep 2024
 07:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918083545.9591-1-jiwonaid0@gmail.com> <ebef9a36-d060-4df3-b139-3dda4a84484a@blackwall.org>
In-Reply-To: <ebef9a36-d060-4df3-b139-3dda4a84484a@blackwall.org>
From: Jiwon Kim <jiwonaid0@gmail.com>
Date: Wed, 18 Sep 2024 23:07:24 +0900
Message-ID: <CAKaoOqdCh41iBbzuZjx3mJpOXBh0aaLmBRd7Pz9jjwBFLqAifg@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: Add net_ratelimit for bond_xdp_get_xmit_slave
 in bond_main.c
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: jv@jvosburgh.net, andy@greyhouse.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	joamaki@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 6:51=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 18/09/2024 11:35, Jiwon Kim wrote:
> > Add net_ratelimit to reduce warnings and logs.
> > This addresses the WARNING in bond_xdp_get_xmit_slave reported by syzbo=
t.
> >
>
> This commit message is severely lacking. I did the heavy lifting and gave=
 you
> detailed analysis of the problem, please describe the actual issue and wh=
y
> this is ok to do. Also the subject is confusing, it should give a concise
> summary of what the patch is trying to do and please don't include filena=
mes in it.
> You can take a look at other commits for examples.
>
> > Setup:
> >     # Need xdp_tx_prog with return XDP_TX;
> >     ip l add veth0 type veth peer veth1
> >     ip l add veth3 type veth peer veth4
> >     ip l add bond0 type bond mode 6 # <- BOND_MODE_ALB, unsupported by =
xdp
> >     ip l add bond1 type bond # <- BOND_MODE_ROUNDROBIN by default
> >     ip l set veth0 master bond1
> >     ip l set bond1 up
> >     ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
> >     ip l set veth3 master bond0
> >     ip l set bond0 up
> >     ip l set veth4 up
> >     ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx
>
> Care to explain why this setup would trigger anything?
>
> >
> > Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc187823a52ed505b2257
> > Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driv=
er")
> > Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> > ---
> > v2: Change the patch to fix bond_xdp_get_xmit_slave
> > ---
> >  drivers/net/bonding/bond_main.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index b560644ee1b1..91b9cbdcf274 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -5610,9 +5610,12 @@ bond_xdp_get_xmit_slave(struct net_device *bond_=
dev, struct xdp_buff *xdp)
> >               break;
> >
> >       default:
> > -             /* Should never happen. Mode guarded by bond_xdp_check() =
*/
> > -             netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmi=
t\n", BOND_MODE(bond));
> > -             WARN_ON_ONCE(1);
> > +             /* This might occur when a bond device increases bpf_mast=
er_redirect_enabled_key,
> > +              * and another bond device with XDP_TX and bond slave.
> > +              */
>
> The comment is confusing and needs to be reworded or dropped altogether.
>
> > +             if (net_ratelimit())
> > +                     netdev_err(bond_dev, "Unknown bonding mode %d for=
 xdp xmit\n",
> > +                                BOND_MODE(bond));
> >               return NULL;
> >       }
> >
>

Hi Nikolay,

I have taken the time to review your feedback and have sent [PATCH net
v3] for your consideration.
Please take a look when you have a moment.

Thank you so much!

Sincerely,

Jiwon Kim

