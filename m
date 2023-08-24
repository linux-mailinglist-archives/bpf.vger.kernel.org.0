Return-Path: <bpf+bounces-8512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7277878CE
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2F51C20DAB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642EB1DDF8;
	Thu, 24 Aug 2023 19:34:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325171DDEA;
	Thu, 24 Aug 2023 19:34:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7461B0;
	Thu, 24 Aug 2023 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905664; x=1724441664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/bVUCVzI7ISJNqobMVC1syQcqj3ccgVlhj7g4HTrk/Q=;
  b=H7XE50jPHA0fdRryTPMo5m9dqvlR2BJn94Hy4A1gCZNK2wzO/+wQS8Z+
   DT0Ylf3EQSfbHRbR1d7HPMtR4h1Pi9BfAsc6SWzNTWLGl7Hp2jfj00ZDC
   IrlfSD2HEk30O/DRkEatnv5iaHKJttKGOaDcUl7b82FMIQ1LwWO/L0l9b
   nKvJzgPtUGdfPHrEY5aYfstJD0v8H/iZ1wF0J09dxgE7owf4y6BiJ6lnI
   vF8g7y5ObN4oJzZAwM7iTG2NVic+wBA34FZzE/vYsit5xAtZNlukE3j0j
   xBXHYXe5dJ3wk6jEt2GWB6hkUNmiOus3BzzPNkFXAOBv5S6qmN3OFDzEJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354865365"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354865365"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860830550"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860830550"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 12:34:17 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B4CFC332C9;
	Thu, 24 Aug 2023 20:34:15 +0100 (IST)
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
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [RFC bpf-next 14/23] selftests/bpf: Allow VLAN packets in xdp_hw_metadata
Date: Thu, 24 Aug 2023 21:26:53 +0200
Message-ID: <20230824192703.712881-15-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make VLAN c-tag and s-tag XDP hint testing more convenient
by not skipping VLAN-ed packets.

Allow both 802.1ad and 802.1Q headers.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/progs/xdp_hw_metadata.c | 10 +++++++++-
 tools/testing/selftests/bpf/xdp_metadata.h          |  8 ++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index b2dfd7066c6e..63d7de6c6bbb 100644
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


