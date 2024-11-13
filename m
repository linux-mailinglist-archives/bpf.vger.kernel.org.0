Return-Path: <bpf+bounces-44710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8239C66ED
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E46B27FFC
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF537081D;
	Wed, 13 Nov 2024 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u/JT/nOI"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BE433D1
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462851; cv=none; b=RnCdQuEvtLzTG4iG4StxhuNn0SGIhg89ANzAdSMoEnqSPhUps6/CauMsoP2orNJQmRsyEKIccDNpvYnwAC8XCAoJfb+A9oxNq+QhnnacQmuSgeoP2fNhs8cKWeR1ciIVgAKaDDkb/l/s+NJSgrGUOO7Fp+8toDQSYBdlt1BLfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462851; c=relaxed/simple;
	bh=BVKfYXyWiadUzjLK+94Q+y7eLsjbBGeo4QJzkSM2tTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOFKl77VPd+7vhEg7y6LQhf3nHpRnHovvzAHp2gV6rhnBZ2Sh7eMiN/+4Gm3zn8WMn2GSC0iQYhme/wT9UVkcJGz0ogjp+7S2a77dhmPUWtAg2S+LycloUI2y19m/Xye5oASuqCxWrHRaNe1bN4NEZID0L09qP/bx9Mc3/xLHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u/JT/nOI; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e7643ba-ae62-4ca8-86b1-fcfb706148c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731462844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7Xy22MisGDK8aS/J8bKS29GT3ChuY5F55/iML6IKh8=;
	b=u/JT/nOIyBJ+sNK5wt+lWviXkanf6bMpJ3TTD8D2n9si4AMI/xBm1EEDKAv5rQoCPNUVUn
	M6frwOyyIUmQMwjbtY8lUsjyvktCqoyZxHR2mzxzpSCp5LaCaN0RIAP63bRCUDK7IZzbTs
	6hT1HaqLoPI+YgT34twhJgoHqH4DPCQ=
Date: Wed, 13 Nov 2024 09:53:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf, x64: Propagate tailcall info only
 for subprogs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, kernel-patches-bot@fb.com
References: <20241107134529.8602-1-leon.hwang@linux.dev>
 <20241107134529.8602-2-leon.hwang@linux.dev>
 <CAADnVQLvt3T5X3wev2fZ1pvwqzJ0_tB-DXxTdBp8GOo+DP_c9Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLvt3T5X3wev2fZ1pvwqzJ0_tB-DXxTdBp8GOo+DP_c9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 13/11/24 09:31, Alexei Starovoitov wrote:
> On Thu, Nov 7, 2024 at 5:46 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> In x64 JIT, propagate tailcall info only for subprogs, not for helpers
>> or kfuncs.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa57..eb08cc6d66401 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -2124,10 +2124,11 @@ st:                     if (is_imm8(insn->off))
>>
>>                         /* call */
>>                 case BPF_JMP | BPF_CALL: {
>> +                       bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
>>                         u8 *ip = image + addrs[i - 1];
>>
>>                         func = (u8 *) __bpf_call_base + imm32;
>> -                       if (tail_call_reachable) {
>> +                       if (pseudo_call && tail_call_reachable) {
>>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>>                                 ip += 7;
>>                         }
> 
> I've applied this patch with this tweak:
> if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable)
> 
> I don't see much value in patch 2.
> The tail_call feature is an old approach. It is now causing
> maintenance issues with other features.
> I'd rather not touch anything tail call related.
> So I dropped patch 2.
> 
> I'd like to see proper indirect goto and indirect call
> support being developed further.
> Anton started working on it, but dropped the ball.
> We need to commandeer the patches.

Great to see jmp table supporting tail call.

Thanks,
Leon



