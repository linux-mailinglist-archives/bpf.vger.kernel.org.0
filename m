Return-Path: <bpf+bounces-69350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1DAB95077
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D17E54E2D0B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C531D389;
	Tue, 23 Sep 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqJXKFfe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931F313D49
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616813; cv=none; b=IwHf4wNj5pRcqEifDI4k1QzOQxfIjjWbX53oqus/aTbuyLm/6gmAh7CHLBxVWyl8DPNGXK56Clhqa6zr5Utx932GBcMT1gk0CyoabkNNkl4DoD/5h3hYFaLrIqTdcOgDK2Ex3dfJXvhsj6BL7+dR+FMebt1IPe7u78mzKQ6aiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616813; c=relaxed/simple;
	bh=AODaK73CD16jKk+03UbKIxye6WRkDa/4oiNXkx8hylY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXfRhI5/scP9V19SlMeGf6PrnqCQWaYAfrBgO+IOUMjfbOk6kHYQdMblT+t0hS+c+H/EGcCgcoov2QYzyJK7D6wm/HS2ie3MPXnEgYQwzN8KyActQY68Zbu0SJvPG9jCCvK9gBJZaEOsZY/SX46hFfhv5376eZJjU9JixpHmqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqJXKFfe; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4257b2781d8so7682595ab.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758616811; x=1759221611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=symkmqcspqr8o30esRANp+CrU+zjLpKuDVPbjsgdgTo=;
        b=mqJXKFfeOlmjGd4katIQhwLygvADaX2FFjghshA1zs2vlw4QG5XmQQnAe2skKuXtjJ
         IGfIDuz5AZ00WB8tyEycLyZ5pE6Z9rYCkoFDzLixOo1u5Q0dCvj5Hzcr0qJjjtDLVTen
         mLcNS56PnNBuGZ2Cw4p3jltxCk3/q4o7FNRhDvVTjhgTQgvdERAJeoq/2Z3aNgAEj2vR
         OUYmA+flvHDq9rCi7CPtY6EXJtkj05nEsh4uvc0+0QxxpJkUye5RFUfyXcEb7wWP1GdR
         2LbRLO4gZ4Xm79ORpl+UZyPihQgn0ltDLDriHX2cMXyD0YWt9Io13l9aIp896Y5jsjVB
         bkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616811; x=1759221611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=symkmqcspqr8o30esRANp+CrU+zjLpKuDVPbjsgdgTo=;
        b=I9nv3BZbChLDmJE4gNeHumMCCRJMvFKTw1conmk5PGlqgILvOhf6gfeX21xUrjMdQO
         QxVbGIUICr3BQeo9qTHLCaa2SSKcVvyYB8RzuqQPSxeZP/wuXceaqJ5+3QXWQgT4Dxfp
         7BjxwtsWNrqthprnvsOxYzO8ue77a8Yj05XPFo98jJFpcvldX9TyXypkuxMHMJxlI5vE
         XYVDFy57oA+mSPCHtw0YfmDJb8lgBjUDalUEJ0t+KtOQLsJl3tnuX1MlsONe46r8fiHr
         B5jVsmdL9mzpvRh3Pp0qDW/pYyyGN4OQfW/JsFXfgGNDvd2A2brXsaqKeA7pTJAcB1hi
         2ukg==
X-Forwarded-Encrypted: i=1; AJvYcCWl/Mtr4LCQh/h7WzEkSQlvNsaA6d9qurmupfQrV22ayVyoVfg7f58k7NJbOsJLSDMXbQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3L6oWd180fTJJgQAKr0K/r/7bOR74fvtekW2k0ccqJJWDki3
	y2O+2ulVpmC42mBKji6PenJNmDWuGOPa63tEGYw7/M+SqUkbhEpouazV6SveidqxdRE0eDpVU6c
	hGZMW8U6/vmWvTLll2L+TQb/waOnnXV4=
X-Gm-Gg: ASbGnct39OLiWoLkGNudzWYzkkIK8GVdGs/o7ZGyKwxMrScebWwQmkAlUt+DpvSgXNa
	4H6XSgjT1ZbiAwGA799/x+49kTsIkx3NPzQOzVGiKzsGIrEbK3nruQ1npNn9NCC2V1a/nohn1WP
	Qlb/XIpX5vsdo0ExOxtiacqiZm6hGtUBy2SIudOndkJQ8S28mIV8A+9M6ekjXKodZlgXXWtNb8o
	+JG6XI=
