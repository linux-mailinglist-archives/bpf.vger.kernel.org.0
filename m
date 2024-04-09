Return-Path: <bpf+bounces-26304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC5289DFEC
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C450B332ED
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685CB13D520;
	Tue,  9 Apr 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwxgsU1Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E621350C0;
	Tue,  9 Apr 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676588; cv=none; b=s3dh0+YNonHyYMJRRusGidXEYfXigz2dOSX1kIsyx7osNy65sRw1SHT5gD802rUw/xc2EJ3UwtONqKCuoVJJHHIOzAghMlwNQ0EF9LkO5/HswM7DFHxi8DhCQuaBQVJ82vxCywLiBWUov9Aio+5o0ixv7DrwFgoE4SOlFlsIuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676588; c=relaxed/simple;
	bh=mFFtRKPX+qZKlafshqo4Fs5hZArztxXE5bcr+Lp9cEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4TbDSPXNExkkGCeJLUtuo/7K5PrfbBzbwkVS5pwtN3LpjVxx+BV9gLXQKhtGCF4+FUEaelSlyjsyGWu7jm0/Fcfz6yLd4IAGRFwAGPPHX8LUiGA/L7zqeLWcV6c7WGanJxMCpV+8f40zW4HPa4S0vvmksibA4r2Uu+nu3D/Gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwxgsU1Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso3629604f8f.2;
        Tue, 09 Apr 2024 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676584; x=1713281384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOFxP/TnNlu2onBFHvckmAc68wCJlKCX1NZKkoLz4dQ=;
        b=lwxgsU1ZTnCIO92toP1a2SBkk67hEuPPTQymIs+a4aTSJa19WsC5SMak1EqZMKi+Vh
         G1MGqqm8iDaWCuruznHK08/6NmFF65DK7+U/yjzmBQBSoq0M2CMoOwDwG9n+2HhV2M7Q
         FhJOJkfEUoJZeBc9Qi9e0tTuIVb3CiLHyq2EozzmDrGcbtKbm07cOeR1w3RUpsI/ca5K
         w/SvedY41CIETswxdJXhiTLVpKcdJRNLJBmaNZOHQC0RcXH6UyVhfepOQrEmrfXdrzu0
         yHGPjQF9hoOqAwdbJcrf4mwlVz0WrSkdDvAKUx3b7sFP4fZ+5KRVqKU9IaJ8WvEMko/e
         PbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676584; x=1713281384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOFxP/TnNlu2onBFHvckmAc68wCJlKCX1NZKkoLz4dQ=;
        b=nQeUq1s1cYZjHDtTs904wQfm4g0YTVEgNzh8BR2IWuHNdaIxkZx2OCb01xfhG0s+yR
         iRXLlyKWIO8h0OlmLSz3DZQ87YTsilIMnE4Z0ZQ7+nGPPfi83Xzz9yl+kNlDgZF9evuB
         44E8MaX2bYmkENDyOfTdtAoOeNcMluvZkvfJuJZp+vlJtcSXRyBRVglkeaefdFzvcQUh
         nIBrxA6FOoz4EEqlmEVUfYIDvt52D70WduQitvT+/QQxrYHcZJJcORFscwVW34FEhLDq
         Ziya20wJT7gVGos1nl+VaKoAdqVActA2bRfE5xnBD+U7Z7by62OGZ5ec1k4OeJSqFy6a
         fBbw==
X-Forwarded-Encrypted: i=1; AJvYcCX50234cP9jdk2NzbQpVIgsi3eak1b1YZJLHDJV2e2fJrdYTc8ICkVWvr/MMeJKhTX9zs2je0LmBoLHUSLNMlaOt7h/cGONRbQSni+JvToG1D/W7aZf1dYK8Rako0GKkuqkDfDZlZNp0BDE+bmfYeyCqNnZAa7PdZMl
X-Gm-Message-State: AOJu0Yx42XXk4IMOzJ7YOT6330jSgVQ7tF/ABPoye5/e6MWk5VZEiOja
	AYoqzEr/SMLn++5DTuHqSPUyvgbz7rsKl+MoZmtx//KO70HvIyzqPwlNc48n6uz+3Hc43h7JN95
	ToYxtnPv4GfSHNOsxAlabjKJWogs=
