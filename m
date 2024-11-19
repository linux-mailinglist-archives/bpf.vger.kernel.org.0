Return-Path: <bpf+bounces-45186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71729D2829
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D5B1F21C73
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C9C1CEAAD;
	Tue, 19 Nov 2024 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLLJWWf4"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8114658D
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026559; cv=none; b=bvsPTZ4hGIXIk6p0HfDEpx7Tx0MMnQ7mNcPR1YVyJeFbOhOZrgu7DG/INMJRwH7+EuSn0/ylHTNtWhfoLKXO0wP3IiP11I6QWe6BU7NbbtwOCrUcfUy6c6CXWmmlJ6XY/6FWRpbmX/iVuEijIXV8B6Fp/Cc9V5ClcW5yy8p9GQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026559; c=relaxed/simple;
	bh=BgTB8YMSmyuhr/AXi0TflyxXEGrwJM8j+RuykjQSWiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNUhX9itEd+HeUAPFBihRkR0v9O5NzKO/a7uScAYl4FczlOVbu4WvOW75/3+NfMsvZGKi4zTbPRZzr3/fD+Ce2tgBqAY2TDdH0IRr0/M5q7xzkNcSm0KEJw6H914kOEJjpKb3Ljxzgvk9sOeQLSQjxJJRFnTpS7eULUgCMk4S/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLLJWWf4; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bade75b3-92d2-42e8-aede-f7a361b491a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732026554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oG0wuB8DfZZSDK/R13XMTYQPz2x8NVtryV3EBjI/sMI=;
	b=PLLJWWf4d9Dm2IMGzxfDQout68fZQZd1WKj6OfEDBlQLIbHglDyzz+ubWQMznPckFGwCRb
	wqQiK5NVz4fk5vlD4TrtHpiP5BaBIAvhCKbGc+fIBKjRftx6k4FV8Om5MUpEEJQUaBSlUE
	IQe3YHENLRMrqx76A9flveC7+S6SZuA=
Date: Tue, 19 Nov 2024 06:29:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-2-vadfed@meta.com>
 <20241119111809.GB2328@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241119111809.GB2328@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/11/2024 03:18, Peter Zijlstra wrote:
> On Mon, Nov 18, 2024 at 10:52:42AM -0800, Vadim Fedorenko wrote:
>> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>   			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>   				int err;
>>   
>> +				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>> +					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
>> +						EMIT3(0x0F, 0xAE, 0xE8);
>> +					EMIT2(0x0F, 0x31);
>> +					break;
>> +				}
> 
> TSC != cycles. Naming is bad.

Any suggestions?

JIT for other architectures will come after this one is merged and some
of them will be using cycles, so not too far away form the truth..

