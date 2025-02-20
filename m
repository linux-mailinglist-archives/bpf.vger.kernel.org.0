Return-Path: <bpf+bounces-52067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AFA3D43C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2119A7A8EAA
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34801EC01E;
	Thu, 20 Feb 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp5i5WSN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7901EE7C4;
	Thu, 20 Feb 2025 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042613; cv=none; b=Ki7hCI/EUIwwzi5tBnYaxN0RCWvddpAqMXlRgrO8uTaFP/OKM/zQFBL9pdb0ouSAeoL7P0szMqVWjvq1Hhj1XKkcK98l9rw2t0GvOZE5IG6a/utoPdwrXYyvyCNm1lWV6+CUEAEdlJwkvl2e3UXUxjMD4horaTMy5FoARZVFOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042613; c=relaxed/simple;
	bh=ap06RU9lK+93Lg6AqAUmYtxQbCvi2WxR1WXqtk+05uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNOoz1o2xAp1f3x1pH75+EBfp8W3dQyENXnT9nXg3xej8A5pW++2XDQm+W8OQKud5moCK7CBAXZ5n8vUKO4Nv4OZZKGRadCDjphb1Vm+8VD7SUcRw+fO3+8QgUVm98pXybhDsnwXrQMB5vp1HQGIV6wUJ4LqHKVx+p2gZYO0WlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp5i5WSN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740042612; x=1771578612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ap06RU9lK+93Lg6AqAUmYtxQbCvi2WxR1WXqtk+05uc=;
  b=fp5i5WSNM61f11f/nPVwqJAQ74IKg9gcxJTa8Z65bztuhCUiz/b94pvh
   9Qsbf/JuCvyj75kV2wz7uDxxGO8lyTtNm8zzI3hx6HyLN8I6JQ8ba769V
   Zo07o4VV+oMLUGuCjln6cLV9z6CjcqUGl8mtIQHdmVUAg3hJw2xIrt0GT
   VQVqcXk3MkU8xtX8pIYHKeSwYYy62P8nI+xlRIAN/NcLzM5GS+s0L74Bb
   ORfezw0/I0rISFVyVSPTLm/eP66Jm5bBVUUxyKrXIuWrzIcHrEEZQZW+T
   ufxoBXXytwiHQvqulJ16uYesV7yP2WcNKckKZPODozZhJgIe1Tj7B8V4J
   Q==;
X-CSE-ConnectionGUID: /VvubdtVRp6DPz2rb4VAEg==
X-CSE-MsgGUID: 38JcGGoZQXmbFeUwEvEaBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40733518"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40733518"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:12 -0800
X-CSE-ConnectionGUID: LZK3BoBqRy2EHG8UiAlviA==
X-CSE-MsgGUID: gjLrkeyTRreDuiUtlW6hYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120084570"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:08 -0800
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
Subject: [PATCH bpf-next 3/6] selftests/xsk: Add testapp_xdp_adjust_tail function to userspace for packet tail adjustment
Date: Thu, 20 Feb 2025 08:41:44 +0000
Message-Id: <20250220084147.94494-4-tushar.vyavahare@intel.com>
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

This commit adds the testapp_xdp_adjust_tail function in the userspace
code. The function is responsible for adjusting the tail of packets using
the xsk_xdp_adjust_tail XDP program.

The function performs the following tasks:
1. Retrieves the XDP program objects (skel_rx and skel_tx) from the
   test_spec structure.
2. Finds the bpf_map for the XDP program's bss section.
3. Updates the 'count' variable in the XDP program's bss section with the
   provided adjust_value.
4. Sets the XDP program (xsk_xdp_adjust_tail) for both RX and TX
   interfaces using test_spec_set_xdp_prog.
5. Calls testapp_validate_traffic to validate the traffic after adjusting
   the packet tail.

This function allows testing and validating the XDP program's behavior when
adjusting the packet tail using the bpf_xdp_adjust_tail helper function.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 1d9b03666ee6..ff3316f6174e 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2518,6 +2518,31 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_xdp_adjust_tail(struct test_spec *test, int count)
+{
+	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
+	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	struct bpf_map *data_map;
+	int key = 0;
+
+	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
+			       skel_tx->progs.xsk_xdp_adjust_tail,
+			       skel_rx->maps.xsk, skel_tx->maps.xsk);
+
+	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
+	if (!data_map || !bpf_map__is_internal(data_map)) {
+		ksft_print_msg("Error: could not find bss section of XDP program\n");
+		return TEST_FAILURE;
+	}
+
+	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY)) {
+		ksft_print_msg("Error: could not update count element\n");
+		return TEST_FAILURE;
+	}
+
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
-- 
2.34.1


