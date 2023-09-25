Return-Path: <bpf+bounces-10733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E017AD534
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4E0CE2818D2
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5801401A;
	Mon, 25 Sep 2023 10:01:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53E134A2;
	Mon, 25 Sep 2023 10:01:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0AE2139;
	Mon, 25 Sep 2023 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695636095; x=1727172095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T6W5WChOpHM1gx/o+m3VmK+oZ2R/XvO/t+sl5tnTSdw=;
  b=ZnnZKrrYrJc5kBZOdla3kwtWi7XXWPfvmtpwtOjWlEpVUZDcO2E9g7rt
   ykHhFlqQhkGV6XMUH/weNaiRFJmEaw9KvkwObOBvFuBconC/g+xn2qU4N
   yrWAVlq1KTMpx7pb3+pOsr10AvgZBYPMZ/5AZnv9/71RCLwVs1YBSfdTu
   aBVKyhlY7fzL/EUa2Lj4+89wEaJePZSo4brlFSyQJtMrSqyrUOC4E8hGp
   nyG2lcpWQwaS1mQPxuuI5ZcduldfPOJ4hg7+3B/AOuk2jRSW+fLEL8t5p
   AHA9kVAKfQi4UIBk2oW9kyU2sP6Ho74YUxqvPxOh8wdwXYptypzy+L9S9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445325056"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445325056"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="697923544"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="697923544"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:01:30 -0700
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
Subject: [PATCH bpf-next v2 0/8] Add a test for SHARED_UMEM feature
Date: Mon, 25 Sep 2023 15:52:41 +0530
Message-Id: <20230925102249.1847195-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
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

Implement a test for the SHARED_UMEM feature in this patch set and make
necessary changes/improvements. Ensure that the framework now supports
different streams for different sockets.

v1->v2
	- Remove generate_mac_addresses() and generate mac addresses based on
	  the number of sockets in __test_spec_init() function. [Magnus]
	- Update Makefile to include find_bit.c for compiling xskxceiver.
	- Add bitmap_full() function to verify all bits are set to break the while loop
	  in the receive_pkts() and send_pkts() functions.
	- Replace __test_and_set_bit() function with __set_bit() function.
	- Add single return check for wait_for_tx_completion() function call.
 
Patch series summary:

1: Move the packet stream from the ifobject struct to the xsk_socket_info
   struct to enable the use of different streams for different sockets
   This will facilitate the sending and receiving of data from multiple
   sockets simultaneously using the SHARED_XDP_UMEM feature.

   It gives flexibility of send/recive individual traffic on particular
   socket.

2: Rename the header file to a generic name so that it can be used by all
   future XDP programs.

3: Move the src_mac and dst_mac fields from the ifobject structure to the
   xsk_socket_info structure to achieve per-socket MAC address assignment.
   Require this in order to steer traffic to various sockets in subsequent
   patches.

4: Improve the receive_pkt() function to enable it to receive packets from
   multiple sockets. Define a sock_num variable to iterate through all the
   sockets in the Rx path. Add nb_valid_entries to check that all the
   expected number of packets are received.

5: The pkt_set() function no longer needs the umem parameter. This commit
   removes the umem parameter from the pkt_set() function.

6: Iterate over all the sockets in the send pkts function. Update
   send_pkts() to handle multiple sockets for sending packets.
   Multiple TX sockets are utilized alternately based on the batch size
   for improve packet transmission.

7: Modify xsk_update_xskmap() to accept the index as an argument, enabling
   the addition of multiple sockets to xskmap.

8: Add a new test for testing shared umem feature. This is accomplished by
   adding a new XDP program and using the multiple sockets. The new  XDP
   program redirects the packets based on the destination MAC address.

Tushar Vyavahare (8):
  selftests/xsk: move pkt_stream to the xsk_socket_info
  selftests/xsk: rename xsk_xdp_metadata.h to xsk_xdp_common.h
  selftests/xsk: move src_mac and dst_mac to the xsk_socket_info
  selftests/xsk: iterate over all the sockets in the receive pkts
    function
  selftests/xsk: remove unnecessary parameter from pkt_set() function
    call
  selftests/xsk: iterate over all the sockets in the send pkts function
  selftests/xsk: modify xsk_update_xskmap() to accept the index as an
    argument
  selftests/xsk: add a test for shared umem feature

 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  22 +-
 tools/testing/selftests/bpf/xsk.c             |   3 +-
 tools/testing/selftests/bpf/xsk.h             |   2 +-
 tools/testing/selftests/bpf/xsk_xdp_common.h  |  12 +
 .../testing/selftests/bpf/xsk_xdp_metadata.h  |   5 -
 tools/testing/selftests/bpf/xskxceiver.c      | 513 +++++++++++-------
 tools/testing/selftests/bpf/xskxceiver.h      |  13 +-
 8 files changed, 363 insertions(+), 211 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/xsk_xdp_common.h
 delete mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h

-- 
2.34.1


