Return-Path: <bpf+bounces-1381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F1714A34
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CB41C209C6
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5E747B;
	Mon, 29 May 2023 13:23:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5E3D60
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 13:23:38 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCFD90
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 06:23:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so21556465e9.0
        for <bpf@vger.kernel.org>; Mon, 29 May 2023 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685366615; x=1687958615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iY4gz99JQLGh2Eet6jekHi0RiB/Ud1E1C+DLO9Qnwc0=;
        b=SrbZGxODnWTzPPYzgcbxGT8VIhs52sQQu+T5L8rGWBeIUrw2uJheRYLjdoHAbqKLjX
         xnfGP2wOFTfKnkDvLkxR4wJzMd+g90y3Xmfr8ExN2mtdc4mx945fI8MhKQTDRStgYDXJ
         RXo0acXkVa5sisMh1n+1lkuOSOHZfU6rZKM1wn2T1JanX8rfdBVmVwr+Pd5TBMjB3UMR
         ui14NdcvSr4h7KVLPpPfbnhPWwwdTdVIlpnGluyL9EX5BfLB6IUmuKBN8x7djlMAZI//
         J6U2gQeKJmOOFsjsuofoNmKYFQcDtEM9E29ckQ1dLpBLlwVB3ICQWHy4l5NpaiY7smEF
         3W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366615; x=1687958615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY4gz99JQLGh2Eet6jekHi0RiB/Ud1E1C+DLO9Qnwc0=;
        b=U4Ojt+psxstWKK2CXQXmemRaf6q9+/e7xApBt/LGpwNW6u5aO/pvWx4POfurSFUYYV
         KEbOnfXj6DQZswhlmi4ajd2koEZLrajp8D6Zaf8mjwuGK5opm3KwhOx/bcaxlbQv/0ai
         /Mzf0x39aKwzGFso6AD2vgJu3xMxG9P4mLW6iXIt21wYSt2SgLlpDNwQupcU9gMpyq6s
         M+ZJId9zFTJxhPpXfJc1fjYwDS9zO7VfQpbUyhw1PIKawib6LD3cPvqfRpiujQWbqu3b
         vHoSsYMtbJYTo4JZbc/qzdlKJRRZaaDZCYxXC5Zv4710vUNBjxBDB2+z7jrcUf7WqXVp
         U8/Q==
X-Gm-Message-State: AC+VfDyw+VkRomfXanp0rEl0qcbIIAgCakLcolxhkpNPE8zxPr+XoJn8
	jD2fF//aiHuT4zzjm9tY+1FBUCB2qtk=
X-Google-Smtp-Source: ACHHUZ7ocwrFylwX+HeRr56IiPCa47oLEXmV7+FdZt8UqPG8QXXuKl8iPPrtYGjpfkciLsV8E9bA2w==
X-Received: by 2002:adf:df12:0:b0:306:2f8e:d259 with SMTP id y18-20020adfdf12000000b003062f8ed259mr7254087wrl.57.1685366614856;
        Mon, 29 May 2023 06:23:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d500c000000b0030ae87bd3e3sm4614105wrt.18.2023.05.29.06.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:23:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 May 2023 15:23:32 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: olsajiri@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: Re: [PATCH v6 RESEND] libbpf: kprobe.multi: Filter with
 available_filter_functions
Message-ID: <ZHSnVHGVDxiNZwxT@krava>
References: <20230526155026.1419390-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526155026.1419390-1-liu.yun@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 11:50:26PM +0800, Jackie Liu wrote:
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
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 100 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 93 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ad1ec893b41b..0914b7e98e30 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10106,6 +10106,12 @@ static const char *tracefs_uprobe_events(void)
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
> @@ -10417,13 +10423,14 @@ static bool glob_match(const char *str, const char *pat)
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
> @@ -10440,6 +10447,77 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
>  	return 0;
>  }
>  
> +static int ftrace_resolve_kprobe_multi_cb(const char *sym_name, void *ctx)
> +{
> +	struct kprobe_multi_resolve *res = ctx;
> +	int err;
> +	char *name;
> +
> +	if (!glob_match(sym_name, res->pattern))
> +		return 0;
> +
> +	err = libbpf_ensure_mem((void **) &res->syms, &res->cap,
> +				sizeof(const char *), res->cnt + 1);
> +	if (err)
> +		return err;
> +
> +	name = strdup(sym_name);
> +	if (!name)
> +		return -errno;
> +
> +	res->syms[res->cnt++] = name;
> +	return 0;
> +}
> +
> +typedef int (*available_kprobe_cb_t)(const char *sym_name, void *ctx);
> +
> +static int
> +libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
> +{
> +	char sym_name[256];
> +	FILE *f;
> +	int ret, err = 0;
> +	const char *available_path = tracefs_available_filter_functions();
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
> +		ret = fscanf(f, "%255s%*[^\n]\n", sym_name);
> +		if (ret == EOF && feof(f))
> +			break;
> +		if (ret != 1) {
> +			pr_warn("failed to read available kprobe entry: %d\n",
> +				ret);
> +			err = -EINVAL;
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
> +}
> +
> +static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
> +{
> +	while (res->syms && res->cnt)
> +		free((char *)res->syms[--res->cnt]);
> +
> +	free(res->syms);
> +	free(res->addrs);

I think we also need to zero the res->syms pointer, so the final
kprobe_multi_resolve_free won't try to release it again
perhaps use zfree for both syms and addrs

other than this it looks ok to me:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> +	/* reset cap to zero, when fallback */
> +	res->cap = 0;
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  				      const char *pattern,
> @@ -10476,13 +10554,21 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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
>  		}
> +		syms = res.syms;
>  		addrs = res.addrs;
>  		cnt = res.cnt;
>  	}
> @@ -10511,12 +10597,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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

