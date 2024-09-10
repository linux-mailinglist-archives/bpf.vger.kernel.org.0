Return-Path: <bpf+bounces-39436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EB9737C8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A7AB2447E
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B091917E4;
	Tue, 10 Sep 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLrCfCVB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2991917FF;
	Tue, 10 Sep 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972098; cv=none; b=LVAro6WOZE1mV30csHi/XFMEQyvGsdbiNUUrLXB9X2CWuj2YZu8dy5eC8y4pFReIlkQulsSG1jp1WP4HcW0Z1IUyN0NssoedCuV+lSGlkFYQOK5ndgOGTsuMYyh/m5uAEPg/Zj3rUVVd06fHEeZPPFoIPgryHfdx1TV6mkjjkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972098; c=relaxed/simple;
	bh=3qR2hYXZ3Wgt0ewP+9TFYTe4gn+0zSUHo7GvUyV7i/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4tiLseoD79uf637fJi3iTovg0thJImEHmo8i2+leXyTljOhFZrfC7VGBsp3nXK8HqL7VQrWef/pL6fUIsKUArAlLhjUy9K6NSN/2YVxUluVKVuDnPUZ5wFluYLmq3QAHYmXOCk22UQkQuua/AJeBv0nDA+8SK26dogEFKzJ70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLrCfCVB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725972097; x=1757508097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3qR2hYXZ3Wgt0ewP+9TFYTe4gn+0zSUHo7GvUyV7i/4=;
  b=JLrCfCVBaSZKbca32QGryK7U3ios9jUA4qfl6ZksVNA6PKJ5dqhOFpu1
   DjUMs9nhhHPDCt8n5imLBZ8PpFS98MZdF86oqv2P9Urw4MIlYOcBPFkfC
   eGFDWwNzdmgfJnVIbfFMbpLPJqDO733f9QJ66lgqxa6KC5woNmvKNrawL
   2WtowHpAhrfjYaAbsO3YU5PqoHm2KDMc2SA5bAatC/05GcsGlBtPHeBaS
   AOUARRi/kAe4+r5ZL9CDAg1Bx8MjRMEeexVEWRCE6AwcLHWHulOyVSt3/
   DIQFRCpvhX6i6YRERFl3Hhlt/+ISBM7dDfw1AJiXT4/Pm4NWU02fwXC45
   w==;
X-CSE-ConnectionGUID: id1rmDCQS0CtV3cY1YMEMA==
X-CSE-MsgGUID: 7HkntKPJSCOFTc+8U/h9Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28606086"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="28606086"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:41:35 -0700
X-CSE-ConnectionGUID: 5Xpyh1n3SGCvdRNgKK753g==
X-CSE-MsgGUID: tyhg5HQCTwS4kCNluNgoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71415350"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa005.fm.intel.com with ESMTP; 10 Sep 2024 05:41:33 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 bpf-next] selftests: xsk: read current MAX_SKB_FRAGS from sysctl knob
Date: Tue, 10 Sep 2024 14:41:29 +0200
Message-Id: <20240910124129.289874-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, xskxceiver assumes that MAX_SKB_FRAGS value is always 17
which is not true - since the introduction of BIG TCP this can now take
any value between 17 to 45 via CONFIG_MAX_SKB_FRAGS.

Adjust the TOO_MANY_FRAGS test case to read the currently configured
MAX_SKB_FRAGS value by reading it from /proc/sys/net/core/max_skb_frags.
If running system does not provide that sysctl file then let us try
running the test with a default value.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---

v2: instead of failing the test case when reading frag value from sysctl
    file did not succeed, use a default count and proceed with test [Magnus]

 tools/testing/selftests/bpf/xskxceiver.c | 43 +++++++++++++++++++++---
 tools/testing/selftests/bpf/xskxceiver.h |  1 -
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 92af633faea8..11f047b8af75 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -325,6 +325,25 @@ static bool ifobj_zc_avail(struct ifobject *ifobject)
 	return zc_avail;
 }
 
+#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
+static unsigned int get_max_skb_frags(void)
+{
+	unsigned int max_skb_frags = 0;
+	FILE *file;
+
+	file = fopen(MAX_SKB_FRAGS_PATH, "r");
+	if (!file) {
+		ksft_print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
+		return 0;
+	}
+
+	if (fscanf(file, "%u", &max_skb_frags) != 1)
+		ksft_print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
+
+	fclose(file);
+	return max_skb_frags;
+}
+
 static struct option long_options[] = {
 	{"interface", required_argument, 0, 'i'},
 	{"busy-poll", no_argument, 0, 'b'},
@@ -2245,13 +2264,24 @@ static int testapp_poll_rxq_tmout(struct test_spec *test)
 
 static int testapp_too_many_frags(struct test_spec *test)
 {
-	struct pkt pkts[2 * XSK_DESC__MAX_SKB_FRAGS + 2] = {};
+	struct pkt *pkts;
 	u32 max_frags, i;
+	int ret;
 
-	if (test->mode == TEST_MODE_ZC)
+	if (test->mode == TEST_MODE_ZC) {
 		max_frags = test->ifobj_tx->xdp_zc_max_segs;
-	else
-		max_frags = XSK_DESC__MAX_SKB_FRAGS;
+	} else {
+		max_frags = get_max_skb_frags();
+		if (!max_frags) {
+			ksft_print_msg("Couldn't retrieve MAX_SKB_FRAGS from system, using default (17) value\n");
+			max_frags = 17;
+		}
+		max_frags += 1;
+	}
+
+	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	if (!pkts)
+		return TEST_FAILURE;
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 
@@ -2281,7 +2311,10 @@ static int testapp_too_many_frags(struct test_spec *test)
 	pkts[2 * max_frags + 1].valid = true;
 
 	pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2);
-	return testapp_validate_traffic(test);
+	ret = testapp_validate_traffic(test);
+
+	free(pkts);
+	return ret;
 }
 
 static int xsk_load_xdp_programs(struct ifobject *ifobj)
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 885c948c5d83..e46e823f6a1a 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -55,7 +55,6 @@
 #define XSK_UMEM__LARGE_FRAME_SIZE (3 * 1024)
 #define XSK_UMEM__MAX_FRAME_SIZE (4 * 1024)
 #define XSK_DESC__INVALID_OPTION (0xffff)
-#define XSK_DESC__MAX_SKB_FRAGS 18
 #define HUGEPAGE_SIZE (2 * 1024 * 1024)
 #define PKT_DUMP_NB_TO_PRINT 16
 #define RUN_ALL_TESTS UINT_MAX
-- 
2.34.1


