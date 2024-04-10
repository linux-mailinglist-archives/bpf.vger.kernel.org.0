Return-Path: <bpf+bounces-26407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C289F060
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61E5282585
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5615959D;
	Wed, 10 Apr 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IcUQGu0g"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381115957E;
	Wed, 10 Apr 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712747417; cv=none; b=M+zACvcooxZDKmSmuEgdJ2uylDJHw78gzVsfyF+/qLmY8lc2Wbq0/IwVJvvp3y0a9AY6I1xsUcyKqJrJ17jZhE7fudrmpzShcE4PDS7g3ohq3DSK6H5o9Lwzs2HU2YJvLpgEOsIF9BV5C6dFNt712IT2vaMiTSSoS8PZx04LGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712747417; c=relaxed/simple;
	bh=jFsdfhaiocpkta4ERYnJWOjDCQJsKVXmRXsHZr/6Kf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz5fOT3Wf2Bwug/lLO6f1DP97IO3VBQ9ob0lVoC/UzTIZqFJUy7mQ+IdIFhSEiA8DLtryldkHiof4cL1MnaTAT/pKTkf/TpKMVy9vp9ZLYNoz/zeA87e2KX1S6q3udm6+hFRnRRVpJY4dg9wg2xD7O9ttfGT5Cin6a1fm4WI2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IcUQGu0g; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4A868180014A;
	Wed, 10 Apr 2024 07:10:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 Apr 2024 07:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712747410; x=1712833810; bh=5RenAIti6McvKXi8QC4qbp24wHgG
	zwtMM+b1Bo/azeU=; b=IcUQGu0gk2uB/Yhz0/r7dNBgzhSphX87liEpsU+lEIRO
	pjyz7Mlw3krXVffkC1hxXjuRwJlcJOWvfEUddF2beeXcDZTQL8vDSIeyZtwgJuoP
	gX1cjd1MKRSrnSlooQrVEI3HaLyuUbRZNqdk4MiB0bUfgI/Qp8MZHLWjtV0riweV
	mFFsdXqfeJgIX/nS1ttboWDQTKA8Jdp+HXQ3llM10Fq1Tvzbw5cQ/LPBF2flJPXi
	tf+nqBi8xCLZ3C7J6cBMLgf1XkLrSFq6b7ZJXyab1IZNV9ZW4vkFEt7htTDoS+gj
	WD+bRPLJTKM9nYMO0YEZxf4g0lSStTSr5rls+i21Nw==
X-ME-Sender: <xms:kXMWZofoAeyyMdCE3dmynplzzSoFKTyN85lWhp2jBx0Hi6pVC5zqcQ>
    <xme:kXMWZqNnI-plEFyUJeVGicC0I2cMQ31244zdFSpFp_sKinA3ltCWl2rkS5wgo0bDW
    YSqUvRHOmrLKs0>
X-ME-Received: <xmr:kXMWZpjq01vNRiIYThXjvgHhCF_SuUNHfrc4Y6ZrAvLG36niqPrKVNTY1J3B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepffeuvefhhfduvdejteefuedugfehgeelvdevheehueeuuddvheegtdetfeeh
    geefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:kXMWZt_eAtfa-EaklNydcuKWlGjEY2Faip1ejvKC_lnZEPEee2kQlQ>
    <xmx:kXMWZksDTTRNKl0lc_dUTlAsoumtMRtFadGWloYnamM62xDZPtZZ0w>
    <xmx:kXMWZkFlygm2o9GsOcU5af3hMO1J50NeXdRA-aQScGE9uHOFn54e1Q>
    <xmx:kXMWZjMUryqdsI04l8sMM1902wmmuzAxIQaT9NV9doZGjVFdo_-Zmg>
    <xmx:knMWZjVX2uhgJxerY0XjCVM6wuenfy3ZzJ1xbR-XbUjrDGyEe38MYUL2>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 07:10:08 -0400 (EDT)
Date: Wed, 10 Apr 2024 14:10:04 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, geomatsi@gmail.com,
	kvalo@kernel.org, quic_jjohnson@quicinc.com, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	amcohen@nvidia.com
Subject: Re: [PATCH net-next v4 2/9] net: create a dummy net_device allocator
Message-ID: <ZhZzjNDRaHtdYjDg@shredder>
References: <20240409125738.1824983-1-leitao@debian.org>
 <20240409125738.1824983-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409125738.1824983-3-leitao@debian.org>

On Tue, Apr 09, 2024 at 05:57:16AM -0700, Breno Leitao wrote:
> It is impossible to use init_dummy_netdev together with alloc_netdev()
> as the 'setup' argument.
> 
> This is because alloc_netdev() initializes some fields in the net_device
> structure, and later init_dummy_netdev() memzero them all. This causes
> some problems as reported here:
> 
> 	https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/
> 
> Split the init_dummy_netdev() function in two. Create a new function called
> init_dummy_netdev_core() that does not memzero the net_device structure.
> Then have init_dummy_netdev() memzero-ing and calling
> init_dummy_netdev_core(), keeping the old behaviour.
> 
> init_dummy_netdev_core() is the new function that could be called as an
> argument for alloc_netdev().
> 
> Also, create a helper to allocate and initialize dummy net devices,
> leveraging init_dummy_netdev_core() as the setup argument. This function
> basically simplify the allocation of dummy devices, by allocating and
> initializing it. Freeing the device continue to be done through
> free_netdev()
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

