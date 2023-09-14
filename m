Return-Path: <bpf+bounces-10010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0DE7A03A5
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E901C20364
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7709219F8;
	Thu, 14 Sep 2023 12:21:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A547208BD
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:21:09 +0000 (UTC)
X-Greylist: delayed 594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 05:21:08 PDT
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com [115.236.118.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325921BF0;
	Thu, 14 Sep 2023 05:21:07 -0700 (PDT)
Received: from [192.168.0.100] (unknown [113.87.233.110])
	by mail-m12769.qiye.163.com (Hmail) with ESMTPA id E69B42803EC;
	Thu, 14 Sep 2023 20:10:28 +0800 (CST)
Message-ID: <11c01e2e-5e6a-442a-868e-b55f73ebcd7e@sangfor.com.cn>
Date: Thu, 14 Sep 2023 20:10:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
 <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
 <0bef11aa061a425f276a539a47b786ec6b661987.camel@gmail.com>
From: pengdonglin <pengdonglin@sangfor.com.cn>
In-Reply-To: <0bef11aa061a425f276a539a47b786ec6b661987.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUpMVkgZGh1MSRhMGk4dTVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVDTFVJSEhVSkpLWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8a9399908db243kuuue69b42803ec
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mj46Pxw4Tj1KMwxWDwJPNxMT
	Gj4aCT9VSlVKTUJPTUJIT0lCQklJVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
	WRILWUFZSkpIVUNMVUlISFVKSktZV1kIAVlBSkpKTUk3Bg++

On 2023/9/13 21:45, Eduard Zingerman wrote:
> On Wed, 2023-09-13 at 14:34 +0100, Alan Maguire wrote:
>> On 13/09/2023 11:32, pengdonglin wrote:
>>> On 2023/9/13 2:46, Alexei Starovoitov wrote:
>>>> On Tue, Sep 12, 2023 at 10:03 AM Eduard Zingerman <eddyz87@gmail.com>
>>>> wrote:
>>>>>
>>>>> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
>>>>>> On Tue, Sep 12, 2023 at 7:19 AM Eduard Zingerman <eddyz87@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>>>>>>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>>>>>>>> Currently, we are only using the linear search method to find the
>>>>>>>>> type id
>>>>>>>>> by the name, which has a time complexity of O(n). This change
>>>>>>>>> involves
>>>>>>>>> sorting the names of btf types in ascending order and using
>>>>>>>>> binary search,
>>>>>>>>> which has a time complexity of O(log(n)). This idea was inspired
>>>>>>>>> by the
>>>>>>>>> following patch:
>>>>>>>>>
>>>>>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of
>>>>>>>>> kallsyms_lookup_name()").
>>>>>>>>>
>>>>>>>>> At present, this improvement is only for searching in vmlinux's and
>>>>>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or
>>>>>>>>> BTF_KIND_STRUCT.
>>>>>>>>>
>>>>>>>>> Another change is the search direction, where we search the BTF
>>>>>>>>> first and
>>>>>>>>> then its base, the type id of the first matched btf_type will be
>>>>>>>>> returned.
>>>>>>>>>
>>>>>>>>> Here is a time-consuming result that finding all the type ids of
>>>>>>>>> 67,819 kernel
>>>>>>>>> functions in vmlinux's BTF by their names:
>>>>>>>>>
>>>>>>>>> Before: 17000 ms
>>>>>>>>> After:     10 ms
>>>>>>>>>
>>>>>>>>> The average lookup performance has improved about 1700x at the
>>>>>>>>> above scenario.
>>>>>>>>>
>>>>>>>>> However, this change will consume more memory, for example,
>>>>>>>>> 67,819 kernel
>>>>>>>>> functions will allocate about 530KB memory.
>>>>>>>>
>>>>>>>> Hi Donglin,
>>>>>>>>
>>>>>>>> I think this is a good improvement. However, I wonder, why did you
>>>>>>>> choose to have a separate name map for each BTF kind?
>>>>>>>>
>>>>>>>> I did some analysis for my local testing kernel config and got
>>>>>>>> such numbers:
>>>>>>>> - total number of BTF objects: 97350
>>>>>>>> - number of FUNC and STRUCT objects: 51597
>>>>>>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC
>>>>>>>> objects: 56817
>>>>>>>>     (these are all kinds for which lookup by name might make sense)
>>>>>>>> - number of named objects: 54246
>>>>>>>> - number of name collisions:
>>>>>>>>     - unique names: 53985 counts
>>>>>>>>     - 2 objects with the same name: 129 counts
>>>>>>>>     - 3 objects with the same name: 3 counts
>>>>>>>>
>>>>>>>> So, it appears that having a single map for all named objects makes
>>>>>>>> sense and would also simplify the implementation, what do you think?
>>>>>>>
>>>>>>> Some more numbers for my config:
>>>>>>> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
>>>>>>> - 43575 funcs, log2 43575 = 15.4
>>>>>>> Thus, having separate map for types vs functions might save ~1.7
>>>>>>> search iterations. Is this a significant slowdown in practice?
>>>>>>
>>>>>> What do you propose to do in case of duplicates ?
>>>>>> func and struct can have the same name, but they will have two
>>>>>> different
>>>>>> btf_ids. How do we store them ?
>>>>>> Also we might add global vars to BTF. Such request came up several
>>>>>> times.
>>>>>> So we need to make sure our search approach scales to
>>>>>> func, struct, vars. I don't recall whether we search any other kinds.
>>>>>> Separate arrays for different kinds seems ok.
>>>>>> It's a bit of code complexity, but it's not an increase in memory.
>>>>>
>>>>> Binary search gives, say, lowest index of a thing with name A, then
>>>>> increment index while name remains A looking for correct kind.
>>>>> Given the name conflicts info from above, 99% of times there would be
>>>>> no need to iterate and in very few cases there would a couple of
>>>>> iterations.
>>>>>
>>>>> Same logic would be necessary with current approach if different BTF
>>>>> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that these
>>>>> cohorts are mainly a way to split the tree for faster lookups, but
>>>>> maybe that is not the main intent.
>>>>>
>>>>>> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
>>>>>> extra memory. That's quite a bit. Anything we can do to compress it?
>>>>>
>>>>> That's an interesting question, from the top of my head:
>>>>> pre-sort in pahole (re-assign IDs so that increasing ID also would
>>>>> mean "increasing" name), shouldn't be that difficult.
>>>>
>>>> That sounds great. kallsyms are pre-sorted at build time.
>>>> We should do the same with BTF.
>>>> I think GCC can emit BTF directly now and LLVM emits it for bpf progs
>>>> too,
>>>> but since vmlinux and kernel module BTFs will keep being processed
>>>> through pahole we don't have to make gcc/llvm sort things right away.
>>>> pahole will be enough. The kernel might do 'is it sorted' check
>>>> during BTF validation and then use binary search or fall back to linear
>>>> when not-sorted == old pahole.
>>>>
>>>
>>> Yeah, I agree and will attempt to modify the pahole and perform a test.
>>> Do we need
>>> to introduce a new macro to control the behavior when the BTF is not
>>> sorted? If
>>> it is not sorted, we can use the method mentioned in this patch or use
>>> linear
>>> search.
>>>
>>>
>>
>> One challenge with pahole is that it often runs in parallel mode, so I
>> suspect any sorting would have to be done after merging across threads.
>> Perhaps BTF deduplication time might be a useful time to re-sort by
>> name? BTF dedup happens after BTF has been merged, and a new "sorted"
>> btf_dedup_opts option could be added and controlled by a pahole
>> option. However dedup is pretty complicated already..
> 
> Hi Alan,
> 
> libbpf might be the right place to do this, however, I think that it is
> also doable in pahole's btf_encoder__encode(), e.g. as follows:
> - after a call to btf__dedup():
>    - create a sorted by name IDs ordering;
>    - create a new BTF object;
>    - add records to the new BTF according to the sorted ordering;
>    - remap id references while adding;
>    - use the new BTF object instead of old one to write BTF output.
> 
> I assume that implementation would be similar regardless whether it is
> done in pahole or in libbpf.

Sounds good ;). We can place named objects at the start and may also need a
variable to keep trace of the number.

