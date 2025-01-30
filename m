Return-Path: <bpf+bounces-50080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52AA22740
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8B53A702F
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110774C79;
	Thu, 30 Jan 2025 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOtWtAt8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193477464
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197258; cv=none; b=gvjWNxa44jTT8eftCz0XvZIGTcCsGk85yfMG1rOfYPcZotJVap6ufq0fBLDOlix/IWGv5ii6F4iI7pSGBTtTqQ/Pvze+0idxceNWzRzTkLNsiJcBpxadrOnkJUS+XkqXx6OTPdNsSd1yvINeBgu1VjysqegYDiTl8mVJa/CYejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197258; c=relaxed/simple;
	bh=xrel+9aOdO8JMuqY4UQ9v1Bn8VnwAqIjqVLgzy+J7gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E19ZJM6yRnXnb/DbFvLBgaIMsE8NvaTkKQaKEa4midP27jhJwgvmnggcHmcbWcq0kgpQWb+yBWKoL4vv5U88A+QhJb2gTGpAGQG4sMTn+yCs7FHaD4FBx/q83y+XWM4OeBTe0/bcuNzpaDONjDSAWnpOJU8UF0xV6fh8brar5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOtWtAt8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so4045545ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738197255; x=1738802055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4LoPalcMSCgAMmVdSmf+WGvhV9qGFgvHvpxZR02JrM=;
        b=MOtWtAt8OQujLOwPC6vN56OUOu0Dzn+47G/i3zYVrcxUBiPAl/y/XUJqJLxzyN/jxG
         1JUAM4yy9forYyNL1p7YLkOQooEFHsCMpech0u0Qn6Myh9GidGdVThS4rLScubk7cgQA
         oX/gQqN9eqcnK4H3eqZdRRa31NwGn1tiVialQRxXUPe88ulxiaDHV+FJLtQmbZ6XlI0U
         b1NdljdQHkzTyt5U0feTRSemmxZ6vJHujXY5MoExkvsI665F5eJ2QR77aPzyviOih9Gq
         zn5k3sT8AM0JpPT5JAh50I9kJReBIrDzoKh6EROAdmc5WAWL2hH/+vXkLuqH0ftNGCLC
         8XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738197255; x=1738802055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4LoPalcMSCgAMmVdSmf+WGvhV9qGFgvHvpxZR02JrM=;
        b=bmS8DJ3j4Ku+o1Ny6wlve8pCgVGwSLaLHjGfy3I5HP+VJ4XqlczQ0K5jLj15leB5jr
         3RT/AaIL6EoVyL45P69vTNC/YLFmaLppWWlZ9TSKVCKbOFN5TMufoETcP7PLD+c3/cuo
         TaLjYmZlm/CK9FpL6L94hCdIeoQJ6kpbK58IKmAoy4QBf6m7eFA81WMknV7LZNXCGfd4
         nZYht+042isAt9w9CmQ6duErbJn5bHWhh4O0/dEbKzPeVQe5lsAxLEt6jcccVZxZifh6
         MZjVY5qNCA6+ceQaFFALHNSsCySSiZvioyjJynC5cSo0WWQtCSXrNi5TOlz+3ZBLSGaw
         Kc3A==
X-Gm-Message-State: AOJu0YwGAolYmMqLluILscvyBUOwMvm4yQMESn0Go4fUfJzoybUnRfU1
	zr9SmCfn5HtaikCEclzFjhzcuZU7oEbv558JP6BKv9K+9he6+1EyW0yMLx+bc5Huz6l7IRf+S77
	BugpSY+pmeDNvzDa/XNlVNbawrbU=
X-Gm-Gg: ASbGnct3cJW5vOX9YHj4XDtu8BwokNLgDIzLR1G7CFcRxdff6btYGJsPsPBhrsWckPc
	eI2rdw0NibOW8SV5M2OOHsxdWCcSZ5onapf/gYZy+lL/HEPgRhDnTo5hH3Y/mU2kPUx6gcNFG3s
	INC4G3BVhachBx
X-Google-Smtp-Source: AGHT+IGkYP5z1pBjewH0no4eT4wyZx6mRhCENVJUtNimLt31HZnWZ6Tv3sDN3fxG3e3N0x6MbKITZ9ZJs1IjyYS9QIc=
X-Received: by 2002:a05:6a21:32a2:b0:1e1:9fef:e974 with SMTP id
 adf61e73a8af0-1ed7a64f4a5mr9007648637.24.1738197255200; Wed, 29 Jan 2025
 16:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev> <20250127233955.2275804-3-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-3-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 16:33:59 -0800