X-Google-Smtp-Source: AGHT+IE17k8FPnDlop6+wKFYJ5JMTdYZ+AZRar4Z8sBtc6/1d7mT6dyvSLmgx5eHKV/OdunMUrdw9um2VeSMMZnp6Uc=
X-Received: by 2002:a5d:64c3:0:b0:345:606e:8a00 with SMTP id
 f3-20020a5d64c3000000b00345606e8a00mr82238wri.14.1712676583734; Tue, 09 Apr
 2024 08:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <CAKgT0Uex+e_g9nyqk6DiB03U4zs_A1z2LoztHnpYbJ9LPm=NFA@mail.gmail.com>
 <05c21500-033b-dfee-6aa7-1ee967616213@huawei.com> <CAKgT0UdjBXguCudxM9-tzKx2qWYg18xp5cG2xaeY893rVbw5qQ@mail.gmail.com>
 <e3e3ad18-8ed0-4bd3-8126-2f60e8d3ae28@huawei.com>
In-Reply-To: <e3e3ad18-8ed0-4bd3-8126-2f60e8d3ae28@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Apr 2024 08:29:07 -0700
Message-ID: <CAKgT0UdvvwG7-tJLKcH2CZDAtObUbP2KHGaRo+setcq=Q26ieA@mail.gmail.com>
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

