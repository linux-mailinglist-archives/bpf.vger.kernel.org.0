Return-Path: <bpf+bounces-70501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16FBC1656
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE1CF4E760E
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13C2DF71B;
	Tue,  7 Oct 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFyBf1MN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0E2DF3D1
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841099; cv=none; b=m2jydeHWXzO7gAoDdUyX1V+E4r7ai891mFrA/7dnndGaSqdyTsX/jwvUx/tQWUjJWB/6Apl0L8nv0qkKhGTa6EvjciIsX99iXYhVlsTYslqak8uhlwY0H3Hf7fkvP+W1DGsywg8XI+//EOSdC3T/sqASoX/wY7FKY0rJpcT4IFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841099; c=relaxed/simple;
	bh=v8R61G9uFRafpRqgof2hr0YG91bTbaxUiJ4pliJV99c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUMgPkX82wIVlNefq5yrhgWKHzOKpoSUUGoe3+B7g59IjrSBcKkHdwycCR4BB1AEYTSuggBOrfKVgAjOfZFd77iBFQMdOZKFIM4TIpeOrfL8N/OrpwG9xP8LbLQlkB8QwRLUpfAOVi4ALIAKWS2wcU3zsGQwXkdPNZj1vvdyYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFyBf1MN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-791875a9071so60861096d6.1
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759841096; x=1760445896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sAHCsIlLwSaJ2tvd0eA1u1tkqHau8sGeAg3aqapTft4=;
        b=kFyBf1MNRU46bYnsRZnUARGBTslOBW5IiGOkXGKqS+Xgk5FL1xh5Md3CM/hVzdyb0I
         1xEumeyQG+k6HR5OL/+WjuOzwqudNcz6H9QM8FZQOp506uYkTQoI+v4LKJDSyHE7uIYA
         y0S0AWTQGKcH0FDgVZ0Agz8m9tTsB8MGwtbY9p19Vkvr4sy4/NLRrGBDphcc2Bj66wwf
         ufySc4lVKzdD/77s1QUV2Ypf1QLkxSftsCQgwAnGRYFdy6S5JMsao+tG203DvhTQxPe5
         17RiAPQXGpUsSSEf6/6DaFix0Reoq2rrLcREDJMSuHKuf+fRvzTR3PeCxXKtVizfQM33
         0NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841096; x=1760445896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAHCsIlLwSaJ2tvd0eA1u1tkqHau8sGeAg3aqapTft4=;
        b=YB3mnMkTYIorVp/uyTwZDREYg8yZ+nQQCHYxF4+Bi1CLLhomhzaHnH8kyHvhDRaley
         Np+w1DyTRXC769qVLCtt7VBI4tBoqSNSU9ifhT9aBxaFHm5rc3X9JOR8MLi9DfMLj24Q
         gTaomNq90QWL6OJ0RHa8dun9Fq4yOBMEX3TBF+RH99wgXTS8cKotE9e2vcgRJm8oCkL1
         lrMr5SPQ+IEFF2oS/HxjnfVfg4tj7XxcYNdrhX46xfNbYescr8ORffymQ6dDBsV9GnYv
         GyvUI/hXY31zF4myAAccYN22Z+EP6NdEFRyFFoJq64+fZ7wWF/Q/mxU+bCwIEH70BeVg
         aklA==
X-Forwarded-Encrypted: i=1; AJvYcCU25/5jmo2QDim1oTFfwmtlZdQ9JUzdpeNS4PRba6Ec9MYS6nYIFXUaFY4p4ECamIqpWIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitZkc9nZqixmi3EjwCl5T3xAkD8+swC5hii4syQGXGmEotqak
	Hrkx0P808yrCL5/KU3KPgLEqrT4ujIduAm7YskQnslqfE5xr6qRQQFMsiPkEls1bq3uXVGfjz1m
	0oaVbYd/3z9/Q52//VtcHATa9PZWC10k=
X-Gm-Gg: ASbGnctDWI+BA+5IshpEJ2tqHbIlnrKg+kqj5Ol4k0p4TCT5NmQWYFEKw9rscsRI4dh
	E2yUud2D/emmjOae5DD9HqgSHcbb+Rr7B3ZmVfPf4bsD/x1Qh5bFR/57mS/SUWFpoKBuBaoCn9g
	xZUL0eMBnB0mCF9jMMXy9KMndgH6wUPmxviQg/CYnXm4kSGyD4uuL06FdTlQcrnSeat+WSsnCOR
	s4WXthdYY9fpDe5PilQPy4GOnJm3xc=
X-Google-Smtp-Source: AGHT+IEo0I4fjDzNt4bWp1Mv8jnjbS6WheOlafdsTmodNxclq2dXxLbXwy+MwuvyKzGZZTCsw5noIpHNgDFNoSYhM18=
X-Received: by 2002:a05:6214:27ed:b0:78e:f843:e974 with SMTP id
 6a1803df08f44-879dc8817bcmr213229076d6.63.1759841096159; Tue, 07 Oct 2025
 05:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
 <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com> <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
 <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com>
