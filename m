Return-Path: <bpf+bounces-52066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B32A3D43E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 10:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7833B727C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BA61EF09A;
	Thu, 20 Feb 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvRTnhTa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A471EEA57;
	Thu, 20 Feb 2025 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042610; cv=none; b=ciYyIIXz9KWHbGqpPfAQozXHJNtS667Qin8A3rGwjhBLihrcL8R7G7frYkyzFxKSpSMZAfttL8a6As7fNIp0SOPi5/oAaXHlkxOo9h6Fhyc1vN08soEwvV2HdRe5jdlLb0BwD6N7BxKGnL/3G22HU0vYOlut+FQhlYHrssDXNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042610; c=relaxed/simple;
	bh=lum8LUwQY8cn20WEhhkEiPaz8vRPQuWHKH2mHyC2354=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLl7+Rncljgu/f+IL/r9MX68v5RCc6GMApdj+jaF+hwnObedPhepXtZFnsZn2ZgjAZmY3WJAdlSp4BQFkAyOPJv6P1alQwDuabwAWzDPV3aQfyaNn+NZisr2pPFVobIpVThcduWcy1ec4FbSTqgE0Wd1pKhW7WDFJz2DtpIuZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvRTnhTa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740042609; x=1771578609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lum8LUwQY8cn20WEhhkEiPaz8vRPQuWHKH2mHyC2354=;
  b=AvRTnhTamsHk4kNyvjjLLh/rVoKZtswiwObm4mAZOu5nKy1u+4OBHGUk
   9Gk1ZPTXvaElZVJJJ9p2yIUszzmNcD84m6IVAhW5RqyrENqg4X+1ghJKk
   olPEr3RMryD5fOi44cKBuyqcIG4x4vczWvyTZFZpVzQZNq3b4R/RCpaPx
   mKY2N+yfRs8u+cRN8zSH2JXVqkGYmeiBG/+jnD/9JDuHp7t82Vruqm/sv
   i7PFYxYCx5b662eJCwPWmDADV761tDbFMrxAwRpMpUrouIpDx0MyTipeQ
   iJBvb8fC9SKH4bxRc9vtGLLi/TXLlIBns1UVypNR08p2sTiun2OZkFFJ+
   A==;
X-CSE-ConnectionGUID: sLTtBWd7S6Wg2G2T2XOKWA==
X-CSE-MsgGUID: 19s7sW6TTMq/lHoA4JB3Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40733491"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40733491"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:08 -0800
X-CSE-ConnectionGUID: UsZkltYqRACt6a15BunG6w==
X-CSE-MsgGUID: +jFibForRq+CwCHc67c3Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120084560"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:04 -0800
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment functionality to XDP
Date: Thu, 20 Feb 2025 08:41:43 +0000
Message-Id: <20250220084147.94494-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220084147.94494-1-tushar.vyavahare@intel.com>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new function, xsk_xdp_adjust_tail, within the XDP program to
adjust the tail of packets. This function utilizes bpf_xdp_adjust_tail to
modify the packet size dynamically based on the 'count' variable.

If the adjustment fails, the packet is dropped using XDP_DROP to ensure
processing of only correctly modified packets.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/progs/xsk_xdp_progs.c       | 48 +++++++++++++++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |  1 +
 2 files changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index ccde6a4c6319..2e8e2faf17e0 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -4,6 +4,8 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/errno.h>
 #include "xsk_xdp_common.h"
 
 struct {
@@ -70,4 +72,50 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
 	return bpf_redirect_map(&xsk, idx, XDP_DROP);
 }
 
+SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
+{
+	__u32 buff_len, curr_buff_len;
+	int ret;
+
+	buff_len = bpf_xdp_get_buff_len(xdp);
+	if (buff_len == 0)
+		return XDP_DROP;
+
+	ret = bpf_xdp_adjust_tail(xdp, count);
+	if (ret < 0) {
+		/* Handle unsupported cases */
+		if (ret == -EOPNOTSUPP) {
+			/* Set count to -EOPNOTSUPP to indicate to userspace that this case is
+			 * unsupported
+			 */
+			count = -EOPNOTSUPP;
+			return bpf_redirect_map(&xsk, 0, XDP_DROP);
+		}
+
+		return XDP_DROP;
+	}
+
+	curr_buff_len = bpf_xdp_get_buff_len(xdp);
+	if (curr_buff_len != buff_len + count)
+		return XDP_DROP;
+
+	if (curr_buff_len > buff_len) {
+		__u32 *pkt_data = (void *)(long)xdp->data;
+		__u32 len, words_to_end, seq_num;
+
+		len = curr_buff_len - PKT_HDR_ALIGN;
+		words_to_end = len / sizeof(*pkt_data) - 1;
+		seq_num = words_to_end;
+
+		/* Convert sequence number to network byte order. Store this in the last 4 bytes of
+		 * the packet. Use 'count' to determine the position at the end of the packet for
+		 * storing the sequence number.
+		 */
+		seq_num = __constant_htonl(words_to_end);
+		bpf_xdp_store_bytes(xdp, curr_buff_len - count, &seq_num, sizeof(seq_num));
+	}
+
+	return bpf_redirect_map(&xsk, 0, XDP_DROP);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
index 5a6f36f07383..45810ff552da 100644
--- a/tools/testing/selftests/bpf/xsk_xdp_common.h
+++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
@@ -4,6 +4,7 @@
 #define XSK_XDP_COMMON_H_
 
 #define MAX_SOCKETS 2
+#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
 
 struct xdp_info {
 	__u64 count;
-- 
2.34.1


