Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878AB618F05
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 04:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKDD1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 23:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKDD0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 23:26:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B022433B
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 20:25:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x14-20020a17090a2b0e00b002134b1401ddso1759937pjc.8
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 20:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ERF9BHGvTUETl3abHklzhUDC9Of0VSXJSH80uF2R5E=;
        b=qtcnXuoxuD0Fg4rg4cv7fMqxZJY1Zim85GVkY9yhw8gShUCEg+Qh9HlP2IPaRgrCku
         Pjr8BZ8+zT/4gC4yT9OWDLVbQTsT39+FLTnbsJUY8KD0UOWDB/odXVpVFyw2jFMnN3X5
         BIJDSt7opsL2j3+7XbCyFyRAfKjXcXwJT5w04whgHoyMesm3bIl9+SdCCgVjrRSA6oxG
         Iz2HLGMDLgEoVamuOksKMjJz5FGUU10WYsa6uk3HqyDGGg5yESs3MqT6G2UqCgBJKH26
         bsVBbI+BFH0C0sBsxgq60GJb8+H3oeEiIrHxmRHmOE3SQLV0Sh5d5TfUiuJRDRzNt1QL
         JyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ERF9BHGvTUETl3abHklzhUDC9Of0VSXJSH80uF2R5E=;
        b=PiDRAUB858qQxVWJCOdZZuxPeRsrlom3+PiI7HGohQ+BTbrmy7S4iLn5Ory7HFo7Bq
         zZB8K+WRbntarpnOh1x7trdan/wpnjzu7TwLMaAqO02EwUq6gYUceXL1bF6FkP/kJiYh
         pdV4OZUAl7PBV8/4qcSvnZ2fvA/H2wKJuQZ23cCQV5w/u29hknr2joMAyBe8gRnXYdoh
         lGFIjucgfNwBwfbiWnC/bmzX5nrb14Ct5gjTEqOLtGoZP7q1SVgNdcxr7InDfmA1RqJV
         yQb8gwV8bWSuzqmzqGOpr3x4HgrV/FUaeeaykwLlbdpG/e79hSCJuIfCFpRisabU84dK
         yy2A==
X-Gm-Message-State: ACrzQf180yXuems2wTUKWopf7tn7fL1pm3e3+xq/kOz0J4Y6E/EEd4zG
        v/jkbedbXY3g86MtqCvyA/yUjRdTetVMJ3lovYexltnoqS+M/oucgXTtX2LMizWUWlNI2fzwYcM
        7Cv8ll2Sct9y/r/wzOVF+RfMpwLf5qvOGPMX9ewBX8H8pqMwXIA==
X-Google-Smtp-Source: AMsMyM6orILfZB5RmRRYvSDa3p/B0DESE08HEe3icEINwzLmxliT4kIQxZGrqHAsBwr+A6ZbX+oXSmw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:b791:b0:214:1440:8d8b with SMTP id
 m17-20020a17090ab79100b0021414408d8bmr197940pjr.4.1667532357566; Thu, 03 Nov
 2022 20:25:57 -0700 (PDT)
Date:   Thu,  3 Nov 2022 20:25:31 -0700
In-Reply-To: <20221104032532.1615099-1-sdf@google.com>
Mime-Version: 1.0
References: <20221104032532.1615099-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104032532.1615099-14-sdf@google.com>
Subject: [RFC bpf-next v2 13/14] bnxt: Introduce bnxt_xdp_buff wrapper for xdp_buff
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No functional changes. Boilerplate to allow stuffing more data after xdp_buff.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 04cf7684f1b0..b2e0607a6400 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1789,6 +1789,10 @@ static void bnxt_deliver_skb(struct bnxt *bp, struct bnxt_napi *bnapi,
 	napi_gro_receive(&bnapi->napi, skb);
 }
 
+struct bnxt_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 /* returns the following:
  * 1       - 1 packet successfully received
  * 0       - successful TPA_START, packet not completed yet
@@ -1812,7 +1816,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
+	struct bnxt_xdp_buff bxbuf;
 	u32 flags, misc;
 	void *data;
 	int rc = 0;
@@ -1922,9 +1926,9 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	dma_addr = rx_buf->mapping;
 
 	if (bnxt_xdp_attached(bp, rxr)) {
-		bnxt_xdp_buff_init(bp, rxr, cons, &data_ptr, &len, &xdp);
+		bnxt_xdp_buff_init(bp, rxr, cons, &data_ptr, &len, &bxbuf.xdp);
 		if (agg_bufs) {
-			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
+			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &bxbuf.xdp,
 							     cp_cons, agg_bufs,
 							     false);
 			if (!frag_len) {
@@ -1937,7 +1941,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, xdp, data, &len, event)) {
+		if (bnxt_rx_xdp(bp, rxr, cons, bxbuf.xdp, data, &len, event)) {
 			rc = 1;
 			goto next_rx;
 		}
@@ -1952,7 +1956,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
 							       agg_bufs, false);
 				else
-					bnxt_xdp_buff_frags_free(rxr, &xdp);
+					bnxt_xdp_buff_frags_free(rxr, &bxbuf.xdp);
 			}
 			cpr->sw_stats.rx.rx_oom_discards += 1;
 			rc = -ENOMEM;
@@ -1983,10 +1987,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				goto next_rx;
 			}
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &bxbuf.xdp, rxcmp1);
 			if (!skb) {
 				/* we should be able to free the old skb here */
-				bnxt_xdp_buff_frags_free(rxr, &xdp);
+				bnxt_xdp_buff_frags_free(rxr, &bxbuf.xdp);
 				cpr->sw_stats.rx.rx_oom_discards += 1;
 				rc = -ENOMEM;
 				goto next_rx;
-- 
2.38.1.431.g37b22c650d-goog

