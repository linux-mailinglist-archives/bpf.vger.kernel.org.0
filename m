Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CEB4028F1
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbhIGMh7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 08:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344251AbhIGMho (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 08:37:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D9260F92;
        Tue,  7 Sep 2021 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631018198;
        bh=FA/EVrYFSTFpTADyITKX9uSlVd/VD7kQxzs4/HwGnRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MK/ud5AS9Gg2RpTikv1HYelMOprgUTjW13zhk1LL74nGYosdT05p+iPxQYHLVRs5a
         F63vhMfEMWJfjp+upuTAA6xsZ5ZWq0I7zy0SdFGU6QcsaHZLJODENKQIHrVtdHd16/
         FK1ci+0flGxK+4SaD7HaXIfsu8uK2ySbbBV+ImxYYPXnLY+K1kEj2cUW7LaCfbck9N
         pLU/X+Xw6o0dCEamZ54YRZ6ILZfN748PVVu90V2ZItvTm9U4dKXR10L0MpFlKplnND
         tSPHJY0Xq7QokB8qky+cxWadSLxfjoVjnkRcAmqqmpNwO0hi9BxmGVyU40G+kQsk/U
         NvtNQmvarZhsw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: [PATCH v13 bpf-next 09/18] net: mvneta: enable jumbo frames for XDP
Date:   Tue,  7 Sep 2021 14:35:13 +0200
Message-Id: <bb310a9caf34bbf867ad45fabae17bb34ff39f2f.1631007211.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631007211.git.lorenzo@kernel.org>
References: <cover.1631007211.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable the capability to receive jumbo frames even if the interface is
running in XDP mode

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 7137e9a5f8e6..707fff28b405 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3767,11 +3767,6 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		mtu = ALIGN(MVNETA_RX_PKT_SIZE(mtu), 8);
 	}
 
-	if (pp->xdp_prog && mtu > MVNETA_MAX_RX_BUF_SIZE) {
-		netdev_info(dev, "Illegal MTU value %d for XDP mode\n", mtu);
-		return -EINVAL;
-	}
-
 	dev->mtu = mtu;
 
 	if (!netif_running(dev)) {
@@ -4481,11 +4476,6 @@ static int mvneta_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 	struct mvneta_port *pp = netdev_priv(dev);
 	struct bpf_prog *old_prog;
 
-	if (prog && dev->mtu > MVNETA_MAX_RX_BUF_SIZE) {
-		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
-		return -EOPNOTSUPP;
-	}
-
 	if (pp->bm_priv) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Hardware Buffer Management not supported on XDP");
-- 
2.31.1

