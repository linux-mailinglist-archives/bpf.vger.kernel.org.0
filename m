Return-Path: <bpf+bounces-16110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922DF7FCE86
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485402834C0
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E77475;
	Wed, 29 Nov 2023 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwcwU+SM"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43C171D
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 21:51:09 -0800 (PST)
Message-ID: <3733942b-f0ef-4e71-8c49-aa4177e9433c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701237066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1uxQwDCw64wpxEyKcQROxpbXzbH6eGgkDgc1MBL+ZA=;
	b=FwcwU+SM/UdE7hlPfbd+MBz81fbxGWSqGUFhhfv2PazuN50L4UoC8WzugJiLmYCkOHqH/U
	rFxdUc6E8fHhw9OHxW47UOBJ/vBXFlZCIGt6MUUhNy4CSiAkd8mDU0Ji64b8JVjgxpPIcp
	goyK0aTD6f52pMho7W0siTKsYJyBuqQ=
Date: Tue, 28 Nov 2023 21:50:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF GCC status - Nov 2023
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
References: <87leahx2xh.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87leahx2xh.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/28/23 11:23 AM, Jose E. Marchesi wrote:
> [During LPC 2023 we talked about improving communication between the GCC
>   BPF toolchain port and the kernel side.  This is the first periodical
>   report that we plan to publish in the GCC wiki and send to interested
>   parties.  Hopefully this will help.]
>
> GCC wiki page for the port: https://gcc.gnu.org/wiki/BPFBackEnd
> IRC channel: #gccbpf at irc.oftc.net.
> Help on using the port: gcc@gcc.gnu.org
> Patches and/or development discussions: gcc-patches@gnu.org

Thanks a lot for detailed report. Really helpful to nail down
issues facing one or both compilers. See comments below for
some mentioned issues.

>
> Assembler
> =========

[...]

> - In the Pseudo-C syntax register names are not preceded by % characters
>    nor any other prefix.  A consequence of that is that in contexts like
>    instruction operands, where both register names and expressions
>    involving symbols are expected, there is no way to disambiguate
>    between them.  GAS was allowing symbols like `w3' or `r5' in syntactic
>    contexts where no registers were expected, such as in:
>
>      r0 = w3 ll  ; GAS interpreted w3 as symbol, clang emits error
>
>    The clang assembler wasn't allowing that.  During LPC we agreed that
>    the simplest approach is to not allow any symbol to have the same name
>    than a register, in any context.  So we changed GAS so it now doesn't
>    allow to use register names as symbols in any expression, such as:
>
>      r0 = w3 + 1 ll  ; This now fails for both GAS and llvm.
>      r0 = 1 + w3 ll  ; NOTE this does not fail with llvm, but it should.

Could you provide a reproducible case above for llvm? llvm does not
support syntax like 'r0 = 1 + w3 ll'. For add, it only supports
'r1 += r2' or 'r1 += 100' syntax.

