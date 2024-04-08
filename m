Return-Path: <bpf+bounces-26188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575B89C7D8
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C55B22323
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5213F44D;
	Mon,  8 Apr 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlBPUSKm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4B1CD21;
	Mon,  8 Apr 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589003; cv=none; b=HaH64v8SxtISHTOcCzLZVo2IBs9xb0tIMiEFwO71K98Puh38P4nt9OuG6Sua+rvn5TGR3W4EEz9bFyTG3Nn8TrNKuOx5OG7NCK7GACYeaxspKCAM7Qdxiv7OA7oYkvYFS48GG/cVI9Fyt38+6v3y2+0mSe/Sb427f5tgrfNQQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589003; c=relaxed/simple;
	bh=7RjjAX+l+5ybv+rftzcGFZmHFQtRiNYQm+IvwvQLEoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/TJWCjkRQyfRROq8xYVTyoO4ZgYYzLR7NqXwU6lWKc01ELFfuF00p0lNwhqclyR3HWEj/uhkkzl8wzybn5wGWtXnJ0M9EPvlWE6tR7bBtWnRefbrzsiIigX8iAhkksV/VS8twC5JC6zuX0Ombg106YUyp01Fogmk8/B4x+PulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlBPUSKm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41650ee55ffso9455035e9.0;
        Mon, 08 Apr 2024 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712588999; x=1713193799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o7+hDSIuCWKDG8jzwsz/CU+9322M+SgxIxtVMZNuNI=;
        b=nlBPUSKm9+uNXDQNnZa+6e6c47Z7wE7XuQeObWPWaF+3xUuW725GMn6bPB/SS+8yKI
         2H4z12+MYZHzjeH6+Xx2xUjAGOjHcIV1cSN0wO1pBnAxIvDFx4irItjFDPMOsy0QaPeK
         G5PP+u1/ZoFtA3kFGFEffVQKP1xA8IC/GCOGbeJZNhiE6uaErR3sSigYYszTTfs6qkfC
         emeoiSxk57DNg+EKnWDocYbP1XBriWbQOB8xo1itFANj1/8014bQAjmmmZwZaUTSkYII
         iZEkOlOvwJWJ67umvA8hKnj6Gn72Xnim7hPI2vxqSblA9EYIz///WYa9eDO0VFBLZ1+r
         KBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712588999; x=1713193799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o7+hDSIuCWKDG8jzwsz/CU+9322M+SgxIxtVMZNuNI=;
        b=sfL4tQprEAFSxhIdM6qBF5mKAEC5dFsOvmij8cvPNNEueodSKKYVD7lWEthkOWYwyh
         DqL6fmiEtFqdaYgCW1Ha7pC1j/q6fp+o1BBLUU5bHAkWXT2+rU0x6iCLXgzErBTC9czq
         +JVK6r2yVsBnx4sdIRncO2KhoCjeRq+k8Sj/xQQQ7RSo+vmj6XPkAPL6SRFvT6NbPU/q
         zotBEIBvexmBuNSJfpn99AfBcUiK7sweyG25MT6vaXw1e7TcDz1mXF+xJ3PhZTJkGlZI
         QB7xLQ9NkDPJMfAnvOiuXV5MUL3zDrNlh1OhwRq8ODWUpMUo7FqVHxBefreP981sTobE
         cSLg==
X-Forwarded-Encrypted: i=1; AJvYcCUZZ/qhim/+QG/JEZy04JGOtxYEtfrkIc8373Sy6yY6W5q6HGxCbM0RZ1gV5pmK/VhONAxW75v2YSU8NvbsdLjFqEDZfqCNl/rnXGsjMW6o6cf7mwJDhU8kUtDUzNQjWTORaVy5pXY5Xcff/W5V4pT475+25WazTqiL
X-Gm-Message-State: AOJu0YwatePjlq1XSKgOxFVFdB0+TjpgkwQ9VDJmhYkuQsUi29lyLz2n
	o2rqbTGQOsoN5+2fYoGNqgusKIa3H8g/l3UJxrBKx7TE/3WEHDSpiSWT6RuWLcu9/c5TXcL2xbg
	9bk2SDoHuGehIjqFibMwmM+B/rcA=
X-Google-Smtp-Source: AGHT+IGfD5tw9rqnE5LU+TW60kXROajtXB4BtqIhZq3i2yRRlQkfuwvGF/5wsc9QyaA0puOL1oGI7yTw06d1aVVHif4=
X-Received: by 2002:a05:6000:1048:b0:343:9d6d:59a4 with SMTP id
 c8-20020a056000104800b003439d6d59a4mr6383480wrx.28.1712588999269; Mon, 08 Apr
 2024 08:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <CAKgT0Uex+e_g9nyqk6DiB03U4zs_A1z2LoztHnpYbJ9LPm=NFA@mail.gmail.com> <05c21500-033b-dfee-6aa7-1ee967616213@huawei.com>
In-Reply-To: <05c21500-033b-dfee-6aa7-1ee967616213@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Apr 2024 08:09:22 -0700
Message-ID: <CAKgT0UdjBXguCudxM9-tzKx2qWYg18xp5cG2xaeY893rVbw5qQ@mail.gmail.com>
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

