Return-Path: <bpf+bounces-61204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280DEAE2295
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E264A6E0C
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CBF2EA466;
	Fri, 20 Jun 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX0MaGpM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962321FBEA6
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445832; cv=none; b=VRD/0lBqRdym5km9kFagfwS/Fwb81aRK7Dv8dK3QEitRMlQ/RHhdRVpL//j7yIaj2vqFw9ZZsOLtUyMsU9yyCP12wnGgUnUXAlWFt7Mb7bkZ1qPJjxICAaMeSqFQwG6ZrOjE3qWUJYVA4sboyLHucIulIinTFkXWWyqssLIOdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445832; c=relaxed/simple;
	bh=MHTEEMPBBu+KW6ftP6lGn4qfdq1HUwvXkwCLY89h4j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRTstSI0MvkBV6JpRzr5Csx8WKkyfFJRObYjgDRs53bVhabr7kicIaZ9l9bvlvyz2gSQgsAlbfjMXtbkfelRUa/CGXJdQPbyIFPzTXPNJN4A/EbbjDAbE0cPej9+5VQEaoOumaDqxc2gT9+tW6QfekjEnekytLhcFqS3IR+Tdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX0MaGpM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so16293245e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 11:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445829; x=1751050629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iar55rAGvy9Do5IsfW7AYhDcpR/jCCq4wQhbAkrFVA=;
        b=MX0MaGpM1oP+jr5Z9lhKMVmn8nmXQ8ovIdM1y5H7tVpNshy09q9aYOZ+NbibV0qJSD
         PVkBFHsBTKgRYXLutPABo1C/chmlGkNSURv77ZkhHBYGPtBIrl2ncvkdk+bd+RpheT4q
         Ib2phO1zqxoXK1Zf6my/4SOS9rlwxPLmBv9Q4ocnfmc1vDee3uojbeZiRpThfImuCSyz
         OantZ8bSZAvjXKg0CLwMt3t8xORVcDxCrOF5yBSDAOsHto2GBYeRntnMct04uNm6ti1S
         zB6Ks1D8inMVtd4SpwYwZCDSfVXkV9aQ6N2d2PXfq5kdc44utwX8VSDbiYSgH48wywP4
         J6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445829; x=1751050629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iar55rAGvy9Do5IsfW7AYhDcpR/jCCq4wQhbAkrFVA=;
        b=nyfjTohtcupUJCuMPxjO1XM4ALtrpzLWo57H3X5K4iy+5xl670uRCEqORseHhHbtgA
         KUFzMhEn+IXdfh9uNw0aX/trkApcwfM1GrnL4SSQHT3x6xkKXriJ6BPuwhSgkOyN0vHS
         tfRayUj585uQVHevtjMMKQKcWwC1y27UwazYYII0BXXcfmkQhqyErTbSisLN2foLl2Z3
         SDVmmdHJpxw07bxKU1+S2ITiaVZh3NcUMZXmd37o3mMwu4FKMW+6JiRD0A+b50aTb9ei
         vz3muOcpAz9asDGf1UanAkFZ4G1WAQqeh8QLKlBtIzEp/SXh7Pb4Fn/Wf2LrV5T27zAH
         bWmg==
X-Forwarded-Encrypted: i=1; AJvYcCU3XC3AzbmKUS23MKm3rAdvfRVaXI+hUjEDxWnWsTPmBXQcHGH4NjxBADBgwAxMwmvFcuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bbQ82dLeP68HPEqy8PMRKnu1a7qcCRQoFc/O98gcWOxVB+Bh
	5OIvJiy4cHLPhPQklfqTTbJgsU8dSEMg+BVKB44FyLPXmhG19EbCm4TJgg1aK0F51A2rJ5PQaJm
	V/xFAxvFaMfKESvWEZ+ZRpg3d0Qe5oEE=
