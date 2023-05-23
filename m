Return-Path: <bpf+bounces-1101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A2170E18B
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFDC1C20DA1
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84520688;
	Tue, 23 May 2023 16:17:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74421200CE
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 16:17:39 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD4DD
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:17:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-953343581a4so1142186266b.3
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684858655; x=1687450655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVHOtWwD/OP+jOElkmhiFGdYlDuzil3L61CP7jY2Nzc=;
        b=PHROlPlAFVl/u2wthUDHVsiwLvIgpt1nluJOqTDvZ2BVJAcN7ke0euAVjT9rp8qJXw
         k9XexnYVZp79MY9J2qxg6pCBhMhUUdnviN9qj0ytM/Jjdwy2NS2rX+7TLMCfCGdrM/MJ
         T1qlcc5epSkPAMSDdCpCub+71TBEdDaGcoSZ9VpItWHyS5mSsONzzGeA5rolywVeraU4
         eNu1J0krKZYYyxYsHLn5TQhGu1vhXyr3yO+ECXmgMM9cJlTnxU0Xf/jzlnY5cxsYZTtT
         zDrx617pSKVMsjnwoHoxBo+iSEaGAsU9DsHDXEJGyVRxNwAARqboiaJVeMvhXQPNZ9e1
         t62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684858655; x=1687450655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVHOtWwD/OP+jOElkmhiFGdYlDuzil3L61CP7jY2Nzc=;
        b=lLF+olBrsaCqLVWQG2BhgmtSJ08jG4Lkia19E+ifSmlSFdqnQUkXdLc1Z0tV8hwYh8
         PlkCH51NBAI/0mTgwKEPbKiYA5AwzM6DY0TSCYHboLYvV0lyh/ghdOPIFvXGHXj61uLH
         NZBdCUAVk9n6WyvpZkc/yDZMKd00yZPM4ZnTb5f+nQg/bKAKdDdlsOCN3GGW+LEc/qhR
         431BXayhexMtaDtyshUjLvFnGgxI0OgkycRfnNJjYvgBkQZFpxxCC7F/ldwzV7Dfbivf
         qRIOoMyx9d0QeUo/RcxJL5yyeZp8/IXPM0CXFaUKmBx5F8RV6s4RGrwWkOCWH/5p15nW
         P7OQ==
X-Gm-Message-State: AC+VfDwUbjyAh6+K/TJLdAULyW+r3dq9/m1EVy71gW6rCAwuWLNRrpFZ
	X5KMZwBv37H55lJpZGBfuHfK/osoLO8=
X-Google-Smtp-Source: ACHHUZ4OQQBGhQHNQ1tYlYksxeV1PPYug0ztOXG5kyCDC2OrB4sM8xDdgIl2hoF6KMxE9S5fKyyT1g==
X-Received: by 2002:a17:907:9809:b0:96b:207:a894 with SMTP id ji9-20020a170907980900b0096b0207a894mr14937287ejc.1.1684858654798;
        Tue, 23 May 2023 09:17:34 -0700 (PDT)
Received: from krava ([83.240.60.247])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067a0100b0096f738bc2f7sm4665983ejo.60.2023.05.23.09.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:17:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 May 2023 18:17:32 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	bpf@vger.kernel.org, liuyun01@kylinos.cn
Subject: Re: [PATCH] libbpf: kprobe.multi: Filter with blacklist and
 available_filter_functions
Message-ID: <ZGznHMU1uhdPnE/F@krava>
References: <20230523132547.94384-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523132547.94384-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 09:25:47PM +0800, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> When using regular expression matching with "kprobe multi", it scans all
> the functions under "/proc/kallsyms" that can be matched. However, not all
> of them can be traced by kprobe.multi. If any one of the functions fails
> to be traced, it will result in the failure of all functions. The best
> approach is to filter out the functions that cannot be traced to ensure
> proper tracking of the functions.
> 
> But, the addition of these checks will frequently probe whether a function
> complies with "available_filter_functions" and ensure that it has not been
> filtered by kprobe's blacklist. As a result, it may take a longer time
> during startup. The function implementation is referenced from BCC's
> "kprobe_exists()"
> 
> Here is the test eBPF program [1].
> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
> 
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ad1ec893b41b..6a201267fa08 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10421,6 +10421,50 @@ struct kprobe_multi_resolve {
>  	size_t cnt;
>  };
>  
> +static bool filter_available_function(const char *name)
> +{
> +	char addr_range[256];
> +	char sym_name[256];
> +	FILE *f;
> +	int ret;
> +
> +	f = fopen("/sys/kernel/debug/kprobes/blacklist", "r");
> +	if (!f)
> +		goto avail_filter;
> +
> +	while (true) {
> +		ret = fscanf(f, "%s %s%*[^\n]\n", addr_range, sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +		if (ret != 2)
> +			break;
> +		if (!strcmp(name, sym_name)) {
> +			fclose(f);
> +			return false;
> +		}
> +	}
> +	fclose(f);

so available_filter_functions already contains all traceable symbols
for kprobe_multi/fprobe

kprobes/blacklist is kprobe specific and does not apply to fprobe,
is there a crash when attaching function from kprobes/blacklist ?

> +
> +avail_filter:
> +	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> +	if (!f)
> +		return true;
> +
> +	while (true) {
> +		ret = fscanf(f, "%s%*[^\n]\n", sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +		if (ret != 1)
> +			break;
> +		if (!strcmp(name, sym_name)) {
> +			fclose(f);
> +			return true;
> +		}
> +	}
> +	fclose(f);
> +	return false;
> +}
> +
>  static int
>  resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>  			const char *sym_name, void *ctx)
> @@ -10431,6 +10475,9 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>  	if (!glob_match(sym_name, res->pattern))
>  		return 0;
>  
> +	if (!filter_available_function(sym_name))
> +		return 0;

I think it'd be better to parse available_filter_functions directly
for kprobe_multi instead of filtering out kallsyms entries

we could add libbpf_available_filter_functions_parse function with
similar callback to go over available_filter_functions file


jirka

> +
>  	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
>  				res->cnt + 1);
>  	if (err)
> -- 
> 2.25.1
> 
> 

