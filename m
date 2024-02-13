Return-Path: <bpf+bounces-21911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3EC853FE1
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF3D1C28DC4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA24C633E3;
	Tue, 13 Feb 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOTGmTi2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4262A02
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866143; cv=none; b=DfyYlmjGpK53iUeiTx2nVk4x1uYXbJmbcF7fA27R6TKeA5lUcHY7uqRUq4ud9rSZn/guA1cKeDXOCno478FZ/1AoBmq0URctV4BkPA3kYRDjk/5yzFiqWXDK/m7FD06Hn9lIEppCpsZJ/IdZtWdVhqn2K3AYjOeClI2Wq1jlCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866143; c=relaxed/simple;
	bh=2sC0Q+dt+DesHtpadntgZLeusDNoYvF0vX4Pou8FEFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKc97OJ0jXdwnjSazY2y+Kgwm/UNDsMkMIk/Nn6RlmM2oE+sp/cGQRE1rhlBHhxz9ne6QRhflYIo+GSD+TT2DyaVtW0XHIZt51N5aupNb1tctef0ZnUSmEBHFW6nvkUkbzKxcC135TWt+eGGD/kXvGFRoWk7sPUsKP8EmX8FvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOTGmTi2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1047215a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866141; x=1708470941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvFUmdkBHte2LSBUzwzMYO4QxUxyEN9D5qA1TjtDL5M=;
        b=IOTGmTi254bgMS8CRhTgRtYKN2S/XES5OorUAbUD52+iw5lD9ihqyrzEhjgJMNfhRY
         1Y1Pl3yj5/WQOnWU3gLX1pdurkYPn+OyGjV87zOrGATxxgbNIxyE0lyjrTW5ru5cSbf2
         jJTu4gJfnfxhBgR/DqqK/yGZOLpSlzN7Qra4TVf100z+e03fL5t04yR4IFdY9XwW+xMV
         DKw96UuwAVwNEJjGwAXCGVNIFEwYKSTP9sKWpVoq0OYJwMM9QTy2rIMr+sAw7iSW0G7Y
         pNL/mtxxNvjTSkbhFqdBBHg2YVI3/We2xba40OfJ2qwEtUS4vsmqiJoFqRNbHY/qhzHI
         sRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866141; x=1708470941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvFUmdkBHte2LSBUzwzMYO4QxUxyEN9D5qA1TjtDL5M=;
        b=wuHMD4qGIFI+ydAM6JkpIWDQD8WE+RNzfgjhqw4wBi+4WXkD7NMMCXNkKuK3A6xMPN
         xrXgVN4jtESwSvEBU8lTnOWIMe7BJqBe/i2UA++lbU1J9SAhoG54lsOtA8i2I2owO3ey
         KlFYigAp1lcY+BYBcd8DTandF3rCqInX9/CzVUbvaKSdTg/YiqF1ohIbBHWma2hdI2DU
         cp+C0DwcZaYypgyOKbRihp+XBQ+cbc++p1EHXSG2h6VWnjrH9ysSfrD/fj4hVzFcCPjR
         4auY/Hs1gRUChvXUPmoQOEMkKOqtGGG4P1WjyqMy0bYcNHBn3rlv+OzRrnBEMM3CaVwg
         Z0zA==
X-Gm-Message-State: AOJu0Yx7lrIvHtqzmhuuBYj3PKSp0QdpBcaXdesJ8r+zF6sH64/lYfU7
	895brcA1SMzP6tMCgwDAazi6sxpGiv1mxZJnUAX1n65Q/jZllOB/PSMLj4ZJgM1fzdyRvjGkGzF
	ZmCXdPgz5n537cn4BazVKZ1Fc4nc=
X-Google-Smtp-Source: AGHT+IE82g/W0O4o8slL1b+5fn/nVasueAk9kOIlMYm0v8P2wKht6jrkvrIWGRPH/PTXX7ivlUr+PrNbk+fMYcna9Zo=
X-Received: by 2002:a17:90a:bc81:b0:298:a701:aacc with SMTP id
 x1-20020a17090abc8100b00298a701aaccmr738773pjr.47.1707866141100; Tue, 13 Feb
 2024 15:15:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-14-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-14-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 15:15:28 -0800
Message-ID: <CAEf4BzZGLJfKRbZdbrZzkYeHfa0Dz8fDLSngv3k+t4b3f80ksg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 13/20] libbpf: Allow specifying 64-bit
 integers in map BTF.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> __uint() macro that is used to specify map attributes like:
