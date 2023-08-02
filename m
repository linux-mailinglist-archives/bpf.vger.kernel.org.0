Return-Path: <bpf+bounces-6763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C3276DAD0
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF561C213A7
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 22:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617BC14AA9;
	Wed,  2 Aug 2023 22:28:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D310973
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 22:28:40 +0000 (UTC)
Received: from out-85.mta1.migadu.com (out-85.mta1.migadu.com [95.215.58.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D83A95
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 15:28:23 -0700 (PDT)
Message-ID: <2cbc2699-a88d-5798-eabd-b4dafdf6d100@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691015301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFLXTFYL8AR7IZl1rOQXm3B76aYCOFrVevhUzH3iK40=;
	b=GDroYwct84JHelR2B5s5e3m1ZVqaW+Enuznr5+SnCiHVreTX0/SAc897QVZbDDWU24nzHg
	JxWV9Sp86ThsCTDgS80+FFisOyDfvToRJUWapZFYxbGGabRwncUYjuBJcnYvcsWyJd9WRn
	xmbsLzQD/0RHNJsog+xzAWzUOnAJhNE=
Date: Wed, 2 Aug 2023 15:28:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next 1/5] bpf: enable sleepable BPF programs attached to
 cgroup/{get,set}sockopt.
Content-Language: en-US
To: kuifeng@meta.com
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, Stanislav Fomichev
 <sdf@google.com>, Kui-Feng Lee <sinquersw@gmail.com>
References: <20230722052248.1062582-1-kuifeng@meta.com>
 <20230722052248.1062582-2-kuifeng@meta.com> <ZL7Ery1lzqj4as7N@google.com>
 <00dbd930-5ec2-7fb6-202b-38d09e13eb0b@gmail.com>
 <CAKH8qBvcD7r0e-0oZryLHyGnsNnZ66w6tHj5t4Qi1SzONnwN+w@mail.gmail.com>
 <bf361930-7d39-531f-d21a-a4e436b2a544@gmail.com>
 <CAKH8qBsn9e+ROsBN9EJ9mWQ6T_1=d0adHYPQ37WwM0TVn1H9hw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBsn9e+ROsBN9EJ9mWQ6T_1=d0adHYPQ37WwM0TVn1H9hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/23 11:08 AM, Stanislav Fomichev wrote:
> On Tue, Aug 1, 2023 at 10:31 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 7/31/23 16:35, Stanislav Fomichev wrote:
>>> On Mon, Jul 31, 2023 at 3:02 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>>
>>>> Sorry for the late reply! I just backed from a vacation.
>>>>
>>>>
>>>> On 7/24/23 11:36, Stanislav Fomichev wrote:
>>>>> On 07/21, kuifeng@meta.com wrote:
>>>>>> From: Kui-Feng Lee <kuifeng@meta.com>
>>>>>>
>>>>>> Enable sleepable cgroup/{get,set}sockopt hooks.
>>>>>>
>>>>>> The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
>>>>>> received a pointer to the optval in user space instead of a kernel
>>>>>> copy. ctx->user_optval and ctx->user_optval_end are the pointers to the
>>>>>> begin and end of the user space buffer if receiving a user space
>>>>>> buffer. ctx->optval and ctx->optval_end will be a kernel copy if receiving
>>>>>> a kernel space buffer.
>>>>>>
>>>>>> A program receives a user space buffer if ctx->flags &
>>>>>> BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel space
>>>>>> buffer.  The BPF programs should not read/write from/to a user space buffer
>>>>>> dirrectly.  It should access the buffer through bpf_copy_from_user() and
>>>>>> bpf_copy_to_user() provided in the following patches.
>>>>>>
>>>>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>>>>>> ---
>>>>>>     include/linux/filter.h         |   3 +
>>>>>>     include/uapi/linux/bpf.h       |   9 ++
>>>>>>     kernel/bpf/cgroup.c            | 189 ++++++++++++++++++++++++++-------
>>>>>>     kernel/bpf/verifier.c          |   7 +-
>>>>>>     tools/include/uapi/linux/bpf.h |   9 ++
>>>>>>     tools/lib/bpf/libbpf.c         |   2 +
>>>>>>     6 files changed, 176 insertions(+), 43 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>>>>>> index f69114083ec7..301dd1ba0de1 100644
>>>>>> --- a/include/linux/filter.h
>>>>>> +++ b/include/linux/filter.h
>>>>>> @@ -1345,6 +1345,9 @@ struct bpf_sockopt_kern {
>>>>>>        s32             level;
>>>>>>        s32             optname;
>>>>>>        s32             optlen;
>>>>>> +    u32             flags;
>>>>>> +    u8              *user_optval;
>>>>>> +    u8              *user_optval_end;
>>>>>>        /* for retval in struct bpf_cg_run_ctx */
>>>>>>        struct task_struct *current_task;
>>>>>>        /* Temporary "register" for indirect stores to ppos. */
>>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>>> index 739c15906a65..b2f81193f97b 100644
>>>>>> --- a/include/uapi/linux/bpf.h
>>>>>> +++ b/include/uapi/linux/bpf.h
>>>>>> @@ -7135,6 +7135,15 @@ struct bpf_sockopt {
>>>>>>        __s32   optname;
>>>>>>        __s32   optlen;
>>>>>>        __s32   retval;
>>>>>> +
>>>>>> +    __bpf_md_ptr(void *, user_optval);
>>>>>> +    __bpf_md_ptr(void *, user_optval_end);
>>>>>
>>>>> Can we re-purpose existing optval/optval_end pointers
>>>>> for the sleepable programs? IOW, when the prog is sleepable,
>>>>> pass user pointers via optval/optval_end and require the programs
>>>>> to do copy_to/from on this buffer (even if the backing pointer might be
>>>>> in kernel memory - we can handle that in the kfuncs?).
>>>>>
>>>>> The fact that the program now needs to look at the flag
>>>>> (BPF_SOCKOPT_FLAG_OPTVAL_USER) and decide which buffer to
>>>>> use makes the handling even more complicated; and we already have a
>>>>> bunch of hairy stuff in these hooks. (or I misreading the change?)
>>>>>
>>>>> Also, regarding sleepable and non-sleepable co-existence: do we really need
>>>>> that? Can we say that all the programs have to be sleepable
>>>>> or non-sleepable? Mixing them complicates the sharing of that buffer.
>>>>
>>>> I considered this approach as well. This is an open question for me.
>>>> If we go this way, it means we can not attach a BPF program of a type
>>>> if any program of the other type has been installed.
>>>
>>> If we pass two pointers (kernel copy buffer + real user mem) to the
>>> sleepable program, we'll make it even more complicated by inheriting
>>> all existing warts of the non-sleepable version :-( >>> IOW, feels like we should try to see if we can have some
>>> copy_to/from_user kfuncs in the sleepable version that transparently
>>> support either kernel or user memory (and prohibit direct access to
>>> user_optval in the sleepable version).

 From looking at patch 5 selftest, I also think exposing user_optval_* and flags 
is not ideal. For example, correct me if I am wrong, in patch 3, dynptr is only 
used for setsockopt to alloc. Intuitively, when developing a bpf prog, I would 
expect using bpf_dynptr_write() to write a new sockopt and then done. However, 
it still needs to "install" (by calling bpf_sockopt_install_optval). I think the 
"install" part is leaking too much internal details.

Beside, adding both new 'ctx->user_optval + len > ctx->user_optval_end' and 
dynptr usage pattern together is counter productive considering dynptr is to 
avoid the length comparison. Saving an unnecessary "copy_from_user(ctx.optval, 
optval,...)" is more important than being able to directly read from 
ctx->user_optval. The bpf prog is usually only interested in a few optnames and 
directly returns without even looking at the optval for the uninterested 
optnames. The current __cgroup_bpf_run_filter_{get,set}sockopt always does a 
"copy_from_user(ctx.optval, optval,...)".

>>> And then, if we have one non-sleepable program in the chain, we can
>>> fallback everything to the kernel buffer (maybe).
>>> This way seems like we can support both versions in the same chain and
>>> have a more sane api?
>>
>> Basically, you are saying to move cp_from_optval() and cp_to_optval() in
>> the testcase to kfuncs. This can cause unnecessary copy. We can add
>> an API to make a dynptr from the ctx to avoid unnecessary copies.
> 
> Yeah, handle this transparently in the kfunc or via dynptr, whatever works.
> I'm not too worried about the extra copy tbh, this is a slow path; I'm
> more concerned about improving the bpf program / user experience.

+1. It will be great if all can be done in two kfunc (/dynptr_{write,read}). I 
would disallow sleepable prog to use the optval if it can make things simpler. 
If it goes with dynptr, need to support bpf_dynptr_slice() as well which I think 
should be doable after a quick thought.

The test needs to include a cgrp->effective array that has interleaved sleepable 
and non-sleepable bpf progs.

