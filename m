Return-Path: <bpf+bounces-21524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F984E89A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F9E290E9E
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124B2D796;
	Thu,  8 Feb 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW65OVqq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3625770
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418511; cv=none; b=JFnQ69TswsD10fOBqnNjeiX+acQ8kRURVcBYnhz3Vc+hg5cHTvp77hlUBcLZMJpHmnfwcj4ZlKJatWCvAjNkYXaNET2YZio9qXxlibVzNMvZZIZAmc1tbfwKyb+rww48TJ2ILH8eRKcGFbQbnosVElZ7EagYRwfeywlPTJvyQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418511; c=relaxed/simple;
	bh=3rJyjwMNNrH2iNqVCF0mR45yFkn1beJfKK5dX2nhNg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWZeZyck0yJxLusRWLDZdiabEpPxtFdPyzrXzgPkFV0Ig2qCV7FZo8maPbSV59yRS7fN0pV8BbTfSPSYXm49Rq2BEGzpH0nOK+V6vvq9GXjDqme07JgnqMr4CBvjbi1ZjEOpHPrbxlISru43M1oeivOo8BOafMm3XD79gjX5r3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW65OVqq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290ec261a61so109129a91.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707418509; x=1708023309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWXbZgKWtvijsMvDIT+yzcg24ikiAe312anPEYmIWVc=;
        b=FW65OVqquOOsUvu3k/9JgVQC722KKsg3Mt+h6i6lcWMv/j3M79LmY1DLEFSkZTF9D2
         Y91rOFSBFfMhLXJLa421FtxtZwodjBACzxsyybxDRACNAIGIeOO1jDiJUSz7odZ6bjZw
         WNy2LvR0lNK/fTd+qIgsqQ1EwXVavmF/Vyk2bCH9UxC1cT3gvlWcxahjQb1FiRKn+dKk
         L13OglsRtnHhFEjPQgP9poBOr5AlKOc5svNcS4dl/oSKP+k5ClX/AWY7TDhm3kWfT/tE
         xx7M0ojAwq+WxMvudmTVjhD0DM1wJ8v5sC9xi8bmw5RCfrI4oWQLeEqdmJL/LS8ftqoG
         oYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707418509; x=1708023309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWXbZgKWtvijsMvDIT+yzcg24ikiAe312anPEYmIWVc=;
        b=kyKDz8FCmQOft/lBgFuVDMKQEKrdkJi8PybJg/0Vg//IjoukHqjslMB6h26inCDHDB
         a/FIPJ4rJtAmsmwSHgO7LwmavxbAx3NG+I8IKzPt5+zt3qu8s4GTEQjtfMKer17QpLTF
         S7d/2QjkkYBPI0cJ/Ex0zPSkk+ztikh4xmGKY8lB8yZgepZpch5TGV1tA3HWY+2E3VrQ
         Yp3+qKrz99NGGMh+0pLEq7ma6E7SnS+cpOyIVHm+61a3IRhvgIGzmH5C6MbPgFZkZ0TR
         eh4VlVpIT/iDhTSzFlhys8hPtUFV+fe2ir4WYzctgeSUhL6vjYe7d8EJDR+PrPkGYTmm
         9n/w==
X-Gm-Message-State: AOJu0YyL/4NDHIMq0zKPSSvi4SyAYQvwueo++Ayr0UgTISph6dpBKJli
	/t1xTmCmGgdOQpAhJMuNJCvlx/2UgVEm2SeUUlx75b3XRO8ytUV6POxjZ/tp5ch5eI/89fdAH8a
	ZVun7BJGBW3t9oB58VYzf7WAGccCk6rn7
X-Google-Smtp-Source: AGHT+IEK8ovRbD8PpPYg56udbFYc4wM458hlpGpgSiG3OaqqQ2JuFv/0m7UvKEm66AWvFQsQCyA41JMRXrzCaqxuMaM=
X-Received: by 2002:a17:90b:e96:b0:296:bf9:dc6b with SMTP id
 fv22-20020a17090b0e9600b002960bf9dc6bmr139779pjb.27.1707418508724; Thu, 08
 Feb 2024 10:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-12-alexei.starovoitov@gmail.com> <CAEf4Bza9gNXfGXuQnvWnoYNA08enBCkqn9uyHtBNdTpZRvn7og@mail.gmail.com>
 <CAADnVQKjkba_wiUJ9wps_k8+TYu_q3Ai5oQ1mnZQmpv+pnPfFw@mail.gmail.com>
 <CAEf4BzYvgHoBQ0KNFOWoK8XOvRTzGNBM1QsS=zR5iPTq-Z+=4g@mail.gmail.com> <CAADnVQJ-rrx-_tC5ek_wyhNdFw2Ya6o3eN_hpdgFswT=CfuXnA@mail.gmail.com>
In-Reply-To: <CAADnVQJ-rrx-_tC5ek_wyhNdFw2Ya6o3eN_hpdgFswT=CfuXnA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Feb 2024 10:54:57 -0800
Message-ID: <CAEf4BzZqsX6W33ZXm8Wt+RsBXyYx3em5gQpB_0U8CNaeNL5KFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/16] libbpf: Add support for bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:45=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 8, 2024 at 10:29=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Feb 7, 2024 at 5:38=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Feb 7, 2024 at 5:15=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > >
> > > > > mmap() bpf_arena right after creation, since the kernel needs to
> > > > > remember the address returned from mmap. This is user_vm_start.
> > > > > LLVM will generate bpf_arena_cast_user() instructions where
> > > > > necessary and JIT will add upper 32-bit of user_vm_start
> > > > > to such pointers.
> > > > >
> > > > > Use traditional map->value_size * map->max_entries to calculate m=
map sz,
> > > > > though it's not the best fit.
> > > >
> > > > We should probably make bpf_map_mmap_sz() aware of specific map typ=
e
> > > > and do different calculations based on that. It makes sense to have
> > > > round_up(PAGE_SIZE) for BPF map arena, and use just just value_size=
 or
> > > > max_entries to specify the size (fixing the other to be zero).
> > >
> > > I went with value_size =3D=3D key_size =3D=3D 8 in order to be able t=
o extend
> > > it in the future and allow map_lookup/update/delete to do something
> > > useful. Ex: lookup/delete can behave just like arena_alloc/free_pages=
.
> > >
> > > Are you proposing to force key/value_size to zero ?
> >
> > Yeah, I was thinking either (value_size=3D<size-in-bytes> and
> > max_entries=3D0) or (value_size=3D0 and max_entries=3D<size-in-bytes>).=
 The
> > latter is what we do for BPF ringbuf, for example.
>
> Ouch. since map_update_elem() does:
>         value_size =3D bpf_map_value_size(map);
>         value =3D kvmemdup_bpfptr(uvalue, value_size);
> ...
> static inline void *kvmemdup_bpfptr(bpfptr_t src, size_t len)
> {
>         void *p =3D kvmalloc(len, GFP_USER | __GFP_NOWARN);
>
>         if (!p)
>                 return ERR_PTR(-ENOMEM);
>         if (copy_from_bpfptr(p, src, len)) {
> ...
>         if (unlikely(!size))
>                 return ZERO_SIZE_PTR;
>
> and it's probably crashing the kernel.

You mean when doing this from SYSCALL program?

>
> Looks like we have fixes to do anyway :(

Yeah, it's kind of weird to first read key/value "memory", and then
getting -ENOTSUP for maps that don't support lookup/update. We should
error out sooner.

