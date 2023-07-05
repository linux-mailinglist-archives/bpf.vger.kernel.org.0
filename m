Return-Path: <bpf+bounces-4032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB7674804F
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 11:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BD0280A51
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 09:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2394A14;
	Wed,  5 Jul 2023 09:01:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0146B2
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 09:01:28 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6343311F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0+P+83xNCcXjp+vWsac468ys2zoCHiPwhe02xGlF9XI=; b=cgWC9RzavNHo4J6ZWSAwXmUxRh
	m4Z0FRRQsifOVxTezNDwTIR5nHi87pqEdI3l2OZpZ0rEl5LAWmnPtYT34BLpHdpo8uu0yxpCsReL4
	kJP2NLdctBEcG36IyA11+2D4NsFzy2lh0IMM28nXFXGc+XJAGmtkQ/HnmzBlnabp2dCzEaSHRUoQF
	xgN8O/i0I+fqZqVlPwkDwsZJVpETtfLc8qCpn4r9Q46CSvcPa2s1tzGZj90Dnz7Y1C81Dc2gGijE4
	qbLtudBTe300yQNHAK2WQhU2kW5unacOOWdDZsvQ41O/TeIWjb1tJOQZrXjMhUq3uB7BFGjCqbCOC
	tPmovrtg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGyNv-0005H5-0Y; Wed, 05 Jul 2023 11:01:15 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGyNu-0008Ht-MS; Wed, 05 Jul 2023 11:01:14 +0200
Subject: Re: [PATCH v6 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
To: Jackie Liu <liu.yun@linux.dev>, olsajiri@gmail.com, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
 liuyun01@kylinos.cn
References: <20230705033457.3778537-1-liu.yun@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <53543ecf-d1dd-3e11-ac6f-59ed134a0711@iogearbox.net>
Date: Wed, 5 Jul 2023 11:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230705033457.3778537-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/5/23 5:34 AM, Jackie Liu wrote:
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
>   v5->v6: fix crash by not init "const char *syms"
>   v4->v5: simplified code
> 
>   tools/lib/bpf/libbpf.c | 106 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 96 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 214f828ece6b..3b5a12ca47bf 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10224,6 +10224,12 @@ static const char *tracefs_uprobe_events(void)
>   	return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
>   }
>   
> +static const char *tracefs_available_filter_functions(void)
> +{
> +	return use_debugfs() ? DEBUGFS"/available_filter_functions" :
> +			       TRACEFS"/available_filter_functions";
> +}
> +
>   static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>   					 const char *kfunc_name, size_t offset)
>   {
> @@ -10539,14 +10545,26 @@ struct kprobe_multi_resolve {
>   	size_t cnt;
>   };
>   
> -static int
> -resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> -			const char *sym_name, void *ctx)
> +static int avail_compare_function(const void *a, const void *b)
> +{
> +	return strcmp(*(const char **)a, *(const char **)b);
> +}
> +
> +struct avail_kallsyms_data {
> +	const char **syms;
> +	size_t cnt;
> +	struct kprobe_multi_resolve *res;
> +};
> +
> +static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
> +			     const char *sym_name, void *ctx)
>   {
> -	struct kprobe_multi_resolve *res = ctx;
> +	struct avail_kallsyms_data *data = ctx;
> +	struct kprobe_multi_resolve *res = data->res;
>   	int err;
>   
> -	if (!glob_match(sym_name, res->pattern))
> +	if (!bsearch(&sym_name, data->syms, data->cnt, sizeof(void *),
> +		     avail_compare_function))
>   		return 0;
>   
>   	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
> @@ -10558,6 +10576,78 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>   	return 0;
>   }
>   
> +static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
> +{
> +	struct avail_kallsyms_data data;
> +	char sym_name[500];
> +	const char *available_functions_file = tracefs_available_filter_functions();
> +	FILE *f;
> +	int err = 0, ret, i;
> +	const char **syms = NULL;
> +	size_t cap = 0, cnt = 0;
> +
> +	f = fopen(available_functions_file, "r");
> +	if (!f) {
> +		err = -errno;
> +		pr_warn("failed to open %s\n", available_functions_file);
> +		return err;
> +	}
> +
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

All your jumps to cleanup here and below leak f.

> +		}
> +
> +		if (!glob_match(sym_name, res->pattern))
> +			continue;
> +
> +		err = libbpf_ensure_mem((void **)&syms, &cap, sizeof(void *),
> +					cnt + 1);
> +		if (err)
> +			goto cleanup;
> +
> +		name = strdup(sym_name);
> +		if (!name) {
> +			err = -errno;
> +			goto cleanup;
> +		}
> +
> +		syms[cnt++] = name;
> +	}
> +	fclose(f);
> +
> +	/* not found entry, return direct */
> +	if (!cnt)
> +		return -ENOENT;
> +
> +	/* sort available functions */
> +	qsort(syms, cnt, sizeof(void *), avail_compare_function);
> +
> +	data.syms = syms;
> +	data.res = res;
> +	data.cnt = cnt;
> +	libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
> +
> +	if (!res->cnt)
> +		err = -ENOENT;
> +
> +cleanup:
> +	for (i = 0; i < cnt; i++)
> +		free((char *)syms[i]);
> +	free(syms);
> +
> +	return err;
> +}
> +
>   struct bpf_link *
>   bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>   				      const char *pattern,
> @@ -10594,13 +10684,9 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>   		return libbpf_err_ptr(-EINVAL);
>   
>   	if (pattern) {
> -		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
> +		err = libbpf_available_kallsyms_parse(&res);
>   		if (err)
>   			goto error;
> -		if (!res.cnt) {
> -			err = -ENOENT;
> -			goto error;
> -		}
>   		addrs = res.addrs;
>   		cnt = res.cnt;
>   	}
> 


