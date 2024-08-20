Return-Path: <bpf+bounces-37650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5A958F32
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1CE1C21472
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CE18E37E;
	Tue, 20 Aug 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WbGSgdi0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC5157464
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186106; cv=none; b=QCPbJdwm4gGLzA6cRI48rcSiHD9Xl5ZZ+Gqs8/QNkMBlqsis2lz9su6Hn3rlmLiA6uo9zkBaoXZyDLlVnx5WOSrBJcT34fZx2ybz+BaT8aZxJ02eXi3Mlcv5C4eJQ/vmsG46Ykj+mcllLFA7TLHXFqZPk1znHdnwjByfEzmDdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186106; c=relaxed/simple;
	bh=UiczpnbBY3ZrF68vlz5ytjzBn/z07xuHXqZM60adjKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5jg1ZuBei9mckVI3IsizCkjK4EuteIhsXJYFEfV69u+H+r8W57fzTIFip2O6jK1vdxTuy2ioLdrsrBH5ORCooRT3Rj6icuyEiNltAI97fSZYMYsHbfDsLmVho4kPEugzlOsyCVCd6AQysMtoSBXV3Z/WGPo+BtWFw97nL6zYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WbGSgdi0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d7bc07b7so401939185a.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724186102; x=1724790902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj06AlN8Lo1JxvByc4fI5xdYlUnQGyATuG5tkQv6ggQ=;
        b=WbGSgdi0XFc8Yh7HBQ/Kxeho4vGLMSUNCFUwHqgxEqBqmE1KtX6qQjbIRtq6FxR/7l
         nk3U4QqowGanj0eQuUNkxw4qlCP9wsdUBikVEERd2Z0jm5VC8yvIgFa5wLNRg7HbNKmX
         EBA+CfkVpdF/Yd53HUU9Qh5v3mqtNiXGVYyrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724186102; x=1724790902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dj06AlN8Lo1JxvByc4fI5xdYlUnQGyATuG5tkQv6ggQ=;
        b=CU7Eo58x3VmYhafON9ZLlRbJg4XF7ykISsTMZpIZ0D+huRF2NNLRw53XXYHlq2h2Ot
         UFBRmF/bK4IuWrP/onF5DYSrxVAgqjAwX5Liteg6C82AzvaH9zSMsk6B1GsNrww2SAx8
         jkGaiCrDtaxMvAFN4meZjM7ekbMltW/KijxVFhQzYNZwkIcku+YgUTCUQ4miEPozuBr5
         OLtKfAUsT3FYSBh1ScWEliGoA+PRD2HOBadl3PTCgDedeGgy3l5B88LygGE07nYKW9nI
         UatBQGpiLdyMjHrJ2uGiifWFtvuhLbuMbsXaF72rhl0OggWRU84x70KjPVarVynrmNNF
         FdTw==
X-Forwarded-Encrypted: i=1; AJvYcCXQMaKTG9JT59aCimU8oOntB012Qj5+UvgAnab5FoOWaVBArlzhIfhyOaPRum1gOOGpM8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPjPdGYo8q7trK3d2VYVRz7bS/3NT08qXeJpma8KVJuCTs+XV
	BLGejJGHvN49bZ/gCMUouOWFlx9E9pNkNzbQxRkV2/I/XR+mhErQKU/erSK5Uw==
X-Google-Smtp-Source: AGHT+IGng1Asyl6Ga00/ocSE7KzAegomxLJh6UiteGdzu4R/6yIcI2ZETWHdEDWTOEsn2pDDoTswDw==
X-Received: by 2002:a05:620a:3906:b0:7a2:32e:3c47 with SMTP id af79cd13be357-7a67404bd69mr51869285a.34.1724186102238;
        Tue, 20 Aug 2024 13:35:02 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e04f6sm559619285a.82.2024.08.20.13.35.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 13:35:01 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net] bnxt_en: Fix double DMA unmapping for XDP_REDIRECT
Date: Tue, 20 Aug 2024 13:34:15 -0700
Message-ID: <20240820203415.168178-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Remove the dma_unmap_page_attrs() call in the driver's XDP_REDIRECT
code path.  This should have been removed when we let the page pool
handle the DMA mapping.  This bug causes the warning:

WARNING: CPU: 7 PID: 59 at drivers/iommu/dma-iommu.c:1198 iommu_dma_unmap_page+0xd5/0x100
CPU: 7 PID: 59 Comm: ksoftirqd/7 Tainted: G        W          6.8.0-1010-gcp #11-Ubuntu
Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS 2.15.2 04/02/2024
RIP: 0010:iommu_dma_unmap_page+0xd5/0x100
Code: 89 ee 48 89 df e8 cb f2 69 ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 e9 ab 17 71 00 <0f> 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9
RSP: 0018:ffffab1fc0597a48 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff99ff838280c8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffab1fc0597a78 R08: 0000000000000002 R09: ffffab1fc0597c1c
R10: ffffab1fc0597cd3 R11: ffff99ffe375acd8 R12: 00000000e65b9000
R13: 0000000000000050 R14: 0000000000001000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff9a06efb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565c34c37210 CR3: 00000005c7e3e000 CR4: 0000000000350ef0
? show_regs+0x6d/0x80
? __warn+0x89/0x150
? iommu_dma_unmap_page+0xd5/0x100
? report_bug+0x16a/0x190
? handle_bug+0x51/0xa0
? exc_invalid_op+0x18/0x80
? iommu_dma_unmap_page+0xd5/0x100
? iommu_dma_unmap_page+0x35/0x100
dma_unmap_page_attrs+0x55/0x220
? bpf_prog_4d7e87c0d30db711_xdp_dispatcher+0x64/0x9f
bnxt_rx_xdp+0x237/0x520 [bnxt_en]
bnxt_rx_pkt+0x640/0xdd0 [bnxt_en]
__bnxt_poll_work+0x1a1/0x3d0 [bnxt_en]
bnxt_poll+0xaa/0x1e0 [bnxt_en]
__napi_poll+0x33/0x1e0
net_rx_action+0x18a/0x2f0

Fixes: 578fcfd26e2a ("bnxt_en: Let the page pool manage the DMA mapping")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 345681d5007e..f88b641533fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -297,11 +297,6 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		 * redirect is coming from a frame received by the
 		 * bnxt_en driver.
 		 */
-		rx_buf = &rxr->rx_buf_ring[cons];
-		mapping = rx_buf->mapping - bp->rx_dma_offset;
-		dma_unmap_page_attrs(&pdev->dev, mapping,
-				     BNXT_RX_PAGE_SIZE, bp->rx_dir,
-				     DMA_ATTR_WEAK_ORDERING);
 
 		/* if we are unable to allocate a new buffer, abort and reuse */
 		if (bnxt_alloc_rx_data(bp, rxr, rxr->rx_prod, GFP_ATOMIC)) {
-- 
2.30.1


