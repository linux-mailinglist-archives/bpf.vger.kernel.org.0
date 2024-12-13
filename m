Return-Path: <bpf+bounces-46944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE9B9F19D4
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2DB188D6BA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3661B87F9;
	Fri, 13 Dec 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jubRRjX+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B52E62B;
	Fri, 13 Dec 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132176; cv=none; b=jk0hnmWcOqO3dIqv6vsPIFCEtrkAImGv8vg9xehPwoMZlzdvjm2ijbiB4Z76Krf8CSFIG2DI+4bVYhhgnEaTo+75fGMQ/o7nK0XndN6/kHO919LN8W/OTy8jR8yZj3ivG/4AVBuVctTulg+fflXSXuMeUIpb6btb8Du0DRsHA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132176; c=relaxed/simple;
	bh=VGdzHQIi3fVgtagYbzv6Ua/Y+Cdp0udMv+eqeWy9bXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As1hBNfEr4Qa24v4N3GbOFDsAzQ8oDQmA6XQvGco/utYwDIMPPgLT1/AEG9T6Hz+6CLQ7XzkeqanvB4OsZ/DAE3ud7fSoxuGEed9GwWyOh+pHnlwKnh6qnNI+P+V2o0jd7ZuMkry6P12QNaXomLJvNQKsCL7iRTCr1DOOyFgr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jubRRjX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353EEC4CED0;
	Fri, 13 Dec 2024 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734132176;
	bh=VGdzHQIi3fVgtagYbzv6Ua/Y+Cdp0udMv+eqeWy9bXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jubRRjX+AKkzfqbkZzXRkcxswbL+z2aT8lM9vqwYGJhS8OBivPuLZfbQtqWHoMw5+
	 bXjSKS7gASj0tV738dhDH8ZK7uZC0/eRB/CA6Qpw5bvg5K1bQWc7ARtFPcPTO2rYHU
	 HA4+OKVlxjHCWOCAvSQn7SKnpXDb5qHg8j2JIA6A0Fq0q+vZG7gRjIjzqcjeaedXQX
	 zF/I+30UgrdwBOtPv4MlDhB5LOSqbfcauvM53kSSZi6IAhIxtruy9q/jQTNa/XLB4g
	 iIKtgUyGZsVg9KQ68LZhtqaCkSnkBIqHn5Du5hJ5eYG9d/NfswVAJa0TPE8F7Bnflc
	 i7aSiujMxgj0A==
Date: Fri, 13 Dec 2024 15:22:53 -0800
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
Subject: Re: [PATCH v2 01/16] perf tools: Create generic syscall table support
Message-ID: <Z1zBzTgEYXw1DbEL@google.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
 <20241212-perf_syscalltbl-v2-1-f8ca984ffe40@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212-perf_syscalltbl-v2-1-f8ca984ffe40@rivosinc.com>

Hello,

On Thu, Dec 12, 2024 at 04:32:51PM -0800, Charlie Jenkins wrote:
> Currently each architecture in perf independently generates syscall
> headers. Adapt the work that has gone into unifying syscall header
> implementations in the kernel to work with perf tools. Introduce this
> framework with riscv at first. riscv previously relied on libaudit, but
> with this change, perf tools for riscv no longer needs this external
> dependency.

Nice work!

> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/perf/Makefile.config                         |  11 +-
>  tools/perf/Makefile.perf                           |   4 +
>  tools/perf/arch/riscv/Makefile                     |  22 --
>  tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
>  .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
>  tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 ---
>  tools/perf/arch/riscv/include/syscall_table.h      |   8 +
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/scripts/Makefile.syscalls               |  60 +++
>  tools/perf/scripts/syscalltbl.sh                   |  86 +++++
>  tools/perf/util/syscalltbl.c                       |   8 +-
>  tools/scripts/syscall.tbl                          | 409 +++++++++++++++++++++
>  12 files changed, 585 insertions(+), 77 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 2916d59c88cd08b299202a48ddb42fa32aac04a6..a72f25162714f0117a88d94474da336814d4f030 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -35,6 +35,13 @@ ifneq ($(NO_SYSCALL_TABLE),1)
>      NO_SYSCALL_TABLE := 0
>    endif
>  
> +  # architectures that use the generic syscall table scripts
> +  ifeq ($(SRCARCH),riscv)
> +    NO_SYSCALL_TABLE := 0
> +    CFLAGS += -DGENERIC_SYSCALL_TABLE
> +    CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
> +  endif
> +
>    ifneq ($(NO_SYSCALL_TABLE),1)
>      CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
>    endif
> @@ -83,10 +90,6 @@ ifeq ($(ARCH),mips)
>    LIBUNWIND_LIBS = -lunwind -lunwind-mips
>  endif
>  
> -ifeq ($(ARCH),riscv)
> -  CFLAGS += -I$(OUTPUT)arch/riscv/include/generated
> -endif
> -
>  # So far there's only x86 and arm libdw unwind support merged in perf.
>  # Disable it on all other architectures in case libdw unwind
>  # support is detected in system. Add supported architectures
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d74241a151313bd09101aabb5d765a5a0a6efc84..f5278ed9f778f928436693a14e016c5c3c5171c1 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -310,6 +310,10 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
>  FEATURE_TESTS := all
>  endif
>  endif
> +# architectures that use the generic syscall table
> +ifeq ($(SRCARCH),riscv)
> +include $(srctree)/tools/perf/scripts/Makefile.syscalls
> +endif
>  include Makefile.config
>  endif
>  
> diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> index 18ad078000e2bba595f92efc5d97a63fdb83ef45..087e099fb453a9236db34878077a51f711881ce0 100644
> --- a/tools/perf/arch/riscv/Makefile
> +++ b/tools/perf/arch/riscv/Makefile
> @@ -1,25 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  PERF_HAVE_JITDUMP := 1
>  HAVE_KVM_STAT_SUPPORT := 1
> -
> -#
> -# Syscall table generation for perf
> -#
> -
> -out    := $(OUTPUT)arch/riscv/include/generated/asm
> -header := $(out)/syscalls.c
> -incpath := $(srctree)/tools
> -sysdef := $(srctree)/tools/arch/riscv/include/uapi/asm/unistd.h
> -sysprf := $(srctree)/tools/perf/arch/riscv/entry/syscalls/
> -systbl := $(sysprf)/mksyscalltbl
> -
> -# Create output directory if not already present
> -$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> -
> -$(header): $(sysdef) $(systbl)
> -	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
> -
> -clean::
> -	$(call QUIET_CLEAN, riscv) $(RM) $(header)
> -
> -archheaders: $(header)
> diff --git a/tools/perf/arch/riscv/entry/syscalls/Kbuild b/tools/perf/arch/riscv/entry/syscalls/Kbuild
> new file mode 100644
> index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
> --- /dev/null
> +++ b/tools/perf/arch/riscv/entry/syscalls/Kbuild
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +syscall-y += syscalls_64.h
> diff --git a/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> new file mode 100644
> index 0000000000000000000000000000000000000000..9668fd1faf60e828ed2786c2ee84739ac1f153fc
> --- /dev/null
> +++ b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +syscall_abis_32 += riscv memfd_secret
> +syscall_abis_64 += riscv rlimit memfd_secret
> diff --git a/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl b/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
> deleted file mode 100755
> index c59f5e852b97712a9a879b89e6ef6999ed4b6cd7..0000000000000000000000000000000000000000
> --- a/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Generate system call table for perf. Derived from
> -# powerpc script.
> -#
> -# Copyright IBM Corp. 2017
> -# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> -# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> -# Changed by: Kim Phillips <kim.phillips@arm.com>
> -# Changed by: Björn Töpel <bjorn@rivosinc.com>
> -
> -gcc=$1
> -hostcc=$2
> -incpath=$3
> -input=$4
> -
> -if ! test -r $input; then
> -	echo "Could not read input file" >&2
> -	exit 1
> -fi
> -
> -create_sc_table()
> -{
> -	local sc nr max_nr
> -
> -	while read sc nr; do
> -		printf "%s\n" "	[$nr] = \"$sc\","
> -		max_nr=$nr
> -	done
> -
> -	echo "#define SYSCALLTBL_RISCV_MAX_ID $max_nr"
> -}
> -
> -create_table()
> -{
> -	echo "#include \"$input\""
> -	echo "static const char *const syscalltbl_riscv[] = {"
> -	create_sc_table
> -	echo "};"
> -}
> -
> -$gcc -E -dM -x c -I $incpath/include/uapi $input \
> -	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
> -		sub("^#define __NR(3264)?_", "");
> -		print | "sort -k2 -n"}' \
> -	|create_table
> diff --git a/tools/perf/arch/riscv/include/syscall_table.h b/tools/perf/arch/riscv/include/syscall_table.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7ff51b783000d727ec48be960730b81ecdb05575
> --- /dev/null
> +++ b/tools/perf/arch/riscv/include/syscall_table.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm/bitsperlong.h>
> +
> +#if __BITS_PER_LONG == 64
> +#include <asm/syscalls_64.h>
> +#else
> +#include <asm/syscalls_32.h>
> +#endif
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index a05c1c105c51bf1bd18a59195220894598eb7461..692f48db810ccbef229e240db29261f0c60db632 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -71,6 +71,7 @@ FILES=(
>    "include/uapi/asm-generic/ioctls.h"
>    "include/uapi/asm-generic/mman-common.h"
>    "include/uapi/asm-generic/unistd.h"
> +  "scripts/syscall.tbl"
>  )
>  
>  declare -a SYNC_CHECK_FILES
> diff --git a/tools/perf/scripts/Makefile.syscalls b/tools/perf/scripts/Makefile.syscalls
> new file mode 100644
> index 0000000000000000000000000000000000000000..e2b0c4b513d5c42c8e9ac51a9ea774c34a1311b7
> --- /dev/null
> +++ b/tools/perf/scripts/Makefile.syscalls
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# This Makefile generates tools/perf/arch/$(SRCARCH)/include/generated/asm from
> +# the generic syscall table if that is supported by the architecture, otherwise
> +# from the architecture's defined syscall table.
> +
> +PHONY := all
> +all:
> +
> +obj := $(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated/asm
> +
> +syscall_abis_32  += common,32
> +syscall_abis_64  += common,64

Couldn't it be := instead of += ?


> +syscalltbl := $(srctree)/tools/scripts/syscall.tbl
> +
> +# let architectures override $(syscall_abis_%) and $(syscalltbl)
> +-include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Makefile.syscalls
> +include $(srctree)/scripts/Kbuild.include
> +-include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Kbuild
> +
> +systbl := $(srctree)/tools/perf/scripts/syscalltbl.sh
> +
> +syscall-y   := $(addprefix $(obj)/, $(syscall-y))
> +
> +# Remove stale wrappers when the corresponding files are removed from generic-y
> +old-headers := $(wildcard $(obj)/*.c)
> +unwanted    := $(filter-out $(syscall-y),$(old-headers))

Can you elaborate?  What's the stable wrappers?

I think syscall-y and old-headers have .h files but the wildcard above
is called for .c files?

Thanks,
Namhyung

> +
> +quiet_cmd_remove = REMOVE  $(unwanted)
> +      cmd_remove = rm -f $(unwanted)
> +
> +quiet_cmd_systbl = SYSTBL  $@
> +      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
> +		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
> +		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
> +		   $< $@
> +
> +all: $(syscall-y)
> +	$(if $(unwanted),$(call cmd,remove))
> +	@:
> +
> +$(obj)/syscalls_%.h: $(syscalltbl) $(systbl) FORCE
> +	$(call if_changed,systbl)
> +
> +targets := $(syscall-y)
> +
> +# Create output directory. Skip it if at least one old header exists
> +# since we know the output directory already exists.
> +ifeq ($(old-headers),)
> +$(shell mkdir -p $(obj))
> +endif
> +
> +PHONY += FORCE
> +
> +FORCE:
> +
> +existing-targets := $(wildcard $(sort $(targets)))
> +
> +-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
> +
> +.PHONY: $(PHONY)

