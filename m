Return-Path: <bpf+bounces-28492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1163F8BA6BD
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 07:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC9B214D1
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B7E13959F;
	Fri,  3 May 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFRfST1e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803F139CF8
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714715562; cv=none; b=jaX509eXU5e1jHq1lFceYLUAuEUogz2Xo7Dg6rcFGYBEtkbq36KlDiK0Ap5EcDS6Z4MiBkVlwS/Q+Lv7boQfd3qcIvLlfVuztzDdA+0L/oEtcnzhIEC7xRi/rVXJOmVQZ6DM7+2J9c7Y2X8iKnDc0aKkr21DIP0j8C+06I2yQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714715562; c=relaxed/simple;
	bh=VQF0eVn3NoCAXy5UhycDlnOdWYZ4DwZ9KEE9+hm5d5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAnKO+OvNoKcV9rDVuvjvByHzFUpEyl7K++pwUn/Cl13ebSuvOzjgbVUCprHYkH+7MdTNpm8QnCK7Rck0LT3UE+25UJSA8rqA2duccuO67ZyvcxD641sGoe3zK90RdvNk+Z+suKhycO6dZTOO5/ZEu6yZhvvHkWI2nc8n+puMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFRfST1e; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58e787130fso444235566b.0
        for <bpf@vger.kernel.org>; Thu, 02 May 2024 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714715559; x=1715320359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YcBX4IFJJWJ7CNCZ4ItBXGe7Szn5wWHCK12m8WLPnU=;
        b=EFRfST1e0DJr8G5XaJk44CcunRSIuCuLZS7bjR48xOtPcffcMErM6bgemsOgherLPS
         hgn5BEaOBVMGcbk9NUkMC+Dl7YDNXnPf8bb9duNUEneZOKsdSsr5kCL2MLQzEKI4C6dj
         RKEhZfmdkLfqTwTVhEaQC3pYuFp4cKachxtd3gDyPJXx/6GacfmcP4VynBTqVtUY1iB6
         trBrFTzXpoQvgErFQ7W48AGu7kiNyYz+oy5Gn7xd1XBE61oMGTVOFg8bjGZGq+ySVNAY
         xw5is6Xgzs1wRYSeonilkZLfcUVk/cIGr9KiY7tktqKVJFMaflKbP4UiXdqMW260XrbS
         8t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714715559; x=1715320359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YcBX4IFJJWJ7CNCZ4ItBXGe7Szn5wWHCK12m8WLPnU=;
        b=GwKuc2t1QRi0MziGzghKQ81waFST69AUpbDEs+9anTrGG8VjGwh6hld6yAmk1JAhw9
         GZpADcF4qNB8o4RGg4YnISadJXfU597ccEOT+4pjQmF7qn1Dh/XEVM8r4q2qTzfLvHsg
         hiLmdMAd1gOrLvFVMWQ7QcDTF6RGTE62mlA1pbDf7oLf/BCbY1CESpmoDdO+sNmL2Rq8
         3Dl8UmzeHJGdDYdUMiFFVbpV++H7TFUuLvBWmXzLV/ta+v0+lrlSglD4bvhHx77uN7h6
         L+2CwW6LXLq695hTulKT02+zwUOYbGlCELfbjJfl0V3zLNWsQV1cC1VKxNl/NQAs8bKB
         3HCA==
X-Gm-Message-State: AOJu0YztA/v7eQWFzB1HkPhjTs/m46stClTVr8yx+2i1Nw2VSFScuvxP
	sNc9bmPiYYzJ5jDAaxSGmk/mXtxcruutRACzH0ObeI+tCqGjCV2gMtdp9RE76Ix1nD/i8T7EXyu
	B9M2PkojFgSahG8nkVZ6y3jVTYzLjRg==
X-Google-Smtp-Source: AGHT+IFnU3GN0S/3XMVcjXIRttM5x/IHiBizsijW6iQBHpP33vWulby1HrDUCp11Nv2gOSu19dG6l4LY2Nm2mXWpEvk=
X-Received: by 2002:a17:906:f58e:b0:a59:21d9:df3a with SMTP id
 cm14-20020a170906f58e00b00a5921d9df3amr4509027ejd.5.1714715558829; Thu, 02
 May 2024 22:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428112559.10518-1-jose.marchesi@oracle.com>
