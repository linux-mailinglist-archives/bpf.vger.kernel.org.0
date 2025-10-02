Return-Path: <bpf+bounces-70216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E7BB49A6
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 18:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CDD3C10B6
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFAB265CBE;
	Thu,  2 Oct 2025 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zjAZRLEt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F40239E9A
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424245; cv=none; b=ox3M8qR5nYqxN/IeAECW9FOT5C/lQzAByobaCh1ZbOYdI9uo/Ocnrhx6GyfhO1MeLddS+YDOjEXav9t0UtxakB2XRuqlSH7Kh0B7Y0QQVjyNhf5Ch3RJEJgszF3X/ztO7eAJom7lEsyl5a+9QWjQgiEOcI7eIXcrccaKltbM7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424245; c=relaxed/simple;
	bh=jvWWU7DsWnVlMM93MPOLc8HvjqVRGQld8Uw+STzCBxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3F4qLeEMa8a66ku7gnqZUR6HqYfG/XGOiJzblY93/GxZjwUMLJC83+LQ9SND3OcMuknoMuUgvc3LVyYJZ330T5i5zsA7KD1yrCZSClcrYsUV+0qHPOqmKpXIIV+3MbxPp50YUJKYfo+FHTegoFD1szHC06soxgBNnfL6EpQ2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zjAZRLEt; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4de60f19a57so23211cf.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759424242; x=1760029042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCGLM/GqGQA83nrxpNHfKddD9nhib5D0cyLH7C8UUk0=;
        b=zjAZRLEt09tZEIzsxAJb27wM2GXdGADV5HjgVzs439YM/NwNHxqmPrb941upzw6w1T
         lO9Ai4hGIXvFTDt9k+GXbZFZ1eZfPUXYYISYYoenYscj/GoifPnovlp/PC6bPNr6ofpd
         9VkJgUbAKh5RTr6G/8pfO0PbH+49a+n8vC7x4aWfDBFKBIl/goGe7DD3IVA4Gz2hj5iB
         VyQNSEiDkfDWL7YH0DUmPuFm8RIgdCVTDUEQmELua60EfZBYmkNFtEBtthA27RfJjDod
         CQFxrNobQ3qS7c1DuUr5nfqO6WqXTAFHFbn2XtUSZVG0wzZAaQq0GLNw6sKQu4wDCe0w
         sOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424242; x=1760029042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCGLM/GqGQA83nrxpNHfKddD9nhib5D0cyLH7C8UUk0=;
        b=FIBYpgtVO1DatKBfcaf73G7q+FTkCEe7fgDaMUQajmXz5JqdKBGFBWVAuZ+3zlKCW+
         TakSMcZZQbOq0X5k5EP7ceWBMtE2BNSO8CpnW2TnP74cDxu/mTWFbC3rm7yo+buXCKqa
         f3uj0Q70GOJ4ak5BBfa+zrHDKnZ63U6UzKIC00QuNJDTovWkBQWa22Dzho6muEL76zqC
         5x7Gt6gSgN+CIvsNAGIx558bl1CWaHbcdDOcg6RrwBJbRPVjD6n+VmlRuSpUhfDrZIqg
         7hbvUH8u74Q6cHuY3R/cOuLHyb9TmpAQxw2PVnjsBg5vawOAz775c3eBpBxqSLQe14/P
         k2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVmYTyztgdGoe+i4usUDyGPVgwQgNVivVikvmJgr+k6JvUhvLydIH/H/n5PaQeOmVtY2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNESjPZvnd8lvJUoixQeeCn/e4UIFs+ED2vzW8/0KE+O2xQzgn
	Enc9bKXo/JXUzzxebWi2AiYdrapy00e1u1nGs9UAj0B/lloJbqO3qcC7jyRFAseP6XsHCRfjdyA
	xXUrAks6EH52qycdDSNR9l7Ytm2jctu6HZFWHPukX
