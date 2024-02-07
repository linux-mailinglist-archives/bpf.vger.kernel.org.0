Return-Path: <bpf+bounces-21438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7D384D589
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EB728D8D3
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7B13A245;
	Wed,  7 Feb 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LfMxprkS"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C113A24C
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342310; cv=none; b=kD6KHy/P/GdMqvr2pu/EWzWtOs9O2Nvx+HggpOo3AJyf7Axc9sYbYmeVAwLQqC308wDR2zEaOMNItQ9RDDmPei52NHzA2cck09T4AcWTDkZ9Cl5zT+EvZlxHL5ByAwWpehC+6aeLn8JU9Nss8a55in0opDmXLmOq7GCub0UEISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342310; c=relaxed/simple;
	bh=CvyJmK4JAWQsKB+2qLcuYCn46BxZq/XJ4RGBqcviFIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/17f7KoVV4uiPBpGcilJne34AnVaipr5AUBynfxO58Hl46GOKNQwGPSTFUMVdgX1uk+vy+dWU7mRvs6uzaE1QfIDIqPy9lmzr71s1X/IIUIRjx0u0r4x0PIr/mUW1sEf9+HO3gbyKcTii3+NZMo3YIel83Zx/2XlUbN0LBjn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LfMxprkS; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707342305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1QwaBrfjHSxe1UdCmYbyo+imh6aoD7PXD1l8mXJi0g=;
	b=LfMxprkS96Ni3drEPTnD17TlBM8kbprAE9Ms1Ks8tCRUOct/NjmMAbucQpvfJ3jBByoptx
	lVIkuOCZ1IyDrz2xTBYk94ULs3elo8I/yJul/R6b15Ype+kbIQyDDqcSGCdWDPcZge6Az7
	9O2Cz6bUjsMPgiRruNtnC6/vLNTASus=
Date: Wed, 7 Feb 2024 13:45:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, david.faust@oracle.com,
 cupertino.miranda@oracle.com
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240207101253.11420-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/7/24 2:12 AM, Jose E. Marchesi wrote:
> Some BPF tests use loop unrolling compiler pragmas that are clang
> specific and not supported by GCC.  These pragmas, along with their
> GCC equivalences are:
>
>    #pragma clang loop unroll_count(N)
>    #pragma GCC unroll N
>
>    #pragma clang loop unroll(full)
>    #pragma GCC unroll 65534
>
>    #pragma clang loop unroll(disable)
>    #pragma GCC unroll 1
>
>    #pragma unroll [aka #pragma clang loop unroll(enable)]
>    There is no GCC equivalence, and it seems to me that this clang
>    pragma may be only useful when building without -funroll-loops to
>    enable the optimization in particular loops.  In GCC -funroll-loops
>    is enabled with -O2 and higher.  If this is also true in clang,
>    perhaps these pragmas in selftests are redundant?

You are right, at -O2 level, loop unrolling is enabled by default.
So I think '#pragma unroll' can be removed since gcc also has
loop unrolling enabled by default at -O2.

Your patch has a conflict with latest bpf-next. Please rebase it
on top of bpf-next, remove '#pragma unroll' support and resubmit.
Thanks!

