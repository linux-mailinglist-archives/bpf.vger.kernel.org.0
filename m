Return-Path: <bpf+bounces-36255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA49456B7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 05:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3142CB23319
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 03:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4D17BB7;
	Fri,  2 Aug 2024 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fGxeuiD8"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB861EB497
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722570212; cv=none; b=uPQGW2Lsns7kiGxbr2utTbXsyQJsWYpNl5exrwm3Nt4vk6KmDpU7oDyrwUHbE7HpJE3wAfXsNXZ3k20Qn8ZdGcxbdDnjhGZQvnXNiHyUSaGKFB9oFjgNUmeaGoQCwFiM7n4lQ9x++oCOlXQ8a0svh3M05DNh3Tr1njwURB3kW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722570212; c=relaxed/simple;
	bh=oEA97ScR5S/bpOQgHnMIK8VHPuwopWM9y2KlzLgI/GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i183vF9h93emswk+EbYOvMljMSGhN72l2Ez+S+nezgpzIEdAKjuXG0ksbYwYClhEpt1CGC06ohTZ0jNDA9gZM1Z7Pt2230QjqI6y+RS/zFWqN27GdvXXcpq6TIBQDcDQCFSiPGRjKCHPrizTTeD3Vne+5z9Gd9zTEm/0xr4oN+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fGxeuiD8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <feab44ce-8218-4e9d-a3f8-8d7109ef32e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722570208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdpxnHNqgQNKt+cIPg4VlxOx1x0blbTdJu4vfXyBDhc=;
	b=fGxeuiD8yd3oiw9QaAC8048lxZ/qwJGLLiE5Gdzv3DySKN0H0WdtGj4m37WLKBtxUzrBFK
	0h+ng+1W3YsTIgjb6tQOWy018HVUaWS7ltQtbT9bXu5LUnvgAXkiVPf8UAXONg6w3ApYI/
	SZQBqAL6V/Gdn2uITiUjcfHQ8qRDUyU=
Date: Thu, 1 Aug 2024 20:43:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240731193140.758210-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index cb9d6d46826b..5d4e61fa26a1 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -473,4 +473,20 @@ extern void test_loader_fini(struct test_loader *tester);
>   	test_loader_fini(&tester);					       \
>   })
>   
> +struct tmonitor_ctx;
> +
> +#ifdef TRAFFIC_MONITOR
> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
> +#else
> +static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns)
> +{
> +	return (struct tmonitor_ctx *)-1;

hmm... from peeking patch 3, only NULL is checked.

While at it, if there is no libpcap during make, is the "-m" option available or 
the test_progs will error out if "-m" is used?

> +}
> +
> +static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
> +{
> +}
> +#endif
> +
>   #endif /* __TEST_PROGS_H */


