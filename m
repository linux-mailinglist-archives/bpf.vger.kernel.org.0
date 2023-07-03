Return-Path: <bpf+bounces-3919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BA74636A
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E79F280EA2
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6B111B6;
	Mon,  3 Jul 2023 19:38:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C7111A6
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 19:38:18 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB9197
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 12:38:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-553b2979fceso1829135a12.3
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688413096; x=1691005096;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL1WyYK5AVfgbPEJZhdLd7ON6UVF+qByKm6rgAaeO50=;
        b=FmXSXvwtnda4qtIlbNUuSNBapFn9AUmXKMSI/eZPBSmRAU6RV9/ejjZpImeG+TxIrz
         MSY1B5joNpV3XrQ25HheUFdNrv/7GzUVb6WGD0U59U3qkWFsNN+NC5Bbn70H/A41PoSL
         5WbTnsZ6GbgZamSABbDtheNOFCepw9Nw2ocdd5uufHETbyhXvqPDHid4j72H4XxzCCzw
         MVKDN8sjLNKV5vGcFZhxuPNQOCg/2XgbsMGS1vapc4Q6KTuIpFoT80n/MVTCzxpJ4gMS
         02FHykpZaNlCoXUEblBRj4xksT8vK4TBi1J/ZPyT2pgzBAhivy8gkbjZlG+4Zt8hAG5f
         q07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688413096; x=1691005096;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EL1WyYK5AVfgbPEJZhdLd7ON6UVF+qByKm6rgAaeO50=;
        b=a8TzZMAlJj0FJ8WYFVfVWGUfmPEBLvHs1tXJkzbB2SVk53hiAwwvXQ96/fXZe5o8gE
         xLN/sFy0QN78mavoF3ZdneXzcoJDL/tgJ2Xrr2ybOwIDihX8wahYALA986THF2rQY6Rx
         lXN1DMwnN8W3xaUMqCmfao0oqRqKk7lgHWSEphmEgi1F4JsVjkg+9ionvbE7jfergtIh
         JwYhp3+zTDqjaKMEjFPo9mIq7CZbkJnMPvQgH3rQ+rFq9xl7QTZCRJEqTAzg2MCKIjzn
         4M+hCzoclpZ70NHhajooP8GBz8kyGThdfoP05HAsCbwabBgQFbHMpU2VfM+xZ7YHFtc9
         UqcA==
X-Gm-Message-State: AC+VfDwqYxLkGGMpACVqInxhW59csKuw5/3lNe8rhBLOEIsZlrfsFMCI
	mZk7IOm3nVNggfNo1qlZ8Lo=
X-Google-Smtp-Source: ACHHUZ6vQP7wJyJQhNZdOs6YpLKSAv6bHBvfYoxu0yqrSAQTGcdEmSdBvG8gD+ZqCmdon8b3PAq8Vg==
X-Received: by 2002:a05:6a20:488:b0:126:7d25:b0ce with SMTP id 8-20020a056a20048800b001267d25b0cemr9305632pzc.51.1688413095969;
        Mon, 03 Jul 2023 12:38:15 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001b86deba2f9sm6183718plh.284.2023.07.03.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:38:15 -0700 (PDT)
Date: Mon, 03 Jul 2023 12:38:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jackie Liu <liu.yun@linux.dev>, 
 olsajiri@gmail.com, 
 andrii@kernel.org
Cc: martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 bpf@vger.kernel.org, 
 liuyun01@kylinos.cn, 
 lkp@intel.com
Message-ID: <64a323a635491_628d32081e@john.notmuch>
In-Reply-To: <20230703013618.1959621-1-liu.yun@linux.dev>
References: <20230703013618.1959621-1-liu.yun@linux.dev>
Subject: RE: [PATCH v3 1/2] libbpf: kprobe.multi: cross filter using
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

Looks like you fixed up the fclose() issues, sorry about the noise
reading email backwards.


bit of a nit...

Its probably worth handling the case where ret == EOF and its
not feof(f) that man page claims can happen on read error for
example. Might never happen but would be good to distinguish from
-EINVAL below?

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
> +
> +	/* sort available functions */
> +	qsort(infos.syms, infos.cnt, sizeof(void *), qsort_compare_function);
> +
> +	f = fopen("/proc/kallsyms", "r");
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

Same off chance we get ret == EOF and !feof(f)?

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

I'm wondering if we could get a debug print if the func was skipped? Its
not always clear when running many kernels what is going to be skipped
and where.

> +
> +		err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
> +					sizeof(unsigned long), res->cnt + 1);
> +		if (err)
> +			break;
> +
> +		res->addrs[res->cnt++] = (unsigned long) sym_addr;
> +	}
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
> 