X-Google-Smtp-Source: AGHT+IE3jRaBDdbMyWwEkuj8pSWIpAJgLExbngsiP4kHQqEPNAVBKry0yg2HISVOBCHlDB/pgKQkleS3bwg0mZdCy7s=
X-Received: by 2002:a92:cd85:0:b0:425:73c6:9041 with SMTP id
 e9e14a558f8ab-42581ea5bacmr26341995ab.17.1758616810906; Tue, 23 Sep 2025
 01:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-2-maciej.fijalkowski@intel.com> <aNGGjMFT_bsByxcZ@mini-arch>
In-Reply-To: <aNGGjMFT_bsByxcZ@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Sep 2025 16:39:33 +0800
X-Gm-Features: AS18NWDqyMqOt5QmgHBQT5tt0U_VJkVVcTst6vX4-fZ9dkU0tjhEdt1jvkyAvgQ
Message-ID: <CAL+tcoCN2Lux970eMyXk_SjWsH9M38zsbaJ9o25tJn94DGLMwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:25=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 09/22, Maciej Fijalkowski wrote:
> > We are unnecessarily setting a bunch of skb fields per each processed
> > descriptor, which is redundant for fragmented frames.
> >
> > Let us set these respective members for first fragment only.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  net/xdp/xsk.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72e34bd2d925..72194f0a3fc0 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -758,6 +758,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >                               goto free_err;
> >
> >                       xsk_set_destructor_arg(skb, desc->addr);
> > +                     skb->dev =3D dev;
> > +                     skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> > +                     skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > +                     skb->destructor =3D xsk_destruct_skb;
> >               } else {
> >                       int nr_frags =3D skb_shinfo(skb)->nr_frags;
> >                       struct xsk_addr_node *xsk_addr;
> > @@ -826,14 +830,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> >
> >                       if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> >                               skb->skb_mstamp_ns =3D meta->request.laun=
ch_time;
> > +                     xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->=
xsk_meta);
> >               }
> >       }
> >
> > -     skb->dev =3D dev;
> > -     skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> > -     skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > -     skb->destructor =3D xsk_destruct_skb;
> > -     xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> >       xsk_inc_num_desc(skb);
>
> What about IFF_TX_SKB_NO_LINEAR case? I'm not super familiar with
> it, but I don't see priority/mark being set over there after this change.

Agreed. NO_LINEAR is used for VM. Aside from what you mentioned, with
this adjustment the initialization of skb is not finished here, which
leads to 1) failure in __dev_direct_xmit() due to unknown skb->dev, 2)
losing the chance to set its own destructor, etc. Those fields work
for either linear drivers (like virtio_net) or physical drivers.

Testing on my VM, I saw the following splat appearing on the screen as
I pointed out earlier:
[   91.389269] RIP: 0010:__dev_direct_xmit+0x32/0x1e0
[   91.389659] Code: e5 41 57 41 56 49 89 fe 41 55 41 54 53 48 83 ec
18 89 75 c4 48 8b 5f 10 65 48 8b 05 d0 f3 b7 01 48 89 45 d0 31 c0 c6
45 cf 00 <48> 8b 83 a8 00 00 00 a8 01 0f 84 90 01 00 00 48 8b 83 a8 00
00 00
[   91.391095] RSP: 0018:ffffc9000482bce8 EFLAGS: 00010246
[   91.391538] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00001
[   91.392107] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881204=
40700
[   91.392663] RBP: ffffc9000482bd28 R08: 000000000000003c R09: 00000000000=
00001
[   91.393230] R10: 0000000000001000 R11: 0000000000000000 R12: ffff8881204=
40700
[   91.393800] R13: ffff888101ed4e00 R14: ffff888120440700 R15: ffff888123b=
f2c00
[   91.394360] FS:  00007f2094609540(0000) GS:ffff88907bec2000(0000)
knlGS:0000000000000000
[   91.394992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.395447] CR2: 00000000000000a8 CR3: 0000000113d0d000 CR4: 00000000003=
506f0
[   91.396015] Call Trace:
[   91.396226]  <TASK>
[   91.396415]  __xsk_generic_xmit+0x315/0x3c0
[   91.396767]  __xsk_sendmsg.constprop.0.isra.0+0x16f/0x1a0
[   91.397208]  xsk_sendmsg+0x25/0x40
[   91.397496]  __sys_sendto+0x210/0x220
[   91.397811]  ? srso_return_thunk+0x5/0x5f
[   91.398343]  ? _sched_setscheduler.isra.0+0x7b/0xb0
[   91.398935]  __x64_sys_sendto+0x24/0x30
[   91.399433]  x64_sys_call+0x8d4/0x1fc0
[   91.399937]  do_syscall_64+0x5d/0x2e0
[   91.400437]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Thanks,
Jason

