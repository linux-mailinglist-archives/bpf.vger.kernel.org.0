Return-Path: <bpf+bounces-12028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A97C6E84
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 14:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E558D1C210A2
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41109266CB;
	Thu, 12 Oct 2023 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHWMx4c1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE922EFA
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 12:53:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6116E91
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 05:53:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso11067225e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115211; x=1697720011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gB+9LISOtc6zHJ5pTxbrdZgc8OFYw7L3yKM+773M10U=;
        b=CHWMx4c14pRi7cVLcHi1DhwgKcwo2MWQFCyhkQu1eLe4PMsLot/HcxHA+j5O213skK
         UVSKh/UKlbHn38ouBSS5y4aW/e/BtaZMfWgfP2osLqzMI51iNsDbyyqeqmiqCC95Jex4
         Es+ffp0PuPYz3O3bycGK7IzQ3Pk+qrHY2BslbhUhe1ddS3Fio0jNApNmWySe9CD5tDIO
         nFzepcfGmVTdd42s/aLUu93DKRWMQgTaMxpp1sCWfIiTmndXQTSzF9nNPI8Fkv8ftVA6
         4a50L3yxVbdwdk7gF0hzP8MW9llnywR8x40fsxliUpmLZNH7I25kWVU48ZQnXxmBvkYV
         mGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115211; x=1697720011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB+9LISOtc6zHJ5pTxbrdZgc8OFYw7L3yKM+773M10U=;
        b=bEzpxvy99ibtoLYgeQQHkvQmLKvUPsYwL9+mJj0NvmCXadiNyXEXejmUXyCegY1AEh
         AnUE6E2XHcVKFND/LMeYH1js9n8wvbOfAEW1Im9Z4R5KvYQBl/r6jhodo/RIRXlYhaI1
         nNxnl1AZjfKUGm5n7EkQjyVBpHImtL0o43V7X0yIxLQ1Ko6Q3VAsX4UFRFJqWgBQHhlR
         L+cKG96gJfdOkO5vpQM1Aa/iR+t0jHlZ38t5MpuB93rQ5BkH0YwQTx7G0ps/2TWOCEXS
         fvr/dYgPgTFyxoz8Phr8pvTnWrQKG3ilghZooKXHk418vM6ijwDVC45yZoZ4Hrmql0Ex
         3Btg==
X-Gm-Message-State: AOJu0YzgV6TxOJQwJqGoDe2DDIFApA8pH3BeYIYUKLfz1OhBG3d3hubD
	BK/+UQfBynm2ekBmRt7IOrk=
X-Google-Smtp-Source: AGHT+IFxXZ8yCjyBy49XEO6jderNhU/N/5pBLBHWR2CRQYkuUKOUBDlTM0BY5v3DNr2uwv9yW50jWQ==
X-Received: by 2002:a7b:c419:0:b0:402:f5c4:2e5a with SMTP id k25-20020a7bc419000000b00402f5c42e5amr21566408wmi.37.1697115210324;
        Thu, 12 Oct 2023 05:53:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c028f00b004065d67c3c9sm19717267wmk.8.2023.10.12.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:53:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Oct 2023 14:53:27 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Message-ID: <ZSfsRzfcGuiJPVnb@krava>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011091732.93254-4-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:17:31AM +0100, Alan Maguire wrote:

SNIP

> +#define BTF_FEATURE(name, alias, skip)				\
> +	{ #name, #alias, offsetof(struct conf_load, alias), skip }
> +
> +struct btf_feature {
> +	const char      *name;
> +	const char      *option_alias;
> +	size_t          conf_load_offset;
> +	bool		skip;
> +} btf_features[] = {
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
> +/* Translate --btf_features=feature1[,feature2] into conf_load values.
> + * Explicitly ignores unrecognized features to allow future specification
> + * of new opt-in features.
> + */
> +static void parse_btf_features(const char *features, struct conf_load *conf_load)
> +{
> +	char *feature_list[BTF_MAX_FEATURES] = {};
> +	char f[BTF_MAX_FEATURE_STR];
> +	bool encode_all = false;
> +	int i, j, n = 0;
> +
> +	strncpy(f, features, sizeof(f));
> +
> +	if (strcmp(features, "all") == 0) {
> +		encode_all = true;
> +	} else {
> +		char *saveptr = NULL, *s = f, *t;
> +
> +		while ((t = strtok_r(s, ",", &saveptr)) != NULL) {
> +			s = NULL;
> +			feature_list[n++] = t;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
> +		bool *bval = (bool *)(((void *)conf_load) + btf_features[i].conf_load_offset);

nit, would it be easier to have btf_features defined inside the function
and pass specific bool pointers directly to BTF_FEATURE macro?

jirka

> +		bool match = encode_all;
> +
> +		if (!match) {
> +			for (j = 0; j < n; j++) {
> +				if (strcmp(feature_list[j], btf_features[i].name) == 0) {
> +					match = true;
> +					break;
> +				}
> +			}
> +		}
> +		if (match)
> +			*bval = btf_features[i].skip ? false : true;
> +	}
> +}
>  
>  static const struct argp_option pahole__options[] = {
>  	{
> @@ -1651,6 +1728,12 @@ static const struct argp_option pahole__options[] = {
>  		.key = ARGP_skip_encoding_btf_inconsistent_proto,
>  		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
>  	},
> +	{
> +		.name = "btf_features",
> +		.key = ARGP_btf_features,
> +		.arg = "FEATURE_LIST",
> +		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
> +	},
>  	{
>  		.name = NULL,
>  	}
> @@ -1796,7 +1879,7 @@ static error_t pahole__options_parser(int key, char *arg,
>  	case ARGP_btf_gen_floats:
>  		conf_load.btf_gen_floats = true;	break;
>  	case ARGP_btf_gen_all:
> -		conf_load.btf_gen_floats = true;	break;
> +		parse_btf_features("all", &conf_load);	break;
>  	case ARGP_with_flexible_array:
>  		show_with_flexible_array = true;	break;
>  	case ARGP_prettify_input_filename:
> @@ -1826,6 +1909,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		conf_load.btf_gen_optimized = true;		break;
>  	case ARGP_skip_encoding_btf_inconsistent_proto:
>  		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
> +	case ARGP_btf_features:
> +		parse_btf_features(arg, &conf_load);	break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> -- 
> 2.31.1
> 

