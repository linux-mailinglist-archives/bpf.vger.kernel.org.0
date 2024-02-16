Return-Path: <bpf+bounces-22165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32A858319
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 17:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB741C22F51
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847C13249D;
	Fri, 16 Feb 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp2nI/JR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC113246E
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102476; cv=none; b=ZH1iFDrx7/xP3BtehTaE4vEMkai7mk6P0qtEVSDhRF0N6D9jlVXdNSm6RBHkbknB/wDJY2RE9rDMFki0EyKou3JWGEh5r80u/9QBs8Ezh1VvNDPg3iixuVEHMHOukIawafOwuX1k7XrR4ZHr0dRd7ema2rHx2y9N6PBZdq3AKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102476; c=relaxed/simple;
	bh=qCNO1B9EujBlyrbKZkI/lpmyUJVAQSbPIx/wkA7pxsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnG8p9RD6SXRAoj7d7QMFa7xiWl+BqjqrikSYWedV+RPSsd/vjbvjA35Nib9Fngp6V+lVUFfD+w/1wETdLlwczeV1YehXeMehXP2tJeVMh97N+fmg07jW1ez7kI6FXdESwUphRGVDos6iWDBJdwdVMFcTEGsVl7zRgf4fGzSxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp2nI/JR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbb47852cdso4340375ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708102474; x=1708707274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLA41j0HV9jJ2SCIVL0NuWzN0XY5DOTvnbV/ieH3Dm4=;
        b=Hp2nI/JROQqyGQXBXWz4tToJ53HqwzzBwSqKG9s34f2avLrJR1ccVR1pw/mA6QTar6
         jcNuQMH85DpZOdP3y0btj2Jw5x0Ctm3N9kQJ+scuoRbGLaXETnk970CLd/vu9XuibUYT
         4D9voZt50RzfcZRiztWngWCwlTKTvbgAMmrzyarC2le8R6WtkJhlIOfFbsKr0BN1i+dN
         s/zzEMaqNgST5fzxcpAgk5WDxGkt8JmHq1YfBypXFF+Gt0IwMwjJxRRBBo2fW7eekixU
         Xng0RwnyjdVPEe0oS6wBd5ByRSIDmX3eJsQM9PO4fe/xAJSSM3FB/kDOmNGBjDAtn2wQ
         L6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102474; x=1708707274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLA41j0HV9jJ2SCIVL0NuWzN0XY5DOTvnbV/ieH3Dm4=;
        b=gnr28uP435wffzZ6sZYi+ftUaYttrG69vQANY3mYSyrscJly/VpfSIAHWGV1NkB/0v
         j4YYH9kjLtVleQKT74ADiJIlXN+v2mnYjfFQFwZmaOwR0zRv2JV5ZhCDCC6vHuvTn54n
         qxQEFlOjFfLDHRI0M9/C7BQNlOfGAC8cP+XJ9ITgA2B8F0KYnJhp8QC0Hc2L0qJZN5u7
         qh3gKZ6uIP5HGRjwgv/zaNdp8EaZ2YWJKxotqHZMPJVY6QIY0llqm8/VJivkm+pbYPfd
         A7bJEoFHlLbv4vsgfpNJDVJzL/wUljSF+Phcryr8rNdAy8xGya+zx2Lez6if32xJwOTg
         mw/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLKqm16vC0Qm3MZgJdZ5HmTEQGyQe3d1GWGDhWTWVPBexKwfRFEiEdVPnsRD9EbBcWkwjOHGM51+w6RAyYNgZFvX4p
X-Gm-Message-State: AOJu0Yw0zjpJpo6yS7Okz3PT4GFxbnFbXreXw+muZ0nWTrntOQIz2rqc
	FjF4cabH9CZt+Q6T8W8gZCGe6IF8IONxr9ez7HnjwUqMJuK+KV3vlRdPfzc6mAYuwqZzLhiJK0/
	MXv/2HL0uYz3ok9tiLc1tDMuKOb2CImn7
X-Google-Smtp-Source: AGHT+IF2GoE6IVDwiREtOJOZg30FElKzdPbBtbFdCAkKk6hG6nx7q4J0rjypji4aMxwTjLJRL4Nwfp9AhSphd2Jr6wI=
X-Received: by 2002:a17:902:f60f:b0:1d9:bd7d:3c79 with SMTP id
 n15-20020a170902f60f00b001d9bd7d3c79mr7297906plg.26.1708102474210; Fri, 16
 Feb 2024 08:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214020836.1845354-1-thinker.li@gmail.com>
 <CAEf4BzbwZLMD=LWqZ_kmMeyLWvpzbeLGXSgWVQPSCsdnh+mufQ@mail.gmail.com> <65f8cbbc-0330-4df8-8e8b-79c389f82f78@gmail.com>
