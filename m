Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4563C879
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiK2TfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiK2TfA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:35:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40C2EF5C
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:34:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id l2-20020a17090add8200b00218daa1a812so9600063pjv.3
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzY0whdCH0LNaf1li3i+ucIqbikEA8y1fjnf4/7T9NE=;
        b=PvfbVY+lqSrxJfukLAzk+NNXrEa5krt2ygDI3c2AJV1YVqBiSl2saWvGxg0CJNi5tK
         +zLfqmUKSd9DgY9n1uNAap+ED95KRdnrlPMZb9dbL/zV3K4QHwmOU2N24MqX4xtzGTG7
         kFyUn2otpkyyj1AP0XYeTEi/Kf/zZk4iIJNFtq1UlcLLGzs6Gw8sY5FuSrtW5z/4HeLX
         Mnlwi5M5PtBdkpLcLwxQlmt/nQdHv0H6mSRohVz+7ECNKyDd38c3p0dQ1ahU5MYBihgm
         03Vz4wC0ODZUdq01gnmRmdetjX5J4UopoJakPUPIXCpNZLE2Tsi9+UlWKqNmW0RmBs5G
         NzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzY0whdCH0LNaf1li3i+ucIqbikEA8y1fjnf4/7T9NE=;
        b=G12h1MyAI5HIDDnNbV64otAaIohFCO98ThdIVliEoNF8ePfj5wwdQ5crbLMS0+jk8l
         XYXCv8ymnpoXRH7GT23NHyP/SfnsVsysNegFwtHmQdJNAmpv0z504mwgZHuXmSJRI8Tf
         Ftfpv2RK9ox8D/04BaFfikV703gb+QT4KOXb81M71etVgxK29E8+WYPdECh24K+3+igW
         wn8DCQN6+lji9TWdZxjqmSEBU9JAKczGn5Bxo7xRYGJgn6habTRZzH7wLucCmertD2k+
         FUKFre6LmDxeeqLX0CJdokTuw+b/JjjT0pyxAQwHRY9iMlLLvlpgrbGBnCElWY7fSdgV
         sbiQ==
X-Gm-Message-State: ANoB5pl5nrJuralMbUWgS7eqKJOa01HyEXTeO9uO0Lp/A1nH3+pPF80x
        OX8mmZ507fgs+eMa7jFXHfrif6z1T11+u8hgl/rmFI28jmE/pysxgWnXPsxwNKh3qg36r85oNhj
        W5Or7LyNFkTC1JSNwdNLt4BCrEd25b8+1JTkEvekwFOjeBtBozw==
X-Google-Smtp-Source: AA0mqf5ZPR8IGn32vzQNjT/CwMf3YxUU5GSZ7O2wMiAy4xyTffSJRYnBr6z7/xu2b6or6Dlm0hhHneo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8c54:0:b0:574:2f5a:18d0 with SMTP id
 e20-20020aa78c54000000b005742f5a18d0mr34579060pfd.23.1669750499097; Tue, 29
 Nov 2022 11:34:59 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:34:44 -0800
In-Reply-To: <20221129193452.3448944-1-sdf@google.com>
Mime-Version: 1.0
References: <20221129193452.3448944-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129193452.3448944-4-sdf@google.com>
Subject: [PATCH bpf-next v3 03/11] veth: Introduce veth_xdp_buff wrapper for xdp_buff
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
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
 drivers/net/veth.c | 56 +++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 2a4592780141..bbabc592d431 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -116,6 +116,10 @@ static struct {
 	{ "peer_ifindex" },
 };
 
