Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D33A11E6EA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 16:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfLMPrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 10:47:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34262 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLMPrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 10:47:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so7174181wrr.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zy/1vxmK7IESgZ5MufAb5lMH5M1hrx2tBtD49AP8IGg=;
        b=EwfZKJpHgTZfq2oP7jePrJKUK8ZNAm4PsQGN32QF3UGr1NkO0kMWQMhpx3xpKJd4k2
         qCENKuKt9VkU+QR6qzO73xgYJPkZkW515/0DMsa4G85AiuMp+AxljrIpsZKE+TY8ngmk
         /8dv3fPgl/f9PgecfmougTtKhSdBMssa8PEsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zy/1vxmK7IESgZ5MufAb5lMH5M1hrx2tBtD49AP8IGg=;
        b=twwfJVlYGIxiZDqtGLRg2GW8I4lwLOHvz2wLczWUkvQWjPPwUaspPx4YTtoYhirs9m
         uaOYXDp/aq52KUjD+TCj2txreI2DcpiKXUbobSWL4KPAsIybU5itm90Gr5Hm9W5aaaby
         VJum30VniGd5bYe940HSrfHS5CJoR5AirRI6Gf8AMdZ0SBCyCp5+JJ8CjCRi0d9wtU49
         FR/PMQbOS2+cd1Z+9+awcxbUGiMdFTSlqML2+J10+mfiwHGVREYpTbJHCZlSbnIyRIuL
         CvYp+IWsLCrWK8KBaw85sTDW7v2GQJZmV6O3OGeDaSS/gp9O2d/qm078JSigaDBUJ/Co
         ksRQ==
X-Gm-Message-State: APjAAAX+veVwuQQvf3vgZCoB2JdrlBJG6mfyWNmI8cdEKdOpd5rT2/G9
        6wgf/O99Dt23uF1TDW4NukAjPg==
X-Google-Smtp-Source: APXvYqxDDCsPNF553NwXAaiIZEZtJCqKHvMMr8OTf4QdQlkxPgrUbkSbZGoxyJoE0pe94MnpErfvJQ==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr14079175wrp.2.1576252064539;
        Fri, 13 Dec 2019 07:47:44 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3da5:43ec:24b:e240])
        by smtp.gmail.com with ESMTPSA id s8sm10140295wrt.57.2019.12.13.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:47:43 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net,
        "David S. Miller" <davem@davemloft.net>,
        Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>,
        Richard Cochran <rcochran@linutronix.de>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] bpf: clear skb->tstamp in bpf_redirect when necessary
Date:   Fri, 13 Dec 2019 15:46:34 +0000
Message-Id: <20191213154634.27338-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Redirecting a packet from ingress to egress by using bpf_redirect
breaks if the egress interface has an fq qdisc installed. This is the same
problem as fixed in 8203e2d8 ("net: clear skb->tstamp in forwarding paths").

Clear skb->tstamp when redirecting into the egress path.

Fixes: 80b14de ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5 ("tcp/fq: move back to CLOCK_MONOTONIC")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index f1e703eed3d2..d914257763b5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2055,6 +2055,7 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	skb->dev = dev;
+	skb->tstamp = 0;
 
 	dev_xmit_recursion_inc();
 	ret = dev_queue_xmit(skb);
-- 
2.20.1

