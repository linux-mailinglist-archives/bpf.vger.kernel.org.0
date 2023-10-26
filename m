Return-Path: <bpf+bounces-13332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23247D85CD
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06B71C20F7B
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6A2F514;
	Thu, 26 Oct 2023 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DAGOl84k"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256DF9E3
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:17:08 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A82DC
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 08:17:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso8136725e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698333425; x=1698938225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRNM7OP8FZNz7PcD8FSoHRmgfXGXNRO9Y1vYfQVDNxo=;
        b=DAGOl84kADeDPMBHJLXipIG39hH+kurn76vEedHlAXdu589Zvk/JTMCxlto8EQEqDP
         MFLrMn4rCLg+FYMiV3J7yUGchToayihjw1gUXYbnNL+O5tZIrMrm/2ETpyxs+QaDE3I4
         jq5q9bnAUR7SMzFgoGxtJCd+wwVaJsLlwh4pjzJhR1kmx5kxy7P9WgSS3NIJWVE9YEZO
         zorFlfZILUHGO3wqFretxUBcj38zn73DI0S/6bbZ5nCyS8rtO1pVio9MoLAYQF6zldny
         gezbsDoNIKLr70ty3WgIkjQvqL/uziQR+iqgHflxzsJK4XHQASNn/D4v7wW2uuWKI9ze
         rbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333425; x=1698938225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRNM7OP8FZNz7PcD8FSoHRmgfXGXNRO9Y1vYfQVDNxo=;
        b=WLqs/E1YtRGujhXnkX/MBAxHVfTmK0JDFrymowOBoyRMxCTriGM1DXd6GJcjSuiAHd
         A34wj3ObY9XknVjmCn9pnbijtNwFdmY8HdH/EOixFPugagD3SwzJGeE9eeao1V7cNEYw
         iDINKWn2IDkww1FmiwBW/MfGBEdbAyK7esrHMLGalnLdXSMY4uXV8+kFhJ9IBeu7yHKJ
         fGpEVAdCmCNpHIoEgKGVlefuob+pWIi5eX2Mknw9y3aQWVcQk3eZTvDugqxHnHy/1sxK
         JbWiY459SK8LHYWOeD4IHxMTcZQHHogypq7eu4S6rdKyMfsNTHR1fhfjJ0LB+W1gDJDM
         HE6w==
X-Gm-Message-State: AOJu0YxdElvJGjvvGBtYapOB3m1KzEnA67QpNesSSlaaRMDZmKwMczTt
	8IGypKOgViA4srEbBUUxazxdG0WD3NnZnQAJYNlJxQ==
X-Google-Smtp-Source: AGHT+IHGG+ljO1uOaaVI84VnXV2gDunKAaklUlaOvOGhlPgpi3XYLBn97iOI8Jo83uuboDnRNluxhQ==
X-Received: by 2002:a05:600c:3ca3:b0:408:386b:1916 with SMTP id bg35-20020a05600c3ca300b00408386b1916mr101578wmb.8.1698333424919;
        Thu, 26 Oct 2023 08:17:04 -0700 (PDT)
Received: from dev.. (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id t10-20020a1c770a000000b0040775fd5bf9sm2804819wmi.0.2023.10.26.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:17:04 -0700 (PDT)
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
	idosch@idosch.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf-next v2] netkit: use netlink policy for mode and policy attributes validation
Date: Thu, 26 Oct 2023 18:16:59 +0300
Message-Id: <20231026151659.1676037-1-razor@blackwall.org>
X-Mailer: git-send-email 2.38.1
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
We have to use NLA_BINARY and validate the length inside the callbacks.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: use NLA_BINARY instead of NLA_U32 (thanks Ido!), validate attribute
    length inside the callbacks, run tests again
    the patch is sent out of the set as only the first one was applied
    before, see:
    https://lore.kernel.org/bpf/8533255d-9b73-cdbe-fbbd-28a275313229@iogearbox.net/

 drivers/net/netkit.c | 79 ++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5a0f86f38f09..df819df86944 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -247,29 +247,39 @@ static struct net *netkit_get_link_net(const struct net_device *dev)
 	return peer ? dev_net(peer) : dev_net(dev);
 }
 
-static int netkit_check_policy(int policy, struct nlattr *tb,
+static int netkit_check_policy(const struct nlattr *attr,
 			       struct netlink_ext_ack *extack)
 {
-	switch (policy) {
+	if (nla_len(attr) != sizeof(u32)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "Invalid policy attribute length");
+		return -EINVAL;
+	}
+
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
+	if (nla_len(attr) != sizeof(u32)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "Invalid mode attribute length");
+		return -EINVAL;
+	}
+
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
@@ -306,13 +316,8 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
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
@@ -324,20 +329,10 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
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
@@ -818,8 +813,6 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
 	struct netkit *nk = netkit_priv(dev);
 	struct net_device *peer = rtnl_dereference(nk->peer);
 	enum netkit_action policy;
-	struct nlattr *attr;
-	int err;
 
 	if (!nk->primary) {
 		NL_SET_ERR_MSG(extack,
@@ -834,22 +827,14 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
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
@@ -889,9 +874,15 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
 	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
-	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
-	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
-	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
+	[IFLA_NETKIT_POLICY]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+								 netkit_check_policy,
+								 sizeof(u32)),
+	[IFLA_NETKIT_MODE]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+								 netkit_check_mode,
+								 sizeof(u32)),
+	[IFLA_NETKIT_PEER_POLICY]	= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+								 netkit_check_policy,
+								 sizeof(u32)),
 	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
 					    .reject_message = "Primary attribute is read-only" },
 };
-- 
2.38.1


