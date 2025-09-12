Return-Path: <bpf+bounces-68207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE38B540B0
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 04:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682A517390C
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 02:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AD21CC59;
	Fri, 12 Sep 2025 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P97GcQQm"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478E155A4E
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645562; cv=none; b=RXpj+fqpj2WwXjtOxy/1Ey05O8aG34TbMj2oQwgptTodxbdJ2NnXnDfR5XJAolTeDgdRyTUJJB8+5DUwEDIr3QOsGwSSoccHHleXlEsceVkgvqMNRxgcxY9z4oNkBL7FNuq7G34NMTYj4aIPDknBtHbt7jf/sbj0EdayDEqHJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645562; c=relaxed/simple;
	bh=O7ALQD3UbUjAs+AX8pUjRyWrFbxUM8fYNiJddhEyzKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhSKVO53Z2HXWVhQfJc4/kY8ReLqS7UbKF+h0NBut4qM/+6WQ8BP8Ay7dvLunyhygFOfo+a1crpif45UjUP3P+2u4d19fEQhnXoPmCy8sPSwdf3j0oFtOQDOCJH/7XP8kz0u1VFpyHE/S5l1OjRN0JLjiYM2+dHnjNpZ3OKh40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P97GcQQm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d704311e-1302-4b14-8993-f5b626d41d46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757645557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7LzGHbHa0XYWAlx5zDX09xnSDgkQTRXQ4PMZcaTpVc=;
	b=P97GcQQmzuUpjLMi8jIDqQEk8y2lN5jJb1+XbDkWCdXP8L2H/9YkeEz20kHLyqF1W/i6B1
	6a8wu9v4G9CT8VDBBRu0FXBsCRF1X3STjNOIJnWnOfmVbkSeCi8L2Uj2A66Ia/ioRlQmle
	AyDvSjJxzENkOVeSuqpmeGPBidSeyrY=
Date: Fri, 12 Sep 2025 10:52:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Support fentry/fexit for functions with
 union args
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 kernel-patches-bot@fb.com
References: <20250905133226.84675-1-leon.hwang@linux.dev>
 <20250905133226.84675-2-leon.hwang@linux.dev>
 <CAADnVQ+uk+sqZhYPJu78NETidUiCa617Wa_YdnmvefOZnNoeZg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+uk+sqZhYPJu78NETidUiCa617Wa_YdnmvefOZnNoeZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/9/25 08:54, Alexei Starovoitov wrote:
> On Fri, Sep 5, 2025 at 6:32 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Currently, functions with 'union' arguments cannot be traced with
>> fentry/fexit:
> 
> union-s passed _by value_.
> It's an important detail.
> 
>>
>> bpftrace -e 'fentry:release_pages { exit(); }' -v
>> AST node count: 6
>> Attaching 1 probe...
>> ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
>> Kernel error log:
>> The function release_pages arg0 type UNION is unsupported.
>> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>
>> ERROR: Loading BPF object(s) failed.
>>
>> The type of the 'release_pages' argument is defined as:
>>
>> typedef union {
>>         struct page **pages;
>>         struct folio **folios;
>>         struct encoded_page **encoded_pages;
>> } release_pages_arg __attribute__ ((__transparent_union__));
>>
>> This patch relaxes the restriction by allowing function arguments of type
>> 'union' to be traced.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/btf.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 64739308902f7..86883b3c97d20 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>         /* skip modifiers */
>>         while (btf_type_is_modifier(t))
>>                 t = btf_type_by_id(btf, t->type);
>> -       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>> +       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
>>                 /* accessing a scalar */
>>                 return true;
>>         if (!btf_type_is_ptr(t)) {
>> @@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
>>         if (btf_type_is_ptr(t))
>>                 /* kernel size of pointer. Not BPF's size of pointer*/
>>                 return sizeof(void *);
>> -       if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>> +       if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
>>                 return t->size;
> 
> Did you look at
> commit 720e6a435194 ("bpf: Allow struct argument in trampoline based programs")
> that added support for accessing struct passed by value?
> 
> Study it and figure out what part of the verifier you forgot
> to update while adding this support for accessing unions
> passed by value.
> Think it through and update the selftest to make sure it tests
> the support end-to-end and covers the bug in this patch.
> 

Thanks for pointing this out.

You’re right — support for union arguments should follow the same
approach used for struct arguments in commit
720e6a435194 ("bpf: Allow struct argument in trampoline based
programs"). My current patch was too naive and missed several necessary
updates.

I’ll review that commit carefully, identify what I overlooked, and align
the implementation for unions accordingly.

I’ll also extend the selftests to ensure we have end-to-end coverage and
can catch the kind of bug exposed here.

Thanks,
Leon


