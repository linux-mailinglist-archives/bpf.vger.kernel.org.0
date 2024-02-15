Return-Path: <bpf+bounces-22114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDB8571F9
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 00:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F11285961
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45737148308;
	Thu, 15 Feb 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+1hK1Z1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDBC1474B2
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041040; cv=none; b=h1VT/nIhZqfaNxC0KQznmimvzukbukKWxa74O8L250QtN+cgj+IL1MD0QEWhlrl7s7IvROnsDsj9n2Ybc7Ulnr78+EnkRtmFMZd9QpTAUDKHUCy/ZW7Ea3HkubSNn/PFyCa7vc4GzJvFmFYl/OQVbSiet42MFkEs5KTQttbhfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041040; c=relaxed/simple;
	bh=uKUWm3PMhjFtFHeFWw8EhAtpTZd+prB4MRN26iBOQUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX/5WEqBofPvUSZMkKDtv0enGsPJf4tsRg5Hm9LwX0vjBSHftwjQoS6zYl3vc3v3AwPLoRDitUfjCK1WOqAtT2zaBOV8LOEIJXPLvT/0sPIPYv2MTjgvlsiijrwmsTLNJWj/M/zUMgsg6FOvq4t8UgTAxO5cahDReRxzE7IE8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+1hK1Z1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so282197a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708041038; x=1708645838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyMcaCeL2BTEkhB/Uc+5/E5qc9E7Xp5T2M7ChgSN3Xs=;
        b=j+1hK1Z1LoNFZGvu00zcV2M5gASWvWgpvv9EoG2t5jiBRPmwp9tgALmMLfIrTgNY/w
         fq/czu6GroAMIMrxV1Q+O6snWhwhbWt7YKBK2sK4LicOoOvAj3kyEKbHZ0LfvMhrgnA7
         ZoloWrfG6U5MjfvBldDFjm7KkQFOkCJvEyN4d6+rDijjJMbq8LE8Qe/LqPcNpQzF5Elf
         6NLnlRO4At/PaoQqISF36x+i/WX55qZWxyIJMT54VlJXfrrdLqwLVn/HkXX0bFjKHFsT
         FH2JxF7LAwQSbHV910BjT2IcFfc+eZUzkpUoaCypSqDyHMXVnchS4NtCMuRnzlt6jq10
         2JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708041038; x=1708645838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyMcaCeL2BTEkhB/Uc+5/E5qc9E7Xp5T2M7ChgSN3Xs=;
        b=e5Mtvp2PW6wzyadYwqRildW82H/xS2kPAitYQi8S+oFw0QplDtVmMLtyQ/ReE413rM
         /Cfopv8IwksTgyRLJ7N5MPAws0puLC1pdQYMWehZXozP/cdd0Sadz7BjwDyBRNzhxAQu
         0Yhf9vCUmQZD08yXX8aSJEkBg9HeY3K+1raghdvYoaK2hyHs3BP86wBw5n+2o1kc/PaY
         34yVXjiHgiR+droNaBYiyhUT8l3cvJTdZMovptxQ7wzztOLfzXbWaKr/m6tsxoti4JRH
         AbQvTdYSN/Gqk0/X19m94pmXbPyB9ts0NAvV6cmUOnLLxnW1sOP6MWlpXUEj8cfG8n84
         UPzw==
X-Gm-Message-State: AOJu0YxLpw581e6/zgU258NaHuXkkebDXTdmZKPxHUtSXeIT/4R59rcg
	Ld/FjC1BFPC5I41c/8B1Ye6OwX4jRL1BCqS5Jw0n2UAi7YDYozSEaDCfGxMQdRdlPUeLEk5zTMC
	r34xXtW9yW/kmb1jOAo/QdUkcZ8c=
X-Google-Smtp-Source: AGHT+IHL4X7oj+SNglwNgn+EV6Elbhek8ZIGg4vz3OTvf+0wx176KsDeFw0n2zhPB8QdsJDBEukfG77OlxIMgPATwXQ=
X-Received: by 2002:a17:90b:381:b0:299:336e:512d with SMTP id
 ga1-20020a17090b038100b00299336e512dmr453317pjb.11.1708041038381; Thu, 15 Feb
 2024 15:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214020836.1845354-1-thinker.li@gmail.com>
