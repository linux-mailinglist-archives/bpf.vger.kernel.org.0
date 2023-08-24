Return-Path: <bpf+bounces-8442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3C78666D
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 05:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BD51C20D9D
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA06B187F;
	Thu, 24 Aug 2023 03:53:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824124528
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:53:52 +0000 (UTC)
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C11BC1
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 20:53:25 -0700 (PDT)
Message-ID: <d95feb80-89d3-920e-0717-df2eb9188217@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692849152; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMWVs7IOGPMEreCKXCiduGv5FoZipkHhPVLArKBZvsg=;
	b=GwAv1URa2qZNIb4sNjnl4H0bMAoQoWv/HCNydZrncQdFKc8Hy8XSttdfcNfR3lvuiET/J8
	Wq+Pdn8jZd1QxoQA2bBU4y1W5Ak+ycljqmk0p+IngApyDOENAfLi1FunTDSsGSgSdoI2j1
	SCE8oHnCwrzBVw3vUEEubYfvC2KEclA=
Date: Wed, 23 Aug 2023 20:52:25 -0700
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
 <71152843-d35d-4165-6410-0aa30a4c0f74@linux.dev>
 <CAADnVQKuAaYhd05XqXzwe=UuAXnV67UUc6MNWH5mgvLozTkSUw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKuAaYhd05XqXzwe=UuAXnV67UUc6MNWH5mgvLozTkSUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/23 6:38 PM, Alexei Starovoitov wrote:
> On Wed, Aug 23, 2023 at 1:29 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 8/23/23 9:20 AM, Alexei Starovoitov wrote:
>>> On Tue, Aug 22, 2023 at 11:26 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
>>>>> This is the final fix for the use-after-free scenario described in
>>>>> commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
>>>>> non-owning refs"). That commit, by virtue of changing
>>>>> bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
>>>>> the "refcount incr on 0" splat. The not_zero check in
>>>>> refcount_inc_not_zero, though, still occurs on memory that could have
>>>>> been free'd and reused, so the commit didn't properly fix the root
>>>>> cause.
>>>>>
>>>>> This patch actually fixes the issue by free'ing using the recently-added
>>>>> bpf_mem_free_rcu, which ensures that the memory is not reused until
>>>>> RCU grace period has elapsed. If that has happened then
>>>>> there are no non-owning references alive that point to the
>>>>> recently-free'd memory, so it can be safely reused.
>>>>>
>>>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>> ---
>>>>>     kernel/bpf/helpers.c | 6 +++++-
>>>>>     1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>>> index eb91cae0612a..945a85e25ac5 100644
>>>>> --- a/kernel/bpf/helpers.c
>>>>> +++ b/kernel/bpf/helpers.c
>>>>> @@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
>>>>>
>>>>>         if (rec)
>>>>>                 bpf_obj_free_fields(rec, p);
>>>>
>>>> During reviewing my percpu kptr patch with link
>>>>
>>>> https://lore.kernel.org/bpf/20230814172809.1361446-1-yonghong.song@linux.dev/T/#m2f7631b8047e9f5da60a0a9cd8717fceaf1adbb7
>>>> Kumar mentioned although percpu memory itself is freed under rcu.
>>>> But its record fields are freed immediately. This will cause
>>>> the problem since there may be some active uses of these fields
>>>> within rcu cs and after bpf_obj_free_fields(), some fields may
>>>> be re-initialized with new memory but they do not have chances
>>>> to free any more.
>>>>
>>>> Do we have problem here as well?
>>>
>>> I think it's not an issue here or in your percpu patch,
>>> since bpf_obj_free_fields() calls __bpf_obj_drop_impl() which will
>>> call bpf_mem_free_rcu() (after this patch set lands).
>>
>> The following is my understanding.
>>
>> void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>> {
>>           const struct btf_field *fields;
>>           int i;
>>
>>           if (IS_ERR_OR_NULL(rec))
>>                   return;
>>           fields = rec->fields;
>>           for (i = 0; i < rec->cnt; i++) {
>>                   struct btf_struct_meta *pointee_struct_meta;
>>                   const struct btf_field *field = &fields[i];
>>                   void *field_ptr = obj + field->offset;
>>                   void *xchgd_field;
>>
>>                   switch (fields[i].type) {
>>                   case BPF_SPIN_LOCK:
>>                           break;
>>                   case BPF_TIMER:
>>                           bpf_timer_cancel_and_free(field_ptr);
>>                           break;
>>                   case BPF_KPTR_UNREF:
>>                           WRITE_ONCE(*(u64 *)field_ptr, 0);
>>                           break;
>>                   case BPF_KPTR_REF:
>>                          ......
>>                           break;
>>                   case BPF_LIST_HEAD:
>>                           if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>>                                   continue;
>>                           bpf_list_head_free(field, field_ptr, obj +
>> rec->spin_lock_off);
>>                           break;
>>                   case BPF_RB_ROOT:
>>                           if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>>                                   continue;
>>                           bpf_rb_root_free(field, field_ptr, obj +
>> rec->spin_lock_off);
>>                           break;
>>                   case BPF_LIST_NODE:
>>                   case BPF_RB_NODE:
>>                   case BPF_REFCOUNT:
>>                           break;
>>                   default:
>>                           WARN_ON_ONCE(1);
>>                           continue;
>>                   }
>>           }
>> }
>>
>> For percpu kptr, the remaining possible actiionable fields are
>>          BPF_LIST_HEAD and BPF_RB_ROOT
>>
>> So BPF_LIST_HEAD and BPF_RB_ROOT will try to go through all
>> list/rb nodes to unlink them from the list_head/rb_root.
>>
>> So yes, rb_nodes and list nodes will call __bpf_obj_drop_impl().
>> Depending on whether the correspondingrec
>> with rb_node/list_node has ref count or not,
>> it may call bpf_mem_free() or bpf_mem_free_rcu(). If
>> bpf_mem_free() is called, then the field is immediately freed
>> but it may be used by some bpf prog (under rcu) concurrently,
>> could this be an issue?
> 
> I see. Yeah. Looks like percpu makes such fields refcount-like.
> For non-percpu non-refcount only one bpf prog on one cpu can observe
> that object. That's why we're doing plain bpf_mem_free() for them.
> 
> So this patch is a good fix for refcounted, but you and Kumar are
> correct that it's not sufficient for the case when percpu struct
> includes multiple rb_roots. One for each cpu.
> 
>> Changing bpf_mem_free() in
>> __bpf_obj_drop_impl() to bpf_mem_free_rcu() should fix this problem.
> 
> I guess we can do that when obj is either refcount or can be
> insider percpu, but it might not be enough. More below.
> 
>> Another thing is related to list_head/rb_root.
>> During bpf_obj_free_fields(), is it possible that another cpu
>> may allocate a list_node/rb_node and add to list_head/rb_root?
> 
> It's not an issue for the single owner case and for refcounted.
> Access to rb_root/list_head is always lock protected.
> For refcounted the obj needs to be acquired (from the verifier pov)
> meaning to have refcount =1 to be able to do spin_lock and
> operate on list_head.

