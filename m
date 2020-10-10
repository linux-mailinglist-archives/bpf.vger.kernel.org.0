Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56F128A46C
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgJJXkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 19:40:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:55530 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgJJXkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 19:40:10 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kROT9-0008Gv-Ph; Sun, 11 Oct 2020 01:40:07 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, yhs@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v6 0/6] Follow-up BPF helper improvements
Date:   Sun, 11 Oct 2020 01:40:00 +0200
Message-Id: <20201010234006.7075-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25953/Sat Oct 10 15:55:36 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series addresses most of the feedback [0] that was to be followed
up from the last series, that is, UAPI helper comment improvements and
getting rid of the ifindex obj file hacks in the selftest by using a
BPF map instead. The __sk_buff data/data_end pointer work, I'm planning
to do in a later round as well as the mem*() BPF improvements we have
in Cilium for libbpf. Next, the series adds two features, i) a helper
called redirect_peer() to improve latency on netns switch, and ii) to
allow map in map with dynamic inner array map sizes. Selftests for each
are added as well. For details, please check individual patches, thanks!

  [0] https://lore.kernel.org/bpf/cover.1601477936.git.daniel@iogearbox.net/

v5 -> v6:
  - Going with Andrii's suggestion to make the misconfigured verifier
    test more robust, and only probe on -EOPNOTSUPP (Andrii)
v4 -> v5:
  - Replace cnt == -EOPNOTSUPP check with cnt < 0; I've used < 0
    here as I think it's useful to keep the existing cnt == 0 ||
    cnt >= ARRAY_SIZE(insn_buf) for error detection (Andrii)
v3 -> v4:
  - Rename new array map flag to BPF_F_INNER_MAP (Alexei)
v2 -> v3:
  - Remove tab that slipped into uapi helper desc (Jakub)
  - Rework map in map for array to error from map_gen_lookup (Andrii)
v1 -> v2:
  - Fixed selftest comment wrt inner1/inner2 value (Yonghong)

Daniel Borkmann (6):
  bpf: improve bpf_redirect_neigh helper description
  bpf: add redirect_peer helper
  bpf: allow for map-in-map with dynamic inner array map entries
  bpf, selftests: add test for different array inner map size
  bpf, selftests: make redirect_neigh test more extensible
  bpf, selftests: add redirect_peer selftest

 drivers/net/veth.c                            |   9 +
 include/linux/bpf.h                           |   2 +-
 include/linux/netdevice.h                     |   4 +
 include/uapi/linux/bpf.h                      |  30 ++-
 kernel/bpf/arraymap.c                         |  17 +-
 kernel/bpf/hashtab.c                          |   6 +-
 kernel/bpf/verifier.c                         |   6 +-
 net/core/dev.c                                |  15 +-
 net/core/filter.c                             |  54 ++++-
 net/xdp/xskmap.c                              |   2 +-
 tools/include/uapi/linux/bpf.h                |  30 ++-
 .../selftests/bpf/prog_tests/btf_map_in_map.c |  39 +++-
 .../selftests/bpf/progs/test_btf_map_in_map.c |  43 ++++
 .../selftests/bpf/progs/test_tc_neigh.c       |  40 ++--
 .../selftests/bpf/progs/test_tc_peer.c        |  45 ++++
 tools/testing/selftests/bpf/test_tc_neigh.sh  | 168 ---------------
 .../testing/selftests/bpf/test_tc_redirect.sh | 204 ++++++++++++++++++
 17 files changed, 489 insertions(+), 225 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_peer.c
 delete mode 100755 tools/testing/selftests/bpf/test_tc_neigh.sh
 create mode 100755 tools/testing/selftests/bpf/test_tc_redirect.sh

-- 
2.17.1