+struct veth_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 static int veth_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *cmd)
 {
@@ -592,23 +596,24 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (likely(xdp_prog)) {
-		struct xdp_buff xdp;
+		struct veth_xdp_buff vxbuf;
+		struct xdp_buff *xdp = &vxbuf.xdp;
 		u32 act;
 
-		xdp_convert_frame_to_buff(frame, &xdp);
-		xdp.rxq = &rq->xdp_rxq;
+		xdp_convert_frame_to_buff(frame, xdp);
+		xdp->rxq = &rq->xdp_rxq;
 
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
+		act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 		switch (act) {
 		case XDP_PASS:
-			if (xdp_update_frame_from_buff(&xdp, frame))
+			if (xdp_update_frame_from_buff(xdp, frame))
 				goto err_xdp;
 			break;
 		case XDP_TX:
 			orig_frame = *frame;
-			xdp.rxq->mem = frame->mem;
-			if (unlikely(veth_xdp_tx(rq, &xdp, bq) < 0)) {
+			xdp->rxq->mem = frame->mem;
+			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 				trace_xdp_exception(rq->dev, xdp_prog, act);
 				frame = &orig_frame;
 				stats->rx_drops++;
@@ -619,8 +624,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 			goto xdp_xmit;
 		case XDP_REDIRECT:
 			orig_frame = *frame;
-			xdp.rxq->mem = frame->mem;
-			if (xdp_do_redirect(rq->dev, &xdp, xdp_prog)) {
+			xdp->rxq->mem = frame->mem;
+			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 				frame = &orig_frame;
 				stats->rx_drops++;
 				goto err_xdp;
@@ -801,7 +806,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 {
 	void *orig_data, *orig_data_end;
 	struct bpf_prog *xdp_prog;
-	struct xdp_buff xdp;
+	struct veth_xdp_buff vxbuf;
+	struct xdp_buff *xdp = &vxbuf.xdp;
 	u32 act, metalen;
 	int off;
 
@@ -815,22 +821,22 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	}
 
 	__skb_push(skb, skb->data - skb_mac_header(skb));
-	if (veth_convert_skb_to_xdp_buff(rq, &xdp, &skb))
+	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
 		goto drop;
 
-	orig_data = xdp.data;
-	orig_data_end = xdp.data_end;
+	orig_data = xdp->data;
+	orig_data_end = xdp->data_end;
 
-	act = bpf_prog_run_xdp(xdp_prog, &xdp);
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	switch (act) {
 	case XDP_PASS:
 		break;
 	case XDP_TX:
-		veth_xdp_get(&xdp);
+		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp.rxq->mem = rq->xdp_mem;
-		if (unlikely(veth_xdp_tx(rq, &xdp, bq) < 0)) {
+		xdp->rxq->mem = rq->xdp_mem;
+		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
 			goto err_xdp;
@@ -839,10 +845,10 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		rcu_read_unlock();
 		goto xdp_xmit;
 	case XDP_REDIRECT:
-		veth_xdp_get(&xdp);
+		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp.rxq->mem = rq->xdp_mem;
-		if (xdp_do_redirect(rq->dev, &xdp, xdp_prog)) {
+		xdp->rxq->mem = rq->xdp_mem;
+		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
 		}
@@ -862,7 +868,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	rcu_read_unlock();
 
 	/* check if bpf_xdp_adjust_head was used */
-	off = orig_data - xdp.data;
+	off = orig_data - xdp->data;
 	if (off > 0)
 		__skb_push(skb, off);
 	else if (off < 0)
@@ -871,21 +877,21 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	skb_reset_mac_header(skb);
 
 	/* check if bpf_xdp_adjust_tail was used */
-	off = xdp.data_end - orig_data_end;
+	off = xdp->data_end - orig_data_end;
 	if (off != 0)
 		__skb_put(skb, off); /* positive on grow, negative on shrink */
 
 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
 	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
 	 */
-	if (xdp_buff_has_frags(&xdp))
+	if (xdp_buff_has_frags(xdp))
 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
 	else
 		skb->data_len = 0;
 
 	skb->protocol = eth_type_trans(skb, rq->dev);
 
-	metalen = xdp.data - xdp.data_meta;
+	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
 out:
@@ -898,7 +904,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	return NULL;
 err_xdp:
 	rcu_read_unlock();
-	xdp_return_buff(&xdp);
+	xdp_return_buff(xdp);
 xdp_xmit:
 	return NULL;
 }
-- 
2.38.1.584.g0f3c55d4c2-goog

