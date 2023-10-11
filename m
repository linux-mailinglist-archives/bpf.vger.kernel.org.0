Return-Path: <bpf+bounces-11929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D47C591A
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACDA1C20C26
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600D3D3B9;
	Wed, 11 Oct 2023 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuNRm9KL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB9315BF
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 16:28:35 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E808F
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:28:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9338e4695so91179891fa.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697041711; x=1697646511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KRWmiXe+sOi5SuBOgRgyTOCAK/vWlcAh/8eiBipZzN8=;
        b=MuNRm9KLbgHqIK1sAiemcs9CuVmXA9Dr1Bk26kCU7H/QesSZFkfjgGyZnT66GyFfFw
         odrwdW+Vj4k+4DwhQeEgOzL7gSQGhvMWv0N5i8zuPJRxVOZlu6jsdwOCOzBnOpF9iGoW
         z+JPBeGInz8A6R/+fRnlOArcYIau2Y73M4FK+H0G9p7z1iQz3MQH124IfifUJ0qSGwNk
         6zEX54vSjJ5MBV19hOuyv7nKTyNR8KvYOeCNCkySSarkjkiv4eqS+wEAewWgM7iSzCDm
         4igf2T4BtcRRTXGGX4NYfAyLts3V61EtsDZUD5QmMqh0Wnh3jui2uD4m/01RupTrUlJa
         NuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041711; x=1697646511;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRWmiXe+sOi5SuBOgRgyTOCAK/vWlcAh/8eiBipZzN8=;
        b=II4PLGsO8zRVmjyc00tzS0NsN1RiORqpnYNjTnMruI/FqkmMGT7IJSWDOvWKJsPLZ1
         iOGB4oHhmfMYxBX8pEGz9vYcmFstJAfBEvV2QsJDVFGT1gq9ntITfhWjiLocX0c3eVb3
         lsrhZ1gDzd5dNc+k4heHBD1R0JSPhmwHIHvq+p00AHZz6mkXg4XeX9Qb7ZtZdsKz/0c+
         qSo3d0U4IR+C+eq0yv8839akWGVbz2ZDvM2w/QSyuGvgiWAw9c8bxUL+lmmE7RTrkXBL
         bxIZgZ8xoXwqVZZ5Kd85W7BOU7F+JKdiviWAmdeAkJtdhBZ6DpkMBS2WxxyBivI6taKj
         lW0A==
X-Gm-Message-State: AOJu0YzTqau9djwjSSSDgYX4stEzo/5oH2X7A42t5b1HJk+DXNWulqHz
	43q4TWxlHUNALLCjAdH/aag=
X-Google-Smtp-Source: AGHT+IFoV2/1kKhAop4qlr++x7R+3xBK1CkUY918JrCtMueQmSKuZUsUpTaRjeZ+BZLunv0JlqxK/g==
X-Received: by 2002:a2e:8241:0:b0:2c1:6b9c:48d6 with SMTP id j1-20020a2e8241000000b002c16b9c48d6mr17641926ljh.16.1697041711231;
        Wed, 11 Oct 2023 09:28:31 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n25-20020a2e7219000000b002bce77e4ddfsm3068060ljc.97.2023.10.11.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:28:30 -0700 (PDT)
Message-ID: <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>
Date: Wed, 11 Oct 2023 19:28:29 +0300
In-Reply-To: <20231011091732.93254-4-alan.maguire@oracle.com>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
	 <20231011091732.93254-4-alan.maguire@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 10:17 +0100, Alan Maguire wrote:
