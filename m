Return-Path: <bpf+bounces-67059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848F0B3CA37
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 12:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE111B2095C
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A427815D;
	Sat, 30 Aug 2025 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ4gneww"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE39218580;
	Sat, 30 Aug 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549991; cv=none; b=ObN47Xk5MU8AaE29Un7aFYlt7c4rk+UC1hatsbfXA3atgCn/xmdQo2rm8vwDupJzjhU5LjybnNzI1TQIwI1M9liH6PyULW9w6vCECaRiuOXymsFRuV8oBX5A32RExychupFcLa69C83Y9bt8NTVVxyUjR8bKn9wIPbSXFgeosjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549991; c=relaxed/simple;
	bh=9+DAISydCmSU/nfnrQmoF3sog1KqXDCTPbYq7Di/xKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfDxENyFrG0T3/MzINuQ77O3vM0m7LPfGlwk0zRTFMWIohBAWkv+AKD9zzSXnsFKfoZM782gXFt1B6oRrJCihyH3Jy6S66Lhjkt4mQupd1HvWtRbxRiAR5q7wWmtTMWiuwsCyNj6AfBTZfuGSbFDtmYegIv019UBC7Cj56sDvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ4gneww; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ea8b3a6454so16305545ab.1;
        Sat, 30 Aug 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756549989; x=1757154789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AMw6pEARHVxLMZpBFfs/K2/1kAMgVkOBI8bUDSNkEE=;
        b=CQ4gnewwD7tUKti0ZpyLBXMlaAgJKE616PK6NUIZ6JQ3nas2pjBzYMJxQpb10ns4jh
         +oP0d7bG5swi9tBF8Ie8kaIfc1kcLXjXfo7BwOAcpcEOG94p5o3m3NArctxGlyg0LgF+
         5CrJkqsbrXCRh+72WAGY7lDEFe+j/FgDfNv6a6OS1U5DXiBCSQKqp5vLCorhjDwOr9Dq
         zTnykGJExbOaeaVGhjg+rmxrUJDHxIDOG/26r6LUdWuk+dIZWsInnWL5llL85lBxwgxP
         nc59UTtRd6jjO43H+voSvLphwIkc5Ba15eJq3hboF7t5j9bD2p/jg1r0IeB0vAYknzSR
         3rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549989; x=1757154789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AMw6pEARHVxLMZpBFfs/K2/1kAMgVkOBI8bUDSNkEE=;
        b=efk4+kgiXnJdLA8WLpLcXzqvsXGqDPfbyaNdz+wyzNiRN0F8UDUNewHfnAmecwC343
         ULExg08nrTusJrmv2z6iGFAKg4NsKu3wiuSM1ohQJaGQPVsMS4STsbfkd4xlzL2Smkw2
         8QDTBKXby5c0FNCRNthWypvIIVFQRFYWBL7Qi9oODYmM78MUld3qVw87jk8sfwiygeNS
         heo4nUx2Snvl0U3r+zLfnoWjFzlPSz6XnoItneu6q1q2h5t4wg68CBrxms7huOIkv7Gd
         Xkmywcf1dcKwWbasQtZ/MWTNGOjzTgs+MTtASHcu0PVb9zM+YwjwPMXuC3MrmNYWX9Xj
         W0WA==
X-Forwarded-Encrypted: i=1; AJvYcCW/KuM+MPkgI+QTZ3k1DCQpCETZniiN0/3oJxFTcKIxtbIgVOMfHfTwog9mf+zWyYOEhinGfziW@vger.kernel.org, AJvYcCWqLYVpZcoxvHep388JOB6aeu5USK1TpLABL2N1X9ypdU7xTDmiwGncMZTozvq38oc/7Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAgWkWVaL3ZhbMIZeAMkGHK4e1Inm48DZYHwM/Iq6ta8ZJ3sW
	jKyhJfmB+7GF+SfYDXuOq0cMAuMWEmJE33PEZaCMV2RaZbOhtkrl3eHsHegTwv7KTa34MRvfA94
	T3AJns7hrbHQs6SbxfFZMZLVKz/EtqT8=
