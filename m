Return-Path: <bpf+bounces-69539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC8B9A1C2
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1D21B2488A
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A62FB608;
	Wed, 24 Sep 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="D6VJuant"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D92AE89
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721934; cv=none; b=GwuBLvsvdXkqQSQ17oSRaivYCmnzaJkRGJVJDpA8YB4EeFU7Zx3vA6GD3kmL6/woKwjVm0Yyl2vkkVuDsD+5RgebyHG8trdjQ1iH2PFflyToqbuBabO+XiM3TZTURAcrD0eMEgZc1Ra+43nt3U4BydCunLGHtk8H1eDpxw9JCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721934; c=relaxed/simple;
	bh=CYBzAZFTyzmb6hggfsw/b7D6cAemmYBcXvFtzcbio2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMYX9hrzzOnNzB61aD20OJdvyj0vBdSLPd19jou3sIIqQq/mDhhi6RSC9G7YT1+/+EAcbjM4NsCsTVBLZQJQKZNtfuh3ey1t2tXjQ8wPSJ5u8AfXKHrQA4OUVbV5HdOCchYaj/cD6l8RlatdrXOq7ZXn7hR9zS5+JOigI5VkpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D6VJuant; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ob2CofzcVDa5VODE51Zj00tIwAXD9lHlKNmQKWKsiEk=; b=D6VJuants4ilbPGywyZDgfYMEX
	8llmEi5hgb82virJF/mruFnOXeNfg3hLmK8x95YC1riFop1tGatFJOt/UQE82oAO8uX467MOGu3ie
	5/f3AqqD2dM+AUoUhtbVjmaS+NdntfLJOBrwD0+NaRHHqxhm3zmIXnONIEU/Xld8/MbvQxxObrYTM
	74bIPyiG6LlvmjoukU2uOC5RLt9gA5y1IlXZu/TFQrhVvEyRXtLDr9P78qKitVx2bJ7QTDtnM0Gvj
	l2pquT2mN0vYcUT2qX+WFZ3v/9nWkxSSHKvc/CSJgsjJkJLIuIfPlDyHYvZArQUXGVmV+1hSAejYs
	x1Y4e3NA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1Pue-00008z-2M;
	Wed, 24 Sep 2025 15:52:04 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1v1Pud-0007D9-1j;
	Wed, 24 Sep 2025 15:52:04 +0200
Message-ID: <b8ad075c-c478-4239-bbda-148e6d4d3c3c@iogearbox.net>
Date: Wed, 24 Sep 2025 15:52:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: task_work selftest cleanup
 fixes
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250924115700.42457-1-mykyta.yatsenko5@gmail.com>
 <20250924115700.42457-2-mykyta.yatsenko5@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250924115700.42457-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27772/Wed Sep 24 10:26:55 2025)

On 9/24/25 1:57 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> task_work selftest does not properly handle cleanup during failures:
>   * destroy bpf_link
>   * perf event fd is passed to bpf_link, no need to close it if link was
>   created successfully
>   * goto cleanup if fork() failed, close pipe.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>   .../selftests/bpf/prog_tests/test_task_work.c | 21 +++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> index 666585270fbf..65c4efd05e9e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> @@ -55,8 +55,8 @@ static void task_work_run(const char *prog_name, const char *map_name)
>   	struct task_work *skel;

[...]

>   	struct bpf_program *prog;
>   	struct bpf_map *map;
> -	struct bpf_link *link;
> -	int err, pe_fd = 0, pid, status, pipefd[2];
> +	struct bpf_link *link = NULL;
> +	int err, pe_fd = -1, pid, status, pipefd[2];
>   	char user_string[] = "hello world";
>   
>   	if (!ASSERT_NEQ(pipe(pipefd), -1, "pipe"))
> @@ -77,7 +77,11 @@ static void task_work_run(const char *prog_name, const char *map_name)
>   		(void)num;
>   		exit(0);
>   	}
> -	ASSERT_GT(pid, 0, "fork() failed");
> +	if (!ASSERT_GT(pid, 0, "fork() failed")) {
> +		close(pipefd[0]);
> +		close(pipefd[1]);
> +		goto cleanup;

Here we go to cleanup before skel is initialized.

> +	}
>   
>   	skel = task_work__open();
>   	if (!ASSERT_OK_PTR(skel, "task_work__open"))
> @@ -109,9 +113,12 @@ static void task_work_run(const char *prog_name, const char *map_name)
>   	}
>   
>   	link = bpf_program__attach_perf_event(prog, pe_fd);
> -	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> +	if (!ASSERT_OK_PTR(link, "attach_perf_event")) {
> +		link = NULL;
>   		goto cleanup;
> -
> +	}
> +	/* perf event fd ownership is passed to bpf_link */
> +	pe_fd = -1;
>   	close(pipefd[0]);
>   	write(pipefd[1], user_string, 1);
>   	close(pipefd[1]);
> @@ -126,8 +133,10 @@ static void task_work_run(const char *prog_name, const char *map_name)
>   cleanup:
>   	if (pe_fd >= 0)
>   		close(pe_fd);
> +	if (link)
> +		bpf_link__destroy(link);
>   	task_work__destroy(skel);

Passing in uninit skel to task_work__destroy.

> -	if (pid) {
> +	if (pid > 0) {
>   		close(pipefd[0]);
>   		write(pipefd[1], user_string, 1);
>   		close(pipefd[1]);


