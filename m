Return-Path: <bpf+bounces-20115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B227839A02
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07C01F2450B
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885E685C5E;
	Tue, 23 Jan 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Tc8n6Pt+"
X-Original-To: bpf@vger.kernel.org
Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401C82D8D;
	Tue, 23 Jan 2024 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040567; cv=none; b=TV/oHGdIGid6chQoWfzUaZmewicRReXIfBRsAJZDjNPs8bSd6f+0IMJYqiGdlHZcMKXz4/FxtjGiQu0EQ88kD6D1+gPQ91vxv4xhizZbjVMbscy2NdwqGyTdoo7juw6zQCREvACQlkYXWZvJldkGjj7Mzp13Gfby3M+DOVEsoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040567; c=relaxed/simple;
	bh=Eahtt7sp9NJ+VqKi4mXtvkxGACKZUdR8h1dFdG71Mf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGpQx8Zl3QeqX3UjGCLp3uTRFMEZ251SdsI9HiaT+s02QQaBmWK6mVUI3hXmPnZghIOfzcHNEaAPJn78F84NHBo2upMATYdCF+R5IhDxH1EloyvXwcR6uIDhsrsglWfRCCpoqA+AqzY0n+tL7sPU+ooPI9EX5bujl4li+SHFrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Tc8n6Pt+; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l+aWBgTvWf+NUADLxxLeRzHBIAi5CDIxHTcun2ROO7c=; b=Tc8n6Pt+KxjzPmnt8vV0luJSvi
	/Uff9U4T65TA3v5LbOh5sXhRjrmTKk+Uel406vBK0GxRMa8kc6upUlSuEN21W1jfdajeEHu9OI0lL
	V3dTCT3bGvaftCXcCKdjb3AaDbjG73qglKTG06RqtO5SHE62bVkJcOyD6MZjeDMe4c1U=;
Received: from 88-117-59-234.adsl.highway.telekom.at ([88.117.59.234] helo=hornet.engleder.at)
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rSN5H-0006xu-2V;
	Tue, 23 Jan 2024 21:09:23 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net 1/2] tsnep: Remove FCS for XDP data path
Date: Tue, 23 Jan 2024 21:09:17 +0100
Message-Id: <20240123200918.61219-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123200918.61219-1-gerhard@engleder-embedded.com>
References: <20240123200918.61219-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

The RX data buffer includes the FCS. The FCS is already stripped for the
normal data path. But for the XDP data path the FCS is included and
acts like additional/useless data.

Remove the FCS from the RX data buffer also for XDP.

Fixes: 65b28c810035 ("tsnep: Add XDP RX support")
Fixes: 3fc2333933fd ("tsnep: Add XDP socket zero-copy RX support")
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 0462834cf6e1..d380a407e175 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1487,7 +1487,7 @@ static int tsnep_rx_poll(struct tsnep_rx *rx, struct napi_struct *napi,
 
 			xdp_prepare_buff(&xdp, page_address(entry->page),
 					 XDP_PACKET_HEADROOM + TSNEP_RX_INLINE_METADATA_SIZE,
-					 length, false);
+					 length - ETH_FCS_LEN, false);
 
 			consume = tsnep_xdp_run_prog(rx, prog, &xdp,
 						     &xdp_status, tx_nq, tx);
@@ -1570,7 +1570,7 @@ static int tsnep_rx_poll_zc(struct tsnep_rx *rx, struct napi_struct *napi,
 		prefetch(entry->xdp->data);
 		length = __le32_to_cpu(entry->desc_wb->properties) &
 			 TSNEP_DESC_LENGTH_MASK;
-		xsk_buff_set_size(entry->xdp, length);
+		xsk_buff_set_size(entry->xdp, length - ETH_FCS_LEN);
 		xsk_buff_dma_sync_for_cpu(entry->xdp, rx->xsk_pool);
 
 		/* RX metadata with timestamps is in front of actual data,
-- 
2.39.2


