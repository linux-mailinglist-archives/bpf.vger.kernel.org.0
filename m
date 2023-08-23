Return-Path: <bpf+bounces-8414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC8786192
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2D42811EA
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63850200A3;
	Wed, 23 Aug 2023 20:29:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9CC2E6
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 20:29:21 +0000 (UTC)
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD610DB
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 13:29:18 -0700 (PDT)
Message-ID: <71152843-d35d-4165-6410-0aa30a4c0f74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692822557; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5ZyuYhr84kqxZrOi+BvZ1YCZ1/vZAjaYvsyVQhUwG4=;
	b=waCzO2I4qFTVB15h0id4GZlMm/inIAuWvSCtcjoDWG2h7VJ9418vkWfN12QydXJ2vJlB3z
	HTM+LB+UrrPvMyvXQwURqs3Nkpg7ZGnI5yHlolnUskhdVQs4dOO8JThngcXnyzR9ch5eHU
	IowFyoFWT4z6qd9Uttv2bgcsAQdcOmU=
Date: Wed, 23 Aug 2023 13:29:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 3/7] bpf: Use bpf_mem_free_rcu when
 bpf_obj_dropping refcounted nodes
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-4-davemarchevsky@fb.com>
 <01367775-1be4-a344-60d7-6b2b1e48b77e@linux.dev>
 <CAADnVQK-6A08+OCtOK20yRebBP_N1hKgfmHxtMgokM67LZrcEQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQK-6A08+OCtOK20yRebBP_N1hKgfmHxtMgokM67LZrcEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/23 9:20 AM, Alexei Starovoitov wrote:
> On Tue, Aug 22, 2023 at 11:26 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
>>> This is the final fix for the use-after-free scenario described in
>>> commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
>>> non-owning refs"). That commit, by virtue of changing
>>> bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
>>> the "refcount incr on 0" splat. The not_zero check in
>>> refcount_inc_not_zero, though, still occurs on memory that could have
>>> been free'd and reused, so the commit didn't properly fix the root
>>> cause.
>>>
>>> This patch actually fixes the issue by free'ing using the recently-added
>>> bpf_mem_free_rcu, which ensures that the memory is not reused until
>>> RCU grace period has elapsed. If that has happened then
>>> there are no non-owning references alive that point to the
>>> recently-free'd memory, so it can be safely reused.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>    kernel/bpf/helpers.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index eb91cae0612a..945a85e25ac5 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
>>>
>>>        if (rec)
>>>                bpf_obj_free_fields(rec, p);
>>
>> During reviewing my percpu kptr patch with link
>>
>> https://lore.kernel.org/bpf/20230814172809.1361446-1-yonghong.song@linux.dev/T/#m2f7631b8047e9f5da60a0a9cd8717fceaf1adbb7
>> Kumar mentioned although percpu memory itself is freed under rcu.
>> But its record fields are freed immediately. This will cause
>> the problem since there may be some active uses of these fields
>> within rcu cs and after bpf_obj_free_fields(), some fields may
>> be re-initialized with new memory but they do not have chances
>> to free any more.
>>
>> Do we have problem here as well?
> 
> I think it's not an issue here or in your percpu patch,
> since bpf_obj_free_fields() calls __bpf_obj_drop_impl() which will
> call bpf_mem_free_rcu() (after this patch set lands).

The following is my understanding.

void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
{
         const struct btf_field *fields;
         int i;

         if (IS_ERR_OR_NULL(rec))
                 return;
         fields = rec->fields;
         for (i = 0; i < rec->cnt; i++) {
                 struct btf_struct_meta *pointee_struct_meta;
                 const struct btf_field *field = &fields[i];
                 void *field_ptr = obj + field->offset;
                 void *xchgd_field;

                 switch (fields[i].type) {
                 case BPF_SPIN_LOCK:
                         break;
                 case BPF_TIMER:
                         bpf_timer_cancel_and_free(field_ptr);
                         break;
                 case BPF_KPTR_UNREF:
                         WRITE_ONCE(*(u64 *)field_ptr, 0);
                         break;
                 case BPF_KPTR_REF:
			......
                         break;
                 case BPF_LIST_HEAD:
                         if (WARN_ON_ONCE(rec->spin_lock_off < 0))
                                 continue;
                         bpf_list_head_free(field, field_ptr, obj + 
rec->spin_lock_off);
                         break;
                 case BPF_RB_ROOT:
                         if (WARN_ON_ONCE(rec->spin_lock_off < 0))
                                 continue;
                         bpf_rb_root_free(field, field_ptr, obj + 
rec->spin_lock_off);
                         break;
                 case BPF_LIST_NODE:
                 case BPF_RB_NODE:
                 case BPF_REFCOUNT:
                         break;
                 default:
                         WARN_ON_ONCE(1);
                         continue;
                 }
         }
}

For percpu kptr, the remaining possible actiionable fields are
	BPF_LIST_HEAD and BPF_RB_ROOT

So BPF_LIST_HEAD and BPF_RB_ROOT will try to go through all
list/rb nodes to unlink them from the list_head/rb_root.

So yes, rb_nodes and list nodes will call __bpf_obj_drop_impl().
Depending on whether the correspondingrec
with rb_node/list_node has ref count or not,
it may call bpf_mem_free() or bpf_mem_free_rcu(). If
bpf_mem_free() is called, then the field is immediately freed
but it may be used by some bpf prog (under rcu) concurrently,
could this be an issue? Changing bpf_mem_free() in
__bpf_obj_drop_impl() to bpf_mem_free_rcu() should fix this problem.

Another thing is related to list_head/rb_root.
During bpf_obj_free_fields(), is it possible that another cpu
may allocate a list_node/rb_node and add to list_head/rb_root?
If this is true, then we might have a memory leak.
But I don't whether this is possible or not.

I think local kptr has the issue as percpu kptr.

> 
> In other words all bpf pointers are either properly life time
> checked through the verifier and freed via immediate bpf_mem_free()
> or they're bpf_mem_free_rcu().
> 
> 
>>
>> I am thinking whether I could create another flavor of bpf_mem_free_rcu
>> with a pre_free_callback function, something like
>>     bpf_mem_free_rcu_cb2(struct bpf_mem_alloc *ma, void *ptr,
>>         void (*cb)(void *, void *), void *arg1, void *arg2)
>>
>> The cb(arg1, arg2) will be called right before the real free of "ptr".
>>
>> For example, for this patch, the callback function can be
>>
>> static bpf_obj_free_fields_cb(void *rec, void *p)
>> {
>>          if (rec)
>>                  bpf_obj_free_fields(rec, p);
>>                  /* we need to ensure recursive freeing fields free
>>                   * needs to be done immediately, which means we will
>>                   * add a parameter to __bpf_obj_drop_impl() to
>>                   * indicate whether bpf_mem_free or bpf_mem_free_rcu
>>                   * should be called.
>>                   */
>> }
>>
>> bpf_mem_free_rcu_cb2(&bpf_global_ma, p, bpf_obj_free_fields_cb, rec, p);
> 
> It sounds nice in theory, but will be difficult to implement.
> bpf_ma would need to add extra two 8 byte pointers for every object,
> but there is no room at present. So to free after rcu gp with a callback
> it would need to allocate 16 byte (at least) which might fail and so on.
> bpf_mem_free_rcu_cb2() would be the last resort.

I don't like this either. I hope we can find better solutions than this.

