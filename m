Return-Path: <bpf+bounces-52068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD92AA3D43F
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 10:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54917189AB2D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3A1EBFE0;
	Thu, 20 Feb 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zp9pW3s/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6F1E9B30;
	Thu, 20 Feb 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042616; cv=none; b=gV28A1kJFOvU1N/jZc1fPiGuwPPsl7qzrjeqTALq5o2CPQoSrV7JrSGdBYLnpxFOeK9TgaYQaPMhIx+QKCiOaf0Dk4VJGPI96a6nWg26BiXtq8x4p1yk7oB5FwpbcHHyL0D5lS9NrWan9LZRtsLJ4ExrqJAn3xnBp1b1LfSqses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042616; c=relaxed/simple;
	bh=vTo4jqO2u9FWy+M1kTIwSjNDnk6sQfDFNVfziDDlhYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRI9WG0g9kQrHjR4Pp3DczFKJzDLS56CZaLDofacMlRBYX4+lZACZTRTmAhIJhgQf/HVcchpUB95pDAlsYrZ3v4Su1Gr5E5/+XzqCvkGo2R2MO0tQVC5RKwA9DWtsSJZ36Iw7blF8JXOa5cW/40382yOeU50szD9UT28FJ7q4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zp9pW3s/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740042616; x=1771578616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTo4jqO2u9FWy+M1kTIwSjNDnk6sQfDFNVfziDDlhYQ=;
  b=Zp9pW3s/Kxa/EQbhFAPwqPNA43eH993gfD78+i+rP7ESqiZrokNZg1Xm
   fb+WvyF1OAmdI+lJDUo05QBu49qKQ27y39TZwQNNGTUgtrGfuy8dGSCnw
   tRo7Ru8k3FvZp0cgEvzraj32qf2jovyNH8uDjzGKgxiQ5iQKRLY5qNVH6
   HjvWwlo+8wQ6A7nQyqbsaUfFdIZkDNLdqgCxdzxFnrDN+9GDNaPOkFECd
   U1Wwt+v8GqrMMs+n6MetqvswWquLbm3JZPq4PgA6N/86DY99jjgQjaIBx
   SJsXbbKNRN/NzlH4mqpQrJygUi5XMMX/40AQ7zDjZk0nLPghx5xXsmdXn
   g==;
X-CSE-ConnectionGUID: vJOOSb6KR6y/H6l6CH4VDQ==
X-CSE-MsgGUID: j1NBPoeGT0KcfK1yyyyelA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40733532"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40733532"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:15 -0800
X-CSE-ConnectionGUID: /okReAK9TAyqzp89tPoY3g==
X-CSE-MsgGUID: Cngx8xvRQ0+17tL4INnGdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120084575"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:11 -0800
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
Subject: [PATCH bpf-next 4/6] selftests/xsk: Add support check for bpf_xdp_adjust_tail() helper in xskxceiver
Date: Thu, 20 Feb 2025 08:41:45 +0000
Message-Id: <20250220084147.94494-5-tushar.vyavahare@intel.com>
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

Add is_adjust_tail_supported function to check if the
bpf_xdp_adjust_tail() helper is supported when 'adjust_tail' is set in the
test. Look up a specific key in the bss section of the XDP program. If the
key is not found or its value is -EOPNOTSUPP, return false, indicating that
the helper is not supported.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 36 ++++++++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h |  2 ++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index ff3316f6174e..ccf35b73418b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -524,6 +524,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->nb_sockets = 1;
 	test->fail = false;
 	test->set_ring = false;
+	test->adjust_tail = false;
+	test->adjust_tail_support = false;
 	test->mtu = MAX_ETH_PKT_SIZE;
 	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
 	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
@@ -992,6 +994,31 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	return true;
 }
 
+static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
+{
+	struct bpf_map *data_map;
+	int value = 0;
+	int key = 0;
+	int ret;
+
+	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
+	if (!data_map || !bpf_map__is_internal(data_map)) {
+		ksft_print_msg("Error: could not find bss section of XDP program\n");
+		exit_with_error(errno);
+	}
+
+	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &value);
+	if (ret) {
+		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
+		return false;
+	}
+
+	/* Set the 'count' variable to -EOPNOTSUPP in the XDP program if the adjust_tail helper is
+	 * not supported. Skip the adjust_tail test case in this scenario.
+	 */
+	return value != -EOPNOTSUPP;
+}
+
 static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
 			  u32 bytes_processed)
 {
@@ -1768,8 +1795,13 @@ static void *worker_testapp_validate_rx(void *arg)
 
 	if (!err && ifobject->validation_func)
 		err = ifobject->validation_func(ifobject);
-	if (err)
-		report_failure(test);
+
+	if (err) {
+		if (test->adjust_tail && !is_adjust_tail_supported(ifobject->xdp_progs))
+			test->adjust_tail_support = false;
+		else
+			report_failure(test);
+	}
 
 	pthread_exit(NULL);
 }
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index e46e823f6a1a..67fc44b2813b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -173,6 +173,8 @@ struct test_spec {
 	u16 nb_sockets;
 	bool fail;
 	bool set_ring;
+	bool adjust_tail;
+	bool adjust_tail_support;
 	enum test_mode mode;
 	char name[MAX_TEST_NAME_SIZE];
 };
-- 
2.34.1


