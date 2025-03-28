Return-Path: <bpf+bounces-54881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7867A75291
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 23:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EC716F1EA
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E351F471D;
	Fri, 28 Mar 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbcnnP5h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800301B87CE
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743202101; cv=none; b=h7a4ZTiuqwABApW6tWjWNhvLPuNxw4BHzvhk6zjy1NpXYuOVqg8nN8j1dp5QO8JWvUY0IB7a3IRuaU77Fb6QDBJRInj8lpKoxDun+JcsHoZ1jbo1iY0Kjyb26BePdeiQ4udkykjdwOW3g64Lgv0AEx+/Tbh8WdJvrXJN9FqRSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743202101; c=relaxed/simple;
	bh=9+h99CIaPZ+KUXASAL0090auWp1XcXUDCR/V4K+FWgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdYc2ItVpXAcUrP1VwllMqdQpgi4XoprHnCuidYFYTNqOOTGB+BgS+aYu5akWJPGJNcKVkHbH82ciXxIcX7K4v2dwCSPqZQywaU5pKtuBlaixdvPesKhWItLgE1koyeO8hFChmOt/ch1FFY5L8lrObuT3eR1zUAbfgxZKVi7zxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbcnnP5h; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so6092551a91.3
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743202099; x=1743806899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RFK+6BO2AD2Alug9q6m2/1gph24H8xMCNHuHkPsiSA=;
        b=UbcnnP5hcmNngrPpENRARbFdPoHK4Uh5O0hKJc36ehAyHq2O/xma1QZ9gzAiEMw5+1
         FX3XwihrvyZ8Y+CyxMFA7hYTXLnwykC3Cq1wNE2IwhkBubHViRMs9ma/vYdoSkwXEVry
         W48jKsYjrdc45HRshUL4auceuXgrXiF06XheuavbCY/P6oI/jZU2uWjBcnnyGCtV76hL
         NR13Qlx3M1Xdj4SeEvU5UWJaBHu2CMgFClMz0kVgnCe0JTHkvvoGA5pDuIRYG8igX/WI
         4fFiXnGbm7MV1Wwwf8vQo0qow7QKHb/IQlkF8UaUEwfCzWL7Pf8KVQ/GrZJW/LfFpRKF
         f5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743202099; x=1743806899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RFK+6BO2AD2Alug9q6m2/1gph24H8xMCNHuHkPsiSA=;
        b=nK1mCMQy414H+y8DsxTTab5HFl7VRURXw5k+fK0IRdW3RFwzdHkA3gX3uWQusSwqJ/
         duHpfnqQEcyMYza9ZiD602YSLUQzu7kRxnmUzt7uAjy1VpnmiZv9MsRhhN+LFdQdPcCZ
         uUjEMrF6zoaQ8OOGA2u6gob1wQPQf4653sEPk6toeFRCgWT0t9Fw1K+LDDrvhYBrirZL
         eatOmEk7xYF7AB62Z40eMaCwxBRCraOU8J1UoJJmzVa8nG3I2r7pDYT38FFKhZn77vPN
         ncjS0pq0mjC3ctA6nvivtyzWAGTi/4kJfs6njSGOUt67orwu+NpRd3/V468nxVdNL0wy
         7nLg==
X-Gm-Message-State: AOJu0Yy5xG+0ZXHeR+w/Bk4afkMHCnLKWGMvjOnowcbhxJM9Fx1osNdj
	Xz17pmbYLA73P6iH+Fcy3PwO605cypfutr775E6j2TJuAGr3l8rdlvoY7Jd5rOJ5SssV0iP1+EY
	jEsvTozeGIsLhdMBIqF6NM/oPX18=
X-Gm-Gg: ASbGncu2+GNRMdaBUbYtEN2buwIayCEo+sxHbXL8FwkfwRivr5OlaUcmFGYE/1vHY1p
	rKjHm7DE0q7mazCl2aP5RQyubdlBMrzzWc9ccYJf3gMZcCEN+E0RuSwkv3IIa5rKKJdPmE5bR6H
	ZB28Y3iHz5DRPmHFKOWJ1e+GfyGlfIK4zNTiqkSB15VQ==
X-Google-Smtp-Source: AGHT+IHeK04z2aimjrY4J5qKSjXWOrxnGmfA+z374LxxIYj6nd3gziv2YAmlBw6z+QklciOiDRRB+VOUjn+cRIQo6mk=
X-Received: by 2002:a17:90b:3b8a:b0:2ee:e945:5355 with SMTP id
 98e67ed59e1d1-305320b1043mr1275128a91.19.1743202098342; Fri, 28 Mar 2025
 15:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741874348.git.vmalik@redhat.com> <4e26ca57634db305a622b010b0d86dbb36b09c37.1741874348.git.vmalik@redhat.com>
