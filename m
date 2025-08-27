Return-Path: <bpf+bounces-66612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1249B37618
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EE07C3CCD
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B91990A7;
	Wed, 27 Aug 2025 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+N4E77d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5701219EB;
	Wed, 27 Aug 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254365; cv=none; b=DW6A2JCva4zkuWRrezl7a2Y7wK+BBLAM5zsC8whEtmN7Bd51Gzzi3I4ZfuPw/m50PfRi39M/UEJvxC+FcAooztrJHojiAHtWZDSbjODv6p346WasQwb9jwv1yYMyqUhJ5+MJodTtfSgKO19DJkG2Sk1YP1E0D7jymLRYAv5KDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254365; c=relaxed/simple;
	bh=ge99JbgU2avZuAf1tXCKgItMiTU80Su/hLqX6ZcrCrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U91KbwCBic1Rt1xlBIaSFQyqc5R/kVBNPZ2MmaixSRNPWoDLhg/NErLbxmNB7UEOauIWUf4W2ezasxqlOS9HOEMTGJIltChQtlb2sKtZxs5EfX3njJgtXQpcH0/yiMyE2Qknl7sx3tfoIP/7z9XoPqLFmtcniIpqXdFNHMwiWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+N4E77d; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88432daa973so157906039f.1;
        Tue, 26 Aug 2025 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756254363; x=1756859163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYJvgy9hwO9zbpyzuffrs6LlwBtoBvC0CLW5PgCSQoo=;
        b=R+N4E77dDyqVc/11Oo5MWeNB6qXZK1wjhlqyyvPvMFRR9Stsg9LT02jsm71C8eSdvd
         oyxEX6yOUezv+QIJ0MIHUzbhG4mnxbOwoDJWnVEsVi/fbxPMHPMRZPLCEFMzPWYIq6e8
         tN4r5iwbn43zHQ08Vc2ngX4UrRoJzwDOYTz/0hNIqtnVBDttvFZVQhntXDiy2pPEphnY
         CEg+g2XCqQkGKFdCzU5LOPfmsKbyl3HrIgEMX2ZjoMbs6q1T5dT5SQqAfx1LFOm124/8
         20kYs7ztZzyOONjdFho/OeDMqlePefl76cxXYRwJTeeRebVE2Cg6dZGYuMIZdOVSuePJ
         cItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756254363; x=1756859163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYJvgy9hwO9zbpyzuffrs6LlwBtoBvC0CLW5PgCSQoo=;
        b=YC33Fcga8tzLFDsa2DI5j2Qi6mHVlbNjR+UuIbAGgbO8RyNE6YQu1X+NgKtVpQpbwy
         VBAOiZcZ2iGXxhJq6vK/9DlNyjunUoo7/sUpHaxu0qDsg3sUD3QuK1IE7tLEsHJQ7h64
         Ol0BcAZgX2FpV1X5bDK2Yvh+dGKX+7U9cN7Q2d6nPRLGcdSSnUOTN8VG77GiU7cAbCEA
         0Tc/jDLcoPYUR7ApgMsx4kuvwYoH0mcJHW+h/A0/hA/OsukzZkEuAV52Msvh8gGNJSH9
         /39sIIUJwxu2vmGTJfnXjqBW+BUL8Ainfw1GAHgsr8/2DFj4moYui/A71iAsJCkRfMO4
         ymDg==
X-Forwarded-Encrypted: i=1; AJvYcCV67kyPMOqx6ldWP10reVtlndaT7d7yQ7jnD/GEP+1EbhWaKy5etCy/AVGoSCbXsOwOSX67HvTb@vger.kernel.org, AJvYcCX6QhFs4rLpRQ5dBf6PbU0pn1twW6oqitzCRe5zctGVJSr/1gc/WpmEoQSjLov6E/Sr+VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywCr6Y8gUw0nCb0UXXVl0aK61/cPbgK8uJu+SBaaG6g93xApMq
	YsXsobE6mSu/qKPbrpQmR5jnSSCZZI+mhixi03gWNEZdawNj+ujaRKWYgXogYkDZug+xiXLsfIV
	ocGTBVHZyx2dvZWMJ7vj2jLONl6ESxP4=