Martin and I came up with the following example early today like below,
assuming the map value struct contains a list_head and a spin_lock.

          cpu 0                              cpu 1
       key = 1;
       v = bpf_map_lookup(&map, &key);
                                         key = 1;
                                         bpf_map_delete_elem(&map, &key);
                                         /* distruction continues and
                                          * bpf_obj_free_fields() are
                                          * called.
                                          */
                                         /* in bpf_list_head_free():
                                          * __bpf_spin_lock_irqsave(...)
                                          * ...
                                          * __bpf_spin_unlock_irqrestore();
                                          */

       n = bpf_obj_new(...)
       bpf_spin_lock(&v->lock);
       bpf_list_push_front(&v->head, &v->node);
       bpf_spin_lock(&v->lock);

In cpu 1 'bpf_obj_free_fields', there is a list head, so
bpf_list_head_free() is called. In bpf_list_head_free(), we do

         __bpf_spin_lock_irqsave(spin_lock);
         if (!head->next || list_empty(head))
                 goto unlock;
         head = head->next;
unlock:
         INIT_LIST_HEAD(orig_head);
         __bpf_spin_unlock_irqrestore(spin_lock);

         while (head != orig_head) {
                 void *obj = head;

                 obj -= field->graph_root.node_offset;
                 head = head->next;
                 /* The contained type can also have resources, including a
                  * bpf_list_head which needs to be freed.
                  */
                 migrate_disable();
                 __bpf_obj_drop_impl(obj, field->graph_root.value_rec);
                 migrate_enable();
         }

So it is possible the cpu 0 may add one element to the list_head
which will never been freed.

This happens to say list_head or rb_root too. I am aware that
this may be an existing issue for some maps, e.g. hash map.
So it may not be a big problem. Just want to mention this though.

> 
> But bpf_rb_root_free is indeed an issue for percpu, since each
> percpu has its own rb root field with its own bpf_spinlock, but
> for_each_cpu() {bpf_obj_free_fields();} violates access contract.

Could you explain what 'access contract' mean here? For non-percpu
case, 'x' special fields may be checked. For percpu case, it is
just 'x * nr_cpus' special fields to be checked.

> 
> percpu and rb_root creates such a maze of dependencies that
> I think it's better to disallow rb_root-s and kptr-s inside percpu
> for now.

I can certainly disallow rb_root and list_head. Just want to
understand what kind of issues we face specially for percpu kptr.

Current kptrs cannot be nested since the first argument of
bpf_kptr_xchg() must be a map_value. So only impactful fields
(w.r.t. bpf_obj_free_fields()) are rb_root and list_head.

> 
>> If this is true, then we might have a memory leak.
>> But I don't whether this is possible or not.
>>
>> I think local kptr has the issue as percpu kptr.
> 
> Let's tackle one at a time.
> I still think Dave's patch set is a good fix for recounted,
> while we need to think more about percpu case.

I agree that Dave's patch indeed fixed an existing issue.
We can resolve other issues (like above) gradually.