In-Reply-To: <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 7 Oct 2025 14:44:45 +0200
X-Gm-Features: AS18NWAnR4YpziIfj3IV8amXvZKL_RMPNGBrMgzSOHgm0l_GJQ5WzXolRyspwjw
Message-ID: <CAJ8uoz1wf6cfRN16pdMZuoWMxVLWfywVymB7NffDpp82vp5dLA@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH net] xsk: Fix overflow in descriptor validation@@
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>, 
	Song Yoong Siang <yoong.siang.song@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 14:11, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> Date: Tue, 7 Oct 2025 11:19:19 +0000
>
> > On 10/6/25 18:19, Alexander Lobakin wrote:
> >> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> >> Date: Mon, 6 Oct 2025 08:53:17 +0000
> >>
> >>> The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
> >>
> >> In theory. Never in practice.
> >>
> >
> > Hi Alexander,
> > Thank you for the review.
> >
> > It seems to me that this problem should be considered not from the point of view of practical use,
> > but from the point of view of security. An attacker can set any length of the packet in the descriptor
> > from the user space and descriptor validation will pass.
> >
> >
> >>> option is also set, then the value of the expression
> >>> 'desc->len + pool->tx_metadata_len' can overflow and validation
> >>> of the incorrect descriptor will be successfully passed.
> >>> This can lead to a subsequent chain of arithmetic overflows
> >>> in the xsk_build_skb() function and incorrect sk_buff allocation.
> >>>
> >>> Found by InfoTeCS on behalf of Linux Verification Center
> >>> (linuxtesting.org) with SVACE.
> >>
> >> I think the general rule for sending fixes is that a fix must fix a real
> >> bug which can be reproduced in real life scenarios.
> >
> > I agree with that, so I make a test program (PoC). Something like that:
> >
> >       struct xdp_umem_reg umem_reg;
> >       umem_reg.addr = (__u64)(void *)umem;
> >       ...
> >       umem_reg.chunk_size = 4096;
> >       umem_reg.tx_metadata_len = 16;
> >       umem_reg.flags = XDP_UMEM_TX_METADATA_LEN;
> >       setsockopt(sfd, SOL_XDP, XDP_UMEM_REG, &umem_reg, sizeof(umem_reg));
> >       ...
> >
> >       xsk_ring_prod__reserve(tq, batch_size, &idx);
> >
> >       for (i = 0; i < nr_packets; ++i) {
> >               struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(tq, idx + i);
> >               tx_desc->addr = packets[i].addr;
> >               tx_desc->addr += umem->tx_metadata_len;
> >               tx_desc->options = XDP_TX_METADATA;
> >               tx_desc->len = UINT32_MAX;
> >       }
> >
> >       xsk_ring_prod__submit(tq, nr_packets);
> >       ...
> >       sendto(sfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
> >
> > Since the check of an invalid descriptor has passed, kernel try to allocate
> > a skb with size of 'hr + len + tr' in the sock_alloc_send_pskb() function
> > and this is where the next overflow occurs.
> > skb allocates with a size of 63. Next the skb_put() is called, which adds U32_MAX to skb->tail and skb->end.
> > Next the skb_store_bits() tries to copy -1 bytes, but fails.
> >
> >  __xsk_generic_xmit
> >       xsk_build_skb
> >               len = desc->len; // from descriptor
> >               sock_alloc_send_skb(..., hr + len + tr, ...) // the next overflow
> >                       sock_alloc_send_pskb
> >                               alloc_skb_with_frags
> >               skb_put(skb, len)  // len casts to int
> >               skb_store_bits(skb, 0, buffer, len)
>
> Oh, so you actually have a repro for this. This is good. I suggest you
> resubmitting the patch and include this repro in the commit message, so
> that it will be clear that it's actually possible to trigger the problem
> in the kernel using a malicious/broken userspace application.
>
> (also pls remove those double `@@` from the subject next time)
>
> I'd also like to hear from Maciej and/or others what they think about
> this problem (that the userspace can set packet len to U32_MAX). Should
> we just go with this proposed u64 propagation or maybe we need to limit
> the maximum length which could be sent from the userspace?

I prefer that we do not set a limit on it and go with the proposed
solution since I do not know what a future proof size limit would be.
Somebody could come up with a new virtual device that can send really
large packets, who knows.

> In any case, you raised a good topic.
>
> >
> >> Static Analysis Tools have no idea that nobody sends 4 Gb sized network
> >> packets.
> >>
> >
> > That's right. Static analyzer is only a tool, but in this case, the overflow
> > highlighted by the static analyzer can be used for malicious purposes.
>
> +1
>
> Also I really do hope Infotecs stayed independent from the govs and
> doesn't take part in any dual-purpose/gov-related projects.
>
> Thanks,
> Olek
>

