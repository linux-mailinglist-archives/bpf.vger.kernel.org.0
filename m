Return-Path: <bpf+bounces-3875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50EC745CB4
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E521A280DF5
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A2F50F;
	Mon,  3 Jul 2023 13:00:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E2DDBE
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 13:00:00 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0144DD
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 05:59:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51de841a727so4495168a12.3
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688389197; x=1690981197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5cZnewjmf7DrJMc5X556bVwXHRxytKI1jw53LG2FMW8=;
        b=Nx080V3m4hq+yTaxZ/ERiRZsDTDQqX8UkibK72STYxhuJWLJRHYxIhNs7erKYtVxPz
         /ME2j0x4CzvMUSaA+3fosciuSdEKd/D7c1WNH8YnLMpmaqIwBzcp9v4Bm5yyGtbjS8QY
         La7JIlMd7A6Z+e6mYecdJogTfRQJu8cZ7L/SHjQr8rCERy/8AaloCDG8fxAu/CgDYYuN
         gB+bHYX2UAtGA02HeE+kwjjmcT5U4eCR8HJx4Ya2Z4KNnfAEWm4b035gzX5FPsd4kPVS
         DP93QQDqXVMHXR5XBHkwmj6bdm+OhY0D8fsHdX5+VCHLjJWFfFrb/hfM1n/sHnI5EJHe
         C79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389197; x=1690981197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cZnewjmf7DrJMc5X556bVwXHRxytKI1jw53LG2FMW8=;
        b=URiYSBS7X8hk6kvjovAJYeR/UqfprUy3G2BTF8XYSGr83VxmhlQuLd7TXbRHAqUnJf
         K7Qm8O3OY28YBsJDL15Gab0TWH0HZj9/RO5KdwpNygvoZe3bk2GVzPYfkn5hoDg6bCBp
         sswBUw+EyXMm/hI9/aywB0JsggEC9/Ii6jl4k9Oe1oosLaQruZ7ow6vCDUkkmv9AoIMh
         iat5m9hCKNI6SHuu2/o01yFUtoFuQHjhBNVF8wpSACW5ZCLg2GdKKDoj4gJ4gwsP1NQc
         0Vp3n8822ogt3QJlEDziVZj5Gh87p03yoa8+hOEamdV8V0DT+CFFdLCJEDqkqhrH/H1H
         RqyA==
X-Gm-Message-State: ABy/qLaPuYBLCE1mLv81WS09RQD3cKm+2ry3tjMTdtlBUc3UnwfV12Sn
	zDvBlUCGJmLxy3dT5Ygv+AE=
X-Google-Smtp-Source: APBJJlFG13wRltK0968hUgiYZuZ5bp5BnY0D3osSKcz0xQiXH4+WVZGTRdza2J7Xw/DS5MeUuhtOhg==
X-Received: by 2002:a05:6402:328:b0:51d:b0f1:bed0 with SMTP id q8-20020a056402032800b0051db0f1bed0mr7291651edw.35.1688389196902;
        Mon, 03 Jul 2023 05:59:56 -0700 (PDT)
