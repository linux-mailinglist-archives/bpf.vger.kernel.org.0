Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4767AFBE
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 11:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjAYKeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 05:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAYKeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 05:34:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1877A46732
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 02:33:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m15so13378592wms.4
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 02:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mYXo/yiFQcIvPJSzYM133RK3EW7bynRG5DHexKVbUE=;
        b=mdFAkUWqFkBXq1DCVsT7JvQ5uNEci2+vAs1WqxeCSAv82RW0zXGIAi48PCvt91UCS6
         3ZgCvlkTa8Dd2By6RePihi2zvzkGCvp5v+6GVNu5JiVhGgstSUR5K3pQfTc6mBErgikq
         BZhQdf0Gn8hAVhP5JbgXHkbysY1Lpw73Drvj0Lfgx4l5W+GCITHbBegB8Fdv/zE1/dgU
         IR3zOMCwdpg+s+OKx1e9JqZHHn2sqg84yfOYgziXc9s0+NRZa4gJYP+mNdRTsf6VuQlq
         NMwUCEA1j88Fm7nWP0eF5pEJcBeZg8IEjLWbdve+enSg4vODATlgu92PRbG1y0/hxoWe
         OSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mYXo/yiFQcIvPJSzYM133RK3EW7bynRG5DHexKVbUE=;
        b=5oQ2sIjSxEHQ1Jlkj5CFrgV2mIozjuFg7pze5DRmWNMfPEe3kZBI/N4Yce92cN1g74
         YQ3o/LnnST+jgk9TsH/icx5rup8XdjBQW68Br/gBHEJZUg+CHudpJE/JpY8EgG31cJtS
         XaFMnEHMrevzGaJ5vkPbVRVkGNzqvzzvZT+dfO2CsRARus4TulSDfPnkZQc4oh4DXjaw
         rBMPp2jm8d3kD9rjuXR95uP4nPUsiNHrkIKUS+kk6Ewqh6VVwacJJ35geAcU6c3zZP9t
         i2/V0Gxuh5yLimSD3vLQAU8aKlW+1MniHJ7K127ltTiZVGxRxHwG8ev+bj1DYx2aWVFp
         f1ww==
X-Gm-Message-State: AFqh2kqLDTpM+EZFV3nv05gypdYuT/6OQglcABFlks2NFNUjGRdHPNXA
        cU9aReCBZ2tGRA66VwMbM//tGg==
X-Google-Smtp-Source: AMrXdXtGbElNOBelxSMW6tbXG0mUX/UpS5uFX7ZV+Syby23iwQtOXW1cdH4jbk9rVGY02QHx/JxUBw==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:efe8:a42d with SMTP id p14-20020a05600c1d8e00b003d9efe8a42dmr31034736wms.21.1674642834534;
        Wed, 25 Jan 2023 02:33:54 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:85d2:c19b:f082:8fe6? ([2a02:8011:e80c:0:85d2:c19b:f082:8fe6])
        by smtp.gmail.com with ESMTPSA id h24-20020a05600c499800b003dc1a525f22sm1394575wmp.25.2023.01.25.02.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:33:54 -0800 (PST)
Message-ID: <2e84c348-c07d-8028-d099-a73bcfba4a09@isovalent.com>
Date:   Wed, 25 Jan 2023 10:33:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next] bpftool: disable bpfilter kernel config checks
Content-Language: en-GB
To:     Chethan Suresh <chethan.suresh@sony.com>, bpf@vger.kernel.org
Cc:     Kenta Tada <Kenta.Tada@sony.com>, Quentin Deslandes <qde@naccy.de>
References: <20230125025516.5603-1-chethan.suresh@sony.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230125025516.5603-1-chethan.suresh@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-25 08:25 UTC+0530 ~ Chethan Suresh <chethan.suresh@sony.com>
> We've experienced similar issues about bpfilter like below:
> https://github.com/moby/moby/issues/43755
> https://lore.kernel.org/bpf/CAADnVQJ5MxGkq=ng214aYoH-NmZ1gjoS=ZTY1eU-Fag4RwZjdg@mail.gmail.com/
> 
> Considering the current development status of bpfilter,
> disable bpfilter kernel config checks in bpftool feature.
> For production system, we should disable both
> CONFIG_BPFILTER and CONFIG_BPFILTER_UMH for now.
> Or can be enabled as some tools depend on bpfilter.
> 
> Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  tools/bpf/bpftool/feature.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 36cf0f1517c9..c6087bbc6613 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -426,10 +426,6 @@ static void probe_kernel_image_config(const char *define_prefix)
>  		{ "CONFIG_BPF_STREAM_PARSER", },
>  		/* xt_bpf module for passing BPF programs to netfilter  */
>  		{ "CONFIG_NETFILTER_XT_MATCH_BPF", },
> -		/* bpfilter back-end for iptables */
> -		{ "CONFIG_BPFILTER", },
> -		/* bpftilter module with "user mode helper" */
> -		{ "CONFIG_BPFILTER_UMH", },
>  
>  		/* test_bpf module for BPF tests */
>  		{ "CONFIG_TEST_BPF", },

Hi,
I don't understand. The feature probe simply looks for the kconfig
option in the kconfig file. What are you hoping to achieve by removing
this check? How is it going to help with your issues?

Quentin
