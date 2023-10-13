Return-Path: <bpf+bounces-12109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B077C7ACC
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 02:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BF1B2098D
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 00:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEFE376;
	Fri, 13 Oct 2023 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8SnNKzf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B929360
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 00:22:07 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CAEB7
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:22:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so801311fa.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697156523; x=1697761323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaNRqLJ8Ei19c13QopijjsRQFqnlj/f9WeQlmJ9yb+c=;
        b=K8SnNKzf+Xr14R/4iQn3OKz9gAsQ3XiGGB6qXma5Ty4X12WHIBhhBEI+toRGZljBTh
         uIL4JRd1ho+/qP7z4IQlpmzj0ott5lX9/gzLVldMkEC6lftGbRzWG4zRyPX5cHTjpUXQ
         POsOeevtQKtci7ihExEd53wPINnC/7mxQNKwio2858fBxebdRQl/sKOqkpdU9qXlFdZt
         GsAW0J+1OlVnkmtrk8iNAR+w0xlBQqgOKQObyD3zh8XrtXaRDuqT4Wdfx8Yy4iAK1Fus
         dfyXdgZnleGrwJky4xWP6Vw7IbETAghmyPja8bT3qh2j0JRFRhH99TheEr8DR9A7V3ND
         QDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697156523; x=1697761323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaNRqLJ8Ei19c13QopijjsRQFqnlj/f9WeQlmJ9yb+c=;
        b=gmFngw7Fmq/SKPnVLdoo+OmZk9xtlBTBBLxlMdgD31e20Uzg+hf/0Fk0bW3cyOoprc
         IPn+DUhdcS1sJG2Ao3AXPfTZzesmTSWv1wegZM24tyFx3/wOFsnbW8/frqVJY6uTTxzb
         6Y7brnm/HdjmCdaZL7sFrGvfLzAtkhJPUzBowvyyi/G23pQUVIQIbrDaM/iIBY/hle7G
         oMcqFK3JYSHslcgwT+6GhTlzQdde8zEF7Cs2s+qimPBaWPYxMPIF2KE8ubG131FbHDI/
         f5t5G4rO+kalAIqnZ+pI103bhGi0asx3iTRRzKfuDndBQUkX/JwbYQz8GF457QDTr84c
         l3uA==
X-Gm-Message-State: AOJu0YzCNyJHaJ3ip2z66UdEx9wh5pK+fJSF1P1mfcQqUcBAJo+kz5Rb
	Upcb88uIphN/UdbobHLFRbsUsCOCGpRWJN1VEiQ=
X-Google-Smtp-Source: AGHT+IFeLlguy5HEr1uOYXHq9jF4N0yaajyeAOp+eVlvN/NdBcfITJvtkIEI/O1wBksjePLyWUtBqqh+iZva90nLmKA=
X-Received: by 2002:a19:f70c:0:b0:500:cb2b:8678 with SMTP id
 z12-20020a19f70c000000b00500cb2b8678mr19077190lfe.40.1697156523088; Thu, 12
 Oct 2023 17:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011091732.93254-1-alan.maguire@oracle.com> <20231011091732.93254-4-alan.maguire@oracle.com>
In-Reply-To: <20231011091732.93254-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 17:21:51 -0700
Message-ID: <CAEf4BzZOMOBpwT6wkXeoh9gBQa5jruE=ynsH-1FOB6TRDxFqzQ@mail.gmail.com>
Subject: Re: [RFC dwarves 3/4] pahole: add --btf_features=feature1[,feature2...]
 support
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 2:17=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> This allows consumers to specify an opt-in set of features
> they want to use in BTF encoding.

This is exactly what I had in mind, so thanks a lot for doing this!
Minor nits below, but otherwise a big thumb up from me for the overall
approach.

>
> Supported features are
>
>         encode_force  Ignore invalid symbols when encoding BTF.

ignore_invalid? Even then I don't really know what this means even
after reading the description, but that's ok :)

