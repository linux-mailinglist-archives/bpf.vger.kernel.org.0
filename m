Return-Path: <bpf+bounces-3263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F173B930
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9EB1C2122B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224358F62;
	Fri, 23 Jun 2023 13:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E09441
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:57:59 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF3FE52
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 06:57:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31122c346f4so911428f8f.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687528676; x=1690120676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnX6MkWX6kMUW0OWpSnnnbXh1LEFHo8ykyPryeM/CCA=;
        b=BMealwlPz2t4WMSOuUgRRKQQGVkUfKfkGOn9vqgMLr6KzqqtQEncog2bzeSqIhCl67
         RTh8fDP3tvrKAUotdVTKJksIuHWWZdiLoNIP3kTJJ/P9qzX4bBLn82E+FzmWfxPsmkdb
         Jw+ri8Te9II3ZC2TSYPNRh0Q4Jc6hItflEJsSy4sjyZI+sw6HzUKbWfEUhs/OCT5Ihjv
         cEIDrXTHBprEKENqyDe83eC0K2iplTMegVbCTLuWyxfffoWYFb0BMFO375J7gxy9Mf1c
         jAw5n2ooApbMiAH5RZN1xlnxc47wZotmK4vxL/Nt4qpRCMQsSY8UyOxbidzzyBQA8DqG
         5yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528676; x=1690120676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnX6MkWX6kMUW0OWpSnnnbXh1LEFHo8ykyPryeM/CCA=;
        b=FYT3/UtdA4V3udpUg+8mcRBH5xGLdWq44aTep2F4+/4G3JX9iJ1yyGP8PYaaWBBCxI
         8DZ59XGIoTCccGGWnkBdPoJnDGgx7vNq+HABN3Ke2ZWQvGamO5fEguCinI7fSohSCDlB
         IWXY/GtTpJjVlvKNE/NANdvtmJ5VJFknKpqGAQ7Eh4KapQrYBNNaM3X/hUs3cX4hqtc0
         jtgZWXK7dTZevE/gTsdwrXyDMtThzoDjvZzAli2eD1IR9M1yuJeLavzq/g31Knwl7m2/
         FYaVbZPGDoJkoum1HZOrlcUH966dYQwKSq6brOHOqoZvKVzjEVOg+9kDadjAnhnTuoSW
         FLLQ==
X-Gm-Message-State: AC+VfDx+t1WJHzkKJ+ygL1ifsFHpThTIhiH0ejSrUBPtGuLwhifRZsnE
	8PtkiH7tabuMCx1DsnD43yU=
X-Google-Smtp-Source: ACHHUZ7E3OSLKNdtvuWZCs9NYbCrhkaObo1CbbR1bbakzA/YjzpYqgV8ecIqKOlWq7HqIWRQtmsWNA==
X-Received: by 2002:adf:f88d:0:b0:311:19a2:e7f8 with SMTP id u13-20020adff88d000000b0031119a2e7f8mr22877806wrp.1.1687528675723;
        Fri, 23 Jun 2023 06:57:55 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d5142000000b003113dc327fbsm9639795wrt.22.2023.06.23.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:57:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Jun 2023 15:57:52 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn, rostedt@goodmis.org
Subject: Re: [PATCH] libbpf: kprobe.multi: Filter with
 available_filter_functions_addrs
Message-ID: <ZJWk4MR984KMiXKi@krava>
References: <20230623021245.2887248-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623021245.2887248-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 10:12:45AM +0800, Jackie Liu wrote:

SNIP

> +
> +static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
> +{
> +	free(res->addrs);
> +
> +	/* reset to zero, when fallback */
> +	res->cap = 0;
> +	res->cnt = 0;
> +	res->addrs = NULL;
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  				      const char *pattern,
> @@ -10477,9 +10539,16 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  
>  	if (pattern) {
> -		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
> -		if (err)
> -			goto error;
> +		err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
> +						     &res);
> +		if (err) {
> +			/* fallback to kallsyms */
> +			kprobe_multi_resolve_free(&res);
> +			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
> +						    &res);
> +			if (err)
> +				goto error;
> +		}
>  		if (!res.cnt) {
>  			err = -ENOENT;
>  			goto error;
> @@ -10512,12 +10581,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		goto error;
>  	}
>  	link->fd = link_fd;
> -	free(res.addrs);
> +	kprobe_multi_resolve_free(&res);

we don't need to zero res in here, so we could just leave the original
free(res.addrs) in here and perhaps rename kprobe_multi_resolve_free
to kprobe_multi_resolve_reinit

thanks,
jirka

>  	return link;
>  
>  error:
>  	free(link);
> -	free(res.addrs);
> +	kprobe_multi_resolve_free(&res);
>  	return libbpf_err_ptr(err);
>  }
>  
> -- 
> 2.25.1
> 

