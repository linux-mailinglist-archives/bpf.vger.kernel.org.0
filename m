Return-Path: <bpf+bounces-9996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA297A0198
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD52281901
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677820B2B;
	Thu, 14 Sep 2023 10:23:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801151D524
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 10:23:11 +0000 (UTC)
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 03:23:10 PDT
Received: from m84-178.qiye.163.com (m84-178.qiye.163.com [123.58.178.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE91BEC;
	Thu, 14 Sep 2023 03:23:09 -0700 (PDT)
Received: from [192.168.0.100] (unknown [113.87.233.110])
	by mail-m11873.qiye.163.com (Hmail) with ESMTPA id B107890036D;
	Thu, 14 Sep 2023 18:13:30 +0800 (CST)
Message-ID: <a0bd3ed9-afe7-49a4-a394-949bd5831d6d@sangfor.com.cn>
Date: Thu, 14 Sep 2023 18:13:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
 <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
From: pengdonglin <pengdonglin@sangfor.com.cn>
In-Reply-To: <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGBkaVkNIGEkeHkJIGkJOTFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVDTFVJSEhVSkpLWVdZFhoPEhUdFFlBWU9LSFVKSEpCSE9VSktLVUtZBg++
X-HM-Tid: 0a8a932e79542eafkusnb107890036d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6KBw4ST1PAQwNCgoQMClL
	IzMwCRlVSlVKTUJPTUNNT0pKTE5DVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
	WRILWUFZSkpIVUNMVUlISFVKSktZV1kIAVlBSklNSEo3Bg++

On 2023/9/13 21:34, Alan Maguire wrote:
> On 13/09/2023 11:32, pengdonglin wrote:
>> On 2023/9/13 2:46, Alexei Starovoitov wrote:
>>> On Tue, Sep 12, 2023 at 10:03 AM Eduard Zingerman <eddyz87@gmail.com>
>>> wrote:
>>>>
>>>> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
>>>>> On Tue, Sep 12, 2023 at 7:19 AM Eduard Zingerman <eddyz87@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>>>>>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>>>>>>> Currently, we are only using the linear search method to find the
>>>>>>>> type id
>>>>>>>> by the name, which has a time complexity of O(n). This change
>>>>>>>> involves
>>>>>>>> sorting the names of btf types in ascending order and using
>>>>>>>> binary search,
>>>>>>>> which has a time complexity of O(log(n)). This idea was inspired
>>>>>>>> by the
>>>>>>>> following patch:
>>>>>>>>
>>>>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of
>>>>>>>> kallsyms_lookup_name()").
>>>>>>>>
>>>>>>>> At present, this improvement is only for searching in vmlinux's and
>>>>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or
>>>>>>>> BTF_KIND_STRUCT.
>>>>>>>>
>>>>>>>> Another change is the search direction, where we search the BTF
>>>>>>>> first and
>>>>>>>> then its base, the type id of the first matched btf_type will be
>>>>>>>> returned.
>>>>>>>>
>>>>>>>> Here is a time-consuming result that finding all the type ids of
>>>>>>>> 67,819 kernel
>>>>>>>> functions in vmlinux's BTF by their names:
>>>>>>>>
>>>>>>>> Before: 17000 ms
>>>>>>>> After:     10 ms
>>>>>>>>
>>>>>>>> The average lookup performance has improved about 1700x at the
>>>>>>>> above scenario.
>>>>>>>>
>>>>>>>> However, this change will consume more memory, for example,
>>>>>>>> 67,819 kernel
>>>>>>>> functions will allocate about 530KB memory.
>>>>>>>
>>>>>>> Hi Donglin,
>>>>>>>
>>>>>>> I think this is a good improvement. However, I wonder, why did you
>>>>>>> choose to have a separate name map for each BTF kind?
>>>>>>>
>>>>>>> I did some analysis for my local testing kernel config and got
>>>>>>> such numbers:
>>>>>>> - total number of BTF objects: 97350
>>>>>>> - number of FUNC and STRUCT objects: 51597
>>>>>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC
>>>>>>> objects: 56817
>>>>>>>     (these are all kinds for which lookup by name might make sense)
>>>>>>> - number of named objects: 54246
>>>>>>> - number of name collisions:
>>>>>>>     - unique names: 53985 counts
>>>>>>>     - 2 objects with the same name: 129 counts
>>>>>>>     - 3 objects with the same name: 3 counts
>>>>>>>
>>>>>>> So, it appears that having a single map for all named objects makes
>>>>>>> sense and would also simplify the implementation, what do you think?
>>>>>>
>>>>>> Some more numbers for my config:
>>>>>> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
>>>>>> - 43575 funcs, log2 43575 = 15.4
>>>>>> Thus, having separate map for types vs functions might save ~1.7
>>>>>> search iterations. Is this a significant slowdown in practice?
>>>>>
>>>>> What do you propose to do in case of duplicates ?
>>>>> func and struct can have the same name, but they will have two
>>>>> different
>>>>> btf_ids. How do we store them ?
>>>>> Also we might add global vars to BTF. Such request came up several
>>>>> times.
>>>>> So we need to make sure our search approach scales to
>>>>> func, struct, vars. I don't recall whether we search any other kinds.
>>>>> Separate arrays for different kinds seems ok.
>>>>> It's a bit of code complexity, but it's not an increase in memory.
>>>>
>>>> Binary search gives, say, lowest index of a thing with name A, then
>>>> increment index while name remains A looking for correct kind.
>>>> Given the name conflicts info from above, 99% of times there would be
>>>> no need to iterate and in very few cases there would a couple of
>>>> iterations.
>>>>
>>>> Same logic would be necessary with current approach if different BTF
>>>> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that these
>>>> cohorts are mainly a way to split the tree for faster lookups, but
>>>> maybe that is not the main intent.
>>>>
>>>>> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
>>>>> extra memory. That's quite a bit. Anything we can do to compress it?
>>>>
>>>> That's an interesting question, from the top of my head:
>>>> pre-sort in pahole (re-assign IDs so that increasing ID also would
>>>> mean "increasing" name), shouldn't be that difficult.
>>>
>>> That sounds great. kallsyms are pre-sorted at build time.
>>> We should do the same with BTF.
>>> I think GCC can emit BTF directly now and LLVM emits it for bpf progs
>>> too,
>>> but since vmlinux and kernel module BTFs will keep being processed
>>> through pahole we don't have to make gcc/llvm sort things right away.
>>> pahole will be enough. The kernel might do 'is it sorted' check
>>> during BTF validation and then use binary search or fall back to linear
>>> when not-sorted == old pahole.
>>>
>>
>> Yeah, I agree and will attempt to modify the pahole and perform a test.
>> Do we need
>> to introduce a new macro to control the behavior when the BTF is not
>> sorted? If
>> it is not sorted, we can use the method mentioned in this patch or use
>> linear
>> search.
>>
>>
> 
> One challenge with pahole is that it often runs in parallel mode, so I
> suspect any sorting would have to be done after merging across threads.
> Perhaps BTF deduplication time might be a useful time to re-sort by
> name? BTF dedup happens after BTF has been merged, and a new "sorted"
> btf_dedup_opts option could be added and controlled by a pahole
> option. However dedup is pretty complicated already..
> 
> One thing we should weigh up though is if there are benefits to the
> way BTF is currently laid out. It tends to start with base types,
> and often-encountered types end up being located towards the start
> of the BTF data. For example
> 
> 
> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [2] CONST '(anon)' type_id=1
> [3] VOLATILE '(anon)' type_id=1
> [4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
> [5] PTR '(anon)' type_id=8
> [6] CONST '(anon)' type_id=5
> [7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> [8] CONST '(anon)' type_id=7
> [9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [10] CONST '(anon)' type_id=9
> [11] TYPEDEF '__s8' type_id=12
> [12] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> [13] TYPEDEF '__u8' type_id=14
> 
> So often-used types will be found quickly, even under linear search
> conditions.

I found that there seems to be no code in the kernel that get the ID of the
basic data type by calling btf_find_by_name_kind directly. The general usage
of this function is to obtain the ID of a structure or function. After we got
the ID of a structure or function, it is O(1) to get the IDs of its members
or parameters.

./kernel/trace/trace_probe.c:383:       id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
./kernel/bpf/btf.c:3523:        id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
./kernel/bpf/btf.c:5504:                id = btf_find_by_name_kind(btf, alloc_obj_fields[i], BTF_KIND_STRUCT);
./kernel/bpf/bpf_struct_ops.c:128:      module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
./net/ipv4/bpf_tcp_ca.c:28:     type_id = btf_find_by_name_kind(btf, "sock", BTF_KIND_STRUCT);
./net/ipv4/bpf_tcp_ca.c:33:     type_id = btf_find_by_name_kind(btf, "tcp_sock", BTF_KIND_STRUCT);
./net/netfilter/nf_bpf_link.c:181:      type_id = btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);

> 
> When we look at how many lookups by id (which are O(1), since they are
> done via the btf->types[] array) versus by name, we see:
> 
> $ grep btf_type_by_id kernel/bpf/*.c|wc -l
> 120
> $ grep btf_find_by_nam kernel/bpf/*.c|wc -l
> 15
> 
> I don't see a huge number of name-based lookups, and I think most are
> outside of the hotter codepaths, unless I'm missing some. All of which
> is to say it would be a good idea to have a clear sense of what will get
> faster with sorted-by-name BTF. Thanks!

The story goes like this.

I have added a new feature to the function graph called "funcgraph_retval",
here is the link:

https://lore.kernel.org/all/1fc502712c981e0e6742185ba242992170ac9da8.1680954589.git.pengdonglin@sangfor.com.cn/

We can obtain the return values of almost every function during the execution
of kernel through this feature, it can help us analyze problems.

However, this feature has two main drawbacks.

1. Even if a function's return type is void,  a return value will still be printed.

2. The return value printed may be incorrect when the width of the return type is
smaller than the generic register.

I think if we can get this return type of the function, then the drawbacks mentioned
above can be eliminated. The function btf_find_by_name_kind can be used to get the ID of
the kernel function, then we can get its return type easily. If the return type is
void, the return value recorded will not be printed. If the width of the return type
is smaller than the generic register, then the value stored in the upper bits will be
trimmed. I have written a demo and these drawbacks were resolved.

However, during my test, I found that it took too much time when read the trace log
with this feature enabled, because the trace log consists of 200,000 lines. The
majority of the time was consumed by the btf_find_by_name_kind, which is called
200,000 times.

So I think the performance of btf_find_by_name_kind  may need to be improved.

> 
> Alan
> 