X-Gm-Features: AWEUYZmZ7-4htpk4Y8TGnkM71Zo6N7L89BR6TkXctOBldzB5yZHHfk_hSoKg_Go
Message-ID: <CAEf4BzZ-nkSV4upWsGznMP-vvq_jCKBbWVKPxYoNJ-CKUYTO9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] docs/bpf: document the semantics of BTF
 tags with kind_flag
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Explain the meaning of kind_flag in BTF type_tags and decl_tags.
> Update uapi btf.h kind_flag comment to reflect the changes.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Documentation/bpf/btf.rst      | 25 +++++++++++++++++++++----
>  include/uapi/linux/btf.h       |  3 ++-
>  tools/include/uapi/linux/btf.h |  3 ++-
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 2478cef758f8..48d9b33d59db 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -102,7 +102,8 @@ Each type contains the following common data::
>           * bits 24-28: kind (e.g. int, ptr, array...etc)
>           * bits 29-30: unused
>           * bit     31: kind_flag, currently used by
> -         *             struct, union, fwd, enum and enum64.
> +        *             struct, union, enum, fwd, enum64,
> +        *             decl_tag and type_tag

tabs instead of spaces (docs seem to be using spaces)


>           */
>          __u32 info;
>          /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
> @@ -478,7 +479,7 @@ No additional type data follow ``btf_type``.
>
>  ``struct btf_type`` encoding requirement:
>   * ``name_off``: offset to a non-empty string
> - * ``info.kind_flag``: 0
> + * ``info.kind_flag``: 0 or 1
>   * ``info.kind``: BTF_KIND_DECL_TAG
>   * ``info.vlen``: 0
>   * ``type``: ``struct``, ``union``, ``func``, ``var`` or ``typedef``
> @@ -489,7 +490,6 @@ No additional type data follow ``btf_type``.
>          __u32   component_idx;
>      };
>
> -The ``name_off`` encodes btf_decl_tag attribute string.
>  The ``type`` should be ``struct``, ``union``, ``func``, ``var`` or ``typ=
edef``.
>  For ``var`` or ``typedef`` type, ``btf_decl_tag.component_idx`` must be =
``-1``.
>  For the other three types, if the btf_decl_tag attribute is
> @@ -499,12 +499,21 @@ the attribute is applied to a ``struct``/``union`` =
member or
>  a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
>  valid index (starting from 0) pointing to a member or an argument.
>
> +If ``info.kind_flag`` is 0, then this is a normal decl tag, and the
> +``name_off`` encodes btf_decl_tag attribute string.
> +
> +If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
> +__attribute__. In this case, ``name_off`` encodes a string
> +representing the attribute-list of the attribute specifier. For
> +example, for an ``__attribute__((aligned(4)))`` the string's contents
> +is ``aligned(4)``.
> +
>  2.2.18 BTF_KIND_TYPE_TAG
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>
>  ``struct btf_type`` encoding requirement:
>   * ``name_off``: offset to a non-empty string
> - * ``info.kind_flag``: 0
> + * ``info.kind_flag``: 0 or 1
>   * ``info.kind``: BTF_KIND_TYPE_TAG
>   * ``info.vlen``: 0
>   * ``type``: the type with ``btf_type_tag`` attribute
> @@ -522,6 +531,14 @@ type_tag, then zero or more const/volatile/restrict/=
typedef
>  and finally the base type. The base type is one of
>  int, ptr, array, struct, union, enum, func_proto and float types.
>
> +Similarly to decl tags, if the ``info.kind_flag`` is 0, then this is a
> +normal type tag, and the ``name_off`` encodes btf_type_tag attribute
> +string.
> +
> +If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
> +__attribute__, and the ``name_off`` encodes a string representing the
> +attribute-list of the attribute specifier.
> +
>  2.2.19 BTF_KIND_ENUM64
>  ~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index ec1798b6d3ff..266d4ffa6c07 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -36,7 +36,8 @@ struct btf_type {
>          * bits 24-28: kind (e.g. int, ptr, array...etc)
>          * bits 29-30: unused
>          * bit     31: kind_flag, currently used by
> -        *             struct, union, enum, fwd and enum64
> +        *             struct, union, enum, fwd, enum64,
> +        *             decl_tag and type_tag
>          */
>         __u32 info;
>         /* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64=
.
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/bt=
f.h
> index ec1798b6d3ff..266d4ffa6c07 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -36,7 +36,8 @@ struct btf_type {
>          * bits 24-28: kind (e.g. int, ptr, array...etc)
>          * bits 29-30: unused
>          * bit     31: kind_flag, currently used by
> -        *             struct, union, enum, fwd and enum64
> +        *             struct, union, enum, fwd, enum64,
> +        *             decl_tag and type_tag
>          */
>         __u32 info;
>         /* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64=
.
> --
> 2.48.1
>

