Return-Path: <bpf+bounces-74250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E437C4F533
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED7318C0321
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AF3A1CE3;
	Tue, 11 Nov 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEru0FzX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186A337BBD
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883612; cv=none; b=felMnM5FERO44gAgA426FmVnHXLkNiLHKOxoTcaz+yF7lX4oiWtblRHsTv7+GeJBcaYjLRt/8JP2gjcPlLM82Ku9Cn3zeoZXAty9yBlxyb7l0m1poDsWGu4TRqvH6gvtVM1z0AndNedb9rluFgVGxM57VMuPyAxFjfgoleyPep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883612; c=relaxed/simple;
	bh=FVQx++BQXZJKMwOtwm3dS6FzN7rxTHYHZUn8b8xdPAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnbdJSbeay4v0IYUiSiCpHgfSz2+BKS3FWkYwILciXxeQZnpseM9FcqDbZE18wIcEUZDHZptOllJF8bOaicSaYemjV93vk6d37XJRRwCdPqMMGus1NQKp0dBrlZL8SmDJEDxnjr5J8H3IK+veCFpST/3yy5iepjfnjAgCFaWvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEru0FzX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so144565e9.0
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762883608; x=1763488408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+uGPPchnFvDjvsncrb+teqk+s3tpDbWahBCT1IY1pM=;
        b=WEru0FzXrmlNYxBRfbk3mhFOVbEoNgjahDWOCcXpSc+Q7cZEPRc14nOS71TygTJi8F
         lckbRbX1V6CObjDwhH2QPqMS6eJh8DKpJMgINmcwp8oV+QCLRqsktHedSoui7H/FYYwX
         Ti3sQVK8APVmj5tegKRRZ9q3cinbT3rEYaufuWMefdhoi5U99ksQpbXFplC0kinM61QD
         42cIlaHVQILLNx0vaKHXHagVeHr+ziTl0sFkF4u6ltgJ3tY+1V8TRdDBA8+g8UVoQDk7
         YwDzGZYaRrOX6byazsLmHRv8liUgF3PcLQl3y5BamPqbHCFNdkbm1RWC9byTAmB60yGq
         6z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883608; x=1763488408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+uGPPchnFvDjvsncrb+teqk+s3tpDbWahBCT1IY1pM=;
        b=eTJF8fy80JMmdl8bU2uVQQwaUmpUJDh6X8gSmKbnPTVAu88sE2+ByTN/SiRpIXfmGN
         JIqvT8CVMRPyQhBDBNk+YdMpcHkbsC2+rruf2p8uSlJVfs/U1O91TCZZksIL2ElE3fVP
         pJIFE+kzmublkhUx9GkdFD/dRbel4/ygHT7lgpEfVbkTVjGyElz6kUFS4VCviOIX3+dl
         sFYkGoI16T4Et1b0mlefy1k4NPAv4sv0aDngxDIdEtq7YptAqVNdnLJtvNpUNy99PIfg
         PCQ3x/CLRZ8ekwzjhLfvZL7ZXWXaA38nafe7I2DOgvlHtY5dK3sqY2RR8PZjjJpW73RK
         gVfg==
X-Forwarded-Encrypted: i=1; AJvYcCUj9Xbq5+lFuprIAGBNXhLZAgxkbXit+hcA8lGwdlnBNTdBgJIZOUT1k6n7nAB7DoryUxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRFx6xdbweSOVLgPv6ONxyoP6uV3OCBMUmczEEQ95MCSGQBRH
	gC3YMXUV3PS6qeCpG3DJHoDJZjspM2V3aWoD0oSPFhCZZsVd1BVZdCjc2dvgAfAYlZMaxFaz2/E
	t6HF8HNuBlWOwmAYXV3aXvcaMC6sJDw4=
X-Gm-Gg: ASbGncs0fCR5KFupB9X5/FaXqbAo8RKW86zY3f/0YAe6R38xAd11p0FDZjSdu2zLEN0
	jSQ8IRuKzwMKxsfwjCVGO22DvZsT/ElO/rxs7u7Emq9LvnoxtQ/IQC77ZzNDLYhIUdnrxwIWeNS
	VObenkntdAZWhDg+WS4YV8A3QdMCNfDuAlyAvByy0lLlUVa8FuN6aDbgpgdFLx1HYhPy7GQrRyt
	z4VtUB+pq3eK6bTYvM9jkXZCcxeGisiztSfxGIXVGuTHTkyFpQiNnNpfB3bn2/5evy4bPvifsjY
	q7uJdgNqh6ufkxkz2+MJMA==
