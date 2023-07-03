Return-Path: <bpf+bounces-3916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489657462DF
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4927A1C20A37
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C8107BE;
	Mon,  3 Jul 2023 18:55:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8256259D
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 18:55:05 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65E1716
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 11:54:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3354178a12.1
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688410485; x=1691002485;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHOQkcZ2UOBO0OtB4APwBwE98KrZIvHkHDhzFeQzSgY=;
        b=OsoroTJCVwAS5kozmAzELav8per4p7qU5aEa0K772Sf1c9llZ5pbgzc8B9nlD0dWi/
         H60dt05hMfpZLdXO0zVDytPyJxlZ7CPqgm9nj9wuYnYFoQjCpDJ0pNomOZNi0QtguO8O
         49sS4qWh/K3dJmut1ZQIel1PC6+px21ByEEv7I43Tx/a+YGtZwXFlZjmlJfUZs/J2Uka
         oVFdLQaT1w/y//B3LDr0Yowvk5U7xeBKWUmCFTq9GrZJor7ALCGFlFZtYGCy4ON64ToH
         5/6ldjuwrrAeJPW3LcEUBeGhgU6K8Cxz4s1oLriN6FNOPZjIIpJfU3Z1BuEQFb23TIif
         SODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688410485; x=1691002485;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vHOQkcZ2UOBO0OtB4APwBwE98KrZIvHkHDhzFeQzSgY=;
        b=HeqDumihVtmMoQmyYl6SK8FEqTeHuuaP9oSHKcJ28yojd3uQUH0zvuS8Eu3JZ7TTSu
         GV0wzxnFZlh/BWvZo1uwHpj7METl/LnLApHBFe9ItFNV7UnzIEVjl0mgKTjUKbQc4qlW
         bJ9J/KYxDM+6UrTedWHSI8HkGU/gxIxcVWYAyYTrg2KPH79pFqvKROgP9SvmhOgBlBZN
         uEaDEY2PSAsBaz2KTfzHZEt2k0QkW1y5NyUrNfYl9b0XuLIAGSv8cXTMYz7NKa9xti5U
         al8He32LYP29hxXALbPvB8dbv1gWugm+tbVG7SBFdkwW+csgiTW7cR2/RWj6fbs6+QCN
         Wi8A==
X-Gm-Message-State: AC+VfDxBgvPaA9wvXNaexWU+pzda9M72J1DuBq2Htvf+cNghZLxiMVN5
	MOwdv9Fc/2Ad7i8QguNNDKU=
X-Google-Smtp-Source: ACHHUZ6Rd8Hxpxb7VsTtaNFFmez+brE7UCnIE6xf1pIMpTYoGyYg9hO4OQNBizytIa3kyguj3kSXVA==
X-Received: by 2002:a05:6a20:9719:b0:122:7e90:61c2 with SMTP id hr25-20020a056a20971900b001227e9061c2mr12037604pzc.9.1688410485489;
        Mon, 03 Jul 2023 11:54:45 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id 16-20020a630f50000000b00553c09cc795sm14772701pgp.50.2023.07.03.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:54:44 -0700 (PDT)
Date: Mon, 03 Jul 2023 11:54:43 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jackie Liu <liu.yun@linux.dev>, 
 olsajiri@gmail.com, 
 andrii@kernel.org
Cc: martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 bpf@vger.kernel.org, 
 liuyun01@kylinos.cn
Message-ID: <64a319738401a_6166820852@john.notmuch>
In-Reply-To: <20230701072615.1765388-1-liu.yun@linux.dev>
References: <20230701072615.1765388-1-liu.yun@linux.dev>
Subject: RE: [PATCH 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> When using regular expression matching with "kprobe multi", it scans all
> the functions under "/proc/kallsyms" that can be matched. However, not all
> of them can be traced by kprobe.multi. If any one of the functions fails
> to be traced, it will result in the failure of all functions. The best
> approach is to filter out the functions that cannot be traced to ensure
> proper tracking of the functions.
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 121 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 108 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 214f828ece6b..e26afcd1ff2d 100644
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
> @@ -10539,23 +10545,112 @@ struct kprobe_multi_resolve {
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
> +	char sym_name[256];
> +	const char *available_functions_file = tracefs_available_filter_functions();
> +	FILE *f;
> +	int err = 0, ret, i;
> +	struct function_info {
> +		const char **syms;
> +		size_t cap;
> +		size_t cnt;
> +	} infos = {};
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
> +		ret = fscanf(f, "%s%*[^\n]\n", sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +
> +		if (ret != 1) {
> +			pr_warn("failed to read available function file entry: %d\n",
> +				ret);
> +			err = -EINVAL;
> +			break;

Should this goto cleanup? Setting the 'err' here is a bit awkward at
least because its changed below or you might complete with an err?

> +		}
> +
> +		if (!glob_match(sym_name, res->pattern))
> +			continue;
> +
> +		err = libbpf_ensure_mem((void **)&infos.syms, &infos.cap,
> +					sizeof(void *), infos.cnt + 1);
> +		if (err)

fclose(f) needed?
> +			goto cleanup;
> +
> +		name = strdup(sym_name);
> +		if (!name) {
> +			err = -errno;

same, fclose(f)?

> +			goto cleanup;
> +		}
> +
> +		infos.syms[infos.cnt++] = name;
> +	}
> +	fclose(f);
> +
> +	/* sort available functions */
> +	qsort(infos.syms, infos.cnt, sizeof(void *), qsort_compare_function);

Didn't follow this back entirely, but seems we are doing this in attach
path. Any idea of the overhead we are adding here? Should we have
an init() op to do this qsort if we are going to be calling attach
repeatedly? OTOH most of our progs are memory constrained and
attach operations done infrequently so we release memory aggressively
for cached things so likely wouldn't use it myself. For example we
release the BTF cached object and just repopulate as needed. Just
a thought.

> +
> +	f = fopen("/proc/kallsyms", "r");
> +	if (!f) {
> +		err = -errno;
> +		pr_warn("failed to open /proc/kallsyms\n");
> +		goto cleanup;
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
> +		res->addrs[res->cnt++] = (unsigned long)sym_addr;
> +	}
> +	fclose(f);
> +
> +cleanup:
> +	for (i = 0; i < infos.cnt; i++)
> +		free((char *)infos.syms[i]);
> +	free(infos.syms);
> +
> +	return err;
>  }
>  
>  struct bpf_link *
> @@ -10594,7 +10689,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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
> 

