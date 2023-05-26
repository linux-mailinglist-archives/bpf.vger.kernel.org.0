Return-Path: <bpf+bounces-1297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A171240D
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7344B1C20FFC
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E98154B7;
	Fri, 26 May 2023 09:53:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D311C84
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:53:14 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452869E
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 02:53:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso3890095e9.0
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685094790; x=1687686790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eG0Rb7YmZYtSBuzJMisfX6ojcV9ZwMXpF3GLzAWkBm8=;
        b=R/l88m99NVM65+oVtrXEMlwY5fWv9jZlbtBWca/XPSB+6MgV2oc+9PCzMw45h5Q9Bj
         W85mhgosKW4RNryPXHRVPVbR5pybhSAo/IHOuCrtMRCOZe4GYuJEE2/ybhmnpT10iKyi
         5bljTIX16beVC+bWq4icSw0YPcFMhCu7mk+XtrCFRH+s5pkC5KEpSt3PwWkoaJliLXqc
         f88LIeWb+vRbDCh3TBUiFoAPC6RjFCT0B1t/AFRLXN7f5gKZ3CsyB77YmG+bG57fpBT8
         dB3CyHBBKgJWwJ2AanQ3fwKShBy0dzmkmznP8A9jSVIo8lR8PE8KqGodbx64H/VZslGq
         DpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685094790; x=1687686790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG0Rb7YmZYtSBuzJMisfX6ojcV9ZwMXpF3GLzAWkBm8=;
        b=iQFGZAYbfywByfvkq8V+88D/K6QFgH3q8kGK+SEl2z8qqNFsTo+mMoXkUtSVqe8BGq
         bT7pLmEaJj0AP1Il5bdVd4eyqX+3VQJM+GCmn63Nh6Z4jIjUKCmY6jlYTIEAbe0D/cUX
         B5dTJglYDojhZrQ+38PzVaFv0fPHbx8Obw4LG/330ERY/p6hO2qWlF1ZWqCvA5lNm1Pb
         wcYn6dEpFhUbBDFHtAB8TQofuC169JFSW0OnZ1qVWqGWxBbTo8wyvzzjFh5gVfEnKSx6
         WatZvqeTb9fb8FdPlFN2ilgZvp73w1p9X44Dr5lqUEOvMWsy+B8esSkhayk5+HrpC46I
         ioZQ==
X-Gm-Message-State: AC+VfDwirB7ZB28UwwmP7RzwzielALrMmpGY3MLVfyr4O4BYd1wS23hv
	vbElvzIUk25kQG7PF5gdsk/vbRFC5q8=
X-Google-Smtp-Source: ACHHUZ6XQFRbpdDYA31ACnsU8S6sn5u68xgunV97TEtv+9gAz6SyxYzdQ22gyDkP7PLX4ajT1OddDQ==
X-Received: by 2002:a05:600c:28f:b0:3f6:c7b:d3b7 with SMTP id 15-20020a05600c028f00b003f60c7bd3b7mr1021907wmk.37.1685094789572;
        Fri, 26 May 2023 02:53:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f605566610sm8321707wmi.13.2023.05.26.02.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 02:53:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 May 2023 11:53:01 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: Re: [PATCH v5] libbpf: kprobe.multi: Filter with
 available_filter_functions
Message-ID: <ZHCBfW6AAxCO53mC@krava>
References: <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <20230526021047.368833-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526021047.368833-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 10:10:47AM +0800, Jackie Liu wrote:

SNIP

> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -			const char *sym_name, void *ctx)
> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> +				 const char *sym_name, void *ctx)
>  {
>  	struct kprobe_multi_resolve *res = ctx;
>  	int err;
> @@ -10431,8 +10438,8 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>  	if (!glob_match(sym_name, res->pattern))
>  		return 0;
>  
> -	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
> -				res->cnt + 1);
> +	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap,
> +				sizeof(unsigned long), res->cnt + 1);

hum, looks like this is just formatting change, AFAICS we don't need that 

>  	if (err)
>  		return err;
>  
> @@ -10440,6 +10447,75 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>  	return 0;
>  }
>  

SNIP

> +
> +static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
> +{
> +	while (res->syms && res->cnt)
> +		free((char *)res->syms[--res->cnt]);
> +
> +	free(res->syms);
> +	free(res->addrs);

we should set cnt and cap to zero for the fallback sake

> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  				      const char *pattern,
> @@ -10476,13 +10552,20 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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

we need to call kprobe_multi_resolve_free in here and set
cnt/cap to zero in kprobe_multi_resolve_free

jirka

> +			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
> +						    &res);
> +			if (err)
> +				goto error;
> +		}
>  		if (!res.cnt) {
>  			err = -ENOENT;
>  			goto error;
>  		}
> +		syms = res.syms;
>  		addrs = res.addrs;
>  		cnt = res.cnt;
>  	}
> @@ -10511,12 +10594,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		goto error;
>  	}
>  	link->fd = link_fd;
> -	free(res.addrs);
> +	kprobe_multi_resolve_free(&res);
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

