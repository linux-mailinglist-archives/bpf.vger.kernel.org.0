Return-Path: <bpf+bounces-78838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672FD1C529
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 05:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4050A300C61A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617252D0298;
	Wed, 14 Jan 2026 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r8aqhHFK"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721C24BBE4;
	Wed, 14 Jan 2026 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363702; cv=none; b=lNFHV7WeINGqajIjmMUGKxrTUMeZ/9AUpWnPYjcoVTt0R6DYKoUM/AdsjVcDgKXrj0DE/9zeUOgoPcNJXGjzcwPoSggRJ5W0LyqEcWA46mD241pvonko6n/KPdxPoPCWEEP9Gn991lavJe1pf49uGHfCkobe7/P5+5twY7c4N1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363702; c=relaxed/simple;
	bh=Aum4e75q/c3WD6beapNhk9vDmdL2F+An3dcb9kVyPNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNmiLzOzM9bSaDeO20WUcc9FvvLau2HjHjlWDRfq1WkijNh1sJ01JYGjKYHpZdqhUVeVQieMhxbw2zhV4zQkSRp6wSRrNvamd0Ndk6q+cXu/hYIE14WgPxuTcHdlcNKhxktF5F3CNGl4BOKYcoK/7cNH0Kis0UlXFpLhyfWUDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r8aqhHFK; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e796df2b-6dd9-4b45-b8fb-9ef9f7fceab6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768363688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjgazky+ZRtvPL75QtxyxWAG7S1HJNuCDfOmdekMQb4=;
	b=r8aqhHFKIgqYlt4KzfjTy42NxtLo8k/QdluHHs/RtNdt/NIJ1m9DeINM0hCi/p8oIJ7EQ9
	SS0iMcFC04uEk91NrPICu2cgPtTp8mP56PXd7dV2je5gGjl2PHH5HLi7S/F47J/hzEe27k
	XkePeuCi6/ZCGEOsZUZyw0DIIH+fU0U=
Date: Tue, 13 Jan 2026 20:08:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
 <18d9b15319bf8d71a3cd5b08239529505714dc96.camel@gmail.com>
 <aff8eeed-414c-49b3-b7f0-c8c328ed5199@linux.dev>
 <5027595d4eff50d423af8ebc5fecd6a0f7229d60.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <5027595d4eff50d423af8ebc5fecd6a0f7229d60.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/13/26 5:06 PM, Eduard Zingerman wrote:
> On Tue, 2026-01-13 at 16:03 -0800, Ihor Solodrai wrote:
>> On 1/13/26 1:59 PM, Eduard Zingerman wrote:
>>> On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
>>>
>>> [...]
>>>
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -3271,6 +3271,38 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>>>>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>>>>  }
>>>>  
>>>> +#define KF_IMPL_SUFFIX "_impl"
>>>> +
>>>> +static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_env *env,
>>>> +						    struct btf *btf,
>>>> +						    const char *func_name)
>>>> +{
>>>> +	char impl_name[KSYM_SYMBOL_LEN];
>>>
>>> Oh, as we discussed already, this should use env->tmp_str_buf.
>>
>> The env->tmp_str_buf size is smaller:
>>
>> 	#define TMP_STR_BUF_LEN 320
>>
>> *And* there is already a local char buffer of size KSYM_SYMBOL_LEN
>> already in use in verifier.c:
>>
>> 	int bpf_check_attach_target(...) {
>> 		bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
>> 		bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
>> 		char trace_symbol[KSYM_SYMBOL_LEN];
>> 	[...]
>>
>> Since these are function names, the real limit is KSYM_SYMBOL_LEN,
>> right?
>>
>> Sure >320 chars long kfunc name is unlikely, but technically possible.
> 
> 320 is good enough, you'll be able to cover this:
> 
> kfunc_trace_long_descriptive_kernel_symbol_for_tracing_scheduler_memory_io_and_interrupt_paths_during_runtime_analysis_of_latency_throughput_and_resource_contention_on_large_scale_multiprocessor_linux_systems_using_bpf_and_kprobes_without_requiring_kernel_recompilation_or_system_restart_for_production_use_cases_v2x
> 
> But not this:
> 
> kfunc_trace_kernel_scheduler_and_memory_management_path_for_observing_task_lifecycle_events_context_switches_page_fault_handling_and_io_wait_states_while_debugging_performance_regressions_on_large_multiprocessor_systems_running_preemptible_linux_kernels_with_bpf_tracing_and_dynamic_instrumentation_enabled_for_deep_visibility_into_runtime_behavior_and_latency_sensitive_code_paths_without_recompilation.
> 
> Should suffice, I think.

I will laugh for at least 321 seconds when the size of this buffer
will have to be increased, and will make sure you hear it :)

They thought 640K of memory is enough, you know.


