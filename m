Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6314EB8A4
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 05:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbiC3DEt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 23:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbiC3DEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 23:04:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD518178C
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 20:03:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso794707pju.2
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 20:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9nK00agkTwms47JLzR1zYa0HYmrkeM8LOfaQkUwZOYo=;
        b=OJBkpghQ5wnhGkR7tn7wipb0HWWldRGzKrivCO2ifZEjpELfUJVyfwy9YtiJa8M5MV
         /El/emMLWX8SpFkbjsr20bKPZyQYWWSH0mapGND6DsGS394RovtFTEZCzd60IYI4MkbC
         kpvnZMkj55v3Nkn0XGUCaf6guA5ClTRVHgHQdbDux92aW8kwshkWzTBmFPqiDC7O64K5
         SgjAncaEnqGYrBkvyC0vdFDEu+oFixYY/Y9Y/o/cWrmJfZFDh2Cpq0WQaRU7zuHxjR1J
         qpCImCZz/fIM0dgir2akqgV2Dgo8bz6H/XVYrl/OoxXzAEyj7tNrChcpYhE4t9mHyq2W
         OLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9nK00agkTwms47JLzR1zYa0HYmrkeM8LOfaQkUwZOYo=;
        b=0ZoJUqKGNHViVQ+I8Cu7VUsfKVMJd4YxISl69k5hWVWFmC2TGswH/XGLnbVPCLH+88
         d52JcbjnTLkt0Cbi8E7iEHo80G1o/OUhEfjSrfqCIVgDBM4zUN9uWIiCKQGmHf8jN/09
         ZL+wAskYaGoOvoYCe4foQHGYRv4+cK+RObb+HIxBZUW5JzGG2PfXaN6E1MdFNHDicb3m
         mjfe4SzeKjylM6XjZDqw0oiDGqW8HWBT/Io7iYTnKsyAEpFR6jdg1mFkjDylLV9x6cbU
         ql4R4Eiuel9YSheZ1n22ZnGNb030C1WSUb8+c7b01GrK/KJMg7/FUhpYMPFeqAolNWak
         GmQw==
X-Gm-Message-State: AOAM530GcG3K8mAxnG9jLsMzujHy5BSERTDQkZ6E1OsKIGZgOMs4YR0Y
        a0kbfJLDXY0G7CjhSg3q1M3d9a54UiCy7g==
X-Google-Smtp-Source: ABdhPJw5vCP1fRhNzv7micLcExw1a6lsahu+1OABz2rljdhnHnlaXUburqLED710zv0hP1k/TaRJCQ==
X-Received: by 2002:a17:902:c242:b0:154:4f3f:ec6a with SMTP id 2-20020a170902c24200b001544f3fec6amr32722881plg.121.1648609384175;
        Tue, 29 Mar 2022 20:03:04 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.110])
        by smtp.gmail.com with ESMTPSA id gk13-20020a17090b118d00b001c6b2472576sm4330871pjb.19.2022.03.29.20.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 20:03:03 -0700 (PDT)
Message-ID: <9c3aece7-84d1-9fd6-76f0-acb2dd9597a9@gmail.com>
Date:   Wed, 30 Mar 2022 11:03:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs
 interface
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20220326144320.560939-1-hengqi.chen@gmail.com>
 <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com>
 <5d5a7f05-6c96-49db-6c3f-ae3ca713059a@gmail.com>
 <CAEf4BzYBzOEDgE+KH9jgUu89=GT7GeMNXx3Rwek4La5wKZZ-AQ@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4BzYBzOEDgE+KH9jgUu89=GT7GeMNXx3Rwek4La5wKZZ-AQ@mail.gmail.com>
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



On 2022/3/30 10:50 AM, Andrii Nakryiko wrote:
> On Tue, Mar 29, 2022 at 7:30 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Hello, Andrii
>>
>> On 2022/3/30 7:18 AM, Andrii Nakryiko wrote:
>>> On Sat, Mar 26, 2022 at 7:43 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>
>>>> On some old kernels, kprobe auto-attach may fail when attach to symbols
>>>> like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
>>>> but don't allow attach to a symbol with '.' ([0]). Add a new option to
>>>> bpf_kprobe_opts to allow using the legacy kprobe attach directly.
>>>> This way, users can use bpf_program__attach_kprobe_opts in a dedicated
>>>> custom sec handler to handle such case.
>>>>
>>>>   [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343
>>>>
>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>> ---
>>>
>>> It's sad, but it makes sense. But, let's have a selftests that
>>> validates uses legacy option explicitly (e.g., in
>>> prog_tests/attach_probe.c). Also, let's fix this limitation in the
>>
>> OK, will add a selftest to exercise the new option.
>>
>>> kernel? It makes no sense to limit attaching to a proper kallsym
>>> symbol.
>>
>> This limitation is lifted in newer kernel. Kernel v5.4 don't have this issue.
> 
> Oh, ok. So how about another plan of attack then: if kprobe target
> function has '.' *and* we are on the kernel that doesn't support that,
> switch to legacy kprobe automatically? No need for a new option,
> libbpf handles this transparently.
> 

That's better, and also eliminate the need for custom SEC() handler.

> Still need a test for kprobe with '.' in it, though not sure how
> reliable that will be... We can use kallsyms cache to check if
> expected xxx.isra.0 (or whatever) is present, and if not - skip
> subtest?
> 

Not sure how to do that. Even if such symbol exists, how to reliably
trigger it is another problem.

>>
>>>
>>>>  tools/lib/bpf/libbpf.c | 9 ++++++++-
>>>>  tools/lib/bpf/libbpf.h | 4 +++-
>>>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>
>>> [...]
>>
>> --
>> Hengqi