> 
> Thanks,
> Eduard
> 
>> One thing we should weigh up though is if there are benefits to the
>> way BTF is currently laid out. It tends to start with base types,
>> and often-encountered types end up being located towards the start
>> of the BTF data. For example
>>
>>
>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>> [2] CONST '(anon)' type_id=1
>> [3] VOLATILE '(anon)' type_id=1
>> [4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
>> [5] PTR '(anon)' type_id=8
>> [6] CONST '(anon)' type_id=5
>> [7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>> [8] CONST '(anon)' type_id=7
>> [9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> [10] CONST '(anon)' type_id=9
>> [11] TYPEDEF '__s8' type_id=12
>> [12] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>> [13] TYPEDEF '__u8' type_id=14
>>
>> So often-used types will be found quickly, even under linear search
>> conditions.
>>
>> When we look at how many lookups by id (which are O(1), since they are
>> done via the btf->types[] array) versus by name, we see:
>>
>> $ grep btf_type_by_id kernel/bpf/*.c|wc -l
>> 120
>> $ grep btf_find_by_nam kernel/bpf/*.c|wc -l
>> 15
>>
>> I don't see a huge number of name-based lookups, and I think most are
>> outside of the hotter codepaths, unless I'm missing some. All of which
>> is to say it would be a good idea to have a clear sense of what will get
>> faster with sorted-by-name BTF. Thanks!
>>
>> Alan
> 


