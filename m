Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F407050D1B2
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiDXMbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiDXMbn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 08:31:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE315CF75
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 05:28:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w16so3433439ejb.13
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fr7QosuuW9SQrebSpuK4bC7h+uibB0pyqcA/ziRBKqg=;
        b=wDqAK/awDKTxG86d2Hv/jTz4FeZaZUw01i76GmoeeKtCAf3h0SWhnrStgEtsscWK/Y
         xQ4IpplVwZJcJhfGWSGM0kfZd+r4Uiw/VJg4RjtDKi621u9T48Sk5LGSGq9IjfaLJ7pJ
         3uyOLgg/xL5KV32TYjwNY2jKSHvg54GFxbLlaC/Y+7nE+U9lvvw5IF+Z7rWChZby7dCp
         eoY8fhdXkDmr/KopIV76f+kCk/fXd0SKbx7eoZdG1bvo96RprnWgAJ79LSGD5g1kduxm
         hiWs/M+d5iK6dE4wWqcWl/doSXRrJz7YIbhUSrHvOZ/hfYDBiVeyYrfgvJYbsgx+iU6Z
         fEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fr7QosuuW9SQrebSpuK4bC7h+uibB0pyqcA/ziRBKqg=;
        b=VpfnvLFAIlUF90qQvk1FDSVzvQSCF1gvvZ1A+QgiYH6chwsx7cklZ/Q77Vq2yLiFrd
         +9WlGokHqnuopXoeVddNZ9qi2HvoXShNA99c2rwgaLsdkGe2Lh3uZJCWLk/5cEwspdbh
         X2VnUt3SaDsQyZZ//gMZIurKD3Y1H5nHirX8/elPSIm02Ays2Bz8Pc/QFeVMheNTbh3q
         VbGIExfncTJ7kAvhsPadPtJWUkqQEAbbxWwwoyXhYX8zQ+WlvAzQl2yBda0U86K5Ee+b
         albC0TqDzPBYq2HRo9FTwsqfV6s9pkjJKVBU9JAYQ8UQrI7pJZLE2nOKsLsLdYWWNNcU
         ZWew==
X-Gm-Message-State: AOAM530zhf19vLLL0uqcRastpEXHZx/zOTlni4IoP8lsGoe9ckHbt7Ka
        IIBCAIHo8Jf3eltLiDJVZADvNA==
X-Google-Smtp-Source: ABdhPJyJj411Lwp/zk86hhKPhNORe5GxM/fAa9YezBMGcJ0TrWLzbFVC5aU8st2zn1SfbMMaXbToig==
X-Received: by 2002:a17:906:7946:b0:6f0:12ee:4418 with SMTP id l6-20020a170906794600b006f012ee4418mr12110290ejo.156.1650803318166;
        Sun, 24 Apr 2022 05:28:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id jl28-20020a17090775dc00b006e05cdf3a95sm2578909ejc.163.2022.04.24.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 05:28:37 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:28:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Timothy Hayes <timothy.hayes@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: arm-spe: Fix addresses of synthesized SPE
 events
Message-ID: <20220424122831.GC978927@leoy-ThinkPad-X240s>
References: <20220421165205.117662-1-timothy.hayes@arm.com>
 <20220421165205.117662-2-timothy.hayes@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421165205.117662-2-timothy.hayes@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 05:52:03PM +0100, Timothy Hayes wrote:
> This patch corrects a bug whereby synthesized events from SPE
> samples are missing virtual addresses.
> 
> Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/arm-spe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index d2b64e3f588b..151cc38a171c 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1036,7 +1036,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
>  	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
>  			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC |
> -			    PERF_SAMPLE_WEIGHT;
> +			    PERF_SAMPLE_WEIGHT | PERF_SAMPLE_ADDR;
>  	if (spe->timeless_decoding)
>  		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
>  	else
> -- 
> 2.25.1
> 
