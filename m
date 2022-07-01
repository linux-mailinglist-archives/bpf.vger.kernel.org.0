Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FCC56307A
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiGAJnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiGAJnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:43:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9CDF8E
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 02:43:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z21so2851822lfb.12
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/+XxQ4vatEZZpJZsZxX9NxljTvF/ngx1W22gCHd1Jc=;
        b=bdVcdhLRy2zjNqSMJRaOvBxK7OIzbU1lmVn/1wK8Ix7rZpIzhUBnxvUCqDuyPD59yD
         zpzCK3HQPs/4U2KHXl0mUMkRv4BbM0LktzYT0/o9f5PDi1MDxOEz5Ly4b8sMOO0p1Vbz
         w2q9B1aSDVouRt4+OXZXVxniM7jppOQUZWRHPkBX+zCKa1YiiOGs3G44uD/medym8/yF
         A4l6Krh33Ba/qDYdT9E0uCZ6z4Hni0uAqKpcner2P/AwBmXu3t5ZY0sokPphY9n8gGgO
         0d1miCyWws431IyznAf2odHAl/QAXiiRuPEWTLpC5jHogs4Ytd1AYEteybQ5pF94Lsfq
         I3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/+XxQ4vatEZZpJZsZxX9NxljTvF/ngx1W22gCHd1Jc=;
        b=X8/FeSO04g229vQ6iz8/tC4RiJAJVRDl+nHM6CtXGZ2UtHBCFu0By5bZOpQ1Abg8OM
         OqGsntZTdwyMBSxApsltO5LpHVwSVCniH2Rhkewdqv9hlZOFOsWbude4u+iLW6Y/cgAE
         8Lu7M6UWFa3vCVEJGKP4aYEgsrO1BdS4Bc5RXw9a/CmmiyROeyke+ZbvSsAEOnTShfI7
         QqhupmxkRuvrdG1iD9c2n1r8lIpJ+c+aaLuSzua3c/zBtrMhaA3ghhn+ra0c5xRS2/E+
         Nt6nrHXW8dJtAp1Ngt1vsRk4CZoDncVtezThnbAsy/gG6Jp9reRt6/2IlI7mFAImUwiQ
         uOEA==
X-Gm-Message-State: AJIora+sr4L6Gb/wypI30zHjPJw75+Vo74HaVG9ohOnd1Ep5aVcvG6XM
        9ebCoqQCdkntNS++tMESf8cNiA==
X-Google-Smtp-Source: AGRyM1s0Lff+ETBavwJNI/8R90n74RfqV2eupQe1iFU7cuRhYDVU/RVppevB4C7VFYBCv5NrgBSP0g==
X-Received: by 2002:a05:6512:3b27:b0:47f:771f:30de with SMTP id f39-20020a0565123b2700b0047f771f30demr8653017lfv.9.1656668592887;
        Fri, 01 Jul 2022 02:43:12 -0700 (PDT)
Received: from anpc2.lan ([62.119.107.74])
        by smtp.gmail.com with ESMTPSA id bx38-20020a05651c19a600b0025a6d563c57sm3072845ljb.134.2022.07.01.02.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 02:43:12 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hawk@kernel.org, john.fastabend@gmail.com
Cc:     song@kernel.org, martin.lau@linux.dev, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf] xdp: Fix spurious packet loss in generic XDP TX path
Date:   Fri,  1 Jul 2022 11:42:56 +0200
Message-Id: <20220701094256.1970076-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The byte queue limits (BQL) mechanism is intended to move queuing from
the driver to the network stack in order to reduce latency caused by
excessive queuing in hardware. However, when transmitting or redirecting
a packet with XDP, the qdisc layer is bypassed and there are no
additional queues. Since netif_xmit_stopped() also takes BQL limits into
account, but without having any alternative queuing, packets are
silently dropped.

This patch modifies the drop condition to only consider cases when the
driver itself cannot accept any more packets. This is analogous to the
condition in __dev_direct_xmit(). Dropped packets are also counted on
the device.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8e6f22961206..41b5d7ac5ec5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4875,10 +4875,12 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 	txq = netdev_core_pick_tx(dev, skb, NULL);
 	cpu = smp_processor_id();
 	HARD_TX_LOCK(dev, txq, cpu);
-	if (!netif_xmit_stopped(txq)) {
+	if (!netif_xmit_frozen_or_drv_stopped(txq)) {
 		rc = netdev_start_xmit(skb, dev, txq, 0);
 		if (dev_xmit_complete(rc))
 			free_skb = false;
+	} else {
+		dev_core_stats_tx_dropped_inc(dev);
 	}
 	HARD_TX_UNLOCK(dev, txq);
 	if (free_skb) {
-- 
2.30.2