Received: from krava ([193.46.31.82])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402001100b0051a53d7b160sm10417659edu.80.2023.07.03.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:59:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Jul 2023 14:59:52 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn, lkp@intel.com
Subject: Re: [PATCH v3 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
Message-ID: <ZKLGSFhBNZtOdulu@krava>
References: <20230703013618.1959621-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703013618.1959621-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 09:36:17AM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> When using regular expression matching with "kprobe multi", it scans all
> the functions under "/proc/kallsyms" that can be matched. However, not all
> of them can be traced by kprobe.multi. If any one of the functions fails
> to be traced, it will result in the failure of all functions. The best
> approach is to filter out the functions that cannot be traced to ensure
> proper tracking of the functions.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307030355.TdXOHklM-lkp@intel.com/
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  v2->v3: fix 'fscanf' may overflow
> 
>  tools/lib/bpf/libbpf.c | 122 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 109 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 214f828ece6b..232268215bb7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10224,6 +10224,12 @@ static const char *tracefs_uprobe_events(void)
>  	return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
>  }
>  
> +static const char *tracefs_available_filter_functions(void)
> +{
> +	return use_debugfs() ? DEBUGFS"/available_filter_functions" :
> +			       TRACEFS"/available_filter_functions";
> +}
> +
>  static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>  					 const char *kfunc_name, size_t offset)
>  {
> @@ -10539,23 +10545,113 @@ struct kprobe_multi_resolve {
>  	size_t cnt;
>  };
>  
> -static int
> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -			const char *sym_name, void *ctx)
> +static int qsort_compare_function(const void *a, const void *b)
>  {
> -	struct kprobe_multi_resolve *res = ctx;
> -	int err;
> +	return strcmp(*(const char **)a, *(const char **)b);
> +}
>  
> -	if (!glob_match(sym_name, res->pattern))
> -		return 0;
> +static int bsearch_compare_function(const void *a, const void *b)
> +{
> +	return strcmp((const char *)a, *(const char **)b);
> +}
>  
> -	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
> -				res->cnt + 1);
> -	if (err)
> +static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
> +{
> +	char sym_name[500];
> +	const char *available_functions_file = tracefs_available_filter_functions();
> +	FILE *f;
> +	int err = 0, ret, i;
> +	struct function_info {
> +		const char **syms;
> +		size_t cap;
> +		size_t cnt;
> +	} infos = {};

do you need to define new struct for this? there's just on infos
variable of that, you could use just:

	const char **syms = NULL;
	size_t cap = 0, cnt = 0;

> +
> +	f = fopen(available_functions_file, "r");
> +	if (!f) {
> +		err = -errno;
> +		pr_warn("failed to open %s\n", available_functions_file);
>  		return err;
> +	}
>  
> -	res->addrs[res->cnt++] = (unsigned long) sym_addr;
> -	return 0;
> +	while (true) {
> +		char *name;
> +
> +		ret = fscanf(f, "%499s%*[^\n]\n", sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +
> +		if (ret != 1) {
> +			pr_warn("failed to read available function file entry: %d\n",
> +				ret);
> +			err = -EINVAL;
> +			goto cleanup;
> +		}
> +
> +		if (!glob_match(sym_name, res->pattern))
> +			continue;
> +
> +		err = libbpf_ensure_mem((void **)&infos.syms, &infos.cap,
> +					sizeof(void *), infos.cnt + 1);
> +		if (err)
> +			goto cleanup;
> +
> +		name = strdup(sym_name);
> +		if (!name) {
> +			err = -errno;
> +			goto cleanup;
> +		}
> +
> +		infos.syms[infos.cnt++] = name;
> +	}
> +	fclose(f);

should you check if you found anything (infos.cnt != 0) and return early
if there's nothing found

> +
> +	/* sort available functions */
> +	qsort(infos.syms, infos.cnt, sizeof(void *), qsort_compare_function);
> +
> +	f = fopen("/proc/kallsyms", "r");

why not use libbpf_kallsyms_parse for kallsyms parsing? the call below
would be in its callback

> +	if (!f) {
> +		err = -errno;
> +		pr_warn("failed to open /proc/kallsyms\n");
> +		goto free_infos;
> +	}
> +
> +	while (true) {
> +		unsigned long long sym_addr;
> +
> +		ret = fscanf(f, "%llx %*c %499s%*[^\n]\n", &sym_addr, sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +
> +		if (ret != 2) {
> +			pr_warn("failed to read kallsyms entry: %d\n", ret);
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		if (!glob_match(sym_name, res->pattern))
> +			continue;

hm, we don't need to call glob_match again, we just want to check
if the kallsyms symbol is in infos.syms

> +
> +		if (!bsearch(&sym_name, infos.syms, infos.cnt, sizeof(void *),
> +			     bsearch_compare_function))
> +			continue;
> +
> +		err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
> +					sizeof(unsigned long), res->cnt + 1);
> +		if (err)
> +			break;
> +
> +		res->addrs[res->cnt++] = (unsigned long) sym_addr;
> +	}

res->cnt is check outside for 0, so we should be find here

jirka

> +
> +cleanup:
> +	fclose(f);
> +free_infos:
> +	for (i = 0; i < infos.cnt; i++)
> +		free((char *)infos.syms[i]);
> +	free(infos.syms);
> +
> +	return err;
>  }
>  
>  struct bpf_link *
> @@ -10594,7 +10690,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  
>  	if (pattern) {
> -		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
> +		err = libbpf_available_kallsyms_parse(&res);
>  		if (err)
>  			goto error;
>  		if (!res.cnt) {
> -- 
> 2.25.1
> 