In-Reply-To: <4e26ca57634db305a622b010b0d86dbb36b09c37.1741874348.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 15:48:05 -0700
X-Gm-Features: AQ5f1Jqtce5Z1bCvt7G5bztntpdY9sG1lwVYa_AyyIJGLkRvcMLzaKAAG-_d-xM
Message-ID: <CAEf4BzYTJh06kqR9hL=TvfBTRNskZMCPTAmcD7=nMFJrqR1OSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 5:04=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> String operations are commonly used so this exposes the most common ones
> to BPF programs. For now, we limit ourselves to operations which do not
> copy memory around.
>
> Unfortunately, most in-kernel implementations assume that strings are
> %NUL-terminated, which is not necessarily true, and therefore we cannot
> use them directly in BPF context. So, we use distinct approaches for
> bounded and unbounded variants of string operations:
>
> - Unbounded variants are open-coded with using __get_kernel_nofault
>   instead of plain dereference to make them safe.
>
> - Bounded variants use params with the __sz suffix so safety is assured
>   by the verifier and we can use the in-kernel (potentially optimized)
>   functions.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  kernel/bpf/helpers.c | 299 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 299 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 5449756ba102..6f6af4289cd0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
>   */
> +#include "linux/uaccess.h"

<> should be used?

>  #include <linux/bpf.h>
>  #include <linux/btf.h>
>  #include <linux/bpf-cgroup.h>
> @@ -3193,6 +3194,291 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned l=
ong *flags__irq_flag)
>         local_irq_restore(*flags__irq_flag);
>  }
>
> +/* Kfuncs for string operations.
> + *
> + * Since strings are not necessarily %NUL-terminated, we cannot directly=
 call
> + * in-kernel implementations. Instead, unbounded variants are open-coded=
 with
> + * using __get_kernel_nofault instead of plain dereference to make them =
safe.
> + * Bounded variants use params with the __sz suffix so safety is assured=
 by the
> + * verifier and we can use the in-kernel (potentially optimized) functio=
ns.
> + */
> +
> +/**
> + * bpf_strcmp - Compare two strings
> + * @cs: One string
> + * @ct: Another string
> + */
> +__bpf_kfunc int bpf_strcmp(const char *cs, const char *ct)
> +{
> +       int i =3D 0, ret =3D 0;
> +       char c1, c2;
> +
> +       pagefault_disable();
> +       while (i++ < XATTR_SIZE_MAX) {
> +               __get_kernel_nofault(&c1, cs++, char, cs_out);
> +               __get_kernel_nofault(&c2, ct++, char, ct_out);

nit: should we avoid passing increment statements into macro? It's
succinct and all, but we lose nothing by having cs++; ct++; at the end
of while loop, no?

> +               if (c1 !=3D c2) {
> +                       ret =3D c1 < c2 ? -1 : 1;
> +                       goto out;
> +               }
> +               if (!c1)
> +                       goto out;
> +       }
> +cs_out:
> +       ret =3D -1;
> +       goto out;
> +ct_out:
> +       ret =3D 1;
> +out:
> +       pagefault_enable();
> +       return ret;
> +}

Given valid values are only -1, 0, and 1, should we return -EFAULT
when one or the other string can't be fetched?

Yes, users that don't care will treat -EFAULT as the first string is
smaller than the second, but that's what you have anyways. But having
-EFAULT is still useful, IMO. We can also return -E2BIG if we reach i
=3D=3D XATTR_SIZE_MAX situation, no?

> +
> +/**
> + * bpf_strchr - Find the first occurrence of a character in a string
> + * @s: The string to be searched
> + * @c: The character to search for
> + *
> + * Note that the %NUL-terminator is considered part of the string, and c=
an
> + * be searched for.
> + */
> +__bpf_kfunc char *bpf_strchr(const char *s, int c)

if we do int -> char here, something breaks?

> +{
> +       char *ret =3D NULL;
> +       int i =3D 0;
> +       char sc;
> +
> +       pagefault_disable();
> +       while (i++ < XATTR_SIZE_MAX) {
> +               __get_kernel_nofault(&sc, s, char, out);
> +               if (sc =3D=3D (char)c) {
> +                       ret =3D (char *)s;
> +                       break;
> +               }
> +               if (sc =3D=3D '\0')

not very consistent with bpf_strcmp() implementation where you just
did `!c1` for the same. FWIW, when dealing with string characters I
like `sc =3D=3D '\0'` better, but regardless let's be consistent, at
least.

> +                       break;
> +               s++;

It's like bpf_strcmp and bpf_strchr were written by two different
people, stylistically :)

> +       }
> +out:
> +       pagefault_enable();

how about we

