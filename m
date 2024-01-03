Return-Path: <bpf+bounces-18840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C6C82260D
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFA1C21BB7
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309B171D4;
	Wed,  3 Jan 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wsvPl0Fa"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF1171C8
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704242526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWuR+5lv5PYCX5iNY8fEAzOxuY3biWLay6PfqBzpAS0=;
	b=wsvPl0Fa3s+BOHjZHEdZtw2sMlGNEJKn4moEyY2znrsep3r4fObooKc7sUNNcY1izThMih
	vW57U4OkNQZ+qCnGj1hfMP00rFZ/89ZMcx9iLoF0p59luMEsrBNCURvQztcIkoAqWCCjhz
	QNHUXeG6BbZh583eAi+l4agFRHcaXHs=
Date: Tue, 2 Jan 2024 16:41:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Double the size of test_loader log
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
 <20240102193531.3169422-3-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240102193531.3169422-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 11:30 AM, Ilya Leoshkevich wrote:
> Testing long jumps requires having >32k instructions. That many
> instructions require the verifier log buffer of 2 megabytes.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/test_loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 37ffa57f28a1..b0bfcc8d4638 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -12,7 +12,7 @@
>   #define str_has_pfx(str, pfx) \
>   	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
>   
> -#define TEST_LOADER_LOG_BUF_SZ 1048576
> +#define TEST_LOADER_LOG_BUF_SZ 2097152

I think this patch is not necessary.
If the log buffer size is not enough, the kernel
verifier will wrap around and overwrite some initial states,
but all later states are still preserved. In my opinion,
there is really no need to increase the buffer size in this case,
esp. it is a verification success case.

>   
>   #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
>   #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"

