Return-Path: <bpf+bounces-16001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407587FAAE9
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 21:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704361C20DF8
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F7C45BEA;
	Mon, 27 Nov 2023 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VmKpj9vx"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9301B6;
	Mon, 27 Nov 2023 12:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=3sYHApJEhrikdY6gZ/hr+GuinNtUT06O9O+W+re7GnI=; b=VmKpj9vxiG4UofWJJt4ol1USKg
	tAuiQMFKRUW9LYilJ5hM+6qRIIbn9CDlX6Ep01YK0ZqOPaRFCTYCP4Gw3RcBw2+MGcdm61M9FZEdW
	c+CSb02JYFjg8/jvlG/bUS0oFuD+qqb495S7EdDOSmY/GcekMj2pmTKAF1U4RWvey6Wu5e62nM3e9
	Nwh8OKt7nngBNwSQw/KPN7TIuEnBs2lO4GpXKWkDLaVoObZpQUoXItAsbMGutlgKnl9QB1pnk+0WB
	iy3g+s1ha+/lEoOce0gCruoJMxw3faR0FYDa5s+AGzy7cZm2eIGt6zrnbh1fG6IHsL48JF+VRcTxm
	Dw2aSPLQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r7hrN-0009hU-34; Mon, 27 Nov 2023 21:05:37 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf v2] netkit: Reject IFLA_NETKIT_PEER_INFO in netkit_change_link
Date: Mon, 27 Nov 2023 21:05:33 +0100
Message-Id: <e86a277a1e8d3b19890312779e42f790b0605ea4.1701115314.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27106/Mon Nov 27 09:39:12 2023)

The IFLA_NETKIT_PEER_INFO attribute can only be used during device
creation, but not via changelink callback. Hence reject it there.

Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 v1 -> v2:
   - Switch error code from EACCES to EINVAL (Jakub)

 drivers/net/netkit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 97bd6705c241..39171380ccf2 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -851,6 +851,12 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 		return -EACCES;
 	}
 
+	if (data[IFLA_NETKIT_PEER_INFO]) {
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
+				    "netkit peer info cannot be changed after device creation");
+		return -EINVAL;
+	}
+
 	if (data[IFLA_NETKIT_POLICY]) {
 		attr = data[IFLA_NETKIT_POLICY];
 		policy = nla_get_u32(attr);
-- 
2.21.0


