Return-Path: <bpf+bounces-19827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E983831EC7
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32272837EE
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EBC2D612;
	Thu, 18 Jan 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Zd6MQnQB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBEF2D608
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600283; cv=none; b=YEdTuRMuMG47awqldV17bg7E8Jv316ppCg1WKxjJKE7skouIIP3tS1U0btMqFsLNHaZ4Gc/Vleorl/Gi9ttY6Xl8kHbmSY0Y71CeprhZcWGBVpMJkQLTF+Lm62Uc75dwR6m2D7fnxzmjAuQqwuW7IosLvdTw2KzH7CHCKOyzTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600283; c=relaxed/simple;
	bh=zDzeJV6NZW8j6zj8Gl8PBTVc1LERlRyv3epUaD3XqCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn2f2suRej8bnsNl+6mcWruiWESohCqw8wimPJZINGsuJE3fSSx4/MpmrYc4QG4IYC3pLsdsUUEmoRyWI3jEu2r90QaqR5jL953s6MUnF+UoAQgTb2hZJfctSnTmelF4sm8hY81nPuwjVY0FGyM78xZnlrCFJanBYPwABCZGZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Zd6MQnQB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso76349915e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705600279; x=1706205079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEGb+aL5zwJvIS/+qwPYYY68qhUpJUzDuBPzGIGW3cU=;
        b=Zd6MQnQBvcmTY6utdQYXXbAWp9rEVex3pliLAH7PjEOT81rcOvG9t3ODs0Us/bz2NK
         bIOFo4ZdLMq4732wofIgfMNH9oUWplqa3txRWYVu7HQcG9N7SXOP2TkYxDbnAQRTBsK8
         QsJJ+9dit7UG6wCOKYpS6XipOlKbdoN3k8ZFi9KFuudPGmzZxN+RqdO62l+trmtzqvQb
         N+Db0G/LLWZKi1YQo0htAD3P9nvoos92uwpK6vk+iSoPFHJfia13BS3mMDflWu8X3WpT
         +S8QmEdgtrJHccqAOpK75FC4W45gshNYGGQM169mtfzK4g7iw5tyqQtrveSo8I3+f0D1
         9TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600279; x=1706205079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEGb+aL5zwJvIS/+qwPYYY68qhUpJUzDuBPzGIGW3cU=;
        b=sQfbQvqLOUkVmPMBlMddrxSAJoNmQ3ARhAMUB55mW8bJDg7iiJkrYds90XcpiJ6iFF
         x7yOcoy96GXpJDALS4Tv/lz3zoHPNP2W90zaLZ0kLu2ODfvXb8bdEJzH8f6Wgi8x3smR
         NKEjd9ohQWDhSpS+zABNHLdfwPKpd9PlsypWuPj7zU/rrc71V9yJBMtAv4Mv1MYFXWHi
         ipDwpOBMeVg/ZmhZLlU+FP/z2bXVj4pxBZjRTQdeBJob5qxelNE1rNWCxshI4z0wxmzo
         DIXBaBNfIIRynkA91S/aUZFmdVP0LuNaUXki9XpNOJ+ISWTN3IO65jBxLBt0qPBkJBzY
         S11w==
X-Gm-Message-State: AOJu0Yw8c5B5QK1X+5DTYt3G73tOfSWgx1O9mMsgoNtheOwaNpZKBRPK
	SkxQ04fYZc7gFG+W+uDmakC1OfluKet43nalxlbFFf1N5GjZHdIYfJ3YII0CpMA=
X-Google-Smtp-Source: AGHT+IFUKt+D5rN62EQGieKmjFK5YBNs34No9qdorHaK7GhpoURya/4lgG7Hww4dBRLLo2TIz18f7A==
X-Received: by 2002:a05:600c:c6:b0:40e:76f4:8cdc with SMTP id u6-20020a05600c00c600b0040e76f48cdcmr775689wmm.111.1705600279455;
        Thu, 18 Jan 2024 09:51:19 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3e3f:a818:b0d3:50b7? ([2a02:8011:e80c:0:3e3f:a818:b0d3:50b7])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b0040e39cbf2a4sm30805293wmo.42.2024.01.18.09.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:51:19 -0800 (PST)
Message-ID: <48e86f23-d938-4705-b91a-adbe4ee3123c@isovalent.com>
Date: Thu, 18 Jan 2024 17:51:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 8/8] bpftool: Display cookie for kprobe multi
 link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20240118095416.989152-1-jolsa@kernel.org>
 <20240118095416.989152-9-jolsa@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240118095416.989152-9-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-01-18 09:55 UTC+0000 ~ Jiri Olsa <jolsa@kernel.org>
