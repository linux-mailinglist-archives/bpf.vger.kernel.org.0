Return-Path: <bpf+bounces-52646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694B7A46308
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A2616B5A9
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D8221F3D;
	Wed, 26 Feb 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVidwe4A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A656221735
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580588; cv=none; b=naH9KivaF/n0d/F5KQdoe5kNTfa6I8/yySWkn4O93JifLvTAcIWYQC52y8fJyeXzSBF/N3Xz0lXyK+0VPV27ZUA2/PS7OCfLgNoNJSNoSPqO5KB8bR0hQrtfCQgg/ym1KDUVo/0pUq3Pky61KoEJQLs7F+ddfgoe5ba2UYGAGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580588; c=relaxed/simple;
	bh=D4cl11alfS3xce5ZPsY57OgxtOA0HNcFBGgQsoGVUWI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A71U23E2cKTGXnXDwI0XWVHkoK2vYh5F5ARRg/VoF08/wB6K+30mnyeuptZbpFdJvJAvExpKSWexLdyDXn+EdTNUmZdJVJZXtC+v+XmTcMNf7y5Q/VkqhW9JxqK2c4YCK1ggT3okWd/TjAsIjiblUS9twLv2mC2UOienKxYePk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVidwe4A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43994ef3872so43026995e9.2
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740580584; x=1741185384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzLLPiIkw1X5t9H5wicrnKzI5xrmskwnmuIBT7qV7DM=;
        b=dVidwe4ABqSAz2kMNsgRt0OCJdVsSVpBcobasQJowcwIE2/yQrhYS5RZ/X9nNe6yfO
         5Hg90FJBdNFHisS7t9x3Q1vyQfduGaMmnJksM/8PeugvPLHcORAW1XlYL+apMnc0ItPp
         jqejytDC2hSdTDjQDkKXCe2JQUq4Pl8UZxlq33ogiFQgC3fNex9aaCTV5FUti1cze7Bv
         tIA+AA6UJ8TQIz/O09ogLJEIw7w20bNy1O8e6185Dan4Y5ITVNq8eSMujbpFz7TEOG+I
         mTGbg9QzeD2H6XSHhYx8qUh5WQUK1pZTFQG9jzE3wo2lzECZx74qUm4FiGPgTa6A3M6e
         S3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580584; x=1741185384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzLLPiIkw1X5t9H5wicrnKzI5xrmskwnmuIBT7qV7DM=;
        b=uS3IKWSQo02sJiPm3TF9sJfjoWkvQKLE5+o/X9JzJS9FXSTkFsOoJWfrZS/EqQKA1H
         mEUzp0z6XtdSZHCo3npWDOT2grBEZCXtPuoDm1VPhPTK6didWbUhi75ZvXDvgkPfS2x/
         3ZhYCdiJjbDx0Peh7b4R7g9cxIU+RaT8u2UuHEME92B0q5n3QfrPr8d+q+FN2ffkxaPP
         D9aG1O18uuggo3fiPneayZHEPLwJH5b6pozO96sJsw0X0esHweKfKotU2vBMd/Ix+6Dt
         yXBzD95y+Rj6s2VAYRL93kS0uZNdyfWQgJ1SImxcbfn2Hx/XHLevkQvh9Do+e3M3v8Sz
         Ug5w==
X-Gm-Message-State: AOJu0YyxzolmTShUd3DzJqwV4le+twMFBIBRyG2SKYWFvvcNoQM1Ph8Z
	0dt5iIDeRrOowgJjKWOTpcG7KzajHpYVfSsmZ4O2Vo9x5Ocq7Kcq
X-Gm-Gg: ASbGncshHkf15iTCo8eJSXQFzfM2+kqru/BBQuq6pcXeL2qQ2NtKjuWr+YSAaVPiOON
	hNDAVagZH6sD+bEEA+/XQXbZiUNbxfNxS0s0zab+8U+kVjCuOmVEADvhkpRs5KEFOiGN0nuQ9Yb
	xn6YkgMAw5Tc7dPF/YaeNZKBRy2oPaayWRhpwZOwASCxomw//mwsmBZOlgXB8dkfTDNnU7gBy9L
	fShsfIdcgZpfu9DQqkqUMzEyrO8rzHHk5FF6nwCNrd4TbyA/1ukVUbVuuMig0RcvO30rb29QPAJ
	0pdQU0GkcSrV2s26Yn0=
X-Google-Smtp-Source: AGHT+IF5GUW2s+RYw5asWGi3zD/GQ+C/eaIh+qb/5ITZDc4wKPi02BcJbi2GgAG5/WnkrlSt1HStEA==
X-Received: by 2002:a05:600c:1d94:b0:439:9a40:aa09 with SMTP id 5b1f17b1804b1-43ab3be40d7mr51488475e9.25.1740580584359;
        Wed, 26 Feb 2025 06:36:24 -0800 (PST)
