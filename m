Return-Path: <bpf+bounces-46620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59719ECC86
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F63C18895A3
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E323FD3B;
	Wed, 11 Dec 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlgPlvnv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3B23FD0F;
	Wed, 11 Dec 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921317; cv=none; b=kokvZqyN8hVo8KM8nn9SyRLmVe1QMLNN0pH7XtW+aLec03aZp3p4i8riC6xtpM95qSmDdHhBv/nKQRcD8KHFknl7/IkYyC7zPGT3UV/SbH2edJdwdpKAy2Yn5QnBzceGWCChk7fissa3endFv787KIgb7uB1o9SudOAZOnp1EO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921317; c=relaxed/simple;
	bh=TjgK9l8h5bZVjMVB089SMe0OnrRxTJz8wjrUeFJG7PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fl+8cXusQtjgRDHpfAR51TCeafFCwaEBS18f3WQyIrmyF5enZMXeNsizGypUvFQJgVw8sNlfPSuFbw1ZNU0V7PJFpJEHmo5L90EmCpxyn855c6e46Stk1BqBDH1zqDHRB8pNoyV55EhA4t+WwPJTHztYDB+fXZ4K0kqPMqPa0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlgPlvnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4AAC4CED2;
	Wed, 11 Dec 2024 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733921317;
	bh=TjgK9l8h5bZVjMVB089SMe0OnrRxTJz8wjrUeFJG7PY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nlgPlvnvibjoyyfH8BnHsiAF8s09lZXIgqTcHulD986JuRuxOCxTQZFrHX3fgvVCJ
	 7d/HsXiA4chus3+cWb0SLRviXimEPcDpj02wEYenRkenapTqNE8Cq9OQVtiROseUsw
	 USMHqz39MdnHi6JORL29tgusdgWhr0wLVywp5FalXhMiYaSAkxz9sxhMNokdA+ilEU
	 K4C1hhYBH9guNAniCdBKfcZORxuVvhn3KkBGeCptB1E9/IJNM2j+2IXRAkxo9WXV37
	 6iMXPG/qCfg+tx4+Nz0QDeNxiuAoWzcsx+C83x1nUfSPHcoC8WMAzC/+3X49kLQKIM
	 fReqZZl5I2YZg==
Message-ID: <36082de5-0cfa-4d43-b175-f9027b819497@kernel.org>
Date: Wed, 11 Dec 2024 12:48:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tools build: Add feature test for libelf with ZSTD
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Guilherme Amadio <amadio@gentoo.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241211093114.263742-1-leo.yan@arm.com>
 <20241211093114.263742-2-leo.yan@arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241211093114.263742-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-11 09:31 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> Add a test for checking if libelf supports ZSTD compress algorithm.
> 
> The macro ELFCOMPRESS_ZSTD is defined for the algorithm, pass it as an
> argument to the elf_compress() function.  If the build succeeds, it
> means the feature is supported.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/Makefile.feature           | 1 +
>  tools/build/feature/Makefile           | 4 ++++
>  tools/build/feature/test-all.c         | 4 ++++
>  tools/build/feature/test-libelf-zstd.c | 9 +++++++++
>  4 files changed, 18 insertions(+)
>  create mode 100644 tools/build/feature/test-libelf-zstd.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index bca47d136f05..b2884bc23775 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -43,6 +43,7 @@ FEATURE_TESTS_BASIC :=                  \
>          libelf-getphdrnum               \
>          libelf-gelf_getnote             \
>          libelf-getshdrstrndx            \
> +        libelf-zstd                     \
>          libnuma                         \
>          numa_num_possible_cpus          \
>          libperl                         \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 043dfd00fce7..f12b89103d7a 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -28,6 +28,7 @@ FILES=                                          \
>           test-libelf-getphdrnum.bin             \
>           test-libelf-gelf_getnote.bin           \
>           test-libelf-getshdrstrndx.bin          \
> +         test-libelf-zstd.bin                   \
>           test-libdebuginfod.bin                 \
>           test-libnuma.bin                       \
>           test-numa_num_possible_cpus.bin        \
> @@ -196,6 +197,9 @@ $(OUTPUT)test-libelf-gelf_getnote.bin:
>  $(OUTPUT)test-libelf-getshdrstrndx.bin:
>  	$(BUILD) -lelf
>  
> +$(OUTPUT)test-libelf-zstd.bin:
> +	$(BUILD) -lelf -lz -lzstd
> +
>  $(OUTPUT)test-libdebuginfod.bin:
>  	$(BUILD) -ldebuginfod
>  
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 80ac297f8196..67125f967860 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -58,6 +58,10 @@
>  # include "test-libelf-getshdrstrndx.c"
>  #undef main
>  
> +#define main main_test_libelf_zstd
> +# include "test-libelf-zstd.c"
> +#undef main
> +
>  #define main main_test_libslang
>  # include "test-libslang.c"
>  #undef main
> diff --git a/tools/build/feature/test-libelf-zstd.c b/tools/build/feature/test-libelf-zstd.c
> new file mode 100644
> index 000000000000..a1324a1db3bb
> --- /dev/null
> +++ b/tools/build/feature/test-libelf-zstd.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stddef.h>
> +#include <libelf.h>
> +
> +int main(void)
> +{
> +	elf_compress(NULL, ELFCOMPRESS_ZSTD, 0);
> +	return 0;
> +}


It's not obvious that the feature indicates that (in the case of
bpftool) support for ZSTD _must_ be added when the probe builds, it
reads more like it _can_ be added if we're after the feature, but that's
fine by me. I double-checked and ELFCOMPRESS_ZSTD support was introduced
in libelf 0.189 indeed, which is the version introducing the linkage
issue for static bpftool builds (maybe this is some info we could
mention in the commit description, by the way). As expected, the probe
sample fails to build on Ubuntu 22.04 (libelf 0.186) but passes on
Ubuntu 24.04 (libelf 0.190). Thanks!

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

Note: This being a bpftool fix, I suppose you're targetting the bpf-next
tree? If so, you've got a conflict on test-all.c given that commit
176c9d1e6a06 ("tools features: Don't check for libunwind devel files by
default") has not been synced there yet.

Thanks,
Quentin

