Return-Path: <bpf+bounces-57744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3ACAAF6C4
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33A19E0D05
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32507263F4E;
	Thu,  8 May 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aJMWhhW3"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36388212B3A;
	Thu,  8 May 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696566; cv=none; b=WfQN4OblPTp9KJ/UGmvt13KNBpGCcZDOokxvOROEXXHBDJ0XNpYoM7A13uVDUFsUBIPxOFGm9yggcAcZuF9dxWgiNoC3KBnSvtmJrVOGldPbjUMspUMHxJ+sPIkiUsFvaSBPaZ9jm7y4U8UxnL3+vygTgYHqHxcjM49g5wzRDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696566; c=relaxed/simple;
	bh=sngpcCVtwhKVcH/6x4CjcHof55f+rqXMxRQja6DBVg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc4wcSbAZsK/wUMeusVsz839rwN8FeWf2Lh6Fcyl06dGLmLwB2Gq4/fveEtAwgf6iHFfdyCSqVbmsU4aKsrgKBz3sv3rF5/qyViz48Rx7VL6oeWT2Evi4xlZIWsaqtUrnoPp365eyJv3evSpqkBn1KCRI5QL0VdJI2L9MnJmX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aJMWhhW3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 7CE162115DCD; Thu,  8 May 2025 02:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CE162115DCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746696564;
	bh=k10D7q/lt/KA5HXrM1tVZYWcIvRW+BWcwZ+HO7w2oy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJMWhhW3RGlwa6IAL36Xcwx0fuoweyGLgDQkjVwBDSJDLj6WJzxfYOrPSysf9Fx73
	 VofAcu12/1GnG0N3rfckSR3fQhZKF2W3/b6qHhMNnXR/5th2UKwM9eDzKjiYmAEuqc
	 98DiRy4tM/3gVAz/2aFczVNOptnQaPkv0DRbM1Lw=
Date: Thu, 8 May 2025 02:29:24 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Add handler for hardware servicing
 events
Message-ID: <20250508092924.GA2081@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746633519-17549-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746633519-17549-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 07, 2025 at 08:58:39AM -0700, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 61 +++++++++++++++++++
>  include/net/mana/gdma.h                       |  5 +-
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4ffaf7588885..aa2ccf4d0ec6 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -352,11 +352,52 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
>  }
>  EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
>  
> +#define MANA_SERVICE_PERIOD 10
> +
> +struct mana_serv_work {
> +	struct work_struct serv_work;
> +	struct pci_dev *pdev;
> +};
> +
> +static void mana_serv_func(struct work_struct *w)
> +{
> +	struct mana_serv_work *mns_wk = container_of(w, struct mana_serv_work, serv_work);
> +	struct pci_dev *pdev = mns_wk->pdev;
> +	struct pci_bus *bus, *parent;
> +
> +	if (!pdev)
> +		goto out;
> +
> +	bus = pdev->bus;
> +	if (!bus) {
> +		dev_err(&pdev->dev, "MANA service: no bus\n");
> +		goto out;
> +	}
> +
> +	parent = bus->parent;
> +	if (!parent) {
> +		dev_err(&pdev->dev, "MANA service: no parent bus\n");
> +		goto out;
> +	}
> +
> +	pci_stop_and_remove_bus_device_locked(bus->self);
> +
> +	msleep(MANA_SERVICE_PERIOD * 1000);
> +
> +	pci_lock_rescan_remove();
> +	pci_rescan_bus(parent);
> +	pci_unlock_rescan_remove();
> +
> +out:
> +	kfree(mns_wk);

Shouldn't gc->in_service be set to false again?

> +}
> +
>  static void mana_gd_process_eqe(struct gdma_queue *eq)
>  {
>  	u32 head = eq->head % (eq->queue_size / GDMA_EQE_SIZE);
>  	struct gdma_context *gc = eq->gdma_dev->gdma_context;
>  	struct gdma_eqe *eq_eqe_ptr = eq->queue_mem_ptr;
> +	struct mana_serv_work *mns_wk;
>  	union gdma_eqe_info eqe_info;
>  	enum gdma_eqe_type type;
>  	struct gdma_event event;
> @@ -400,6 +441,26 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
>  		eq->eq.callback(eq->eq.context, eq, &event);
>  		break;
>  
> +	case GDMA_EQE_HWC_FPGA_RECONFIG:
> +	case GDMA_EQE_HWC_SOCMANA_CRASH:

may be we also add a log(dev_dbg) to indicate if the servicing is for
FPGA reconfig or socmana crash.

> +		if (gc->in_service) {
> +			dev_info(gc->dev, "Already in service\n");
> +			break;
> +		}
> +
> +		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> +		if (!mns_wk) {
> +			dev_err(gc->dev, "Fail to alloc mana_serv_work\n");
> +			break;
> +		}
> +
> +		dev_info(gc->dev, "Start MANA service\n");
> +		gc->in_service = true;
> +		mns_wk->pdev = to_pci_dev(gc->dev);
> +		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> +		schedule_work(&mns_wk->serv_work);
> +		break;
> +
>  	default:
>  		break;
>  	}
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 228603bf03f2..13cfbcf67815 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -58,8 +58,9 @@ enum gdma_eqe_type {
>  	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
>  	GDMA_EQE_HWC_INIT_DATA		= 130,
>  	GDMA_EQE_HWC_INIT_DONE		= 131,
> -	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
> +	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
>  	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
> +	GDMA_EQE_HWC_SOCMANA_CRASH	= 135,
>  	GDMA_EQE_RNIC_QP_FATAL		= 176,
>  };
>  
> @@ -388,6 +389,8 @@ struct gdma_context {
>  	u32			test_event_eq_id;
>  
>  	bool			is_pf;
> +	bool			in_service;
> +
>  	phys_addr_t		bar0_pa;
>  	void __iomem		*bar0_va;
>  	void __iomem		*shm_base;
> -- 
> 2.34.1

