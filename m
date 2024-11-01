Return-Path: <bpf+bounces-43715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6E9B8EFF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948D71C23E42
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD60199939;
	Fri,  1 Nov 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJzswM9g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8231991A3;
	Fri,  1 Nov 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456347; cv=none; b=U7YPutm276mxFrGKaFmjLrGsqCEsBmhyrdQ4aHxfjMFTQZ00LaASNIb9R8tPjMOWF87jsNBAIXKSL6hh8DO2xSAi26ZG1NyVt3YztZUyBjzFBm1/WkcB5TE5JD1SWpgrTrObWGv9cIPnV6XBwuIdx57eSTKNT6PQtZL6Qzy4t/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456347; c=relaxed/simple;
	bh=U6tpuulTeOgvwtvb5sojTOh2aLlWGBBVysX1bDTyIMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtUOzVb5lmUoj5TXwLyYeBGAZhNhHYDIXTPFd2w0VImoDn2RLW2LVHSAxXJPzgc5dWewKoqByQOL5FXatw5BVfSQeRF38gUb12YdPURtKsul7VbI/eBOzLsN3y/gaVAlGABm70QZuWC65rWvw5L++WAGH0/HbeznXYr2Lw4Gygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJzswM9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55B8C4CECF;
	Fri,  1 Nov 2024 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730456346;
	bh=U6tpuulTeOgvwtvb5sojTOh2aLlWGBBVysX1bDTyIMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rJzswM9gvxJZm0FSQR178z4DVdY+PcV4io9MbtUNkSH/EQi0ZEC8GNNgRr3DX83fS
	 sT1HikFL11HulC69np/p9PL02XrFXzSB7oU6Po9dqjTE37vYWcGfOTO9A+o08I0/56
	 iCagb0/In7uauEJpAAanIbtct3jHjz2n5ENWthlwmURQHqhawE0kMj6JwY2FvXjWtW
	 1YEoyanhuCiPOansiJwTaHE42tdEMNq7PYdiA4eVK4pyq93HdW2hNa5LlJX+c2y0H0
	 6RZuFrGFz/6ZD2Syi/Dvnl7KmMuRfyiNVApkTWd5A3sH6F1Av5vKsljVipbMdN9AZh
	 i0hDvtYdq2Ahw==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 01 Nov 2024 12:18:51 +0200
Subject: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: fix warning in
 am65_cpsw_nuss_remove_rx_chns()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-am65-cpsw-multi-rx-j7-fix-v3-2-338fdd6a55da@kernel.org>
References: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
In-Reply-To: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>, 
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=U6tpuulTeOgvwtvb5sojTOh2aLlWGBBVysX1bDTyIMw=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnJKsNcaiR4BPsDDyrSNOWdM/Xg4jhrTrgJBlEP
 0WEh4DKpv2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZySrDQAKCRDSWmvTvnYw
 kwqFD/wNRFWCGfFUZ642Jr12qkcRUBFhVTWTXrm7p2CLvKdQwPFoVreRP7qbIARHEPnjAv8y7RC
 mYKy+fpf0XR+R6L1qp9jbBETjRDFgj2uKPKridBaTLdoIKTVqNioJKn7ZWrntfSLWgdlFJFdeDa
 wz05MJBCkCAaDBN/7JRAnwwxYe6ugGpOox0n3Rw3PreQagaw28Hk0a8SLrToYXFNdyWVy/KwXJc
 Ih0v0Uf+GEuCX+a+pQzV9jpxTn0gxntM9HSLQ/aRjeJNVjqCdfLLQkpl/bu6jvhhov75RfB6Wj0
 Ojgfs8jBCnbBUksMHppcdPUGmeYZP0mXmDXEEHqQmIysMkkCAyLg6YscFLStOyUhXr2uiWnnGL+
 wuRdDLRfMsBhJFoR4lh4XOF8t6QvvktDvZoBNBgN/23/wGZ2LNE6UfmUaUzV37bkwzAxgC2UwH2
 TmOz6r6igzKSMFUpjAbVOlUmPHDrlVS7zW+J2uGn76/rS/WrVWgRl+r/jicnofybaRYejIoM4Qp
 BAeIeLtSovZJeRIkeV2DRRP/Us1APNxsLrT5oxcHVDeb/1MeBXmqiB0fy00YS+qFLM/mP2y5kok
 IuOQXF7wjWBLmygBWtSVq5nc6m3zWNCaIPhpWDL2kA5bRbRSsKzSI/Stexy96liT3zzSLp34Npp
 QWV2AepsIHkxHQQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

