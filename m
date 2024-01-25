Return-Path: <bpf+bounces-20352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3883CF3F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 23:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556101C2201E
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 22:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A313AA57;
	Thu, 25 Jan 2024 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFOdnmBv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC4130E3C
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221296; cv=none; b=imHLBEkDlamU2A/J2LBlucHqNsblVPRAG6O6ZPEwWWsekVv/k2u6atiPMQlQqtQ97QPhzPh7ZDnEKS5kq6MNbGrUN/iDGhAOfCX85WuK+9lo1yDSN8D5sOitgxeQh1FpVrUokJMM9qJdb013ftsg+d7I8S7pRYCiJa+t9xAV/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221296; c=relaxed/simple;
	bh=QpSX3xJL67yhP4XVKBwiuSowyYswC5F7a7fBfYp+d74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJTkA+INT0pwn/NRwNNAMmbBb9ObFFsJpdqHoblNyu8jaICr5EWwUkRHTFdYZyzipyPZQVpQsoSSQdjhI0hoy2s4/CgzvXv0SOZZoN2J4Djsc8E9GEECPdc0hdD8jvVOouxWkwaVP2QcmPkNn5yh89w13KORQQNwnkuM+5f4diY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFOdnmBv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso5496746a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 14:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706221294; x=1706826094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIkuu2R5PPBx/jiKdPU0YL1SzedJzRwBKIrEVGLhQGk=;
        b=lFOdnmBv4FdfcrmMpAERig7LIwD80KjyKAWfa9UfCBFY6q6fOhQT7+v/UVa0+CDwAE
         db3XLr4ZuenqUvkBYj1yjZZP8PonyxKTK9cc7sl2CvkwYVcb7RUc5cBJt5CcgrnpoAyp
         bLaaSUrgfPlfRpyrTuQv7i5PxmlddGyQSRi7PLjUUd5rcp7CHVp7RtHiKiQ9AhvHOIMl
         BdvRz58/NLV4kUiEpw53KRdw1rVdy+fuiwhoeX/icoVvvYmGq4jKExu9espq/ZGcJhur
         3LfG+Yj0zYI2hxYNCUX9tAoo4jREA7Ojevhr5XiIVTPdfFIhkO8FYSGfMsSctna+4Fcw
         AUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221294; x=1706826094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIkuu2R5PPBx/jiKdPU0YL1SzedJzRwBKIrEVGLhQGk=;
        b=ghZY5j1TIp2sYxgJfJ+P5J4fZSIspTsmZI9X1oUmAih3wHrP5Pkf0iBxT7reHFUt20
         AU6G1mUxMQmm50zba2gzwmE9O5efGMA7wgfyhfLqG9rOlkgGTZc15YQhYdYBs7eEMYKj
         YXXm7NXT6UfN8lOkUhYZwEj2neCifBewM85AYbE8KzAzVfgfaUToNqC5fsAwSPW6B6A0
         alJJfC0PUKV1iGiOxjsIQPBMcdzrvmx9UtIrZd6kueV3++ZYs2lwi9QjJ7hokhKPo9kY
         LKxxKZL7SdZqu3C019foPVA3egYwdLgIV5mX1BDIDYuxsFqtlIn93DODqNEyNSmsZBNX
         RJtw==
X-Gm-Message-State: AOJu0YyhBt2rQMMvwqx3SFMh3cg3neaPSXxc08nf3uFbTyTjMFP6ldpF
	Ti501V+G2ej5vheCiqD/jqMYBBs9CC7ZKEaEKe/jLhneVjOSt3m/bs+8ZAuk/Qh7OA79u+n82jl
	LCC0xDOuD4uhpMORHU81YFEtr0XY=
X-Google-Smtp-Source: AGHT+IGzrIUdBKFOfXbpZnQduD5SdbOr9kbWhRIqpf/X2SsD26/wFkwTBPO+9yTVHwZN+91CD/c06NBU0no6g8qnbZw=
X-Received: by 2002:a17:90a:fe0d:b0:28e:df2:708a with SMTP id
 ck13-20020a17090afe0d00b0028e0df2708amr263567pjb.53.1706221294491; Thu, 25
 Jan 2024 14:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124224130.859921-1-thinker.li@gmail.com>
