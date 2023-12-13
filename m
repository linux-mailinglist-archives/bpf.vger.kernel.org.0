Return-Path: <bpf+bounces-17648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C66E81092A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 05:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EBE281D5A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 04:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C85C2DF;
	Wed, 13 Dec 2023 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JtR/u6ja"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A2D2;
	Tue, 12 Dec 2023 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FHrupvbQcDGgET6dyTC+OcKST+HXM/FqSxzspMVtFCs=; b=JtR/u6jaLg/mXNViR2Is2pqVQo
	4SyS6BJw65psZ9nQPRprSM68Tut2L95XsnFDG7ZvC5aXPmdlR5XtNoH0M3pXDU+0s6rsU985Xt4FC
	h45k9Kwj/QRENZBvaT9o5GeNbtqvQvx6OGEIV2icdwQbx2iqimRHsPdBsNHD+KtqM4TM/+jU40ifm
	BzMoBqp+F5W596RxhEWAg29oJDRBLCxy7JrpRMOOI3EN7vU6UZZ+QhplQRTJ9DIFMnSRaOXJsXwrk
	cJif0zhsEHf5PdahqHjuraywuyTT4N22DmHYan8Xm3V4ybeT9l1AKx2LGME1BcuU3d/ue5iNTHbqd
	+wPVziKg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDH04-00DavN-1o;
	Wed, 13 Dec 2023 04:37:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH] net, xdp: correct grammar
Date: Tue, 12 Dec 2023 20:37:35 -0800
Message-ID: <20231213043735.30208-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct verb form in 2 places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
---
 include/net/xdp.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/net/xdp.h b/include/net/xdp.h
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -16,7 +16,7 @@
  *
  * The XDP RX-queue info (xdp_rxq_info) is associated with the driver
  * level RX-ring queues.  It is information that is specific to how
- * the driver have configured a given RX-ring queue.
+ * the driver has configured a given RX-ring queue.
  *
  * Each xdp_buff frame received in the driver carries a (pointer)
  * reference to this xdp_rxq_info structure.  This provides the XDP
@@ -32,7 +32,7 @@
  * The struct is not directly tied to the XDP prog.  A new XDP prog
  * can be attached as long as it doesn't change the underlying
  * RX-ring.  If the RX-ring does change significantly, the NIC driver
- * naturally need to stop the RX-ring before purging and reallocating
+ * naturally needs to stop the RX-ring before purging and reallocating
  * memory.  In that process the driver MUST call unregister (which
  * also applies for driver shutdown and unload).  The register API is
  * also mandatory during RX-ring setup.

