Return-Path: <bpf+bounces-19692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B582FDAF
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 00:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1EB1F26D46
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9C95232;
	Tue, 16 Jan 2024 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QMSKAhQD"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A567C47
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446862; cv=none; b=lV9yS9WeHM1y3JfQt4QDrSIpvySr9/WWVEfcwlNy+zHognlEnV2/ieVu0CKVpleY/c7gt+fSeD3TGsGkigSEyJxK2+mVnYDeLTnhuRT4xR2wJZKHPmKApju8yx4vgyg9E2xSi1IS0RABbq/HPSice/Z6i25VUB3q/i5p7vhe5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446862; c=relaxed/simple;
	bh=Beno16Q5tJneHF1q+1soG828NSFossEu/DvxdwTgHYI=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=dFnkiY3qnzDkjZTv+n8TlepDqGkifyf1VOoDanZUXYrY/MqxnCauepO2p9CJvbXYSMA/bx1k4FhAk8FMVmDdwamqDGUjPZ2/UKznnuSdnp/4ZUGPNKrxnQ9e9xMwZ0PaiKyS5NmRx86TKqmxzKfQ/M4f3kduZqc2xdiRMCJ2dic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QMSKAhQD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <317a4996-2bb4-48b7-911b-96f053d60e3c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705446857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vVpRnGK6P35CgRdOgn+ytQvtiSjsDXADMZKqUSf0qE=;
	b=QMSKAhQD4EVoy1+YVoq8PEUJkVtHWlpjN6KUiyN8RD6oJabrRLitZZeMjTzXDNulw4Ajv4
	UrMi4GGj5ZAlw/GXyMvItuWg8kIu3khTqg6icjuV/WEegkj+soAUVlArlrTxx3KAedBE3w
	We4CueWNkcil98B6oxieitf+sWtPawg=
Date: Tue, 16 Jan 2024 15:14:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com>
 <878r4vra87.fsf@oracle.com>
 <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
 <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com>
 <48a7a7db-978d-4e8c-8378-2851975a1ddb@linux.dev>
 <CAADnVQJTaDrXsn=EXSmEvRX6Zs-kAGtHmMxfS6S__NPD73yoeg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJTaDrXsn=EXSmEvRX6Zs-kAGtHmMxfS6S__NPD73yoeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/16/24 11:34 AM, Alexei Starovoitov wrote:

> On Tue, Jan 16, 2024 at 11:07 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 1/16/24 9:47 AM, Alexei Starovoitov wrote:
>>> On Mon, Jan 15, 2024 at 8:33 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>> [0] Updated LLVM
>>>>       https://github.com/eddyz87/llvm-project/tree/bpf-inline-asm-polymorphic-r
>>> 1.
>>> // Use sequence 'wX = wX' if 32-bits ops are available.
>>> let Predicates = [BPFHasALU32] in {
>>>
>>> This is unnecessary conservative.
>>> wX = wX instructions existed from day one.
>>> The very first commit of the interpreter and the verifier recognized it.
>>> No need to gate it by BPFHasALU32.
>> Actually this is not true from llvm perspective.
>> wX = wX is available in bpf ISA from day one, but
>> wX register is only introduced in llvm in 2017
>> and at the same time alu32 is added to facilitate
>> its usage.
> Not quite. At that time we added general support in the verifier
> for the majority of alu32 insns. The insns worked in the interpreter
> earlier, but the verifier didn't handle them.
> While wX=wX was supported by the verifier from the start.
> So this particular single insn shouldn't be part of alu32 flag
> It didn't need to be back in 2017 and doesn't need to be now.

Okay, IIUC, currently 32-bit subreg is enabled
only if alu32 is enabled.
   if (STI.getHasAlu32())
     addRegisterClass(MVT::i32, &BPF::GPR32RegClass);

We should unconditionally enable 32-bit subreg with.
   addRegisterClass(MVT::i32, &BPF::GPR32RegClass);

We may need to add Alu32 control in some other
places which trying to access 32-bit subreg.
But for wX = wX thing, we do not need Alu32 control
and the following is okay:
  def : Pat<(i64 (and (i64 GPR:$src), 0xffffFFFF)),
           (INSERT_SUBREG
             (i64 (IMPLICIT_DEF)),
             (MOV_rr_32 (i32 (EXTRACT_SUBREG GPR:$src, sub_32))),
             sub_32)>;

I tried with the above change with unconditionally
doing addRegisterClass(MVT::i32, &BPF::GPR32RegClass).

$ cat t1.c
unsigned long test1(unsigned long x) {
         return (unsigned)x;
}
unsigned long test2(unsigned x) {
         return x;
}
#if 0
unsigned test3(unsigned x, unsigned y) {
         return x + y;
}
#endif
$ clang --target=bpf -mcpu=v1 -O2 -c t1.c && llvm-objdump -d t1.o

t1.o:   file format elf64-bpf

Disassembly of section .text:
         
0000000000000000 <test1>:
        0:       bc 10 00 00 00 00 00 00 w0 = w1
        1:       95 00 00 00 00 00 00 00 exit
         
0000000000000010 <test2>:
        2:       bc 10 00 00 00 00 00 00 w0 = w1
        3:       95 00 00 00 00 00 00 00 exit
$

More changes in BPFInstrInfo.td and possible other
places need to make the above test3() function work
at -mcpu=v1.


