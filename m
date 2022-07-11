Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580E456FA29
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiGKJOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 05:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiGKJNc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 05:13:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52F131343
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 02:09:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so6092147wrd.13
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/pcnRIW/7DqaI74csNZqWulO2lEfzvHKuul41w0X/MQ=;
        b=kpVg4zLg3RvS3hG6clwutcm4uZNNQg3sCT6+dhUteIOSxNXj6p6FHvsI6YXYy63riW
         6M8K1qikTHuAlRmZOSMWtlYl2b7RmXevdywTfiRKWC2r9DtfoUfiOMec9orQA2OvU8N6
         PciTMcdVD1UNXJvm+E6Md0RB/zSB863oEaKYOx+ycxyYK+aZnQ0W4YuovTX77QVxi8dp
         bOJ7j17UHDQOxhIzj/bNsjSFmCSIY8F7b27fBd2E23v3L4hKS7nOEhEuw843PelHWJdo
         ctqgj4lCe0GeiPABXmticCX8G0hSRcFzLLFTm1owlUpzSMCuCgIJ5fp/8luNhuHcMlWw
         WMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/pcnRIW/7DqaI74csNZqWulO2lEfzvHKuul41w0X/MQ=;
        b=V37epcvQlcmc9tDjLd7emXd/HfWtG3OPBfvDaJ1kspGpR4GE/2x/uRTW8sY1U2DqCX
         IGQFVQbQt4CNJdd3b9ODwF+/znB64OvO+l1NLWQRWNE8PpZnLUxsaqempQktUqIMN8TZ
         gNaEX9Dc9pThiZhPlsCZYF3D+4pUvfrNRt/Nzj6KupQzZDqzG32hUcKBo9xXRezd6ACY
         tsz6jnMzUj1Qi3hpzZ9I04f2YwBTAAGeHtN83advSt2BtRYeokRGEv+sX/42fGar30Jk
         ZNZBwgdQftmMo0No6W/H+6DlbHBMKH+yplgXHetFsB/MLjHvJhF6qD9OGxlgszc7gjaP
         2nmQ==
X-Gm-Message-State: AJIora/fN6FH48Ls+XrFyqWBLwvdPJOOsXDrLG4VCi/pmq7EEjAmvP50
        +jANeIPRsOwKVn2hfJTSz0Cgbw==
X-Google-Smtp-Source: AGRyM1u1PBtHuK7lC4YINOhrs2EufYD57+WVbtMH8VMuDDNuwMv1e1Eid5TCKq0v90BO0KqqFxcR4Q==
X-Received: by 2002:a05:6000:186e:b0:21d:ac3c:a066 with SMTP id d14-20020a056000186e00b0021dac3ca066mr1233102wri.57.1657530584199;
        Mon, 11 Jul 2022 02:09:44 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b003a02b135747sm6060414wmf.46.2022.07.11.02.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 02:09:43 -0700 (PDT)
Message-ID: <4e6d7f63-11a9-bf55-2dc2-465b16ac48e0@isovalent.com>
Date:   Mon, 11 Jul 2022 10:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: libbfd feature autodetection
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Hao Luo <haoluo@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <aa98e9e1a7f440779d509046021d0c1c@huawei.com>
 <CA+khW7i39MXy4aTFCGeu+85Shyd47A+0w5EAA5qL7v+n4S74dA@mail.gmail.com>
 <6f501b451d4a4f3882ee9aa662964310@huawei.com>
 <ae8feec0-3c0f-d4f4-64e9-588df2d02d24@isovalent.com>
 <CAEf4BzbPdXgDiTTpw1F79ym=k=Y6GS8EoW_Vtgu30Lv9PaV4kg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzbPdXgDiTTpw1F79ym=k=Y6GS8EoW_Vtgu30Lv9PaV4kg@mail.gmail.com>
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

On 06/07/2022 06:14, Andrii Nakryiko wrote:
> On Tue, Jul 5, 2022 at 7:46 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> On 01/07/2022 08:10, Roberto Sassu wrote:
>>>> From: Hao Luo [mailto:haoluo@google.com]
>>>> Sent: Thursday, June 30, 2022 7:29 PM
>>>> Hi Roberto,
>>>>
>>>> On Thu, Jun 30, 2022 at 6:55 AM Roberto Sassu <roberto.sassu@huawei.com>
>>>> wrote:
>>>>>
>>>>> Hi everyone
>>>>>
>>>>> I'm testing a modified version of bpftool with the CI.
>>>>>
>>>>> Unfortunately, it does not work due to autodetection
>>>>> of libbfd in the build environment, but not in the virtual
>>>>> machine that actually executes the tests.
>>>>>
>>>>> What the proper solution should be?
>>>>
>>>> Can you elaborate by not working? do you mean bpftool doesn't build?
>>>> or bpftool builds, but doesn't behave as you expect when it runs. On
>>>> my side, when I built bpftool, libbfd was not detected, but I can
>>>> still bpftool successfully.
>>>
>>> Hi Hao
>>>
>>> in Github Actions, the build environment has support for
>>> libbfd. When bpftool is compiled, libbfd is linked to it.
>>>
>>> However, the run-time environment is different, is an ad hoc
>>> image made by the eBPF maintainers, which does not have
>>> libbfd.
>>>
>>> When a test executes bpftool, I get the following message:
>>>
>>> 2022-06-28T16:15:14.8548432Z ./bpftool_nobootstrap: error while loading shared libraries: libbfd-2.34-system.so: cannot open shared object file: No such file or directory
>>>
>>> I solved with this:
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index e32a28fe8bc1..d44f4d34f046 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -242,7 +242,9 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
>>>                   OUTPUT=$(HOST_BUILD_DIR)/bpftool/                          \
>>>                   LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/                    \
>>>                   LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/                        \
>>> -                 prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
>>> +                 prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin           \
>>> +                 FEATURE_TESTS='disassembler-four-args zlib libcap clang-bpf-co-re'  \
>>
>> (disassembler-four-args can probably be removed too, the file using it
>> shouldn't be compiled if libbfd support if not present.)
>>
>>> +                 FEATURE_DISPLAY='disassembler-four-args zlib libcap clang-bpf-co-re'
>>>
>>> but I'm not sure it is the right approach.
>>
>> Hi Roberto,
>>
>> I don't think we have another solution for intentionally disabling
>> bpftool's feature at build time at the moment. For the context: I
>> submitted a patch last week to do just this [0], but in the end we
>> preferred to avoid encouraging distributions to remove features.
>>
>> But I agree it's not ideal. We shouldn't have to pass all existing
>> bpftool's features to the selftests Makefile.
>>
>> Daniel, what would you think of an alternative approach: instead of
>> having variables with obvious names like BPFTOOL_FEATURE_NO_LIBCAP, we
>> could maybe have a FEATURE_IGNORE in bpftool's Makefile and filter out
>> its contents from FEATURE_TESTS/FEATURE_DISPLAY before running the
>> tests? Given that features can already be edited as in the above patch,
>> it wouldn't change much what we can do but would be cleaner here?
>>
> 
> Is statically linking all such dependencies into bpftool an option? If
> build environment has libbfd, we compile and statically link against
> it. Then no matter what environment bpftool runs in, we have libbfd
> inside.

This is a different approach, but as long as static linking is made
optional, this would be fine by me and should address the current use case.

Quentin


