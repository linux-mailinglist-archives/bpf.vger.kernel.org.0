Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23021BD7C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2019 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfEMSyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 14:54:06 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:49940 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfEMSyG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 14:54:06 -0400
Received: by mail-ua1-f74.google.com with SMTP id j43so1685842uae.16
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ojq1kpYzLVjj7s0IxpD9pNDAUCSKVEzFe5EcgprjOmE=;
        b=N/NN1+KH1wMODtFxJ1Bf54yABh2tsar3BB9B2WrQsecN6NJDwv3pyRznv+SbcdjpPQ
         tCzqaMhW/7+es7IEmdJf2By8o6W1r+jfSra7zwsHQq7vRmFQ/5FAG2wiuw9xBIxI1Yvo
         JNGhwk4hcpeHHmmudR5D9dN9p88XdMIPlgXf+7l7o4S1XLxQwydzCMtVX6+NipkqLjxY
         PGuXheP4rzFGhRrheUTA5C93kXgpVruHwSela2EMPfrwuvqA6LuI1Rv5hvLiKqZfz7+A
         OsXemxsDBJUtmUMQNjbowMTPK+G8sy2cYa5C2rCbnLoe1I3l52X6kWZungHw1wJzDf+V
         q6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ojq1kpYzLVjj7s0IxpD9pNDAUCSKVEzFe5EcgprjOmE=;
        b=WtoR11c4zf442C9CEOuBqRj5oocxubIlnyee95MQGHEx+XYdTm+r2OS/towdrIDDOC
         xnEOs/cZa2NAR9OnIjcwS2bRIK6tP4Aez2bktN7iFfeKJXUuep7gG5tTLEF5mqagahC8
         jnMPPBiUpj0CraDT/nJOvZaS4eKtKsnRE+PKxwnkRWaDQ7s++D+AaGz8G1Pe8euIjARs
         Ql4DBKFrIMa01kp3eD4oOjSIGnanlcQOE6NuBDMYCruEN1JChg0AiSXYUE70zWeUVKps
         EXW3iEA4tZxphcbtz8tc5vH3aUIXNtnAZ/OMg9PO1mNONbFov/j+aT80ihNfBlR2PAzN
         2Iyg==
X-Gm-Message-State: APjAAAV5uF4Pe3fOQCm2SshzAiBWvscj6S/IXTAazGvGqVTR2rKT1rkM
        3tjHwsY9wt80Fb1QKLh46cbFcp8=
X-Google-Smtp-Source: APXvYqwdDZTAL3yc21dxQnZKNPhlwTN9jMcv/Pc/16SNZfAxZkgotJj7aqgGZCE/DF4+vhMkt5PUU08=
X-Received: by 2002:a67:ed84:: with SMTP id d4mr14634240vsp.207.1557773644903;
 Mon, 13 May 2019 11:54:04 -0700 (PDT)
Date:   Mon, 13 May 2019 11:54:01 -0700
Message-Id: <20190513185402.220122-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf 1/2] flow_dissector: support FLOW_DISSECTOR_KEY_ETH_ADDRS
 with BPF
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        willemb@google.com, ppenkov@google.com,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If we have a flow dissector BPF program attached to the namespace,
FLOW_DISSECTOR_KEY_ETH_ADDRS won't trigger because we exit early.

Handle FLOW_DISSECTOR_KEY_ETH_ADDRS before BPF and only if we have
an skb (used by tc-flower only).

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/flow_dissector.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9ca784c592ac..ba76d9168c8b 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -825,6 +825,18 @@ bool __skb_flow_dissect(const struct net *net,
 			else if (skb->sk)
 				net = sock_net(skb->sk);
 		}
+
+		if (dissector_uses_key(flow_dissector,
+				       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+			struct ethhdr *eth = eth_hdr(skb);
+			struct flow_dissector_key_eth_addrs *key_eth_addrs;
+
+			key_eth_addrs = skb_flow_dissector_target(flow_dissector,
+								  FLOW_DISSECTOR_KEY_ETH_ADDRS,
+								  target_container);
+			memcpy(key_eth_addrs, &eth->h_dest,
+			       sizeof(*key_eth_addrs));
+		}
 	}
 
 	WARN_ON_ONCE(!net);
@@ -860,17 +872,6 @@ bool __skb_flow_dissect(const struct net *net,
 		rcu_read_unlock();
 	}
 
-	if (dissector_uses_key(flow_dissector,
-			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-		struct ethhdr *eth = eth_hdr(skb);
-		struct flow_dissector_key_eth_addrs *key_eth_addrs;
-
-		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
-							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
-							  target_container);
-		memcpy(key_eth_addrs, &eth->h_dest, sizeof(*key_eth_addrs));
-	}
-
 proto_again:
 	fdret = FLOW_DISSECT_RET_CONTINUE;
 
-- 
2.21.0.1020.gf2820cf01a-goog

