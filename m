Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D16BCE74
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 12:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCPLho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 07:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCPLhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 07:37:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2F7C3CE;
        Thu, 16 Mar 2023 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678966639; x=1710502639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q3tc4GYyiOU2uNgooS6P06z+EYUuo4vPnkgkpRpdBNI=;
  b=QsKq0t16YCaK/nzD1pqEgMFFza1HZlxPt1p/Nz0MF1QnpKGvKa9L30I1
   iH4fXbRxyipIWmREfnrp0oaupwiROHlVzLz94nSKQ2k2Y1QS550Cj/PcJ
   PbdyNfP5QvUFxJdtSwWSY7ZLC4mfdrRJUoT8iFgoMUbiMoMggd3T6SBba
   r7Dp+D6SKp30OA/HlcODUZJaWkrArOyXBkbE5LWvDgmk9v68wDFdRbodq
   Rk9IK5q+l4AAxjdqTmkPqI4KAz4lYLy+sq3Zzhffu9rUZ/cN8cpoTJfZ4
   ODIyXr1Ha/8mSsDmpiJkovAAwa/1G7L/VnKvtj6V6nQeUwLEqhQKk2c6l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340320585"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="340320585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 04:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="1009190173"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009190173"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2023 04:37:15 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 4B9824FEA1;
        Mon, 13 Mar 2023 21:44:00 +0000 (GMT)
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Mykola Lysenko <mykolal@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: robustify test_xdp_do_redirect with more payload magics
Date:   Mon, 13 Mar 2023 22:42:57 +0100
Message-Id: <20230313214300.1043280-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313214300.1043280-1-aleksander.lobakin@intel.com>
References: <20230313214300.1043280-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the test relies on that only dropped ("xmitted") frames will
be recycled and if a frame became an skb, it will be freed later by the
stack and never come back to its page_pool.
So, it easily gets broken by trying to recycle skbs[0]:

  test_xdp_do_redirect:PASS:pkt_count_xdp 0 nsec
  test_xdp_do_redirect:FAIL:pkt_count_zero unexpected pkt_count_zero:
actual 9936 != expected 2
  test_xdp_do_redirect:PASS:pkt_count_tc 0 nsec

That huge mismatch happened because after the TC ingress hook zeroes the
magic, the page gets recycled when skb is freed, not returned to the MM
layer. "Live frames" mode initializes only new pages and keeps the
recycled ones as is by design, so they appear with zeroed magic on the
Rx path again.
Expand the possible magic values from two: 0 (was "xmitted"/dropped or
did hit the TC hook) and 0x42 (hit the input XDP prog) to three: the new
one will mark frames hit the TC hook, so that they will elide both
@pkt_count_zero and @pkt_count_xdp. They can then be recycled to their
page_pool or returned to the page allocator, this won't affect the
counters anyhow. Just make sure to mark them as "input" (0x42) when they
appear on the Rx path again.
Also make an enum from those magics, so that they will be always visible
and can be changed in just one place anytime. This also eases adding any
new marks later on.

Link: https://github.com/kernel-patches/bpf/actions/runs/4386538411/jobs/7681081789
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../bpf/progs/test_xdp_do_redirect.c          | 36 +++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
index 77a123071940..cd2d4e3258b8 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
@@ -4,6 +4,19 @@
 
 #define ETH_ALEN 6
 #define HDR_SZ (sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + sizeof(struct udphdr))
+
+/**
+ * enum frame_mark - magics to distinguish page/packet paths
+ * @MARK_XMIT: page was recycled due to the frame being "xmitted" by the NIC.
+ * @MARK_IN: frame is being processed by the input XDP prog.
+ * @MARK_SKB: frame did hit the TC ingress hook as an skb.
+ */
+enum frame_mark {
+	MARK_XMIT	= 0U,
+	MARK_IN		= 0x42,
+	MARK_SKB	= 0x45,
+};
+
 const volatile int ifindex_out;
 const volatile int ifindex_in;
 const volatile __u8 expect_dst[ETH_ALEN];
@@ -34,10 +47,10 @@ int xdp_redirect(struct xdp_md *xdp)
 	if (*metadata != 0x42)
 		return XDP_ABORTED;
 
-	if (*payload == 0) {
-		*payload = 0x42;
+	if (*payload == MARK_XMIT)
 		pkts_seen_zero++;
-	}
+
+	*payload = MARK_IN;
 
 	if (bpf_xdp_adjust_meta(xdp, 4))
 		return XDP_ABORTED;
@@ -51,7 +64,7 @@ int xdp_redirect(struct xdp_md *xdp)
 	return ret;
 }
 
-static bool check_pkt(void *data, void *data_end)
+static bool check_pkt(void *data, void *data_end, const __u32 mark)
 {
 	struct ipv6hdr *iph = data + sizeof(struct ethhdr);
 	__u8 *payload = data + HDR_SZ;
@@ -59,13 +72,13 @@ static bool check_pkt(void *data, void *data_end)
 	if (payload + 1 > data_end)
 		return false;
 
-	if (iph->nexthdr != IPPROTO_UDP || *payload != 0x42)
+	if (iph->nexthdr != IPPROTO_UDP || *payload != MARK_IN)
 		return false;
 
 	/* reset the payload so the same packet doesn't get counted twice when
 	 * it cycles back through the kernel path and out the dst veth
 	 */
-	*payload = 0;
+	*payload = mark;
 	return true;
 }
 
@@ -75,11 +88,11 @@ int xdp_count_pkts(struct xdp_md *xdp)
 	void *data = (void *)(long)xdp->data;
 	void *data_end = (void *)(long)xdp->data_end;
 
-	if (check_pkt(data, data_end))
+	if (check_pkt(data, data_end, MARK_XMIT))
 		pkts_seen_xdp++;
 
-	/* Return XDP_DROP to make sure the data page is recycled, like when it
-	 * exits a physical NIC. Recycled pages will be counted in the
+	/* Return %XDP_DROP to recycle the data page with %MARK_XMIT, like
+	 * it exited a physical NIC. Those pages will be counted in the
 	 * pkts_seen_zero counter above.
 	 */
 	return XDP_DROP;
@@ -91,9 +104,12 @@ int tc_count_pkts(struct __sk_buff *skb)
 	void *data = (void *)(long)skb->data;
 	void *data_end = (void *)(long)skb->data_end;
 
-	if (check_pkt(data, data_end))
+	if (check_pkt(data, data_end, MARK_SKB))
 		pkts_seen_tc++;
 
+	/* Will be either recycled or freed, %MARK_SKB makes sure it won't
+	 * hit any of the counters above.
+	 */
 	return 0;
 }
 
-- 
2.39.2