In-Reply-To: <20240214020836.1845354-1-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 15:50:26 -0800
Message-ID: <CAEf4BzbwZLMD=LWqZ_kmMeyLWvpzbeLGXSgWVQPSCsdnh+mufQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 0/3] Create shadow variables for struct_ops in skeletons
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:08=E2=80=AFPM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> This RFC is for gathering feedback/opinions on the design.
> Based on the feedback received for v1, I made some modifications.
>
> =3D=3D Pointers to Shadow Copies =3D=3D
>
> With the current implementation, the code generator will create a
> pointer to a shadow copy of the struct_ops map for each map. For
> instance, if we define a testmod_1 as a struct_ops map, we can access
> its corresponding shadow variable "data" using the pointer.
>
>     skel->struct_ops.testmod1->data
>
> =3D=3D Shadow Info =3D=3D
>
> The code generator also generates a shadow info to describe the layout
> of the data pointed to by all these pointers. For instance, the
> following shadow info describes the layout of a struct_ops map called
> testmod_1, which has 3 members: test_1, test_2, and data.
>
>     static struct bpf_struct_ops_member_info member_info_testmod_1[] =3D =
{
>         {
>                 .name =3D "test_1",
>                 .offset =3D .....,
>                 .size =3D .....,
>         },
>         {
>                 .name =3D "test_2",
>                 .offset =3D .....,
>                 .size =3D .....,
>         },
>         {
>                 .name =3D "data",
>                 .offset =3D .....,
>                 .size =3D .....,
>         },
>     };
>     static struct bpf_struct_ops_map_info map_info[] =3D {
>         {
>                 .name =3D "testmod_1",
>                 .members =3D member_info_testmod_1,
>                 .cnt =3D ARRAY_SIZE(member_info_testmod_1),
>                 .data_size =3D sizeof(struct_ops->testmod_1),
>         },
>     };
>     static struct bpf_struct_ops_shadow_info shadow_info =3D {
>         .maps =3D map_info,
>         .cnt =3D ARRAY_SIZE(map_info),
>     };
>
> A shadow info describes the layout of the shadow copies of all
> struct_ops maps included in a skeleton. (Defined in *__shadow_info())

I must be missing something, but libbpf knows the layout of struct_ops
struct through BTF, why do we need all these descriptors?

>
> =3D=3D libbpf Creates Shadow Copies =3D=3D
>
> This shadow info should be passed to bpf_object__open_skeleton() as a
> part of "opts" so that libbpf can create shadow copies with the layout
> described by the shadow info. For now, *__open() in the skeleton will
> automatically pass the shadow info to bpf_object__open_skeleton(),
> looking like the following example.
>
>     static inline struct struct_ops_module *
>     struct_ops_module__open(void)
>     {
>         DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>
>         opts.struct_ops_shadow =3D struct_ops_module__shadow_info();
>
>         return struct_ops_module__open_opts(*** BLURB HERE ***opts);
>     }
>
> The function bpf_map__initial_value() will return the shadow copy that
> is created based on the received shadow info. Therefore, in the
> function *__open_opts() in the skeleton, the pointers to shadow copies
> will be initialized with the values returned from
> bpf_map__initial_value(). For instance,
>
>    obj->struct_ops.testmod_1 =3D
>         bpf_map__initial_value(obj->maps.testmod_1, NULL);
>

I also don't get why you need to allocate some extra "shadow memory"
if we already have struct bpf_struct_ops->data pointer malloc()'ed
during bpf_map initialization, and its size matches exactly the
struct_ops's type size.

> This line of code will be included in the *__open_opts() function. If
> the opts.struct_ops_shadow is not set, bpf_map__initial_value() will
> return a NULL.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> DESCRIPTION form v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

you probably don't need to keep cover letter from previous versions if
they are not relevant anymore

[...]

>
> ---
>
> v1: https://lore.kernel.org/all/20240124224130.859921-1-thinker.li@gmail.=
com/
>
> Kui-Feng Lee (3):
>   libbpf: Create a shadow copy for each struct_ops map if necessary.
>   bpftool: generated shadow variables for struct_ops maps.
>   selftests/bpf: Test if shadow variables work.
>
>  tools/bpf/bpftool/gen.c                       | 358 +++++++++++++++++-
>  tools/lib/bpf/libbpf.c                        | 195 +++++++++-
>  tools/lib/bpf/libbpf.h                        |  34 +-
>  tools/lib/bpf/libbpf.map                      |   1 +
>  tools/lib/bpf/libbpf_internal.h               |   1 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +-
>  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
>  .../bpf/prog_tests/test_struct_ops_module.c   |  16 +-
>  .../selftests/bpf/progs/struct_ops_module.c   |   8 +
>  9 files changed, 596 insertions(+), 24 deletions(-)
>
> --
> 2.34.1
>

