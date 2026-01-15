Return-Path: <bpf+bounces-79069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF438D2621D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DDF9300F1A4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6A3BC4F3;
	Thu, 15 Jan 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wmfNeiJn"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66265350A05;
	Thu, 15 Jan 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496960; cv=none; b=pKaaABI1t+Vt5HXhUnioVgeOsUw68YKMuzB7gpxB3X5LTbz51M+S/kvLYqe/VYmEpvu1Oim6UzBHdVmBJb1JpPeP9zKjLubHcTAIq2PzRZ/wFdvnmoqHmzt7/QKjxMtXaEde/Mf0eRT+9/gZTjfXoozc1JIhUj6AWfu8aUI/wJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496960; c=relaxed/simple;
	bh=ATx1WzXweeQgNnLBzqNGKjs/DXaQMK2c+b+J8kI3S9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX5KCxrx5iVUtXNZVFqcu8HfECDKY9vbl1CqwOyfkJh6FgM3Axa5g0xrnMIrEHHu/gsV6GxPkdF95glCsmxGKEZtzRkJstjAhmf7oVAkK7WjAFLtA5lzOQegT1fx0M6iWzUb4bBEcdKBIZcaxdFFSfsx49/CDNPad+D8UPSbvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wmfNeiJn; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c19cd4b2-1fa0-4626-9c1a-00ab2a278587@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768496955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qwwuBFztNaCxw76U+eiQA1piFlpJ2GogAqGTtKgRqc=;
	b=wmfNeiJnV7j43XlM8k4AvNzgXG38kjy/h15PprD6htTFJziDvhc5i0jj76HBpN56m3kWTc
	rh0ELARH3gTGm1gj8MHyGnGT/mOgWYs02roJ5xIuYw6RfzBELs4e273RX4U5a7om6IX+XI
	6CWNdibHC0t5Bk9aGcxCc69jAtD8cEQ=
Date: Thu, 15 Jan 2026 09:09:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] bpf_encoder: Fix a verbose output issue
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260115050044.2220436-1-yonghong.song@linux.dev>
 <4e8df34f-50be-4c91-a43a-26c84fc5008b@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <4e8df34f-50be-4c91-a43a-26c84fc5008b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/15/26 1:41 AM, Alan Maguire wrote:
> On 15/01/2026 05:00, Yonghong Song wrote:
>> For the following test.c:
>>    $ cat test.c
>>    unsigned tar(int a);
>>    __attribute__((noinline)) static int foo(int a, int b)
>>    {
>>      return tar(a) + tar(a + 1);
>>    }
>>    __attribute__((noinline)) int bar(int a)
>>    {
>>      foo(a, 1);
>>      return 0;
>>    }
>> The llvm compilation:
>>    $ clang -O2 -g -c test.c
>> And then
>>    $ pahole -JV test.o
>>    btf_encoder__new: 'test.o' doesn't have '.data..percpu' sectio  n
>>    File test.o:
>>    [1] INT unsigned int size=4 nr_bits=32 encoding=(none)
>>    [2] INT int size=4 nr_bits=32 encoding=SIGNED
>>    search cu 'test.c' for percpu global variables.
>>    [3] FUNC_PROTO (anon) return=2 args=(2 a, [4] FUNC bar type_id=3
>>    [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b, [6] FUNC foo type_id=5
>>
>> The above confused format is due to btf_encoder__add_func_proto_for_state().
>> The "is_last = param_idx == nr_params" is always false since param_idx
>> starts from 0. The below change fixed the issue:
>>    is_last = param_idx == (nr_params - 1)
>>
>> With the fix, 'pahole -JV test.o' will produce the following:
>>    ...
>>    [3] FUNC_PROTO (anon) return=2 args=(2 a)
>>    [4] FUNC bar type_id=3
>>    [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b)
>>    [6] FUNC foo type_id=5
>>    ...
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This fix looks good but I _think_ we have another instance of this; see
> btf_encoder__add_func_proto_for_ftype()
>
> 	ftype__for_each_parameter(ftype, param) {
>                  name = parameter__name(param);
>                  type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
>                  ++param_idx;
>                  if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
>                          return -1;
>          }
>
>          ++param_idx;
>          if (ftype->unspec_parms)
>                  if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
>                          return -1;
>
> Maybe I'm misreading but that last ++param_idx outside the loop is unneeded
> I think? If I'm right would you mind fixing that one too? Thanks!

Sure. Will take a look.

>
>> ---
>>   btf_encoder.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index b37ee7f..09a5cda 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -895,7 +895,7 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
>>   	for (param_idx = 0; param_idx < nr_params; param_idx++) {
>>   		p = &state->parms[param_idx];
>>   		name = btf__name_by_offset(btf, p->name_off);
>> -		is_last = param_idx == nr_params;
>> +		is_last = param_idx == (nr_params - 1);
>>   
>>   		/* adding BTF data may result in a move of the
>>   		 * name string memory, so make a temporary copy.


