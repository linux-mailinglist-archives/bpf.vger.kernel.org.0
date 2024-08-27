Return-Path: <bpf+bounces-38156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56765960B07
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884EE1C22993
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4131BD4E0;
	Tue, 27 Aug 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wq8djsEF"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8219F49A
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762901; cv=none; b=k5pBUsO8O9BWLg3WNVHMwbFtkXY22Y6GMQX9//PDtljnB0+QQ89VbMkYw2gOSQJyMTWGTa7QX9d/ASoUGN1biQM4Lb6FIcWV/uJ1hkwTiWfeoC9TsVTJnNE5v68euv5g5llUROdfP/5BPp9T1kmI9qSq0EtNZpBLlYjQuz0S5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762901; c=relaxed/simple;
	bh=s1KoZs+zuOhL/w0JwImKNhwezv+lLEwLxyg78TDUcCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORPQEpoFcC+72eESgZNFVmoL4ySb/3sYOSZ4RVgZghCT/s1HMtBWsc8ud7t1w5I6HZEEldfp3wULihSLeGyFtOWiLeVoxi3tV9af7rCztkq8Y6OpTV6ktYiPHcGKgAZKPANsT1Sc6VR5lUezNOtrVJMt1T9qxSLHkRq8rPRyOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wq8djsEF; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724762896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUyZXDsmSa8QyW1Xno1CGTcNy3G6IGu1+AfQwBJn/FM=;
	b=Wq8djsEFfpDvHaJuJ5MGLGdvT4BpliggQVuRplu+g+6t3/kwmrXy33njH2rC79mHrqzGDT
	Zlexj+elOQzj9pBRxHu97/4nLqGdG8aYe6LbzQCfwbe8Dugue9T8dvr1HpJUYoqRYaYUFf
	k4uCH+5T2A5UzfcSAw2ST5kpGML7k40=
Date: Tue, 27 Aug 2024 20:48:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop caused
 by freplace
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-2-leon.hwang@linux.dev>
 <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/27 18:37, Eduard Zingerman wrote:
> On Sun, 2024-08-25 at 21:09 +0800, Leon Hwang wrote:
>> This patch fixes a tailcall infinite loop issue caused by freplace.
>>
>> Since commit 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility"),
>> freplace prog is allowed to tail call its target prog. Then, when a
>> freplace prog attaches to its target prog's subprog and tail calls its
>> target prog, kernel will panic.
>>

[...]

>>
>> As a result, the tail_call_cnt is stored on the stack of entry_tc. And
>> the tail_call_cnt_ptr is propagated between subprog_tc, entry_freplace,
>> subprog_tail and entry_tc.
>>
>> Furthermore, trampoline is required to propagate
>> tail_call_cnt/tail_call_cnt_ptr always, no matter whether there is
>> tailcall at run time.
>> So, it reuses trampoline flag "BIT(7)" to tell trampoline to propagate
>> the tail_call_cnt/tail_call_cnt_ptr, as BPF_TRAMP_F_TAIL_CALL_CTX is not
>> used by any other arch BPF JIT.
> 
> This change seem to be correct.
> Could you please add an explanation somewhere why nop3/xor and nop5
> are swapped in the prologue?

OK, I'll explain it in message of patch v2.

> 
> As far as I understand, this is done so that freplace program
> would reuse xor generated for replaced program, is that right?
> E.g. for tailcall_bpf2bpf_freplace test case disasm looks as follows:
> 
> --------------- entry_tc --------------
> func #0:
> 0:	f3 0f 1e fa                         	endbr64
> 4:	48 31 c0                            	xorq	%rax, %rax
> 7:	0f 1f 44 00 00                      	nopl	(%rax,%rax)
> c:	55                                  	pushq	%rbp
> d:	48 89 e5                            	movq	%rsp, %rbp
> 10:	f3 0f 1e fa                         	endbr64
> ...
> 
> ------------ entry_freplace -----------
> func #0:
> 0:	f3 0f 1e fa                         	endbr64
> 4:	0f 1f 00                            	nopl	(%rax)
> 7:	0f 1f 44 00 00                      	nopl	(%rax,%rax)
> c:	55                                  	pushq	%rbp
> d:	48 89 e5                            	movq	%rsp, %rbp
> ...
> 
> So, if entry_freplace would be used to replace entry_tc instead
> of subprog_tc, the disasm would change to: 
> 
> --------------- entry_tc --------------
> func #0:
> 0:	f3 0f 1e fa                         	endbr64
> 4:	48 31 c0                            	xorq	%rax, %rax
> 7:	0f 1f 44 00 00                      	jmp <entry_freplace>
> 
> Thus reusing %rax initialization from entry_tc.
> 

Great. You understand it correctly.

>> However, the bad effect is that it requires initializing tail_call_cnt at
>> prologue always no matter whether the prog is tail_call_reachable, because
>> it is unable to confirm itself or its subprog[s] whether to be attached by
>> freplace prog.
>> And, when call subprog, tail_call_cnt_ptr is required to be propagated
>> to subprog always.
> 
> This seems unfortunate.
> I wonder if disallowing to freplace programs when
> replacement.tail_call_reachable != replaced.tail_call_reachable
> would be a better option?
> 

This idea is wonderful.

We can disallow attaching tail_call_reachable freplace prog to
not-tail_call_reachable bpf prog. So, the following 3 cases are allowed.

1. attach tail_call_reachable freplace prog to tail_call_reachable bpf prog.
2. attach not-tail_call_reachable freplace prog to tail_call_reachable
bpf prog.
3. attach not-tail_call_reachable freplace prog to
not-tail_call_reachable bpf prog.

I would like to add this limit in patch v2, that tail_call_reachable
freplace is disallowed to attach to not-tail_call_reachable bpf prog.
Thereafter, tail_call_cnt_ptr is required to be propagated to subprog
only when subprog is tail_call_reachable.

Thanks,
Leon

