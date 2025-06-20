Return-Path: <bpf+bounces-61205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60DAE22AA
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 21:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B1D3AC0BC
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371C26E708;
	Fri, 20 Jun 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxZtkCea"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D81CBEB9
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446417; cv=none; b=OU88xgTqAMgQbLnfZCBls1SPwtHpf1YiVNT+sggFegi6XcahWDqyPquZ8tpjO13JR/9lFvUPWrClAl0smQYC4qMcC77DdGgqhqGyb11B4GPPAZvaGLeBhKPHq0puNfZDtHf9iAKbxAD/CWQxYdrvU936tV+h2y5WZumFWhOugLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446417; c=relaxed/simple;
	bh=zaBJdsPalF5VgJrNe2ryodgdQ+HU/CzP6oEe7s2NVR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gP/BUpGuJy8w530pvctcRy96p7dgL2GJV42ollQI1hEQqJW12kUk8u0pkrw2YEarStmjQ4q8GPVl20j6hUXKoC7CnoWgJsUY9bpb+BcI811CXeGRR9mKCR8LekuLVCvyj5zmwtvnBA6D3w+fHyVJ6RzfNLNiu18Yst6gezZ7dOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxZtkCea; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad93ff9f714so382332166b.2
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446414; x=1751051214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksPONgyWm3u8yBnp4wRNl8j8XqhGsAgRGxD0zA9GwT8=;
        b=kxZtkCeaMYXsVafR5P2WHn2/d8dgX82feGaZztsSQg3DuA0cDzwSVWZV0J3CDV0lyf
         zO8rvqGMjjZVmYVr9LeGflakahb8gJe0oGmRpIt5pkb5xWCw6KsMTT1wsoF6U6NLNSUl
         Brvew5KqeIOuParjIPWNDwXY9KGGvevka2OYoZpoRH6DBemjAnWBkiGmF8pG/2qb/3VZ
         HOPxm8Nf4spj7/Xk2u8rgByc0MCkxZhpnairBmVkJwLJ2eecYjECZPYaBKTmA1ZvYI56
         zo+i0qOQw4Log41YRbUC+RvnNJAolifkQ6n2RIg9Q2yfN6XhBkjT/M7pyq/oEA5JePNZ
         nylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446414; x=1751051214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksPONgyWm3u8yBnp4wRNl8j8XqhGsAgRGxD0zA9GwT8=;
        b=mfG6yGCdsgOi9kotsY70I9TXudynYb9aYHgvPIVStMFQzOew2vPNng2epYbPbW8p6H
         1sYUVxA0yz89OUPcM3BuKlZECOl80ernFM7VR/C6c3VX/Han/p6+Ki3Qapis7eu1LvSM
         K98kEm9C3bQwteT24jI8zrf+pjMK9dczllePW28EgLhK6Ge1xX5/KznyLYbhd1kYO4UV
         GE415ZKW5H4dVOqwF2g4WxdwuAgz5QZSohWGAE3R7i73m4oliYmYrNijdYq6QdwXlxD2
         erosKHgRNiJltsgV1uRhm2RcFFG3SFBPnjdzYbFZfbIf+SKJ5gfuvvupT4MrccHFFxcx
         atdw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2SchlikR9g4+Xj9gxThFi5mAqgLRyoWiJmJju4OgL30wxCNmbXEBcMDNlZOw8w/KI1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFC2nSuZhxvmNql6Udm/uUyagBkiVcNyqUTzeQL5Yq2eAz+/QG
	awd+jjbZ1JUAvvp1A/FUjHOSKFKIiO69dm+iBVkQG9YPsUfflbrQ3GNXCr6XhwQh23oGsxuCXWP
	0oNndyow5S8Pec7KyRJqncngNaRDylFg=
X-Gm-Gg: ASbGncsWdraNaD+/wG7g3DMutQBcIjd2oWnxabt7mjID3DBtGN6gF6Q35MTs6SayPsz
	q0row1gFp4OHO4XkKQ3andalks3GCAF1nIUQhrvfT3dShOIoBpTmcWR6byZ5jHqw7+WzWaSjKrW
	HKGZlH1xGIu+j5cWzNlgYdLCYO/LFwNrzuX2Z7znHm21ep5qE8GSj65hY=
