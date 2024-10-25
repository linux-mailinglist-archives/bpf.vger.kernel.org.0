Return-Path: <bpf+bounces-43192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363DE9B111C
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 23:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32C8286AF8
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3C821620A;
	Fri, 25 Oct 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDYAoAkL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016B20C32F
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889922; cv=none; b=WDIGdxI6XmEACj/ezNjJih39c3f+j1NyxGNKlMO2BUOFTXnTkHy/LKjPOUkv+BEmCTrez5fhkNNj4f2zXmk/EUSFI22wcUCDzJk7WSPAK0eGvTon+PP0cAPs8ttQwcMb92gACBUdeTf9QZFXuP9OSkrMhZvTazkfjnSY8EzKdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889922; c=relaxed/simple;
	bh=rvLHlB8gHbXwjdToTsl8Fj8RUMFNxDWc7jWgFLfvvxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDB514WZ4wh6rfBsfYkKXyWf0XAbD4DGe1qQJyRx/D3Lalmq8Av2wmibW1cXRNX8XgepDDNgZmOKCsaNTev0XiwU86xTzwcO3qYGAvx6fJM3bgFTqy6a/6Py8mq1psvd0ugudpu9IGqfnTkz0xg/jsbQ7gy+YqSL7eGVlygrvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDYAoAkL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99e3b3a411so586658266b.0
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729889918; x=1730494718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBlR6dAVr3qp61guywM3To1J5+wBm9JfxYua5ZYdzeM=;
        b=lDYAoAkLKhulfDaMmwZuUQDzhwtE0SHV27tSV+w21eKitT+iu3IieZof3GVWzeCuMJ
         ort3jrAGhKG3R0z1AF7NnjOpslKbFb/sD4knMjYXI2QD0MRIdmodTNkfO7Ah1ImMf+c2
         LAHLp51BP9ONskehqixN2CVR+q5B+fat2t0kMvn92NroG2AHLwM5/+AVP649c1UOawWt
         jTPoJhfqtNce2OvTiG+yZi9ePhAXLlQF/aA40jLyE308eLFRnsB46O5jaQDhfQLNdKhg
         Yv7GFB+jS+LJAsG3QZnsZMeZMHmdxRLzhYYfTN/2pI4CIIyR+i0bldGWOlP0UbNj9u1Y
         xpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889918; x=1730494718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBlR6dAVr3qp61guywM3To1J5+wBm9JfxYua5ZYdzeM=;
        b=Kte4FrDSw7Rk2gTfTj8y/p3yiKJ9MyE4PUTwGi98zDJ/2wEUoI9b9Em8c4+HnUnyja
         YQNii5wwH76sSjkKlsEKyVTDqqcr4apDex0lMwmg8LjU4rnEwOqZg7+REoXKWkk1sc3N
         fIh9W0r6siBWGNeTkTbXChuhfi3MSp7ZmhcCptZ4oE6bUPz53AosXsco0qKEDQVTmRv4
         ugZzmy/xberuW54RWdBYW30AWjGEcoXcfs7xYaVfTHPrKPsLS2kB1BAD5x2t2qNkMcQp
         eKmLS4wuXYNYWai4BksOJoNzxP9GBZMzZYIoF0+M/uJaF4S+ZYxmw88a16d++fDnuFvR
         FKEw==
X-Forwarded-Encrypted: i=1; AJvYcCW2OUUhGxDy9r3I3dhzrtW8bt/0YjGrRZT0A6ZcqUpZVt5kIXEsoMsI8rJ7MMsX575KuYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64gtzqCEvkrkXlMxpN3k9L3fN14CLZFTWwWj3jv001sNGELB5
	wQ9/92ZRUAmqM1oGj7Nb1cteDO8ATxCMaV6pfK70oycZqgA1C6hEgOekqOsmxaeRI2z4cGbq4JH
	RFkdVZUaJPZLlCqrOJVNbOOZEcb/Pr3HH
X-Google-Smtp-Source: AGHT+IE24dS8yHWODdjrqKmVFJy2JewNLoAz966f5iq08RWAPf5PJSQA5pUQF1En9F8nxMYFChl0U+lLRsBDRl+MhgU=
X-Received: by 2002:a17:906:f5a5:b0:a99:4045:c88a with SMTP id
 a640c23a62f3a-a9de321855cmr69993666b.0.1729889917756; Fri, 25 Oct 2024
 13:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025153850.1791761-1-alan.maguire@oracle.com>
