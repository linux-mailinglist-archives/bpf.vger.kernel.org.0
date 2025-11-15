Return-Path: <bpf+bounces-74609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2623C5FD50
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E483BA851
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F841DC997;
	Sat, 15 Nov 2025 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4uB2QLb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D261CD1E4
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170012; cv=none; b=rYqxFI5nhOtqhao7ToEiE8LRd76nFTxnMC8n2IQHpzHA5M/S84XIN2YUOhrBt9aaE6NL4EiDlXACrL5vfdwKzaxthQ7kBU+zL8s6xx0njTIIXeex44UpMOBzfHme2mrOwBaBGGDt53TmyTDbmqUGvrUH/ecME7lXi+ymJLvdYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170012; c=relaxed/simple;
	bh=qK7BzIAro2xRXnca+vqzfR0yervIbn1WARpUYZJioww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgGTMDVhI1q4gdexrrce0rJHnHnB0NWGcew/3gRiYa7Lx+X5vy3/1Hi7bz8Xlgy7gBxyyF4jpelWpCKs9ATwoTjQ5kvpjMoMEuvwjVPpREDe39gKsNj51k2qnF4kNZLDG1MwmLJDYtq6cdpofvj50b0o1A02hZkbFgYWsLcy6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4uB2QLb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c8632fcbso1766812f8f.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763170009; x=1763774809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gljCO8qBTb3+vxMDJZXaimG2Gvgg53YhZHTieEq6cSg=;
        b=R4uB2QLbNb0bnrJVvwydG9Rdnha37QhFkzPznvixBZ2WZpimohDACzZeWfq/HYTYUA
         qrMNrdkPNuwWFE2bbWd87UklqF96Bqmo4XbljbsTlHDskKFjsYhczcYKax5skoY9i5gu
         w2Xw3b0TBufi+eUXr+R4y9+ab1aNuNjyVgCnk08OMnwXdoUQftcUkI7kOOasRKTJdTIq
         /URmL8tLCZZ3RJL18JFD1zplaN4bxA7W/+kfMjiUTrbQ76+pfgJRnMb4cXaYC50IiB9L
         kH8scuAkEjRgHpbyH58n3+/yuSOild4L9IJPF0fEvUvZUZLvk6r6uG0UWJar8kRHr1X/
         nBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763170009; x=1763774809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gljCO8qBTb3+vxMDJZXaimG2Gvgg53YhZHTieEq6cSg=;
        b=m2rG2rjRyFAZ7NN43Qy5s/eZ5dsC+wAeD+cgW77tidhtMMuxBuZNSd8Oi7nznfBQ5s
         HLLFm0GRxQQDixiLLJhunjn/YiC5UzNU6wN0lWfXXObZZp6JoT1M/DJ43MNULQaCefE/
         LeGT8bh8I3MqSeULYao9zt09DdORBpCszIjwflPjKTL67wkk9LHbJte+QTHJZd/JQ3F8
         InQ/0OUzFhd4uQ9NCXtgjLVhRpXPQJOV+gq2KUcJdNp0Ug1VT9XdJJ86+v6wXr+CvL2N
         vNM1nljaTNz5T46QPr5dHI3QuBdpk8jzBKEcF2QVEcYuXZ7qxHCluhVkPrHOjTG1OiJS
         yrUA==
X-Forwarded-Encrypted: i=1; AJvYcCUhSIZdOshHEVKMpDUvTrJXBlOmKUTWvCM817A5X1kJg7K3+nfpuSc7piz6BRnn4THcQj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoS7VsJtOAZxaT8hro+/kUuCgshBL6TwX4QhjVfHFbSrK+qCf
	AWvpLLHY5a3AjsvDvbbBOwHdc2QLHQLMDYt6SFJOAqF2ZC+TZS0OIAM4is9PCVhvqZlDRtomAfc
	ZFE3iIF+fT2cmX2vt22xgD+/TXhvl+cU=
X-Gm-Gg: ASbGncv2tVJ+9F0BOl0ZAKRfzMyLjHDXmY+LEcp03LNS7JlRAtHcpdBPCP/nUHK1h0K
	aFeFXAwfrrwXBpzK61kNYc4kgg7KvF/UNjbwmY0YAcAEKCD9/rYypJeHopX1FSVPh942RoPuSYc
	9sN0waVl1Z/AXkW51Nqr1+Fcwu5ncAPBelcuGGcTX77XnahtGrYwXcXyfXxmSJI9zrnHL2GRTwN
	CGQVak29KOw+mWfUCYwfGU6OgdAbCcNFo8V6RrDS51gkhHWAuzwjTJOUQaJtB26lAnULsDcSxA/
	7rgD+mHEfiT9HAuvg3rufvjoNolvTCP95TTae8pySo4laJ4j0g==
X-Google-Smtp-Source: AGHT+IFCUWCxEOGufukMH7cltQlk6RfoKM0HF060oQEqfizI5G5APwcvECs24GycnuW5BJtS4zeodCZ+FkU5ijXgqdY=
X-Received: by 2002:a05:6000:228a:b0:42b:4223:e63c with SMTP id
 ffacd0b85a97d-42b5932346amr5183991f8f.11.1763170009361; Fri, 14 Nov 2025
 17:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114111700.43292-2-puranjay@kernel.org> <5542c931e3200fd81c95abc6bbdfc1e37ca2951a9a480164558c05fe1b9044a4@mail.kernel.org>
 <mb61pms4ofyq9.fsf@kernel.org> <CAADnVQJBkRCNts86ug+B7H3kFiF4LfBGEw4acVoPyLz7350SkQ@mail.gmail.com>
 <mb61pbjl43ynu.fsf@kernel.org>