We were about to submit another user of init_dummy_netdev() when I
noticed this patch. Converted the code to use alloc_netdev_dummy() [1]
and it seems to be working fine. Will submit after your patch is
accepted.

See a few minor comments below.

[...]

> +/**
> + *	init_dummy_netdev	- init a dummy network device for NAPI
> + *	@dev: device to init
> + *
> + *	This takes a network device structure and initialize the minimum

s/initialize/initializes/

> + *	amount of fields so it can be used to schedule NAPI polls without
> + *	registering a full blown interface. This is to be used by drivers
> + *	that need to tie several hardware interfaces to a single NAPI
> + *	poll scheduler due to HW limitations.
> + */
> +void init_dummy_netdev(struct net_device *dev)
> +{
> +	/* Clear everything. Note we don't initialize spinlocks
> +	 * are they aren't supposed to be taken by any of the

I assume you meant s/are/as/ ?

> +	 * NAPI code and this dummy netdev is supposed to be
> +	 * only ever used for NAPI polls
> +	 */
> +	memset(dev, 0, sizeof(struct net_device));
> +	init_dummy_netdev_core(dev);
> +}
> +EXPORT_SYMBOL_GPL(init_dummy_netdev);

[1]
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index db2950baf6b4..bf66d996e32e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -132,20 +132,40 @@ struct mlxsw_pci {
        u8 num_cqs; /* Number of CQs */
        u8 num_sdqs; /* Number of SDQs */
        bool skip_reset;
-       struct net_device napi_dev_tx;
-       struct net_device napi_dev_rx;
+       struct net_device *napi_dev_tx;
+       struct net_device *napi_dev_rx;
 };
 
-static void mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
+static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 {
-       init_dummy_netdev(&mlxsw_pci->napi_dev_tx);
-       strscpy(mlxsw_pci->napi_dev_tx.name, "mlxsw_tx",
-               sizeof(mlxsw_pci->napi_dev_tx.name));
+       int err;
+
+       mlxsw_pci->napi_dev_tx = alloc_netdev_dummy(0);
+       if (!mlxsw_pci->napi_dev_tx)
+               return -ENOMEM;
+       strscpy(mlxsw_pci->napi_dev_tx->name, "mlxsw_tx",
+               sizeof(mlxsw_pci->napi_dev_tx->name));
+
+       mlxsw_pci->napi_dev_rx = alloc_netdev_dummy(0);
+       if (!mlxsw_pci->napi_dev_rx) {
+               err = -ENOMEM;
+               goto err_alloc_rx;
+       }
+       strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
+               sizeof(mlxsw_pci->napi_dev_rx->name));
+       dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
+
+       return 0;
 
-       init_dummy_netdev(&mlxsw_pci->napi_dev_rx);
-       strscpy(mlxsw_pci->napi_dev_rx.name, "mlxsw_rx",
-               sizeof(mlxsw_pci->napi_dev_rx.name));
-       dev_set_threaded(&mlxsw_pci->napi_dev_rx, true);
+err_alloc_rx:
+       free_netdev(mlxsw_pci->napi_dev_tx);
+       return err;
+}
+
+static void mlxsw_pci_napi_devs_fini(struct mlxsw_pci *mlxsw_pci)
+{
+       free_netdev(mlxsw_pci->napi_dev_rx);
+       free_netdev(mlxsw_pci->napi_dev_tx);
 }
 
 static char *__mlxsw_pci_queue_elem_get(struct mlxsw_pci_queue *q,
@@ -804,11 +824,11 @@ static void mlxsw_pci_cq_napi_setup(struct mlxsw_pci_queue *q,
 
        switch (cq_type) {
        case MLXSW_PCI_CQ_SDQ:
-               netif_napi_add(&mlxsw_pci->napi_dev_tx, &q->u.cq.napi,
+               netif_napi_add(mlxsw_pci->napi_dev_tx, &q->u.cq.napi,
                               mlxsw_pci_napi_poll_cq_tx);
                break;
        case MLXSW_PCI_CQ_RDQ:
-               netif_napi_add(&mlxsw_pci->napi_dev_rx, &q->u.cq.napi,
+               netif_napi_add(mlxsw_pci->napi_dev_rx, &q->u.cq.napi,
                               mlxsw_pci_napi_poll_cq_rx);
                break;
        }
@@ -1793,7 +1813,10 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
        if (err)
                goto err_requery_resources;
 
-       mlxsw_pci_napi_devs_init(mlxsw_pci);
+       err = mlxsw_pci_napi_devs_init(mlxsw_pci);
+       if (err)
+               goto err_napi_devs_init;
+
        err = mlxsw_pci_aqs_init(mlxsw_pci, mbox);
        if (err)
                goto err_aqs_init;
@@ -1811,6 +1834,8 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 err_request_eq_irq:
        mlxsw_pci_aqs_fini(mlxsw_pci);
 err_aqs_init:
+       mlxsw_pci_napi_devs_fini(mlxsw_pci);
+err_napi_devs_init:
 err_requery_resources:
 err_config_profile:
 err_cqe_v_check:
@@ -1838,6 +1863,7 @@ static void mlxsw_pci_fini(void *bus_priv)
 
        free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
        mlxsw_pci_aqs_fini(mlxsw_pci);
+       mlxsw_pci_napi_devs_fini(mlxsw_pci);
        mlxsw_pci_fw_area_fini(mlxsw_pci);
        mlxsw_pci_free_irq_vectors(mlxsw_pci);
 }

