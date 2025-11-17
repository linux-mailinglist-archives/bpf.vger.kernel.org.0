Return-Path: <bpf+bounces-74729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E41C64473
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E5CB4E5271
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07732C31A;
	Mon, 17 Nov 2025 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNfcJfVs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EF283FD4
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384469; cv=none; b=pbZsugaNMgfENGKPjP2id1GX1QphIFeJjgv2DjlwhoVSs3viMiZ75I0LO3ITnJ8pMXrFhrYCnK7i07YdifcTBDzqk0QLZ+01DaHCS21AOTu00ig3+5lhEKTtP2QwMk8RTrvfWx9UfuT0w8ysf9NL2F/xb4530qnOq4quhVT0jzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384469; c=relaxed/simple;
	bh=1XaobrZ1iSKa/N6CAfU+omnCxFx7705Pzw14VqgAit0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QqteZSWY4u6uM3gam6lcte99VBqRM4V1NTnMktmbAJPgnR3HhXWnG5ob9jpXelwh9msOR5u4qtDo/w92Tj9ntDZq65fyT948xzAl4P6m3SzfXhfGXY6Dluf1u5yF2hwByrIdYB7P6e4tqNqYgV2vfUmd5n+C8MD0cSqGQjYT2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNfcJfVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E012C4CEFB;
	Mon, 17 Nov 2025 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763384468;
	bh=1XaobrZ1iSKa/N6CAfU+omnCxFx7705Pzw14VqgAit0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HNfcJfVsKbD4CcAJsIQIrXttPDO8ew5XSMhlmY1F9H7lXg6umHDbOZ997ae3c7K+H
	 fnnW3ZSnM7Se6vJekdwyZ34HS/+v7XJDrzba+m1xixCsCaSlKGT2Lkgl87nHL6gdrM
	 DhB/r7EaEZnElcojZ2yymWdwNoKHJeV1Veap79F+TOFO5lVGP5TXSZnrRCjywG6/cy
	 eHq3o1rHKQHMOJr0zBzIHcV21BfYvvnF/XH/u7AA1BAUy5HJOKjRJ/lu/4R+FS3uu2
	 IeGF79jDhkr0yJPd1NS6EI1QQFbHT4vkddDVJZq0ds8kawU06O0Zv530E6cUdWbpPf
	 F2os22cFtp00Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel-team@meta.com, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 0/4] bpf: arm64: Indirect jumps
In-Reply-To: <aRrX7eXoWL1RhtJO@mail.gmail.com>
References: <20251117004656.33292-1-puranjay@kernel.org>
 <aRrX7eXoWL1RhtJO@mail.gmail.com>
Date: Mon, 17 Nov 2025 13:01:05 +0000
Message-ID: <mb61p4iqsn78u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anton Protopopov <a.s.protopopov@gmail.com> writes:

> On 25/11/17 12:46AM, Puranjay Mohan wrote:
>> This set adds the support of indirect jumps to the arm64 JIT. It
>> involves calling bpf_prog_update_insn_ptrs() to support instructions
>> array map. The second piece is supporting BPF_JMP|BPF_X|BPF_JA, SRC=0,
>> DST=Rx, off=0, imm=0 instruction that is trivial to implement on arm64.
>>
>> When running the selftests after doing the above changes, I found that
>> on arm64 builds of llvm, a relocation section was being generated for
>> .jumptables sections and it was making libbpf fail like:
>> 
>> libbpf: relocation against STT_SECTION in non-exec section is not supported!
>> Error: failed to link 'tools/testing/selftests/bpf/cpuv4/bpf_gotox.bpf.o': Invalid argument (22)
>> 
>> Which is due to:
>> 
>> Relocation section '.rel.jumptables' at offset 0x5b50 contains 263 entries:
>>     Offset             Info             Type               Symbol's Value  Symbol's Name
>> 0000000000000000  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
>> 0000000000000008  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
>> 0000000000000010  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
>> 
>> This rel section is not generated by x86 builds of LLVM. The third patch
>> of this set makes libbpf ignore relocation sections for .jumptables.
>
> I added Yonghong to this thread. He had fixed this problem in
> https://github.com/llvm/llvm-project/pull/166301 changes doesn't seem to be
> x86-specific...

My arm64 build didn't have this change, that is why it was failing.
After pulling the latest changes and building again, it works without
the libbpf patch.

So, I will send v2 and drop the libbpf patch.

Thanks,
Puranjay

