Return-Path: <bpf+bounces-21227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E5849D03
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6132868C2
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518928E2B;
	Mon,  5 Feb 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyoaza5M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8B2D611;
	Mon,  5 Feb 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143222; cv=none; b=N9YD9Z3Wi3GsG0bBAKPGzdw4WzwQACkY6Nn81PnJhfuMZkzdJ3eCeRBRhzAcajOqmlvqQr8dSL7E8aVIwLo02CkMOl5T5V+MKx6/mqAMn00thbVqn1aM0AMJOp3uNkOtxCtrEdIiiA2Jh+fqyizSz8rdyIFYdk3pTU7u0wypODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143222; c=relaxed/simple;
	bh=fHb64vAvjms1IJ+wa6ZUREjhZ5d/5ix6urd8YanzItg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ByJ93pDpBFIl4Wd41LBUunuAmn0neOF9NReGYl0CCnWRpeaqvgeVAnY5thz6pEEq2oHhBwD17INpHyr/8Z2gpZCJGrziCiGRsEWG3hel6Ostm1bxUyEw1TA6tb4nZK3XsUVxnRCteTTrLcSMOk/vkMAmySHRJaVGFQDyOp9Tb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyoaza5M; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78406c22dc7so292637185a.0;
        Mon, 05 Feb 2024 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707143219; x=1707748019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ1lOhbO92PlxgtcbaAX9FzQjO9r6NgkpjBf1Q1piR4=;
        b=kyoaza5MnLl5D5VOp+GFpLcnj+1Veu9s5eO4ZrIbWN67br3xJ+y/uAuV418xh1DYXV
         ppQ3u9pu4/5Iy04REejdQ0d6HIgGhqYNa2alJhqppmJ10GJjFyXoDSEaipPiPjoUOp1I
         Kv9aLNvS0uEkzmGxxbVUZZ/R1HSXzl3BN3iqDt7PQKabTiJOsOq3GnDEYMqKotpC/+7N
         +/1Hz11kB/zD2IpkBP3OpXblWNxh6L4tk3smPwimH3qrTso686bcu+CFn4I4fHflxBq1
         Ht+/jstE/hgSiDSE3Xt9rAlgCjHaeEV1M0j1rhLKmo3Cju9zBJlwaQUqsn25ELsMza3z
         dbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707143219; x=1707748019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YZ1lOhbO92PlxgtcbaAX9FzQjO9r6NgkpjBf1Q1piR4=;
        b=eE4BooPfmbA+96NQrVgYpFAX4M6tj+Q7Rq6vRaTKRyrXiVtqiMSeipzk6qGOsQVTOk
         HAsQhYhcMxuKYEDvVA9C1AgUNA0iB0Q35Q0s85qLgWOQgJLpghMrkysm8pgKQW002fvH
         JGIunawgc1n0EB28/iXVWe6dDV5WcYQqDaTxrSsGMasZ0j3CsFz3/gtZEdcAVoyh2JFY
         ULBfaWqnUF0B3NJHqEozFEOJKbO95aY/R+rkrh02Jz+Ni4pbKSyBzsVZ7yA3x3RzPZSR
         XROUB0fiXV/FwzNopS6Sc8vBqjSc35NoNd+QEJfeeFudKarPwNYHoi1oVx5/ZV1V2A1H
         kJvg==
X-Gm-Message-State: AOJu0YwTrVXSeHvOhaM+bIYZCjBdzxNHuynCH8HTpmPznh6ZSK/20MiC
	sInk576E9EImh6+HrBZyLRcYIRNVIoBBVduSGSVrQBzQprL1N+JP
X-Google-Smtp-Source: AGHT+IH2MUJZjX90X/rH7UP8ZHaBw9bc04SoSE5q+JoyM6FIpTvvo9UhXAj6my6o2yS49gbeITn4VA==
X-Received: by 2002:a05:620a:5628:b0:783:6b97:dfe5 with SMTP id vv8-20020a05620a562800b007836b97dfe5mr12915809qkn.23.1707143219332;
        Mon, 05 Feb 2024 06:26:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUx2IP5MxENEjxl3zlaNMv4KZPzKoL8pmeplrCMItUEiCDIdZGE0kKhITJ3bdZh920jbp+xiCmFuQEWJih/v6G9+QGPgqU2kN95Xx5CATlQPVar65/5ZJcOSkqYfrabF4bY2mVn5Uf7OUw4FCeoINEnA8UAM1skdw3lvFe24udGpG5bmqQrnIvaU+3ayK0AJdFukHmzs+xeId1ttKRkFSc2v0qE/XCTVDqZPgSxXcmRHosflzUSTbWn/8WCjGD7G931DOM2tMCwVT5++g==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id a2-20020a05620a102200b00783e1590ebasm2995468qkk.82.2024.02.05.06.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:26:58 -0800 (PST)
Date: Mon, 05 Feb 2024 09:26:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, 
 magnus.karlsson@intel.com, 
 bjorn@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, 
 yuvale@radware.com
Cc: bpf@vger.kernel.org
Message-ID: <65c0f032ac71a_7396029419@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240205123553.22180-2-magnus.karlsson@gmail.com>
References: <20240205123553.22180-1-magnus.karlsson@gmail.com>
 <20240205123553.22180-2-magnus.karlsson@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] xsk: support redirect to any socket bound to
 the same umem
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add support for directing a packet to any socket bound to the same
> umem. This makes it possible to use the XDP program to select what
> socket the packet should be received on. The user can populate the
> XSKMAP with various sockets and as long as they share the same umem,
> the XDP program can pick any one of them.
> 
> Suggested-by: Yuval El-Hanany <yuvale@radware.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This will greatly simplify using AF_XDP sockets with standard RSS.

A socket can be attached to each NIC receive queue, and regardless to
which queue RSS directs a packet, the XDP program can pass it to the
AF_XDP socket that is the intended target.

In the trivial case a single AF_XDP socket receives all XDP_REDIRECT
traffic for the entire device. Similar to how a single PF_PACKET
socket can access all ingress traffic.

Though N fill queues still need to be maintained of course.

> ---
>  net/xdp/xsk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 1eadfac03cc4..a339e9a1b557 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -313,10 +313,13 @@ static bool xsk_is_bound(struct xdp_sock *xs)
>  
>  static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  {
> +	struct net_device *dev = xdp->rxq->dev;
> +	u32 qid = xdp->rxq->queue_index;
> +
>  	if (!xsk_is_bound(xs))
>  		return -ENXIO;
>  
> -	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
> +	if (!dev->_rx[qid].pool || xs->umem != dev->_rx[qid].pool->umem)
>  		return -EINVAL;
>  
>  	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
> -- 
> 2.42.0
> 



