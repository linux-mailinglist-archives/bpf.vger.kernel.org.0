Return-Path: <bpf+bounces-12690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E586A7CF628
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 13:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1484C1C20E52
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122ED18C0E;
	Thu, 19 Oct 2023 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAzR5xHB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F29179B7
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:07:27 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C1DFA
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:07:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so1229437366b.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697713643; x=1698318443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cEY1r7ZmRljSI55sL554K8/qvIqPSOoQdNdG0QUzzEU=;
        b=HAzR5xHB1lzXpN/5MeYjqVtqCHmQ3Vh5g/7/bm1m2CIlPIJ34wunS/NUh3+lbQVc6d
         EnQDvWfpeXKAz7yOR9SDlJWTcrDI6cYymYGTmjIWNE39zoYPbNFsGxknoSq9ErGlGQ2a
         YXdXenMurwO9UO7uLKPm3PConmbeFSgGPXIRwlKCt9HIvmUCQOIIU2tood/pFzmV2dSA
         ZiOKAKZaFCLDQG1U0qDSFhsalwWidKXULzjbA12pCtoJf9YsZbPDCOYteanWz3L/0q7Q
         BfVaJRBgEf03/M7/ZWzJLx/ihqOEyroO3na4MuYqbtvSxgDaWzwAEQpjXtEh3syFXhrl
         OEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697713643; x=1698318443;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEY1r7ZmRljSI55sL554K8/qvIqPSOoQdNdG0QUzzEU=;
        b=S56e0TXvDRcozwqjiLFmooyiddla8A8SFgao6cNV3vnhCtj1/1ufs0kCk9amdoHf7W
         sjc2BYCA4qXn7QhdISzHvIOyknI5jeRfwj96lqqG17au3T6CWb1suKB1+UWqDiCB+Hq7
         e/oT8uVo0ClufXUhL4jcMLYc1B0dE/O7J5N8v4J6JDj1y9ZReGVYQmQvvVXmfuTCgExk
         EhrSPW/S+3js4aPkdSOl6NYewsrbuE2VHP6s18p0nme4XUwRKBi05LQqAiYEZWPn/Vnd
         eNXjRbeyLtNX9pKxhqm9/8iSForhxvQJQCsIMVAMN7VEw30zyEFwQX4/c6sv0lray9W/
         V/3w==
X-Gm-Message-State: AOJu0YwjPy9dOc8BzA52JM86pGAX5yrqDlY/y2buRqEbrLDOaXEnJOpi
	uyaNcgZGrLiwYrincml9WEL0FSxS/8iPzkTy
X-Google-Smtp-Source: AGHT+IFb7r/873ZmgheTkR9UYkb2dGm4JFVpdsjo363NbzNdvCdEv0Xv/XdcSulgpV4wtRoW7DOwrg==
X-Received: by 2002:a17:907:3f09:b0:9a2:1e03:1572 with SMTP id hq9-20020a1709073f0900b009a21e031572mr1744825ejc.19.1697713642848;
        Thu, 19 Oct 2023 04:07:22 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i20-20020a1709061cd400b009a1fef32ce6sm3375595ejh.177.2023.10.19.04.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:07:22 -0700 (PDT)
Message-ID: <a6d4adeef784737341c959d5a967b9c746d5a297.camel@gmail.com>
Subject: Re: [PATCH v3 dwarves 3/5] pahole: add --btf_features support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>
Date: Thu, 19 Oct 2023 14:07:20 +0300
In-Reply-To: <20231018122926.735416-4-alan.maguire@oracle.com>
References: <20231018122926.735416-1-alan.maguire@oracle.com>
	 <20231018122926.735416-4-alan.maguire@oracle.com>
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

