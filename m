Return-Path: <bpf+bounces-71732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E3BFC8A9
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 004EF3544DB
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5134FF41;
	Wed, 22 Oct 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oQEsosCM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9834C144
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143245; cv=none; b=nAA2vcgnzIdw/Vnn+PNZwBdyMHOeBtqW8oZ6F4aIXhE2J3UKoA8p0Vghh3qLQPnheiaDriSym2JoxcVv2zymkOxkR+B8p+9KveLm+q1uQhrgmUePm1MolsAnC4GTlD3mMWkWiX5vpqJHdCGT2FwI8muuAak1Lo1CUk4pDgN6dpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143245; c=relaxed/simple;
	bh=RZM9nt+kwLCYwQZklggOSRY1olXaCxq9hVj3DYtBkOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtGbe5nrdoZ7miYvseU5Jg8JwxttSYZotLsUqCPuj0Gb4MsVTZVmNclwlmE7gcnDnZ4yvhcA6S/1lEF7Ze0By/fiXCoXY0+Ym2tvtIpE33lBkgHFKLW8E4ljuNZQ1KDL0aS6cwnWpRykIFkmYjgCw3ZJg8GL22ZYJh0o1wiV4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oQEsosCM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b64cdbb949cso1168497666b.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761143242; x=1761748042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6JXyTnl4/CTgSiYlD4AsySyt1xWwLhH6bPhS5L6+ns=;
        b=oQEsosCMj+q+bS0XPgzOe/ySDo6EtvE6qpsfUle6q/pc8j7SHko3v30geSxE4i/HvD
         FeakV8V8vZPP3VV6nw4CPHIiLaHpEAzTL1od3ZuxF32PBUwwLmVvsVxZBNDamxZQpY39
         5OSqFKHPCWLUx2lJc5i6ndMxvTcIRfBTsGVa2YyDSfcANuswNVkAZZyIXqK/tri8/VoI
         vSbKKKSUOy7cGicbJik92xi4Gk6dwg2y5qUed39FRhGLgACC9gNTlum2N63ESps54M7f
         1ZcsbqCqL2YRT2HaG1mHCPJA2tZ0ZtQ1eTKDuHgIKG5uoHWJ1TtlrV+Oc39TxGFlkELt
         GCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143242; x=1761748042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6JXyTnl4/CTgSiYlD4AsySyt1xWwLhH6bPhS5L6+ns=;
        b=ew6/W1QyL9kC81LMp3eUEyVRAu/8ezVzqN346KYge2YuTXIoFJt6V/ad+sVUSVClbD
         ZGxoo32teMLajSAg7cVrRUf2XWxI1YaUG6OoiH24MuJ0yQGyat4zMnKVWyU9hOgmgV5s
         qkOuf+7K6+xxaJFnujGfvf7YDUOaekb8jPUqgpeMeLwL1Qo3qSniCpx4oZcBnd1BOT3Q
         tfkP8jCVYEdcQYm/DpBhqnAWkseoQ1AQxrL4mnRK+PbBpTf+oGq+UAd65NrRlCgkwYwJ
         04fDBuyaqCuCMElnvh8shp4k8Zg89MxC+62xNCV0Qmx3lxAwF2cY8wCishEpw+NvnE09
         pb3A==
X-Gm-Message-State: AOJu0YxSXssMTeKlLnlmLyA/NvEg8sFzxouHqIowKHeRfK0M2zTHakk2
	mJC8SRjSyRsszVzpHPwzO2OJ+GIyA4IMX9w8ozQRaNjRMcuiGWfgtNc+DYNJ/EP34EQ=
X-Gm-Gg: ASbGncs+mCcKo8jFp/2omCDPdNDSgWK2GnPtJmHv+diPim9x4ztl24Wwpqd9/9/YbAB
	dK9FNuw4NP0wK6OoKks1jXvLYGdMrpvhZ+K1Ng2mia1YxTu195594DNXqu2uFWvWASi50h5YnPC
	wFOtahiEY69j3yVyKkox24Gm3q7LjfOyzR0DrYDXPKlmlPdR81Dmqsl1/Muz0S05Caj8n1wJiGU
	9qTGjIfUF6qzViExqEWplnjZ5FTPmJiWGOhYlDK/39g0ZjwdSMG5DICXiOpSEU4ADFyNceSx+0/
	dPKoPSOkI8RyuewKMhgNJk1yiDYJ9GtdUhiUxhlBNDi5W66yAM20BO+BHkOnRju3Vp2AKhZXrJc
	jwqSw31IcFWX8JK76QASfi78j/YjqCtIUZ2JlkxETd87ut9t5PpEw+fffPq0JtHfWetbLZ1fE1Y
	NOe23okjDIQz89SD5oQRn/78a3sd0dBuvO
