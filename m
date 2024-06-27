Return-Path: <bpf+bounces-33223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF3F919E6D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 06:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E20B24266
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 04:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5121BF24;
	Thu, 27 Jun 2024 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yg0rMFFU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE11B285;
	Thu, 27 Jun 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719464119; cv=none; b=iGAf5N/4GWNIfOyyChVg4xBcd8ERkp4/I7x9fN58y1AlCWojYUAThVg6KmAl6S4BeUbzfv0W1nJF58/AEldcHILwZAu+e/0+OkQoDYCXxSKLgEPOdCvoYT9f28jS39X1qvAjKdu7ZUPsNSs8qLphc2dBMUWFp2j1zMzl24TYQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719464119; c=relaxed/simple;
	bh=q6uqEbADZxu+0ilyVpM4YB3ReUNiEIK5MfTZIiK6HLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Djrl5EKbDQRinFhpDMjHFgoxUtY6L3yNEarGGSXQAxC+fA4iqQ0M6LfW/ldlGibYGEyGZJyIjyflmDwQH5lmxYkzqw6eW8umecImYCP4/nYs5pLmvT9VQFnmeI8JqmIao+1pOqoHsJmh2Zeqn3Bz0rhAiv9hnJnqtE5gqsTLvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yg0rMFFU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719464117; x=1751000117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6uqEbADZxu+0ilyVpM4YB3ReUNiEIK5MfTZIiK6HLU=;
  b=Yg0rMFFUlnYJmLugTk+gD0xs5dkokmgp4ucwiUmE33Pp/4KOtYI5LT5r
   5PTr92ymnuS2SPXmJGHBS/KJVBqVGGmKrGy217DN6k7fPc2VOoYGl/ikw
   HcWat/aXo4RP7dEp67nmWAEZSwctNvId6xCeE9h+JJpGZKUrostzYBDK9
   KTyfD5HvvcqqeWkSEUl9HBxQ6IvvrpuWUiXYmqAFzd/Xc/6f5oqJ7z9pj
   AHsUQYZplR45hm/Ct3DwaQEDyt00fig6lnkHa6c8JY6UId0nB7j450+aQ
   LOrhgtnhlgFvjbzX6oBRJqaSrjDMyghTDHLTQ8co61pRyCGdsNnFcVmAW
   g==;
X-CSE-ConnectionGUID: muXgbVSPRqS7DpD5M1uSwQ==
X-CSE-MsgGUID: O1fPCW54T76aIDhxCDRLCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27966810"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27966810"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:55:16 -0700
X-CSE-ConnectionGUID: fhXDxdHcSZiRFOI4dy9yAw==
X-CSE-MsgGUID: VAB+ivtdRg+bvTDebkE0dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="49210008"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:55:05 -0700
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
Subject: [PATCH bpf-next v2 1/2] selftests/xsk: Ensure traffic validation proceeds after ring size adjustment in xskxceiver
Date: Thu, 27 Jun 2024 04:35:47 +0000
Message-Id: <20240627043548.221724-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627043548.221724-1-tushar.vyavahare@intel.com>
References: <20240627043548.221724-1-tushar.vyavahare@intel.com>
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

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

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


