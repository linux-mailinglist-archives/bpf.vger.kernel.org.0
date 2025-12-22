Return-Path: <bpf+bounces-77309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D94BCD6FE9
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B04230198A5
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75B327C0B;
	Mon, 22 Dec 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmEwmokt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464C131E49
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432315; cv=none; b=cfSH2ycN6rmn9srlpaxU7gwwWuE1mFmFs9bWmdTsRPySCyO0cbNDKYGW6cWS9gw9Ioz/H3iOR1PHzjryQJvxv0ezUAHQptqOSlwEMIhAHp5iMItVTfa2rQNKruRD40qgOo3ITnFkpU/doxfrYTGtEDj507YurCH62NJwid3P1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432315; c=relaxed/simple;
	bh=FnOBjZteG6PrhJCGR+DNNfq0AS5q4KTRVMliGnEQ2Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVDRUtgT/PvqhBungT9PiodSoofr7z2Ocm10pFZbcYuBP83e/E5jyUd5oHZMHYqwB5nFEr0O+u2946RBUhlihq9PIcIZynE65BrOZAaiEL/kmgNQJWXDEku0STdndmpvyBo0GJADFZiwW39LXbHaYr3oqVBiHXz3wuXPJrzTwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmEwmokt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A613EC19421
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766432314;
	bh=FnOBjZteG6PrhJCGR+DNNfq0AS5q4KTRVMliGnEQ2Bk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DmEwmoktRwjYnC/5bMSEgec/kh+P5WSvCbGI2C6U88E3xnJrvDWlpQT3+PhgZBgKo
	 ua2PGUa6IV09yUaz9JhfMEOUuvtMIWm50fpaaZ8+zJCJmM1oDNRHXktxJ6U4oP6EPC
	 O6F3G7weL/Amg+Aavddq/Pn2Cmh6AdPP27VsmbWpOwniZKX3+vfD4oleI5auR1pWeb
	 LraD0RUuTO1hd/XyWLPH0FQo+Op0VuFxtAJ412c7ukJYkyd4GTuP/ZxyA1xNuROPR/
	 tVyTFG+qseu1JoYReh4ExwUSfrG7GpJ1TuzY3aIN1ow40dB6x+nH0ULppCktP/K+km
	 lwl+0IrJl+/uA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so4556794a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 11:38:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yxshx8s6pIkuSAMXFtIarZrk6h92aO/dLLVnduvnf8H+yE3bKzs
	lAOzDHoczYjeWYg47GFw5L7fARP7QfaUln3k0W20xpGU3g9/QGFLwwtDszjFxAetv2QB2M+J/6r
	K3ICaWz4kUh4LdzlG6CmOOGVnTgKQIVE=
X-Google-Smtp-Source: AGHT+IF9xERG+rj5BlLYRbMhNthyVUYr7MQppu/Mnuj1+nxjS+zM5YlG25FpPGe1zs+39ZytX2eRC49spRtT1aJ7D7E=
X-Received: by 2002:a17:907:7f15:b0:b6d:4df9:68bc with SMTP id
 a640c23a62f3a-b8036ebbbe8mr1128757666b.1.1766432313195; Mon, 22 Dec 2025
 11:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222190815.4112944-4-puranjay@kernel.org> <dc0a81fe1debcd43ec9bdb440695bdf6d443a02080229dc1a2b60fa0eed00d18@mail.kernel.org>
In-Reply-To: <dc0a81fe1debcd43ec9bdb440695bdf6d443a02080229dc1a2b60fa0eed00d18@mail.kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Mon, 22 Dec 2025 19:38:19 +0000
X-Gmail-Original-Message-ID: <CANk7y0jWWOZt4uRoLbRc+BJBOhxu+p-vJispG6R6fHu09ibgLg@mail.gmail.com>
X-Gm-Features: AQt7F2oqyCU2iAnYM_JrvHvQRzA0sVwwXT2cIJBjZwS6mY2kAH3FTJyV-_F_iic
Message-ID: <CANk7y0jWWOZt4uRoLbRc+BJBOhxu+p-vJispG6R6fHu09ibgLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/4] bpf: arena: make arena kfuncs any context safe
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 7:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 128efb68d47b..55d1e15725c7 100644
>
> [ ... ]
>
> > +static void arena_free_worker(struct work_struct *work)
> > +{
> > +     struct bpf_arena *arena =3D container_of(work, struct bpf_arena, =
free_work);
> > +     struct llist_node *list, *pos, *t;
> > +     struct arena_free_span *s;
> > +     u64 arena_vm_start, user_vm_start;
> > +     struct llist_head free_pages;
> > +     struct page *page;
> > +     unsigned long full_uaddr;
> > +     long kaddr, page_cnt, pgoff;
> > +     unsigned long flags;
> > +
> > +     if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
> > +             schedule_work(work);
> > +             return;
> > +     }
> > +
> > +     init_llist_head(&free_pages);
> > +     arena_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> > +     user_vm_start =3D bpf_arena_get_user_vm_start(arena);
> > +
> > +     list =3D llist_del_all(&arena->free_spans);
> > +     llist_for_each(pos, list) {
> > +             s =3D llist_entry(pos, struct arena_free_span, node);
> > +             page_cnt =3D s->page_cnt;
> > +             kaddr =3D arena_vm_start + s->uaddr;
> > +             pgoff =3D compute_pgoff(arena, s->uaddr);
> > +
> > +             /* clear ptes and collect pages in free_pages llist */
> > +             apply_to_existing_page_range(&init_mm, kaddr, page_cnt <<=
 PAGE_SHIFT,
> > +                                          apply_range_clear_cb, &free_=
pages);
> > +
> > +             range_tree_set(&arena->rt, pgoff, page_cnt);
> > +     }
> > +     raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> > +
> > +     /* Iterate the list again without holding spinlock to do the tlb =
flush and zap_pages */
> > +     llist_for_each_safe(pos, t, list) {
> > +             s =3D llist_entry(pos, struct arena_free_span, node);
> > +             page_cnt =3D s->page_cnt;
> > +             full_uaddr =3D user_vm_start + s->uaddr;
>                           ^^^^^^^^^^^^^^^^^^^^^^^
>
> Is there a missing clear_lo32() call here? In arena_free_pages() the
> sleepable path computes full_uaddr as:
>
>     full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
>
> But arena_free_worker() computes it as:
>
>     full_uaddr =3D user_vm_start + s->uaddr;
>
> Since s->uaddr is already the lower 32 bits (set from masked uaddr in
> arena_free_pages()), and user_vm_start includes its own lower 32 bits,
> this appears to produce the wrong address. For example, if user_vm_start
> is 0x7f7d26200000 and s->uaddr is 0x26200000, this would give
> 0x7f7d4c400000 instead of the correct 0x7f7d26200000.
>
> Should this be:
>
>     full_uaddr =3D clear_lo32(user_vm_start) + s->uaddr;
>
> to match the sleepable path?

I will send v8 with this change now.

>
> > +             kaddr =3D arena_vm_start + s->uaddr;
> > +
> > +             /* ensure no stale TLB entries */
> > +             flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SI=
ZE));
> > +
> > +             /* remove pages from user vmas */
> > +             zap_pages(arena, full_uaddr, page_cnt);
> > +
> > +             kfree_nolock(s);
> > +     }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/204415=
98118

