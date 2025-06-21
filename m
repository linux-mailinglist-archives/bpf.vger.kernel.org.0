Return-Path: <bpf+bounces-61222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C1DAE269C
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 02:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E08C3B68CF
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A24A23;
	Sat, 21 Jun 2025 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jPH+6UhG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B784A11
	for <bpf@vger.kernel.org>; Sat, 21 Jun 2025 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750464925; cv=none; b=GGPQ6O6nZH3aYIhioXS4WtBm4U3gDWd8QyuAMA8lRFeEycSIgEFbFbxAIf3vOe7vDzOtA5KUXhEKhnPLqjqjTjslJH8VQL6QtRVtaEgeJAe2Nt3OphFOycgjUFpA1u/opRsQ/n6FzSHNamXLkSYs7I2YKKbXcGeW76rTXzsAnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750464925; c=relaxed/simple;
	bh=KGYTwMuCVIx5/sbDAdM30ATQHYKpmnKaBtiKeHNNG8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCmpQTNVZHyGGylX2A3cpRxgNh+sP94LLiGMHt6KVzNVtHyeqIcoXvDDZUxLy0lIyoZ/8VogheDCcGzJ/3Cx0DsNq7tjrWdhDWrLvWnH5TmgjAaoF+XZvUHPsLwz3j+b66+rsC4dgWpT/lbfoFZOS6Mh9cC91zNu+li6rAhZr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jPH+6UhG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so1464263276.3
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 17:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1750464922; x=1751069722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ndKpXVFgBBg33x6m0rmTbjRqAdAQhuy7EPiHXrhC3s=;
        b=jPH+6UhG427LO8q2bETb0Zwo23eqow+v+SKbLEwQpLdgT1dJyANparFfc3YC9cVi/9
         nec00mejAWsSFisn9axryamPy2eOwZjtBHVNuS90pf2AUF5QPbJ6r0xc+76+mY9x0f25
         DOU2aTq7Bb6DcA20gZ6j0fRH0Y7BN4d0rZs/QHKip05HBlHv552NZrl382rhBFe+B/lk
         4o8DpFnfRCdcgRW9eXaWPRzhLVbl85fjojqfifaLD70KUunjKvTbUDL3uYFArzkJc33A
         i95QJquwnSOTQfW2HKBN/jCRiCU8UoE5ltGv+K877hA61aHSZGSo55y1f4LhwozPhxPe
         e0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750464922; x=1751069722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ndKpXVFgBBg33x6m0rmTbjRqAdAQhuy7EPiHXrhC3s=;
        b=WB67tmrEmossoIuTKjGggSiY3Zw30spCmJwXP42s2YQdJf0KvNsJpHBgq5h7NYsOAM
         mFkYo41Wq6kZr9VpLknUkiC0WPNV6oj6jPsCOylZxulMWUhyqAAhD2RDDf3MVgDYTtjA
         WrqbQ+KTOupuf7tWe1oTqzTyX1FxPdtBf8OIPk3GMlFULgienu7qkblAfYLxSobmm5s8
         GBJaeeMZziEKtwzqdcKouJmmhESuKUpQ2A/ekWOUp2N5kFGsRznSNEXogGqamJUHbOK+
         J+yfVyX0WZgb10DSl5YtZaLxNv5u6ZSZvyotVn/h20UO212e1NVpSr/nJVgv1R3YpLHx
         h5xA==
X-Forwarded-Encrypted: i=1; AJvYcCXpn+UnkMgcuOlRVULbB2fjs7iJ7+kKcWl4yKl3z0IRhuym2JCLI6+OhMsQFK9qPxuaKiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUuJLRU4c9LiLVzK6HrWGppszdvSqn/53Brk1OlH1gyHSVQxv
	iQzFNZj+OaKXHth4Y76Nd3EDAQiGJYVI+FYmSNMow66vpETXFJOe6UY5SrrZCnFMN1j+jf+k8V1
	PhLumC28TSmNu75AZHIfuY0v/riHeGqfBkfis6yQQpA==
X-Gm-Gg: ASbGncs+YRG4Ku7jACK47mqjJw1yTplZLE0mhPp+hImJzyMDRimThF2+X/ecVOEBXRD
	jWltc3zYbFogUSUcSunkB8vsy+lS895b0T9M0Ylq3KWc76/j1F500XuBgnUM2AGyyyB68sy0bZT
	R75YKkWEERJxg4Lo8qUss61XWpGSOtLffdILhmt1bICbr5
X-Google-Smtp-Source: AGHT+IGTymXS5DCE1qIe6MeFMwN0YxCN9za0VchsWhDIH8fPLcx0MDSe59ErIZzUgvs2WIH2GQNAA0zy3x7gGg83bQw=
X-Received: by 2002:a05:690c:a0a8:10b0:70d:f47a:7e21 with SMTP id
 00721157ae682-712c6311a2emr52794627b3.1.1750464922015; Fri, 20 Jun 2025
 17:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620031118.245601-1-emil@etsalapatis.com> <20250620031118.245601-2-emil@etsalapatis.com>
 <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
 <CAP01T74rJKXqG5QHV=rXsou33_vfTp7vBZxHC5Qo2G_Vv3V9Dg@mail.gmail.com>
 <CAADnVQ+PKxryg_d5=G_txq8N5oZ618pW1NN7XFwXnKLZECNxGg@mail.gmail.com>
 <CAP01T76bZTCSKd-CC4Fge+5OAxJBSkaf9ZWNCzsJo3UvEigEfg@mail.gmail.com> <CAADnVQ+yFCXKGoF=73zxoKz2-ECcx8f4ETVn=s9pHJRkg0jzHQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+yFCXKGoF=73zxoKz2-ECcx8f4ETVn=s9pHJRkg0jzHQ@mail.gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 20 Jun 2025 20:15:11 -0400
