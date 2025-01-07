Return-Path: <bpf+bounces-48065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A0A03C82
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE8161F2D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B91E9B24;
	Tue,  7 Jan 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+gr0p6P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A11EBA19
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245991; cv=none; b=IqkvC08m36sNOgQDqmUh2mucAqmLYHwxtll1tGyUeAGKxJcBnm6uwU5Cn9YpT/IBRLDDar22csJeuf8UU0Jx1e4URmbj0n6XXGHHc/WlxJhlPi01XzkAZwUiaHvnF0yT7h5H/Bx+TLAhCYjddXmUcybbPFjhSIxbx/aEr6wQgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245991; c=relaxed/simple;
	bh=Cb5uRRn3US5XEl1u5YseoQmZExghVpMDhHyOw7bElZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KVxk4MH/1GCRt6fG6LYkq0s1AcdJ9MNPrur07stWwc/MCFbbz0pZ3mZGpYMI4r1yvXDkZAQC8y+mju+9CenpujEKuiabqXu77cQC+9shtzm3qYcswsQclGQanS/4nvEIu6Tw7YhnQz9wv7P24xXEjqwzeGGNhhWofHQEJTYv5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+gr0p6P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so160293695e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 02:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736245985; x=1736850785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RphMn2e4Q1St9vq+rxp1ToCrnuLL1BhPJJ2B2L9l9eg=;
        b=P+gr0p6PdF28GEsf+dsGjFdVXBHiQtY5QhlqrRPwi8vOa7CdUoyeN3j3/o3TfBAO1S
         PRq4J7fNhrc3tAPRAiSnj+g/xF5j2sbn+Eib09V528uHZiHIRlBMQsGvNz3oN8t63Doq
         m/FGKVZ0rzWW4n3FG3WtEHdjpPIL9DIL1BC9hXDDbos1gJNPCxuSEIRPaZ8L9DO6aK/4
         CruTOqvP3QTQnOmYAZeaegS4OVEtIgo/sB8Olm3SUcAXJJ+TXbk60llA81MCSqVidYSS
         sRLTetsVjxq89LYGYNH/E4+ZRkjA9nZ31ygArRZMoLC/kotyQB0xbGmS8SsWhBrWCY7Y
         bDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736245985; x=1736850785;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RphMn2e4Q1St9vq+rxp1ToCrnuLL1BhPJJ2B2L9l9eg=;
        b=jb1vRvT4+xKn+QGbamAcy7mD7HXWu6poMAM2IW6P1xeJ7M3+UdNzyvBOaHeQW0g/0A
         27Clwr5aJWkszzuKGb6P0P0EJUu30xGVm5j6P/ErhMvT/5f/sDBpCDEG+Ia0yv/v5Gu6
         2iMnHIKp3QLmCzcTlWnSOU3PHlvtumsEsYNak4GJ9hsmvxRjBlaSO3ZWP7pNtzBzIHGB
         Te1/1z14vWG3/oHWJq1PFbtnj0+pk1zZZA08y/Uu21KwdAtbgrQ+T3CWQsWv/BW/JbGV
         H1/w2SS0OWn3XiDzFaTvFjtJw4OmXbOYPA0auB2O97BH2uiiKEeXqAR6vbEIB7NgK3TR
         WWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHh+OMdCvL2s59KICg7GTxHNhjrykwypQ9swKxj04ftFL4V8bwkLQdBhGHSKkoR2y6VOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjowoiTCIaoz7cAFOvovcDD8TGupuUaSydEm3NB5MVuVa10mY2
	7wC9qhE7eH3QYI3JsGzkoKcgGbh2Lbq/cj629K4mcozPYbmp7rXoGWwoPqNC7NQ=
X-Gm-Gg: ASbGncuoXZUZNr/Sh58soXiqxtyLFzuhOp49DuFF1GQD/+w5wx755SUj1BzT8v92kzp
	h3z6jX8RjtLseoJiTO+TPRI0BahnVm1nbETpIe10Hx4XTaX4Rk+2T66ssqswkoByKR3XMj5/+iE
	8nHtBSGFsYcHjGpLGuKgECkBPg0oRXInjze5hRmi5Bwu+QcEDfF79XY5vn5K4IUiIGdMj4Uvzem
	czWuJQHbqkvHRqdk/2RcEYVWDuwm6faY/0tW50yuSKyeBBqMwrcs4a6Lfh2PUmNFWw=
X-Google-Smtp-Source: AGHT+IF4cAbFaDuFO0ANbdGTWbKd/5vdEOwE/yFqLusfL+kY9On8ee5PWPU2n+94M9LSgLICckwu0A==
X-Received: by 2002:a05:600c:1f8f:b0:436:30e4:459b with SMTP id 5b1f17b1804b1-4368a8b6a2emr430163255e9.18.1736245985256;
        Tue, 07 Jan 2025 02:33:05 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008casm595653245e9.14.2025.01.07.02.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 02:33:04 -0800 (PST)
Message-ID: <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
Date: Tue, 7 Jan 2025 10:33:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@arm.com>
References: <20250106215443.198633-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250106215443.198633-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/01/2025 9:54 pm, Ian Rogers wrote:
> There's some expressed interest in having the compiler flag
> -Wconversion detect at build time certain kinds of potential problems:
> https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
> 
> As feature detection passes -Wconversion from CFLAGS when set, the
> feature detection compile tests need to not fail because of
> -Wconversion as the failure will be interpretted as a missing
> feature. Switch various types to avoid the -Wconversion issue, the
> exact meaning of the code is unimportant as it is typically looking
> for header file definitions.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

