Return-Path: <bpf+bounces-55054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA9A77726
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB023AC44A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF71EBA14;
	Tue,  1 Apr 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSt7wske"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA51E1A16;
	Tue,  1 Apr 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498164; cv=none; b=eNEVDlpMIvKarO7N1azn1nyJWCWbxFPmLaADSQpgtpKb/Qf0tQVLJQAPhf8AySUgqFZbsLzEc/Nto3HmtI0/H0NpQiUeFutYgE0ZdoED9oNUIY/khWAQd/86yEok/2fNiHeFsBnNLnpwQgTQd8rOjYkB3uAYaoQXN4/mcaIdKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498164; c=relaxed/simple;
	bh=sZy9HJEWjFiaEJU7uCcxroLNVGgBYJioQSxlKWKogB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XSR9igQtKhLLK4RKq00r+C1NsFYIOV8IOKr73ugAl6THemQRQ5spXQPJDnxBi3v81tmHUpLPd4DMnOWRCZ01EAywMDzKrq4FZ4y/jJt469JiK8E0X7x4LCSdQ2Ruo3CzlWl+FerYf3fHJYrdEpbjZBWQA84gtq35U510x3Khye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSt7wske; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB46C4CEE4;
	Tue,  1 Apr 2025 09:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743498164;
	bh=sZy9HJEWjFiaEJU7uCcxroLNVGgBYJioQSxlKWKogB8=;
	h=From:Date:Subject:To:Cc:From;
	b=NSt7wskeDBTxLpmPeTK+xAzw2fEH+RGlOpqceZPdtsQASUP9exTdZUgNY4s98YSaR
	 7pfEiYvsCBodPppFRSLrJBlqU+qa+IKdKppcpMWupgAG70UFReRt5mYyZPrH2n3v+S
	 M2A/zxgQJl1uBvs7/eTmbmidcPNsfa4+sQKxy4t37VFbth7RwUZh7XbfzZwYBQ47mV
	 miybLIM/6ei4LOlWlIlEBynszXpqemDMSmA5fNcgTyRvk/GW1AE1ME3S88TbO5zBoq
	 NwYSQjRWTjBcAIMed0mQixb9Js348sVu4LzhnZBqWK3HXkRcHWUreVfsWaDCEwEqnF
	 1b5H21MJmBGvw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 01 Apr 2025 11:02:12 +0200
Subject: [PATCH net] net: octeontx2: Handle XDP_ABORTED and XDP invalid as
 XDP_DROP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-octeontx2-xdp-abort-fix-v1-1-f0587c35a0b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJOr62cC/x2MQQqAIBAAvxJ7bkGlPPSV6GDrVnvRUAkh/HvSc
 QZmXsichDMswwuJH8kSQwc9DkCXCyej+M5glJnVpDRGKhxDqQarv9HtMRU8pOJBlnbylqxV0Os
 7cdf/ed1a+wDgBWhFaQAAAA==
X-Change-ID: 20250401-octeontx2-xdp-abort-fix-fc6cbcd6c660
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Sunil Goutham <sgoutham@cavium.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In the current implementation octeontx2 manages XDP_ABORTED and XDP
invalid as XDP_PASS forwarding the skb to the networking stack.
Align the behaviour to other XDP drivers handling XDP_ABORTED and XDP
invalid as XDP_DROP.
Please note this patch has just compile tested.

Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index af8cabe828d05c8832085d24d183312f24d00330..0a6bb346ba45be3a5d680a49cece5042cea68583 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1559,12 +1559,11 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
-		break;
+		fallthrough;
 	case XDP_ABORTED:
-		if (xsk_buff)
-			xsk_buff_free(xsk_buff);
-		trace_xdp_exception(pfvf->netdev, prog, act);
-		break;
+		if (act == XDP_ABORTED)
+			trace_xdp_exception(pfvf->netdev, prog, act);
+		fallthrough;
 	case XDP_DROP:
 		cq->pool_ptrs++;
 		if (xsk_buff) {

---
base-commit: f278b6d5bb465c7fd66f3d103812947e55b376ed
change-id: 20250401-octeontx2-xdp-abort-fix-fc6cbcd6c660

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


