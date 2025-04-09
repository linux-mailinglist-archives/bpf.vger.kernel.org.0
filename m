Return-Path: <bpf+bounces-55608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74EA834D5
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFA33B6429
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC77E21C175;
	Wed,  9 Apr 2025 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcrQ/PoU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8B1A5BA4
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242713; cv=none; b=jwovAgY+2wxbxQKL0lfzdVvYXZi8xcfLaqJIYnT+ZblmttBfRiifyPOSQqxnOeUeSANyV2x/ctg4pe+enqRLbftsTcRY7jVDJZVvNywWQl+MNGM7ha6hcM/e/n82EdUuL4+j3Z/FnABTDKcBr0mCYL4ZNl/5rdh3R9GBruzVuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242713; c=relaxed/simple;
	bh=ksKH9gATVOXT7BZRjX+E3qIk9U9AsNOVdxbT7yYEKnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBeAknETMT0VqawZnD8LQPXONjJrHjYSd+5u1lSNZ5UubW7UrfkY5MH7s7qn2SMEZORScO85WV2mAt6abeAXkW8GqHlZKETCAfYgi2g20PqVT2LHOlCgQhrbjK38gKkQircE/KpVqK+qZ+6HFlxODTWIiAS4uE+Y+bsN1jikIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcrQ/PoU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so123656b3a.3
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 16:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744242711; x=1744847511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgjk1z69WUyfpdGAtw6E7EsFwh/BHN8N0h99fIKd8R0=;
        b=HcrQ/PoUpW+lZGiC2kNyaeWBGXLXkkuQtAX0M0waRg6cigq7NSS3Nq12LQt7S/Pg1j
         ozrJBQQEHr0yrYHuviPA190tvEOJ25e+NppWOgzqBsUzsswUUlJXyYx4P8KJWz7PnVL4
         7ShpJtayWNg3V2nBpk9GsZzXICJTEw7Yr2jdX17iVzAiXkoxgB1RlFBLWQ+goIWc4CuY
         y679mSGoPB8mpt2tMZfnUgALAQZJzqsmvzV0EayUDNSvCGVqMnXVhR0xnee7EewAWAuU
         jjiTIsu0bKI9cTxmt4UQB80KWrgg0ID+4I1mrfqB8XXviHopwHDweI8CnhrpbtT1RlYu
         FurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744242711; x=1744847511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgjk1z69WUyfpdGAtw6E7EsFwh/BHN8N0h99fIKd8R0=;
        b=puCPZz5/3u1QlnqxpR9LVuH6yQLXu0Fy0X5zcPFY2I+5R36u5U2sKZLriTCObELEac
         oiVfjmY4TZjelRNYWT702UZ8m5R42qEqUcEcXYGzc7BpstT7+e1zOnuV0OrhmD0Ki11R
         HBTQOiW0uJRCK8NA1TOTR2qa35P9hTZSq+S8RJU7kuI2NWT0DxbigRXG/EYa2FuWWnsb
         rWOFZGK4C2A9V1F0jR9n74f62opIZKSTaTx+Bd34maeUbcDPPqg87GMgrfM86nWZSd8Y
         OwwfmAxBOK8YjJ9YpwBlaOaIlAdO2AqY+LVwPYOwZjQoFCq+8yi2L/xKenvhFQa9f2hZ
         ImWg==
X-Gm-Message-State: AOJu0YycOLwo48R6pjPfJBUyNL1xYVi5/SHI3hseGnsL0+GR8MytKZ8Q
	3Kq1QmcjFch6hIrZo2pa0A6UqWZbkCT9qGBlX8kYRDBuFgcLqN6NJjjh/Z4L3Mkcui11VLlFz9U
	K9wp7cAcWPycxuJ+VkVPd8KbYaT+4oFga
X-Gm-Gg: ASbGncvHjq1AkJ+aEaU2p8RSDKbwKvPFDx/ms/Yzs7ecLsTt7R8ZO+XjG2l7mYqOWal
	9uTbPRX8gBVe8TrK4orar6FAKv9o6OBEVpgjN7FHX1eSEmH0HNeYIDOS+dwQhmcfvyxv7pTVvnf
	8+iAwvrK4Gkn5sNuIpXuMkl303T3WgXvh6E5o4TA==
X-Google-Smtp-Source: AGHT+IGtMOEPieq8IXFkaZtgAK7rh1E2517OTZCLAYPwJNRMES3YqED3tmI3QBmhnmKFToFuOFoPW71C7vYvQ3hk0UA=
X-Received: by 2002:a05:6a00:1152:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-73bbefad6camr990782b3a.20.1744242710849; Wed, 09 Apr 2025
 16:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407190158.351783-1-tim.cherry.co@gmail.com> <20250407190158.351783-2-tim.cherry.co@gmail.com>
