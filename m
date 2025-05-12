Return-Path: <bpf+bounces-58017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBEFAB3A43
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F326719E0D32
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942F1EF0BA;
	Mon, 12 May 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8djEoCP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E91E505;
	Mon, 12 May 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059354; cv=none; b=uhonIVZLbqSrQEAwroBwT1ldu4wrabkxdvXeSjVtYZybK3AFOMr2a8Nci7Rg3ptqn9Xx3pUqrJoECGzQ1ZgnJLHXhj9Neu3Z5yJQItj7K2+58M1CGqb7zhaUsHkqnjQke+uf8qcgHzDiwQ1gy0ZjBj+OZAX3t2manY6A96QuYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059354; c=relaxed/simple;
	bh=MEHGyJSZV6ZmVvbm4C4hI9TFH3oY2U0jBbfKq+YT31I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4QHtIWcYNjDfBWQWdSsNq0vY15cJCVDSkM7MRtpN4SEF6cTY2zRvf2zV5ZXnDP7Hj3eHCz29NDiYgjQ2gL4WKQL+8n72e4czrwf/WgeEw8xuyTghNSN9aMmT7wXDLn04Z/+NzjZAGyVVkoM2qQXtNG1a6bt/dafujZWkazZbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8djEoCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AACC4CEEF;
	Mon, 12 May 2025 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747059353;
	bh=MEHGyJSZV6ZmVvbm4C4hI9TFH3oY2U0jBbfKq+YT31I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8djEoCPjVGyQx42aTZVSbqgQDZkJ/Bj5aRHJUHgLcQd/mnl/eY5cWr5F1P4swDmb
	 lzG6JLGZU0Ux1ZZs5sjKcv5w4aTYiilPh5dzD717eImtSkvgPEpRmCKwi9n93zKQV0
	 UKaX8fY2iUpJgoVN7Qf78dmv80A95BDTKkzqIE5TXbeFEh/O+sRPUc6YO8UxSq4o8n
	 SlQne8XGIR0WeijFfGryo85ElqzfZXctr8HKG1FebB3u6NGhfAhjEefVEI01K1wp9R
	 VMQDo7Zvn7Kd7dGauwJtfURxUSALzYzHGi5P79HmdlQAgQRlKnLZ30P6zhm0cKOiW1
	 9mLZbKqtKN/CA==
Date: Mon, 12 May 2025 15:15:46 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de,
	shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v2] net: mana: Add handler for hardware
 servicing events
Message-ID: <20250512141546.GI3339421@horms.kernel.org>
References: <1746832603-4340-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746832603-4340-1-git-send-email-haiyangz@microsoft.com>

On Fri, May 09, 2025 at 04:16:43PM -0700, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: 
> Added dev_dbg for service type as suggested by Shradha Gupta.
> Added driver cap bit.
> 
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 63 +++++++++++++++++++
>  include/net/mana/gdma.h                       | 11 +++-
>  2 files changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c

...

> +static void mana_serv_func(struct work_struct *w)
> +{
> +	struct mana_serv_work *mns_wk = container_of(w, struct mana_serv_work, serv_work);
> +	struct pci_dev *pdev = mns_wk->pdev;
> +	struct pci_bus *bus, *parent;

Please avoid lines wider than 80 columns in Networking code.  In this case
I would suggest separating the declaration and initialisation of mns_wk and
pdev.  Something like this (completely untested!):

	struct mana_serv_work *mns_wk;
	struct pci_bus *bus, *parent;
	struct pci_dev *pdev;

	mns_wk = container_of(w, struct mana_serv_work, serv_work);
	pdev = mns_wk->pdev;


...

> @@ -400,6 +441,28 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
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
> +		if (!mns_wk) {
> +			dev_err(gc->dev, "Fail to alloc mana_serv_work\n");

The memory allocator will log a message on error.
So please don't also do so here.

> +			break;
> +		}
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

...

-- 
pw-bot: changes-requested