In-Reply-To: <mb61pbjl43ynu.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 17:26:36 -0800
X-Gm-Features: AWmQ_bn-OZfDKILFTXfPEKlgJPYhxttA9oD9C5iuuYyNYC_Q4PHbZN1c3bbIoi8
Message-ID: <CAADnVQL8fgreswikfBQY1nEnaVtPc9NkZKid1YDuTTHvN+Ckcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: arena: populate vm_area without
 allocating memory
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 4:52=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Nov 14, 2025 at 6:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> bot+bpf-ci@kernel.org writes:
> >>
> >> >> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> >> >> index 1074ac445..48b8ffba3 100644
> >> >> --- a/kernel/bpf/arena.c
> >> >> +++ b/kernel/bpf/arena.c
> >> >
> >> > [ ... ]
> >> >
> >> >> @@ -92,6 +93,62 @@ static long compute_pgoff(struct bpf_arena *aren=
a, long uaddr)
> >> >>      return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> >> >>  }
> >> >>
> >> >> +struct apply_range_data {
> >> >> +    struct page **pages;
> >> >> +    int i;
> >> >> +};
> >> >> +
> >> >> +static int apply_range_set_cb(pte_t *pte, unsigned long addr, void=
 *data)
> >> >> +{
> >> >> +    struct apply_range_data *d =3D data;
> >> >> +    struct page *page;
> >> >> +
> >> >> +    if (!data)
> >> >> +            return 0;
> >> >> +    /* sanity check */
> >> >> +    if (unlikely(!pte_none(ptep_get(pte))))
> >> >> +            return -EBUSY;
> >> >> +
> >> >> +    page =3D d->pages[d->i++];
> >> >> +    /* paranoia, similar to vmap_pages_pte_range() */
> >> >> +    if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
> >> >> +            return -EINVAL;
> >> >> +
> >> >> +    set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> >> >> +    return 0;
> >> >> +}
> >> >> +
> >> >> +static int apply_range_clear_cb(pte_t *pte, unsigned long addr, vo=
id *data)
> >> >> +{
> >> >> +    pte_t old_pte;
> >> >> +    struct page *page;
> >> >> +
> >> >> +    /* sanity check */
> >> >> +    old_pte =3D ptep_get(pte);
> >> >> +    if (pte_none(old_pte) || !pte_present(old_pte))
> >> >> +            return 0; /* nothing to do */
> >> >> +
> >> >> +    /* get page and free it */
> >> >> +    page =3D pte_page(old_pte);
> >> >> +    if (WARN_ON_ONCE(!page))
> >> >> +            return -EINVAL;
> >> >> +
> >> >> +    pte_clear(&init_mm, addr, pte);
> >> >> +
> >> >> +    /* ensure no stale TLB entries */
> >> >> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >> >> +
> >> >> +    __free_page(page);
> >> >> +
> >> >> +    return 0;
> >> >> +}
> >> >> +
> >> >> +static int populate_pgtable_except_pte(struct bpf_arena *arena)
> >> >> +{
> >> >> +    return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_sta=
rt(arena),
> >> >> +                               KERN_VM_SZ - GUARD_SZ, apply_range_=
set_cb, NULL);
> >> >> +}
> >> >> +
> >> >>  static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
> >> >>  {
> >> >>      struct vm_struct *kern_vm;
> >> >
> >> > [ ... ]
> >> >
> >> >> @@ -144,6 +201,11 @@ static struct bpf_map *arena_map_alloc(union b=
pf_attr *attr)
> >> >>              goto err;
> >> >>      }
> >> >>      mutex_init(&arena->lock);
> >> >> +    err =3D populate_pgtable_except_pte(arena);
> >> >> +    if (err) {
> >> >> +            bpf_map_area_free(arena);
> >> >> +            goto err;
> >> >> +    }
> >> >                      ^^^^
> >> >
> >> > Can this leak the range tree? Looking at the code, range_tree_set() =
was
> >> > called earlier in this function and can allocate range_node structur=
es
> >> > via range_tree_clear()->kmalloc_nolock(). If populate_pgtable_except=
_pte()
> >> > fails here, the error path calls bpf_map_area_free(arena) but doesn'=
t call
> >> > range_tree_destroy(&arena->rt) first. Compare with arena_map_free() =
which
> >> > always calls range_tree_destroy() before freeing the arena.
> >>
> >> As the range tree is empty at this point, we can be sure that
> >> range_tree_clear() in range_tree_set() will not allocate anything.
> >
> > range_tree_clear() won't clear anything, but AI pointed in
> > the right direction.
> > Look at what range_tree_set() does. It will allocate for sure.
>
> If I am understanding it correctly, range_tree_set() allocates memory
> using kmalloc_nolock() and it fails when this allocation fails, so in
> the error path we don't need to do anything as no allocation was successf=
ul.

Not following. Why would kmalloc_nolock() inside range tree fail?
range_tree_set() will allocate memory and above hunk
after failed populate_pgtable_except_pte() will leak it.

