Return-Path: <bpf+bounces-35243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F09392C1
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C8B1F220EE
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726916EB58;
	Mon, 22 Jul 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mj123IM4"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFBB16DC1A
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667267; cv=none; b=NFqoHJCBM6dOuyQ2nz8EtBgMdF6IvTg35bZD3rIf120kaz/SycPiq9R7/y401n6H0PdNkJ9WKAk83v0OO/0lFOWLby2wC301+as4jbs1Ewm6AYB8nHZfqqSbH5NLU1Xi3+eDAabQlFAH2/5RcEIuhJiXUqWynSuSQzw9bdIxLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667267; c=relaxed/simple;
	bh=uGWVBtQfbbkzI+x+tvERJpg+tuUWNc6Wh5gLg4NabIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhA4YgsiI7KUczYjdEnUGuWomVjEKlpUK8HNQxjMFoaMxXp55oN0xe3abuQwKnRMD/aHIIzQv6UycK+ICO/yInrHK1UL/RKP3ut2h2nwfkju/0lZbVK6bsin8Tq/gLmRNGg2AM1p0p4ass0g53U4p9T6CbjAszVADNydlhVUDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mj123IM4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721667262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmmHgnwkfkxlnEWLUjOLMC/sdoxEIHajzF0GPURF7Sc=;
	b=mj123IM4W/VCp4p6Dt3BFTpQrincgZVfoSmDK9dTzosDQN+0bbJ7RDF6W8YyUuZUMOceS4
	ZyJxnk820ZOUGJoYw18CK88NIA+7HJNwWlN3rm00BnZ0DKMWPUlWiMIdlToSfiLT3Zov9i
	WC4SfvdWanBq4n9uSH2OZ90qJvuCknA=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <acb61caf-049b-4304-a083-165c18636587@linux.dev>
Date: Mon, 22 Jul 2024 09:54:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/21/24 8:33 PM, Eduard Zingerman wrote:
> Hi Yonghong,
>
> In general I think that changes in this patch are logical and make sense.
> I have a suggestion regarding testing JIT related changes.
>
> We currently lack a convenient way to verify jit behaviour modulo
> runtime tests. I think we should have a capability to write tests like below:
>
>      SEC("tp")
>      __jited_x86("f:	endbr64")
>      __jited_x86("13:	movabs $0x.*,%r9")
>      __jited_x86("1d:	add    %gs:0x.*,%r9")
>      __jited_x86("26:	mov    $0x1,%edi")
>      __jited_x86("2b:	mov    %rdi,-0x8(%r9)")
>      __jited_x86("2f:	mov    -0x8(%r9),%rdi")
>      __jited_x86("33:	xor    %eax,%eax")
>      __jited_x86("35:	lock xchg %rax,-0x8(%r9)")
>      __jited_x86("3a:	lock xadd %rax,-0x8(%r9)")
>      __naked void stack_access_insns(void)
>      {
>      	asm volatile (
>      	"r1 = 1;"
>      	"*(u64 *)(r10 - 8) = r1;"
>      	"r1 = *(u64 *)(r10 - 8);"
>      	"r0 = 0;"
>      	"r0 = xchg_64(r10 - 8, r0);"
>      	"r0 = atomic_fetch_add((u64 *)(r10 - 8), r0);"
>      	"exit;"
>      	::: __clobber_all);
>      }
>
> In the following branch I explored a way to add such capability:
> https://github.com/eddyz87/bpf/tree/yhs-private-stack-plus-jit-testing
>
> Beside testing exact translation, such tests also provide good
> starting point for people trying to figure out how some jit features work.
>
> The below two commits are the gist of the feature:
> 8f9361be2fb3 ("selftests/bpf: __jited_x86 test tag to check x86 assembly after jit")
> 0156b148b5b4 ("selftests/bpf: utility function to get program disassembly after jit")
>
> For "0156b148b5b4" I opted to do a popen() call and execute bpftool process,
> an alternative would be to:
> a. either link tools/bpf/bpftool/jit_disasm.c as a part of the
>     test_progs executable;
> b. call libbfd (binutils dis-assembler) directly from the bpftool.
>
> Currently bpftool can use two dis-assemblers: libbfd and llvm library,
> depending on the build environment. For CI builds libbfd is used.
> I don't know if llvm and libbfd always produce same output for
> identical binary code. Imo, if people are Ok with adding libbfd
> dependency to test_progs, option (b) is the best. If folks on the
> mailing list agree with this, I can work on updating the patches.

I think this is a good idea in the long time.
Let me try with your patch.

>
> -------------
>
> Aside from testing I agree with Andrii regarding rbp usage,
> it seems like it should be possible to do the following in prologue:
>
>      movabs $0x...,%rsp
>      add %gs:0x...,%rsp
>      push %rbp
>
> and there would be no need to modify translation for instructions
> accessing r10, plus debugger stack unrolling logic should still work?.
> Or am I mistaken?

This may not work. The 'push %rbp' does not change %rbp value which still
the original %rbp.

>
> Thanks,
> Eduard

