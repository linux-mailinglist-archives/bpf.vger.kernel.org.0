Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C991634D56
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 02:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiKWBjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 20:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWBja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 20:39:30 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8ABDFDF
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:39:29 -0800 (PST)
Message-ID: <ac70f574-4023-664e-b711-e0d3b18117fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669167568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zym+CbN7tIH7b5zdi5Z23Kk8vaibYbRhHpyvhW5E4zg=;
        b=OcTuypTNsS3R7UQ9CPKDPxdFK2u5ck7mk0l49paYuDQ0vinqbJNLckYoN+JDsEEqSEFzkv
        NJFKlezJYBJX9OWDYMFUTkEzIY6Dj+9hzjjpRJkAAT5SkEsjpqq8YdNSlmJbLMZME+QHTx
        CgwPVP9lVOuTpPpZ2IZM/AN2VVLJqsI=
Date:   Tue, 22 Nov 2022 17:39:25 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195340.1783247-1-yhs@fb.com>
 <201c1603-cb3e-7893-c411-e7949ef8e9d3@linux.dev>
 <b1b8d321-1c3a-ca41-707f-95b3cef7f124@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b1b8d321-1c3a-ca41-707f-95b3cef7f124@meta.com>
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

On 11/22/22 5:13 PM, Yonghong Song wrote:
> 
> 
> On 11/22/22 4:56 PM, Martin KaFai Lau wrote:
>> On 11/22/22 11:53 AM, Yonghong Song wrote:
>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>>> +int task_acquire(void *ctx)
>>> +{
>>> +    struct task_struct *task, *real_parent;
>>> +
>>> +    task = bpf_get_current_task_btf();
>>> +    bpf_rcu_read_lock();
>>> +    real_parent = task->real_parent;
>>> +    /* acquire a reference which can be used outside rcu read lock region */
>>> +    real_parent = bpf_task_acquire(real_parent);
>> Does the bpf_task_acquire() kfunc need a change to do refcount_inc_not_zero() 
>> and KF_RET_NULL?
> 
> We have this definition in kernel:
> BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
> 
> So the argument is trusted args so, either marked as PTR_TRUSTED/MEM_ALLOC or 
> have a reference acquired already, so
> I guess we should be fine here.


The verifier part is fine on {KF_TRUSTED_ARGS, PTR_TRUSTED}.

iiuc, PTR_TRUSTED means the kfunc can safely dereference the pointer because the 
ptr has not been freed yet but does not mean its refcnt > 0 and not on its way 
to be freed after the rcu gp.

If real_parent's refcnt is 0 here, bpf_task_acquire() will resurrect a task 
which is on its way to be freed and the task can be stored in a map, so a UAF.

