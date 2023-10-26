Return-Path: <bpf+bounces-13307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F07D7FDD
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 11:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E15B281ED0
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83BC2D025;
	Thu, 26 Oct 2023 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="nAMQqUyc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC128E3C
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:42:33 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C318F
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 02:42:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5720a321aso9072631fa.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698313349; x=1698918149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRFqQRbJwohV4hz3RUlZk8QhY1exu1Qc9CmvHK/zHWc=;
        b=nAMQqUycVRyuBEtkerF/kNAVW3CxT/K+TJXPAz3FVs+B9Z8mjIhdBGJFuy9ftlqCEW
         v4EAivcjwYqZgUxr52+21Lon+/fjseuDlMDR+GywILno8AXWmxQllFNmCvoxZr8yaKHs
         oPgwKkowgH/9On20jPt1NQtX9zy1gtshvPCWdoKQIcZgbgQSPltf7NiwjNm7r2Kv4KRv
         gD4j+9hk0W/oTzzpg9qYedHdOElhA7MyP5tirK/qxX9MaFoe8OZFyFh+qZdNLsolWVTT
         B9CaYGB2OPn/6Pnur0RYkvExgkz2wFPxHheLs2cIjFzxr9dx38eBxY7C5CRn8HdtVsEC
         LV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313349; x=1698918149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRFqQRbJwohV4hz3RUlZk8QhY1exu1Qc9CmvHK/zHWc=;
        b=Jho1HZ7iv8muYtZN+cEbUJS0OHekILJiXevR4yfsacG8L11thAGaln+gfedhBysDkz
         m+x/mw3G0Kei+1zxPpQuZLot3i8FDF6NI5YeZ1fXBf63WKSJqEQBCkcoNVSNH8PGPojS
         tVn7WkDUhYKGplnEDP6RqqE90rswnMza19xGHYsiPpICwqbd8zoWcSSX+tWnXNds8wDk
         LL5QsdeARWKc7N0fPjFnUjuk4naj9DLk9c72i7/W3xtWWhA43DqhE7RUnokPYEQEh9an
         pmOiGyhQubPtZk0653hZhB3tEn06+nc3z6nnilXnsgdi7AtPLwVLOcrkP7+SyCjNNf3e
         JU6Q==
X-Gm-Message-State: AOJu0Yy31RLPOSRytp0ROxb7R+K1T7CEtrgqim2HOGPxAHZVLjalUwj+
	f7anwivHN8IJd5RG6lYONFRMebEQ+mvV3NE6Na3erA==
X-Google-Smtp-Source: AGHT+IFCQFMVHABFdXKPA187ltQqoa+6AuQmZhvGADpF8JfxXb18rohfsdiZnoqCjVHFPiwA2ttYrA==
X-Received: by 2002:a2e:a7d2:0:b0:2c5:72e:6ff9 with SMTP id x18-20020a2ea7d2000000b002c5072e6ff9mr13075111ljp.6.1698313349053;
        Thu, 26 Oct 2023 02:42:29 -0700 (PDT)
Received: from dev.. (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c470d00b00407460234f9sm2082121wmo.21.2023.10.26.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:42:28 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: jiri@resnulli.us,
	netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	toke@kernel.org,
	toke@redhat.com,
	sdf@google.com,
	daniel@iogearbox.net,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and policy attributes validation
Date: Thu, 26 Oct 2023 12:41:06 +0300
Message-Id: <20231026094106.1505892-3-razor@blackwall.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231026094106.1505892-1-razor@blackwall.org>
References: <20231026094106.1505892-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netlink's NLA_POLICY_VALIDATE_FN() type for mode and primary/peer
policy with custom validation functions to return better errors. This
simplifies the logic a bit and relies on netlink's policy validation.
We don't have to specify len because the type is NLA_U32 and attribute
length is enforced by netlink.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 66 +++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5a0f86f38f09..1ce116e68f95 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -247,29 +247,29 @@ static struct net *netkit_get_link_net(const struct net_device *dev)
 	return peer ? dev_net(peer) : dev_net(dev);
 }
 
