Return-Path: <bpf+bounces-54615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB8A6E20D
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 19:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473091888FC2
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034762641F2;
	Mon, 24 Mar 2025 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RJ4YtZS1"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA89444
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839633; cv=none; b=nd1QaTWTuySGedxA6tDBJOowgxH4YxPIwQ8rwKv+42+ahbBNGiwwujdTCG+1MenCL8zpdnV6Ws0G3V7/4IIM4GS6rLEe8vpKlLzfTJbxd23ogDxKEsLCaOTiYIcPTfzWi2+JbOVUKmVR0r+FfcPiywu+klosVbKeFzXz4JlNtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839633; c=relaxed/simple;
	bh=VlffPSwXz5m+7b65z6AoSxCFwSYmKV0jPhoZf6su9a4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ChqsY7oI/8oQqu9yOGkTZyqAa0ScgxmqVwI2fMaSobpLaDBo2uk65N/cRPP16jyIruAp2WXPHq4RoXRDEbb5nLPlWnv+wl7L79URSmGLdhU/a4CrK0WxKwDH3+abbILfKpeeLQ2OEO2o8cx9I7Tc71KaFS4cdFudPF1s55tjBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RJ4YtZS1; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742839628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzm3QJqQ+50L9OOopCPfOT2n+yvU/8+Tpg0Za+m/sY4=;
	b=RJ4YtZS1YgdFKweUmEdMpuE+owREE64J0xLyyxBw1l+74p/NGxnmHZX8vaA5n2wH9Bb7ck
	a7FUwLm9SONt8uUROaO9UOYjqbzVxY0TeH1OGIWHLL0L+n2fI1Df3hCyj58Y+vHaW8/eNx
	hnEOOzW/ytLBb4jdojDq5xQiI/MJsVs=
Date: Mon, 24 Mar 2025 18:07:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
To: "Alan Maguire" <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
 <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
 <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 3/23/25 4:11 AM, Alan Maguire wrote:
> [...]
>
> hi Ihor, I took a look at the series and merged it with latest next
> branch; results are in
>
> https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=3Dnex=
t.attributes-v4
>
> ...if you want to take a look.
>
> There are a few small things I think that it would be good to resolve
> before landing this.
>
> First, when testing this with -DLIBBPF_EMBEDDED=3DOFF and a packaged
> libbpf 1.5 - which means we wouldn't have the latest attributes-related
> libbpf function; I saw:
>
>   BTF     .tmp_vmlinux1.btf.o
> btf__add_type_attr is not available, is libbpf < 1.6?
> error: failed to encode function 'bbr_cwnd_event': invalid proto
> Failed to encode BTF
>   NM      .tmp_vmlinux1.syms

Hi Alan. Thanks for testing. This is my mistake, I should've checked
for attributes feature here:

