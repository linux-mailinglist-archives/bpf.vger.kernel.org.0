Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BEE68605F
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 08:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjBAHNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 02:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjBAHNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 02:13:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3917291
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 23:12:57 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P6CkJ6WmCznVvl;
        Wed,  1 Feb 2023 15:10:48 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 15:12:51 +0800
From:   Hou Tao <houtao1@huawei.com>
Subject: Re: [bpf-next v5 3/3] bpf: hash map, suppress false lockdep warning
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Tonghao Zhang <tong@infragraf.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        <bpf@vger.kernel.org>
References: <20230111092903.92389-1-tong@infragraf.org>
 <20230111092903.92389-3-tong@infragraf.org>
 <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
 <EE4608EF-84F5-4E4C-967F-37B96D680D2E@infragraf.org>
 <bfa2b221-9ed7-2791-08e2-2e5b29e21dee@linux.dev>
Message-ID: <136b2803-3c86-c65a-7398-dd415c26ac5c@huawei.com>
Date:   Wed, 1 Feb 2023 15:12:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bfa2b221-9ed7-2791-08e2-2e5b29e21dee@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 1/16/2023 6:51 AM, Martin KaFai Lau wrote:
> On 1/13/23 1:15 AM, Tonghao Zhang wrote:
>>
>>
>>> On Jan 13, 2023, at 9:53 AM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 1/11/23 1:29 AM, tong@infragraf.org wrote:
>>>> +    /*
>>>> +     * The lock may be taken in both NMI and non-NMI contexts.
>>>> +     * There is a false lockdep warning (inconsistent lock state),
>>>> +     * if lockdep enabled. The potential deadlock happens when the
>>>> +     * lock is contended from the same cpu. map_locked rejects
>>>> +     * concurrent access to the same bucket from the same CPU.
>>>> +     * When the lock is contended from a remote cpu, we would
>>>> +     * like the remote cpu to spin and wait, instead of giving
>>>> +     * up immediately. As this gives better throughput. So replacing
>>>> +     * the current raw_spin_lock_irqsave() with trylock sacrifices
>>>> +     * this performance gain. atomic map_locked is necessary.
>>>> +     * lockdep_off is invoked temporarily to fix the false warning.
>>>> +     */
>>>> +    lockdep_off();
>>>>       raw_spin_lock_irqsave(&b->raw_lock, flags);
>>>> -    *pflags = flags;
>>>> +    lockdep_on();
>>>
>>> I am not very sure about the lockdep_off/on. Other than the false warning
>>> when using the very same htab map by both NMI and non-NMI context, I think
>>> the lockdep will still be useful to catch other potential issues. The commit
>>> c50eb518e262 ("bpf: Use separate lockdep class for each hashtab") has
>>> already solved this false alarm when NMI happens on one map and non-NMI
>>> happens on another map.
>>>
>>> Alexei, what do you think? May be only land the patch 1 fix for now.
>> Hi Martin
>> Patch 2 is used for patch 1 to test whether there is a deadlock. We should
>> apply this two patches.
>
> It is too noisy for test_progs that developers routinely run. Lets continue to
> explore other ways (or a different test) without this false positive splat.
> Patch 1 was applied as already mentioned in the earlier reply.
> .
Sorry for the late reply. We had discussed with lockdep experts [0]. They
suggested to add a virtual lockdep class for map_locked, because map_locked acts
like a spin_trylock. So how about using lockdep_off() and lockdep_on() for
raw_lock to get rid of these false alarms and adding the lockdep annotation for
map_locked to do the lockdep check ?

[0]: https://lore.kernel.org/bpf/Y4ZABpDSs4%2FuRutC@Boquns-Mac-mini.local/

