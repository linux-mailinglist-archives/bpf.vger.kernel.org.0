Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE74432D09
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhJSFNY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 01:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSFNX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 01:13:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F97C06161C
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 22:11:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f5so18251584pgc.12
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=KWqMvVzFdjb4+vgEt3fiMHERAKUzJR+cIprxv925wDI=;
        b=eS+LGxD8vKQ3mMoOr+eC1m+zLWz+Jm28k5ReDdI4kZRW+WKeWlZUOqLYpQQKAOL9j5
         e5fdFYK5FzD7SJ2DkmSfbIZxptcqvoJ9EFSubPZQMbkKcRxOUC0Wa1HwBxzSPxsM5TTd
         ZUKBhIOmIJCKn69mvu/LPIKWqeir5UP9G7Hj26jyZDSRcqU6yFXTtIGo8BZ4naIUJAa5
         FRolINWYmdTOHr3qKBrAw2dwbkkq4/hE6OQxCw97TE1pC1qJBzaM0CfPHxkVsZJ7M6Tq
         38VORKQF+i+NvGRD5fcGNi32Y57q8VSQCvBk2nDO25BgLJzsk2E0c158CgWEJInqqZGF
         9wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KWqMvVzFdjb4+vgEt3fiMHERAKUzJR+cIprxv925wDI=;
        b=EQ709GXfR54CFBo3gXdQKdB48L6NLuLQ4m/U+KUVgMwGRPEk3zguUTuIMGvgTIz9n8
         a9VnvpmNJ7BUnCr3/TE2Z/yzSFtltPe84WzDyPXCZtAXV5xcpIjCanK9UJi3HWe3aper
         OsD6q5Te6QT2Z1klORiijEWowLHcJTbdkzljMRXpn1SlEY7EUoiuF5okm8FNXJ2UU8ak
         8BURur1Y6L/QIa2GZdyGtiQzMOV2wTiaIAUmSePhuAeFE5OIdoZEfuyuxLkFreY88ygd
         BWaWCM0AOQbvNBB+TbG//cahIpxXqOhafJ64vsvQ/bsArisg5B93H1qFZCUPVsBzq+rP
         cC6w==
X-Gm-Message-State: AOAM5319nbFdnXQLyjKRWJDt8btO/XV82L5m9bMpbTBjGGnjVmUvXXTt
        1GPI1vLZpgJD28XG0tWGnArHAA==
X-Google-Smtp-Source: ABdhPJxXQHZRx2FP/ZWEN2TiVFh8L6JbBeXBsSTkioaqRV1dj/uJBp3myc8gzfg3U9aEUrn9uGVgvQ==
X-Received: by 2002:a63:230c:: with SMTP id j12mr27283900pgj.1.1634620270923;
        Mon, 18 Oct 2021 22:11:10 -0700 (PDT)
Received: from [10.70.253.117] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y2sm1110843pjl.6.2021.10.18.22.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 22:11:10 -0700 (PDT)
Message-ID: <85391f68-f5d9-974f-3ce5-26cc486e0dd9@bytedance.com>
Date:   Tue, 19 Oct 2021 13:11:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [External] Re: [PATCH] bpf: use count for prealloc hashtab too
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20211015090353.31248-1-zhouchengming@bytedance.com>
 <CAADnVQ+A5LdWQTXFugNTceGcz_biV-uEJma4oT5UJKeHQBHQPw@mail.gmail.com>
 <6d7246b6-195e-ee08-06b1-2d1ec722e7b2@bytedance.com>
 <CAADnVQKG5=qVSjZGzHEc0ijwiYABVCU1uc8vOQ-ZLibhpW--Hg@mail.gmail.com>
 <b8f6c2f6-1b07-9306-46da-5ab170a125f9@bytedance.com>
 <CAADnVQJpcFXVE1j5aEdeyCoBZytzytiYP+3AwQxtWmNj6q-kNQ@mail.gmail.com>
 <36b27bba-e20b-8fd4-1436-d2d4c0e86896@bytedance.com>
 <CAADnVQ+ijmng_s1EP_qTG3Xsvg6v5EWLvP9PTFEH0vLnyJUtRg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAADnVQ+ijmng_s1EP_qTG3Xsvg6v5EWLvP9PTFEH0vLnyJUtRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

