Return-Path: <bpf+bounces-15901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5507FA13E
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F235B21155
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16C2FE38;
	Mon, 27 Nov 2023 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="O/YSnbK8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE22111;
	Mon, 27 Nov 2023 05:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=jFd/xkuX/ftetMANpbJB4kdYUDf7JGwdEouihkb81Hg=; b=O/YSnbK8TbXGiVNqeT6AY2IwYV
	M/Zqqw0c0PkAVi6Z695Mc6/0Pbb3PAgg9kfr2i8F17NdF9fYiBODQsau1C2IxNYfNasAUposXxkeg
	JeQnFCIssGSnfTuStmUY8G9YVK7n92gXLhQCxHxLoK2Ce5xJ7f+Y1+5dLMG/RGEHikyRLgnuikr+7
	se4MvJ5ra1aXW74Y8GoCWYEMaZiWZx53K1V5DFe9DTDOrRPzvARFBbCf3cmvwOzoIdKSycBYORx21
	8XnjsTU2jl4YPA6QqolG6jqGClfDZpcltf9AvFohb/o8vdopfAEkyYD6/TDCiYamVh2YZY7DcVWWp
	lD5Aaa0A==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r7btJ-0006Pv-5f; Mon, 27 Nov 2023 14:43:13 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] netkit: Reject IFLA_NETKIT_PEER_INFO in netkit_change_link
Date: Mon, 27 Nov 2023 14:43:11 +0100
Message-Id: <20231127134311.30345-1-daniel@iogearbox.net>
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
---
 drivers/net/netkit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 97bd6705c241..35553b16b8e2 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -851,6 +851,12 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 		return -EACCES;
 	}
 
+	if (data[IFLA_NETKIT_PEER_INFO]) {
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
+				    "netkit peer info cannot be changed after device creation");
+		return -EACCES;
+	}
+
 	if (data[IFLA_NETKIT_POLICY]) {
 		attr = data[IFLA_NETKIT_POLICY];
 		policy = nla_get_u32(attr);
-- 
2.27.0


