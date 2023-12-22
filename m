Return-Path: <bpf+bounces-18626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75581CFA8
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 23:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0551C22C7A
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37F2EAFE;
	Fri, 22 Dec 2023 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu5JnpDH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F12EAE0
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3368ae75082so1125780f8f.1
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 14:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703283107; x=1703887907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vzfYgJnEcKLNF1jKJSRJKqzfV/NlSLYfF2jY7QlvHI=;
        b=Wu5JnpDH7vjeJ4zfGjAlNc1gIha2JT4UDAUg0K/E22RBtMFmH3uImP796jgRhuMMT2
         ofq7AtCXlzMjQ8iedwrUh8utcULNhcBEMwElIWWmykLwhC5Jbc/WWBT8EAAkSEArl88d
         p+Yx8afyDQ357J6bxw8KFLQbMFgsoYGr1Dr/aGPsnawdxkmkhybPqeAhHS2bikQXU/J/
         LSrlkYP3crLjImKA/hV1Lq29ODLMDFEOz2C2iqnjiKSb1AhFWL4oXjNV9lbUxASN7i07
         j3LPxxD15yPlL35S8PXq/agAy1VVfTOvj1oTQ0gxNZlYaRbRCy9VorxqEEUZ9C/eoH3r
         WDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283107; x=1703887907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vzfYgJnEcKLNF1jKJSRJKqzfV/NlSLYfF2jY7QlvHI=;
        b=wXBeuas5Nd+Nt45jdpPVG1ySeHNKLMqyTpJ7XJ7HzKt0U2dMkvVrKrvMQJo8mF04q3
         Gg5wGAMo0CgKqbgpPwioZyjYjOm2xgBgaFCRaKDD6RZA3X9oQmTpkZNpIZoXkNAE2hP5
         riKU/IP0YvWWnTyMwz5XJvqIDX5gQgRxWecYXO8uwCE8FdgfRlm4hFKoeBo1ZLMh8sVQ
         jI/Zrbnj3ihjfDIpK0KUTA1NaJnmCJX53B0mdkghr968a8ijNKYQP2f9+A8qIU+C19Tg
         I2lb32VuJOXCFmQw8XwcWKcAoz6IkJ9o2c6OkNupjLUxpOsdS1EB/NagxqUhM5K8L6Uh
         WijA==
X-Gm-Message-State: AOJu0YzdRl7ghWS4tFDxJ40l1+eLwDwF6/W8U/lHJEbBVu2HYirAsn38
	E25L7Dv+MW4btD4mr/PxpR90UTlujuWA+IFufNM=
X-Google-Smtp-Source: AGHT+IFo/VZOTtja8gmT3ZoZeExFJShF1PsG/CNpPWQdqF+59UwBT+fAs/9OvWKt5MoDIe+CK6VGU96qu7zz0TnVrjQ=
X-Received: by 2002:a05:600c:3d8c:b0:40d:4d79:5cc3 with SMTP id
 bi12-20020a05600c3d8c00b0040d4d795cc3mr274800wmb.73.1703283106720; Fri, 22
 Dec 2023 14:11:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava> <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com> <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
 <64f6db18-ebd5-501b-2457-a8abe6187a0f@oracle.com> <ZYWFQ62dASM5InBZ@krava>
 <00df5193-bde2-fc03-0d88-313cf6ac71b6@oracle.com> <bzmrkewfmwfjp5zq2ct6s3hgnf74q463fxpyphkk7ai7cyki5c@eknreyedyeaf>
In-Reply-To: <bzmrkewfmwfjp5zq2ct6s3hgnf74q463fxpyphkk7ai7cyki5c@eknreyedyeaf>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Dec 2023 14:11:35 -0800
Message-ID: <CAADnVQLk3zSD1ygBQ7yExoR6xFLfH7_4wmCdBiSVbvgj-ZZZvA@mail.gmail.com>
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
>
> > From a user
> > perspective though can we always assume the BTF id sets of kfuncs alway=
s
> > match the set of available kfuncs? If the goal of this feature is to se=
e
> > which kfuncs are available to be used, we'd need some form of active
> > participation by the kernel in producing the registered list I think.
> > But again, depends what the goal is here.
>
> The goal is to query for available kfuncs.

The list of available kfuncs across all modules and prog types
doesn't really help the users to know whether their program
will be accepted if they use this kfunc.
Today kfuncs are grouped by prog type, but soon it will be more
fine grained. We need to allow different set of kfuncs depending
on struct_ops attach point and potentially flags at hook attach point.
So the list of kfuncs is similar to the list of helpers.

Adding kfunc btf_decl_tag to vmlinux BTF and module BTF only
helps with generation of vmlinux.h or module.h so that the users
don't need to manually write __ksym protos in their programs.
Analogous to generation of bpf_helper_defs.h.

re: your other email. Extra ~6k for vmlinux BTF is fine.
As Dave suggested in the other email let's make sure that dedup
removes the duplicated decl_tags or pahole doesn't add another
one if btf_decl_tag is already present in __bpf_kfunc macro.
pahole will essentially be a workaround for lack of btf_decl_tag in GCC.

