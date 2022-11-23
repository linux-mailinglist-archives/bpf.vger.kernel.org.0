Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B6634D76
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 02:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiKWBxN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 20:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiKWBxM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 20:53:12 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC92716
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:53:09 -0800 (PST)
Message-ID: <767c6ae6-4aad-69a1-53e2-b7f8643a79c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669168388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2D1AbYJf8XBCkKrZI/eMmG+hfb32LXKkbM3nY1ISoY=;
        b=OM1IHFGaesvU33IeNgx7guA5etHS7/n1FIBmaXXda6twwuUCXesjC3LvZBPaObjzAoQQaz
        mZdm5iAej7TCOodSXIensHl5COAFCwDtE7jw83MGX5+yfbYcPyfoic0s+WSvRs82bdZOKS
        0AMe/o//QnvxV3xiMQV9/xltb8UXZ90=
Date:   Tue, 22 Nov 2022 17:52:59 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195340.1783247-1-yhs@fb.com>
 <201c1603-cb3e-7893-c411-e7949ef8e9d3@linux.dev>
 <b1b8d321-1c3a-ca41-707f-95b3cef7f124@meta.com>
 <ac70f574-4023-664e-b711-e0d3b18117fd@linux.dev>
In-Reply-To: <ac70f574-4023-664e-b711-e0d3b18117fd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/22/22 5:39 PM, Martin KaFai Lau wrote:
> On 11/22/22 5:13 PM, Yonghong Song wrote:
>>
>>
>> On 11/22/22 4:56 PM, Martin KaFai Lau wrote:
>>> On 11/22/22 11:53 AM, Yonghong Song wrote:
>>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>>>> +int task_acquire(void *ctx)
>>>> +{
>>>> +    struct task_struct *task, *real_parent;
>>>> +
>>>> +    task = bpf_get_current_task_btf();
>>>> +    bpf_rcu_read_lock();
>>>> +    real_parent = task->real_parent;
>>>> +    /* acquire a reference which can be used outside rcu read lock region */
>>>> +    real_parent = bpf_task_acquire(real_parent);
>>> Does the bpf_task_acquire() kfunc need a change to do refcount_inc_not_zero() 
>>> and KF_RET_NULL?
>>
>> We have this definition in kernel:
>> BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
>>
>> So the argument is trusted args so, either marked as PTR_TRUSTED/MEM_ALLOC or 
>> have a reference acquired already, so
>> I guess we should be fine here.
> 
> 
> The verifier part is fine on {KF_TRUSTED_ARGS, PTR_TRUSTED}.
> 
> iiuc, PTR_TRUSTED means the kfunc can safely dereference the pointer because the 
> ptr has not been freed yet but does not mean its refcnt > 0 and not on its way 
> to be freed after the rcu gp.
> 
> If real_parent's refcnt is 0 here, bpf_task_acquire() will resurrect a task 
> which is on its way to be freed and the task can be stored in a map, so a UAF.


This could be addressed as a follow up though since it is not specific to this set.

