Return-Path: <bpf+bounces-38232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF8961C2D
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 04:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6460E2832D0
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6646A33F;
	Wed, 28 Aug 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4hCvQ+Z"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CB3AC2B
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812579; cv=none; b=PifUOVtzBA7MWWgj5cyr5LL0h97C0XYu7QjoU0yhrhpm041x2Guc07UK4rc8ht3zsjj4IyM+wJqaC5JIf9SOg7qCsXPmlR7kQddAIwn84/tbypqHGSPnc8aw+WJnBlkuYKgOOZNeKj7CB4b5U4SMcCQ/HbJs9eoT4jLf0Q3R9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812579; c=relaxed/simple;
	bh=x4Xr/1K16EpENfDDH0pvqEyu/3rOQ64NJ722s2Rlkt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2tdISoTQdioAkTBqXVdgHnjpG4hUBd5wB1Plyo2v7Q/UZ3CI/TPS9PL223mZuk1bmdDTXD/VqU4d2I1TyXkSNKFfmOBSDL1obuWUpB7dwl4x6Emo0DW/QvPJBMHWpIG4SQG6USVV8SXbFjRyZZ3GKBGKdYc1pePWE0EcA45zok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4hCvQ+Z; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c63deed3-d5e5-4b1b-8cb5-ce9f92812e49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724812575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/YUfURha0i3Kv6ZcBTXOwODkgaI/FiXYMaBlNxqzwA=;
	b=I4hCvQ+ZLGZS3AG9uItMO/5e5SFSMBIXs23TZsUVNrg/wa/WweFNhvh8U7zQ2FI9RVXHKA
	vO6h8151jhnKDrlazFmDmL0z/OofSXv0auk9LYDxTuMu2TLse71dlxToK2431SffQwYfkc
	el7/ycGOPE5fdna/S0m+3xEUv8N/oVQ=
Date: Wed, 28 Aug 2024 10:36:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop caused
 by freplace
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-2-leon.hwang@linux.dev>
 <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
 <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev>
 <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 28/8/24 04:50, Alexei Starovoitov wrote:
> On Tue, Aug 27, 2024 at 5:48 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>> I wonder if disallowing to freplace programs when
>>> replacement.tail_call_reachable != replaced.tail_call_reachable
>>> would be a better option?
>>>
>>
>> This idea is wonderful.
>>
>> We can disallow attaching tail_call_reachable freplace prog to
>> not-tail_call_reachable bpf prog. So, the following 3 cases are allowed.
>>
>> 1. attach tail_call_reachable freplace prog to tail_call_reachable bpf prog.
>> 2. attach not-tail_call_reachable freplace prog to tail_call_reachable
>> bpf prog.
>> 3. attach not-tail_call_reachable freplace prog to
>> not-tail_call_reachable bpf prog.
> 
> I think it's fine to disable freplace and tail_call combination altogether.

I don't think so.

My XDP project heavily relies on freplace and tailcall combination.

> 
> And speaking of the patch. The following:
> -                       if (tail_call_reachable) {
> -
> LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
> -                               ip += 7;
> -                       }
> +                       LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
> +                       ip += 7;
> 
> Is too high of a penalty for every call for freplace+tail_call combo.
> 
> So disable it in the verifier.
> 

I think, it's enough to disallow attaching tail_call_reachable freplace
prog to not-tail_call_reachable prog in verifier.

As for this code snippet in x64 JIT:

			func = (u8 *) __bpf_call_base + imm32;
			if (tail_call_reachable) {
				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
				ip += 7;
			}
			if (!imm32)
				return -EINVAL;
			ip += x86_call_depth_emit_accounting(&prog, func, ip);
			if (emit_call(&prog, func, ip))
				return -EINVAL;

when a subprog is tail_call_reachable, its caller has to propagate
tail_call_cnt_ptr by rax. It's fine to attach tail_call_reachable
freplace prog to this subprog as for this case.

When the subprog is not tail_call_reachable, its caller is unnecessary
to propagate tail_call_cnt_ptr by rax. Then it's disallowed to attach
tail_call_reachable freplace prog to the subprog. However, it's fine to
attach not-tail_call_reachable freplace prog to the subprog.

In conclusion, if disallow attaching tail_call_reachable freplace prog
to not-tail_call_reachable prog in verifier, the above code snippet
won't be changed.

Thanks,
Leon


