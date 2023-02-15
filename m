Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B156973F3
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 02:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBOBy4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 20:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjBOByf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 20:54:35 -0500
Received: from out-140.mta0.migadu.com (out-140.mta0.migadu.com [IPv6:2001:41d0:1004:224b::8c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0170B4207
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 17:54:33 -0800 (PST)
Message-ID: <6d48c284-42eb-9688-4259-79b7f096e294@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676426072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhqbNPN7xfCGCSg3vVz7nFLwHSKzUxezJOcTZ/ywPcs=;
        b=oazU5CKA6kp0Y87uBdomtQ6CiatwUxSuz6iu7gi80L0osDrOdsjmBG9Qz5PG2NYNBERSHy
        jpI9BBKK4OaPrV9osJiKlEpbR+OfjqaffTtMfMXFodEZHpW/gXMVabVuAFGmHJGe5Yd8KK
        +l/0V8Y1VdWpRKg5QkxeYNI2vKxqMRA=
Date:   Tue, 14 Feb 2023 17:54:26 -0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hou Tao <houtao@huaweicloud.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
 <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
 <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo>
 <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
 <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
 <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/11/23 8:34 AM, Alexei Starovoitov wrote:
> On Sat, Feb 11, 2023 at 8:33 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, Feb 10, 2023 at 5:10 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>>> Hou, are you plannning to resubmit this change? I also hit this while testing my
>>>>> changes on bpf-next.
>>>> Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
>>>> The former will take a long time to settle.
>>>> The latter is trivial.
>>>> To unblock yourself just add GFP_ZERO in an extra patch?
>>> Sorry for the long delay. Just find find out time to do some tests to compare
>>> the performance of bzero and ctor. After it is done, will resubmit on next week.
>>
>> I still don't like ctor as a concept. In general the callbacks in the critical
>> path are guaranteed to be slow due to retpoline overhead.
>> Please send a patch to add GFP_ZERO.
>>
>> Also I realized that we can make the BPF_REUSE_AFTER_RCU_GP flag usable
>> without risking OOM by only waiting for normal rcu GP and not rcu_tasks_trace.
>> This approach will work for inner nodes of qptrie, since bpf progs
>> never see pointers to them. It will work for local storage
>> converted to bpf_mem_alloc too. It wouldn't need to use its own call_rcu.
>> It's also safe without uaf caveat in sleepable progs and sleepable progs
> 
> I meant 'safe with uaf caveat'.
> Safe because we wait for rcu_task_trace later before returning to kernel memory.

For local storage, when its owner (sk/task/inode/cgrp) is going away, the memory 
can be reused immediately. No rcu gp is needed.

The local storage delete case (eg. bpf_sk_storage_delete) is the only one that 
needs to be freed by tasks_trace gp because another bpf prog (reader) may be 
under the rcu_read_lock_trace(). I think the idea (BPF_REUSE_AFTER_RCU_GP) on 
allowing reuse after vanilla rcu gp and free (if needed) after tasks_trace gp 
can be extended to the local storage delete case. I think we can extend the 
assumption that "sleepable progs (reader) can use explicit bpf_rcu_read_lock() 
when they want to avoid uaf" to bpf_{sk,task,inode,cgrp}_storage_get() also.

I also need the GFP_ZERO in bpf_mem_alloc, so will work on the GFP_ZERO and the 
BPF_REUSE_AFTER_RCU_GP idea.  Probably will get the GFP_ZERO out first.

> 
>> can use explicit bpf_rcu_read_lock() when they want to avoid uaf.
>> So please respin the set with rcu gp only and that new flag.