> Displaying cookies for kprobe multi link, in plain mode:
> 
>   # bpftool link
>   ...
>   1397: kprobe_multi  prog 47532
>           kretprobe.multi  func_cnt 3
>           addr             cookie           func [module]
>           ffffffff82b370c0 3                bpf_fentry_test1
>           ffffffff82b39780 1                bpf_fentry_test2
>           ffffffff82b397a0 2                bpf_fentry_test3
> 
> And in json mode:
> 
>   # bpftool link -j | jq
>   ...
>     {
>       "id": 1397,
>       "type": "kprobe_multi",
>       "prog_id": 47532,
>       "retprobe": true,
>       "func_cnt": 3,
>       "missed": 0,
>       "funcs": [
>         {
>           "addr": 18446744071607382208,
>           "func": "bpf_fentry_test1",
>           "module": null,
>           "cookie": 3
>         },
>         {
>           "addr": 18446744071607392128,
>           "func": "bpf_fentry_test2",
>           "module": null,
>           "cookie": 1
>         },
>         {
>           "addr": 18446744071607392160,
>           "func": "bpf_fentry_test3",
>           "module": null,
>           "cookie": 2
>         }
>       ]
>     }
> 
> Cookie is attached to specific address, and because we sort addresses
> before printing, we need to sort cookies the same way, hence adding
> the struct addr_cookie to keep and sort them together.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 71 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 57 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index b66a1598b87c..fd862afe6c6f 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -249,18 +249,44 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
>  	return err;
>  }
>  
> -static int cmp_u64(const void *A, const void *B)
> +struct addr_cookie {
> +	__u64 addr;
> +	__u64 cookie;
> +};
> +
> +static int cmp_addr_cookie(const void *A, const void *B)
> +{
> +	const struct addr_cookie *a = A, *b = B;
> +
> +	if (a->addr == b->addr)
> +		return 0;
> +	return a->addr < b->addr ? -1 : 1;
> +}
> +
> +static struct addr_cookie *
> +get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
>  {
> -	const __u64 *a = A, *b = B;
> +	struct addr_cookie *data;
> +	__u32 i;
>  
> -	return *a - *b;
> +	data = calloc(count, sizeof(data[0]));
> +	if (!data) {
> +		p_err("mem alloc failed");
> +		return NULL;
> +	}
> +	for (i = 0; i < count; i++) {
> +		data[i].addr = addrs[i];
> +		data[i].cookie = cookies[i];
> +	}
> +	qsort(data, count, sizeof(data[0]), cmp_addr_cookie);
> +	return data;
>  }
>  
>  static void
>  show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  {
> +	struct addr_cookie *data;
>  	__u32 i, j = 0;
> -	__u64 *addrs;
>  
>  	jsonw_bool_field(json_wtr, "retprobe",
>  			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
> @@ -268,14 +294,17 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  	jsonw_uint_field(json_wtr, "missed", info->kprobe_multi.missed);
>  	jsonw_name(json_wtr, "funcs");
>  	jsonw_start_array(json_wtr);
> -	addrs = u64_to_ptr(info->kprobe_multi.addrs);
> -	qsort(addrs, info->kprobe_multi.count, sizeof(addrs[0]), cmp_u64);
> +	data = get_addr_cookie_array(u64_to_ptr(info->kprobe_multi.addrs),
> +				     u64_to_ptr(info->kprobe_multi.cookies),
> +				     info->kprobe_multi.count);
> +	if (!data)
> +		return;
>  
>  	/* Load it once for all. */
>  	if (!dd.sym_count)
>  		kernel_syms_load(&dd);
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != addrs[j])
> +		if (dd.sym_mapping[i].address != data[j].addr)
>  			continue;
>  		jsonw_start_object(json_wtr);
>  		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
> @@ -287,11 +316,13 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  		} else {
>  			jsonw_string_field(json_wtr, "module", dd.sym_mapping[i].module);
>  		}
> +		jsonw_uint_field(json_wtr, "cookie", data[j].cookie);
>  		jsonw_end_object(json_wtr);
>  		if (j++ == info->kprobe_multi.count)
>  			break;
>  	}
>  	jsonw_end_array(json_wtr);
> +	free(data);
>  }
>  
>  static __u64 *u64_to_arr(__u64 val)
> @@ -675,8 +706,8 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
>  
>  static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  {
> +	struct addr_cookie *data;
>  	__u32 i, j = 0;
> -	__u64 *addrs;
>  
>  	if (!info->kprobe_multi.count)
>  		return;
> @@ -688,8 +719,11 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  	printf("func_cnt %u  ", info->kprobe_multi.count);
>  	if (info->kprobe_multi.missed)
>  		printf("missed %llu  ", info->kprobe_multi.missed);
> -	addrs = (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> -	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
> +	data = get_addr_cookie_array(u64_to_ptr(info->kprobe_multi.addrs),
> +				     u64_to_ptr(info->kprobe_multi.cookies),
> +				     info->kprobe_multi.count);
> +	if (!data)
> +		return;
>  
>  	/* Load it once for all. */
>  	if (!dd.sym_count)
> @@ -697,12 +731,12 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  	if (!dd.sym_count)
>  		return;

Don't we need to free(data) if we return here?

>  
> -	printf("\n\t%-16s %s", "addr", "func [module]");
> +	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != addrs[j])
> +		if (dd.sym_mapping[i].address != data[j].addr)
>  			continue;
> -		printf("\n\t%016lx %s",
> -		       dd.sym_mapping[i].address, dd.sym_mapping[i].name);
> +		printf("\n\t%016lx %-16llx %s",
> +		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
>  		if (dd.sym_mapping[i].module[0] != '\0')
>  			printf(" [%s]  ", dd.sym_mapping[i].module);
>  		else
> @@ -711,6 +745,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  		if (j++ == info->kprobe_multi.count)
>  			break;
>  	}
> +	free(data);
>  }
>  
>  static void show_uprobe_multi_plain(struct bpf_link_info *info)
> @@ -966,6 +1001,14 @@ static int do_show_link(int fd)
>  				return -ENOMEM;
>  			}
>  			info.kprobe_multi.addrs = ptr_to_u64(addrs);
> +			cookies = calloc(count, sizeof(__u64));
> +			if (!cookies) {
> +				p_err("mem alloc failed");
> +				free(addrs);
> +				close(fd);
> +				return -ENOMEM;
> +			}
> +			info.kprobe_multi.cookies = ptr_to_u64(cookies);
>  			goto again;
>  		}
>  	}


