Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C835E5A8869
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 23:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiHaVu6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiHaVu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 17:50:56 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00066E6886;
        Wed, 31 Aug 2022 14:50:55 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m5so11911481qkk.1;
        Wed, 31 Aug 2022 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vOy+aMqhVVgkaFdcKPS9BO6pUN7ZgzHkeevfPR3xgF8=;
        b=moMlIKwBR5qnYuq9/hV5tNMraORsTiT1tQ/JJRfZM7uOBVm1j61bYK7YcjRSU9nGqw
         qZEYIjKDHn1l3GLGwQ42OJYivWEw9ifn2fCgYAzflrlLSCtCL+agQ0tw2sI+CYh4zk27
         QWjf4S75dInJz9H1m+vaF3805hHNeUVxkhi8BuFMApCREwmjGgAdgysFN1x7X+HCb/jL
         9Ur3FrvcPYhrC9/7l1O9s7MwiY+tBV3nBp66dzq/Ofr/jEbLjqnKn6GgVYBngdX2T60m
         k7XSKxcN2Y8Ftngs1IKD/Hy6Az/YeUamOFrPZeDUEPOS11Ce5XP+yr1MzVKEfUm+qCZ+
         UaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vOy+aMqhVVgkaFdcKPS9BO6pUN7ZgzHkeevfPR3xgF8=;
        b=vdPK5PTVggoGB0y8XEWQcKAL+fSJCAp7t9Xyqcq7PFYSa4STv1w3YxaR6CRAIa74uV
         WGXq5q2rfDPIRcUE8g53Ep4+E9LzxgAUPIRBosN0K+FIogGA9T7VWnKOEVh1kM0e9pNa
         faCn7x5DeWrxHMaCjP8ah8eooy5b7hgEwROLMEgqPpJt4UOOZJVAi77F7qmkpPcKDozE
         YKnXlLPgDwNGigsDkmjtuN1D7urcmrZClGpoPIcNbX0tQA6S70QV0tSby1KwFM+9yZlb
         F9Pxgi0PwIGWiHCkBFZNFQcYIWe6qJ9WzHs8E8a2vRis2NKOEUeWCLis9uishmvQNZQ6
         VIUg==
X-Gm-Message-State: ACgBeo2HyqUoRMS4f4AmlOi2nqGdK3Dv4OSUYzc5Uun+6BKQwEiHlKgr
        xBLWaw5lt2fvBsxp4ESYM0A=
X-Google-Smtp-Source: AA6agR5geD3j89IRsqLWukwG9AJmINLMZD/jIMiSMIrcF9dGTHQwDO1QvOnnST9XHmsotiUKXfC2Xw==
X-Received: by 2002:a37:a811:0:b0:6ba:bc14:18ff with SMTP id r17-20020a37a811000000b006babc1418ffmr17077658qke.173.1661982655028;
        Wed, 31 Aug 2022 14:50:55 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id bx4-20020a05622a090400b00342fcdc2d46sm9180494qtb.56.2022.08.31.14.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 14:50:53 -0700 (PDT)
Message-ID: <1d5510f7-7c2d-6e30-f5d9-e45c470c380a@gmail.com>
Date:   Wed, 31 Aug 2022 14:50:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] libbpf: Initialize err in probe_map_create
Content-Language: en-US
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davemarchevsky@fb.com, linux-kernel@vger.kernel.org
References: <20220801025109.1206633-1-f.fainelli@gmail.com>
 <165964981402.20332.403823292048774488.git-patchwork-notify@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <165964981402.20332.403823292048774488.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/4/2022 2:50 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
> 
> On Sun, 31 Jul 2022 19:51:09 -0700 you wrote:
>> GCC-11 warns about the possibly unitialized err variable in
>> probe_map_create:
>>
>> libbpf_probes.c: In function 'probe_map_create':
>> libbpf_probes.c:361:38: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>    361 |                 return fd < 0 && err == exp_err ? 1 : 0;
>>        |                                  ~~~~^~~~~~~~~~
>>
>> [...]
> 
> Here is the summary with links:
>    - libbpf: Initialize err in probe_map_create
>      https://git.kernel.org/bpf/bpf-next/c/3045f42a6432
> 
> You are awesome, thank you!

Thanks for applying, I was sort of expecting this patch to land to Linus 
a bit quicker, as far as I can see it is still only in linux-next yet it 
does fix a build warning turned error. Any chance of fast tracking it?

Thanks!
-- 
Florian
