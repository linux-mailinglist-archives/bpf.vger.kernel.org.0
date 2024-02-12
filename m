Return-Path: <bpf+bounces-21804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB28522CD
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609B31C2326B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A75024A;
	Mon, 12 Feb 2024 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2JNT+sN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76342AA3
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781894; cv=none; b=sdLrvx7ADIuzjZcll9gPoSfQ+S6rrHKc6eQBVBhbtpNJtF2lhFsVTtnhumdxIusF+wHxIiYiuE6A0E04jmfegaBJ7TqGb6FvkMW6WRNhPaNbMeQEUosUi3zcc61dAWFH/6cCH6a9pHpfpnD1UI4l2hXxOgKieDJ5DdU5L6Xw3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781894; c=relaxed/simple;
	bh=HrAWmexl2Xnk/BVI0yg/CTQ16s3zvD8bu/HwnXijU2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqEnDUEfo/eZysvyRL1jUdB06KBCfmGVCUbkBp5yptxEtKpAAuX0d+NOGkMK9bYkzY6VkmJttngEWTyldD5LG/XeU3K5oBlAlIQTIFkYEIWX6BZMB2MJbkazXepxRr/5+775ANgnj3pBFO96s2cBaONTCcy4iVraj0sqzbbI9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2JNT+sN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-290da27f597so2090553a91.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781892; x=1708386692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tb71br0BB+TDITHOii+uqlyElNGp5KBZUvhVzl/GmBs=;
        b=X2JNT+sNUjqq78v6PYuD993NP7+nG6YBE+QU0Ggo806drJeHFUMbD0AFKHCGOyFoDZ
         ckc7gTPl1u4gboNyqwICiUSiyB4/Z5UeDcPeO50Z/yPS7htTFOuOOxj2ihJK+V/tWLZO
         mFSorEb8HY1kYQ+IlgLOnZve1pG4p+ayJy4m7I5qiqvZ2ZvPUTK98+Cl0NlvdUfRuVBJ
         QHXwmZJWML9LhscoqN9j07+/To1CNVamPdb2M+yI81ksqcFIm0Do7ZKKa2y1WoFz7hXO
         3hFa23cy6hkkKUSRvTcyklrM+E/PaU2/ctuufiPXzAvsP0n6C8yRoLyEoNJOQgSA/HrQ
         jEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781892; x=1708386692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tb71br0BB+TDITHOii+uqlyElNGp5KBZUvhVzl/GmBs=;
        b=YoEnsj9hQWZdxIQM2iwgSCmYL86sYlzdmufHeaO/eqBiH0JQNKsiPHLrrbpEqAHYLK
         0VuunjdvOhKlmN2rrixPmM9eV4UkZGtaTweOKh4OPI/9gDZyHwGnNCq/GwjYa59HM5Sw
         d9ax8jf+n9TwqeF8EFSesw0j8ZmRKKxTyHPjD83tHooFGgO4D26Hs5lWZEAn0JkHd+1l
         wYKN2b/6O/RZ6/pG/XBNGVkBR1QT0zo5G7t6yLcWJuhqxxtAU3oqy562PHlgXvhiGJCz
         PvWU+lTMqyO0xCtO9NmF2WfvXUJngsmeYuykSeSo27bDzQgWQZzGjXPunbZhwdLVOZA3
         Qi5Q==
X-Gm-Message-State: AOJu0YyOKGpGUsd9ydP5/EkvkNBtj2SjvdaBU/qr3Fy/LD/FKGONdV5P
	MjkCZR/EwoI5bnhTcW13Mzks8Y1nUSIgWvAN6CtZQQU2PwFz5JaBl8opHLx7Udfr1EJdUZgxfuE
	3XuW/DFxD4Us0yKADRiEHN4/+fY8=
X-Google-Smtp-Source: AGHT+IFnKo2yMFoUWnHYdx5MgHXWqJo/3p3476GiBXgO+r3KE+ZzcnLSgERvlhOrMp3PLiGlJXwGnDhR9add9rR1IzE=
X-Received: by 2002:a17:90a:c382:b0:297:1346:c0fc with SMTP id
 h2-20020a17090ac38200b002971346c0fcmr4936184pjt.35.1707781892425; Mon, 12 Feb
 2024 15:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208195822.1299781-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240208195822.1299781-1-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Feb 2024 15:51:20 -0800
