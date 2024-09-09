Return-Path: <bpf+bounces-39319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B2971C2B
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FEB1C223A4
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8471BA278;
	Mon,  9 Sep 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSLQYJUl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C501B3F23;
	Mon,  9 Sep 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891107; cv=none; b=UQD4Tm3LugTtQwGjoGYQ9b2sQilnWrSQzB85qxqHnmMQvzXfClsefjUAobxcDNuYZvBnUw2vza2HNJjtdV05piWv9feoDryqaaamfGFvbwjobARxxopDpgerybKVzXW/rWZho6ATr/sJ9mPxs3GK6zKc2+iqAIwie8j3BJy1i20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891107; c=relaxed/simple;
	bh=23oZwDhbdCQqpo72g74qTnX1DdfPshP6HhiuWn4ZdOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IZNRmiiM0KgrarFP/UFLXqAwYHHh6LbQNbYlK+/7hbLYmuXrSPEi+2AHxpV6m/YkN/F7wNEHVuVITYPhgMPEid0zqUxO+xvgh7LHBW5blQZwCqw0HhXy4teXrwB7lOR08OnQjfCaOVU03X9DtOixD3VOivGlUklDdxt91jCREZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSLQYJUl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725891105; x=1757427105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=23oZwDhbdCQqpo72g74qTnX1DdfPshP6HhiuWn4ZdOE=;
  b=LSLQYJUlaApB8eT5m5IwXqGvxHPp9taTd8KC9O4KUOqmZUr6buxf5NmP
   n+AM9Q7uYYgNBAzTgiKqE/6Ju9LsPxdYwnoN0iOKjm8zHEj+R8GAUBeUN
   KqJrVrYtuRjiGxVTxCHol6b9eOF/Kq2DV/IbuMAeReiiSQ91I/vRSsXfn
   r7WgHRqE8sxPuRt92jLaDgkE7lEfCf9wBjeOfEZz68tUnioPLLBiqYs7L
   FYaVl6b3uGSGXczMfn3ny3bKL8oelSq2zFyrL3lYUdM2eosglYX67rpT8
   dxuivNb2w8XQnC0FtF5TkBrmrf70PPwDZKGk+Pd2MI1A1sJj5yvWOZ8La
   Q==;
X-CSE-ConnectionGUID: BBuLm+gHSiSyCHPKSyYiJg==
X-CSE-MsgGUID: LPjecEUcSaCZgtKyHoMymw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24782702"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24782702"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 07:11:45 -0700
X-CSE-ConnectionGUID: fv2J4nK5QiiIc4s+/qlwZA==
X-CSE-MsgGUID: bRc2KOZhRVK59to2BM7oyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="104138052"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 09 Sep 2024 07:11:43 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next] selftests: xsk: read current MAX_SKB_FRAGS from sysctl knob
Date: Mon,  9 Sep 2024 16:11:10 +0200
Message-Id: <20240909141110.284967-1-maciej.fijalkowski@intel.com>
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

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 41 +++++++++++++++++++++---
 tools/testing/selftests/bpf/xskxceiver.h |  1 -
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 92af633faea8..595b6da26897 100644
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
@@ -2245,13 +2264,22 @@ static int testapp_poll_rxq_tmout(struct test_spec *test)
 
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
+		if (!max_frags)
+			return TEST_FAILURE;
+		max_frags += 1;
+	}
+
+	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	if (!pkts)
+		return TEST_FAILURE;
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 
@@ -2281,7 +2309,10 @@ static int testapp_too_many_frags(struct test_spec *test)
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