Received: from krava ([2a00:102a:5013:7b7d:132e:7dd4:845b:548e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b9d1sm24237085e9.8.2025.02.26.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:36:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Feb 2025 15:36:21 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test bpf_usdt_arg_size()
 function
Message-ID: <Z78m5XkzuC1L3QPE@krava>
References: <20250224235756.2612606-1-ihor.solodrai@linux.dev>
 <20250224235756.2612606-2-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224235756.2612606-2-ihor.solodrai@linux.dev>

On Mon, Feb 24, 2025 at 03:57:56PM -0800, Ihor Solodrai wrote:
> Update usdt tests to also check for correct behavior of
> bpf_usdt_arg_size().
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 11 ++++++++++-
>  tools/testing/selftests/bpf/progs/test_usdt.c | 14 ++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 56ed1eb9b527..495d66414b57 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -45,7 +45,7 @@ static void subtest_basic_usdt(void)
>  	LIBBPF_OPTS(bpf_usdt_opts, opts);
>  	struct test_usdt *skel;
>  	struct test_usdt__bss *bss;
> -	int err;
> +	int err, i;
>  
>  	skel = test_usdt__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "skel_open"))
> @@ -75,6 +75,7 @@ static void subtest_basic_usdt(void)
>  	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
>  	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
>  	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
> +	ASSERT_EQ(bss->usdt0_arg_size, -ENOENT, "usdt0_arg_size");
>  
>  	/* auto-attached usdt3 gets default zero cookie value */
>  	ASSERT_EQ(bss->usdt3_cookie, 0, "usdt3_cookie");
> @@ -86,6 +87,9 @@ static void subtest_basic_usdt(void)
>  	ASSERT_EQ(bss->usdt3_args[0], 1, "usdt3_arg1");
>  	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
>  	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
> +	ASSERT_EQ(bss->usdt3_arg_sizes[0], 4, "usdt3_arg1_size");
> +	ASSERT_EQ(bss->usdt3_arg_sizes[1], 8, "usdt3_arg2_size");
> +	ASSERT_EQ(bss->usdt3_arg_sizes[2], 8, "usdt3_arg3_size");
>  
>  	/* auto-attached usdt12 gets default zero cookie value */
>  	ASSERT_EQ(bss->usdt12_cookie, 0, "usdt12_cookie");
> @@ -104,6 +108,11 @@ static void subtest_basic_usdt(void)
>  	ASSERT_EQ(bss->usdt12_args[10], nums[idx], "usdt12_arg11");
>  	ASSERT_EQ(bss->usdt12_args[11], t1.y, "usdt12_arg12");
>  
> +	int usdt12_expected_arg_sizes[12] = { 4, 4, 8, 8, 4, 8, 8, 8, 4, 2, 2, 1 };
> +
> +	for (i = 0; i < 12; i++)
> +		ASSERT_EQ(bss->usdt12_arg_sizes[i], usdt12_expected_arg_sizes[i], "usdt12_arg_size");
> +
>  	/* trigger_func() is marked __always_inline, so USDT invocations will be
>  	 * inlined in two different places, meaning that each USDT will have
>  	 * at least 2 different places to be attached to. This verifies that
> diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> index 505aab9a5234..096488f47fbc 100644
> --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> @@ -11,6 +11,7 @@ int usdt0_called;
>  u64 usdt0_cookie;
>  int usdt0_arg_cnt;
>  int usdt0_arg_ret;
> +int usdt0_arg_size;
>  
>  SEC("usdt")
>  int usdt0(struct pt_regs *ctx)
> @@ -26,6 +27,7 @@ int usdt0(struct pt_regs *ctx)
>  	usdt0_arg_cnt = bpf_usdt_arg_cnt(ctx);
>  	/* should return -ENOENT for any arg_num */
>  	usdt0_arg_ret = bpf_usdt_arg(ctx, bpf_get_prandom_u32(), &tmp);
> +	usdt0_arg_size = bpf_usdt_arg_size(ctx, bpf_get_prandom_u32());
>  	return 0;
>  }
>  
> @@ -34,6 +36,7 @@ u64 usdt3_cookie;
>  int usdt3_arg_cnt;
>  int usdt3_arg_rets[3];
>  u64 usdt3_args[3];
> +int usdt3_arg_sizes[3];
>  
>  SEC("usdt//proc/self/exe:test:usdt3")
>  int usdt3(struct pt_regs *ctx)
> @@ -50,12 +53,15 @@ int usdt3(struct pt_regs *ctx)
>  
>  	usdt3_arg_rets[0] = bpf_usdt_arg(ctx, 0, &tmp);
>  	usdt3_args[0] = (int)tmp;
> +	usdt3_arg_sizes[0] = bpf_usdt_arg_size(ctx, 0);
>  
>  	usdt3_arg_rets[1] = bpf_usdt_arg(ctx, 1, &tmp);
>  	usdt3_args[1] = (long)tmp;
> +	usdt3_arg_sizes[1] = bpf_usdt_arg_size(ctx, 1);
>  
>  	usdt3_arg_rets[2] = bpf_usdt_arg(ctx, 2, &tmp);
>  	usdt3_args[2] = (uintptr_t)tmp;
> +	usdt3_arg_sizes[2] = bpf_usdt_arg_size(ctx, 2);
>  
>  	return 0;
>  }
> @@ -64,12 +70,15 @@ int usdt12_called;
>  u64 usdt12_cookie;
>  int usdt12_arg_cnt;
>  u64 usdt12_args[12];
> +int usdt12_arg_sizes[12];
>  
>  SEC("usdt//proc/self/exe:test:usdt12")
>  int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
>  		     long a6, __u64 a7, uintptr_t a8, int a9, short a10,
>  		     short a11, signed char a12)
>  {
> +	int i;
> +
>  	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
>  		return 0;
>  
> @@ -90,6 +99,11 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
>  	usdt12_args[9] = a10;
>  	usdt12_args[10] = a11;
>  	usdt12_args[11] = a12;
> +
> +	bpf_for(i, 0, 12) {
> +		usdt12_arg_sizes[i] = bpf_usdt_arg_size(ctx, i);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.48.1
> 
> 

