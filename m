Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3E68EFA9
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 14:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjBHNT1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 08:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHNT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 08:19:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B56185
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 05:19:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bu23so875272wrb.8
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 05:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atBMqAVPdS9Lb+gc8eHarH4WbwL0lkZPuCU73SgBrF8=;
        b=qqeXyEtYxJ8Cya4ElCjWiXfzHmD29ijQrOZRnc4WUKCEwPDjVvlWoDjKx2Yt5RCXKi
         aWPvw45KzrJMD3yaY99rm/A54uHInIXOOta+XUa8N+U5HtNEBQ2k9sg3JlwzyViQmsSu
         fxi+Ib5lFQhWSEG283sJrAlmAK3yaDSAXuCNw0j6RaVTS0oO4FM5OmTGOQhi4VQ/Ayzc
         HnlmMMpi7Zu5O8OMCk6e5mw3F3EG2OhRCfLj/Ocrk9j3tr0mlpsYzIGw8iQ+4m2Nl2K6
         ZvJi162RhyNlLtfELOZog/hyNhPfgehkUDoAkBx/LVcMlppg2vdyP+NpTP3lTxXOszev
         CN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atBMqAVPdS9Lb+gc8eHarH4WbwL0lkZPuCU73SgBrF8=;
        b=2gJ3bxNx6viGTEx+aqdDhepdX5kWsTZ0360XuXAG9xnJhPRg6LC/7mXh+bbUkNXbDI
         ROsNFp75tZUMJiKgxQ58D2qy4hnay1pY78jOyz3Db1Qi0+cAtOmLYBcAGU1AIjhbYSoU
         xX4IQSh9l2JtdnLDzUxf5F9iOc0U6swT2EiYdfHRart+XE0cfW/K5ADJXgmOxUslz/8V
         0D49ZeEe3L4QKGzMcBm3oIY0Z+S2CUlgIoLXrndmZ5s2C7OHrSkc6NpUkE724332Y5ZN
         ylZclGXcS/c1nebefLdq4rxidsMrxoTXoDQDSS9cG2cavcXBdSfpLipmxo+MVawzhKqB
         UVMA==
X-Gm-Message-State: AO0yUKXrSkEcDB9CbXZ0Bb8oKNJtU9074KQ9hO3zSpGVH83QXFAg2Yaf
        /N2Lz7nJcFzhfTaCYM70QUo=
X-Google-Smtp-Source: AK7set/OoRhA7rzRPt7AUEKB1ftE6jXOilPIcx0eWKDRUaSRVvq6lorggVddQmn6x3S7NdnuEGHVVA==
X-Received: by 2002:a5d:6147:0:b0:2c3:e392:67ac with SMTP id y7-20020a5d6147000000b002c3e39267acmr6681153wrt.13.1675862363464;
        Wed, 08 Feb 2023 05:19:23 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d68c4000000b002c3e4f2ffdbsm8748959wrw.58.2023.02.08.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:19:22 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Feb 2023 14:19:20 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 5/8] btf_encoder: Represent "."-suffixed
 functions (".isra.0") in BTF
Message-ID: <Y+OhWAjPI5ngE/Jc@krava>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <1675790102-23037-6-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675790102-23037-6-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 07, 2023 at 05:14:59PM +0000, Alan Maguire wrote:

SNIP

> +
>  /*
>   * This corresponds to the same macro defined in
>   * include/linux/kallsyms.h
> @@ -818,6 +901,11 @@ static int functions_cmp(const void *_a, const void *_b)
>  	const struct elf_function *a = _a;
>  	const struct elf_function *b = _b;
>  
> +	/* if search key allows prefix match, verify target has matching
> +	 * prefix len and prefix matches.
> +	 */
> +	if (a->prefixlen && a->prefixlen == b->prefixlen)
> +		return strncmp(a->name, b->name, b->prefixlen);
>  	return strcmp(a->name, b->name);
>  }
>  
> @@ -850,14 +938,22 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
>  	}
>  
>  	encoder->functions.entries[encoder->functions.cnt].name = name;
> +	if (strchr(name, '.')) {
> +		const char *suffix = strchr(name, '.');
> +
> +		encoder->functions.suffix_cnt++;
> +		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
> +	}
>  	encoder->functions.entries[encoder->functions.cnt].generated = false;
> +	encoder->functions.entries[encoder->functions.cnt].function = NULL;

should we zero functions.state in here? next patch adds other stuff
like got_parameter_names and parameter_names in it, so looks like it
could actually matter

jirka

>  	encoder->functions.cnt++;
>  	return 0;
>  }
>  
> -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
> +static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
> +						       const char *name, size_t prefixlen)
>  {
> -	struct elf_function key = { .name = name };
> +	struct elf_function key = { .name = name, .prefixlen = prefixlen };
>  

SNIP
