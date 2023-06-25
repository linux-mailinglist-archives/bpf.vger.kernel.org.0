Return-Path: <bpf+bounces-3388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761873CDE1
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A971C208B2
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD61633;
	Sun, 25 Jun 2023 01:56:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB587F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:56:12 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154EB10C9
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:56:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so31779705e9.3
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687658169; x=1690250169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P08VCUzqywET5nIEl5Wq1FdUwrv1jkQsFa19gf2erNo=;
        b=XDvJXfh8gXRh3q9fGiEqmA03cjxE+CqxozI6A2JIY3qeGj6YXChSV4paAG3nLxWzn8
         QWzW4EkPbDN3vZcGexe0pqnwe6NfoHxDrFxjAzyjL1BfVbkcDXttTy2SOmfFAfLUF0Vm
         bl9zAw+zaBCqTpv0YGVr0TNIw49ZHDtkujZjt9mEnoKGMbhWbeV6/iGoSGMemQrxHoBV
         KTJXQtEpgujFrCu7ifrx8PJSDRem658QAXJq1ZPwywV20xwNHMbCAOepzzi3Pr5I7gDo
         eHTAmX/G0EcBjHg6sPelRbuVAsjD+WTQ9nLpCIJdvX/y3SFdzyZ4tD1BiSkesWwzYOVf
         Rxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687658169; x=1690250169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P08VCUzqywET5nIEl5Wq1FdUwrv1jkQsFa19gf2erNo=;
        b=kmPFGU2QA2wD1hHwPfRT8Eb5XpP/2vK6iyHZKSMAGU7iiQ3DZImrfBx6tbGw3DzXGN
         5YqER6ctIgpnInBExcDqiCVon0I1UJwtjt63t8+oYNyksBHeynN7hjz/Cdb25tUrteEY
         hPoBrseDU0jSnvBrn9D8qixJFvs/Y85Odi2yNvzxq/P7rqgm3pzcAQOxGyJmR4KVUNhZ
         4dgJLKRLZfUPTwhfyU+CYuWrUBKFxpDlyYsJltBpwsRQ1D9FXwe31d/FdjhPdM9Ie+oq
         YxL+ZSrvmGQx8rzFCMOaOtyPqpTySWnM61kayrQejhSGxA9ibdRNm6qj6/62V61+8zAy
         4YVg==
X-Gm-Message-State: AC+VfDx2C501QpCaAMFB5sqyLKnglgPNEntZ4Ul/9Bb7Gn3QoHxmkidb
	YaSSvX2c2Xz1cdSyx4IkOs8PCVRhKR4=
X-Google-Smtp-Source: ACHHUZ5VQlDQEhbKjdoZbRVp2WHTMEBvkSGLQxJQ2SRqpWEDUWm4K1Q254MH4xdQkVwX/mJ0yWDkgQ==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b244:c294 with SMTP id 6-20020a05600c22c600b003f9b244c294mr20487863wmg.35.1687658169318;
        Sat, 24 Jun 2023 18:56:09 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b003f8126bcf34sm6385755wml.48.2023.06.24.18.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:56:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:56:05 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: Re: [PATCH v2] libbpf: kprobe.multi: Filter with
 available_filter_functions_addrs
Message-ID: <ZJeetQ0h/dULeOvU@krava>
References: <20230625011326.1729020-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625011326.1729020-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 09:13:26AM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> When using regular expression matching with "kprobe multi", it scans all
> the functions under "/proc/kallsyms" that can be matched. However, not all
> of them can be traced by kprobe.multi. If any one of the functions fails
> to be traced, it will result in the failure of all functions. The best
> approach is to filter out the functions that cannot be traced to ensure
> proper tracking of the functions.
> 
> Use available_filter_functions_addrs check first, if failed, fallback to
> kallsyms.
> 
> Here is the test eBPF program [1].
> [1] https://github.com/JackieLiu1/ketones/tree/master/src/funccount
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/lib/bpf/libbpf.c | 81 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a27f6e9ccce7..fca5d2e412c5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10107,6 +10107,12 @@ static const char *tracefs_uprobe_events(void)
>  	return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
>  }
>  
> +static const char *tracefs_available_filter_functions_addrs(void)
> +{
> +	return use_debugfs() ? DEBUGFS"/available_filter_functions_addrs" :
> +			       TRACEFS"/available_filter_functions_addrs";
> +}
> +
>  static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>  					 const char *kfunc_name, size_t offset)
>  {
> @@ -10422,9 +10428,8 @@ struct kprobe_multi_resolve {
>  	size_t cnt;
>  };
>  
> -static int
> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -			const char *sym_name, void *ctx)
> +static int ftrace_resolve_kprobe_multi_cb(unsigned long long sym_addr,
> +					  const char *sym_name, void *ctx)
>  {
>  	struct kprobe_multi_resolve *res = ctx;
>  	int err;
> @@ -10441,6 +10446,63 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>  	return 0;
>  }
>  
> +static int
> +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> +				 const char *sym_name, void *ctx)
> +{
> +	return ftrace_resolve_kprobe_multi_cb(sym_addr, sym_name, ctx);
> +}
> +
> +typedef int (*available_kprobe_cb_t)(unsigned long long sym_addr,
> +				     const char *sym_name, void *ctx);
> +
> +static int
> +libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
> +{
> +	unsigned long long sym_addr;
> +	char sym_name[256];
> +	FILE *f;
> +	int ret, err = 0;
> +	const char *available_path = tracefs_available_filter_functions_addrs();
> +
> +	f = fopen(available_path, "r");
> +	if (!f) {
> +		err = -errno;
> +		pr_warn("failed to open %s, fallback to /proc/kallsyms.\n",
> +			available_path);
> +		return err;
> +	}
> +
> +	while (true) {
> +		ret = fscanf(f, "%llx %255s%*[^\n]\n", &sym_addr, sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +		if (ret != 2) {
> +			pr_warn("failed to read available kprobe entry: %d\n",
> +				ret);
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		err = cb(sym_addr, sym_name, ctx);
> +		if (err)
> +			break;
> +	}
> +
> +	fclose(f);
> +	return err;
> +}
> +
> +static void kprobe_multi_resolve_reinit(struct kprobe_multi_resolve *res)
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
> +			kprobe_multi_resolve_reinit(&res);
> +			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
> +						    &res);
> +			if (err)
> +				goto error;
> +		}
>  		if (!res.cnt) {
>  			err = -ENOENT;
>  			goto error;
> -- 
> 2.25.1
> 

