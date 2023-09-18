Return-Path: <bpf+bounces-10263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A817A4591
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 11:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4502F1C20A1F
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1D14F8C;
	Mon, 18 Sep 2023 09:11:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FA5382;
	Mon, 18 Sep 2023 09:11:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D484C5;
	Mon, 18 Sep 2023 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695028313; x=1726564313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RJJO2x4Zh+7nF0s81CNDj9yNY5C6WK5O66SjlprhQYg=;
  b=inCbK/8xEStPovu7GTJrr74RW+IpogO/u/eddRfDDc0Jlt9qD4owIyw0
   V/0Dv65HDr1ypk15QZSteIFksb0rIudoXUVJ25YagSTud28kXs32HU+7E
   d+Bu7bS2PUWxcZ2K0fsl56Ute+3WVRTsVqtWIFuXML7nhvKUafExSrvqz
   UvFJmM259ky3wfP5gTeCYcUqqlfk2IA63Ui8FuERjjOiLjAlYJ6rMF7Sn
   lMhO5VCwmgQDsGsLf9c+4ZV83YQkQOI/JiGt3yfbyrstwJ11Z6oJc8xZ8
   dtXZi3xjysn1Mzp7hriBb35eYZm8aRO1LvJKuDesHy3tmAhh0ZcDfLz8K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364647890"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364647890"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815949958"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815949958"
Received: from unknown (HELO axxiablr2..) ([10.190.162.200])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 02:11:48 -0700
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
Subject: [PATCH bpf-next 0/8] Add a test for SHARED_UMEM feature
Date: Mon, 18 Sep 2023 15:02:56 +0530
Message-Id: <20230918093304.367826-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
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

Implement a test for the SHARED_UMEM feature in this patch set and make
necessary changes/improvements. Ensure that the framework now supports
different streams for different sockets.

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
   Implement the function called generate_mac_addresses() to generate MAC
   addresses based on the required number by the framework.

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
  selftests/xsk: implement a function that generates MAC addresses
  selftests/xsk: iterate over all the sockets in the receive pkts
    function
  selftests/xsk: remove unnecessary parameter from pkt_set() function
    call
  selftests/xsk: iterate over all the sockets in the send pkts function
  selftests/xsk: modify xsk_update_xskmap() to accept the index as an
    argument.
  selftests/xsk: add a test for shared umem feature

 .../selftests/bpf/progs/xsk_xdp_progs.c       |  22 +-
 tools/testing/selftests/bpf/xsk.c             |   3 +-
 tools/testing/selftests/bpf/xsk.h             |   2 +-
 tools/testing/selftests/bpf/xsk_xdp_common.h  |  12 +
 .../testing/selftests/bpf/xsk_xdp_metadata.h  |   5 -
 tools/testing/selftests/bpf/xskxceiver.c      | 524 +++++++++++-------
 tools/testing/selftests/bpf/xskxceiver.h      |  14 +-
 7 files changed, 376 insertions(+), 206 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/xsk_xdp_common.h
 delete mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h

-- 
2.34.1


