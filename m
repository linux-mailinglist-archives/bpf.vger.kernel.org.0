Return-Path: <bpf+bounces-10270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B074D7A45B4
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 11:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCCF1C21151
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E751C6A2;
	Mon, 18 Sep 2023 09:12:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32C1C69C;
	Mon, 18 Sep 2023 09:12:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C59AD1;
	Mon, 18 Sep 2023 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695028349; x=1726564349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2dn+blYe19DwXEdoBxUqThGIE3twNzwQ0WV6TI8flPA=;
  b=iZfUJuuvfnzQMHMAg8BrREL9GPA6zTdDBrCWTI7EXZiv+qhRM1AmETvC
   napN9ySbBcIVsOtgIePS80dUP+W2K/q7RlpEEOAAHI3sJhckWlgtndP6I
   4J1m/ltuyiEjxp4xxe/9Ali4Dt+BPRebUwnhAxURw3R5Mn/FRw7vm4Zdq
   eFlfYMUWUEU1L80v6cbJcowj9VHx4JPSmk9cqJBZpAGRpb/U1z2xOXiXj
   DxgbQCyc//iN/zCBj7Tc3sucB3LkWUglQ83CDqzz4jkuWT/6Jf3n2YqnM
   A54Sy2udiz7a6U8ouNyAeG6Hsl8e8jSCaRMxxnH000mglr/kKhUJ5r+Fz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364648015"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364648015"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815950077"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815950077"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:12:25 -0700
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
Subject: [PATCH bpf-next 7/8] selftests/xsk: modify xsk_update_xskmap() to accept the index as an argument.
Date: Mon, 18 Sep 2023 15:03:03 +0530
Message-Id: <20230918093304.367826-8-tushar.vyavahare@intel.com>
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

Modify xsk_update_xskmap() to accept the index as an argument, enabling
the addition of multiple sockets to xskmap.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xsk.c        | 3 +--
 tools/testing/selftests/bpf/xsk.h        | 2 +-
 tools/testing/selftests/bpf/xskxceiver.c | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index d9fb2b730a2c..e574711eeb84 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -442,10 +442,9 @@ void xsk_clear_xskmap(struct bpf_map *map)
 	bpf_map_delete_elem(map_fd, &index);
 }
 
-int xsk_update_xskmap(struct bpf_map *map, struct xsk_socket *xsk)
+int xsk_update_xskmap(struct bpf_map *map, struct xsk_socket *xsk, u32 index)
 {
 	int map_fd, sock_fd;
-	u32 index = 0;
 
 	map_fd = bpf_map__fd(map);
 	sock_fd = xsk_socket__fd(xsk);
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index d93200fdaa8d..771570bc3731 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -204,7 +204,7 @@ struct xsk_umem_config {
 
 int xsk_attach_xdp_program(struct bpf_program *prog, int ifindex, u32 xdp_flags);
 void xsk_detach_xdp_program(int ifindex, u32 xdp_flags);
-int xsk_update_xskmap(struct bpf_map *map, struct xsk_socket *xsk);
+int xsk_update_xskmap(struct bpf_map *map, struct xsk_socket *xsk, u32 index);
 void xsk_clear_xskmap(struct bpf_map *map);
 bool xsk_is_in_mode(u32 ifindex, int mode);
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 0ef0575c095c..c432548235dd 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1625,7 +1625,7 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 
 	xsk_populate_fill_ring(ifobject->umem, ifobject->xsk->pkt_stream, ifobject->use_fill_ring);
 
-	ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
+	ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
 	if (ret)
 		exit_with_error(errno);
 }
@@ -1663,7 +1663,7 @@ static void *worker_testapp_validate_rx(void *arg)
 		thread_common_ops(test, ifobject);
 	} else {
 		xsk_clear_xskmap(ifobject->xskmap);
-		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
+		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
 		if (err) {
 			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
 				       strerror(-err));
@@ -1897,7 +1897,7 @@ static int swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_
 	ifobj_tx->xsk = &ifobj_tx->xsk_arr[1];
 	ifobj_rx->xsk = &ifobj_rx->xsk_arr[1];
 
-	ret = xsk_update_xskmap(ifobj_rx->xskmap, ifobj_rx->xsk->xsk);
+	ret = xsk_update_xskmap(ifobj_rx->xskmap, ifobj_rx->xsk->xsk, 0);
 	if (ret)
 		return TEST_FAILURE;
 
-- 
2.34.1


