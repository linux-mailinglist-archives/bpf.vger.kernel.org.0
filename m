Return-Path: <bpf+bounces-48906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36818A117BC
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 04:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412CD166C43
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46222DFBB;
	Wed, 15 Jan 2025 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXoOw39C"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C46AA1;
	Wed, 15 Jan 2025 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911381; cv=none; b=RMLwxIt1uYtZK7FlmB62TM6QiwR9XLpRQdteixdXW9b0epsLA3qmFvO7y3Te5z+Jm0M3myJow9KnZ8KWNRHU2oUdN4bI2hl+13KPKiHge5965SZwtTO4MxUOZsF80kGLR/ZVGU8Pnf76YlqJCqrhWhTj93kKsxvEIjGvD94PLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911381; c=relaxed/simple;
	bh=Tca4XH1RiY/74FH6duaTmwocup7M/EKjp0h466Y8NjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8nk7jX/ZfSz/7VzZh7sze3WPrw6Grexvs0UkudlzQPFSVQJRu5xriRCZmT5MoIjbYEAi9b4JzIRzv1EHqlouuHeYJBd1+mn9GLnPfhOxvBXVrM48swsjhBFVnHR3f4j+0K4Bv9H+qEReUuZA52CV0zsG7B9VfnWqvuGYOv1ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXoOw39C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736911380; x=1768447380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tca4XH1RiY/74FH6duaTmwocup7M/EKjp0h466Y8NjQ=;
  b=jXoOw39CEOcmi30An9L246R6zaFN6+OYL976VuESGra4/5ORsHjoOqsQ
   CMHXGgL2V/hwFIHFOOHfr0hnLYBmdBG0Wazmsmwc47wS4ertEndipJvL6
   cWLm4bYxXs1kI9MmJEeSLjcYjNsXAsVE52+0A10+cW1quROIr2BrxzYUX
   WvsNw1B5AcojjeV+O1Zvewxsu0QptXM00yShUcnQ7y/ucQ1pEoPWEmyxK
   qVZ2Mr/UWM8MOZlfLl35ObYh/fR4RdCwCXt6Lf4MwS+/IP+t7iZAfGO9L
   +hXDOuVxnTqq5qvSi6KpcoWn8ZVbgFp3ABjloimZEn50kO3m0mxx8mZck
   Q==;
X-CSE-ConnectionGUID: 4P2pCfY+S4GPnMhPVFCl3g==
X-CSE-MsgGUID: 3D6w6xjOTDque+qCWcGD3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40997407"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="40997407"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 19:22:59 -0800
X-CSE-ConnectionGUID: A/SXHqtqQG6YzkuRjkgwSg==
X-CSE-MsgGUID: pfcvW7p9ST6cGKT97NfshQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105593665"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa009.fm.intel.com with ESMTP; 14 Jan 2025 19:22:55 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 1/1] tools: Sync if_xdp.h uapi tooling header
Date: Wed, 15 Jan 2025 11:22:48 +0800
Message-Id: <20250115032248.125742-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vishal Chourasia <vishalc@linux.ibm.com>

Sync if_xdp.h uapi header to remove following warning:

Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs
from latest version at 'include/uapi/linux/if_xdp.h'

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Cc: <stable@vger.kernel.org> # 6.8
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
RFC: https://patchwork.kernel.org/project/netdevbpf/patch/Z4TjzzB8NSnTy_Wa@linux.ibm.com/
---
 tools/include/uapi/linux/if_xdp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 2f082b01ff22..42ec5ddaab8d 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -117,12 +117,12 @@ struct xdp_options {
 	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
 
 /* Request transmit timestamp. Upon completion, put it into tx_timestamp
- * field of union xsk_tx_metadata.
+ * field of struct xsk_tx_metadata.
  */
 #define XDP_TXMD_FLAGS_TIMESTAMP		(1 << 0)
 
 /* Request transmit checksum offload. Checksum start position and offset
- * are communicated via csum_start and csum_offset fields of union
+ * are communicated via csum_start and csum_offset fields of struct
  * xsk_tx_metadata.
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
-- 
2.34.1


