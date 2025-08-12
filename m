Return-Path: <bpf+bounces-65478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9807B23C50
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C7F3B5BB7
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 23:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190D2D9EF3;
	Tue, 12 Aug 2025 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNtOpros"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485B4C92
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755041823; cv=none; b=jGAGSINXc7RSsTFYyIpHLDwF6i6fJmb8hqSRupIvgvplNZNo0UmayBWPKpQvrPkMueJtae4mYJovKZ8nlxSpbs3MJya1apZOd6X9+3mIggbNLWa7qlrpxls01CWOXw75Vu37IA+vuk+XCAAHDNQ0BU99yv5BZXVz36HQ85qpLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755041823; c=relaxed/simple;
	bh=80qmoJYY0enGzRRQcatGILRc+KHEggi+jpYoyL3JJcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t45WNftoqvohpK+QIKoWtpmalzemsIEljCA95kgYvwvw6Cao1QVfux9uLJ2JOL/9dvkYYF3zUjOj+9KpEEkE+t3j09I7Jd4/6PJrRw6LVz1CsPEAu+146eUW0shokhpFc48XzM4zOxRm+Ej+e6WKWVDih+KgQULVMldlNXVFDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNtOpros; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-af939afe5efso699707766b.2
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755041820; x=1755646620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtwU+3Hj55rDEcK9X5I3e4srKubezGXkCK/ehaBfS7g=;
        b=SNtOprossc47HkywrjeonE684DdSkfdbs7oUZlLneEHTC6q7Twwp9+NYaSxp3nxLox
         JY41ZYyVxkDPf6uheu6pSlbcB7ZlKIrS3bWo5zQZiYaiquuR5ttozKmYuC/E8nrgjfrR
         L3JMDB9gBLNczaiE/NvGmU87Q8PadhKEksk7g1BpahMygf5HIHeMRNMSwm33pFi36c33
         88FOXb8QkhBxbVkaYL5n0P8pQzYe4NQvRvi9FQm5PDxamfd0k6iZrgCZFvO4byfSigpv
         XLI55eFGDD6CWi95M3aMAdybPAgjyHD52ej8npzns4RpDwWL81CRZaZTqO5EBMNstekx
         YKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755041820; x=1755646620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtwU+3Hj55rDEcK9X5I3e4srKubezGXkCK/ehaBfS7g=;
        b=EhskHaD+dWGKV5j7IbLoiYF3+ZzK30o1PoGm76lHQr0axrFrz1KnbMImsfriy/rA1d
         0Vcaq/u7SluXe62Wfzya8mkAv3H1MrAQ9188PNYSdhnE+/Vs/mSUDjhPJVxlMNndgj3D
         9YZgpttM2yo9hYflJ4r2uHrRLOg/a8I5pYIGEh3eL4ObYQdXAcADycY6hxRgfjlQyRZ5
         sHwwVaepTffbJFZqRfayVG+Pe/NGnPHiIfR/XKv2uwAKcZZdcPwU4Zume5kg+y9m6ED5
         6lbuZ/0+lP45KJk3R2RokFIijwnWpVKxbJuFEhI7pN9zETlElBf0I9l2FQ830cbYmntx
         k04w==
X-Gm-Message-State: AOJu0YxRL4rNG/gG80qrmQa31V1oFxDhtceX4Y/GNCHKzyQr8dcm7HKA
	+qNDtkiVtHjrry9GIBW2kwjv4laMHscE4U4iALWYr/M/Qcg/HWnA+KPandkNoPF6Jx/M2wVnRbv
	F3BJUTwnqpVv2SXlbG6BY7T/PLGt7oW4=
X-Gm-Gg: ASbGncuef+pIi/LU9GVT3j83lCA28HowEgN3nWn9yvkoAuOtNiLYP/2c11zYBve9Ie2
	X43u+RFyJU7DJEXSB8TgwNopNQC9t9h2p+wfoTbaTVZI3HLVEXagRYaJkrxEbQkJ7iYLqoAQiUk
	Z0WzcZK3RJdVeBgowGGEtXkOsqFS7VnvH9p5Q7VVpWsvgBDBniPYPFR7p/GWw0dLj2FDzj85qfW
	jADAZf5KDsj5MXTii7+wp2Qq4AN9koUt0O32DFv
X-Google-Smtp-Source: AGHT+IESu1bSSoBzB5nqzoFF3PfHWZIo4KgEJQzXY9utGFsChfVxXL25cc0A6B3IOicY135Y2/NTRQlEpsTJHyCGfVQ=
X-Received: by 2002:a17:907:9686:b0:ae3:6744:3680 with SMTP id
 a640c23a62f3a-afca4e438admr90567666b.42.1755041819532; Tue, 12 Aug 2025
 16:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811195901.1651800-1-memxor@gmail.com> <20250811195901.1651800-2-memxor@gmail.com>
 <CAEf4BzY6kEGAOpo6-DivyROL5Ma61Niun6X3ic76_jFoZ8DGZw@mail.gmail.com>
