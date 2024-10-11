Return-Path: <bpf+bounces-41711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD0999B92
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 06:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6021F23E94
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E71BD01A;
	Fri, 11 Oct 2024 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpKFnY7H"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF57F9
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620173; cv=none; b=Nv4jBjximt214eCnkkSqJ+VZmCu2HXJ1Y7YPzJcKgbcafDsw5m3dsu3/5dhZhQ/P9pvTKSQg50RIZDRQ8VynAse5GAe+8U6VRXvok2fEj9E9W+v/GyjGvnys3xOS5T1VAz7M22uujQVNfLYfdxP4L2HpNHoNHSkpu6xOqmGaZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620173; c=relaxed/simple;
	bh=ioEYPZzqI7PnpOX4eJKqwUZGYNzBMz4lkAXxIXUeXBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uq7N8qiegq1+Vy7iENejLP3boOGeVurD/tTFY0RUpj5QhYQSAKkO5HDAZwSqE5f0JW6wifZK0MbLUZWRDgkK/Kwba7sigUuY7gP7UXJkxWEOIfCPU7E1Zfx9ZOjx1ACp163YdrjSZjxu7ivWhQFUzQKTb3Hp1XWF2SptIqcOK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpKFnY7H; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc1dcb35-59bb-40ff-af99-6339d344f285@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728620169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kzXGtYpfNKlhytFsKhnwUeqrz0rUu6I/3O9JX96Iu4=;
	b=JpKFnY7H0o003CP3qMNkJnFofFmZ5nOxD9gZfPnfHsL4cfFjHktyw5o2HIsh3cYb9jZyPQ
	7xwTOr3HgST3tfChhrezL+H4x7cOhUk8q2yf92crDZsUy9/l6nxxBDhqubv112KRLdqn+r
	6QsjWcyYotcZoKPDzlmt2PSj1ijzsEs=
Date: Thu, 10 Oct 2024 21:16:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 08/10] bpf, x86: Create two helpers for some
 arith operations
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
 <20241010175633.1898994-1-yonghong.song@linux.dev>
 <CAADnVQJvLWYiEZqEG3SfBf4BvoCvHfXYJ4avCrcXWGNzRunBOw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJvLWYiEZqEG3SfBf4BvoCvHfXYJ4avCrcXWGNzRunBOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/10/24 1:21 PM, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 10:56 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Two helpers are extracted from bpf/x86 jit:
>>    - a helper to handle 'reg1 <op>= reg2' where <op> is add/sub/and/or/xor
>>    - a helper to handle 'reg *= imm'
>>
>> Both helpers will be used in the subsequent patch.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 51 ++++++++++++++++++++++++-------------
>>   1 file changed, 34 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index a6ba85cec49a..297dd64f4b6a 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1475,6 +1475,37 @@ static void emit_alu_helper_1(u8 **pprog, u8 insn_code, u32 dst_reg, s32 imm32)
>>          *pprog = prog;
>>   }
>>
>> +/* emit ADD/SUB/AND/OR/XOR 'reg1 <op>= reg2' operations */
>> +static void emit_alu_helper_2(u8 **pprog, u8 insn_code, u32 dst_reg, u32 src_reg)
>> +{
>> +       u8 b2 = 0;
>> +       u8 *prog = *pprog;
>> +
>> +       maybe_emit_mod(&prog, dst_reg, src_reg,
>> +                      BPF_CLASS(insn_code) == BPF_ALU64);
>> +       b2 = simple_alu_opcodes[BPF_OP(insn_code)];
>> +       EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
>> +
>> +       *pprog = prog;
>> +}
>> +
>> +/* emit 'reg *= imm' operations */
>> +static void emit_alu_helper_3(u8 **pprog, u8 insn_code, u32 dst_reg, s32 imm32)
> _1, _2, _3 ?!
>
> There must be a better way to name the helpers. Like:
>
> _1 -> emit_alu_imm
> _2 -> emit_alu_reg
> _3 -> emit_mul_imm

I struggle to get a proper name here. I originally thought about to use
emit_alu_reg_imm, emit_alu_reg_reg, but in my case, even emit_alu_reg_imm
only supports add/sub/and/or/xor and it does not support mul/div/mod, so
emit_alu_reg_imm does not really cover all alu operations so I chose
another name which is also not good.

I guess I can use the above you suggested in the above which actually
covers most alu operations.