> This allows consumers to specify an opt-in set of features
> they want to use in BTF encoding.
>=20
> Supported features are
>=20
> 	encode_force  Ignore invalid symbols when encoding BTF.
> 	var           Encode variables using BTF_KIND_VAR in BTF.
> 	float         Encode floating-point types in BTF.
> 	decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
> 	type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
> 	enum64        Encode enum64 values with BTF_KIND_ENUM64.
> 	optimized     Encode representations of optimized functions
> 	              with suffixes like ".isra.0" etc
> 	consistent    Avoid encoding inconsistent static functions.
> 	              These occur when a parameter is optimized out
> 	              in some CUs and not others, or when the same
> 	              function name has inconsistent BTF descriptions
> 	              in different CUs.
>=20
> Specifying "--btf_features=3Dall" is the equivalent to setting
> all of the above.  If pahole does not know about a feature
> it silently ignores it.  These properties allow us to use
> the --btf_features option in the kernel pahole_flags.sh
> script to specify the desired set of features.  If a new
> feature is not present in pahole but requested, pahole
> BTF encoding will not complain (but will not encode the
> feature).
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  man-pages/pahole.1 | 20 +++++++++++
>  pahole.c           | 87 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 106 insertions(+), 1 deletion(-)
>=20
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index c1b48de..7c072dc 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -273,6 +273,26 @@ Generate BTF for functions with optimization-related=
 suffixes (.isra, .constprop
>  .B \-\-btf_gen_all
>  Allow using all the BTF features supported by pahole.
> =20
> +.TP
> +.B \-\-btf_features=3DFEATURE_LIST
> +Encode BTF using the specified feature list, or specify 'all' for all fe=
atures supported.  This single parameter value can be used as an alternativ=
e to unsing multiple BTF-related options. Supported features are
> +
> +.nf
> +	encode_force  Ignore invalid symbols when encoding BTF.
> +	var           Encode variables using BTF_KIND_VAR in BTF.
> +	float         Encode floating-point types in BTF.
> +	decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
> +	type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
> +	enum64        Encode enum64 values with BTF_KIND_ENUM64.
> +	optimized     Encode representations of optimized functions
> +	              with suffixes like ".isra.0" etc
> +	consistent    Avoid encoding inconsistent static functions.
> +	              These occur when a parameter is optimized out
> +	              in some CUs and not others, or when the same
> +	              function name has inconsistent BTF descriptions
> +	              in different CUs.
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
> +#define ARGP_btf_features	341
> +
> +/* --btf_features=3Dfeature1[,feature2,..] option allows us to specify
> + * opt-in features (or "all"); these are translated into conf_load
> + * values by specifying the associated bool offset and whether it
> + * is a skip option or not; btf_features is for opting _into_ features
> + * so for skip options we have to reverse the logic.  For example
> + * "--skip_encoding_btf_type_tag --btf_gen_floats" translate to
> + * "--btf_features=3Dtype_tag,float"
> + */
> +#define BTF_FEATURE(name, alias, skip)				\
> +	{ #name, #alias, offsetof(struct conf_load, alias), skip }
> +
> +struct btf_feature {
> +	const char      *name;
> +	const char      *option_alias;
> +	size_t          conf_load_offset;
> +	bool		skip;
> +} btf_features[] =3D {
> +	BTF_FEATURE(encode_force, btf_encode_force, false),
> +	BTF_FEATURE(var, skip_encoding_btf_vars, true),
> +	BTF_FEATURE(float, btf_gen_floats, false),
> +	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
> +	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
> +	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
> +	BTF_FEATURE(optimized, btf_gen_optimized, false),
> +	/* the "skip" in skip_encoding_btf_inconsistent_proto is misleading
> +	 * here; this is a positive feature to ensure consistency of
> +	 * representation rather than a negative option which we want
> +	 * to invert.  So as a result, "skip" is false here.
> +	 */
> +	BTF_FEATURE(consistent, skip_encoding_btf_inconsistent_proto, false),
> +};
> +
> +#define BTF_MAX_FEATURES	32
> +#define BTF_MAX_FEATURE_STR	256
> +
> +/* Translate --btf_features=3Dfeature1[,feature2] into conf_load values.
> + * Explicitly ignores unrecognized features to allow future specificatio=
n
> + * of new opt-in features.
> + */
> +static void parse_btf_features(const char *features, struct conf_load *c=
onf_load)
> +{
> +	char *feature_list[BTF_MAX_FEATURES] =3D {};
> +	char f[BTF_MAX_FEATURE_STR];
> +	bool encode_all =3D false;
> +	int i, j, n =3D 0;
> +
> +	strncpy(f, features, sizeof(f));
> +
> +	if (strcmp(features, "all") =3D=3D 0) {
> +		encode_all =3D true;
> +	} else {
> +		char *saveptr =3D NULL, *s =3D f, *t;
> +
> +		while ((t =3D strtok_r(s, ",", &saveptr)) !=3D NULL) {
> +			s =3D NULL;
> +			feature_list[n++] =3D t;

Maybe guard against `n` >=3D BTF_MAX_FEATURES here?

> +		}
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(btf_features); i++) {
> +		bool *bval =3D (bool *)(((void *)conf_load) + btf_features[i].conf_loa=
d_offset);
> +		bool match =3D encode_all;
> +
> +		if (!match) {
> +			for (j =3D 0; j < n; j++) {
> +				if (strcmp(feature_list[j], btf_features[i].name) =3D=3D 0) {
> +					match =3D true;
> +					break;
> +				}
> +			}
> +		}
> +		if (match)
> +			*bval =3D btf_features[i].skip ? false : true;

I'm not sure I understand the logic behind "skip" features.
Take `decl_tag` for example:
- by default conf_load->skip_encoding_btf_decl_tag is 0;
- if `--btf_features=3Ddecl_tag` is passed it is still 0 because of the
  `skip ? false : true` logic.

If there is no way to change "skip" features why listing these at all?

Other than that I tested the patch-set with current kernel master and
a change to pahole-flags.sh and bpf tests pass.

> +	}
> +}
> =20
>  static const struct argp_option pahole__options[] =3D {
>  	{
> @@ -1651,6 +1728,12 @@ static const struct argp_option pahole__options[] =
=3D {
>  		.key =3D ARGP_skip_encoding_btf_inconsistent_proto,
>  		.doc =3D "Skip functions that have multiple inconsistent function prot=
otypes sharing the same name, or that use unexpected registers for paramete=
r values."
>  	},
> +	{
> +		.name =3D "btf_features",
> +		.key =3D ARGP_btf_features,
> +		.arg =3D "FEATURE_LIST",
> +		.doc =3D "Specify supported BTF features in FEATURE_LIST or 'all' for =
all supported features. See the pahole manual page for the list of supporte=
d features."
> +	},
>  	{
>  		.name =3D NULL,
>  	}
> @@ -1796,7 +1879,7 @@ static error_t pahole__options_parser(int key, char=
 *arg,
>  	case ARGP_btf_gen_floats:
>  		conf_load.btf_gen_floats =3D true;	break;
>  	case ARGP_btf_gen_all:
> -		conf_load.btf_gen_floats =3D true;	break;
> +		parse_btf_features("all", &conf_load);	break;
>  	case ARGP_with_flexible_array:
>  		show_with_flexible_array =3D true;	break;
>  	case ARGP_prettify_input_filename:
> @@ -1826,6 +1909,8 @@ static error_t pahole__options_parser(int key, char=
 *arg,
>  		conf_load.btf_gen_optimized =3D true;		break;
>  	case ARGP_skip_encoding_btf_inconsistent_proto:
>  		conf_load.skip_encoding_btf_inconsistent_proto =3D true; break;
> +	case ARGP_btf_features:
> +		parse_btf_features(arg, &conf_load);	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}


