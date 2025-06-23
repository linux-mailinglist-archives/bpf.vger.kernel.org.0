Return-Path: <bpf+bounces-61315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD70AE50F4
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34C1440F51
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B17221DAE;
	Mon, 23 Jun 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpeG+Ay9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9621FF50
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714173; cv=none; b=bgG45jeuSM2l6tKXroOBo0tA8MYv8lyp4oG5AJnwTVYAgTuZf24R89UbJBPH32LRgHHLBdxJU1Ti8Og4KhEwzcB0ybcl5zN+kIPq6em1HlDTItLe03WgK4uZ6r+fyrCrFo2E2mDRN0p15Ss0HqaRmvFlvt0p3oEJNSs2XVEsosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714173; c=relaxed/simple;
	bh=PKjccEtQTQJ+WUlWmAJTa5qaZ4bI75AGsY8jDfb8Hts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFwiqvo13FF6EkbO1CPJktxA2alcIeHn3tpc9RHrLVPy0XjAfk1Kjx/jmXvFo93JHXorfT7OeDypuIq0eNEhroY+3vOc+9SrY6DWwkINDvRxdYnSUnhZ7Vz3ZeppBT/vF/b3Pi/9Qe+29XuBHuuKg8nK0M1PfvwFiihHTBxg6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpeG+Ay9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3134c67a173so5088369a91.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750714171; x=1751318971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL3LhEttgGEpUZlN6r2JFG60zk0+w1uqQU/YCzcnbzM=;
        b=JpeG+Ay9gg6hV9bCAR3p2aN6g7UN+jluqZL0oh0idlthCEB9O7f6bs1NCvED2onxef
         0CDYhcDX70JXj+6fNuphrOGKO4hemSBN7SALL8BFH/qweTRdzb1UtejobCBVgWEsLDKI
         3zO9HIbHMilxQmzJJw3lz/5wYSwhcDEROWMcZR/yg2s7/gjeaXT5TwVL2wG73Tk//oU1
         AqPakFJNEJiMaXCjaWxY/rhZe15bDlN81ys8hQJQ3PXJrn4ek16nR1njvH877zV6yebU
         YfwMi+oJBUDO2xGgG7cGgKI0XVils9DrQ/jaGdcXJkiKFYufblU+11Y8ixz+ivOUSYaT
         8sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750714171; x=1751318971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL3LhEttgGEpUZlN6r2JFG60zk0+w1uqQU/YCzcnbzM=;
        b=cwh6J6WmlCDGwZk9cie0MTrsoMBJhtKnxUpnjEoI5kDWIu3o1JkfuyQzZh8Yi7QPgp
         sywTlfQgvLIIObFxKoGZcWhw/N55+dBR3rfhwkibS3MpmlfQ1B66Ng4QpWYB+TOXK0yp
         QLKUfbAaUFUOsJ7sLouJ25TdHl4lMZ7gehptKNx68SupZoQbi5cfF+jmvC9DrC3lRpgS
         8WdAyRANr4vuAOO1opRzUI/6bJPAlp6wIcTlQG+M0rD/+rnTRX26n7kd00BHaUkrTYlr
         iamj/BjaeKyH3gAzoMndKnKbXwogw1lYXBrG1DocyQ436j/waG4U2LIv5LrRPOrS/1ML
         1w4A==
X-Gm-Message-State: AOJu0Yz/1TT5KhSbP3dpFbgnlA83zY2fpcXvX9nA8M4tNC3+R+kFemsS
	Rm8Md2E8jUK6y99VB6Yn937DXgbMQO584gLJjXpBl3KRNXkqhQqUEcn4gHmae3di88ANdjyUlLe
	FlkRDrmN6wHCmNcNLqAunq0ERrd2/KoM=
X-Gm-Gg: ASbGncvcjajbLez7IPl2pvNrzlAu/bvKCl/pEBr35YYBUONDGOdEQZbfheRpXdw1JsS
	TKBDTDnD9+PUc7zEzkq6VkULLZIt1gSf/28TtWwfyr82lBrkauQQ6ZKjuuBqIn25vq5hg1ob9nj
	fwWr7mAaibeig6SCduDmwOkDqtICbcD/kkwFRtZh204tiqIA1+qCz8X19QHxw=
X-Google-Smtp-Source: AGHT+IGOE6sXx3SEiBejoCfkxxdGWnHCvTilY1cwVk825NFpojFWSDh6txdHyRAl7ahlgec0gbVfzVb/6g6NojlfABE=
X-Received: by 2002:a17:90a:c883:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-3159d8d9098mr21475817a91.29.1750714171547; Mon, 23 Jun 2025
 14:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750681829.git.vmalik@redhat.com> <1b75082af9f349a0c20aa49a47d003fc1b81e5f5.1750681829.git.vmalik@redhat.com>
