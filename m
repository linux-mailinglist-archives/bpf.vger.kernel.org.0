Return-Path: <bpf+bounces-74229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA0C4E4D4
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 15:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8292F3AFD55
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7E3AA195;
	Tue, 11 Nov 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6r6ZUGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E06308F14
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869817; cv=none; b=Wh/i/kt3k1tnu678BRZNE15VfvwG5x2WXscfzYBYydKKA+DPvnPzgImIV/d3ZaWLFUS+WHPCk5k0vLtR9iMJ1FI052+C695vA/dv35ICTBHiVYQ3UwzsezyyfoqRgGsDqtF21ysKNg51fihj0Jpxtd7QFeoR3922RnBjMGNQe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869817; c=relaxed/simple;
	bh=K0Z2ySIFKx3PKPiK4P6YQ5+78mUXMIM5vSlFfWNQ4dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE68qLR7AYrpIBmDLJPeCt87qsqJZiTGpUXwEOevMZ3Y22I3SWhvbBgMvW+XsNnDnJToK4BgtNTj309tPJiePiGgXJKajjARjRFpHGS7qsm2vgvJkb1yPYKRoFEXvQDGeuLIK9t6S//eA5B1/UcSkIQum0VDR8R+C6Wy1Ki3SDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6r6ZUGx; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso25746435ab.0
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762869815; x=1763474615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VibbC+5mk65vMHz2LaNUPLHvms8z1KT5kdMPNVMdO3U=;
        b=C6r6ZUGxcJ27v9+XxBACOZqimYIrjQIEX410DJepy6DXGygOrztIpIGS9uK18e+Eo7
         teng0aFq9OzP9RNasJ3cY3SrE1J3yaOlewpCq8m/qy/IEjt0VtxH0xeEaIQu6CgI9hXr
         3F/DT5AcbhV/kLvliaGxHGk27fYB6yx55fBICJ3cx6qvOLMXCaJeibwx3+nwQ9EvNFbf
         VASKVtrC2o2YXpXrM7lnJjJF2NCdGwYpfWxCGZ1WHoFoiAdSygP/bYvJFT7miLSNB1I4
         SYMRU3sX0QnNAlDRUy0/UtbgUY76SReohOsIX1dI5Y5rE0/B0K6CXrgcseY2xGWnoUV5
         pdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869815; x=1763474615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VibbC+5mk65vMHz2LaNUPLHvms8z1KT5kdMPNVMdO3U=;
        b=Mbert34IZZBeeePuA/p7+oW8kdnREGE84Nh4wbUSLOBgRmEZoPXHcaxcZOwRKJ/bfF
         yJXcKtIIAB+lfMipZxP461iWytOAkepnKsH7zoOn1S6hLJ+eADD/yWtojuRzr2Lub1e3
         WMujviv/6ddEUeWV/KRSGQOc0lCNDp6rSnDmxVVZk1hytE5BzdaP7hTn+aAN/vo5HuB9
         9nE2lRSn561UutY2sau6sIPGgR6sxKJsSxwCwIIwaJt6ANrvDAxAOetCosMhue/snYDF
         sRP83Zw/Woqd2RsQvcj4dPe2Zq5eylnCCFxxBB/ttFdp9iXB7ixMvsHHuLAG2MFyATMu
         /L8A==
X-Forwarded-Encrypted: i=1; AJvYcCVoGmyHLrrlOBzIC0SycTtZbpbd6oiSmCsGAi4wtH+pXTgrPYRw21XnyVQUy3HaH9Zrzpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBawKSLzTZQ/HXM2o3AHHixMcs7koqBUCC1TBf0Do8od595Qdp
	aoKDmr07f32J/aiDnOa4TAHmtRAs4SZIF5oXrgUaH1IcASNgnIX7tGI4N5SNZYdJpbLxGSEKDPo
	OMntq7iH1Z3pDnGGU22elsrXuOFV/bFU=
X-Gm-Gg: ASbGncsPzD68HeqwK2pALubsnMiDenCdmEqALgO1SDjlenA883pgMfN24R5jXr6f7w/
	CF6KNpFQxEX9G1zFdrrUYT1PGhthnnXYz9gCXP/Cc6XrqvjJN40iDRAuRwLpuvnR/bxhAoI8suJ
	gGun3d6haDr/7j0AMCdJ5KrZOufAmO25Qx2NiQ8Yc2tXG0S3bdqsDm8gyfBnlVH6sLdqkG+eB9k
	OsImEx98P+mgK3hqGvTxnGlZGMA/iebnNX5DpfQrQSFAX51WF9N91x5uU0wKc6Y
X-Google-Smtp-Source: AGHT+IHuoHFU6FYkv3l9u96xec1YaIlfxleDt4yGphqk53vvSYJtLCUXD8JZMVEb4IB6UksKud8d04ljIXLqqbIMwE8=
X-Received: by 2002:a05:6e02:152c:b0:433:7b82:307f with SMTP id
 e9e14a558f8ab-4337b823291mr122812125ab.15.1762869814589; Tue, 11 Nov 2025
 06:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com> <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
 <aQjDjaQzv+Y4U6NL@boxer> <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
