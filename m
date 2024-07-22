Return-Path: <bpf+bounces-35241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AD2939297
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8E71F22011
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D816EB46;
	Mon, 22 Jul 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t3wbZtu5"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EB26ACD
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666033; cv=none; b=f8uweYDUzxeRInpjjTl78CWMBOcX/jsjbj6ficECEuBL280L3/ymTbeCedz+Lh+BY/cHfqrcWPFZY4ck5d44RBDqnSCtgmtIg1BXtrVESm4J7DrxM0r4mzq5LPhaUUURrk1To4Ot277UKLFBkwNxGi/ideN4ivkvX7hUkB24XxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666033; c=relaxed/simple;
	bh=CN7JuEk3s8/iM7YCJIxboDTKdduFqTCgFEnSyili/EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilkw0F/SrYA9f1LwuzeIwFF3E2kQzxQ6CHOK2T/KPyk1LxoZNCd8GUqqC2bqxOfYWOXEVwwiE4zXa0Gh3J4rJNV2vxqbWsLUiQeBmu5xZrjyyXMdG6PXOgCgXi3CGHEWQ6TePuLh7YXgk6MsCnQefeEVQsZWNKQ03F9sdHJootw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t3wbZtu5; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721666027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeZHgZqj1R2lDVY3jGDKFM2MzRBR+8NOwBkMi1ci6bw=;
	b=t3wbZtu5kG5/empp72bQPUVORVP3ulRNmGb1v53i74TGgsQiR3O3ZBIPy0MDc3LlnPWXB7
	T3sHXLpkA6/b7O0WEGcoIAUJbBvd+CK7EvAweVJrAjsXgz587Pj/I7TWYlLTMqgpjD1J/J
	6V+EVtWq4yQSCT7ChkT1R3lEeGo2+pA=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <c8c63a07-7eab-41e8-bb9f-05a42f86220f@linux.dev>
Date: Mon, 22 Jul 2024 09:33:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <20240718205203.3652080-1-yonghong.song@linux.dev>
 <CAADnVQ+C--rr_C=dCqwGhZux4JQSHJvAazgem1L8OGx7CC6+nw@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+C--rr_C=dCqwGhZux4JQSHJvAazgem1L8OGx7CC6+nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/19/24 6:08 PM, Alexei Starovoitov wrote:
> On Thu, Jul 18, 2024 at 1:52 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> The following are the jited progs with private stack:
>>
>> subprog:
>> 0:  f3 0f 1e fa             endbr64
>> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>> 9:  66 90                   xchg   ax,ax
>> b:  55                      push   rbp
>> c:  48 89 e5                mov    rbp,rsp
>> f:  f3 0f 1e fa             endbr64
>> 13: 49 b9 70 a6 c1 08 7e    movabs r9,0x607e08c1a670
>> 1a: 60 00 00
>> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
>> 24: 02 00
>> 26: 31 c0                   xor    eax,eax
>> 28: c9                      leave
>> 29: c3                      ret
> Thanks for doing the benchmarking.
> It's clear now that worst case overhead is ~5%.
> Could you do one more benchmark such that the 'main prog'
> below stays as-is with setup of r9 and push/pop r9,
> but in the subprog above there is no 'movabs r9 + add r9' ?
> To simulate the case when a big function with a large stack
> triggers private-stack use, but it calls a subprog without
> a private stack.
> I think we should see a different overhead.
> Obviously subprog won't have these two extra insns that setup r9
> which would lead to something like ~4% slowdown vs 5%,
> but I feel the overhead of pure push/pop r9 around calls
> will be lower as well, because r9 is not written into inside subprog.
> The CPU HW should be able to execute such push/pop faster.
> I'm curious what it is.
Sure. Let me do an experiment with this.
>
>> main prog:
>> 0:  f3 0f 1e fa             endbr64
>> 4:  0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>> 9:  66 90                   xchg   ax,ax
>> b:  55                      push   rbp
>> c:  48 89 e5                mov    rbp,rsp
>> f:  f3 0f 1e fa             endbr64
>> 13: 49 b9 88 a6 c1 08 7e    movabs r9,0x607e08c1a688
>> 1a: 60 00 00
>> 1d: 65 4c 03 0c 25 00 1a    add    r9,QWORD PTR gs:0x21a00
>> 24: 02 00
>> 26: 48 bf 00 d0 5b 00 00    movabs rdi,0xffffc900005bd000
>> 2d: c9 ff ff
>> 30: 48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>> 34: 48 83 c6 01             add    rsi,0x1
>> 38: 48 89 77 00             mov    QWORD PTR [rdi+0x0],rsi
>> 3c: 41 51                   push   r9
>> 3e: e8 46 23 51 e1          call   0xffffffffe1512389
>> 43: 41 59                   pop    r9
>> 45: 41 51                   push   r9
>> 47: e8 3d 23 51 e1          call   0xffffffffe1512389
>> 4c: 41 59                   pop    r9
>> 4e: 41 51                   push   r9
>> 50: e8 34 23 51 e1          call   0xffffffffe1512389
>> 55: 41 59                   pop    r9
>> 57: 31 c0                   xor    eax,eax
>> 59: c9                      leave
>> 5a: c3                      ret
>>
> Also pls share 'perf annotate' of JIT-ed asm.
> I wonder where the hotspots are in the code.
Okay, will do.

