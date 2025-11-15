Return-Path: <bpf+bounces-74601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F5C5FC73
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0E5F35CF82
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B735965;
	Sat, 15 Nov 2025 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm9LyOmX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B911799F
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763167945; cv=none; b=pUs/H+Kdv33COpOXZczn+IK4NQYBvZeGRi0ZvoGF3WA5WkG64HsOgU7NUC/d7h6YbmmbvlxWXu723zWwVRVnHUNL76W2ssVb7o5c9pedtoipg3YGlbfObLxefH9UIEyn7xY13IMd/khmnv/IyG9qGvf0uo1avNs239KQwcr7mn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763167945; c=relaxed/simple;
	bh=C0FFA8dvNmk1WfKMCK4qwUaU0BT0LQLsG/v+b+AWARw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F659QYPjNyp0uDzybXuRgzir4iP67/Fnk+FMhtTiPBP88IG6vjlQ9AZlRH/8W56igkCsMUwFj8aPizCNzGxojprhg5CLvwW0vboywIGngH1QwmIwI+v9aMSe9TSAcltKTEFeYkUSqhqQlEPaSxyq80kiBN/vNeoLthwT6InSMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm9LyOmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40079C4CEF5;
	Sat, 15 Nov 2025 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763167945;
	bh=C0FFA8dvNmk1WfKMCK4qwUaU0BT0LQLsG/v+b+AWARw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cm9LyOmX0eFuAAuWX6N3IF4MrBV1kBu8myR0zgboDq9m6LrYopFNtCcFxUIj2t3s8
	 mz1pxLRpCKWxQsOAG2eUFVBbMcZLU4cZJ6uGII2DdL2vgrg+l1uZZTh+AoxsG4+pdq
	 XeOII0PvqqormXuF/BL5/U/g/T6rWciv/Geeu3OxvJ9HC9aga7MO+CqEJtMm672QUf
	 UBT8fjxeRNOjh3ntAJbNdOv1OubFr3MrXz7wK6TogzVYpErKmcOsM4n/FGr7MNfHgX
	 gXI4Fyka8OVx5c6Jcg1d/gLigzZTrDg3nVP/Mk67Mkv/BsdeJTWpZzx+t3BfhYIKrI
	 YayGNNBwzyIXQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@meta.com>, Yonghong Song <yonghong.song@linux.dev>,
 Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: arena: populate vm_area without
 allocating memory
In-Reply-To: <CAADnVQJBkRCNts86ug+B7H3kFiF4LfBGEw4acVoPyLz7350SkQ@mail.gmail.com>
References: <20251114111700.43292-2-puranjay@kernel.org>
 <5542c931e3200fd81c95abc6bbdfc1e37ca2951a9a480164558c05fe1b9044a4@mail.kernel.org>
 <mb61pms4ofyq9.fsf@kernel.org>
 <CAADnVQJBkRCNts86ug+B7H3kFiF4LfBGEw4acVoPyLz7350SkQ@mail.gmail.com>
Date: Sat, 15 Nov 2025 00:52:21 +0000
Message-ID: <mb61pbjl43ynu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Nov 14, 2025 at 6:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> bot+bpf-ci@kernel.org writes:
>>
>> >> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> >> index 1074ac445..48b8ffba3 100644
>> >> --- a/kernel/bpf/arena.c
>> >> +++ b/kernel/bpf/arena.c
>> >
>> > [ ... ]
>> >
>> >> @@ -92,6 +93,62 @@ static long compute_pgoff(struct bpf_arena *arena,=
 long uaddr)
>> >>      return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
>> >>  }
>> >>
>> >> +struct apply_range_data {
>> >> +    struct page **pages;
>> >> +    int i;
>> >> +};
>> >> +
>> >> +static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *=
data)
>> >> +{
>> >> +    struct apply_range_data *d =3D data;
>> >> +    struct page *page;
>> >> +
>> >> +    if (!data)
>> >> +            return 0;
>> >> +    /* sanity check */
>> >> +    if (unlikely(!pte_none(ptep_get(pte))))
>> >> +            return -EBUSY;
>> >> +
>> >> +    page =3D d->pages[d->i++];
>> >> +    /* paranoia, similar to vmap_pages_pte_range() */
>> >> +    if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
>> >> +            return -EINVAL;
>> >> +
>> >> +    set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
>> >> +    return 0;
>> >> +}
>> >> +
>> >> +static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void=
 *data)
>> >> +{
>> >> +    pte_t old_pte;
>> >> +    struct page *page;
>> >> +
>> >> +    /* sanity check */
>> >> +    old_pte =3D ptep_get(pte);
>> >> +    if (pte_none(old_pte) || !pte_present(old_pte))
>> >> +            return 0; /* nothing to do */
>> >> +
>> >> +    /* get page and free it */
>> >> +    page =3D pte_page(old_pte);
>> >> +    if (WARN_ON_ONCE(!page))
>> >> +            return -EINVAL;
>> >> +
>> >> +    pte_clear(&init_mm, addr, pte);
>> >> +
>> >> +    /* ensure no stale TLB entries */
>> >> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> >> +
>> >> +    __free_page(page);
>> >> +
>> >> +    return 0;
>> >> +}
>> >> +
>> >> +static int populate_pgtable_except_pte(struct bpf_arena *arena)
>> >> +{
>> >> +    return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start=
(arena),
>> >> +                               KERN_VM_SZ - GUARD_SZ, apply_range_se=
t_cb, NULL);
>> >> +}
>> >> +
>> >>  static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>> >>  {
>> >>      struct vm_struct *kern_vm;
>> >
>> > [ ... ]
>> >
>> >> @@ -144,6 +201,11 @@ static struct bpf_map *arena_map_alloc(union bpf=
_attr *attr)
>> >>              goto err;
>> >>      }
>> >>      mutex_init(&arena->lock);
>> >> +    err =3D populate_pgtable_except_pte(arena);
>> >> +    if (err) {
>> >> +            bpf_map_area_free(arena);
>> >> +            goto err;
>> >> +    }
>> >                      ^^^^
>> >
>> > Can this leak the range tree? Looking at the code, range_tree_set() was
>> > called earlier in this function and can allocate range_node structures
>> > via range_tree_clear()->kmalloc_nolock(). If populate_pgtable_except_p=
te()
>> > fails here, the error path calls bpf_map_area_free(arena) but doesn't =
call
>> > range_tree_destroy(&arena->rt) first. Compare with arena_map_free() wh=
ich
>> > always calls range_tree_destroy() before freeing the arena.
>>
>> As the range tree is empty at this point, we can be sure that
>> range_tree_clear() in range_tree_set() will not allocate anything.
>
> range_tree_clear() won't clear anything, but AI pointed in
> the right direction.
> Look at what range_tree_set() does. It will allocate for sure.

If I am understanding it correctly, range_tree_set() allocates memory
using kmalloc_nolock() and it fails when this allocation fails, so in
the error path we don't need to do anything as no allocation was successful.