X-Gm-Features: Ac12FXznaGQjzNkTifr6Myy40yUl-ozcuyIxx-sw_lfaEcNKWD9HqMtr5QqEfdI
Message-ID: <CABFh=a7ioM=aciHDW12t3WdEGBB8qeSFH7q6D2LpnecHvJ49AA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 5:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 20, 2025 at 12:06=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 20 Jun 2025 at 20:57, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jun 20, 2025 at 11:52=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Fri, 20 Jun 2025 at 20:44, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jun 19, 2025 at 8:11=E2=80=AFPM Emil Tsalapatis <emil@ets=
alapatis.com> wrote:
> > > > > >
> > > > > > Add a new BPF arena kfunc from protecting a range of pages. The=
se pages
> > > > > > cannot be allocated, either explicitly through bpf_arena_alloc_=
pages()
> > > > > > or implicitly through userspace page faults.
> > > > > >
> > > > > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > > > > ---
> > > > > >  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++=
++++++--
> > > > > >  1 file changed, 92 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > > > > index 0d56cea71602..2f9293eb7151 100644
> > > > > > --- a/kernel/bpf/arena.c
> > > > > > +++ b/kernel/bpf/arena.c
> > > > > > @@ -48,6 +48,7 @@ struct bpf_arena {
> > > > > >         u64 user_vm_end;
> > > > > >         struct vm_struct *kern_vm;
> > > > > >         struct range_tree rt;
> > > > > > +       struct range_tree rt_guard;
> > > > >
> > > > > ...
> > > > >
> > > > > >  }
> > > > > > @@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm=
_fault *vmf)
> > > > > >                 /* User space requested to segfault when page i=
s not allocated by bpf prog */
> > > > > >                 return VM_FAULT_SIGSEGV;
> > > > > >
> > > > > > +       /* Make sure the page is not guarded. */
> > > > > > +       ret =3D is_range_tree_set(&arena->rt_guard, vmf->pgoff,=
 1);
> > > > > > +       if (ret)
> > > > > > +               return VM_FAULT_SIGSEGV;
> > > > > > +
> > > > > >         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> > > > >
> > > > > Why complicate things with another tree ?
> > > > > The logic has to range_tree_clear(&arena->rt, ... anyway
> > > > > and here check:
> > > > > is_range_tree_set(&arena->rt, ...
> > > > >
> > > > > bpf_arena_guard_pages() won't have EALREADY errors, so be it.
> > > > > Keeping another range_tree and spending kernel memory
> > > > > just to produce an error to buggy bpf prog is imo wrong trade off=
.
> > > >
> > > > IIUC the main requirement is reserving a region that cannot be faul=
ted
> > > > in user space, and cannot be allocated from the BPF side.
> > > > I would instead add a flag that when set overrides the SIGSEGV/page=
-in
> > > > behavior (which can be set globally by a flag on the map).
> > > > That sounds more generic and potentially useful to pick the behavio=
r
> > > > on a per-allocation basis instead of making it global.
> > > > So for specific allocations, we get SEGSEGV instead of paging in
> > > > memory, while for the rest it's the default based on map's flags.
> > > > And to prevent anybody else from allocating this range, reserve it
> > > > ahead of time in the scheduler's init() callback.
> > > > For normal programs it can be an extra prog run before the program =
is
> > > > attached and starts firing.
> > > > We won't need a new kfunc either.
> > >
> > > I'm not following the idea.
> > > There is already a flag:
> > >         if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> > >                 /* User space requested to segfault when page is not
> > > allocated by bpf prog */
> > >                 return VM_FAULT_SIGSEGV;
> >
> > Yeah, but it's global. We may want fault-in for normal memory on
> > access, but we may want some range in the address space to have
> > SEGV_ON_FAULT behavior.
> > It allows some allocations to pick their fault-in/segv behavior
> > independent of the arena user's choice, which I think is important for
> > library like code / malloc etc.
>
> You mean to augment range_tree with extra flags per range ?
> I don't like it. So far no one has used BPF_F_SEGV_ON_FAULT.
> Making it more granular won't make it more useful.
>
> > The thing described above still wastes some memory because we map pages=
.
> > I feel the proper way to do this is how one would do something like
> > this in user space.
> > Have pages mapped in a range and remove PROT_READ | PROT_WRITE from
> > them, making them inaccessible.
> > Ideally it'd be zero pages but if we cannot do that, wasting some
> > memory for guard regions may not be too bad, for now.
> > We need mprotect() like capabilities to change r/w permissions to
> > create such guard pages, e.g. for a malloc with some debug features /
> > efence-like protection.
>
> I don't see the point of all that.
> bpf_arena_guard_pages() that only reserve the range without
> allocating the pages makes sense to me.
> I think bpf_arena_reserve_range() would be a better name for such api.
> Since actual pages are not allocated.
> "guard pages" typically means actual pages are allocated and populated
> with some pattern. Here it's not the case.

I'd agree with bpf_arena_reserve_range() as the name.

Wrt having more granular permissions, it can be useful for some
consumers of the arena API, e.g., for sched-ext arena data that gets
set up at initialization but is never modified afterward. But we can
consider the two features separately imo even if they touch the same
code.

