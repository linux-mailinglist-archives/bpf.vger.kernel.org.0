Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82365A734F
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 03:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiHaBXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 21:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiHaBXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 21:23:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94E7BB0B2A
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:23:45 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+AZuA5jsikNAA--.58516S3;
        Wed, 31 Aug 2022 09:23:38 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 4/4] LoongArch: Enable BPF_JIT and TEST_BPF in
 default config
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn>
 <1661857809-10828-5-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H6Dq+Z_kS0LcM=QGF1h=k2i0hR7fYZdXgU2kXAfm1VPLw@mail.gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6bc9bd64-1ba9-a35f-c0b7-480429b26b9f@loongson.cn>
Date:   Wed, 31 Aug 2022 09:23:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6Dq+Z_kS0LcM=QGF1h=k2i0hR7fYZdXgU2kXAfm1VPLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxT+AZuA5jsikNAA--.58516S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfGr1DGFy5Ww1kJF4rAFb_yoW8Wr18pw
        1rAa1DtF4kGrnYkrWjy3s7WFWDJrsrJFZrWF4UA3WrC39ru348Zw1ktw1qvF42qa90qr48
        Zas3KFnIva1UGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        xU7Q6pUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 08/30/2022 10:46 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Tue, Aug 30, 2022 at 7:10 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> For now, BPF JIT for LoongArch is supported, update loongson3_defconfig to
>> enable BPF_JIT to allow the kernel to generate native code when a program
>> is loaded into the kernel, and also enable TEST_BPF to test BPF JIT.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/loongarch/configs/loongson3_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
>> index 3712552..93dc072 100644
>> --- a/arch/loongarch/configs/loongson3_defconfig
>> +++ b/arch/loongarch/configs/loongson3_defconfig
>> @@ -4,6 +4,7 @@ CONFIG_POSIX_MQUEUE=y
>>  CONFIG_NO_HZ=y
>>  CONFIG_HIGH_RES_TIMERS=y
>>  CONFIG_BPF_SYSCALL=y
>> +CONFIG_BPF_JIT=y
>>  CONFIG_PREEMPT=y
>>  CONFIG_BSD_PROCESS_ACCT=y
>>  CONFIG_BSD_PROCESS_ACCT_V3=y
>> @@ -801,3 +802,4 @@ CONFIG_MAGIC_SYSRQ=y
>>  CONFIG_SCHEDSTATS=y
>>  # CONFIG_DEBUG_PREEMPT is not set
>>  # CONFIG_FTRACE is not set
>> +CONFIG_TEST_BPF=m
> I don't want the test module be built by default, but I don't insist
> if you have a strong requirement.
>

Hi Huacai,

It is useful to enable TEST_BPF in default config, otherwise we
need to use "make menuconfig" to select it manually if we want
to test bpf jit, and build it as a module by default has no side
effect, so I prefer to enable TEST_BPF in default config.

Thanks,
Tiezhu

