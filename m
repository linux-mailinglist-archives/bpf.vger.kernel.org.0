Return-Path: <bpf+bounces-36945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668094F85B
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 22:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB381F22B73
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1BC194A68;
	Mon, 12 Aug 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eLDtahEl"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458E194143
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495347; cv=none; b=LftiozJMALdz4p1rBe2VzUPz0wvkHh1ihwWhsv+YyC4qx6tXVM+sVpUE306l/yAfkC9l6XKTPhpJpApk5ALdY4xRi/322OvG9VBxrF4vSk3nc6L9ZfHB5RRZXIxNletFHQ2bqQvMYjEXXvk2QZxw+GxdSk2KYQIbVYLqv5JzLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495347; c=relaxed/simple;
	bh=AJgVTWdjQFmZuUxNFJEMTC+EwPKWkWmyu2hLSbnNGfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL6X4X7NB77SJi+yfznNd2AKEGPQpY2avUIHHY1CKcTgImwZtfFs16A+SPDtIqJRRu+mVnAAYzWIV/nEMe2n2vHHYwIyU/E7pyHEC4tVnDlpLVj67vJKWCFYMggkuHafiaK8+z28QwUDc6vzcb/luKQtVwXnIG7EK3wdYZrvd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eLDtahEl; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b941f53-2a05-48ec-9032-8f106face3a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723495343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6KVg5423rXzVJvDTpuPiHZT0EenMuLXSSobvv6VNqI=;
	b=eLDtahElfuj/bZ9JOJTVvqqWSyNl8XG9oMHNQTP/Y6QBErYO/rZNvijzmOwZHNxeUUsYiH
	3dgwxZrOki3xWPfvm3Zk/vAbD1n799gPIy0TOYzJIJWQhekr/L1EkjUeCENZny1kAy5Z0D
	vmNu57MGw9NJVvjFwewtXMRmUEDwpcw=
Date: Mon, 12 Aug 2024 13:42:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix arena_atomics selftest
 failure due to llvm change
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240803025928.4184433-1-yonghong.song@linux.dev>
 <CAADnVQKt8FQjuZKFTGbyf5uKGZ8gfjzSvC36CbZ7ENbkuCmopA@mail.gmail.com>
 <e42a26b6-1520-40b9-850a-28d660bd9149@linux.dev> <87cymmqmry.fsf@oracle.com>
 <6f32c0a1-9de2-4145-92ea-be025362182f@linux.dev>
 <CAADnVQ+gxrq5O2N168xYZa3UGWx_kNyPQihFPt=FLC56j9KOnA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+gxrq5O2N168xYZa3UGWx_kNyPQihFPt=FLC56j9KOnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/8/24 9:26 AM, Alexei Starovoitov wrote:
> On Mon, Aug 5, 2024 at 10:26 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>>> Maybe we could special process the above to generate
>>>> a locked insn if
>>>>     - atomicrmw operator
>>>>     - monotonic (related) consistency
>>>>     - return value is not used
> This sounds like a good idea, but...
>
>>>> So this will not violate original program semantics.
>>>> Does this sound a reasonable apporach?
>>> Whether monotonic consistency is desired (ordered writes) can be
>>> probably deduced from the memory_order_* flag of the built-ins, but I
>>> don't know what atomiccrmw is...  what is it in non-llvm terms?
>> The llvm language reference for atomicrmw:
>>
>>     https://llvm.org/docs/LangRef.html#atomicrmw-instruction
> I read it back and forth, but couldn't find whether it's ok
> for the backend to use stronger ordering insn when weaker ordering
> is specified in atomicrmw.
> It's probably ok.
> Otherwise atomicrmw with monotnic (memory_order_relaxed) and
> return value is used cannot be mapped to any bpf insn.
> x86 doesn't have monotonic either, but I suspect the backend
> still generates the code without any warnings.

I did a little bit experiment for x86,

$ cat t.c
int foo;
void bar1(void) {
         __sync_fetch_and_add(&foo, 10);
}
int bar2(void) {
         return __sync_fetch_and_add(&foo, 10);
}
$ clang -O2 -I. -c t.c && llvm-objdump -d t.o

