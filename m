Return-Path: <bpf+bounces-9886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFD79E558
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24B31C20FC4
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46031DDCF;
	Wed, 13 Sep 2023 10:53:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22EE23A0
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:53:30 +0000 (UTC)
Received: from mail-m127156.xmail.ntesmail.com (mail-m127156.xmail.ntesmail.com [115.236.127.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE6ACA;
	Wed, 13 Sep 2023 03:53:29 -0700 (PDT)
Received: from [10.128.10.193] (unknown [123.120.52.233])
	by mail-m11873.qiye.163.com (Hmail) with ESMTPA id F37C09007E7;
	Wed, 13 Sep 2023 18:52:46 +0800 (CST)
Message-ID: <0d8b7948-12b4-4af5-83df-b6998980398a@sangfor.com.cn>
Date: Wed, 13 Sep 2023 18:52:43 +0800
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
From: pengdonglin <pengdonglin@sangfor.com.cn>
In-Reply-To: <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTktIVk4eQx5CGU5KGEJLTVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSFVKSUtVTklVSUhIWVdZFhoPEhUdFFlBWU9LSFVKSEpOTUlVSktLVUtZBg++
X-HM-Tid: 0a8a8e2c122f2eafkusnf37c09007e7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6FAw*Cz1NNw9NHiJJFRFO
	GDFPCitVSlVKTUJPTUtJSE1DS0lMVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
	WRILWUFZSklIVUpJS1VOSVVJSEhZV1kIAVlBTkxCSjcG

On 2023/9/13 0:40, Alexei Starovoitov wrote:
> On Tue, Sep 12, 2023 at 7:19 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>>> Currently, we are only using the linear search method to find the type id
>>>> by the name, which has a time complexity of O(n). This change involves
>>>> sorting the names of btf types in ascending order and using binary search,
>>>> which has a time complexity of O(log(n)). This idea was inspired by the
>>>> following patch:
>>>>
>>>> 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").
>>>>
>>>> At present, this improvement is only for searching in vmlinux's and
>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_KIND_STRUCT.
>>>>
>>>> Another change is the search direction, where we search the BTF first and
>>>> then its base, the type id of the first matched btf_type will be returned.
>>>>
>>>> Here is a time-consuming result that finding all the type ids of 67,819 kernel
>>>> functions in vmlinux's BTF by their names:
>>>>
>>>> Before: 17000 ms
>>>> After:     10 ms
>>>>
>>>> The average lookup performance has improved about 1700x at the above scenario.
>>>>
>>>> However, this change will consume more memory, for example, 67,819 kernel
>>>> functions will allocate about 530KB memory.
>>>
>>> Hi Donglin,
>>>
>>> I think this is a good improvement. However, I wonder, why did you
>>> choose to have a separate name map for each BTF kind?
>>>
>>> I did some analysis for my local testing kernel config and got such numbers:
>>> - total number of BTF objects: 97350
>>> - number of FUNC and STRUCT objects: 51597
>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC objects: 56817
>>>    (these are all kinds for which lookup by name might make sense)
>>> - number of named objects: 54246
>>> - number of name collisions:
>>>    - unique names: 53985 counts
>>>    - 2 objects with the same name: 129 counts
>>>    - 3 objects with the same name: 3 counts
>>>
>>> So, it appears that having a single map for all named objects makes
>>> sense and would also simplify the implementation, what do you think?
>>
>> Some more numbers for my config:
>> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
>> - 43575 funcs, log2 43575 = 15.4
>> Thus, having separate map for types vs functions might save ~1.7
>> search iterations. Is this a significant slowdown in practice?
> 
> What do you propose to do in case of duplicates ?
> func and struct can have the same name, but they will have two different
> btf_ids. How do we store them ?
> Also we might add global vars to BTF. Such request came up several times.
> So we need to make sure our search approach scales to
> func, struct, vars. I don't recall whether we search any other kinds.
> Separate arrays for different kinds seems ok.
> It's a bit of code complexity, but it's not an increase in memory.
> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
> extra memory. That's quite a bit. Anything we can do to compress it?
> Folks requested vmlinux BTF to be a module, so it's loaded on demand.
> BTF memory consumption is a concern to many.
> I think before we add these per-kind search arrays we better make
> BTF optional as a module.

I think that making BTF as a module may not have much significance, since
the function bpf_get_btf_vmlinux is invoked in many places, such as during
loading a kernel module.

> 