X-Gm-Gg: ASbGncuzJlKBoe+OKJ3mdFRBHG998DjPVx9+9zYLe7BBoxAyJPu5Y8VRv30zrpI0R3k
	kg6OZWfWliVk+rtQd6uIKyPx0q/Bh3OCd1EHROKhjkRaqn81lstg0YfZqJ8zniPL2OYCu6jAmrB
	Q72WrM3Tb1yb1ApGqHQEtmz04rza0Rp2wRcAWcK9hBdQEQb4t4074TbolpGw4VDVo/pkW9BfiGD
	s8Q7A==
X-Google-Smtp-Source: AGHT+IFWsAxGn/NYIrw/M+ETRxOSzmi58TDOAVBYhpYICXDz3ds/TMLrHt1q2TBuexoFdV7JbNQrfc+tdDa308nAxyo=
X-Received: by 2002:a05:6e02:1aa4:b0:3e8:b0f1:6b02 with SMTP id
 e9e14a558f8ab-3f3ffda307amr34366655ab.2.1756549988846; Sat, 30 Aug 2025
 03:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
 <aK1sz42QLX42u6Eo@stanley.mountain> <089fa206-1511-4fd9-bc12-f73ab8a08bb6@iogearbox.net>
 <aLHR4qMphDdG43l2@boxer>
In-Reply-To: <aLHR4qMphDdG43l2@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 30 Aug 2025 18:32:32 +0800
X-Gm-Features: Ac12FXx8tr7aiwoApMgfby28_0kDY9_tPzQFu6hVUOReUb3jhOdjyGQhFx1NPlA
Message-ID: <CAL+tcoD1t4a5wEUYKJbhFHC2Cf8smY983JzWgLhjpcHd7-fwGg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Dan Carpenter <dan.carpenter@linaro.org>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, netdev@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, aleksander.lobakin@intel.com, 
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 12:15=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Aug 26, 2025 at 02:23:34PM +0200, Daniel Borkmann wrote:
> > On 8/26/25 10:14 AM, Dan Carpenter wrote:
> > > On Wed, Aug 20, 2025 at 05:44:16PM +0200, Maciej Fijalkowski wrote:
> > > >                           return ERR_PTR(err);
> > > >                   skb_reserve(skb, hr);
> > > > +
> > > > +         addrs =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KER=
NEL);
> > > > +         if (!addrs) {
> > > > +                 kfree(skb);
> > >
> > > This needs to be kfree_skb(skb);
> >
> > Oh well, good catch! Maciej, given this commit did not land yet in Linu=
s' tree,
> > I can toss the commit from bpf tree assuming you send a v7?
> >
> > Also, looking at xsk_build_skb(), do we similarly need to free that all=
ocated
> > skb when we hit the ERR_PTR(-EOVERFLOW) ? Mentioned function has the fo=
llowing
> > in the free_err path:
> >
> >         if (first_frag && skb)
> >                 kfree_skb(skb);
> >
> > Pls double check.
>
> for EOVERFLOW we drop skb and then we continue with consuming next
> descriptors from XSK Tx queue. Every other errno causes this loop
> processing to stop and give the control back to application side. skb
> pointer is kept within xdp_sock and on next syscall we will retry with
> sending it.
>
>         if (err =3D=3D -EOVERFLOW) {
>                 xsk_drop_skb(xs->skb);
>                 -> xsk_consume_skb(skb);
>                    -> consume_skb(skb);
>
> since it's a drop, i wonder if we should have a kfree_skb() with proper
> drop reason for XSK subsystem, but that's for a different discussion.

I agree on this point. A few days ago, I scanned the code over and
over again and stumbled on this. Sure, we can add reasons into it.

Thanks,
Jason

