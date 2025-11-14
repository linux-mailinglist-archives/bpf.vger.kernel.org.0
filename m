Return-Path: <bpf+bounces-74571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24BC5F58F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83D3635C90D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B4D355059;
	Fri, 14 Nov 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/p6rwAY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18A35502E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155314; cv=none; b=u/2Kbcfy0TC/30PMgGG99mG1+rNQUilim8jSTj+05gl7bVw3ioNscOShkrDtG9B1qWWIA45xqRS6bgr4LFt5xmIn0d9Ek6kyIw0SBtdNc2OQpI5Sfn8jj5ceEW8dYc/WNpZn9ADDNwso88bAfshygZ2J5/yMN8oUA2OG2nxBa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155314; c=relaxed/simple;
	bh=Wfp3R2hr+GhAmXxRPmIFEaPq6zfpnwt0LdD4pWlQAvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iha4HniFMQPdViYQoCF7Gsj3tdpzSSfIbo2TW7wRp9gWf0lXiC9flsChW3K2gRcrJ7/7mkTLQ41CnDEt0Z29onI+VO1so52QZSDcKyId8VQs7i35HHbbbMtBmcrsTtBCm5OCRc59XfeSqPOQTQ17Wfc5qPqEixik8oIBUbm8afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/p6rwAY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47778b23f64so17886145e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763155310; x=1763760110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7l1GWV5jM0o0XZ6Mxqc9Hrka64QAUMd9dk8g1NBdjk=;
        b=J/p6rwAYZfwWvrQFRooZo0yUXAt9ylAux42ujfroOKuYSgp0V853KuUqxeiotOA28x
         81uZyf2gdaqgpejNPoH0wjwXoGbGqURQQcGefvZRY3JKKN1b/vvS91y4K05OPH7DFuH7
         Il/FYtZDBju6zIJddrVuRk3k28y5FjcPCTDM2K5cZ1TEjdRRX8l6L6HZ3CnjfjHmlyl4
         ZgQ/NomkikIFhJ0LiFUo9EBxBaMLcZSi6lv5qt2Lb+xxFmWpKfUmzqEmsMoiSukljvgK
         1oEqPxYCkTaBnQIcOhApblwzvcIQb8vHJZCxtaMUqJ/MIF0L2zqkZH54uXEQES4rKpAQ
         KRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763155310; x=1763760110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7l1GWV5jM0o0XZ6Mxqc9Hrka64QAUMd9dk8g1NBdjk=;
        b=iZzN1sHX9L0lcJZYDsd4KDJA+ZH7j1bTzGRcy50/BfgSfJjh79XHLnQ2JqRq4GuJMK
         1yXmkTjHOPL8p0/94y3dgSyjPq8E+kh9jVPTxwfufJfjEXSdKY87/vGcIemcTVdu2VOF
         7bqlZxMl1AcwSyfxuvYf6AJzlTNrY1dOWol7hbA2/33ZlNe4MtOZiLwLqzKeZu9wIsWK
         HQSLhOA33huojnK/IpsUw8YyIKy6VNXMG0cysKJ0wFZKrUSg1JsZyZvmQyRAH69qGiJg
         1SmhemUtPmSUxlXUE/zNMmNDltsWgPEtLl1DPD6Sygi4G9YhqOb8TmQB947pJa6XXl4/
         8L0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBx0qsNvmJ1JZeC7J8VK/8NFxBqyV9wet3pcCQpMsG1RCpSV1jQXkCHtMpKpSoIgtxmM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8UhXnJOyK0M3fqcixmNn91N6KKnIKrJyFsNCLTyj83+EDS/B
	LtskqQGtbMLA0U0PAleAlwIXM4xlWAQC/hc9dDTpGyUvyC4Leu7ArObCbgZW0eK+WhshMgjrQcM
	5x9wtR2ijGv0UocVTXGHRMFYffVg5vrw=
X-Gm-Gg: ASbGncuLqE8YvhamaXAb7BC6M0rI2m3POZsaG60a+1e9eTZY1Dk4y3YRqMkdmQ68uun
	qJJeCpwDREyAwO/LmPevN+g7MAFAEgpWaXbXfD0Z0Asc/2jF7wUnc2dHkMmgyoVu5Nqupe516I+
	kWeGkDyCzc0UXIvjLW1dbNxUA0VvgG7Ls79+kqPJ1sYvsqP4ONb4oHGyhO+4SD1+nu0GW5TfUn5
	N6Sa80z1XgV+JOYSbrWkN/FNZ0+9MSa6QvtZpX+qIzEa6Vd0a6MSXxtA4VX4nfftxyJl/Wp9Yx6
	uN4nI77ztG4BHM4iweeV1lantNO/