Message-ID: <CAEf4BzbGkx3xy85U7Oku3xCkkr2TEeGs8h9Pc2z61B7Wyz0HTg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support to GCC in CORE macro definitions
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, eddyz87@gmail.com, 
	alexei.starovoitov@gmail.com, david.faust@oracle.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:58=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Due to internal differences between LLVM and GCC the current
> implementation for the CO-RE macros does not fit GCC parser, as it will
> optimize those expressions even before those would be accessible by the
> BPF backend.
>
> As examples, the following would be optimized out with the original
> definitions:
>   - As enums are converted to their integer representation during
>   parsing, the IR would not know how to distinguish an integer
>   constant from an actual enum value.
>   - Types need to be kept as temporary variables, as the existing type
>   casts of the 0 address (as expanded for LLVM), are optimized away by
>   the GCC C parser, never really reaching GCCs IR.
>
> Although, the macros appear to add extra complexity, the expanded code
> is removed from the compilation flow very early in the compilation
> process, not really affecting the quality of the generated assembly.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> ---
>  tools/lib/bpf/bpf_core_read.h | 46 ++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index 0d3e88bd7d5f..074f1f4e4d2b 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -81,6 +81,23 @@ enum bpf_enum_value_kind {
>         val;                                                             =
     \
>  })
>
> +/* Differentiator between compilers builtin implementations. This is a
> + * requirement due to the compiler parsing differences where GCC optimiz=
es
> + * early in parsing those constructs of type pointers to the builtin spe=
cific
> + * type, resulting in not being possible to collect the required type
> + * information in the builtin expansion.
> + */
> +#ifdef __clang__
> +#define bpf_type_for_compiler(type) ((typeof(type) *) 0)

let's call it something with triple underscore and shorter at the same
time. ___bpf_typeof()?

> +#else
> +#define COMPOSE_VAR(t, s) t##s

we already define this as ___concat() in this file, let's reuse that one

> +#define bpf_type_for_compiler1(type, NR) ({ \
> +       extern  typeof(type) *COMPOSE_VAR(bpf_type_tmp_, NR); \

nite: double space

please also align '\' at the end to match the rest of this file

> +       COMPOSE_VAR(bpf_type_tmp_, NR); \
> +})
> +#define bpf_type_for_compiler(type) bpf_type_for_compiler1(type, __COUNT=
ER__)
> +#endif
> +
>  /*
>   * Extract bitfield, identified by s->field, and return its value as u64=
.
>   * This version of macro is using direct memory reads and should be used=
 from

[...]

>   * Convenience macro to check that provided enumerator value is defined =
in
> @@ -246,8 +268,14 @@ enum bpf_enum_value_kind {
>   *    kernel's BTF;
>   *    0, if no matching enum and/or enum value within that enum is found=
.
>   */
> +#ifdef __clang__
>  #define bpf_core_enum_value_exists(enum_type, enum_value)               =
   \
>         __builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, B=
PF_ENUMVAL_EXISTS)
> +#else
> +#define bpf_core_enum_value_exists(enum_type, enum_value)               =
   \
> +       __builtin_preserve_enum_value(bpf_type_for_compiler(enum_type), \
> +                                     enum_value, BPF_ENUMVAL_EXISTS)

with ___bpf_typeof() it should fit on one line

> +#endif
>
>  /*
>   * Convenience macro to get the integer value of an enumerator value in
> @@ -257,8 +285,14 @@ enum bpf_enum_value_kind {
>   *    present in target kernel's BTF;
>   *    0, if no matching enum and/or enum value within that enum is found=
.
>   */
> +#ifdef __clang__
>  #define bpf_core_enum_value(enum_type, enum_value)                      =
   \
>         __builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, B=
PF_ENUMVAL_VALUE)
> +#else
> +#define bpf_core_enum_value(enum_type, enum_value)                      =
   \
> +       __builtin_preserve_enum_value(bpf_type_for_compiler(enum_type), \
> +                                     enum_value, BPF_ENUMVAL_VALUE)
> +#endif
>
>  /*
>   * bpf_core_read() abstracts away bpf_probe_read_kernel() call and captu=
res
> --
> 2.30.2
>

pw-bot: cr

