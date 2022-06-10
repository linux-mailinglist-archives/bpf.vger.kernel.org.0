Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1E9546957
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiFJPYS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiFJPYQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 11:24:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD18635B
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 08:24:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x17so36982966wrg.6
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zdnlR199A5rHfHQzkHqSQo1rmxRTA9oX0cSemBZ61Po=;
        b=A3YbFwjHa11/tMWATopSLeHWGMYPWZ5Yhir/6dD1yEEmMpPgrTLuc51jszOu/Vz53y
         o8H2DbQbyu34J0aDr/riTUW30o65MQvQD9ajZ3iamglpJ/eCf5jS2tPsnrRpmD/UQ5z6
         D5Xaow1zg2n3ysVn51fUF98/bIeoHG7iIIheg4gCUdNP+L4sp8T6WYPECfNciKVNlp68
         auHKYr007xlHHLSiHqUw1KLiyGfuK3P9Kz/2UuUA6u/PsTKuLjdCdqPhrWwQobMWLQ7P
         tA1/vJFAgscZgeFUjjHZUsgGc02CxJS5kgnflJeUJAS4nr6AZTLzgQvCdp7VJdVhmH7A
         K0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zdnlR199A5rHfHQzkHqSQo1rmxRTA9oX0cSemBZ61Po=;
        b=gWg2xNY1STWuNYU8JZesKig691Pe/d+UgFuHwCQLNmLr8T1zgVToK6pM8fAB19zUKZ
         sSnYNrsyMDARh3EW6YvJIpKZUdd/eFXZ3mkhLMvC979sgTfqbTEInh9PcCUNBF4FufGc
         +rnw9yhqLQzn+FEV84KOIpVnYvPdC5Be1/J720YZiPC+ndXe5Mi0SxjAPX+r/ZnZ4r/6
         QVOnM87e7NRm0aS7pJi2JfEZ/N27ZWi2mfuAW1LbmqdoV7DunqjZTK5DNLpgxW7xMOjU
         0GaoX4hifE7pS3eoHMhRJNtCDqFPKlo6zgJRGcFQJqSteYhEPa4JsmmcE1ZDgt1I+X2R
         tBAQ==
X-Gm-Message-State: AOAM531txiWB+DD9/2fkaDtst6EfeppFuGjQz070NYmMV1Ef+UjkMWKJ
        SYUCrNWR+mO6Ag+w12D58h3rMg==
X-Google-Smtp-Source: ABdhPJwEFNd2LK9f14APy/YJRQucj+r1WjPYCSCSY7uEEzuqMf+QKCGRFRdEfif8/k51JNSLGlJbww==
X-Received: by 2002:adf:fec3:0:b0:216:ea3d:b118 with SMTP id q3-20020adffec3000000b00216ea3db118mr33407915wrs.517.1654874652480;
        Fri, 10 Jun 2022 08:24:12 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5588000000b00219e4ebf549sm2672399wrv.56.2022.06.10.08.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 08:24:12 -0700 (PDT)
Message-ID: <b1a604e1-be09-ac0b-ff22-b194ae9ce886@isovalent.com>
Date:   Fri, 10 Jun 2022 16:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Building release 6.8.0 on Debian 11
Content-Language: en-GB
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexander Lobakin <alobakin@pm.me>
References: <c47f732d-dba8-2c13-7c72-3a651bf72353@synopsys.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <c47f732d-dba8-2c13-7c72-3a651bf72353@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-06-10 11:28 UTC+0000 ~ Shahab Vahedi <Shahab.Vahedi@synopsys.com>
> Hi,
> 
> This email is in the form of an inquiry and not a bug report.
> 
> When I tried to build bpftool 6.8.0 on my Debian 11 (bullseye) machine it
> failed with errors like:
> 
> -----------------------------------8<-----------------------------------
> $ make
>   .
>   .
>   .
>   CLANG    pid_iter.bpf.o
> skeleton/pid_iter.bpf.c:47:14: error: incomplete definition of type
>                                'struct bpf_perf_link'
>         perf_link = container_of(link, struct bpf_perf_link, link);
>   .
>   .
>   .
> skeleton/pid_iter.bpf.c:49:30: error: no member named 'bpf_cookie' in
>                                'struct perf_event'
>         return BPF_CORE_READ(event, bpf_cookie);
>   .
>   .
>   .
> 10 errors generated.
> make: *** [Makefile:176: pid_iter.bpf.o] Error 1
> 
> ----------------------------------->8-----------------------------------
> 
> This happens because in the generated vmlinux.h from my 5.10 kernel there is
> no relevant types regarding the bpf_cookies.
> 
> Release v6.7.0 builds fine because it doesn't have this commit [1]. That
> leaves me with the following questions:
> 
> - Should I stick to v6.7.0?
> - Maybe I could use a version of 6.8.0 that reverts the commit [1]?
> - Should the newly added bpf cookie section be guarded somehow?
> 
> [1] bpftool: Add bpf_cookie to link output
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=cbdaf71f
> 
> 
> Cheers,
> Shahab

Hi Shahab,

I think we want to guard that section in the skeleton indeed. There was
a patch submitted for that purpose some time ago (motivated by the fact
this struct can also be missing on new kernels, if CONFIG_PERF_EVENTS is
not enabled in the kernel config) [0].

Alexander (+Cc): Hi, are you still working on this series?

[0] https://lore.kernel.org/bpf/20220421003152.339542-3-alobakin@pm.me/T/#u

Quentin
