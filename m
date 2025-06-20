Return-Path: <bpf+bounces-61213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510FAE23DB
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 23:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C291BC70A5
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB96225A23;
	Fri, 20 Jun 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS0nd98M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DDF2253A9
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453941; cv=none; b=Pzl2yzqdpJa4EXXuGeAyFoel8EC3Ma/o+nemOgUSFNfvOkpELXFGehO1KkOOgRwk+ZVdVNL3bXK8QMCqlxNRUj34P8tZR0mSsqXVG1jrLj52E0by3b//DOzdNQa7z/f1M6QjP2wOCk0T5Q5feWNGKk1jGWAfkst0SYUx7qyxyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453941; c=relaxed/simple;
	bh=FBrcObEz8e1dmGMDv711eKcNxK1Hnjw5uyPnzYgnjpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp3fWhroKASHggzLXIDulkIHXooP3N5+Zjo83/L58LdFOQJGkIGcdPoq78dW2z92hOUyWiaiTUwR6ibqDMh1WW1eGB7qEf/38QbYg65J5OhM6ivQz3wfHO4yycQ8kNzuXC6HU9qB2v92Zj5u3so5aqR5Sr3tp6eW6oU80ly2OuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS0nd98M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453647147c6so12846185e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750453938; x=1751058738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIV3y9i93eyQNUh0VyTiCH+zUeIHLluCSk6EAgiH8Gg=;
        b=lS0nd98MUDgI5rloToNaMGsNFxGsvn7KdlYRAg4oQMNO6CPhhPgyxT2tUhN3b7JaGd
         L7od+C5jN2hE2mxXvwt2sXxAxf/N9apdxGYd443mjYQQcPwwHVs/5vv25NOSXSi8kkYf
         gHli1EUn1Y8eJcIQXfaa23lcLnAcPiOK4u6mOcB/5kgwnwkMIThAHlZ+dpy7uh3ToVBO
         IqE5SVrCLR8i8f6RVR6KlxUlSZnj0J8OKN3RS1h4G6HEqhC7KXVLA9vQIFhvDsl31509
         9BQagf6u0ofWY/1BlpLDYf7iUYKNqdJ/nJvoRrm+LTlvbt55n5ZGXEZjkS5mHWIVuMv7
         KoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750453938; x=1751058738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIV3y9i93eyQNUh0VyTiCH+zUeIHLluCSk6EAgiH8Gg=;
        b=JPDlqNqX2w7TcNkIaM2TGuHD27nxWn7bBmEYJkQqalbf2xfPz5Dl0/IeyxteTpdHlI
         QKELZFsAWKHamGA07+XPdD+fTLbmKlfpXdIvlka2zwzkxeyEqEoEL6vM1suO4U6VgHSC
         sj4av/oV+AlbaeR7XAaJ95MS9G3Rs13zv6m8+Pee2kw+oCkuQBXxOSi+WOWWTyANJC+G
         ejrlQIj18VD+X+qpVE9SsVm0ndgGBpCT8LwfLDhQWdD1yd4K6ztFf3W5ZnZsJpfsGW3r
         onuUjDbwUfVv98oqFdJOZc8Lsp2SG0i8hQSr/IzCrhcUIsFSGx/fWlgVfmiJEFnPEcaU
         YcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb6b3j+qJddCM7iA7QphFh+isU34a5SvwlvjDGuzoWM3/sa0XdLe8KYOJzB3AOaReRvXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWllKJwi7C1vNeMpTxZInTGaJEqca9m1r1ZJIH1ufCSO+C1oZJ
	Ag9gF151tr6bbR6EZ/qOFUUuU7yBFz+bYYtzN6LUsb0QUnX5P6TVRyxyfrMeUBw5vrwohWAm00R
	5OU4SkYGJUhlNWiy8YiLAxzExp1mKHCI=
X-Gm-Gg: ASbGnct1D4elbDxNsSbunrUc7xAWIGc4NR7SXrDu0gzwyirov0ZfUXVwNhJYxoOEklA
	FikpTFEK9Z/fTPgP22fO+J66G8W+Wd+eGjIP921uMjR3asXiRWHH9Yb5dhnqlcRo8NEOa5x0j5B
	qdDcKwRcKwvJyu32czTXwwDPehP+SONyBKcj1Au5v5JFEiLXls7B0AkYtgwDwBK3sD86YOctr7
X-Google-Smtp-Source: AGHT+IGr3Kp+M977g8YmmfzEacWq/v5aBcBFD/JaqUY1KrutDqkGch+F1XYub8oyitMlTzv4Jbyn3lx4pE3kJyPtDGY=
X-Received: by 2002:a05:600c:450d:b0:453:2433:1c5b with SMTP id
 5b1f17b1804b1-453653cead1mr40051165e9.5.1750453937690; Fri, 20 Jun 2025
 14:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620031118.245601-1-emil@etsalapatis.com> <20250620031118.245601-2-emil@etsalapatis.com>
 <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
 <CAP01T74rJKXqG5QHV=rXsou33_vfTp7vBZxHC5Qo2G_Vv3V9Dg@mail.gmail.com>
 <CAADnVQ+PKxryg_d5=G_txq8N5oZ618pW1NN7XFwXnKLZECNxGg@mail.gmail.com> <CAP01T76bZTCSKd-CC4Fge+5OAxJBSkaf9ZWNCzsJo3UvEigEfg@mail.gmail.com>
