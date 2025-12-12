Return-Path: <bpf+bounces-76505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3CCCB7C4D
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 04:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F983079EA9
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2532ECE83;
	Fri, 12 Dec 2025 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZKT2jCM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7082D77F5
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509468; cv=none; b=WCfmnLdB/Ki8urIs4amdYL5OjK7pEQTEk/ZsQUqT3kftrg+ASSpEv7wOIWLmzdDBfbgS5gNgOdYqt6F4vzPe2b9hrUQ7JeitjYa/WQ447MwdjR9o8N7WaGaqwxXDx8avHXSazWJ8CrKCg9LBNOI+JUxhd/H02YpkcGPgIcnDtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509468; c=relaxed/simple;
	bh=326pnqB+xhMV23EWJj+ZVcK0yuYTFI7uAaTkD4Zehns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db+82yUQG7Ty7EOCMws7JGQJAfrQz8aF/OdgNymJ6VwmUuzz+hl/pwpFq9KtGCDpnezWP1q7xzLxjNZMaxUG6dgsXd0oQw5wWnwr3lsXQG6/J5BZw7xhraGJUvHeKXpe/OhD2zGVuzJlluhE30RjMKWVm23iqlHlYROddkwlb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZKT2jCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D8DC19422
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 03:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765509465;
	bh=326pnqB+xhMV23EWJj+ZVcK0yuYTFI7uAaTkD4Zehns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MZKT2jCMLC+Sq0CSonzlJoJNn9ElLpP8nayc3fW4mCoKq+veRmcRpI08PFMoXjhOL
	 UGNzNcvViYmLtgmqnd7jTpMogjpck6T+2kTo7LaXMfIvkfaUqrNz31iAMlffFBjguE
	 XVIdyiADaI6e9ItyE9483MBSKDkM3+EF6T63BsdnTDe+/sTTdNirsVUTfSH+N+PNFK
	 dE4Ts3UzuDi8nR9ZCrYahVC3t3MSIz8I2Y8Ghfwj7ffTQfM4rb9w7zQC5LkjFIvCAU
	 wPU02WKDzgWqJfqX1tsCO7wVY7tG2qyTghwLzsUWAfG1rIRE0het/E5cC6bM1/a5XM
	 lUbnD0+P2M1Gg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736ffc531fso149780466b.1
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 19:17:45 -0800 (PST)
X-Gm-Message-State: AOJu0YxWXQanZ8VL6w8s8ihy1vxmVwzdG45iODLZxKJD0G4VDjsk7QZz
	4EBbedBdRXMkkFE8sJqybzHngSmG6EnIrScfeOyzyulgTxcXjqQF5OHEqcJ5ER1hMiRumShGOIC
	X6VV9F5W1nx1p1CD9XlWDySdL8BLwzi4=
X-Google-Smtp-Source: AGHT+IGRNKAB05akuKjZBRSjBQQlO9fU4FTZQCu/XzbOaGJKsSGwKXZugV1OY4WAjtgQJEfTSQKkNaHKLLibJYlEouY=
X-Received: by 2002:a17:907:1c26:b0:b73:5864:f317 with SMTP id
 a640c23a62f3a-b7d23a76de8mr36632166b.54.1765509464414; Thu, 11 Dec 2025
 19:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212004350.6520-2-puranjay@kernel.org> <5a493961a3e344496c8a1333525c15d995a3f0742ac8a2cc21ddf58cc0f5d647@mail.kernel.org>
In-Reply-To: <5a493961a3e344496c8a1333525c15d995a3f0742ac8a2cc21ddf58cc0f5d647@mail.kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Fri, 12 Dec 2025 12:17:33 +0900
X-Gmail-Original-Message-ID: <CANk7y0hY4M3dw+3Koa95dJ5ejh7n0cDtB78W0C6Dk2YSRRh0KA@mail.gmail.com>
X-Gm-Features: AQt7F2pIL8RyUi0AEoh2Z-ViL839f7c2Sxu0bS24JjVkmp9FfrnalYNxrAdIIjQ
Message-ID: <CANk7y0hY4M3dw+3Koa95dJ5ejh7n0cDtB78W0C6Dk2YSRRh0KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: arena: populate vm_area without
 allocating memory
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 10:05=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 1074ac4459f2..214a4da54162 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
> > @@ -465,6 +529,7 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
> >       if (ret)
> >               goto out_free_pages;
> >
> > +     struct apply_range_data data =3D { .pages =3D pages, .i =3D 0 };
> >       ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages=
);
> >       if (ret)
> >               goto out;
> > @@ -477,8 +542,8 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
> >        * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflo=
w
> >        * lower 32-bit and it's ok.
> >        */
> > -     ret =3D vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32=
,
> > -                             kern_vm_start + uaddr32 + page_cnt * PAGE=
_SIZE, pages);
> > +     ret =3D apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
> > +                               page_cnt << PAGE_SHIFT, apply_range_set=
_cb, &data);
> >       if (ret) {
> >               for (i =3D 0; i < page_cnt; i++)
> >                       __free_page(pages[i]);
>                         ^^^^
>
> Can this create PTEs pointing to freed memory? If apply_to_page_range()
> fails after partially setting PTEs, the callback will have been invoked
> multiple times, and data.i will reflect how many PTEs were successfully
> set. The error path frees all pages in the array, including those that
> were already mapped into PTEs.
>
> Later access to those addresses via arena_vm_fault()->vmalloc_to_page()
> or arena_free_pages()->vmalloc_to_page() would return pointers to the
> freed pages, leading to use-after-free.
>
> The next commit (3b7e9448213a) fixes this by tracking data.i and only
> freeing pages that weren't successfully mapped.

Yes, the next commit has the fix, I will fix this commit as well in
the next version.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/201524=
58491