X-Google-Smtp-Source: AGHT+IFifipYZkU+q6CoXl4AjALxtL5Nul+3Wb6oFNd5hYdmhpRi+uPeeLQohG6fOMqVQPzw2FsqeO2Ham2YLr9D/5M=
X-Received: by 2002:a05:600c:4594:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-4778fe9b281mr44396055e9.23.1763155310185; Fri, 14 Nov 2025
 13:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114111700.43292-2-puranjay@kernel.org> <5542c931e3200fd81c95abc6bbdfc1e37ca2951a9a480164558c05fe1b9044a4@mail.kernel.org>
 <mb61pms4ofyq9.fsf@kernel.org>
In-Reply-To: <mb61pms4ofyq9.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 13:21:39 -0800
X-Gm-Features: AWmQ_bmCn3DD9tuc1kXXTriovMR9VUhF-2788rTS2RGfFvGVBCXINyGD4pVy1LU
Message-ID: <CAADnVQJBkRCNts86ug+B7H3kFiF4LfBGEw4acVoPyLz7350SkQ@mail.gmail.com>
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

On Fri, Nov 14, 2025 at 6:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bot+bpf-ci@kernel.org writes:
>
> >> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> >> index 1074ac445..48b8ffba3 100644
> >> --- a/kernel/bpf/arena.c
> >> +++ b/kernel/bpf/arena.c
> >
> > [ ... ]
> >
> >> @@ -92,6 +93,62 @@ static long compute_pgoff(struct bpf_arena *arena, =
long uaddr)
> >>      return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> >>  }
> >>
> >> +struct apply_range_data {
> >> +    struct page **pages;
> >> +    int i;
> >> +};
> >> +
> >> +static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *d=
ata)
> >> +{
> >> +    struct apply_range_data *d =3D data;
> >> +    struct page *page;
> >> +
> >> +    if (!data)
> >> +            return 0;
> >> +    /* sanity check */
> >> +    if (unlikely(!pte_none(ptep_get(pte))))
> >> +            return -EBUSY;
> >> +
> >> +    page =3D d->pages[d->i++];
> >> +    /* paranoia, similar to vmap_pages_pte_range() */
> >> +    if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
> >> +            return -EINVAL;
> >> +
> >> +    set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> >> +    return 0;
> >> +}
> >> +
> >> +static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void =
*data)
> >> +{
> >> +    pte_t old_pte;
> >> +    struct page *page;
> >> +
> >> +    /* sanity check */
> >> +    old_pte =3D ptep_get(pte);
> >> +    if (pte_none(old_pte) || !pte_present(old_pte))
> >> +            return 0; /* nothing to do */
> >> +
> >> +    /* get page and free it */
> >> +    page =3D pte_page(old_pte);
> >> +    if (WARN_ON_ONCE(!page))
> >> +            return -EINVAL;
> >> +
> >> +    pte_clear(&init_mm, addr, pte);
> >> +
> >> +    /* ensure no stale TLB entries */
> >> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >> +
> >> +    __free_page(page);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int populate_pgtable_except_pte(struct bpf_arena *arena)
> >> +{
> >> +    return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start(=
arena),
> >> +                               KERN_VM_SZ - GUARD_SZ, apply_range_set=
_cb, NULL);
> >> +}
> >> +
> >>  static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
> >>  {
> >>      struct vm_struct *kern_vm;
> >
> > [ ... ]
> >
> >> @@ -144,6 +201,11 @@ static struct bpf_map *arena_map_alloc(union bpf_=
attr *attr)
> >>              goto err;
> >>      }
> >>      mutex_init(&arena->lock);
> >> +    err =3D populate_pgtable_except_pte(arena);
> >> +    if (err) {
> >> +            bpf_map_area_free(arena);
> >> +            goto err;
> >> +    }
> >                      ^^^^
> >
> > Can this leak the range tree? Looking at the code, range_tree_set() was
> > called earlier in this function and can allocate range_node structures
> > via range_tree_clear()->kmalloc_nolock(). If populate_pgtable_except_pt=
e()
> > fails here, the error path calls bpf_map_area_free(arena) but doesn't c=
all
> > range_tree_destroy(&arena->rt) first. Compare with arena_map_free() whi=
ch
> > always calls range_tree_destroy() before freeing the arena.
>
> As the range tree is empty at this point, we can be sure that
> range_tree_clear() in range_tree_set() will not allocate anything.

range_tree_clear() won't clear anything, but AI pointed in
the right direction.
Look at what range_tree_set() does. It will allocate for sure.

pw-bot: cr

