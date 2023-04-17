Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3906E4A54
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDQNtn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjDQNtm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 09:49:42 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D221BE2
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=PQOeShViw/L17sqeYAZYnRT50F8C73Ft+ykr4Y7oRFA=; b=qgtpPCbmHO/CtTf1Ne0mADoLju
        zi81iFESxgE9zNbfoD1JDs6NmSbjh5RzpySMH6B8UuNNWzeJcBmLqPXLqnZhCnGPpIjTxmArUxQJw
        O48hsaZbt6vgcdOuaUEwzxW2H1sT4x0V3hB91kF1dLGM+gtmI9XjhrIhpxKo/HC7E6Sb912GbhYra
        ctx/+GCYW7rVMlABb41G7xmjgjSL6UWge2tATmxmo6U0eB65ICUSgvA3DBbC1O+p2pj6ytPHW039g
        9ZeFbuRlzV+EGEDM4wVoIa+Zk/GaZkTFm6/knPFCu6cnrfZ11arolcgk88QZA63UNviyCr2d2t0l8
        TLimGsHA==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1poPEf-000FfC-4z; Mon, 17 Apr 2023 15:49:37 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: [PATCH bpf-next] bpf: Set skb redirect and from_ingress info in __bpf_tx_skb
Date:   Mon, 17 Apr 2023 15:49:15 +0200
Message-Id: <8cebc8b2b6e967e10cbafe2ffd6795050e74accd.1681739137.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26878/Mon Apr 17 09:23:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are some use-cases where it is desirable to use bpf_redirect()
in combination with ifb device, which currently is not supported, for
example, around filtering inbound traffic with BPF to then push it to
ifb which holds the qdisc for shaping in contrast to doing that on the
egress device.

Toke mentions the following case related to OpenWrt:

   Because there's not always a single egress on the other side. These are
   mainly home routers, which tend to have one or more WiFi devices bridged
   to one or more ethernet ports on the LAN side, and a single upstream WAN
   port. And the objective is to control the total amount of traffic going
   over the WAN link (in both directions), to deal with bufferbloat in the
   ISP network (which is sadly still all too prevalent).

   In this setup, the traffic can be split arbitrarily between the links
   on the LAN side, and the only "single bottleneck" is the WAN link. So we
   install both egress and ingress shapers on this, configured to something
   like 95-98% of the true link bandwidth, thus moving the queues into the
   qdisc layer in the router. It's usually necessary to set the ingress
   bandwidth shaper a bit lower than the egress due to being "downstream"
   of the bottleneck link, but it does work surprisingly well.

   We usually use something like a matchall filter to put all ingress
   traffic on the ifb, so doing the redirect from BPF has not been an
   immediate requirement thus far. However, it does seem a bit odd that
   this is not possible, and we do have a BPF-based filter that layers on
   top of this kind of setup, which currently uses u32 as the ingress
   filter and so it could presumably be improved to use BPF instead if
   that was available.

Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reported-by: Yafang Shao <laoar.shao@gmail.com>
Reported-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://git.openwrt.org/?p=project/qosify.git;a=blob;f=README
Link: https://lore.kernel.org/bpf/875y9yzbuy.fsf@toke.dk
---
 include/linux/skbuff.h | 9 +++++++++
 net/core/filter.c      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 494a23a976b0..9ff2e3d57329 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5041,6 +5041,15 @@ static inline void skb_reset_redirect(struct sk_buff *skb)
 	skb->redirected = 0;
 }
 
+static inline void skb_set_redirected_noclear(struct sk_buff *skb,
+					      bool from_ingress)
+{
+	skb->redirected = 1;
+#ifdef CONFIG_NET_REDIRECT
+	skb->from_ingress = from_ingress;
+#endif
+}
+
 static inline bool skb_csum_is_sctp(struct sk_buff *skb)
 {
 	return skb->csum_not_inet;
diff --git a/net/core/filter.c b/net/core/filter.c
index df0df59814ae..44fb997434ad 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2122,6 +2122,7 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	skb->dev = dev;
+	skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
 	skb_clear_tstamp(skb);
 
 	dev_xmit_recursion_inc();
-- 
2.21.0