@@ -731,6 +812,10 @@ static int32_t btf_encoder__add_func_proto(struct bt=
f_encoder *encoder, struct f
=20
=20	assert(ftype !=3D NULL || state !=3D NULL);
=20
+=09if (is_kfunc_state(state) && encoder->tag_kfuncs)
+		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
+			return -1;

>
> ...and we got no BTF as a result. Ideally we'd like pahole to encode bu=
t
> without the attributes feature if not available. Related, we also repor=
t
> features that are not present, i.e. attributes with
> "--supported_btf_features".  So I propose that we make use of the weak
> declarations being NULL in an optional feature check function. It is
> optionally declared for a feature, and if declared must return true if
> the feature is available.
>
> Something like the below works (it's in the next.attributes-v4 branch
> too for reference) and it resolves the issue of BTF generation failure
> and accurate supported_btf_features reporting. What do you think? Thank=
s!

I think failing fast is a good approach here: check that all
requested/default features are available on startup.

>
> Alan
>
> From: Alan Maguire <alan.maguire@oracle.com>
> Date: Sun, 23 Mar 2025 11:06:18 +0000
> Subject: [PATCH] pahole: add a BTF feature check function
>
> It is used to see if functions that BTF features rely on are
> really there; weak declarations mean they will be NULL if not
> in non-embedded linked libbpf.
>
> This gives us more accurate --supported_btf_features reporting also.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  pahole.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> diff --git a/pahole.c b/pahole.c
> index 4a2b1ce..8304ba4 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1183,10 +1183,31 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D
> dwarves_print_version;
>   * floats, etc.  This ensures backwards compatibility.
>   */
>  #define BTF_DEFAULT_FEATURE(name, alias, initial_value)		\
> -	{ #name, #alias, &conf_load.alias, initial_value, true }
> +	{ #name, #alias, &conf_load.alias, initial_value, true, NULL }
> +
> +#define BTF_DEFAULT_FEATURE_CHECK(name, alias, initial_value,
> feature_check)	\
> +	{ #name, #alias, &conf_load.alias, initial_value, true, feature_check=
 }
>
>  #define BTF_NON_DEFAULT_FEATURE(name, alias, initial_value)	\
> -	{ #name, #alias, &conf_load.alias, initial_value, false }
> +	{ #name, #alias, &conf_load.alias, initial_value, false, NULL }
> +
> +#define BTF_NON_DEFAULT_FEATURE_CHECK(name, alias, initial_value,
> feature_check) \
> +	{ #name, #alias, &conf_load.alias, initial_value, false, feature_chec=
k }
> +
> +static bool enum64_check(void)
> +{
> +	return btf__add_enum64 !=3D NULL;
> +}
> +
> +static bool distilled_base_check(void)
> +{
> +	return btf__distill_base !=3D NULL;
> +}
> +
> +static bool attributes_check(void)
> +{
> +	return btf__add_type_attr !=3D NULL;
> +}
>
>  struct btf_feature {
>  	const char      *name;
> @@ -1196,20 +1217,23 @@ struct btf_feature {
>  	bool		default_enabled;	/* some nonstandard features may not
>  						 * be enabled for --btf_features=3Ddefault
>  						 */
> +	bool		(*feature_check)(void);
>  } btf_features[] =3D {
>  	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
>  	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
>  	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
>  	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>  	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
> -	BTF_DEFAULT_FEATURE(enum64, skip_encoding_btf_enum64, true),
> +	BTF_DEFAULT_FEATURE_CHECK(enum64, skip_encoding_btf_enum64, true,
> enum64_check),
>  	BTF_DEFAULT_FEATURE(optimized_func, btf_gen_optimized, false),
>  	BTF_DEFAULT_FEATURE(consistent_func,
> skip_encoding_btf_inconsistent_proto, false),
>  	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
>  	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false=
),
> -	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false=
),
> +	BTF_NON_DEFAULT_FEATURE_CHECK(distilled_base, btf_gen_distilled_base,
> false,
> +				      distilled_base_check),
>  	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
> -	BTF_NON_DEFAULT_FEATURE(attributes, btf_attributes, false),
> +	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
> +				      attributes_check),
>  };
>
>  #define BTF_MAX_FEATURE_STR	1024
> @@ -1248,7 +1272,8 @@ static void enable_btf_feature(struct btf_feature
> *feature)
>  	/* switch "initial-off" features on, and "initial-on" features
>  	 * off; i.e. negate the initial value.
>  	 */
> -	*feature->conf_value =3D !feature->initial_value;
> +	if (!feature->feature_check || feature->feature_check())
> +		*feature->conf_value =3D !feature->initial_value;
>  }
>
>  static void show_supported_btf_features(FILE *output)
> @@ -1256,6 +1281,8 @@ static void show_supported_btf_features(FILE *out=
put)
>  	int i;
>
>  	for (i =3D 0; i < ARRAY_SIZE(btf_features); i++) {
> +		if (btf_features[i].feature_check && !btf_features[i].feature_check(=
))
> +			continue;
>  		if (i > 0)
>  			fprintf(output, ",");
>  		fprintf(output, "%s", btf_features[i].name);

