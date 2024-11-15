Return-Path: <bpf+bounces-44947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631049CDE2C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 13:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FA4281BB6
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F21BBBC4;
	Fri, 15 Nov 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNL9Q0Gu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0F15C140
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673259; cv=none; b=fkfAsCvXmXH7RA9QUNC+C+sEW81ZLaoT+gK7lBjfskHoZUoLwXZu/m/GwCG7UmTFkGKgPnjolPl8ciWF2Um5ZedyDmey5ImLGo3Jt3x76m1aAu3p65XRIKPNkOmZfkac2GWX8YDz6wTFm2yyAjSbEqu/aoK16r8GpTHea/cypvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673259; c=relaxed/simple;
	bh=0BIALmpGGeNUBzXzx4YtGLmd87YhB+VzpmW19/0W0ws=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMfOcLLl9q7wIEWjlKUkgjpFoi0+g3PeZmDg7jLa6JSbtP/V+wkDTC0e34Mf7QQSkdlCL+0+4iDlWRsiC5J3rBLpOy/Yyt0AgEvp+KD3T6uYby9Ti9ybBNjWONi6gX9PELL7S9MYIRTh1lcR1GvF8ziGcBmIW+jpTcJZ3BkAq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNL9Q0Gu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so420135f8f.2
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 04:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731673255; x=1732278055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+RjkEDkRcem8qMJJrn73qO1LJrxzYzReIXxjRPYqSc=;
        b=FNL9Q0Gutkrhum33rDFWJBJYvPToHkYNySrPLN2X8tN8sgAq8BUg21aPnqcoOCMkQx
         jTI5FIAQo2+rE/45Z7GGjOCkTSMZmx2wgW5+vtuG1Q+R+BmbLrj8m6eLH9+roUit1sgg
         grCVpdzPhMY8Iy+S8amLH5QAXuv6jNVLRoxyinkCZ4I5CXrxnSSq5OWR8gjFIt1EN6ZD
         Ck7V32DbMUM+lByGeg32Z9c+GaZ4+p4Z77f1RVMIjMfjgJu5IMzfQck+4h/2Tczba9XN
         n7jMFXRZCl/AlyPs8TMQ5ICl00FbOlnloTdCPjBNQO5Fm97/3CtYHaek6q1H6z+NoWl0
         3++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731673255; x=1732278055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+RjkEDkRcem8qMJJrn73qO1LJrxzYzReIXxjRPYqSc=;
        b=HyJ8HJP+/2FNPArZnXfEbDGx629dEi3zjdZu4lbOT/ZAIl4E7pBJ3sSKu0R7cg2lBJ
         d5GtQmhXR9l/0ZYiX0ePaC2slctSjDnw4eisqMdnHtl45YGpO5vdLJEYZdCr0GMInQLP
         MJlLP0TnnK7LFkBy0jHtMQAQaBawT0sam5WVaAuTxQK5u7J9GZ9A/e4eyUfOXK5M0FmN
         GZ+2WMUMv5oMQ5nD1WnvrRoTLXKUJnRsX66G4XA96ixfZNaVceCUsULgpsGj5Hm9azko
         waN7QWcNTCiVTcpSNea85VX0VdL4lx1xTPrUDBirOsOWdRs4FYZbh/916dem2kB7W6uS
         NlZw==
X-Gm-Message-State: AOJu0YzAlYHoIGixlkHwB7RHUWY8Wp1VYRF8KrrddMtVGH3/qUDTAK+8
	plzpn6VybdaRJ3p1odvOCyVIUiJHV49dGu1HJo4GvL5mF+uRYw7Y
X-Google-Smtp-Source: AGHT+IFinjosvsGDccEaW0B6p9KKJciZnxf0H29OPYrIpYL8rg+nz6gk8DwpcGCjKW970ocunEdbxA==
X-Received: by 2002:a05:6000:a0a:b0:381:f443:21bf with SMTP id ffacd0b85a97d-38225901b26mr1840326f8f.2.1731673255288;
        Fri, 15 Nov 2024 04:20:55 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae2f651sm4392316f8f.87.2024.11.15.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:20:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Nov 2024 13:20:53 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	djwong@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for arena range
 tree algorithm
Message-ID: <Zzc8pVMtTAkqUdvA@krava>
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
 <20241108025616.17625-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108025616.17625-3-alexei.starovoitov@gmail.com>

On Thu, Nov 07, 2024 at 06:56:16PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Add a test that verifies specific behavior of arena range tree
> algorithm and just existing bif_alloc1 test due to use
> of global data in arena.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  .../bpf/progs/verifier_arena_large.c          | 110 +++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> index 6065f862d964..8a9af79db884 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -29,12 +29,12 @@ int big_alloc1(void *ctx)
>  	if (!page1)
>  		return 1;
>  	*page1 = 1;
> -	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
> +	page2 = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE * 2,
>  				      1, NUMA_NO_NODE, 0);
>  	if (!page2)
>  		return 2;
>  	*page2 = 2;
> -	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE,
> +	no_page = bpf_arena_alloc_pages(&arena, base + ARENA_SIZE - PAGE_SIZE,
>  					1, NUMA_NO_NODE, 0);
>  	if (no_page)
>  		return 3;
> @@ -66,4 +66,110 @@ int big_alloc1(void *ctx)
>  #endif
>  	return 0;
>  }
> +
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +#define PAGE_CNT 100
> +__u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
> +__u8 __arena *base;
> +
> +/*
> + * Check that arena's range_tree algorithm allocates pages sequentially
> + * on the first pass and then fills in all gaps on the second pass.
> + */
> +__noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
> +		int max_idx, int step)
> +{
> +	__u8 __arena *pg;
> +	int i, pg_idx;
> +
> +	for (i = 0; i < page_cnt; i++) {
> +		pg = bpf_arena_alloc_pages(&arena, NULL, pages_atonce,
> +					   NUMA_NO_NODE, 0);
> +		if (!pg)
> +			return step;
> +		pg_idx = (pg - base) / PAGE_SIZE;

hi,
I'm getting compile error below with clang 20.0.0:

      CLNG-BPF [test_progs] verifier_arena_large.bpf.o
    progs/verifier_arena_large.c:90:24: error: unsupported signed division, please convert to unsigned div/mod.
       90 |                 pg_idx = (pg - base) / PAGE_SIZE;

should we just convert it to unsigned div like below?

also I saw recent llvm change [1] that might help, I'll give it a try

jirka


[1] 38a8000f30aa [BPF] Use mul for certain div/mod operations (#110712)
---
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 8a9af79db884..e743d008697e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -87,7 +87,7 @@ __noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
 					   NUMA_NO_NODE, 0);
 		if (!pg)
 			return step;
-		pg_idx = (pg - base) / PAGE_SIZE;
+		pg_idx = (unsigned int) (pg - base) / PAGE_SIZE;
 		if (first_pass) {
 			/* Pages must be allocated sequentially */
 			if (pg_idx != i)

