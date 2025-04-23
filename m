Return-Path: <bpf+bounces-56489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB34A98BDA
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251103BC10C
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3581A4E70;
	Wed, 23 Apr 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="khKz/QWp"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334719F121;
	Wed, 23 Apr 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416321; cv=none; b=N5hJX6HsaKfOC/+ihhYH590t59k6kqd9VoAATBomzRBBGZSJ/DhLcn5Ji2XnRs3c9hZM+7Bj5NDaPFzlYV9zx2dQWPvyqaG/vwxQr4K3mWDt/HxlAQ1F8NQmV/yTYyVCJdN7o0dO02rkYlBha8Ew90Fs38V2VvfWv3EBD51m9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416321; c=relaxed/simple;
	bh=vkHUz5Y/Z51TaWRVJXs72kzGY33VaBWtYdjAEAOQWJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExWpWQCXZl5JRVQIEHETtD/bCdOr1fdr5qRkxI5Il47LN065YnXTWe9FtXVwzg3LxOJXj98d+JlVmibZJ/vFmAchGNumvCmQNEHsO3FrwaHHjAi5xIZYbZ+zN5q4gIr9SSH99DFLC6wqpTv0fSpRvOUHgJ3I3C5IbxCapCpg+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=khKz/QWp; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=IMCPuVA6/i+pUoALfItRP9EV1da9/5LML/7OjIzcryo=; b=khKz/QWpSt9+BEGBkdWgA9dpxk
	oFqcuci/ch6LseibNN1DNmQYS7rztVj53+GWrU9BnUrOG85m9gLyD/lOG9TTyaGonszuCWCmgN04H
	10Mh+RN1Og7epCKmxnYXr/LJEsQZwUBiErb2GyMdUT78leboDY8rFJfOSJHZcIaSZ3jYrinrJKHo4
	8GTApS7C+smSbop94hZfYyk0LVTAZ1O5ksaGzcbHRirhHDL8arV1vXTz3KviX8IWln4dJsz1EhKka
	8BEyGrcKSAoDsQocgUrp9xuOMaUiK1jMoLp/35kDOGTj/YrH4kfHfC8jHuIBYQhw0nZBE1ctWzK/1
	Wcj8Qr+A==;
Received: from 85-195-247-12.fiber7.init7.net ([85.195.247.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1u7aGe-0007fK-2p;
	Wed, 23 Apr 2025 15:36:01 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Sauber <andrew.sauber@isovalent.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	William Tu <witu@nvidia.com>,
	Martin Zaharinov <micron10@gmail.com>,
	Ronak Doshi <ronak.doshi@broadcom.com>
Subject: [PATCH net] vmxnet3: Fix malformed packet sizing in vmxnet3_process_xdp
Date: Wed, 23 Apr 2025 15:36:00 +0200
Message-ID: <20250423133600.176689-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27617/Wed Apr 23 10:38:53 2025)

vmxnet3 driver's XDP handling is buggy for packet sizes using ring0 (that
is, packet sizes between 128 - 3k bytes).

We noticed MTU-related connectivity issues with Cilium's service load-
balancing in case of vmxnet3 as NIC underneath. A simple curl to a HTTP
backend service where the XDP LB was doing IPIP encap led to overly large
packet sizes but only for *some* of the packets (e.g. HTTP GET request)
while others (e.g. the prior TCP 3WHS) looked completely fine on the wire.

In fact, the pcap recording on the backend node actually revealed that the
node with the XDP LB was leaking uninitialized kernel data onto the wire
for the affected packets, for example, while the packets should have been
152 bytes their actual size was 1482 bytes, so the remainder after 152 bytes
was padded with whatever other data was in that page at the time (e.g. we
saw user/payload data from prior processed packets).

We only noticed this through an MTU issue, e.g. when the XDP LB node and
the backend node both had the same MTU (e.g. 1500) then the curl request
got dropped on the backend node's NIC given the packet was too large even
though the IPIP-encapped packet normally would never even come close to
the MTU limit. Lowering the MTU on the XDP LB (e.g. 1480) allowed to let
the curl request succeed (which also indicates that the kernel ignored the
padding, and thus the issue wasn't very user-visible).

Commit e127ce7699c1 ("vmxnet3: Fix missing reserved tailroom") was too eager
to also switch xdp_prepare_buff() from rcd->len to rbi->len. It really needs
to stick to rcd->len which is the actual packet length from the descriptor.
The latter we also feed into vmxnet3_process_xdp_small(), by the way, and
it indicates the correct length needed to initialize the xdp->{data,data_end}
parts. For e127ce7699c1 ("vmxnet3: Fix missing reserved tailroom") the
relevant part was adapting xdp_init_buff() to address the warning given the
xdp_data_hard_end() depends on xdp->frame_sz. With that fixed, traffic on
the wire looks good again.

Fixes: e127ce7699c1 ("vmxnet3: Fix missing reserved tailroom")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Andrew Sauber <andrew.sauber@isovalent.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
Cc: William Tu <witu@nvidia.com>
Cc: Martin Zaharinov <micron10@gmail.com>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 616ecc38d172..5f470499e600 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -397,7 +397,7 @@ vmxnet3_process_xdp(struct vmxnet3_adapter *adapter,
 
 	xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
 	xdp_prepare_buff(&xdp, page_address(page), rq->page_pool->p.offset,
-			 rbi->len, false);
+			 rcd->len, false);
 	xdp_buff_clear_frags_flag(&xdp);
 
 	xdp_prog = rcu_dereference(rq->adapter->xdp_bpf_prog);
-- 
2.43.0


