Return-Path: <bpf+bounces-16805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F5806065
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F74282097
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510F6D1A1;
	Tue,  5 Dec 2023 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/OMiykf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E11AA;
	Tue,  5 Dec 2023 13:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810694; x=1733346694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFIEc+Yvqkty5GlVFkjBKio/4XCiyEws/++M7IFgm/A=;
  b=j/OMiykfVucLM/ev2cZOor14UkkQR9KxIE5rr06wkwCblAidgHGejZmv
   P/toC1///TVBugf3OASycWrqO8FJ/m8y1OyOLUvgWeVVTxG1gjYw8G/Ni
   wGNQd1l6qfn8cbOLU8YW1SAZ6iS6noP/TzppUHftpqk+7Q8yUxipiwFVw
   x6bauNKfA8g25giuFPhIJGg2CYbOXwObz1/2LU5oMefQ9HxbuX0y7sd88
   i4TfHPORIpQGo4gqjzL82BBGa/NDpHQMDlO/YX524cC7O13xd+Omus2ta
   Dry4ZOrr7uwTqOlpZ26ZYFT/mSLAC0u6Hg+ieNoUoWmAOzOHuZhO2RkI/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392827543"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="392827543"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764464726"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="764464726"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 13:11:27 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0BBCB3433C;
	Tue,  5 Dec 2023 21:11:24 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v8 15/18] selftests/bpf: Allow VLAN packets in xdp_hw_metadata
Date: Tue,  5 Dec 2023 22:08:44 +0100
Message-ID: <20231205210847.28460-16-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205210847.28460-1-larysa.zaremba@intel.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make VLAN c-tag and s-tag XDP hint testing more convenient
by not skipping VLAN-ed packets.

Allow both 802.1ad and 802.1Q headers.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/progs/xdp_hw_metadata.c | 10 +++++++++-
 tools/testing/selftests/bpf/xdp_metadata.h          |  8 ++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index f6d1cc9ad892..8767d919c881 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -26,15 +26,23 @@ int rx(struct xdp_md *ctx)
 {
 	void *data, *data_meta, *data_end;
 	struct ipv6hdr *ip6h = NULL;
-	struct ethhdr *eth = NULL;
 	struct udphdr *udp = NULL;
 	struct iphdr *iph = NULL;
 	struct xdp_meta *meta;
+	struct ethhdr *eth;
 	int err;
 
 	data = (void *)(long)ctx->data;
 	data_end = (void *)(long)ctx->data_end;
 	eth = data;
+
+	if (eth + 1 < data_end && (eth->h_proto == bpf_htons(ETH_P_8021AD) ||
+				   eth->h_proto == bpf_htons(ETH_P_8021Q)))
+		eth = (void *)eth + sizeof(struct vlan_hdr);
+
+	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021Q))
+		eth = (void *)eth + sizeof(struct vlan_hdr);
+
 	if (eth + 1 < data_end) {
 		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
 			iph = (void *)(eth + 1);
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 938a729bd307..6664893c2c77 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -9,6 +9,14 @@
 #define ETH_P_IPV6 0x86DD
 #endif
 
+#ifndef ETH_P_8021Q
+#define ETH_P_8021Q 0x8100
+#endif
+
+#ifndef ETH_P_8021AD
+#define ETH_P_8021AD 0x88A8
+#endif
+
 struct xdp_meta {
 	__u64 rx_timestamp;
 	__u64 xdp_timestamp;
-- 
2.41.0