>
>    We installed a patch in GAS for this.
>    Jose E. Marchesi
>    https://sourceware.org/pipermail/binutils/2023-November/130684.html
>
>
> Pending Patches for bpf-next
> ============================
>
>
> - bpf: avoid VLAs in progs/test_xdp_dynptr.c
>
>    In the progs/test_xdp_dynptr.c there are a bunch of VLAs in the
>    handle_ipv4 and handle_ipv6 functions:
>
>      const size_t tcphdr_sz = sizeof(struct tcphdr);
>      const size_t udphdr_sz = sizeof(struct udphdr);
>      const size_t ethhdr_sz = sizeof(struct ethhdr);
>      const size_t iphdr_sz = sizeof(struct iphdr);
>      const size_t ipv6hdr_sz = sizeof(struct ipv6hdr);
>      
>      [...]
>      
>      static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
>      {
> 	__u8 eth_buffer[ethhdr_sz + ipv6hdr_sz + ethhdr_sz];
> 	__u8 ip6h_buffer_tcp[ipv6hdr_sz + tcphdr_sz];
> 	__u8 ip6h_buffer_udp[ipv6hdr_sz + udphdr_sz];
>    	[...]
>      }
>      
>      static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
>      {
>    	__u8 eth_buffer[ethhdr_sz + ipv6hdr_sz + ethhdr_sz];
> 	__u8 ip6h_buffer_tcp[ipv6hdr_sz + tcphdr_sz];
> 	__u8 ip6h_buffer_udp[ipv6hdr_sz + udphdr_sz];
> 	[...]
>      }
>
>    In both GCC and clang we are not allowing dynamic stack allocation (we
>    used to support it in GCC using one register as an auxiliary stack
>    pointer, but not any longer).
>
>    The above code builds with clang but not with GCC:
>
>      progs/test_xdp_dynptr.c:79:14: error: BPF does not support dynamic stack allocation
>         79 |         __u8 eth_buffer[ethhdr_sz + iphdr_sz + ethhdr_sz];
>            |              ^~~~~~~~~~
>
>    We are guessing that clang turns these arrays from VLAs into normal
>    statically sized arrays because ethhdr_sz and friends are constant and
>    set to sizeof, which is always known at compile time.  This patch
>    changes the selftest to use preprocessor constants instead of
>    variables:
>
>      #define tcphdr_sz sizeof(struct tcphdr)
>      #define udphdr_sz sizeof(struct udphdr)
>      #define ethhdr_sz sizeof(struct ethhdr)
>      #define iphdr_sz sizeof(struct iphdr)
>      #define ipv6hdr_sz sizeof(struct ipv6hdr)

Indeed, clang frontend (before generating IR) did some optimization
and calculates the real array size and that is why dynamic stack
allocation didn't happen. Since this is an optimizaiton, there is
no guarantee that frontend is able to calculate the precise
array size in all cases. See llvm patch https://reviews.llvm.org/D111897.

So your above change looks good to me.

>
> - bpf_helpers.h: define bpf_tail_call_static when building with GCC
>
> - bpf: fix constraint in test_tcpbpf_kern.c
>
>    GCC emits a warning:
>
>      progs/test_tcpbpf_kern.c:60:9: error: ‘op’ is used uninitialized [-Werror=uninitialized]
>
>    when the uninitialized automatic `op' is used with a "+r" constraint
>    in:
>
> 	asm volatile (
> 		"%[op] = *(u32 *)(%[skops] +96)"
> 		: [op] "+r"(op)
> 		: [skops] "r"(skops)
> 		:);
>
>    The constraint shall be "=r" instead.

We may miss an error case like above in llvm. Will double check.

>
>
> Open Questions
> ==============
>
> - BPF programs including libc headers.
>
>    BPF programs run on their own without an operating system or a C
>    library.  Implementing C implies providing certain definitions and
>    headers, such as stdint.h and stdarg.h.  For such targets, known as
>    "bare metal targets", the compiler has to provide these definitions
>    and headers in order to implement the language.
>
>    GCC provides the following C headers for BPF targets:
>
>      float.h
>      gcov.h
>      iso646.h
>      limits.h
>      stdalign.h
>      stdarg.h
>      stdatomic.h
>      stdbool.h
>      stdckdint.h
>      stddef.h
>      stdfix.h
>      stdint.h
>      stdnoreturn.h
>      syslimits.h
>      tgmath.h
>      unwind.h
>      varargs.h
>
>    However, we have found that there is at least one BPF kernel self test
>    that include glibc headers that, indirectly, include glibc's own
>    definitions of stdint.h and friends.  This leads to compile-time
>    errors due to conflicting types.  We think that including headers from
>    a glibc built for some host target is very questionable.  For example,
>    in BPF a C `char' is defined to be signed.  But if a BPF program
>    includes glibc headers in an android system, that code will assume an
>    unsigned char instead.

Currently clang side does not have compiler side bpf specific header so
we do not have this issues. We do encourage users to use vmlinux.h, e.g.,
for tracing programs, or for all kinds of programs using kfunc's
where parameters likely being kernel structures. In the future, kfunc
definitions are likely to be included in vmlinux.h itself.
For selftests, we also slowly move to vmlinux.h.


