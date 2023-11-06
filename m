Return-Path: <bpf+bounces-14328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493367E2EEE
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 22:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2451C208CA
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689332E65B;
	Mon,  6 Nov 2023 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxbDyqsH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68562C859;
	Mon,  6 Nov 2023 21:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BE7C433C7;
	Mon,  6 Nov 2023 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699306127;
	bh=HeCGytM/CxpByzJMdq2pZz7dPN27FdYys9/RqjZeljY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gxbDyqsHT+3gfotbEtP8TuQyCIBs2qA9CzCeGe3TkT9us+umZgjr+8oaiYC4vzESV
	 UH3QDglZoPdkR8KqY5lXbfKUEFntG7eWPYVgRKv1UUbT/H0nX8ua6Hfq+Ehm39FBF1
	 gUe4XQMyRrziEFdIiEyRwNi2GTbPAt7Nu/uLyvfoakmQAqseFgZIEeYImnS5hYIeXr
	 6C2vyjnBkfUS6xNbY29ipYfzYUf5ZweFxSAAuoY0yT4MyLuV9zenkU6IVcqmPC4tRf
	 K8zI/a8/BIyMIek1h5qOHrPcs5kaTbfvf7EnbOo/RsSpebtTCcKnXLSda/W1/IXieD
	 KUIvjAFfHHrtg==
Date: Mon, 6 Nov 2023 13:28:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH bpf 1/6] netkit: Add tstats per-CPU traffic counters
Message-ID: <20231106132845.6356bc72@kernel.org>
In-Reply-To: <20231103222748.12551-2-daniel@iogearbox.net>
References: <20231103222748.12551-1-daniel@iogearbox.net>
	<20231103222748.12551-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Nov 2023 23:27:43 +0100 Daniel Borkmann wrote:
> Add dev->tstats traffic accounting to netkit. The latter contains per-CPU
> RX and TX counters.
> 
> The dev's TX counters are bumped upon pass/unspec as well as redirect
> verdicts, in other words, on everything except for drops.
> 
> The dev's RX counters are bumped upon successful __netif_rx(), as well
> as from skb_do_redirect() (not part of this commit here).
> 
> Using dev->lstats with having just a single packets/bytes counter and
> inferring one another's RX counters from the peer dev's lstats is not
> possible given skb_do_redirect() can also bump the device's stats.

sorry for the delay in replying, I'll comment here instead of on:

https://lore.kernel.org/all/6d5cb0ef-fabc-7ca3-94b2-5b1925a6805f@iogearbox.net/

What I had in mind was to have the driver just set the type of stats.
That way it doesn't have to bother with error handling either
(allocation failure checking, making sure free happens in the right
spot etc. all happen in the core). Here's a completely untested diff:



diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9980517ed8b0..c23cb7dc0122 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1506,25 +1506,12 @@ static void veth_free_queues(struct net_device *dev)
 
 static int veth_dev_init(struct net_device *dev)
 {
-	int err;
-
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
-		return -ENOMEM;
-
-	err = veth_alloc_queues(dev);
-	if (err) {
-		free_percpu(dev->lstats);
-		return err;
-	}
-
-	return 0;
+	return veth_alloc_queues(dev);
 }
 
 static void veth_dev_free(struct net_device *dev)
 {
 	veth_free_queues(dev);
-	free_percpu(dev->lstats);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -1802,6 +1789,8 @@ static void veth_setup(struct net_device *dev)
 	dev->hw_enc_features = VETH_FEATURES;
 	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTAT;
 }
 
 /*
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 208c63f177f4..25e71480ca58 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1797,6 +1797,13 @@ enum netdev_ml_priv_type {
 	ML_PRIV_CAN,
 };
 
+enum netdev_stat_type {
+	NETDEV_PCPU_STAT_NONE,
+	NETDEV_PCPU_STAT_LSTAT, /* struct pcpu_lstats */
+	NETDEV_PCPU_STAT_TSTAT, /* struct pcpu_sw_netstats */
+	NETDEV_PCPU_STAT_DSTAT, /* struct pcpu_dstats */
+};
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -2354,6 +2361,8 @@ struct net_device {
 	void				*ml_priv;
 	enum netdev_ml_priv_type	ml_priv_type;
 
+	/** @pcpu_stat_type: type of per-CPU stats in use */
+	enum netdev_stat_type pcpu_stat_type:8;
 	union {
 		struct pcpu_lstats __percpu		*lstats;
 		struct pcpu_sw_netstats __percpu	*tstats;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..15fec94c7d24 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10049,6 +10049,45 @@ void netif_tx_stop_all_queues(struct net_device *dev)
 }
 EXPORT_SYMBOL(netif_tx_stop_all_queues);
 
+static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
+{
+	void __percpu *v;
+
+	switch (dev->pcpu_stat_type) {
+	case NETDEV_PCPU_STAT_NONE:
+		return 0;
+	case NETDEV_PCPU_STAT_LSTAT:
+		v = dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
+		break;
+	case NETDEV_PCPU_STAT_TSTAT:
+		v = dev->tstats =
+			netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+		break;
+	case NETDEV_PCPU_STAT_DSTAT:
+		v = dev->dstats = netdev_alloc_pcpu_stats(struct pcpu_dstats);
+		break;
+	}
+
+	return v ? 0 : -ENOMEM;
+}
+
+static void netdev_do_free_pcpu_stats(struct net_device *dev)
+{
+	switch (dev->pcpu_stat_type) {
+	case NETDEV_PCPU_STAT_NONE:
+		return;
+	case NETDEV_PCPU_STAT_LSTAT:
+		free_percpu(dev->lstats);
+		break;
+	case NETDEV_PCPU_STAT_TSTAT:
+		free_percpu(dev->tstats);
+		break;
+	case NETDEV_PCPU_STAT_DSTAT:
+		free_percpu(dev->dstats);
+		break;
+	}
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -10109,9 +10148,13 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	ret = netdev_do_alloc_pcpu_stats(dev);
+	if (ret)
+		goto err_uninit;
+
 	ret = dev_index_reserve(net, dev->ifindex);
 	if (ret < 0)
-		goto err_uninit;
+		goto err_free_pcpu;
 	dev->ifindex = ret;
 
 	/* Transfer changeable features to wanted_features and enable
@@ -10217,6 +10260,8 @@ int register_netdevice(struct net_device *dev)
 	call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
 err_ifindex_release:
 	dev_index_release(net, dev->ifindex);
+err_free_pcpu:
+	netdev_do_free_pcpu_stats(dev);
 err_uninit:
 	if (dev->netdev_ops->ndo_uninit)
 		dev->netdev_ops->ndo_uninit(dev);
@@ -10469,6 +10514,7 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		netdev_do_free_pcpu_stats(dev);
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
 		if (dev->needs_free_netdev)

