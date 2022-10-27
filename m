Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1661C610241
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiJ0UAz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiJ0UAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 16:00:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B19446DA8
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 13:00:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x16-20020a63b210000000b0045f5c1e18d0so1317761pge.0
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1Wy4MtVrL47Mg6ubq0m6la2HOdUZD2ps1PI5efyQcs=;
        b=SyIs+Emv1OBwjcyUosDYnXifGanJYSjH84/nXaLyaA5afcxeH3mO8R0OkOrVKyLtud
         colO6y3DBMP++hfxqwQiWOEw8/pwZvEj1kYeJFT2Xw3X9ZltE5YGffc67Ko8KpATeT2K
         a+WBWCh9VZZTbOLPAqeamWIpZDzp5a1i4xXDZIewe0q9rMxAULjB1A8SBhCDQ8wx1V/l
         8Qa5HthLZz94xj48WkINPKiY4QnYILSE+SEtwsN5CzXuBS+F8stvHwCmbd7bgAzV1yWU
         qjPXtDvukNrC+qqR1vfQLEdObH869HnuF6Qpen3iytklLrT7RmDZRKxScbVwvWXoy5Z7
         iK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1Wy4MtVrL47Mg6ubq0m6la2HOdUZD2ps1PI5efyQcs=;
        b=tCCQ9wat73671SJHZEGGO1Y96I1KayYPXFSm0uGrCEy5NBbf7s4YGJ6dxGhV8iDfo6
         EkrdoNuan9CyBtAd8fa7IUOG31HXp6V77UI1XKRDpsG973Y9cA9o+ncQUEQcCF1NQc/E
         GyZGU9/Kz3yEMSpasT991iBjVtm2xx0Q8HdvQEJ7jVYhvSk3MDN0mYAISRNnZGbdAkTo
         kZbI4bBgsQHXTJKS6wE8q3qSTOznx4Pp4doXvjmeRRgpzQ2SEWyd58e/QjEx37FkJ/3/
         wLN/lokQUShsrVzTpJTu2gM8XkPh/9G8d6KG9IoPaiPPHDtNCPXYqS7P2ssWO+dFtOgK
         I13g==
X-Gm-Message-State: ACrzQf2BlFsB2++p71CJ7ld0Drp7UpuxBcH8ouqnIw7pW8lPx7JbXCkr
        fhEvG5InhSI95jNDecDmF5D/alFcCbR9SCP7So0hY/3h630c8uYHRJCkF9Oz1u4pQHnaML0FjgB
        P2OV9VAbpTuviqTbADGEoXDIp3t28vK2PXw/smHXyRrPdDL4z/A==
X-Google-Smtp-Source: AMsMyM74Nmf3sqNhRUcydUqTY8hM2m32VR/qgcCbmIBnAg2SN9JSYoBjNFvsPVPTnWinR5B/f4Wg1/4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2447:b0:186:e200:6109 with SMTP id
 l7-20020a170903244700b00186e2006109mr8840520pls.104.1666900825517; Thu, 27
 Oct 2022 13:00:25 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:00:16 -0700
In-Reply-To: <20221027200019.4106375-1-sdf@google.com>
Mime-Version: 1.0
References: <20221027200019.4106375-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027200019.4106375-3-sdf@google.com>
Subject: [RFC bpf-next 2/5] veth: Support rx timestamp metadata for xdp
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

xskxceiver conveniently setups up veth pairs so it seems logical
to use veth as an example for some of the metadata handling.

We timestamp skb right when we "receive" it, store its
pointer in xdp_buff->priv and generate BPF bytecode to
reach it from the BPF program.

This largely follows the idea of "store some queue context in
the xdp_buff/xdp_frame so the metadata can be reached out
from the BPF program".

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
 drivers/net/veth.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 09682ea3354e..35396dd73de0 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -597,6 +597,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 
 		xdp_convert_frame_to_buff(frame, &xdp);
 		xdp.rxq = &rq->xdp_rxq;
+		xdp.priv = NULL;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
@@ -820,6 +821,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 	orig_data = xdp.data;
 	orig_data_end = xdp.data_end;
+	xdp.priv = skb;
 
 	act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
@@ -936,6 +938,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct sk_buff *skb = ptr;
 
 			stats->xdp_bytes += skb->len;
+			__net_timestamp(skb);
 			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
 			if (skb) {
 				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
@@ -1595,6 +1598,33 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+static int veth_unroll_kfunc(struct bpf_prog *prog, struct bpf_insn *insn)
+{
+	u32 func_id = insn->imm;
+
+	if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_HAVE_RX_TIMESTAMP)) {
+		/* return true; */
+		insn[0] = BPF_MOV64_IMM(BPF_REG_0, 1);
+		return 1;
+	} else if (func_id == xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP)) {
+		/* r1 = ((struct xdp_buff *)r1)->priv; [skb] */
+		insn[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1,
+				      offsetof(struct xdp_buff, priv));
+		/* if (r1 == NULL) { */
+		insn[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1);
+		/*	return 0; */
+		insn[2] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		/* } else { */
+		/*	return ((struct sk_buff *)r1)->tstamp; */
+		insn[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+				      offsetof(struct sk_buff, tstamp));
+		/* } */
+		return 4;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1614,6 +1644,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_unroll_kfunc       = veth_unroll_kfunc,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.38.1.273.g43a17bfeac-goog