X-Gm-Gg: ASbGncvJws6uikad9+XIzWdCCca1MnUuiwZ+yUiOCmH3KyntFKNUO8ZI9oAVo44XFId
	NLp5e1a2JAls2Arqe22+K8St+ClKs13Z4YV2QhMcoYFyhn1U6ArkeIfJ9Vp+wlne6ZjJZZTwuoj
	0SRinZfFhaSoP6cuqDtrXK/dLvjC1ujhwL1Z4l4pFugF1AWellQjZzZM+D+qfzSVJlVy6O+vEr
X-Google-Smtp-Source: AGHT+IGWpAaZCLMgy49YEmYwqskvUKeD12r59qZsOGPAFJhu5Mr/FWPH1jaIzbyhbcBJWMb4e0RDvgejTjSmf+5g3hw=
X-Received: by 2002:a05:600c:4e8b:b0:453:608:a18b with SMTP id
 5b1f17b1804b1-453654cb7dfmr46267915e9.9.1750445828668; Fri, 20 Jun 2025
 11:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620031118.245601-1-emil@etsalapatis.com> <20250620031118.245601-2-emil@etsalapatis.com>
 <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com> <CAP01T74rJKXqG5QHV=rXsou33_vfTp7vBZxHC5Qo2G_Vv3V9Dg@mail.gmail.com>
In-Reply-To: <CAP01T74rJKXqG5QHV=rXsou33_vfTp7vBZxHC5Qo2G_Vv3V9Dg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 11:56:57 -0700
X-Gm-Features: Ac12FXz407NFEhN6rB9PEWXAQ6Qc2eTqE6sCy--7UuJjtmUtuS6rBxVtSQtJ58w
Message-ID: <CAADnVQ+PKxryg_d5=G_txq8N5oZ618pW1NN7XFwXnKLZECNxGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 11:52=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 20 Jun 2025 at 20:44, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jun 19, 2025 at 8:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapat=
is.com> wrote:
> > >
> > > Add a new BPF arena kfunc from protecting a range of pages. These pag=
es
> > > cannot be allocated, either explicitly through bpf_arena_alloc_pages(=
)
> > > or implicitly through userspace page faults.
> > >
> > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > ---
> > >  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 92 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > index 0d56cea71602..2f9293eb7151 100644
> > > --- a/kernel/bpf/arena.c
> > > +++ b/kernel/bpf/arena.c
> > > @@ -48,6 +48,7 @@ struct bpf_arena {
> > >         u64 user_vm_end;
> > >         struct vm_struct *kern_vm;
> > >         struct range_tree rt;
> > > +       struct range_tree rt_guard;
> >
> > ...
> >
> > >  }
> > > @@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm_fault=
 *vmf)
> > >                 /* User space requested to segfault when page is not =
allocated by bpf prog */
> > >                 return VM_FAULT_SIGSEGV;
> > >
> > > +       /* Make sure the page is not guarded. */
> > > +       ret =3D is_range_tree_set(&arena->rt_guard, vmf->pgoff, 1);
> > > +       if (ret)
> > > +               return VM_FAULT_SIGSEGV;
> > > +
> > >         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> >
> > Why complicate things with another tree ?
> > The logic has to range_tree_clear(&arena->rt, ... anyway
> > and here check:
> > is_range_tree_set(&arena->rt, ...
> >
> > bpf_arena_guard_pages() won't have EALREADY errors, so be it.
> > Keeping another range_tree and spending kernel memory
> > just to produce an error to buggy bpf prog is imo wrong trade off.
>
> IIUC the main requirement is reserving a region that cannot be faulted
> in user space, and cannot be allocated from the BPF side.
> I would instead add a flag that when set overrides the SIGSEGV/page-in
> behavior (which can be set globally by a flag on the map).
> That sounds more generic and potentially useful to pick the behavior
> on a per-allocation basis instead of making it global.
> So for specific allocations, we get SEGSEGV instead of paging in
> memory, while for the rest it's the default based on map's flags.
> And to prevent anybody else from allocating this range, reserve it
> ahead of time in the scheduler's init() callback.
> For normal programs it can be an extra prog run before the program is
> attached and starts firing.
> We won't need a new kfunc either.

I'm not following the idea.
There is already a flag:
        if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
                /* User space requested to segfault when page is not
allocated by bpf prog */
                return VM_FAULT_SIGSEGV;

