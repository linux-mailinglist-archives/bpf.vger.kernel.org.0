Return-Path: <bpf+bounces-70339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46BBBB7F8B
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 21:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D623A8B21
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58328221F0A;
	Fri,  3 Oct 2025 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0JtpUcZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C041CD15;
	Fri,  3 Oct 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519317; cv=none; b=Q7OM9f2mBJafXqiSbmWErOO//wZKp3MwhawTd3BYdGZxj4pqa+JrzbBJlgob9sMJECaplkHmS32MhH+TUymCsbQeph8YUPsj+r0yT4ljR0XHVmYbIqWPZk1AoTJOh2bPwL1EYE+WuP/hXccXbE/Bs/wKJMcvmbTd1xaa71pxD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519317; c=relaxed/simple;
	bh=80nbnm2CPFV9HG1mbn/+h7LeN9AlMRAg/bGpCYmogiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/mLRgS2W/toPFfNBOE2qvtk1y5MxInMT2Y9++dvLhSmDK/DFT4aOzvO+8S9+UuM1Su3K3VyPhp5B7l8Z6IYUrFNAVQog/L8Rl/PZAGS7rlt7h2h92OQ7xKcMi6jNs210iQ19yO8fnGbVSV92AtTP0HzbVipA8+fSQOalWQ0Jkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0JtpUcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1F8C4CEF5;
	Fri,  3 Oct 2025 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759519317;
	bh=80nbnm2CPFV9HG1mbn/+h7LeN9AlMRAg/bGpCYmogiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0JtpUcZ8aHKE5hrl/QykQpclSICOyVUyl2oHfCM/6cWtm0HS0MaB2Pi4tNW7LCod
	 sjmL4hjJxQDjTvHEKlGVhp3E9FkE5tmkei4G+akKwHitLrFbTGiDc8weH9NullvzSV
	 H4YOEzlLGXJSD+M9Wx3Y8CAx8NGJZSRAECL+S9FBFBul5/FG0qVqfdsym4u0Ah7Sz3
	 /91pV7ySRE9GfNo8va+n1ZA2jZmzXBeBfOyJS+OSUopzWxQv2ZAq2RLqIP6AbV0bud
	 pq+kVBMo3A++yAhTeB/3vKYcpaVgtIXUGuB5qMshj7QsBAadjwJoAgp2Y0LC+SYEpx
	 93+DrX5ge0J7Q==
Date: Fri, 3 Oct 2025 16:21:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Blake Jones <blakejones@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf bpf-event: Use libbpf version rather than
 feature check
Message-ID: <aOAiUgWjbdwBZTzO@x1>
References: <20251003012349.2396685-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003012349.2396685-1-irogers@google.com>

On Thu, Oct 02, 2025 at 06:23:48PM -0700, Ian Rogers wrote:
> The feature check guarded the -DHAVE_LIBBPF_STRINGS_SUPPORT is
> unnecessary as it is sufficient and easier to use the
> LIBBPF_CURRENT_VERSION_GEQ macro.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config  | 7 -------
>  tools/perf/builtin-check.c  | 1 +
>  tools/perf/util/bpf-event.c | 2 --
>  tools/perf/util/bpf-utils.h | 5 +++++
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 6cdb96576cb8..b0e15721c5a5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -596,13 +596,6 @@ ifndef NO_LIBELF
>  	  LIBBPF_INCLUDE = $(LIBBPF_DIR)/..
>          endif
>        endif
> -
> -      FEATURE_CHECK_CFLAGS-libbpf-strings="-I$(LIBBPF_INCLUDE)"
> -      $(call feature_check,libbpf-strings)
> -      ifeq ($(feature-libbpf-strings), 1)
> -        $(call detected,CONFIG_LIBBPF_STRINGS)
> -        CFLAGS += -DHAVE_LIBBPF_STRINGS_SUPPORT
> -      endif
>      endif
>    endif # NO_LIBBPF
>  endif # NO_LIBELF
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 7fd054760e47..8c0668911fb1 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "builtin.h"
>  #include "color.h"
> +#include "util/bpf-utils.h"
>  #include "util/debug.h"
>  #include "util/header.h"
>  #include <tools/config.h>
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 59f84aef91b4..2298cd396c42 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -288,9 +288,7 @@ static void format_btf_variable(struct btf *btf, char *buf, size_t buf_size,
>  		.sz = sizeof(struct btf_dump_type_data_opts),
>  		.skip_names = 1,
>  		.compact = 1,
> -#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
>  		.emit_strings = 1,
> -#endif

I see, this is already under HAVE_LIBBPF_STRINGS_SUPPORT

Applying,

- Arnaldo

>  	};
>  	struct btf_dump *d;
>  	size_t btf_size;
> diff --git a/tools/perf/util/bpf-utils.h b/tools/perf/util/bpf-utils.h
> index eafc43b8731f..a8bc1a232968 100644
> --- a/tools/perf/util/bpf-utils.h
> +++ b/tools/perf/util/bpf-utils.h
> @@ -14,6 +14,11 @@
>         (LIBBPF_MAJOR_VERSION > (major) ||                              \
>          (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
>  
> +#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
> +// libbpf 1.7+ support the btf_dump_type_data_opts.emit_strings option.
> +#define HAVE_LIBBPF_STRINGS_SUPPORT 1
> +#endif
> +
>  /*
>   * Get bpf_prog_info in continuous memory
>   *
> -- 
> 2.51.0.618.g983fd99d29-goog

