Return-Path: <bpf+bounces-63391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EFB06A86
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E6F3ABB60
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A567B3E1;
	Wed, 16 Jul 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1hT0i3a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039BC74040;
	Wed, 16 Jul 2025 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625904; cv=none; b=SU30qRVu2gzwpA0lOuV/fCIJstEM+nVDoJ6xlIwOkW+MCYdxBqmRf5jglPMvroof9StvCxV7FLNgKztqGcH4zJy8rP5lbgUJTQrzPIVubiIBfj7Qa4X89KtRo8Gl7rXg28Tp+gm0+RkwkknjuCm+5a1gk3vT23ZYRw10uxq9r2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625904; c=relaxed/simple;
	bh=7eQgKzaHVCtbh5Th5oGm0PkfPyHX0sdchUQoH8TKrl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1rTL6H4++4HM1UPlxw9VL2/N3KlUTSRaHNJCS37z5yJUxK84Q5SapbpVrKluxtxBcNFs68Y5uDE6sx88HL7frK2jtG9kfrLLYSjg+FKQl4ACbmyx4ekTEYVmKO/U9JCzbEZpJHJIGh0thxyeco8kJmLR2b67tyAzQMLziG4Zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1hT0i3a; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so3419092f8f.0;
        Tue, 15 Jul 2025 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625901; x=1753230701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjTmZqsGwwZX24g6Zl1t7K6+Hwg2JfoMR3T6ChDoynE=;
        b=D1hT0i3aQTWngawHPMBm10xm1QjbGzDpXk+a9SgGr8hvIge1gWCsAjOE/TTkg3FsHC
         8ujVmR9hj/r/8NasOAufSKvrWiDhDPdXAS6eJawo3QnVf6bWLYvDxwURfk/IkSEV0sa2
         V/DrwxeocljEhrAzk6GeV0illaO4IcwSOb5L0dZOBlBOOsJVRtoyANchNRnypdBjnyTo
         PAWQgPHHQcgYGOq15ieVoqpulWwitYr0apqB/sa6haAQdNCLglhZxfgIMj5auz7s7Pkg
         zULCA9Q2WkHN1dJIInLiEPNvjGQQlj1pH2uJl5e/z517koLkrs/kmMrHh5Ut6SVLnKXc
         Nh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625901; x=1753230701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjTmZqsGwwZX24g6Zl1t7K6+Hwg2JfoMR3T6ChDoynE=;
        b=Y9+bzQLz9+WSxuRfiiCsgahPYlUMpp5AqPH9T1ndumXJdrkFMKQIplshlv6XeyjBX+
         /gBOWuJm9yif+sVbss/GytZSX5A5F03cI9CZEWwuhGNCNzVOZdnk/8hWZHjpXgRM4bcJ
         nRwevUm2PT9JmGykW2KFptCV53jFs6t6l/nvRTOpdpwxcFfamV9HvzuuPjYT5/hYjBs+
         aZZ77yR17hR4ukz+Hn0eKZYYqncKJ7PB8afBnRk/puoE11F2fxntAgevYxVacRmLSNar
         mUUhQOS1l0KCRf5Lk+hGXW+nCjMxNn4xa8AQQT0VRaIycaMp5tqq8IeyCxzgAMC4cukB
         ZqKg==
X-Forwarded-Encrypted: i=1; AJvYcCVaX4WpMjQlOVovyfUwUzR16JEw/H0tFPJ5q4RijuzgdC6fqpEXlxEHJtw5ho1Z/jIKzDTnQx2YPA==@vger.kernel.org, AJvYcCXXMU20bTQgOeVU0p1FGtsrBkDa5DvvbnKE1VLEBWbNMXp/+1auMA6KfT4qS2sruvuu+6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4c4HgLhGfOZwQ6rpj6A2D3OAe6gIrXdemR2j37QxJkztnAkR
	o233kRKWVmIdBhcscNO91iuLGU7aAOQEyjzmG7Jn6wRHmqC+6yCv3mxdDRo8JGFOaNG4Xm6U2Av
	2e9GCzupPxTbkcFqJtSPUy4HRUYc3kl0=
X-Gm-Gg: ASbGncu1TjYV6ezGPdRDShGP6gsV8zTw+fSy8Td5vRML1ToZsH27XMmT8gVsaI2Bag+
	1kZsOwEKhC5V9o2TNPlrFZ3GEZEUJ+23DPXHXdxOCaHes1pVFnZJ5jyKcIb62lU/S/fG5LRF5/r
	MvEtqtuR+rcbKvg0DfDTyGxI8WWhfu1LJuG22fuHrzDG5/MkAuTbmic3u/fxnZmG2ai7yVJGLGG
	vBCehsG9bu73vX4mXWH50HpHXa33FbiHc+U
