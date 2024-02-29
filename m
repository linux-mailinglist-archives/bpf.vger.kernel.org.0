Return-Path: <bpf+bounces-22974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1286BCCF
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FDF285D70
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38F0185B;
	Thu, 29 Feb 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CutVQ3x7"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731C15C4
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166322; cv=none; b=RXpQlQ0bAt2Y8tlSr62YWcV0+JjZxGnYJopTjeEomuAiet8Iql+tXglhWg2GUiIUQOBGusqqdRs08vd9wvajbAd2cHgCf/o0wN5CytoArZP0g5B+uYxcuuZCSJ3MnrYRZwI+ujk5m2uxUrCVuJ+mGA1iBAGYC+6aypfrHPf0O6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166322; c=relaxed/simple;
	bh=09ZyQcc8vmp2J/NnUnJZEGeuQc2j16all3RRMUnPbfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frfmpHBpedT+bwVN6rub5dcBkQPHS/EHEAkpIb299OA4QD/vL4nJzAXMQA3QoznHiNvHBnzjl81Pw9R572ycUgnKigP4TjDccveVRuM+VrzrJEbVu0SpGKTGLrQyVhW4fi4mnCm5lvbtEt8AmK5tFoPFvFrECLAE0ZRO5dFfp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CutVQ3x7; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca62c2b8-adbb-4cbd-ab93-10a90dbdf2cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709166317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47VHirmAlpCNhGZCZtGQlr9g0StUrS/wARmnIszDyFc=;
	b=CutVQ3x7cXhZhiASqXfX4N95iQOteKVwyhTfPIWt7m9xPaIY3VT2fvYqA05oYndkvcwft4
	vj7P33gHSDmilIwGOTdDo3XAq5Cplmp/BR/6IIqLQprBXFx5Jmwe36NdUqiW6YZYJNKFz/
	dXsvMJt9L055EJG/QSNwuWKNImhZMVw=
Date: Wed, 28 Feb 2024 16:25:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 yonghong.song@linux.dev, void@manifault.com, bpf@vger.kernel.org,
 ast@kernel.org
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-8-eddyz87@gmail.com>
 <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
 <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/28/24 3:55 PM, Andrii Nakryiko wrote:
> On Tue, Feb 27, 2024 at 6:11 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/27/24 12:45 PM, Eduard Zingerman wrote:
>>> Make bpf_map__set_autocreate() for struct_ops maps toggle autoload
>>> state for referenced programs.
>>>
>>> E.g. for the BPF code below:
>>>
>>>       SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
>>>       SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }
>>>
>>>       SEC(".struct_ops.link")
>>>       struct test_ops___v1 A = {
>>>           .foo = (void *)foo
>>>       };
>>>
>>>       SEC(".struct_ops.link")
>>>       struct test_ops___v2 B = {
>>>           .foo = (void *)foo,
>>>           .bar = (void *)bar,
>>>       };
>>>
>>> And the following libbpf API calls:
>>>
>>>       bpf_map__set_autocreate(skel->maps.A, true);
>>>       bpf_map__set_autocreate(skel->maps.B, false);
>>>
>>> The autoload would be enabled for program 'foo' and disabled for
>>> program 'bar'.
>>>
>>> Do not apply such toggling if program autoload state is set by a call
>>> to bpf_program__set_autoload().
>>>
>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>> ---
>>>    tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 34 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index b39d3f2898a1..1ea3046724f8 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -446,13 +446,18 @@ struct bpf_program {
>>>        struct bpf_object *obj;
>>>
>>>        int fd;
>>> -     bool autoload;
>>> +     bool autoload:1;
>>> +     bool autoload_user_set:1;
>>>        bool autoattach;
>>>        bool sym_global;
>>>        bool mark_btf_static;
>>>        enum bpf_prog_type type;
>>>        enum bpf_attach_type expected_attach_type;
>>>        int exception_cb_idx;
>>> +     /* total number of struct_ops maps with autocreate == true
>>> +      * that reference this program
>>> +      */
>>> +     __u32 struct_ops_refs;
>>
>> Instead of adding struct_ops_refs and autoload_user_set,
>>
>> for BPF_PROG_TYPE_STRUCT_OPS, how about deciding to load it or not by checking
>> prog->attach_btf_id (non zero) alone. The prog->attach_btf_id is now decided at
>> load time and is only set if it is used by at least one autocreate map, if I
>> read patch 2 & 3 correctly.
>>
>> Meaning ignore prog->autoload*. Load the struct_ops prog as long as it is used
>> by one struct_ops map with autocreate == true.
>>
>> If the struct_ops prog is not used in any struct_ops map, the bpf prog cannot be
>> loaded even the autoload is set. If bpf prog is used in a struct_ops map and its
>> autoload is set to false, the struct_ops map will be in broken state. Thus,
> 
> We can easily detect this condition and report meaningful error.
> 
>> prog->autoload does not fit very well with struct_ops prog and may as well
>> depend on whether the struct_ops prog is used by a struct_ops map alone?
> 
> I think it's probably fine from a usability standpoint to disable
> loading the BPF program if its struct_ops map was explicitly set to
> not auto-create. It's a bit of deviation from other program types, but
> in practice this logic will make it easier for users.
> 
> One question I have, though, is whether we should report as an error a
> stand-alone struct_ops BPF program that is not used from any
> struct_ops map? Or should we load it nevertheless? Or should we
> silently not load it?

I think the libbpf could report an error if the prog is not used in any 
struct_ops map at the source code level, not sure if it is useful.

However, it probably should not report error if that struct_ops map (where the 
prog is resided) does not have autocreate set to true.

If a BPF program is not used in any struct_ops map, it cannot be loaded anyway 
because the prog->attach_btf_id is not set. If libbpf tries to load the prog, 
the kernel will reject it also. I think it may be a question on whether it is 
the user intention of not loading the prog if the prog is not used in any 
struct_ops map. I tend to think it is the user intention of not loading it in 
this case.

SEC("struct_ops/test1")
int BPF_PROG(test1) { ... }

SEC("struct_ops/test2")
int BPF_PROG(test2) { ... }

SEC("?.struct_ops.link") struct some_ops___v1 a = { .test1 = test1 }
SEC("?.struct_ops.link") struct some_ops___v2 b = { .test1 = test1,
						   .test2 = test2, }

In the above, the userspace may try to load with a newer some_ops___v2 first, 
failed and then try a lower version some_ops___v1 and then succeeded. The test2 
prog will not be used and not expected to be loaded.

> 
> I feel like silently not loading is the worst behavior here. So either
> loading it anyway or reporting an error would be my preference,
> probably.