在 2021/10/19 下午12:43, Alexei Starovoitov 写道:
> On Mon, Oct 18, 2021 at 9:31 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> 在 2021/10/19 上午11:45, Alexei Starovoitov 写道:
>>> On Mon, Oct 18, 2021 at 8:14 PM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> 在 2021/10/19 上午9:57, Alexei Starovoitov 写道:
>>>>> On Sun, Oct 17, 2021 at 10:49 PM Chengming Zhou
>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>
>>>>>> 在 2021/10/16 上午3:58, Alexei Starovoitov 写道:
>>>>>>> On Fri, Oct 15, 2021 at 11:04 AM Chengming Zhou
>>>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>>>
>>>>>>>> We only use count for kmalloc hashtab not for prealloc hashtab, because
>>>>>>>> __pcpu_freelist_pop() return NULL when no more elem in pcpu freelist.
>>>>>>>>
>>>>>>>> But the problem is that __pcpu_freelist_pop() will traverse all CPUs and
>>>>>>>> spin_lock for all CPUs to find there is no more elem at last.
>>>>>>>>
>>>>>>>> We encountered bad case on big system with 96 CPUs that alloc_htab_elem()
>>>>>>>> would last for 1ms. This patch use count for prealloc hashtab too,
>>>>>>>> avoid traverse and spin_lock for all CPUs in this case.
>>>>>>>>
>>>>>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>>>>>
>>>>>>> It's not clear from the commit log what you're solving.
>>>>>>> The atomic inc/dec in critical path of prealloc maps hurts performance.
>>>>>>> That's why it's not used.
>>>>>>>
>>>>>> Thanks for the explanation, what I'm solving is when hash table hasn't free
>>>>>> elements, we don't need to call __pcpu_freelist_pop() to traverse and
>>>>>> spin_lock all CPUs. The ftrace output of this bad case is below:
>>>>>>
>>>>>>  50)               |  htab_map_update_elem() {
>>>>>>  50)   0.329 us    |    _raw_spin_lock_irqsave();
>>>>>>  50)   0.063 us    |    lookup_elem_raw();
>>>>>>  50)               |    alloc_htab_elem() {
>>>>>>  50)               |      pcpu_freelist_pop() {
>>>>>>  50)   0.209 us    |        _raw_spin_lock();
>>>>>>  50)   0.264 us    |        _raw_spin_lock();
>>>>>
>>>>> This is LRU map. Not hash map.
>>>>> It will grab spin_locks of other cpus
>>>>> only if all previous cpus don't have free elements.
>>>>> Most likely your map is actually full and doesn't have any free elems.
>>>>> Since it's an lru it will force free an elem eventually.
>>>>>
>>>>
>>>> Maybe I missed something, the map_update_elem function of LRU map is
>>>> htab_lru_map_update_elem() and the htab_map_update_elem() above is the
>>>> map_update_elem function of hash map.
>>>> Because of the implementation of percpu freelist used in hash map, it
>>>> will spin_lock all other CPUs when there is no free elements.
>>>
>>> Ahh. Right. Then what's the point of optimizing the error case
>>> at the expense of the fast path?
>>>
>>
>> Yes, this patch only optimized the very bad case that no free elements left,
>> and add atomic operation in the fast path. Maybe the better workaround is not
>> allowing full hash map in our case or using LRU map?
> 
> No idea, since you haven't explained your use case.
> 
>> But the problem of spinlock contention also exist even when the map is not full,
>> like some CPUs run out of its freelist but other CPUs seldom used, then have to
>> grab those CPUs' spinlock to get free element.
> 
> In theory that would be correct. Do you see it in practice?
> Please describe the use case.
> 
>> Should we change the current implementation of percpu freelist to percpu lockless freelist?
> 
> Like llist.h ? That was tried already and for typical hash map usage
> it's slower than percpu free list.
> Many progs still do a lot of hash map update/delete on all cpus at once.
> That is the use case hashmap optimized for.
> Please see commit 6c9059817432 ("bpf: pre-allocate hash map elements")
> that also lists different alternative algorithms that were benchmarked.
> 

Ok, I will figure out our use case, try these alternatives and collect some data first.
Thanks for your explanation.
