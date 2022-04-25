Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0041350EAE9
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbiDYVEY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiDYVEY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 17:04:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4991167C4;
        Mon, 25 Apr 2022 14:01:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso309877wml.1;
        Mon, 25 Apr 2022 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F0Wqha00tJlONZuaPT+kIQeQKt6+cyUurVU3OwL9MQ8=;
        b=Cox9LyVwKYukwokad9zF3+dkLCkrBEMLcFoiTsgL3EcV2ue6iyY2KSSJl0MZMVTm5W
         iTf1akXBASsM/m1o4cDefkTymgrUsu4kg0bcB70ohCuQzxdP60/DWaoXmAz9paRizmV2
         7fIyk097aNIAkatUVyhiaE6tJNANsM/fYYEHCAALSJBCgOrJXLifFGYj2uGlQWSbHxI7
         fN1MypHnLdh7S9vAri+LfJ37kduF71FJ7FFjhto6pXt583zVY3ye+kpU1XsLFJUPmb8h
         A1fhiOnqY+2ZoLUGufeY4MYUOGljoTjRPPjeZHTEiFtq95812LpX7IMBFXiyZAVs0Acj
         L73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F0Wqha00tJlONZuaPT+kIQeQKt6+cyUurVU3OwL9MQ8=;
        b=4vR1hNA9gcUdO79EzMv6CpsIzZZ/7nCvcjHjzFbWyfCI2h35Tdte6XGrJ7ns7bgMdj
         t1BfBepsZoRkK7jRjY95H98FKkxcbqd7ff9/FySamW9znyhRVTUUqu+DN2eF4ebDXTRW
         A7cuoCmT0zuEa6ASl5eBBXvDnwNHaW0H8FYAzb+KXj1TZfCUO2TTVM8ItuICUWo81aSW
         vg0vrA+51gk9MbV0vNS3qE2xx5dG0yFv1gL/7uJNWPPGsVmRiDFd4XcWdODSiE8mZSM6
         NMClyqyP2jcZCktx41hM2cLSDsBtDA8CZptGB7r0TTY71qIilYBsdROBDWMA56ZS8ua/
         rNOg==
X-Gm-Message-State: AOAM530WiPA9HSynneH0RxU/iFGXelAIi7BvpagpkWai9O4GNzVLDGF/
        SKVPEvJcWbvbuP0KwmDQ3uQ=
X-Google-Smtp-Source: ABdhPJyN+qjSO23iBiSRTCicfMm9+inXCycFjx6L88fyJtPxu99EfrcvJewaw6pSqSPd+yNZ9eANRg==
X-Received: by 2002:a1c:ac44:0:b0:38e:a7df:3179 with SMTP id v65-20020a1cac44000000b0038ea7df3179mr18634853wme.61.1650920477587;
        Mon, 25 Apr 2022 14:01:17 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id b2-20020adfc742000000b0020ac89e4241sm10732022wrh.31.2022.04.25.14.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 14:01:17 -0700 (PDT)
Message-ID: <31702ffb-380f-69f9-ab87-3aec5b22537c@gmail.com>
Date:   Mon, 25 Apr 2022 23:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] bpf.2: Note that unused fields and padding in bpf_attr
 must be zero
Content-Language: en-US
To:     Jakub Sitnicki <jakub@cloudflare.com>, linux-man@vger.kernel.org
Cc:     bpf@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220425160803.114851-1-jakub@cloudflare.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220425160803.114851-1-jakub@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jakub,

On 4/25/22 18:08, Jakub Sitnicki wrote:
> In a discussion regarding a potential backward incompatible change [1],
> Andrii Nakryiko points out that unused bytes of bpf_attr should be
> zero. Add this bit of information to the bpf(2) man page.
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzbT4vQBnZzdD00SuPCDkeb4Cm=F6PLUoO_3X93UQD5hbQ@mail.gmail.com/
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Patch applied.

Thanks,

Alex

> ---
>   man2/bpf.2 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man2/bpf.2 b/man2/bpf.2
> index 2d257eaa6..ee57226ee 100644
> --- a/man2/bpf.2
> +++ b/man2/bpf.2
> @@ -142,7 +142,7 @@ provided via
>   .IR attr ,
>   which is a pointer to a union of type
>   .I bpf_attr
> -(see below).
> +(see below). The unused fields and padding must be zeroed out before the call.

But I changed it to add a separate line, instead of continuation in the 
same one.

>   The
>   .I size
>   argument is the size of the union pointed to by