t.o:    file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <bar1>:
        0: f0                            lock
        1: 83 05 00 00 00 00 0a          addl    $0xa, (%rip)            # 0x8 <bar1+0x8>
        8: c3                            retq
        9: 0f 1f 80 00 00 00 00          nopl    (%rax)
         
0000000000000010 <bar2>:
       10: b8 0a 00 00 00                movl    $0xa, %eax
       15: f0                            lock
       16: 0f c1 05 00 00 00 00          xaddl   %eax, (%rip)            # 0x1d <bar2+0xd>
       1d: c3                            retq

So without return value, __sync_fetch_and_add will generated locked add insn.
With return value, 'lock xaddl' is used which should be similar to bpf atomic_fetch_add.

Another example,

$ cat t1.c
#include <stdatomic.h>

void f1(_Atomic int *i) {
   __c11_atomic_fetch_and(i, 10, memory_order_relaxed);
}

void f2(_Atomic int *i) {
   __c11_atomic_fetch_and(i, 10, memory_order_seq_cst);
}

void f3(_Atomic int *i) {
   __c11_atomic_fetch_and(i, 10, memory_order_release);
}

_Atomic int f4(_Atomic int *i) {
   return __c11_atomic_fetch_and(i, 10, memory_order_release);
}
$ clang -O2 -I. -c t1.c && llvm-objdump -d t1.o

t1.o:   file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <f1>:
        0: f0                            lock
        1: 83 27 0a                      andl    $0xa, (%rdi)
        4: c3                            retq
        5: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)

0000000000000010 <f2>:
       10: f0                            lock
       11: 83 27 0a                      andl    $0xa, (%rdi)
       14: c3                            retq
       15: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)

0000000000000020 <f3>:
       20: f0                            lock
       21: 83 27 0a                      andl    $0xa, (%rdi)
       24: c3                            retq
       25: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)

0000000000000030 <f4>:
       30: 8b 07                         movl    (%rdi), %eax
       32: 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00     nopw    %cs:(%rax,%rax)
       40: 89 c1                         movl    %eax, %ecx
       42: 83 e1 0a                      andl    $0xa, %ecx
       45: f0                            lock
       46: 0f b1 0f                      cmpxchgl        %ecx, (%rdi)
       49: 75 f5                         jne     0x40 <f4+0x10>
       4b: c3                            retq
$

In all cases without return value, for x86, 'lock andl' insn is generated
regardless of the memory order constraint. This is similar to
what we had before.

Although previous 'lock' encoding matches to x86 nicely.
But for ARM64 and for 'lock ...' bpf insn,
the generated insn won't have a barrier (acquire or release or both)
semantics. So I guess that ARM64 wants to preserve the current hehavior:
   - for 'lock ...' insn, no barrier,
   - for 'atomic_fetch_add ...' insn, proper barrier.

For x86, for both 'lock ...' and 'atomic_fetch_add ...' will have proper barrier.

To keep 'lock ...' no-barrier required, user needs to specify
memory_order_relaxed constraint. This will permit bpf backend
to generate 'lock ...' insn.

Looks like x86 does check memory_order_relaxed to do some
special processing:

X86CompressEVEX.cpp:  if (!TableChecked.load(std::memory_order_relaxed)) {
X86CompressEVEX.cpp:    TableChecked.store(true, std::memory_order_relaxed);
X86FloatingPoint.cpp:    if (!TABLE##Checked.load(std::memory_order_relaxed)) {                     \
X86FloatingPoint.cpp:      TABLE##Checked.store(true, std::memory_order_relaxed);                   \
X86InstrFMA3Info.cpp:  if (!TableChecked.load(std::memory_order_relaxed)) {
X86InstrFMA3Info.cpp:    TableChecked.store(true, std::memory_order_relaxed);
X86InstrFoldTables.cpp:  if (!FoldTablesChecked.load(std::memory_order_relaxed)) {
X86InstrFoldTables.cpp:    FoldTablesChecked.store(true, std::memory_order_relaxed);

So I guess that bpf can do similar thing to check memory_order_relaxed in IR
and may generate different (more efficient insns) as needed.

> Would be good to clarify before we proceed with the above plan.