X-Google-Smtp-Source: AGHT+IElLHePzR4nkLZCNTHBNjUGie9d2bdgKonlzrSAAze44lKV0Rh2D2DXfUaUHb1xkiSQ8aWljC1/YH0RHwHDc3o=
X-Received: by 2002:a17:907:6d17:b0:ae0:13e5:1883 with SMTP id
 a640c23a62f3a-ae057b89b6bmr382815066b.40.1750446414055; Fri, 20 Jun 2025
 12:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620031118.245601-1-emil@etsalapatis.com> <20250620031118.245601-2-emil@etsalapatis.com>
 <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
 <CAP01T74rJKXqG5QHV=rXsou33_vfTp7vBZxHC5Qo2G_Vv3V9Dg@mail.gmail.com> <CAADnVQ+PKxryg_d5=G_txq8N5oZ618pW1NN7XFwXnKLZECNxGg@mail.gmail.com>
In-Reply-To: <CAADnVQ+PKxryg_d5=G_txq8N5oZ618pW1NN7XFwXnKLZECNxGg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 20 Jun 2025 21:06:16 +0200
X-Gm-Features: Ac12FXzasMRAL2XENEh8IHP_AUel50X6vLyyRRhHGUVqFcs8cYaOYzJ5RMhcbQ4
Message-ID: <CAP01T76bZTCSKd-CC4Fge+5OAxJBSkaf9ZWNCzsJo3UvEigEfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jun 2025 at 20:57, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 20, 2025 at 11:52=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 20 Jun 2025 at 20:44, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jun 19, 2025 at 8:11=E2=80=AFPM Emil Tsalapatis <emil@etsalap=
atis.com> wrote:
> > > >
> > > > Add a new BPF arena kfunc from protecting a range of pages. These p=
ages
> > > > cannot be allocated, either explicitly through bpf_arena_alloc_page=
s()
> > > > or implicitly through userspace page faults.
> > > >
> > > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > > ---
> > > >  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 92 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > > index 0d56cea71602..2f9293eb7151 100644
> > > > --- a/kernel/bpf/arena.c
> > > > +++ b/kernel/bpf/arena.c
> > > > @@ -48,6 +48,7 @@ struct bpf_arena {
> > > >         u64 user_vm_end;
> > > >         struct vm_struct *kern_vm;
> > > >         struct range_tree rt;
> > > > +       struct range_tree rt_guard;
> > >
> > > ...
> > >
> > > >  }
> > > > @@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm_fau=
lt *vmf)
> > > >                 /* User space requested to segfault when page is no=
t allocated by bpf prog */
> > > >                 return VM_FAULT_SIGSEGV;
> > > >
> > > > +       /* Make sure the page is not guarded. */
> > > > +       ret =3D is_range_tree_set(&arena->rt_guard, vmf->pgoff, 1);
> > > > +       if (ret)
> > > > +               return VM_FAULT_SIGSEGV;
> > > > +
> > > >         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> > >
> > > Why complicate things with another tree ?
> > > The logic has to range_tree_clear(&arena->rt, ... anyway
> > > and here check:
> > > is_range_tree_set(&arena->rt, ...
> > >
> > > bpf_arena_guard_pages() won't have EALREADY errors, so be it.
> > > Keeping another range_tree and spending kernel memory
> > > just to produce an error to buggy bpf prog is imo wrong trade off.
> >
> > IIUC the main requirement is reserving a region that cannot be faulted
> > in user space, and cannot be allocated from the BPF side.
> > I would instead add a flag that when set overrides the SIGSEGV/page-in
> > behavior (which can be set globally by a flag on the map).
> > That sounds more generic and potentially useful to pick the behavior
> > on a per-allocation basis instead of making it global.
> > So for specific allocations, we get SEGSEGV instead of paging in
> > memory, while for the rest it's the default based on map's flags.
> > And to prevent anybody else from allocating this range, reserve it
> > ahead of time in the scheduler's init() callback.
> > For normal programs it can be an extra prog run before the program is
> > attached and starts firing.
> > We won't need a new kfunc either.
>
> I'm not following the idea.
> There is already a flag:
>         if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
>                 /* User space requested to segfault when page is not
> allocated by bpf prog */
>                 return VM_FAULT_SIGSEGV;

Yeah, but it's global. We may want fault-in for normal memory on
access, but we may want some range in the address space to have
SEGV_ON_FAULT behavior.
It allows some allocations to pick their fault-in/segv behavior
independent of the arena user's choice, which I think is important for
library like code / malloc etc.

The thing described above still wastes some memory because we map pages.
I feel the proper way to do this is how one would do something like
this in user space.
Have pages mapped in a range and remove PROT_READ | PROT_WRITE from
them, making them inaccessible.
Ideally it'd be zero pages but if we cannot do that, wasting some
memory for guard regions may not be too bad, for now.
We need mprotect() like capabilities to change r/w permissions to
create such guard pages, e.g. for a malloc with some debug features /
efence-like protection.