flow->irq is initialized to 0 which is a valid IRQ. Set it to -EINVAL
in error path of am65_cpsw_nuss_init_rx_chns() so we do not try
to free an unallocated IRQ in am65_cpsw_nuss_remove_rx_chns().

If user tried to change number of RX queues and am65_cpsw_nuss_init_rx_chns()
failed due to any reason, the warning will happen if user tries to change
the number of RX queues after the error condition.

root@am62xx-evm:~# ethtool -L eth0 rx 3
[   40.385293] am65-cpsw-nuss 8000000.ethernet: set new flow-id-base 19
[   40.393211] am65-cpsw-nuss 8000000.ethernet: Failed to init rx flow2
netlink error: Invalid argument
root@am62xx-evm:~# ethtool -L eth0 rx 2
[   82.306427] ------------[ cut here ]------------
[   82.311075] WARNING: CPU: 0 PID: 378 at kernel/irq/devres.c:144 devm_free_irq+0x84/0x90
[   82.469770] Call trace:
[   82.472208]  devm_free_irq+0x84/0x90
[   82.475777]  am65_cpsw_nuss_remove_rx_chns+0x6c/0xac [ti_am65_cpsw_nuss]
[   82.482487]  am65_cpsw_nuss_update_tx_rx_chns+0x2c/0x9c [ti_am65_cpsw_nuss]
[   82.489442]  am65_cpsw_set_channels+0x30/0x4c [ti_am65_cpsw_nuss]
[   82.495531]  ethnl_set_channels+0x224/0x2dc
[   82.499713]  ethnl_default_set_doit+0xb8/0x1b8
[   82.504149]  genl_family_rcv_msg_doit+0xc0/0x124
[   82.508757]  genl_rcv_msg+0x1f0/0x284
[   82.512409]  netlink_rcv_skb+0x58/0x130
[   82.516239]  genl_rcv+0x38/0x50
[   82.519374]  netlink_unicast+0x1d0/0x2b0
[   82.523289]  netlink_sendmsg+0x180/0x3c4
[   82.527205]  __sys_sendto+0xe4/0x158
[   82.530779]  __arm64_sys_sendto+0x28/0x38
[   82.534782]  invoke_syscall+0x44/0x100
[   82.538526]  el0_svc_common.constprop.0+0xc0/0xe0
[   82.543221]  do_el0_svc+0x1c/0x28
[   82.546528]  el0_svc+0x28/0x98
[   82.549578]  el0t_64_sync_handler+0xc0/0xc4
[   82.553752]  el0t_64_sync+0x190/0x194
[   82.557407] ---[ end trace 0000000000000000 ]---

Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 70aea654c79f..ba6db61dd227 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2441,6 +2441,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		flow = &rx_chn->flows[i];
 		flow->id = i;
 		flow->common = common;
+		flow->irq = -EINVAL;
 
 		rx_flow_cfg.ring_rxfdq0_id = fdqring_id;
 		rx_flow_cfg.rx_cfg.size = max_desc_num;
@@ -2483,6 +2484,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		if (ret) {
 			dev_err(dev, "failure requesting rx %d irq %u, %d\n",
 				i, flow->irq, ret);
+			flow->irq = -EINVAL;
 			goto err;
 		}
 	}

-- 
2.34.1


