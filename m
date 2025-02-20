Return-Path: <bpf+bounces-52070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C5A3D444
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA81B189DC7D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA351EE03B;
	Thu, 20 Feb 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoMCbTxk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631571EA7EA;
	Thu, 20 Feb 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042623; cv=none; b=F3VnsoRWcDQo6pKrg8aHEtM52T//puHSPXfJL3qV6zKZVR4BFsG5CWd35qKnH7V5wT2pU3ridciVwLj/tjaj38K5LhcjQChcP99quu+Dtdmua1MIu8rEOamOu07snCtiCZkhcUk86KaOpQlQX5dd1s4KwAat1gXffkkWB/OUnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042623; c=relaxed/simple;
	bh=KXJG1gcD6dEpOZizSd+f6lNxkAX7x7A5ASaYgh4OlhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6k/YOzzbPRv31Te7xhglrZoqFT68krsyvzDXqOBRE6wHxKp64PwgsWyDd9ASeTfnhIe4uf0dlfbqGEsRNq3+hb9DMmKKvC+sWfEAmuKDS1W2KWsxaLAPEbEE/ER3DhduAf6iA696xPOEGR5+N9o55vyQVTqqcrUvFT/ZX+Euh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoMCbTxk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740042623; x=1771578623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXJG1gcD6dEpOZizSd+f6lNxkAX7x7A5ASaYgh4OlhY=;
  b=FoMCbTxkmmD4fgUhRBFamQV2NZ0UMTpiAyRWoPuUi5AUVlEQSfACucxO
   Cwxyx329vIHNzmgPipvISTRzLNu1mZz4QkTqJvSFjjz6ZqIf+9u0PYbYB
   h4wAJxeWRYpLsgBSS1GPKloimcgmY5oNa2+MNTUUGVbOPeSKkpu9ugHU3
   MUE1wXV3E/pNY9dkyHq5OYHcDhxMVxI5phutbE82hlbDhus/D4yajy0q1
   xxT6TvLI3+MY8h8B2X1oqo4LlpUPzcFlLv+2zhkXn8AM6aOGKb7K0FujY
   gAowqWEONJeg+THYGuRlgnbAZozC/kYZu/JPzRvwWDsC4c8SGLlSymNNV
   Q==;
X-CSE-ConnectionGUID: r7yc3/wOTK+DzOx/mZNZSw==
X-CSE-MsgGUID: 5Ex332JoQf+AUo98e3q8iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40733549"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40733549"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:23 -0800
X-CSE-ConnectionGUID: EV+HLZuAS1irpmB2g6ibSQ==
X-CSE-MsgGUID: ksRbIP7kQv65pRKpPBt9fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120084585"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:19 -0800
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
Subject: [PATCH bpf-next 6/6] selftests/xsk: Add packet resizing tests with bpf_xdp_adjust_tail for AF_XDP
Date: Thu, 20 Feb 2025 08:41:47 +0000
Message-Id: <20250220084147.94494-7-tushar.vyavahare@intel.com>
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

Add packet resizing tests using the bpf_xdp_adjust_tail()function within
the AF_XDP framework. Implement testapp_adjust_tail_common() to handle
common logic for packet resizing tests, streamlining the testing process.
Allow setting MTU to MAX_ETH_JUMBO_SIZE for specific tests.

Implement testapp_adjust_tail_shrink() and testapp_adjust_tail_shrink_mb()
to test shrinking packets, including multi-buffer scenarios, under AF_XDP.
Implement testapp_adjust_tail_grow() and testapp_adjust_tail_grow_mb() to
test growing packets within the AF_XDP context, utilizing the common logic
function for consistency and efficiency.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 52ce0217d3d5..36f32b7ef31d 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2600,6 +2600,34 @@ static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
 	return 0;
 }
 
+static int testapp_adjust_tail_common(struct test_spec *test, int adjust_value, u32 len,
+				      bool set_mtu)
+{
+	if (set_mtu)
+		test->mtu = MAX_ETH_JUMBO_SIZE;
+	return testapp_adjust_tail(test, adjust_value, len);
+}
+
+static int testapp_adjust_tail_shrink(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE, false);
+}
+
+static int testapp_adjust_tail_shrink_mb(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, -4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
+}
+
+static int testapp_adjust_tail_grow(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, 4, MIN_PKT_SIZE, false);
+}
+
+static int testapp_adjust_tail_grow_mb(struct test_spec *test)
+{
+	return testapp_adjust_tail_common(test, 4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2706,6 +2734,10 @@ static const struct test_spec tests[] = {
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
 	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
+	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
+	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
+	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
+	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
 	};
 
 static void print_tests(void)
-- 
2.34.1


