Return-Path: <bpf+bounces-68982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68666B8B57A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BCAD4E2152
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD82D6410;
	Fri, 19 Sep 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="N3JoIo34"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111D2C029C;
	Fri, 19 Sep 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317531; cv=none; b=jakvYi2IMDQwTvqQvisklmY9MSenVs83QIPOZG2vFiFo+ay1oorY4ZAGC2W/5wbFUOjBYE5QSnuUQL9MllIjpmixHCknWwnX0E2ShkT7M8MCzLVoo5hk9rx/0bPtbpA5eNOZD2fl/LYqU3vCgKHti9ZikMKN5QosRu3KeojURwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317531; c=relaxed/simple;
	bh=Odu2cbCnp787JaTYJJTVkAGeCswNgCv46XCig/OHxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyPpYRDx7B9HjcP1jqzjLjrI055KXylnEnLkV+2eqgDzRdgP1Xb7RLJw2AChY32Mcie81inJhYBFGsoOxko50k/59SgLXq5fj/IEkLaUW6oQNbDcPjn59Hdwc7qQMy2qpDdTENufbqL/Jo0Of4F6D2+AxDp7NpmufvZaccuMOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=N3JoIo34; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9TOxTiJg//vS9gtm6X3V3jz1BAHoN+xI3f9f2tp03ZQ=; b=N3JoIo34BHhZNsmcIICk9PBL5u
	bWO+oHzx2YzaWxiIzx1xjJMDNZAem1Iq3ud/BJjuYHjsxWR/7COOZ43SxzxsntXiPn8Hl/WiQ/mNQ
	duir4PsXOjOOBq1ofm0nhQzQQZRZ4vHn8ZdJCg9ACKBXX+Zjtx14NianrEPnrHjJo2sKFf+LDkW+g
	6dc+x/lJ9D1mlj6fUtU8XuZgogqCuQukT+riEQ8kJxSNsyN7B1xJKsSnaRnjgUrOT8/iWIIuzZd/e
	zP7aJNLpQwwoeIdnrJVbCD0e6NqLP6z/NsXZ+VcgMGGBOiTLXsmElY7CMKimDhg+wnksarm95C0ah
	MpVG4lQA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzii1-000NqO-2X;
	Fri, 19 Sep 2025 23:32:01 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 07/20] net, ethtool: Disallow mapped real rxqs to be resized
Date: Fri, 19 Sep 2025 23:31:40 +0200
Message-ID: <20250919213153.103606-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

Similar to AF_XDP, do not allow queues in a physical netdev to be
resized by ethtool -L when they are peered.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/ethtool/channels.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index ca4f80282448..0ede1075e016 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <net/netdev_rx_queue.h>
 #include <net/xdp_sock_drv.h>
 
 #include "netlink.h"
@@ -169,14 +170,19 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* ensure channels are not busy at the moment */
 	from_channel = channels.combined_count +
 		       min(channels.rx_count, channels.tx_count);
-	for (i = from_channel; i < old_total; i++)
+	for (i = from_channel; i < old_total; i++) {
+		if (netdev_rx_queue_peered(dev, i)) {
+			GENL_SET_ERR_MSG(info, "requested channel counts are too low due to existing queue peering");
+			return -EINVAL;
+		}
 		if (xsk_get_pool_from_qid(dev, i)) {
 			GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing zerocopy AF_XDP sockets");
 			return -EINVAL;
 		}
+	}
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	return ret < 0 ? ret : 1;
-- 
2.43.0


