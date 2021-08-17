Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111613EE7D3
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 09:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhHQHyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 03:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhHQHyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 03:54:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73253C0613CF
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 00:54:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u15so8533263plg.13
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypyY+Uqc+Z2ZZW93qVfCBhIjoZdHXKViPbFJWksLXyw=;
        b=zT3Q4BfuKTe1/h5Cue4i0alXI++5/qEOTcetPdbWNDd5BT1u+30szX/nxKKtPTtRYq
         OyAMbpKI3Pg3UuoEf8zSfz6l9unAlkyNJaeaL3Xtfq1lTw68wHfq2l5ruVozMW+e3H52
         //iG+wCIP7yoaBRB2Bc+mMrPeNGQPH+vJ2ydbT8NyCMra+lTstYuSk5bYmajOJPHvjwW
         syFKeRkNKYYmkpMX7lrasN2P2JdkhYdVrOpwCgSRSMGehDR0zc1MIyqbBoYgifWtf5w+
         Xkad6k7S9ga6IAk/T00DYnvU0m0R+x5RFYEcaAy6pX4GZh6vVWY39lEgGhJivvRbS/TO
         +IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypyY+Uqc+Z2ZZW93qVfCBhIjoZdHXKViPbFJWksLXyw=;
        b=RBAL1MACuuU7h0+980B+aJ0u/TxDTIXdZ/alMpo7BcuhEXtdG5tss2O7Tfpzq9xojg
         sdpkqVPl1w4/cf+lTvQ7WyfRcibTHFYAGvEWby6aAutdYtiNVMSIp3g8yLF5TDHBQLmS
         x2nOIrBO1O2KUbFrJtxvKf6wIYWlSj7fJfSpTdVEPXtcoDl/7KEPoUGX1h3anF1BrU6F
         E2joYbhacW7JaFHfVlqWycLSK50mErQBvrNiUDhh4O8+LkHtkXF80/rsqBF00TjKM24d
         +swak8oprZRshTxDcP/X00nCRWK5uf8uKRi+Pl5KxTTxLKaVSB1nSUfQd54VvnXRcV4A
         JxHA==
X-Gm-Message-State: AOAM530PjxMqOFlCe2uMhYC/uFEsAqgh9slM7/9eeunlpR8orWQ+/jIa
        PHlHQFb/Mqo8iErhLkOtsz01sQ==
X-Google-Smtp-Source: ABdhPJye1vzAfWWx07/uMcHku/JU3zMK/QgXPEu+ekIr4KWMO6ud6T6xHHof6LTdTXnfKmiOfg5fCw==
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id j11-20020aa7800b0000b0290330455f57a8mr2381541pfi.7.1629186859912;
        Tue, 17 Aug 2021 00:54:19 -0700 (PDT)
Received: from FVFX41FWHV2J.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id j6sm1722212pgh.17.2021.08.17.00.54.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 00:54:19 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        jeffrey.t.kirsher@intel.com, magnus.karlsson@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH] ixgbe: Fix NULL pointer dereference in ixgbe_xdp_setup
Date:   Tue, 17 Aug 2021 15:54:07 +0800
Message-Id: <20210817075407.11961-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

The ixgbe driver currently generates a NULL pointer dereference with
some machine (online cpus < 63). This is due to the fact that the
maximum value of num_xdp_queues is nr_cpu_ids. Code is in
"ixgbe_set_rss_queues"".

Here's how the problem repeats itself:
Some machine (online cpus < 63), And user set num_queues to 63 through
ethtool. Code is in the "ixgbe_set_channels",
adapter->ring_feature[RING_F_FDIR].limit = count;
It becames 63.
When user use xdp, "ixgbe_set_rss_queues" will set queues num.
adapter->num_rx_queues = rss_i;
adapter->num_tx_queues = rss_i;
adapter->num_xdp_queues = ixgbe_xdp_queues(adapter);
And rss_i's value is from
f = &adapter->ring_feature[RING_F_FDIR];
rss_i = f->indices = f->limit;
So "num_rx_queues" > "num_xdp_queues", when run to "ixgbe_xdp_setup",
for (i = 0; i < adapter->num_rx_queues; i++)
	if (adapter->xdp_ring[i]->xsk_umem)
lead to panic.
Call trace:
[exception RIP: ixgbe_xdp+368]
RIP: ffffffffc02a76a0  RSP: ffff9fe16202f8d0  RFLAGS: 00010297
RAX: 0000000000000000  RBX: 0000000000000020  RCX: 0000000000000000
RDX: 0000000000000000  RSI: 000000000000001c  RDI: ffffffffa94ead90
RBP: ffff92f8f24c0c18   R8: 0000000000000000   R9: 0000000000000000
R10: ffff9fe16202f830  R11: 0000000000000000  R12: ffff92f8f24c0000
R13: ffff9fe16202fc01  R14: 000000000000000a  R15: ffffffffc02a7530
ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 7 [ffff9fe16202f8f0] dev_xdp_install at ffffffffa89fbbcc
 8 [ffff9fe16202f920] dev_change_xdp_fd at ffffffffa8a08808
 9 [ffff9fe16202f960] do_setlink at ffffffffa8a20235
10 [ffff9fe16202fa88] rtnl_setlink at ffffffffa8a20384
11 [ffff9fe16202fc78] rtnetlink_rcv_msg at ffffffffa8a1a8dd
12 [ffff9fe16202fcf0] netlink_rcv_skb at ffffffffa8a717eb
13 [ffff9fe16202fd40] netlink_unicast at ffffffffa8a70f88
14 [ffff9fe16202fd80] netlink_sendmsg at ffffffffa8a71319
15 [ffff9fe16202fdf0] sock_sendmsg at ffffffffa89df290
16 [ffff9fe16202fe08] __sys_sendto at ffffffffa89e19c8
17 [ffff9fe16202ff30] __x64_sys_sendto at ffffffffa89e1a64
18 [ffff9fe16202ff38] do_syscall_64 at ffffffffa84042b9
19 [ffff9fe16202ff50] entry_SYSCALL_64_after_hwframe at ffffffffa8c0008c

Fixes: 4a9b32f30f80 ("ixgbe: fix potential RX buffer starvation for
AF_XDP")
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 14aea40da50f..5db496cc5070 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10112,6 +10112,7 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct bpf_prog *old_prog;
 	bool need_reset;
+	int num_queues;
 
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		return -EINVAL;
@@ -10161,11 +10162,14 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	/* Kick start the NAPI context if there is an AF_XDP socket open
 	 * on that queue id. This so that receiving will start.
 	 */
-	if (need_reset && prog)
-		for (i = 0; i < adapter->num_rx_queues; i++)
+	if (need_reset && prog) {
+		num_queues = min_t(int, adapter->num_rx_queues,
+			adapter->num_xdp_queues);
+		for (i = 0; i < num_queues; i++)
 			if (adapter->xdp_ring[i]->xsk_pool)
 				(void)ixgbe_xsk_wakeup(adapter->netdev, i,
 						       XDP_WAKEUP_RX);
+	}
 
 	return 0;
 }
-- 
2.11.0

