Return-Path: <bpf+bounces-54624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E8A6EB9C
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 09:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AC03A8547
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F72528E5;
	Tue, 25 Mar 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL6Na3Fu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC519E992
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891624; cv=none; b=VkIECMTtNYKY5yUsS5RBBhFkV2hzu7svjH87/gdBMX3kjK5jOgeICUYCQgUAWfJ08smpIbvAC84QcswEVg7+EFvS7LvKfaTv5ro8hAhX1RpqUXtJo+1j1m0Nop7tIS4y3nTAZHdUPITrqFkb0a9WyFOxsKD3Y1Jov+NL4ca2oeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891624; c=relaxed/simple;
	bh=CIpgglvc6zGyqz34CRhRB2JPJCMFeVq9yDZ+adJAmf8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg5mDXNTYdMsbN3g0hyyppreV45lS0+VuqHQ1N8Eiel+6Iii0W6G+FgnanUkLCs4oR3WL2AJFiP6FZAji9r0Vg4g+SDYQmGBoK5jf/0aAixAGBUqnfPjyfWVF+PrECw9ggOV3oRgzAn4Sr3hb/M86Kj7VFibXqeBuJ8yyWezezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL6Na3Fu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso56877625e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742891621; x=1743496421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf4bT8kmKVbZr7VGN7uPEhabgyxoTN8D48RcEUDiO3A=;
        b=NL6Na3FunwlrWvzWkR6hJnaeaFdvXcFr68pbOJOqmJu9VzRCjgZznOK3l0zoreWr+I
         HM1Mrb9Jbo93uCA2yKzqzDZG9Ux34kxfwYEsdXngWti60qPwfa5liX9k5Ni9ZPwPDPTC
         o0cm4pT0AJHLlVLeq44bPf0T2kWcWG07QpL6lLbVt7wap0NRDat6UszC9kisdU3dJlv1
         P5tdTmnY9ivy6fmEtTMfjDbFr04g6c1OmoWUmsYQe9oB5L7U0aUJniCH10m2PLtLAhWm
         ZJvUp+kmJoO1USTlv5TxiZPn+WJTOXZCWByhmHhx6t2P61yYeZsOV69imQP3qI1IXYCA
         g/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742891621; x=1743496421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf4bT8kmKVbZr7VGN7uPEhabgyxoTN8D48RcEUDiO3A=;
        b=s1MqYL+G2Aa4//e3e13dlu+Tm1hRb3vk3rV9IYcI+pXWsL6SLbfiyi3/x8wHsMT84y
         JGhGTC67nmYHqPWqs/WYnV95/85yy99bsjITPEcD5wc3gBDImtNdo/tqwvgDRmnXmcoL
         ieeZbOGSfw4HYTzKVFkvbHJSbEodR2XSL+UHhoa1uMGG7LlSlwrFyzVZKMJVMu4kKNqM
         GtCRX6criSK9ykABzHfi1P9Boqe+XAku5JqhckLmDxsyl6TZygPczua/Gb50uh/XP3Rz
         U5z+jQ4cLUV2U9z8/gsagxxN9c0gLAkEYf5iESGt3QGEXw/Vyc9dclxnFcT663luJbGx
         mqRA==
X-Gm-Message-State: AOJu0YzA9QTzQVZEMelRxyGsJWev0XCGMUlmJfplxnEocLGdSX3wjmjy
	8Po+rbnHbKk3JKnnk6zsnzmOisjlOA1VuyivnL0bBTeteCdLkwEz
X-Gm-Gg: ASbGncvUsUKd7sx7CgmimdizDL/fNxcNCXaQZzuxxlJdaCHyWrs9aJgqDQwQ7zdGI9Q
	5SqHfGTysqUGNbKvc4GtMWSU3N06Vd9C9i81MWLURCjU0kklgG9wwRlimVNw6fb+zu9iToXaDii
	zhrln5o1EU7EndQKdJ+D5Con/dfahaBAMnl5p5wkrJUDGkWOYY7KzsISIv648LS+s/PP577d32x
	7S6hV+Cgt6CDUYVaiOL0Apr8CsboPMYVI5MBhrPLeXRfYmVvYK9SoGgckyzAxiEiJt3INhyNka2
	T8W152YeVxDf6rLjiRQlGt/52Al+7go=
X-Google-Smtp-Source: AGHT+IEOyGpkfiMhe0MlnEZsUSK53xOln3mF+6k9rwU1nUcUqj43DXQTClofbiJDUfmm5tHn94104Q==
X-Received: by 2002:a05:600c:b8d:b0:43b:ce08:c382 with SMTP id 5b1f17b1804b1-43d509f6797mr157213785e9.16.1742891620597;
        Tue, 25 Mar 2025 01:33:40 -0700 (PDT)
