Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45D3DE3CE
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhHCBEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233470AbhHCBEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327863"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327863"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480141"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:51 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 16/16] samples/bpf: Show XDP hints usage
Date:   Mon,  2 Aug 2021 18:03:31 -0700
Message-Id: <20210803010331.39453-17-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An example of how to retrieve XDP hints/metadata from an XDP frame. To
get the xdp_hints struct, one can use:

$ bpftool net xdp show
  xdp:
  enp6s0(2) md_btf_id(44) md_btf_enabled(0)

To get the BTF id, and then:

$ bpftool btf dump id 44 format c > btf.h

But, in this example, to demonstrate BTF and CORE features, a simpler
struct was defined, containing the only field used by the sample.

A lowpoint is that it's not currently possible to use some CORE features
from "samples/bpf" directory, as those samples are currently built
without using "clang -target bpf". This way, it was not possible to use
"bpf_core_field_exists" macro to check, in runtime, the presence of a
given XDP hints field.
---
 samples/bpf/xdp_sample_pkts_kern.c | 21 +++++++++++++++++++++
 samples/bpf/xdp_sample_pkts_user.c |  4 +++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/xdp_sample_pkts_kern.c b/samples/bpf/xdp_sample_pkts_kern.c
index 9cf76b340dd7..9f0b0c5a6237 100644
--- a/samples/bpf/xdp_sample_pkts_kern.c
+++ b/samples/bpf/xdp_sample_pkts_kern.c
@@ -3,6 +3,7 @@
 #include <linux/version.h>
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
 
 #define SAMPLE_SIZE 64ul
 
@@ -12,16 +13,23 @@ struct {
 	__uint(value_size, sizeof(u32));
 } my_map SEC(".maps");
 
+struct xdp_hints {
+	u64 rx_timestamp;
+};
+
 SEC("xdp_sample")
 int xdp_sample_prog(struct xdp_md *ctx)
 {
+	void *meta_data = (void *)(long)ctx->data_meta;
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
+	struct xdp_hints *hints;
 
 	/* Metadata will be in the perf event before the packet data. */
 	struct S {
 		u16 cookie;
 		u16 pkt_len;
+		u64 rx_timestamp;
 	} __packed metadata;
 
 	if (data < data_end) {
@@ -41,9 +49,22 @@ int xdp_sample_prog(struct xdp_md *ctx)
 
 		metadata.cookie = 0xdead;
 		metadata.pkt_len = (u16)(data_end - data);
+		metadata.rx_timestamp = 0;
 		sample_size = min(metadata.pkt_len, SAMPLE_SIZE);
 		flags |= (u64)sample_size << 32;
 
+		if (meta_data < data) {
+			hints = meta_data;
+			/* bpf_core_field_exists doesn't work from samples/bpf,
+			 * as it is only available for "clang -target bpf", which
+			 * is not used on samples/bpf. A program that can use
+			 * the "vmlinux.h" and "clang -target btf" could use this
+			 * call to check the existence of a given field in runtime
+			 */
+			/*if (bpf_core_field_exists(hints->rx_timestamp))*/
+				metadata.rx_timestamp = BPF_CORE_READ(hints, rx_timestamp);
+		}
+
 		ret = bpf_perf_event_output(ctx, &my_map, flags,
 					    &metadata, sizeof(metadata));
 		if (ret)
diff --git a/samples/bpf/xdp_sample_pkts_user.c b/samples/bpf/xdp_sample_pkts_user.c
index 495e09897bd3..b87e0ae8eb3d 100644
--- a/samples/bpf/xdp_sample_pkts_user.c
+++ b/samples/bpf/xdp_sample_pkts_user.c
@@ -76,6 +76,7 @@ static void print_bpf_output(void *ctx, int cpu, void *data, __u32 size)
 	struct {
 		__u16 cookie;
 		__u16 pkt_len;
+		__u64 rx_timestamp;
 		__u8  pkt_data[SAMPLE_SIZE];
 	} __packed *e = data;
 	int i;
@@ -85,7 +86,8 @@ static void print_bpf_output(void *ctx, int cpu, void *data, __u32 size)
 		return;
 	}
 
-	printf("Pkt len: %-5d bytes. Ethernet hdr: ", e->pkt_len);
+	printf("Pkt len: %-5d bytes. RX timestamp: %llu Ethernet hdr: ", e->pkt_len,
+	       e->rx_timestamp);
 	for (i = 0; i < 14 && i < e->pkt_len; i++)
 		printf("%02x ", e->pkt_data[i]);
 	printf("\n");
-- 
2.32.0