DEFINE_LOCK_GUARD_0(pagefault, pagefault_disable(), pagefault_enable())

like we do for preempt_{disable,enable}() and simplify all the
implementations significantly?

> +       return ret;
> +}
> +
> +/**
> + * bpf_strchrnul - Find and return a character in a string, or end of st=
ring
> + * @s: The string to be searched
> + * @c: The character to search for
> + *
> + * Returns pointer to first occurrence of 'c' in s. If c is not found, t=
hen
> + * return a pointer to the null byte at the end of s.
> + */
> +__bpf_kfunc char *bpf_strchrnul(const char *s, int c)
> +{
> +       char *ret =3D NULL;
> +       int i =3D 0;
> +       char sc;
> +
> +       pagefault_disable();
> +       while (i++ < XATTR_SIZE_MAX) {

erm... for (i =3D 0; i < XATTR_SIZE_MAX; i++, s++) ?

what advantage does while() form provide? same question for lots of
other functions. for() is meant for loops like this, no?

> +               __get_kernel_nofault(&sc, s, char, out);
> +               if (sc =3D=3D '\0' || sc =3D=3D (char)c) {
> +                       ret =3D (char *)s;
> +                       break;
> +               }
> +               s++;
> +       }
> +out:
> +       pagefault_enable();
> +       return ret;
> +}
> +
> +/**
> + * bpf_strnchr - Find a character in a length limited string
> + * @s: The string to be searched
> + * @s__sz: The number of characters to be searched
> + * @c: The character to search for
> + *
> + * Note that the %NUL-terminator is considered part of the string, and c=
an
> + * be searched for.
> + */
> +__bpf_kfunc char *bpf_strnchr(void *s, u32 s__sz, int c)

I'm a bit on the fence here. I can see cases where s would be some
string somewhere (not "trusted" by verifier, because I did BPF CO-RE
based casts, etc). Also I can see how s__sz is non-const known at
runtime only.

I think the performance argument is much less of a priority compared
to the ability to use the helper in a much wider set of cases. WDYT?
Maybe let's just have __get_kernel_nofault() for everything?

If performance is truly that important, we can later have an
optimization in which we detect constant size and "guaranteed"
lifetime and validity of `s`, and use optimized strnchr()
implementation?

But I'd start with a safe and generic __get_kernel_nofault() way for sure.

> +{
> +       return strnchr(s, s__sz, c);
> +}
> +
> +/**
> + * bpf_strnchrnul - Find and return a character in a length limited stri=
ng,
> + * or end of string
> + * @s: The string to be searched
> + * @s__sz: The number of characters to be searched
> + * @c: The character to search for
> + *
> + * Returns pointer to the first occurrence of 'c' in s. If c is not foun=
d,
> + * then return a pointer to the last character of the string.
> + */
> +__bpf_kfunc char *bpf_strnchrnul(void *s, u32 s__sz, int c)
> +{
> +       return strnchrnul(s, s__sz, c);
> +}
> +
> +/**
> + * bpf_strrchr - Find the last occurrence of a character in a string
> + * @s: The string to be searched
> + * @c: The character to search for
> + */
> +__bpf_kfunc char *bpf_strrchr(const char *s, int c)

`const char *` return? we won't (well, shouldn't!) allow writing into
it from the BPF program.

