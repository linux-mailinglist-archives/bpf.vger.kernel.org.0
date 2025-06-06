Return-Path: <bpf+bounces-59918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C453AD0878
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72158188D89E
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4F1F460B;
	Fri,  6 Jun 2025 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIjkbpRy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150622746A;
	Fri,  6 Jun 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236695; cv=none; b=UpUiuIdTmyaBW/mkFQYQ1GJoS0ip4lehoTFund7SqJwxuTpIXVUDQZt3wmak+S6eGgThzwoXnmeuT12stuU7JB+Ij+zSSz02oRWkOn2UreX//GkOohnW1fZHJfBVh59aAphyMJZeKX1fH5+nMPLrppSPErp9/B0scjfaPvM/FUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236695; c=relaxed/simple;
	bh=fuYqdoV1jvKU3tUKFTnTsNAh6QOQSVphydcsDKTi/LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO9yUxRk5KJ4w0l5LlMQqZSnfEscjsVflHIfKN5d3Yrh62cEHlSeoJnaNzM3/T2MSwOxKQO4TjqZ7iO58ctcBsG6+lzscImPnLHvVZECXvC5k3GvcHrm6Zvq5dnTeNRNvuXxUeRCib+4Z28xI+9WeXmL0Ia1zB3iZIW7jf24ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIjkbpRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DD0C4CEEB;
	Fri,  6 Jun 2025 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749236694;
	bh=fuYqdoV1jvKU3tUKFTnTsNAh6QOQSVphydcsDKTi/LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIjkbpRyH44Mlt7GAnAgaOAIRy4YqXVlLPyuoVWVvX6QHHsLAwoMb+ZYgdpLWu/RD
	 mplKgMnNVeZrWGOyXae6f34CJGx03x4xZDU4+b6+62FMvLAW6Y9PYF+TR780QTFmpu
	 ElB1/EOBJpmqs0nPQYHs3mJ/BlteV9moMfLKVQ5ivTWSj4aaundU3qGIgpMce2FiLK
	 VtBCar1apDUTvlccIvzLiW6c//Peg8571g/tinuHpTtBB6P0ryRkKFjjMdzoQ2tmPL
	 tWuzbm5GdhoqEpfT/Uz+M+hAxpYMG7yhXghzjF2i+eaFWiMJ9SlPBPEbHMMqwFk9QP
	 tiNyMi/Q+54Dg==
Date: Fri, 6 Jun 2025 12:04:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf: detect support for libbpf's emit_strings
 option
Message-ID: <aEM71LulKhuEinN6@google.com>
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-2-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605233934.1881839-2-blakejones@google.com>

On Thu, Jun 05, 2025 at 04:39:31PM -0700, Blake Jones wrote:
> This creates a config option that detects libbpf's ability to display
> character arrays as strings, which was just added to the BPF tree
> (https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4).
> 
> To test this change, I built perf (from later in this patch set) with:
> 
> - static libbpf (default, using source from kernel tree)
> - dynamic libbpf (LIBBPF_DYNAMIC=1 LIBBPF_INCLUDE=/usr/local/include)
> 
> For both the static and dynamic versions, I used headers with and without
> the ".emit_strings" option.
> 
> I verified that of the four resulting binaries, the two with
> ".emit_strings" would successfully record BPF_METADATA events, and the two
> without wouldn't.  All four binaries would successfully display
> BPF_METADATA events, because the relevant bit of libbpf code is only used
> during "perf record".
> 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  tools/build/Makefile.feature              |  1 +
>  tools/build/feature/Makefile              |  4 ++++
>  tools/build/feature/test-libbpf-strings.c | 10 ++++++++++
>  tools/perf/Documentation/perf-check.txt   |  1 +
>  tools/perf/Makefile.config                | 12 ++++++++++++
>  tools/perf/builtin-check.c                |  1 +
>  6 files changed, 29 insertions(+)
>  create mode 100644 tools/build/feature/test-libbpf-strings.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 57bd995ce6af..541ea3cc53e9 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -126,6 +126,7 @@ FEATURE_TESTS_EXTRA :=                  \
>           llvm                           \
>           clang                          \
>           libbpf                         \
> +         libbpf-strings                 \
>           libbpf-btf__load_from_kernel_by_id \
>           libbpf-bpf_prog_load           \
>           libbpf-bpf_object__next_program \

Please check out tmp.perf-tools-next branch which made some changes in
the area.

Thanks,
Namhyung


> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index b8b5fb183dd4..327bb501fd2b 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -59,6 +59,7 @@ FILES=                                          \
>           test-lzma.bin                          \
>           test-bpf.bin                           \
>           test-libbpf.bin                        \
> +         test-libbpf-strings.bin                \
>           test-get_cpuid.bin                     \
>           test-sdt.bin                           \
>           test-cxx.bin                           \
> @@ -360,6 +361,9 @@ $(OUTPUT)test-libbpf-bpf_program__set_insns.bin:
>  $(OUTPUT)test-libbpf-btf__raw_data.bin:
>  	$(BUILD) -lbpf
>  
> +$(OUTPUT)test-libbpf-strings.bin:
> +	$(BUILD)
> +
>  $(OUTPUT)test-sdt.bin:
>  	$(BUILD)
>  
> diff --git a/tools/build/feature/test-libbpf-strings.c b/tools/build/feature/test-libbpf-strings.c
> new file mode 100644
> index 000000000000..83e6c45f5c85
> --- /dev/null
> +++ b/tools/build/feature/test-libbpf-strings.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <bpf/btf.h>
> +
> +int main(void)
> +{
> +	struct btf_dump_type_data_opts opts;
> +
> +	opts.emit_strings = 0;
> +	return opts.emit_strings;
> +}
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> index a764a4629220..799982d8d868 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -52,6 +52,7 @@ feature::
>                  dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
>                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
>                  libbfd                  /  HAVE_LIBBFD_SUPPORT
> +                libbpf-strings          /  HAVE_LIBBPF_STRINGS_SUPPORT
>                  libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
>                  libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
>                  libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d1ea7bf44964..647ade45e4e5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -595,8 +595,20 @@ ifndef NO_LIBELF
>            LIBBPF_STATIC := 1
>            $(call detected,CONFIG_LIBBPF)
>            CFLAGS += -DHAVE_LIBBPF_SUPPORT
> +          ifneq ($(OUTPUT),)
> +            LIBBPF_INCLUDE = $(abspath $(OUTPUT))/libbpf/include
> +          else
> +            LIBBPF_INCLUDE = $(CURDIR)/libbpf/include
> +          endif
>          endif
>        endif
> +
> +      FEATURE_CHECK_CFLAGS-libbpf-strings="-I$(LIBBPF_INCLUDE)"
> +      $(call feature_check,libbpf-strings)
> +      ifeq ($(feature-libbpf-strings), 1)
> +        $(call detected,CONFIG_LIBBPF_STRINGS)
> +        CFLAGS += -DHAVE_LIBBPF_STRINGS_SUPPORT
> +      endif
>      endif
>    endif # NO_LIBBPF
>  endif # NO_LIBELF
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 9a509cb3bb9a..f4827f0ddb47 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -43,6 +43,7 @@ struct feature_status supported_features[] = {
>  	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
>  	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
>  	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
> +	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
>  	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
>  	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
>  	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
> -- 
> 2.50.0.rc0.604.gd4ff7b7c86-goog
> 

