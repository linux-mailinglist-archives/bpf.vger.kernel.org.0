Return-Path: <bpf+bounces-78511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C9D10B14
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AE1303A091
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95E2F39A3;
	Mon, 12 Jan 2026 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E9Id8tLK"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04515E8B
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768198644; cv=none; b=dEgOalUOlRjDh7mVgKJ6cx3nWRIGriN2ZQP+ZD3nALmCIHRZBFTjbMKrCp673nYFPVXPDYrO5JL4a4F6bJoCOvTKea7TPyQb1r6ND2XAjMyAS/wPjn6tmtn5nvCHST695Dna3aCisd6YllYdClhEqoPJ1h0RgJIDMjkb9gA3Ok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768198644; c=relaxed/simple;
	bh=AEICQsO+pyn65b8kJSdU82kVaiiYrl7+b1EkhBX8IR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rs7UxDwnfs8Fe9CwLb0pg27IkEFULO9UG9Op2RlPH4Dng/uWeJZvpcognNDLTPtq2jJvyhPDzPlOQdWy8/h4K5tV5FFRl7aKCQeL5yLjUqP3qyi0vL/qvvBu5JBv3v58O2DFAxAS/MiaUQxh8dCI1UkbjMbsOQr3qeYbBnqtofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E9Id8tLK; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <214576f2-e3a3-400c-a7c8-aa9b0227d5d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768198639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNixRBCqqqSBiz2YbJoIYgPMycxehl1421m/a2XjBhY=;
	b=E9Id8tLK2MMpLjw01oROs3oUSQlS6EUw7JgTfkJS2gsfkzDav2oyG6DWIu1sEOouHI4N93
	N3b5ieMnSFyy1+UYi+ppzcIlJYjjCiRdWYsBCxi4wuA7d+FAFmkR6HxTqhuQ4cAvXlX1du
	3j2WVVQ1n7QtwvWaPzudfaOy8jmlisM=
Date: Sun, 11 Jan 2026 22:17:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: wq: fix skel leak in serial_test_wq()
Content-Language: en-GB
To: Kery Qi <qikeyu2017@gmail.com>, andrii@kernel.org
Cc: martin.lau@linux.dev, bpf@vger.kernel.org
References: <20260111183024.2273-1-qikeyu2017@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260111183024.2273-1-qikeyu2017@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/11/26 10:30 AM, Kery Qi wrote:
> serial_test_wq() returns early when ASSERT_OK_PTR(wq_skel, "wq_skel_load")
> fails. In that case wq__open_and_load() may still have returned a non-NULL
> skeleton, and the early return skips wq__destroy(), leaking resources and
> triggering ASAN leak reports in selftests runs.
>
> Jump to the common clean_up label instead, so wq__destroy() is executed on
> all exit paths. Also fix the missing semicolon after 'goto clean_up'.
>
> Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/wq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> index 1dcdeda84853..b32e22876492 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -17,11 +17,11 @@ void serial_test_wq(void)
>   
>   	wq_skel = wq__open_and_load();
>   	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
> -		return;
> +		goto clean_up;

This is not correct. There is no 'clean_up' label in the original code.
Also, there is nothing to clean up if wq__open_and_load() failed.

>   
>   	err = wq__attach(wq_skel);
>   	if (!ASSERT_OK(err, "wq_attach"))
> -		goto clean_up
> +		goto clean_up;
>   
>   	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
>   	err = bpf_prog_test_run_opts(prog_fd, &topts);


