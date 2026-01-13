Return-Path: <bpf+bounces-78752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB49D1AEB6
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 19:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644CB3012756
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C5352C36;
	Tue, 13 Jan 2026 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sf8dnJwJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA9A41
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330671; cv=none; b=WodF5YVUf+m415kRTMR8PPVDdXZEOTQm3MtDmnSvBfe7MeKSV0DJEElrqz3WpwmXXiy5CzJOLmG0JQvSccT01G4x8Edbq4Wt2AcS0IkyigTiWTgv13Z1V2hdMPLc+2KJ5UPqou+PhKTCa1+QqzaVYdl7sUznx7mYiddoCmCpUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330671; c=relaxed/simple;
	bh=WeJdCzxuVdCX9LKpDd8ywejuXPA6PHeQfGF7b43XTlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5F2S9mbGGe8zxll9vssRbXkGH5B7kQ9KDeEyI5YXbu+86WkdHO+ROJIaIQdd+IYg1b6ovxdNuzGfZCuuy0YbUDUXTwvwQipndcb5AWtNVh8PQydiiccNaVZqp8XrngoV8JNnIldA3NPQAMRXwhyijKLG4umiAdpFB38VRHQHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sf8dnJwJ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <caf60d1c-4ff6-491c-8b82-27f3a0a356b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768330663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMURkLYd210t3BUeI7Ax3Scj5E7vL28kqnDh3jBhp2Q=;
	b=Sf8dnJwJJfe4i3dSX5Tvf84RUAYVpvxHt5a86k7BPkG9kGDDZwa9ho+u05icobnjvYxhKG
	osKOlsYAYJT/0amAqatopQKV3/185tOhRAANFpdv3CiVJ5HZtoD9wn21r+zL5Wu7RAN7wH
	8T5ErVPkvzP3VZg65mWXLl5ZoeKSrlE=
Date: Tue, 13 Jan 2026 10:57:38 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 2/4] btf_encoder: Refactor elf_functions__new()
 with struct btf_encoder as argument
Content-Language: en-GB
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-3-alan.maguire@oracle.com>
 <362ab824-6726-49ad-9602-ea25490e3298@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <362ab824-6726-49ad-9602-ea25490e3298@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/13/26 10:32 AM, Ihor Solodrai wrote:
> On 1/13/26 5:13 AM, Alan Maguire wrote:
>> From: Yonghong Song <yonghong.song@linux.dev>
>>
>> For elf_functions__new(), replace original argument 'Elf *elf' with
>> 'struct btf_encoder *encoder' for future use.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   btf_encoder.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 2c3cef9..5bc61cb 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -187,11 +187,13 @@ static inline void elf_functions__delete(struct elf_functions *funcs)
>>   
>>   static int elf_functions__collect(struct elf_functions *functions);
>>   
>> -struct elf_functions *elf_functions__new(Elf *elf)
>> +struct elf_functions *elf_functions__new(struct btf_encoder *encoder)
> Hi Alan, Yonghong,
>
> I assume "future use" refers to this patch:
> https://lore.kernel.org/dwarves/20251130040350.2636774-1-yonghong.song@linux.dev/
>
> Do I understand correctly that you're passing btf_encoder here in
> order to detect that the `encoder->dotted_true_signature` feature flag
> is set? If so, I think this is a bit of an overkill.
>
> How about just store the flag in struct elf_functions, pass it to the
> elf_functions__new() directly and set it there:
>
> 	funcs->elf = elf;
> 	funcs->dotted_true_signature = dotted_true_signature; // <--
> 	err = elf_functions__collect(funcs);
> 	if (err < 0)
> 		goto out_delete;
>
> And even then, it doesn't feel right to me that the contents of the
> *ELF* functions table changes based on a feature flag. But we are
> discarding the suffixes currently, so I understand why this was done.
>
> Taking a step back, I remember Yonghong mentioned some pushback both
> from LLVM and DWARF side regarding the introduction of true signatures
> to DWARF data. Is there a feasible path forward landing all that?

Yes. My previous dwarf format (https://github.com/llvm/llvm-project/pull/165310)
gets resistance from llvm esp. dwarf community.

There are two possible solutions going forward:
   1. use existing dwarf data (e.g. locations, etc) to extract true signatures.
   2. generate vmlinux BTF directly from compiler and make sure true signatures
      are encoded in that BTF. Currently gcc is able to generate BTF but
      do not have changed signatures.

The second approach is more complicated so I prefer to try option 1 first.
With option 1, I think pahole already has lots of checking for various
inconsistency or ambiguity. But llvm generated dwarf may have some
difference from gcc generated dwarf. For example, for function
__blkcg_rstat_flush() in patch 1, gcc has abstract origin for that function,
but clang does not have it in dwarf. I will need to sort out
these things.

>
> I haven't followed this work in detail, so apologies if I missed
> anything. Just want to have a high-level understanding of the
> situation.
>
> Thank you!
>
>
>>   {
>>   	struct elf_functions *funcs;
>> +	Elf *elf;
>>   	int err;
>>   
>> +	elf = encoder->cu->elf;
>>   	funcs = calloc(1, sizeof(*funcs));
>>   	if (!funcs) {
>>   		err = -ENOMEM;
>> @@ -1552,7 +1554,7 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
>>   
>>   	funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
>>   	if (!funcs) {
>> -		funcs = elf_functions__new(encoder->cu->elf);
>> +		funcs = elf_functions__new(encoder);
>>   		if (funcs)
>>   			list_add(&funcs->node, &encoder->elf_functions_list);
>>   	}