On Wed, 2023-10-18 at 13:29 +0100, Alan Maguire wrote:
> This allows consumers to specify an opt-in set of features
> they want to use in BTF encoding.
>=20
> Supported features are a comma-separated combination of
>=20
> 	encode_force    Ignore invalid symbols when encoding BTF.
> 	var             Encode variables using BTF_KIND_VAR in BTF.
> 	float           Encode floating-point types in BTF.
> 	decl_tag        Encode declaration tags using BTF_KIND_DECL_TAG.
> 	type_tag        Encode type tags using BTF_KIND_TYPE_TAG.
> 	enum64          Encode enum64 values with BTF_KIND_ENUM64.
> 	optimized_func  Encode representations of optimized functions
> 	                with suffixes like ".isra.0" etc
> 	consistent_func Avoid encoding inconsistent static functions.
> 	                These occur when a parameter is optimized out
> 	                in some CUs and not others, or when the same
> 	                function name has inconsistent BTF descriptions
> 	                in different CUs.
>=20
> Specifying "--btf_features=3Dall" is the equivalent to setting
> all of the above.  If pahole does not know about a feature
> specified in --btf_features it silently ignores it.
>=20
> The --btf_features can either be specified via a single comma-separated
> list
> 	--btf_features=3Denum64,float
>=20
> ...or via multiple --btf_features values
>=20
> 	--btf_features=3Denum64 --btf_features=3Dfloat
>=20
> These properties allow us to use the --btf_features option in
> the kernel scripts/pahole_flags.sh script to specify the desired
> set of BTF features.
>=20
> If a feature named in --btf_features is not present in the version
> of pahole used, BTF encoding will not complain.  This is desired
> because it means we no longer have to tie new features to a specific
> pahole version.
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  man-pages/pahole.1 |  24 ++++++++
>  pahole.c           | 137 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 160 insertions(+), 1 deletion(-)
>=20
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index c1b48de..a09885f 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -273,6 +273,30 @@ Generate BTF for functions with optimization-related=
 suffixes (.isra, .constprop
>  .B \-\-btf_gen_all
>  Allow using all the BTF features supported by pahole.
> =20
> +.TP
> +.B \-\-btf_features=3DFEATURE_LIST
> +Encode BTF using the specified feature list, or specify 'all' for all fe=
atures supported.  This option can be used as an alternative to unsing mult=
iple BTF-related options. Supported features are
> +
> +.nf
> +	encode_force       Ignore invalid symbols when encoding BTF; for exampl=
e
> +	                   if a symbol has an invalid name, it will be ignored
> +	                   and BTF encoding will continue.
> +	var                Encode variables using BTF_KIND_VAR in BTF.
> +	float              Encode floating-point types in BTF.
> +	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
> +	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
> +	enum64             Encode enum64 values with BTF_KIND_ENUM64.
> +	optimized_func     Encode representations of optimized functions
> +	                   with suffixes like ".isra.0".
> +	consistent_func    Avoid encoding inconsistent static functions.
> +	                   These occur when a parameter is optimized out
> +	                   in some CUs and not others, or when the same
> +	                   function name has inconsistent BTF descriptions
> +	                   in different CUs.
> +.fi
> +
> +So for example, specifying \-\-btf_encode=3Dvar,enum64 will result in a =
BTF encoding that (as well as encoding basic BTF information) will contain =
variables and enum64 values.
> +
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
>  Show first biggest size base_type member.
> diff --git a/pahole.c b/pahole.c
> index 7a41dc3..0e889cf 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1229,6 +1229,133 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_v=
ersion;
>  #define ARGP_skip_emitting_atomic_typedefs 338
>  #define ARGP_btf_gen_optimized  339
>  #define ARGP_skip_encoding_btf_inconsistent_proto 340
> +#define ARGP_btf_features	341
> +
> +/* --btf_features=3Dfeature1[,feature2,..] allows us to specify
> + * a list of requested BTF features or "all" to enable all features.
> + * These are translated into the appropriate conf_load values via a
> + * struct btf_feature which specifies the associated conf_load
> + * boolean field and whether its default (representing the feature being
> + * off) is false or true.
> + *
> + * btf_features is for opting _into_ features so for a case like
> + * conf_load->btf_gen_floats, the translation is simple; the presence
> + * of the "float" feature in --btf_features sets conf_load->btf_gen_floa=
ts
> + * to true.
> + *
> + * The more confusing case is for features that are enabled unless
> + * skipping them is specified; for example
> + * conf_load->skip_encoding_btf_type_tag.  By default - to support
> + * the opt-in model of only enabling features the user asks for -
> + * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
> + * type_tags) and it is only set to false if --btf_features contains
> + * the "type_tag" keyword.
> + *
> + * So from the user perspective, all features specified via
> + * --btf_features are enabled, and if a feature is not specified,
> + * it is disabled.
> + *
> + * If --btf_features is not used, the usual pahole defaults for
> + * BTF encoding apply; we encode type/decl tags, do not encode
> + * floats, etc.  This ensures backwards compatibility.
> + */
> +#define BTF_FEATURE(name, alias, default_value)			\
> +	{ #name, #alias, &conf_load.alias, default_value }
> +
> +struct btf_feature {
> +	const char      *name;
> +	const char      *option_alias;
> +	bool		*conf_value;
> +	bool		default_value;
> +} btf_features[] =3D {
> +	BTF_FEATURE(encode_force, btf_encode_force, false),
> +	BTF_FEATURE(var, skip_encoding_btf_vars, true),
> +	BTF_FEATURE(float, btf_gen_floats, false),
> +	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
> +	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
> +	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
> +	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
> +	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, fals=
e),
> +};
> +
> +#define BTF_MAX_FEATURES	32
> +#define BTF_MAX_FEATURE_STR	1024
> +
> +bool set_btf_features_defaults;
> +
> +static void init_btf_features(void)
> +{
> +	int i;
> +
> +	/* Only set default values once, as multiple --btf_features=3D
> +	 * may be specified on command-line, and setting defaults
> +	 * again could clobber values.   The aim is to enable
> +	 * all features set across all --btf_features options.
> +	 */
> +	if (set_btf_features_defaults)
> +		return;
> +	for (i =3D 0; i < ARRAY_SIZE(btf_features); i++)
> +		*btf_features[i].conf_value =3D btf_features[i].default_value;
> +	set_btf_features_defaults =3D true;
> +}
> +
> +static struct btf_feature *find_btf_feature(char *name)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(btf_features); i++) {
> +		if (strcmp(name, btf_features[i].name) =3D=3D 0)
> +			return &btf_features[i];
> +	}
> +	return NULL;
> +}
> +
> +static void enable_btf_feature(struct btf_feature *feature)
> +{
> +	/* switch "default-off" features on, and "default-on" features
> +	 * off; i.e. negate the default value.
> +	 */
> +	*feature->conf_value =3D !feature->default_value;
> +}
> +
> +/* Translate --btf_features=3Dfeature1[,feature2] into conf_load values.
> + * Explicitly ignores unrecognized features to allow future specificatio=
n
> + * of new opt-in features.
> + */
> +static void parse_btf_features(const char *features)
> +{
> +	char *feature_list[BTF_MAX_FEATURES] =3D {};
> +	char *saveptr =3D NULL, *s, *t;
> +	char f[BTF_MAX_FEATURE_STR];
> +	int i, n =3D 0;
> +
> +	init_btf_features();
> +
> +	if (strcmp(features, "all") =3D=3D 0) {
> +		for (i =3D 0; i < ARRAY_SIZE(btf_features); i++)
> +			enable_btf_feature(&btf_features[i]);
> +		return;
> +	}
> +
> +	strncpy(f, features, sizeof(f));
> +	s =3D f;
> +	while ((t =3D strtok_r(s, ",", &saveptr)) !=3D NULL && n < BTF_MAX_FEAT=
URES) {
> +		s =3D NULL;
> +		feature_list[n++] =3D t;
> +	}
> +

Sorry, I should have realized it when I sent suggestion for v2.
It should be possible to merge the "while" and "for" loops and avoid
hypothetical edge case when old version of pahole is fed with 33 items
long feature list. As in the diff attached to the end of the email.
Feel free to ignore this if you think code is fine as it is.

> +	for (i =3D 0; i < n; i++) {
> +		struct btf_feature *feature =3D find_btf_feature(feature_list[i]);
> +
> +		if (!feature) {
> +			if (global_verbose)
> +				fprintf(stderr, "Ignoring unsupported feature '%s'\n",
> +					feature_list[i]);
> +		} else {
> +			enable_btf_feature(feature);
> +		}
> +	}
> +}
> =20
>  static const struct argp_option pahole__options[] =3D {
>  	{
> @@ -1651,6 +1778,12 @@ static const struct argp_option pahole__options[] =
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
> @@ -1796,7 +1929,7 @@ static error_t pahole__options_parser(int key, char=
 *arg,
>  	case ARGP_btf_gen_floats:
>  		conf_load.btf_gen_floats =3D true;	break;
>  	case ARGP_btf_gen_all:
> -		conf_load.btf_gen_floats =3D true;	break;
> +		parse_btf_features("all");		break;
>  	case ARGP_with_flexible_array:
>  		show_with_flexible_array =3D true;	break;
>  	case ARGP_prettify_input_filename:
> @@ -1826,6 +1959,8 @@ static error_t pahole__options_parser(int key, char=
 *arg,
>  		conf_load.btf_gen_optimized =3D true;		break;
>  	case ARGP_skip_encoding_btf_inconsistent_proto:
>  		conf_load.skip_encoding_btf_inconsistent_proto =3D true; break;
> +	case ARGP_btf_features:
> +		parse_btf_features(arg);		break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}

---

diff --git a/pahole.c b/pahole.c
index e308dd1..b9bf395 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1280,7 +1280,6 @@ struct btf_feature {
 	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false)=
,
 };
=20
-#define BTF_MAX_FEATURES	32
 #define BTF_MAX_FEATURE_STR	1024
=20
 bool set_btf_features_defaults;
@@ -1338,10 +1337,10 @@ static void show_supported_btf_features(FILE *outpu=
t)
  */
 static void parse_btf_features(const char *features, bool strict)
 {
-	char *feature_list[BTF_MAX_FEATURES] =3D {};
-	char *saveptr =3D NULL, *s, *t;
+	char *saveptr =3D NULL, *s, *requested;
 	char f[BTF_MAX_FEATURE_STR];
-	int i, n =3D 0;
+	struct btf_feature *feature;
+	int i;
=20
 	init_btf_features();
=20
@@ -1353,24 +1352,19 @@ static void parse_btf_features(const char *features=
, bool strict)
=20
 	strncpy(f, features, sizeof(f));
 	s =3D f;
-	while ((t =3D strtok_r(s, ",", &saveptr)) !=3D NULL && n < BTF_MAX_FEATUR=
ES) {
+	while ((requested =3D strtok_r(s, ",", &saveptr)) !=3D NULL) {
 		s =3D NULL;
-		feature_list[n++] =3D t;
-	}
-
-	for (i =3D 0; i < n; i++) {
-		struct btf_feature *feature =3D find_btf_feature(feature_list[i]);
-
+		feature =3D find_btf_feature(requested);
 		if (!feature) {
 			if (strict) {
 				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF=
 features are:\n",
-					feature_list[i], features);
+					requested, features);
 				show_supported_btf_features(stderr);
 				exit(EXIT_FAILURE);
 			}
 			if (global_verbose)
 				fprintf(stderr, "Ignoring unsupported feature '%s'\n",
-					feature_list[i]);
+					requested);
 		} else {
 			enable_btf_feature(feature);
 		}



