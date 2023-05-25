Return-Path: <bpf+bounces-1212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DE7107D6
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A561C20E4D
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B00D2F3;
	Thu, 25 May 2023 08:44:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E825D2ED
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 08:44:37 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449801A1
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 01:44:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-970028cfb6cso66143366b.1
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685004272; x=1687596272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlTEoKuCtzfsJTJm4b3QEEnRPwedxuUPpxY8nF+caBM=;
        b=RdlaMEPNdyksR6A/IWurpVDDfZj/ntA6qIuuo2BRYyF8SZ6jBYLKLZ4OPwfZzFEKkV
         4iSxecMD3HVPt4ds9dlDs8ZR+Kpio6KehMR9LtmOzQ394RfmaWTMMF8K6kr78GPkebvX
         Vf0FaD9Fq/08igfmBXWsjmDcIcHSuOlZmPhsGxXIlpITFzoJuUb5KVOVTR5WUZ1rYV9R
         rU+h7pUo5802MfMTrHzDrgK9p/5m2KnYGITOLDxHzjU41f3lLqsgCR94FKK7vyEjYLX/
         bhTsYu65hVcg+JsNouSxTZlxPpFb3awiphEM7QHz5B1u1DgNUCgpsYRwxDpv1FcAnadR
         rq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685004272; x=1687596272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlTEoKuCtzfsJTJm4b3QEEnRPwedxuUPpxY8nF+caBM=;
        b=azH/dx3fxNr17/ETxfZWJ9j81FsRcLNUlmkh+B+/r06A8iFFC8gGJffcIkLQNzUitO
         HjCGN7IpM8S9+B9t0KiET75SkSwxJeJNjoC/IqI5BNYlWHTi4lcTI1LTFWF8L9unBFvE
         7LRAVuHzsUKuFz39+XDz8Xz3jZ0BHG3O2jqUReIoO8UMv5P2aFckvNcpMSXTpTEW1YGd
         mYgwPk7toKNJynosd0s05Vz0EMIHxqCeKOQQDkREr/N1zE8yIJoW1hQYWdUWwiihKWbc
         MOJGDciNDVgE74lkqrfM5SDThTxxL2KwOYjsfONBsiASRM50w3PibmtL9NAl0C3cbU3a
         45Fw==
X-Gm-Message-State: AC+VfDz48ZYWJVd7s7sMCqN6NkLgT1L/CEJULg+4Rllea+vmI4rueVqS
	LXv+MU1iUb1m+Krd4M5QsrelV3UX4r0=
X-Google-Smtp-Source: ACHHUZ7mT9ziizSYYGZlKX+dWsKtOFZrf0Wwu2OqzPxCWJxUP3BmQAM9aDa7UKKco5LqcYCbN64Xjw==
X-Received: by 2002:a17:907:74b:b0:973:a9c3:e055 with SMTP id xc11-20020a170907074b00b00973a9c3e055mr729896ejb.71.1685004272300;
        Thu, 25 May 2023 01:44:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709062a0f00b0096f8c4b1911sm542989eje.130.2023.05.25.01.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:44:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 May 2023 10:44:29 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: Re: [PATCH v3] libbpf: kprobe.multi: Filter with
 available_filter_functions
Message-ID: <ZG8f7ffghG7mLUhR@krava>
References: <ZG2y/zBhk4hnUfSg@krava>
 <20230524084154.89226-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524084154.89226-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 04:41:54PM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> When using regular expression matching with "kprobe multi", it scans all
