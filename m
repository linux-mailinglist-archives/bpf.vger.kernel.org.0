Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595275A65CC
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiH3N6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiH3N50 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:57:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1F11B3F9;
        Tue, 30 Aug 2022 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661867794; x=1693403794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqdkOJq6upCJY9YWkw0j8B8ITD8I35DIghCrlGZJy0s=;
  b=U/B7YLBx0vqllk2vdfnA/Zu2JP5sGyV9PQiorDF2wasJwS/6XD1w72dB
   w0M1RfqCRwNPHzBE9SB6e6FXlsWifQW/g420Hoo8KjcPQxMTM76NOT1bu
   c+3zxLzJL5/piJ6bjw8QTiZ4uKJmCUgYcorQft8QWxjAkamT6QuFRst6q
   ntHgazi7BZQ2Z/jns/lMzmLEcQikZbDGmJT4fiWKXeHCoFg19+OLqIw6c
   zFhG+Wg5nz3/J9AHe0Yk3iiAFnivqvXGmHyDOk2Ce2klsb1biL2Wg7OKq
   hAjNlmBF6GjDo9N4BGNdkqhdDgvKfR4MWgblyqpx9hS099Cf2dRMO+DPV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295180440"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="295180440"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562651359"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 06:56:31 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     netdev@vger.kernel.org, magnus.karlsson@intel.com,
        bjorn@kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 bpf-next 6/6] selftests: xsk: add support for zero copy testing
Date:   Tue, 30 Aug 2022 15:56:04 +0200
Message-Id: <20220830135604.10173-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220830135604.10173-1-maciej.fijalkowski@intel.com>
References: <20220830135604.10173-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce new mode to xskxceiver responsible for testing AF_XDP zero
copy support of driver that serves underlying physical device. When
setting up test suite, determine whether driver has ZC support or not by
trying to bind XSK ZC socket to the interface. If it succeeded,
interpret it as ZC support being in place and do softirq and busy poll
tests for zero copy mode.

Note that Rx dropped tests are skipped since ZC path is not touching
rx_dropped stat at all.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 76 ++++++++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h |  2 +
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 8e157c462cd0..adfbde5552b9 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -124,9 +124,20 @@ static void __exit_with_error(int error, const char *file, const char *func, int
 }
 
 #define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
-
-#define mode_string(test) (test)->ifobj_tx->xdp_flags & XDP_FLAGS_SKB_MODE ? "SKB" : "DRV"
 #define busy_poll_string(test) (test)->ifobj_tx->busy_poll ? "BUSY-POLL " : ""
+static char *mode_string(struct test_spec *test)
+{
+	switch (test->mode) {
+	case TEST_MODE_SKB:
+		return "SKB";
+	case TEST_MODE_DRV:
+		return "DRV";
+	case TEST_MODE_ZC:
+		return "ZC";
+	default:
+		return "BOGUS";
+	}
+}
 
 static void report_failure(struct test_spec *test)
 {
@@ -322,6 +333,51 @@ static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_i
 	return xsk_socket__create(&xsk->xsk, ifobject->ifname, 0, umem->umem, rxr, txr, &cfg);
 }
 
+static bool ifobj_zc_avail(struct ifobject *ifobject)
+{
+	size_t umem_sz = DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;
+	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
+	struct xsk_socket_info *xsk;
+	struct xsk_umem_info *umem;
+	bool zc_avail = false;
+	void *bufs;
+	int ret;
+
+	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
+	if (bufs == MAP_FAILED)
+		exit_with_error(errno);
+
+	umem = calloc(1, sizeof(struct xsk_umem_info));
+	if (!umem) {
+		munmap(bufs, umem_sz);
+		exit_with_error(-ENOMEM);
+	}
+	umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
+	ret = xsk_configure_umem(umem, bufs, umem_sz);
+	if (ret)
+		exit_with_error(-ret);
+
+	xsk = calloc(1, sizeof(struct xsk_socket_info));
+	if (!xsk)
+		goto out;
+	ifobject->xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
+	ifobject->xdp_flags |= XDP_FLAGS_DRV_MODE;
+	ifobject->bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
+	ifobject->rx_on = true;
+	xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+	ret = __xsk_configure_socket(xsk, umem, ifobject, false);
+	if (!ret)
+		zc_avail = true;
+
+	xsk_socket__delete(xsk->xsk);
+	free(xsk);
+out:
+	munmap(umem->buffer, umem_sz);
+	xsk_umem__delete(umem->umem);
+	free(umem);
+	return zc_avail;
+}
+
 static struct option long_options[] = {
 	{"interface", required_argument, 0, 'i'},
 	{"busy-poll", no_argument, 0, 'b'},
@@ -488,9 +544,14 @@ static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		else
 			ifobj->xdp_flags |= XDP_FLAGS_DRV_MODE;
 
-		ifobj->bind_flags = XDP_USE_NEED_WAKEUP | XDP_COPY;
+		ifobj->bind_flags = XDP_USE_NEED_WAKEUP;
+		if (mode == TEST_MODE_ZC)
+			ifobj->bind_flags |= XDP_ZEROCOPY;
+		else
+			ifobj->bind_flags |= XDP_COPY;
 	}
 
+	test->mode = mode;
 	__test_spec_init(test, ifobj_tx, ifobj_rx);
 }
 
@@ -1664,6 +1725,10 @@ static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_
 {
 	switch (type) {
 	case TEST_TYPE_STATS_RX_DROPPED:
+		if (mode == TEST_MODE_ZC) {
+			ksft_test_result_skip("Can not run RX_DROPPED test for ZC mode\n");
+			return;
+		}
 		testapp_stats_rx_dropped(test);
 		break;
 	case TEST_TYPE_STATS_TX_INVALID_DESCS:
@@ -1863,8 +1928,11 @@ int main(int argc, char **argv)
 	init_iface(ifobj_rx, MAC2, MAC1, IP2, IP1, UDP_PORT2, UDP_PORT1,
 		   worker_testapp_validate_rx);
 
-	if (is_xdp_supported(ifobj_tx))
+	if (is_xdp_supported(ifobj_tx)) {
 		modes++;
+		if (ifobj_zc_avail(ifobj_tx))
+			modes++;
+	}
 
 	test_spec_init(&test, ifobj_tx, ifobj_rx, 0);
 	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, PKT_SIZE);
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 068e88d7327e..ebbb4a8c39cf 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -62,6 +62,7 @@
 enum test_mode {
 	TEST_MODE_SKB,
 	TEST_MODE_DRV,
+	TEST_MODE_ZC,
 	TEST_MODE_MAX
 };
 
@@ -167,6 +168,7 @@ struct test_spec {
 	u16 current_step;
 	u16 nb_sockets;
 	bool fail;
+	enum test_mode mode;
 	char name[MAX_TEST_NAME_SIZE];
 };
 
-- 
2.34.1

