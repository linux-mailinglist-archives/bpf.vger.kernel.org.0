Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5F4EDA98
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiCaNgH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiCaNgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 09:36:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D1CA0F0
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 06:34:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c23so23449577plo.0
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lZhwepnxAc/yh4rF8zP4EM/wwbRWgt9IV08R1qU0KbU=;
        b=KnVY2b45B7S89cTPbT2OFJkdlQ15sCswj4m0wSOVCcmcVwbx4pjTANApoQULiS4gIY
         r3aPeqyiIs+G/vPvAhXmDUbtNtPPiyJghxLKV3wsnCKgx2Se7Y2dMMAUjG2kj1qNxA9w
         PSoFMIHCNI/8cL944bZUqjQiSF0xl4UwSb0ortU2noqVlCMWtA8Cg1vnRegDo7bjIOk9
         Yx0hiDmlqFVkjq1T21ZqtvStI7eLaVi0ohJs21oHst28wKSu54hZ+BTpFOyyzIOi20vq
         E0RfVTPzFk0z+XKVf+jkqEU6bsWH8ZCfudp6Zeo6pl2jer/b1SpSPQNNKtrQVKmoUGv+
         USbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lZhwepnxAc/yh4rF8zP4EM/wwbRWgt9IV08R1qU0KbU=;
        b=vANHRC80zHqzO6NS+XVGls6AG7KDPBtS+0WKQ6d3IaW5EvUZDjHPUDQojD/5QE5qLE
         4XSMu3n7aNRK3Xf4/y7bjqNvS2OOuYjPKzax3ckKroxC7AUBs8V+dLuIUWMx6c6LNMIF
         IO1F6S0G7QMJpVUcJH9zAQk3B06GEqBjxaBcuGu+Fdj7SWvQVEQOmlaNMOaPpPx9qqmf
         DGi+Y05aKIHJcNGpcYxuvM+VzA7bILwfV8R5KF7Yqv4iltgPH/D7Rzclm2ZH/3RPS/3K
         Xy5Ei51Non2122WBlYmiAqHify1Z4/GQuz5K3m35jkuWGc/wy7gq3TMuTqnb/SQAmm2W
         jEZQ==
X-Gm-Message-State: AOAM532e9kj5RP27P5mCAdgzsp7XZ9kjNQcLPk2sGYYcNPzOLNpZttXo
        c/8aEjcIqSnSnDqrmOmPBzk=
X-Google-Smtp-Source: ABdhPJwrvKTIH15KcmS/kfusnOJTyM1emuum3i8t2gvWmjBh7bcecAbscH9ZUJC9AeD21hbrXC+1Mw==
X-Received: by 2002:a17:902:da90:b0:154:4737:a3f with SMTP id j16-20020a170902da9000b0015447370a3fmr5044802plx.73.1648733658592;
        Thu, 31 Mar 2022 06:34:18 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.119])
        by smtp.gmail.com with ESMTPSA id i7-20020a628707000000b004fa6eb33b02sm26541191pfe.49.2022.03.31.06.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:34:18 -0700 (PDT)
Message-ID: <49d07e4b-35de-1a55-425c-7669fa4f0877@gmail.com>
Date:   Thu, 31 Mar 2022 21:34:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs
 interface
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20220326144320.560939-1-hengqi.chen@gmail.com>
 <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com>
 <5d5a7f05-6c96-49db-6c3f-ae3ca713059a@gmail.com>
 <CAEf4BzYBzOEDgE+KH9jgUu89=GT7GeMNXx3Rwek4La5wKZZ-AQ@mail.gmail.com>
 <9c3aece7-84d1-9fd6-76f0-acb2dd9597a9@gmail.com>
 <alpine.LRH.2.23.451.2203311006110.28122@MyRouter>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <alpine.LRH.2.23.451.2203311006110.28122@MyRouter>
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

Hello, Alan

On 2022/3/31 5:27 PM, Alan Maguire wrote:
> On Wed, 30 Mar 2022, Hengqi Chen wrote:
> 
>>
>>
>> On 2022/3/30 10:50 AM, Andrii Nakryiko wrote:
>>> On Tue, Mar 29, 2022 at 7:30 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>
>>>> Hello, Andrii
>>>>
>>>> On 2022/3/30 7:18 AM, Andrii Nakryiko wrote:
>>>>> On Sat, Mar 26, 2022 at 7:43 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>>>
>>>>>> On some old kernels, kprobe auto-attach may fail when attach to symbols
>>>>>> like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
>>>>>> but don't allow attach to a symbol with '.' ([0]). Add a new option to
>>>>>> bpf_kprobe_opts to allow using the legacy kprobe attach directly.
>>>>>> This way, users can use bpf_program__attach_kprobe_opts in a dedicated
>>>>>> custom sec handler to handle such case.
>>>>>>
>>>>>>   [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343
>>>>>>
>>>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>>>> ---
>>>>>
>>>>> It's sad, but it makes sense. But, let's have a selftests that
>>>>> validates uses legacy option explicitly (e.g., in
>>>>> prog_tests/attach_probe.c). Also, let's fix this limitation in the
>>>>
>>>> OK, will add a selftest to exercise the new option.
>>>>
>>>>> kernel? It makes no sense to limit attaching to a proper kallsym
>>>>> symbol.
>>>>
>>>> This limitation is lifted in newer kernel. Kernel v5.4 don't have this issue.
>>>
>>> Oh, ok. So how about another plan of attack then: if kprobe target
>>> function has '.' *and* we are on the kernel that doesn't support that,
>>> switch to legacy kprobe automatically? No need for a new option,
>>> libbpf handles this transparently.
>>>
>>
>> That's better, and also eliminate the need for custom SEC() handler.
>>
>>> Still need a test for kprobe with '.' in it, though not sure how
>>> reliable that will be... We can use kallsyms cache to check if
>>> expected xxx.isra.0 (or whatever) is present, and if not - skip
>>> subtest?
>>>
>>
>> Not sure how to do that. Even if such symbol exists, how to reliably
>> trigger it is another problem.
>>
> 
> could we add a function to bpf testmod that is easily triggered
> and likely to be .isra-ed maybe?
> 
> Experimenting, the following function becomes .isra-ed at when 
> compiled with -fipa-sra:
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c 
> b/tools/testing/selftests/bpf/bpf
> index e585e1c..bb51e21 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -88,6 +88,17 @@ __weak noinline struct file *bpf_testmod_return_ptr(int 
> arg)
>         }
>  }
>  
> +struct testisra {
> +       int val1;
> +       int val2;
> +       int val3;
> +};
> +
> +static noinline void bpf_testmod_test_isra(struct testisra *t, int val1, 
> int val2)
> +{
> +       t->val3 = val1 + val2;
> +}
> +
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>                       struct bin_attribute *bin_attr,
> @@ -98,8 +109,14 @@ __weak noinline struct file 
> *bpf_testmod_return_ptr(int arg)
>                 .off = off,
>                 .len = len,
>         };
> +       struct testisra t = {
> +               .val1 = off,
> +               .val2 = len
> +       };
>         int i = 1;
>  
> +       bpf_testmod_test_isra(&t, t.val1, t.val2);
> +
>         while (bpf_testmod_return_ptr(i))
>                 i++;
> 
> 
> Tested on gcc 9; possibly different results on different versions..
>  
> Alan

Thanks for the pointer, will give it a try.

Hengqi
