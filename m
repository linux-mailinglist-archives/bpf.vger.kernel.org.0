Return-Path: <bpf+bounces-58648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD7ABF223
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4204F7AF25D
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED202609EE;
	Wed, 21 May 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J3oOrIJv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C425FA3F;
	Wed, 21 May 2025 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824754; cv=none; b=gE6SppzM7jRsht4Ws4WrkZoyOBzvbeNu8yP7DgZX62SUUzvIWEvTj2PI7X6Ln2Y0xevQJiA8F60RrK4iK6/b8hK35qYWVbYuZYx8xATJ7+rAmSC+Zf3pTfhPFUy43sOVQgvBjz2U7hkDfaC6BqqnC5kJ3K7x2TCaBfg9XY6K0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824754; c=relaxed/simple;
	bh=NuhKwHI2nW53UE351PC9BJ73o4Df/w7BYnciDnGlPqU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ2I/GsXOlZGsimVs/ez/ZXjX/bJkr1cTIAvAjFZW+W6PVqy8aqY2TfIBBnKOr2hHc+q5ipPlzzqH+j8WBcvWiy176KFgKDs68TV5y2tdIy9H08a2Yhk5pLKDCYC/SloRxtSIyNVefLV0F44x8R4zEiaRKsXxZuSiuRe3OOXfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J3oOrIJv; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qfAg001293;
	Wed, 21 May 2025 03:52:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yAkH1FsqP6lKT2Kz3bz3cS/am
	EwGvdmgThbUuXd/2HE=; b=J3oOrIJvsb9JwWrYTYUg5HoVyvby6YjKOzvIac4mB
	oqg5qDH2zy9c6SgyT3lF5Xza60ekuH27xKtQ+ABOEhGruJy1qUBgOA09FsrjHCb6
	WuwUJMos+byz/DXOtJn5bY9benie3ZJnnyeLOF3jCDJW1Ch95KZVpov8PmT1Z00S
	KskLyDsIYX1fPFJUaeYG59xiaaQn7qpQHqeujYvC5CzXzfhDM1cfAEeBKsv8vrRL
	0IZ4+AGyVaklts4G4azFsTZ2CjqTp3tV3dw4td1rSe6X6gufKtOPT8khvSwuI1J+
	PIENTttBGElRmjDJOiBoVMaFbNk+I4KNCpMsoGOBxq2Cg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sbxkr5k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 03:52:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 21 May 2025 03:52:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 May 2025 03:52:04 -0700
Received: from 2af006248302 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 0E6D03F70B3;
	Wed, 21 May 2025 03:51:56 -0700 (PDT)
Date: Wed, 21 May 2025 10:51:55 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
CC: <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <sdf@fomichev.me>, <kuniyu@amazon.com>,
        <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
        <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <ssengar@microsoft.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH net,v2] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
Message-ID: <aC2wS-GnVytjQNm3@2af006248302>
References: <1747823103-3420-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1747823103-3420-1-git-send-email-ssengar@linux.microsoft.com>
X-Proofpoint-ORIG-GUID: ubpNTmvJRL_YTz8i4BpJaf9ToudIqBaJ
X-Proofpoint-GUID: ubpNTmvJRL_YTz8i4BpJaf9ToudIqBaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNyBTYWx0ZWRfXyZcmM+fgOod7 XVeKABA7Uosfk24JbWOtilartf+b8D5m3dEc95XDXDUgZ8c02zaddYo8yc0kqp5IRlxedd1S+PS DTu2Nt9MrYQyGIZufg9rF2f/x5J/s0ivuSp3n6jWpnVhmcZVUeCSpHrSFYSi2YASeXNGzqlRPih
 qkprG/+AXinHHis9bWPIaDR20RWMoy/54MOnN+DYM1LljDUMhgHDugFuEJ0zz5v74PVCkvQSmKK 2mDDeDQoqmJ02SdqXddQ/zqUZd3fcWyVmrRavFqLWSTKBqvgNo/63YdE5UUDGfw+QW8QA5kaupu 52SCAGmUdiAko1NDxhwB9GLM8/BDvKMifVYAotjWReEJ4/mfu/7Ji0iAOYSnXgu3XhTV1/RU4XJ
 ouKEfK5fHxMUaMdVqiBUFCtc2E7ZucI55M1W8dANarhz5R3x7QR0muZmEgnZ60XfilGGU2aP
X-Authority-Analysis: v=2.4 cv=U72SDfru c=1 sm=1 tr=0 ts=682db055 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=2B81ANjg1XA65u3fEzcA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01

On 2025-05-21 at 10:25:03, Saurabh Sengar (ssengar@linux.microsoft.com) wrote:
> The MANA driver's probe registers netdevice via the following call chain:
> 
> mana_probe()
>   register_netdev()
>     register_netdevice()
> 
> register_netdevice() calls notifier callback for netvsc driver,
> holding the netdev mutex via netdev_lock_ops().
> 
> Further this netvsc notifier callback end up attempting to acquire the
> same lock again in dev_xdp_propagate() leading to deadlock.
> 
> netvsc_netdev_event()
>   netvsc_vf_setxdp()
>     dev_xdp_propagate()
> 
> This deadlock was not observed so far because net_shaper_ops was never set,
> and thus the lock was effectively a no-op in this case. Fix this by using
> netif_xdp_propagate() instead of dev_xdp_propagate() to avoid recursive
> locking in this path.
> 
> Also, clean up the unregistration path by removing the unnecessary call to
> netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already
> performs this cleanup via dev_xdp_uninstall().
> 
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Tested-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep
> ---
> [V2]
>  - Modified commit message
> 
>  drivers/net/hyperv/netvsc_bpf.c | 2 +-
>  drivers/net/hyperv/netvsc_drv.c | 2 --
>  net/core/dev.c                  | 1 +
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> index e01c5997a551..1dd3755d9e6d 100644
> --- a/drivers/net/hyperv/netvsc_bpf.c
> +++ b/drivers/net/hyperv/netvsc_bpf.c
> @@ -183,7 +183,7 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
>  	xdp.command = XDP_SETUP_PROG;
>  	xdp.prog = prog;
>  
> -	ret = dev_xdp_propagate(vf_netdev, &xdp);
> +	ret = netif_xdp_propagate(vf_netdev, &xdp);
>  
>  	if (ret && prog)
>  		bpf_prog_put(prog);
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index d8b169ac0343..ee3aaf9c10e6 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2462,8 +2462,6 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
>  
>  	netdev_info(ndev, "VF unregistering: %s\n", vf_netdev->name);
>  
> -	netvsc_vf_setxdp(vf_netdev, NULL);
> -
>  	reinit_completion(&net_device_ctx->vf_add);
>  	netdev_rx_handler_unregister(vf_netdev);
>  	netdev_upper_dev_unlink(vf_netdev, ndev);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fccf2167b235..8c6c9d7fba26 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9953,6 +9953,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  
>  	return dev->netdev_ops->ndo_bpf(dev, bpf);
>  }
> +EXPORT_SYMBOL_GPL(netif_xdp_propagate);
>  
>  u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
>  {
> -- 
> 2.43.0
> 

