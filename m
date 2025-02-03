Return-Path: <bpf+bounces-50331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD05A267E0
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F258162A99
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 23:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32D20FAAB;
	Mon,  3 Feb 2025 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVJMBC3+"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B31C3BEE
	for <bpf@vger.kernel.org>; Mon,  3 Feb 2025 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738625027; cv=none; b=qF7VuMCRoBqxTk/ZdvsCfKyi+9mhyHA8FT59T2nkB8zhJk7bMJrlsnlGLcv9fyc6yK5/vw9XMmYnsUTO2JcSwBipD+RBAixXshb8Fz6gJAJF34H8tR/sweo+vqKnuUmYPMIEJuRtxlJz0V2HN9hND9ifqPTZKCrdE/bJwfY250A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738625027; c=relaxed/simple;
	bh=pqBnQl0l5OV6fN+nZIF3hWHtjZaYHJizasP7hYkazZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9uKmr6iK2klP3YkDiy1nXSLBj4wxUu7eeQ/GMs4iCHRI3DHX5VNt8hYQ+ZITzzG0/rcM0Dp2AwE7aTHfi6om1KwfrAMTQso8UJi7/A6WiMP8mKBO0OLWE0H0UkyPQ7wfUJznhZOcXpEOP1V8E4tKeviTl6cc1cDYTazR5Coyb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVJMBC3+; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2097d7a3-97f0-4c79-8f82-aa7e2b7d9d2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738625024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScKVwP1rjUIoXlpeuJRESuEL660BuJpKn/RntpGzSu8=;
	b=YVJMBC3+CThKa5Y9QO1tMQCm3OedMclPfGtbTlq5o6hTvInJ4vklz+w53AGeYL7JLWVYp5
	U6RDt09f2ERidjKE1/FthO8GvYT5T0QL8jbuMxac6XrUfKz05/kA+jgy0Jfzx8krqu2Ibz
	ggdVy7B8EAKeXtGiZoVT3mfd9nTJPyE=
Date: Mon, 3 Feb 2025 15:23:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 06/13] net-timestamp: support SCM_TSTAMP_SCHED
 for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-7-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6042961dfc02..d19d577b996f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5564,6 +5564,24 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
>   	return false;
>   }
>   
> +static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)
> +{
> +	int op;
> +
> +	if (!sk)

This check is redundant.

> +		return;
> +
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:
> +		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	bpf_skops_tx_timestamping(sk, skb, op);
> +}
> +
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		     const struct sk_buff *ack_skb,
>   		     struct skb_shared_hwtstamps *hwtstamps,
> @@ -5576,6 +5594,11 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   	if (!sk)

It has been tested here...

>   		return;
>   
> +	/* bpf extension feature entry */
> +	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> +		skb_tstamp_tx_bpf(orig_skb, sk, tstype);

...before calling this.

> +
> +	/* application feature entry */
>   	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
>   		return;

