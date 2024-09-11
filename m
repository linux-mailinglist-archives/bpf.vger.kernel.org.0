Return-Path: <bpf+bounces-39593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC012974DBF
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD241F214D1
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556515B155;
	Wed, 11 Sep 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVzfJFcW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC92BAEF;
	Wed, 11 Sep 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045165; cv=none; b=ZMOD4Vxw+hgNE20XfamExmnpOT+J7pTlGcgC31S00SvHMQcg5QojvxbfZN5gA6Q5umbbXqVu6hPp/4UU9xj479RD3oJbquesxBydQFMxtRa/XxE54ohGdSJQOz1K2HRkU3btU29jAnxSsbj6z0hMzcwY1S7xl691KLPTI85xSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045165; c=relaxed/simple;
	bh=r4bBF14gBANTikwNF+yeRO3cMKhd/yFgq4Vd69aTAIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIGVpi07PEeFJr1zUpmwUkzd40I6CkyJ/iqAAN9rwqcdtKZHArDAhGavAD38lnUBpKMeBCUE/d8QovVQNEgc693U2t1LKZor09PU/wY/n9HSzJvRx4Ln67yC5iRTKjBchM0Suhm6a7mavmZZlsyqKh+gk+QxDh2oSDr2J03GxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVzfJFcW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d43657255so485603866b.0;
        Wed, 11 Sep 2024 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726045162; x=1726649962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBnUI6afKDpCiR+H0AbE0esdnGanX/F6vO5Tln9iGbU=;
        b=nVzfJFcWIVbPk37LnYCyxTAp/s0YXXQAsTIp4SGAMrmVOk6snPJb7lrraHpP6gH7C4
         a2ofho4MwaexS4tOBUWyoojy2wmXPfA1z7rns3o1n1IyX6hHxFz0vL8ciyFI56zaJ9dT
         DPz2SjJWca/6U395v6lzVbKqQc0GhiXxUuOy79HU4W/KpdVIx8jnhkGlfLu2aG6EAxyM
         eShLIScBvFUKM93xqtMeNpAHLvs5fK0G/NJyDw2cUzH+nKx7KUONP9hc36iRh2G3H90O
         KuibebwkMcFnSxChAEDPuj0lmW+eSbFxB8VGW1QJMo0ups7oZuy7cnAGPQ8ERgscCs9X
         /8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045162; x=1726649962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBnUI6afKDpCiR+H0AbE0esdnGanX/F6vO5Tln9iGbU=;
        b=RMrdLkQ5VV6rbsdMNFhYX5H4nOgS3SFZCFtA6TyOQLQBMXwPzPXlTPpAQGpHV2EGW8
         FDhXfW/T/tntVYV1VNFSSaCXW1TcMGaXDAJlyWcJZ5EWOfOEu0SdGWgHrwAKEgqQKA4+
         IoX17rQQeipd37+H1KXYQEDDX/fC86mYxsAietlkPfCVjTvyCOkfQqN+wjr+1/lhrTFn
         tPrtASfgRAQO/iVoV5TC/jU4+RueebXeMO2pyoaZyRiZqUHesk7YHv4L1FlqhZL3JXIg
         JTrOYdKVyKwQyTUU1By7sqc8D+F3ZsR/dKA45xBI1v7n4kExSJeu5cKaAV9CCe2JYuca
         lgxw==
X-Forwarded-Encrypted: i=1; AJvYcCUHHzckl17y6e9ngRkUHss7T/OVpXtV56NI6nU4+XYLj00TFmZa8nHNTDpx+JbCcbPeuzdl4FlPcVBmh692@vger.kernel.org, AJvYcCV8u2PZAgH2FSc+jRHaXETLEPSIeOiWQwae7tW5wSYZM8Ft+PszjtFetnCRj3IeA+DHBP4=@vger.kernel.org, AJvYcCVDwNTui2mTtFsGPP/cFzhL9avgr0QRO5hHSWl9EBN39gGujSI+6LCw37KWt9Wfoy2dtlqprw3P@vger.kernel.org, AJvYcCXhUQAb2xkie+ZqVYBsM4HSBF4ud8ibuB/ZQH8ElOduHMgyI993SAWw2ysSDJ58jzDejvsPuTtOrLcjYg==@vger.kernel.org, AJvYcCXlBA3fMdqgJ9jJuVhUD9bZaVVODYrEGFVinm8EitT//zhCLNQIPWFMPUAGd9UEfuo8JkF3CS4drlvDPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HXH5IxViubZe4XHYIAj9OJJz8tCCP6pMTvh+zs+/Cztla5wm
	8QGC/KIM5w8dXWd9Xzq6DAmviZZothlsRKlD4qZkpxjXV8bIBMSA