>         var           Encode variables using BTF_KIND_VAR in BTF.
>         float         Encode floating-point types in BTF.
>         decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
>         type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
>         enum64        Encode enum64 values with BTF_KIND_ENUM64.
>         optimized     Encode representations of optimized functions
>                       with suffixes like ".isra.0" etc
>         consistent    Avoid encoding inconsistent static functions.
>                       These occur when a parameter is optimized out
>                       in some CUs and not others, or when the same
>                       function name has inconsistent BTF descriptions
>                       in different CUs.

both optimized and consistent refer to functions, so shouldn't the
feature name include func somewhere?

>
> Specifying "--btf_features=3Dall" is the equivalent to setting
> all of the above.  If pahole does not know about a feature
> it silently ignores it.  These properties allow us to use
> the --btf_features option in the kernel pahole_flags.sh
> script to specify the desired set of features.  If a new
> feature is not present in pahole but requested, pahole
> BTF encoding will not complain (but will not encode the
> feature).

As I mentioned in the cover letter reply, we might add a "strict mode"
flag, that will error out on unknown features. I don't have much
opinion here, up to Arnaldo and others whether this is useful.

>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  man-pages/pahole.1 | 20 +++++++++++
>  pahole.c           | 87 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 106 insertions(+), 1 deletion(-)
>
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index c1b48de..7c072dc 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -273,6 +273,26 @@ Generate BTF for functions with optimization-related=
 suffixes (.isra, .constprop
>  .B \-\-btf_gen_all
>  Allow using all the BTF features supported by pahole.
>
> +.TP
> +.B \-\-btf_features=3DFEATURE_LIST
> +Encode BTF using the specified feature list, or specify 'all' for all fe=
atures supported.  This single parameter value can be used as an alternativ=
e to unsing multiple BTF-related options. Supported features are
> +
> +.nf
> +       encode_force  Ignore invalid symbols when encoding BTF.
> +       var           Encode variables using BTF_KIND_VAR in BTF.
> +       float         Encode floating-point types in BTF.
> +       decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
> +       type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
> +       enum64        Encode enum64 values with BTF_KIND_ENUM64.
> +       optimized     Encode representations of optimized functions
> +                     with suffixes like ".isra.0" etc
> +       consistent    Avoid encoding inconsistent static functions.
> +                     These occur when a parameter is optimized out
> +                     in some CUs and not others, or when the same
> +                     function name has inconsistent BTF descriptions
> +                     in different CUs.
> +.fi
> +
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
>  Show first biggest size base_type member.
> diff --git a/pahole.c b/pahole.c
> index 7a41dc3..4f00b08 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1229,6 +1229,83 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_ve=
rsion;
>  #define ARGP_skip_emitting_atomic_typedefs 338
>  #define ARGP_btf_gen_optimized  339
>  #define ARGP_skip_encoding_btf_inconsistent_proto 340
> +#define ARGP_btf_features      341
> +
> +/* --btf_features=3Dfeature1[,feature2,..] option allows us to specify
> + * opt-in features (or "all"); these are translated into conf_load
> + * values by specifying the associated bool offset and whether it
> + * is a skip option or not; btf_features is for opting _into_ features
> + * so for skip options we have to reverse the logic.  For example
> + * "--skip_encoding_btf_type_tag --btf_gen_floats" translate to
> + * "--btf_features=3Dtype_tag,float"
> + */
> +#define BTF_FEATURE(name, alias, skip)                         \
> +       { #name, #alias, offsetof(struct conf_load, alias), skip }
> +
> +struct btf_feature {
> +       const char      *name;
> +       const char      *option_alias;
> +       size_t          conf_load_offset;
> +       bool            skip;
> +} btf_features[] =3D {
> +       BTF_FEATURE(encode_force, btf_encode_force, false),
> +       BTF_FEATURE(var, skip_encoding_btf_vars, true),
> +       BTF_FEATURE(float, btf_gen_floats, false),
> +       BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
> +       BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
> +       BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
> +       BTF_FEATURE(optimized, btf_gen_optimized, false),
> +       /* the "skip" in skip_encoding_btf_inconsistent_proto is misleadi=
ng
> +        * here; this is a positive feature to ensure consistency of
> +        * representation rather than a negative option which we want
> +        * to invert.  So as a result, "skip" is false here.
> +        */
> +       BTF_FEATURE(consistent, skip_encoding_btf_inconsistent_proto, fal=
se),
> +};
> +
> +#define BTF_MAX_FEATURES       32
> +#define BTF_MAX_FEATURE_STR    256
> +
> +/* Translate --btf_features=3Dfeature1[,feature2] into conf_load values.
> + * Explicitly ignores unrecognized features to allow future specificatio=
n
> + * of new opt-in features.
> + */
> +static void parse_btf_features(const char *features, struct conf_load *c=
onf_load)
> +{
> +       char *feature_list[BTF_MAX_FEATURES] =3D {};
> +       char f[BTF_MAX_FEATURE_STR];
> +       bool encode_all =3D false;
> +       int i, j, n =3D 0;
> +
> +       strncpy(f, features, sizeof(f));
> +
> +       if (strcmp(features, "all") =3D=3D 0) {
> +               encode_all =3D true;
> +       } else {
> +               char *saveptr =3D NULL, *s =3D f, *t;
> +
> +               while ((t =3D strtok_r(s, ",", &saveptr)) !=3D NULL) {
> +                       s =3D NULL;
> +                       feature_list[n++] =3D t;
> +               }
> +       }

I see that pahole uses argp for argument parsing. argp supports
specifying the same parameter multiple times, so it's very natural to
support

--btf_feature=3Dvar --btf_feature=3Dfloat --btf_feature enum64

without doing any of this parsing. Just find a matching feature and
set corresponding bool value in the callback.

> +
> +       for (i =3D 0; i < ARRAY_SIZE(btf_features); i++) {
> +               bool *bval =3D (bool *)(((void *)conf_load) + btf_feature=
s[i].conf_load_offset);
> +               bool match =3D encode_all;
> +
> +               if (!match) {
> +                       for (j =3D 0; j < n; j++) {
> +                               if (strcmp(feature_list[j], btf_features[=
i].name) =3D=3D 0) {
> +                                       match =3D true;
> +                                       break;
> +                               }
> +                       }
> +               }
> +               if (match)
> +                       *bval =3D btf_features[i].skip ? false : true;
> +       }
> +}
>
>  static const struct argp_option pahole__options[] =3D {
>         {
> @@ -1651,6 +1728,12 @@ static const struct argp_option pahole__options[] =
=3D {
>                 .key =3D ARGP_skip_encoding_btf_inconsistent_proto,
>                 .doc =3D "Skip functions that have multiple inconsistent =
function prototypes sharing the same name, or that use unexpected registers=
 for parameter values."
>         },
> +       {
> +               .name =3D "btf_features",
> +               .key =3D ARGP_btf_features,
> +               .arg =3D "FEATURE_LIST",
> +               .doc =3D "Specify supported BTF features in FEATURE_LIST =
or 'all' for all supported features. See the pahole manual page for the lis=
t of supported features."
> +       },
>         {
>                 .name =3D NULL,
>         }
> @@ -1796,7 +1879,7 @@ static error_t pahole__options_parser(int key, char=
 *arg,
>         case ARGP_btf_gen_floats:
>                 conf_load.btf_gen_floats =3D true;        break;
>         case ARGP_btf_gen_all:
> -               conf_load.btf_gen_floats =3D true;        break;
> +               parse_btf_features("all", &conf_load);  break;
>         case ARGP_with_flexible_array:
>                 show_with_flexible_array =3D true;        break;
>         case ARGP_prettify_input_filename:
> @@ -1826,6 +1909,8 @@ static error_t pahole__options_parser(int key, char=
 *arg,
>                 conf_load.btf_gen_optimized =3D true;             break;
>         case ARGP_skip_encoding_btf_inconsistent_proto:
>                 conf_load.skip_encoding_btf_inconsistent_proto =3D true; =
break;
> +       case ARGP_btf_features:
> +               parse_btf_features(arg, &conf_load);    break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> --
> 2.31.1
>

