Return-Path: <bpf+bounces-30331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526358CC816
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BB22825EF
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7F7D09D;
	Wed, 22 May 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c6ncbalb"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B4F4E7
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412743; cv=none; b=gvWvFpPRbiaZjs0Lw7uqcWt15K2B4PoMEg34PO2JVDwNman1CETs8N0FRo2n6QM+jF8MeNlunoSfRioqICBy9vupobPZxEHHcchNoz6WqbOW0LQOVpfl4yD64q5QnYRGQNcaE8DGFHh6mYHqbnA25LV7Y8DLUA0op9wCgG8C1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412743; c=relaxed/simple;
	bh=oDAV2yil6A1vCx6CKLnHvCJmTqC6W8DF9/0pqySHX04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9NYz82qI6T8b9RuCNq4zo6Pr/LzL2cwDQEl/mb3+d6HQagDpMFwY99xNiaN/IN4C+IvG3A8MOAppG6XZg3MxX8r0ZWUH0zpReacMibytPvrPWFSMQZyaJosA74ZMgKgznoo9RJEadPKCPwSTDY1ajHtlbr2LgWSjIihlWtQTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c6ncbalb; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: martin.lau@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716412738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcLKXoM1yfdGlPL5kvCwkXkP4LsOLbWEupxR0XZPWxk=;
	b=c6ncbalb44HoK+ncOVLI3G+wiATZUWE3OzNT1JFd7zQdSJtPKJUlHnYlMw6f8VgzC+tEVr
	NX1vtt3w+NOyzZCQjPYbug2UCX9M0eJfSBF0a8rOHXdM9XgE42PBzm6YF1Wi96b0gK2pMT
	HMOUyzZo44TaKujsDex4F2UI8snGL4I=
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: kuba@kernel.org
Message-ID: <d9a672d7-c595-4e8e-aef6-1ba1155f3549@linux.dev>
Date: Wed, 22 May 2024 22:18:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] selftests: bpf: crypto: adjust bench to
 use nullable IV
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240510122823.1530682-1-vadfed@meta.com>
 <20240510122823.1530682-5-vadfed@meta.com>
 <73add1b3-b1e4-4d83-85b3-5be45f2658d6@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <73add1b3-b1e4-4d83-85b3-5be45f2658d6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 22/05/2024 19:01, Martin KaFai Lau wrote:
> On 5/10/24 5:28 AM, Vadim Fedorenko wrote:
>> The bench shows some improvements, around 4% faster on decrypt.
> 
> The original intention is to make the crypto kfunc more ergonomic to use 
> such that the bpf prog does not have to initialize a zero length dynptr 
> for the optional dynptr argument.
> 
> This performance boost is a decent surprise considering the crypto 
> operation should be pretty heavy. (thanks for having the crypto 
> benchmark handy).
> 
> Do you have a chance to get a perf record to confirm where the cycles is 
> saved?

Not really, but it's just initialization part changed, I was using the
same base commit to do the comparison.

> 
> Why it only helps decrypt?

It helps both, I just didn't show encrypt output, but it's the same 4%

