Return-Path: <bpf+bounces-35563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110193B88D
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 23:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A0F1F23F47
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 21:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704313AD3D;
	Wed, 24 Jul 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bY6n4uE+"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708578C60
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856534; cv=none; b=HLhQWXl/xmGGee/SqONylT8CUSmuKcgRoEl79OD+tGQ1FOrGtgXC7orPSOv2c0ESFI/ikU9tezWXjeHNH8JhFfQlBAry0D2bJgFkqXJPZNy2WFxgQEqv/+v3VYyKOxUK4tG1Ix9foFwXjW0y770303Z0mMuW9P3arzx6+uDtcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856534; c=relaxed/simple;
	bh=UFncxwS+Klo+TW++3hbkyNiA2dh5MYhFphDYtRqHORw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8CkXreDstiJPRxaDKhReOW5jLTSjc6WsaIQk1oHNkPMapaGlagoKvP5Npuqk5liQxDq7zxLLTeTjmxaYsZCpPWnzOavbINT+WXndsKNDkN/DZgBWX2BSbvGp1OMW/cmETqvhxZ9WRBiUOt3va2zSWB//X+sXJoyUqEl3fUg3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bY6n4uE+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0706fd3-7665-4983-b7ca-ab410c83bf57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721856529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKBO04AywrRxA/q1s86NTAmW7O6ax3vJG8Nc5C0KBTc=;
	b=bY6n4uE+qOFtVWrIric2qf3Pv9CjjC8h9AdskmY/FQvQCX5cuuM5ANZAIIqPJQ4Wuev5vP
	Jggwx2igD8c60k1G6BEOSPR7VRNySeqim6Nv4KfefQVU8suR/LBV7HsfAzSGU6xLJyMT2v
	T9DIN+1HisebIS6oHLWYITq5beV6ysE=
Date: Wed, 24 Jul 2024 14:28:40 -0700
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

I tried a simple example like below.
$ cat test.c
#include <stdint.h>
typedef struct {
     unsigned char x[8];
} buf_t;
void f(buf_t *buf, uint64_t y, uint64_t z) {
     if (z > 8) z = 8;
     unsigned char *y_bytes = (unsigned char *)&y;
     for (int i = 0; i < z; ++i) {
         buf->x[i] = y_bytes[i];
     }
}
$ clang -c test.c
$ objdump -d test.o <==== gcc binutils based objdump

test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <f>:
    0:   55                      push   %rbp
    1:   48 89 e5                mov    %rsp,%rbp
    4:   48 89 7d f8             mov    %rdi,-0x8(%rbp)
    8:   48 89 75 f0             mov    %rsi,-0x10(%rbp)
    c:   48 89 55 e8             mov    %rdx,-0x18(%rbp)
   10:   48 83 7d e8 08          cmpq   $0x8,-0x18(%rbp)
   15:   76 08                   jbe    1f <f+0x1f>
   17:   48 c7 45 e8 08 00 00    movq   $0x8,-0x18(%rbp)
   1e:   00
   1f:   48 8d 45 f0             lea    -0x10(%rbp),%rax
   23:   48 89 45 e0             mov    %rax,-0x20(%rbp)
   27:   c7 45 dc 00 00 00 00    movl   $0x0,-0x24(%rbp)
   2e:   48 63 45 dc             movslq -0x24(%rbp),%rax
   32:   48 3b 45 e8             cmp    -0x18(%rbp),%rax
   36:   73 21                   jae    59 <f+0x59>
   38:   48 8b 45 e0             mov    -0x20(%rbp),%rax
   3c:   48 63 4d dc             movslq -0x24(%rbp),%rcx
   40:   8a 14 08                mov    (%rax,%rcx,1),%dl
   43:   48 8b 45 f8             mov    -0x8(%rbp),%rax
   47:   48 63 4d dc             movslq -0x24(%rbp),%rcx
   4b:   88 14 08                mov    %dl,(%rax,%rcx,1)
   4e:   8b 45 dc                mov    -0x24(%rbp),%eax
   51:   83 c0 01                add    $0x1,%eax
   54:   89 45 dc                mov    %eax,-0x24(%rbp)
   57:   eb d5                   jmp    2e <f+0x2e>
   59:   5d                      pop    %rbp
   5a:   c3                      ret

$ llvm-objdump -d test.o  <== clang based objdump

test.o: file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <f>:
        0: 55                            pushq   %rbp
        1: 48 89 e5                      movq    %rsp, %rbp
        4: 48 89 7d f8                   movq    %rdi, -0x8(%rbp)
        8: 48 89 75 f0                   movq    %rsi, -0x10(%rbp)
        c: 48 89 55 e8                   movq    %rdx, -0x18(%rbp)
       10: 48 83 7d e8 08                cmpq    $0x8, -0x18(%rbp)
       15: 76 08                         jbe     0x1f <f+0x1f>
       17: 48 c7 45 e8 08 00 00 00       movq    $0x8, -0x18(%rbp)
       1f: 48 8d 45 f0                   leaq    -0x10(%rbp), %rax
       23: 48 89 45 e0                   movq    %rax, -0x20(%rbp)
       27: c7 45 dc 00 00 00 00          movl    $0x0, -0x24(%rbp)
       2e: 48 63 45 dc                   movslq  -0x24(%rbp), %rax
       32: 48 3b 45 e8                   cmpq    -0x18(%rbp), %rax
       36: 73 21                         jae     0x59 <f+0x59>
       38: 48 8b 45 e0                   movq    -0x20(%rbp), %rax
       3c: 48 63 4d dc                   movslq  -0x24(%rbp), %rcx
       40: 8a 14 08                      movb    (%rax,%rcx), %dl
       43: 48 8b 45 f8                   movq    -0x8(%rbp), %rax
       47: 48 63 4d dc                   movslq  -0x24(%rbp), %rcx
       4b: 88 14 08                      movb    %dl, (%rax,%rcx)
       4e: 8b 45 dc                      movl    -0x24(%rbp), %eax
       51: 83 c0 01                      addl    $0x1, %eax
       54: 89 45 dc                      movl    %eax, -0x24(%rbp)
       57: eb d5                         jmp     0x2e <f+0x2e>
       59: 5d                            popq    %rbp
       5a: c3                            retq

There are some differences like constant representation, e.g. jump offset hex number,
gcc does not have '0x' prefix while clang has. Insn at 4b is also difference.
But overall the difference is smaller.

> dependency to test_progs, option (b) is the best. If folks on the
> mailing list agree with this, I can work on updating the patches.
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
>
> Thanks,
> Eduard

