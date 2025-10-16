Return-Path: <bpf+bounces-71135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03786BE511D
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 971A64E06BF
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359823507C;
	Thu, 16 Oct 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOwAK85O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39D223710
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639809; cv=none; b=optdn1LiIOzYS4pr5O4yayKXNmbeOXcPwPTXAmSrq5WwTfFUPNV/qPwEcq9kiyyVTjrvqKlo1B8IxwhoWP7IwfrpuhmqX/v02tpPn4YazsJVEI3m4B9VQk+ArwKd6TDuhTQQWrcg/Ot4/4OG+LHN42gDMpNW2qsBJF20piwQzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639809; c=relaxed/simple;
	bh=1rbL45FMVSe4BjG/+S1b4B71TRFQ1nJRqlW4ptOffFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnXnMGsIJMVrvmTjF0xQP+d0hc/2l+G1GU9Er5zCm+iJzOFc3crzsmc/Y7rmbJ1fL1NxljygHS+H1N5oVROZnla3AaZQl+tFA3ZeVHnQRRhdaqC7yuoyvwFWZmGMLTOBkQ+ImonMpAmmJCxbgpu2KtE+jCJ7MAu9XrXcv6d/wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOwAK85O; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33ba5fc3359so1132702a91.3
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639807; x=1761244607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtvzcspykrWvml/ZQaFmJ1ULtUoDYDgtDcEdxkXU444=;
        b=jOwAK85OIUe2meckK+AcwATu9pHQj8sOq9uSB9bVwu0cOPPlwjfD6sE5DUExM0W5E4
         WELCie6vkrHudsTSIQTU4aiXJsy33IuRr1unTfVLLzppwaI5IFk18LAXDcB6PWCvAFUU
         erT/yrSJ4LLKLc/STRu5TRofYZuE6cA1wvK80oI5qF8xkagginAEYrjwoYkLSMjxohjo
         0M1gsBwe+CmhGZot882MU8V9z8xhmc/4NpCw6dYMMlelCVXb4YM0Gf618TAnex8RCE9J
         LlH1kX/SNwt8mOKVn7TCmQGSCJAbBVEjtH4/2qUCqGBryzfVDyPWFuP4ohVIghBzcqlR
         Z1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639807; x=1761244607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtvzcspykrWvml/ZQaFmJ1ULtUoDYDgtDcEdxkXU444=;
        b=EGjhS0hfpB08k/pqtjJW0wIwpjz2Gz6gN/VbzdZV0d2X3tIVO9rMjkPBpY8OvGvuiG
         YJS9BqKya3jki+d3KVZ1FSjAiBzYoVeeRbXvGgK3WcP8iH++jezOmJFXCCbh8mlilNMh
         bVlMVZULfnfiuZ+ZqM+3/Vp17Bfk8NNskgL2Av5Z37O9lbmaDG9eOlPEZkokC84f9zlr
         D1wI/bydKcw4Wqa5zQV2dqIiILJfV5P3T0xoIR8KXPp8MJaKx0//BcHqwzu+LYo6ZTpI
         RCPVuAqeW1+y4CY+G7qyVXoxqNm7cYiAmC2zlq361mcU89VfACvAe1qbyXSo+g2T83ZX
         GMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZKiVvg7AXC//Hdn3uj1UFDEvd6rRT8DD10XbQsAmrm0LqGIoy5KxJ8Ylyf6GKRKAGgyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUWbvozOFdZyWOUl2s5i7nTi+pjmL1aDIzN4LAUjf655DC9KD9
	/rMMw5zM+vjTLf6qCJxTwLV0vkxkyVn9p9fYI26sgJ+5LMucsgjy3FQjwcDF/gCb8gnfgXx/fje
	v6Udjq5YbJYs0U+rYd/MSiC8N5g3X3Lw=
X-Gm-Gg: ASbGnculP0zmWl20IVL/fm0QWDsLRXb0wlk8Lbtpydg2tMQnW+GRoSpwd8ALpz4IRRv
	xqIeYYVlobgpaSIljIyZ1HfF1LqcdH3zF4/G1Pkru9m7aT6s+28xmDQH0jiD5SZ/ZXCix0f8bKC
	uBbXS1Uf3to0llrhVOIJpEXnvWwHT3kdvYzd6EUMxfHF5JHNvNhC4LCPtIWOTI+HnWwDCLl2e3p
	Ne9m9Q2dm+u/mzVMaSQgKoBWyKWS4o4GG9LqdEzebLnbYzUIuoP9fa5cWEMwHkgoeTjkcDkOBtW
	0Ie+4NvL5kuo8xEm2jpw7w==
X-Google-Smtp-Source: AGHT+IFA+yWqh6yNcbdD6yNvAlEMBpxPiFs7IgcCtVuveruvuo2NP7BZ2jGaPK+s1vL+azXNqAa4quoI3FkCqHhdO1g=
X-Received: by 2002:a17:90b:5623:b0:33b:d371:1131 with SMTP id
 98e67ed59e1d1-33bd3711391mr513567a91.34.1760639806706; Thu, 16 Oct 2025
 11:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com> <20251008173512.731801-2-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:36:31 -0700