In-Reply-To: <20240124224130.859921-1-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jan 2024 14:21:22 -0800
Message-ID: <CAEf4BzZaFh3BaDYhTAWCuZBZ9t_2C2iXOsCGF88LeNb+ndVaXg@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: Create shadow variables for struct_ops in skeletons.
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:41=E2=80=AFPM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> Create shadow variables for the fields of struct_ops maps in a skeleton
> with the same name as the respective fields. For instance, if struct
> bpf_testmod_ops has a "data" field as following, you can access or modify
> its value through a shadow variable also named "data" in the skeleton.
>
>   SEC(".struct_ops.link")
>   struct bpf_testmod_ops testmod_1 =3D {
>       .data =3D 0x1,
>   };
>
> Then, you can change the value in the following manner as shown in the co=
de
> below.
>
>   skel->st_ops_vars.testmod_1.data =3D 13;
>
> It is helpful to configure a struct_ops map during the execution of a
> program. For instance, you can include a flag in a struct_ops type to
> modify the way the kernel handles an instance. By implementing this
> feature, a user space program can alter the flag's value prior to loading
> an instance into the kernel.
>
> The code generator for skeletons will produce code that copies values to
> shadow variables from the internal data buffer when a skeleton is
> opened. It will also copy values from shadow variables back to the intern=
al
> data buffer before a skeleton is loaded into the kernel.
>
> The code generator will calculate the offset of a field and generate code
> that copies the value of the field from or to the shadow variable to or
> from the struct_ops internal data, with an offset relative to the beginni=
ng
> of the internal data. For instance, if the "data" field in struct
> bpf_testmod_ops is situated 16 bytes from the beginning of the struct, th=
e
> address for the "data" field of struct bpf_testmod_ops will be the starti=
ng
> address plus 16.
>
> The offset is calculated during code generation, so it is always in line
> with the internal data in the skeleton. Even if the user space programs a=
nd
> the BPF program were not compiled together, any differences in versions
> would not impact correctness. This means that even if the BPF program and
> the user space program reference different versions of the "struct
> bpf_testmod_ops" and have different offsets for "data", these offsets
> computed by the code generator would still function correctly.
>
> The user space programs can only modify values by using these shadow
> variables when the skeleton is open, but before being loaded. Once the
> skeleton is loaded, the value is copied to the kernel, and any future
> changes only affect the shadow variables in the user space memory and do
> not update the kernel space. The shadow variables are not initialized
> before opening a skeleton, so you cannot update values through them befor=
e
> opening.
>
> For function pointers (operators), you can change/replace their values wi=
th
> other BPF programs. For example, the test case in test_struct_ops_module.=
c
> points .test_2 to test_3() while it was pointed to test_2() by assigning =
a
> new value to the shadow variable.
>
>   skel->st_ops_vars.testmod_1.test_2 =3D skel->progs.test_3;
>
> However, you need to turn off autoload for test_2() since it is not
> assigned to any struct_ops map anymore. Or, it will fails to load test_2(=
).
>
>  bpf_program__set_autoload(skel->progs.test_2, false);
>
> You can define more struct_ops programs than necessary. However, you need
> to turn autoload off for unused ones.

Overall I like the idea, it seems like a pretty natural and powerful
interface. Few things I'd do a bit differently:

- less code gen in the skeleton. It feels like it's better to teach
libbpf to allow getting/setting intial struct_ops map "image" using
standard bpf_map__initial_value() and bpf_map__set_initial_value().
That fits with other global data maps.

- I think all struct ops maps should be in skel->struct_ops.<name>,
not struct_ops_vars. I'd probably also combine struct_ops.link and
no-link struct ops in one section for simplicity

- getting underlying struct_ops BTF type should be possible to do
through bpf_map__btf_value_type_id(), no need for struct_ops-specific
one

- you have a bunch of specific logic to dump INT/ENUM/PTR, I wonder if
we can just reuse libbpf's BTF dumping API to dump everything? Though
for prog pointers we'd want to rewrite them to `struct bpf_program *`
field, not sure yet how hard it is.

The above is brief, so please ask questions where it's not clear what
I propose, thanks!

[...]