X-Google-Smtp-Source: AGHT+IG4ks03N8t5m8d/yZLzmsmg3EoYDRc4B1K4gETR9ezwFcTuKQNM9fl5uGW1J6/LfZUsXG6GXIEqS31OLZ+j9/o=
X-Received: by 2002:a05:6000:4382:b0:3b3:9c56:b834 with SMTP id
 ffacd0b85a97d-3b60e4c513emr368588f8f.1.1752625901073; Tue, 15 Jul 2025
 17:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-18-dongml2@chinatelecom.cn> <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
 <9771eaa3-413a-4ab0-b7e1-d6a6f326c43f@linux.dev> <3dfbc97c-5721-4bd7-9443-ce57d7ba592c@linux.dev>
In-Reply-To: <3dfbc97c-5721-4bd7-9443-ce57d7ba592c@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Jul 2025 17:31:30 -0700
X-Gm-Features: Ac12FXw6CNKA5PuLbyba2uihUtE7H-L_HI3TIaOagYbvpi9c4uKcgiq9H2EiysQ
Message-ID: <CAADnVQK-06d8E85aJ-=K+Af+a8_MSNJFiBqjpXYs4+adiTuwvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] selftests/bpf: add basic testcases for tracing_multi
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves <dwarves@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 5:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 7/14/25 4:49 PM, Ihor Solodrai wrote:
> > On 7/8/25 1:07 PM, Alexei Starovoitov wrote:
> >> On Thu, Jul 3, 2025 at 5:18=E2=80=AFAM Menglong Dong
> >> <menglong8.dong@gmail.com> wrote:
> >>>
> >>> +               return true;
> >>> +
> >>> +       /* Following symbols have multi definition in kallsyms, take
> >>> +        * "t_next" for example:
> >>> +        *
> >>> +        *     ffffffff813c10d0 t t_next
> >>> +        *     ffffffff813d31b0 t t_next
> >>> +        *     ffffffff813e06b0 t t_next
> >>> +        *     ffffffff813eb360 t t_next
> >>> +        *     ffffffff81613360 t t_next
> >>> +        *
> >>> +        * but only one of them have corresponding mrecord:
> >>> +        *     ffffffff81613364 t_next
> >>> +        *
> >>> +        * The kernel search the target function address by the symbo=
l
> >>> +        * name "t_next" with kallsyms_lookup_name() during attaching
> >>> +        * and the function "0xffffffff813c10d0" can be matched, whic=
h
> >>> +        * doesn't have a corresponding mrecord. And this will make
> >>> +        * the attach failing. Skip the functions like this.
> >>> +        *
> >>> +        * The list maybe not whole, so we still can fail......We nee=
d a
> >>> +        * way to make the whole things right. Yes, we need fix it :/
> >>> +        */
> >>> +       if (!strcmp(name, "kill_pid_usb_asyncio"))
> >>> +               return true;
> >>> +       if (!strcmp(name, "t_next"))
> >>> +               return true;
> >>> +       if (!strcmp(name, "t_stop"))
> >>> +               return true;
>
> This little patch will filter out from BTF any static functions with
> the same name that appear more than once.
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0bc2334..6441269 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -96,7 +96,8 @@ struct elf_function {
>          const char      *name;
>          char            *alias;
>          size_t          prefixlen;
> -       bool            kfunc;
> +       uint8_t         is_static:1;
> +       uint8_t         kfunc:1;
>          uint32_t        kfunc_flags;
>   };
>
> @@ -1374,7 +1375,7 @@ static int saved_functions_combine(struct
> btf_encoder_func_state *a, struct btf_
>                  return ret;
>          optimized =3D a->optimized_parms | b->optimized_parms;
>          unexpected =3D a->unexpected_reg | b->unexpected_reg;
> -       inconsistent =3D a->inconsistent_proto | b->inconsistent_proto;
> +       inconsistent =3D a->inconsistent_proto | b->inconsistent_proto |
> a->elf->is_static | b->elf->is_static;
>          if (!unexpected && !inconsistent && !funcs__match(a, b))
>                  inconsistent =3D 1;
>          a->optimized_parms =3D b->optimized_parms =3D optimized;
> @@ -1461,6 +1462,8 @@ static void elf_functions__collect_function(struct
> elf_functions *functions, GEl
>
>          func =3D &functions->entries[functions->cnt];
>          func->name =3D name;
> +       func->is_static =3D elf_sym__bind(sym) =3D=3D STB_LOCAL;
> +

Hmm. We definitely don't want to filter out all static functions.
That's too drastic.

