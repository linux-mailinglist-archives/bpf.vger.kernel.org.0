Return-Path: <bpf+bounces-63831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A8B0B48B
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C2E3B98EB
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A531EA7E4;
	Sun, 20 Jul 2025 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXlWHUKd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D59A1EA65;
	Sun, 20 Jul 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002720; cv=none; b=LYWAAfUrUypMISWp4yU59ui5/GwA5+iHpMkZ3PmMb5oSiD220biCsyZDyd59SAbspU0myJi5wCZZs6TM+tMfDZHKUBHO5CJomqJJ/uffTf9Zlbc8LjbIlCAEFUGkRftMWy27wUiAsHf8TGJfag3U38TO1H7hRMxONoT8vWflHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002720; c=relaxed/simple;
	bh=SVOm332ZMkidRN5x01g9cOYuk3un1VbkEF/kUobgkbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqFmmRkdvoP8CXk1jNbI76ZHyCweMWX4JDV0kYDVUGPdpSiKIYerH5+JWBhPo+iQjsZMtmyXsjyH/i+39ZCHiqBNfSijC7iL3BGyqCOper5yTgoLrKxGmuX6ai4QTALuKIt+Qwq8TXOiPsq8lGaVjMYY791Bbf7usdu+s2UfY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXlWHUKd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b27c1481bso2111605b3a.2;
        Sun, 20 Jul 2025 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753002718; x=1753607518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVTh8scedwT+FOGTHFHCKCjv2dpHDWdPrkAltL4AcWE=;
        b=aXlWHUKdBLP4OEg/Jqji0x7C7PoaT2hYF13BRZ1dSyBdLosGV2ikHyADYMiNZlecHn
         VfXgO9190cVxDP0kyCn6lHIbMD4sTtQoeHzSfNc+kC7I30DyvTHHJAPwla3L7TUVamh0
         uHtLNgoSvSUzsFI8xFsfjEdk+GeKvrsr1AKHgIoBe+o72E1P99+PtYgcLEzUdTN/sT/v
         kXdtBTPMoHrepATkZpDOiFsWabcwQMTiThESpAIpUpI1eHTz5aa21R/mo5mz/l61YqY3
         MXdMbr0EiHdllDDH+wh4wxNldyzio9q5RmmBagzdPJCMC1E55IAk7tmGhe3pnEu8YWOc
         fSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002718; x=1753607518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVTh8scedwT+FOGTHFHCKCjv2dpHDWdPrkAltL4AcWE=;
        b=wlGNOSb1g9LV2yyqRDUWoQoXG7MuSb2Vq4z9N78AAgmnsXzWXbeR4SWZ1Q9nXVdsKl
         WTzpiuLSgFNzF2oyLn4cZ2wjRVnylingWfX245rsw8sjXH0lonYZr0Xn8JtuMdmyhgwu
         5JbEvW0Sem6dOF1bjypLtVHQWnH8cC7a2W76Jbj3mDDevy6qvuRyYEUlPgLnFWr3UE1X
         x9p9Gta6SEkBL8H3NYHviekiDVSBeeOI5/ql6qtVKaUXNnH+2CcQJVOCuQ9bF7cTOZLC
         SB1uVNfpu0EHjuziBXfypVUDNdH4jrT6cqk0IBFqaFxXh8br01ZiwuFvdJzmS9fcYE0V
         UPvA==
X-Forwarded-Encrypted: i=1; AJvYcCXaDr40GhigcHj54jy7Q51Cp/9EmlzY2I+y5ZCeFCmZ8Ekl9QO6cpn/KM1Y5rfbHSG5ZawbtY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqUn10vs3aAH69bqc1YYAgtaM1229WpUv2c1C/4GroThqjZ4o
	wmXG2TAhXmDCFA/Je2iQYvr5rFinCaYy8SJipc/wHxoAql3wwC82HpfT
X-Gm-Gg: ASbGncvodJahz7PiGsp+cBtbKZ5p7EgPjAojaJ90YTYrZQRrGU0+pZ+uTeO1mP8KzFm
	9F5Dqc8HuedjBAr551L8qnZIMZ7cTD7+VWMAgy36g/VsBwxLP/HiODMWQqcU82KJPmjGrQUKRtB
	+kfBAuiwdpoYYgIGp0hpNIX8jFuGiWH7OKo5KJNpLBHlWoKFVIBV2UeChhmAoE3SIy0RfDdxuiR
	FYeuB2IoQpnHJTWdHSpjAuy7N/N6SEQ3xF60jP9QnK0dXQDJnqLy2ogMN9AGKt+XQOS1L3jgUUu
	+Ctb7nP+sK+n3eyP8w6P9W/+UKWukd6dxT/1rBJhHvKfgEDM6LB4nkT7Ixv/fe/k9RJSXWAOtE7
	YK3+42Nz59rrdTNz2CFIRHylFIYUs3TrHApG14TjinkMXDbVBZnMAdixynB0=
X-Google-Smtp-Source: AGHT+IGn9znc9ZrKLBsrlOwE9Bg2AnWaL3wLmuxWRd7FltjLlF/qlyzNXzxY+owS9C9xXPp/8i+nJA==
X-Received: by 2002:a05:6a00:92a7:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-756e81a0b16mr29927197b3a.8.1753002718242;
        Sun, 20 Jul 2025 02:11:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm3902585b3a.105.2025.07.20.02.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 02:11:57 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 5/5] ixgbe: xsk: add TX multi-buffer support
Date: Sun, 20 Jul 2025 17:11:23 +0800
Message-Id: <20250720091123.474-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250720091123.474-1-kerneljasonxing@gmail.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Use the common interface to see if the desc is the end of packets. If
so, set IXGBE_TXD_CMD_EOP bit instead of setting for all preceding
descriptors. This is also how i40e driver did in commit a92b96c4ae10
("i40e: xsk: add TX multi-buffer support").

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a59fd8f74b5e..c34737065f9e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -52,6 +52,8 @@
 #include "ixgbe_txrx_common.h"
 #include "devlink/devlink.h"
 
+#define IXGBE_MAX_BUFFER_TXD 4
+
 char ixgbe_driver_name[] = "ixgbe";
 static const char ixgbe_driver_string[] =
 			      "Intel(R) 10 Gigabit PCI Express Network Driver";
@@ -11805,6 +11807,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	netdev->xdp_zc_max_segs = IXGBE_MAX_BUFFER_TXD;
+
 	/* MTU range: 68 - 9710 */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE - (ETH_HLEN + ETH_FCS_LEN);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 9fe2c4bf8bc5..3d9fa4f2403e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -424,7 +424,9 @@ static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc,
 	cmd_type = IXGBE_ADVTXD_DTYP_DATA |
 		   IXGBE_ADVTXD_DCMD_DEXT |
 		   IXGBE_ADVTXD_DCMD_IFCS;
-	cmd_type |= desc[i].len | IXGBE_TXD_CMD_EOP;
+	cmd_type |= desc[i].len;
+	if (xsk_is_eop_desc(&desc[i]))
+		cmd_type |= IXGBE_TXD_CMD_EOP;
 	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
 	tx_desc->read.olinfo_status =
 		cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
-- 
2.41.3