X-Gm-Features: AS18NWBsOIN6uckciWK7ely2k0oEzQ3wfrycAbveEAnKw8ZNiAGlfwI6cbDCm-s
Message-ID: <CAEf4BzZ-0POy7UyFbyN37Y6zx+_2Q0kKR3hrQffq+KW6MOkZ1w@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/15] bpf: Extend UAPI to support location information
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
> to help represent location information for functions.
>
> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
> location; either via a register, or register+offset or a
> constant value.
>
> BTF_KIND_LOC_PROTO represents location information about a location
> with multiple BTF_KIND_LOC_PARAMs.
>
> And finally BTF_KIND_LOCSEC is a set of location sites, each
> of which has
>
> - a name (function name)
> - a function prototype specifying which types are associated
>   with parameters
> - a location prototype specifying where to find those parameters
> - an address offset
>
> This can be used to represent
>
> - a fully-inlined function
> - a partially-inlined function where some _LOC_PROTOs represent
>   inlined sites as above and others have normal _FUNC representations
> - a function with optimized parameters; again the FUNC_PROTO
>   represents the original function, with LOC info telling us
>   where to obtain each parameter (or 0 if the parameter is
>   unobtainable)
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/btf.h            |  29 +++++-
>  include/uapi/linux/btf.h       |  85 ++++++++++++++++-
>  kernel/bpf/btf.c               | 168 ++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/btf.h |  85 ++++++++++++++++-
>  4 files changed, 359 insertions(+), 8 deletions(-)
>

[...]

> @@ -78,6 +80,9 @@ enum {
>         BTF_KIND_DECL_TAG       =3D 17,   /* Decl Tag */
>         BTF_KIND_TYPE_TAG       =3D 18,   /* Type Tag */
>         BTF_KIND_ENUM64         =3D 19,   /* Enumeration up to 64-bit val=
ues */
> +       BTF_KIND_LOC_PARAM      =3D 20,   /* Location parameter informati=
on */
> +       BTF_KIND_LOC_PROTO      =3D 21,   /* Location prototype for site =
*/
> +       BTF_KIND_LOCSEC         =3D 22,   /* Location section */
>
>         NR_BTF_KINDS,
>         BTF_KIND_MAX            =3D NR_BTF_KINDS - 1,
> @@ -198,4 +203,78 @@ struct btf_enum64 {
>         __u32   val_hi32;
>  };
>
> +/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, name_o=
ff is 0

what if we make LOC_PARAM variable-length (i.e., use vlen). We can
always have a fixed 4 bytes value that will contain an arg size, maybe
some flags, and an enum representing what kind of location spec it is
(constant, register, reg-deref, reg+off, reg+off-deref, etc). And then
depending on that enum we'll know how to interpret those vlen * 4
bytes. This will give us extensibility to support more complicated
expressions, when we will be ready to tackle them. Still nicely
dedupable, though. WDYT?

> + * and is followed by a singular "struct btf_loc_param". type/size speci=
fies
> + * the size of the associated location value.  The size value should be
> + * cast to a __s32 as negative sizes can be specified; -8 to indicate a =
signed
> + * 8 byte value for example.
> + *
> + * If kind_flag is 1 the btf_loc is a constant value, otherwise it repre=
sents
> + * a register, possibly dereferencing it with the specified offset.
> + *
> + * "struct btf_type" is followed by a "struct btf_loc_param" which consi=
sts
> + * of either the 64-bit value or the register number, offset etc.
> + * Interpretation depends on whether the kind_flag is set as described a=
bove.
> + */
> +
> +/* BTF_KIND_LOC_PARAM specifies a signed size; negative values represent=
 signed
> + * values of the specific size, for example -8 is an 8-byte signed value=
.
> + */
> +#define BTF_TYPE_LOC_PARAM_SIZE(t)     ((__s32)((t)->size))
> +
> +/* location param specified by reg + offset is a dereference */
> +#define BTF_LOC_FLAG_REG_DEREF         0x1
> +/* next location param is needed to specify parameter location also; for=
 example
> + * when two registers are used to store a 16-byte struct by value.
> + */
> +#define BTF_LOC_FLAG_CONTINUE          0x2
> +
> +struct btf_loc_param {
> +       union {
> +               struct {
> +                       __u16   reg;            /* register number */
> +                       __u16   flags;          /* register dereference *=
/
> +                       __s32   offset;         /* offset from register-s=
tored address */
> +               };
> +               struct {
> +                       __u32 val_lo32;         /* lo 32 bits of 64-bit v=
alue */
> +                       __u32 val_hi32;         /* hi 32 bits of 64-bit v=
alue */
> +               };
> +       };
> +};
> +
> +/* BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations =
relate
> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by=
 a
> + * a vlen-specified number of __u32 which specify the associated
> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
> + * location.  The type should either be 0 (no location info) or point at
> + * a BTF_KIND_LOC_PARAM.  Multiple BTF_KIND_LOC_PARAMs can be used to
> + * represent a single function parameter; in such a case each should spe=
cify
> + * BTF_LOC_FLAG_CONTINUE.
> + *
> + * The type field in the associated "struct btf_type" should point at an
> + * associated BTF_KIND_FUNC_PROTO.
> + */
> +
> +/* BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
> + * containing location site-specific information;
> + *
> + * - name associated with the location (name_off)
> + * - function prototype type id (func_proto)
> + * - location prototype type id (loc_proto)
> + * - address offset (offset)
> + */
> +
> +struct btf_loc {
> +       __u32 name_off;
> +       __u32 func_proto;
> +       __u32 loc_proto;
> +       __u32 offset;
> +};

What is that offset relative to? Offset within the function in which
we were inlined? Do we know what that function is? I might have missed
how we represent that.

> +
> +/* helps libbpf know that location declarations are present; libbpf
> + * can then work around absence if this value is not set.
> + */
> +#define BTF_KIND_LOC_UAPI_DEFINED 1
> +

you don't mention that in the commit, I'll have to figure this out
from subsequent patches, but it would be nice to give an overview of
the purpose of this in this patch


[...]

