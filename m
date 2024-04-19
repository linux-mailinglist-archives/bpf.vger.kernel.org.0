Return-Path: <bpf+bounces-27189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E48AA613
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 02:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361601F222DC
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 00:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B33372;
	Fri, 19 Apr 2024 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFPT9GF2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221987F;
	Fri, 19 Apr 2024 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485207; cv=none; b=EnQFlQaf4K0YVeXEyoP7b2QBeEyVvm5NEqkLmev1L4r4LNbdBndr+yXaTLz6MBEaDaPaekQ16HbVv0YH4QdAe1iklXDzjj/N92xGUleWko3gnQ1OQCgQ1cpJcUOUku/SjBSFaRuMNakbNSJ1iMqfKhxeB86wLKTLUTGQUu5ogO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485207; c=relaxed/simple;
	bh=dy6VHv3Joc4Mt3esV02MhGm3EZY+hP2gUuWFLddz9fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi8BWk43bnRkV7rk5976zwz/ymrbtpsF44Ain57+P/TUFclUkOyDAEPeaQ1U6jsANNk4vXkHvWq5uMPU5QdAUCzqCnXt/PNHFf6hu1ESfZpzTxfRGk4eNfzJ6AoOLfSFSl7GKdIfLU0dkVPTGJHFgmnI6t9YxcPnbXklC4QMizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFPT9GF2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so872603a12.0;
        Thu, 18 Apr 2024 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713485205; x=1714090005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f04bGW23kA1vQtafifnXdUC394zPIaqeSJbFwK5fAko=;
        b=OFPT9GF217uElNGc1Y2AQDKDBh+5uQky5DyNTTWZ+VCbshQjHKKqTzu8JnAJWrYRQo
         oqdvLqTIrljJfPNMXthHJ+cAsEIciM2wWkC3hCjcv8F7CtqCJUt3DjLYuN5/PXg1Nnni
         y0g1k2yp7/N/n0J3+a7aX95+0AhLZ9eqFuXCwkiTsf0U04+Obo0ZfXSGm33nNbcvGJsD
         ADVmypdA97lcJvufsFvrTy/O/lRuNSYgdkhLBrDEAG4yjrdTy9A4ELIWMQbjf0NXD/j6
         h0MCNPJDTY2mhvgbW60mtkA4aQrBLsTODBrjeYtZ8jroWEa+4uk7K6qBLj0i2nMznQ3R
         rp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713485205; x=1714090005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f04bGW23kA1vQtafifnXdUC394zPIaqeSJbFwK5fAko=;
        b=cmIoAm8nVys2Isg51u0mLf/62/U6eA/2lLnImcusJ2gITukvdXU9gyVVl4CnucSLn/
         LtdM7gY6yTi5/Gzo+eFhATufAUeXPLxrciBBHXTxcyyOe6TgPohYREQZDMfEaod3JgPb
         vtNrG7KoEiPuSJlN8DvyyQpELywQevR+AKXZj6sy0oHpvBOcJop4b5Ys1Y803KE/k1Tt
         59wFXWgtxK8wTNZ+m7g6CsPalXxnowwNRRycccYk5hhXlIJJ9GZnDDGnzSK1d6sxSEJo
         /r2k9ZV2PLXP5uRH9paMVMeKbXVCd1Gc7yMcIlGyr6veYl5umFB33IkgzkqqBrJQ+y3V
         UG7g==
X-Forwarded-Encrypted: i=1; AJvYcCW5hdEvLYWdZhNu++sOf6eQfLM6Fh2pKWqWSYlOq8qPTU70m3ReUBNCKKKSzDZtcYMoYlFds5liShJeEMTAuJYg4zxytv0nPLIHJWY8qE492qzKPg0MP+pxMP0akw==
X-Gm-Message-State: AOJu0Ywt5Hq4xxwAyW32S8u/P/2MlIC7B07DXvlg9+82k9t7763QhVDY
	RG4knxFhHOY5Tg2QeLeGop2EOW8wkc1eiA1XqMWBSoPj2gyXviY6l9dt+lTFCGOqYBwQAl5jOD9
	3cBzPdj3/sLgfXrYyLDgtXFm5jBY=
X-Google-Smtp-Source: AGHT+IHSOB6WAdgdFzhljmNBqmnrSPIwLGwuBQ08WQIVYJ43wPmKxRAIa3SoXYEhwrBHEootQ77Bn11iHgfIlpTGtOM=
X-Received: by 2002:a17:90a:7e81:b0:2a6:1625:368c with SMTP id
 j1-20020a17090a7e8100b002a61625368cmr790881pjl.6.1713485205274; Thu, 18 Apr
 2024 17:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416143718.2857981-1-alan.maguire@oracle.com> <20240416143718.2857981-2-alan.maguire@oracle.com>
