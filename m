Return-Path: <bpf+bounces-55730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DBA85DD1
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90AF4C83AF
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7971A2367BA;
	Fri, 11 Apr 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNnb/eUq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5952367A3;
	Fri, 11 Apr 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375685; cv=none; b=NEbmwD5ZTAZ62GrZmUSTOMZgmeNyaUMIHFFlV1ntBHHbFD3tavce+uRzBR2/OnerjbCkMp/6yJdFJejWo34JgkJphvJKK8sH+eRDuoBa9iwAOB1lrvMOYJpXl1V+2HAcm8K2TAZFY/t3lgR7Gm3Dl0H89nSFviYFpAXP+qcHR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375685; c=relaxed/simple;
	bh=DLn/1k4yzurPU3BqpETrnnNJz49BO3hg9hoCjbRBq14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyzJYQmeddWE3oHNgMcbXUdOdFYrAyJKQzbczO4ckwsaZ10FSBtR1yUVMO4bhjKnXqQgyf8N/qIDdoG/oMIbVg5AliyU7CtCQZwhy9oOirx5/ULljTOXzBllf7BdPL7ji7Aq6PQrlBl+e2oTAspUr8Ov1770JsuMIQdfjNXMc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNnb/eUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E46C4CEE8;
	Fri, 11 Apr 2025 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744375684;
	bh=DLn/1k4yzurPU3BqpETrnnNJz49BO3hg9hoCjbRBq14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNnb/eUqH+4+uEqn806bE4tk5dzq62rtjaj+lDwsSrrOXk2ATjO7xOZacmwglwBRo
	 vweBZHyZNvqpBK8+mCheheCG0D8b33MXPfJyLr0J6/Jrd6iCdla4ZkTCG/HfvuIW5L
	 dKoDGiMq+lZ0uiBoSPGeXItTnV3rpaaBDrlvvnh6GjLKgHw79AwpwOCVejGCwVxLLR
	 ajH8O/tm07UkXrmAc3RyJ/yxBiNgZwIuyZ2CacbeIGbUUz+CiTKGKh1mfr0tt4/t02
	 M4z4Rvg+9G4u3PRMcd/SndyrnByN3VSDAzJBazXUbBetutVKM14Dvn5C7oRMTxshTN
	 hzRoJ29ASpjfg==
Date: Fri, 11 Apr 2025 13:48:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org, tom@herbertland.com,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
	kernel-team@cloudflare.com
Subject: Re: [PATCH net-next V2 2/2] net: sched: generalize check for no-op
 qdisc
Message-ID: <20250411124800.GE395307@horms.kernel.org>
References: <174412623473.3702169.4235683143719614624.stgit@firesoul>
 <174412628464.3702169.81132659219041209.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174412628464.3702169.81132659219041209.stgit@firesoul>

On Tue, Apr 08, 2025 at 05:31:24PM +0200, Jesper Dangaard Brouer wrote:
> Several drivers (e.g., veth, vrf) contain open-coded checks to determine
> whether a TX queue has a real qdisc attached - typically by testing if
> qdisc->enqueue is non-NULL.
> 
> These checks are functionally equivalent to comparing the queue's qdisc
> pointer against &noop_qdisc (qdisc named "noqueue"). This equivalence
> stems from noqueue_init(), which explicitly clears the enqueue pointer
> for the "noqueue" qdisc. As a result, __dev_queue_xmit() treats the qdisc
> as a no-op only when enqueue == NULL.
> 
> This patch introduces a common helper, qdisc_txq_is_noop() to standardize
> this check. The helper is added in sch_generic.h and replaces open-coded
> logic in both the veth and vrf drivers.
> 
> This is a non-functional change.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

...

> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 7168b33adadb..d4fe36c55f29 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -349,9 +349,8 @@ static bool qdisc_tx_is_default(const struct net_device *dev)
>  		return false;
>  
>  	txq = netdev_get_tx_queue(dev, 0);
> -	qdisc = rcu_access_pointer(txq->qdisc);

nit: the qdisc variable is now unused in this function and can be removed.

Flagged by W=1 builds.

>  
> -	return !qdisc->enqueue;
> +	return qdisc_txq_is_noop(txq);
>  }
>  
>  /* Local traffic destined to local address. Reinsert the packet to rx

...

