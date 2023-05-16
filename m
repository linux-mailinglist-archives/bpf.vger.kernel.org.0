Return-Path: <bpf+bounces-643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 810F7704E84
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804C01C20E65
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8027703;
	Tue, 16 May 2023 13:01:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969734CD9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 13:01:20 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49AF2D7F
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:01:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso100691685e9.3
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684242075; x=1686834075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUe2lAMx53t6m/5RaI9UwG8JLL/e+g3YKbhqNqFAMHk=;
        b=W7EQti70WjYDZ2FKyiwwT6BJbTMKkwyUkQZH52oWsJBVltWCQBTlVhse5dJ8dKTctG
         kpbzDsEAK2QLwChjGGaMIovtjowGN4T/R8C5vquPrb94yDEAtdZxYByPSAwNzyRr/LtA
         YxQ3SJkhr1tMKh06C/IChWiz18pYE4cnc0qjjgb5W8r/hMhtgOtCuYtLn6vbfyy8csPu
         U6IFAcpXD+wgycqdBMRseKlK1d0jObwj0q8OUgkcxh+pGYQIaPOhLnOKk44xPVNiiC4E
         IXK6tXozYkFXsAfzt0cANJPDvbB49jHIfdiBDmiN4Bb6T/SVKlPtRQGP++w1TLTngaKW
         Nnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242075; x=1686834075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUe2lAMx53t6m/5RaI9UwG8JLL/e+g3YKbhqNqFAMHk=;
        b=fDJpNAcQDl3ycCy6GYPrq0TzRjMGOr33+FWCT7wj14hqCkkXCaVcaApu/nkc8h3q6p
         StrPthOR6S1H/UAGoCNZ7Yh9q4hqSmkvwTck6f2AkHjt5NkEUEG3FPyCyUKO61TmDrAG
         X/BEYP1DUOqlXWlTqz8O3LpnKAgDEZB5uWNh/h5r1cuLfEORvAMH4u9n4/KgLUCp7L3h
         kAgo6QQto5mDLRZwECGpvw2lwYvQN/LIcD86zv8tO7ORPcB6lmOtUjHL3QCWiCpqgzKn
         yMxaS1HAST8cL3VeJs/RJtoc/CWeAJ4Ce1sLPRw5TYf8tmJDYAFljVq3rqktZM1mayZ0
         UkGg==
X-Gm-Message-State: AC+VfDyzSYNdrNdGVYglrLvSECdSDFRHlb2/AKkZpR1l9CIEPjCd6ka7
	4tGmKQAUrhh0v02YGBQSc9cpuQ==
X-Google-Smtp-Source: ACHHUZ5T0c+t5Uks62/4Fw1fKzviKeJFCTEbjGDl9RpDKa1z8iY+GepVjtUHb7dwSNzKdnUSkhqa9Q==
X-Received: by 2002:adf:f849:0:b0:306:35d4:566f with SMTP id d9-20020adff849000000b0030635d4566fmr25406145wrq.65.1684242074579;
        Tue, 16 May 2023 06:01:14 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:8d0d:450e:a1d0:2661? ([2a02:8011:e80c:0:8d0d:450e:a1d0:2661])
        by smtp.gmail.com with ESMTPSA id w9-20020adff9c9000000b00301a351a8d6sm2530485wrr.84.2023.05.16.06.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 06:01:14 -0700 (PDT)
Message-ID: <5c8e5c0e-02a6-f043-7c22-add9d2996eec@isovalent.com>
Date: Tue, 16 May 2023 14:01:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next 2/2] bpftool: Show target_{obj,btf}_id in tracing
 link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, song@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230516123926.57623-1-laoar.shao@gmail.com>
 <20230516123926.57623-3-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230516123926.57623-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-16 12:39 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> The target_btf_id can help us understand which kernel function is
> linked by a tracing prog. The target_btf_id and target_obj_id have
> already been exposed to userspace, so we just need to show them.
> 
> The result as follows,
> 
> $ tools/bpf/bpftool/bpftool link show
> 2: tracing  prog 13
>         prog_type tracing  attach_type trace_fentry
>         target_obj_id 1  target_btf_id 13964
>         pids trace(10673)
> 
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":2,"type":"tracing","prog_id":13,"prog_type":"tracing","attach_type":"trace_fentry","target_obj_id":1,"target_btf_id":13964,"pids":[{"pid":10673,"comm":"trace"}]}]
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 243b74e..cfe896f 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -195,6 +195,8 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>  
>  		show_link_attach_type_json(info->tracing.attach_type,
>  					   json_wtr);
> +		jsonw_uint_field(json_wtr, "target_obj_id", info->tracing.target_obj_id);
> +		jsonw_uint_field(json_wtr, "target_btf_id", info->tracing.target_btf_id);
>  		break;
>  	case BPF_LINK_TYPE_CGROUP:
>  		jsonw_lluint_field(json_wtr, "cgroup_id",
> @@ -375,6 +377,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  			printf("\n\tprog_type %u  ", prog_info.type);
>  
>  		show_link_attach_type_plain(info->tracing.attach_type);
> +		printf("\n\ttarget_obj_id %u  target_btf_id %u  ",
> +			   info->tracing.target_obj_id, info->tracing.target_btf_id);

Older kernels won't share this info, so maybe we can skip this printf()
in plain output if the target object and BTF ids are 0?

>  		break;
>  	case BPF_LINK_TYPE_CGROUP:
>  		printf("\n\tcgroup_id %zu  ", (size_t)info->cgroup.cgroup_id);


