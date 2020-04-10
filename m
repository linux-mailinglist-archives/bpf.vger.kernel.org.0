Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181151A4858
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 18:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJQWK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 12:22:10 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33465 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbgDJQWK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Apr 2020 12:22:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 97D2547B;
        Fri, 10 Apr 2020 12:22:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 Apr 2020 12:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jibi.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=9CR9pol/44
        Milc3qq6BmYWxyUhlRaU2unFcL4Jxpl3s=; b=hUI5vdChkK8q8Uv8lWe99IKOjy
        9MZHd7VsrjqI6vwuk9UG0C3kzWT6HHjWfoYScVrbSjAqYS/ZVorvcH9ZS595Zmyw
        Vv0i/0+LCK4dtjSF+lzIxSBAcXTxwcEsdKjs6fsPfrt7JfYjMuTWzszRHx+2kqdK
        49r/wc1GsCtQ7tinw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=9CR9pol/44Milc3qq6BmYWxyUhlRaU2unFcL4Jxpl3s=; b=VdE0ga93
        il6MvmY5hjaIRR8yApmWo7UuhLhInpV6bg2OVUq/+osS/hIanzeJur2Oot50Yv2E
        zBMiAIrCXC7P9uzTvvMV6qURBosSMAQAoT+gnWPi2JHJbJ4CeXwTiuUlXd9DiAbM
        SGrhCjs6g2EfO4/unkI/fmTGRpCRXBeiYLNAR/j7ZKbjI239v0QHTm6gsyFy2fKO
        c9s8qEe4i3wTG6Wtz23p6TJ0K8Z651mY6H6C5vP8pl9Cvi6GDS+HNiJ6QTlgRksK
        JTszcqwwfIa8sqn2/1iTgspo40n6YXi87xC6rDR5iA6WSxFSJDSI6m7sIMiLboPR
        vv7WDBVTHvjOJA==
X-ME-Sender: <xms:MZ2QXlDJ3FgeqztKOCOgXLfzLq1ojVV7UXEuW-esYUNJqOOZhG8dSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepifhilhgsvghrthhouceuvghrthhinhcuoehmvgesjhhisghi
    rdhioheqnecukfhppedvrddvfeegrddufedurddvheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesjhhisghirdhioh
X-ME-Proxy: <xmx:MZ2QXno5leJeqGdH_JMmHwBfxZe9SfpBAxbqQ18CqRyKiibB-61aVg>
    <xmx:MZ2QXtnT6ZxizYW577wntz14EgBIqPdnBdD2MUv8Af6883qRBiX8Sg>
    <xmx:MZ2QXqXF0SB25oF5xiwVYl9EKwa5_vXXKt5j4RY-xvjEGGwamdMG-Q>
    <xmx:MZ2QXuEIDaKyx2oUcGnYX1Ok7DNPDNY7HKYB2dx36hYA5MfcBANKCA>
Received: from apathy.lan (2-234-131-25.ip223.fastwebnet.it [2.234.131.25])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E7A23280067;
        Fri, 10 Apr 2020 12:22:07 -0400 (EDT)
From:   Gilberto Bertin <me@jibi.io>
To:     bpf@vger.kernel.org, jasowang@redhat.com
Cc:     Gilberto Bertin <me@jibi.io>
Subject: [PATCH 1/1] net: tun: record RX queue in skb before do_xdp_generic()
Date:   Fri, 10 Apr 2020 18:20:59 +0200
Message-Id: <20200410162059.15438-2-me@jibi.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410162059.15438-1-me@jibi.io>
References: <20200410162059.15438-1-me@jibi.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows netif_receive_generic_xdp() to correctly determine the RX
queue from which the skb is coming, so that the context passed to the
XDP program will contain the correct RX queue index.

Signed-off-by: Gilberto Bertin <me@jibi.io>
---
 drivers/net/tun.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 228fe449dc6d..42b5d8740987 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1886,6 +1886,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	skb_reset_network_header(skb);
 	skb_probe_transport_header(skb);
+	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
 		struct bpf_prog *xdp_prog;
@@ -2457,6 +2458,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb->protocol = eth_type_trans(skb, tun->dev);
 	skb_reset_network_header(skb);
 	skb_probe_transport_header(skb);
+	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
 		err = do_xdp_generic(xdp_prog, skb);
@@ -2468,7 +2470,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 	    !tfile->detached)
 		rxhash = __skb_get_hash_symmetric(skb);
 
-	skb_record_rx_queue(skb, tfile->queue_index);
 	netif_receive_skb(skb);
 
 	/* No need for get_cpu_ptr() here since this function is
-- 
2.20.1