In-Reply-To: <20250407190158.351783-2-tim.cherry.co@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Apr 2025 16:51:39 -0700
X-Gm-Features: ATxdqUEjtcgHuVeYgryKrsrAnbJlnj-0Uil4yYvgWNouM7WEiLqZ_svTQqcy5_A
Message-ID: <CAEf4BzZKNhnNAhHb8ZSWa0KzJM2j_cht6_C1G389RaoSOW_Xow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: add proto_func param name generation
To: 20250331201016.345704-1-tim.cherry.co@gmail.com
Cc: bpf@vger.kernel.org, mykyta.yatsenko5@gmail.com, 
	Timur Chernykh <tim.cherry.co@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 12:24=E2=80=AFPM Timur Chernykh <tim.cherry.co@gmail=
.com> wrote:
>
> When the kernel loads BTF with specified min-CORE BTF and libbpf does som=
e
> sanitizing on those, then it "translates" func_proto to enum. But if
> func_proto has no names for it's parameters then kernel verifier fails
> with "Invalid name" error. This error caused by enum members must has a
> valid C identifier, but there's might be no names generated in some
> cases like function callback member declaration. This commit adds enum
> names generation during sanitizing process for func_proto kind, when
> it's being translate to `enum` kind.
>

I asked ChatGPT to fix up grammar and typos, it did a pretty good job,
actually :)


When the kernel loads BTF with a specified min-CORE BTF and libbpf
performs some sanitization, it "translates" FUNC_PROTO to an ENUM.
However, if the FUNC_PROTO has no parameter names, the kernel verifier
fails with an "Invalid name" error. This is because enum members must
have valid C identifiers, but in some cases=E2=80=94such as function callba=
ck
member declarations=E2=80=94no names may be generated.

This commit adds name generation for enum members during the
sanitization process of the FUNC_PROTO kind when it is being
translated to the ENUM kind.


> Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6b85060f07b3..c2369b6f3260 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3128,6 +3128,8 @@ static int bpf_object__sanitize_btf(struct bpf_obje=
ct *obj, struct btf *btf)
>         bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>         bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
>         bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DA=
TASEC);
> +

don't split variable declaration block with empty lines

> +       char name_gen_buff[32] =3D {0};
>         int enum64_placeholder_id =3D 0;
>         struct btf_type *t;
>         int i, j, vlen;
> @@ -3178,10 +3180,50 @@ static int bpf_object__sanitize_btf(struct bpf_ob=
ject *obj, struct btf *btf)
>                         if (name[0] =3D=3D '?')
>                                 name[0] =3D '_';
>                 } else if (!has_func && btf_is_func_proto(t)) {
> +                       struct btf_param *params;
> +                       int new_name_off;
> +
>                         /* replace FUNC_PROTO with ENUM */
>                         vlen =3D btf_vlen(t);
>                         t->info =3D BTF_INFO_ENC(BTF_KIND_ENUM, 0, vlen);
>                         t->size =3D sizeof(__u32); /* kernel enforced */
> +
> +                       /* since the btf_enum and btf_param has the same =
binary layout
> +                        * it's ok to use btf_param
> +                        */
> +                       params =3D btf_params(t);
> +
> +                       for (j =3D 0; j < vlen; ++j) {
> +                               struct btf_param *param =3D &params[j];
> +                               const char *param_name =3D btf__str_by_of=
fset(btf, param->name_off);
> +
> +                               /*
> +                                * kernel disallow any unnamed enum membe=
rs which can be generated for,
> +                                * as example, struct members like
> +                                * struct quota_format_ops {
> +                                *     ...
> +                                *     int (*get_next_id)(struct super_bl=
ock *, struct kqid *);
> +                                *     ...
> +                                * }
> +                                */
> +                               if (param_name && param_name[0])
> +                                       continue; /* definitely has a nam=
e */
> +
> +                               /*
> +                                * generate an uniq name for each func_pr=
oto
> +                                */
> +                               snprintf(name_gen_buff, sizeof(name_gen_b=
uff), "__parm_proto_%d_%d", i, j);
> +                               new_name_off =3D btf__add_str(btf, name_g=
en_buff);
> +
> +                               if (new_name_off < 0) {
> +                                       pr_warn("Error creating the name =
for func_proto param\n");
> +                                       return new_name_off;
> +                               }
> +
> +                               /* give a valid name to func_proto param =
as it now an enum member */
> +                               param->name_off =3D new_name_off;

kernel doesn't really check nor enforce that enumerator names should
be unique, just that they are valid, so instead of all this we can
just add a trivial "p" string and use it for all parameters

try to make this code a bit more tight and succinct: shorter names
(look around the code you are adding new code to and keep the styling
consistent), no need for pr_warn(), it's unlikely that we'll fail to
add a string (we don't explicitly log -ENOMEM conditions)

also, instead of param =3D &params[j] and so on, just do

struct btf_param *p;

p =3D btf_params(t);
for (j =3D 0; j < vlen; j++, p++) { ... }

pw-bot: cr

> +                       }
> +
>                 } else if (!has_func && btf_is_func(t)) {
>                         /* replace FUNC with TYPEDEF */
>                         t->info =3D BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0);
> --
> 2.49.0
>
>