> +{
> +       char *ret =3D NULL;
> +       int i =3D 0;
> +       char sc;
> +
> +       pagefault_disable();
> +       while (i++ < XATTR_SIZE_MAX) {
> +               __get_kernel_nofault(&sc, s, char, out);
> +               if (sc =3D=3D '\0')
> +                       break;
> +               if (sc =3D=3D (char)c)
> +                       ret =3D (char *)s;
> +               s++;
> +       }
> +out:
> +       pagefault_enable();
> +       return (char *)ret;
> +}
> +
> +__bpf_kfunc size_t bpf_strlen(const char *s)
> +{
> +       int i =3D 0;
> +       char c;
> +
> +       pagefault_disable();
> +       while (i < XATTR_SIZE_MAX) {
> +               __get_kernel_nofault(&c, s++, char, out);
> +               if (c =3D=3D '\0')
> +                       break;
> +               i++;
> +       }
> +out:
> +       pagefault_enable();
> +       return i;
> +}
> +
> +__bpf_kfunc size_t bpf_strnlen(void *s, u32 s__sz)
> +{
> +       return strnlen(s, s__sz);
> +}
> +
> +/**
> + * bpf_strspn - Calculate the length of the initial substring of @s whic=
h only contain letters in @accept
> + * @s: The string to be searched
> + * @accept: The string to search for
> + */
> +__bpf_kfunc size_t bpf_strspn(const char *s, const char *accept)
> +{
> +       int i =3D 0;
> +       char c;
> +
> +       pagefault_disable();
> +       while (i < XATTR_SIZE_MAX) {
> +               __get_kernel_nofault(&c, s++, char, out);
> +               if (c =3D=3D '\0' || !bpf_strchr(accept, c))

hm... so `s` is untrusted/unsafe, but `accept` is? How should verifier
make a distinction? It's `const char *` in the signature, so what
makes one more safe than the other?

> +                       break;
> +               i++;
> +       }
> +out:
> +       pagefault_enable();
> +       return i;
> +}
> +
> +/**
> + * strcspn - Calculate the length of the initial substring of @s which d=
oes not contain letters in @reject
> + * @s: The string to be searched
> + * @reject: The string to avoid
> + */
> +__bpf_kfunc size_t bpf_strcspn(const char *s, const char *reject)
> +{
> +       int i =3D 0;
> +       char c;
> +
> +       pagefault_disable();
> +       while (i < XATTR_SIZE_MAX) {
> +               __get_kernel_nofault(&c, s++, char, out);
> +               if (c =3D=3D '\0' || bpf_strchr(reject, c))
> +                       break;
> +               i++;
> +       }
> +out:
> +       pagefault_enable();
> +       return i;
> +}
> +
> +/**
> + * bpf_strpbrk - Find the first occurrence of a set of characters
> + * @cs: The string to be searched
> + * @ct: The characters to search for
> + */
> +__bpf_kfunc char *bpf_strpbrk(const char *cs, const char *ct)

wouldn't this be `cs + bpf_strcspn(cs, ct)`?

> +{
> +       char *ret =3D NULL;
> +       int i =3D 0;
> +       char c;
> +
> +       pagefault_disable();
> +       while (i++ < XATTR_SIZE_MAX) {
> +               __get_kernel_nofault(&c, cs, char, out);
> +               if (c =3D=3D '\0')
> +                       break;
> +               if (bpf_strchr(ct, c)) {
> +                       ret =3D (char *)cs;
> +                       break;
> +               }
> +               cs++;
> +       }
> +out:
> +       pagefault_enable();
> +       return ret;
> +}
> +
> +/**
> + * bpf_strstr - Find the first substring in a %NUL terminated string
> + * @s1: The string to be searched
> + * @s2: The string to search for
> + */
> +__bpf_kfunc char *bpf_strstr(const char *s1, const char *s2)
> +{
> +       size_t l1, l2;
> +
> +       l2 =3D bpf_strlen(s2);
> +       if (!l2)
> +               return (char *)s1;
> +       l1 =3D bpf_strlen(s1);
> +       while (l1 >=3D l2) {
> +               l1--;
> +               if (!memcmp(s1, s2, l2))
> +                       return (char *)s1;
> +               s1++;
> +       }
> +       return NULL;

no __get_kernel_nofault() anymore?

> +}
> +
> +/**
> + * bpf_strnstr - Find the first substring in a length-limited string
> + * @s1: The string to be searched
> + * @s1__sz: The size of @s1
> + * @s2: The string to search for
> + * @s2__sz: The size of @s2
> + */
> +__bpf_kfunc char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz=
)
> +{
> +       /* strnstr() uses strlen() to get the length of s2. Since this is=
 not
> +        * safe in BPF context for non-%NUL-terminated strings, use strnl=
en
> +        * first to make it safe.
> +        */
> +       if (strnlen(s2, s2__sz) =3D=3D s2__sz)
> +               return NULL;
> +       return strnstr(s1, s2, s1__sz);
> +}
> +

we have to assume that the string will change from under us, so any
algorithm that does bpf_strlen/strlen/strnlen and then relies on that
length to be true seems fishy...

pw-bot: cr

>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3293,6 +3579,19 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_IT=
ER_NEXT | KF_RET_NULL | KF_SLE
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLE=
EPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +BTF_ID_FLAGS(func, bpf_strcmp);
> +BTF_ID_FLAGS(func, bpf_strchr);
> +BTF_ID_FLAGS(func, bpf_strchrnul);
> +BTF_ID_FLAGS(func, bpf_strnchr);
> +BTF_ID_FLAGS(func, bpf_strnchrnul);
> +BTF_ID_FLAGS(func, bpf_strrchr);
> +BTF_ID_FLAGS(func, bpf_strlen);
> +BTF_ID_FLAGS(func, bpf_strnlen);
> +BTF_ID_FLAGS(func, bpf_strspn);
> +BTF_ID_FLAGS(func, bpf_strcspn);
> +BTF_ID_FLAGS(func, bpf_strpbrk);
> +BTF_ID_FLAGS(func, bpf_strstr);
> +BTF_ID_FLAGS(func, bpf_strnstr);
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.48.1
>

