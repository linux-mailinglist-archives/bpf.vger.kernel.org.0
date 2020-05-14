Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100061D2D36
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgENKtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 06:49:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENKtV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 06:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589453361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5Pk5DJLVGFLtCPU8i1qdArebWBTUU2KueadN/fIUUM=;
        b=diFJFdqtF3f1Ekjf+1YlzqHWvjwJOaAGeVM8V9vQQAJt2v6Z23odo5a56a8TKmpxyWivYV
        buPjJKsTp/69v0H+4XpY47asTO+omuJ4IIbllVPS47yaOStMZ5gQFVpkUpJ2KgoU8Fv0or
        J8qWOEer7nudNNKHpj2LbNN54Wr8sSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-tvc8kPVbP3WTrosgjRaf4w-1; Thu, 14 May 2020 06:49:17 -0400
X-MC-Unique: tvc8kPVbP3WTrosgjRaf4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4421E8015CF;
        Thu, 14 May 2020 10:49:15 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBC1160C87;
        Thu, 14 May 2020 10:49:13 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id D0E78325159C9;
        Thu, 14 May 2020 12:49:12 +0200 (CEST)
Subject: [PATCH net-next v4 03/33] sfc: add XDP frame size
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
Date:   Thu, 14 May 2020 12:49:12 +0200
Message-ID: <158945335278.97035.14611425333184621652.stgit@firesoul>
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

This driver uses RX page-split when possible. It was recently fixed
in commit 86e85bf6981c ("sfc: fix XDP-redirect in this driver") to
add needed tailroom for XDP-redirect.

After the fix efx->rx_page_buf_step is the frame size, with enough
head and tail-room for XDP-redirect.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/sfc/rx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index 260352d97d9d..68c47a8c71df 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -308,6 +308,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	xdp_set_data_meta_invalid(&xdp);
 	xdp.data_end = xdp.data + rx_buf->len;
 	xdp.rxq = &rx_queue->xdp_rxq_info;
+	xdp.frame_sz = efx->rx_page_buf_step;
 
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
 	rcu_read_unlock();


