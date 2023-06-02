Return-Path: <bpf+bounces-1745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6552C720A6A
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8BA281B23
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FB8846F;
	Fri,  2 Jun 2023 20:38:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF232F33
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 20:38:50 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944BE4D
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:38:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b025d26f4fso22191025ad.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685738328; x=1688330328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/YN/stoESsynLYfCXVgZFUwA4VC/yc0QuXPpF/IiIY=;
        b=A6SrNMBiiE8M+5dpOJAPhv1HikN2RqYDaQ3pzhq8Lttkdleb1ZyIa9fBv3DmiJ58Hw
         xWg78ZPXDxmL6ZSh7AV07lr9TZ8L5nCv90avq2ltIUE92W9Z1Nc6SOKAROJvmZPBteLG
         HqlQVt83NB2miQ3L/+WcIyf6A2uiEoIU80C2e+lc6UMmmrH0TVF5KyVvMmtdFUbaFRs+
         mvphnEtHrldiRsq8KzuAQX8z1nSiqBu5TQ7cYXmyh0j7IQ2h0xswXeKgdUoxP5cVpPAF
         DrcYlVi3DuVXJPpG8VylyqJfAc9Q5l05WP3nVuUxWjZLKMzg8fmO0IK2b9cIHKabNT4X
         rIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738328; x=1688330328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/YN/stoESsynLYfCXVgZFUwA4VC/yc0QuXPpF/IiIY=;
        b=khLzynAO8pTxzQQDi9mzdR6IXhI8if62zMCSXUYpCIMPlZXv4DkookoexiDNpRS2lo
         cjX1UFAirNFT6jiaC0UOU0h5VSUapo7P2/u0sD0HZNarBmdV1SC37NMNAp+wsXPN2Ks+
         9iYT84uCH3DYWebhRqruNoTnXYqn4UkZzYMWX+rYMkm6URy7hP0tvxGqtp0MtKterLcn
         Avi58DVgMGA/XzZClOS/apAHI/kRxcpk9WTpRxnWU6tdogy7YJbTOywQxtOGY3+k3K2h
         /z5wlfOwNi38V4n7tlES6Fjp93CGScqyddBQqkzE2NCOjM8ExZxg4z2oRnJr2odGLD75
         lUGw==
X-Gm-Message-State: AC+VfDy4qNULglTZhajuWZB4Tuotks6MvhtfijaqMh3EaDTgt18TwkGT
	hxDOo/OuDeVp/TpAAmlFYxI=
X-Google-Smtp-Source: ACHHUZ7GTLt93Ujk3V8hhowsQxiplfJhUxJGbaCeVku0g0qfwwDj3gaViaDgRvP3yUOZAdsM7roEzA==
X-Received: by 2002:a17:902:ec86:b0:1af:d750:10cb with SMTP id x6-20020a170902ec8600b001afd75010cbmr1235773plg.63.1685738328463;
        Fri, 02 Jun 2023 13:38:48 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:bddd])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902779400b001a6e5c2ebfesm1767285pll.152.2023.06.02.13.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 13:38:48 -0700 (PDT)
Date: Fri, 2 Jun 2023 13:38:45 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 6/6] bpftool: Show probed function in perf_event
 link info
Message-ID: <20230602203845.iklpi4f6wgdfnbll@MacBook-Pro-8.local>
References: <20230602085239.91138-1-laoar.shao@gmail.com>
 <20230602085239.91138-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602085239.91138-7-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 02, 2023 at 08:52:39AM +0000, Yafang Shao wrote:
> Show the exposed perf_event link info in bpftool. The result as follows,
> 
> $ bpftool link show
> 1: perf_event  prog 5
>         func kernel_clone  addr ffffffffb40bc310  offset 0
>         bpf_cookie 0
>         pids trace(9726)
> $ bpftool link show -j
> [{"id":1,"type":"perf_event","prog_id":5,"func":"kernel_clone","addr":18446744072435254032,"offset":0,"bpf_cookie":0,"pids":[{"pid":9726,"comm":"trace"}]}]
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 3b00c07..045f59f 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -280,6 +280,12 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>  			kernel_syms_show(addrs, info->kprobe_multi.count, 0);
>  		jsonw_end_array(json_wtr);
>  		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		jsonw_string_field(json_wtr, "func",
> +				   u64_to_ptr(info->perf_event.name));
> +		jsonw_uint_field(json_wtr, "addr", info->perf_event.addr);
> +		jsonw_uint_field(json_wtr, "offset", info->perf_event.offset);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -416,7 +422,7 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
>  static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  {
>  	struct bpf_prog_info prog_info;
> -	const char *prog_type_str;
> +	const char *prog_type_str, *buf;
>  	int err;
>  
>  	show_link_header_plain(info);
> @@ -472,6 +478,12 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
>  		kernel_syms_show(addrs, cnt, indent);
>  		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		buf = (const char *)u64_to_ptr(info->perf_event.name);
> +		if (buf[0] != '\0' || info->perf_event.addr)
> +			printf("\n\tfunc %s  addr %llx  offset %d  ", buf,
> +			       info->perf_event.addr, info->perf_event.offset);

Let's print the name here as well?

