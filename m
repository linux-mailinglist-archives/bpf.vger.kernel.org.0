Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFA67F119
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjA0W26 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 17:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA0W26 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 17:28:58 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F146C8625F
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 14:28:56 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso2652624oti.10
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 14:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S33WhhJQVH2vCdhHjXsrPKqM+2GoXIv4S8eaY/tzSHs=;
        b=nwEvdjbcohvV2a9PAN587HqL+kJi7VYoR7PsXjM8XH8dOtKklqEBfoI7DYMQJWBPPr
         4/eTV+4JA3Pq7opLQoyXu+/OveFhdCCfygSv6LT9s2IsFQauIUowTPnIkpe10UZZgTHC
         YudcChHiLaug3iShy0QuovJXzuYOP3cqoalBZ03SOOsSfdI+tidpiRoqEQD4/DBWRtv2
         lo/COEPAu2AGAFmnx8FuaQ/mHNIU3dwYZe2kCprBIMXJlhsKWdRYluH4z/0k3LfGU/OO
         fIQuRym5EPC0RfZFG6uPDM95y4fvdj3cMC0e9rhfrVlik6ZYFtpvKZmCE189/l63bani
         dqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S33WhhJQVH2vCdhHjXsrPKqM+2GoXIv4S8eaY/tzSHs=;
        b=HciVjbq+BWpAhJdW/sDDUnuILwdnZNRNESSP/dR5ZN1svApkePy00c3TweQeu9LmYi
         TBMjRVJAuHaThBkaBZUJTkNp1GNiyIom4VulOxfNfXDpuAcBHsc1df/5Sc2iX8uwM6ln
         0tvy3022hbgAWRzQZdGhS87m+4T0D1OLJK9GwugTGZZjHv3JffKqt7Wu53aTu8gyqOUW
         I+tCGWkn8r+d49Yo2McEjPnMX1Dgi1Cv2TpIwlOBoQ2dVhYz3yJariUjUboJ9/AeoxRW
         ZZds6TO3MrhVCz5+zveoQWdjgh9NhATeoB0hnsSRnBUsxJBp3K/wdchUDlT9NIOabfYP
         tELA==
X-Gm-Message-State: AO0yUKV5Jg/bJ9UriGLnbLKFWkSRubgcl6zLKOoJZD0G8LBDwJIjY58X
        0hMtHwi6bqewKvU4ZrbFOPA=
X-Google-Smtp-Source: AK7set9kf4NCNkToCDnp3OqO9vXbe7ljP4NgPrKhTEtoIdh+FGtgkZHw+PZ8rV+ZP4SIo6WOQG/dWQ==
X-Received: by 2002:a05:6830:9c2:b0:68b:b07c:2103 with SMTP id y2-20020a05683009c200b0068bb07c2103mr1225338ott.26.1674858536196;
        Fri, 27 Jan 2023 14:28:56 -0800 (PST)
Received: from ?IPV6:2603:8080:2800:f9bf:eb7:f10d:ceda:48f6? (2603-8080-2800-f9bf-0eb7-f10d-ceda-48f6.res6.spectrum.com. [2603:8080:2800:f9bf:eb7:f10d:ceda:48f6])
        by smtp.gmail.com with ESMTPSA id l1-20020a9d7341000000b0068663820588sm2355772otk.44.2023.01.27.14.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:28:55 -0800 (PST)
Message-ID: <bb569967-d33a-7252-964b-a36501b3366a@gmail.com>
Date:   Fri, 27 Jan 2023 16:28:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Content-Language: en-US
To:     Daniel Xu <dxu@dxuuu.xyz>, Jiri Olsa <olsajiri@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
From:   Alexandre Peixoto Ferreira <alexandref75@gmail.com>
In-Reply-To: <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/24/23 00:13, Daniel Xu wrote:
> Hi Jiri,
>
> On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
>> On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>>> Hi,
>>>
>>> I'm getting the following error during build:
>>>
>>>          $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>>>          [...]
>>>            BTF     .btf.vmlinux.bin.o
>>>          btf_encoder__encode: btf__dedup failed!
>>>          Failed to encode BTF
>>>            LD      .tmp_vmlinux.kallsyms1
>>>            NM      .tmp_vmlinux.kallsyms1.syms
>>>            KSYMS   .tmp_vmlinux.kallsyms1.S
>>>            AS      .tmp_vmlinux.kallsyms1.S
>>>            LD      .tmp_vmlinux.kallsyms2
>>>            NM      .tmp_vmlinux.kallsyms2.syms
>>>            KSYMS   .tmp_vmlinux.kallsyms2.S
>>>            AS      .tmp_vmlinux.kallsyms2.S
>>>            LD      .tmp_vmlinux.kallsyms3
>>>            NM      .tmp_vmlinux.kallsyms3.syms
>>>            KSYMS   .tmp_vmlinux.kallsyms3.S
>>>            AS      .tmp_vmlinux.kallsyms3.S
>>>            LD      vmlinux
>>>            BTFIDS  vmlinux
>>>          FAILED: load BTF from vmlinux: No such file or directory
>>>          make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>>          make[1]: *** Deleting file 'vmlinux'
>>>          make: *** [Makefile:1264: vmlinux] Error 2
>>>
>>> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>>> (2241ab53cb).
>>>
>>> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>>> upstream pahole on master (02d67c5176) and upstream pahole on
>>> next (2ca56f4c6f659).
>>>
>>> Of the above 6 combinations, I think I've tried all of them (maybe
>>> missing 1 or 2).
>>>
>>> Looks like GCC got updated recently on my machine, so perhaps
>>> it's related?
>>>
>>>          CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>>>
>>> I'll try some debugging, but just wanted to report it first.
>> hi,
>> I can't reproduce that.. can you reproduce it outside vmtest.sh?
>>
>> there will be lot of output with patch below, but could contain
>> some more error output
> Thanks for the hints. Doing a regular build outside of vmtest.sh
> seems to work ok. So maybe it's a difference in the build config.
>
> I'll put a little more time into debugging to see if it goes anywhere.
> But I'll have to get back to the regularly scheduled programming
> soon.
6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but 
fails in pahole when CONFIG_X86_KERNEL_IBT is set.

Thanks,

-- 
Alexandre Peixoto Ferreira

