Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA19343A62
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 08:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCVHN3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 03:13:29 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48516 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229574AbhCVHNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 03:13:09 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxE+R7Q1hgu_IEAA--.12497S3;
        Mon, 22 Mar 2021 15:13:00 +0800 (CST)
Subject: Re: [PATCH v2] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <1616034557-5844-1-git-send-email-yangtiezhu@loongson.cn>
 <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Christoph Hellwig <hch@lst.de>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f36f4ca6-a3bb-8db9-01e6-65fec0916b58@loongson.cn>
Date:   Mon, 22 Mar 2021 15:12:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2103220540591.21463@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxE+R7Q1hgu_IEAA--.12497S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKF45uw47GF4ktFy7XFyrZwb_yoWDXrbEqw
        nrCa1DGFs5ZryrC3y2qF48Gr1UZw4xWrn5CF1UAr92ya4fX34fGrs5tF95Ar15Gwn0qFn3
        ZFWS9rs5ZFZ2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUjE1v3UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/22/2021 12:46 PM, Maciej W. Rozycki wrote:
> On Thu, 18 Mar 2021, Tiezhu Yang wrote:
>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 160b3a8..4b94ec7 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -6,6 +6,7 @@ config MIPS
>>   	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
>>   	select ARCH_HAS_FORTIFY_SOURCE
>>   	select ARCH_HAS_KCOV
>> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   Hmm, documentation on ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE seems rather
> scarce, but based on my guess shouldn't this be "if !EVA"?
>
>    Maciej

I do not quite know what the effect if MIPS EVA (Enhanced Virtual 
Addressing)
is set, I saw that ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should be 
restricted
to archs with non-overlapping address ranges.

I wonder whether MIPS EVA will generate overlapping address ranges?
If yes, it is better to make ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE depend
on !EVA on MIPS.

Thanks,
Tiezhu

