Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D50F1D2D37
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgENKtX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 06:49:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26418 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbgENKtW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 06:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589453361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILUJG63r1fVqpZWn7jYsmXbyYX5nOdIA8b/M8XqOOLI=;
        b=NjH8UGEs5Nmkg3ikiYdA8YIHsvVhMKfBMcK85xdrcp+Kc9Xhkce0MT7qufz+GDWzraMqBt
        AGxYgv0uULCz4Y/4/OJ/ThLuZ8dF5u0yUr+OUcGXUnDFF8OD5jDgN0kAKSS+NpL9HDvyng
        sloI8AuNEnAut/rZ9q/qd7gGUZSfE2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-4d3CsMd4PP2C4TcHRz3NyA-1; Thu, 14 May 2020 06:49:17 -0400
X-MC-Unique: 4d3CsMd4PP2C4TcHRz3NyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38D4DEC1A2;
        Thu, 14 May 2020 10:49:15 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB8DE60BF1;
        Thu, 14 May 2020 10:49:08 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id BC051300020FC;
        Thu, 14 May 2020 12:49:07 +0200 (CEST)
Subject: [PATCH net-next v4 02/33] bnxt: add XDP frame size to driver
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Date:   Thu, 14 May 2020 12:49:07 +0200
Message-ID: <158945334769.97035.13437970179897613984.stgit@firesoul>
In-Reply-To: <158945314698.97035.5286827951225578467.stgit@firesoul>
References: <158945314698.97035.5286827951225578467.stgit@firesoul>
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

In case of XDP uses driver uses __bnxt_alloc_rx_page which does full
page DMA-map. Thus, xdp_adjust_tail grow is DMA compliant for XDP_TX
action that does DMA-sync.

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


