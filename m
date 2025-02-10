Return-Path: <bpf+bounces-51030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74962A2F60B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A943165694
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA324FBE0;
	Mon, 10 Feb 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkjSOf4S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8225B687;
	Mon, 10 Feb 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210200; cv=none; b=NKa23JaZzaxbhNJxyVVEu6+sJ8OZY17qlHiaKPLlKhQ/Afszon01o9OkXe5NXTyjowg+g7M2d1MytrQlRlA5F9r2IES/g/GwmsxSP1Bq+m0ySS586osn0xq8W2LKr1KY7ts2ruEbEKLkG2VT4KmSMW1lodto1hRt3QVjUjaRNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210200; c=relaxed/simple;
	bh=KpY6DC5THF4x3FmHBSdEQ2+HQyx/vX+y02EHmdKk6vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0PSHF6JSfnpVAQGdOvWwvyJEaZdmEerKIfdbkxuDvJqfRH24dPxyVaSKvqizMflzp5zz5U9WNLKpSKCzpaq4ihD5DtL6aXlmeKdvTjBAEuyaafCPSHAuCdRmAMdDhMxXy5Y3hPqb7PcceCH7AcS7nZ/gq5uxsvZJ49yGDIeIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkjSOf4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3651C4CEEB;
	Mon, 10 Feb 2025 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739210199;
	bh=KpY6DC5THF4x3FmHBSdEQ2+HQyx/vX+y02EHmdKk6vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkjSOf4SYDY/vM6yCAFpKl7TaRX7Gxj8+o8/SCB/x+SLXhQp7VLYUaMfzsewS80Am
	 KQrL8Fmd2oaxWW6UtZZmsS6X/4BeTQ11+OHLx04FFzBUxjTYeWUnY2zJs5d3PSbxgT
	 CgwpTfeXKMND35p91MIiq+uB0THwr6z8XLAJNoTdjjz0ckJe0+/PABHOl319f7f5xf
	 wjHtUTjU5m3OKauToeFyaWLDaFJVj0Hs5Lc0A9na8Z3g+hpkSlMRDqh5rnsOrxFcRr
	 +fF1tQkzLwENVpb+PePMkAGJOSwwbCWciMhxhpzYD8yz3Ee3nJeoUT5K9flLSP6g5H
	 8QaCnaQ8xiMpQ==
Date: Mon, 10 Feb 2025 17:56:33 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
Subject: Re: [net-next PATCH v5 3/6] octeontx2-pf: AF_XDP zero copy receive
 support
Message-ID: <20250210175633.GJ554665@kernel.org>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-4-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206085034.1978172-4-sumang@marvell.com>

On Thu, Feb 06, 2025 at 02:20:31PM +0530, Suman Ghosh wrote:
> This patch adds support to AF_XDP zero copy for CN10K.
> This patch specifically adds receive side support. In this approach once
> a xdp program with zero copy support on a specific rx queue is enabled,
> then that receive quse is disabled/detached from the existing kernel
> queue and re-assigned to the umem memory.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c

...

> @@ -124,7 +127,8 @@ int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
>  			break;
>  		}
>  		cq->pool_ptrs--;
> -		ptrs[num_ptrs] = (u64)bufptr + OTX2_HEAD_ROOM;
> +		ptrs[num_ptrs] = pool->xsk_pool ? (u64)bufptr : (u64)bufptr + OTX2_HEAD_ROOM;

Please consider limiting lines to 80 columns wide or less in Networking
code where it can be done without reducing readability (subjective to be
sure).

