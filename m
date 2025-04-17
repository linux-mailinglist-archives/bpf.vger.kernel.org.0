Return-Path: <bpf+bounces-56132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA3A91D0D
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21C2169FFB
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889B188CDB;
	Thu, 17 Apr 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/9HznJM"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114735979
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894568; cv=none; b=DR+CM7U6qCLvmvSAliWAvACEgkQabIXqlq2RbZhHLCn9G3uZ+CBT6GoDXz7HEx0t2GG6EGeJtPllWNtozu91U3ttoJUwZjpJHQ5cnnpY5PfZ77/BP110Fo4jM5U/dt1p8tneQYjXwbgYnVYqOmUH6BdCjoeK4KxMSUaPfc0GPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894568; c=relaxed/simple;
	bh=tKAiwNOF/uN5H0L2knS1GDGDXBAMddJoBtxd6RkJbGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhebJiTZuX0u1DWeaDgGF3uSaQLGJEUpDdl+LmTfrNeJnbY4l3u95OuRiyb15p2hLew0tDJPyDH7Dx67zCSVGtJbNrtzS8TLYoFgYCZO3wwisJ+AeqNHsO5IbSA48nryh6S0l0NycCfzbQdhvmSKFkWA/ZE5zYmodcq1O+hP6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/9HznJM; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <361850e7-1d1b-4502-9e5a-91638fa481b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744894561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpU1p5EGeHFOZwOo9244niXunZi2VshoCd+nsS3sWUE=;
	b=m/9HznJMTrbhxUfScQwifgSkDMcctb3ZmPbrmPZdE5XPB6KwapG2Pnenvm+XbsqKL210GT
	XSUXX0IpGqA7NIoVN/w2h7ttUBTG1Bk3Y1eVvPRTfD4EICrCpzdfMM7kKj1e1u8dEGixIG
	CmOUnuygCVtACyThR1UEckbJfhQHHic=
Date: Thu, 17 Apr 2025 20:55:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Question: fentry on kernel func optimized by compiler
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
References: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
 <CAEf4BzaEg1mPag0-bAPVeJhj-BL_ssABBAOc_AhFvOLi2GkrEg@mail.gmail.com>
 <3c6f539b-b498-4587-b0dc-5fdeba717600@oracle.com>
 <ee8a41c8-9500-4ff9-bffb-e6c764da6e3e@linux.dev> <Z_6x1CH38clO_OTV@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <Z_6x1CH38clO_OTV@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/16 03:21, Jiri Olsa 写道:
> On Tue, Apr 15, 2025 at 08:10:09PM +0800, Tao Chen wrote:
>> 在 2025/3/31 18:13, Alan Maguire 写道:
>>> On 28/03/2025 17:21, Andrii Nakryiko wrote:
>>>> On Thu, Mar 27, 2025 at 9:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>>
>>>>> Hi,
> 
> hi, sorry for late reply
> 
>>>>>
>>>>> I recently encountered a problem when using fentry to trace kernel
>>>>> functions optimized by compiler, the specific situation is as follows:
>>>>> https://github.com/bpftrace/bpftrace/issues/3940
>>>>>
>>>>> Simply put, some functions have been optimized by the compiler. The
>>>>> original function names are found through BTF, but the optimized
>>>>> functions are the ones that exist in kallsyms_lookup_name. Therefore,
>>>>> the two do not match.
> 
> hum, would you have example BTF/kernel/config with such case? I'd think
> if function is in BTF you should find it through kallsyms, the other way
> around is not garanteed
> 

It seems that there is no special configuration. I am using the official 
Ubuntu 24.04. The issue link is: 
https://github.com/bpftrace/bpftrace/issues/3940