> 
> Inlining it would be nice (as Eduard mentioned in another thread). I 
> also wonder if Eduard's work on the no caller saved registers could help 
> the dynptr kfunc? I think the dynptr kfunc optimization could be a 
> followup.
> 
>>
>> Before:
>>
>> Benchmark 'crypto-decrypt' started.
>> Iter   0 (325.719us): hits    5.105M/s (  5.105M/prod), drops 
>> 0.000M/s, total operations    5.105M/s
>> Iter   1 (-17.295us): hits    5.224M/s (  5.224M/prod), drops 
>> 0.000M/s, total operations    5.224M/s
>> Iter   2 (  5.504us): hits    4.630M/s (  4.630M/prod), drops 
>> 0.000M/s, total operations    4.630M/s
>> Iter   3 (  9.239us): hits    5.148M/s (  5.148M/prod), drops 
>> 0.000M/s, total operations    5.148M/s
>> Iter   4 ( 37.885us): hits    5.198M/s (  5.198M/prod), drops 
>> 0.000M/s, total operations    5.198M/s
>> Iter   5 (-53.282us): hits    5.167M/s (  5.167M/prod), drops 
>> 0.000M/s, total operations    5.167M/s
>> Iter   6 (-17.809us): hits    5.186M/s (  5.186M/prod), drops 
>> 0.000M/s, total operations    5.186M/s
>> Summary: hits    5.092 ± 0.228M/s (  5.092M/prod), drops    0.000 
>> ±0.000M/s, total operations    5.092 ± 0.228M/s
>>
>> After:
>>
>> Benchmark 'crypto-decrypt' started.
>> Iter   0 (268.912us): hits    5.312M/s (  5.312M/prod), drops 
>> 0.000M/s, total operations    5.312M/s
>> Iter   1 (124.869us): hits    5.354M/s (  5.354M/prod), drops 
>> 0.000M/s, total operations    5.354M/s
>> Iter   2 (-36.801us): hits    5.334M/s (  5.334M/prod), drops 
>> 0.000M/s, total operations    5.334M/s
>> Iter   3 (254.628us): hits    5.334M/s (  5.334M/prod), drops 
>> 0.000M/s, total operations    5.334M/s
>> Iter   4 (-77.691us): hits    5.275M/s (  5.275M/prod), drops 
>> 0.000M/s, total operations    5.275M/s
>> Iter   5 (-164.510us): hits    5.313M/s (  5.313M/prod), drops 
>> 0.000M/s, total operations    5.313M/s
>> Iter   6 (-81.376us): hits    5.346M/s (  5.346M/prod), drops 
>> 0.000M/s, total operations    5.346M/s
>> Summary: hits    5.326 ± 0.029M/s (  5.326M/prod), drops    0.000 
>> ±0.000M/s, total operations    5.326 ± 0.029M/s
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   tools/testing/selftests/bpf/progs/crypto_bench.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/crypto_bench.c 
>> b/tools/testing/selftests/bpf/progs/crypto_bench.c
>> index e61fe0882293..4ac956b26240 100644
>> --- a/tools/testing/selftests/bpf/progs/crypto_bench.c
>> +++ b/tools/testing/selftests/bpf/progs/crypto_bench.c
>> @@ -57,7 +57,7 @@ int crypto_encrypt(struct __sk_buff *skb)
>>   {
>>       struct __crypto_ctx_value *v;
>>       struct bpf_crypto_ctx *ctx;
>> -    struct bpf_dynptr psrc, pdst, iv;
>> +    struct bpf_dynptr psrc, pdst;
>>       v = crypto_ctx_value_lookup();
>>       if (!v) {
>> @@ -73,9 +73,8 @@ int crypto_encrypt(struct __sk_buff *skb)
>>       bpf_dynptr_from_skb(skb, 0, &psrc);
>>       bpf_dynptr_from_mem(dst, len, 0, &pdst);
>> -    bpf_dynptr_from_mem(dst, 0, 0, &iv);
>> -    status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
>> +    status = bpf_crypto_encrypt(ctx, &psrc, &pdst, NULL);
>>       __sync_add_and_fetch(&hits, 1);
>>       return 0;
>> @@ -84,7 +83,7 @@ int crypto_encrypt(struct __sk_buff *skb)
>>   SEC("tc")
>>   int crypto_decrypt(struct __sk_buff *skb)
>>   {
>> -    struct bpf_dynptr psrc, pdst, iv;
>> +    struct bpf_dynptr psrc, pdst;
>>       struct __crypto_ctx_value *v;
>>       struct bpf_crypto_ctx *ctx;
>> @@ -98,9 +97,8 @@ int crypto_decrypt(struct __sk_buff *skb)
>>       bpf_dynptr_from_skb(skb, 0, &psrc);
>>       bpf_dynptr_from_mem(dst, len, 0, &pdst);
>> -    bpf_dynptr_from_mem(dst, 0, 0, &iv);
>> -    status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
>> +    status = bpf_crypto_decrypt(ctx, &psrc, &pdst, NULL);
>>       __sync_add_and_fetch(&hits, 1);
>>       return 0;
> 


