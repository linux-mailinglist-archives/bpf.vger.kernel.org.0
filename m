Return-Path: <bpf+bounces-66730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232B9B38B9B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1541893F62
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF8A302767;
	Wed, 27 Aug 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s72A5Fbc"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDD23D7F8
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331212; cv=none; b=IrQoDt0NMIvB4CPfTmBxsZsXQBCmr6Ub7XRZ1XM7EVFttroOEXcPcLdoXGqTJko65qC+bRD/V35C82IvAvIgUG3uQ5wEffkLGwW1/HP2g4wqzY+8GGQWJPfm0XxnOgntpeRyS2F/KIL9EZPSwDGBSPxra9EwhHJSsDLQdOinLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331212; c=relaxed/simple;
	bh=AUn/m64B/v2N4BjG3uSpNqy5RwHEm00XLqBa6Vi0wIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LovevjtAHd+tZR15HgDo8AqZ9AVwPt03Q6uXhGUya+For5Ww2oAqP7N5if0OQ0qHB4++JTANpJe86BfCzWTlbeuhWL7RaTlqG9D9pL6WK/qK6bwVxOhwpBoD/2t2QfPcqNe9vrowum5lFaXcNPPpIPtYDhzMmgjHKacAxkmjjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s72A5Fbc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4da12baa-7211-4d9e-bbf1-f2eee9097efc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756331203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TUksHtwVQV0t16IcgMpjaM5T4+a/mC3Gl2IGMQ8Dgw=;
	b=s72A5FbcO7rR/h3Ge/6LqEOO9+RqU1yFQ7V2a2vQrmww6xCwg382AAIQD7GPbsg0ljoSxp
	Fq1H2CFLP2UJ0GvP4vyXuHDclyj5crVYUIdnIpglDTd/Dpi1AmfZnyVxYjJbfRjdAFpK/v
	uAVZI6yFTT/t5KSaijL5SDgmZLHC+BI=
Date: Wed, 27 Aug 2025 14:46:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Fix "expression result
 unused" warnings with icecc
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250827194929.416969-1-iii@linux.ibm.com>
 <20250827194929.416969-3-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250827194929.416969-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/27/25 12:46 PM, Ilya Leoshkevich wrote:
> icecc is a compiler wrapper that distributes compile jobs over a build
> farm [1]. It works by sending toolchain binaries and preprocessed
> source code to remote machines.
>
> Unfortunately using it with BPF selftests causes build failures due to
> a clang bug [2]. The problem is that clang suppresses the
> -Wunused-value warning if the unused expression comes from a macro
> expansion. Since icecc compiles preprocessed source code, this
> information is not available. This leads to -Wunused-value false
> positives.
>
> arena_spin_lock_slowpath() uses two macros that produce values and
> ignores the results. Add (void) cast to explicitly indicate that this
> is intentional and suppress the warning.
>
> An alternative solution is to change the macros to not produce values.
> This would work today, but in the future there may appear users who
> need them. Another potential solution is to replace these macros with
> functions. Unfortunately this would not work, because these macros
> work with unknown types and control flow.
>
> [1] https://github.com/icecc/icecream
> [2] https://github.com/llvm/llvm-project/issues/142614

As you described in [1] and [2]. The failure is due to the compilation from .i file to .o file.

$ cat run2.sh
echo '.c -> .i -> .o'
clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -std=gnu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types -idirafter /home/yhs/work/llvm-project/llvm/build.21/Release/lib/clang/21/include -idirafter /usr/local/include -idirafter /usr/include    -DENABLE_ATOMICS_TESTS   -O2 --target=bpfel -E progs/arena_spin_lock.c -mcpu=v4 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/arena_spin_lock.i
clang  -g -Wall -Werror -mlittle-endian -std=gnu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types -O2 --target=bpfel -c arena_spin_lock.i -mcpu=v4 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/cpuv4/arena_spin_lock.bpf.o

echo '.c -> .o'
clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -std=gnu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types -idirafter /home/yhs/work/llvm-project/llvm/build.21/Release/lib/clang/21/include -idirafter /usr/local/include -idirafter /usr/include    -DENABLE_ATOMICS_TESTS   -O2 --target=bpfel -c progs/arena_spin_lock.c -mcpu=v4 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/cpuv4/arena_spin_lock.bpf.o

$ ./run2.sh
.c -> .i -> .o
In file included from progs/arena_spin_lock.c:7:
progs/bpf_arena_spin_lock.h:305:1765: error: expression result unused [-Werror,-Wunused-value]
   305 |   ...unsigned long __val; __sync_fetch_and_add(&__val, 0); }); else asm volatile("" ::: "memory"); }); }); (typeof(*(&lock->locked)))__val; });
       |                                                                                                            ^                         ~~~~~
progs/bpf_arena_spin_lock.h:383:1769: error: expression result unused [-Werror,-Wunused-value]
   383 |   ...unsigned long __val; __sync_fetch_and_add(&__val, 0); }); else asm volatile("" ::: "memory"); }); }); (typeof(*(&node->locked)))__val; });
       |                                                                                                            ^                         ~~~~~
2 errors generated.
.c -> .o
$

I am not sure whether we should do anything with pahole or libbpf. Essentially this is a clang
bug. We should push clang community to fix the problem.

>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> index d67466c1ff77..f90531cf3ee5 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> @@ -302,7 +302,7 @@ int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val
>   	 * barriers.
>   	 */
>   	if (val & _Q_LOCKED_MASK)
> -		smp_cond_load_acquire_label(&lock->locked, !VAL, release_err);
> +		(void)smp_cond_load_acquire_label(&lock->locked, !VAL, release_err);
>   
>   	/*
>   	 * take ownership and clear the pending bit.
> @@ -380,7 +380,7 @@ int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val
>   		/* Link @node into the waitqueue. */
>   		WRITE_ONCE(prev->next, node);
>   
> -		arch_mcs_spin_lock_contended_label(&node->locked, release_node_err);
> +		(void)arch_mcs_spin_lock_contended_label(&node->locked, release_node_err);
>   
>   		/*
>   		 * While waiting for the MCS lock, the next pointer may have


