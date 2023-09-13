Return-Path: <bpf+bounces-9884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BB779E4FB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 12:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E02B1C20F68
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE61775D;
	Wed, 13 Sep 2023 10:33:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB53210
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:33:21 +0000 (UTC)
Received: from mail-m49247.qiye.163.com (mail-m49247.qiye.163.com [45.254.49.247])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DBD3;
	Wed, 13 Sep 2023 03:33:20 -0700 (PDT)
Received: from [10.128.10.193] (unknown [123.120.52.233])
	by mail-m12739.qiye.163.com (Hmail) with ESMTPA id BAEF74A0314;
	Wed, 13 Sep 2023 18:32:46 +0800 (CST)
Message-ID: <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
Date: Wed, 13 Sep 2023 18:32:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, dinghui@sangfor.com.cn,
 huangcun@sangfor.com.cn, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
 <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
 <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
From: pengdonglin <pengdonglin@sangfor.com.cn>
In-Reply-To: <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHh4YVklLTkxLHh9CTU1LGlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSFVKSUtVTklVSUhIWVdZFhoPEhUdFFlBWU9LSFVKSEpOTUlVSktLVUtZBg++
X-HM-Tid: 0a8a8e19c1c8b212kuuubaef74a0314
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6Lgw*KD1WPw86NQ4VSk03
	IS4KFAxVSlVKTUJPTUtKSk1MQ0xNVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
	WRILWUFZSklIVUpJS1VOSVVJSEhZV1kIAVlBTE9IQzcG

On 2023/9/13 2:46, Alexei Starovoitov wrote:
> On Tue, Sep 12, 2023 at 10:03 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
>>> On Tue, Sep 12, 2023 at 7:19 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>
>>>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>>>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>>>>> Currently, we are only using the linear search method to find the type id
>>>>>> by the name, which has a time complexity of O(n). This change involves
>>>>>> sorting the names of btf types in ascending order and using binary search,
>>>>>> which has a time complexity of O(log(n)). This idea was inspired by the
>>>>>> following patch:
>>>>>>
>>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").
>>>>>>
>>>>>> At present, this improvement is only for searching in vmlinux's and
>>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_KIND_STRUCT.
>>>>>>
>>>>>> Another change is the search direction, where we search the BTF first and
>>>>>> then its base, the type id of the first matched btf_type will be returned.
>>>>>>
>>>>>> Here is a time-consuming result that finding all the type ids of 67,819 kernel
>>>>>> functions in vmlinux's BTF by their names:
>>>>>>
>>>>>> Before: 17000 ms
>>>>>> After:     10 ms
>>>>>>
>>>>>> The average lookup performance has improved about 1700x at the above scenario.
>>>>>>
>>>>>> However, this change will consume more memory, for example, 67,819 kernel
>>>>>> functions will allocate about 530KB memory.
>>>>>
>>>>> Hi Donglin,
>>>>>
>>>>> I think this is a good improvement. However, I wonder, why did you
>>>>> choose to have a separate name map for each BTF kind?
>>>>>
>>>>> I did some analysis for my local testing kernel config and got such numbers:
>>>>> - total number of BTF objects: 97350
>>>>> - number of FUNC and STRUCT objects: 51597
>>>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC objects: 56817
>>>>>    (these are all kinds for which lookup by name might make sense)
>>>>> - number of named objects: 54246
>>>>> - number of name collisions:
>>>>>    - unique names: 53985 counts
>>>>>    - 2 objects with the same name: 129 counts
>>>>>    - 3 objects with the same name: 3 counts
>>>>>
>>>>> So, it appears that having a single map for all named objects makes
>>>>> sense and would also simplify the implementation, what do you think?
>>>>
>>>> Some more numbers for my config:
>>>> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
>>>> - 43575 funcs, log2 43575 = 15.4
>>>> Thus, having separate map for types vs functions might save ~1.7
>>>> search iterations. Is this a significant slowdown in practice?
>>>
>>> What do you propose to do in case of duplicates ?
>>> func and struct can have the same name, but they will have two different
>>> btf_ids. How do we store them ?
>>> Also we might add global vars to BTF. Such request came up several times.
>>> So we need to make sure our search approach scales to
>>> func, struct, vars. I don't recall whether we search any other kinds.
>>> Separate arrays for different kinds seems ok.
>>> It's a bit of code complexity, but it's not an increase in memory.
>>
>> Binary search gives, say, lowest index of a thing with name A, then
>> increment index while name remains A looking for correct kind.
>> Given the name conflicts info from above, 99% of times there would be
>> no need to iterate and in very few cases there would a couple of iterations.
>>
>> Same logic would be necessary with current approach if different BTF
>> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that these
>> cohorts are mainly a way to split the tree for faster lookups, but
>> maybe that is not the main intent.
>>
>>> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
>>> extra memory. That's quite a bit. Anything we can do to compress it?
>>
>> That's an interesting question, from the top of my head:
>> pre-sort in pahole (re-assign IDs so that increasing ID also would
>> mean "increasing" name), shouldn't be that difficult.
> 
> That sounds great. kallsyms are pre-sorted at build time.
> We should do the same with BTF.
> I think GCC can emit BTF directly now and LLVM emits it for bpf progs too,
> but since vmlinux and kernel module BTFs will keep being processed
> through pahole we don't have to make gcc/llvm sort things right away.
> pahole will be enough. The kernel might do 'is it sorted' check
> during BTF validation and then use binary search or fall back to linear
> when not-sorted == old pahole.
> 

Yeah, I agree and will attempt to modify the pahole and perform a test. Do we need
to introduce a new macro to control the behavior when the BTF is not sorted? If
it is not sorted, we can use the method mentioned in this patch or use linear
search.


