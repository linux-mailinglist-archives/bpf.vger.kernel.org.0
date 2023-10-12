Return-Path: <bpf+bounces-12077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92907C787D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 23:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9FE282C5E
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C83E475;
	Thu, 12 Oct 2023 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmaHg5f7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0834CE2
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 21:19:12 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B409D
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 14:19:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so2515486a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697145549; x=1697750349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaju1aWLXezr9iluq3jB8IjgHL+gRRa5sbWm2vXSJfI=;
        b=JmaHg5f71weLRYsZX/si/srAtfQF/QQUDki98EBaoMKIlya0ulOpAnSpB/Yj0xS+Re
         vAHlNQBPFvB+zADKvVIV4az2QV5TJVnFYFPr7fo15r17VcJwbgw9v2IbKjjnz0v2nKoL
         coblwgwzniKStF8Bp2AIYTFZJvFslGjkQRb+miWxX36WsZoZ9m/vbNNoLGo/TJ1nPPue
         sC98abimAI/+9wtg3p3vxIMNuMBU1bYP4/QPxaPpSQAmC07IDDJ3TjXUksjqpr14E++R
         56DIe+pO0xJ06EO2wtnqlQYuUMXC0EcBc3gW47w12yqQWQN2+mM2fHGvMnhlLdbjy/xt
         flvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145549; x=1697750349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaju1aWLXezr9iluq3jB8IjgHL+gRRa5sbWm2vXSJfI=;
        b=GtQnOC43ejtLSTfdGjxyDDmaejKmYlP/NZZPNw40cALfYY+yeSKW/pJa171gs2kdz6
         6hznI/6bODzpZRqsTFBnNJejGe5+c+bCn9uxgXX9833dloEe1CqxUo74eTegQ92D56d2
         9AXkH8+eBnIkVC8YxUiS5W2RoyC7iQMwmPlM0NNbr0/dAsh+6ZjJQAZXCHRGRzaFJ/AS
         bPi/Ke3sA7ghFAqCu8wf75eWyh38DfiDiK5RvfXklF7HElrNkgB8PkQIyUzR3SIQ033h
         sEPSlD/nIiMyRSk5kY61TUsYPL/vwE7JfRhC2LQ0K69OUALq7/DNlFRRfOHt5iA0UuZ7
         vh3Q==
X-Gm-Message-State: AOJu0YybpMGOsYaEPNkfDi5cZ8ErjPuz3h7KN1B3mKik5/le4njR+Med
	mtGieR9Moh0Ckkh30V2g0Ck=
X-Google-Smtp-Source: AGHT+IGQoJSCxZAhZ8E6DenYtQBmXFu9f3Wkv2c3nhJ2kfm5p2vE238BL8b3Hv3c3ipA3H9rhFbF1A==
X-Received: by 2002:a17:906:53da:b0:99c:ad52:b00 with SMTP id p26-20020a17090653da00b0099cad520b00mr20435233ejo.6.1697145548374;
        Thu, 12 Oct 2023 14:19:08 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id dx8-20020a170906a84800b0099cbfee34e3sm11448270ejb.196.2023.10.12.14.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:19:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Oct 2023 23:19:05 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org,
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, mykolal@fb.com,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Message-ID: <ZShiydEi4T9whEUk@krava>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com>
 <ZSfsRzfcGuiJPVnb@krava>
 <632ce05e-1c22-62cc-9512-616627d2a6e2@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632ce05e-1c22-62cc-9512-616627d2a6e2@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 02:48:50PM +0100, Alan Maguire wrote:
> On 12/10/2023 13:53, Jiri Olsa wrote:
> > On Wed, Oct 11, 2023 at 10:17:31AM +0100, Alan Maguire wrote:
> > 
> > SNIP
> > 
> >> +#define BTF_FEATURE(name, alias, skip)				\
> >> +	{ #name, #alias, offsetof(struct conf_load, alias), skip }
> >> +
> >> +struct btf_feature {
> >> +	const char      *name;
> >> +	const char      *option_alias;
> >> +	size_t          conf_load_offset;
> >> +	bool		skip;
> >> +} btf_features[] = {
> >> +	BTF_FEATURE(encode_force, btf_encode_force, false),
> >> +	BTF_FEATURE(var, skip_encoding_btf_vars, true),
> >> +	BTF_FEATURE(float, btf_gen_floats, false),
> >> +	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
> >> +	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
> >> +	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
> >> +	BTF_FEATURE(optimized, btf_gen_optimized, false),
> >> +	/* the "skip" in skip_encoding_btf_inconsistent_proto is misleading
> >> +	 * here; this is a positive feature to ensure consistency of
> >> +	 * representation rather than a negative option which we want
> >> +	 * to invert.  So as a result, "skip" is false here.
> >> +	 */
> >> +	BTF_FEATURE(consistent, skip_encoding_btf_inconsistent_proto, false),
> >> +};
> >> +
> >> +#define BTF_MAX_FEATURES	32
> >> +#define BTF_MAX_FEATURE_STR	256
> >> +
> >> +/* Translate --btf_features=feature1[,feature2] into conf_load values.
> >> + * Explicitly ignores unrecognized features to allow future specification
> >> + * of new opt-in features.
> >> + */
> >> +static void parse_btf_features(const char *features, struct conf_load *conf_load)
> >> +{
> >> +	char *feature_list[BTF_MAX_FEATURES] = {};
> >> +	char f[BTF_MAX_FEATURE_STR];
> >> +	bool encode_all = false;
> >> +	int i, j, n = 0;
> >> +
> >> +	strncpy(f, features, sizeof(f));
> >> +
> >> +	if (strcmp(features, "all") == 0) {
> >> +		encode_all = true;
> >> +	} else {
> >> +		char *saveptr = NULL, *s = f, *t;
> >> +
> >> +		while ((t = strtok_r(s, ",", &saveptr)) != NULL) {
> >> +			s = NULL;
> >> +			feature_list[n++] = t;
> >> +		}
> >> +	}
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
> >> +		bool *bval = (bool *)(((void *)conf_load) + btf_features[i].conf_load_offset);
> > 
> > nit, would it be easier to have btf_features defined inside the function
> > and pass specific bool pointers directly to BTF_FEATURE macro?
> >
> 
> thanks for taking a look! I _think_ I see what you mean; if we had
> conf_load we could encode the bool pointer directly using
> the BTF_FEATURE() definition, something like
> 
> #define BTF_FEATURE(name, alias, default_value)                 \
>         { #name, #alias, &conf_load->alias, default_value }
> 
> struct btf_feature {
>         const char      *name;
>         const char      *option_alias;
>         bool		*conf_value;
>         bool            default_value;
> } btf_features[] = {
> ...
> 
> This will work I think because conf_load is a global variable,

yes, it's global, but it's also passed as an argument to parse_btf_features,
so it could be done on top of that conf_load pointer

> and I think we need to keep it global since it's also used by
> patch 4 to get the list of supported features. Is the above
> something like what you had in mind? Thanks!

yes, using the bools directly

thanks,
jirka

