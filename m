Return-Path: <bpf+bounces-36926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F294F6BC
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E59BB23972
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90C19754D;
	Mon, 12 Aug 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aLPR3EiE"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AE197A61
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487198; cv=none; b=c6TS+ZDPbDp9zkJdioZM6JtnIxML9HNEMzEMOuPCygH7hQJu3Yl3sEgiqHlx2i5gIO4fxTc9YVAA3Sb2wQoj3KWk4bUHSz5OWfyUDkSnt8StLhfuoYsHRH172a09m7qu7pKLFxRlMXe8LPAtU8QwlWJNZhyaDhRGt5lwg4YzCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487198; c=relaxed/simple;
	bh=0WyGHkukyGZHDMwlvIezfC/2C4FqFjtsuDHqCt4AKt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwllkfTKEYIgsOo4mMme1kwvt47lT0K2ckcgJNEC4D2AtztXRS/SCfpM6TR2OcYKb/2bkn6/TuCwe7Zfm+Dzs/dEFJpR1Q5O1YRQfEOFqE/6E4A+BLz1Z7Il0mfdKVMg3qoHlCUOaPWcWUWsWDKvzw8GFzrbSt2zD619BIRAbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aLPR3EiE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4af06f9-5ea7-4541-90fd-1241043d5659@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723487193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wKPHI7S780ej8n6HXdIRMab9YIG8QCPfjynVGg4Myo=;
	b=aLPR3EiEBKs+6qCEdqcFZQZhBmEW2Z3y3BcNc6uDWGKQoxyb0Oupi60c69+gHKGjE+jvrW
	8zVfE+NyHj69TYEEAltVu0BbtfoHMsAE1jeSHc9hZuWXdC3saC7vxBNDDOjGcPorau/YK9
	THOmvZQEFDLxtDqmB6epk5HhSOxWHo4=
Date: Mon, 12 Aug 2024 11:26:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/12/24 10:50 AM, Alexei Starovoitov wrote:
> On Mon, Aug 12, 2024 at 10:47 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Mon, 2024-08-12 at 10:44 -0700, Alexei Starovoitov wrote:
>>
>> [...]
>>
>>> Should we move the check up instead?
>>>
>>> if (i >= cur->allocated_stack)
>>>            return false;
>>>
>>> Checking it twice looks odd.
>> A few checks before that, namely:
>>
>>                  if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
>>                      && exact == NOT_EXACT) {
>>                          i += BPF_REG_SIZE - 1;
>>                          /* explored state didn't use this */
>>                          continue;
>>                  }
>>
>>                  if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
>>                          continue;
>>
>>                  if (env->allow_uninit_stack &&
>>                      old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
>>                          continue;
>>
>> Should be done regardless cur->allocated_stack.
> Right, but then let's sink old->slot_type != cur->slot_type down?

We could do the following to avoid double comparison: diff --git 
a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c index 
df3be12096cf..1906798f1a3d 100644 --- a/kernel/bpf/verifier.c +++ 
b/kernel/bpf/verifier.c @@ -17338,10 +17338,13 @@ static bool 
stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old, */ 
for (i = 0; i < old->allocated_stack; i++) { struct bpf_reg_state 
*old_reg, *cur_reg; + bool cur_exceed_bound; spi = i / BPF_REG_SIZE; - 
if (exact != NOT_EXACT && + cur_exceed_bound = i >= 
cur->allocated_stack; + + if (exact != NOT_EXACT && !cur_exceed_bound && 
old->stack[spi].slot_type[i % BPF_REG_SIZE] != 
cur->stack[spi].slot_type[i % BPF_REG_SIZE]) return false; @@ -17363,7 
+17366,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct 
bpf_func_state *old, /* explored stack has more populated slots than 
current stack * and these slots were used */ - if (i >= 
cur->allocated_stack) + if (cur_exceed_bound) return false; /* 64-bit 
scalar spill vs all slots MISC and vice versa. WDYT?


