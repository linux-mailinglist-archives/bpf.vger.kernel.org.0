Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C445C45AB82
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhKWSwQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:52:16 -0500
Received: from foss.arm.com ([217.140.110.172]:57360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237739AbhKWSwM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 13:52:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D7A31FB;
        Tue, 23 Nov 2021 10:49:03 -0800 (PST)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAC613F66F;
        Tue, 23 Nov 2021 10:48:52 -0800 (PST)
Subject: Re: [PATCH bpf] cacheinfo: move get_cpu_cacheinfo_id() back out
To:     Song Liu <song@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        bpf <bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org
References: <20211120165528.197359-1-kuba@kernel.org>
 <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d4c52f8f-7efb-3d2a-8f2e-c983cd0c8cce@arm.com>
Date:   Tue, 23 Nov 2021 18:48:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On 23/11/2021 17:45, Song Liu wrote:
> On Sat, Nov 20, 2021 at 6:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> This commit more or less reverts commit 709c4362725a ("cacheinfo:
>> Move resctrl's get_cache_id() to the cacheinfo header file").
>>
>> There are no users of the static inline helper outside of resctrl/core.c
>> and cpu.h is a pretty heavy include, it pulls in device.h etc. This
>> trips up architectures like riscv which want to access cacheinfo
>> in low level headers like elf.h.
>>
>> Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.org/
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---

>> x86 resctrl folks, does this look okay?
>>
>> I'd like to do some bpf header cleanups in -next which this is blocking.
>> How would you like to handle that? This change looks entirely harmless,
>> can I get an ack and take this via bpf/netdev to Linus ASAP so it
>> propagates to all trees?
> 
> Does this patch target the bpf tree, or the bpf-next tree? If we want to unblock
> bpf header cleanup in -next, we can simply include it in a set for bpf-next.


Some background: this is part of the mpam tree that wires up resctrl for arm64. This patch
floated to the top and got merged with some cleanup as it was independent of the wider
resctrl changes.

If the cpu.h include is the problem, I can't see what that is needed for. It almost
certainly came in with a lockdep annotation that got replaced by a comment instead.


Thanks,

James


>> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
>> index 2f909ed084c6..c8c71eea237d 100644
>> --- a/include/linux/cacheinfo.h
>> +++ b/include/linux/cacheinfo.h
>> @@ -3,7 +3,6 @@
>>  #define _LINUX_CACHEINFO_H
>>
>>  #include <linux/bitops.h>
>> -#include <linux/cpu.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/smp.h>
>>
>> @@ -102,24 +101,4 @@ int acpi_find_last_cache_level(unsigned int cpu);
>>
>>  const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
>>
>> -/*
>> - * Get the id of the cache associated with @cpu at level @level.
>> - * cpuhp lock must be held.
>> - */
>> -static inline int get_cpu_cacheinfo_id(int cpu, int level)
>> -{
>> -       struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
>> -       int i;
>> -
>> -       for (i = 0; i < ci->num_leaves; i++) {
>> -               if (ci->info_list[i].level == level) {
>> -                       if (ci->info_list[i].attributes & CACHE_ID)
>> -                               return ci->info_list[i].id;
>> -                       return -1;
>> -               }
>> -       }
>> -
>> -       return -1;
>> -}
>> -
>>  #endif /* _LINUX_CACHEINFO_H */
>> --
>> 2.31.1
>>

