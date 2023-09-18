Return-Path: <bpf+bounces-10268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF677A45AF
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 11:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D7D28200F
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD91C683;
	Mon, 18 Sep 2023 09:12:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F61C28D;
	Mon, 18 Sep 2023 09:12:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9745C5;
	Mon, 18 Sep 2023 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695028338; x=1726564338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xT9x3a94LD9U61KuO9Bp2lM+KNPJLA0BsvoEvX2oBg8=;
  b=SuM/8d6874tpPA9MVAkMku3beHresnA7JtxvsrJ+8qCkgvEp6iC4j6Kw
   IfmJU5+jMPkv9wib8CqtDMfx1KcNYMgxLQLJsThfYKaejm/g/4oLAh3UX
   2rz6PwJFekZ7x9tabKQVjyHk8TbcbTarCp/70VQ4j7eIEt6DJehF1Tp5q
   8XHTignIWM0VuIGHUjlB57eVoLBygDqw6Z+AmMX7yRMTjfhvkI9PaPYd1
   YRyjgeKLRjl+5fqnQZIqhIRDY4xVFkGh7Jo2KDykg4BMTzzweZtg2eyKA
   LRVM77QnSvxQPPQL2FN9kzbRr7G0QZWRcyA47Psik9fgaktITmunUmC//
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364647973"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364647973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815950016"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815950016"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:14 -0700
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
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next 5/8] selftests/xsk: remove unnecessary parameter from pkt_set() function call
Date: Mon, 18 Sep 2023 15:03:01 +0530
Message-Id: <20230918093304.367826-6-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918093304.367826-1-tushar.vyavahare@intel.com>
References: <20230918093304.367826-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The pkt_set() function no longer needs the umem parameter. This commit
removes the umem parameter from the pkt_set() function.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 27 ++++++++++--------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index cf3a723cc827..e67032f04a74 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -661,7 +661,7 @@ static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
 	return ceil_u32(len, umem->frame_size) * umem->frame_size;
 }
 
-static struct pkt_stream *pkt_stream_generate(struct xsk_umem_info *umem, u32 nb_pkts, u32 pkt_len)
+static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32 pkt_len)
 {
 	struct pkt_stream *pkt_stream;
 	u32 i;
@@ -682,30 +682,28 @@ static struct pkt_stream *pkt_stream_generate(struct xsk_umem_info *umem, u32 nb
 	return pkt_stream;
 }
 
-static struct pkt_stream *pkt_stream_clone(struct xsk_umem_info *umem,
-					   struct pkt_stream *pkt_stream)
+static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
 {
-	return pkt_stream_generate(umem, pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
+	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
 }
 
 static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
 {
 	struct pkt_stream *pkt_stream;
 
-	pkt_stream = pkt_stream_generate(test->ifobj_tx->umem, nb_pkts, pkt_len);
+	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
 	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
-	pkt_stream = pkt_stream_generate(test->ifobj_rx->umem, nb_pkts, pkt_len);
+	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
 }
 
 static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
 				      int offset)
 {
-	struct xsk_umem_info *umem = ifobj->umem;
 	struct pkt_stream *pkt_stream;
 	u32 i;
 
-	pkt_stream = pkt_stream_clone(umem, ifobj->xsk->pkt_stream);
+	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream);
 	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
 		pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
 
@@ -720,11 +718,10 @@ static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int off
 
 static void pkt_stream_receive_half(struct test_spec *test)
 {
-	struct xsk_umem_info *umem = test->ifobj_rx->umem;
 	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
 	u32 i;
 
-	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(umem, pkt_stream->nb_pkts,
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
 							      pkt_stream->pkts[0].len);
 	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
 	for (i = 1; i < pkt_stream->nb_pkts; i += 2)
@@ -1929,8 +1926,7 @@ static int testapp_stats_tx_invalid_descs(struct test_spec *test)
 static int testapp_stats_rx_full(struct test_spec *test)
 {
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
-	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
-							      DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
 	test->ifobj_rx->release_rx = false;
@@ -1941,8 +1937,7 @@ static int testapp_stats_rx_full(struct test_spec *test)
 static int testapp_stats_fill_empty(struct test_spec *test)
 {
 	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
-	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
-							      DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->use_fill_ring = false;
 	test->ifobj_rx->validation_func = validate_fill_empty;
@@ -2479,8 +2474,8 @@ int main(int argc, char **argv)
 	init_iface(ifobj_tx, worker_testapp_validate_tx);
 
 	test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
-	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-	rx_pkt_stream_default = pkt_stream_generate(ifobj_rx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
 	if (!tx_pkt_stream_default || !rx_pkt_stream_default)
 		exit_with_error(ENOMEM);
 	test.tx_pkt_stream_default = tx_pkt_stream_default;
-- 
2.34.1


