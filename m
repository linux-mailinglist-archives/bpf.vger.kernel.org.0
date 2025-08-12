Return-Path: <bpf+bounces-65421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C6B224EC
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 12:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A7217477F
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BEC2ECD3C;
	Tue, 12 Aug 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kuUad/oi"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123C2ECD1C
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995663; cv=none; b=PhRmy2SdsXzvT6aKxdCAJJr/YWYicneNfH0bUG8ZkaYt6uGl8i8uuezQlObSA7y6SdYmFi5wThm4WTsnDs1bHU7UDMCredwMt/4oNBRfEkWwvKVR3NU3JkFPLURDg+0njmv3sLgU8X0EmEQJDpnB6nQicfTPKBXhRUdqY1s7Q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995663; c=relaxed/simple;
	bh=vWJzRn9K7yU/3QENsPPnkZtrnoY9uRJHYLmCQ2rjCXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7r7NL6E/D1K55nGCZueGoLv1ib5azQ+8MP6oNP4ssAnRzcCvstPHNve640ljZMGPdCmbDEDpEPdZCuCx/t4XbPu/OLniuQgfN6rB95bEOLgr1VSzs7PBMZ4FpQrOZvBHnQk1WnwCpZrvJc7SVZ6WpnvAFssdWH3yG/rfPvYh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kuUad/oi; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a3ffacd-bae8-4ca6-85a4-4369b687e718@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754995649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Scp50z0Dvu6B20Ahy9Y1eBh5Yz0aoN/w1llqkMOJ0Xc=;
	b=kuUad/oiCn5L3tw8efKsiaQVTU1OU1PaNXRFnkMBSx12Yb+4alkVRPw51+VHIClz/aa/wU
	0DH0MjV3VSuH3eR6On6Jj147ghU//xt7mFbptMp+dXlYGkwtijvYz3w7pD6DCFGDFiBJkP
	vUopPdPXlRp409XJm4E/rq0SE+ZiIwE=
Date: Tue, 12 Aug 2025 11:47:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V2 1/9] eth: fbnic: Add support for HDS
 configuration
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 ast@kernel.org, bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org, horms@kernel.org,
 jdamato@fastly.com, john.fastabend@gmail.com, kernel-team@meta.com,
 pabeni@redhat.com, sdf@fomichev.me, aleksander.lobakin@intel.com
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
 <20250811211338.857992-2-mohsin.bashr@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250811211338.857992-2-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/08/2025 22:13, Mohsin Bashir wrote:
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index f9543d03485f..c80cbde50925 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -2232,13 +2232,22 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
>   {
>   	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
>   	u32 log_size = fls(rcq->size_mask);
> -	u32 rcq_ctl;
> +	u32 hds_thresh = fbn->hds_thresh;
> +	u32 rcq_ctl = 0;

I don't think this initialization is needed ...

>   
>   	fbnic_config_drop_mode_rcq(nv, rcq);
>   
> +	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
> +	 * be split at L4. It would also result in the frames being split at
> +	 * L2/L3 depending on the frame size.
> +	 */
> +	if (fbn->hds_thresh < FBNIC_HDR_BYTES_MIN) {
> +		rcq_ctl = FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT;
> +		hds_thresh = FBNIC_HDR_BYTES_MIN;
> +	}
> +
>   	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |

because you still unconditionally rewrite the value here. at the same
time FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT value will be lost, so I believe
it should be

  rcq_ctl |= FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |

and then the init code above makes sense.

> -		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK,
> -			      FBNIC_RX_MAX_HDR) |
> +		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK, hds_thresh) |
>   		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
>   			      FBNIC_RX_PAYLD_OFFSET) |
>   		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK,