In-Reply-To: <CAP01T76bZTCSKd-CC4Fge+5OAxJBSkaf9ZWNCzsJo3UvEigEfg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 14:12:06 -0700
X-Gm-Features: Ac12FXz_cBegfPdlTY0a1KnmNU8UDe52cEdtAHfzaWEWpjhfXG4GJC1FfeIiHYQ
Message-ID: <CAADnVQ+yFCXKGoF=73zxoKz2-ECcx8f4ETVn=s9pHJRkg0jzHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 12:06=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 20 Jun 2025 at 20:57, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jun 20, 2025 at 11:52=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 20 Jun 2025 at 20:44, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 19, 2025 at 8:11=E2=80=AFPM Emil Tsalapatis <emil@etsal=
apatis.com> wrote:
> > > > >
> > > > > Add a new BPF arena kfunc from protecting a range of pages. These=
 pages
> > > > > cannot be allocated, either explicitly through bpf_arena_alloc_pa=
ges()
> > > > > or implicitly through userspace page faults.
> > > > >
> > > > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > > > ---
> > > > >  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++=
++++--
> > > > >  1 file changed, 92 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > > > index 0d56cea71602..2f9293eb7151 100644
> > > > > --- a/kernel/bpf/arena.c
> > > > > +++ b/kernel/bpf/arena.c
> > > > > @@ -48,6 +48,7 @@ struct bpf_arena {
> > > > >         u64 user_vm_end;
> > > > >         struct vm_struct *kern_vm;
> > > > >         struct range_tree rt;
> > > > > +       struct range_tree rt_guard;
> > > >
> > > > ...
> > > >
> > > > >  }
> > > > > @@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm_f=
ault *vmf)
> > > > >                 /* User space requested to segfault when page is =
not allocated by bpf prog */
> > > > >                 return VM_FAULT_SIGSEGV;
> > > > >
> > > > > +       /* Make sure the page is not guarded. */
> > > > > +       ret =3D is_range_tree_set(&arena->rt_guard, vmf->pgoff, 1=
);
> > > > > +       if (ret)
> > > > > +               return VM_FAULT_SIGSEGV;
> > > > > +
> > > > >         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> > > >
> > > > Why complicate things with another tree ?
> > > > The logic has to range_tree_clear(&arena->rt, ... anyway
> > > > and here check:
> > > > is_range_tree_set(&arena->rt, ...
> > > >
> > > > bpf_arena_guard_pages() won't have EALREADY errors, so be it.
> > > > Keeping another range_tree and spending kernel memory
> > > > just to produce an error to buggy bpf prog is imo wrong trade off.
> > >
> > > IIUC the main requirement is reserving a region that cannot be faulte=
d
> > > in user space, and cannot be allocated from the BPF side.
> > > I would instead add a flag that when set overrides the SIGSEGV/page-i=
n
> > > behavior (which can be set globally by a flag on the map).
> > > That sounds more generic and potentially useful to pick the behavior
> > > on a per-allocation basis instead of making it global.
> > > So for specific allocations, we get SEGSEGV instead of paging in
> > > memory, while for the rest it's the default based on map's flags.
> > > And to prevent anybody else from allocating this range, reserve it
> > > ahead of time in the scheduler's init() callback.
> > > For normal programs it can be an extra prog run before the program is
> > > attached and starts firing.
> > > We won't need a new kfunc either.
> >
> > I'm not following the idea.
> > There is already a flag:
> >         if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> >                 /* User space requested to segfault when page is not
> > allocated by bpf prog */
> >                 return VM_FAULT_SIGSEGV;
>
> Yeah, but it's global. We may want fault-in for normal memory on
> access, but we may want some range in the address space to have
> SEGV_ON_FAULT behavior.
> It allows some allocations to pick their fault-in/segv behavior
> independent of the arena user's choice, which I think is important for
> library like code / malloc etc.

You mean to augment range_tree with extra flags per range ?
I don't like it. So far no one has used BPF_F_SEGV_ON_FAULT.
Making it more granular won't make it more useful.

> The thing described above still wastes some memory because we map pages.
> I feel the proper way to do this is how one would do something like
> this in user space.
> Have pages mapped in a range and remove PROT_READ | PROT_WRITE from
> them, making them inaccessible.
> Ideally it'd be zero pages but if we cannot do that, wasting some
> memory for guard regions may not be too bad, for now.
> We need mprotect() like capabilities to change r/w permissions to
> create such guard pages, e.g. for a malloc with some debug features /
> efence-like protection.

I don't see the point of all that.
bpf_arena_guard_pages() that only reserve the range without
allocating the pages makes sense to me.
I think bpf_arena_reserve_range() would be a better name for such api.
Since actual pages are not allocated.
"guard pages" typically means actual pages are allocated and populated
with some pattern. Here it's not the case.

