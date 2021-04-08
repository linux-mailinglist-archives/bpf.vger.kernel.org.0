Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41E3583D1
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhDHMwh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 08:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231747AbhDHMw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBC0B61106;
        Thu,  8 Apr 2021 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617886335;
        bh=DveDYhQgmegYY2rLgb5TYaE79CFicjQXv1T7n9wK6kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Af9kY76wL7tfbjc4dib5GWueUR4H4lf1Fg/HSiGnoNWbEceJRSlAw/TnIJp9qSyhu
         IN8ljyTP5vd13kYM1Lc9v/xmP4jC5hFzatwhMvaMDQfBj/OZPvZmyy361Gb1oDMxN7
         bVBSNlnfMBRAasrod3yZ8IqR/adfA3bJzjlWkJEuw7k1S1w193sdV3uZt18910M61c
         tlJ1nSKdWjvkCIPBzkRLEVnp0/HLUntlFa5yhq4nr3bJwgvDRfu9ZkisBo3JI+q2tZ
         bYinfkfN71axWkVGISxIdsFaStEtsiFqZ/3XJtQ+MdzjluHpay3pGA7tfdt/UyWepe
         FaIXSSL2GmtQg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        sameehj@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        brouer@redhat.com, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com
Subject: [PATCH v8 bpf-next 12/14] bpf: introduce multibuff support to bpf_prog_test_run_xdp()
Date:   Thu,  8 Apr 2021 14:51:04 +0200
Message-Id: <927b354182cefa48893a775545968e8ce1076066.1617885385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617885385.git.lorenzo@kernel.org>
References: <cover.1617885385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce the capability to allocate a xdp multi-buff in
bpf_prog_test_run_xdp routine. This is a preliminary patch to introduce
the selftests for new xdp multi-buff ebpf helpers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/bpf/test_run.c | 52 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 1acd94377822..bb953b2e6501 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -692,23 +692,22 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 {
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	u32 headroom = XDP_PACKET_HEADROOM;
-	u32 size = kattr->test.data_size_in;
+	struct xdp_shared_info *xdp_sinfo;
 	u32 repeat = kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
 	struct xdp_buff xdp = {};
+	u32 max_data_sz, size;
 	u32 retval, duration;
-	u32 max_data_sz;
+	int i, ret;
 	void *data;
-	int ret;
 
 	if (kattr->test.ctx_in || kattr->test.ctx_out)
 		return -EINVAL;
 
-	/* XDP have extra tailroom as (most) drivers use full page */
 	max_data_sz = 4096 - headroom - tailroom;
+	size = min_t(u32, kattr->test.data_size_in, max_data_sz);
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in,
-			     max_data_sz, headroom, tailroom);
+	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -717,16 +716,53 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		      &rxqueue->xdp_rxq);
 	xdp_prepare_buff(&xdp, data, headroom, size, true);
 
+	xdp_sinfo = xdp_get_shared_info_from_buff(&xdp);
+	if (unlikely(kattr->test.data_size_in > size)) {
+		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
+
+		while (size < kattr->test.data_size_in) {
+			struct page *page;
+			skb_frag_t *frag;
+			int data_len;
+
+			page = alloc_page(GFP_KERNEL);
+			if (!page) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			frag = &xdp_sinfo->frags[xdp_sinfo->nr_frags++];
+			xdp_set_frag_page(frag, page);
+
+			data_len = min_t(int, kattr->test.data_size_in - size,
+					 PAGE_SIZE);
+			xdp_set_frag_size(frag, data_len);
+
+			if (copy_from_user(page_address(page), data_in + size,
+					   data_len)) {
+				ret = -EFAULT;
+				goto out;
+			}
+			xdp_sinfo->data_length += data_len;
+			size += data_len;
+		}
+		xdp.mb = 1;
+	}
+
 	bpf_prog_change_xdp(NULL, prog);
 	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
 	if (ret)
 		goto out;
-	if (xdp.data != data + headroom || xdp.data_end != xdp.data + size)
-		size = xdp.data_end - xdp.data;
+
+	size = xdp.data_end - xdp.data + xdp_sinfo->data_length;
 	ret = bpf_test_finish(kattr, uattr, xdp.data, size, retval, duration);
+
 out:
 	bpf_prog_change_xdp(prog, NULL);
+	for (i = 0; i < xdp_sinfo->nr_frags; i++)
+		__free_page(xdp_get_frag_page(&xdp_sinfo->frags[i]));
 	kfree(data);
+
 	return ret;
 }
 
-- 
2.30.2

