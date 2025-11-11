Return-Path: <bpf+bounces-74228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70831C4E3EE
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDFE3A79D5
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526D32BF20;
	Tue, 11 Nov 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLlEFHoi"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3942DF15F
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869183; cv=none; b=IWozQ7m/9k87drzcBdmBDfnbSYl7xuT36eoqRr9QDy359ow56Jm9irP0TLFOP77iFY20C13VGMexLmHc+tTH5aKi2FpP25xUUz+Dy1LL7gMDk5Smepo9/o6eKTB4qBi1zNTJrPZrrr40yVK0fQJilT8CpvdAAEJQA0lxSAdpkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869183; c=relaxed/simple;
	bh=wBbcbJWqmPiiZ6PP5axPAAmcItPUcBfZrVlI/kVkEb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ImLni86a10B1cMWCZbI8nEoIOWB2sjp+aiG22mZ6my9U5fR2AP7xulnpLswCzVRiJe21sNxTT1u3506+emzuEa2pTvXqZ2n7P+WvX+vLVZIGVCr8Hbri2bNqo09u1OSjAu8+mPrfgNo9djDywfiOM9w9maFItRCfXUPZmuISUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLlEFHoi; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22251785-789d-43f8-8031-86406cd4c12b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762869179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjtgKmBvNNQ5YHYpzf8UsFzZziq//kwzZtTybo0p1L8=;
	b=pLlEFHoiqo6/fkSQ7G35nWlAvIY+R+s2iPCzETNYr0ikqcMd6rjvwLokADPdN/taQhaaxE
	HtoBKZVAMMLiI8vMKOD0zaOl53qImyVBhn4egwZ/g3azXMYvUV7qGOeDGvkP1GZfQkTzgF
	aO6Qw0tgV4HSCLdKukMYHeI5kflM4/c=
Date: Tue, 11 Nov 2025 21:52:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Add test to verify freeing
 the special fields when update [lru_,]percpu_hash maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251105151407.12723-1-leon.hwang@linux.dev>
 <20251105151407.12723-3-leon.hwang@linux.dev>
 <9f662e2c-7370-4f99-bdec-bc123495e1c5@linux.dev>
 <04c35045-ef5b-4e92-9da9-6710ce8fdabf@linux.dev>
