Return-Path: <bpf+bounces-16653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3A804237
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8819C1C20C67
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5A23742;
	Mon,  4 Dec 2023 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T3xxA7tH"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A2EA0
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:02:31 -0800 (PST)
Message-ID: <7de7f58a-5d98-4a72-892b-368559fdc581@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701730949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6OJqeOKzaTLw90G79LForSbKX+pxNJtCUk6vA5xadc=;
	b=T3xxA7tHA+Zt97zQm8TZyEe8tZVec6BCHJ5Pg9SGid+b5ke6BQfU94dBZCSuaya4Y/eQKU
	hfb9OEwoQD76BT4yR+pjvlptTya/6INdXt/EMqRyXajXIRqA52+sAi7qoHsXS838E3SQXS
	tpUQGYUDQJVHt9TCJN1GTityezulo/U=
Date: Mon, 4 Dec 2023 15:02:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 00/10] Complete BPF verifier precision
 tracking support for register spills
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20231204192601.2672497-1-andrii@kernel.org>
 <CAEf4BzaqWDNUyWzwSM6ZyZXcVuE10HZ6ryaZQ05wPY-0spb+aw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaqWDNUyWzwSM6ZyZXcVuE10HZ6ryaZQ05wPY-0spb+aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/4/23 5:32 PM, Andrii Nakryiko wrote:
> On Mon, Dec 4, 2023 at 11:26 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>> Add support to BPF verifier to track and support register spill/fill to/from
>> stack regardless if it was done through read-only R10 register (which is the
>> only form supported today), or through a general register after copying R10
>> into it, while also potentially modifying offset.
>>
>> Once we add register this generic spill/fill support to precision
>> backtracking, we can take advantage of it to stop doing eager STACK_ZERO
>> conversion on register spill. Instead we can rely on (im)precision of spilled
>> const zero register to improve verifier state pruning efficiency. This
>> situation of using const zero register to initialize stack slots is very
>> common with __builtin_memset() usage or just zero-initializing variables on
>> the stack, and it causes unnecessary state duplication, as that STACK_ZERO
>> knowledge is often not necessary for correctness, as those zero values are
>> never used in precise context. Thus, relying on register imprecision helps
>> tremendously, especially in real-world BPF programs.
>>
>> To make spilled const zero register behave completely equivalently to
>> STACK_ZERO, we need to improve few other small pieces, which is done in the
>> second part of the patch set. See individual patches for details. There are
>> also two small bug fixes spotted during STACK_ZERO debugging.
>>
>> The patch set consists of logically three changes:
>>    - patch #1 (and corresponding tests in patch #2) is fixing/impoving precision
>>      propagation for stack spills/fills. This can be landed as a stand-alone
>>      improvement;
>>    - patches #3 through #9 is improving verification scalability by utilizing
>>      register (im)precision instead of eager STACK_ZERO. These changes depend
>>      on patch #1.
>>    - patch #10 is a memory efficiency improvement to how instruction/jump
>>      history is tracked and maintained. It depends on patch #1, but is not
>>      strictly speaking required, even though I believe it's a good long-term
>>      solution to have a path-dependent per-instruction information. Kind
>>      of like a path-dependent counterpart to path-agnostic insn_aux array.
>>
>> v2->v3:
>>    - BPF_ST instruction workaround (Eduard);
> ok, so I fixed this in the main partial_stack_load_preserves_zeros
> test, but there is at least spill_subregs_preserve_stack_zero that
> needs fixing as well. I'll audit all the tests thoroughly and will fix
> all BPF_ST uses.
>
> Eduard or Yonghong, what's the Clang version that does support BPF_ST
> instructions in inline asm? When would we be able to just assume those
> instructions are supported?

For inline asm, llvm18.
For C->asm codegen, llvm18 + cpu=v4.

[...]


