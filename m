Return-Path: <bpf+bounces-51603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26CA366EC
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66B1188DFA6
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529C1990BA;
	Fri, 14 Feb 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WU42aG7x"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60318F2CF
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565260; cv=none; b=lvZkG2oCFEeb7jTKgqXsr4Tm6PFBg2ME4AjbOFOXGk+qxBVE3FXvkpo3SH7O2CwVnygfD+EvSb/ce81GUgdtULcil3h1x2Jd87FIpeYrA7qyq69JGMAyBWh64EFeZmgnHUfQb/TVzA81IFk5Nn6Wbx4J3CJMIiRVq8o6wX2LMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565260; c=relaxed/simple;
	bh=+opS0wZsEykY1Lhzdun0rIdFQFUhtryeHWytlyFileo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWqk7taTHyVcLm7T58SOgoUSOhbiYIQZ3anFipikpru7q0eetsgSR7uzDI5UeSdUt13OSnY/CMOG3AMyWLR66lYcJ4wEtkvAWEdulTv2Nuva6tusd9c0hlNv7j9k/Ps6XVPnNK3/DgVKwLhVKgKw46P7wejo5qqzkgHEnPUOj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WU42aG7x; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5f6e9e0b-1a5f-4129-9a88-ad612b6c6e3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739565249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkG+QW+mT97zF6xc95tcvPiqFdJ5JTXyl1kp7DON/2s=;
	b=WU42aG7xhCytVoT5PvqRE1cAVNXfebKTuCV+dwuUMjOiqzHnsdPy81LZKnjHE5EoyAEeDj
	ONb334leMztWzCHvcl1BYkMOyLsglErRIdQ5KgkqpW1WnryDdOyvJfH+t4q70GdgfGZriS
	PJbyyRgH3fZMrHxd/WIVUX9n1FFIsuk=
Date: Fri, 14 Feb 2025 12:33:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB
 callback
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-10-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250214010038.54131-10-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 5:00 PM, Jason Xing wrote:
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 291ab1b4acc4..794fe553dd77 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_priv *p,
>   {
>   	struct dsa_switch *ds = p->dp->ds;
>   
> -	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> +	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF))

This change should be in patch 8.

[ ... ]

> diff --git a/net/socket.c b/net/socket.c
> index 262a28b59c7f..517de433d4bb 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
>   	u8 flags = *tx_flags;
>   
>   	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
> -		flags |= SKBTX_HW_TSTAMP;
> +		flags |= SKBTX_HW_TSTAMP_NOBPF;

Same here.



