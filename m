Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BA6CEF6D
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjC2Qac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjC2QaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 12:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A6448D
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680107359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phrCwuF2IZNqe/IWguOcg/v1PLS/jorujG/kF7C6s+4=;
        b=Zp6UdwGxbOGnbFXA8NH3kFCZZkSgJdJrylXh79t5cpNlrxi7d2Drg9PvVVaRjqvVoDXlYO
        xF0r0RkkrXQNCte0BBViYP6A2yKVh9dP4N6mB/UzaWNB2/Jv+YkiaoviTdDjo7hJ5dB9ll
        bpKvqApY8iT7VkNlUtbk6ASzkv2u2AQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-22tuEMDwMvKNnNE4IGw0gw-1; Wed, 29 Mar 2023 12:29:15 -0400
X-MC-Unique: 22tuEMDwMvKNnNE4IGw0gw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 806CE3C0F22C;
        Wed, 29 Mar 2023 16:29:14 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45C45492B02;
        Wed, 29 Mar 2023 16:29:14 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 6815230736C72;
        Wed, 29 Mar 2023 18:29:13 +0200 (CEST)
Subject: [PATCH bpf RFC-V2 3/5] veth: bpf_xdp_metadata_rx_hash return xdp rss
 hash type
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Date:   Wed, 29 Mar 2023 18:29:13 +0200
Message-ID: <168010735338.3039990.5752685085641326312.stgit@firesoul>
In-Reply-To: <168010726310.3039990.2753040700813178259.stgit@firesoul>
References: <168010726310.3039990.2753040700813178259.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update API for bpf_xdp_metadata_rx_hash() by returning xdp rss hash type.

The veth driver currently only support XDP-hints based on SKB code path.
The SKB have lost information about the RSS hash type, by compressing
the information down to a single bitfield skb->l4_hash, that only knows
if this was a L4 hash value.

In preparation for veth, the xdp_rss_hash_type have an L4 indication
bit that allow us to return a meaningful L4 indication when working
with SKB based packets.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/veth.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 046461ee42ea..770eee664b4c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1619,12 +1619,13 @@ static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
 {
 	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
 
-	if (!_ctx->skb)
+	if (!skb)
 		return -ENODATA;
 
-	*hash = skb_get_hash(_ctx->skb);
-	return 0;
+	*hash = skb_get_hash(skb);
+	return skb->l4_hash ? XDP_RSS_TYPE_L4_ANY : XDP_RSS_TYPE_NONE;
 }
 
 static const struct net_device_ops veth_netdev_ops = {


