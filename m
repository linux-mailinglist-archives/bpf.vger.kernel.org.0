Return-Path: <bpf+bounces-46641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599429ECF55
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 16:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE27281BB8
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F431AA1C4;
	Wed, 11 Dec 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkKLyBHz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3771D63C8;
	Wed, 11 Dec 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929524; cv=none; b=tcgJLy6rSyv/RBkVXqd6224W3obP4TYB1ZSQLYQyYXlTdhxGpNDfwModSDzIW1Kn/pKuewfkdhTC3VQzJwk85aFDp1anjD+G/yEnXB4+AV4V7eBYHSaK48DIxEL2U+4sWFd7ODucVedwydTzcJ84psKPI6W3U+iw7e2GTjgNmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929524; c=relaxed/simple;
	bh=zBAP9mh8OPUKcmyV9VNqiPkVz3ps9OJpez4j8qjPT2A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cONqVQ0lmjB+9c2xHDEY9BpQ6kDggleOZrJGXU39lX1iNkXpSgzmDJIYHYXV43nc75MaGSEGi54obcnA9+jNAnb7synqWbzAJ/gIOdNcxgsmxhtF+BMOxyaAgOyX7BZqZ+OwJPXe1NiyBnZdgMUzc1wivnbRrFTUajQNSpP4URY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkKLyBHz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6a92f863cso332853266b.1;
        Wed, 11 Dec 2024 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733929519; x=1734534319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmuSRYRsN+CVodQCjU4cJzoXt2OifyhdBUg+LTTXX5I=;
        b=YkKLyBHzwIIjh1ID1+J7E3MIvvgO96Aq+MemS2iP1KZhSLIcFNvK7lI0q1+t082izp
         7AePbFVCdFkawO3c690HdLLGzmUNQS+xSeDjCOr5YJ4pU/SkpOj2guuqr+VAiRPicftH
         uRIAwMTlkeogxyo+AftkKrubTLnxLDKGDgGMk0bUbaBCi2q1wL8Zjiyuamq9xdj5xs96
         /fiAXZZgq2NvsAaLxLQIX3v8xL+7X/hUnRQPrjCdPx0rZIIcPLN4yFc73aBl+XTsQZhf
         K6WDwDAQ80Z7CSopyj1uKAd7+sguUFlX32z+Difqqvbt5306GzQmmN7D8dEVi6mh1AH3
         gigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929519; x=1734534319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmuSRYRsN+CVodQCjU4cJzoXt2OifyhdBUg+LTTXX5I=;
        b=pFEVzNDrp1OsI8L+Iq22kJ6PIfmP8ElWJOEGZblD8fL7tfy6blNm1zvLocAq7E3rqu
         gnoZZVGT9nOPVvKmoE6E6QmDtRL8NDSQK5uWsXJEk9ScJx6mentwUan1K9I/JdmkrYam
         uaoonPB7tmPISjPlYugBPxJzZCh47QazPDtYE/Voljz3aKXO7ks04X+RVqb4mfDdkbFO
         2KrjsNgRhxUZlNODcoDLqwa5dOXeW8S9jpjTaleGYMU+oYgKLzp+6JH5evOH0mhuwQxy
         jEO1yd5c8V1N1kel0Sk8zzFiHSVaL0PkDv4yx4MHAoK7+cKDhruZzCN7LusJ+Who0sTg
         wJHw==
X-Forwarded-Encrypted: i=1; AJvYcCWVCH4barhEG5FzVA/96mJCehF4M2LiX5vx52aqtQqtEt3//Kk0srgS43tfKfvlIwrAn+8GZbTq8WZsbpnn@vger.kernel.org, AJvYcCXnyZ41EQQaZY1EsDDmsf7ha8YsW+OsRGyqQmud/nvE6mNF539de3qGsMIh4zOe2n6G5hsQzVHJU/dQm+oRG0DVHQ==@vger.kernel.org, AJvYcCXrIyz9PhELvU9TLnwnuOinFP1Fq2buOmtLMj6QC3YLU73hfQ20Bx6JpkLTEoqRxhG6rNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9Cmef8dHYeEFpbRycTqhbrUDfkY7NNKQkSql0kxtDh9ulCi/
	D8dpUef8hIozDVzjojT9BFmYBkRyzd/ohBNKnW9nrFkX1TCmEy2y
X-Gm-Gg: ASbGncsqBnb2IvivxbFzC94f7RYrbhohA1nn/59dcabdw6ehqNUS23xtc96iqeNnMJk
	HUb6CBMFmwUDjZrWzIRxjdzRksT1OjCnKkEmHP/tdeCCdOM8oj9HLewEwUafbOwEp0bbr6wWnbQ
	1xTa/LKriTiCjt52ckt9K/o6pWVlph52pCa1RmLYv3fLStoYcdh9es3lPFJGrDblmPDtHH+QWee
	XoGa22FXQ7cP2RPnXR7k3n8OBuBPAs1y78mcsb2ZIIA7ErR46oNSHLy1qpHgfINK6zXQ0m/09Tc
	DZcz8N1+GCiYqI8N3hG9sMZYRjc=
X-Google-Smtp-Source: AGHT+IFLqy5ye4iT4eGtn9cgCHM7T7Xqhx1toNYhHYc9h0YsfMhXBP1rDtSH6hw3JVfTojL6m1mg1A==
X-Received: by 2002:a17:907:3a18:b0:aa6:6e10:61f1 with SMTP id a640c23a62f3a-aa6b10f56d7mr267950166b.1.1733929516706;
        Wed, 11 Dec 2024 07:05:16 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3dcbcc2sm260913266b.117.2024.12.11.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:05:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Dec 2024 16:05:14 +0100
To: Leo Yan <leo.yan@arm.com>
Cc: Quentin Monnet <qmo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Nick Terrell <terrelln@fb.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools build: Add feature test for libelf with ZSTD
Message-ID: <Z1mqKpXBcl303IDY@krava>
References: <20241211093114.263742-1-leo.yan@arm.com>
 <20241211093114.263742-2-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211093114.263742-2-leo.yan@arm.com>

On Wed, Dec 11, 2024 at 09:31:12AM +0000, Leo Yan wrote:
> Add a test for checking if libelf supports ZSTD compress algorithm.
> 
> The macro ELFCOMPRESS_ZSTD is defined for the algorithm, pass it as an
> argument to the elf_compress() function.  If the build succeeds, it
> means the feature is supported.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

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
> -- 
> 2.34.1
> 

