Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E4633005
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKUW4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 17:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiKUW4T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 17:56:19 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB871183
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 14:56:17 -0800 (PST)
Message-ID: <1b1d17a5-8178-0cf8-21c3-b60c7f011942@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669071376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LH1/szULEkERMHJbiRdyLkyuxxGbJ3JaSWM7fYM1Tog=;
        b=espqWa00tJu3rvxJz3dFL0+PbDuRQtsCkwvoSUeOGjQFmiV51yZtWod0LsIyYXtjg18oSF
        dFk7VX9wEUn/CGvJm9ZVuNajlHhcINZoeW2RUD2LXiOfWSdKEMn8G1E9bepLmUWTPkTmaE
        XcWOq6MrLxUppFV2m41agM6bvE1Evv0=
Date:   Mon, 21 Nov 2022 14:56:12 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
 <ee7248b9-50ae-f4cf-5592-49634913b6ce@linux.dev>
 <7b09c839-ea51-fc8d-99b3-a32c94d175b9@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7b09c839-ea51-fc8d-99b3-a32c94d175b9@meta.com>
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

On 11/21/22 12:01 PM, Yonghong Song wrote:
> 
> 
> On 11/21/22 11:41 AM, Martin KaFai Lau wrote:
>> On 11/21/22 9:05 AM, Yonghong Song wrote:
>>> @@ -4704,6 +4715,15 @@ static int check_ptr_to_btf_access(struct 
>>> bpf_verifier_env *env,
>>>           return -EACCES;
>>>       }
>>> +    /* Access rcu protected memory */
>>> +    if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
>>> +        !env->cur_state->active_rcu_lock) {
>>> +        verbose(env,
>>> +            "R%d is ptr_%s access rcu-protected memory with off=%d, not rcu 
>>> protected\n",
>>> +            regno, tname, off);
>>> +        return -EACCES;
>>> +    }
>>> +
>>>       if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
>>>           if (!btf_is_kernel(reg->btf)) {
>>>               verbose(env, "verifier internal error: reg->btf must be kernel 
>>> btf\n");
>>> @@ -4731,12 +4751,27 @@ static int check_ptr_to_btf_access(struct 
>>> bpf_verifier_env *env,
>>>       if (ret < 0)
>>>           return ret;
>>> +    /* The value is a rcu pointer. The load needs to be in a rcu lock region,
>>> +     * similar to rcu_dereference().
>>> +     */
>>> +    if ((flag & MEM_RCU) && env->prog->aux->sleepable && 
>>> !env->cur_state->active_rcu_lock) {
>>> +        verbose(env,
>>> +            "R%d is rcu dereference ptr_%s with off=%d, not in rcu_read_lock 
>>> region\n",
>>> +            regno, tname, off);
>>> +        return -EACCES;
>>> +    }
>>
>> Would this make the existing rdonly use case fail?
>>
>> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
>> int task_real_parent(void *ctx)
>> {
>>      struct task_struct *task, *real_parent;
>>
>>      task = bpf_get_current_task_btf();
>>          real_parent = task->real_parent;
>>          bpf_printk("pid %u\n", real_parent->pid);
>>          return 0;
>> }
> 
> Right, it will fail. To fix the issue, user can do
>     bpf_rcu_read_lock();
>     real_parent = task->real_parent;
>     bpf_printk("pid %u\n", real_parent->pid);
>     bpf_rcu_read_unlock();
> 
> But this raised a good question. How do we deal with
> legacy sleepable programs with newly-added rcu tagging
> capabilities.
> 
> My current option is to error out if rcu usage is not right.
> But this might break existing sleepable programs.
> 
> Another option intends to not break existing, like above,
> codes. In this case, MEM_RCU will not tagged if it is
> not inside bpf_rcu_read_lock() region.

hmm.... it is to make MEM_RCU to mean a reg is protected by the current 
active_rcu_lock or not?

> In this case, the above non-rcu-protected code should work. And the
> following should work as well although it is a little
> bit awkward.
>     real_parent = task->real_parent; // real_parent not tagged with rcu
>     bpf_rcu_read_lock();
>     bpf_printk("pid %u\n", real_parent->pid);
>     bpf_rcu_read_unlock();

I think it should be fine.  bpf_rcu_read_lock() just not useful in this example 
but nothing break or crash.  Also, after bpf_rcu_read_unlock(), real_parent will 
continue to be readable because the MEM_RCU is not set?

On top of the active_rcu_lock, should MEM_RCU be set only when it is 
dereferenced from a PTR_TRUSTED ptr (or with ref_obj_id != 0)?
I am thinking about the following more common case:

	/* bpf_get_current_task_btf() may need to be changed
	 * to set PTR_TRUSTED at the retval?
	 */
	/* task: PTR_TO_BTF_ID | PTR_TRUSTED */
	task = bpf_get_current_task_btf();

	bpf_rcu_read_lock();

	/* real_parent: PTR_TO_BTF_ID | PTR_TRUSTED | MEM_RCU */
	real_parent = task->real_parent;

         /* bpf_task_acquire() needs to change to use refcount_inc_not_zero */
	real_parent = bpf_task_acquire(real_parent);

	bpf_rcu_read_unlock();

	/* real_parent is accessible here (after checking NULL) and
	 * can be passed to kfunc
	 */


