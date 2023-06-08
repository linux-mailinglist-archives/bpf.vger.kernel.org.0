Return-Path: <bpf+bounces-2077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DE7273E7
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 02:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22783281372
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 00:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCC8809;
	Thu,  8 Jun 2023 00:57:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1545622
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 00:57:32 +0000 (UTC)
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA926A4
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 17:57:30 -0700 (PDT)
Message-ID: <7fecf93e-eaf9-1ffe-4f1d-64f530828363@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1686185848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QX9ZuqTFz6uqO9wWrJvZ+bRKcySO/Wjy6glgWhXkYPg=;
	b=DTu9WxRQYnsHFOsPm921knfqeTXYk5PZFIc3b0cS9ldhDtKbBL/TCMGePz1FF4DXQQIDlp
	vMSIIEgYH+k2TN3syT1h2amp2A5+ms0S4tQ1Nzjdv6R9EssposaoR3mWzgv3jE1UarqPN8
	1MRQ1BxGhDnV+xh9pLzll63N8bGTWmI=
Date: Thu, 8 Jun 2023 08:57:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with
 available_filter_functions
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 bpf@vger.kernel.org, liuyun01@kylinos.cn
References: <ZG8f7ffghG7mLUhR@krava>
 <20230525102747.68708-1-liu.yun@linux.dev>
 <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev>
 <CAEf4BzbGtZJvS-8=6i3g5A9uJm9_LHVRRbye-OLTdgeWZtdrsw@mail.gmail.com>
 <ZIERQNxgXWvgxHNO@krava>
 <CAEf4BzaNpxNZ12N1JY4=EijXv14oWQMQpjF8t4zt-ZaYNp+U=Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <CAEf4BzaNpxNZ12N1JY4=EijXv14oWQMQpjF8t4zt-ZaYNp+U=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/6/8 08:00, Andrii Nakryiko 写道:
> On Wed, Jun 7, 2023 at 4:22 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Fri, Jun 02, 2023 at 10:27:31AM -0700, Andrii Nakryiko wrote:
>>> On Thu, May 25, 2023 at 6:38 PM Jackie Liu <liu.yun@linux.dev> wrote:
>>>>
>>>> Hi Andrii.
>>>>
>>>> 在 2023/5/26 04:43, Andrii Nakryiko 写道:
>>>>> On Thu, May 25, 2023 at 3:28 AM Jackie Liu <liu.yun@linux.dev> wrote:
>>>>>>
>>>>>> From: Jackie Liu <liuyun01@kylinos.cn>
>>>>>>
>>>>>> When using regular expression matching with "kprobe multi", it scans all
>>>>>> the functions under "/proc/kallsyms" that can be matched. However, not all
>>>>>> of them can be traced by kprobe.multi. If any one of the functions fails
>>>>>> to be traced, it will result in the failure of all functions. The best
>>>>>> approach is to filter out the functions that cannot be traced to ensure
>>>>>> proper tracking of the functions.
>>>>>>
>>>>>> Use available_filter_functions check first, if failed, fallback to
>>>>>> kallsyms.
>>>>>>
>>>>>> Here is the test eBPF program [1].
>>>>>> [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
>>>>>>
>>>>>> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
>>>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>>>> ---
>>>>>>    tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++-----
>>>>>>    1 file changed, 83 insertions(+), 9 deletions(-)
>>>>>>
>>>>>
>>>>> Question to you and Jiri: what happens when multi-kprobe's syms has
>>>>> duplicates? Will the program be attached multiple times? If yes, then
>>>>> it sounds like a problem? Both available_filters and kallsyms can have
>>>>> duplicate function names in them, right?
>>>>
>>>> If I understand correctly, there should be no problem with repeated
>>>> function registration, because the bottom layer is done through fprobe
>>>> registration addrs, kprobe.multi itself does not do this work, but
>>>> fprobe is based on ftrace, it will register addr by makes a hash,
>>>> that is, if it is the same address, it should be filtered out.
>>>>
>>>
>>> Looking at kernel code, it seems kernel will actually return error if
>>> user specifies multiple duplicated names. Because kernel will
>>> bsearch() to the first instance, and never resolve the second
>>> duplicated instance. And then will assume that not all symbols are
>>> resolved.
>>
>> right, as I wrote in here [1] it will fail
>>
>> [1] https://lore.kernel.org/bpf/ZHB0xNEbjmwHv18d@krava/
>>
>>>
>>> So, it worries me that we'll switch from kallsyms to available_filters
>>> by default, because that introduces new failure modes.
>>
>> we did not care about duplicate with kallsyms because we used addresses,
>> and I think with duplicate addresss the kprobe_multi link will probably
>> attach (need to check) while with duplicate symbols it won't..
>>
>> perhaps we could make sure we don't pass duplicate symbols?
> 
> I think we have to stick to kallsyms and addresses. What if I actually
> want to attach to all instances of type_show? We should take into
> account available_filter_functions, but still use addresses from
> kallsyms.
> 
> I'd also advocate working on having an available_filter_functions
> version reporting not just function names, but also its associated
> address. That would actually eliminate the need for kallsyms.
> 
> I chatted with Steven Rostedt about this at the last LSF/MM/BPF
> conference, and I think we both agreed that we both a) have all the
> information in the kernel to implement this and b) it's a good idea to
> expose all that to user space. For backwards compat reasons it will
> have to be a separate file, but it's generated on the fly, so it's not
> a big deal in terms of resource usage.

Yes, I noticed that the latest version of the kernel has added 
touched_functions and enabled_functions, are they? I'm not sure.
Perhaps we can wait for such an interface to appear before directly
switching to that interface, and then submit this patch again.

-- 
Jackie Liu

> 
> 
>>
>> we do the kprobe_multi bench with symbol names read from available_filter_functions
>> and we filter out duplicates
>>
>> jirka
>>
>>>
>>> Either way, let's add a selftest that uses a duplicate function name
>>> and see what happens?
>>>
>>>> The main problem here is not the problem of repeated registration of
>>>> functions, but some functions are not allowed to hook. For example, when
>>>> I track vfs_*, vfs_set_acl_prepare_kgid and vfs_set_acl_prepare_kuid are
>>>> not allowed to hook. These exist under kallsyms, but
>>>> available_filter_functions does not, I have observed for a while,
>>>> matching through available_filter_functions can effectively prevent this
>>>> from happening.
>>>
>>> Yeah, I understand that. My point above is that a)
>>> available_filter_functions contains duplicates and b) doesn't contain
>>> addresses. So we are forced to rely on kernel string -> addr
>>> resolution, which doesn't seem to handle duplicate entries well (let's
>>> test).
>>>
>>> So it's a regression to switch to that without taking any other precautions.
>>>
>>>>
>>>>>
>>>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>>>> index ad1ec893b41b..3dd72d69cdf7 100644
>>>>>> --- a/tools/lib/bpf/libbpf.c
>>>>>> +++ b/tools/lib/bpf/libbpf.c
>>>>>> @@ -10417,13 +10417,14 @@ static bool glob_match(const char *str, const char *pat)
>>>>>>    struct kprobe_multi_resolve {
>>>>>>           const char *pattern;
>>>>>>           unsigned long *addrs;
>>>>>> +       const char **syms;
>>>>>>           size_t cap;
>>>>>>           size_t cnt;
>>>>>>    };
>>>>>>
>>>
>>> [...]