In-Reply-To: <20240428112559.10518-1-jose.marchesi@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 May 2024 22:52:24 -0700
Message-ID: <CAEf4Bzb-bbEZ5Q6vSX+tiMu4iME2uVjN1T3d3vPZXMe5ngAfxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix bpf_ksym_exists in GCC
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 4:26=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> The macro bpf_ksym_exists is defined in bpf_helpers.h as:
>
>   #define bpf_ksym_exists(sym) ({                                        =
                       \
>         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be mar=
ked as __weak");       \
>         !!sym;                                                           =
                       \
>   })
>
> The purpose of the macro is to determine whether a given symbol has
> been defined, given the address of the object associated with the
> symbol.  It also has a compile-time check to make sure the object
> whose address is passed to the macro has been declared as weak, which
> makes the check on `sym' meaningful.
>
> As it happens, the check for weak doesn't work in GCC in all cases,
> because __builtin_constant_p not always folds at parse time when
> optimizing.  This is because optimizations that happen later in the
> compilation process, like inlining, may make a previously non-constant
> expression a constant.  This results in errors like the following when
> building the selftests with GCC:
>
>   bpf_helpers.h:190:24: error: expression in static assertion is not cons=
tant
>   190 |         _Static_assert(!__builtin_constant_p(!!sym), #sym " shoul=
d be marked as __weak");       \
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fortunately recent versions of GCC support a __builtin_has_attribute
> that can be used to directly check for the __weak__ attribute.  This
> patch changes bpf_helpers.h to use that builtin when building with a
> recent enough GCC, and to omit the check if GCC is too old to support
> the builtin.
>
> The macro used for GCC becomes:
>
>   #define bpf_ksym_exists(sym) ({                                        =
                               \
>         _Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " s=
hould be marked as __weak");   \
>         !!sym;                                                           =
                               \
>   })
>
> Note that since bpf_ksym_exists is designed to get the address of the
> object associated with symbol SYM, we pass *sym to
> __builtin_has_attribute instead of sym.  When an expression is passed
> to __builtin_has_attribute then it is the type of the passed
> expression that is checked for the specified attribute.  The
> expression itself is not evaluated.  This accommodates well with the
> existing usages of the macro:
>
> - For function objects:
>
>   struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __we=
ak;
>   [...]
>   bpf_ksym_exists(bpf_task_acquire)
>
> - For variable objects:
>
>   extern const struct rq runqueues __ksym __weak; /* typed */
>   [...]
>   bpf_ksym_exists(&runqueues)
>
> Note also that BPF support was added in GCC 10 and support for
> __builtin_has_attribute in GCC 9.
>
> Locally tested in bpf-next master branch.
> No regressions.
>
> Signed-of-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---
>  tools/lib/bpf/bpf_helpers.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 62e1c0cc4a59..a720636a87d9 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -186,10 +186,19 @@ enum libbpf_tristate {
>  #define __kptr __attribute__((btf_type_tag("kptr")))
>  #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
>
> +#if defined (__clang__)
>  #define bpf_ksym_exists(sym) ({                                         =
                               \
>         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be mar=
ked as __weak");       \
>         !!sym;                                                           =
                       \
>  })
> +#elif __GNUC__ > 8
> +#define bpf_ksym_exists(sym) ({                                         =
                               \
> +       _Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " s=
hould be marked as __weak");   \
> +       !!sym;                                                           =
                               \
> +})

I wrapped _Static_assert() to keep it under 100 characters (and fix
one unaligned '\' while at it). Also, the patch prefix should be
"libbpf: " as this is purely a libbpf header. Applied to bpf-next,
thanks.

> +#else
> +#define bpf_ksym_exists(sym) !!sym
> +#endif
>
>  #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
>  #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
> --
> 2.30.2
>
>

