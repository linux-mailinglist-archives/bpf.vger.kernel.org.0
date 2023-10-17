Return-Path: <bpf+bounces-12418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A27CC3AF
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ADDB21137
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836C41E2F;
	Tue, 17 Oct 2023 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr2VgIpR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DDEBE
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:53:58 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFCDB
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:53:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so9977053a12.2
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697547235; x=1698152035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h1Bas8/4rSjG5DLwSV2D6JGkMGl8xJ+dNySrFoMYV0I=;
        b=fr2VgIpRfJino3tEZghbg9ahV1OyVHmqAQOtqPA60ridRHtKJ3vLBeU0AYiRfDSm9Y
         pH/uCd2shKJRdPbXKrkuvguAhcCEz8vcNzkHxhRKZ+Yhj1uJgLeuhTXuu77iFzLs1gaF
         3awwaq7kw+y1a0QLJeEGPl/9qwtdGvK1NmwJERYWtdqnUDZaM0BtkBbOMF5MV+V/gL4W
         L5jbUzIiE/TG+mVr4iDSYXtGk2uoCsr+7nBH7hBAyYRNxiRSH661G/3d5soBRPwx1+S9
         VXqpp2jfngqSiIHIyxEzapXZYYsHzdneNSfhjkPFaVBl/s/EbNCf5O6cLKJ4ro00n9zn
         wpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547235; x=1698152035;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1Bas8/4rSjG5DLwSV2D6JGkMGl8xJ+dNySrFoMYV0I=;
        b=GuyEXzF2bRC9brzEamLLa96iG9X3MHJg5sRLGDCVLVFhwD6lcKx6CM8ZTjInJo8Ebf
         7l0DtfNBRpEwfSlX+G1SbLwQWfSE4URDGYGJ+dLn053mgTmIxWwY1f1toj+o5M8/fHBA
         e8TLrPf23dbvW080AUPDmfvM1bMDKzgjQkJfXNQUETmq5aspd7FcOQFMsjzcuwCmwAX3
         C+LSBujtdM6/Gdb+lWwPgxEUTvFi0q7KtB6JDNXetxPM+QF9lnVJRb3/BP0xDDvKUBOx
         +MipfzoaXJeaUw0Bc9zez+Qd1LC8xH/8FbM/HT8QktYkA4VIAdlgiRbh31d0Dcpy1ZZb
         lEkw==
X-Gm-Message-State: AOJu0YxkQIhGhLE8CPV7PVWYF/zGn3JMvXuG8q46M+3dhklGtOKorYYg
	8xT/efFaitDtAxFTJjGOvxo=
X-Google-Smtp-Source: AGHT+IF3S/BYWh7/Hg9vveawhXj28NgUJRaQy7x/sAO9F6UOdCQBc0Fs3V+abKHznIXMt+KxqTLtsQ==
X-Received: by 2002:a17:907:60d2:b0:9c3:bd63:4245 with SMTP id hv18-20020a17090760d200b009c3bd634245mr1862804ejc.47.1697547235083;
        Tue, 17 Oct 2023 05:53:55 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906bc4e00b00977cad140a8sm1201271ejv.218.2023.10.17.05.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:53:54 -0700 (PDT)
Message-ID: <dbaa9e9b3e090f5ed88faaa62a40a080eae53ec4.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 5/5] pahole: add --btf_features_strict to
 reject unknown BTF features
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>
Date: Tue, 17 Oct 2023 15:53:52 +0300
In-Reply-To: <20231013153359.88274-6-alan.maguire@oracle.com>
References: <20231013153359.88274-1-alan.maguire@oracle.com>
	 <20231013153359.88274-6-alan.maguire@oracle.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-13 at 16:33 +0100, Alan Maguire wrote:
> --btf_features is used to specify the list of requested features
> for BTF encoding.  However, it is not strict in rejecting requests
> with unknown features; this allows us to use the same parameters
> regardless of pahole version.  --btf_features_strict carries out
> the same encoding with the same feature set, but will fail if an
> unrecognized feature is specified.
>=20
> So
>=20
>   pahole -J --btf_features=3Denum64,foo
>=20
> will succeed, while
>=20
>   pahole -J --btf_features_strict=3Denum64,foo
>=20
> will not.
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  man-pages/pahole.1 |  4 ++++
>  pahole.c           | 20 +++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 6148915..ea9045c 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -297,6 +297,10 @@ Encode BTF using the specified feature list, or spec=
ify 'all' for all features s
> =20
>  So for example, specifying \-\-btf_encode=3Dvar,enum64 will result in a =
BTF encoding that (as well as encoding basic BTF information) will contain =
variables and enum64 values.
> =20
> +.TP
> +.B \-\-btf_features_strict
> +Identical to \-\-btf_features above, but pahole will exit if it encounte=
rs an unrecognized feature.
> +
>  .TP
>  .B \-\-supported_btf_features
>  Show set of BTF features supported by \-\-btf_features option and exit. =
 Useful for checking which features are supported since \-\-btf_features wi=
