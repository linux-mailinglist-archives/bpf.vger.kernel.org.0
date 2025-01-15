Return-Path: <bpf+bounces-48993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531AFA12E8D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8863E7A1998
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9577D1DB366;
	Wed, 15 Jan 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pDCtdWpY"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077C1DC9BA
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981353; cv=none; b=i7Hu8w2M/AWLKYZFnXfogrgESS0Z3E1N9jnCpbMFn5Xq6fz7iwVi7By5P9yrEAANbLVvVOT3HFZY1wKxoXaSb9XrvqRntq3v494TQZeQDwT6yzvPl7xgRfzzS1F7FffakPcTlGSU3c44sBS6yQcwk9I6jhPrI8yW1MGGpKjoROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981353; c=relaxed/simple;
	bh=jiSH/bfbegEXtTGAYUT/sOsQMnkvmuSTEAIVnsFkP1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY2VqtZ12PoMMfHN+pWLx31i/JIjgystvWzeQ39rZyd5OfbDq9BCgMY0dyXu/OzvfkZvMeEIEvJtNgffGbtVKsIJePdWvt2Pi4r/byonslMsGAkcvZ8dJlq8gcUYnIvk+39a+njpvLMAFlrhofeb2RRIeXnaSDeQArWAtRpqNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pDCtdWpY; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef391d15-4968-42c6-b107-cbd941d98e73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736981337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEYCmuqYP0cjDEBQZe4V8Y2BHG78JX9bxQWg8ucTrBM=;
	b=pDCtdWpYskkXYXc0YnrriAy5IyevA/OS24t5qbhMSbsR6s1Sm4yVF+JI1qEwpNZQoaog8u
	ipH3EL5K76HSrJjWybb+VawhDXtA76PyCgORPYACJgLj6L8HuR8uUaI5cyLhYAbDCQdfuS
	DajdbSR0rJ7lmEy3OJ5VwqRrlPlQRuw=
Date: Wed, 15 Jan 2025 14:48:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 08/15] net-timestamp: support sw
 SCM_TSTAMP_SND for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-9-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> Support SCM_TSTAMP_SND case. Then we will get the software
> timestamp when the driver is about to send the skb. Later, I
> will support the hardware timestamp.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 169c6d03d698..0fb31df4ed95 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5578,6 +5578,9 @@ static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype
>   	case SCM_TSTAMP_SCHED:
>   		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>   		break;
> +	case SCM_TSTAMP_SND:
> +		op = BPF_SOCK_OPS_TS_SW_OPT_CB;

For the hwtstamps case, is skb_hwtstamps(skb) set? From looking at a few 
drivers, it does not look like it. I don't see the hwtstamps support in patch 10 
either. What did I miss ?

> +		break;
>   	default:
>   		return;
>   	}

