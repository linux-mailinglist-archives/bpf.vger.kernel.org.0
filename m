Return-Path: <bpf+bounces-2650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99C731EEA
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 19:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB4280C38
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56DEACA;
	Thu, 15 Jun 2023 17:26:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E9EAC5;
	Thu, 15 Jun 2023 17:26:20 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940312944;
	Thu, 15 Jun 2023 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686849977; x=1718385977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ecus7llwKUUqigrW6JPbuZqEm8/x6S7PAZO6TC6dqB4=;
  b=FK91345E9HE+/yLmyQL5FFslT6gcSZljh2KjAsCKHndPrY2v38BDgp7R
   HyN/oJPxqtvTQvIdOREsmebfhSxRqaJWXbuctXatihzPghe/65B6GImBH
   ie3Mw0Ar7wrdcjKJ46J1mLN6r1zvNFJXQMsGGd68wMvVMYNpdAVUr/g97
   0qfOFOOujQxfWmRPt3TKcw8PN+2DVeCy+b9FjvVadI013m9z9FETpz8Kb
   doUpxco7hp+8AHfj5VmYeWZsxc6ihDdjM1lNbOfpQlkrOVIpx2oYEx5If
   BE3hS89FhatMaEDVaGd8Q8ogzZZvszwS5cstsRxAjj9gY+GqQfArgYqha
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="358983434"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="358983434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689858288"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689858288"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 10:26:14 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v4 bpf-next 00/22] xsk: multi-buffer support
Date: Thu, 15 Jun 2023 19:25:44 +0200
Message-Id: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
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

v3->v4:
-rely on ynl for adding new xdp_features flag [Jakub]
- move xskb_list to xsk_buff_pool

v2->v3:
- Fix issue with the next valid packet getting dropped after an invalid
  packet with MAX_SKB_FRAGS + 1 frags [Magnus]
- query NETDEV_XDP_ACT_ZC_SG flag within xskxceiver and act on it
- remove redundant include in xsk.c [kernel test robot]
- s/NETDEV_XDP_ACT_NDO_ZC_SG/NETDEV_XDP_ACT_ZC_SG + kernel doc [Magnus,
  Simon]

v1->v2:
- fix spelling issues in commit messages [Simon]
- remove XSK_DESC_MAX_FRAGS, use MAX_SKB_FRAGS instead [Stan, Alexei]
- add documentation patch
- fix build error from kernel test robot on patch 10


This series of patches add multi-buffer support for AF_XDP. XDP and
various NIC drivers already have support for multi-buffer packets. With
this patch set, programs using AF_XDP sockets can now also receive and
transmit multi-buffer packets both in copy as well as zero-copy mode.
ZC multi-buffer implementation is based on ice driver.

Some definitions to put us all on the same page:

* A packet consists of one or more frames

* A descriptor in one of the AF_XDP rings always refers to a single
  frame. In the case the packet consists of a single frame, the
  descriptor refers to the whole packet.

To represent a packet consisting of multiple frames, we introduce a
new flag called XDP_PKT_CONTD in the options field of the Rx and Tx
descriptors. If it is true (1) the packet continues with the next
descriptor and if it is false (0) it means this is the last descriptor
of the packet. Why the reverse logic of end-of-packet (eop) flag found
in many NICs? Just to preserve compatibility with non-multi-buffer
applications that have this bit set to false for all packets on Rx, and
the apps set the options field to zero for Tx, as anything else will
be treated as an invalid descriptor.

These are the semantics for producing packets onto XSK Tx ring
consisting of multiple frames:

* When an invalid descriptor is found, all the other
  descriptors/frames of this packet are marked as invalid and not
  completed. The next descriptor is treated as the start of a new
  packet, even if this was not the intent (because we cannot guess
  the intent). As before, if your program is producing invalid
  descriptors you have a bug that must be fixed.

* Zero length descriptors are treated as invalid descriptors.

* For copy mode, the maximum supported number of frames in a packet is
  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
  descriptors accumulated so far are dropped and treated as
  invalid. To produce an application that will work on any system
  regardless of this config setting, limit the number of frags to 18,
  as the minimum value of the config is 17.