In-Reply-To: <20240416143718.2857981-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Apr 2024 17:06:32 -0700
Message-ID: <CAEf4BzaS9_x+0DPuHU4NAFEP1+Mb-RPdmMfVCw9oW-d=Lj-cmg@mail.gmail.com>
Subject: Re: [PATCH dwarves 1/3] pahole: allow --btf_features to not
 participate in "all"
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, jolsa@kernel.org, 
	williams@redhat.com, kcarcia@redhat.com, bpf@vger.kernel.org, kuifeng@fb.com, 
	linux@weissschuh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Specifying --btf_features=3Dall enables all supported BTF features.
> However there are some features that are non-standard, so we should
> support a way to use them in --btf_features but not participate in
> the set of features enabled by "--btf_features=3Dall".  As part of this,
> also support all used in a list of --btf_features, i.e.
>
> --btf_features=3Dall,nonstandard_feature
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  man-pages/pahole.1 |  2 +-
>  pahole.c           | 36 +++++++++++++++++++++++-------------
>  2 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 2be165d..2c08e97 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -290,7 +290,7 @@ Allow using all the BTF features supported by pahole.
>
>  .TP
>  .B \-\-btf_features=3DFEATURE_LIST
> -Encode BTF using the specified feature list, or specify 'all' for all fe=
atures supported.  This option can be used as an alternative to unsing mult=
iple BTF-related options. Supported features are
> +Encode BTF using the specified feature list, or specify 'all' for all st=
andard features supported.  This option can be used as an alternative to un=
sing multiple BTF-related options. Supported standard features are
>
>  .nf
>         encode_force       Ignore invalid symbols when encoding BTF; for =
example
> diff --git a/pahole.c b/pahole.c
> index 77772bb..890ef81 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1266,23 +1266,26 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_v=
ersion;
>   * BTF encoding apply; we encode type/decl tags, do not encode
>   * floats, etc.  This ensures backwards compatibility.
>   */
> -#define BTF_FEATURE(name, alias, default_value)                        \
> -       { #name, #alias, &conf_load.alias, default_value }
> +#define BTF_FEATURE(name, alias, default_value, enable_for_all)         =
       \
> +       { #name, #alias, &conf_load.alias, default_value, enable_for_all =
}
>
>  struct btf_feature {
>         const char      *name;
>         const char      *option_alias;
>         bool            *conf_value;
>         bool            default_value;
> +       bool            enable_for_all; /* some nonstandard features may =
not
> +                                        * be enabled for --btf_features=
=3Dall
> +                                        */
>  } btf_features[] =3D {
> -       BTF_FEATURE(encode_force, btf_encode_force, false),
> -       BTF_FEATURE(var, skip_encoding_btf_vars, true),
> -       BTF_FEATURE(float, btf_gen_floats, false),
> -       BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
> -       BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
> -       BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
> -       BTF_FEATURE(optimized_func, btf_gen_optimized, false),
> -       BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto=
, false),
> +       BTF_FEATURE(encode_force, btf_encode_force, false, true),
> +       BTF_FEATURE(var, skip_encoding_btf_vars, true, true),
> +       BTF_FEATURE(float, btf_gen_floats, false, true),
> +       BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true, true),
> +       BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true, true),
> +       BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
> +       BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
> +       BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto=
, false, true),
>  };

maybe keep those special features in a separate array instead?

it is kind of weird to see --btf_features=3Dall,and_then_some, maybe it
makes sense to have --btf_extras or something for those?

>
>  #define BTF_MAX_FEATURE_STR    1024
> @@ -1350,8 +1353,10 @@ static void parse_btf_features(const char *feature=
s, bool strict)
>         if (strcmp(features, "all") =3D=3D 0) {
>                 int i;
>
> -               for (i =3D 0; i < ARRAY_SIZE(btf_features); i++)
> -                       enable_btf_feature(&btf_features[i]);
> +               for (i =3D 0; i < ARRAY_SIZE(btf_features); i++) {
> +                       if (btf_features[i].enable_for_all)
> +                               enable_btf_feature(&btf_features[i]);
> +               }
>                 return;
>         }
>
> @@ -1361,7 +1366,12 @@ static void parse_btf_features(const char *feature=
s, bool strict)
>                 struct btf_feature *feature =3D find_btf_feature(feature_=
name);
>
>                 if (!feature) {
> -                       if (strict) {
> +                       /* --btf_features=3Dall,nonstandard_feature shoul=
d be
> +                        * allowed.
> +                        */
> +                       if (strcmp(feature_name, "all") =3D=3D 0) {
> +                               parse_btf_features(feature_name, strict);
> +                       } else if (strict) {
>                                 fprintf(stderr, "Feature '%s' in '%s' is =
not supported.  Supported BTF features are:\n",
>                                         feature_name, features);
>                                 show_supported_btf_features(stderr);
> --
> 2.39.3
>
>

