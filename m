Return-Path: <bpf+bounces-42112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF099FC9F
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 01:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C16D2869F2
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD51E32A9;
	Tue, 15 Oct 2024 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eyq8ShRR"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4891B0F2E
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036458; cv=none; b=AVyc8uJYpvCux3NztBo8WZexHeg8252D2rUutLepgTD0l6e1vQQhoQvKZorqXv9LY/QexCX1c8iRGDh1mbTLbG773aCuR2IbDnpgLucbSSh1Z1dxLKYyFyIMjxk/Ru1qVf+abZ1DzDtmWhvn17TwPAS9yoopCx/R5b9PiP/FCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036458; c=relaxed/simple;
	bh=EaqPW5MElTLXlWTNLSLu6YuZsmhwHN1uGj2YHufSh3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZ422BXwlN/u9c+1liQrXJ+sUSZ2yWjGn8w/OX0kb011D+gJQeAw6UGzYhrSsNNDGgMPVuAM+BEmXeceFHrFzpUJZkyo6abRxMuVqQiIPvn08+alfhOsRclu+7oZ+1Cb8eFp8BakfXZoJIpB9srn61/929Nz4qDZS+EkWM2U/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eyq8ShRR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <93fe5cf0-1e22-4036-a6da-b39e0046e16c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729036454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sJovGkLaqDcW3mFVfFBSshuN7qTkIUyyEMhj6h1N7Q=;
	b=eyq8ShRR8PD3EoMEzGO8EsKCFelxPPxVfxqylkfgrBE3rV6kRVyrrLXaB3ueFGQgt+LIYL
	b2W2pOazMbXw+LT99ydluq/6Trr8S9BfD62QcG6B4/8me+bzyDkUl7jKHOHQOqGfIRb973
	rdEDUzYM4KYU1a3N6cwqxw1FWYQYiHs=
Date: Tue, 15 Oct 2024 16:54:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for
 bpf_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241012040651.95616-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/11/24 9:06 PM, Jason Xing wrote:
> +static int bpf_sock_set_timestamping(struct sock *sk,
> +				     struct so_timestamping *timestamping)
> +{
> +	u32 flags = timestamping->flags;
> +
> +	if (flags & ~SOF_TIMESTAMPING_MASK)
> +		return -EINVAL;
> +
> +	if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
> +	      SOF_TIMESTAMPING_TX_ACK)))

hmm... Does it mean at least one of the bit must be set and cannot be completely 
cleared once it has been set before?

> +		return -EINVAL;
> +
> +	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> +
> +	return 0;
> +}

