Return-Path: <bpf+bounces-32517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F890EF2B
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722FE1F2268E
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5114F9F9;
	Wed, 19 Jun 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moPkI3db"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234D14F111;
	Wed, 19 Jun 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804402; cv=none; b=NsFtmu76+N6v+DSHByqUGdStAP5TStr0duKuc0QWNeQS5uEDz1rilLvX7kDuNtx2T5QP/gMTqHxUrjieUkAZTpEek3Ei3othoegFs/shtl/Dz5pelOaDLYYEOz6Ls+sLMh2K94vgwnNvJp0ik1PQCHdJvIUs92vye9gOcDPbiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804402; c=relaxed/simple;
	bh=smapOZaqNHWpq6GDLRmnPCHw4AzIsTQjqetoNtIsPFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D19dbikhXVMai5LOtWDqHAKQOuJEXcka9vvL4g+DoeM3F8XhbDtrBW6q6Nqxjm7DqMT5XUIcCmwu3Tg2rB3N4E2maGLcTzP1u7I18lo5gabxsBeuBxjcu8aEYcdcNi+dTVrvzagnecEzggpNIRalprkY9yD4l4jRQ4MghFTNiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moPkI3db; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718804401; x=1750340401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smapOZaqNHWpq6GDLRmnPCHw4AzIsTQjqetoNtIsPFM=;
  b=moPkI3dbY+QMtXe3+dzVQn0oGAjoO/kLkNKiq+UtFsa8cNI0y9tpddy6
   pM8VSs+7ld3bphqm3RVHiltzFWsKnPBVx5wyPDnY2q/K7X9jtqCfb1Vro
   rVrFuwpDun2rag2ZaNRC9CRkYYpOpbHMD1mz73jRLheiW2/2IdSTm1cfo
   9GNYk1sr047BE3RZY5Y1mrlq15UT054T70hN+AFs1KcfPqfcFjiBOzawM
   74aoORot/aF+uISYmZB5EOCkGxU0IN0zN5+xx7eBVuy2WuD53oQW6chwW
   DJ9IEULMqIxc9LTUK1/8doOw5I1PgeTR1/y4j3LyVCz55/dYBw4yGcjyN
   Q==;
X-CSE-ConnectionGUID: otlTWvbBSmKhJCb+75Ehfw==
X-CSE-MsgGUID: 6P9gO2qsSiuEMX+Mgxyp3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41146149"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41146149"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:40:01 -0700
X-CSE-ConnectionGUID: oDPIF4EbTcWo/zmtwr4OEQ==
X-CSE-MsgGUID: MtTJ/m5vQNWMfs3aiqRr5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="65167443"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 06:39:57 -0700
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
Subject: [PATCH bpf-next 1/2] selftests/xsk: Ensure traffic validation proceeds after ring size adjustment in xskxceiver
Date: Wed, 19 Jun 2024 13:20:47 +0000
Message-Id: <20240619132048.152830-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619132048.152830-1-tushar.vyavahare@intel.com>
References: <20240619132048.152830-1-tushar.vyavahare@intel.com>
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


