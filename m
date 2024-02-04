Return-Path: <bpf+bounces-21157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EEE848F9A
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD1A283195
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263F2377E;
	Sun,  4 Feb 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kyJrQPZe"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A1249E8
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066584; cv=none; b=uY6g4ryU2lMYUYa5YbLhm+O/0SxtS3QkN9gNLd9gtDx6go0A5ugiQ8rkZFfEiMTDBddg49t0arReOha8Bf96eTdOLaOwfHFpqGRqqbg8Ffe/aauwG2PzfKlykqxuOZiwXTwtNreTQrLysNpnjqVY8QcFSUFWYs0/EvyBBco6qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066584; c=relaxed/simple;
	bh=rqP/2I11fbuwqycfXfubF5tj0so2hvTRW5CbVLJ3xHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ3zrjdUZzRoGjhlyd6l55aqVA5YJKlnHtEASKC/iXEO8MU7/evgoyxaKhxdSxzOjkl3B98cCeavj/9hE5/Nc/++A/4jcZlJSFkBHlIX4yjVYkvN4wYAJAE2QB0lTm6eo0CZAzj9oAAYDoUlpqH7aql+FM71gIkK5KY21Cbjs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kyJrQPZe; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5497a6a9-1b41-4605-8220-041e5dff46f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707066579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUMo/p3gVGGo/CF7fNXWdrF7LnxEOlkoHqHMuzt+oVo=;
	b=kyJrQPZeKU0+IGQDDUSEBmjYHJ50sZdyrS0T9wV2ZDvy9E1gvIWDuniaJqNKMa4fqJe0jW
	FgJ8RpUstktuCT3X56sj4D3uZjUK+GHu2OZbPs2spaP1qTpsngixIXq/tVFg0NQMea/yFO
	Zw2Jj55lTzldU424zHYDgedEIhHT22c=
Date: Sun, 4 Feb 2024 09:09:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask
 iter
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 tj@kernel.org, void@manifault.com, bpf@vger.kernel.org
References: <20240131145454.86990-1-laoar.shao@gmail.com>
 <20240131145454.86990-5-laoar.shao@gmail.com>
 <CAEf4Bzanfe3X3NMce=WKg7LMdVU=USzc+NZw+4gViU6HJ18Ptw@mail.gmail.com>
 <CALOAHbApjK3MO+Hn-TiW9jR1cJuNEP9uHxZ=4WBMYLMrOANKLA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CALOAHbApjK3MO+Hn-TiW9jR1cJuNEP9uHxZ=4WBMYLMrOANKLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/3/24 7:30 PM, Yafang Shao wrote:
> On Sat, Feb 3, 2024 at 6:03 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Wed, Jan 31, 2024 at 6:55 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>> Add selftests for the newly added cpumask iter.
>>> - cpumask_iter_success
>>>    - The number of CPUs should be expected when iterating over the cpumask
>>>    - percpu data extracted from the percpu struct should be expected
>>>    - It can work in both non-sleepable and sleepable prog
>>>    - RCU lock is only required by bpf_iter_cpumask_new()
>>>    - It is fine without calling bpf_iter_cpumask_next()
>>>
>>> - cpumask_iter_failure
>>>    - RCU lock is required in sleepable prog
>>>    - The cpumask to be iterated over can't be NULL
>>>    - bpf_iter_cpumask_destroy() is required after calling
>>>      bpf_iter_cpumask_new()
>>>    - bpf_iter_cpumask_destroy() can only destroy an initilialized iter
>>>    - bpf_iter_cpumask_next() must use an initilialized iter
>> typos: initialized
> will fix it.
>
>>> The result as follows,
>>>
>>>    #64/37   cpumask/test_cpumask_iter:OK
>>>    #64/38   cpumask/test_cpumask_iter_sleepable:OK
>>>    #64/39   cpumask/test_cpumask_iter_sleepable:OK
>>>    #64/40   cpumask/test_cpumask_iter_next_no_rcu:OK
>>>    #64/41   cpumask/test_cpumask_iter_no_next:OK
>>>    #64/42   cpumask/test_cpumask_iter:OK
>>>    #64/43   cpumask/test_cpumask_iter_no_rcu:OK
>>>    #64/44   cpumask/test_cpumask_iter_no_destroy:OK
>>>    #64/45   cpumask/test_cpumask_iter_null_pointer:OK
>>>    #64/46   cpumask/test_cpumask_iter_next_uninit:OK
>>>    #64/47   cpumask/test_cpumask_iter_destroy_uninit:OK
>>>    #64      cpumask:OK
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> ---
>>>   tools/testing/selftests/bpf/config            |   1 +
>>>   .../selftests/bpf/prog_tests/cpumask.c        | 152 ++++++++++++++++++
>>>   .../selftests/bpf/progs/cpumask_common.h      |   3 +
>>>   .../bpf/progs/cpumask_iter_failure.c          |  99 ++++++++++++
>>>   .../bpf/progs/cpumask_iter_success.c          | 126 +++++++++++++++
>>>   5 files changed, 381 insertions(+)
>>>   create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_failure.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_success.c
>>>
>> LGTM overall, except for seemingly unnecessary use of a big macro
>>
>>> diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
>>> index 0cd4aebb97cf..cdb9dc95e9d9 100644
>>> --- a/tools/testing/selftests/bpf/progs/cpumask_common.h
>>> +++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
>>> @@ -55,6 +55,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym
>>>   u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
>>>   u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const struct cpumask *src2) __ksym;
>>>   u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
>>> +int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpumask *mask) __ksym;
>>> +int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
>>> +void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;
>> let's mark them __weak so they don't conflict with definitions that
>> will eventually come from vmlinux.h (that applies to all the kfunc
>> definitions we currently have and we'll need to clean all that up, but
>> let's not add non-weak kfuncs going forward)
> will change it.
>
>>>   void bpf_rcu_read_lock(void) __ksym;
>>>   void bpf_rcu_read_unlock(void) __ksym;
>> [...]
>>
>>> diff --git a/tools/testing/selftests/bpf/progs/cpumask_iter_success.c b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
>>> new file mode 100644
>>> index 000000000000..4ce14ef98451
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
>>> @@ -0,0 +1,126 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
>>> +
>>> +#include "vmlinux.h"
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +
>>> +#include "task_kfunc_common.h"
>>> +#include "cpumask_common.h"
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +
>>> +extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
>>> +extern const struct rq runqueues __ksym __weak;
>>> +
>>> +int pid;
>>> +
>>> +#define READ_PERCPU_DATA(meta, cgrp, mask)                                                     \
>>> +{                                                                                              \
>>> +       u32 nr_running = 0, psi_nr_running = 0, nr_cpus = 0;                                    \
>>> +       struct psi_group_cpu *groupc;                                                           \
>>> +       struct rq *rq;                                                                          \
>>> +       int *cpu;                                                                               \
>>> +                                                                                               \
>>> +       bpf_for_each(cpumask, cpu, mask) {                                                      \
>>> +               rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);                            \
>>> +               if (!rq) {                                                                      \
>>> +                       err += 1;                                                               \
>>> +                       continue;                                                               \
>>> +               }                                                                               \
>>> +               nr_running += rq->nr_running;                                                   \
>>> +               nr_cpus += 1;                                                                   \
>>> +                                                                                               \
>>> +               groupc = (struct psi_group_cpu *)bpf_per_cpu_ptr(&system_group_pcpu, *cpu);     \
>>> +               if (!groupc) {                                                                  \
>>> +                       err += 1;                                                               \
>>> +                       continue;                                                               \
>>> +               }                                                                               \
>>> +               psi_nr_running += groupc->tasks[NR_RUNNING];                                    \
>>> +       }                                                                                       \
>>> +       BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",                  \
>>> +                      nr_running, nr_cpus, psi_nr_running);                                    \
>>> +}
>>> +
>> Does this have to be a gigantic macro? Why can't it be just a function?
> It seems that the verifier can't identify a function call between
> bpf_rcu_read_lock() and bpf_rcu_read_unlock().
> That said, if there's a function call between them, the verifier will fail.
> Below is the full verifier log if I define it as :
> static inline void read_percpu_data(struct bpf_iter_meta *meta, struct
> cgroup *cgrp, const cpumask_t *mask)
>
> VERIFIER LOG:
> =============
> 0: R1=ctx() R10=fp0
> ; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
> *meta, struct cgroup *cgrp)
> 0: (b4) w7 = 0                        ; R7_w=0
> ; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
> *meta, struct cgroup *cgrp)
> 1: (79) r2 = *(u64 *)(r1 +8)          ; R1=ctx()
> R2_w=trusted_ptr_or_null_cgroup(id=1)
> ; if (!cgrp)
> 2: (15) if r2 == 0x0 goto pc+16       ; R2_w=trusted_ptr_cgroup()
> ; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
> *meta, struct cgroup *cgrp)
> 3: (79) r6 = *(u64 *)(r1 +0)
> func 'bpf_iter_cgroup' arg0 has btf_id 10966 type STRUCT 'bpf_iter_meta'
> 4: R1=ctx() R6_w=trusted_ptr_bpf_iter_meta()
> ; bpf_rcu_read_lock();
> 4: (85) call bpf_rcu_read_lock#84184          ;
> ; p = bpf_task_from_pid(pid);
> 5: (18) r1 = 0xffffbc1ad3f72004       ;
> R1_w=map_value(map=cpumask_.bss,ks=4,vs=8,off=4)
> 7: (61) r1 = *(u32 *)(r1 +0)          ;
> R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> ; p = bpf_task_from_pid(pid);
> 8: (85) call bpf_task_from_pid#84204          ;
> R0=ptr_or_null_task_struct(id=3,ref_obj_id=3) refs=3
> 9: (bf) r8 = r0                       ;
> R0=ptr_or_null_task_struct(id=3,ref_obj_id=3)
> R8_w=ptr_or_null_task_struct(id=3,ref_obj_id=3) refs=3
> 10: (b4) w7 = 1                       ; R7_w=1 refs=3
> ; if (!p) {
> 11: (15) if r8 == 0x0 goto pc+6       ;
> R8_w=ptr_task_struct(ref_obj_id=3) refs=3
> ; read_percpu_data(meta, cgrp, p->cpus_ptr);
> 12: (79) r2 = *(u64 *)(r8 +984)       ; R2_w=rcu_ptr_cpumask()
> R8_w=ptr_task_struct(ref_obj_id=3) refs=3
> ; read_percpu_data(meta, cgrp, p->cpus_ptr);
> 13: (bf) r1 = r6                      ;
> R1_w=trusted_ptr_bpf_iter_meta() R6=trusted_ptr_bpf_iter_meta() refs=3
> 14: (85) call pc+6
> caller:
>   R6=trusted_ptr_bpf_iter_meta() R7_w=1
> R8_w=ptr_task_struct(ref_obj_id=3) R10=fp0 refs=3
> callee:
>   frame1: R1_w=trusted_ptr_bpf_iter_meta() R2_w=rcu_ptr_cpumask() R10=fp0 refs=3
> 21: frame1: R1_w=trusted_ptr_bpf_iter_meta() R2_w=rcu_ptr_cpumask()
> R10=fp0 refs=3
> ; static inline void read_percpu_data(struct bpf_iter_meta *meta,
> struct cgroup *cgrp, const cpumask_t *mask)
> 21: (bf) r8 = r1                      ; frame1:
> R1_w=trusted_ptr_bpf_iter_meta() R8_w=trusted_ptr_bpf_iter_meta()
> refs=3
> 22: (bf) r7 = r10                     ; frame1: R7_w=fp0 R10=fp0 refs=3
> ;
> 23: (07) r7 += -24                    ; frame1: R7_w=fp-24 refs=3
> ; bpf_for_each(cpumask, cpu, mask) {
> 24: (bf) r1 = r7                      ; frame1: R1_w=fp-24 R7_w=fp-24 refs=3
> 25: (85) call bpf_iter_cpumask_new#77163      ; frame1: R0=scalar()
> fp-24=iter_cpumask(ref_id=4,state=active,depth=0) refs=3,4
> ; bpf_for_each(cpumask, cpu, mask) {
> 26: (bf) r1 = r7                      ; frame1: R1=fp-24 R7=fp-24 refs=3,4
> 27: (85) call bpf_iter_cpumask_next#77165     ; frame1: R0_w=0
> fp-24=iter_cpumask(ref_id=4,state=drained,depth=0) refs=3,4
> 28: (bf) r7 = r0                      ; frame1: R0_w=0 R7_w=0 refs=3,4
> 29: (b4) w1 = 0                       ; frame1: R1_w=0 refs=3,4
> 30: (63) *(u32 *)(r10 -40) = r1       ; frame1: R1_w=0 R10=fp0
> fp-40=????0 refs=3,4
> 31: (b4) w1 = 0                       ; frame1: R1_w=0 refs=3,4
> 32: (7b) *(u64 *)(r10 -32) = r1       ; frame1: R1_w=0 R10=fp0
> fp-32_w=0 refs=3,4
> 33: (b4) w9 = 0                       ; frame1: R9_w=0 refs=3,4
> ; bpf_for_each(cpumask, cpu, mask) {
> 34: (15) if r7 == 0x0 goto pc+57      ; frame1: R7_w=0 refs=3,4
> ; bpf_for_each(cpumask, cpu, mask) {
> 92: (bf) r1 = r10                     ; frame1: R1_w=fp0 R10=fp0 refs=3,4
> ; bpf_for_each(cpumask, cpu, mask) {
> 93: (07) r1 += -24                    ; frame1: R1_w=fp-24 refs=3,4
> 94: (85) call bpf_iter_cpumask_destroy#77161          ; frame1: refs=3
> ; BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
> 95: (61) r1 = *(u32 *)(r10 -40)       ; frame1: R1_w=0 R10=fp0
> fp-40=????0 refs=3
> 96: (bc) w1 = w1                      ; frame1: R1_w=0 refs=3
> 97: (7b) *(u64 *)(r10 -8) = r1        ; frame1: R1_w=0 R10=fp0 fp-8_w=0 refs=3
> 98: (79) r1 = *(u64 *)(r10 -32)       ; frame1: R1_w=0 R10=fp0 fp-32=0 refs=3
> 99: (7b) *(u64 *)(r10 -16) = r1       ; frame1: R1_w=0 R10=fp0 fp-16_w=0 refs=3
> 100: (7b) *(u64 *)(r10 -24) = r9      ; frame1: R9=0 R10=fp0 fp-24_w=0 refs=3
> 101: (79) r1 = *(u64 *)(r8 +0)        ; frame1:
> R1_w=trusted_ptr_seq_file() R8=trusted_ptr_bpf_iter_meta() refs=3
> 102: (bf) r4 = r10                    ; frame1: R4_w=fp0 R10=fp0 refs=3
> ; bpf_for_each(cpumask, cpu, mask) {
> 103: (07) r4 += -24                   ; frame1: R4_w=fp-24 refs=3
> ; BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
> 104: (18) r2 = 0xffff9bce47e0e210     ; frame1:
> R2_w=map_value(map=cpumask_.rodata,ks=4,vs=41) refs=3
> 106: (b4) w3 = 41                     ; frame1: R3_w=41 refs=3
> 107: (b4) w5 = 24                     ; frame1: R5_w=24 refs=3
> 108: (85) call bpf_seq_printf#126     ; frame1: R0=scalar() refs=3
> ; }
> 109: (95) exit
> bpf_rcu_read_unlock is missing
> processed 45 insns (limit 1000000) max_states_per_insn 0 total_states
> 5 peak_states 5 mark_read 3
> =============

The error is due to the following in verifier:

                         } else if (opcode == BPF_EXIT) {
				...
                                 if (env->cur_state->active_rcu_lock &&
                                     !in_rbtree_lock_required_cb(env)) {
                                         verbose(env, "bpf_rcu_read_unlock is missing\n");
                                         return -EINVAL;
                                 }


I guess, we could relax the condition not to return -EINVAL if
it is a static function.

>
>
> Another workaround is using the __always_inline :
> static __always_inline void read_percpu_data(struct bpf_iter_meta
> *meta, struct cgroup *cgrp, const cpumask_t *mask)

__always_inline is also work. But let us improve verifier so we
can avoid such workarounds in the future. Note that Kumar just
submitted a patch set to relax spin_lock for static functions:
   https://lore.kernel.org/bpf/20240204120206.796412-1-memxor@gmail.com/

>
>>> +SEC("iter.s/cgroup")
>>> +int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta *meta, struct cgroup *cgrp)
>>> +{
>>> +       struct task_struct *p;
>>> +
>>> +       /* epilogue */
>>> +       if (!cgrp)
>>> +               return 0;
>>> +
>>> +       bpf_rcu_read_lock();
>>> +       p = bpf_task_from_pid(pid);
>>> +       if (!p) {
>>> +               bpf_rcu_read_unlock();
>>> +               return 1;
>>> +       }
>>> +
>>> +       READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
>>> +       bpf_task_release(p);
>>> +       bpf_rcu_read_unlock();
>>> +       return 0;
>>> +}
>>> +
>> [...]
>
>