ll not emit an error if an unrecognized feature is specified.
> diff --git a/pahole.c b/pahole.c
> index 816525a..e2a2440 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1231,6 +1231,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_ver=
sion;
>  #define ARGP_skip_encoding_btf_inconsistent_proto 340
>  #define ARGP_btf_features	341
>  #define ARGP_supported_btf_features 342
> +#define ARGP_btf_features_strict 343
> =20
>  /* --btf_features=3Dfeature1[,feature2,..] allows us to specify
>   * a list of requested BTF features or "all" to enable all features.
> @@ -1288,7 +1289,7 @@ bool set_btf_features_defaults;
>   * Explicitly ignores unrecognized features to allow future specificatio=
n
>   * of new opt-in features.
>   */
> -static void parse_btf_features(const char *features)
> +static void parse_btf_features(const char *features, bool strict)
>  {
>  	char *feature_list[BTF_MAX_FEATURES] =3D {};
>  	char f[BTF_MAX_FEATURE_STR];
> @@ -1325,6 +1326,11 @@ static void parse_btf_features(const char *feature=
s)
>  					break;
>  				}
>  			}
> +			if (strict && !match) {
> +				fprintf(stderr, "Feature in '%s' is not supported.  'pahole --suppor=
ted_btf_features' shows the list of features supported.\n",
> +					features);
> +				exit(EXIT_FAILURE);
> +			}

Hi Alan,

Sorry for late response.

This won't work if --btf_features_strict specifies an incomplete list, e.g.=
:

  $ pahole --btf_features_strict=3Ddecl_tag,enum64 --btf_encode_detached=3D=
/dev/null ~/work/tmp/test.o=20
  Feature in 'decl_tag,enum64' is not supported.  'pahole --supported_btf_f=
eatures' shows the list of features supported.

Also, I think it would be good to print exactly which feature is not suppor=
ted.
What do you think about modification as in the end of this email?
(applied on top of your series).

Thanks,
Eduard

---

diff --git a/pahole.c b/pahole.c
index e2a2440..cf87f83 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1285,6 +1285,29 @@ struct btf_feature {
=20
 bool set_btf_features_defaults;
=20
+static struct btf_feature *find_feature(char *name)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(btf_features); i++)
+		if (strcmp(name, btf_features[i].name) =3D=3D 0)
+			return &btf_features[i];
+	return NULL;
+}
+
+static void init_feature(struct btf_feature *feature)
+{
+	*feature->conf_value =3D feature->default_value;
+}
+
+static void enable_feature(struct btf_feature *feature)
+{
+	/* switch "default-off" features on, and "default-on" features
+	 * off; i.e. negate the default value.
+	 */
+	*feature->conf_value =3D !feature->default_value;
+}
+
 /* Translate --btf_features=3Dfeature1[,feature2] into conf_load values.
  * Explicitly ignores unrecognized features to allow future specification
  * of new opt-in features.
@@ -1294,7 +1317,7 @@ static void parse_btf_features(const char *features, =
bool strict)
 	char *feature_list[BTF_MAX_FEATURES] =3D {};
 	char f[BTF_MAX_FEATURE_STR];
 	bool encode_all =3D false;
-	int i, j, n =3D 0;
+	int i, n =3D 0;
=20
 	strncpy(f, features, sizeof(f));
=20
@@ -1309,36 +1332,36 @@ static void parse_btf_features(const char *features=
, bool strict)
 		}
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(btf_features); i++) {
-		bool match =3D encode_all;
+	/* Only set default values once, as multiple --btf_features=3D
+	 * may be specified on command-line, and setting defaults
+	 * again could clobber values.   The aim is to enable
+	 * all features set across all --btf_features options.
+	 */
+	if (!set_btf_features_defaults) {
+		for (i =3D 0; i < ARRAY_SIZE(btf_features); i++)
+			init_feature(&btf_features[i]);
+		set_btf_features_defaults =3D true;
+	}
=20
-		/* Only set default values once, as multiple --btf_features=3D
-		 * may be specified on command-line, and setting defaults
-		 * again could clobber values.   The aim is to enable
-		 * all features set across all --btf_features options.
-		 */
-		if (!set_btf_features_defaults)
-			*(btf_features[i].conf_value) =3D btf_features[i].default_value;
-		if (!match) {
-			for (j =3D 0; j < n; j++) {
-				if (strcmp(feature_list[j], btf_features[i].name) =3D=3D 0) {
-					match =3D true;
-					break;
-				}
-			}
-			if (strict && !match) {
-				fprintf(stderr, "Feature in '%s' is not supported.  'pahole --supporte=
d_btf_features' shows the list of features supported.\n",
-					features);
+	if (encode_all) {
+		for (i =3D 0; i < ARRAY_SIZE(btf_features); i++)
+			enable_feature(&btf_features[i]);
+	} else {
+		for (i =3D 0; i < n; i++) {
+			struct btf_feature *feature =3D find_feature(feature_list[i]);
+
+			if (!feature && strict) {
+				fprintf(stderr, "Feature '%s' is not supported.  'pahole --supported_b=
tf_features' shows the list of features supported.\n",
+					feature_list[i]);
 				exit(EXIT_FAILURE);
 			}
+			if (!feature && global_verbose)
+				fprintf(stdout, "Ignoring unsupported feature '%s'\n",
+					feature_list[i]);
+			if (feature)
+				enable_feature(feature);
 		}
-		/* switch "default-off" features on, and "default-on" features
-		 * off; i.e. negate the default value.
-		 */
-		if (match)
-			*(btf_features[i].conf_value) =3D !btf_features[i].default_value;
 	}
-	set_btf_features_defaults =3D true;
 }
=20
 static void show_supported_btf_features(void)

