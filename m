Return-Path: <bpf+bounces-52761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476CBA48257
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965CC17A726
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48AA25E837;
	Thu, 27 Feb 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhRKfPb0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA45B25E80F;
	Thu, 27 Feb 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668159; cv=none; b=SQ60vbY3Dy1X+H9h6uHqyKLrZXeNsndp7z/IylTCZokVm3Iq9MsEVaQ6her5zv1GjeqqdTf/x3E7ymoTvDplu6sYGwYfXOxMUn1ghddwycV7ULGdOiXhpmRLkfLoM9GNVwTx/ajK7z7qz53Rh7LM4MXnI4w0NXXNRVunL7lorxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668159; c=relaxed/simple;
	bh=B+3yO58mPXLNKWSK23exJcJPPCrGftTXonjllEkm1OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZfWvqeelLeqkjXlIYWaqkGA1Qn62Xz99t301dtGqfmRdQ58rl+Jp8JXhKuqUSvfXfOSBH1ED4/+0Fe3fqsgkaBPEGLYR6HTDqeR/69sZkL33FFGlpAXkb931WCFUfb0RDaXGL1KN0V6hd1/wB4lA31UZCCGVBHmlorCXKNE9+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhRKfPb0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740668158; x=1772204158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B+3yO58mPXLNKWSK23exJcJPPCrGftTXonjllEkm1OE=;
  b=AhRKfPb0vNVqE9hRcwImlpm4QAhGCMOPAXsG1BvRuOPZtZ5s7gGXrgli
   jK0yebfRmqNF6YUBb4vtwioMD5I3a3m1Z3oTaXBLiKOWGeWC/Bdv1q4jQ
   JRkYyHEalvh/jUG6SZ2NgMb5AJp/e6LRVq8pBpvFl2W+94DobiYPVc8zA
   v42Bsl8oa0t5GCbbQhlUL/ip8ynWYYAsZ2TOkexjgqFLUvctvvc7vJSvQ
   7nW70AW5yv0onq/P5+/wlHkREx4m59eQqOtlTRcE2LAvszdxBPOLX0eTT
   0vbkKOSs70ivzcts4SkhdxibrHT1iD3kEMmEkqj4TIxy7DIqwVeRV97Rc
   Q==;
X-CSE-ConnectionGUID: 52CwQkq2RgS7Gk0UuKFRUA==
X-CSE-MsgGUID: EjRpxDKLSDOCxZEq93DRMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41480542"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41480542"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:55:57 -0800
X-CSE-ConnectionGUID: grw6SfyGT024CqUHLNb46A==
X-CSE-MsgGUID: 5XidMIstRR2nGsbJaB9+aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117541119"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:55:53 -0800
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
Subject: [PATCH bpf-next v2 0/2] selftests/xsk: Add tests for XDP tail adjustment in AF_XDP
Date: Thu, 27 Feb 2025 14:27:35 +0000
Message-Id: <20250227142737.165268-1-tushar.vyavahare@intel.com>
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

 .../selftests/bpf/progs/xsk_xdp_progs.c       |  48 +++++++
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
 tools/testing/selftests/bpf/xskxceiver.c      | 131 ++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h      |   2 +
 4 files changed, 174 insertions(+), 8 deletions(-)

-- 
2.34.1


