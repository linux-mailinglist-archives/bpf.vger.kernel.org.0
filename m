Return-Path: <bpf+bounces-52069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E1A3D441
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 10:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECDD17973B
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09281EE002;
	Thu, 20 Feb 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTYUWDJh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA501F03C7;
	Thu, 20 Feb 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042620; cv=none; b=Mw3leyzT8jj/LevjdZNKa2DN8ZaavKZBt61aEybney8uLV/rhFMF+BOpHevcm5vlkm0yafE/aal8Ar2T+yT6q9s2umlko/R6fWJF0u+/61m++WdI03+AwtYsvzhAWN8Lg+KJXtbtFoTM0MTMfLbdPTJlQyX/VXuiHB+OU9uAWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042620; c=relaxed/simple;
	bh=oaNG+MnBFlX2IjQboZYU9Xa0t64UQTXamM3hMilbGLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOb8ykQ4z/AhkY8rFjjHDe1dP6zie+ODu3w3/wfqgpTfkGcj1QSNUCymmj3FT/ipXw7GlzA7wE53dtA8cQtY8kyVuIXqm3gRFpF8fhKwpbVdT8/4MaMOebVshOmaAHMo9p+jIRn/Q4J+8qid6fwjgf+ddaBMUqxfubr2ZuThVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTYUWDJh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740042619; x=1771578619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oaNG+MnBFlX2IjQboZYU9Xa0t64UQTXamM3hMilbGLk=;
  b=bTYUWDJhdG4+65oQAwCVwvY7p/bVg2BbIKV0s4skDlOZbCgTmZti5uhA
   1B7+E/5z9AAs/DikDS4sxs1c0HUWcGHW8tuK5TKphJ2q3qJGtGzzo4kSK
   +Z1s8IYjSMKLSwL3lx0bE50zEdcOij38mn0ZV4av20+NRhtMFty1Klz4b
   AJfnbtcxGpNaaTAhujleSWOVSz/K3tunw77FwKPJD5Bg6+90z1S7huUgN
   FVrBZnm8ZvlagNs198MCpvmOSE7MJIC3yWgtha82uIIMgUW62YpjeIetd
   KbfVCx8ZxV20MoqVm0k2FKnmL6NSUiZN8db6CFYAUTcGy8VnKuE+0uV+v
   A==;
X-CSE-ConnectionGUID: yqWhADG5T0aOiB5OfvtbPw==
X-CSE-MsgGUID: aB1VxxrLRvOdRP1GAtm1zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40733542"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40733542"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:19 -0800
X-CSE-ConnectionGUID: q8yh1Ze4QIarKmC02uCY0g==
X-CSE-MsgGUID: 1nXxnU0wQH2IdiMhbEl8IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120084581"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:15 -0800
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
Subject: [PATCH bpf-next 5/6] selftests/xsk: Implement packet resizing test with bpf_xdp_adjust_tail
Date: Thu, 20 Feb 2025 08:41:46 +0000
Message-Id: <20250220084147.94494-6-tushar.vyavahare@intel.com>
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

Implement a packet resizing test using the bpf_xdp_adjust_tail() function.
Add the testapp_adjust_tail function to test packet resizing capabilities.

Replace packet streams for both transmit and receive with adjusted lengths.
Include logic to skip the test if bpf_xdp_adjust_tail is not supported.
Update the test framework to handle various packet resizing scenarios.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index ccf35b73418b..52ce0217d3d5 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2575,6 +2575,31 @@ static int testapp_xdp_adjust_tail(struct test_spec *test, int count)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
+{
+	u32 pkt_cnt = DEFAULT_BATCH_SIZE;
+	int ret;
+
+	test->adjust_tail_support = true;
+	test->adjust_tail = true;
+	test->total_steps = 1;
+
+	pkt_stream_replace(test->ifobj_tx, pkt_cnt, pkt_len);
+	pkt_stream_replace(test->ifobj_rx, pkt_cnt, pkt_len + value);
+
+	ret = testapp_xdp_adjust_tail(test, value);
+	if (ret)
+		return ret;
+
+	if (!test->adjust_tail_support) {
+		ksft_test_result_skip("%s %sResize pkt with bpf_xdp_adjust_tail() not supported\n",
+				      mode_string(test), busy_poll_string(test));
+	return TEST_SKIP;
+	}
+
+	return 0;
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
-- 
2.34.1


