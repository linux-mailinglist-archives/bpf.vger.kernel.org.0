Return-Path: <bpf+bounces-17102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADCE809ABD
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31C41C20D1F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB44A35;
	Fri,  8 Dec 2023 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fhjxuq7h"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD11708
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:59:19 -0800 (PST)
Message-ID: <969852f3-34f8-45d9-bf2d-f6a4d5167e55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702007957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWomjvLuH3X/N2Te8k+8sOxFI8mcNJUVmZM7qI3EkbQ=;
	b=Fhjxuq7hW8zxctV6g7T1nDmEGH+rRiPJEs1BjIttuj9WtjHIyWzpFEzo5hgz34Ey7n+hpa
	9/YLdGgdD2RuZj0B4DIYC5XM/BZVOWosNzY3HR+uZc7Au70PUwh51lv+dVhdqEB8Ej9naD
	TNOmEaRjZMPgWfNrkpcAjzJYJvmspgo=
Date: Thu, 7 Dec 2023 19:59:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] bpf: Fix a race condition between btf_put()
 and map_free()
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Hou Tao <houtao@huaweicloud.com>,
 bpf@vger.kernel.org
References: <20231206210959.1035724-1-yonghong.song@linux.dev>
 <d1c0232c-a41c-4cce-9bdf-3a1e8850ed05@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d1c0232c-a41c-4cce-9bdf-3a1e8850ed05@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/7/23 5:23 PM, Martin KaFai Lau wrote:
