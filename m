Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1464ADB5
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 03:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiLMChE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 21:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiLMCgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 21:36:43 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E141DF1B
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 18:36:19 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o5-20020a170903210500b0018f9edbba6eso3017190ple.11
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 18:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLbwZVoIdeiDs0e+MLPZphHSP+35iiBlddtDTyUBuKk=;
        b=HD1MOfHpAUeKeZUiKl7ft3cCAhG6gcbH6aYPbn2SYHFYvLgM0lOjJx45p9ykMmU/fo
         BJmswx/iZ+hLw4swgjIsMSa9g5IsEC0GtGDoLd77oOE8hJeq5dBUVQYzp1/NSCTrD+aA
         NXp53yD5+eFcUjlArd1lwPvA9GWfqCIb1wfTzaDzZldDJjS/csD03aZxiHi42tlhiThX
         JRER6fuxoh9jdUGYSUmT5P8WpOLIYqhpw8jOFTINm2bzYhUOMtBn6qoklDCH12WF7G1j
         uBA6PD9/3w49nnRM07PVDgoVG5t4yK2HkKeU7Lmk7LPhyqgUW5t4S7SBjjVAc9Ks2C7z
         LNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLbwZVoIdeiDs0e+MLPZphHSP+35iiBlddtDTyUBuKk=;
        b=qDyKFtm/a9mDgwH+agxa6t+56UlH/4q9vtXXQl7PAEDH/BGIFv4Un2P9HceoAo5VTO
         63D1A0FESIWdVO//m79BoZaD4vOgfnbs33drVmzBOC33mmtuxGdnfkjI4QlwrLu5hLcJ
         On7LmO0PjYwG7FEI6ABYfMVI4MYb4AeMR5EnGeL6csPju1r8TfSs2zbfC/M8rgjw5paf
         XVxVGCeSWmjFQzbUl7guJ8RMJ7Xjo9lTqVhifbqOXCnbraoK7i4TO43V4dL8CO11Qru0
         kqHI31uq6fgqEbbEMVuGE26qjyRmcUBCJ8eSyq8vWyPkaNcNGmfNrW/v2Dsz31zbNTu8
         a3Ww==
X-Gm-Message-State: ANoB5pkBHt8cPEN1ytrN12b9ohJYuZJytGHko1KoPKejXdsc7JWuTCqR
        CtXEN8VaNewo9Y3pu27vzBQfXVdFiVYbM1SEEjNtEXsoiOiEBgZTNXLgd4y602h7lgF2rMLd38Q
        8SdA/ZtQsUoRz5xNEgKMcCv9lYkLkKngcQ0dlQhbDH/T1tDIdcQ==
X-Google-Smtp-Source: AA0mqf4k5ngczsRoDw3/3Jh2eFmWYlX+gnprhjopMh5shB56zpX69jblxVyDjJQxQPXMIFKYE5NCsxY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:21c2:b0:56b:bba4:650a with SMTP id
 t2-20020a056a0021c200b0056bbba4650amr79648605pfj.4.1670898978719; Mon, 12 Dec
 2022 18:36:18 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:35:57 -0800
In-Reply-To: <20221213023605.737383-1-sdf@google.com>
Mime-Version: 1.0
References: <20221213023605.737383-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213023605.737383-8-sdf@google.com>
Subject: [PATCH bpf-next v4 07/15] veth: Introduce veth_xdp_buff wrapper for xdp_buff
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
index ac7c0653695f..04ffd8cb2945 100644
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
2.39.0.rc1.256.g54fd8350bd-goog

