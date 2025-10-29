Return-Path: <bpf+bounces-72817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F72C1BDF9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612DA465A89
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97EF2C11EB;
	Wed, 29 Oct 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k42z7LLh"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1828469E
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749955; cv=none; b=tarh4C5Yk0ECr05lz5lRjDCnujMKRYMjyZv5Nk/z5C4M3FdC753M98WOpH4OOq1pMzrOimnuO5lSuUp63X1/c9g99RUI1bK/12kHJzJca1H3bFZl0JlzymBYZtct+XaQ6iUdQJr3xVsOV0LZdGmmq8cpbS1NGPRcGuHRVd7YgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749955; c=relaxed/simple;
	bh=il83HUFisxYaHb+3aHy2CKREbiZN8XyIVWIzvVft0MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYxZCzdKhk6dCeNXm2O2xpbHkMUYK6IxnMn9zbugxmmDXGTi3sz3JwVQuqnJBfYZK2TvbmhsF7aHRg9jNppEBxvWabWSEMy4qYU0MGr10EVpqb8mVnygUIDDBcrj+Y/CKn6+YWT/VFtlatD5Ne+OqKKsw4uDO7mcMp8F/Z2s7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k42z7LLh; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a798d47e-4ab8-423a-b8ef-e42ff9760324@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761749939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GBtMnyXtOy6IbhuD6W3L/20izTM7y/rPg3EMOICW6o=;
	b=k42z7LLh/xIZfFTqvRTH8lwSP1acaTkA/+2+/XcdMa1O/sF3l00ko5HHyxNGl3njtHwV3V
	vaviUQNbSIQrXv7uX/f5/NIz+xGK4eFttRYJmGUekZBBmH9b3w+v8lHW03c2CVvMNPApfC
	PrvUIHZai58CUVTSevF2XCyaN2ygoMw=
Date: Wed, 29 Oct 2025 22:58:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Add tests to verify freeing the
 special fields when update hash and local storage maps
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251026154000.34151-1-leon.hwang@linux.dev>
 <20251026154000.34151-5-leon.hwang@linux.dev>
 <CAMB2axN6bsrMH6_qVz9eHY1HLp6SQmM-nOUEXUOOiibZFMzXMw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAMB2axN6bsrMH6_qVz9eHY1HLp6SQmM-nOUEXUOOiibZFMzXMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/28 00:34, Amery Hung wrote:
> On Sun, Oct 26, 2025 at 8:42 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Add tests to verify that updating hash and local storage maps decrements
>> refcount when BPF_KPTR_REF objects are involved.
>>
>> The tests perform the following steps:
>>
>> 1. Call update_elem() to insert an initial value.
>> 2. Use bpf_refcount_acquire() to increment the refcount.
>> 3. Store the node pointer in the map value.
>> 4. Add the node to a linked list.
>> 5. Probe-read the refcount and verify it is *2*.
>> 6. Call update_elem() again to trigger refcount decrement.
>> 7. Probe-read the refcount and verify it is *1*.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  .../bpf/prog_tests/refcounted_kptr.c          | 178 +++++++++++++++++-
>>  .../selftests/bpf/progs/refcounted_kptr.c     | 160 ++++++++++++++++
>>  2 files changed, 337 insertions(+), 1 deletion(-)
>>

[...]

>> @@ -44,3 +44,179 @@ void test_refcounted_kptr_wrong_owner(void)
>>         ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
>>         refcounted_kptr__destroy(skel);
>>  }
>> +
>> +static void test_refcnt_leak(void *values, size_t values_sz, u64 flags, struct bpf_map *map,
>> +                            struct bpf_program *prog_leak, struct bpf_program *prog_check)
>> +{

[...]

>> +}
>
> Just use syscall BPF programs across different subtests, and you can
> share this test_refcnt_leak() across subtests.
>
> It also saves you some code setting up bpf_test_run_opts. You can just
> call bpf_prog_test_run_opts(prog_fd, NULL) as you don't pass any input
> from ctx.
>
>> +
>> +static void test_percpu_hash_refcount_leak(void)
>> +{

[...]

>> +out:
>> +       close(cgroup);
>> +       refcounted_kptr__destroy(skel);
>> +       if (client_fd >= 0)
>> +               close(client_fd);
>> +       if (server_fd >= 0)
>> +               close(server_fd);
>> +}
>
> Then, you won't need to set up server, connection.... just to
> read/write cgroup local storage. Just call test_refcnt_leak() that
> runs the two BPF syscall programs for cgroup local storage.
>

[...]

>
>
> And in syscall BPF program, you can simply get the cgroup through the
> current task
>
> SEC("syscall")
> int syscall_prog(void *ctx)
> {
>         struct task_struct *task = bpf_get_current_task_btf();
>
>         v = bpf_cgrp_storage_get(&cgrp_strg, task->cgroups->dfl_cgrp, 0,
>                                BPF_LOCAL_STORAGE_GET_F_CREATE);
>         ...
> }
>

Hi Amery,

Thanks for the suggestion.

I tried your approach, but the verifier rejected it with the following
error:

0: R1=ctx() R10=fp0
; task = bpf_get_current_task_btf(); @ refcounted_kptr.c:686
0: (85) call bpf_get_current_task_btf#158     ; R0=trusted_ptr_task_struct()
; v = bpf_cgrp_storage_get(&cgrp_strg, task->cgroups->dfl_cgrp, 0, @
refcounted_kptr.c:687
1: (79) r1 = *(u64 *)(r0 +4856)       ; R0=trusted_ptr_task_struct()
R1=untrusted_ptr_css_set()
2: (79) r2 = *(u64 *)(r1 +96)         ; R1=untrusted_ptr_css_set()
R2=untrusted_ptr_cgroup()
3: (18) r1 = 0xffffa1b442a4b800       ; R1=map_ptr(map=cgrp_strg,ks=4,vs=16)
5: (b7) r3 = 0                        ; R3=0
6: (b7) r4 = 1                        ; R4=1
7: (85) call bpf_cgrp_storage_get#210
R2 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_
processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

The issue is that dereferencing task->cgroups->dfl_cgrp results in an
untrusted pointer, which bpf_cgrp_storage_get() doesn't accept in
syscall programs. I will investigate the issue later.

However, while searching for 'task->cgroups->dfl_cgrp' usage in the
selftests, I found that bpf_cgrp_storage_get() works fine in fentry
programs. This approach also has the benefit of avoiding the cgroup
setup and client/server infrastructure.

I'll respin the selftest using fentry programs instead.

Thanks,
Leon

[...]

