Return-Path: <bpf+bounces-46681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9549EDD2B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 02:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DB72833F9
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC757CBE;
	Thu, 12 Dec 2024 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugssm1ja"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF717225A8
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967796; cv=none; b=EH9WMivmDPse20Qd5KN86uKzGWQNRaes92bu3n+B36C4BOJmF+wAX9mfvR7VO1Q0EqM/1T6NsT7q+n5CHb/9bPEHldo9x75UuerbrCtlnlJal5jgMEvlixaKVQY23AOAElfvAnmi56cFrLx8mn99hr24aNkvoVD++baajfHXn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967796; c=relaxed/simple;
	bh=/xKAJ4llUOqQVbiGYITJf3q4k9JqPx8yLmCSosVD07c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odaBEetY1hxCV0aYBwX4I7gqslMriLqQf+annJTSc+WLLj0V3heyXCuMdi5gj02hj7PppeGTv1GL98Bste9F47GW27W/R91q6nFGmMhk3n8IiJ9OleLOnL0CwFv8967Iv3HGFNNrsmsPZrlR6rt2qI9/Q5jMRZeHfyIH1AgPJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugssm1ja; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862d6d5765so23519f8f.3
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 17:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733967793; x=1734572593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjW0Rmfd8vrE4q76KDpCVdgkurMhEEeT93Mb5OI6eT4=;
        b=Ugssm1japKlJNXguh1pqBDAgcV+MlTfbraHVfJL0usyKlqS02nVncy7kFeTtYzV+xJ
         dFOhAlKdDzeAIQA3EP/u1WhbwS35/m2LoevxRnNCZeT+sTEqZRwx3D+7D+XQpBJ7CVVI
         6kBSNqof2ERN2Xw7E0qobh4m/AoScUW/zH+wgieMaXa6nV2ZLI09tL+ZyX20B/dkzlWV
         3BNrCMxaJT09W22diCGJbeFS15mqFpnME5lKaj3a8BZYbDkbgjFrEElEPkdURYO4RNG7
         EILSwPV5MTpHNumViYhW1SKR2dejWYrQE6veP8Gqe//tLy7fqbI1qEddOhcfCXVKbi9O
         buXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733967793; x=1734572593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjW0Rmfd8vrE4q76KDpCVdgkurMhEEeT93Mb5OI6eT4=;
        b=K+5/PI9RE7I1LhapWO07GF/imvZYQ94zT4ejBsWWCbY1fPuY8G6/WbSawnb1tYS2p3
         ifj0IVindH7aEpijCtkYshxXAGLdfOr7GeVjxbHuTB3sudMXbXn5VkVbbdxNskGxYVy4
         +n5InDi/qkm2n96B0kSldpoOqnNb8VqdCdJLM2irFi68eWYkjxOyfp/w6xBuV9XQnW29
         +BzbT8wUqxeK1bjc3yR1R/p0eBWmAFYKCfqrLN7KqE6ihRO9MQCeb92N8BG61ehV2W1p
         +dZnN9yIiQ7GolChcXFcNAMyld+NaX/TrVHcVZ3JIt3RfnMFimLVINTJY9Uehm5Oz714
         +7vw==
X-Gm-Message-State: AOJu0YzVPKQTUDU5YtfhxgdflOqKBfCgHGpn+3wU4mQ/QTC6BhQMuDUX
	OETe4inyvr7Lvwgup4F513ZW7/lIT4DLXQy6NZEj+yW+Nf02IbaqzGME72wEcDXdYnn0jzue8We
	WG2fwCVFN+ehpLDdU5j0ks3Omf7I=
X-Gm-Gg: ASbGncspO+zs5LBcRs0dIFcab1BCtbnluBzP1hJ49BmOUackOJSmemdwv1J7h6bg4sm
	OD97jQ7XujmIubEdiKJPl55AST/fhrC+dP85f1EJu9fzCWnIVlgvsOw==
X-Google-Smtp-Source: AGHT+IEtVUyDNZpyi7qkYFygQxdaBBeAVrU1ivg7A1I+f/b5v9TTf5pswGF9uA+NIBR0nYb0rZOzwOMp6Jn5F62JUcs=
X-Received: by 2002:a05:6000:4405:b0:385:f13c:570f with SMTP id
 ffacd0b85a97d-3864ce5fbcemr3088012f8f.33.1733967793034; Wed, 11 Dec 2024
 17:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-3-alexei.starovoitov@gmail.com> <c9433086-04e3-4c58-a7b6-a64d986ab1e2@suse.cz>
In-Reply-To: <c9433086-04e3-4c58-a7b6-a64d986ab1e2@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Dec 2024 17:43:01 -0800
Message-ID: <CAADnVQL2ys3zO2TncNXydC6_fbAQ-GrEJMiH3yx9My0AHr2=sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] mm, bpf: Introduce free_pages_nolock()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:11=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 12/10/24 03:39, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce free_pages_nolock() that can free a page without taking locks=
.
> > It relies on trylock only and can be called from any context.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> <snip>
>
> > +/* Can be called while holding raw_spin_lock or from IRQ. RCU must be =
watching. */
> > +void free_pages_nolock(struct page *page, unsigned int order)
>
> What does "RCU must be watching" mean and why?

Meaning that rcu_is_watching() must be true.
Because pgalloc_tag_get() relies on RCU.
ree_unref_page() and things it calls doesn't use RCU directly,
but it calls tracepoints and they need RCU too.

Hence the comment to say that free_pages_nolock() cannot be
called in _any_ context. Some care needs to be taken.
bpf needs RCU, so we don't allow attach bpf to idle and notrace,
but, last I heard, notrace attr is not 100% reliable on some odd arch-es.

> > +{
> > +     int head =3D PageHead(page);
> > +     struct alloc_tag *tag =3D pgalloc_tag_get(page);
> > +
> > +     if (put_page_testzero(page)) {
> > +             __free_unref_page(page, order, FPI_TRYLOCK);
> > +     } else if (!head) {
> > +             pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> > +             while (order-- > 0)
> > +                     __free_unref_page(page + (1 << order), order, FPI=
_TRYLOCK);
>
> Not your fault for trying to support everything __free_pages did,
> specifically order > 0 pages that are not compound and thus needing this
> extra !head branch. We'd love to get rid of that eventually in
> __free_pages(), but at least I think we don't need to support it in a new
> API and instead any users switching to it should know it's not supported.

Great. Good to know.

> I suppose BFP doesn't need that, right?

Nope.
Initially I wrote above bit as:

void free_pages_nolock(struct page *page, unsigned int order)
{
         if (put_page_testzero(page))
                __free_unref_page(page, order, FPI_TRYLOCK);
}

but then I studied Matthew's commit
e320d3012d25 ("mm/page_alloc.c: fix freeing non-compound pages")

and couldn't convince myself that the race he described
+               get_page(page);
+               free_pages(addr, 3);
+               put_page(page);

will never happen.
It won't happen if bpf is the only user of this api,
but who knows what happens in the future.
So copy-pasted this part just in case.
Will be happy to drop it.

> Maybe if the function was taking a folio instead of page, it would be the
> best as that has to be order-0 or compound by definition. It also wouldn'=
t
> need the order parameter. What do you think, Matthew?

For bpf there is no use case for folios.
All we need is a page order 0 and separately
later kmalloc_nolock() will call it from new_slab().
And I think new_slab() might need order >=3D 1.
So that's the reason to have order parameter.