> On 12/6/23 1:09 PM, Yonghong Song wrote:
>> When running `./test_progs -j` in my local vm with latest kernel,
>> I once hit a kasan error like below:
>>
>>    [ 1887.184724] BUG: KASAN: slab-use-after-free in 
>> bpf_rb_root_free+0x1f8/0x2b0
>>    [ 1887.185599] Read of size 4 at addr ffff888106806910 by task 
>> kworker/u12:2/2830
>>    [ 1887.186498]
>>    [ 1887.186712] CPU: 3 PID: 2830 Comm: kworker/u12:2 Tainted: 
>> G           OEL     6.7.0-rc3-00699-g90679706d486-dirty #494
>>    [ 1887.188034] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>> 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>    [ 1887.189618] Workqueue: events_unbound bpf_map_free_deferred
>>    [ 1887.190341] Call Trace:
>>    [ 1887.190666]  <TASK>
>>    [ 1887.190949]  dump_stack_lvl+0xac/0xe0
>>    [ 1887.191423]  ? nf_tcp_handle_invalid+0x1b0/0x1b0
>>    [ 1887.192019]  ? panic+0x3c0/0x3c0
>>    [ 1887.192449]  print_report+0x14f/0x720
>>    [ 1887.192930]  ? preempt_count_sub+0x1c/0xd0
>>    [ 1887.193459]  ? __virt_addr_valid+0xac/0x120
>>    [ 1887.194004]  ? bpf_rb_root_free+0x1f8/0x2b0
>>    [ 1887.194572]  kasan_report+0xc3/0x100
>>    [ 1887.195085]  ? bpf_rb_root_free+0x1f8/0x2b0
>>    [ 1887.195668]  bpf_rb_root_free+0x1f8/0x2b0
>>    [ 1887.196183]  ? __bpf_obj_drop_impl+0xb0/0xb0
>>    [ 1887.196736]  ? preempt_count_sub+0x1c/0xd0
>>    [ 1887.197270]  ? preempt_count_sub+0x1c/0xd0
>>    [ 1887.197802]  ? _raw_spin_unlock+0x1f/0x40
>>    [ 1887.198319]  bpf_obj_free_fields+0x1d4/0x260
>>    [ 1887.198883]  array_map_free+0x1a3/0x260
>>    [ 1887.199380]  bpf_map_free_deferred+0x7b/0xe0
>>    [ 1887.199943]  process_scheduled_works+0x3a2/0x6c0
>>    [ 1887.200549]  worker_thread+0x633/0x890
>>    [ 1887.201047]  ? __kthread_parkme+0xd7/0xf0
>>    [ 1887.201574]  ? kthread+0x102/0x1d0
>>    [ 1887.202020]  kthread+0x1ab/0x1d0
>>    [ 1887.202447]  ? pr_cont_work+0x270/0x270
>>    [ 1887.202954]  ? kthread_blkcg+0x50/0x50
>>    [ 1887.203444]  ret_from_fork+0x34/0x50
>>    [ 1887.203914]  ? kthread_blkcg+0x50/0x50
>>    [ 1887.204397]  ret_from_fork_asm+0x11/0x20
>>    [ 1887.204913]  </TASK>
>>    [ 1887.204913]  </TASK>
>>    [ 1887.205209]
>>    [ 1887.205416] Allocated by task 2197:
>>    [ 1887.205881]  kasan_set_track+0x3f/0x60
>>    [ 1887.206366]  __kasan_kmalloc+0x6e/0x80
>>    [ 1887.206856]  __kmalloc+0xac/0x1a0
>>    [ 1887.207293]  btf_parse_fields+0xa15/0x1480
>>    [ 1887.207836]  btf_parse_struct_metas+0x566/0x670
>>    [ 1887.208387]  btf_new_fd+0x294/0x4d0
>>    [ 1887.208851]  __sys_bpf+0x4ba/0x600
>>    [ 1887.209292]  __x64_sys_bpf+0x41/0x50
>>    [ 1887.209762]  do_syscall_64+0x4c/0xf0
>>    [ 1887.210222]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>>    [ 1887.210868]
>>    [ 1887.211074] Freed by task 36:
>>    [ 1887.211460]  kasan_set_track+0x3f/0x60
>>    [ 1887.211951]  kasan_save_free_info+0x28/0x40
>>    [ 1887.212485]  ____kasan_slab_free+0x101/0x180
>>    [ 1887.213027]  __kmem_cache_free+0xe4/0x210
>>    [ 1887.213514]  btf_free+0x5b/0x130
>>    [ 1887.213918]  rcu_core+0x638/0xcc0
>>    [ 1887.214347]  __do_softirq+0x114/0x37e
>>
>> The error happens at bpf_rb_root_free+0x1f8/0x2b0:
>>
>>    00000000000034c0 <bpf_rb_root_free>:
>>    ; {
>>      34c0: f3 0f 1e fa                   endbr64
>>      34c4: e8 00 00 00 00                callq   0x34c9 
>> <bpf_rb_root_free+0x9>
>>      34c9: 55                            pushq   %rbp
>>      34ca: 48 89 e5                      movq    %rsp, %rbp
>>    ...
>>    ;       if (rec && rec->refcount_off >= 0 &&
>>      36aa: 4d 85 ed                      testq   %r13, %r13
>>      36ad: 74 a9                         je      0x3658 
>> <bpf_rb_root_free+0x198>
>>      36af: 49 8d 7d 10                   leaq    0x10(%r13), %rdi
>>      36b3: e8 00 00 00 00                callq   0x36b8 
>> <bpf_rb_root_free+0x1f8>
>>                                          <==== kasan function
>>      36b8: 45 8b 7d 10                   movl    0x10(%r13), %r15d
>>                                          <==== use-after-free load
>>      36bc: 45 85 ff                      testl   %r15d, %r15d
>>      36bf: 78 8c                         js      0x364d 
>> <bpf_rb_root_free+0x18d>
>>
>> So the problem is at rec->refcount_off in the above.
>>
>> I did some source code analysis and find the reason.
>>                                    CPU A CPU B
>>    bpf_map_put:
>>      ...
>>      btf_put with rcu callback
>>      ...
>>      bpf_map_free_deferred
>>        with system_unbound_wq
>>      ...                          ... ...
>>      ...                          btf_free_rcu: ...
>>      ...                          ... bpf_map_free_deferred:
>>      ...                          ...
>>      ...         --------->       btf_struct_metas_free()
>>      ...         | race condition ...
>>      ... ---------> map->ops->map_free()
>>      ...
>>      ...                          btf->struct_meta_tab = NULL
>>
>> In the above, map_free() corresponds to array_map_free() and eventually
>> calling bpf_rb_root_free() which calls:
>>    ...
>>    __bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
>>    ...
>>
>> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with 
>> following code:
>>
>>    meta = btf_find_struct_meta(btf, btf_id);
>>    if (!meta)
>>      return -EFAULT;
>>    rec->fields[i].graph_root.value_rec = meta->record;
>>
>> So basically, 'value_rec' is a pointer to the record in 
>> struct_metas_tab.
>> And it is possible that that particular record has been freed by
>> btf_struct_metas_free() and hence we have a kasan error here.
>>
>> Actually it is very hard to reproduce the failure with current 
>> bpf/bpf-next
>> code, I only got the above error once. To increase reproducibility, I 
>> added
>> a delay in bpf_map_free_deferred() to delay map->ops->map_free(), which
>> significantly increased reproducibility.
>>
>>    diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>    index 5e43ddd1b83f..aae5b5213e93 100644
>>    --- a/kernel/bpf/syscall.c
>>    +++ b/kernel/bpf/syscall.c
>>    @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct 
>> work_struct *work)
>>          struct bpf_map *map = container_of(work, struct bpf_map, work);
>>          struct btf_record *rec = map->record;
>>
>>    +     mdelay(100);
>>          security_bpf_map_free(map);
>>          bpf_map_release_memcg(map);
>>          /* implementation dependent freeing */
>>
>> To fix the problem, we need to have a reference on btf in order to
>> safeguard accessing field->graph_root.value_rec in map->ops->map_free().
>> The function btf_parse_graph_root() is the place to get a btf reference.
>> The following are rough call stacks reaching bpf_parse_graph_root():
>>
>>     btf_parse
>>       ...
>>         btf_parse_fields
>>           ...
>>             btf_parse_graph_root
>>
>>     map_check_btf
>>       btf_parse_fields
>>         ...
>>           btf_parse_graph_root
>>
>> Looking at the above call stack, the btf_parse_graph_root() is 
>> indirectly
>> called from btf_parse() or map_check_btf().
>>
>> We cannot take a reference in btf_parse() case since at that moment,
>> btf is still in the middle to self-validation and initial reference
>> (refcount_set(&btf->refcnt, 1)) has not been triggered yet.
>
> Thanks for the details analysis and clear explanation. It helps a lot.
>
> Sorry for jumping in late.
>
> I am trying to avoid making a special case for "bool has_btf_ref;" and 
> "bool from_map_check". It seems to a bit too much to deal with the 
> error path for btf_parse().
>
> Would doing the refcount_set(&btf->refcnt, 1) earlier in btf_parse help?

No, it does not. The core reason is what Hao is mentioned in
   https://lore.kernel.org/bpf/47ee3265-23f7-2130-ff28-27bfaf3f7877@huaweicloud.com/
We simply cannot take btf reference if called from btf_parse().
Let us say we move refcount_set(&btf->refcnt, 1) earlier in btf_parse()
so we take ref for btf during btf_parse_fields(), then we have
      btf_put <=== expect refcount == 0 to start the destruction process
        ...
          btf_record_free <=== in which if graph_root, a btf reference will be hold
so btf_put will never be able to actually free btf data.
Yes, the kasan problem will be resolved but we leak memory.

>
>> It is also unnecessary to take a reference since the value_rec is
>> referring to a record in struct_meta_tab.
>
> If we optimize for not taking a refcnt, how about not taking a refcnt 
> for all cases and postpone the btf_put(), instead of taking refcnt in 
> one case but not another. Like your fix in v1. The failed selftest can 
> be changed or even removed if it does not make sense anymore.

After a couple of iterations, I think taking necessary reference approach sounds better
and this will be consistent with how kptr is handled. For kptr, btf_parse will ignore it.
Unfortunately, for graph_root (list_head, rb_root), btf_parse and map_check will both
process it and that adds a little bit complexity.
Alexei also suggested the same taking reference approach:
   https://lore.kernel.org/bpf/CAADnVQL+uc6VV65_Ezgzw3WH=ME9z1Fdy8Pd6xd0oOq8rgwh7g@mail.gmail.com/

>
>>
>> But we do need to take a reference for map_check_btf() case as
>> the value_rec refers to a record in struct_meta_tab and we want
>> to make sure btf is not freed until value_rec usage at map_free
>> is done.
>>
>> So the fix is to get a btf reference for map_check_btf() case
>> whenever a graph_root is found. A boolean field 'has_btf_ref' is 
>> added to
>> struct btf_field_graph_root so later the btf reference can be properly
>> released.
>>
>> Rerun './test_progs -j' with the above mdelay() hack for a couple
>> of times and didn't observe the error.
>> Running Hou's test ([1]) is also successful.
>>
>>    [1] 
>> https://lore.kernel.org/bpf/20231206110625.3188975-1-houtao@huaweicloud.com/
>>
>

