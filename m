Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62993F2FB2
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbhHTPmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 11:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241039AbhHTPmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 11:42:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EE9560FE6;
        Fri, 20 Aug 2021 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629474091;
        bh=Q4Y/Mi73XVONIxpjJQ8TbBlUPQ/wBcBTt+lWijhPT2c=;
        h=From:To:Cc:Subject:Date:From;
        b=lOl4LfQMvEPWsHoCsQlBU2vPmpN9MqNWrLozqbzIo4jJX9pbwsb7D8Lgp/YocH8l6
         vyXl1Ado2VabARytYgbpzMXREEtExJAXyVRn5cgnOFo7VojC5OvT1WwJRhwTsTCk/+
         kFYvNEbCsf72jYzi/TVJJ7a8zfTHeo+PhvLgHE40Ojk35fVhTGsTh4g33gCmQcizEc
         9ooCW5p/E1mw2/xHT9dcGAQcG4hIVzMxpvZ59pxr+JauCKy3q/aZ9uBJDhKqr5v6mo
         dexajGvUo3f5UqukM6ZZ0x/6Jkb6PpwJEFbpSCNuQAOA//J8Duc3ZRsLcMEiOS1b21
         /5JvvVI09TB/w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: [PATCH v12 bpf-next 00/18] mvneta: introduce XDP multi-buffer support
Date:   Fri, 20 Aug 2021 17:40:13 +0200
Message-Id: <cover.1629473233.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series introduce XDP multi-buffer support. The mvneta driver is
the first to support these new "non-linear" xdp_{buff,frame}. Reviewers
please focus on how these new types of xdp_{buff,frame} packets
traverse the different layers and the layout design. It is on purpose
that BPF-helpers are kept simple, as we don't want to expose the
internal layout to allow later changes.

The main idea for the new multi-buffer layout is to reuse the same
structure used for non-linear SKB. This rely on the "skb_shared_info"
struct at the end of the first buffer to link together subsequent
buffers. Keeping the layout compatible with SKBs is also done to ease
and speedup creating a SKB from an xdp_{buff,frame}.
Converting xdp_frame to SKB and deliver it to the network stack is shown
in patch 05/18 (e.g. cpumaps).

A multi-buffer bit (mb) has been introduced in the flags field of xdp_{buff,frame}
structure to notify the bpf/network layer if this is a xdp multi-buffer frame
(mb = 1) or not (mb = 0).
The mb bit will be set by a xdp multi-buffer capable driver only for
non-linear frames maintaining the capability to receive linear frames
without any extra cost since the skb_shared_info structure at the end
of the first buffer will be initialized only if mb is set.
Moreover the flags field in xdp_{buff,frame} will be reused even for
xdp rx csum offloading in future series.

Typical use cases for this series are:
- Jumbo-frames
- Packet header split (please see Google’s use-case @ NetDevConf 0x14, [0])
- TSO/GRO

The two following ebpf helpers (and related selftests) has been introduced:
- bpf_xdp_adjust_data:
  Move xdp_md->data and xdp_md->data_end pointers in subsequent fragments
  according to the offset provided by the ebpf program. This helper can be
  used to read/write values in frame payload.
- bpf_xdp_get_buff_len:
  Return the total frame size (linear + paged parts)

bpf_xdp_adjust_tail and bpf_xdp_copy helpers have been modified to take into
account xdp multi-buff frames.

More info about the main idea behind this approach can be found here [1][2].

Changes since v11:
- add missing static to bpf_xdp_get_buff_len_proto structure
- fix bpf_xdp_adjust_data helper when offset is smaller than linear area length.

Changes since v10:
- move xdp->data to the requested payload offset instead of to the beginning of
  the fragment in bpf_xdp_adjust_data()

Changes since v9:
- introduce bpf_xdp_adjust_data helper and related selftest
- add xdp_frags_size and xdp_frags_tsize fields in skb_shared_info
- introduce xdp_update_skb_shared_info utility routine in ordere to not reset
  frags array in skb_shared_info converting from a xdp_buff/xdp_frame to a skb 
- simplify bpf_xdp_copy routine

Changes since v8:
- add proper dma unmapping if XDP_TX fails on mvneta for a xdp multi-buff
- switch back to skb_shared_info implementation from previous xdp_shared_info
  one
- avoid using a bietfield in xdp_buff/xdp_frame since it introduces performance
  regressions. Tested now on 10G NIC (ixgbe) to verify there are no performance
  penalties for regular codebase
- add bpf_xdp_get_buff_len helper and remove frame_length field in xdp ctx
- add data_len field in skb_shared_info struct
- introduce XDP_FLAGS_FRAGS_PF_MEMALLOC flag

