Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6145A14F3
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbiHYO6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbiHYO6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 10:58:14 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A61B5E66;
        Thu, 25 Aug 2022 07:58:11 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11d08d7ece2so18499640fac.0;
        Thu, 25 Aug 2022 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JocMNnEiBXUEw7bov+fVPhMWeLGE8sKeXpxcOij+6G8=;
        b=mc1gYOpYDv8Y3QEu7Vh7YVIXdiXaTwCz7X/J1tfeSWKR91Q75vACKn9WwAH+upQBXO
         X2fInuxuyWPxExA819uRGlvccV+crTVGIUvMOR96sOONnmSijjnDVB3rhNGcBccrpj7E
         SZMFBZCwZPUlUr3Ptl4p//mJ1yMU6wxe8yViljiAy0RLFmXxQuHQFBnWtFxEIU1Vs+1O
         qvlDnuAKGMPuy/8VdNeZ+BLLnukVKXMo43R/x8UjnTiS6tdHTfN6fmjrO2wHsCIAsQHg
         iGAQeNUEg+H0nZ3g6Dm/FGD+RZe0GNWtTA7UKsm92Y7rMYVeARcv3E1N0nEklVdF79V5
         ksTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JocMNnEiBXUEw7bov+fVPhMWeLGE8sKeXpxcOij+6G8=;
        b=m8eGdsSjzyKvnpDTOls2wf/X7k7N1AVPJUy1jfpsTffHe0uZUokWuRLlG6GGCur10l
         CBTCa0Jdyxzfy2ThPPODi9tOWPie7jC/Md3Hf4cHKWlqqrF9OKwwzm88Lkfbym89OzVY
         JH75GF8tRR/yHi/mIm4DSLCeCA9htMkhBiSKao6InQV3qEylfliAHRwDZhLhu839bJ5C
         Z2QUU+9IBqn1z70TLrf0SzS5V0MonP9R4pm/iPrfexIkCIyAaxha/tBjtkaqP/Y/dLJX
         01U1+0JCURBw9uVDy7Aio2Aslo9SOLIXD+J2xJLJMOCnWaIbhSQvGTXdDCgdvKBUFInt
         Ws4A==
X-Gm-Message-State: ACgBeo1hxfAfzNJd9DxV9SHFLAGCuelsEcVJNDhhC920DAjALFvGDkp0
        TuL7HUiqeGjXbgESe5Y0dMo=
X-Google-Smtp-Source: AA6agR64WsA2EuS+9gM8Rg8g5ic0ddF6AgWvFuFQDxAG5nieCueld/ADlcubeaSJ6w8tsaRJHa+h3Q==
X-Received: by 2002:a05:6870:7092:b0:11d:83fe:9193 with SMTP id v18-20020a056870709200b0011d83fe9193mr6337617oae.41.1661439491010;
        Thu, 25 Aug 2022 07:58:11 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g18-20020a544f92000000b0033a11fcb23bsm4814836oiy.27.2022.08.25.07.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:58:10 -0700 (PDT)
Message-ID: <76bda5de-f165-d886-dbf9-9cdfd837cc61@gmail.com>
Date:   Thu, 25 Aug 2022 11:58:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] core: Conditionally define language encodings entries)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        Luna Jernberg <droidbittin@gmail.com>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <YwZQ0UkLsoa+6VyY@dev-arch.thelio-3990X> <YwZcuCj49wMkr18W@kernel.org>
 <YwZl9xaRplsFkWXb@kernel.org> <Ywd2zJA63QCkd3RL@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <Ywd2zJA63QCkd3RL@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 8/25/22 10:19, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 24, 2022 at 02:55:03PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Yeah, recent enough distros are all building ok, I'll try and add some
>> fallback for old distros.
>>
> 
> Ok, now it builds everywhere:
> 
> [...]
> 
> With this patch:
> 
> [...]

Builds on Arch Linux on master.

Acked-by: Martin Rodriguez Reboredo

- Martin Rodriguez Reboredo
