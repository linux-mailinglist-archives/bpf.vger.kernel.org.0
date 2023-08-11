Return-Path: <bpf+bounces-7522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E6778761
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 08:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7AB281F94
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D1185B;
	Fri, 11 Aug 2023 06:22:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467FEC6
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:22:08 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8272D4F;
	Thu, 10 Aug 2023 23:22:08 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-589bcdaa8a4so6520627b3.3;
        Thu, 10 Aug 2023 23:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691734927; x=1692339727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDg7LlTpwnWl+RJycQyw1wWW7VkBhcND+Qq+Xp3OYos=;
        b=FOLmEXSpxFxnSnoTER89dZQ1GkfRLO3+Pw/ChSx+yD4/6zCz8B57PkXI1M8wcV2LdW
         HNz2KzG75jMsghPujaCnfBPE6vvCPO216SmuPa8FzDM4HN+pkeMd8SCbf1KYdtNYH4Kk
         QUOUyLj7ZrQp0KVO/NmeEg7YxCr4lL3vfe5NqqDC5cx9TFEv+O4Cd2e1SVDpHjGDgBk8
         9ct0Fcfgi9/Uvfx/gtFmnAIltxqxPc/u6Z3DMeUHj1FUXcLlwJybkmL829UK58MrDsTo
         9FPIGUjtyyWnuCgyPU1A0WM7oNYZiaZdsTwrZmnTcAfUTpWwwQN5QU7TrsDizR7xOHLh
         Kndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691734927; x=1692339727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDg7LlTpwnWl+RJycQyw1wWW7VkBhcND+Qq+Xp3OYos=;
        b=QVjjdYZQVbEycY9dnhFFPGRSbMWBcEKgN6ij1pbHgXs0vGXAil9U/qDqggfvwTJgoA
         T73q/3OlRz8Vk96fmknsUTX232QBAxrrinB2uo02aYaTIIvcGyCQNqIAGxjixsVq/zwq
         qWTmh2PDP6DNfQgZAQtdQgtg1ZlfELNJ5skY2ipSihqhgzKk08npGn5X7FAExTMYL/ku
         uql/e6yybrpv8yBcepUPTv8YMPCPLmpNNvof/npLD1B8PNoQq8wu+tRsy8XMS/1eAkd8
         ny+WcM6TW6xFmo4wCI6ZGWAKFsh2yjH8OKK+d0HeNFV5CXAajpr0MRz34hQb2vFi3s+Z
         Lj4Q==
X-Gm-Message-State: AOJu0YwxuoT/o7WIoNt434N57KSPgCFIuZlXqL3LvlV/IMVUL4+C7fMM
	qbXFshWFXUpkWs74myF37Tk=
X-Google-Smtp-Source: AGHT+IEemiBMxEzSxka3FYy9LtwcKUBiXtJEAo8VRNVLnmAXVxAbTcSeJYcw9xkpw52j8U7/4H2afA==
X-Received: by 2002:a81:8482:0:b0:577:21ff:4d47 with SMTP id u124-20020a818482000000b0057721ff4d47mr929125ywf.7.1691734927269;
        Thu, 10 Aug 2023 23:22:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:16da:9387:4176:e970? ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id f184-20020a0ddcc1000000b0058390181d16sm830063ywe.30.2023.08.10.23.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 23:22:06 -0700 (PDT)
Message-ID: <1fb5d153-7f5d-0024-92e0-8ae75a2eb7cc@gmail.com>
Date: Thu, 10 Aug 2023 23:22:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
 clm@meta.com, thinker.li@gmail.com
References: <20230810220456.521517-1-void@manifault.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230810220456.521517-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Overall, this patch make sense to me.

On 8/10/23 15:04, David Vernet wrote:
> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> define the .validate() and .update() callbacks in its corresponding
> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> in its own right to ensure that the map is unloaded if an application
> crashes. For example, with sched_ext, we want to automatically unload
> the host-wide scheduler if the application crashes. We would likely
> never support updating elements of a sched_ext struct_ops map, so we'd
> have to implement these callbacks showing that they _can't_ support
> element updates just to benefit from the basic lifetime management of
> struct_ops links.
> 
> Let's enable struct_ops maps to work with BPF_F_LINK even if they
> haven't defined these callbacks, by assuming that a struct_ops map
> element cannot be updated by default.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index eaff04eefb31..3d2fb85186a9 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -509,9 +509,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	}
>   
>   	if (st_map->map.map_flags & BPF_F_LINK) {
> -		err = st_ops->validate(kdata);
> -		if (err)
> -			goto reset_unlock;
> +		err = 0;
> +		if (st_ops->validate) {
> +			err = st_ops->validate(kdata);
> +			if (err)
> +				goto reset_unlock;
> +		}
>   		set_memory_rox((long)st_map->image, 1);
>   		/* Let bpf_link handle registration & unregistration.
>   		 *
> @@ -663,9 +666,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	if (attr->value_size != vt->size)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->update))
> -		return ERR_PTR(-EOPNOTSUPP);
> -
>   	t = st_ops->type;
>   
>   	st_map_size = sizeof(*st_map) +
> @@ -838,6 +838,11 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>   		goto err_out;
>   	}
>   
> +	if (!st_map->st_ops->update) {
> +		err = -EOPNOTSUPP;
> +		goto err_out;
> +	}
> +

We can perform this check before calling mutex_lock(), and
return -EOPNOTSUPP early.


>   	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
>   	if (err)
>   		goto err_out;