X-Gm-Gg: ASbGncun/SEHg7zxNqDFEwDBCqamPsolFtnyj6GHKsP0WkCLlOesecW7WQ7sY0RlQDV
	kMQRM5a6yaRuTJk2c2rJihHgrCK64LtynJ6NWPCeUG34kdWU43vkJMN1D7ihtNcB5HqcGZ/eifd
	hcvSY2RZW3f+Rk3Wk7EAWFYBZ/snAAwNdmuLfnQ7a4629TI8NU6M+uZjHMIqhKNsOVOC5IASAy5
	7WcLAsZC9fTCWOqBw==
X-Google-Smtp-Source: AGHT+IEvUAhQn7BUvIVKHy74w+2r+ev6IDRc/fi10HGJuygQHfsVpy8NIqjhk4BVPHygW7a+iJfsuOkCo95nhNFebcE=
X-Received: by 2002:a05:6e02:164c:b0:3eb:e9c6:8ed8 with SMTP id
 e9e14a558f8ab-3ebe9c69061mr135968705ab.29.1756254362554; Tue, 26 Aug 2025
 17:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
 <CAL+tcoD3Kj6h=RvkEJ_9vmJPWKGVcaLj4ws=JqRbE0TiyjDDWg@mail.gmail.com>
 <CAJ8uoz0v4sdj8YwadpCKpDSpY1JrJnO_kkEfHHyv+qAFMiKOOQ@mail.gmail.com>
 <aK4FEXMHOd2MLqmC@boxer> <aK4HP0LxJvfEhugu@boxer>
In-Reply-To: <aK4HP0LxJvfEhugu@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 27 Aug 2025 08:25:26 +0800
X-Gm-Features: Ac12FXz61K6dWxGksFWotQV7IkOdfkOxmuMIUspvD5irTmFOB4vJRWX5TzXbumE
Message-ID: <CAL+tcoCgahL0AmH7=nBF3gGfaxua+-Uc-mZb_zCKPKqGteSZHA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, aleksander.lobakin@intel.com, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:13=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Aug 26, 2025 at 09:03:45PM +0200, Maciej Fijalkowski wrote:
> > On Tue, Aug 26, 2025 at 08:23:04PM +0200, Magnus Karlsson wrote:
> > > On Tue, 26 Aug 2025 at 18:07, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
> > > >
> > > > On Wed, Aug 20, 2025 at 11:49=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > Eryk reported an issue that I have put under Closes: tag, related=
 to
> > > > > umem addrs being prematurely produced onto pool's completion queu=
e.
> > > > > Let us make the skb's destructor responsible for producing all ad=
drs
> > > > > that given skb used.
> > > > >
> > > > > Introduce struct xsk_addrs which will carry descriptor count with=
 array
> > > > > of addresses taken from processed descriptors that will be carrie=
d via
> > > > > skb_shared_info::destructor_arg. This way we can refer to it with=
in
> > > > > xsk_destruct_skb(). In order to mitigate the overhead that will b=
e
> > > > > coming from memory allocations, let us introduce kmem_cache of
> > > > > xsk_addrs. There will be a single kmem_cache for xsk generic xmit=
 on the
