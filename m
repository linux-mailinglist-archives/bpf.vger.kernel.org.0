Return-Path: <bpf+bounces-5285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59995759699
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CCA28186F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF20154A4;
	Wed, 19 Jul 2023 13:25:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC90101F4;
	Wed, 19 Jul 2023 13:25:05 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF728FD;
	Wed, 19 Jul 2023 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773102; x=1721309102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5atvwtzpEOJEseHHuIHuA1PMoC4iKRRs9GBBRMUrrXU=;
  b=araJ9BoH1HCB1JIURr9+nyQJMXbjXoPgJRxEkVJnDc/cg4kMKoFtKzUx
   IwkSOk8puvniz/IEALFKItdgQsVpsi3UOD1BL3kKfPNJhA9PwPH+15Ta+
   pR89L3gG0vE5npTkg2JmXxc9E3wmcbv1sJT1Jl265sFeEEmdVHMV47aVj
   wqHu1oiluBKKzvuvb4t93e0OgesSDJIVqn1fM8RyPn/DBscETLm7J4azg
   bRBro+3XOVIO+gjapoJGDCtBOLg3c1vuaG0NppIMxRvgN3KLo1xtT0oRz
   8uUqkKt/6i8zD2sT3XTD9DAC3BcM6iIUMkeAuAfap87SSoD2XSZYKGAEl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920483"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920483"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717977983"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717977983"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:33 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v7 bpf-next 00/24] xsk: multi-buffer support
Date: Wed, 19 Jul 2023 15:23:57 +0200
Message-Id: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v6->v7:
- rebase...[Alexei]

v5->v6:
- update bpf_xdp_query_opts__last_field in patch 10 [Alexei]

v4->v5:
- align options argument size to match options from xdp_desc [Benjamin]
- cleanup skb from xdp_sock on socket termination [Toke]
- introduce new netlink attribute for letting user space know about Tx
  frag limit; this substitutes xdp_features flag previously dedicated
  for setting ZC multi-buffer support [Toke, Jakub]
- include i40e ZC multi-buffer support
- enable TOO_MANY_FRAGS for ZC on xskxceiver; this is now possible due
  to netlink attribute mentioned two bullets above

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
  supports. User space can discover this via newly introduced
  NETDEV_A_DEV_XDP_ZC_MAX_SEGS netlink attribute.

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

We had to introduce a new bind flag (XDP_USE_SG) on the AF_XDP level to
enable multi-buffer support. The reason we need to differentiate between
non multi-buffer and multi-buffer is the behaviour when the kernel gets
a packet that is larger than the frame size. Without multi-buffer, this
packet is dropped and marked in the stats. With multi-buffer on, we want
to split it up into multiple frames instead.

At the start, we thought that riding on the .frags section name of
the XDP program was a good idea. You do not have to introduce yet
another flag and all AF_XDP users must load an XDP program anyway
to get any traffic up to the socket, so why not just say that the XDP
program decides if the AF_XDP socket should get multi-buffer packets
or not? The problem is that we can create an AF_XDP socket that is Tx
only and that works without having to load an XDP program at
all. Another problem is that the XDP program might change during the
execution, so we would have to check this for every single packet.

Here is the observed throughput when compared to a codebase without any
multi-buffer changes and measured with xdpsock for 64B packets.
Apparently ZC Tx takes a hit from explicit zero length descriptors
validation. Overall, in terms of ZC performance, there is a room for
improvement, but for now we think this work is in a good shape in terms
of correctness and functionality. We were targetting for up to 5%
overhead though. Note that ZC performance drops come from core + driver
support being combined, whereas copy mode had already driver support in
place.

Mode     rxdrop       l2fwd       txonly
ice-zc    -4%          -7%         -6%
i40e-zc   -7%          -6%         -7%
drv       -1.2%         0%         +2%
skb       -0.6%        -1%         +2%

Thank you,
Tirthendu, Magnus and Maciej


Maciej Fijalkowski (8):
  xsk: prepare both copy and zero-copy modes to co-exist
  xsk: allow core/drivers to test EOP bit
  xsk: add new netlink attribute dedicated for ZC max frags
  xsk: support mbuf on ZC RX
  ice: xsk: add RX multi-buffer support
  xsk: support ZC Tx multi-buffer in batch API
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

Tirthendu Sarkar (9):
  xsk: prepare 'options' in xdp_desc for multi-buffer use
  xsk: introduce XSK_USE_SG bind flag for xsk socket
  xsk: move xdp_buff's data length check to xsk_rcv_check
  xsk: add support for AF_XDP multi-buffer on Rx path
  xsk: introduce wrappers and helpers for supporting multi-buffer in Tx
    path
  xsk: add support for AF_XDP multi-buffer on Tx path
  xsk: discard zero length descriptors in Tx path
  i40e: xsk: add RX multi-buffer support
  i40e: xsk: add TX multi-buffer support

 Documentation/netlink/specs/netdev.yaml       |   6 +
 Documentation/networking/af_xdp.rst           | 211 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 101 +++-
 drivers/net/ethernet/intel/ice/ice_base.c     |   9 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 221 ++++++---
 include/linux/netdevice.h                     |   1 +
 include/net/xdp_sock.h                        |   7 +
 include/net/xdp_sock_drv.h                    |  54 +++
 include/net/xsk_buff_pool.h                   |   7 +
 include/uapi/linux/if_xdp.h                   |  13 +
 include/uapi/linux/netdev.h                   |   1 +
 net/core/dev.c                                |   1 +
 net/core/filter.c                             |   7 +-
 net/core/netdev-genl.c                        |   8 +
 net/xdp/xsk.c                                 | 365 ++++++++++----
 net/xdp/xsk_buff_pool.c                       |   7 +
 net/xdp/xsk_queue.h                           |  95 ++--
 tools/include/uapi/linux/if_xdp.h             |   9 +
 tools/include/uapi/linux/netdev.h             |   1 +
 tools/lib/bpf/libbpf.h                        |   3 +-
 tools/lib/bpf/netlink.c                       |   5 +
 .../selftests/bpf/progs/xsk_xdp_progs.c       |   6 +-
 tools/testing/selftests/bpf/test_xsk.sh       |   5 +
 tools/testing/selftests/bpf/xsk.c             | 136 +++++-
 tools/testing/selftests/bpf/xsk.h             |   2 +
 tools/testing/selftests/bpf/xsk_prereqs.sh    |   7 +
 tools/testing/selftests/bpf/xskxceiver.c      | 458 +++++++++++++++---
 tools/testing/selftests/bpf/xskxceiver.h      |  21 +-
 32 files changed, 1505 insertions(+), 275 deletions(-)

-- 
2.34.1


