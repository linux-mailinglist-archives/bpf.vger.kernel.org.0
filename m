Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5862D5A86C6
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 21:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiHaTcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiHaTcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 15:32:05 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D223B78237
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 12:32:02 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTTRM-000Ch9-PW; Wed, 31 Aug 2022 21:31:56 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTTRM-000VIn-Il; Wed, 31 Aug 2022 21:31:56 +0200
Subject: Re: [PATCH bpf-next v2 4/4] LoongArch: Enable BPF_JIT and TEST_BPF in
 default config
To:     Xi Ruoyao <xry111@xry111.site>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
References: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn>
 <1661857809-10828-5-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H6Dq+Z_kS0LcM=QGF1h=k2i0hR7fYZdXgU2kXAfm1VPLw@mail.gmail.com>
 <6bc9bd64-1ba9-a35f-c0b7-480429b26b9f@loongson.cn>
 <75b27dacb8b4d779c6b2c0e46871baf404a32b6b.camel@xry111.site>
 <e477e042aee090d6c3cf7ebeabed25df5b0fa07e.camel@xry111.site>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d0188f86-33ba-50ce-3761-882528796057@iogearbox.net>
Date:   Wed, 31 Aug 2022 21:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e477e042aee090d6c3cf7ebeabed25df5b0fa07e.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26644/Wed Aug 31 09:53:02 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/22 11:02 AM, Xi Ruoyao wrote:
> On Wed, 2022-08-31 at 12:12 +0800, Xi Ruoyao wrote:
>> On Wed, 2022-08-31 at 09:23 +0800, Tiezhu Yang wrote:
>>>
>>>
>>> On 08/30/2022 10:46 PM, Huacai Chen wrote:
>>>> Hi, Tiezhu,
>>>>
>>>> On Tue, Aug 30, 2022 at 7:10 PM Tiezhu Yang
>>>> <yangtiezhu@loongson.cn> wrote:
>>>>>
>>>>> For now, BPF JIT for LoongArch is supported, update
>>>>> loongson3_defconfig to
>>>>> enable BPF_JIT to allow the kernel to generate native code when
>>>>> a program
>>>>> is loaded into the kernel, and also enable TEST_BPF to test BPF
>>>>> JIT.
>>>>>
>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>> ---
>>>>>   arch/loongarch/configs/loongson3_defconfig | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/arch/loongarch/configs/loongson3_defconfig
>>>>> b/arch/loongarch/configs/loongson3_defconfig
>>>>> index 3712552..93dc072 100644
>>>>> --- a/arch/loongarch/configs/loongson3_defconfig
>>>>> +++ b/arch/loongarch/configs/loongson3_defconfig
>>>>> @@ -4,6 +4,7 @@ CONFIG_POSIX_MQUEUE=y
>>>>>   CONFIG_NO_HZ=y
>>>>>   CONFIG_HIGH_RES_TIMERS=y
>>>>>   CONFIG_BPF_SYSCALL=y
>>>>> +CONFIG_BPF_JIT=y
>>>>>   CONFIG_PREEMPT=y
>>>>>   CONFIG_BSD_PROCESS_ACCT=y
>>>>>   CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>> @@ -801,3 +802,4 @@ CONFIG_MAGIC_SYSRQ=y
>>>>>   CONFIG_SCHEDSTATS=y
>>>>>   # CONFIG_DEBUG_PREEMPT is not set
>>>>>   # CONFIG_FTRACE is not set
>>>>> +CONFIG_TEST_BPF=m
>>>> I don't want the test module be built by default, but I don't
>>>> insist
>>>> if you have a strong requirement.
>>>>
>>>
>>> Hi Huacai,
>>>
>>> It is useful to enable TEST_BPF in default config, otherwise we
>>> need to use "make menuconfig" to select it manually if we want
>>> to test bpf jit, and build it as a module by default has no side
>>> effect, so I prefer to enable TEST_BPF in default config.
>>
>> IMO we shouldn't enable a test feature which is never used by 99% of
>> users in the default.
> 
> P. S. this is not a strong option.  CONFIG_TEST_BPF seems enabled by
> default for S390, and I'm not sure if defconfig is designed for "kernel
> developers" or "distro builders", or even "normal users".

Right now BPF CI [0] tests x86_64 and s390x archs, would be nice to also
add others in future to increase test coverage and then include test_bpf
as part of the executed test suites. If noone beats me to it, the latter
still sits in my bucket list. But either way, that would make more sense
than adding CONFIG_TEST_BPF to defconfig. Looks like for odd reasons m68k
and s390x has it, it shouldn't be there, really.

Thanks,
Daniel

   [0] https://github.com/kernel-patches/bpf/pulls
