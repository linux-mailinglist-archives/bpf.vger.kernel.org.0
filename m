Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BE1B3326
	for <lists+bpf@lfdr.de>; Wed, 22 Apr 2020 01:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDUX3c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 19:29:32 -0400
Received: from sym2.noone.org ([178.63.92.236]:48870 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUX3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 19:29:32 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 496KXR40w9zvjc1; Wed, 22 Apr 2020 01:29:27 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] xsk: Fix typo in xsk_umem_consume_tx and xsk_generic_xmit comments
Date:   Wed, 22 Apr 2020 01:29:27 +0200
Message-Id: <20200421232927.21082-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

s/backpreassure/backpressure/

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c350108aa38d..f6e6609f70a3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -322,7 +322,7 @@ bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc)
 		if (!xskq_cons_peek_desc(xs->tx, desc, umem))
 			continue;
 
-		/* This is the backpreassure mechanism for the Tx path.
+		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
@@ -406,7 +406,7 @@ static int xsk_generic_xmit(struct sock *sk)
 		addr = desc.addr;
 		buffer = xdp_umem_get_data(xs->umem, addr);
 		err = skb_store_bits(skb, 0, buffer, len);
-		/* This is the backpreassure mechanism for the Tx path.
+		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
-- 
2.26.1