> +
>  		num_ptrs++;
>  		if (num_ptrs == NPA_MAX_BURST || cq->pool_ptrs == 0) {
>  			__cn10k_aura_freeptr(pfvf, cq->cq_idx, ptrs,

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

...

> @@ -1312,8 +1326,8 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
>  
>  	/* Free SQB and RQB pointers from the aura pool */
>  	for (pool_id = pool_start; pool_id < pool_end; pool_id++) {
> -		iova = otx2_aura_allocptr(pfvf, pool_id);
>  		pool = &pfvf->qset.pool[pool_id];
> +		iova = otx2_aura_allocptr(pfvf, pool_id);
>  		while (iova) {
>  			if (type == AURA_NIX_RQ)
>  				iova -= OTX2_HEAD_ROOM;

This hunk seems unnecessary.

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

...

> @@ -529,9 +530,10 @@ static void otx2_adjust_adaptive_coalese(struct otx2_nic *pfvf, struct otx2_cq_p
>  int otx2_napi_handler(struct napi_struct *napi, int budget)
>  {
>  	struct otx2_cq_queue *rx_cq = NULL;
> +	struct otx2_cq_queue *cq = NULL;
>  	struct otx2_cq_poll *cq_poll;
>  	int workdone = 0, cq_idx, i;
> -	struct otx2_cq_queue *cq;
> +	struct otx2_pool *pool;
>  	struct otx2_qset *qset;
>  	struct otx2_nic *pfvf;
>  	int filled_cnt = -1;
> @@ -556,6 +558,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
>  
>  	if (rx_cq && rx_cq->pool_ptrs)
>  		filled_cnt = pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
> +
>  	/* Clear the IRQ */
>  	otx2_write64(pfvf, NIX_LF_CINTX_INT(cq_poll->cint_idx), BIT_ULL(0));
>  

> @@ -568,20 +571,31 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
>  		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
>  			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
>  
> +		if (likely(cq))
> +			pool = &pfvf->qset.pool[cq->cq_idx];

pool is initialised conditionally here.

> +
>  		if (unlikely(!filled_cnt)) {
>  			struct refill_work *work;
>  			struct delayed_work *dwork;
>  
> -			work = &pfvf->refill_wrk[cq->cq_idx];
> -			dwork = &work->pool_refill_work;
> -			/* Schedule a task if no other task is running */
> -			if (!cq->refill_task_sched) {
> -				work->napi = napi;
> -				cq->refill_task_sched = true;
> -				schedule_delayed_work(dwork,
> -						      msecs_to_jiffies(100));
> +			if (likely(cq)) {

And here it is assumed that the same condition may not be met.

> +				work = &pfvf->refill_wrk[cq->cq_idx];
> +				dwork = &work->pool_refill_work;
> +				/* Schedule a task if no other task is running */
> +				if (!cq->refill_task_sched) {
> +					work->napi = napi;
> +					cq->refill_task_sched = true;
> +					schedule_delayed_work(dwork,
> +							      msecs_to_jiffies(100));
> +				}
>  			}
> +			/* Call for wake-up for not able to fill buffers */
> +			if (pool->xsk_pool)

> +				xsk_set_rx_need_wakeup(pool->xsk_pool);

But here pool is dereferences without being guarded by the same
condition. This seems inconsistent.

>  		} else {
> +			/* Clear wake-up, since buffers are filled successfully */
> +			if (pool->xsk_pool)
> +				xsk_clear_rx_need_wakeup(pool->xsk_pool);

And it is not obvious to me (or Smatch, which flagged this one) that
pool is initialised here.

>  			/* Re-enable interrupts */
>  			otx2_write64(pfvf,
>  				     NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index e926c6ce96cf..e43ecfb633f8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -722,15 +722,25 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		goto err_shutdown_tc;
>  
> +	vf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
> +	if (!vf->af_xdp_zc_qidx) {
> +		err = -ENOMEM;
> +		goto err_af_xdp_zc;
> +	}
> +
>  #ifdef CONFIG_DCB
>  	err = otx2_dcbnl_set_ops(netdev);
>  	if (err)
> -		goto err_shutdown_tc;
> +		goto err_dcbnl_set_ops;
>  #endif
>  	otx2_qos_init(vf, qos_txqs);
>  
>  	return 0;
>  
> +err_dcbnl_set_ops:
> +	bitmap_free(vf->af_xdp_zc_qidx);
> +err_af_xdp_zc:
> +	otx2_unregister_dl(vf);

Please consider naming the labels above after what they do rather
than where they come from, as seems to be the case for the existing
labels below, and is preferred in Networking code.

>  err_shutdown_tc:
>  	otx2_shutdown_tc(vf);
>  err_unreg_netdev:

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c

...

> +static int otx2_xsk_ctx_disable(struct otx2_nic *pfvf, u16 qidx, int aura_id)
> +{
> +	struct nix_cn10k_aq_enq_req *cn10k_rq_aq;
> +	struct npa_aq_enq_req *aura_aq;
> +	struct npa_aq_enq_req *pool_aq;
> +	struct nix_aq_enq_req *rq_aq;
> +
> +	if (test_bit(CN10K_LMTST, &pfvf->hw.cap_flag)) {
> +		cn10k_rq_aq = otx2_mbox_alloc_msg_nix_cn10k_aq_enq(&pfvf->mbox);
> +		if (!cn10k_rq_aq)
> +			return -ENOMEM;
> +		cn10k_rq_aq->qidx = qidx;
> +		cn10k_rq_aq->rq.ena = 0;
> +		cn10k_rq_aq->rq_mask.ena = 1;
> +		cn10k_rq_aq->ctype = NIX_AQ_CTYPE_RQ;
> +		cn10k_rq_aq->op = NIX_AQ_INSTOP_WRITE;
> +	} else {
> +		rq_aq = otx2_mbox_alloc_msg_nix_aq_enq(&pfvf->mbox);
> +		if (!rq_aq)
> +			return -ENOMEM;
> +		rq_aq->qidx = qidx;
> +		rq_aq->sq.ena = 0;
> +		rq_aq->sq_mask.ena = 1;
> +		rq_aq->ctype = NIX_AQ_CTYPE_RQ;
> +		rq_aq->op = NIX_AQ_INSTOP_WRITE;
> +	}
> +
> +	aura_aq = otx2_mbox_alloc_msg_npa_aq_enq(&pfvf->mbox);
> +	if (!aura_aq) {
> +		otx2_mbox_reset(&pfvf->mbox.mbox, 0);
> +		return -ENOMEM;

It's not a big deal, but FWIIW I would have used a goto label here.

> +	}
> +
> +	aura_aq->aura_id = aura_id;
> +	aura_aq->aura.ena = 0;
> +	aura_aq->aura_mask.ena = 1;
> +	aura_aq->ctype = NPA_AQ_CTYPE_AURA;
> +	aura_aq->op = NPA_AQ_INSTOP_WRITE;
> +
> +	pool_aq = otx2_mbox_alloc_msg_npa_aq_enq(&pfvf->mbox);
> +	if (!pool_aq) {
> +		otx2_mbox_reset(&pfvf->mbox.mbox, 0);
> +		return -ENOMEM;

And re-used it here.

> +	}
> +
> +	pool_aq->aura_id = aura_id;
> +	pool_aq->pool.ena = 0;
> +	pool_aq->pool_mask.ena = 1;
> +
> +	pool_aq->ctype = NPA_AQ_CTYPE_POOL;
> +	pool_aq->op = NPA_AQ_INSTOP_WRITE;
> +
> +	return otx2_sync_mbox_msg(&pfvf->mbox);
> +}

...

