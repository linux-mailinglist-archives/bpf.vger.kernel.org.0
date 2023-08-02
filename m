Return-Path: <bpf+bounces-6684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2E76C5E0
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 08:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A691C211A5
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB41869;
	Wed,  2 Aug 2023 06:54:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D251111
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 06:54:40 +0000 (UTC)
Received: from out-94.mta1.migadu.com (out-94.mta1.migadu.com [IPv6:2001:41d0:203:375::5e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3D2D7D
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 23:54:26 -0700 (PDT)
Message-ID: <8b6b0703-4ed6-c0cb-c61a-9ebcfb5fe668@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690959263; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffbbhxXh4DsgdVMg4qFuWVPTer+LcrbUFX2YyXoOncA=;
	b=k5ACqMQClwgbdWN8sz6BYvHHCFZ4RwCmWfB0QWdVBqFuOCf+XSYpcJJHl1csbr1Igf20St
	wXqVc07dWxJqt91OdJq6GWxMlI4Tc8xDvQzfglPGNgQZU1FszmjfYfu+cCge4m4hOobaAN
	+eOKIXgMfLHrFaQOpAuSpyCT245ZmTE=
Date: Tue, 1 Aug 2023 23:54:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
Content-Language: en-US
To: David Vernet <void@manifault.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
 <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230802032958.GB472124@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 8:29 PM, David Vernet wrote:
> On Tue, Aug 01, 2023 at 07:45:57PM -0700, Alexei Starovoitov wrote:
>> On Tue, Aug 1, 2023 at 7:34 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>
>>>>
>>>> In kernel, we have a global variable
>>>>      nr_cpu_ids (also in kernel/bpf/helpers.c)
>>>> which is used in numerous places for per cpu data struct access.
>>>>
>>>> I am wondering whether we could have bpf code like
>>>>      int nr_cpu_ids __ksym;
> 
> I think this would be useful in general, though any __ksym variable like
> this would have to be const and mapped in .rodata, right? But yeah,
> being able to R/O map global variables like this which have static
> lifetimes would be nice.

No. There is no map here. __ksym symbol will have a ld_imm64 insn
to load the value in the bpf code. The address will be the kernel
address patched by libbpf.

> 
> It's not quite the same thing as nr_cpu_ids, but FWIW, you could
> accomplish something close to this by doing something like this in your
> BPF prog:
> 
> /* Set in user space to libbpf_num_possible_cpus() */
> const volatile __u32 nr_cpus;

This is another approach. In this case, nr_cpus will be
stored in a map.

I don't know the difference between kernel nr_cpu_ids vs.
libbpf_num_possible_cpus(). I am choosing nr_cpu_ids
because it is the one used inside the kernel. If
libbpf_num_possible_cpus() effectively nr_cpu_ids,
then happy to use libbpf_num_possible_cpus() which
is more user/libbpf friendly.

> 
> ...
> 	__u32 i;
> 
> 	bpf_for(i, 0, nr_cpus)
> 		bpf_printk("Iterating over cpu %u", i);
> 
> ...
> 
>>>>      struct bpf_iter_num it;
>>>>      int i = 0;
>>>>
>>>>      // nr_cpu_ids is special, we can give it a range [1, CONFIG_NR_CPUS].
>>>>      bpf_iter_num_new(&it, 1, nr_cpu_ids);
>>>>      while ((v = bpf_iter_num_next(&it))) {
>>>>             /* access cpu i data */
>>>>             i++;
>>>>      }
>>>>      bpf_iter_num_destroy(&it);
>>>>
>>>>   From all existing open coded iterator loops, looks like
>>>> upper bound has to be a constant. We might need to extend support
>>>> to bounded scalar upper bound if not there.
>>>
>>> Currently the upper bound is required by both the open-coded for-loop
>>> and the bpf_loop. I think we can extend it.
>>>
>>> It can't handle the cpumask case either.
>>>
>>>      for_each_cpu(cpu, mask)
>>>
>>> In the 'mask', the CPU IDs might not be continuous. In our container
>>> environment, we always use the cpuset cgroup for some critical tasks,
>>> but it is not so convenient to traverse the percpu data of this cpuset
>>> cgroup.  We have to do it as follows for this case :
>>>
>>> That's why we prefer to introduce a bpf_for_each_cpu helper. It is
>>> fine if it can be implemented as a kfunc.
>>
>> I think open-coded-iterators is the only acceptable path forward here.
>> Since existing bpf_iter_num doesn't fit due to sparse cpumask,
>> let's introduce bpf_iter_cpumask and few additional kfuncs
>> that return cpu_possible_mask and others.
> 
> I agree that this is the correct way to generalize this. The only thing
> that we'll have to figure out is how to generalize treating const struct
> cpumask * objects as kptrs. In sched_ext [0] we export
> scx_bpf_get_idle_cpumask() and scx_bpf_get_idle_smtmask() kfuncs to
> return trusted global cpumask kptrs that can then be "released" in
> scx_bpf_put_idle_cpumask(). scx_bpf_put_idle_cpumask() is empty and
> exists only to appease the verifier that the trusted cpumask kptrs
> aren't being leaked and are having their references "dropped".
> 
> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
> 
> I'd imagine that we have 2 ways forward if we want to enable progs to
> fetch other global cpumasks with static lifetimes (e.g.
> __cpu_possible_mask or nohz.idle_cpus_mask):
> 
> 1. The most straightforward thing to do would be to add a new kfunc in
>     kernel/bpf/cpumask.c that's a drop-in replacment for
>     scx_bpf_put_idle_cpumask():
> 
> void bpf_global_cpumask_drop(const struct cpumask *cpumask)
> {}
> 
> 2. Another would be to implement something resembling what Yonghong
>     suggested in [1], where progs can link against global allocated kptrs
>     like:
> 
> const struct cpumask *__cpu_possible_mask __ksym;
> 
> [1]: https://lore.kernel.org/all/3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev/#t
> 
> In my opinion (1) is more straightforward, (2) is a better UX.
> 
> Note again that both approaches only works for cpumasks with static
> lifetimes.  I can't think of a way to treat dynamically allocated struct
> cpumask *objects as kptrs as there's nowhere to put a reference. If
> someone wants to track a dynamically allocated cpumask, they'd have to
> create a kptr out of its container object, and then pass that object's
> cpumask as a const struct cpumask * to other BPF cpumask kfuncs
> (including e.g. the proposed iterator).
> 
>> We already have some cpumask support in kernel/bpf/cpumask.c
>> bpf_iter_cpumask will be a natural follow up.
> 
> Yes, this should be easy to add.
> 
> - David

