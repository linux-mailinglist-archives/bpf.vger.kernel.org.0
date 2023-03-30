Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59086D0C4A
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjC3RI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjC3RIv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E1CDDF
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680196082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZoFlTLlLEFnWNA/e5RUGygzU5KPyB6B2U1PTeQjWe4=;
        b=WnwgCtqppdJ3oYYa9rQu5zfxaDug4Mwud25OD+uZ43Mbst0KcS2ZMQuLxp9zK+SnKMW9D6
        3+OjuqkDo4XJCj/UcosW80MGtX6P3mz0WRAfVY5zMaDBRZKDWSUIowbiH3vtkmPE0Hxa4R
        60URHSgIkWCPHi7rnWiCoPQJ2LxrduQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-aug2f9xDNsKg0k9hF4gfzg-1; Thu, 30 Mar 2023 13:07:58 -0400
X-MC-Unique: aug2f9xDNsKg0k9hF4gfzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C643A101A54F;
        Thu, 30 Mar 2023 17:07:56 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 860244042AC0;
        Thu, 30 Mar 2023 17:07:56 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id E2D5430736C72;
        Thu, 30 Mar 2023 19:07:55 +0200 (CEST)
Subject: [PATCH bpf RFC-V3 3/5] veth: bpf_xdp_metadata_rx_hash add xdp rss
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
Date:   Thu, 30 Mar 2023 19:07:55 +0200
Message-ID: <168019607588.3557870.8079404138352729694.stgit@firesoul>
In-Reply-To: <168019602958.3557870.9960387532660882277.stgit@firesoul>
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update API for bpf_xdp_metadata_rx_hash() with arg for xdp rss hash type.

The veth driver currently only support XDP-hints based on SKB code path.
The SKB have lost information about the RSS hash type, by compressing
the information down to a single bitfield skb->l4_hash, that only knows
if this was a L4 hash value.

In preparation for veth, the xdp_rss_hash_type have an L4 indication
bit that allow us to return a meaningful L4 indication when working
with SKB based packets.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/veth.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index c1178915496d..f5381e7c9310 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1648,14 +1648,19 @@ static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 	return 0;
 }
 
-static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
+static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+			    enum xdp_rss_hash_type *rss_type)
+
 {
 	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
 
-	if (!_ctx->skb)
+	if (!skb)
 		return -ENODATA;
 
-	*hash = skb_get_hash(_ctx->skb);
+	*hash = skb_get_hash(skb);
+	*rss_type = skb->l4_hash ? XDP_RSS_TYPE_L4_ANY : XDP_RSS_TYPE_NONE;
+
 	return 0;
 }
 