X-Google-Smtp-Source: AGHT+IEVvCYGMT20AlONXArI5ZJU+ATjkgjMkDZAN5mCoU6BHx1n0N9IPfznfrfqCGL9lGquKsWsKA==
X-Received: by 2002:a17:907:96a2:b0:a86:81b8:543f with SMTP id a640c23a62f3a-a8ffae0b0c3mr317186966b.64.1726045160878;
        Wed, 11 Sep 2024 01:59:20 -0700 (PDT)
Received: from localhost ([5.255.99.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d63c0fsm591527466b.213.2024.09.11.01.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:59:20 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:59:19 +0300
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Tariq Toukan <tariqt@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: Fix error path in multi-packet WQE transmit
Message-ID: <ZuFb54umfQDpfc6N@mail.gmail.com>
References: <20240910-fix-mlx5_dma_unmap-v1-1-6ae3d19d0b86@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-fix-mlx5_dma_unmap-v1-1-6ae3d19d0b86@linux.ibm.com>

On Tue, 10 Sep 2024 at 10:53:51 +0200, Gerd Bayer wrote:
> Remove the erroneous unmap in case no DMA mapping was established
> 
> The multi-packet WQE transmit code attempts to obtain a DMA mapping for
> the skb. This could fail, e.g. under memory pressure, when the IOMMU
> driver just can't allocate more memory for page tables. While the code
> tries to handle this in the path below the err_unmap label it erroneously
> unmaps one entry from the sq's FIFO list of active mappings.

The fix looks valid to me, thanks!

Acked-by: Maxim Mikityanskiy <maxtram95@gmail.com>

> Since the
> current map attempt failed this unmap is removing some random DMA mapping
> that might still be required. If the PCI function now presents that IOVA,
> the IOMMU may assumes a rogue DMA access and e.g. on s390 puts the PCI
> function in error state.
> 
> The erroneous behavior was seen in a stress-test environment that created
> memory pressure.
> 
> Fixes: 5af75c747e2a ("net/mlx5e: Enhanced TX MPWQE for SKBs")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> While running some stress tests that put our system under memory pressure
> we observed the following splat, eventually:
> 
>     [ 1350.038775] ------------[ cut here ]------------
>     [ 1350.038776] WARNING: CPU: 36 PID: 37194 at arch/s390/include/asm/pci_dma.h:136 dma_update_cpu_trans+0x66/0x70
>     [ 1350.038799] Modules linked in: macvtap macvlan vhost_net vhost vhost_iotlb tap tun xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables nfnetlink lcs ctcm fsm dasd_fba_mod mlx5_ib ib_uverbs ib_core mlx5_core
>     "
>     "mlxfw psample rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs tls dm_service_time 8021q garp mrp rfkill sd_mod t10_pi sg sunrpc zfcp scsi_transport_fc dm_multipath dm_mod vfio_ccw mdev vfio_iommu_type1 vfio eadm_sch iommufd kvm drm i2c_core drm_panel_orientation_quirks xfs libcrc32c qeth_l2
>     "
>     " bridge stp llc ghash_s390 prng aes_s390 dasd_eckd_mod des_s390 libdes sha3_512_s390 qeth sha3_256_s390 dasd_mod ccwgroup qdio pkey zcrypt fuse
>     [ 1350.038880] CPU: 36 PID: 37194 Comm: vhost-37179 Kdump: loaded Tainted: G               X  -------  ---  5.14.0-427.20.1.el9_4.s390x #1
>     [ 1350.038884] Hardware name: IBM 3931 A01 400 (LPAR)
>     [ 1350.038886] Krnl PSW : 0704f00180000000 00000056803d1eba (dma_update_cpu_trans+0x6a/0x70)
>     [ 1350.038890]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
>     [ 1350.038893] Krnl GPRS: 0000000000000000 0000000589eff400 0000003be2b477b0 0000000000000000
>     [ 1350.038895]            0000000000000400 0000000000001000 0000000000000400 ffffffbe8000a000
>     [ 1350.038897]            0000000000000001 0000000086d6bc00 0000000000000001 000000417fff7000
>     [ 1350.038900]            000000012d5baa00 0000000000000000 00000056803d1f3e 0000038016df75d8
>     [ 1350.038957] Krnl Code: 00000056803d1eae: af000000            mc      0,0
>     [ 1350.038963]            00000056803d1eb2: a7f4fff9            brc     15,00000056803d1ea4
>     [ 1350.038963]           #00000056803d1eb6: af000000            mc      0,0
>     [ 1350.038970]           >00000056803d1eba: a7f4ffd9            brc     15,00000056803d1e6c
>     [ 1350.038979]            00000056803d1ebe: 0707                bcr     0,%r7
>     [ 1350.038983]            00000056803d1ec0: c004004b3334        brcl    0,0000005680d38528
>     [ 1350.038983]            00000056803d1ec6: eb7ff0500024        stmg    %r7,%r15,80(%r15)
>     [ 1350.038983]            00000056803d1ecc: b90400ef            lgr     %r14,%r15
>     [ 1350.038994] Call Trace:
>     [ 1350.038995]  [<00000056803d1eba>] dma_update_cpu_trans+0x6a/0x70
>     [ 1350.038998] ([<00000056803d1f22>] __dma_update_trans+0x62/0x150)
>     [ 1350.039001]  [<00000056803d2432>] s390_dma_unmap_pages+0x72/0x1c0
>     [ 1350.039003]  [<000000568047e70c>] dma_unmap_page_attrs+0x3c/0x190
>     [ 1350.039008]  [<000003ff807c5230>] mlx5e_sq_xmit_mpwqe+0x2b0/0x430 [mlx5_core]
>     [ 1350.039170]  [<000003ff807c589e>] mlx5e_xmit+0x20e/0x5a0 [mlx5_core]
>     [ 1350.039246]  [<0000005680aae326>] dev_hard_start_xmit+0xb6/0x210
>     [ 1350.039252]  [<0000005680b144d8>] sch_direct_xmit+0x88/0x420
>     [ 1350.039256]  [<0000005680aa9496>] __dev_xmit_skb+0x2c6/0x5c0
>     [ 1350.039259]  [<0000005680aae93e>] __dev_queue_xmit+0x36e/0x840
>     [ 1350.039262]  [<000003ff809e3b6a>] macvlan_start_xmit+0x6a/0x140 [macvlan]
>     [ 1350.039266]  [<0000005680aae326>] dev_hard_start_xmit+0xb6/0x210
>     [ 1350.039269]  [<0000005680aaeae8>] __dev_queue_xmit+0x518/0x840
>     [ 1350.039271]  [<000003ff809b40f4>] tap_get_user_xdp.isra.0+0x134/0x300 [tap]
>     [ 1350.039274]  [<000003ff809b4354>] tap_sendmsg+0x94/0xc0 [tap]
>     [ 1350.039277]  [<000003ff809d4f06>] vhost_tx_batch.constprop.0+0x66/0x1a0 [vhost_net]
>     [ 1350.039281]  [<000003ff809d6a5e>] handle_tx_copy+0x24e/0x340 [vhost_net]
>     [ 1350.039283]  [<000003ff809d6c0c>] handle_tx+0xbc/0x100 [vhost_net]
>     [ 1350.039286]  [<000003ff809bb6f2>] vhost_worker+0xa2/0x100 [vhost]
>     [ 1350.039294]  [<000000568040be98>] kthread+0x108/0x110
>     [ 1350.039299]  [<000000568038afdc>] __ret_from_fork+0x3c/0x60
>     [ 1350.039302]  [<0000005680d2e89a>] ret_from_fork+0xa/0x40
>     [ 1350.039307] Last Breaking-Event-Address:
>     [ 1350.039308]  [<00000056803d1e68>] dma_update_cpu_trans+0x18/0x70
>     [ 1350.039310] ---[ end trace a581115ebebd62f3 ]---
>     
> And here the IOMMU complains about the "rogue DMA attempt":
>     [ 1350.043079] zpci: 0037:00:00.0: Event 0x7 reports an error for PCI function 0x3932
>     
> With some instrumentation in mlx5e_sq_xmit_mpwqe() to mimic a failure
> to DMA map every 1000th buffer, I was able to reproduce this with recent
> upstream code, too. I think the error handling of that routine has a bug
> as it DMA unmaps a buffer/IOVA that might be used, still.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> index b09e9abd39f3..f8c7912abe0e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -642,7 +642,6 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>  	return;
>  
>  err_unmap:
> -	mlx5e_dma_unmap_wqe_err(sq, 1);
>  	sq->stats->dropped++;
>  	dev_kfree_skb_any(skb);
>  	mlx5e_tx_flush(sq);
> 
> ---
> base-commit: 8d53a5170c8677af9b3fbd9d0b75ae120fdefba2
> change-id: 20240909-fix-mlx5_dma_unmap-e2a12e26e929
> 
> Best regards,
> -- 
> Gerd Bayer <gbayer@linux.ibm.com>
> 