X-Google-Smtp-Source: AGHT+IERjCtVPjayNeyvtIlXJNCXCbJfsnwrTGxOW9ZK5k/XoJSYtSsD3B7zemyh98rdbn4aRjVzNA==
X-Received: by 2002:a17:907:3c92:b0:b6b:d71:6d97 with SMTP id a640c23a62f3a-b6b0d71825amr1475084166b.31.1761143241998;
        Wed, 22 Oct 2025 07:27:21 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83937a3sm1374200266b.23.2025.10.22.07.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:27:21 -0700 (PDT)
Message-ID: <50d4a072-209e-4751-80c3-1929c536afcb@blackwall.org>
Date: Wed, 22 Oct 2025 17:27:20 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 15/15] netkit: Add xsk support for af_xdp
 applications
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-16-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-16-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Enable support for AF_XDP applications to operate on a netkit device.
> The goal is that AF_XDP applications can natively consume AF_XDP
> from network namespaces. The use-case from Cilium side is to support
> Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
> virtual machine management add-on for Kubernetes which aims to provide
> a common ground for virtualization. KubeVirt spawns the VMs inside
> Kubernetes Pods which reside in their own network namespace just like
> regular Pods.
> 
> Raw QEMU AF_XDP backend example with eth0 being a physical device with
> 16 queues where netkit is bound to the last queue (for multi-queue RSS
> context can be used if supported by the driver):
> 
>   # ethtool -X eth0 start 0 equal 15
>   # ethtool -X eth0 start 15 equal 1 context new
>   # ethtool --config-ntuple eth0 flow-type ether \
>             src 00:00:00:00:00:00 \
>             src-mask ff:ff:ff:ff:ff:ff \
>             dst $mac dst-mask 00:00:00:00:00:00 \
>             proto 0 proto-mask 0xffff action 15
>   [ ... setup BPF/XDP prog on eth0 to steer into shared xsk map ... ]
>   # ip netns add foo
>   # ip link add numrxqueues 2 nk type netkit single
>   # ./pyynl/cli.py --spec ~/netlink/specs/netdev.yaml \
>                    --do bind-queue \
>                    --json "{"src-ifindex": $(ifindex eth0), "src-queue-id": 15, \
>                             "dst-ifindex": $(ifindex nk), "queue-type": "rx"}"
>   {'dst-queue-id': 1}
>   # ip link set nk netns foo
>   # ip netns exec foo ip link set lo up
>   # ip netns exec foo ip link set nk up
>   # ip netns exec foo qemu-system-x86_64 \
>           -kernel $kernel \
>           -drive file=${image_name},index=0,media=disk,format=raw \
>           -append "root=/dev/sda rw console=ttyS0" \
>           -cpu host \
>           -m $memory \
>           -enable-kvm \
>           -device virtio-net-pci,netdev=net0,mac=$mac \
>           -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
>           -nographic
> 
> We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
> 100G NIC with successful network connectivity out of QEMU. An earlier
> iteration of this work was presented at LSF/MM/BPF [0].
> 
> For getting to a first starting point to connect all things with
> KubeVirt, bind mounting the xsk map from Cilium into the VM launcher
> Pod which acts as a regular Kubernetes Pod while not perfect, is not
> a big problem given its out of reach from the application sitting
> inside the VM (and some of the control plane aspects are baked in
> the launcher Pod already), so the isolation barrier is still the VM.
> Eventually the goal is to have a XDP/XSK redirect extension where
> there is no need to have the xsk map, and the BPF program can just
> derive the target xsk through the queue where traffic was received
> on.
> 
> The exposure through netkit is because Cilium should not act as a
> proxy handing out xsk sockets. Existing applications expect a netdev
> from kernel side and should not need to rewrite just to implement
> against a CNI's protocol. Also, all the memory should not be accounted
> against Cilium but rather the application Pod itself which is consuming
> AF_XDP. Further, on up/downgrades we expect the data plane to being
> completely decoupled from the control plane; if Cilium would own the
> sockets that would be disruptive. Another use-case which opens up and
> is regularly asked from users would be to have DPDK applications on
> top of AF_XDP in regular Kubernetes Pods.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
> ---
>  drivers/net/netkit.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index a281b39a1047..f69abe5ec4cd 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -12,6 +12,7 @@
>  #include <net/netdev_lock.h>
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
> +#include <net/xdp_sock_drv.h>
>  #include <net/netkit.h>
>  #include <net/dst.h>
>  #include <net/tcx.h>
> @@ -235,6 +236,71 @@ static void netkit_get_stats(struct net_device *dev,
>  	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
>  }
>  
> +static bool netkit_xsk_supported_at_phys(const struct net_device *dev)
> +{
> +	if (!dev->netdev_ops->ndo_bpf ||
> +	    !dev->netdev_ops->ndo_xdp_xmit ||
> +	    !dev->netdev_ops->ndo_xsk_wakeup)
> +		return false;
> +	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK)
> +		return false;
> +	return true;
> +}
> +
> +static int netkit_xsk(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	struct netkit *nk = netkit_priv(dev);
> +	struct netdev_bpf xdp_lower;
> +	struct netdev_rx_queue *rxq;
> +	struct net_device *phys;
> +
> +	switch (xdp->command) {
> +	case XDP_SETUP_XSK_POOL:
> +		if (nk->pair == NETKIT_DEVICE_PAIR)
> +			return -EOPNOTSUPP;
> +		if (xdp->xsk.queue_id >= dev->real_num_rx_queues)
> +			return -EINVAL;
> +
> +		rxq = __netif_get_rx_queue(dev, xdp->xsk.queue_id);
> +		if (!rxq->peer)
> +			return -EOPNOTSUPP;
> +
> +		phys = rxq->peer->dev;
> +		if (!netkit_xsk_supported_at_phys(phys))
> +			return -EOPNOTSUPP;
> +
> +		memcpy(&xdp_lower, xdp, sizeof(xdp_lower));
> +		xdp_lower.xsk.queue_id = get_netdev_rx_queue_index(rxq->peer);
> +		break;
> +	case XDP_SETUP_PROG:
> +		return -EPERM;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
> +}
> +
> +static int netkit_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct net_device *phys;
> +
> +	if (queue_id >= dev->real_num_rx_queues)
> +		return -EINVAL;
> +
> +	rxq = __netif_get_rx_queue(dev, queue_id);
> +	if (!rxq->peer)
> +		return -EOPNOTSUPP;
> +
> +	phys = rxq->peer->dev;
> +	if (!netkit_xsk_supported_at_phys(phys))
> +		return -EOPNOTSUPP;
> +
> +	return phys->netdev_ops->ndo_xsk_wakeup(phys,
> +			get_netdev_rx_queue_index(rxq->peer), flags);
> +}
> +
>  static int netkit_init(struct net_device *dev)
>  {
>  	netdev_lockdep_set_classes(dev);
> @@ -255,6 +321,8 @@ static const struct net_device_ops netkit_netdev_ops = {
>  	.ndo_get_peer_dev	= netkit_peer_dev,
>  	.ndo_get_stats64	= netkit_get_stats,
>  	.ndo_uninit		= netkit_uninit,
> +	.ndo_bpf		= netkit_xsk,
> +	.ndo_xsk_wakeup		= netkit_xsk_wakeup,
>  	.ndo_features_check	= passthru_features_check,
>  };
>  
> @@ -409,10 +477,11 @@ static void netkit_setup(struct net_device *dev)
>  	dev->hw_enc_features = netkit_features;
>  	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
>  	dev->vlan_features = dev->features & ~netkit_features_hw_vlan;
> -
>  	dev->needs_free_netdev = true;
>  
>  	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> +
> +	xdp_set_features_flag(dev, NETDEV_XDP_ACT_XSK);
>  }
>  
>  static struct net *netkit_get_link_net(const struct net_device *dev)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


