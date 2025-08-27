Return-Path: <bpf+bounces-66733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C7B38BBB
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B893616554B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150030EF8F;
	Wed, 27 Aug 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmS8L7LB"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448E30E0F9
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331782; cv=none; b=KNEijm0MRmH95Do1+VxwyH6I5mYeFWIel9yYqkUvT5U7RR6KjT1wAEiQXd40nzpsIkJUeHPZraGOIsz5dym6M5gnRdtXIQekhV51o4xsEhtbtKEEQI2ngm8js76119R+UqhHdPf/AOjQ8O3RH+l9f/lEyVz9btbxwvETqHEZKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331782; c=relaxed/simple;
	bh=H+pfRO9h648rdk+IzP524QlF3ejwb8HlQPoVqvFuIlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcffmc6tMMGrvKai068Qa2j7pIEXhQkcn1a0DIYXjJ4LeNuKnJFbvn3+QirPId5IAXwpwJ35cjdwm7hNtfbX5Kov543GBmP7VQCmix89Uep+LSWr69gjD9qA1NVLF6lW+u4WdXoG2nsQx3CqCUul0xhFMZaYHMcuFAO01ZmsKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmS8L7LB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <643863ab-0eb4-40f0-af44-4815f171341f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756331777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxIBxahfMoDVTTdr77B0gYXWYByJrW9zFcNYqiFjAQY=;
	b=fmS8L7LBrPrGgFJarSgrvI3zPgqH7fHLMjDhIcUcKxv/FyuPyq+1/z4557l7KJbjbaptzo
	tSqHjqtenMkWIFNJN8DsEEW9FbS3ZpUbETWO3/5gBfE2VGIwf+bJYgkoXSzOarcI8wtgvX
	XJdXRptgTW9ed/YHz8wbXkdOovZS3sM=
Date: Wed, 27 Aug 2025 14:56:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Annotate
 bpf_obj_new_impl() with __must_check
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250827130519.411700-1-iii@linux.ibm.com>
 <20250827130519.411700-2-iii@linux.ibm.com>
 <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com>
 <1c796beb8e6d864f6c7498b8a31e2085986e2d60.camel@linux.ibm.com>
 <CAEf4BzYaZJ-TH_T32QpuxdeXOa4yt1dqrExbV6xrsXvs+kp6kQ@mail.gmail.com>
 <f1b6178d73d242c20ac2345d2da9293dd3d1906f.camel@linux.ibm.com>
 <b1b7ffb001712eca27cfafb71365920833eafcd9.camel@linux.ibm.com>
 <CAEf4BzY3wpBSQY5CWkm7CLrD3ZHHoq6LR7dOiCiT6=TmKONGLQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzY3wpBSQY5CWkm7CLrD3ZHHoq6LR7dOiCiT6=TmKONGLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/27/25 2:28 PM, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 2:04 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>
