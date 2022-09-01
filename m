Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5365A8ABC
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 03:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIABbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIABbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 21:31:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 190B4AA4F8
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 18:31:01 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmtNCxBjvV4OAA--.51477S3;
        Thu, 01 Sep 2022 09:30:53 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 4/4] LoongArch: Enable BPF_JIT and TEST_BPF in
 default config
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>
References: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn>
 <1661857809-10828-5-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H6Dq+Z_kS0LcM=QGF1h=k2i0hR7fYZdXgU2kXAfm1VPLw@mail.gmail.com>
 <6bc9bd64-1ba9-a35f-c0b7-480429b26b9f@loongson.cn>
 <75b27dacb8b4d779c6b2c0e46871baf404a32b6b.camel@xry111.site>
 <e477e042aee090d6c3cf7ebeabed25df5b0fa07e.camel@xry111.site>
 <d0188f86-33ba-50ce-3761-882528796057@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fc4216f3-e8ae-e2b8-22ef-5d6631f7598e@loongson.cn>
Date:   Thu, 1 Sep 2022 09:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d0188f86-33ba-50ce-3761-882528796057@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxvmtNCxBjvV4OAA--.51477S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1rZFW3ZrW5Zr18Zr4xWFg_yoW5Ar4rpr
        yrAF4UtF4kJr1rArW2y34kWFyDtwsrJrnrWr4UJ34UAryq9w1UZw18tw1j9FsFqas2qr18
        ZF93KF9I9F4UJ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07j0GQhUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 09/01/2022 03:31 AM, Daniel Borkmann wrote:
> On 8/31/22 11:02 AM, Xi Ruoyao wrote:
>> On Wed, 2022-08-31 at 12:12 +0800, Xi Ruoyao wrote:
>>> On Wed, 2022-08-31 at 09:23 +0800, Tiezhu Yang wrote:
>>>>
>>>>
>>>> On 08/30/2022 10:46 PM, Huacai Chen wrote:
>>>>> Hi, Tiezhu,
>>>>>
>>>>> On Tue, Aug 30, 2022 at 7:10 PM Tiezhu Yang
>>>>> <yangtiezhu@loongson.cn> wrote:
>>>>>>
>>>>>> For now, BPF JIT for LoongArch is supported, update
>>>>>> loongson3_defconfig to
>>>>>> enable BPF_JIT to allow the kernel to generate native code when
>>>>>> a program
>>>>>> is loaded into the kernel, and also enable TEST_BPF to test BPF
>>>>>> JIT.
>>>>>>
>>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>>> ---
>>>>>>   arch/loongarch/configs/loongson3_defconfig | 2 ++
>>>>>>   1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/loongarch/configs/loongson3_defconfig
>>>>>> b/arch/loongarch/configs/loongson3_defconfig
>>>>>> index 3712552..93dc072 100644
>>>>>> --- a/arch/loongarch/configs/loongson3_defconfig
>>>>>> +++ b/arch/loongarch/configs/loongson3_defconfig
>>>>>> @@ -4,6 +4,7 @@ CONFIG_POSIX_MQUEUE=y
>>>>>>   CONFIG_NO_HZ=y
>>>>>>   CONFIG_HIGH_RES_TIMERS=y
>>>>>>   CONFIG_BPF_SYSCALL=y
>>>>>> +CONFIG_BPF_JIT=y
>>>>>>   CONFIG_PREEMPT=y
>>>>>>   CONFIG_BSD_PROCESS_ACCT=y
>>>>>>   CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>>> @@ -801,3 +802,4 @@ CONFIG_MAGIC_SYSRQ=y
>>>>>>   CONFIG_SCHEDSTATS=y
>>>>>>   # CONFIG_DEBUG_PREEMPT is not set
>>>>>>   # CONFIG_FTRACE is not set
>>>>>> +CONFIG_TEST_BPF=m
>>>>> I don't want the test module be built by default, but I don't
>>>>> insist
>>>>> if you have a strong requirement.
>>>>>
>>>>
>>>> Hi Huacai,
>>>>
>>>> It is useful to enable TEST_BPF in default config, otherwise we
>>>> need to use "make menuconfig" to select it manually if we want
>>>> to test bpf jit, and build it as a module by default has no side
>>>> effect, so I prefer to enable TEST_BPF in default config.
>>>
>>> IMO we shouldn't enable a test feature which is never used by 99% of
>>> users in the default.
>>
>> P. S. this is not a strong option.  CONFIG_TEST_BPF seems enabled by
>> default for S390, and I'm not sure if defconfig is designed for "kernel
>> developers" or "distro builders", or even "normal users".
>
> Right now BPF CI [0] tests x86_64 and s390x archs, would be nice to also
> add others in future to increase test coverage and then include test_bpf
> as part of the executed test suites. If noone beats me to it, the latter
> still sits in my bucket list. But either way, that would make more sense
> than adding CONFIG_TEST_BPF to defconfig. Looks like for odd reasons m68k
> and s390x has it, it shouldn't be there, really.
>
> Thanks,
> Daniel
>
>   [0] https://github.com/kernel-patches/bpf/pulls

OK, it is clear now, let me remove CONFIG_TEST_BPF in
loongson3_defconfig, thank you all.

Thanks,
Tiezhu

