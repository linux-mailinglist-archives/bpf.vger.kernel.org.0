Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403C11A202C
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgDHLuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Apr 2020 07:50:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55950 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728570AbgDHLuy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Apr 2020 07:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586346653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=902ZrQ0FmY2T7r9/E7C7KmRNTtWQBm4ZVBZiBQzPeQk=;
        b=DNS9GYK4Wyj4qCRQz06W/Qb5C8x81cGrrHNEfmizxoLnwyMhE0Z2j/zkYnABC6jkBqooVv
        TuOoUy7slHNnCrKet/37Xbsu8fuLd3Ct8I5oxsjwnE4jgyL5itxVwSsWTLoq9sSvmYXFA5
        Kg+nya3l5GlwEsFGqspGO1+YocRMunI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-4iHv-62-P3-vbWBqBEsJEg-1; Wed, 08 Apr 2020 07:50:49 -0400
X-MC-Unique: 4iHv-62-P3-vbWBqBEsJEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF01108442E;
        Wed,  8 Apr 2020 11:50:46 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6570A60BFB;
        Wed,  8 Apr 2020 11:50:45 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 80560300020FA;
        Wed,  8 Apr 2020 13:50:44 +0200 (CEST)
Subject: [PATCH RFC v2 02/33] bnxt: add XDP frame size to driver
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Michael Chan <michael.chan@broadcom.com>,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Wed, 08 Apr 2020 13:50:44 +0200
Message-ID: <158634664445.707275.1398644487162575219.stgit@firesoul>
In-Reply-To: <158634658714.707275.7903484085370879864.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This driver uses full PAGE_SIZE pages when XDP is enabled.

Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index c6f6f2033880..5e3b4a3b69ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -138,6 +138,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	xdp_set_data_meta_invalid(&xdp);
 	xdp.data_end = *data_ptr + *len;
 	xdp.rxq = &rxr->xdp_rxq;
+	xdp.frame_sz = PAGE_SIZE; /* BNXT_RX_PAGE_MODE(bp) when XDP enabled */
 	orig_data = xdp.data;
 
 	rcu_read_lock();


