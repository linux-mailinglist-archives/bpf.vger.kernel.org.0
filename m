Return-Path: <bpf+bounces-33601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9399991EED8
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E3F1F22489
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E684DE2;
	Tue,  2 Jul 2024 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noIkp3Vl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753258BFA;
	Tue,  2 Jul 2024 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901144; cv=none; b=aBLMOr5q90ptb28kGSBsUtBLWx3s8CXZcw0oWfivHCk85vZreK4Q4Dp6fY79ogFJ8/qAnWUxTZMheZzd41uZ1HmqCljEi+48mstQmPcd1di4EGyoNHCRjN3Zb62aYO3wQhpCUBkFCqrXnauWA9q3/ynLwL7J1skrJ1Nav5WvObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901144; c=relaxed/simple;
	bh=eXG9fydes34Q10hYBkE+wfrlAHVCfwmffZn785d9xZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANXOE8OkHeaBNDvbBkImBfE22e0krr7y75p+xjzetcYILp9W1dB1uPhIKNkKlPn/vRHUmMHzmfiNlNxseTedesOv3YOz6T7ZrePwivtibhuyE4MztAT7ot+HlVMot+hgk1F9iYaKqkjmRnbQPt5XCi9zHXm5D251ujkpS/jsBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noIkp3Vl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719901142; x=1751437142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXG9fydes34Q10hYBkE+wfrlAHVCfwmffZn785d9xZY=;
  b=noIkp3VlHYO8kq2nQqD9LV1hKqnKNx3jJ/62YV9Bd+SuDbbWLmG9phgz
   8Md8wnbaeFrEzLP0T0pEHVfXVxNG04rF+MMYF1BXh1V7A5Uu3JSc2zDbt
   0nsOCbn4FmzmepK20bdAQKplA631euCgo3xdHcSiEuO8nxFkqRgXY/cGX
   84JUsVbDkfI7nZGLdk9bhg/FLuenTeIZOiWEVVFv1IN9N+1wEaRI552VH
   gb/5t8mvGFX+/Vrt5ZdA/DqpUgKalm8WMwuGUSjz8Dk2x+t9CRSJE+3yo
   RcgSy+R8bvWORhJTXOVTa30T7Gwg6+t7w3e7vKjrfMOPcvRbAYONgg3uF
   w==;
X-CSE-ConnectionGUID: 3RVciacBRmKqI10FDYILyg==
X-CSE-MsgGUID: K12XC09HQdCbitylxoi5Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20866600"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20866600"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:19:02 -0700
X-CSE-ConnectionGUID: Ya+VZqy8Tui8kDrkOwydNQ==
X-CSE-MsgGUID: //OgO6BLRo6Ut87pR+5WgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45919941"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:18:58 -0700
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
Subject: [PATCH bpf-next v3 1/2] selftests/xsk: Ensure traffic validation proceeds after ring size adjustment in xskxceiver
Date: Tue,  2 Jul 2024 05:59:15 +0000
Message-Id: <20240702055916.48071-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702055916.48071-1-tushar.vyavahare@intel.com>
References: <20240702055916.48071-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE test cases were
not validating Tx/Rx traffic at all due to early return after changing HW
ring size in testapp_validate_traffic().

Fix the flow by checking return value of set_ring_size() and act upon it
rather than terminating the test case there.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 2eac0895b0a1..088df53869e8 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1899,11 +1899,15 @@ static int testapp_validate_traffic(struct test_spec *test)
 	}
 
 	if (test->set_ring) {
-		if (ifobj_tx->hw_ring_size_supp)
-			return set_ring_size(ifobj_tx);
-
-	ksft_test_result_skip("Changing HW ring size not supported.\n");
-	return TEST_SKIP;
+		if (ifobj_tx->hw_ring_size_supp) {
+			if (set_ring_size(ifobj_tx)) {
+				ksft_test_result_skip("Failed to change HW ring size.\n");
+				return TEST_FAILURE;
+			}
+		} else {
+			ksft_test_result_skip("Changing HW ring size not supported.\n");
+			return TEST_SKIP;
+		}
 	}
 
 	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
-- 
2.34.1