In-Reply-To: <65f8cbbc-0330-4df8-8e8b-79c389f82f78@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Feb 2024 08:54:22 -0800
Message-ID: <CAEf4BzZofuTRNP5CuNF-C_nrp-HBFAnQE3PSx0_xsj2ZcE09Vw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 0/3] Create shadow variables for struct_ops in skeletons
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:40=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 2/15/24 15:50, Andrii Nakryiko wrote:
> > On Tue, Feb 13, 2024 at 6:08=E2=80=AFPM <thinker.li@gmail.com> wrote:
> >>
> >> From: Kui-Feng Lee <thinker.li@gmail.com>
> >>
> >> This RFC is for gathering feedback/opinions on the design.
> >> Based on the feedback received for v1, I made some modifications.
> >>
> >> =3D=3D Pointers to Shadow Copies =3D=3D
> >>
> >> With the current implementation, the code generator will create a
> >> pointer to a shadow copy of the struct_ops map for each map. For
> >> instance, if we define a testmod_1 as a struct_ops map, we can access
> >> its corresponding shadow variable "data" using the pointer.
> >>
> >>      skel->struct_ops.testmod1->data
> >>
> >> =3D=3D Shadow Info =3D=3D
> >>
> >> The code generator also generates a shadow info to describe the layout
> >> of the data pointed to by all these pointers. For instance, the
> >> following shadow info describes the layout of a struct_ops map called
> >> testmod_1, which has 3 members: test_1, test_2, and data.
> >>
> >>      static struct bpf_struct_ops_member_info member_info_testmod_1[] =
=3D {
> >>          {
> >>                  .name =3D "test_1",
> >>                  .offset =3D .....,
> >>                  .size =3D .....,
> >>          },
> >>          {
> >>                  .name =3D "test_2",
> >>                  .offset =3D .....,
> >>                  .size =3D .....,
> >>          },
> >>          {
> >>                  .name =3D "data",
> >>                  .offset =3D .....,
> >>                  .size =3D .....,
> >>          },
> >>      };
> >>      static struct bpf_struct_ops_map_info map_info[] =3D {
> >>          {
> >>                  .name =3D "testmod_1",
> >>                  .members =3D member_info_testmod_1,
> >>                  .cnt =3D ARRAY_SIZE(member_info_testmod_1),
> >>                  .data_size =3D sizeof(struct_ops->testmod_1),
> >>          },
> >>      };
> >>      static struct bpf_struct_ops_shadow_info shadow_info =3D {
> >>          .maps =3D map_info,
> >>          .cnt =3D ARRAY_SIZE(map_info),
> >>      };
> >>
> >> A shadow info describes the layout of the shadow copies of all
> >> struct_ops maps included in a skeleton. (Defined in *__shadow_info())
> >
> > I must be missing something, but libbpf knows the layout of struct_ops
> > struct through BTF, why do we need all these descriptors?
>
> I explain it in the response for part 1.

yep, replied there. Let's keep it simple and restrict this
functionality to 64-bit host architecture

>
> >
> >>
> >> =3D=3D libbpf Creates Shadow Copies =3D=3D
> >>
> >> This shadow info should be passed to bpf_object__open_skeleton() as a
> >> part of "opts" so that libbpf can create shadow copies with the layout
> >> described by the shadow info. For now, *__open() in the skeleton will
> >> automatically pass the shadow info to bpf_object__open_skeleton(),
> >> looking like the following example.
> >>
> >>      static inline struct struct_ops_module *
> >>      struct_ops_module__open(void)
> >>      {
> >>          DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> >>
> >>          opts.struct_ops_shadow =3D struct_ops_module__shadow_info();
> >>
> >>          return struct_ops_module__open_opts(*** BLURB HERE ***opts);
> >>      }
> >>
> >> The function bpf_map__initial_value() will return the shadow copy that
> >> is created based on the received shadow info. Therefore, in the
> >> function *__open_opts() in the skeleton, the pointers to shadow copies
> >> will be initialized with the values returned from
> >> bpf_map__initial_value(). For instance,
> >>
> >>     obj->struct_ops.testmod_1 =3D
> >>          bpf_map__initial_value(obj->maps.testmod_1, NULL);
> >>
> >
> > I also don't get why you need to allocate some extra "shadow memory"
> > if we already have struct bpf_struct_ops->data pointer malloc()'ed
> > during bpf_map initialization, and its size matches exactly the
> > struct_ops's type size.
>
>
> I assume that the alignments & padding of BPF and the user space
> programs are different. (Check the response for part 1 as well)
>
> >
> >> This line of code will be included in the *__open_opts() function. If
> >> the opts.struct_ops_shadow is not set, bpf_map__initial_value() will
> >> return a NULL.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> DESCRIPTION form v1
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >
> > you probably don't need to keep cover letter from previous versions if
> > they are not relevant anymore
> >
> > [...]
>
>
> Sure!
> It explains what the feature is and how to use this feature.
> So, I keep it here for people just found this discussion.
>

Just lore link to the previous revision should be enough if anyone is
interested in history. Cover letter should represent the current state
of things.

> >
> >>
> >> ---
> >>
> >> v1: https://lore.kernel.org/all/20240124224130.859921-1-thinker.li@gma=
il.com/
> >>
> >> Kui-Feng Lee (3):
> >>    libbpf: Create a shadow copy for each struct_ops map if necessary.
> >>    bpftool: generated shadow variables for struct_ops maps.
> >>    selftests/bpf: Test if shadow variables work.
> >>
> >>   tools/bpf/bpftool/gen.c                       | 358 ++++++++++++++++=
+-
> >>   tools/lib/bpf/libbpf.c                        | 195 +++++++++-
> >>   tools/lib/bpf/libbpf.h                        |  34 +-
> >>   tools/lib/bpf/libbpf.map                      |   1 +
> >>   tools/lib/bpf/libbpf_internal.h               |   1 +
> >>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +-
> >>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
> >>   .../bpf/prog_tests/test_struct_ops_module.c   |  16 +-
> >>   .../selftests/bpf/progs/struct_ops_module.c   |   8 +
> >>   9 files changed, 596 insertions(+), 24 deletions(-)
> >>
> >> --
> >> 2.34.1
> >>