* For zero-copy mode, the limit is up to what the NIC HW
  supports. Usually at least five on the NICs we have checked. We
  consciously chose to not enforce a rigid limit (such as
  CONFIG_MAX_SKB_FRAGS + 1) for zero-copy mode, as it would have
  resulted in copy actions under the hood to fit into what limit the
  NIC supports. Kind of defeats the purpose of zero-copy mode.

* ZC batch API guarantees that it will provide a batch of Tx descriptors
  that ends with full packet at the end. If not, ZC drivers would have
  to gather the full packet on their side. The approach we picked makes
  ZC drivers life much easier (at least on Tx side).

Here is an example Tx path pseudo-code (using libxdp interfaces for
simplicity) ignoring that the umem is finite in size, and that we
eventually will run out of packets to send. Also assumes pkts.addr
points to a valid location in the umem.

void tx_packets(struct xsk_socket_info *xsk, struct pkt *pkts,
                int batch_size)
{
	u32 idx, i, pkt_nb = 0;

	xsk_ring_prod__reserve(&xsk->tx, batch_size, &idx);

	for (i = 0; i < batch_size;) {
		u64 addr = pkts[pkt_nb].addr;
		u32 len = pkts[pkt_nb].size;

		do {
			struct xdp_desc *tx_desc;

			tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i++);
			tx_desc->addr = addr;

			if (len > xsk_frame_size) {
				tx_desc->len = xsk_frame_size;
				tx_desc->options |= XDP_PKT_CONTD;
			} else {
				tx_desc->len = len;
				tx_desc->options = 0;
				pkt_nb++;
			}
			len -= tx_desc->len;
			addr += xsk_frame_size;

			if (i == batch_size) {
				/* Remember len, addr, pkt_nb for next
				 * iteration. Skipped for simplicity.
				 */
				break;
			}
		} while (len);
	}

	xsk_ring_prod__submit(&xsk->tx, i);
}

On the Rx path in copy mode, the xsk core copies the XDP data into
multiple descriptors, if needed, and sets the XDP_PKT_CONTD flag as
detailed before. Zero-copy mode in order to avoid the copies has to
maintain a chain of xdp_buff_xsk structs that represent whole packet.
This is because what actually is redirected is the xdp_buff and we
currently have no equivalent mechanism that is used for copy mode
(embedded skb_shared_info in xdp_buff) to carry the frags. This means
xdp_buff_xsk grows in size but these members are at the end and should
not be touched when data path is not dealing with fragmented packets.
This solution kept us within assumed performance impact, hence we
decided to proceed with it.

When the application gets a descriptor with the
XDP_PKT_CONTD flag set to one, it means that the packet consists of
multiple buffers and it continues with the next buffer in the following
descriptor. When a descriptor with XDP_PKT_CONTD == 0 is received, it
means that this is the last buffer of the packet. AF_XDP guarantees that
only a complete packet (all frames in the packet) is sent to the
application.

If application reads a batch of descriptors, using for example the libxdp
interfaces, it is not guaranteed that the batch will end with a full
packet. It might end in the middle of a packet and the rest of the
buffers of that packet will arrive at the beginning of the next batch,
since the libxdp interface does not read the whole ring (unless you
have an enormous batch size or a very small ring size).

Here is a simple Rx path pseudo-code example (using libxdp interfaces for
simplicity). Error paths have been excluded for simplicity:

void rx_packets(struct xsk_socket_info *xsk)
{
	static bool new_packet = true;
	u32 idx_rx = 0, idx_fq = 0;
	static char *pkt;

	int rcvd = xsk_ring_cons__peek(&xsk->rx, opt_batch_size, &idx_rx);

	xsk_ring_prod__reserve(&xsk->umem->fq, rcvd, &idx_fq);

	for (int i = 0; i < rcvd; i++) {
		struct xdp_desc *desc = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++);
		char *frag = xsk_umem__get_data(xsk->umem->buffer, desc->addr);
		bool eop = !(desc->options & XDP_PKT_CONTD);

		if (new_packet)
			pkt = frag;
		else
			add_frag_to_pkt(pkt, frag);

		if (eop)
			process_pkt(pkt);

		new_packet = eop;

		*xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) = desc->addr;
	}

	xsk_ring_prod__submit(&xsk->umem->fq, rcvd);
	xsk_ring_cons__release(&xsk->rx, rcvd);
}

