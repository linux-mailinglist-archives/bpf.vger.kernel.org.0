Return-Path: <bpf+bounces-36506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E026B949A56
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9551C21A96
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A363F16A943;
	Tue,  6 Aug 2024 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h2l/i5Pi"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3B14F9D7
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980578; cv=none; b=l5qKGYZ+STDGoH1tCmmpwyyfAkETEYWjGWBJmiCEVfhQJGHi4R4Gh3r00iRRpgsYzprvz4qK2IMyMdTd18Kikc1B7pkA4b2HFLSz5mCjyt7KZXIBxub6JRnmIW+y8gJs5sXHLV9CvM1j28r0nLZqwSOY7SEBtO/64UEcrvJ3Lfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980578; c=relaxed/simple;
	bh=xjtWOkQa6cfBhgyEAyZAXi3pixOekYEgZHCMIUzPRq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ts7RkZqdrQ2F6eEePFEMCLWcWKbkv5tJgdwqJQ6NeQtMVSozrN2zSH/6+L6LJt1E4fybCM5g7S9e/rBG7Bp9G4hYtzIWRkSMRRT7oa6I65N6+TMP9STCJ0mZCBy5mrzLa7MxL74O6+wQoCLwLD3rWCEmDCRQw9sCLnfGspqq0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h2l/i5Pi; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0fa4647-5779-4421-b5c2-e22915f39252@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722980573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgOmMq7t1Crwvq8XfFnHhtfRchofbM9hWJ5x4UKCxJY=;
	b=h2l/i5PiaR4ygzVql/2Qf2n8c/FaQPwnJFm92Oh8CKHdgQr/8ynnpctIS0FRNFCdl37WR3
	zDfQ3v9fQknOjOd5JMl5PeqSQrAMr0zHoKt0XCDTNaaovkXj0qvT7Ln1wcFc3zC12MX1KP
	XzG2NTO+0Iyr5wTddFJtltpCoSXA8bM=
Date: Tue, 6 Aug 2024 14:42:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: modify bpf_iter_setsockopt to
 test TCP_BPF_SOCK_OPS_CB_FLAGS
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, bpf@vger.kernel.org
References: <20240802152929.2695863-1-alan.maguire@oracle.com>
 <20240802152929.2695863-4-alan.maguire@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240802152929.2695863-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/2/24 8:29 AM, Alan Maguire wrote:
> Add support to test bpf_setsockopt(.., TCP_BPF_SOCK_OPS_CB_FLAGS, ...)
> in BPF iterator context; use per-socket storage to store the new
> value and retrieve it in a cgroup/getsockopt program we attach to
> allow us to query TCP_BPF_SOCK_OPS_CB_FLAGS via getsockopt.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   .../bpf/prog_tests/bpf_iter_setsockopt.c      | 83 +++++++++++++------
>   .../selftests/bpf/progs/bpf_iter_setsockopt.c | 76 ++++++++++++++---

There are too many code churns to reuse this test to test a new 
TCP_BPF_SOCK_OPS_CB_FLAGS sockopt. This is not the right test to reuse. It was 
created mainly to test if the tcp batching logic can survive the bpf-iter's 
seq_stop.

I don't think it needs a separate bpf_set/getsockopt test specifically for the 
bpf iter prog. The test in patch 2 should be enough.

pw-bot: cr

