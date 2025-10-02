Return-Path: <bpf+bounces-70179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A9BB23D1
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 03:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2ADB7B3FCE
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FC1419A9;
	Thu,  2 Oct 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TE+R7hUe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962878F20
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367741; cv=none; b=H5j89CqUUzvbNiX/V1oDvqnG0LzP5ZBSX7tAP4A6BPXSG+BwnRBhs66b2yu3dpCYLgbmuc2An2lqyI1k8T1+Q8p1RPrQzElVGt1B0h/joyofhfygMkfxEEqKA0n8GiUzU7M6LARzPV5V7p/WUd4aCb+hRvtCH9kLLLCN4bIxYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367741; c=relaxed/simple;
	bh=JKhQbZsUBTEPWhMd10mVzzVtvORQk/05UaHxitUieA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkf8H4f8ReahsLDN1f3NzS/woqV8JALFVGfYNo66MlgpYOpzK+vpd2t+IShEF5A/O/ByZb/BwsmC/WNmefrRXXO+fEH44DOhBiVVukPhUFnJBeb7iNxoIyV/l5/fBf3adqPo+FDyo7j3v9lilJKxlZeMOSgNGmAXZ8gUJOFIUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TE+R7hUe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4de66881569so234011cf.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 18:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759367737; x=1759972537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMgNT/1x8z1utdDYgKHKTeeRqtfkL3MvkmmESru+sa0=;
        b=TE+R7hUet8fFflcDMRpBVPFwZVDGKhv5zhpGJ1ZRwQf5vf+w71viIEUg8fDVyxtXRF
         XSJCgYv/iGahkhvypS8hLY15Vy0D4jlXl2u2A2pDsDyzIclepcHJrmDAUoNLq1AgZYrJ
         94ju/kJLZa/M/WDKHwXqTQTXENJmCGYe8/vMhgJ7fr0kg5VwC8tQYQSEghBjHrNVeq1U
         GAyMWvaVncBuHXL+1qnVZmArahhGyi3Zc4w37N0NYKxNz8+3Mo4ez50Ra4V3YxNn1Lz9
         W6SkX6LnDlpWRE0S6l+7ofhovhfOoWybHw2Jojp098BPxss+aree+uY18yWH/41fdF+i
         pF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759367737; x=1759972537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMgNT/1x8z1utdDYgKHKTeeRqtfkL3MvkmmESru+sa0=;
        b=N+MCz+tauOizDY1tWs2Eqm4M5VVOyFlJxwvdCVafIMv86wHouXNLWi9TsqVP1Lf/VZ
         OZJ7GUAiC0upaaVEJK4rUgR/2uAy0XnTXEniOCUNOchyehk8V7a9b2YQ5rF1+iHyZgwS
         TNMrx9r8GIBfP5z1mguCH6O6eS/2N4x4//YPaKLJQOlBJEoNYMhUh8/o6u+vSz4eAvDr
         0JUK7xHfuZ9kl+VI1GHl692i3/ti9WyIwzgYG6Kqgr1TfYMTBC5diyz6R5mQAvJT0bOP
         0lMPKMv6tlRXLg7bV2CQQwGwFHAgBNC8Tt+Bpi7WnD20qRthchKIN8YEVWrCus4sq52h
         kJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyy32pPjpp1+HoN3duWve6afDu3nwijSLM8OWsPWdcocYv77e5HktG3PtmvT3Nt+qHtaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzVzq1hzu3VyYL9eoyOTQstAiyUgtZlDdeYmHF9u0TiTzfLV9
	059trieYdXHPj0cizZAzvQb9dtdFgNvpzlAeKvfQhI0WElVscO4b1DBOhJxxbLznbl/dmWLvG1g
	pGxUzmls9oT8+QB5NCKGNBTO5mK8ADKLwAuqD2gyF
X-Gm-Gg: ASbGncsyAgJaPu1Mu0L0qMVd7S6t3rK9ATdYDxZuPYD6YKSqjtqgIyof171qB5HTv/H
	2rLty14S3R21V2njMe1w/nhEElo/yEYRZMjNj00PLSm37fVFrfIW+VYDsK2Iz3yRPUIsBoflmcW
	4gEiLvNKfBgtt7vbc1vtV81Z1FVHA0Qlbp5PKLcXpchIfY1pJ43iGpPc5EUni0svm6kTIJEt9oI
	HMQvCNPjKWkBziA5jlsudbaWnQ/aYzJp1djC0vn46SHyt1nS2AdAlm/2KjxxLA/pdX2AjnjiuKI
	8mVDAA==
X-Google-Smtp-Source: AGHT+IGdMl6CIKTN4pE90JFzZFLVGowsdHBBDVGm9atrf3WOR5kwNtlwrFbr1CnYAv34CMLs1bYPuu8RTpowcCBf+FQ=
X-Received: by 2002:ac8:584f:0:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4e56b1c1f1fmr2840781cf.10.1759367737081; Wed, 01 Oct 2025
 18:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001074704.2817028-1-tavip@google.com> <aN091c4VZRtZwZDZ@boxer>
 <20251001082737.23f5037f@kernel.org> <aN17pc5/ZBQednNi@boxer>
In-Reply-To: <aN17pc5/ZBQednNi@boxer>
From: Octavian Purdila <tavip@google.com>
Date: Wed, 1 Oct 2025 18:15:25 -0700
X-Gm-Features: AS18NWDy1XtaBZhsbQmwi36wcmA6oBe8mTFyPt8fP9YrWLHf1E1EALGgc3kwh8I
Message-ID: <CAGWr4cSMme5B-bMc+maKccoYxgVeVKaXk7Eh=SOM7jX3Du5Rkw@mail.gmail.com>
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

On Wed, Oct 1, 2025 at 12:06=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Oct 01, 2025 at 08:27:37AM -0700, Jakub Kicinski wrote:
> > On Wed, 1 Oct 2025 16:42:29 +0200 Maciej Fijalkowski wrote:
> > > Here we piggy back on sk_buff::pp_recycle setting as it implies under=
lying
> > > memory is backed by page pool.
> >
> > skb->pp_recycle means that if the pages of the skb came from a pp then
> > the skb is holding a pp reference not a full page reference on those
> > pages. It does not mean that all pages of an skb came from pp.
> > In practice it may be equivalent, especially here. But I'm slightly
> > worried that checking pp_recycle will lead to confusion..
>
> Mmm ok - maybe that's safer and straight-forward?
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 93a25d87b86b..7707a95ca8ed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5269,6 +5269,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, s=
truct xdp_buff *xdp,
>         orig_bcast =3D is_multicast_ether_addr_64bits(eth->h_dest);
>         orig_eth_type =3D eth->h_proto;
>
> +       xdp->rxq->mem.type =3D page_pool_page_is_pp(virt_to_page(xdp->dat=
a)) ?
> +               MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
> +
>         act =3D bpf_prog_run_xdp(xdp_prog, xdp);
>
>         /* check if bpf_xdp_adjust_head was used */
>
> As you know we do not have that kind of granularity within xdp_buff where
> we could distinguish the memory provider per linear part and each frag...

LGTM, based on my limited understanding. I can also confirm the syz
repro no longer crashes with this patch.

