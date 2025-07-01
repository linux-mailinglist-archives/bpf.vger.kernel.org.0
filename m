Return-Path: <bpf+bounces-61948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839EAEF08A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7B81641E1
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E526A08D;
	Tue,  1 Jul 2025 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FleEplB4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314961F874F;
	Tue,  1 Jul 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357429; cv=none; b=EA8/MgtjFYaSqQ/crl0Xv7wAljeGEtZBKoWPg4uoVw/XshMZbFKdOahNwzVlat6dHAgJ2g6O9ORmbTmo6n5jWvQv4tomVkT6phF68u+jqrK/6A5Hf6DBneIPcn2u8rNYqj0tLe0JnJysM9ml8awI+1axSiIjyPErVIYNTPttrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357429; c=relaxed/simple;
	bh=7sZ8JpEpsLeAlSytAyUZab5HbOa8V6855ztPImxUrcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RsxtoFIw+Aio2sUl22b3RGmHJv+nU0InKqRuhKQqgB756M8ZsMEWUkd9wwyWgvX0DSyAW2dFjoXX8DtT7KtmJX2klRxKqeRy/8SdLYhYpB1iE/8Ublg5TgANz8oG+DisjTJLJP/P0LL1e02jtqEm04m5pz/37nkEndQamSvdBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FleEplB4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751357428; x=1782893428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7sZ8JpEpsLeAlSytAyUZab5HbOa8V6855ztPImxUrcQ=;
  b=FleEplB4fGXZZO1Qpx4VNf4MX2FIGbyi+sVb1X6/14c4DV+BPo576o3M
   dHjWvLv/zgmApSU41R945SILMZqn1myQtmC9Xgk76LVNqiDQUHza8u9Za
   rcntO6vxJkowXd6Q2B5xN4cLLF85gPvWkmmwA5QQZp5zAHmIHZ3weYZK2
   H5gdP2XW4TbUztKIf6vuqF+2JU8oUH8xyZpn1HKUBNZQF8KGFfQaYCZvL
   FGkEYte5zZIGkyIUpfoYLR7TQQwpdczxGo35M0b3F8mC2OyNWaaWogO6P
   WI69tcesHfhP0CvqKhNzO2xXenBhtv79x6B6MSnJs/1bJiQkZ24A0SWwd
   Q==;
X-CSE-ConnectionGUID: vKNTV+R4Rxa98dw89cuxHQ==
X-CSE-MsgGUID: 8ptiVLdgTHq8V3G/5a0f9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64208499"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="64208499"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 01:10:28 -0700
X-CSE-ConnectionGUID: FfQM4HJ7SaOljEvwIOLLnw==
X-CSE-MsgGUID: gsGXBrZtTReyIxWpf9dV0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154237068"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jul 2025 01:10:21 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Zdenek Bouska <zdenek.bouska@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net v1 1/1] igc: Fix data_meta pointer adjustment for XDP zero-copy
Date: Tue,  1 Jul 2025 16:09:55 +0800
Message-Id: <20250701080955.3273137-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unnecessary increment of the data_meta pointer to ensure the
metadata area is correctly presented to XDP program and to avoid accidental
overwriting of device-reserved metadata by XDP programs.

Previously, the data_meta pointer was incorrectly advanced when handling
hardware timestamps for XDP zero-copy frames. Since the HW timestamp is no
longer copied into a local variable, there is no need to adjust data_meta.

Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
Reported-by: Zdenek Bouska <zdenek.bouska@siemens.com>
Closes: https://lore.kernel.org/netdev/AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 686793c539f2..8362e789777e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2829,11 +2829,6 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 			ctx->rx_ts = bi->xdp->data;
 
 			bi->xdp->data += IGC_TS_HDR_LEN;
-
-			/* HW timestamp has been copied into local variable. Metadata
-			 * length when XDP program is called should be 0.
-			 */
-			bi->xdp->data_meta += IGC_TS_HDR_LEN;
 			size -= IGC_TS_HDR_LEN;
 		} else {
 			ctx->rx_ts = NULL;
-- 
2.34.1


