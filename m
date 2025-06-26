Return-Path: <bpf+bounces-61632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87BCAE93B3
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 03:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDEA1C2779E
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83C1A262D;
	Thu, 26 Jun 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBlUxsPK"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CC13C8FF
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750901160; cv=none; b=Hr3soG0Lhip76qeOKDAd2puzpmGD3jRz2GUipupS5UqqUNdaaMjZIe8h8EEqG+CEjZQTDR5UVE55EOGVqXEJQKJAvjvXIsErzAFbRvzgjBBJ3N5kyqRl27fuALVCBb0V6FHx1ALjneKAbIc/28+0l3o0gjohGrZlJpL2UOyyxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750901160; c=relaxed/simple;
	bh=Mma+smHy8Bn5YkWAgTrJRXkVdda5HC29vDWL+WVpnhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJ8o4DQr4N8Cxptuj0SQzUhETBM+VbuzP0hCvgdVbEXivezrJX2YcmuL+nnty2VHw5AGR5kK65yqKE4KApNdM+VTDfSMxPhKii1DW9dsjVij465vUooT2lTGckp/FpodgllEwbhHjH21engQd6Iej3dYpOPOEmyx17y2Ijq6QfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBlUxsPK; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a08af28b-e81f-47a8-96b9-94a67d6bd3a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750901155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4OZ8zA7jIIESIfUjfoc872YxAKDYQLaX3efqeg+Rok=;
	b=BBlUxsPKzGqA/GDV+ghP+uB615XWNJYWVdhEckhE85e/uRZUzAOfFzJu8Q6i9fIynG9NqY
	2NPrrUfI9/lLaJDlrGi76efvn9AsbnUNDwSBdsZYUQC5+mQZoIN9yQavTp0Ru0VakjOicl
	wiQrQp/HSo+Q0gWIbl3QTIB6euuvTJM=
Date: Wed, 25 Jun 2025 18:25:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add test cases for
 bpf_dynptr_memset()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
References: <20250624205240.1311453-1-isolodrai@meta.com>
 <20250624205240.1311453-3-isolodrai@meta.com>
 <5f00c508-5150-4e69-b006-d15b0e6b2d23@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <5f00c508-5150-4e69-b006-d15b0e6b2d23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/25/25 4:45 AM, Mykyta Yatsenko wrote:
> On 6/24/25 21:52, Ihor Solodrai wrote:
>> Add tests to verify the behavior of bpf_dynptr_memset():
>>    * normal memset 0
>>    * normal memset non-0
>>    * memset with an offset
>>    * memset in dynptr that was adjusted
>>    * error: size overflow
>>    * error: offset+size overflow
>>    * error: readonly dynptr
>>    * memset into non-linear xdp dynptr
>>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   .../testing/selftests/bpf/prog_tests/dynptr.c |   8 +
>>   .../selftests/bpf/progs/dynptr_success.c      | 164 ++++++++++++++++++
>>   2 files changed, 172 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/ 
>> testing/selftests/bpf/prog_tests/dynptr.c
>> index 62e7ec775f24..f2b65398afce 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
>> @@ -21,6 +21,14 @@ static struct {
>> [...]
>> +
>> +SEC("xdp")
>> +int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
>> +{
>> +    const int max_chunks = 200;
>> +    struct bpf_dynptr ptr_xdp;
>> +    u32 data_sz, offset = 0;

A question not directly to Mykyta.

So noalu32 version of this test was failing to verify with this:

     118: (85) call bpf_dynptr_read#201
     R2 min value is negative, either use unsigned or 'var &= const'

Where R2 refers to `data_sz - offset`

Full log here: 
https://github.com/kernel-patches/bpf/actions/runs/15861036149/job/44718289284

I tried various conditions unsuccessfully.  But changing u32 to u64
made it work. If handle_tail part is removed, as Mykyta suggested,
this doesn't matter, so I will probably leave u32 in v3.

However I am curious if u32->u64 change is an appropriate workaround
in general for noalu32 problems?  AFAIU verifier might get confused by
all the added shifts, and "noalu32" is a backward compatibility thing.


>> +    char expected_buf[32];
> nit: expected_buf[32] = {DYNPTR_MEMSET_VAL};

I tried that at the beginning. As it turns out, this doesn't work in
BPF the way you'd expect:

Here is a piece of llvm-objdump with explicit memset:

0000000000000968 <test_dynptr_memset_xdp_chunks>:
      301:	18 02 00 00 2a 2a 2a 2a 00 00 00 00 2a 2a 2a 2a	r2 = 
0x2a2a2a2a2a2a2a2a ll
      303:	7b 2a c8 ff 00 00 00 00	*(u64 *)(r10 - 0x38) = r2
      304:	7b 2a d0 ff 00 00 00 00	*(u64 *)(r10 - 0x30) = r2
      305:	7b 2a d8 ff 00 00 00 00	*(u64 *)(r10 - 0x28) = r2
      306:	7b 2a e0 ff 00 00 00 00	*(u64 *)(r10 - 0x20) = r2
      307:	bf a7 00 00 00 00 00 00	r7 = r10
      308:	07 07 00 00 e8 ff ff ff	r7 += -0x18
      309:	b7 02 00 00 00 00 00 00	r2 = 0x0
      310:	bf 73 00 00 00 00 00 00	r3 = r7
      311:	85 10 00 00 ff ff ff ff	call -0x1
      ...

You can clearly see a piece of stack filling up with 0x2a

After applying this diff:

diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c 
b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 5120acb8b15a..5b351f6fe07c 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -809,12 +809,10 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
         const int max_chunks = 200;
         struct bpf_dynptr ptr_xdp;
         u32 data_sz, chunk_sz, offset = 0;
-       char expected_buf[32];
+       char expected_buf[32] = { DYNPTR_MEMSET_VAL };
         char buf[32];
         int i;

-       __builtin_memset(expected_buf, DYNPTR_MEMSET_VAL, 
sizeof(expected_buf));
-
         /* ptr_xdp is backed by non-contiguous memory */
         bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
         data_sz = bpf_dynptr_size(&ptr_xdp);

We get the following:

0000000000000968 <test_dynptr_memset_xdp_chunks>:
      301:	bf a7 00 00 00 00 00 00	r7 = r10
      302:	07 07 00 00 e8 ff ff ff	r7 += -0x18
      303:	b7 02 00 00 00 00 00 00	r2 = 0x0
      304:	bf 73 00 00 00 00 00 00	r3 = r7
      305:	85 10 00 00 ff ff ff ff	call -0x1
      ...

The stack allocated array is not initialized.
Could be an LLVM bug/incompleteness? I used LLVM 19 while developing.


>> +    char buf[32];
>> +    int i;
>> +
>> +    __builtin_memset(expected_buf, DYNPTR_MEMSET_VAL, 
>> sizeof(expected_buf));
>> +
>> +    /* ptr_xdp is backed by non-contiguous memory */
>> +    bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
>> +    data_sz = bpf_dynptr_size(&ptr_xdp);
>> +
>> +    err = bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
>> +    if (err)
>> +        goto out;
>> +
> Maybe we can calculate max_chunks instead of hardcoding, something like:
> max_chunks = data_sz / sizeof(expected_buf) + (data_sz % 
> sizeof(expected_buf) ? 1 : 0);

I don't see a point of doing it for this test. max_chunks is just a
big enough arbitrary constant that works. We do a similar thing in
other tests.

>> +    bpf_for(i, 0, max_chunks) {
>> +        offset = i * sizeof(buf);
>> +        err = bpf_dynptr_read(&buf, sizeof(buf), &ptr_xdp, offset, 0);
> 
> handle_tail seems unnecessary, maybe handle tail in the main loop:
> __u32 sz = min_t(data_sz - offset : sizeof(buf));
> bpf_dynptr_read(&buf, sz, &ptr_xdp, offset, 0);
> 

Yeah, you're right.

It ended up like this because I've been fighting the verifier while
writing the test, and this version worked eventually. The critical
piece to uncofuse it was changing:
     offset += sizeof(buf)
to
     offset = i * sizeof(buf)

I will have to add min_t macro locally though.


>> +        switch (err) {
>> +        case 0:
>> +            break;
>> +        case -E2BIG:
>> +            goto handle_tail;
>> +        default:
>> +            goto out;
>> +        }
>> +        err = bpf_memcmp(buf, expected_buf, sizeof(buf));
>> +        if (err)
>> +            goto out;
>> +    }
>> +
>> +handle_tail:
>> +    if (data_sz - offset < sizeof(buf)) {
>> +        err = bpf_dynptr_read(&buf, data_sz - offset, &ptr_xdp, 
>> offset, 0);
>> +        if (err)
>> +            goto out;
>> +        err = bpf_memcmp(buf, expected_buf, data_sz - offset);
>> +    }
>> +out:
>> +    return XDP_DROP;
>> +}
>> +
>>   void *user_ptr;
>>   /* Contains the copy of the data pointed by user_ptr.
>>    * Size 384 to make it not fit into a single kernel chunk when copying
> 


