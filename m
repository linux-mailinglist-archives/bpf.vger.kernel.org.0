Return-Path: <bpf+bounces-61957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B389AAEFF11
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6673D5225BB
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6AF27AC35;
	Tue,  1 Jul 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WUuDIIM4"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FD27A92D
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385808; cv=none; b=h66yYiSNFDKqmJk41x9Wznc4m7FfIRARNyswsisE23v8P5HQPYilHLO7BUSAddjPXL2p7OYHyMzXsg1qSW1+YcyptkqR+Z0wvVADhaFfZzOE0XKqQwCL2KZxqsKtkwS1wOrZIGKvwvjvkfhL9mawCehDEqNK/K5XiHC6eqTWFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385808; c=relaxed/simple;
	bh=JFHhiKG+5od4Zz/YIQDgOWE3Fs2lGwGO4JlL2+Cp8j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaZXUu19y4vHIPOgMa7up+2Nv5iyI5tp8jznVzM5XZ1taJuU0JIlVUvvYbd8KsaOckDI/AeDc6qPj9I6Laq0jMGxmU/JLGsHhX7pj6juSLEbaqTyuBi19StupBc7rgX+5EO7XDZ9iYFIN2guF+RkCMC87Ac4VJlSmmaa5J/xP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WUuDIIM4; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <387dd87d-ef1b-415d-bfa2-1608dce65e32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751385804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6VuJKbNNqzzwWr+JfCNe+N+Vl0Gzz0xdQK+JM2V6es=;
	b=WUuDIIM4piCKOHU52X8592s3/jw3i3Oouo1qIS6TZ7tVSJQcc5rLvCykNpSbOnsCp5QUmJ
	xk0wBovx0kPOw9K2dbqGJ4OH7lO3o38CCT0oOwzDuZlj/RYstDYdfSV2KTgpoOLR9350+b
	Ef9Pq7sNWl2kdIk+67CbXlKsaJqEeCg=
Date: Tue, 1 Jul 2025 09:03:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add negative test cases for
 snprintf
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Florent Revest <revest@chromium.org>
References: <9d7c0974af8ab9b99723bd3f72d4bea8972d7cb5.1750953849.git.paul.chaignon@gmail.com>
 <30ed8c0add8d08c22cec95f302d85d2e4a2dd760.1750953849.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <30ed8c0add8d08c22cec95f302d85d2e4a2dd760.1750953849.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/26/25 9:07 AM, Paul Chaignon wrote:
> This patch adds a couple negative test cases with a trailing % at the
> end of the format string.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/prog_tests/snprintf.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> index 4be6fdb78c6a..594441acb707 100644
> --- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -116,6 +116,8 @@ static void test_snprintf_negative(void)
>   	ASSERT_ERR(load_single_snprintf("%llc"), "invalid specifier 7");
>   	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
>   	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
> +	ASSERT_ERR(load_single_snprintf("%p%"), "invalid specifier 8");
> +	ASSERT_ERR(load_single_snprintf("%s%"), "invalid specifier 9");

The above "%s%" test already succeeded without Patch 1. It would be
good to mention this in the commit message to avoid confusion.

>   }
>   
>   void test_snprintf(void)


