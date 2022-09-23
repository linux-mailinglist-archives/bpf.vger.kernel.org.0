Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A25E7983
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIWLZD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiIWLYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 07:24:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B8A137447
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 04:24:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so19899446wrp.11
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IDpRSD1Nci5iWssLH15aZt/k6nC4O8uDj1ODpGT2TC4=;
        b=G2UnVOJHl+KrXTgr+mOLpnqfp/YMjwgjeao+hNYXCxPaD6ACTJ0V7Iol7PIsWGHmUY
         ng9NTd/PSoutlBRpvWvwkFX9UUiIZVLashdPmHT1OxVW2mHcwUBudPOoId7noc4CpCWe
         +uoI/xahjVk+iwDJUPKm32brhAZH1v41iaOJH64m5zghO5pt42i92RPAwjDkUgGSWdpp
         BM9ePjtpeo6ycYcZM/ExP/hvKsGv3rljzw9svsBhMgxDQQ/VLeeMtrSu8vss50O0fj0z
         cMR210qhOyaoFnVxq/LFcpw2tNQp76JeY48DnQfSxsCK/nX1vQyj1Fbf8U2812Vurhbs
         HRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IDpRSD1Nci5iWssLH15aZt/k6nC4O8uDj1ODpGT2TC4=;
        b=rgDXaFT6uwpgXafhbbFjkqur1FBwOfB4qQ7L5Olrvtd3haK4opIsDIJqLwPT8VJJ/c
         i/qFmN3rtjE+AE2ODrNChlxRvy8Qm+2HVVc+jpbnIeh5+wUwtAEeKl5twEEhKrvulwwY
         byxEBGXZq4JGt1tIB9f5tpd80Ny+hgBkps2jvMtCuic7ruUKzkgGxrU7T7+KrOi1CGW8
         K8UyES4ZHKJ4Kbwdfxp33rocgduvRXAVuco53q5lgAQyiZPgr3RWQ0jexTNCzy2jorRa
         BB/U83SuL8I68uLLpiNpqtu0vgcXtfHg1AlB55261Pif1YMS9Gf6OK+4XsnWkyQkaPTg
         ixFQ==
X-Gm-Message-State: ACrzQf2ISPfbOq20EPB2ZF/VzIwCe1WcjnBw2/cN0QHBW6cH7/c3FzCP
        T+LOIentIPDA/ptWPsdAtwkDPg==
X-Google-Smtp-Source: AMsMyM7oKyVLttKaIt7+uU2RvlNSD5H/Pn3S+WaENedNlGXjSaLUfZg1ewQZ44wP+UQc3otUGzEB0Q==
X-Received: by 2002:a5d:5269:0:b0:22a:e5c9:7749 with SMTP id l9-20020a5d5269000000b0022ae5c97749mr4744452wrc.448.1663932236384;
        Fri, 23 Sep 2022 04:23:56 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6405000000b0022af9555669sm8446553wru.99.2022.09.23.04.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 04:23:55 -0700 (PDT)
Message-ID: <38ca290c-52ba-c099-898f-2880d5536942@isovalent.com>
Date:   Fri, 23 Sep 2022 12:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v2 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-GB
To:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
 <20220911201451.12368-7-quentin@isovalent.com>
 <00d4de2e-c7ac-7aa5-9d31-868d73af4fe2@iogearbox.net>
 <60c18ba0-6f3a-4385-8622-9db8013dee28@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <60c18ba0-6f3a-4385-8622-9db8013dee28@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong,

Tue Sep 20 2022 05:08:04 GMT+0100 (British Summer Time) ~ Yonghong Song
<yhs@fb.com>
> 
> 
> On 9/16/22 2:09 PM, Daniel Borkmann wrote:
>> On 9/11/22 10:14 PM, Quentin Monnet wrote:
>>> To disassemble instructions for JIT-ed programs, bpftool has relied on
>>> the libbfd library. This has been problematic in the past: libbfd's
>>> interface is not meant to be stable and has changed several times. For
>>> building bpftool, we have to detect how the libbfd version on the system
>>> behaves, which is why we have to handle features disassembler-four-args
>>> and disassembler-init-styled in the Makefile. When it comes to shipping
>>> bpftool, this has also caused issues with several distribution
>>> maintainers unwilling to support the feature (see for example Debian's
>>> page for binutils-dev, which ships libbfd: "Note that building Debian
>>> packages which depend on the shared libbfd is Not Allowed." [0]).
>>>
>>> For these reasons, we add support for LLVM as an alternative to libbfd
>>> for disassembling instructions of JIT-ed programs. Thanks to the
>>> preparation work in the previous commits, it's easy to add the library
>>> by passing the relevant compilation options in the Makefile, and by
>>> adding the functions for setting up the LLVM disassembler in file
>>> jit_disasm.c.
>>
>> Could you add more context around the LLVM lib? The motivation is that
>> libbfd's
>> interface is not meant to be stable and has changed several times. How
>> does this
>> look on the LLVM's library side? Also, for the 2nd part, what is
>> Debian's stance
>> related to the LLVM lib? Would be good if both is explained in the
>> commit message.
>> Right now it mainly reads 'that libbfd has all these issues, so we're
>> moving to
>> something else', so would be good to provide more context to the ready
>> why the
>> 'something else' is better than current one.
> 
> It will be good to mention that e.g., llvm development package
> (e.g., llvm-devel for fedora) is needed for bpftool build with llvm.

Right. I didn't mention it because I noticed that on my distro, llvm-dev
came as a dependency for llvm (so simply having llvm installed is enough
to ensure the development package is present too). But this may not be
the case everywhere (do you know for Fedora?), so I'll add it to the
commit log for the next version.

Thanks for the review!
Quentin

