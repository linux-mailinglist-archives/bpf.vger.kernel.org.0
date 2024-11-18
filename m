Return-Path: <bpf+bounces-45102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF79D1581
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10411F22064
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985D1BD9FE;
	Mon, 18 Nov 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q/fOt4HD"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C21BD51F
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948055; cv=none; b=UfkG35u6uLPUx7rR3BY+6ZyHN5HN45lnaxi+rwyTXJXQUKffzHYdDTNzI3SSXgBKnx/g/puowuK/nyb6FfXqW8CL0F9wRQKcVaLP1U0oyoNgXfBD+YEi/1cjQq7+Gl8sWGpxXkqPTj/yRI+DF1sCMB+4rShtAxSFqq7GsqHYF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948055; c=relaxed/simple;
	bh=cbTNluZDGlJlXeR6eDJvBnU39wu6Y44zf+cWF1SHq4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlKat01gva3wsEReGj01xxKQUMfyGcM1uits06MDkLzhLO5V8fHHUtDN4OQgiEN5p+qRVN3xpmXzvxvKl9PBYVAWxO7TLomTYIW9AAVxc+jZd3hEJ1AIuMB28Y+bgcIAu1OF7741qCwpkx1ev4p+8uLZBBSGC+3yYZju7wQGDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q/fOt4HD; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <37c96a19-6e90-42f0-be42-b00d9b78adeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731948050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTQfc30/GXtGrxH2JiH5sirzfpXiYh8hRmO+Wd+V2y8=;
	b=Q/fOt4HDUg4IcdS0/tfbRsc12nvQgaYtS6zaaz63VpEpjGH5bynUeD7sYfmfTpG3QawK7G
	9d3pZy1MeWttRSL5xOjvlc51pemEOTZPI3OdncvI7jRMNHpQ0+aYuCItyDNFdez75Jd30V
	AzpCtW8XfiVFFBvyJVil+fSRyVYc0L0=
Date: Mon, 18 Nov 2024 08:40:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Remove unused variable
Content-Language: en-GB
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org
References: <20241118093440.2818-1-zhujun2@cmss.chinamobile.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241118093440.2818-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/18/24 1:34 AM, Zhu Jun wrote:
> the variable is never referenced in the code, just remove them.
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/log_buf.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> index 27676a04d0b6..5d1678b15d8b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> @@ -191,7 +191,6 @@ static void bpf_prog_load_log_buf(void)
>   	ASSERT_LT(fd, 0, "bad_fd");
>   	if (fd >= 0)
>   		close(fd);
> -	fd = -1;
>   
>   	free(log_buf);
>   }

This patch failed to apply to latest bpf-next.
   $ git apply ~/p1.txt
   error: patch failed: tools/testing/selftests/bpf/prog_tests/log_buf.c:191
   error: tools/testing/selftests/bpf/prog_tests/log_buf.c: patch does not apply

The reason is the above 'fd = -1' already gone:

188         ASSERT_OK_PTR(strstr(log_buf, "R0 !read_ok"), "bad_log_0");
189         ASSERT_LT(fd, 0, "bad_fd");
190         if (fd >= 0)
191                 close(fd);
192
193         free(log_buf);
194 }

> @@ -259,7 +258,6 @@ static void bpf_btf_load_log_buf(void)
>   	ASSERT_LT(fd, 0, "bad_fd");
>   	if (fd >= 0)
>   		close(fd);
> -	fd = -1;
>   
>   cleanup:
>   	free(log_buf);

There are more redundant 'fd = -1' in function bpf_btf_load_log_buf(),
you may want to remove them as well.


