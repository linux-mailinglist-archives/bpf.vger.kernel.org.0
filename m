Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73404EF7F6
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiDAQeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349039AbiDAQdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 12:33:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0C32A1EBF
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 09:05:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so3583527wms.1
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sjfwJQGdgK4o6lp5qgare8KfoLw0OxKyARMv1JLsw+s=;
        b=eMI5L4xnBQmxhQ7cT4ChcsSBYTztKqAiSNKMIlYjhkWBrAbWxwY1zl+P2d+kHGnWCh
         V4hTzYzKBA8crL7lJ+ke9bSOAEWypV9yLe1slPBw0CJnL8oXLrvVHVepIjazSUNyVxCn
         M6GH4m6drXzVf2iNIT06ur/RTL5Xl9OmUGNa1cQAKcRGVmfARMaa3IK/y7YZbdwIZtcy
         +7B8hpC5ZTV5F7rHfcMkWpWsV75A339xTk89/T9J6eqLhip4CvFzcw1I81ZPGzq0csp4
         nJYl+C4aGqiqaDKGCrIXJ5rpg2e+5kFJR7io2DNciSYpJK0ng6Ic2WGN85kIfXGdJt59
         DftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sjfwJQGdgK4o6lp5qgare8KfoLw0OxKyARMv1JLsw+s=;
        b=sYDdmsCKG09EM+N9Y8aAfGyCT5IcAtNp+WbfXEmNoYRsNUI8DRNnmLAzxZI5yMSx1J
         Ei6VPZqdfgPpvtfXRlF4hVqMYxJMxj+4lecIws5pGmq7+McCta9L06RWr1cUJlg1hzF0
         yk+bOx+rDlfAdHGL/7h3uvhdWAWfPhSDs8IPLOd0jDEuaC/+ZoNDTq8ZVG1H3JsaSkrO
         p/QiEc+9DOnwK+EYydG5KwWdVwM4frr7qb71x4F+McEC7xd6B5d7wEZlP0e5iPbc1yKl
         YYXK7j/EPnKdx3J3H5c4n1NuksLaKVMZMd51a76g6vyLCn0Hwj04IaJsFkdt1co1brUE
         V9/g==
X-Gm-Message-State: AOAM530WCzVDcF1+kFKVIaF78Rm9x8oIs0LSdVL3LOtC5eleV3HAaH1O
        3dPtRbSbPFMvYe/+y4+0FvxgMQ==
X-Google-Smtp-Source: ABdhPJx+lm62SiIUpPeMCMBfhVARpAvnAuoK+9DB1KYT4WBwBGPOgKFeFh4IFjf3SAW2luc8hCKnFQ==
X-Received: by 2002:a1c:f70a:0:b0:37c:533d:d296 with SMTP id v10-20020a1cf70a000000b0037c533dd296mr9057296wmh.147.1648829104298;
        Fri, 01 Apr 2022 09:05:04 -0700 (PDT)
Received: from [192.168.178.8] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm3071247wrd.31.2022.04.01.09.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 09:05:03 -0700 (PDT)
Message-ID: <4612c72e-0256-0c99-c2b1-92e93a4c4416@isovalent.com>
Date:   Fri, 1 Apr 2022 17:05:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH bpf-next 2/3] bpf/bpftool: add missing link types
Content-Language: en-GB
To:     Milan Landaverde <milan@mdaverde.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        davemarchevsky@fb.com, sdf@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220331154555.422506-1-milan@mdaverde.com>
 <20220331154555.422506-3-milan@mdaverde.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220331154555.422506-3-milan@mdaverde.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-03-31 11:45 UTC-0400 ~ Milan Landaverde <milan@mdaverde.com>
> Will display the link type names in bpftool link show output
> 
> Signed-off-by: Milan Landaverde <milan@mdaverde.com>
> ---
>  tools/bpf/bpftool/link.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 97dec81950e5..9392ef390828 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -20,6 +20,8 @@ static const char * const link_type_name[] = {
>  	[BPF_LINK_TYPE_CGROUP]			= "cgroup",
>  	[BPF_LINK_TYPE_ITER]			= "iter",
>  	[BPF_LINK_TYPE_NETNS]			= "netns",
> +	[BPF_LINK_TYPE_XDP]				= "xdp",
> +	[BPF_LINK_TYPE_PERF_EVENT]		= "perf_event",

Since this goes into bpf-next, we should add BPF_LINK_TYPE_KPROBE_MULTI
as well.

Quentin
