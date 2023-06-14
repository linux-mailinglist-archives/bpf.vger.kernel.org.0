Return-Path: <bpf+bounces-2604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BBA7308C2
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 21:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE2E281570
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8111CBC;
	Wed, 14 Jun 2023 19:50:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2052EC11
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 19:50:39 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E151B2;
	Wed, 14 Jun 2023 12:50:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25e89791877so260869a91.2;
        Wed, 14 Jun 2023 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686772237; x=1689364237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gp+AR3/vLmcKpBmQRw80wRDt4ktiTGG+Gs0p9LJEj1M=;
        b=KE+FkRfXXTGlRgRRQDiDF+n9tcPoR3XGPXHNurpuijBlbjcVim2wkjKIS6lApWTwnc
         1l8eikOXUCblB49LKt846s4v+ykWC2Pi9WN3bb2o8g+X65KX0Kl5YMUdVdDUHu6eEVzN
         uF6tWpO6EAhvbbaZhBtgfDK85D0evsz83uRN74dg/1YzDye0e1fO3tDmAS8KwmuVbOtU
         Hs8fvl3YAz6hnYKzH2ySTDGvwkWJLNokZbaGPWM8Gzl4+HkZ8zq4ezu5OxiC2pgHL+bT
         WdTeJo0i3imibnRbhxpFKsDOBVEFTbS48PIp/Kn4gMcX17JVkHdPJm8aI6psJnNGWz88
         Z6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686772237; x=1689364237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gp+AR3/vLmcKpBmQRw80wRDt4ktiTGG+Gs0p9LJEj1M=;
        b=BNFKHYu9vrOIXcU0JatRBsGJbzT/Vp2Tn8Jr51DJX2JYCBht41tQoJ0IWlcg+adPl5
         satNL+pD/vgHIdPVZ66Cv7kA7gOuB5n1EDduudhtfs49x0d7WrTWcJPZXU+5Ba9ro4SI
         lCGUlmEUD65RmLOzBUCWRGQ7wx/O+FNczqRzkFNn1McmN/8wq77OhiAvOcnBh7YHZArd
         F1Vz7hYzUh9vaBHE7/CuZIFfkeVund7oGs9aQ1HW6j3a44uDyG3ARjZR4MBuZv9/UiNL
         0BR5m/I4hAKYRv4v95M/OWLpOIjiaI2qjRHt8/vb7UOjQ1XKJ8W+X/yFHWmDvQu1ax/U
         C33w==
X-Gm-Message-State: AC+VfDxmYmybX92KmM8FQtwKdxrJtzDMA6ObckPOr1lnlUIORHfwLLTX
	XNCebKQyR5+nXQw6vuyYQHRiLjrnjbM=
X-Google-Smtp-Source: ACHHUZ7+ZwrH2Nffp3z5kNDqI0XxcNAaUzM5pui3u4gcrNTXNbdB2i1Q17e1VObsABYRvA6YkdJq3w==
X-Received: by 2002:a17:90b:1c0f:b0:25b:b4c6:d13e with SMTP id oc15-20020a17090b1c0f00b0025bb4c6d13emr2189948pjb.8.1686772237423;
        Wed, 14 Jun 2023 12:50:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c68c:b00b:182a:614f? ([2620:10d:c090:500::7:1e87])
        by smtp.gmail.com with ESMTPSA id qa2-20020a17090b4fc200b002310ed024adsm13225677pjb.12.2023.06.14.12.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 12:50:36 -0700 (PDT)
Message-ID: <12b0c61d-1270-ab34-63bf-a5c389fd45bc@gmail.com>
Date: Wed, 14 Jun 2023 12:50:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tracing/probes: Fix tracepoint event with $arg* to fetch
 correct argument
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, kernel test robot <lkp@intel.com>
References: <168657113778.3038017.12245893750241701312.stgit@mhiramat.roam.corp.google.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <168657113778.3038017.12245893750241701312.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 04:58, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> To hide the first dummy 'data' argument on the tracepoint probe events,
> the BTF argument array was modified (skip the first argument for tracepoint),
> but the '$arg*' meta argument parser missed that.
> 
> Fix to increment the argument index if it is tracepoint probe. And decrement
> the index when searching the type of the argument.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   kernel/trace/trace_probe.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 473e1c43bc57..643aa3a51d5a 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -456,7 +456,10 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
>   
>   		if (name && !strcmp(name, varname)) {
>   			code->op = FETCH_OP_ARG;
> -			code->param = i;
> +			if (ctx->flags & TPARG_FL_TPOINT)
> +				code->param = i + 1;
> +			else
> +				code->param = i;
>   			return 0;
>   		}
>   	}
> @@ -470,8 +473,11 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
>   	struct btf *btf = traceprobe_get_btf();
>   	const char *typestr = NULL;
>   
> -	if (btf && ctx->params)
> +	if (btf && ctx->params) {
> +		if (ctx->flags & TPARG_FL_TPOINT)
> +			arg_idx--;
>   		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
> +	}
>   
>   	return find_fetch_type(typestr, ctx->flags);
>   }
> 
> 

I failed to apply this patch.
Would you mind to rebase this patch?


