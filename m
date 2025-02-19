Return-Path: <bpf+bounces-51991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81799A3CB9E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EE7189BCD9
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944072586DB;
	Wed, 19 Feb 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="aJHNcKdd"
X-Original-To: bpf@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91B23536C;
	Wed, 19 Feb 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001045; cv=none; b=jjyK0JYClHoEAU6o72G6D+qesE3IFwfIJx3gJRw7E8D0/VrMzab9R1R0vXx+C2g2lcz/PHIqXG9319YqQOoEXV5vnJNbSybXLxKRiyCg/pEN2u/iESVC7XxSNPYcar0nj6nkr6ecduiF3hZ7dTeFOu48MHU5yjMOqUo6Zphn68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001045; c=relaxed/simple;
	bh=O6zQw43LAnWXOb2LcFvXhT5c9S8XjaexMimq/8E+fNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=icSyqtppsHnZ7HId8NODjOV24ZsIB/w4aUlKI7aMXS7pK1uyRdyt5PtmSXKQCLYLuVidDW2TkOgczhqLPWDSe3Kc4EKkK7aQNL2x0hAwpJNRAmVzgilRg6vi6j3+py9Qbm9cwMyDbAr2udm6zO1nxup7KSiqi7Ialr56Fgv3xGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=aJHNcKdd; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1740001032; bh=O6zQw43LAnWXOb2LcFvXhT5c9S8XjaexMimq/8E+fNA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aJHNcKdd5m9Dac2h4LNAim6W8Hbgi8hGpOM2oSuk/9cL+cIA6aVZocLxesHdXN/jy
	 wPLcui6hDdwCc82LrLLtL7BlKQ/bM6mduv6fuh88nq9u0K03MqfJZeD+zfS40Hm0No
	 oA27b0Tpio/DF5EYVUiizXD0GhSzbASAlyFRlp+x+3dNv7DJg1MfzFHQ4BBKOYke18
	 Ah8HgPKHBCE0d8l2+b23h1JdDcCZKfIs/FPF+kifz8whQKgZO6KVGZSuM8CuqC0eaG
	 Q4ATkGyls80xHUpYuNg9jTikfRPWrqw0fCPtGO6i9GfslVL6gma8j3lpV+U1hJ1/jd
	 VHMPpjNVsqscrW0+n6+qmG4Cy6MC9LwHcTJTwdoRMshSjaPrdIQrpuhNt6luGuv0vF
	 W822OP4j2ObWGZCYOH2FmhK4nSRcVAOLqJy5bKgXJ9QM9jADglgRVyQAHu3/8C2+ox
	 nxOoyeLNWjAlkESs7tjRHtTA+5x0krjRZM7tgucYDZEEc21GCUzppxwHPDYy2HX1bP
	 EgKOwQCWOh7QAcfvYsQZbXxTU+e7TFjHXRIZqbvuGJn3b2REFftA0PpJoYwcQRn++L
	 TM/M4V1seQaa/ZiaRwRDaPIEwYHzfcYZ4o+0VrquwEUALMZupX0AHvHMIV7VHL+cCo
	 Ejwv2bKCpAu0riLlnMKOLvqk=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 554D01601C1;
	Wed, 19 Feb 2025 22:36:58 +0100 (CET)
Message-ID: <4cf65af4-4b86-47b2-bfd0-3dd5a15c91ff@ijzerbout.nl>
Date: Wed, 19 Feb 2025 22:36:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 3/6] octeontx2-pf: AF_XDP zero copy receive
 support
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lcherian@marvell.com, jerinj@marvell.com, john.fastabend@gmail.com,
 bbhushan2@marvell.com, hawk@kernel.org, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
 larysa.zaremba@intel.com
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-4-sumang@marvell.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20250213053141.2833254-4-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 13-02-2025 om 06:31 schreef Suman Ghosh:
> This patch adds support to AF_XDP zero copy for CN10K.
> This patch specifically adds receive side support. In this approach once
> a xdp program with zero copy support on a specific rx queue is enabled,
> then that receive quse is disabled/detached from the existing kernel
> queue and re-assigned to the umem memory.
>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>   .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
>   .../ethernet/marvell/octeontx2/nic/cn10k.c    |   7 +-
>   .../marvell/octeontx2/nic/otx2_common.c       | 114 ++++++++---
>   .../marvell/octeontx2/nic/otx2_common.h       |   6 +-
>   .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  25 ++-
>   .../marvell/octeontx2/nic/otx2_txrx.c         |  73 +++++--
>   .../marvell/octeontx2/nic/otx2_txrx.h         |   6 +
>   .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
>   .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 182 ++++++++++++++++++
>   .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  21 ++
>   .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
>   11 files changed, 389 insertions(+), 61 deletions(-)
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
>
>
> [...]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> new file mode 100644
> index 000000000000..894c1e0aea6f
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
>
> [...]
> +static void otx2_clean_up_rq(struct otx2_nic *pfvf, int qidx)
> +{
> +	struct otx2_qset *qset = &pfvf->qset;
> +	struct otx2_cq_queue *cq;
> +	struct otx2_pool *pool;
> +	u64 iova;
> +
> +	/* If the DOWN flag is set SQs are already freed */
> +	if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
> +		return;
> +
> +	cq = &qset->cq[qidx];
> +	if (cq)
> +		otx2_cleanup_rx_cqes(pfvf, cq, qidx);
The if check makes no sense, cq is always != NULL
> +
> [...]
> +int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
> +{
> +	struct otx2_nic *pf = netdev_priv(dev);
> +	struct otx2_cq_poll *cq_poll = NULL;
> +	struct otx2_qset *qset = &pf->qset;
> +
> +	if (pf->flags & OTX2_FLAG_INTF_DOWN)
> +		return -ENETDOWN;
> +
> +	if (queue_id >= pf->hw.rx_queues)
> +		return -EINVAL;
> +
> +	cq_poll = &qset->napi[queue_id];
> +	if (!cq_poll)
> +		return -EINVAL;
cq_poll can never be NULL.
> [...]
>