>> On Wed, 2025-08-27 at 22:54 +0200, Ilya Leoshkevich wrote:
>>> On Wed, 2025-08-27 at 13:05 -0700, Andrii Nakryiko wrote:
>>>> On Wed, Aug 27, 2025 at 11:34 AM Ilya Leoshkevich
>>>> <iii@linux.ibm.com>
>>>> wrote:
>>>>>
>>>>> On Wed, 2025-08-27 at 10:32 -0700, Andrii Nakryiko wrote:
>>>>>> On Wed, Aug 27, 2025 at 6:05 AM Ilya Leoshkevich
>>>>>> <iii@linux.ibm.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> The verifier requires that pointers returned by
>>>>>>> bpf_obj_new_impl()
>>>>>>> are
>>>>>>> either dropped or stored in a map. Therefore programs that do
>>>>>>> not
>>>>>>> use
>>>>>>> its return values will fail to load. Make the compiler point
>>>>>>> out
>>>>>>> these
>>>>>>> issues. Adjust selftests that check that the verifier does
>>>>>>> indeed
>>>>>>> spot
>>>>>>> these bugs.
>>>>>>>
>>>>>>> Link:
>>>>>>> https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com/
>>>>>>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>>>>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>>>> ---
>>>>>>>   tools/lib/bpf/bpf_helpers.h                          | 4
>>>>>>> ++++
>>>>>>>   tools/testing/selftests/bpf/bpf_experimental.h       | 2 +-
>>>>>>>   tools/testing/selftests/bpf/progs/linked_list_fail.c | 8
>>>>>>> ++++-
>>>>>>> ---
>>>>>>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>>
>>> [...]
>>>
>>>>>>>   /* When utilizing vmlinux.h with BPF CO-RE, user BPF
>>>>>>> programs
>>>>>>> can't include
>>>>>>>    * any system-level headers (such as stddef.h,
>>>>>>> linux/version.h,
>>>>>>> etc), and
>>>>>>>    * commonly-used macros like NULL and KERNEL_VERSION aren't
>>>>>>> available through
>>>>>>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
>>>>>>> b/tools/testing/selftests/bpf/bpf_experimental.h
>>>>>>> index da7e230f2781..e5ef4792da42 100644
>>>>>>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>>>>>>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>>>>>>> @@ -20,7 +20,7 @@
>>>>>>>    *     A pointer to an object of the type corresponding to
>>>>>>> the
>>>>>>> passed in
>>>>>>>    *     'local_type_id', or NULL on failure.
>>>>>>>    */
>>>>>>> -extern void *bpf_obj_new_impl(__u64 local_type_id, void
>>>>>>> *meta)
>>>>>>> __ksym;
>>>>>>> +extern __must_check void *bpf_obj_new_impl(__u64
>>>>>>> local_type_id,
>>>>>>> void *meta) __ksym;
>>>>>>
>>>>>> bpf_obj_new_impl will generally come from vmlinux.h nowadays,
>>>>>> and
>>>>>> that
>>>>>> one won't have __must_check annotation, is that a problem?
>>>>>
>>>>> It should be fine according to [1]:
>>>>>
>>>>> Compatible attribute specifications on distinct declarations of
>>>>> the
>>>>> same function are merged.
>>>>>
>>>>> I will add this to the commit message in v3.
>>>>
>>>> Sure, for BPF selftests it will work. My question was broader, for
>>>> anyone using bpf_obj_new in the wild, they won't have __must_check
>>>> annotation from vmlinux.h (and I doubt they will manually add it
>>>> like
>>>> we do here for BPF selftests), so if that's important, I guess we
>>>> need
>>>> to think how to wire that up so that it happens automatically
>>>> through
>>>> vmlinux.h.
>>>>
>>>> "It's not that important to bother" is a fine answer as well :)
>>>
>>> I see. Seems like it's tough:
>>>
>>> - The attribute is not available in DWARF
>>> - But we could introduce KF_MUST_CHECK flag
>>> - Which pahole would extract from .BTF_ids and convert to
>>>    a btf_decl_tag
>>>    - This will make pahole depend on .BTF_ids format though, which
>>> might
>>>      be undesirable
>>
>> Hm, I should have checked that before hitting "send": apparently pahole
>> already parses both .BTF_ids and __BTF_ID__set8__*.
> 
> Correct, this isn't any new dependency.
> 
>> Still, DW_TAG_GNU_annotation looks like a better long-term solution.
> 
> Ihor a bit earlier added BTF-specific way to attach any random
> attribute to BTF type (it's a special form of
> BTF_TYPE_TAG/BTF_DECL_TAG), I think it's still on his plate to wire up
> the use of that for a few long-standing issues with vmlinux.h, so this
> might be yet another reason and use case for that.

Acked. Thanks for the reminder...

Although in this particular case (__must_check) there is still an
issue of passing through the attribute from kernel source to pahole,
and AFAIU the only feasible way to do that right now is via KF_ flags.

So this DW_TAG_GNU_annotation looks promising, because with that
pahole could read annotations from DWARF directly, without special
handling of .BTF_ids data.

But then we probably don't want pahole to put _all_ the attributes in
BTF, there might be too many of attributes we don't care about. Still,
a filter on a generic DWARF tag is much simpler then what we have now.

Ilya, thanks for sharing. I wasn't aware of DW_TAG_GNU_annotation
development.

> 
> But agreed, for now I'd go with BPF selftests-specific mitigation.
> 
>>
>>> - Then bpftool would convert this btf_decl_tag to __must_check
>>>
>>> Seems like they are attempting to upstream the new
>>> DW_TAG_GNU_annotation right now [1], if that lands and is available
>>> for non-BPF targets, we could put
>>> __attribute((btf_decl_tag("must_check"))) on kernel's
>>> bpf_obj_new_impl() and directly access it from bpftool.
>>>
>>> So for now I would propose to limit the solution to selftests.
>>>
>>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692445.html
>>>
>>>>> [1]
>>>>> https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.html
>>>>>
>>>>> [...]


