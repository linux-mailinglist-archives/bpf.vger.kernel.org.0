Return-Path: <bpf+bounces-5132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E26756B2A
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 20:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560112812EF
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C8BE56;
	Mon, 17 Jul 2023 18:00:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898211878;
	Mon, 17 Jul 2023 18:00:56 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E50115;
	Mon, 17 Jul 2023 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616855; x=1721152855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RjQve+ajtq6zDTbE381g1mmA3qfKB2Tvgtd16TWYHZ0=;
  b=mH+gW55SP8imbiRu03MbvrY1WYfkDl0bskU20CcStSnHB2RDr8Qd6kdq
   gjeE00dd9P0UZQvS1YYAKVcCx72k06cLi0wXxTRlQA/ySYaA3+TFErGAM
   QXrFJ7L/F7/+kzQRrziqrMjw56nDeLRPx5335UeLMqv7z8rex3/3fdIKz
   mHl+iCuo85Ylh50tP4P6IIJ6mTtQ+7R6GsBR/VeU+rxUnodP9NsUB5jrP
   pZTGLngJBZ9zc783f/jSaWwTYgPfsKsiXNgBNDexPT42GbPIzPjdoUTIp
   4+KSICAoNWZLcICQOUSARZQLVdw6EeTs5w9SJhyJQAZnW2mfSGxt9i/Fh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432173503"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432173503"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 11:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793329326"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793329326"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 11:00:52 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	sasha.neftin@intel.com,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net] igc: Prevent garbled TX queue with XDP ZEROCOPY
Date: Mon, 17 Jul 2023 10:54:44 -0700
Message-Id: <20230717175444.3217831-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Florian Kauer <florian.kauer@linutronix.de>

In normal operation, each populated queue item has
next_to_watch pointing to the last TX desc of the packet,
while each cleaned item has it set to 0. In particular,
next_to_use that points to the next (necessarily clean)
item to use has next_to_watch set to 0.

When the TX queue is used both by an application using
AF_XDP with ZEROCOPY as well as a second non-XDP application
generating high traffic, the queue pointers can get in
an invalid state where next_to_use points to an item
where next_to_watch is NOT set to 0.

However, the implementation assumes at several places
that this is never the case, so if it does hold,
bad things happen. In particular, within the loop inside
of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
Finally, this prevents any further transmission via
this queue and it never gets unblocked or signaled.
Secondly, if the queue is in this garbled state,
the inner loop of igc_clean_tx_ring() will never terminate,
completely hogging a CPU core.

The reason is that igc_xdp_xmit_zc() reads next_to_use
before acquiring the lock, and writing it back
(potentially unmodified) later. If it got modified
before locking, the outdated next_to_use is written
pointing to an item that was already used elsewhere
(and thus next_to_watch got written).

Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9f93f0f4f752..f36bc2a1849a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2828,9 +2828,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
 	struct xdp_desc xdp_desc;
-	u16 budget;
+	u16 budget, ntu;
 
 	if (!netif_carrier_ok(ring->netdev))
 		return;
@@ -2840,6 +2839,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	txq_trans_cond_update(nq);
 
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
-- 
2.38.1


