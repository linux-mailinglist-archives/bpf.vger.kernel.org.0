Return-Path: <bpf+bounces-54516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA2A6B29E
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 02:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50AD1707A3
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D871BCA07;
	Fri, 21 Mar 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVZalSi0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0991C69D;
	Fri, 21 Mar 2025 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742520182; cv=none; b=Fjen16ag55uYZTCtzz48bimrUl8TS3npue4aI0guKPCImvd9UsDccQVwXg4/2trnxVK9duyQcmS9WMvt/mgf6NlemgUD2vtESeIYDEYYO+SlOHN261+n17tisIKlI2QS/96Qe6kufy40/aNxWRCHD3gTq1t2FRX/u4meleEoFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742520182; c=relaxed/simple;
	bh=Qx9upjCEqqj89CgDRgn4abPCjHUGg2vZqPB7be+0fSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SYwAIkZMmMqJi5QsX0UKW2bghPSreoT1jkFaddeBH5275FYC4o/KnAXH5QtiXmBXkMYdGHYrt9TMgc3wW0ERvRAjtOv8zOZg08SQphj4vYi7O31cFO3zlzQ+efxcBanmNPYiJuAvH7MD1xu3e6j2IqlLp7lTucVxe4CVbZ+rhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVZalSi0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742520179; x=1774056179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qx9upjCEqqj89CgDRgn4abPCjHUGg2vZqPB7be+0fSw=;
  b=cVZalSi0pcf3Yz0QYk1jOolCJ/IIVmTtSwIWZM9CBWfzEncQl67yciKa
   r3WDQCMtXnKDp93bg51z7JoogoiHcHV6rSrxH1z/c9U9l5kS/d0I1u+QH
   OBzqWrCVPNp3VrFtgbKaXEQEkqNIKcpnB5U+aBaXlFiSxOJs5B8j+rz2B
   cekMilfj2PiUbwUPUCPE8Rwaiko+PatnAgg70+1LYw66CHcLkCryVQ3Fc
   AuBdSBlOLyXVS4KBcBH31nGArEsA2LZIQQXzRpGTnzTgZ2tRTFkO2TQF7
   +smWSCMr6h4M/lfdidAyWXEsrH8tAfcqsgdcI2PenxRMyUTAM9uFn32Nc
   Q==;
X-CSE-ConnectionGUID: TewBPiEVQIufDS5B4/Ujbw==
X-CSE-MsgGUID: nDw9kdSySVCrzBIB5kVT/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43658336"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43658336"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:22:59 -0700
X-CSE-ConnectionGUID: 32o1xHxtRomcweEPcGGWFg==
X-CSE-MsgGUID: frmWgOWIQXSeDVndPKytvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123777061"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:22:54 -0700
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
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v4 0/2] selftests/xsk: Add tests for XDP tail adjustment in AF_XDP
Date: Fri, 21 Mar 2025 00:54:17 +0000
Message-Id: <20250321005419.684036-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds tests to validate the XDP tail adjustment
functionality, focusing on its use within the AF_XDP context. The tests
verify dynamic packet size manipulation using the bpf_xdp_adjust_tail()
helper function, covering both single and multi-buffer scenarios.

v1 -> v2:
1. Retain and extend stream replacement: Keep `pkt_stream_replace`
   unchanged. Add `pkt_stream_replace_ifobject` for targeted ifobject
   handling.

2. Consolidate patches: Merge patches 2 to 6 for tail adjustment tests and
   check.

v2 -> v3:
1. Introduce `adjust_value` to replace `count` for clearer communication
   with userspace.

v3 -> v4:
1. Remove `testapp_adjust_tail_common()`. [Maciej]

2. Add comments and modify code for buffer resizing logic in test cases
   (shrink/grow by specific byte sizes for testing purposes). [Maciej]

---
Patch Summary:

1. Packet stream replacement: Add `pkt_stream_replace_ifobject` to manage
   packet streams efficiently.

2. Tail adjustment tests and support check: Implement dynamic packet
   resizing in xskxceiver by adding `xsk_xdp_adjust_tail` and extend this
   functionality to userspace with `testapp_xdp_adjust_tail` for
   validation. Ensure support by adding `is_adjust_tail_supported` to
   verify the availability of `bpf_xdp_adjust_tail()`. Introduce tests for
   shrinking and growing packets using `bpf_xdp_adjust_tail()`, covering
   both single and multi-buffer scenarios when used with AF_XDP.
---

Tushar Vyavahare (2):
  selftests/xsk: Add packet stream replacement function
  selftests/xsk: Add tail adjustment tests and support check

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

 .../selftests/bpf/progs/xsk_xdp_progs.c       |  50 ++++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
 tools/testing/selftests/bpf/xskxceiver.c      | 118 ++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h      |   2 +
 4 files changed, 163 insertions(+), 8 deletions(-)

-- 
2.34.1


