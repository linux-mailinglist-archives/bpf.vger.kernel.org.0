Return-Path: <bpf+bounces-57292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB03AA7B63
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CE14C53CE
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F64202998;
	Fri,  2 May 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJW33cCQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB121F2365
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221496; cv=none; b=p0vkczymiqaaVVocaOvZTx/WnSRalEK2A18UO9iVvG02ycmfVIDwLw9wDpmnlJLY6IqTgkRX5oWHTzfS1MRXk6oAK3wgC5PhTNaYraPbAfeIQJ10+9RzjzTFOWbpclZJi50OAqVEcA2NDKczfKUwZIR/ypn4Q9jPymeeuY6AV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221496; c=relaxed/simple;
	bh=fO83jngm4I+8NcFnovYW3J2Nl2BVgEK5gRt7cR1a8m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3R5P6o29m+s4wxviVthXA13xDx+vadfHkbUHKPTNfjFJcLuO5yW5hSHy5BF7D97klbyZkcSG34wMPRjMdcW5YR3ItsBrZIPZw5TbuNop0rCSFZ+2EogjcWPsqpBdtiREbBJ8XaliNpfO+GtX1xUP9A99Q6CZKYLXEtph8q4zmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iJW33cCQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35aee73f-171c-4c64-9144-ff97afd8801c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746221492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vm2HtaUa4lsM1mZOYVFFrWZAlxQrKgy52YQ3FmHDcHI=;
	b=iJW33cCQkusBm/ILZY3pDjmkY8h0yGTNs8GvLGa4bw7alleMj+jz8jxB/61w5W22nN0ZPV
	iM72Ni6NC7bADzX/iwtmehOrmv9CIFvWErlzn+SS0lEbYa8Kcs4DHKK6tWVL0x299Be7Xs
	7val0UqNNEc7qGAulJNSr+q/P/v5ovM=
Date: Fri, 2 May 2025 14:31:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 1/7] bpf: udp: Make mem flags configurable
 through bpf_iter_udp_realloc_batch
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250502161528.264630-1-jordan@jrife.io>
 <20250502161528.264630-2-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250502161528.264630-2-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/2/25 9:15 AM, Jordan Rife wrote:
> Prepare for the next patch which needs to be able to choose either
> GFP_USER or GFP_NOWAIT for calls to bpf_iter_udp_realloc_batch.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/ipv4/udp.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 2742cc7602bb..6a3c351aa06e 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3401,7 +3401,7 @@ struct bpf_udp_iter_state {
>   };
>   
>   static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
> -				      unsigned int new_batch_sz);
> +				      unsigned int new_batch_sz, int flags);

I also made a minor change from "int flags" to "gfp_t flags".


