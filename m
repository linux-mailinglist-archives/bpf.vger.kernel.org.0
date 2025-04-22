Return-Path: <bpf+bounces-56376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFCA95C9D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 05:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716E2176D66
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC515098F;
	Tue, 22 Apr 2025 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mvfrf9Mq"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F261F92A
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745293689; cv=none; b=kybpiZfy+C+L2H1UdiTeBvScEEb7BI42wq8E2q4k2TzfP6ybcqcMAG1UIaDk0E/GxyyMXkV9g1/dLFQxjcRZ/GY9xgr4YQ3EuuBHDaO/7WVRsAr8GF0XxQYGn/MYIpqwbfhWKw32uasZ1EKEe53Qvb0w/WSl+XfpzZZcuY+6Ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745293689; c=relaxed/simple;
	bh=G7vzUSQq4EdTbRpV3cT6/T4Ye2LenWWEj8g9fAdleSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKXTItT6JYdGV2qsdtFamano8nEd5JDkZRyTjr+bEtq2hAZdsH9awwCiCUAoJBauNFhVY+WaPYDTJ86OohY8eo0yDFsrOSjFfthMt1uEO7OU9I6rspUVXrqp96uFBbDZdYqvEJ6abE5hT3kCmFQlXdR7oNkRE1sb4evio84ucBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mvfrf9Mq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11f8a2b3-ad4d-4e59-b537-61e1381de692@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745293680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJJ8zOuJRaeaBCUDDtT5H5CNBrXaLTCynq9UCqphlkk=;
	b=Mvfrf9Mqrcq/2AhrYdeEk7kN0WoxRCRumzttLrNCJSzF1Kv9WzLs0Fk70KaCnEXS0CO11L
	430iHGTId52z+PGLWd+4LpcsUsjpbIu1+D2LMaHnk/YIXqi9m1KZ6f0l5Rr4ihrqW+kF7X
	vfw7Z7ZEaE/R25mxatrjBOq2LhWqxJ8=
Date: Mon, 21 Apr 2025 20:47:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250419155804.2337261-1-jordan@jrife.io>
 <20250419155804.2337261-5-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250419155804.2337261-5-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/19/25 8:58 AM, Jordan Rife wrote:
>   static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
>   {
> -	while (iter->cur_sk < iter->end_sk)
> -		sock_put(iter->batch[iter->cur_sk++].sock);
> +	union bpf_udp_iter_batch_item *item;
> +	unsigned int cur_sk = iter->cur_sk;
> +	__u64 cookie;
> +
> +	/* Remember the cookies of the sockets we haven't seen yet, so we can
> +	 * pick up where we left off next time around.
> +	 */
> +	while (cur_sk < iter->end_sk) {
> +		item = &iter->batch[cur_sk++];
> +		cookie = __sock_gen_cookie(item->sock);

This can be called in the start/stop which is preemptible. I suspect this should 
be sock_gen_cookie instead of __sock_gen_cookie. gen_cookie_next() is using 
this_cpu_ptr.

> +		sock_put(item->sock);
> +		item->cookie = cookie;
> +	}
>   }


