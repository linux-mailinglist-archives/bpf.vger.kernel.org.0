Return-Path: <bpf+bounces-27741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A822C8B15E7
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3573C282418
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352316D9D9;
	Wed, 24 Apr 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gcwS3JUK"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CC155358;
	Wed, 24 Apr 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996707; cv=none; b=H9oNcnzkwjj36oj+ac8gD+PRPJSV/P0mXxwUJ/da9OqzNrwlwiEeS7162Xrculqak9DZsVg/3B5Ki99dQk+zpTpAf0cMDFn4VWZQgZjLoE0GVnLlDtU39BWXcF/BnGX73oLDKfj+H97HgIhcHdMk7UGrHNVRh2OGdbXsK2aDmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996707; c=relaxed/simple;
	bh=vvEngh34ePrOPT9U6Tqx7jBnZa20+xX3f6kTvkMFwaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjY2DX/lFUgVB5a7NQrVbPFQGWK/Jiy9zTfVH3Yf9BCF5zL3vSDfIJQWYblhl5wk1tqvAltP/a2DsjWr8F0qT+DfbAgR96GLFpYLHx718tvf31rLi0pxIR6eWYOL1/w2ZhE8zn2aM8kJ2+HlvcxscVzVtuhd8FvyCFYnjiyaxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gcwS3JUK; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12964e33-921a-440d-a423-0bff1b3f1c0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713996703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZB3j2SB0jwlNoQ6VH7kP0jo6T5qEBoaB3VCHae1Bwg=;
	b=gcwS3JUKmdhseL1Nl8c4QYX3M92cSRd6IPwTE4hmqMYtj4qL0ZBopu02SfzgXTq+Hhe+oG
	h8JMPe1UkNA0X5kpwLYzDVPMNggX2+LmCK6BqPTNAwfVO55VQC9bqWvQ0iL+yaPYkySYvI
	KPs1ZCXcwqhJcBwFnuAfb5eQYWmo680=
Date: Wed, 24 Apr 2024 15:11:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: extending BTF_KIND_INIT to accommodate some
 unusual types
Content-Language: en-GB
To: Xin Liu <liuxin350@huawei.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kongweibin2@huawei.com, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, liwei883@huawei.com, martin.lau@linux.dev,
 sdf@google.com, song@kernel.org, wuchangye@huawei.com,
 xiesongyang@huawei.com, yanan@huawei.com, yhs@fb.com, zhangmingyi5@huawei.com
References: <a79006a7-a5af-4e30-8424-d54145bcd538@linux.dev>
 <20240424070621.740898-1-liuxin350@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240424070621.740898-1-liuxin350@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/24/24 12:06 AM, Xin Liu wrote:
> On Tue, 23 Apr 2024 13:12:04 -0700 Yonghong Song <yonghong.song@linux.dev> wrote:
>> On 4/23/24 6:15 AM, Xin Liu wrote:
>>> On Mon, 22 Apr 2024 10:43:38 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>
>>>> On Mon, Apr 22, 2024 at 7:46 AM Xin Liu <liuxin350@huawei.com> wrote:
>>>>> In btf__add_int, the size of the new btf_kind_int type is limited.
>>>>> When the size is greater than 16, btf__add_int fails to be added
>>>>> and -EINVAL is returned. This is usually effective.
>>>>>
>>>>> However, when the built-in type __builtin_aarch64_simd_xi in the
>>>>> NEON instruction is used in the code in the arm64 system, the value
>>>>> of DW_AT_byte_size is 64. This causes btf__add_int to fail to
>>>>> properly add btf information to it.
>>>>>
>>>>> like this:
>>>>>     ...
>>>>>      <1><cf>: Abbrev Number: 2 (DW_TAG_base_type)
>>>>>       <d0>   DW_AT_byte_size   : 64              // over max size 16
>>>>>       <d1>   DW_AT_encoding    : 5        (signed)
>>>>>       <d2>   DW_AT_name        : (indirect string, offset: 0x53): __builtin_aarch64_simd_xi
>>>>>      <1><d6>: Abbrev Number: 0
>>>>>     ...
>>>>>
>>>>> An easier way to solve this problem is to treat it as a base type
>>>>> and set byte_size to 64. This patch is modified along these lines.
>>>>>
>>>>> Fixes: 4a3b33f8579a ("libbpf: Add BTF writing APIs")
>>>>> Signed-off-by: Xin Liu <liuxin350@huawei.com>
>>>>> ---
>>>>>    tools/lib/bpf/btf.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>>>> index 2d0840ef599a..0af121293b65 100644
>>>>> --- a/tools/lib/bpf/btf.c
>>>>> +++ b/tools/lib/bpf/btf.c
>>>>> @@ -1934,7 +1934,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
>>>>>           if (!name || !name[0])
>>>>>                   return libbpf_err(-EINVAL);
>>>>>           /* byte_sz must be power of 2 */
>>>>> -       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
>>>>> +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)
>>>> maybe we should just remove byte_sz upper limit? We can probably
>>>> imagine 256-byte integers at some point, so why bother artificially
>>>> restricting it?
>>>>
>>>> pw-bot: cr
>>> In the current definition of btf_kind_int, bits has only 8 bits, followed
>>> by 8 bits of unused interval. When we expand, we should only use 16 bits
>>> at most, so the maximum value should be 8192(1 << 16 / 8), directly removing
>>> the limit of byte_sz. It may not fit the current design. For INT type btfs
>>> greater than 255, how to dump is still a challenge.
>> Looking at this patch. Now I remember that I have an old pahole patch
>> to address similar issues
>>     https://lore.kernel.org/bpf/20230426055030.3743074-1-yhs@fb.com/
>> which is not merged and I forgot that.
>>
>> In that particular case, the int size is 1024 bytes.
>> Currently the int type more than 16 bytes cannot be dumped in libbpf.
>> Do you have a particular use case to use your__builtin_aarch64_simd_xi() type
>> in bpf program? I guess probably not as BPF does not support
>> builtin function your__builtin_aarch64_simd_xi().
>>
> Currently, there is no use case of byte_sz in btf, so let's remove
> __builtin_aarch64_simd_xi first.At least this will support the kernel
> compilation phase without causing the kernel to fail directly when
> generating btf.

Okay, I will resend my pahole patch later to address this issue.

>
>>> Does the current version support a maximum of 8192 bytes?
>>>
>>>>>                   return libbpf_err(-EINVAL);
>>>>>           if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
>>>>>                   return libbpf_err(-EINVAL);
>>>>> --
>>>>> 2.33.0
>>>>>

