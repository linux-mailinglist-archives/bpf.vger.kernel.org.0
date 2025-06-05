Return-Path: <bpf+bounces-59697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E7ACE889
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 05:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DE188B54D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 03:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF591F3FC8;
	Thu,  5 Jun 2025 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2iHCBmm"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1C82866
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749092698; cv=none; b=HEFnIXCAWZFeTI+Y4N+c/wMwIAbkA6tOwLv3KHXHj9Xa6vRr9ZQJ4sZF0AsqyuexqQCwzFxrPKHvaCvknspYRdBqeLTI3YHnrdr8EtBbRtQtZHW7Fh98RmQWoGpIoanRi6MW5VL3xAzO4tRUsxQ3C8a+4bpFeiodm+I9GRLqeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749092698; c=relaxed/simple;
	bh=cdn7vJ3pD50PZP4VCvvST5yBodisn49UCGaeKcsi4Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofczaQrurehHRfz8iEP7g2duytgiDvVQHpZLMq/mj3LFd8nt2aEnsHN1koqJVhXQglrOj1WyAZDOBlMsu/1rjgoaGf/IvNe1KDltUm6WcMJTQmNd3FY9woW/NVBiI9w8qVR5lu6MX3Cde970bDTGRT/flRsBnUkaS/stLBSZ+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2iHCBmm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38c56b31-ac8a-436d-bc4a-0731bc702ecf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749092692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWxGKOciZpgjL4rlb7fvoJzSw7kfbOO6T7c3c9Ni2Fk=;
	b=q2iHCBmm3G8B2XgzL9AhsjFbBT737bh71/3J3120k1+nB3uN2pFx1tVEZQsgGjR+oTy9tq
	uzfyEnuAaetCFFuMD+Xowv518w/Zu5XZF4uv4w9fib2nSACZnEBZ0vs0l80I+NLmvmgEp4
	bBKPIehtMSkJnih6G/DSAPm64JBQruY=
Date: Wed, 4 Jun 2025 20:04:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add
 cmp_map_pointer_with_const test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kernel Team <kernel-team@meta.com>
References: <20250604222729.3351946-1-isolodrai@meta.com>
 <20250604222729.3351946-2-isolodrai@meta.com>
 <CAADnVQJr0JZ1BKeSEE0YM=xcnP0QEBM0smmCkjNs2oaOR1jcbw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQJr0JZ1BKeSEE0YM=xcnP0QEBM0smmCkjNs2oaOR1jcbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/4/25 3:41 PM, Alexei Starovoitov wrote:
> On Wed, Jun 4, 2025 at 3:28 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>
>> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
>> BPF program with this code must not pass verification in unpriv.
>>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>> index 28200f068ce5..c4a48b57e167 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>> @@ -634,6 +634,23 @@ l0_%=:     r0 = 0;                                         \
>>          : __clobber_all);
>>   }
>>
>> +SEC("socket")
>> +__description("unpriv: cmp map pointer with const")
>> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibited")
>> +__retval(0)
>> +__naked void cmp_map_pointer_with_const(void)
>> +{
>> +       asm volatile ("                                 \
>> +       r1 = 0;                                         \
>> +       r1 = %[map_hash_8b] ll;                         \
>> +       if r1 == 0xdeadbeef goto l0_%=;         \
> 
> I bet this doesn't fit into imm32 either.
> It should fit into _signed_ imm32.

Apparently it's fine both for gcc and clang:
https://github.com/kernel-patches/bpf/actions/runs/15454151804

I guess the value from inline asm is just put into IMM bytes as
is. llvm-objdump is exactly the same, although the value is pretty
printed as negative:

0000000000000320 <cmp_map_pointer_with_const>:
      100:       b7 01 00 00 00 00 00 00 r1 = 0x0
      101:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
      103:       15 01 00 00 ef be ad de if r1 == -0x21524111 goto +0x0 
<l0_11>



