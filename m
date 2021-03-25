Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC723491C1
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 13:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhCYMTW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 08:19:22 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57278 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229659AbhCYMTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 08:19:02 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT8usf1xgr7AAAA--.2327S3;
        Thu, 25 Mar 2021 20:18:52 +0800 (CST)
Subject: Re: [PATCH v2] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn>
 <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk>
 <f36f4ca6-a3bb-8db9-01e6-65fec0916b58@loongson.cn>
 <20210325101712.GA6893@alpha.franken.de>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@lst.de>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <38cf6f7c-28dd-20a0-8193-776fa7bdb83a@loongson.cn>
Date:   Thu, 25 Mar 2021 20:18:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210325101712.GA6893@alpha.franken.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxT8usf1xgr7AAAA--.2327S3
X-Coremail-Antispam: 1UD129KBjvJXoWruF47Gry5tFW7WrW7Kw48WFg_yoW8JrWkp3
        4qyFsrtF42gry3WFs2y34xWr17trykKrWUWF4UtF1YkF909r95Gw40gw1agF1UXr4Iv3yI
        9Fy8Wa40gFyFy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjfUeWlkDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/25/2021 06:17 PM, Thomas Bogendoerfer wrote:
> On Mon, Mar 22, 2021 at 03:12:59PM +0800, Tiezhu Yang wrote:
>> On 03/22/2021 12:46 PM, Maciej W. Rozycki wrote:
>>> On Thu, 18 Mar 2021, Tiezhu Yang wrote:
>>>
>>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>>> index 160b3a8..4b94ec7 100644
>>>> --- a/arch/mips/Kconfig
>>>> +++ b/arch/mips/Kconfig
>>>> @@ -6,6 +6,7 @@ config MIPS
>>>>    	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
>>>>    	select ARCH_HAS_FORTIFY_SOURCE
>>>>    	select ARCH_HAS_KCOV
>>>> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>>    Hmm, documentation on ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE seems rather
>>> scarce, but based on my guess shouldn't this be "if !EVA"?
>>>
>>>     Maciej
>> I do not quite know what the effect if MIPS EVA (Enhanced Virtual
>> Addressing)
>> is set, I saw that ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should be
>> restricted
>> to archs with non-overlapping address ranges.
>>
>> I wonder whether MIPS EVA will generate overlapping address ranges?
> they can overlap in EVA mode.
>
>> If yes, it is better to make ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE depend
>> on !EVA on MIPS.
> Could please add the change ?

OK, thank you, I will do it soon.

>
> Thomas.
>

