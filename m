Return-Path: <bpf+bounces-46605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84799EC8D1
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4756F188CEAD
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8412336AB;
	Wed, 11 Dec 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMhG//Qv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFED233689;
	Wed, 11 Dec 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908749; cv=none; b=qG+uEvAuvriuhRKrzn2foBAdEqjURhU4x3/mEcAbB6/qKsRZUVUbhIA956PYPZbyL8dRjWOtinlED4dmiZjTjflzRTe3ARvoAXGHFbD9OvaFq6YahRsHFJgoWYzXPKxDUnq6iaBoXzms9qnB78PJ6v50wUgZ6I5QxNQx7nbvhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908749; c=relaxed/simple;
	bh=ccDv+BGItuiw6xibkArOPmLn7r/DfMsgf4dDFe1Php0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiV/1twCXvtvuvrwpVQ6zuk1hAWEK1Y28YxVbzwW4DkW9/WmmC4dGaZSFCgE6iU2yBuzwBbic6VEt3q4Z+6nafITEoN8hJtnKMFItEYgqs6O+avGdiyZIajcgfLOuvYujx9XzxkA927w2PU3IEphVO1vklLZJtES2+/aUPezVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMhG//Qv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724d23df764so5907092b3a.1;
        Wed, 11 Dec 2024 01:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733908743; x=1734513543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1jyiwzd0Z/n+82kPVa6gi9A3SNfZqteAOTVnxb9JOc=;
        b=JMhG//QvlCEGg0YCWTkbyLOtRsoAIaqrinrMMCmQp+srwSO8bZhsyQ77bnVjr2g+mv
         O2H6EzPVp8rw3QThw1uClaHFoul44eIf3M7tf93jsVWDgGJ8Fn+0HSAzfqXLHw/qWB47
         DvXEwz841oBVc8zUxuJTMEOc50FLiL9KmkUdjeeApVmbbolNDdtCzNN9xka0t5y+f4yu
         sdu4ZneVTLSjQ5WgbUMBvjV9d1Wkpa2CeaMP7oLooKM5nkDB07Rq0Z4vQbdLsNJ1UNWg
         OdSlSq2UMKWJ0y6haTcNTU61etquL9/UrDetHOpISqcAMQ6GyWNCX9tBgoSTQHG10gat
         HJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908743; x=1734513543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1jyiwzd0Z/n+82kPVa6gi9A3SNfZqteAOTVnxb9JOc=;
        b=ZAJvnPSVVCVk1hM52VhhFQ1vYO23yh9x56tQdoc/xfpCi+CLOYPFeYBeymEtyWwzua
         swAsO5wZxgW5L2xtyiiK05lzL16MIHmgOGS/KiciXHo71kQWlhlAcDk7YIVY3pO32Zjp
         +l6+3Vy1Uw9SxP4+CDWUDTj6GI990iWw4pQ8lVkrvNRJZJDaAQnnDPWbA08qmD/KgXoy
         EtACD3Hqr2huAnTBz/f5doEzW0rIVcz72dbsfNYY76Yel4ArHUGirnQtMOfPpX12zwZn
         geMvDUVDD9JA8HkV/N6vR0wT2ROTNR8DGkE/sWzMfZtm027xyJlLTBkuDnOiSR10z7ql
         3IoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPW9TPU7CSGg3z8q+bGsdYIrQs5pvvtdLX/nSrmmLc001o+3RaIFPqLmFKbQGusb757lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3A+qCxxAUM0SH/0QkOx7QYSmJHO8LSugcFgs3wk9zgmRMvSBw
	778NvBGBjUFSL26N70Ofo5H7H3rocaKpnsPX/BYWMEt/fUql1jn/4Lehu/FR
X-Gm-Gg: ASbGncv8tddkrD/0bmqbdeXISs9YXevEhze977i2lxscBWSGYlmwDZ32Op9K8LIPTnF
	bFOgZmmkUdUoUBtjKADzaAoYfhkyh7hb09pFiNrvqgCQGCNhsPEgFaXtnH87Uy+wz1eAbZYz771
	hV7pRt/7gO8jH+G18aL85Pmi/Y9kEKQw+aB6bAZ21V2YLJp1wmyPWiMkBhirqaJjpDRV6DHTjOl
	QNkwHPjYyupdlRub2/y/gRqCfda3xJVo2xgeXnKBNm6G4xi7oc30E1j27s=
X-Google-Smtp-Source: AGHT+IEylXEntLivv8RY1Wajt83uGqYDaX6PobDf/srxEzJ3hpDOb1NT8RlLWyzwtwrtBB0AbOzZGw==
X-Received: by 2002:a05:6a21:3394:b0:1dc:e8d:c8f0 with SMTP id adf61e73a8af0-1e1c139a731mr4135313637.29.1733908743414;
        Wed, 11 Dec 2024 01:19:03 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cc7fcfb2sm7731809b3a.141.2024.12.11.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:19:02 -0800 (PST)
Date: Wed, 11 Dec 2024 09:18:57 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net 3/5] bonding: Fix feature propagation of
 NETIF_F_GSO_ENCAP_ALL
Message-ID: <Z1lZAT_lzl3G2v6V@fedora>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210141245.327886-3-daniel@iogearbox.net>

On Tue, Dec 10, 2024 at 03:12:43PM +0100, Daniel Borkmann wrote:
> Drivers like mlx5 expose NIC's vlan_features such as
> NETIF_F_GSO_UDP_TUNNEL & NETIF_F_GSO_UDP_TUNNEL_CSUM which are
> later not propagated when the underlying devices are bonded and
> a vlan device created on top of the bond.
> 
> Right now, the more cumbersome workaround for this is to create
> the vlan on top of the mlx5 and then enslave the vlan devices
> to a bond.
> 
> To fix this, add NETIF_F_GSO_ENCAP_ALL to BOND_VLAN_FEATURES
> such that bond_compute_features() can probe and propagate the
> vlan_features from the slave devices up to the vlan device.
> 
> Given the following bond:
> 
>   # ethtool -i enp2s0f{0,1}np{0,1}
>   driver: mlx5_core
>   [...]
> 
>   # ethtool -k enp2s0f0np0 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: on
>   rx-udp-gro-forwarding: off
> 
>   # ethtool -k enp2s0f1np1 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: on
>   rx-udp-gro-forwarding: off
> 
>   # ethtool -k bond0 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: off [fixed]
>   rx-udp-gro-forwarding: off
> 
> Before:
> 
>   # ethtool -k bond0.100 | grep udp
>   tx-udp_tnl-segmentation: off [requested on]
>   tx-udp_tnl-csum-segmentation: off [requested on]
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: off [fixed]
>   rx-udp-gro-forwarding: off
> 
> After:
> 
>   # ethtool -k bond0.100 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: off [fixed]
>   rx-udp-gro-forwarding: off
> 
> Various users have run into this reporting performance issues when
> configuring Cilium in vxlan tunneling mode and having the combination
> of bond & vlan for the core devices connecting the Kubernetes cluster
> to the outside world.
> 
> Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 320dd71392ef..7b78c2bada81 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1534,6 +1534,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
>  
>  #define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
>  				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> +				 NETIF_F_GSO_ENCAP_ALL | \
>  				 NETIF_F_HIGHDMA | NETIF_F_LRO)
>  
>  #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -- 
> 2.43.0
> 
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

