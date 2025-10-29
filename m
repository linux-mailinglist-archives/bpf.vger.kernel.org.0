Return-Path: <bpf+bounces-72912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA265C1D836
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E46403662
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860320C00C;
	Wed, 29 Oct 2025 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZxlBgTv0"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684620010A
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774576; cv=none; b=ebf87lW45WZyHAlf/YVATzl64xz5arsROofEGEDJ3sBVp45xOXZol/T5Xjf6nypA/CPtKBbDFNpVaLqEEviZupIgQSsWVTe8qwxDwWx6pxEaQVgwNgWaq9emfChh6Lzo40/2yJm31qnOU/itdOmxrGAI8rcS8ldyztiBGI+p7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774576; c=relaxed/simple;
	bh=5ElzWagHbGBXES7LgsOqPDJHbxWl8gd5+wO4+qgWVnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBded3Ii89HL9/7VUZYRvCgbwO7P08e7twnyNOLe7XW6mXoExK0QvzTv+a51xnkvId78BDh5CyLFcY4RdtHN1K9WXCWn96XQvkiJc1BcDK9jxG0WurzNg17EicZRwxof5+bXYRygLYG+IqtDaVfY1HpqEBvhllId/fpFEiOJtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZxlBgTv0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac753f54-0e20-4f95-ae93-3376eb77dc89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761774571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1h4HS/PxtRXNX6KM2UsGxsKenfMNMI5HNDVKvouZeM=;
	b=ZxlBgTv0Agwh7rjG46rxOYc192tHRYhXVx/Rpsn7mQfzyTPIkKaTMbJAeeGu5kR582qY31
	thJXCTCq8+sisjp4PstkwPWys9X9VbrVs5FAERlA1RmIkCDdfkshu0CK5reV/Sfp6QPo9s
	lvWf0ROASOhJlw90jydoZkoQRjbwsC4=
Date: Wed, 29 Oct 2025 14:49:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf: fix file_reader test
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251029195907.858217-1-mykyta.yatsenko5@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251029195907.858217-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/29/25 12:59 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> file_reader/on_open_expect_fault intermittently fails when test_progs
> runs tests in parallel, because it expects a page fault on first read.
> Another file_reader test running concurrently may have already pulled
> the same pages into the page cache, eliminating the fault and causing a
> spurious failure.
> 
> Make file_reader/on_open_expect_fault read from a file region that does
> not overlap with other file_reader tests, so the initial access still
> faults even under parallel execution.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/file_reader.c | 6 +++++-
>  tools/testing/selftests/bpf/progs/file_reader.c      | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)

No more failures on CI:
https://github.com/kernel-patches/bpf/actions/runs/18920720310/job/54022355262

Thank you for fixing.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> index 2a034d43b73e..5cde32b35da4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/file_reader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> @@ -52,7 +52,11 @@ static int initialize_file_contents(void)
>  	/* page-align base file address */
>  	addr = (void *)((unsigned long)addr & ~(page_sz - 1));
>  
> -	for (off = 0; off < sizeof(file_contents); off += page_sz) {
> +	/*
> +	 * Page out range 0..512K, use 0..256K for positive tests and
> +	 * 256K..512K for negative tests expecting page faults
> +	 */
> +	for (off = 0; off < sizeof(file_contents) * 2; off += page_sz) {
>  		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
>  			       "madvise pageout"))
>  			return errno;
> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
> index 2585f83b0ce5..166c3ac6957d 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
> @@ -49,7 +49,7 @@ int on_open_expect_fault(void *c)
>  	if (bpf_dynptr_from_file(file, 0, &dynptr))
>  		goto out;
>  
> -	local_err = bpf_dynptr_read(tmp_buf, user_buf_sz, &dynptr, 0, 0);
> +	local_err = bpf_dynptr_read(tmp_buf, user_buf_sz, &dynptr, user_buf_sz, 0);
>  	if (local_err == -EFAULT) { /* Expect page fault */
>  		local_err = 0;
>  		run_success = 1;