On Mon, Apr 8, 2024 at 6:38=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/4/8 1:02, Alexander Duyck wrote:
> > On Sun, Apr 7, 2024 at 6:10=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> After [1], Only there are two implementations for page frag:
> >>
> >> 1. mm/page_alloc.c: net stack seems to be using it in the
> >>    rx part with 'struct page_frag_cache' and the main API
> >>    being page_frag_alloc_align().
> >> 2. net/core/sock.c: net stack seems to be using it in the
> >>    tx part with 'struct page_frag' and the main API being
> >>    skb_page_frag_refill().
> >>
> >> This patchset tries to unfiy the page frag implementation
> >> by replacing page_frag with page_frag_cache for sk_page_frag()
> >> first. net_high_order_alloc_disable_key for the implementation
> >> in net/core/sock.c doesn't seems matter that much now have
> >> have pcp support for high-order pages in commit 44042b449872
> >> ("mm/page_alloc: allow high-order pages to be stored on the
> >> per-cpu lists").
> >>
> >> As the related change is mostly related to networking, so
> >> targeting the net-next. And will try to replace the rest
> >> of page_frag in the follow patchset.
> >>
> >> After this patchset, we are not only able to unify the page
> >> frag implementation a little, but seems able to have about
> >> 0.5+% performance boost testing by using the vhost_net_test
> >> introduced in [1] and page_frag_test.ko introduced in this
> >> patch.
> >
> > One question that jumps out at me for this is "why?". No offense but
> > this is a pretty massive set of changes with over 1400 additions and
> > 500+ deletions and I can't help but ask why, and this cover page
> > doesn't give me any good reason to think about accepting this set.
>
> There are 375 + 256 additions for testing module and the documentation
> update in the last two patches, and there is 198 additions and 176
> deletions for moving the page fragment allocator from page_alloc into
> its own file in patch 1.
> Without above number, there are above 600+ additions and 300+ deletions,
> deos that seems reasonable considering 140+ additions are needed to for
> the new API, 300+ additions and deletions for updating the users to use
> the new API as there are many users using the old API?

Maybe it would make more sense to break this into 2 sets. The first
one adding your testing, and the second one consolidating the API.
With that we would have a clearly defined test infrastructure in place
for the second set which is making significant changes to the API. In
addition it would provide the opportunity for others to point out any
other test that they might want pulled in since this is likely to have
impact outside of just the tests you have proposed.

> > What is meant to be the benefit to the community for adding this? All
> > I am seeing is a ton of extra code to have to review as this
> > unification is adding an additional 1000+ lines without a good
> > explanation as to why they are needed.
>
> Some benefits I see for now:
> 1. Improve the maintainability of page frag's implementation:
>    (1) future bugfix and performance can be done in one place.
>        For example, we may able to save some space for the
>        'page_frag_cache' API user, and avoid 'get_page()' for
>        the old 'page_frag' API user.

The problem as I see it is it is consolidating all the consumers down
to the least common denominator in terms of performance. You have
already demonstrated that with patch 2 which enforces that all drivers
have to work from the bottom up instead of being able to work top down
in the page.

This eventually leads you down the path where every time somebody has
a use case for it that may not be optimal for others it is going to be
a fight to see if the new use case can degrade the performance of the
other use cases.

>    (2) Provide a proper API so that caller does not need to access
>        internal data field. Exposing the internal data field may
>        enable the caller to do some unexpcted implementation of
>        its own like below, after this patchset the API user is not
>        supposed to do access the data field of 'page_frag_cache'
>        directly[Currently it is still acessable from API caller if
>        the caller is not following the rule, I am not sure how to
>        limit the access without any performance impact yet].
> https://elixir.bootlin.com/linux/v6.9-rc3/source/drivers/net/ethernet/che=
lsio/inline_crypto/chtls/chtls_io.c#L1141

This just makes the issue I point out in 1 even worse. The problem is
this code has to be used at the very lowest of levels and is as
tightly optimized as it is since it is called at least once per packet
in the case of networking. Networking that is still getting faster
mind you and demanding even fewer cycles per packet to try and keep
up. I just see this change as taking us in the wrong direction.

> 2. page_frag API may provide a central point for netwroking to allocate
>    memory instead of calling page allocator directly in the future, so
>    that we can decouple 'struct page' from networking.

I hope not. The fact is the page allocator serves a very specific
purpose, and the page frag API was meant to serve a different one and
not be a replacement for it. One thing that has really irked me is the
fact that I have seen it abused as much as it has been where people
seem to think it is just a page allocator when it was really meant to
just provide a way to shard order 0 pages into sizes that are half a
page or less in size. I really meant for it to be a quick-n-dirty slab
allocator for sizes 2K or less where ideally we are working with
powers of 2.

It concerns me that you are talking about taking this down a path that
will likely lead to further misuse of the code as a backdoor way to
allocate order 0 pages using this instead of just using the page
allocator.

> >
> > Also I wouldn't bother mentioning the 0.5+% performance gain as a
> > "bonus". Changes of that amount usually mean it is within the margin
> > of error. At best it likely means you haven't introduced a noticeable
> > regression.
>
> For micro-benchmark ko added in this patchset, performance gain seems qui=
t
> stable from testing in system without any other load.

Again, that doesn't mean anything. It could just be that the code
shifted somewhere due to all the code moved so a loop got more aligned
than it was before. To give you an idea I have seen performance gains
in the past from turning off Rx checksum for some workloads and that
was simply due to the fact that the CPUs were staying awake longer
instead of going into deep sleep states as such we could handle more
packets per second even though we were using more cycles. Without
significantly more context it is hard to say that the gain is anything
real at all and a 0.5% gain is well within that margin of error.