-static int netkit_check_policy(int policy, struct nlattr *tb,
+static int netkit_check_policy(const struct nlattr *attr,
 			       struct netlink_ext_ack *extack)
 {
-	switch (policy) {
+	switch (nla_get_u32(attr)) {
 	case NETKIT_PASS:
 	case NETKIT_DROP:
 		return 0;
 	default:
-		NL_SET_ERR_MSG_ATTR(extack, tb,
+		NL_SET_ERR_MSG_ATTR(extack, attr,
 				    "Provided default xmit policy not supported");
 		return -EINVAL;
 	}
 }
 
-static int netkit_check_mode(int mode, struct nlattr *tb,
+static int netkit_check_mode(const struct nlattr *attr,
 			     struct netlink_ext_ack *extack)
 {
-	switch (mode) {
+	switch (nla_get_u32(attr)) {
 	case NETKIT_L2:
 	case NETKIT_L3:
 		return 0;
 	default:
-		NL_SET_ERR_MSG_ATTR(extack, tb,
+		NL_SET_ERR_MSG_ATTR(extack, attr,
 				    "Provided device mode can only be L2 or L3");
 		return -EINVAL;
 	}
@@ -306,13 +306,8 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
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
@@ -324,20 +319,10 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 				return err;
 			tbp = peer_tb;
 		}
-		if (data[IFLA_NETKIT_POLICY]) {
-			attr = data[IFLA_NETKIT_POLICY];
-			default_prim = nla_get_u32(attr);
-			err = netkit_check_policy(default_prim, attr, extack);
-			if (err < 0)
-				return err;
-		}
-		if (data[IFLA_NETKIT_PEER_POLICY]) {
-			attr = data[IFLA_NETKIT_PEER_POLICY];
-			default_peer = nla_get_u32(attr);
-			err = netkit_check_policy(default_peer, attr, extack);
-			if (err < 0)
-				return err;
-		}
+		if (data[IFLA_NETKIT_POLICY])
+			default_prim = nla_get_u32(data[IFLA_NETKIT_POLICY]);
+		if (data[IFLA_NETKIT_PEER_POLICY])
+			default_peer = nla_get_u32(data[IFLA_NETKIT_PEER_POLICY]);
 	}
 
 	if (ifmp && tbp[IFLA_IFNAME]) {
@@ -818,8 +803,6 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	struct netkit *nk = netkit_priv(dev);
 	struct net_device *peer = rtnl_dereference(nk->peer);
 	enum netkit_action policy;
-	struct nlattr *attr;
-	int err;
 
 	if (!nk->primary) {
 		NL_SET_ERR_MSG(extack,
@@ -834,22 +817,14 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_NETKIT_POLICY]) {
-		attr = data[IFLA_NETKIT_POLICY];
-		policy = nla_get_u32(attr);
-		err = netkit_check_policy(policy, attr, extack);
-		if (err)
-			return err;
+		policy = nla_get_u32(data[IFLA_NETKIT_POLICY]);
 		WRITE_ONCE(nk->policy, policy);
 	}
 
 	if (data[IFLA_NETKIT_PEER_POLICY]) {
-		err = -EOPNOTSUPP;
-		attr = data[IFLA_NETKIT_PEER_POLICY];
-		policy = nla_get_u32(attr);
-		if (peer)
-			err = netkit_check_policy(policy, attr, extack);
-		if (err)
-			return err;
+		if (!peer)
+			return -EOPNOTSUPP;
+		policy = nla_get_u32(data[IFLA_NETKIT_PEER_POLICY]);
 		nk = netkit_priv(peer);
 		WRITE_ONCE(nk->policy, policy);
 	}
@@ -889,9 +864,12 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
-	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
-	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
-	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
+	[IFLA_NETKIT_POLICY]		= NLA_POLICY_VALIDATE_FN(NLA_U32,
+								 netkit_check_policy),
+	[IFLA_NETKIT_MODE]		= NLA_POLICY_VALIDATE_FN(NLA_U32,
+								 netkit_check_mode),
+	[IFLA_NETKIT_PEER_POLICY]	= NLA_POLICY_VALIDATE_FN(NLA_U32,
+								 netkit_check_policy),
 	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
 					    .reject_message = "Primary attribute is read-only" },
 };
-- 
2.38.1


