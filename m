Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEA122824
	for <lists+bpf@lfdr.de>; Sun, 19 May 2019 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfESR66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 May 2019 13:58:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45966 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfESR66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 May 2019 13:58:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so5629807pgi.12
        for <bpf@vger.kernel.org>; Sun, 19 May 2019 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYRthToGOVGrtWs/K77iVnKy2UFNhHHnBACsWKb9qN8=;
        b=rzk0sxgcSFBT6HdPWh1ToOScWy2gA+Joyd1bYf2PwVqr6+8v18UmTILLtYTApoNpbg
         IPAsqCIjjLU5ssIf3svAtIU06evlPSveke77CbH2AkcvAPT+UbpLz3lPbhw4wBIhBsnO
         OfAnoEOhgs7PSZowphBJ5G28+qoDJbNH8o3k3FDERquVaAxyGbKTK9kbKXRgsRvF/TSt
         fou0eWoMywhwwHaUv3uZz8Pgs3QMGXBBMzEvP9uBZhEwcA8Sg2wP4032WN2+gWmwfPPq
         bVSZ0hcaHJ7FIX52epyFd4fCksNBztXbrvFkhlAA8Fp8odkzpdIlmGI+k21U+/bWpv7B
         oujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYRthToGOVGrtWs/K77iVnKy2UFNhHHnBACsWKb9qN8=;
        b=iR1bU+pjQl4LUcCTUMT5gQWS0cmNdfDUU6RXKTznIVvQn+BXNw2IhjB2u8lKS6Mxk3
         7ivwQe/IuK2bCR0cnUZNgCMFe9mwNBbC5+i/5tGPxGpDq50QzYhYcx6+Y3WkqRzb/RiB
         ZeDQYYcZ4foKCRPMY6+C+2jsB3APbgEu9fKFIg+dvAfAX+glJPa4fCceebhjo153qDKL
         PUo4AYdMAZ3/ZqwrGttc2sZKW7rEophL2ZNjmfmqzphfXZcKOusa00K2uYNU+w9zhBH5
         WU9qP7pwgB7uUsjSgc1mhSvmyDGfWWP9tzm+VLR64VlTazKcwi4SpYobXZ/efYW2wy23
         ozkQ==
X-Gm-Message-State: APjAAAXJkSGu6WdjFPYrAhRax0raq6+0KYyjyf8RhaNwIneWx2LeAG+u
        1fwNlz3f/JImjtq+28M5aFuJkcg4UqY=
X-Google-Smtp-Source: APXvYqyoucFoYOSTtZKSe61X7xiKiWmULV+TFSbvE/bVuh25r1W26JPYc8xUwg6QaUUDS9CDWjDvrw==
X-Received: by 2002:a62:5653:: with SMTP id k80mr71034976pfb.144.1558235452284;
        Sat, 18 May 2019 20:10:52 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id s80sm39049604pfs.117.2019.05.18.20.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 20:10:51 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <sthemmin@microsoft.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 net 2/2] net: core: generic XDP support for stacked device
Date:   Sat, 18 May 2019 20:10:46 -0700
Message-Id: <20190519031046.4049-3-sthemmin@microsoft.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190519031046.4049-1-sthemmin@microsoft.com>
References: <20190519031046.4049-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a device is stacked like (team, bonding, failsafe or netvsc) the
XDP generic program for the parent device is not called.  In these
cases, the rx handler changes skb->dev to its own in the receive
handler, and returns RX_HANDLER_ANOTHER.  Fix this by calling
do_xdp_generic if necessary before starting another round.

Review of all the places RX_HANDLER_ANOTHER is returned
show that the current devices do correctly change skb->dev.

There was an older patch that got abandoned that did the
same thing, this is just a rewrite.

Suggested-by: Jason Wang <jasowang@redhat.com>
Fixes: d445516966dc ("net: xdp: support xdp generic on virtual devices")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 net/core/dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index b6b8505cfb3e..240d0b2de1a8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4921,6 +4921,16 @@ static int __netif_receive_skb_core(struct sk_buff *skb, bool pfmemalloc,
 			ret = NET_RX_SUCCESS;
 			goto out;
 		case RX_HANDLER_ANOTHER:
+			if (static_branch_unlikely(&generic_xdp_needed_key)) {
+				struct bpf_prog *xdp_prog;
+
+				xdp_prog = rcu_dereference(skb->dev->xdp_prog);
+				ret = do_xdp_generic(xdp_prog, skb);
+				if (ret != XDP_PASS) {
+					ret = NET_RX_SUCCESS;
+					goto out;
+				}
+			}
 			goto another_round;
 		case RX_HANDLER_EXACT:
 			deliver_exact = true;
-- 
2.20.1