In-Reply-To: <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Nov 2025 22:02:58 +0800
X-Gm-Features: AWmQ_bmSMzXXqE569VVMBugamvS7-t3lSqZ_J028auD5hU_BTicFSrEV42vogww
Message-ID: <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	fmancera@suse.de, csmate@nop.hu, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Magnus,

On Tue, Nov 11, 2025 at 9:44=E2=80=AFPM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> wrot=
e:
> >
> > Hi Maciej,
> >
> > On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descripto=
r
> > > > > > production"), there is one issue[1] which causes the wrong publ=
ish
> > > > > > of descriptors in race condidtion. The above commit fixes the i=
ssue
> > > > > > but adds more memory operations in the xmit hot path and interr=
upt
> > > > > > context, which can cause side effect in performance.
> > > > > >
> > > > > > This patch tries to propose a new solution to fix the problem
> > > > > > without manipulating the allocation and deallocation of memory.=
 One
> > > > > > of the key points is that I borrowed the idea from the above co=
mmit
> > > > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > > > instead of in __xsk_generic_xmit().
> > > > > >
> > > > > > The core logics are as show below:
> > > > > > 1. allocate a new local queue. Only its cached_prod member is u=
sed.
> > > > > > 2. write the descriptors into the local queue in the xmit path.=
 And
> > > > > >    record the cached_prod as @start_addr that reflects the
> > > > > >    start position of this queue so that later the skb can easil=
y
> > > > > >    find where its addrs are written in the destruction phase.
> > > > > > 3. initialize the upper 24 bits of destructor_arg to store @sta=
rt_addr
> > > > > >    in xsk_skb_init_misc().
> > > > > > 4. Initialize the lower 8 bits of destructor_arg to store how m=
any
> > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > 5. write the desc addr(s) from the @start_addr from the cached =
cq
> > > > > >    one by one into the real cq in xsk_destruct_skb(). In turn s=
ync
> > > > > >    the global state of the cq.
> > > > > >
> > > > > > The format of destructor_arg is designed as:
> > > > > >  ------------------------ --------
> > > > > > |       start_addr       |  num   |
> > > > > >  ------------------------ --------
> > > > > > Using upper 24 bits is enough to keep the temporary descriptors=
. And
> > > > > > it's also enough to use lower 8 bits to show the number of desc=
riptors
> > > > > > that one skb owns.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kuban=
ski@partner.samsung.com/
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > > I posted the series as an RFC because I'd like to hear more opi=
nions on
> > > > > > the current rought approach so that the fix[2] can be avoided a=
nd
> > > > > > mitigate the impact of performance. This patch might have bugs =
because
> > > > > > I decided to spend more time on it after we come to an agreemen=
t. Please
> > > > > > review the overall concepts. Thanks!
> > > > > >
> > > > > > Maciej, could you share with me the way you tested jumbo frame?=
 I used
> > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utiliz=
es the
> > > > > > nic more than 90%, which means I cannot see the performance imp=
act.
> > > >
> > > > Could you provide the command you used? Thanks :)
> > > >
> > > > > >
> > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@=
suse.de/
> > > > > > ---
> > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++=
--------
> > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > >
> > > > > (...)
> > > > >
> > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_um=
em(struct xdp_sock *xs,
> > > > > >
> > > > > >       pool->fq =3D xs->fq_tmp;
> > > > > >       pool->cq =3D xs->cq_tmp;
> > > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > > >
> > > > > Jason,
> > > > >
> > > > > pool can be shared between multiple sockets that bind to same <ne=
tdev,qid>
> > > > > tuple. I believe here you're opening up for the very same issue E=
ryk
> > > > > initially reported.
> > > >
> > > > Actually it shouldn't happen because the cached_cq is more of the
> > > > temporary array that helps the skb store its start position. The
> > > > cached_prod of cached_cq can only be increased, not decreased. In t=
he
> > > > skb destruction phase, only those skbs that go to the end of life n=
eed
> > > > to sync its desc from cached_cq to cq. For some skbs that are relea=
sed
> > > > before the tx completion, we don't need to clear its record in
> > > > cached_cq at all and cq remains untouched.
> > > >
> > > > To put it in a simple way, the patch you proposed uses kmem_cached*
> > > > helpers to store the addr and write the addr into cq at the end of
> > > > lifecycle while the current patch uses a pre-allocated memory to
> > > > store. So it avoids the allocation and deallocation.
> > > >
> > > > Unless I'm missing something important. If so, I'm still convinced
> > > > this temporary queue can solve the problem since essentially it's a
> > > > better substitute for kmem cache to retain high performance.
> > >
> > > I need a bit more time on this, probably I'll respond tomorrow.
> >
> > I'd like to know if you have any further comments on this? And should
> > I continue to post as an official series?
>
> Hi Jason,
>
> Maciej has been out-of-office for a couple of days. He should
> hopefully be back later this week, so please wait for his comments.

Thanks for letting me know. I will wait :)

Thanks,
Jason