> the functions under "/proc/kallsyms" that can be matched. However, not all
> of them can be traced by kprobe.multi. If any one of the functions fails
> to be traced, it will result in the failure of all functions. The best
> approach is to filter out the functions that cannot be traced to ensure
> proper tracking of the functions.
> 
> Use available_filter_functions check first, if failed, fallback to
> kallsyms.
> 
> Here is the test eBPF program [1].
> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  v1: 0.27s user 5.09s system 99% cpu 5.392 total
>  v2: 0.37s user 1.54s system 98% cpu 1.947 total
>  v3: 0.10s user 0.98s system 97% cpu 1.107 total
> 
>  I saw that reading available_filter_functions takes 0.98s and kallsyms only
>  takes 0.12s.  There is a big difference in performance between them.
> 
>  tools/lib/bpf/libbpf.c          | 80 ++++++++++++++++++++++++++++++---
>  tools/lib/bpf/libbpf_internal.h |  4 +-
>  2 files changed, 77 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ad1ec893b41b..f3e3c92bdf8a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, const char *pat)
>  struct kprobe_multi_resolve {
>  	const char *pattern;
>  	unsigned long *addrs;
> +	const char **syms;
>  	size_t cap;
>  	size_t cnt;
>  };
>  
>  static int
> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -			const char *sym_name, void *ctx)
> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> +				 const char *sym_name, void *ctx)
>  {
>  	struct kprobe_multi_resolve *res = ctx;
>  	int err;
> @@ -10440,6 +10441,69 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>  	return 0;
>  }
>  
> +static int resolve_kprobe_multi_cb(const char *sym_name, void *ctx)
> +{
> +	struct kprobe_multi_resolve *res = ctx;
> +	int err;
> +
> +	if (!glob_match(sym_name, res->pattern))
> +		return 0;
> +
> +	err = libbpf_ensure_mem((void **) &res->syms, &res->cap, sizeof(const char *),
> +				res->cnt + 1);
> +	if (err)
> +		return err;
> +
> +	res->syms[res->cnt++] = strdup(sym_name);

we need to check the strdup return value

> +	return 0;
> +}
> +
> +int libbpf_available_filter_functions_parse(available_filter_functions_cb_t cb,
> +					    void *ctx)

might be too long, maybe we could just use 'ftrace' instead, so we'd have:

   libbpf_ftrace_parse
   libbpf_kallsyms_parse

that might be too terse, but AFAIK we don't parse any other ftrace file

> +{
> +	char sym_name[256];
> +	FILE *f;
> +	int ret, err = 0;
> +
> +	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> +	if (!f) {
> +		pr_warn("failed to open available_filter_functions, fallback to /proc/kallsyms.\n");
> +		goto fallback;
> +	}
> +
> +	while (true) {
> +		ret = fscanf(f, "%s%*[^\n]\n", sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +		if (ret != 1) {
> +			pr_warn("failed to read available_filter_functions entry: %d\n",
> +				ret);
> +			break;
> +		}
> +
> +		err = cb(sym_name, ctx);
> +		if (err)
> +			break;
> +	}
> +
> +	fclose(f);
> +	return err;
> +
> +fallback:
> +	return libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb, ctx);

let's do the kallsyms fallback in bpf_program__attach_kprobe_multi_opts,
something like:

	err = libbpf_available_filter_functions_parse(resolve_kprobe_multi_cb, &res);
	if (err)
		err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb, &res);
	if (err)
		goto error;


> +}
> +
> +static void kprobe_multi_resolve_resource_free(struct kprobe_multi_resolve *res)

s/kprobe_multi_resolve_resource_free/kprobe_multi_resolve_free/

> +{
> +	if (res->syms) {
> +		while (res->cnt)
> +			free((char *)res->syms[--res->cnt]);
> +		free(res->syms);
> +	} else {
> +		free(res->addrs);
> +	}
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  				      const char *pattern,
> @@ -10476,14 +10540,18 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  
>  	if (pattern) {
> -		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
> +		err = libbpf_available_filter_functions_parse(resolve_kprobe_multi_cb,
> +							      &res);
>  		if (err)
>  			goto error;
>  		if (!res.cnt) {
>  			err = -ENOENT;
>  			goto error;
>  		}
> -		addrs = res.addrs;
> +		if (res.syms)
> +			syms = res.syms;
> +		else
> +			addrs = res.addrs;

this could be just:

		syms = res.syms;
		addrs = res.addrs;

once (cnt > 0) then we have either syms or addrs defined
and the other is NULL

>  		cnt = res.cnt;
>  	}
>  
> @@ -10511,12 +10579,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		goto error;
>  	}
>  	link->fd = link_fd;
> -	free(res.addrs);
> +	kprobe_multi_resolve_resource_free(&res);
>  	return link;
>  
>  error:
>  	free(link);
> -	free(res.addrs);
> +	kprobe_multi_resolve_resource_free(&res);
>  	return libbpf_err_ptr(err);
>  }
>  
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index e4d05662a96c..fdf6b464481f 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -481,8 +481,10 @@ __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
>  
>  typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
>  			     const char *sym_name, void *ctx);
> -
>  int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *arg);
> +typedef int (*available_filter_functions_cb_t)(const char *sym_name, void *ctx);
> +int libbpf_available_filter_functions_parse(available_filter_functions_cb_t cb,
> +					    void *arg);

let's kee it static, we don't have any other callers

thanks,
jirka

