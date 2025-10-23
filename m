Return-Path: <bpf+bounces-71866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C92BFF4E8
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D43AA495
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA527FD49;
	Thu, 23 Oct 2025 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qG1HcRaJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C9286D5D
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199919; cv=none; b=o7uiTlhbzRvWTuvyaBwiVuxuXw7E5XyBluZKc5k7+L7OIpt8PBvXPLB8lCB3sHyXqFOTQYVhcDrqsDiwKO+r/jDxbfDD18wN2LVQXRX//JA6Lgzn+WSfanxldszAJ8wjPJJbVG/Gp334a9swyKOu+sYGI+EvYfHMZr2PSbRF/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199919; c=relaxed/simple;
	bh=wdaVwDtAh+xzW3oYCE8lhLcNeQkNEiruuO30tZexr64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huIFybTQxxALN0usxPgUADM2NHGRdzqbfVmMz4EIUQrd1/iI4xvG0iuJ4rvN8E3x7QCWiLyMYVa/zV5CpPHz9Om1/Rhl1o6WkZp6+mHH2dByGcl9H9Qz23Xske1h3x22y9qN+9hjI3JFSDhnbSfuNqAHqPyzLKwzFch3FRYSeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qG1HcRaJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb6328bf-2b96-4b91-811c-dd8dd303fdbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761199905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8b9Xl9t/F/Zd9A3cHpf9cxx3vOlRhkRz/axJ6cIiX6w=;
	b=qG1HcRaJ/21gF2OmS1N7C4DLCJbx9Dvm78VWWyg7uHAZ+sC5XgCsaQcZVZPlLX+Msx+u9e
	/aE5fJXHORO2C1rvlK+MyXuuJoN8P9bwkhLDAVE6tt2rGgGeZFrXxTr7jaIx+LxUeVHORj
	Zy9zgcplK+DpSM2DOkidi7P5iXP4S3Q=
Date: Thu, 23 Oct 2025 14:11:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to
 get_perf_callchain
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava>
 <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
 <CAEf4BzbAt_3co0s-+DspnHuJryG2DKPLP9OwsN0bWWnbd5zsmQ@mail.gmail.com>
 <abd75aed-9ff2-4e6d-8fec-2b118264efa9@linux.dev>
 <CAEf4BzbtU2m9mh+Wi-BvuJ7U5_oHL3TWB8w2M5pRO6w6CCbfVw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbtU2m9mh+Wi-BvuJ7U5_oHL3TWB8w2M5pRO6w6CCbfVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/22 00:37, Andrii Nakryiko 写道:
> On Sat, Oct 18, 2025 at 12:51 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2025/10/17 04:39, Andrii Nakryiko 写道:
>>> On Tue, Oct 14, 2025 at 8:02 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Tue, Oct 14, 2025 at 5:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>>>
>>>>> On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
>>>>>> As Alexei noted, get_perf_callchain() return values may be reused
>>>>>> if a task is preempted after the BPF program enters migrate disable
>>>>>> mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
>>>>>> stack-allocated memory of bpf_perf_callchain_entry is used here.
>>>>>>
>>>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>>>> ---
>>>>>>    kernel/bpf/stackmap.c | 19 +++++++++++--------
>>>>>>    1 file changed, 11 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>>>> index 94e46b7f340..acd72c021c0 100644
>>>>>> --- a/kernel/bpf/stackmap.c
>>>>>> +++ b/kernel/bpf/stackmap.c
>>>>>> @@ -31,6 +31,11 @@ struct bpf_stack_map {
>>>>>>         struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>>>>>>    };
>>>>>>
>>>>>> +struct bpf_perf_callchain_entry {
>>>>>> +     u64 nr;
>>>>>> +     u64 ip[PERF_MAX_STACK_DEPTH];
>>>>>> +};
>>>>>> +
>>>
>>> we shouldn't introduce another type, there is perf_callchain_entry in
>>> linux/perf_event.h, what's the problem with using that?
>>
>> perf_callchain_entry uses flexible array, DEFINE_PER_CPU seems do not
>> create buffer for this, for ease of use, the size of the ip array has
>> been explicitly defined.
>>
>> struct perf_callchain_entry {
>>           u64                             nr;
>>           u64                             ip[]; /*
>> /proc/sys/kernel/perf_event_max_stack */
>> };
>>
> 
> Ok, fair enough, but instead of casting between perf_callchain_entry
> and bpf_perf_callchain_entry, why not put perf_callchain_entry inside
> bpf_perf_callchain_entry as a first struct and pass a pointer to it.
> That looks a bit more appropriate? Though I'm not sure if compiler
> will complain about that flex array...
> 
> But on related note, I looked briefly at how perf gets those
> perf_callchain_entries, and it does seem like it also has a small
> stack of entries, so maybe we don't really need to invent anything
> here. See PERF_NR_CONTEXTS and how that's used.
> 

