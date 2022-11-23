Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042CE636E31
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 00:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKWXOC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 18:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKWXOC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 18:14:02 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E6B8572
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 15:14:01 -0800 (PST)
Message-ID: <73adebc6-ab32-08a3-9e62-460160d108cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669245239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7M1S77W56HNJ8miO35V1dIcecN2cgWe3VrDTzvXjQI=;
        b=Njk/Gp6n+++m1/ZM9pi6+FZAeMhC2YWifWlK35hzr533f2SRfktfdUxSSeQnX7tIgQ4STd
        hA1o6FHKKL4dsId+IAtMSxfM4B+B5R/CAKIB5S3Gg1ZPBislSXe+rSay6hZYagkZlkRTbG
        T/9TOvGPesrUbP9vOQhJVpPmQ35I90c=
Date:   Wed, 23 Nov 2022 15:13:54 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@meta.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195340.1783247-1-yhs@fb.com>
 <201c1603-cb3e-7893-c411-e7949ef8e9d3@linux.dev>
 <b1b8d321-1c3a-ca41-707f-95b3cef7f124@meta.com>
 <ac70f574-4023-664e-b711-e0d3b18117fd@linux.dev>
 <767c6ae6-4aad-69a1-53e2-b7f8643a79c1@linux.dev>
 <SN6PR1501MB20649F820B6FFE58166817E5CA0C9@SN6PR1501MB2064.namprd15.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <SN6PR1501MB20649F820B6FFE58166817E5CA0C9@SN6PR1501MB2064.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/22/22 9:29 PM, Yonghong Song wrote:
> 
> 
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Tuesday, November 22, 2022 at 5:53 PM
> To: Yonghong Song <yhs@meta.com>
> Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@meta.com>, Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org <bpf@vger.kernel.org>
> Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add tests for bpf_rcu_read_lock()
> On 11/22/22 5:39 PM, Martin KaFai Lau wrote:
>> On 11/22/22 5:13 PM, Yonghong Song wrote:
>>>
>>>
>>> On 11/22/22 4:56 PM, Martin KaFai Lau wrote:
>>>> On 11/22/22 11:53 AM, Yonghong Song wrote:
>>>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>>> +int task_acquire(void *ctx)
>>>>> +{
>>>>> +    struct task_struct *task, *real_parent;
>>>>> +
>>>>> +    task = bpf_get_current_task_btf();
>>>>> +    bpf_rcu_read_lock();
>>>>> +    real_parent = task->real_parent;
>>>>> +    /* acquire a reference which can be used outside rcu read lock region */
>>>>> +    real_parent = bpf_task_acquire(real_parent);
>>>> Does the bpf_task_acquire() kfunc need a change to do refcount_inc_not_zero()
>>>> and KF_RET_NULL?
>>>
>>> We have this definition in kernel:
>>> BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
>>>
>>> So the argument is trusted args so, either marked as PTR_TRUSTED/MEM_ALLOC or
>>> have a reference acquired already, so
>>> I guess we should be fine here.
>>
>>
>> The verifier part is fine on {KF_TRUSTED_ARGS, PTR_TRUSTED}.
>>
>> iiuc, PTR_TRUSTED means the kfunc can safely dereference the pointer because the
>> ptr has not been freed yet but does not mean its refcnt > 0 and not on its way
>> to be freed after the rcu gp.
>>
>> If real_parent's refcnt is 0 here, bpf_task_acquire() will resurrect a task
>> which is on its way to be freed and the task can be stored in a map, so a UAF.
> I see. Maybe we need strong trusted vs. weak trusted variants. Strong trusted means refcnt > 0 and weak means no guarantee? Or we consider everything as week and tries to grab a reference anyway? In most if not all cases, ‘current’ should represent a strong trusted btf_id I guess.

yeah, "current" task here is fine.  current->real_parent is questionable.

imo, I think this check may be better done in runtime. The bpf_*_acquire() kfunc 
should always do refcount_inc_not_zero() + KF_RET_NULL. Otherwise, it may end up 
requiring to tag which ctx has a zero/non-zero refcnt.  eg. the 
security_sk_alloc() hook, the sk's refcnt is 0 and later the kernel does a 
refcount_set(&sk->sk_refcnt, 1).

> 
>> This could be addressed as a follow up though since it is not specific to this set.
> Right, we have the same potential problem for both task and cgroup acquire functions.
> 

