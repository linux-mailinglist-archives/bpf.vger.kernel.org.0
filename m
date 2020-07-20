Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC6225B41
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGTJTJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 05:19:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:40721 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgGTJTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 05:19:09 -0400
IronPort-SDR: oEiPROgsQl49m4foMrq9hPnG7UBq8a/IdbTpR5jdewSHRzDvrCrxPXItEmIJAYn3xYYa9yrZZm
 O+kdyLDb8a6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="234729964"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="234729964"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 02:19:08 -0700
IronPort-SDR: IipPMVb3td1chFDioLh/OGTvPZYMYwpARXAPXwh1b4Zen9mjQS9rt+DSASfdoprF9QGW/WK2Vq
 NN/RbVzs9Zxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="431549202"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.252.34.51])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2020 02:19:05 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, maximmi@mellanox.com
Cc:     bpf@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        anthony.l.nguyen@intel.com, maciej.fijalkowski@intel.com,
        maciejromanfijalkowski@gmail.com, cristian.dumitrescu@intel.com
Subject: [PATCH bpf-next v3 11/14] xsk: add shared umem support between devices
Date:   Mon, 20 Jul 2020 11:18:11 +0200
Message-Id: <1595236694-12749-12-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595236694-12749-1-git-send-email-magnus.karlsson@intel.com>
References: <1595236694-12749-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support to share a umem between different devices. This mode
can be invoked with the XDP_SHARED_UMEM bind flag. Previously,
sharing was only supported within the same device. Note that when
sharing a umem between devices, just as in the case of sharing a
umem between queue ids, you need to create a fill ring and a
completion ring and tie them to the socket (with two setsockopts,
one for each ring) before you do the bind with the
XDP_SHARED_UMEM flag. This so that the single-producer
single-consumer semantics of the rings can be upheld.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e897755..ec2a2df 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -701,14 +701,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 			sockfd_put(sock);
 			goto out_unlock;
 		}
-		if (umem_xs->dev != dev) {
-			err = -EINVAL;
-			sockfd_put(sock);
-			goto out_unlock;
-		}
 
-		if (umem_xs->queue_id != qid) {
-			/* Share the umem with another socket on another qid */
+		if (umem_xs->queue_id != qid || umem_xs->dev != dev) {
+			/* Share the umem with another socket on another qid
+			 * and/or device.
+			 */
 			xs->pool = xp_create_and_assign_umem(xs,
 							     umem_xs->umem);
 			if (!xs->pool) {
-- 
2.7.4

