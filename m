Return-Path: <bpf+bounces-26127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E789B333
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 19:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C768B1F21A79
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3653BB22;
	Sun,  7 Apr 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLHAbAiB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F43A1A2;
	Sun,  7 Apr 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712509405; cv=none; b=t6h1Z70tIm3W30ogGIMeksUeWYpTdiECIXIML5XRbpE0Cwy2TGUYhjZYDKjNTsVWKEXxZkh+96DOTxlBdZkwmmamHJafMUOIXusQt0+e/1JSPS/jQhxeDUDPpBmhF/iBH4TBEjwrB+VAnrk9cLjcbcX8KoDZtWebUkt6cGrRHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712509405; c=relaxed/simple;
	bh=fRM90mJoop7mHkTq4lHxrtHPapUGNNrALtNHT2ImE9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGs9i2i3Dd+0xUiE7FP37ezZA7eLYdnewd9QqTtX8YQhid9SLIcVUOAnXyvjxPEcs44rlZVUqwByrOnxbbHOWE6zOZDKQVtR790tdgo0WxbSojIyB/9+wWOv4tf6Rl6CjkIidU8mvVUvUjSquhd0bns1cjk1rroJ+5T4aApWsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLHAbAiB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso2642851f8f.1;
        Sun, 07 Apr 2024 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712509402; x=1713114202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRL6F0Y7GWiKLw5ZjSnTgJyOyz7w6uvipEUuFAhRYQ8=;
        b=TLHAbAiBjkxCQqqIv72Pvae8oWQd0rj/Lf8HocKJs7CeanGr+d+nlH4l3Ly5XCjxo+
         bkrQkzdn+k+Um1D7bGCExHx0LOJqgex6f1PSW8t7tpVRYpRff13ZUZ6QmkLFOZ2I4CHR
         ZGpzxHLfxFWvlYwIqQlQVhXVC6SHCwre7b0RIyAHUsZOnb2b3dpDjU1iLm32WiDk89JV
         8CQAiOwLr3ikzg4yxQL6eG85W+gufoQYxOVkvCazGQCZyKPwrOZYwI6LyADWolj26/pA
         0g4DNyXQiW5VIhVqxswLj01OVllsKMENi/Fx0EG5iQI1EvxsmGbH3TT28Ywcc1L9vP6g
         4DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712509402; x=1713114202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRL6F0Y7GWiKLw5ZjSnTgJyOyz7w6uvipEUuFAhRYQ8=;
        b=gPh/GmsP5sMaTYgI8bGww2o1RvpaRz4CjBkbwYLMJm8v9yt1ZeA8bJFuEXLN98Wd5u
         nAh5aDWQVAyyxCcG94YMTUrteaj4dvHMO6uJoMZYypTijei3v+ihxiltFRA/GZwJAnYM
         qdjol6Okc9PbSfnoXvHWaOHkjd+klnaGtYG+2m3v2u8l+0P9g1FVO/Ldi1/3e7cQclpA
         dnJ7kQmbknaEQ5951GMyWWNFv2XtlYo6IbGgyOIpKV627bwdnYA0E5CA00aJZ7ftzy4e
         ldVeN5S76gEoMri2uBxtgpmxPVKiX7I+n1NZfkF06y3FkEPZv+w1O/ZD0L67W8ZTQMYm
         XnUw==
X-Forwarded-Encrypted: i=1; AJvYcCUqIoWJZ02dzRvoAVr8hvc+vSpoX+94S6c3KUZPWUsCdiWg7NLJE6DbIwwmFcH5BUD2LVdlL5o0VBRALF0wGBS+HIUnTdOffJAjCS4jt30uaGAl2wfYf16cly/oCJ1Eo1o3YZqE4iH0AIvEggZzVtrrtH/G5ReZg2ji
X-Gm-Message-State: AOJu0YwzMOJdEyrm5PNdphMqPCH87563bpvIhVl6z4XGGHdOemmXKArN
	FfsVtusjD+CEvt/rdS92c68h5p78bjGXeAAhJqn31/dNTFFdAwesm0DrcETbSALMT3aKGjz45Dp
	EkLVz8GpR13sSeEOpkrYcT9qUMmA=
X-Google-Smtp-Source: AGHT+IHJQxJHl+wPj51rspPjpYHaysfsWlIxLTCgpIveJzPwDf+CTy65VL1Y+YNaoJwGVL0dTTu913oNCo9Ck2pbQtI=
X-Received: by 2002:a5d:6c64:0:b0:345:8c1b:32f with SMTP id
 r4-20020a5d6c64000000b003458c1b032fmr1847452wrz.26.1712509401720; Sun, 07 Apr
 2024 10:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407130850.19625-1-linyunsheng@huawei.com>
In-Reply-To: <20240407130850.19625-1-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 7 Apr 2024 10:02:45 -0700
Message-ID: <CAKgT0Uex+e_g9nyqk6DiB03U4zs_A1z2LoztHnpYbJ9LPm=NFA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/12] First try to replace page_frag with page_frag_cache
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 6:10=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> After [1], Only there are two implementations for page frag:
>
> 1. mm/page_alloc.c: net stack seems to be using it in the
>    rx part with 'struct page_frag_cache' and the main API
>    being page_frag_alloc_align().
> 2. net/core/sock.c: net stack seems to be using it in the
>    tx part with 'struct page_frag' and the main API being
>    skb_page_frag_refill().
>
> This patchset tries to unfiy the page frag implementation
> by replacing page_frag with page_frag_cache for sk_page_frag()
> first. net_high_order_alloc_disable_key for the implementation
> in net/core/sock.c doesn't seems matter that much now have
> have pcp support for high-order pages in commit 44042b449872
> ("mm/page_alloc: allow high-order pages to be stored on the
> per-cpu lists").
>
> As the related change is mostly related to networking, so
> targeting the net-next. And will try to replace the rest
> of page_frag in the follow patchset.
>
> After this patchset, we are not only able to unify the page
> frag implementation a little, but seems able to have about
> 0.5+% performance boost testing by using the vhost_net_test
> introduced in [1] and page_frag_test.ko introduced in this
> patch.

One question that jumps out at me for this is "why?". No offense but
this is a pretty massive set of changes with over 1400 additions and
500+ deletions and I can't help but ask why, and this cover page
doesn't give me any good reason to think about accepting this set.
What is meant to be the benefit to the community for adding this? All
I am seeing is a ton of extra code to have to review as this
unification is adding an additional 1000+ lines without a good
explanation as to why they are needed.

Also I wouldn't bother mentioning the 0.5+% performance gain as a
"bonus". Changes of that amount usually mean it is within the margin
of error. At best it likely means you haven't introduced a noticeable
regression.

