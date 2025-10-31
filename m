Return-Path: <bpf+bounces-73215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B8FC273CE
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 01:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D523B9CE0
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E532E6AB;
	Sat,  1 Nov 2025 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HubYdLtm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C928A1F1
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955215; cv=none; b=tnUvjs1JZQThi6gwDXFEpkXgEbLDYi/3V+8+9ewuVFVxV3Oi3yM6M/1zig271OKoTCAvjq333gCay52ympaA5qQm3QvaafYfMq2SNEwH5yKi7EKCU1IcbmmF53cgfvRFUtJe3VFNwALu0WHAYEiGDmvl+TvkG8tJ5hGlu/3Mvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955215; c=relaxed/simple;
	bh=+35/7pDV5aHtbLm+WJ3oucpJf+JGDSplZl6Cxp0IjVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GONnEDxx35TQ8IslHoLKvem7y1OCNSzA3tQzBx4CrphB6ykgHpUCWRuyit26KpObjOIttOQvel82/W36+55wr0T4bZqp3o8gISua8GKSk3YZsIwVzG7fHmgvlJW+cXYtZ2Xqnm7B+7hIQg2hnAyF09CfZ1nLDa68BwMDB7nxaq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HubYdLtm; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4330a76ce05so15608615ab.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761955212; x=1762560012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MJ5WHi4v1NRsIzLB+zxCWG9/nSKi6YI0V6ws2xqZ6E=;
        b=HubYdLtm4AQn7kip/qrGPnYPdSPuRFIFBOhci/qIStoP9oJXqKKkXKJjFG9fSvw5V0
         Vx8HkiS4FivEeLJoMEtxPG6VXQcSb62oLD5MQgRoNI+O1onG0jBpgGNejxpKUMjSmMWL
         7MKaZ7wBoEFWAK6hNgERMztiY4iFRp6SbUNs1YVl6k/nM8YczMgWap3QVLjKkh/aNZ8o
         YLF0FBKej0KvkHAvncUwpgWAN4S7+l4oMIPyZhvCZh3l3LC5gKzoHlWf7HwY9s5fu3Sa
         jiCpX9laN/IpRuoSdRjtZ6cARUuZCb5x0/7Whq7ICRz1YSUqNnBqdeWKTSBM3vmOTqKn
         gpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761955212; x=1762560012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MJ5WHi4v1NRsIzLB+zxCWG9/nSKi6YI0V6ws2xqZ6E=;
        b=TxbBfBzzLwWpAGr6oorkETpvy6lmL0uXIsfuVga7PM6Cu7AqUYkjNy75GSBXDNokX2
         ++9stg760sXUh2miFBlG5ozbmDOxiRT2CrrUQAt729B0aMHutQA3I+wgm1QFnNT/yJrO
         OpS64eD9u4NAjrJ46cmdYoP+DJbVWArswFQTvlTlofobk01Czyb7ZsLjFBSTWTMdyFyv
         X02jNc8yyBw40dhdpqK/HBjbkgwJAEPB7WLSOfgOMHX30bY9XYmWxqmWmeJHe69T40Yf
         f/LAddHOCoUNHZUiGGhEN4Tk56ipM1Jc2X5enuVEko/2TdxMwdhdvOI/5q52NUc5BNf1
         AJwA==
X-Forwarded-Encrypted: i=1; AJvYcCWVEeajltSLjDbbWibW1og+WYKz/0TliOeGatzNP9Z1nTqKPvBc6VGEF5/ro10uL5vyZhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMV3o78YsFjXbrkMRy5y+04EiRNF3VTJnCLZDmIoQix2iW6PD
	8b11tW/me+ZU0TuOhqvUZrAClTKiotMNXxoRQoCyirShGpQnY19AOPHEh+khxt0niVxHoRbVk8I
	Ab3oliVAIFlw/bMoaO8XyC8UtbEeqsQ8=
X-Gm-Gg: ASbGncsz4G3DJgWCoj7fOl47w5onH4ZyuO3FC7moNmmxU7Vw2uqZLCRYCCAPQcXHUsf
	o6C6g7JyHq0OsnBPNjT2YQ0ktASskfVMRXbrTEp8fhW3s+gPkpoPu7dlYJi/l0SOYMcZjt0KOlq
	4GVZ5pqBw49VPnD6sAk8iD01apD8reFRCbJbak7W6HNUZowDuFGuyI0kTaMMqb+5y2od/mW5zIh
	4for6IY5q0mQFZbJfBje558rCbNhJzFCJa9qGUmYRZbUgjhi3fI40lDPydtjr1yMV5UZNlty7E=