In-Reply-To: <1b75082af9f349a0c20aa49a47d003fc1b81e5f5.1750681829.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Jun 2025 14:29:18 -0700
X-Gm-Features: AX0GCFt06dbAQx07j5zArrZszcuwBNRWnbEKjwemDIqOx2nzC5E_E5MCxn5RHtc
Message-ID: <CAEf4BzYxZkwBQJncHRw9KQCrPcCs9L3h-6szgKLiT=QPErPzqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/4] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:48=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
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
> In addition, we return -ERANGE when the passed strings are outside of
> the kernel address space.
>
> Note that thanks to these dynamic safety checks, no other constraints
> are put on the kfunc args (they are marked with the "__ign" suffix to
> skip any verifier checks for them).
>
> All of the functions return integers, including functions which normally
> (in kernel or libc) return pointers to the strings. The reason is that
> since the strings are generally treated as unsafe, the pointers couldn't
> be dereferenced anyways. So, instead, we return an index to the string
> and let user decide what to do with it. This also nicely fits with
> returning various error codes when necessary (see above).
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  kernel/bpf/helpers.c | 389 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 389 insertions(+)
>

few more comments below, beside the -ENOENT issue Alexei mentioned earlier

[...]

> +/**
> + * bpf_strrchr - Find the last occurrence of a character in a string
> + * @s__ign: The string to be searched
> + * @c: The character to search for
> + *
> + * Return:
> + * * >=3D0      - Index of the last occurrence of @c within @s__ign
> + * * %-1      - @c not found in @s__ign
> + * * %-EFAULT - Cannot read @s__ign
> + * * %-E2BIG  - @s__ign is too large
> + * * %-ERANGE - @s__ign is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
> +{
> +       char sc;
> +       int i, last =3D -1;
> +
> +       if (!copy_from_kernel_nofault_allowed(s__ign, 1))
> +               return -ERANGE;
> +
> +       guard(pagefault)();
> +       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +               __get_kernel_nofault(&sc, s__ign, char, err_out);
> +               if (sc =3D=3D '\0')
> +                       return last;
> +               if (sc =3D=3D c)
> +                       last =3D i;

swap these two ifs, so that bpf_strrchr("blah", 0) will still return a
meaningful result (effectively become bpf_strlen(), of course)? That
should match strrchr's behavior in libc, if I'm reading this
correctly:

"The terminating NUL character is considered to be part of the string."


> +               s__ign++;
> +       }
> +       return -E2BIG;
> +err_out:
> +       return -EFAULT;
> +}
> +

[...]

> +/**
> + * bpf_strspn - Calculate the length of the initial substring of @s__ign=
 which
> + *              only contains letters in @accept__ign
> + * @s__ign: The string to be searched
> + * @accept__ign: The string to search for
> + *
> + * Return:
> + * * >=3D0      - The length of the initial substring of @s__ign which o=
nly
> + *              contains letters from @accept__ign
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of the strings is too large
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
> +{
> +       char cs, ca;
> +       bool found;
> +       int i, j;
> +
> +       if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
> +           !copy_from_kernel_nofault_allowed(accept__ign, 1)) {
> +               return -ERANGE;
> +       }
> +
> +       guard(pagefault)();
> +       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +               __get_kernel_nofault(&cs, s__ign, char, err_out);
> +               if (cs =3D=3D '\0')
> +                       return i;
> +               found =3D false;
> +               for (j =3D 0; j < XATTR_SIZE_MAX; j++) {
> +                       __get_kernel_nofault(&ca, accept__ign + j, char, =
err_out);
> +                       if (cs =3D=3D ca) {
> +                               found =3D true;
> +                               break;
> +                       }
> +                       if (ca =3D=3D '\0')
> +                               break;
> +               }
> +               if (!found)
> +                       return i;

nit: you shouldn't need "found", just `ca =3D=3D '\0'` would mean "not
found", I think?

so you'd have a succinct `if (cs =3D=3D ca || ca =3D=3D '\0') break;` in th=
e
innermost loop


> +               s__ign++;
> +       }
> +       return -E2BIG;
> +err_out:
> +       return -EFAULT;
> +}
> +

[...]

> +/**
> + * bpf_strnstr - Find the first substring in a length-limited string
> + * @s1__ign: The string to be searched
> + * @s2__ign: The string to search for
> + * @len: the maximum number of characters to search
> + *
> + * Return:
> + * * >=3D0      - Index of the first character of the first occurrence o=
f @s2__ign
> + *              within the first @len characters of @s1__ign
> + * * %-1      - @s2__ign not found in the first @len characters of @s1__=
ign
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of the strings is too large
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, si=
ze_t len)
> +{
> +       char c1, c2;
> +       int i, j;
> +
> +       if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
> +           !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
> +               return -ERANGE;
> +       }
> +
> +       guard(pagefault)();
> +       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +               for (j =3D 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
> +                       __get_kernel_nofault(&c1, s1__ign + j, char, err_=
out);

move this after you check `c2 =3D=3D 0` below? why reading this character
if we are not going to compare it?

> +                       __get_kernel_nofault(&c2, s2__ign + j, char, err_=
out);
> +                       if (c2 =3D=3D '\0')
> +                               return i;
> +                       if (c1 =3D=3D '\0')
> +                               return -1;
> +                       if (c1 !=3D c2)
> +                               break;
> +               }
> +               if (j =3D=3D XATTR_SIZE_MAX)
> +                       return -E2BIG;
> +               if (i + j =3D=3D len)
> +                       return -1;
> +               s1__ign++;
> +       }
> +       return -E2BIG;
> +err_out:
> +       return -EFAULT;
> +}
> +

[...]

