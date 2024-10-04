Return-Path: <bpf+bounces-40924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B79D99009E
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32C01F21757
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B814D6E1;
	Fri,  4 Oct 2024 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="En1rlGKn"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799414AD2B;
	Fri,  4 Oct 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036820; cv=none; b=mqb+S265pA89DJnitpadm0UIJJ4vd/9fGQDYUv9vm11d74cjn8c1uCKM+s7hJdjBkU67rsTjiHn/IEmQmfaRm8nfctHhhuyidX3g0oslLLXC7jUkPioiL5+Kf3lDuM6YBjdzWSJD6dU5saSGg8edbCDN4H0TPXL5mAxs3AoLaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036820; c=relaxed/simple;
	bh=B6if5tMMZ9GJi1tFuCoWoOLntlXQ47B5NMRgYA4olpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWxV5XtHrSQJbOTCjXep8w0bqpLReaAMh+I2Rotc/zeopkyKAsr+RrF5vx8QhMI7e5EnYtey3Pjd8G68uRpCkAoZuwvSPqw+KSEKrdCe6QDDYKxO+fXugie/z7Wbxz+hiEC+JYl7re8G6SHmDfxoMbXNoWaN4JpsdfU2lR1+xHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=En1rlGKn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IqONZw7NdWqlh6ST1cwKGMJ3mKRzsHntCJoL3bxEg6Q=; b=En1rlGKnfOIf6vIGIQh0QJvdCh
	YL116nWmp741mlIHl4ZpGcCX4LL3ybjdlOZKco3qI4VHx9cW9hjC74v8OgNXZGFnu8vD28MMod6Qh
	jZ1lXQBxI+gqBoaQcH53h+nU+slBo3kbbXTTBHWTq9hotqkXTrodhzeEX6fBR8Wg/xvHu7NMGXoRi
	mkG1oQziUevx5ukCg9CqFcbpdzkxdYqPSamnLmbZjJEuEQpux8rEx01364j0/F5q1iIQGGAm1QlJ/
	q0Octrwnq1w3ieYpTjjxp38R8BO41C6YY6il4zETZ8bFPEyU25Q+UTszYCsKx5N95fK7+Bt//SvpP
	HGzrLgHw==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swfJY-000BVJ-On; Fri, 04 Oct 2024 12:13:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	kuba@kernel.org,
	jrife@google.com,
	tangchen.1@bytedance.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 2/5] netkit: Simplify netkit mode over to use NLA_POLICY_MAX
Date: Fri,  4 Oct 2024 12:13:32 +0200
Message-Id: <20241004101335.117711-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004101335.117711-1-daniel@iogearbox.net>
References: <20241004101335.117711-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27417/Fri Oct  4 10:53:24 2024)

Jakub suggested to rely on netlink policy validation via NLA_POLICY_MAX()
instead of open-coding it. netkit_check_mode() is a candidate which can
be simplified through this as well aside from the netkit scrubbing one.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 v1 -> v2:
   - new patch, also use NLA_POLICY_MAX here (Jakub)

 drivers/net/netkit.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index fba2c734f0ec..cd8360b9bbde 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -311,20 +311,6 @@ static int netkit_check_policy(int policy, struct nlattr *tb,
 	}
 }
 
-static int netkit_check_mode(int mode, struct nlattr *tb,
-			     struct netlink_ext_ack *extack)
-{
-	switch (mode) {
-	case NETKIT_L2:
-	case NETKIT_L3:
-		return 0;
-	default:
-		NL_SET_ERR_MSG_ATTR(extack, tb,
-				    "Provided device mode can only be L2 or L3");
-		return -EINVAL;
-	}
-}
-
 static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
@@ -360,13 +346,8 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	int err;
 
 	if (data) {
-		if (data[IFLA_NETKIT_MODE]) {
-			attr = data[IFLA_NETKIT_MODE];
-			mode = nla_get_u32(attr);
-			err = netkit_check_mode(mode, attr, extack);
-			if (err < 0)
-				return err;
-		}
+		if (data[IFLA_NETKIT_MODE])
+			mode = nla_get_u32(data[IFLA_NETKIT_MODE]);
 		if (data[IFLA_NETKIT_PEER_INFO]) {
 			attr = data[IFLA_NETKIT_PEER_INFO];
 			ifmp = nla_data(attr);
@@ -976,7 +957,7 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
-	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
+	[IFLA_NETKIT_MODE]		= NLA_POLICY_MAX(NLA_U32, NETKIT_L3),
 	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
 	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
 	[IFLA_NETKIT_SCRUB]		= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
-- 
2.43.0