What's the plan for errors in #includes that we can't modify? I noticed 
the Perl feature test fails with -Wconversion but can be fixed by 
disabling the warning:

   #pragma GCC diagnostic push
   #pragma GCC diagnostic ignored "-Wsign-conversion"
   #pragma GCC diagnostic ignored "-Wconversion"
   #include <EXTERN.h>
   #include <perl.h>
   #pragma GCC diagnostic pop

Not sure why it needs both those things to be disabled when I only 
enabled -Wconversion, but it does.

> ---
>   tools/build/feature/test-backtrace.c           | 2 +-
>   tools/build/feature/test-bpf.c                 | 2 +-
>   tools/build/feature/test-glibc.c               | 2 +-
>   tools/build/feature/test-libdebuginfod.c       | 2 +-
>   tools/build/feature/test-libdw.c               | 2 +-
>   tools/build/feature/test-libelf-gelf_getnote.c | 2 +-
>   tools/build/feature/test-libelf.c              | 2 +-
>   tools/build/feature/test-lzma.c                | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/build/feature/test-backtrace.c b/tools/build/feature/test-backtrace.c
> index e9ddd27c69c3..7962fbad6401 100644
> --- a/tools/build/feature/test-backtrace.c
> +++ b/tools/build/feature/test-backtrace.c
> @@ -5,7 +5,7 @@
>   int main(void)
>   {
>   	void *backtrace_fns[10];
> -	size_t entries;
> +	int entries;
>   
>   	entries = backtrace(backtrace_fns, 10);
>   	backtrace_symbols_fd(backtrace_fns, entries, 1);
> diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
> index 727d22e34a6e..e7a405f83af6 100644
> --- a/tools/build/feature/test-bpf.c
> +++ b/tools/build/feature/test-bpf.c
> @@ -44,5 +44,5 @@ int main(void)
>   	 * Test existence of __NR_bpf and BPF_PROG_LOAD.
>   	 * This call should fail if we run the testcase.
>   	 */
> -	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> +	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr)) == 0;

Seems a bit weird to invert some of the return values rather than doing 
!= 0, but as you say, the actual values seem to be unimportant.

Reviewed-by: James Clark <james.clark@linaro.org>

>   }
> diff --git a/tools/build/feature/test-glibc.c b/tools/build/feature/test-glibc.c
> index 9ab8e90e7b88..20a250419f31 100644
> --- a/tools/build/feature/test-glibc.c
> +++ b/tools/build/feature/test-glibc.c
> @@ -16,5 +16,5 @@ int main(void)
>   	const char *version = XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);
>   #endif
>   
> -	return (long)version;
> +	return version == NULL;
>   }
> diff --git a/tools/build/feature/test-libdebuginfod.c b/tools/build/feature/test-libdebuginfod.c
> index da22548b8413..823f9fa9391d 100644
> --- a/tools/build/feature/test-libdebuginfod.c
> +++ b/tools/build/feature/test-libdebuginfod.c
> @@ -4,5 +4,5 @@
>   int main(void)
>   {
>   	debuginfod_client* c = debuginfod_begin();
> -	return (long)c;
> +	return !!c;
>   }
> diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
> index 2fb59479ab77..aabd63ca76b4 100644
> --- a/tools/build/feature/test-libdw.c
> +++ b/tools/build/feature/test-libdw.c
> @@ -9,7 +9,7 @@ int test_libdw(void)
>   {
>   	Dwarf *dbg = dwarf_begin(0, DWARF_C_READ);
>   
> -	return (long)dbg;
> +	return dbg == NULL;
>   }
>   
>   int test_libdw_unwind(void)
> diff --git a/tools/build/feature/test-libelf-gelf_getnote.c b/tools/build/feature/test-libelf-gelf_getnote.c
> index 075d062fe841..e06121161161 100644
> --- a/tools/build/feature/test-libelf-gelf_getnote.c
> +++ b/tools/build/feature/test-libelf-gelf_getnote.c
> @@ -4,5 +4,5 @@
>   
>   int main(void)
>   {
> -	return gelf_getnote(NULL, 0, NULL, NULL, NULL);
> +	return gelf_getnote(NULL, 0, NULL, NULL, NULL) == 0;
>   }
> diff --git a/tools/build/feature/test-libelf.c b/tools/build/feature/test-libelf.c
> index 905044127d56..2dbb6ea870f3 100644
> --- a/tools/build/feature/test-libelf.c
> +++ b/tools/build/feature/test-libelf.c
> @@ -5,5 +5,5 @@ int main(void)
>   {
>   	Elf *elf = elf_begin(0, ELF_C_READ, 0);
>   
> -	return (long)elf;
> +	return !!elf;
>   }
> diff --git a/tools/build/feature/test-lzma.c b/tools/build/feature/test-lzma.c
> index 78682bb01d57..b57103774e8e 100644
> --- a/tools/build/feature/test-lzma.c
> +++ b/tools/build/feature/test-lzma.c
> @@ -4,7 +4,7 @@
>   int main(void)
>   {
>   	lzma_stream strm = LZMA_STREAM_INIT;
> -	int ret;
> +	lzma_ret ret;
>   
>   	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
>   	return ret ? -1 : 0;


