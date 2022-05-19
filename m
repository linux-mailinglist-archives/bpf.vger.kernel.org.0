Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43652D21F
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiESMLA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbiESMKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 08:10:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162C26E9
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 05:10:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k30so6883482wrd.5
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c1ZlHTWlfR4lEgmlniS7VG1lMCqc2EIDrFO7TCMTxfY=;
        b=BpoafXMhTbjp1eKU++xjRN0rb38xiKw90r9nn3HJfS3/zkHBlDzkX1u5boNTbXo/wF
         rJiViAiLCZjDwgALqY2tRr4W/m2X7wQDnyFX0XF2Y4XLDLjc1LhCqAFF1fc7U931PVS5
         FkSRkNP1JmsvGtQ598aVEA+pJeq/nfxjl3x1XuqO+UNs00ZhB7kjMIL9PAGUqP7uHFOt
         93dHi3uNNP/64tgPjUnnedwtJaqEKHeIuD5nR3yuCGOojWaqBxThfShgWyJs7C9L43GJ
         6fcd0+3LPJLwo7r4NtksF0USGlrpqzRpLAgPVQ7QvPfq6p1r4yp0XXj3gNp5orBn2vUL
         TqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c1ZlHTWlfR4lEgmlniS7VG1lMCqc2EIDrFO7TCMTxfY=;
        b=ZBzbAAWS40TpCTi50bcZ2Be1kKVGl2rM5qqJ78O/GIz1RdwA7VlOcv7YQ/75/xSD/l
         MSAvGDofmJclBL0lx0P8E9npZjE/hgM4U8L/ur5QP7rdknWE2O0nyC1j31JXn06agc7F
         7hlXj6B6wm9aPylAupOUF2vWP8s7yWxfCQEy/0PV1fbEzpHPlgm9aK2dkCvqmzBMnrVb
         uDSkl7A8GbsaNujm4UBmKsEiGhWjq9pcU3q9AcDGdF6dDmx9PKXTWHt9B4HvYeJ9ccXN
         b2MU1Y2ZZMcZJwjDx516I4lJtJaz7ToI+cj31V7hCFxUr6RNlKe/G9j7u+8cXzOFyRKv
         hQZQ==
X-Gm-Message-State: AOAM532v44a+wWiyL7nIrNKPqCHKgf8BnrD+vhXbBxrWYILTJJ/OqQuU
        243ezqsVPUiKTsdwlq5cAyVIaw==
X-Google-Smtp-Source: ABdhPJxNJf6XBZNO3eG7/0Lq4PEl8AD9nuTpKoNPLyePloek9ZKAtcy+B3qVYRiwxE7D0Y05+UHv8g==
X-Received: by 2002:adf:dbce:0:b0:20c:f507:8ef9 with SMTP id e14-20020adfdbce000000b0020cf5078ef9mr3799150wrj.29.1652962243741;
        Thu, 19 May 2022 05:10:43 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c231600b003944821105esm3986329wmo.2.2022.05.19.05.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:10:43 -0700 (PDT)
Message-ID: <b90f2bc7-6405-7eaa-ef54-ebdf031a72b0@isovalent.com>
Date:   Thu, 19 May 2022 13:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: bpf selftest compiling error
Content-Language: en-GB
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAK3+h2zMMMir6_ut=fb7gGj0Merzsc9vksG3fmt9JazCvk2=WA@mail.gmail.com>
 <CAK3+h2z74LZ5OFQxNDktex8WYxpYhycQxaWt=KqqW3ZsTu1nwg@mail.gmail.com>
 <YoUIAFPYea86JvDx@syu-laptop> <YoX97QJ976GelRw6@myrica>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <YoX97QJ976GelRw6@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-19 09:21 UTC+0100 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> Hi,
> 
> On Wed, May 18, 2022 at 10:51:44PM +0800, Shung-Hsi Yu wrote:
>> On Thu, May 12, 2022 at 06:12:36PM -0700, Vincent Li wrote:
>>> On Thu, May 12, 2022 at 5:49 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I cloned the bpf-next and tried to compile the bpf selftest.
>>>>
>>>> first I got error
>>>>
>>>> "
>>>> CC      /usr/src/bpf
>>>> next/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
>>>>
>>>> make[1]: *** No rule to make target
>>>> '/usr/src/bpf-next/tools/include/asm-generic/bitops/find.h', needed by
>>>> '/usr/src/bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o'.
>>>> Stop.
>>
>> I also ran into the same issue on bpf-next, and the error seems rather
>> absurd as
>>
>>   1. asm-generic/bitops/find.h was removed back in 47d8c15615c0a "include:
>>      move find.h from asm_generic to linux", so perhaps this error has
>>      something to do with Makefile.asm-generic
>>   2. normal way of building bpftool with `make tools/bpf/bpftool` still
>>      works fine
>>
>> Anyway removing ARCH= CROSS_COMPILE= in the bpf selftests Makefile
>> (reverting change added in ea79020a2d9e "selftests/bpf: Enable
>> cross-building with clang") can be used as a workaround to get the build
>> working again. Adding the commit author to the thread to see if there is
>> better approach available.
> 
> Could you share the commands that lead to this error?  And did you make
> sure to clean the build tree?  I often get errors when building tools
> because my toolchains changed and some dependencies in generated .*.d
> files do not exist anymore.
> 
> I can't reproduce this specific error on today's linux-next (but found
> another issue with out-of-tree build that I'll investigate). This is what
> I run, on an x86 host for an x86 target:
> 
>  $ make defconfig
>  $ cat tools/testing/selftests/bpf/config >> .config
>    # and enable CONFIG_DEBUG_INFO_BTF
>  $ make
>  $ make -C tools/testing/selftests TARGETS=bpf SKIP_TARGETS=
> 
> Thanks,
> Jean

Hi, for what it's worth I also observed the same today in samples/bpf;
but after "make clean" the issue disappeared, and I can't reproduce it
anymore.

Quentin
