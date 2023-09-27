Return-Path: <bpf+bounces-10973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80B7B0574
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4D1691C20AE7
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537B34189;
	Wed, 27 Sep 2023 13:32:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06731A92;
	Wed, 27 Sep 2023 13:32:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2475C126;
	Wed, 27 Sep 2023 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695821520; x=1727357520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1toNm6YmC4RFOzOKHEDBK3Y3V254EoVUNgBr1nKX7d4=;
  b=JvR3sXiZbTICeUgTgOvbSchramBEpj146R4MBnkAdEtlLDl5LfQtE/Fy
   1u2BM+35ATbXGg9azE1OsY0kbXnU/jN5VU3PQ7stY8fYoi0mzdHwxU8Lb
   cKrMts4d6oXLRSWJRCO5YnF71l9gVfb9hWjtbb/gAvMPfaIqk3kmcuL1I
   N5dO1XJfJpHMdtanZyM4qjT32Q/7nio5OxfoJNQF3CpbswvlgAunapzBA
   /vB+oLTTs4E/dQQ3bx4oAgpCSRcfW2mgxKulCD57Ur2ORmppIBlbjw0F5
   8SpMLIT3Z2VNqYbU/KT3iUG3WkSJvp+hcVGixQRy+GoS7BCSZjtG0aIj5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="448316439"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="448316439"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698879046"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698879046"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:31:55 -0700
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
Subject: [PATCH bpf-next v3 7/8] selftests/xsk: modify xsk_update_xskmap() to accept the index as an argument
Date: Wed, 27 Sep 2023 19:22:40 +0530
Message-Id: <20230927135241.2287547-8-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
References: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
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
index ce869431556c..0432c516a413 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1608,7 +1608,7 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 
 	xsk_populate_fill_ring(ifobject->umem, ifobject->xsk->pkt_stream, ifobject->use_fill_ring);
 
-	ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
+	ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
 	if (ret)
 		exit_with_error(errno);
 }
@@ -1646,7 +1646,7 @@ static void *worker_testapp_validate_rx(void *arg)
 		thread_common_ops(test, ifobject);
 	} else {
 		xsk_clear_xskmap(ifobject->xskmap);
-		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk);
+		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
 		if (err) {
 			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
 				       strerror(-err));
@@ -1884,7 +1884,7 @@ static int swap_xsk_resources(struct test_spec *test)
 	test->ifobj_tx->xsk = &test->ifobj_tx->xsk_arr[1];
 	test->ifobj_rx->xsk = &test->ifobj_rx->xsk_arr[1];
 
-	ret = xsk_update_xskmap(test->ifobj_rx->xskmap, test->ifobj_rx->xsk->xsk);
+	ret = xsk_update_xskmap(test->ifobj_rx->xskmap, test->ifobj_rx->xsk->xsk, 0);
 	if (ret)
 		return TEST_FAILURE;
 
-- 
2.34.1