X-Gm-Gg: ASbGncv+k2MfKCuDqpRCKfovRZrCSJK2rBkdShz/lvQCYG4Zp20g5xXurg8tOb/xyM9
	tRb5hjKgU282JsXpwEER+H9QLLOGODpUGuU+KFgpbm18eBuUkzDDgAJ73XAJovKJJEy3Mo94LQh
	1B6VyGK5TvSYq0SifzLNveCNvD8XayVZhG7wjIS1rZtfcu/WKD4p0XlN8GMN2HfN7Efp+IMPnuj
	vALXHbFrXYxY+3qPtHCxdH6Iu2HL3j2NpKQEm/q57dvQl9p
X-Google-Smtp-Source: AGHT+IGjSO8rMfuq7KqxiCPuz/RJu/+p2b9lnog0dTmqYYsEOQWVKbG/Nu2mGxt55MxB++Fj2wSpOxT30Ug2gJcEr7U=
X-Received: by 2002:a05:622a:15cd:b0:4e4:ec1f:6a79 with SMTP id
 d75a77b69052e-4e56c773eccmr5849651cf.3.1759424242000; Thu, 02 Oct 2025
 09:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001074704.2817028-1-tavip@google.com> <aN091c4VZRtZwZDZ@boxer>
 <20251001082737.23f5037f@kernel.org> <aN17pc5/ZBQednNi@boxer>
 <CAGWr4cSMme5B-bMc+maKccoYxgVeVKaXk7Eh=SOM7jX3Du5Rkw@mail.gmail.com> <aN51q5TeJV5R5x04@boxer>
In-Reply-To: <aN51q5TeJV5R5x04@boxer>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 2 Oct 2025 09:57:10 -0700
X-Gm-Features: AS18NWC16cinXwsgu8fwX0n2Ewjv30s8MT_D81INJP7YSjIl2xdKZMz7Ce2P6_M
Message-ID: <CAGWr4cTKgcrWKcNchdo6OKbKFTNaNc+jfPoKf+_qb+9W-nJT3g@mail.gmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com, 
	aleksander.lobakin@intel.com, toke@redhat.com, lorenzo@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 5:54=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Oct 01, 2025 at 06:15:25PM -0700, Octavian Purdila wrote:
> > On Wed, Oct 1, 2025 at 12:06=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Oct 01, 2025 at 08:27:37AM -0700, Jakub Kicinski wrote:
> > > > On Wed, 1 Oct 2025 16:42:29 +0200 Maciej Fijalkowski wrote:
> > > > > Here we piggy back on sk_buff::pp_recycle setting as it implies u=
nderlying
> > > > > memory is backed by page pool.
> > > >
> > > > skb->pp_recycle means that if the pages of the skb came from a pp t=
hen
> > > > the skb is holding a pp reference not a full page reference on thos=
e
> > > > pages. It does not mean that all pages of an skb came from pp.
> > > > In practice it may be equivalent, especially here. But I'm slightly
> > > > worried that checking pp_recycle will lead to confusion..
> > >
> > > Mmm ok - maybe that's safer and straight-forward?
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 93a25d87b86b..7707a95ca8ed 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -5269,6 +5269,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *sk=
b, struct xdp_buff *xdp,
> > >         orig_bcast =3D is_multicast_ether_addr_64bits(eth->h_dest);
> > >         orig_eth_type =3D eth->h_proto;
> > >
> > > +       xdp->rxq->mem.type =3D page_pool_page_is_pp(virt_to_page(xdp-=
>data)) ?
> > > +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> > > +
> > >         act =3D bpf_prog_run_xdp(xdp_prog, xdp);
> > >
> > >         /* check if bpf_xdp_adjust_head was used */
> > >
> > > As you know we do not have that kind of granularity within xdp_buff w=
here
> > > we could distinguish the memory provider per linear part and each fra=
g...
> >
> > LGTM, based on my limited understanding. I can also confirm the syz
> > repro no longer crashes with this patch.
>
> Would you be OK with me submitting this fix and giving you the proper
> credit?

Yes, of course, thank you!