>
> This patch adds a new header progs/bpf_compiler.h that defines the
> following macros, which correspond to each pair of compiler-specific
> pragmas above:
>
>    __pragma_loop_unroll_count(N)
>    __pragma_loop_unroll_full
>    __pragma_loop_no_unroll
>    __pragma_loop_unroll
>
> The selftests using loop unrolling pragmas are then changed to include
> the header and use these macros in place of the explicit pragmas.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---
>   .../selftests/bpf/progs/bpf_compiler.h        | 33 +++++++++++++++++++
>   tools/testing/selftests/bpf/progs/iters.c     |  5 +--
>   tools/testing/selftests/bpf/progs/loop4.c     |  4 ++-
>   .../selftests/bpf/progs/profiler.inc.h        | 17 +++++-----
>   tools/testing/selftests/bpf/progs/pyperf.h    |  7 ++--
>   .../testing/selftests/bpf/progs/strobemeta.h  | 18 +++++-----
>   .../selftests/bpf/progs/test_cls_redirect.c   |  5 +--
>   .../selftests/bpf/progs/test_lwt_seg6local.c  |  6 ++--
>   .../selftests/bpf/progs/test_seg6_loop.c      |  4 ++-
>   .../selftests/bpf/progs/test_skb_ctx.c        |  4 ++-
>   .../selftests/bpf/progs/test_sysctl_loop1.c   |  6 ++--
>   .../selftests/bpf/progs/test_sysctl_loop2.c   |  6 ++--
>   .../selftests/bpf/progs/test_sysctl_prog.c    |  6 ++--
>   .../selftests/bpf/progs/test_tc_tunnel.c      |  4 ++-
>   tools/testing/selftests/bpf/progs/test_xdp.c  |  3 +-
>   .../selftests/bpf/progs/test_xdp_loop.c       |  3 +-
>   .../selftests/bpf/progs/test_xdp_noinline.c   |  5 +--
>   .../selftests/bpf/progs/xdp_synproxy_kern.c   |  6 ++--
>   .../testing/selftests/bpf/progs/xdping_kern.c |  3 +-
>   19 files changed, 103 insertions(+), 42 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_compiler.h
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_compiler.h b/tools/testing/selftests/bpf/progs/bpf_compiler.h
> new file mode 100644
> index 000000000000..a7c343dc82e6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_compiler.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __BPF_COMPILER_H__
> +#define __BPF_COMPILER_H__
> +
> +#define DO_PRAGMA_(X) _Pragma(#X)
> +
> +#if __clang__
> +#define __pragma_loop_unroll DO_PRAGMA_(clang loop unroll(enable))
> +#else
> +/* In GCC -funroll-loops, which is enabled with -O2, should have the
> +   same impact than the loop-unroll-enable pragma above.  */
> +#define __pragma_loop_unroll
> +#endif
> +
> +#if __clang__
> +#define __pragma_loop_unroll_count(N) DO_PRAGMA_(clang loop unroll_count(N))
> +#else
> +#define __pragma_loop_unroll_count(N) DO_PRAGMA_(GCC unroll N)
> +#endif
> +
> +#if __clang__
> +#define __pragma_loop_unroll_full DO_PRAGMA_(clang loop unroll(full))
> +#else
> +#define __pragma_loop_unroll_full DO_PRAGMA_(GCC unroll 65534)
> +#endif
> +
> +#if __clang__
> +#define __pragma_loop_no_unroll DO_PRAGMA_(clang loop unroll(disable))
> +#else
> +#define __pragma_loop_no_unroll DO_PRAGMA_(GCC unroll 1)
> +#endif
> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
> index 225f02dd66d0..3db416606f2f 100644
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c
> @@ -5,6 +5,7 @@
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
> +#include "bpf_compiler.h"
>   
>   #define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
>   
> @@ -183,7 +184,7 @@ int iter_pragma_unroll_loop(const void *ctx)
>   	MY_PID_GUARD();
>   
>   	bpf_iter_num_new(&it, 0, 2);
> -#pragma nounroll
> +	__pragma_loop_no_unroll
>   	for (i = 0; i < 3; i++) {
>   		v = bpf_iter_num_next(&it);
>   		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
> @@ -238,7 +239,7 @@ int iter_multiple_sequential_loops(const void *ctx)
>   	bpf_iter_num_destroy(&it);
>   
>   	bpf_iter_num_new(&it, 0, 2);
> -#pragma nounroll
> +	__pragma_loop_no_unroll
>   	for (i = 0; i < 3; i++) {
>   		v = bpf_iter_num_next(&it);
>   		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);

[...]