On Tue, Apr 9, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/4/8 23:09, Alexander Duyck wrote:
> > On Mon, Apr 8, 2024 at 6:38=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2024/4/8 1:02, Alexander Duyck wrote:
> >>> On Sun, Apr 7, 2024 at 6:10=E2=80=AFAM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>>
> >>>> After [1], Only there are two implementations for page frag:
> >>>>
> >>>> 1. mm/page_alloc.c: net stack seems to be using it in the
> >>>>    rx part with 'struct page_frag_cache' and the main API
> >>>>    being page_frag_alloc_align().
> >>>> 2. net/core/sock.c: net stack seems to be using it in the
> >>>>    tx part with 'struct page_frag' and the main API being
> >>>>    skb_page_frag_refill().
> >>>>
> >>>> This patchset tries to unfiy the page frag implementation
> >>>> by replacing page_frag with page_frag_cache for sk_page_frag()
> >>>> first. net_high_order_alloc_disable_key for the implementation
> >>>> in net/core/sock.c doesn't seems matter that much now have
> >>>> have pcp support for high-order pages in commit 44042b449872
> >>>> ("mm/page_alloc: allow high-order pages to be stored on the
> >>>> per-cpu lists").
> >>>>
> >>>> As the related change is mostly related to networking, so
> >>>> targeting the net-next. And will try to replace the rest
> >>>> of page_frag in the follow patchset.
> >>>>
> >>>> After this patchset, we are not only able to unify the page
> >>>> frag implementation a little, but seems able to have about
> >>>> 0.5+% performance boost testing by using the vhost_net_test
> >>>> introduced in [1] and page_frag_test.ko introduced in this
> >>>> patch.
> >>>
> >>> One question that jumps out at me for this is "why?". No offense but
> >>> this is a pretty massive set of changes with over 1400 additions and
> >>> 500+ deletions and I can't help but ask why, and this cover page
> >>> doesn't give me any good reason to think about accepting this set.
> >>
> >> There are 375 + 256 additions for testing module and the documentation
> >> update in the last two patches, and there is 198 additions and 176
> >> deletions for moving the page fragment allocator from page_alloc into
> >> its own file in patch 1.
> >> Without above number, there are above 600+ additions and 300+ deletion=
s,
> >> deos that seems reasonable considering 140+ additions are needed to fo=
r
> >> the new API, 300+ additions and deletions for updating the users to us=
e
> >> the new API as there are many users using the old API?
> >
> > Maybe it would make more sense to break this into 2 sets. The first
> > one adding your testing, and the second one consolidating the API.
> > With that we would have a clearly defined test infrastructure in place
> > for the second set which is making significant changes to the API. In
> > addition it would provide the opportunity for others to point out any
> > other test that they might want pulled in since this is likely to have
> > impact outside of just the tests you have proposed.
>
> Do you have someone might want pulled in some test in mind, if yes, then
> it might make sense to work together to minimise some possible duplicated
> work. If no, it does not make much sense to break this into 2 sets just t=
o
> introduce a testing in the first set.
>
> If it helps you or someone to do the comparing test before and after patc=
hset
> easier, I would reorder the patch adding the micro-benchmark ko to the fi=
rst
> patch.

Well the socket code will be largely impacted by any changes to this.
Seems like it might make sense to think about coming up with a socket
based test for example that might make good use of the allocator
located there so we can test the consolidating of the page frag code
out of there.

> >
> >>> What is meant to be the benefit to the community for adding this? All
> >>> I am seeing is a ton of extra code to have to review as this
> >>> unification is adding an additional 1000+ lines without a good
> >>> explanation as to why they are needed.
> >>
> >> Some benefits I see for now:
> >> 1. Improve the maintainability of page frag's implementation:
> >>    (1) future bugfix and performance can be done in one place.
> >>        For example, we may able to save some space for the
> >>        'page_frag_cache' API user, and avoid 'get_page()' for
> >>        the old 'page_frag' API user.
> >
> > The problem as I see it is it is consolidating all the consumers down
> > to the least common denominator in terms of performance. You have
> > already demonstrated that with patch 2 which enforces that all drivers
> > have to work from the bottom up instead of being able to work top down
> > in the page.
>
> I am agreed that consolidating 'the least common denominator' is what we
> do when we design a subsystem/libary and sometimes we may need to have a
> trade off between maintainability and perfromance.
>
> But your argument 'having to load two registers with the values and then
> compare them which saves us a few cycles' in [1] does not seems to justif=
y
> that we need to have it's own implementation of page_frag, not to mention
> the 'work top down' way has its own disadvantages as mentioned in patch 2=
.
>
> Also, in patch 5 & 6, we need to load 'size' to a register anyway so that=
 we
> can remove 'pagecnt_bias' and 'pfmemalloc' from 'struct page_frag_cache',=
 it
> would be better you can work through the whole patchset to get a bigger p=
icture.
>
> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.c=
amel@gmail.com/

I haven't had a chance to review the entire patch set yet. I am hoping
to get to it tomorrow. That said, my main concern is that this becomes
a slippery slope. Where one thing leads to another and eventually this
becomes some overgrown setup that is no longer performant and has
people migrating back to the slab cache.

> >
> > This eventually leads you down the path where every time somebody has
> > a use case for it that may not be optimal for others it is going to be
> > a fight to see if the new use case can degrade the performance of the
> > other use cases.
>
> I think it is always better to have a disscusion[or 'fight'] about how to
> support a new use case:
> 1. refoctor the existing implementation to support the new use case, and
>    introduce a new API for it if have to.
> 2. if the above does not work, and the use case is important enough that
>    we might create/design a subsystem/libary for it.
>
> But from updating page_frag API, I do not see that we need the second
> option yet.

That is why we are having this discussion right now though. It seems
like you have your own use case that you want to use this for. So as a
result you are refactoring all the existing implementations and
crafting them to support your use case while trying to avoid
introducing regressions in the others. I would argue that based on
this set you are already trying to take the existing code and create a
"new" subsystem/library from it that is based on the original code
with only a few tweaks.

> >
> >>    (2) Provide a proper API so that caller does not need to access
> >>        internal data field. Exposing the internal data field may
> >>        enable the caller to do some unexpcted implementation of
> >>        its own like below, after this patchset the API user is not
> >>        supposed to do access the data field of 'page_frag_cache'
> >>        directly[Currently it is still acessable from API caller if
> >>        the caller is not following the rule, I am not sure how to
> >>        limit the access without any performance impact yet].
> >> https://elixir.bootlin.com/linux/v6.9-rc3/source/drivers/net/ethernet/=
chelsio/inline_crypto/chtls/chtls_io.c#L1141
> >
> > This just makes the issue I point out in 1 even worse. The problem is
> > this code has to be used at the very lowest of levels and is as
> > tightly optimized as it is since it is called at least once per packet
> > in the case of networking. Networking that is still getting faster
> > mind you and demanding even fewer cycles per packet to try and keep
> > up. I just see this change as taking us in the wrong direction.
>
> Yes, I am agreed with your point about 'demanding even fewer cycles per
> packet', but not so with 'tightly optimized'.
>
> 'tightly optimized' may mean everybody inventing their own wheels.

I hate to break this to you but that is the nature of things. If you
want to perform with decent performance you can only be so abstracted
away from the underlying implementation. The more generic you go the
less performance you will get.

> >
> >> 2. page_frag API may provide a central point for netwroking to allocat=
e
> >>    memory instead of calling page allocator directly in the future, so
> >>    that we can decouple 'struct page' from networking.
> >
> > I hope not. The fact is the page allocator serves a very specific
> > purpose, and the page frag API was meant to serve a different one and
> > not be a replacement for it. One thing that has really irked me is the
> > fact that I have seen it abused as much as it has been where people
> > seem to think it is just a page allocator when it was really meant to
> > just provide a way to shard order 0 pages into sizes that are half a
> > page or less in size. I really meant for it to be a quick-n-dirty slab
> > allocator for sizes 2K or less where ideally we are working with
> > powers of 2.
> >
> > It concerns me that you are talking about taking this down a path that
> > will likely lead to further misuse of the code as a backdoor way to
> > allocate order 0 pages using this instead of just using the page
> > allocator.
>
> Let's not get to a conclusion here and wait to see how thing evolve
> in the future.

I still have an open mind, but this is a warning on where I will not
let this go. This is *NOT* an alternative to the page allocator. If we
need order 0 pages we should be allocating order 0 pages. Ideally this
is just for cases where we need memory in sizes 2K or less.

> >
> >>>
> >>> Also I wouldn't bother mentioning the 0.5+% performance gain as a
> >>> "bonus". Changes of that amount usually mean it is within the margin
> >>> of error. At best it likely means you haven't introduced a noticeable
> >>> regression.
> >>
> >> For micro-benchmark ko added in this patchset, performance gain seems =
quit
> >> stable from testing in system without any other load.
> >
> > Again, that doesn't mean anything. It could just be that the code
> > shifted somewhere due to all the code moved so a loop got more aligned
> > than it was before. To give you an idea I have seen performance gains
> > in the past from turning off Rx checksum for some workloads and that
> > was simply due to the fact that the CPUs were staying awake longer
> > instead of going into deep sleep states as such we could handle more
> > packets per second even though we were using more cycles. Without
> > significantly more context it is hard to say that the gain is anything
> > real at all and a 0.5% gain is well within that margin of error.
>
> As vhost_net_test added in [2] is heavily invovled with tun and virtio
> handling, the 0.5% gain does seems within that margin of error, there is
> why I added a micro-benchmark specificly for page_frag in this patchset.
>
> It is tested five times, three times with this patchset and two times wit=
hout
> this patchset, the complete log is as below, even there is some noise, al=
l
> the result with this patchset is better than the result without this patc=
hset:

The problem is the vhost_net_test is you optimizing the page fragment
allocator for *YOUR* use case. I get that you want to show overall
improvement but that doesn't. You need to provide it with context for
the current users of the page fragment allocator in the form of
something other than one synthetic benchmark.

I could do the same thing by by tweaking the stack and making it drop
all network packets. The NICs would show a huge performance gain. It
doesn't mean it is usable by anybody. A benchmark is worthless without
the context about how it will impact other users.

Think about testing with real use cases for the areas that are already
making use of the page frags rather than your new synthetic benchmark
and the vhost case which you are optimizing for. Arguably this is why
so many implementations go their own way. It is difficult to optimize
for one use case without penalizing another and so the community needs
to be wiling to make that trade-off.

