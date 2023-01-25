Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C7167B388
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjAYNjM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 08:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjAYNjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 08:39:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74065552A6
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 05:39:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ss4so47581957ejb.11
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 05:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmpFBokXGbkJYF/ngahseYdeCFL2T96XR84JAFtd5wU=;
        b=oNFJ77t1JqK1TcmmJgOqWYon/v0qQSoP4t8vU/JZ0KEhbNbnxnfD0+knRSx72rnHZm
         ZtcE4vwTVdZCLTgyNZn1Pu7p8BSS0eEWIN8nD7B3H8a/D7LVs1jeAXKjXsZWcVThDRdF
         jukxsaZRc6Bop3g8kIRQdJQHooY/uufAh8e6Z3QnPfpkwX8kd2HOOzcrsbHBp4K/SelA
         LPO111eImKlhXN+KEiuFLrhbkd80rf/I/BMHNSXRvq+/3xDJT7Xsx4YL6BYG0b4gzqQj
         hjH2BBKykJIeEDJ8iEyhW6nU3c9R/9siqVUiPUHNJf8jTNiJFO/TUJHYFvX5nAQBZ8au
         7R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmpFBokXGbkJYF/ngahseYdeCFL2T96XR84JAFtd5wU=;
        b=VnnI1mevIyI+Yn9LtvCWQAFbKKgZnUmIuHmAzADRjEW+z8QAceRirFxgkr/+HUCDy1
         DIFqWQZ519ylemyfskhKf3azztQAc4/GXN83lLdjYN7i8GoG7KhHn+dQcuIS8r6bqw2X
         xpKZYYl4FPJLTVYUOb8l2lciBGWPzgSSBBtXwmhAS60qZioad8yDe4CA8/sRvup8SO+R
         ySaSag2bY7F/S4PdYDRU9SO6pM6yl8xDYXEWmkPtOLc4xLdT4+Mi+xtmpxzhlgMLTX5Z
         UrzLWg7acD1dS/AN666V3Xer6E9zXKDFF6YHLW4lORCElAv5/kcQyZLfGmt0zR3iHIea
         rgLQ==
X-Gm-Message-State: AFqh2krBW90rzjTp3fw4hwPQOTI31FTTCSKgYvHeMXQOzDQo6v0Djl6r
        yok0A/j3kTlTA14t8lmaWu8D6ZM3jMu5FQ==
X-Google-Smtp-Source: AMrXdXtHTzKtiXd3NFWrU3ZNJ1tCbaqgLT+ehlg0Bt7l/4PelhIfNsmH0I0gu+luIpYi6et0cn24NQ==
X-Received: by 2002:a17:906:5417:b0:877:5dbc:da84 with SMTP id q23-20020a170906541700b008775dbcda84mr27109850ejo.72.1674653944811;
        Wed, 25 Jan 2023 05:39:04 -0800 (PST)
Received: from krava ([83.240.62.58])
        by smtp.gmail.com with ESMTPSA id fw19-20020a170907501300b0085a958808c6sm2377591ejc.7.2023.01.25.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 05:39:04 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 14:39:02 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 5/5] btf_encoder: skip BTF encoding of static
 functions with inconsistent prototypes
Message-ID: <Y9Ew9iwd3Jg5vk9c@krava>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-6-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674567931-26458-6-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 01:45:31PM +0000, Alan Maguire wrote:

SNIP

>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
>  {
> @@ -819,13 +837,51 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  	}
>  	/* If we find an existing entry, we want to merge observations
>  	 * across both functions, checking that the "seen optimized-out
> -	 * parameters" status is reflected in our tree entry.
> +	 * parameters"/inconsistent proto status is reflected in tree entry.
>  	 * If the entry is new, record encoder state required
>  	 * to add the local function later (encoder + type_id_off)
> -	 * such that we can add the function later.
> +	 * such that we can add the function later.  Parameter names are
> +	 * also stored in state to speed up multiple static function
> +	 * comparisons.
>  	 */
>  	if (*nodep != fn) {
> -		(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
> +		struct function *ofn = *nodep;
> +
> +		ofn->proto.optimized_parms |= fn->proto.optimized_parms;
> +		/* compare parameters to see if signatures match */
> +
> +		if (ofn->proto.inconsistent_proto)
> +			goto out;
> +
> +		if (ofn->proto.nr_parms != fn->proto.nr_parms) {
> +			ofn->proto.inconsistent_proto = 1;
> +			goto out;
> +		}
> +		if (ofn->proto.nr_parms > 0) {
> +			struct btf_encoder_state *state = ofn->priv;
> +			const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
> +			int i;
> +
> +			if (!state->got_parameter_names) {
> +				parameter_names__get(&ofn->proto, BTF_ENCODER_MAX_PARAMETERS,
> +						     state->parameter_names);
> +				state->got_parameter_names = true;
> +			}
> +			parameter_names__get(&fn->proto, BTF_ENCODER_MAX_PARAMETERS,
> +					     parameter_names);
> +			for (i = 0; i < ofn->proto.nr_parms; i++) {
> +				if (!state->parameter_names[i]) {
> +					if (!parameter_names[i])
> +						continue;
> +				} else if (parameter_names[i]) {
> +					if (strcmp(state->parameter_names[i],
> +						   parameter_names[i]) == 0)
> +						continue;

I guess we can't check type easily? tag has type field,
but I'm not sure if we can get reasonable type info from that

jirka

> +				}
> +				ofn->proto.inconsistent_proto = 1;
> +				goto out;
> +			}
> +		}
>  	} else {
>  		struct btf_encoder_state *state = zalloc(sizeof(*state));
>  
> @@ -898,10 +954,12 @@ static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
>  	/* we can safely free encoder state since we visit each node once */
>  	free(fn->priv);
>  	fn->priv = NULL;
> -	if (fn->proto.optimized_parms) {
> +	if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
>  		if (encoder->verbose)
> -			printf("skipping addition of '%s' due to optimized-out parameters\n",
> -			       function__name(fn));
> +			printf("skipping addition of '%s' due to %s\n",
> +			       function__name(fn),
> +			       fn->proto.optimized_parms ? "optimized-out parameters" :
> +							   "multiple inconsistent function prototypes");
>  	} else {
>  		btf_encoder__add_func(encoder, fn);
>  	}
> @@ -1775,6 +1833,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  		 */
>  		if (fn->declaration)
>  			continue;
> +		if (!fn->external)
> +			save = true;
>  		if (!ftype__has_arg_names(&fn->proto))
>  			continue;
>  		if (encoder->functions.cnt) {
> @@ -1790,7 +1850,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  			if (func) {
>  				if (func->generated)
>  					continue;
> -				func->generated = true;
> +				if (!save)
> +					func->generated = true;
>  			} else if (encoder->functions.suffix_cnt) {
>  				/* falling back to name.isra.0 match if no exact
>  				 * match is found; only bother if we found any
> diff --git a/dwarves.h b/dwarves.h
> index 1ad1b3b..9b80262 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -830,6 +830,7 @@ struct ftype {
>  	uint16_t	 nr_parms;
>  	uint8_t		 unspec_parms:1; /* just one bit is needed */
>  	uint8_t		 optimized_parms:1;
> +	uint8_t		 inconsistent_proto:1;
>  };
>  
>  static inline struct ftype *tag__ftype(const struct tag *tag)
> -- 
> 1.8.3.1
> 