X-Google-Smtp-Source: AGHT+IEVdQ5RhyNFNAvyojjJ1ti+zJbNcVc4GOdb7no78U2rfmD6BQ3bRpKhH9UT07fZsJo9s2ImChJIKUeTJGRlZUQ=
X-Received: by 2002:a05:6e02:318f:b0:430:b999:49e7 with SMTP id
 e9e14a558f8ab-4330d1df5femr94395585ab.27.1761955212448; Fri, 31 Oct 2025
 17:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com> <aQTBajODN3Nnskta@boxer>
In-Reply-To: <aQTBajODN3Nnskta@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 1 Nov 2025 07:59:36 +0800
X-Gm-Features: AWmQ_bm-C1tVR72l0QC9N9w_Vlw7AltvmNhED9xPVwSrZnJ7IiRp8OGbkDKrcjw
Message-ID: <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, fmancera@suse.de, csmate@nop.hu, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > production"), there is one issue[1] which causes the wrong publish
> > of descriptors in race condidtion. The above commit fixes the issue
> > but adds more memory operations in the xmit hot path and interrupt
> > context, which can cause side effect in performance.
> >
> > This patch tries to propose a new solution to fix the problem
> > without manipulating the allocation and deallocation of memory. One
> > of the key points is that I borrowed the idea from the above commit
> > that postpones updating the ring->descs in xsk_destruct_skb()
> > instead of in __xsk_generic_xmit().
> >
> > The core logics are as show below:
> > 1. allocate a new local queue. Only its cached_prod member is used.
> > 2. write the descriptors into the local queue in the xmit path. And
> >    record the cached_prod as @start_addr that reflects the
> >    start position of this queue so that later the skb can easily
> >    find where its addrs are written in the destruction phase.
> > 3. initialize the upper 24 bits of destructor_arg to store @start_addr
> >    in xsk_skb_init_misc().
> > 4. Initialize the lower 8 bits of destructor_arg to store how many
> >    descriptors the skb owns in xsk_update_num_desc().
> > 5. write the desc addr(s) from the @start_addr from the cached cq
> >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> >    the global state of the cq.
> >
> > The format of destructor_arg is designed as:
> >  ------------------------ --------
> > |       start_addr       |  num   |
> >  ------------------------ --------
> > Using upper 24 bits is enough to keep the temporary descriptors. And
> > it's also enough to use lower 8 bits to show the number of descriptors
> > that one skb owns.
> >
> > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@part=
ner.samsung.com/
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > I posted the series as an RFC because I'd like to hear more opinions on
> > the current rought approach so that the fix[2] can be avoided and
> > mitigate the impact of performance. This patch might have bugs because
> > I decided to spend more time on it after we come to an agreement. Pleas=
e
> > review the overall concepts. Thanks!
> >
> > Maciej, could you share with me the way you tested jumbo frame? I used
> > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> > nic more than 90%, which means I cannot see the performance impact.

Could you provide the command you used? Thanks :)

> >
> > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> > ---
> >  include/net/xdp_sock.h      |   1 +
> >  include/net/xsk_buff_pool.h |   1 +
> >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
> >  net/xdp/xsk_buff_pool.c     |   1 +
> >  4 files changed, 84 insertions(+), 23 deletions(-)
>
> (...)
>
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index aa9788f20d0d..6e170107dec7 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struc=
t xdp_sock *xs,
> >
> >       pool->fq =3D xs->fq_tmp;
> >       pool->cq =3D xs->cq_tmp;
> > +     pool->cached_cq =3D xs->cached_cq;
>
> Jason,
>
> pool can be shared between multiple sockets that bind to same <netdev,qid=
>
> tuple. I believe here you're opening up for the very same issue Eryk
> initially reported.

Actually it shouldn't happen because the cached_cq is more of the
temporary array that helps the skb store its start position. The
cached_prod of cached_cq can only be increased, not decreased. In the
skb destruction phase, only those skbs that go to the end of life need
to sync its desc from cached_cq to cq. For some skbs that are released
before the tx completion, we don't need to clear its record in
cached_cq at all and cq remains untouched.

To put it in a simple way, the patch you proposed uses kmem_cached*
helpers to store the addr and write the addr into cq at the end of
lifecycle while the current patch uses a pre-allocated memory to
store. So it avoids the allocation and deallocation.

Unless I'm missing something important. If so, I'm still convinced
this temporary queue can solve the problem since essentially it's a
better substitute for kmem cache to retain high performance.

Thanks,
Jason

