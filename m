Return-Path: <bpf+bounces-57906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB39BAB1C30
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB857504EEC
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D523BCE7;
	Fri,  9 May 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAemBLen"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE023717F
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814870; cv=none; b=EwjB9NaO0KriQt6k9/jUNp5/ppiBIzAH3UtgAx1JtndmkScjYFGhuoh+xCiwG0HDc/T87EeKC5U/ZKn499Kuqd++CIv43vIVxW7IvyvDhfxAqvV8tCmzithbuzjr1UpZxrE9y0z42/kgx7REb8MGIo54gjxpzJJ/Rt8GjP5F/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814870; c=relaxed/simple;
	bh=VtftV+TruY9vtIRrHtbzfO1wpUZxWlyDZt5F7/CbjdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8NGaa1O7wVQDosk/sjWW3F1wF1E8D3rPsHuGQltV64KjQowEJocXlP5+dW0orWMwzekuqJ8nzwUIyEijU9zbChX+sqLpCXMpJCGEmytdpekyEEvogJ3VWWnJ5Qjrd0qJzSz6URpVzmXg8p9PLNdv9/1IPuSD5lNEBFMqdJxfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAemBLen; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c062b1f5so2675792b3a.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746814868; x=1747419668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qYRE79HASpUAwbHUgWaD2KiN5HoEGcppPa3eACv14o=;
        b=eAemBLensIVy8+HcVhRIlyEyiCGGn5tinyTl8WhUw/+5HRjMYJy1gaTJLoyjYGUBfy
         A0EANoC8sC00a1nZPVRi9j0ZXErNQ4g6Jsn8x7mL7gVM3ES9DaaeVE5HwNx2gx9/K8Yi
         qMEq0p7Z23mZE1GEPf+QlS4hT348rbQdfmBxWBuxKq7ybSV8yfFobA7DbiMdxmJLoc+R
         jyrC0ZQ2TtaQ2c1RS495jc/EC3OSEndgb4T+3r8+EYXjQHJ91zsSQ///mPUvtfAfBIfg
         G+OUvV4G+QnSQiM/M+GkFV5M+MxciqUOcFpTtm84wL4yrgDVp2Bb3Cm3Fg4CClCKkpY3
         diMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746814868; x=1747419668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qYRE79HASpUAwbHUgWaD2KiN5HoEGcppPa3eACv14o=;
        b=ppE9s+hIZLJtedPPIwOeCA59SYqpxc6HITwYTjuPUsX+n74rBzN/S6mIgEndutm2Em
         GpOJVRozaFoq9DcQQIfVqbHKKKHRjj5GvlUfTBpoUhq59UkTYPLxnTfLwhl6jRA9EFQE
         RvLe9FSCu8fn7Ufva3iSZd8N+mQNxZR0r6BRObnigyXXMB572Eo7lqWObElQrpnO3Bku
         ArkkigPiu3KB0LO01LKaWFFdW7lpbQ4j5QyItzuzNFZ2Hz1tYQx0DHbtxoShIRihM/G4
         VQsM07DW+ra69RaL43l3OcwD+UXMIGtnHte8j0GgQjX4spRy0CqJuD2ctB0nrZSyhhC9
         Rp6Q==
X-Gm-Message-State: AOJu0YywxpCDGHGm82UQ4VIn1WFMu0uG+u0Vui3HahjxE+ALm+gdmpYD
	UxVhaxag2e231+OQIBuIy5pEMiuhj/lDD06q0c3fTUGllzTBOSK3NrUxgg3Sut18iEpIfQVd6nz
	D5qj719vdFe1fiFOnT3zQBUrOyhQ=
X-Gm-Gg: ASbGnctuj0pawGDA0PQ/cMxodsf4KMftbhqtZLECrNDXkvd314WPqMrRD0lAEo2064b
	Oftijk5ldNdehHYPfXeAun8T6ZUbO3a8JChGxFKXcWypiYDumydai/rJZdrR3I79do3P8u+Xz2x
	Kp8Kg160+FHBCNzQINmdIrWgaDmoQSaDeuOXrjOL9MAMbnWZrp
X-Google-Smtp-Source: AGHT+IEHbyOvfmgryy1eyjqG6/rSq8k9hLyM/+lwoLkU/9iE12rGan1qNFp2JBsISmHAX/e1H7PcRsXZszoyyRiYOR4=
X-Received: by 2002:a05:6a20:e617:b0:203:bb3b:5f03 with SMTP id
 adf61e73a8af0-215ababd0d6mr6312259637.6.1746814867790; Fri, 09 May 2025
 11:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