It seems so. The implementation of get_callchain_entry and 
put_callchain_entry is similar to a simple stack management.

struct perf_callchain_entry *get_callchain_entry(int *rctx)
{
         int cpu;
         struct callchain_cpus_entries *entries;

         *rctx = get_recursion_context(this_cpu_ptr(callchain_recursion));
         if (*rctx == -1)
                 return NULL;

         entries = rcu_dereference(callchain_cpus_entries);
         if (!entries) {
  
put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
                 return NULL;
         }

         cpu = smp_processor_id();

         return (((void *)entries->cpu_entries[cpu]) +
                 (*rctx * perf_callchain_entry__sizeof()));
}

void
put_callchain_entry(int rctx)
{
         put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
}

> If instead of disabling preemption we disable migration, then I think
> we should be good with relying on perf's callchain management, or am I
> missing something?
> 

Peter proposed refactoring the get_perf_callchain interface in v3, i 
think after that we can still use perf callchain, but with the 
refactored API, it can prevent being overwritten by preemption.

BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map
{
	...
	entry = bpf_get_perf_callchain;
	__bpf_get_stackid(map, entry, flags);
	bpf_put_callchain_entry(entry);
	...
}

A simple specific implementation is as follows:

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b9..1c7573f085f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
  	u32				nr;
  	short				contexts;
  	bool				contexts_maxed;
+	bool				add_mark;
  };

  typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
@@ -1718,9 +1719,18 @@ DECLARE_PER_CPU(struct perf_callchain_entry, 
perf_callchain_entry);

  extern void perf_callchain_user(struct perf_callchain_entry_ctx 
*entry, struct pt_regs *regs);
  extern void perf_callchain_kernel(struct perf_callchain_entry_ctx 
*entry, struct pt_regs *regs);
+
+extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+				      struct perf_callchain_entry *entry,
+				      u32 max_stack, bool add_mark);
+
+extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx 
*ctx, struct pt_regs *regs);
+extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx 
*ctx, struct pt_regs *regs);
+
+
  extern struct perf_callchain_entry *
  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask);
  extern int get_callchain_buffers(int max_stack);
  extern void put_callchain_buffers(void);
  extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 4d53cdd1374..3f2543e5244 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -297,14 +297,38 @@ static long __bpf_get_stackid(struct bpf_map *map,
  	return id;
  }

+static struct perf_callchain_entry *entry
+bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel, 
bool user, int max_stack)
+{
+	struct perf_callchain_entry_ctx ctx;
+	struct perf_callchain_entry *entry;
+
+	entry = get_callchain_entry(&rctx);
+	if (unlikely(!entry))
+		return NULL;
+
+	__init_perf_callchain_ctx(&ctx, entry)
+	if (kernel)
+		__get_perf_callchain_kernel(&ctx, regs);
+	if (user)
+		__get_perf_callchain_user(&ctx, regs);
+	return entry;
+}
+
+static bpf_put_perf_callchain(int rctx)
+{
+	put_callchain_entry(rctx);
+}
+
  BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
  	   u64, flags)
  {
  	u32 max_depth = map->value_size / stack_map_data_size(map);
  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
  	bool user = flags & BPF_F_USER_STACK;
-	struct perf_callchain_entry *trace;
+	struct perf_callchain_entry *entry;
  	bool kernel = !user;
+	int rctx, ret;

  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -314,14 +338,14 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, 
regs, struct bpf_map *, map,
  	if (max_depth > sysctl_perf_event_max_stack)
  		max_depth = sysctl_perf_event_max_stack;

-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
-
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
+	entry = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth);
+	if (unlikely(!entry))
  		return -EFAULT;

-	return __bpf_get_stackid(map, trace, flags);
+	ret = __bpf_get_stackid(map, entry, flags);
+	bpf_put_callchain_entry(rctx);
+
+	return ret;
  }

  const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -452,7 +476,7 @@ static long __bpf_get_stack(struct pt_regs *regs, 
struct task_struct *task,
  		trace = get_callchain_entry_for_task(task, max_depth);
  	else
  		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+					   crosstask);

  	if (unlikely(!trace) || trace->nr < skip) {
  		if (may_fault)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 808c0d7a31f..2c36e490625 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -216,13 +216,54 @@ static void 
fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
  #endif
  }