Received: from krava ([173.38.220.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef1f7sm12970301f8f.82.2025.03.25.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:33:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 25 Mar 2025 09:33:37 +0100
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add tests for string
 kfuncs
Message-ID: <Z-JqYX6k6lS6srQX@krava>
References: <cover.1741874348.git.vmalik@redhat.com>
 <2a26a72e223811f3060d772f5e9c2cf217541f18.1741874348.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a26a72e223811f3060d772f5e9c2cf217541f18.1741874348.git.vmalik@redhat.com>

On Mon, Mar 24, 2025 at 01:03:29PM +0100, Viktor Malik wrote:
> The tests use the RUN_TESTS helper which executes BPF programs with
> BPF_PROG_TEST_RUN and check for the expected return value.
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  .../selftests/bpf/prog_tests/string_kfuncs.c  | 10 ++++
>  .../selftests/bpf/progs/string_kfuncs.c       | 58 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>  create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> new file mode 100644
> index 000000000000..79dab172eb92
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Red Hat, Inc.*/
> +#include <test_progs.h>
> +#include "string_kfuncs.skel.h"
> +
> +void test_string_kfuncs(void)
> +{
> +	RUN_TESTS(string_kfuncs);
> +}
> +
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs.c b/tools/testing/selftests/bpf/progs/string_kfuncs.c
> new file mode 100644
> index 000000000000..9fb1ed5ba1fa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Red Hat, Inc.*/
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +int bpf_strcmp(const char *cs, const char *ct) __ksym;
> +char *bpf_strchr(const char *s, int c) __ksym;
> +char *bpf_strchrnul(const char *s, int c) __ksym;
> +char *bpf_strnchr(void *s, u32 s__sz, int c) __ksym;
> +char *bpf_strnchrnul(void *s, u32 s__sz, int c) __ksym;
> +char *bpf_strrchr(const char *s, int c) __ksym;
> +size_t bpf_strlen(const char *s) __ksym;
> +size_t bpf_strnlen(void *s, u32 s__sz) __ksym;
> +size_t bpf_strspn(const char *s, const char *accept) __ksym;
> +size_t bpf_strcspn(const char *s, const char *reject) __ksym;
> +char *bpf_strpbrk(const char *cs, const char *ct) __ksym;
> +char *bpf_strstr(const char *s1, const char *s2) __ksym;
> +char *bpf_strstr(const char *s1, const char *s2) __ksym;
> +char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz) __ksym;

hi,
I don't think above declarations are necessary, it should be all
in vmlinux.h already

jirka

> +
> +char str1[] = "hello world";
> +char str2[] = "hello";
> +char str3[] = "world";
> +char str4[] = "abc";
> +char str5[] = "";
> +
> +#define __test(retval) SEC("syscall") __success __retval(retval)
> +
> +__test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str1, str1); }
> +__test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str1, str2); }
> +__test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str1, 'e') - str1; }
> +__test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str1, '\0') - str1; }
> +__test(0) u64 test_strchr_notfound(void *ctx) { return (u64)bpf_strchr(str1, 'x'); }
> +__test(1) int test_strchrnul_found(void *ctx) { return bpf_strchrnul(str1, 'e') - str1; }
> +__test(11) int test_strchrnul_notfound(void *ctx) { return bpf_strchrnul(str1, 'x') - str1; }
> +__test(1) int test_strnchr_found(void *ctx) { return bpf_strnchr(str1, 5, 'e') - str1; }
> +__test(11) int test_strnchr_null(void *ctx) { return bpf_strnchr(str1, 12, '\0') - str1; }
> +__test(0) u64 test_strnchr_notfound(void *ctx) { return (u64)bpf_strnchr(str1, 5, 'w'); }
> +__test(1) int test_strnchrnul_found(void *ctx) { return bpf_strnchrnul(str1, 5, 'e') - str1; }
> +__test(11) int test_strnchrnul_notfound(void *ctx) { return bpf_strnchrnul(str1, 12, 'x') - str1; }
> +__test(9) int test_strrchr_found(void *ctx) { return bpf_strrchr(str1, 'l') - str1; }
> +__test(0) u64 test_strrchr_notfound(void *ctx) { return (u64)bpf_strrchr(str1, 'x'); }
> +__test(11) size_t test_strlen(void *ctx) { return bpf_strlen(str1); }
> +__test(11) size_t test_strnlen(void *ctx) { return bpf_strnlen(str1, 12); }
> +__test(5) size_t test_strspn(void *ctx) { return bpf_strspn(str1, str2); }
> +__test(2) size_t test_strcspn(void *ctx) { return bpf_strcspn(str1, str3); }
> +__test(2) int test_strpbrk_found(void *ctx) { return bpf_strpbrk(str1, str3) - str1; }
> +__test(0) u64 test_strpbrk_notfound(void *ctx) { return (u64)bpf_strpbrk(str1, str4); }
> +__test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str1, str3) - str1; }
> +__test(0) u64 test_strstr_notfound(void *ctx) { return (u64)bpf_strstr(str1, str4); }
> +__test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str1, str5) - str1; }
> +__test(6) int test_strnstr_found(void *ctx) { return bpf_strnstr(str1, 12, str3, 6) - str1; }
> +__test(0) u64 test_strnstr_unsafe(void *ctx) { return (u64)bpf_strnstr(str1, 5, str3, 5); }
> +__test(0) u64 test_strnstr_notfound(void *ctx) { return (u64)bpf_strnstr(str1, 12, str4, 4); }
> +__test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str1, 5, str5, 1) - str1; }
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.48.1
> 

