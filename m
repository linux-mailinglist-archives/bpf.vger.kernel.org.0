Return-Path: <bpf+bounces-2503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879A72E45F
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F7281252
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9034CCF;
	Tue, 13 Jun 2023 13:41:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E29522B
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 13:41:56 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089710F9
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:41:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30fb4b3e62fso1999517f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686663712; x=1689255712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cShwZbLvyK2iKaNF3sdSh4w/Hz3w1Wjs3fmrVAMGg+g=;
        b=Fh0NkM2YnbiA2wJJ2qZMJeQzu4qnHB65w3qRNbnm/A+v2Hd463sC0YHcCxCB0N76Ie
         48PcEAo3qrzhkYmolvpiHtaVvCCd+W2fGobcOwE1IkRUGeJBx59grpJYigksx/iEGs2/
         44v2BlY5SOpRXA13VMRQbrv5bDcRck+HTkYJFLHgH9EbYdwrWL9wwrk07UhVI+FQyU+O
         Ts9QLH19IcXG3w5AKyNf9o3y0w3gtHnko/4cINiuDK4iGGajgdz1y9sKEfuV36TKtnJ9
         dEqRhLUpzPeLZFQVQWTfuy0lnrV9XuWeU8v/3aXq2BISZOcMn6gwgNRjYVLGdK+TspXs
         zyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663712; x=1689255712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cShwZbLvyK2iKaNF3sdSh4w/Hz3w1Wjs3fmrVAMGg+g=;
        b=DV8BqpZAEUHd/AuR1LvEh2QmRnwXYQ3njUMkHG76tF547FTaf9OvHRC5+XP1RhFDp3
         UFjHcYJ73e67SUSDiE8LDnuIjyemH7b3QEWF9bs/NzFPW6N9zgvr0imW61W5Q4I+YApp
         CjeAXrW4wFDv0R4F/evHrrxqtEdap0JffINiH7jeUO9m9/thoK9mbpovz72ONWPlAfsS
         CK/o+4ydNToh6AbJxWYE440x7YQPUqzLxQDJhbr/LUSSe2KI6s7Bt2cZd8op3ErqnDay
         cs9doi2t+6S1/wUIUiqrBJS8vcvRxb2h70mytVTtlKnKYJ6/6QUWur534MgHgj52Rjbk
         bIIA==
X-Gm-Message-State: AC+VfDyYqjhIrEiPSo/uQ+YMazQOnRgvG0T40oS1Z5AjZL7KEjBF8wQw
	Qbcg8ZgAUVkt15QIbSxZzGfI2g==
X-Google-Smtp-Source: ACHHUZ4x1w7x/B7Q1i49H36K6M7BvG0XTB6AbY6m7ONe5v7v0/C86ixWjAh7o62cVRMjpLJS1E1kbg==
X-Received: by 2002:a5d:5258:0:b0:30d:44a1:99a with SMTP id k24-20020a5d5258000000b0030d44a1099amr6812564wrc.54.1686663712249;
        Tue, 13 Jun 2023 06:41:52 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a03e:3034:b6bf:fd8e? ([2a02:8011:e80c:0:a03e:3034:b6bf:fd8e])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0030e5da3e295sm15382207wrx.65.2023.06.13.06.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:41:51 -0700 (PDT)
Message-ID: <ffe856f4-9c25-2b6c-a508-bf474df39b7d@isovalent.com>
Date: Tue, 13 Jun 2023 14:41:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 bpf-next 02/10] bpftool: Dump the kernel symbol's
 module name
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-3-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230612151608.99661-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> If the kernel symbol is in a module, we will dump the module name as
> well.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
>  tools/bpf/bpftool/xlated_dumper.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index da608e1..dd917f3 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
>  		}
>  		dd->sym_mapping = tmp;
>  		sym = &dd->sym_mapping[dd->sym_count];
> -		if (sscanf(buff, "%p %*c %s", &address, sym->name) != 2)
> +
> +		/* module is optional */
> +		sym->module[0] = '\0';
> +		if (sscanf(buff, "%p %*c %s %s", &address, sym->name,
> +		    sym->module) < 2)
>  			continue;
>  		sym->address = (unsigned long)address;
>  		if (!strcmp(sym->name, "__bpf_call_base")) {
> diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
> index 9a94637..5df8025 100644
> --- a/tools/bpf/bpftool/xlated_dumper.h
> +++ b/tools/bpf/bpftool/xlated_dumper.h
> @@ -5,12 +5,14 @@
>  #define __BPF_TOOL_XLATED_DUMPER_H
>  
>  #define SYM_MAX_NAME	256
> +#define MODULE_NAME_LEN	64
>  
>  struct bpf_prog_linfo;
>  
>  struct kernel_sym {
>  	unsigned long address;
>  	char name[SYM_MAX_NAME];
> +	char module[MODULE_NAME_LEN];

Nit: MODULE_MAX_NAME would be more consistent and would make more sense
to me? And it would avoid confusion with MODULE_NAME_LEN from kernel,
which doesn't have the same value.

>  };
>  
>  struct dump_data {