In-Reply-To: <20241025153850.1791761-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Oct 2024 13:58:03 -0700
Message-ID: <CAEf4Bza6nRG9S41NREVZRwxa=+nnnnkZOfKiyubi=rXoRBcD6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Add description of .BTF.base section
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 8:39=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Now that .BTF.base sections are generated for out-of-tree kernel
> modules (provided pahole supports the "distilled_base" BTF feature),
> document .BTF.base and its role in supporting resilient split BTF
> and BTF relocation.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  Documentation/bpf/btf.rst | 78 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 93060283b6fd..57992a9aa4f6 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -835,7 +835,7 @@ section named by ``btf_ext_info_sec->sec_name_off``.
>  See :ref:`Documentation/bpf/llvm_reloc.rst <btf-co-re-relocations>`
>  for more information on CO-RE relocations.
>
> -4.2 .BTF_ids section
> +4.3 .BTF_ids section
>  --------------------
>
>  The .BTF_ids section encodes BTF ID values that are used within the kern=
el.
> @@ -896,6 +896,82 @@ and is used as a filter when resolving the BTF ID va=
lue.
>  All the BTF ID lists and sets are compiled in the .BTF_ids section and
>  resolved during the linking phase of kernel build by ``resolve_btfids`` =
tool.
>
> +4.4 .BTF.base section
> +---------------------
> +Split BTF - where the .BTF section only contains types not in the associ=
ated
> +base .BTF section - is an extremely efficient way to encode type informa=
tion
> +for kernel modules, since they generally consist of a few module-specifi=
c
> +types along with a large set of shared kernel types.  The former are enc=
oded
> +in split BTF, while the latter are encoded in base BTF, resulting in mor=
e
> +compact representations.  A type in split BTF that referes to a type in

typo: refers

> +base BTF refers to it using its base type id, and split BTF type ids sta=
rt

let's use consistent ID/IDs spelling in documentation everywhere

> +at last_base_type + 1.
> +
> +The downside of this approach however is that this makes the split BTF
> +somewhat brittle - when the base BTF changes, these base id references a=
re
> +no longer valid and the split BTF itself becomes useless.  The role of t=
he
> +.BTF.base section is to make split BTF more resilient for cases where
> +the base BTF may change, as is the case for kernel modules not built eve=
ry
> +time the kernel is for example.  .BTF.base contains named base types; IN=
Ts,
> +FLOATs, STRUCTs, UNIONs, ENUM[64]s and FWDs.  INTs and FLOATs are fully
> +described in .BTF.base sections, while composite types like structs
> +and unions are not fully defined - the .BTF.base type simply serves as
> +a description of the type the split BTF referred to, so struct/unions
> +has 0 members in the .BTF.base section.  ENUM[64]s are similarly recorde=
d
> +with 0 members.  Any other types are added to the split BTF.  This
> +distillation process then leaves us with a .BTF.base section with
> +such minimal descriptions of base types and .BTF split section which ref=
ers
> +to those base types.  Later, we can relocate the split BTF using both th=
e
> +information stored in the .BTF.base section and the new BTF base; the ty=
pe
> +information in the .BTF.base section allows us to update the split BTF
> +references to point at the corresponding new base BTF types.
> +
> +BTF relocation happens on kernel module load when a kernel module has a
> +.BTF.base section, and libbpf also provides a btf__relocate() API to
> +accomplish this.
> +
> +As an example consider the following base BTF:
> +
> +[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> +[2] STRUCT 'foo' size=3D8 vlen=3D2
> +        'f1' type_id=3D1 bits_offset=3D0
> +        'f2' type_id=3D2 bits_offset=3D32
> +
> +...and associated split BTF:
> +
> +[3] PTR '(anon)' type_id=3D2
> +
> +i.e. split BTF describes a pointer to struct foo { int f1; int f2 };
> +
> +.BTF.base will consist of
> +
> +[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> +[2] STRUCT 'foo' size=3D8 vlen=3D0
> +
> +..so if we relocate the split BTF later using the following new base
> +BTF:
> +
> +[1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encodi=
ng=3D(none)
> +[2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> +[3] STRUCT 'foo' size=3D8 vlen=3D2
> +        'f1' type_id=3D2 bits_offset=3D0
> +        'f2' type_id=3D2 bits_offset=3D32
> +
> +...we can use our .BTF.base description to know that the split BTF refer=
ence
> +is to struct foo, and relocation results in:
> +
> +[4] PTR '(anon)' type_id=3D3
> +
> +Note that we had to update type id and start BTF id for the split BTF.
> +
> +So we see how .BTF.base plays the role of facilitating later relocation,
> +leading to more resilient split BTF.
> +
> +.BTF.base sections will be generated automatically for out-of-tree kerne=
l module
> +builds - i.e. where KBUILD_EXTMOD is set (as it would be for "make M=3Dp=
ath/2/mod"
> +cases).  .BTF.base generation requires pahole support for the "distilled=
_base"
> +BTF feature; this is available in pahole v1.28 and later.
> +

I don't think we use double space after dot format, please don't
introduce your own conventions. Single space ought to be enough, no?

pw-bot: cr


>  5. Using BTF
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.43.5
>