In-Reply-To: <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 11:20:55 -0700
X-Gm-Features: ATxdqUFUvzrsyDctcjpwvITXHud4TvnhV76FsEIm7xYhJX-lVIEAbU7S0x6W8MQ
Message-ID: <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 11:41=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> String operations are commonly used so this exposes the most common ones
> to BPF programs. For now, we limit ourselves to operations which do not
> copy memory around.
>
> Unfortunately, most in-kernel implementations assume that strings are
> %NUL-terminated, which is not necessarily true, and therefore we cannot
> use them directly in the BPF context. Instead, we open-code them using
> __get_kernel_nofault instead of plain dereference to make them safe and
> limit the strings length to XATTR_SIZE_MAX to make sure the functions
> terminate. When __get_kernel_nofault fails, functions return -EFAULT.
> Similarly, when the size bound is reached, the functions return -E2BIG.
>
> At the moment, strings can be passed to the kfuncs in three forms:
> - string literals (i.e. pointers to read-only maps)
> - global variables (i.e. pointers to read-write maps)
> - stack-allocated buffers
>
> Note that currently, it is not possible to pass strings from the BPF
> program context (like function args) as the verifier doesn't treat them
> as neither PTR_TO_MEM nor PTR_TO_BTF_ID.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  kernel/bpf/helpers.c | 440 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 440 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..8fb7c2ca7ac0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> +#include <linux/uaccess.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -3194,6 +3195,433 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned l=
ong *flags__irq_flag)
>         local_irq_restore(*flags__irq_flag);
>  }
>
> +/* Kfuncs for string operations.
> + *
> + * Since strings are not necessarily %NUL-terminated, we cannot directly=
 call
> + * in-kernel implementations. Instead, we open-code the implementations =
using
> + * __get_kernel_nofault instead of plain dereference to make them safe.
> + */
> +
> +/**
> + * bpf_strcmp - Compare two strings
> + * @s1: One string
> + * @s2: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1 is smaller
> + * * %1       - @s2 is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + */
> +__bpf_kfunc int bpf_strcmp(const char *s1, const char *s2)
> +{
> +       char c1, c2;
> +       int i;
> +
> +       if (!s1 || !s2)
> +               return -EFAULT;
> +
> +       guard(pagefault)();
> +       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +               __get_kernel_nofault(&c1, s1, char, err_out);
> +               __get_kernel_nofault(&c2, s2, char, err_out);
> +               if (c1 !=3D c2)
> +                       return c1 < c2 ? -1 : 1;
> +               if (c1 =3D=3D '\0')
> +                       return 0;
> +               s1++;
> +               s2++;
> +       }
> +       return -E2BIG;
> +err_out:
> +       return -EFAULT;
> +}
> +
> +/**
> + * bpf_strchr - Find the first occurrence of a character in a string
> + * @s: The string to be searched
> + * @c: The character to search for
> + *
> + * Note that the %NUL-terminator is considered part of the string, and c=
an
> + * be searched for.
> + *
> + * Return:
> + * * const char * - Pointer to the first occurrence of @c within @s
> + * * %NULL        - @c not found in @s
> + * * %-EFAULT     - Cannot read @s
> + * * %-E2BIG      - @s too large
> + */
> +__bpf_kfunc const char *bpf_strchr(const char *s, char c)

so let's say we found the character, we return a pointer to it, and
that memory goes away (because we never owned it, so we don't really
know what and when will happen with it). Question, will verifier allow
BPF program to dereference this pointer? If yes, that's a problem. But
if not, then I'm not sure there is much point in returning a pointer.


I'm just trying to imply that in BPF world integer-based APIs work
better/safer, overall? For strings, we can switch any
pointer-returning API to position-returning (or negative error) API
and it would more or less naturally fit into BPF API surface, no?

> +{
> +       char sc;
> +       int i;
> +
> +       if (!s)
> +               return ERR_PTR(-EFAULT);
> +
> +       guard(pagefault)();
> +       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +               __get_kernel_nofault(&sc, s, char, err_out);
> +               if (sc =3D=3D c)
> +                       return s;
> +               if (sc =3D=3D '\0')
> +                       return NULL;
> +               s++;
> +       }
> +       return ERR_PTR(-E2BIG);
> +err_out:
> +       return ERR_PTR(-EFAULT);

this implementation can be replaced with just `return bpf_strnchr(s,
XATTR_SIZE_MAX, c);`, no?

> +}
> +
> +/**
> + * bpf_strnchr - Find a character in a length limited string
> + * @s: The string to be searched
> + * @count: The number of characters to be searched
> + * @c: The character to search for
> + *
> + * Note that the %NUL-terminator is considered part of the string, and c=
an
> + * be searched for.
> + *
> + * Return:
> + * * const char * - Pointer to the first occurrence of @c within @s
> + * * %NULL        - @c not found in the first @count characters of @s
> + * * %-EFAULT     - Cannot read @s
> + * * %-E2BIG      - @s too large
> + */
> +__bpf_kfunc const char *bpf_strnchr(const char *s, size_t count, char c)
> +{
> +       char sc;
> +       int i;
> +
> +       if (!s)
> +               return ERR_PTR(-EFAULT);
> +
> +       guard(pagefault)();
> +       for (i =3D 0; i < count && i < XATTR_SIZE_MAX; i++) {
> +               __get_kernel_nofault(&sc, s, char, err_out);
> +               if (sc =3D=3D c)
> +                       return s;
> +               if (sc =3D=3D '\0')
> +                       return NULL;
> +               s++;
> +       }
> +       return i =3D=3D XATTR_SIZE_MAX ? ERR_PTR(-E2BIG) : NULL;
> +err_out:
> +       return ERR_PTR(-EFAULT);
> +}
> +

[...]

> +/**
> + * bpf_strlen - Calculate the length of a string
> + * @s: The string
> + *
> + * Return:
> + * * >=3D0      - The length of @s
> + * * %-EFAULT - Cannot read @s
> + * * %-E2BIG  - @s too large
> + */
> +__bpf_kfunc int bpf_strlen(const char *s)
> +{
> +       char c;
> +       int i;
> +
> +       if (!s)
> +               return -EFAULT;
> +
> +       guard(pagefault)();
> +       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +               __get_kernel_nofault(&c, s, char, err_out);
> +               if (c =3D=3D '\0')
> +                       return i;
> +               s++;
> +       }
> +       return -E2BIG;
> +err_out:
> +       return -EFAULT;


return bpf_strnlen(s, XATTR_SIZE_MAX)?

You get the idea.

[...]

