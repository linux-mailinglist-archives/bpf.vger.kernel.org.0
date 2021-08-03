Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702D13DE3BF
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhHCBD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:03:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232311AbhHCBD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:03:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327831"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327831"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480104"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:48 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 00/16] XDP hints and AF_XDP support
Date:   Mon,  2 Aug 2021 18:03:15 -0700
Message-Id: <20210803010331.39453-1-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While there's some work going on different aspects of the XDP hints, I'd like
to present and ask for comments on this patch series.

XDP hints/metadata is a way for the driver to transmit information regarding a
specific XDP frame along with the frame. Following current discussions and
based on top of Saeed's early patches, this series provides the XDP hints with
one (or two, depending on how you view it) use case: RX/TX timestamps for the
igc driver.

Keeping with Saeed's patches, to enable XDP hints usage, one has to first
enable it with bpftool like:

  bpftool net xdp set dev <iface> md_btf on

From the driver perspective, support for XDP hints is achieved by:

 - Adding support for XDP_SETUP_MD_BTF operation, where it can register the BTF.

 - Adding support for XDP_QUERY_MD_BTF so user space can retrieve the BTF id.

 - Adding the relevant data to the metadata area of the XDP frame.

    - One of this relevant data is the BTF id of the BTF in use.

In order to make use of the BPF CO-RE mechanism, this series makes the driver
name of the struct for the XDP hints be called `xdp_hints___<driver_name>` (in
this series, as I'm using igc driver, it becomes `xdp_hints___igc`). This
should help BPF programs, as they can simply refer to the struct as `xdp_hints`.

A common issue is how to standardize the names of the fields in the BTF. Here,
a series of macros is provided on the `include/net/xdp.h`, that goes by
`XDP_GENERIC_` prefixes. In there, the `btf_id` field was added, that needs
to be strategically positioned at the end of the struct. Also added are the
`rx_timestamp` and  `tx_timestamp` fields, as I believe they're generic as
well. The macros also provide `u32` and `u64` types. Besides, I also ended
up adding a `valid_map` field. It should help whoever is using the XDP hints
to be sure of what is valid in that hints. It also makes the driver life
simple, as it just uses a single struct and validates fields as it fills
them.

The BPF sample `xdp_sample_pkts` was modified to demonstrate the usage of XDP
hints on BPF programs. It's a very simple example, but it shows some nice
things about it. For instance, instead of getting the struct somehow before,
it uses CO-RE to simply name the XDP hint field it's interested in and
read it using `BPF_CORE_READ`. (I also tried to use `bpf_core_field_exists` to
make it even more dynamic, but couldn't get to build it. I mention why in the
example.)

Also, as much of my interest lies in the user space side, the one using
AF_XDP, to support it a few additional things were done.

Firstly, a new "driver info" is provided, to be obtained via
`ioctl(SIOCETHTOOL)`: "xdp_headroom". This is how much XDP headroom is
required by the driver. While not really important for the RX path (as the
driver already applies that headroom to the XDP frame), it's
important for the TX path, as here, it's the application responsibility to
factor in the XDP headroom area. (Note that the TX timestamp is obtained from
the XDP frame of the transmitted packet, when that frame goes back to the
completion queue.)

A series of helpers was also added to libbpf to help manage this headroom
area. They go by the prefix " xsk_umem__adjust_", to adjust consumer and
producer data and metadata.

In order to read the XDP hints from the memory, another series of helpers was
added. They read the BTF from the BTF id, and create a hashmap of the offsets
and sizes of the fields, that is then used to actually retrieve the data.

I modified the "xdpsock" example to show the use of XDP hints on the AF_XDP
world, along with the proposed API.

Finally, I know that Michal and Alexandr (and probably others that I don't
know) are working in this same front. This RFC is not to race any other work,
instead I hope it can help in the discussion of the best solution for the
XDP hints – and I truly think it brings value, specifically for the AF_XDP
usages.

Andre Guedes (1):
  igc: Fix race condition in PTP Tx code

Ederson de Souza (8):
  net/xdp: Support for generic XDP hints
  igc: XDP packet RX timestamp
  igc: XDP packet TX timestamp
  ethtool,igc: Add "xdp_headroom" driver info
  libbpf: Helpers to access XDP frame metadata
  libbpf: Helpers to access XDP hints based on BTF definitions
  samples/bpf: XDP hints AF_XDP example
  samples/bpf: Show XDP hints usage

Saeed Mahameed (4):
  bpf: add btf register/unregister API
  net/core: XDP metadata BTF netlink API
  tools/bpf: Query XDP metadata BTF ID
  tools/bpf: Add xdp set command for md btf

Vinicius Costa Gomes (3):
  igc: Retrieve the TX timestamp directly (instead of in a interrupt)
  igc: Add support for multiple in-flight TX timestamps
  igc: Use irq safe locks for timestamping

 drivers/net/ethernet/intel/igc/igc.h         |  49 ++-
 drivers/net/ethernet/intel/igc/igc_base.h    |   3 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   7 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 207 +++++++++++--
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 239 +++++++++-----
 drivers/net/ethernet/intel/igc/igc_regs.h    |  12 +
 drivers/net/ethernet/intel/igc/igc_xdp.c     |  93 ++++++
 drivers/net/ethernet/intel/igc/igc_xdp.h     |  11 +
 include/linux/btf.h                          |   9 +
 include/linux/netdevice.h                    |  15 +-
 include/net/xdp.h                            |  62 ++++
 include/uapi/linux/ethtool.h                 |   3 +
 include/uapi/linux/if_link.h                 |   2 +
 include/uapi/linux/if_xdp.h                  |   3 +
 kernel/bpf/btf.c                             | 155 ++++++++--
 net/core/dev.c                               |  54 ++++
 net/core/rtnetlink.c                         |  18 +-
 samples/bpf/xdp_sample_pkts_kern.c           |  21 ++
 samples/bpf/xdp_sample_pkts_user.c           |   4 +-
 samples/bpf/xdpsock_user.c                   | 146 ++++++++-
 tools/bpf/bpftool/main.h                     |   3 +-
 tools/bpf/bpftool/net.c                      |   7 +-
 tools/bpf/bpftool/netlink_dumper.c           |  21 +-
 tools/bpf/bpftool/xdp.c                      | 310 +++++++++++++++++++
 tools/include/uapi/linux/if_link.h           |   2 +
 tools/lib/bpf/libbpf.h                       |   2 +
 tools/lib/bpf/libbpf.map                     |  10 +
 tools/lib/bpf/netlink.c                      |  49 +++
 tools/lib/bpf/xsk.c                          | 203 ++++++++++++
 tools/lib/bpf/xsk.h                          |  22 ++
 31 files changed, 1579 insertions(+), 165 deletions(-)
 create mode 100644 tools/bpf/bpftool/xdp.c

-- 
2.32.0

