Return-Path: <bpf+bounces-58100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAFDAB4BE7
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 08:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206E719E4A3F
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE971E9B2F;
	Tue, 13 May 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mf/B0kFF"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4CEDF49;
	Tue, 13 May 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117654; cv=none; b=AWtaNXD3FxJXGkU0Y/4DZPcvfCNn2iYWTwRAjK0DQP5/MPEtS+VVJXoGZjK/00UTd+DKCXCrTG6Gl3Q2qfHf1Ck2TGtj7hNHVM9KUaQ0Rgav4WHY+wj6SkHpukbZyZys4xnsq3G7DPgGsi3b27IeRiidVC9aT3sL9Gu2y8aKwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117654; c=relaxed/simple;
	bh=NTyhw2Sxrc2FRoeNUdP0aniN1vvCdiMHWpOBLku//+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h90qj+juehtrrLnG7dWig7gXfIOKrRdAZPjK4Bo5pGJuoFAbCz7fJBX7WeTp3FYwCwp+kU22Zo4vVUmBOEy9V7RWxhTgxM/LYXGzR9dDVLDYofmRSa5Zsyv+uYzOCGP2vJ3lOpgSjtu6AYqZgYXmhh+pRzsMcVfnzM938Gmbyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mf/B0kFF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 254242117449; Mon, 12 May 2025 23:27:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 254242117449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747117652;
	bh=cC2JhmOqv91IV0Hp0w7gkJeK2Cjeqx/4eBqdSgpnygk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mf/B0kFF966OBH69THTGBU/0xKE+7M3ANOR9RORRp7mN2mOWK81ZiCKGtpXgR8/Fj
	 FLvu8rqvD1Lu4ozNy60jJq3yFxP18B0XKYY97SO8GEkrzMg8dSpHYwXzmrBEezl557
	 YhKo8GbEBgDybZikbVezJBCvNDdHwHkoNFxDbasg=
Date: Mon, 12 May 2025 23:27:32 -0700
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
	kotaranov@microsoft.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v3] net: mana: Add handler for hardware
 servicing events
Message-ID: <20250513062732.GA32721@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1747079874-9445-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747079874-9445-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, May 12, 2025 at 12:57:54PM -0700, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v3:
> Updated for checkpatch warnings as suggested by Simon Horman.
> 
> v2:
> Added dev_dbg for service type as suggested by Shradha Gupta.
> Added driver cap bit.
> 
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 64 +++++++++++++++++++
>  include/net/mana/gdma.h                       | 11 +++-
>  2 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4ffaf7588885..3102bd2b875b 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -352,11 +352,55 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
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
> +	struct mana_serv_work *mns_wk;
> +	struct pci_bus *bus, *parent;
> +	struct pci_dev *pdev;
> +
> +	mns_wk = container_of(w, struct mana_serv_work, serv_work);
> +	pdev = mns_wk->pdev;
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
> @@ -400,6 +444,26 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
>  		eq->eq.callback(eq->eq.context, eq, &event);
>  		break;
>  
> +	case GDMA_EQE_HWC_FPGA_RECONFIG:
> +	case GDMA_EQE_HWC_SOCMANA_CRASH:
> +		dev_dbg(gc->dev, "Recv MANA service type:%d\n", type);
> +
> +		if (gc->in_service) {
> +			dev_info(gc->dev, "Already in service\n");
> +			break;
> +		}
> +
> +		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> +		if (!mns_wk)
> +			break;
> +
> +		dev_info(gc->dev, "Start MANA service type:%d\n", type);
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
> index 228603bf03f2..d0fbc9c64cc8 100644
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
> @@ -558,12 +561,16 @@ enum {
>  /* Driver can handle holes (zeros) in the device list */
>  #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
>  
> +/* Driver can self reset on EQE notification */
> +#define GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE BIT(14)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
>  	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
>  	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
> -	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
> +	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
> +	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE)
>  
>  #define GDMA_DRV_CAP_FLAGS2 0
>  
> -- 
> 2.34.1

Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