Content-Language: en-US
In-Reply-To: <04c35045-ef5b-4e92-9da9-6710ce8fdabf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/11 21:38, Leon Hwang wrote:
> 
> 
> On 2025/11/7 10:00, Yonghong Song wrote:
>>
>>
>> On 11/5/25 7:14 AM, Leon Hwang wrote:
>>> Add test to verify that updating [lru_,]percpu_hash maps decrements
>>> refcount when BPF_KPTR_REF objects are involved.
>>>
>>> The tests perform the following steps:
>>>
>>> 1. Call update_elem() to insert an initial value.
>>> 2. Use bpf_refcount_acquire() to increment the refcount.
>>> 3. Store the node pointer in the map value.
>>> 4. Add the node to a linked list.
>>> 5. Probe-read the refcount and verify it is *2*.
>>> 6. Call update_elem() again to trigger refcount decrement.
>>> 7. Probe-read the refcount and verify it is *1*.
>>>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>
>> LGTM with a few nits below.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
> 
> Hi Yonghong,
> 
> Thanks for your review and ack.
> 
>>> ---
>>>   .../bpf/prog_tests/refcounted_kptr.c          | 57 ++++++++++++++++++
>>>   .../selftests/bpf/progs/refcounted_kptr.c     | 60 +++++++++++++++++++
>>>   2 files changed, 117 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>>> b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>>> index d6bd5e16e6372..086f679fa3f61 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>>> @@ -44,3 +44,60 @@ void test_refcounted_kptr_wrong_owner(void)
>>>       ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
>>>       refcounted_kptr__destroy(skel);
>>>   }
>>> +
>>> +void test_percpu_hash_refcounted_kptr_refcount_leak(void)
>>> +{
>>> +    struct refcounted_kptr *skel;
>>> +    int cpu_nr, fd, err, key = 0;
>>> +    struct bpf_map *map;
>>> +    size_t values_sz;
>>> +    u64 *values;
>>> +    LIBBPF_OPTS(bpf_test_run_opts, opts,
>>> +            .data_in = &pkt_v4,
>>> +            .data_size_in = sizeof(pkt_v4),
>>> +            .repeat = 1,
>>> +    );
>>> +
>>> +    cpu_nr = libbpf_num_possible_cpus();
>>> +    if (!ASSERT_GT(cpu_nr, 0, "libbpf_num_possible_cpus"))
>>> +        return;
>>> +
>>> +    values = calloc(cpu_nr, sizeof(u64));
>>> +    if (!ASSERT_OK_PTR(values, "calloc values"))
>>> +        return;
>>> +
>>> +    skel = refcounted_kptr__open_and_load();
>>> +    if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load")) {
>>> +        free(values);
>>> +        return;
>>> +    }
>>> +
>>> +    values_sz = cpu_nr * sizeof(u64);
>>> +    memset(values, 0, values_sz);
>>> +
>>> +    map = skel->maps.percpu_hash;
>>> +    err = bpf_map__update_elem(map, &key, sizeof(key), values,
>>> values_sz, 0);
>>> +    if (!ASSERT_OK(err, "bpf_map__update_elem"))
>>> +        goto out;
>>> +
>>> +    fd = bpf_program__fd(skel->progs.percpu_hash_refcount_leak);
>>> +    err = bpf_prog_test_run_opts(fd, &opts);
>>> +    if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
>>> +        goto out;
>>> +    if (!ASSERT_EQ(opts.retval, 2, "opts.retval"))
>>> +        goto out;
>>> +
>>> +    err = bpf_map__update_elem(map, &key, sizeof(key), values,
>>> values_sz, 0);
>>> +    if (!ASSERT_OK(err, "bpf_map__update_elem"))
>>> +        goto out;
>>> +
>>> +    fd = bpf_program__fd(skel->progs.check_percpu_hash_refcount);
>>> +    err = bpf_prog_test_run_opts(fd, &opts);
>>> +    ASSERT_OK(err, "bpf_prog_test_run_opts");
>>> +    ASSERT_EQ(opts.retval, 1, "opts.retval");
>>> +
>>> +out:
>>> +    refcounted_kptr__destroy(skel);
>>> +    free(values);
>>> +}
>>> +
>>
>> Empty line here.
>>
>>> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/
>>> tools/testing/selftests/bpf/progs/refcounted_kptr.c
>>> index 893a4fdb4b6e9..1aca85d86aebc 100644
>>> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>>> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>>> @@ -568,4 +568,64 @@ int
>>> BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
>>>       return 0;
>>>   }
>>>   +private(kptr_ref) u64 ref;
>>> +
>>> +static int probe_read_refcount(void)
>>> +{
>>> +    u32 refcount;
>>> +
>>> +    bpf_probe_read_kernel(&refcount, sizeof(refcount), (void *) ref);
>>> +    return refcount;
>>> +}
>>> +
>>> +static int __insert_in_list(struct bpf_list_head *head, struct
>>> bpf_spin_lock *lock,
>>> +                struct node_data __kptr **node)
>>> +{
>>> +    struct node_data *node_new, *node_ref, *node_old;
>>> +
>>> +    node_new = bpf_obj_new(typeof(*node_new));
>>> +    if (!node_new)
>>> +        return -1;
>>> +
>>> +    node_ref = bpf_refcount_acquire(node_new);
>>> +    node_old = bpf_kptr_xchg(node, node_new);
>>
>> Change the above to node_old = bpf_kptr_xchg(node, node_node_ref); might
>> be better for reasoning although node_ref/node_new are the same.
>>
> 
> Nope — node_ref and node_new are different for the verifier.

They are the same in theory.

The verifier failure was likely caused by something else, but I'm not
sure of the exact reason.

> 
> When trying node_old = bpf_kptr_xchg(node, node_ref), the verifier reported:
> 
> [verifier log snipped for brevity...]
> ; bpf_obj_drop(node_ref); @ refcounted_kptr.c:594
> 26: (bf) r1 = r6                      ; R1=scalar(id=7) R6=scalar(id=7)
> refs=3
> 27: (b7) r2 = 0                       ; R2=0 refs=3
> 28: (85) call bpf_obj_drop_impl#54490
> R1 must be referenced or trusted
> processed 27 insns (limit 1000000) max_states_per_insn 0 total_states 2
> peak_states 2 mark_read 0
> 
> So the verifier rejected it because R6 became scalar(id=7) from
> ptr_node_data(ref_obj_id=4).
> 
> ---
> 
> Hi Alexei, could you please drop the extra empty line when applying this
> patch?
> 
> Then I don't need to send another revision.
> 
> Thanks,
> Leon
> 
> [...]
> 


