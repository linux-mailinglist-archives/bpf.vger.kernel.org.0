Return-Path: <bpf+bounces-69120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188AAB8D324
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 03:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC82317B861
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A9185955;
	Sun, 21 Sep 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w1kruT7P"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64367C133
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758419009; cv=none; b=e1kfGOsAqLn80MMRkzVHctcRQv1NlB7JpMWxxF/bL/3acWmXX7rfOQV7QQX7W0stNZrMPM6R07sBu1Ix6qFjAUmJCtduojENeNib5Ud0y9L6Mx00zS5uBCkMlj15CYubWG50UnUaN9I0jl+VoGrcl7ksACDgfaoMAJ2e7y/vh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758419009; c=relaxed/simple;
	bh=1f4yV4O3uTfpI6PoKkoQIlVlBEEMB/jGfM0SxappyXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQMjvr1c4c2UXyyEg6xYvKAnC+suLYaae1w5s2Ct181taDBNadLiIiLI5cSpyi3qhtJQAf/LqCIlhyJ5ibM6rWLhzjufMVK5155hE6daaT96v++ISjyiQtf0FzZh8jtfMQoVflsjJzjyKcgay94zZiCbAMpjJv+SKGl4flfNmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w1kruT7P; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60dcd6a3-b0d7-4dfc-bb0a-86e5c56d4935@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758419005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0L86CwbY4lRwZ+Avjlueo8TAMzJINk0HDwqvN9E4NVc=;
	b=w1kruT7Prs9Tmur+A7OC/5BDXUj1zSV11qmy7FgGLUogiZmVQbR7c74HF88EolAAMInbu2
	y/BCSyMLS0b1pJrsGyFfIr94gbgd09qbLLukHFigssDPIKwynUd+Yc2nLG3l/J/NtasM87
	766rYB1/W2EGnKRuRViasmJ2s6cvWUo=
Date: Sat, 20 Sep 2025 18:43:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest verifier_arena_large
 failure
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20250920045805.3288551-1-yonghong.song@linux.dev>
 <CAADnVQL=vMa0a2zRtbaH64ft4ipTTBaM4tLeiAF9J6sVqUha0A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL=vMa0a2zRtbaH64ft4ipTTBaM4tLeiAF9J6sVqUha0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/20/25 3:52 PM, Alexei Starovoitov wrote:
> On Fri, Sep 19, 2025 at 9:58 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With latest llvm22, I got the following verification failure:
>>
>>    ...
>>    ; int big_alloc2(void *ctx) @ verifier_arena_large.c:207
>>    0: (b4) w6 = 1                        ; R6_w=1
>>    ...
>>    ; if (err) @ verifier_arena_large.c:233
>>    53: (56) if w6 != 0x0 goto pc+62      ; R6=0
>>    54: (b7) r7 = -4                      ; R7_w=-4
>>    55: (18) r8 = 0x7f4000000000          ; R8_w=scalar()
>>    57: (bf) r9 = addr_space_cast(r8, 0, 1)       ; R8_w=scalar() R9_w=arena
>>    58: (b4) w6 = 5                       ; R6_w=5
>>    ; pg = page[i]; @ verifier_arena_large.c:238
>>    59: (bf) r1 = r7                      ; R1_w=-4 R7_w=-4
>>    60: (07) r1 += 4                      ; R1_w=0
>>    61: (79) r2 = *(u64 *)(r9 +0)         ; R2_w=scalar() R9_w=arena
>>    ; if (*pg != i) @ verifier_arena_large.c:239
>>    62: (bf) r3 = addr_space_cast(r2, 0, 1)       ; R2_w=scalar() R3_w=arena
>>    63: (71) r3 = *(u8 *)(r3 +0)          ; R3_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
>>    64: (5d) if r1 != r3 goto pc+51       ; R1_w=0 R3_w=0
>>    ; bpf_arena_free_pages(&arena, (void __arena *)pg, 2); @ verifier_arena_large.c:241
>>    65: (18) r1 = 0xff11000114548000      ; R1_w=map_ptr(map=arena,ks=0,vs=0)
>>    67: (b4) w3 = 2                       ; R3_w=2
>>    68: (85) call bpf_arena_free_pages#72675      ;
>>    69: (b7) r1 = 0                       ; R1_w=0
>>    ; page[i + 1] = NULL; @ verifier_arena_large.c:243
>>    70: (7b) *(u64 *)(r8 +8) = r1
>>    R8 invalid mem access 'scalar'
>>    processed 61 insns (limit 1000000) max_states_per_insn 0 total_states 6 peak_states 6 mark_read 2
>>    =============
>>    #489/5   verifier_arena_large/big_alloc2:FAIL
>>
>> The main reason is that 'r8' in insn '70' is not an arena pointer.
>> Further debugging at llvm side shows that llvm commit ([1]) caused
>> the failure. For the original code:
>>    page[i] = NULL;
>>    page[i + 1] = NULL;
>> the llvm transformed it to something like below at source level:
>>    __builtin_memset(&page[i], 0, 16)
>> Such transformation prevents llvm BPFCheckAndAdjustIR pass from
>> generating proper addr_space_cast insns ([2]).
>>
>> Adding support in llvm BPFCheckAndAdjustIR pass should work, but
>> not sure that such a pattern exists or not in real applications.
>> At the same time, simply adding a memory barrier between two 'page'
>> assignment can fix the issue.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/155415
> Applied, but this is a serious issue.
> We were hoping that arena will be immune from llvm doing pointless
> "optimization" all the time and breaking the verifier.
> Looks like it's not.
> Let's fix BPFCheckAndAdjustIR or improve handling of
> __builtin_memset for arena asap.

Ack. Will do.