In-Reply-To: <CAEf4BzY6kEGAOpo6-DivyROL5Ma61Niun6X3ic76_jFoZ8DGZw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 Aug 2025 01:36:23 +0200
X-Gm-Features: Ac12FXye9Bnn1Hs5ggzbsova0NFfBF92iBhN1id_X2cRX01fFtPIc2D2a_AMrko
Message-ID: <CAP01T77+z8hoWWeBi9SGjdZQ=wEYkfowmz5Un0jk1yX7Tckq-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Do not limit bpf_cgroup_from_id to
 current's namespace
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, tj@kernel.org, Dan Schatzberg <dschatzberg@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 at 01:20, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Mon, Aug 11, 2025 at 12:59=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
> > cgroup corresponding to a given cgroup ID. This helper can be called in
> > a lot of contexts where the current thread can be random. A recent
> > example was its use in sched_ext's ops.tick(), to obtain the root cgrou=
p
> > pointer. Since the current task can be whatever random user space task
> > preempted by the timer tick, this makes the behavior of the helper
> > unreliable.
> >
> > Resolve this by refactoring cgroup_get_from_id to take a parameter to
> > elide the cgroup_is_descendant check when root_cgns parameter is set to
> > true.
> >
> > There is no compatibility breakage here, since changing the namespace
> > against which the lookup is being done to the root cgroup namespace onl=
y
> > permits a wider set of lookups to succeed now. The cgroup IDs across
> > namespaces are globally unique, and thus don't need to be retranslated.
> >
> > Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/cgroup.h   | 2 +-
> >  kernel/bpf/cgroup_iter.c | 2 +-
> >  kernel/bpf/helpers.c     | 2 +-
> >  kernel/cgroup/cgroup.c   | 7 ++++++-
>
> hmm... I see mm/memcontrol.c and block/blk-cgroup-fc-appid.c using
> this function as well, but you didn't update them, so under some
> kernel config this will break?

Yeah, addressed in upcoming v3, I also got a kernel test robot error
privately about it.

>
> but I'm also wondering if it wouldn't be cleaner to keep
> cgroup_get_from_id() as is, and add __cgroup_get_from_id(u64 id) that
> would not perform a cgroup_is_descendant() check. BPF helpers that
> don't need this root descendancy would call __cgroup_get_from_id()
> directly, while cgroup_get_from_id() would use __cgroup_get_from_id()
> first, and then (if successful) would perform addition root_cgrp
> check?

Yeah, I can refactor as such.

>
>
> >  4 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index b18fb5fcb38e..da757a496fbe 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -650,7 +650,7 @@ static inline void cgroup_kthread_ready(void)
> >  }
> >
> >  void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
> > -struct cgroup *cgroup_get_from_id(u64 id);
> > +struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns);
> >  #else /* !CONFIG_CGROUPS */
> >
> >  struct cgroup_subsys_state;
> > diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> > index f04a468cf6a7..49234d035583 100644
> > --- a/kernel/bpf/cgroup_iter.c
> > +++ b/kernel/bpf/cgroup_iter.c
> > @@ -212,7 +212,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *=
prog,
> >         if (fd)
> >                 cgrp =3D cgroup_v1v2_get_from_fd(fd);
> >         else if (id)
> > -               cgrp =3D cgroup_get_from_id(id);
> > +               cgrp =3D cgroup_get_from_id(id, false);
> >         else /* walk the entire hierarchy by default. */
> >                 cgrp =3D cgroup_get_from_path("/");
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6b4877e85a68..12466103917f 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2537,7 +2537,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64=
 cgid)
> >  {
> >         struct cgroup *cgrp;
> >
> > -       cgrp =3D cgroup_get_from_id(cgid);
> > +       cgrp =3D cgroup_get_from_id(cgid, true);
> >         if (IS_ERR(cgrp))
> >                 return NULL;
> >         return cgrp;
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 312c6a8b55bb..b490e1e0d2c4 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -6345,10 +6345,11 @@ void cgroup_path_from_kernfs_id(u64 id, char *b=
uf, size_t buflen)
> >  /*
> >   * cgroup_get_from_id : get the cgroup associated with cgroup id
> >   * @id: cgroup id
> > + * @root_cgns: Select root cgroup namespace instead of current's.
> >   * On success return the cgrp or ERR_PTR on failure
> >   * Only cgroups within current task's cgroup NS are valid.
> >   */
> > -struct cgroup *cgroup_get_from_id(u64 id)
> > +struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns)
> >  {
> >         struct kernfs_node *kn;
> >         struct cgroup *cgrp, *root_cgrp;
> > @@ -6374,6 +6375,10 @@ struct cgroup *cgroup_get_from_id(u64 id)
> >         if (!cgrp)
> >                 return ERR_PTR(-ENOENT);
> >
> > +       /* We don't need to namespace this operation against current. *=
/
> > +       if (root_cgns)
> > +               return cgrp;
> > +
> >         root_cgrp =3D current_cgns_cgroup_dfl();
> >         if (!cgroup_is_descendant(cgrp, root_cgrp)) {
> >                 cgroup_put(cgrp);
> > --
> > 2.47.3
> >

