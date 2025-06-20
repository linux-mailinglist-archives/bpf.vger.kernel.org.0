Return-Path: <bpf+bounces-61221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2CFAE2698
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 01:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94ADE5A5468
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBA241116;
	Fri, 20 Jun 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="c7guFUK2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F717BD3
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750463913; cv=none; b=KjwNirXq1vTjGB1azSFyrnLp95wbLdueWB3FGzwVBWV13TMD+uAdedmGfYfKvHe+Mgvk1dyCOLl1nIqaI+mwZFhRgWBZwohmBsu5izixuoMA192mtxE2Dv738AHZ/mP78DUaiFJ6zPot6+VlXgqXmm43cgd6oBs47JmdmxURUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750463913; c=relaxed/simple;
	bh=+nV+UElo712fFG/kXPJ39/3WX7XivdH+JP8NRVHvkYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOhBfpYUfv2rqCJcWSuDJE01H0TkyCskQ/qc2thXX8KcdeJsVJ2DRFs9reBTmEgtiF1PG2tC8voiZ+wc7PBxUh3tCRPMAEURzkgREtQ/l9fIeeGsr2F/s7Iji+DnHTf8KPHGeBAYFWH5NRhVzAmVcjoLA9wNqFPXc5ONX0YXvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=c7guFUK2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e5d953c0bso26983757b3.1
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1750463910; x=1751068710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEI0s3XwokMFO7rMi03iYf4qtMs/y/tiFQASIRYbRmk=;
        b=c7guFUK21467zq81G8ubh4AsY5YZZZAu7fPYtqFv2HFF2Uoo6LoqM563DORUGVaeHH
         hl69+XvwZ6mMzECXVIPPfgUzdnl6/jCLmBksd7I5VWRJye5mEnLWMcnIzBuA0ixY6KLv
         Y6KAsSm+osJKQEHgaEb9ZztYRMi5T/TEM4rO++NXSjDF3qvKL6rIrB7XpR3q9lXQFD5G
         4xQjV3WSkSHaK2K5Xbc4l1QE98AK7ojr1PClMJTvzpqsfAMX4mzEemxh2fYFwPVc87RS
         n/0apui/0KzIFe3yjsG3KTVak8Siqa5H476CrJeLUU6BElMXtb8fVTFzQ1FGd37ky2i1
         Ejow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750463910; x=1751068710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEI0s3XwokMFO7rMi03iYf4qtMs/y/tiFQASIRYbRmk=;
        b=ds8qdjfe+eCRgoo95u6mb1tXq66U0/qKrmTNuktHqfcxDf/urDn3xBFxUFVxpHijIe
         AqAjenOxithPr90Rq8v2PMnL2THvTWhsM0Eum2kC+IMM+GqqGU86uvw7kMpf0kPteTWG
         uaBGYQA9VR0sG5mJ6A6rEz9PDhKT8inArISVlms4WFR6pB3E2pJKgw9Cp0yIG+sAvWlz
         BSnhW5jjr/opHml2VF5I0tuWUGUDgSnkcJOCtPJy7RSZPygN/828wY5+tSAgE3Tc+pzP
         +KPfcwxwAQ6o/9b6Bk2dkrh0poT2UaTlFiv2ZTSZaX06rd1i5OjOC0ZAgPH2tvnzutbn
         IGpw==
X-Gm-Message-State: AOJu0YyqCkgV95m+lCMBixqTcXue7GINfHk3ImFsyP27xU2KCNCHtcJ3
	JzFIuS3h7Wnnuk6pIjOSe89yCEsMnWuSRoThDJ8tqkbiXYWYnxdKjjmmmbhy16NHYZljnDN+vOh
	IqDK8BHtKLc1OkjBC0ts5O3UWH9F974Ey/mPNczF0nw==
X-Gm-Gg: ASbGncvTO/D8A51NgIyesRS/P7X9CnJ2mPzRI9hp8OHHxIz+Ntee8p2crJ68s3X2DhB
	gSD1lnj/bCsum1mQk8frYuKt+toTK6xebmBxWtMk7PPFaNV/jKbKT/D4SVqY+4ubMD3EZCt7p7b
	v8n3QVdCu37WU2DD36uvd4iOYQDs2A0FGe8ahUPOaFc3aS
X-Google-Smtp-Source: AGHT+IFFf3DHQTKceGJDxgdCKu8NuCG2xRHy2HPbKzY1CCbwFeTOGYtypSxrdaslyCfU7ol8nsHPI2+l1jwoym2snlk=
X-Received: by 2002:a05:690c:5506:10b0:712:d54e:2209 with SMTP id
 00721157ae682-712d54e2895mr14283577b3.14.1750463910106; Fri, 20 Jun 2025
 16:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620031118.245601-1-emil@etsalapatis.com> <20250620031118.245601-2-emil@etsalapatis.com>
 <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
In-Reply-To: <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 20 Jun 2025 19:58:18 -0400
X-Gm-Features: Ac12FXzCAE0q1a4Z29Vs4-Cu0o2eCjcMEgzoihtwUD5GoiFtDRKZS2HJuq8MiFU
Message-ID: <CABFh=a72iTtpi7bwXGjkcWvSzc48iN+S6phRjOYs2pBudHtH-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 2:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 19, 2025 at 8:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
> >
> > Add a new BPF arena kfunc from protecting a range of pages. These pages
> > cannot be allocated, either explicitly through bpf_arena_alloc_pages()
> > or implicitly through userspace page faults.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 92 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 0d56cea71602..2f9293eb7151 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -48,6 +48,7 @@ struct bpf_arena {
> >         u64 user_vm_end;
> >         struct vm_struct *kern_vm;
> >         struct range_tree rt;
> > +       struct range_tree rt_guard;
>
> ...
>
> >  }
> > @@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm_fault *=
vmf)
> >                 /* User space requested to segfault when page is not al=
located by bpf prog */
> >                 return VM_FAULT_SIGSEGV;
> >
> > +       /* Make sure the page is not guarded. */
> > +       ret =3D is_range_tree_set(&arena->rt_guard, vmf->pgoff, 1);
> > +       if (ret)
> > +               return VM_FAULT_SIGSEGV;
> > +
> >         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
>
> Why complicate things with another tree ?
> The logic has to range_tree_clear(&arena->rt, ... anyway
> and here check:
> is_range_tree_set(&arena->rt, ...
>

The idea was to distinguish between allocated and reserved regions to
avoid a stray bpf_arena_free_pages() from freeing a guarded region or
using bpf_arena_guard_pages twice on the same set of addresses. We can
remove the extra tree If we don't care about particularly egregious
misuses of the bpf_arena_* API.

> bpf_arena_guard_pages() won't have EALREADY errors, so be it.
> Keeping another range_tree and spending kernel memory
> just to produce an error to buggy bpf prog is imo wrong trade off.

Same as above, we can remove the checks and extra tree if that's the case.

