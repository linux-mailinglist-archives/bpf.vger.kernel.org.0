Return-Path: <bpf+bounces-46960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF289F1A4E
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57C3188C5F0
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B721C3C0D;
	Fri, 13 Dec 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtbDPPlZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D067190696;
	Fri, 13 Dec 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734133911; cv=none; b=aoKa6lLC+oR3L6A5RRs4FBjKlGvfpRw9Z9+hhRBo4jSK6w5NmsQbt3yYeVP3r8KyvM+owPYilb69+3ySytDtmkm+WXeCjU83VZxKOVNX2BbfSWSd45PNRrQMNzlwGdEvgNuLgQE594rmlV7fESaYegM7uMemchqv+N3E/6Jmvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734133911; c=relaxed/simple;
	bh=LBl8bC14OQtqtIKs1HukcWT3y7YKXmSmDiIE/yMGSmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBYWL5kWj3xp5ZRKeIHO56165wo624WY1G1og1YY5K8amLkpLilhC8KlyWifHYvnwn1At5RkBY+9sJXuE7ku8O/wJK1bnpY67m59oVVFijrZiNad3e6GT1V/LKf0BaBNOjxkWnhp0w1oxMpop2TwrGY6fh2uKxEUZ0qjYc5WGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtbDPPlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94490C4CED0;
	Fri, 13 Dec 2024 23:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734133910;
	bh=LBl8bC14OQtqtIKs1HukcWT3y7YKXmSmDiIE/yMGSmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtbDPPlZbvqi8CN6Oxf/cp0n+oSr7ObvLvF/U2VDgAChn1LmY9vPTTrZPXt16xhat
	 inbTnXZlRscl4snJJ6UgFlEeSj8INrtWj3w+kY5Zw6Xwg/PSii2l0HnKE9BmyS9OVT
	 8N0rE6al1xzB6jamo6faQdVxRpqtjSmRmiAwfcJhnFdx0fBBSN910Mi1qMJ5n+kktQ
	 5hNIUPaZXmQiXX9jVYYu5/7CRPAvUoy2K6AFHWYU/z5bFe44BQV9tOCZxs16Vn8N4x
	 pKammezScSiU7mB84NioErtAEA5PzW9kkj2h4m+pmdJm0TyG9CjJqpZAVG7w4/b+7Y
	 1sa1Hb94hlvOw==
Date: Fri, 13 Dec 2024 15:51:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/16] perf tools: arc: Support generic syscall headers
Message-ID: <Z1zIlKq19lAXMoGs@google.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
 <20241212-perf_syscalltbl-v2-2-f8ca984ffe40@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-perf_syscalltbl-v2-2-f8ca984ffe40@rivosinc.com>

On Thu, Dec 12, 2024 at 04:32:52PM -0800, Charlie Jenkins wrote:
> Arc uses the generic syscall table, use that in perf instead of
> requiring libaudit.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/perf/Makefile.config                           | 2 +-
>  tools/perf/Makefile.perf                             | 2 +-
>  tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
>  tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
>  tools/perf/arch/arc/include/syscall_table.h          | 2 ++
>  5 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a72f25162714f0117a88d94474da336814d4f030..3959a9c9972999f6d1bb85e8c1d7dc5dce92fd09 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
>    endif
>  
>    # architectures that use the generic syscall table scripts
> -  ifeq ($(SRCARCH),riscv)
> +  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))

This might work as well.

  ifneq ($(filter $(SRCARCH), riscv arc),)

And maybe you can add a variable for supported archs.

Thanks,
Namhyung


>      NO_SYSCALL_TABLE := 0
>      CFLAGS += -DGENERIC_SYSCALL_TABLE
>      CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f5278ed9f778f928436693a14e016c5c3c5171c1..3b463b42b0e3982e74056e672b2ee6adad5a3f0e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -311,7 +311,7 @@ FEATURE_TESTS := all
>  endif
>  endif
>  # architectures that use the generic syscall table
> -ifeq ($(SRCARCH),riscv)
> +ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
>  include $(srctree)/tools/perf/scripts/Makefile.syscalls
>  endif
>  include Makefile.config
> diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
> new file mode 100644
> index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
> --- /dev/null
> +++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +syscall-y += syscalls_32.h
> diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> new file mode 100644
> index 0000000000000000000000000000000000000000..391d30ab7a831b72d2ed3f2e7966fdbf558a9ed7
> --- /dev/null
> +++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +syscall_abis_32 += arc time32 renameat stat64 rlimit
> diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
> --- /dev/null
> +++ b/tools/perf/arch/arc/include/syscall_table.h
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm/syscalls_32.h>
> 
> -- 
> 2.34.1
> 