Changes since v7:
- rebase on top of bpf-next
- fix sparse warnings
- improve comments for frame_length in include/net/xdp.h

Changes since v6:
- the main difference respect to previous versions is the new approach proposed
  by Eelco to pass full length of the packet to eBPF layer in XDP context
- reintroduce multi-buff support to eBPF kself-tests
- reintroduce multi-buff support to bpf_xdp_adjust_tail helper
- introduce multi-buffer support to bpf_xdp_copy helper
- rebase on top of bpf-next

Changes since v5:
- rebase on top of bpf-next
- initialize mb bit in xdp_init_buff() and drop per-driver initialization
- drop xdp->mb initialization in xdp_convert_zc_to_xdp_frame()
- postpone introduction of frame_length field in XDP ctx to another series
- minor changes

Changes since v4:
- rebase ontop of bpf-next
- introduce xdp_shared_info to build xdp multi-buff instead of using the
  skb_shared_info struct
- introduce frame_length in xdp ctx
- drop previous bpf helpers
- fix bpf_xdp_adjust_tail for xdp multi-buff
- introduce xdp multi-buff self-tests for bpf_xdp_adjust_tail
- fix xdp_return_frame_bulk for xdp multi-buff

Changes since v3:
- rebase ontop of bpf-next
- add patch 10/13 to copy back paged data from a xdp multi-buff frame to
  userspace buffer for xdp multi-buff selftests

Changes since v2:
- add throughput measurements
- drop bpf_xdp_adjust_mb_header bpf helper
- introduce selftest for xdp multibuffer
- addressed comments on bpf_xdp_get_frags_count
- introduce xdp multi-buff support to cpumaps

Changes since v1:
- Fix use-after-free in xdp_return_{buff/frame}
- Introduce bpf helpers
- Introduce xdp_mb sample program
- access skb_shared_info->nr_frags only on the last fragment

Changes since RFC:
- squash multi-buffer bit initialization in a single patch
- add mvneta non-linear XDP buff support for tx side

[0] https://netdevconf.info/0x14/session.html?talk-the-path-to-tcp-4k-mtu-and-rx-zerocopy
[1] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp-multi-buffer01-design.org
[2] https://netdevconf.info/0x14/session.html?tutorial-add-XDP-support-to-a-NIC-driver (XDPmulti-buffers section)

Eelco Chaudron (3):
  bpf: add multi-buff support to the bpf_xdp_adjust_tail() API
  bpf: add multi-buffer support to xdp copy helpers
  bpf: update xdp_adjust_tail selftest to include multi-buffer

Lorenzo Bianconi (15):
  net: skbuff: add size metadata to skb_shared_info for xdp
  xdp: introduce flags field in xdp_buff/xdp_frame
  net: mvneta: update mb bit before passing the xdp buffer to eBPF layer
  net: mvneta: simplify mvneta_swbm_add_rx_fragment management
  net: xdp: add xdp_update_skb_shared_info utility routine
  net: marvell: rely on xdp_update_skb_shared_info utility routine
  xdp: add multi-buff support to xdp_return_{buff/frame}
  net: mvneta: add multi buffer support to XDP_TX
  net: mvneta: enable jumbo frames for XDP
  bpf: introduce bpf_xdp_get_buff_len helper
  bpf: move user_size out of bpf_test_init
  bpf: introduce multibuff support to bpf_prog_test_run_xdp()
  bpf: test_run: add xdp_shared_info pointer in bpf_test_finish
    signature
  net: xdp: introduce bpf_xdp_adjust_data helper
  bpf: add bpf_xdp_adjust_data selftest

 drivers/net/ethernet/marvell/mvneta.c         | 204 ++++++++++-------
 include/linux/skbuff.h                        |   6 +-
 include/net/xdp.h                             |  95 +++++++-
 include/uapi/linux/bpf.h                      |  39 ++++
 kernel/trace/bpf_trace.c                      |   3 +
 net/bpf/test_run.c                            | 117 ++++++++--
 net/core/filter.c                             | 213 +++++++++++++++++-
 net/core/xdp.c                                |  76 ++++++-
 tools/include/uapi/linux/bpf.h                |  39 ++++
 .../bpf/prog_tests/xdp_adjust_data.c          |  55 +++++
 .../bpf/prog_tests/xdp_adjust_tail.c          | 118 ++++++++++
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 151 +++++++++----
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  10 +-
 .../bpf/progs/test_xdp_adjust_tail_shrink.c   |  32 ++-
 .../selftests/bpf/progs/test_xdp_bpf2bpf.c    |   2 +-
 .../bpf/progs/test_xdp_update_frags.c         |  41 ++++
 16 files changed, 1036 insertions(+), 165 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_adjust_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_update_frags.c

-- 
2.31.1