>>>>>
>>>>>            func_proto = btf_type_by_id(desc_btf, func->type);
>>>>>            if (!func_proto || !btf_type_is_func_proto(func_proto)) {
>>>>>                    verbose(env, "kernel function btf_id %u does not have a
>>>>> valid func_proto\n",
>>>>>                            func_id);
>>>>>                    return -EINVAL;
>>>>>            }
>>>>>
>>>>>            func_name = btf_name_by_offset(desc_btf, func->name_off);
>>>>>            addr = kallsyms_lookup_name(func_name);
>>>>>            if (!addr) {
>>>>>                    verbose(env, "cannot find address for kernel function
>>>>> %s\n",
>>>>>                            func_name);
>>>>>                    return -EINVAL;
>>>>>            }
>>>>>
>>>>> I have made a simple statistics and there are approximately more than
>>>>> 2,000 functions in Ubuntu 24.04.
>>>>>
>>>>> dylane@2404:~$ cat /proc/kallsyms | grep isra | wc -l
>>>>> 2324
>>>>>
>>>>> So can we add a judgment from libbpf. If it is an optimized function,
>>>>
>>>> No, we cannot. It's a different function at that point and libbpf
>>>> isn't going to be in the business of guessing on behalf of the user
>>>> whether it's ok to do or not.
>>>>
>>>> But the user can use multi-kprobe with `prefix*` naming, if they
>>>> encountered (or are anticipating) this situation and think it's fine
>>>> for them.
>>>>
>>>> As for fentry/fexit, you need to have the correct BTF ID associated
>>>> with that function anyways, so I'm not sure that currently you can
>>>> attach fentry/fexit to such compiler-optimized functions at all
>>>> (pahole won't produce BTF for such functions, right?).
>>>>
>>>
>>> Yep, BTF will not be there for all cases, but ever since we've had the
>>> "optimized_func" BTF feature, we've have encoded BTF for suffixed
>>> functions as long as their parameters are not optimized away and as long
>>> as we don't have multiple inconsistent representations associated with a
>>> function (say two differing function signatures for the same name).
>>> Optimization away of parameters happens quite frequently, but not always
>>> for .isra.0 functions so they are potentially sometimes safe for fentry.
>>>
>>> The complication here is that - by design - the function name in BTF
>>> will be the prefix; i.e. "foo" not "foo.isra.0". So how we match up the
>>> BTF with the right suffixed function is an issue; a single function
>>> prefix can have ".isra.0" and ".cold.0" suffixes associated for example.
>>> The latter isn't really a function entry point (in the C code at least);
>>> it's just a split of the function into common path and less common path
>>> for better code locality for the more commonly-executed code.
>>>
>>> Yonghong and I talked about this a bit last year in Plumbers, but it did
>>> occur to me that there are conditions where we could match up the prefix
>>> from BTF with a guaranteed fentry point for the function using info we
>>> have today.
>>>
>>> /sys/kernel/tracing/available_filter_functions_addr has similar info to
>>> /proc/kallysyms but as far as I understand it we are also guaranteed
>>> that the associated addresses correspond to real function entry points.
> 
> available_filter_functions_addr contains exactly the same functions as
> available_filter_functions (all functions managed by ftrace), it just
> adds address value for each function as a hint to user space
> 
> it's used in kprobe_multi bench test to get all traceable addresses,
> and passed to kprobe_multi link, which uses following fprobe interface
> to attach:
> 
>          err = register_fprobe_ips(&link->fp, addrs, cnt);
> 
>>> So because the BTF representation currently ensures consistency _and_
>>> available function parameters, I think we could use
>>> available_filter_functions_addr to carry out the match and provide the
>>> right function address for the BTF representation.
> 
> where would you do the match to available_filter_functions_addr?

maybe in libbpf? If it is the situation encountered above, use the 
passed-in address from user; otherwise, still use the original logic.

	func_name = btf_name_by_offset(desc_btf, func->name_off);
	addr = kallsyms_lookup_name(func_name);
> 
> also not sure how it's connected to the original issue, that seems
> to be related to pahole eliminating unsafe functions in BTF?
> 
> jirka
> 
> 
>>>
>>
>> Hi, Alan
>> Sorry for not replying in time. As you said，it seems much simpler when use
>> the func addr from available_filter_functions_addr. It seems to be a bit
>> similar to the way of passing function addresses in kprobe_multi. @Andrii
>> @Jiri what do you think?
>>
>>> In the future, the hope is we can handle inconsistent representations
>>> too in BTF, but the above represents a possible approach we could
>>> implement today I think, though I may be missing something. Thanks!
>>>
>>> Alan
>>
>>
>> -- 
>> Best Regards
>> Tao Chen
>>


-- 
Best Regards
Tao Chen

