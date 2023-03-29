Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229AC6CD6C9
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjC2Jqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjC2Jqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 05:46:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2819B
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 02:46:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso1751932wmo.1
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680083194;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFnqQQZqqqvt4Jl0EXjSsKHNNVCFZyaVGyDhontWDGs=;
        b=TBXHQB5u+/iZ6JiUQHStsiwQFwqpJc/PfVgwXY64TC+7wsl2P+XnYKpg67iU0Ajabz
         02u1m8je6FjvwUIY3TK7UQH7P8PvFkpX+K696BraS8JqnKk3ahZyqt5PQm0QeXCuokI8
         X3AruW1Ng6z/G7aC/Pjbf2BOkqa2VLn7dA3cEkDeDbYNobxrJ10xc43sEvV7YWNhYne/
         A5bkkaI+pHLZWaK8VfiOe2G6zmQtkHcazvEBkqcjX3DRAQeCOAk09q/B895S1C2253fF
         i8YZlAXr1q1OxchGMuGyJabPy8/TpPt9iwLZm26yTCa/BpzimOdrQglqCprb4zUTL5tW
         Fhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083194;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFnqQQZqqqvt4Jl0EXjSsKHNNVCFZyaVGyDhontWDGs=;
        b=df7sc7rJeq+ydPHorS3LN+LHs7GQzdAWwTbQ3dN0rYX7dnT4TX/JhemfHlPRRwjgbC
         mnLGyMgiU0Uzz4PDuLDvgDqJdLClt26mWBigywQtn40u4XwRIJDONJkf2xNPKA/n2kOi
         16aR5PEgzON8aEO64h5Igs8iAIs0APTdg8RdNuknc6cxAF6BZtNx4ocTmXJ/npyHE0+X
         ritoBtC0LYdIsAye8YMweoCnoa3Ffux4Egbcj6n1U7DdFjSyPalM8lpFqbRs/YzBtTyv
         Odjh7JZgnG44Jr5JRiiCDUxNAQGj1kImd7blkJRhNo39XLbuHMGQGNjIXcgrpx5qKD28
         ymJA==
X-Gm-Message-State: AO0yUKXaXhQYIFb7dK4HPPbWrMZZrSNT61VJzbCUHK0f9eqhEkKc6vWL
        1YY2MCEAmmIGL7CDQgeZ+9CEyA==
X-Google-Smtp-Source: AK7set/8m6eF3EPK1HuT2aLMxIvkNe/Q4SEMnkGCKHtyshenTP3hfChKz4nB+3ZQtC3D0xj9y8mhWQ==
X-Received: by 2002:a7b:c7ce:0:b0:3ed:8360:e54 with SMTP id z14-20020a7bc7ce000000b003ed83600e54mr14808184wmk.8.1680083194323;
        Wed, 29 Mar 2023 02:46:34 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:2dbc:f491:d2fe:828e? ([2a02:8011:e80c:0:2dbc:f491:d2fe:828e])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c22cf00b003edff838723sm1640620wmg.3.2023.03.29.02.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 02:46:34 -0700 (PDT)
Message-ID: <4b65f781-351d-2f47-17ae-e042d8ee2f08@isovalent.com>
Date:   Wed, 29 Mar 2023 10:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] tools: bpftool: json: fix backslash escape typo in
 jsonw_puts
Content-Language: en-GB
To:     Manu Bretelle <chantr4@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
References: <20230329073002.2026563-1-chantr4@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230329073002.2026563-1-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-03-29 00:30 UTC-0700 ~ Manu Bretelle <chantr4@gmail.com>
> This is essentially a backport of iproute2's
> commit ed54f76484b5 ("json: fix backslash escape typo in jsonw_puts")
> 
> Also added the stdio.h include in json_writer.h to be able to compile
> and run the json_writer test as used below).
> 
> Before this fix:
> 
> $ gcc -D notused -D TEST -I../../include -o json_writer  json_writer.c
> json_writer.h
> $ ./json_writer
> {
>     "Vyatta": {
>         "url": "http://vyatta.com",
>         "downloads": 2000000,
>         "stock": 8.16,
>         "ARGV": [],
>         "empty": [],
>         "NIL": {},
>         "my_null": null,
>         "special chars": [
>             "slash": "/",
>             "newline": "\n",
>             "tab": "\t",
>             "ff": "\f",
>             "quote": "\"",
>             "tick": "'",
>             "backslash": "\n"
>         ]
>     }
> }
> 
> After:
> 
> $ gcc -D notused -D TEST -I../../include -o json_writer  json_writer.c
> json_writer.h
> $ ./json_writer
> {
>     "Vyatta": {
>         "url": "http://vyatta.com",
>         "downloads": 2000000,
>         "stock": 8.16,
>         "ARGV": [],
>         "empty": [],
>         "NIL": {},
>         "my_null": null,
>         "special chars": [
>             "slash": "/",
>             "newline": "\n",
>             "tab": "\t",
>             "ff": "\f",
>             "quote": "\"",
>             "tick": "'",
>             "backslash": "\\"
>         ]
>     }
> }
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!