+void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
+			       struct perf_callchain_entry *entry,
+			       u32 max_stack, bool add_mark)
+
+{
+	ctx->entry		= entry;
+	ctx->max_stack		= max_stack;
+	ctx->nr			= entry->nr = 0;
+	ctx->contexts		= 0;
+	ctx->contexts_maxed	= false;
+	ctx->add_mark		= add_mark;
+}
+
+void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, 
struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return;
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_KERNEL);
+	perf_callchain_kernel(ctx, regs);
+}
+
+void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, 
struct pt_regs *regs)
+{
+	int start_entry_idx;
+
+	if (!user_mode(regs)) {
+		if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			return;
+		regs = task_pt_regs(current);
+	}
+
+	if (ctx->add_mark)
+		perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
+
+	start_entry_idx = ctx->nr;
+	perf_callchain_user(ctx, regs);
+	fixup_uretprobe_trampoline_entries(ctx->entry, start_entry_idx);
+}
+
  struct perf_callchain_entry *
  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool crosstask)
  {
  	struct perf_callchain_entry *entry;
  	struct perf_callchain_entry_ctx ctx;
-	int rctx, start_entry_idx;
+	int rctx;

  	/* crosstask is not supported for user stacks */
  	if (crosstask && user && !kernel)
@@ -232,34 +273,14 @@ get_perf_callchain(struct pt_regs *regs, bool 
kernel, bool user,
  	if (!entry)
  		return NULL;

-	ctx.entry		= entry;
-	ctx.max_stack		= max_stack;
-	ctx.nr			= entry->nr = 0;
-	ctx.contexts		= 0;
-	ctx.contexts_maxed	= false;
+	__init_perf_callchain_ctx(&ctx, entry, max_stack, true);

-	if (kernel && !user_mode(regs)) {
-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
-		perf_callchain_kernel(&ctx, regs);
-	}
-
-	if (user && !crosstask) {
-		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				goto exit_put;
-			regs = task_pt_regs(current);
-		}
+	if (kernel)
+		__get_perf_callchain_kernel(&ctx, regs);

-		if (add_mark)
-			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
-
-		start_entry_idx = entry->nr;
-		perf_callchain_user(&ctx, regs);
-		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-	}
+	if (user && !crosstask)
+		__get_perf_callchain_user(&ctx, regs);

-exit_put:
  	put_callchain_entry(rctx);

  	return entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f85fc..eb0f110593d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8218,7 +8218,7 @@ perf_callchain(struct perf_event *event, struct 
pt_regs *regs)
  		return &__empty_callchain;

  	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+				       max_stack, crosstask);
  	return callchain ?: &__empty_callchain;
  }

>>>
>>>>>>    static inline bool stack_map_use_build_id(struct bpf_map *map)
>>>>>>    {
>>>>>>         return (map->map_flags & BPF_F_STACK_BUILD_ID);
>>>>>> @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>>>>>         bool user = flags & BPF_F_USER_STACK;
>>>>>>         struct perf_callchain_entry *trace;
>>>>>>         bool kernel = !user;
>>>>>> +     struct bpf_perf_callchain_entry entry = { 0 };
>>>>>
>>>>> so IIUC having entries on stack we do not need to do preempt_disable
>>>>> you had in the previous version, right?
>>>>>
>>>>> I saw Andrii's justification to have this on the stack, I think it's
>>>>> fine, but does it have to be initialized? it seems that only used
>>>>> entries are copied to map
>>>>
>>>> No. We're not adding 1k stack consumption.
>>>
>>> Right, and I thought we concluded as much last time, so it's a bit
>>> surprising to see this in this patch.
>>>
>>
>> Ok, I feel like I'm missing some context from our previous exchange.
>>
>>> Tao, you should go with 3 entries per CPU used in a stack-like
>>> fashion. And then passing that entry into get_perf_callchain() (to
>>> avoid one extra copy).
>>>
>>
>> Got it. It is more clearer, will change it in v3.
>>
>>>>
>>>> pw-bot: cr
>>
>>
>> --
>> Best Regards
>> Tao Chen


-- 
Best Regards
Tao Chen