Unfortunately, we had to introduce a new bind flag (XDP_USE_SG) on the
AF_XDP level to enable multi-buffer support. It would be great if you
have ideas on how to get rid of it. The reason we need to
differentiate between non multi-buffer and multi-buffer is the
behaviour when the kernel gets a packet that is larger than the frame
size. Without multi-buffer, this packet is dropped and marked in the
stats. With multi-buffer on, we want to split it up into multiple
frames instead.

At the start, we thought that riding on the .frags section name of
the XDP program was a good idea. You do not have to introduce yet
another flag and all AF_XDP users must load an XDP program anyway
to get any traffic up to the socket, so why not just say that the XDP
program decides if the AF_XDP socket should get multi-buffer packets
or not? The problem is that we can create an AF_XDP socket that is Tx
only and that works without having to load an XDP program at
all. Another problem is that the XDP program might change during the
execution, so we would have to check this for every single packet.

Here is the observed throughput when compared without any multi-buffer
changes and measured with xdpsock prog for 64B packets (+ is
improvement) is about same with a small drop for rx_drop for copy mode,
zero-copy mode is more sensitive and as shown below rxdrop gets around
5% performance drop. Note that this drop combines from core + driver
support, whereas copy mode had already driver support in place.

Mode       rxdrop       l2fwd     txonly
xdp-zc      -5%         -3%         -2%
xdp-drv     -1.2%        0%         +2%
xdp-skb     -0.6%       -1%         +2%

Thank you,
Tirthendu, Magnus and Maciej


Maciej Fijalkowski (8):
  xsk: prepare both copy and zero-copy modes to co-exist
  xsk: allow core/drivers to test EOP bit
  xsk: support mbuf on ZC RX
  ice: xsk: add RX multi-buffer support
  xsk: support ZC Tx multi-buffer in batch API
  xsk: report zero-copy multi-buffer capability via xdp_features
  ice: xsk: Tx multi-buffer support
  selftests/xsk: reset NIC settings to default after running test suite

Magnus Karlsson (7):
  xsk: add multi-buffer documentation
  selftests/xsk: transmit and receive multi-buffer packets
  selftests/xsk: add basic multi-buffer test
  selftests/xsk: add unaligned mode test for multi-buffer
  selftests/xsk: add invalid descriptor test for multi-buffer
  selftests/xsk: add metadata copy test for multi-buff
  selftests/xsk: add test for too many frags

Tirthendu Sarkar (7):
  xsk: prepare 'options' in xdp_desc for multi-buffer use
  xsk: introduce XSK_USE_SG bind flag for xsk socket
  xsk: move xdp_buff's data length check to xsk_rcv_check
  xsk: add support for AF_XDP multi-buffer on Rx path
  xsk: introduce wrappers and helpers for supporting multi-buffer in Tx
    path
  xsk: add support for AF_XDP multi-buffer on Tx path
  xsk: discard zero length descriptors in Tx path

 Documentation/netlink/specs/netdev.yaml       |   5 +
 Documentation/networking/af_xdp.rst           | 177 +++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   9 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 221 ++++++---
 include/net/xdp_sock.h                        |   7 +
 include/net/xdp_sock_drv.h                    |  54 +++
 include/net/xsk_buff_pool.h                   |   7 +
 include/uapi/linux/if_xdp.h                   |  13 +
 include/uapi/linux/netdev.h                   |   5 +-
 net/core/filter.c                             |   7 +-
 net/xdp/xsk.c                                 | 362 ++++++++++----
 net/xdp/xsk_buff_pool.c                       |   8 +
 net/xdp/xsk_queue.h                           |  91 ++--
 tools/include/uapi/linux/if_xdp.h             |   9 +
 tools/include/uapi/linux/netdev.h             |   5 +-
 .../selftests/bpf/progs/xsk_xdp_progs.c       |   6 +-
 tools/testing/selftests/bpf/test_xsk.sh       |   5 +
 tools/testing/selftests/bpf/xsk.c             | 136 +++++-
 tools/testing/selftests/bpf/xsk.h             |   2 +
 tools/testing/selftests/bpf/xsk_prereqs.sh    |   7 +
 tools/testing/selftests/bpf/xskxceiver.c      | 447 +++++++++++++++---
 tools/testing/selftests/bpf/xskxceiver.h      |  20 +-
 23 files changed, 1352 insertions(+), 253 deletions(-)

-- 
2.34.1


