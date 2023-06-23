Return-Path: <bpf+bounces-3292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6773BD20
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E204281CAE
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D24AD3F;
	Fri, 23 Jun 2023 16:49:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7D8C13
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:49:09 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0D3584
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:48:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3112f2b9625so931501f8f.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687538929; x=1690130929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=em8e/YdhU6uGDSaxJVcqLoWFsW+6uVuPv5+TwUmAu9Q=;
        b=ZpQOsUe0EGOAhpfXlLwq9xAiz1yWkubYRPrNtXLwc3NWChQvsEPU1IrDFAwfXmVCgj
         j0dfPf0zausQCBd5OT5KUNg+XDus6AmbbmyQx80IPl4btZxt92ifswli6f7TXkLw3edP
         XyAeQM2te5yM5wlY5TnVMROtdUKfCLDZQ0GHoyxcTiUdbpRFy7MzOv8hQJ/pjPUXhvU0
         rRF1Y2CQv2o9N1uJIqqGbAQnOh0n76RyldkmYIyqMtvqUlSL3dEvlTbbZHrf88YgTfSC
         w73/A8OVyZehxyGdQY6BEXhfcaR+Yk5vj863YXdEXKhaproJK9PR+ldWE+DF6rYsV/Tu
         8vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538929; x=1690130929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em8e/YdhU6uGDSaxJVcqLoWFsW+6uVuPv5+TwUmAu9Q=;
        b=Q8c9GZ2NxDHRVBBIGaSomYUrjv2/9TV8ivVM5Oe1HgEduUs/IMUzLkYAdlP3Q626pL
         49mD430H+4Nc0khr67DOnRZWT3cz6ry+rZ9uO9rp9z/eJ3gyf2k36s5ItdHSo1m1NkZo
         2LkpSHJFADpnEfUhXSlB4ApMAc5aZn78Jbnb5R9Yi23XZJ7s9mHFDL6zzdJglnmfKidM
         DY3fVF9+axwJuOzvK/eMshneVMsFBLUmH+IvFHDQE/t1Gber4aDto4YavKlpWrm/IBiP
         b5giWltXti3yG2gVJlS3n7tDFwlfG0c7qFiIQXJ5Mx+/cxXDAWm5QLfs2HwoBHUT4xYd
         09WQ==
X-Gm-Message-State: AC+VfDx04yASj8+4hRHMTx9gqjxpcvkXnxYR01+T0dRrV+Es+QLxkHvj
	Jt2gu5M2xEZQOxYBbwrKmUPNYA==
X-Google-Smtp-Source: ACHHUZ6FI5xT6Fucht1rSOdcV0HV0pBx4JEy4L1XUgEdYiFBYWHdoi0tA8nGnK+IEZbcvdRgCRqopg==
X-Received: by 2002:a5d:43c2:0:b0:311:1cd8:b97a with SMTP id v2-20020a5d43c2000000b003111cd8b97amr4447081wrr.47.1687538929236;
        Fri, 23 Jun 2023 09:48:49 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cb8:f81f:3342:3b44? ([2a02:8011:e80c:0:9cb8:f81f:3342:3b44])
        by smtp.gmail.com with ESMTPSA id j18-20020adff012000000b0030e56a9ff25sm9985240wro.31.2023.06.23.09.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:48:49 -0700 (PDT)
Message-ID: <a2835797-a0da-2c7f-5494-2edb820146e0@isovalent.com>
Date: Fri, 23 Jun 2023 17:48:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 bpf-next 02/11] bpftool: Dump the kernel symbol's
 module name
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230623141546.3751-1-laoar.shao@gmail.com>
 <20230623141546.3751-3-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230623141546.3751-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-23 14:15 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> If the kernel symbol is in a module, we will dump the module name as
> well. The square brackets around the module name are trimmed.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
>  tools/bpf/bpftool/xlated_dumper.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index da608e1..567f56d 100644
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
>  			continue;
>  		sym->address = (unsigned long)address;
>  		if (!strcmp(sym->name, "__bpf_call_base")) {
> diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
> index 9a94637..db3ba067 100644
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

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

