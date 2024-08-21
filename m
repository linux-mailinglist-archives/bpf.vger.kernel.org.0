Return-Path: <bpf+bounces-37661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C39591A0
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 02:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D481F227D0
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BBA139B;
	Wed, 21 Aug 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U9OoAIsS"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B4EAC0
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199119; cv=none; b=rDqc+R8Ld3iTHdSYwT3LyUM1/7QUCs0CLdrnaLhZKXNlubh5xAfUyblvFhu7DKmJY2vOvHJV2nAW7Gomfw/PrfS3whpa6T7OJKcR3c9uoBQLXqKvhuwpkSYg/f3fTXPRVWSIkGNoPbPpH41hM2CM0f9giC1fi3epKoMkZ/Sw8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199119; c=relaxed/simple;
	bh=HLdlsUzUS7CbOZv77pFXbEfp1QE8U6wgysmv52Vsn7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8nxG93T7PO8UQG8Finl6JAB5rEt5223VbBV2XOCOuYI78z9Cf5wBbTYXJg4u7HxjU69qjZxqh3mPdOfmbzriGoiyGpl9T3NykRB/WEovP9qmv4qRO/vaqU1pLWY4k7jB6sU8dOl7xPl9fWn/B4RBbvlLEtFO5k+BRL2To86If0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U9OoAIsS; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <823a9e15-ec42-4c6c-a0e9-56ec63b8936b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724199115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mn2KYsI8AYo0tOU9C4z9EuSQ5Kf7XsZuzozS54S6WLQ=;
	b=U9OoAIsSG0WOxRluqIIxGVDKDanbwF7zDqTzSjbvtp1KaU7xavylAjDrMc7yN+dt0FwJMJ
	vJY4Bh6xxfvL0IH8pZOsLv0tPZrv6cxqZBGWKfRpScK3rrSZSp4GZIoZwLv0AlqtmxbU2a
	/y5m1JOD4BgIqBa1ejLf9yKqIfcKxWA=
Date: Tue, 20 Aug 2024 17:11:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next] selftest: bpf: Correct mssind comparison in
 test_tcp_custom_syncookie.c.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240819194247.27491-1-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240819194247.27491-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/19/24 12:42 PM, Kuniyuki Iwashima wrote:
> Smatch reported a possible off-by-one in tcp_validate_cookie().
> 
> However, it's false positive because the possible range of mssind is
> limited from 0 to 3 by the preceding calculation.
> 
>    mssind = (cookie & (3 << 6)) >> 6;
> 
> There's no real issue, but let's make Smatch happy to suppress the same
> reports.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> index 44ee0d037f95..36b842133033 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> @@ -487,12 +487,12 @@ static int tcp_validate_cookie(struct tcp_syncookie *ctx)
>   
>   	mssind = (cookie & (3 << 6)) >> 6;

This should have bound the mssind.

>   	if (ctx->ipv4) {
> -		if (mssind > ARRAY_SIZE(msstab4))
> +		if (mssind >= ARRAY_SIZE(msstab4))

Does the verifier complain without this if check?

>   			goto err;
>   
>   		ctx->attrs.mss = msstab4[mssind];
>   	} else {
> -		if (mssind > ARRAY_SIZE(msstab6))
> +		if (mssind >= ARRAY_SIZE(msstab6))
>   			goto err;
>   
>   		ctx->attrs.mss = msstab6[mssind];