X-Google-Smtp-Source: AGHT+IG8zR98gG7/MTtX7554gJcZKTanfWbnepJNUt/9XWjSbITUXGUR68/Agzw5U/R2gGTFIlOi8gF0I3L4gYqjLh4=
X-Received: by 2002:a05:600c:b99:b0:477:7af8:c893 with SMTP id
 5b1f17b1804b1-47787046a82mr2837335e9.15.1762883608493; Tue, 11 Nov 2025
 09:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111163424.16471-4-puranjay@kernel.org> <868fe984f4c96d9fa12fb5aedeec6acdcb97339f9ba59e7900761dfed697e65e@mail.kernel.org>
In-Reply-To: <868fe984f4c96d9fa12fb5aedeec6acdcb97339f9ba59e7900761dfed697e65e@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Nov 2025 09:53:15 -0800
X-Gm-Features: AWmQ_bnDTUo2zX-olrafR2PrEJl3cnkNAOI9YZRV4fIi9aaB3I2xjpQ_Q8sXpNY
Message-ID: <CAADnVQ+uJN4z_j4RbnVS0BFATxCv_VZsFnH8k7tnS_-gMh=Rkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: arena: make arena kfuncs any context safe
To: bot+bpf-ci@kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 9:01=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 09d5dc541..527921269 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
>
> [ ... ]
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 9d8a8eb44..f330b51de 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
> > @@ -327,12 +351,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault =
*vmf)
> >       struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> >       struct page *page;
> >       long kbase, kaddr;
> > +     unsigned long flags;
> >       int ret;
> >
> >       kbase =3D bpf_arena_get_kern_vm_start(arena);
> >       kaddr =3D kbase + (u32)(vmf->address);
> >
> > -     guard(mutex)(&arena->lock);
> > +     if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> > +             /*
> > +              * This is an impossible case and would only trigger if r=
es_spin_lock is buggy or
> > +              * due to another kernel bug.
> > +              */
> > +             return VM_FAULT_RETRY;
> > +
> >       page =3D vmalloc_to_page((void *)kaddr);
> >       if (page)
> >               /* already have a page vmap-ed */
> > @@ -344,26 +375,30 @@ static vm_fault_t arena_vm_fault(struct vm_fault =
*vmf)
> >
> >       ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> >       if (ret)
> > -             return VM_FAULT_SIGSEGV;
> > +             goto out_unlock_sigsegv;
> >
> >       struct apply_range_data data =3D { .pages =3D &page, .i =3D 0 };
> >       /* Account into memcg of the process that created bpf_arena */
> >       ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
> >       if (ret) {
> >               range_tree_set(&arena->rt, vmf->pgoff, 1);
> > -             return VM_FAULT_SIGSEGV;
> > +             goto out_unlock_sigsegv;
> >       }
> >
> >       ret =3D apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_ran=
ge_set_cb, &data);
> >       if (ret) {
> >               range_tree_set(&arena->rt, vmf->pgoff, 1);
> > -             __free_page(page);
> > -             return VM_FAULT_SIGSEGV;
> > +             free_pages_nolock(page, 0);
> > +             goto out_unlock_sigsegv;
> >       }
> >  out:
> > +     raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> >       page_ref_add(page, 1);
> >       vmf->page =3D page;
> >       return 0;
> > +out_unlock_sigsegv:
> > +     raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> > +     return VM_FAULT_SIGSEGV;
> >  }
>
> Can the page reference race with arena_free_pages()? The sequence:
>
>   Thread A (arena_vm_fault):
>     bpf_map_alloc_pages() -> page refcount=3D1
>     apply_to_page_range() -> maps PTE
>     raw_res_spin_unlock_irqrestore()
>     page_ref_add(page, 1) -> tries to increment to 2
>
>   Thread B (arena_free_pages):
>     raw_res_spin_lock_irqsave()
>     apply_to_existing_page_range()->apply_range_clear_cb() -> clears PTE
>     raw_res_spin_unlock_irqrestore()
>     __free_page(page) -> refcount 1->0, page freed
>
> Between Thread A's unlock and page_ref_add(), Thread B can acquire the
> lock, clear the PTE, and free the page. Then Thread A's page_ref_add()
> operates on freed memory.
>
> Should page_ref_add() happen before releasing the spinlock,

AI has a point. page_ref should be under lock.

