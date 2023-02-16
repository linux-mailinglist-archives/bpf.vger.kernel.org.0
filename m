Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16791698EF2
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBPIrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 03:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBPIrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 03:47:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B908138B6C
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 00:47:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r28so616579wra.5
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlUNRxM8S8gi/BdDzeX/+Eq/CsQesfLN0ayoMKaZyAk=;
        b=HFy7pD8VGpJ7C/FKnZTZrs2vSiUzVXJ3QMDVlI42Rb/9oaX1MiqYFI1VtY+tJZAvys
         /KOnl+pVI/Q/s9awZEqoJsvPzw4Mwvn8YLZ8iwprh3wiprh/tf0CW2IOIw9crsnRMkzU
         XZRdptNZb7pw28q7PkmIvrvTn38aOivbg8GgS2ZD4reqYhoK+ljtBkGXTeaQXIP/0Cp4
         MhfhGkcX4VB0ljxFBlLMbrqQmqLvqVLtYXinqaFug/bUaUhRYpkVlBsO+9T7U96G4hdB
         3y7D/0pdyPGVolMB6rK2kTXSTmEd3udEq/D7XFnRZbTn7Uhe2hq/0k9TVtDQq9bkBR9G
         43+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlUNRxM8S8gi/BdDzeX/+Eq/CsQesfLN0ayoMKaZyAk=;
        b=fbWtRtr5ZtfrhzMRRvNX31LtmviZhMDyMi5ltsWYqe4MQQ+JkCM/iaYDY0674KiZ8z
         cM/GfsVXX87Bg0KGkXW4xw5+i/jhFP50Brxtc7XKP0npSe9uTTSIW0BLyTsJe0H2ZI3S
         YVebKVCzFDbep8ZLvJuEoARZiaNml/eRtlgUNaAj6hZZqbXKiqy352I4lWM5MM51uUA1
         RvRfwWAgOO1Fdm8kSDyUwPTckHZP6Fk4MVdb7IFESDKrvRcaakoyTGk3v30SqWhtRsbV
         sQc1uONntNxoYrGBqw8maxMvj+epDa+qwsx4WYbsDUOHJTGIB3wviXEZZrhluduvzbE7
         BZRA==
X-Gm-Message-State: AO0yUKVMAsMbITwwaNj2kM+rvh8sfv3jl/xznhIFn5JJRqH62BI56PxI
        fwM1TgulHiVxSSOzMYjpjqe6VbGvllb0lNpt
X-Google-Smtp-Source: AK7set9GQwPQZuwLW/ewYlVOv8L1Q9baQ56aZs5RMbASMF0GbcD2E+7F5Ud7zPWKKfbIX9BaCE2R2w==
X-Received: by 2002:a5d:6a10:0:b0:2c5:8c56:42d3 with SMTP id m16-20020a5d6a10000000b002c58c5642d3mr545794wru.23.1676537225086;
        Thu, 16 Feb 2023 00:47:05 -0800 (PST)
Received: from krava ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id h17-20020a056000001100b002c54c8e70b1sm916785wrx.9.2023.02.16.00.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 00:47:04 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 16 Feb 2023 09:47:02 +0100
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Vernet <void@manifault.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next v2] bpf: Only allocate one bpf_mem_cache for
 bpf_cpumask_ma
Message-ID: <Y+3thjLs1RwxaqfT@krava>
References: <20230216024821.2202916-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216024821.2202916-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 10:48:21AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The size of bpf_cpumask is fixed, so there is no need to allocate many
> bpf_mem_caches for bpf_cpumask_ma, just one bpf_mem_cache is enough.
> Also add comments for bpf_mem_alloc_init() in bpf_mem_alloc.h to prevent
> future miuse.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> v2: fix typo (forget to regenerate the patch after testing)
> v1: https://lore.kernel.org/bpf/7736864d-af8d-4f74-086b-0ec125aae2a6@huawei.com/T/#t

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  include/linux/bpf_mem_alloc.h | 7 +++++++
>  kernel/bpf/cpumask.c          | 6 +++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> index 3e164b8efaa9..a7104af61ab4 100644
> --- a/include/linux/bpf_mem_alloc.h
> +++ b/include/linux/bpf_mem_alloc.h
> @@ -14,6 +14,13 @@ struct bpf_mem_alloc {
>  	struct work_struct work;
>  };
>  
> +/* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
> + * Alloc and free are done with bpf_mem_cache_{alloc,free}().
> + *
> + * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
> + * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
> + * the returned object is given by the size argument of bpf_mem_alloc().
> + */
>  int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
>  void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
>  
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 52b981512a35..2b3fbbfebdc5 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -55,7 +55,7 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
>  	/* cpumask must be the first element so struct bpf_cpumask be cast to struct cpumask. */
>  	BUILD_BUG_ON(offsetof(struct bpf_cpumask, cpumask) != 0);
>  
> -	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
> +	cpumask = bpf_mem_cache_alloc(&bpf_cpumask_ma);
>  	if (!cpumask)
>  		return NULL;
>  
> @@ -123,7 +123,7 @@ __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
>  
>  	if (refcount_dec_and_test(&cpumask->usage)) {
>  		migrate_disable();
> -		bpf_mem_free(&bpf_cpumask_ma, cpumask);
> +		bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
>  		migrate_enable();
>  	}
>  }
> @@ -468,7 +468,7 @@ static int __init cpumask_kfunc_init(void)
>  		},
>  	};
>  
> -	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, 0, false);
> +	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
>  	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
> -- 
> 2.29.2
> 
