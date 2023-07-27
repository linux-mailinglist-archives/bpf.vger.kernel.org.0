Return-Path: <bpf+bounces-6073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852447653CE
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B639D1C21644
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B383171B1;
	Thu, 27 Jul 2023 12:27:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BC13AC1
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 12:27:18 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE574200
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 05:26:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31297125334so586928f8f.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1690460815; x=1691065615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krUsWJrSbT94Y2njRnvGsx0mZ0IDUPa+ST4QCqg21Lk=;
        b=SirOA77z3IYYVzo6MktRkF6SXigTC2gNOaK9LgeVqhnF4poO7cjaVWGOowctJLdZm4
         p4np4nG0P5aWhe0Qxr6zY1IDJIKSpli9n+ZvXQd49z08XLStoFaronpi2dokRWTzxDY/
         AoBytA6eEDOmIDoUr2Fry49cmkURQXxjE6zYW0mqjIaFjYD3Mxq1/Gz/yr8S121D6Au5
         M7HqFRoQD8xpI+PmWqJOjHp9dctOqdrxw+za7TJ2P1PPs4moeci+258f2dn7Acr4DE76
         78vs8AiXcxCFuFC8ZC345YAXJI9YbMdhDSKn1iAST8RQR8pC+8QecnGDNxdwsrq9qXG0
         mRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460815; x=1691065615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krUsWJrSbT94Y2njRnvGsx0mZ0IDUPa+ST4QCqg21Lk=;
        b=HVqpkE40GPYJ9jzzWcetnhQTuBPndJcx77qDTwZ7X4dkIr+pouJ/vGASqKCcoWj7mv
         l8tcsZ7RDemnId/VBfO/d5IwuN2pvYZaluKc6dh1azMKMawE8StsVNRJAGNN/GsacojI
         EzgrVKE04M9QqpS8HGIAmuDfUno+A3U/9bzTF/AYT3NvNTIkf4uECNf0Zrsi28UiYPjN
         x3o9027gL57vlzo4I4GbBfAjvNp1kpLndAdscX64j5bv3HF9jeA32djzGY/tzO34BO2e
         Q1wPm3UB2raC4PhUka8ivvcxNiR6qzAkgW4i6g+WvG6GxMraQQYjSDv5f3VU1QnU+wjJ
         buOQ==
X-Gm-Message-State: ABy/qLYcWh7C7Kq97t0h5b8XS2RBhPvSjYJG4EaBxcsttJO590b+C6GF
	3LPGTW59++aWO8FZ7NKYFiP6zA==
X-Google-Smtp-Source: APBJJlHZESWh+iPWchiyU4VlWw4pInX9ZuRnhfnhpPmvQe48Qu8W8h1SapWmUqg5A8Lk7cb0f7hH5A==
X-Received: by 2002:adf:e252:0:b0:314:1e15:f30b with SMTP id bl18-20020adfe252000000b003141e15f30bmr1223531wrb.35.1690460814905;
        Thu, 27 Jul 2023 05:26:54 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:3cc3:939b:a917:f0a3? ([2a02:8011:e80c:0:3cc3:939b:a917:f0a3])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4f12000000b0030647449730sm1931066wru.74.2023.07.27.05.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:26:54 -0700 (PDT)
Message-ID: <b22038a1-d06f-8bca-57f1-cc8da84a8fca@isovalent.com>
Date: Thu, 27 Jul 2023 13:26:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [RFC PATCH 3/5] libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <20230727073632.44983-4-zhouchuyi@bytedance.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230727073632.44983-4-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-07-27 15:36 UTC+0800 ~ Chuyi Zhou <zhouchuyi@bytedance.com>
> Support BPF_PROG_TYPE_OOM_POLICY program in libbpf and bpftool, so that
> we can identify and use BPF_PROG_TYPE_OOM_POLICY in our application.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  tools/bpf/bpftool/common.c     |  1 +
>  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>  tools/lib/bpf/libbpf.c         |  3 +++
>  tools/lib/bpf/libbpf_probes.c  |  2 ++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..c5c311299c4a 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -1089,6 +1089,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>  	case BPF_TRACE_FENTRY:			return "fentry";
>  	case BPF_TRACE_FEXIT:			return "fexit";
>  	case BPF_MODIFY_RETURN:			return "mod_ret";
> +	case BPF_OOM_POLICY:			return "oom_policy";

This case is not necessary. This block is here to keep legacy attach
type strings supported by bpftool. In your case, the name is the same as
the one provided by libbpf, so...

>  	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
>  	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
>  	default:	return libbpf_bpf_attach_type_str(t);

... we just want to pick it up from libbpf directly, here.

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 214f828ece6b..10496bb9b3bc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -118,6 +118,7 @@ static const char * const attach_type_name[] = {
>  	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
>  	[BPF_STRUCT_OPS]		= "struct_ops",
>  	[BPF_NETFILTER]			= "netfilter",
> +	[BPF_OOM_POLICY]		= "oom_policy",
>  };


