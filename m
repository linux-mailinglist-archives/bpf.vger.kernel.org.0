Return-Path: <bpf+bounces-57144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A025AA6362
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A104C1B17
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCD72248A0;
	Thu,  1 May 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxdF0+ji"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D48174EF0
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126049; cv=none; b=Sx3eJMnhzQnPcG+aHre4m78jFAzynQrpv+6Yu0M36tZokuJuIrcm1RjKF+VKZlE9nLj1xDibP96jgFQ6TZHassqZN3IrP/Z6+iqQ2rmT8U36VUd1hKqtmhbIY09hyHZREiNncQ4K37ukdhM30pm4V9/fe0K28k43xi2RdW0/mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126049; c=relaxed/simple;
	bh=swxoD0CDHWRKMTi6y+LmYMtOp+D0ypJ48EMOCRrz2fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYkXOf4SIQBGQCjQz/e/g1C68hqxduc3jcOUQ2pEcZ6nsr4wB31UzyiELJ6ZfKx7y2UkC2h1nr3G/VKhgom/27cqN14A4PeRsFu5Alag/uIdQ0mqqc+3sLdRZkWh+dRTR65olc4V0Ueh5qBTJ0RVufUGDGMU4sXs42CmSp4ZWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxdF0+ji; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77e7b3b4-a6c3-442a-9fec-884382a3153f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746126044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaEQbz4bHG4R9G3Y7olWJlc70DZXxZViJLO1fX8M43U=;
	b=FxdF0+jiFPfXUJVI6PJM6sSNDxjle86rtWcJhKTbPSOiNMDkThvZaAD+f8aDETr7kHxpt5
	aDw4vbmiXDCy2Ey/TRxdJZrEs13iq4hnc0d1NfZcgZcVbL2gtWf3xmoOM+LC4vhpVxJMsq
	bKhwECE/G7BTkFkyvGL2UQQEpgP9sRM=
Date: Thu, 1 May 2025 12:00:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 7/7] selftests/bpf: Add tests for bucket
 resume logic in UDP socket iterators
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250428180036.369192-1-jordan@jrife.io>
 <20250428180036.369192-8-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250428180036.369192-8-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/28/25 11:00 AM, Jordan Rife wrote:
> +static void do_resume_test(struct test_case *tc)
> +{
> +	static const __u16 port = 10001;
> +	struct bpf_link *link = NULL;
> +	struct sock_iter_batch *skel;
> +	struct sock_count *counts;
> +	int err, iter_fd = -1;
> +	const char *addr;
> +	int local_port;
> +	int *fds;
> +
> +	counts = calloc(tc->max_socks, sizeof(*counts));
> +	if (!counts)

ASSERT_OK_PTR.

Overall lgtm. In addition to avoiding the skip/repeat, the code is also simpler 
(e.g. the st_bucket_done and offset state are gone). Thanks.

> +		return;