> > > > > system.
> > > > >
> > > > > Commit from fixes tag introduced the buggy behavior, it was not b=
roken
> > > > > from day 1, but rather when xsk multi-buffer got introduced.
> > > > >
> > > > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for sup=
porting multi-buffer in Tx path")
> > > > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.k=
ubanski@partner.samsung.com/
> > > > > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > ---
> > > > >
> > > > > v1:
> > > > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijal=
kowski@intel.com/
> > > > > v2:
> > > > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijal=
kowski@intel.com/
> > > > > v3:
> > > > > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijal=
kowski@intel.com/
> > > > > v4:
> > > > > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijal=
kowski@intel.com/
> > > > > v5:
> > > > > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> > > > >
> > > > > v1->v2:
> > > > > * store addrs in array carried via destructor_arg instead having =
them
> > > > >   stored in skb headroom; cleaner and less hacky approach;
> > > > > v2->v3:
> > > > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > > > * set err when xsk_addrs allocation fails (Dan)
> > > > > * change xsk_addrs layout to avoid holes
> > > > > * free xsk_addrs on error path
> > > > > * rebase
> > > > > v3->v4:
> > > > > * have kmem_cache as percpu vars
> > > > > * don't drop unnecessary braces (unrelated) (Stan)
> > > > > * use idx + i in xskq_prod_write_addr (Stan)
> > > > > * alloc kmem_cache on bind (Stan)
> > > > > * keep num_descs as first member in xsk_addrs (Magnus)
> > > > > * add ack from Magnus
> > > > > v4->v5:
> > > > > * have a single kmem_cache per xsk subsystem (Stan)
> > > > > v5->v6:
> > > > > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation =
fails
> > > > >   (Stan)
> > > > > * unregister netdev notifier if creating kmem_cache fails (Stan)
> > > > >
> > > > > ---
> > > > >  net/xdp/xsk.c       | 95 +++++++++++++++++++++++++++++++++++++--=
------
> > > > >  net/xdp/xsk_queue.h | 12 ++++++
> > > > >  2 files changed, 91 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index 9c3acecc14b1..989d5ffb4273 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -36,6 +36,13 @@
> > > > >  #define TX_BATCH_SIZE 32
> > > > >  #define MAX_PER_SOCKET_BUDGET 32
> > > > >
> > > > > +struct xsk_addrs {
> > > > > +       u32 num_descs;
> > > > > +       u64 addrs[MAX_SKB_FRAGS + 1];
> > > > > +};
> > > > > +
> > > > > +static struct kmem_cache *xsk_tx_generic_cache;
> > > >
> > > > IMHO, adding a few heavy operations of allocating and freeing from
> > > > cache in the hot path is not a good choice. What I've been trying s=
o
> > > > hard lately is to minimize the times of manipulating memory as much=
 as
> > > > possible :( Memory hotspot can be easily captured by perf.
> > > >
> > > > We might provide an new option in setsockopt() to let users
> > > > specifically support this use case since it does harm to normal cas=
es?
> > >
> > > Agree with you that we should not harm the normal case here. Instead
> > > of introducing a setsockopt, how about we detect the case when this
> > > can happen in the code? If I remember correctly, it can only occur in
> > > the XDP_SHARED_UMEM mode were the xsk pool is shared between
> > > processes. If this can be tested (by introducing a new bit in the xsk
> > > pool if that is necessary), we could have two potential skb
> > > destructors: the old one for the "normal" case and the new one with
> > > the list of addresses to complete (using the expensive allocations an=
d
> > > deallocations) when it is strictly required i.e., when the xsk pool i=
s
> > > shared. Maciej, you are more in to the details of this, so what do yo=
u
> > > think? Would something like this be a potential path forward?
> >
> > Meh, i was focused on 9k mtu impact, it was about 5% on my machine but =
now
> > i checked small packets and indeed i see 12-14% perf regression.
> >
> > I'll look into this so Daniel, for now let's drop this unfortunate
> > patch...
>
> One more thing - Jason, you still need to focus your work on this approac=
h
> where we produce cq entries from destructor. I just need to come up with
> smarter way of producing descs to be consumed by destructor :<

No problem. Before getting to that batch feature, I'm dealing with
AF_PACKET implementation first which probably takes much time than
needed.

Thanks,
Jason

