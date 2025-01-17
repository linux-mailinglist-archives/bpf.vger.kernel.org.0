Return-Path: <bpf+bounces-49161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161AA149B3
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 07:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994103A43DB
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5B1F7586;
	Fri, 17 Jan 2025 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RsjWGCg2"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D622619
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737095083; cv=none; b=eSyk9Fsf7YXjR+fztb1jNisZqgrg5fwWmGm8YM+DBAwIVvgp5GRMqb+KKp8ea6LKrUyVrzktlDJcLI7IUCKIN/4MaB1JgNBDGXNWpF9dl1lz/OLCKsWqtYICsTJeZthrHmbE3yxcyWiavejRuDb2ccerBUW2QFfIVW2V7pbLF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737095083; c=relaxed/simple;
	bh=p1C1wIBV0Vf9Wkff52ZWYTfK/qhWeDg2S5UX/J7CWMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9nsbPeTQddZnwKiaxseoyhBUcovzBoBMv/NaraIoZjXyc3UiMHtuGBbCCU+Ll5Qdax08vIXK+FNJGRlJtk4Lxco/gZM0o/G1kLUnRrkMNshZmxfwYZv8WHOKPYbMpBiU0p3PMVTbViGb1FBnETCPgGRS2Wj6KoTuV2NNEYGMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RsjWGCg2; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9fc744b6-9139-4cbd-bcd7-23945cf94a92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737095073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg2CDAYmq5znSllBNtuVwu541iM+r1fpRn6Y/PWx9ws=;
	b=RsjWGCg2paTSt+/NU0RBJoS6GopcRT6HX18KTLKKQ8zfWFYEO7Vr7F9pup2NnOWQp2JaTr
	wFCBT8dCInY9Mwr59/YQ3+Okai40rYSCK5Yueb2UEuzxRJGeGdJgfMlRE/FxzXOrU5R7oz
	74dPLmWU65MtyaN36z3YIeKvF3YRuYE=
Date: Fri, 17 Jan 2025 14:24:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Introduce global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20250113152437.67196-1-leon.hwang@linux.dev>
 <20250113152437.67196-2-leon.hwang@linux.dev>
 <CAEf4BzahZ04K5LDaqaToJnQ9yvRZ48yh-2+ywsKRgcj8whMheA@mail.gmail.com>
 <9872244c-0e3b-4e83-be1d-1503f7b086e6@linux.dev>
 <CAEf4BzaBXuztqhvAxPGi6nzebMVifx2cU1iFQqEo_GwF3z-ADg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaBXuztqhvAxPGi6nzebMVifx2cU1iFQqEo_GwF3z-ADg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 17/1/25 07:37, Andrii Nakryiko wrote:
> On Wed, Jan 15, 2025 at 11:22 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Hi,
>>
>> On 15/1/25 07:10, Andrii Nakryiko wrote:
>>> On Mon, Jan 13, 2025 at 7:25 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>

[...]

>>>
>>> So I think the feature overall makes sense, but we need to think
>>> through at least libbpf's side of things some more. Unlike .data,
>>> per-cpu .data section is not mmapable, and so that has implication on
>>> BPF skeleton and we should make sure all that makes sense on BPF
>>> skeleton side. In that sense, per-cpu global data is more akin to
>>> struct_ops initialization image, which can be accessed by user before
>>> skeleton is loaded to initialize the image.
>>>
>>> There are a few things to consider. What's the BPF skeleton interface?
>>> Do we expose it as single struct and use that struct as initial image
>>> for each CPU (which means user won't be able to initialize different
>>> CPU data differently, at least not through BPF skeleton facilities)?
>>> Or do we expose this as an array of structs and let user set each CPU
>>> data independently?
>>>
>>> I feel like keeping it simple and having one image for all CPUs would
>>> cover most cases. And users can still access the underlying
>>> PERCPU_ARRAY map if they need more control.
>>
>> Agree. It is necessary to keep it simple.
>>
>>>
>>> But either way, we need tests for skeleton, making sure we NULL-out
>>> this per-cpu global data, but take it into account before the load.
>>>
>>> Also, this huge calloc for possible CPUs, I'd like to avoid it
>>> altogether for the (probably very common) zero-initialized case.
>>
>> Ack.
>>
>>>
>>> So in short, needs a bit of iteration to figure out all the
>>> interfacing issues, but makes sense overall. See some more low-level
>>> remarks below.
>>>
>>
>> It is challenging to figure out them. I'll do my best to achieve it.
>>
>>> pw-bot: cr
>>>
>>>
> 
> [...]
> 
>>>
>>>> @@ -516,6 +516,7 @@ struct bpf_struct_ops {
>>>>  };
>>>>
>>>>  #define DATA_SEC ".data"
>>>> +#define PERCPU_DATA_SEC ".data..percpu"
>>>
>>> I don't like this prefix, even if that's what we have in the kernel.
>>> Something like just ".percpu" or ".percpu_data" or ".data_percpu" is
>>> better, IMO.
>>
>> I tested ".percpu". It is OK to use it. But we have to update "bpftool
>> gen" too, which relies on these section names.
>>
>> Is it better to keep ".data" prefix, like ".data.percpu", ".data_percpu"?
>> Can keeping ".data" prefix reduce some works on bpftool, go-ebpf and
>> akin bpf loaders?
> 
> It's literally two lines of code in gen.c, and that should actually be
> a common array of known prefixes. Even if someone uses this new
> .percpu section with old bpftool nothing will break, they just won't
> have structure representing the initial per-CPU image. They will still
> have the generic map pointer in the skeleton. So I think this is
> acceptable.
> 
> I'd definitely go with a simple and less error-prone ".percpu" prefix.
> 

Being simple and less error-prone is indeed important. Let's proceed
with the ".percpu" prefix as suggested.

Thanks,
Leon



