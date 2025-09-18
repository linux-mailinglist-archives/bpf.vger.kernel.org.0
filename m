Return-Path: <bpf+bounces-68729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80343B828CA
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 03:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE6C462FD2
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83018189F3B;
	Thu, 18 Sep 2025 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YWHoaQKq"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995F23741
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160062; cv=none; b=QQTNUHiXVrUMMw+B/mqW1TqbnEP9hxU2CBPp4EhhomcogSoWg7i3Rrxf/1z3FRfiwS0lZP4f9sV5MtzLMG1+r7ym6N57TZ3zCdaNzi2a+DGWFegEgO4fXYk64kN/1CJK+W037n1uqLkWdpwa/Wjs1VjCut8FWN7FqAIuYFQgZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160062; c=relaxed/simple;
	bh=15W8wPSXEJ8nCTJpQwCThqY6iVyHUCC7KTarr0O2IVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=assItOGQgdyIzy2FSmPBO9QQEtAdcToB++JE8dgT34TejW/kACUOKvdZutY9+6VbPRypx098+b+fvgjyD/tr29YINIRbvjBjiJA5RISxo+9p3/eTsUJuiurgn3Qded2XlUJ1rdjZ13ioDksiE5+KD3oiZYgG4ntKtsltZgNSVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YWHoaQKq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8f45af4-b19c-4811-8928-1c9acc2a9120@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758160058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jRhZB7rQ1SSgHAzGT04ij75/4HzHEVofnLku2MLYI0=;
	b=YWHoaQKqpBgMXuTKQdPlkbhn+mWnLQ4C+mTfBKSOrWOE7x1Rh3yswXRcpdqA8zVPl85Xyx
	gghqtX4k1A1O8GzEFqqE4krEqS6A/aR0vpQyFJ/9+ce6BeTfEVuy9rzKFhHEU5D68Yw8Fc
	pLcfGbjQM6WMW4KvN7Fl8CDgCmanw+s=
Date: Thu, 18 Sep 2025 09:47:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Allow union argument in trampoline
 based programs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Mykyta Yatsenko <yatsenko@meta.com>, Puranjay Mohan <puranjay@kernel.org>,
 davidzalman.101@gmail.com, cheick.traore@foss.st.com,
 Tao Chen <chen.dylane@linux.dev>, mika.westerberg@linux.intel.com,
 Menglong Dong <menglong8.dong@gmail.com>, kernel-patches-bot@fb.com
References: <20250916155211.61083-1-leon.hwang@linux.dev>
 <20250916155211.61083-2-leon.hwang@linux.dev>
 <CAMB2axM2o+tr0hUJYWgPRO7sGg5rE5RSa_tW_sHY_oegi1_bbg@mail.gmail.com>
 <DCV2ZG5KIFEO.R8HEGONFWBLP@linux.dev>
 <CAADnVQ+bAvzjbB+u-_skndu8bNKFUzrNZT7erc-nmayOyEN5+Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+bAvzjbB+u-_skndu8bNKFUzrNZT7erc-nmayOyEN5+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 18/9/25 02:13, Alexei Starovoitov wrote:
> On Wed, Sep 17, 2025 at 5:40 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On Wed Sep 17, 2025 at 5:35 AM +08, Amery Hung wrote:
>>> On Tue, Sep 16, 2025 at 8:52 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> Currently, functions with 'union' arguments cannot be traced with
>>>> fentry/fexit:
>>>>
>>>> bpftrace -e 'fentry:release_pages { exit(); }' -v
>>>> AST node count: 6
>>>> Attaching 1 probe...
>>>> ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
>>>> Kernel error log:
>>>> The function release_pages arg0 type UNION is unsupported.
>>>> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>>>
>>>> ERROR: Loading BPF object(s) failed.
>>>>
>>>> The type of the 'release_pages' argument is defined as:
>>>>
>>>> typedef union {
>>>>         struct page **pages;
>>>>         struct folio **folios;
>>>>         struct encoded_page **encoded_pages;
>>>> } release_pages_arg __attribute__ ((__transparent_union__));
>>>>
>>>> This patch relaxes the restriction by allowing function arguments of type
>>>> 'union' to be traced in verifier.
>>>>
>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>> ---
>>>>  include/linux/bpf.h | 3 +++
>>>>  include/linux/btf.h | 5 +++++
>>>>  kernel/bpf/btf.c    | 8 +++++---
>>>>  3 files changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 41f776071ff51..010ecbb798c60 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -1119,6 +1119,9 @@ struct bpf_prog_offload {
>>>>  /* The argument is signed. */
>>>>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
>>>>
>>>> +/* The argument is a union. */
>>>> +#define BTF_FMODEL_UNION_ARG           BIT(2)
>>>> +
>>>
>>> [...]
>>>
>>>>  struct btf_func_model {
>>>>         u8 ret_size;
>>>>         u8 ret_flags;
>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>> index 9eda6b113f9b4..255f8c6bd2438 100644
>>>> --- a/include/linux/btf.h
>>>> +++ b/include/linux/btf.h
>>>> @@ -404,6 +404,11 @@ static inline bool btf_type_is_struct(const struct btf_type *t)
>>>>         return kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
>>>>  }
>>>>
>>>> +static inline bool __btf_type_is_union(const struct btf_type *t)
>>>> +{
>>>> +       return BTF_INFO_KIND(t->info) == BTF_KIND_UNION;
>>>> +}
>>>> +
>>>>  static inline bool __btf_type_is_struct(const struct btf_type *t)
>>>>  {
>>>>         return BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT;
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> index 64739308902f7..2a85c51412bea 100644
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>> @@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>>>         /* skip modifiers */
>>>>         while (btf_type_is_modifier(t))
>>>>                 t = btf_type_by_id(btf, t->type);
>>>> -       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>>>> +       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
>>>>                 /* accessing a scalar */
>>>>                 return true;
>>>>         if (!btf_type_is_ptr(t)) {
>>>> @@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
>>>>         if (btf_type_is_ptr(t))
>>>>                 /* kernel size of pointer. Not BPF's size of pointer*/
>>>>                 return sizeof(void *);
>>>> -       if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>>>> +       if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
>>>>                 return t->size;
>>>>         return -EINVAL;
>>>>  }
>>>> @@ -7347,6 +7347,8 @@ static u8 __get_type_fmodel_flags(const struct btf_type *t)
>>>>                 flags |= BTF_FMODEL_STRUCT_ARG;
>>>
>>> Might be nit-picking but the handling of union arguments is identical
>>> to struct, so maybe we don't need to introduce a new flag
>>> BTF_FMODEL_UNION_ARG just for this. Changing __btf_type_is_struct() to
>>> btf_type_is_struct() here should also work.
>>
>> Correct. It should work with such changing.
>>
>> However, it would be more readable to introduce the new flag as the flag
>> indicates the argument is a 'union' instead of a 'struct'.
>
> Why? How is that more readable?
> Does it make a difference in calling convention?
> If so, then yes they should be treated differently by JITs
> that process func model, but if current JITs that support small structs
> as an argument treat small union exact same way, then extra flag
> is redundant and an existing flag should be renamed,
> or a comment added
> -/* The argument is a structure. */
> +/* The argument is a structure or a union. */
>  #define BTF_FMODEL_STRUCT_ARG          BIT(0)
>

Adding a comment sounds like a better approach than introducing a new flag:

1. Change __btf_type_is_struct() to btf_type_is_struct().
2. Drop BTF_FMODEL_UNION_ARG.
3. Drop __btf_type_is_union().
4. Drop patch #2.

I’ll send the next revision later.

Thanks,
Leon