>   __uint(type, BPF_MAP_TYPE_ARRAY);
>   __uint(map_flags, BPF_F_MMAPABLE);
> is limited to 32-bit, since BTF_KIND_ARRAY has u32 "number of elements" f=
ield.
>
> Introduce __ulong() macro that allows specifying values bigger than 32-bi=
t.
> In map definition "map_extra" is the only u64 field.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/bpf_helpers.h |  5 +++++
>  tools/lib/bpf/libbpf.c      | 44 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9c777c21da28..0aeac8ea7af2 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -13,6 +13,11 @@
>  #define __uint(name, val) int (*name)[val]
>  #define __type(name, val) typeof(val) *name
>  #define __array(name, val) typeof(val) *name[]
> +#ifndef __PASTE
> +#define ___PASTE(a,b) a##b
> +#define __PASTE(a,b) ___PASTE(a,b)
> +#endif

we already have ___bpf_concat defined further in this file (it's macro
so ordering shouldn't matter), let's just use that instead of adding
another variant

> +#define __ulong(name, val) enum { __PASTE(__unique_value, __COUNTER__) =
=3D val } name
>
>  /*
>   * Helper macro to place programs, maps, license in
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4880d623098d..f8158e250327 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2243,6 +2243,39 @@ static bool get_map_field_int(const char *map_name=
, const struct btf *btf,
>         return true;
>  }
>
> +static bool get_map_field_long(const char *map_name, const struct btf *b=
tf,
> +                              const struct btf_member *m, __u64 *res)
> +{
> +       const struct btf_type *t =3D skip_mods_and_typedefs(btf, m->type,=
 NULL);
> +       const char *name =3D btf__name_by_offset(btf, m->name_off);
> +
> +       if (btf_is_ptr(t))
> +               return false;

It's not great that anyone that uses __uint(map_extra, ...) would get
warnings now.
Let's just teach get_map_field_long to recognize __uint vs __ulong?

Let's call into get_map_field_int() here if we have a pointer, and
then upcast u32 into u64?

> +
> +       if (!btf_is_enum(t) && !btf_is_enum64(t)) {
> +               pr_warn("map '%s': attr '%s': expected enum or enum64, go=
t %s.\n",

seems like get_map_field_int() is using "PTR" and "ARRAY" all caps
spelling in warnings, let's use ENUM and ENUM64 for consistency?

> +                       map_name, name, btf_kind_str(t));
> +               return false;
> +       }
> +
> +       if (btf_vlen(t) !=3D 1) {
> +               pr_warn("map '%s': attr '%s': invalid __ulong\n",
> +                       map_name, name);
> +               return false;
> +       }
> +
> +       if (btf_is_enum(t)) {
> +               const struct btf_enum *e =3D btf_enum(t);
> +
> +               *res =3D e->val;
> +       } else {
> +               const struct btf_enum64 *e =3D btf_enum64(t);
> +
> +               *res =3D btf_enum64_value(e);
> +       }
> +       return true;
> +}
> +
>  static int pathname_concat(char *buf, size_t buf_sz, const char *path, c=
onst char *name)
>  {
>         int len;
> @@ -2476,10 +2509,15 @@ int parse_btf_map_def(const char *map_name, struc=
t btf *btf,
>                         map_def->pinning =3D val;
>                         map_def->parts |=3D MAP_DEF_PINNING;
>                 } else if (strcmp(name, "map_extra") =3D=3D 0) {
> -                       __u32 map_extra;
> +                       __u64 map_extra;
>
> -                       if (!get_map_field_int(map_name, btf, m, &map_ext=
ra))
> -                               return -EINVAL;
> +                       if (!get_map_field_long(map_name, btf, m, &map_ex=
tra)) {
> +                               __u32 map_extra_u32;
> +
> +                               if (!get_map_field_int(map_name, btf, m, =
&map_extra_u32))
> +                                       return -EINVAL;
> +                               map_extra =3D map_extra_u32;
> +                       }

with the above change it would be a simple
s/get_map_field_int/get_map_field_long/ (and __u32 -> __u64, of
course)


>                         map_def->map_extra =3D map_extra;
>                         map_def->parts |=3D MAP_DEF_MAP_EXTRA;
>                 } else {
> --
> 2.34.1
>

