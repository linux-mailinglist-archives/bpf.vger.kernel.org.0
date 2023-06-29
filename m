Return-Path: <bpf+bounces-3736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D57427A4
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCF280DCC
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE0125B9;
	Thu, 29 Jun 2023 13:46:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9C125A9
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:46:37 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3F30F1
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:46:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa93d61d48so7385125e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688046395; x=1690638395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZsl8N+iQhKsIOsKT4bOEhED89h7DOOL2ijQX1JXlvM=;
        b=VEiixseM0P5V7v02CJFneYpijvx9SKlFreI31SM1UDp0Ceg9n5lxkz3TBCvceeqbOl
         CGWVQyXcB3aYDjyseZVs+R+kuUGR1OplM520KZUAl2VvQBGbswOvYpXSKU2LEMQf55QV
         phQABZ/H3UWcVWc43zbY7Pig4EK46BHYCU/GyHI7yz7WZdvd5vquzY4QmCHtSBQ9IgM2
         qbx3JH+1pmWH61BOXJH0QRqbkjozLnEArQzUo6X53kUes9ODHTtmy9+KF18btvMONgpR
         gaMsuLsQYuJFFXBQrn7eRvpX4DTlhplkZFnZf+0tbcHYA2/i70V2OzSdUIF6HhVnfqeq
         0Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688046395; x=1690638395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZsl8N+iQhKsIOsKT4bOEhED89h7DOOL2ijQX1JXlvM=;
        b=Kxx6GokLB070PJPkt/oe+TXdAo7AOOXmKI4C17cDNz+AHhfPgIFSjP5D5222iO9vwo
         vB5x5dzO0WuiSSa5W951zpROGNJWNktz75AbPKnnKaDw6dMthMDPZC54q3fz963QpZDl
         X77dSoL1xOd7LpaeetMwV7MG9i5auJvCnJ2UyVLwPBh+u7ONU/+j2cOP+fAHvefRWKuV
         zS4D6LJPB3SjHPaskHhNGQEp9AT5Dy2WloZ9JW+cjkbEqKZH8V/orItKSsGELflY2gSJ
         3u1T3P+Potf0TsyN4FXIZpArrqEXDfwwJhBM6zo/cwXYLdUqQv3dvCmsGlgm5bij7xn2
         S3jw==
X-Gm-Message-State: AC+VfDxYkNdJkqtdIJZQXaJHioZZX3saykF/2LoAdAPjTZQQVqEuMSca
	Lui1fFz4D2UbrkfNtW6dBiD7MQ==
X-Google-Smtp-Source: ACHHUZ4ykR0aC8ipskXrfleWK1VpP1ySR2rPo8RtiZjGjbTNbOYq1LXPxBwFvwYApocWQDJzR2fHCQ==
X-Received: by 2002:a05:600c:29a:b0:3fb:a8ef:edfe with SMTP id 26-20020a05600c029a00b003fba8efedfemr6067924wmk.18.1688046394807;
        Thu, 29 Jun 2023 06:46:34 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:48c4:4b87:cc05:b4fb? ([2a02:8011:e80c:0:48c4:4b87:cc05:b4fb])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c238500b003f900678815sm16575276wma.39.2023.06.29.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 06:46:34 -0700 (PDT)
Message-ID: <4892a56a-44f8-c45e-c119-503d63ce0fd2@isovalent.com>
Date: Thu, 29 Jun 2023 14:46:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 bpf-next 02/11] bpftool: Dump the kernel symbol's
 module name
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-3-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230628115329.248450-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-28 11:53 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> If the kernel symbol is in a module, we will dump the module name as
> well. The square brackets around the module name are trimmed.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
>  tools/bpf/bpftool/xlated_dumper.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index da608e10c843..567f56dfd9f1 100644
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
> +		/* trim the square brackets around the module name */
> +		if (sscanf(buff, "%p %*c %s [%[^]]s", &address, sym->name, sym->module) < 2)

Looking again at this patch, we should be good for parsing the module
name with the sscanf() because I don't expect a module name longer than
MODULE_MAX_NAME to show up, but I wonder what guarantee we have about
symbols names staying under SYM_MAX_NAME? Maybe we should specify the
max length to read, to remain on the safe side (or in case these limits
change in the future). But it doesn't have to be part of your set, I can
send a follow-up after that.

>  			continue;
>  		sym->address = (unsigned long)address;
>  		if (!strcmp(sym->name, "__bpf_call_base")) {
> diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
> index 9a946377b0e6..db3ba0671501 100644
> --- a/tools/bpf/bpftool/xlated_dumper.h
> +++ b/tools/bpf/bpftool/xlated_dumper.h
> @@ -5,12 +5,14 @@
>  #define __BPF_TOOL_XLATED_DUMPER_H
>  
>  #define SYM_MAX_NAME	256
> +#define MODULE_MAX_NAME	64
>  
>  struct bpf_prog_linfo;
>  
>  struct kernel_sym {
>  	unsigned long address;
>  	char name[SYM_MAX_NAME];
> +	char module[MODULE_MAX_NAME];
>  };
>  
>  struct dump_data {


