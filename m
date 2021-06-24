Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7B3B337B
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFXQIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhFXQIk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=11IrsOSzBoxczXraDEKVGDeksPezKPK6+d2pMyPVA9g=;
        b=QL4hkLvfzZiWriIbmv79g2hSOP3H7erPvdSRUGj9lFZzjcUowwhiNZ7/9M3mJKjm5vT/XX
        KMZGKrkjZKl1zxZj/IvfAvJaliLjH+SzwwXI45iCStw5kPJfRxrL9uWygdYZtlzeiYghSs
        RPl7oOFn8PyKW3sHCVP4HdliD+aPwog=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-ew-2TgZhNfaaPBx8OTSNuA-1; Thu, 24 Jun 2021 12:06:19 -0400
X-MC-Unique: ew-2TgZhNfaaPBx8OTSNuA-1
Received: by mail-ed1-f72.google.com with SMTP id j19-20020aa7c4130000b029039497d5cdbeso3581089edq.15
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11IrsOSzBoxczXraDEKVGDeksPezKPK6+d2pMyPVA9g=;
        b=W4B7pmTtsoMXi3GKWHbR5l93yheDwoKnup9pYPAORii6YQu4zAgbYmwPtCblv+PItb
         I4HZ0uMIxnpqwWJXCYyD6OEINeBg4dpPsJBxXTKkxLntRLdOH3L4jH46LAuOKVxWyAuJ
         cFQmXl9phoE+3Xc9+Zcpj2SbIbSaxTwTnSTJm4N3edgaq/7ASD56Z8Bz4tH/aG+5NgR1
         3C99IG/9//8Mh5+IpHKAVGr7mBfto/696cS8mDGn3Cbk7JIOVyuGlONjlUgrO2dIo/US
         sy5ui1IpRam63kS9x5AwxbYMzqZNJ4kpwSJyrNL/MMlw1y/ZNNkVIU0JVLFalusjLpCs
         MuXw==
X-Gm-Message-State: AOAM533xed99xHQfjWJp/UfBfRTcU82HABv6zBv1pbPg+GIjtZgD6bYC
        Z+lEbGKeTeAx5Bkn+yHPLGvdGCe/IAQwAb5VycJ6jCy/ZBYN598L71uxSSJ+DiMnn0gSgC9/zT/
        twMKgCPgS0xF1
X-Received: by 2002:a17:907:3d8e:: with SMTP id he14mr6078378ejc.374.1624550776466;
        Thu, 24 Jun 2021 09:06:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfgAC1/FiXU4gdsVOVYPQiNILedqNklNl7J/mUUEf3ENWZ5aQtPrR2WRebMFpqwhtYnNzItw==
X-Received: by 2002:a17:907:3d8e:: with SMTP id he14mr6078325ejc.374.1624550775949;
        Thu, 24 Jun 2021 09:06:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ce3sm1415155ejc.53.2021.06.24.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:06:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2713C180731; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v5 00/19] Clean up and document RCU-based object protection for XDP and TC BPF
Date:   Thu, 24 Jun 2021 18:05:50 +0200
Message-Id: <20210624160609.292325-1-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During the discussion[0] of Hangbin's multicast patch series, Martin pointed out
that the lifetime of the RCU-protected  map entries used by XDP_REDIRECT is by
no means obvious. I promised to look into cleaning this up, and Paul helpfully
provided some hints and a new unrcu_pointer() helper to aid in this.

It seems[1] that back in the early days of XDP, local_bh_disable() did not
provide RCU protection, which is why the rcu_read_lock() calls were added
to drivers in the first place. But according to Paul[2], in recent kernels
a local_bh_disable()/local_bh_enable() pair functions as one big RCU
read-side section, so no further protection is needed. This even applies to
-rt kernels, which has an explicit rcu_read_lock() in place as part of the
local_bh_disable()[3].

This patch series is mostly a documentation exercise, cleaning up the
description of the lifetime expectations and adding __rcu annotations so
sparse and lockdep can help verify it.

Patches 1-4 are preparatory: Patch 1 adds Paul's unrcu_pointer()
helper (which has already been added to his tree), which we need for some
of the operations in devmap, patches 2 and 3 update the RCU documentation
and patch 4 adds bh context as a valid condition for map lookups. Patch 5
is the main bit that adds the __rcu annotations and updates documentation
comments. Finally, patch 6 removes unneeded rcu_read_lock()s from TC BPF,
and the rest are patches updating the drivers, with one patch per distinct
maintainer.

Unfortunately I don't have any hardware to test any of the driver patches;
Jesper helpfully verified that it doesn't break anything on i40e, but the rest
of the driver patches are only compile-tested.

[0] https://lore.kernel.org/bpf/20210415173551.7ma4slcbqeyiba2r@kafai-mbp.dhcp.thefacebook.com/
[1] https://lore.kernel.org/bpf/c5192ab3-1c05-8679-79f2-59d98299095b@iogearbox.net/
[2] https://lore.kernel.org/bpf/20210417002301.GO4212@paulmck-ThinkPad-P17-Gen-1/
[3] https://lore.kernel.org/bpf/20210419165837.GA975577@paulmck-ThinkPad-P17-Gen-1/

Changelog:
v5:
  - Rebase to bpf-next and fix build error
v4:
  - Move comment about RCU protection into core instead of leaving it in
    drivers
  - Also remove rcu_read_lock() around TC BPF program execution
  - Fold in a couple of patches from Paul updating the RCU documentation
v3:
  - Remove one other unnecessary change to hlist_for_each_entry_rcu()
  - Carry forward another ACK
v2:
  - Add a comment about RCU protection to the drivers where rcu_read_lock()
    is removed
  - Drop unnecessary patch 3 which changed dev_get_by_index_rcu()
  - Add some more text with the history to cover letter
  - Fix a few places where the wrong RCU checks were used in cpumap and
    xskmap code
  - Carry forward ACKs

Paul E. McKenney (2):
  rcu: Create an unrcu_pointer() to remove __rcu from a pointer
  doc: Clarify and expand RCU updaters and corresponding readers

Toke Høiland-Jørgensen (17):
  doc: Give XDP as example of non-obvious RCU reader/updater pairing
  bpf: allow RCU-protected lookups to happen from bh context
  xdp: add proper __rcu annotations to redirect map entries
  sched: remove unneeded rcu_read_lock() around BPF program invocation
  ena: remove rcu_read_lock() around XDP program invocation
  bnxt: remove rcu_read_lock() around XDP program invocation
  thunderx: remove rcu_read_lock() around XDP program invocation
  freescale: remove rcu_read_lock() around XDP program invocation
  net: intel: remove rcu_read_lock() around XDP program invocation
  marvell: remove rcu_read_lock() around XDP program invocation
  mlx4: remove rcu_read_lock() around XDP program invocation
  nfp: remove rcu_read_lock() around XDP program invocation
  qede: remove rcu_read_lock() around XDP program invocation
  sfc: remove rcu_read_lock() around XDP program invocation
  netsec: remove rcu_read_lock() around XDP program invocation
  stmmac: remove rcu_read_lock() around XDP program invocation
  net: ti: remove rcu_read_lock() around XDP program invocation

 Documentation/RCU/checklist.rst               | 55 ++++++++++++-------
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  3 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  2 -
 .../net/ethernet/cavium/thunder/nicvf_main.c  |  2 -
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  8 +--
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  3 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  2 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  3 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  3 -
 drivers/net/ethernet/intel/igb/igb_main.c     |  2 -
 drivers/net/ethernet/intel/igc/igc_main.c     |  7 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  3 -
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 -
 drivers/net/ethernet/marvell/mvneta.c         |  2 -
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 --
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  8 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  2 -
 drivers/net/ethernet/qlogic/qede/qede_fp.c    |  6 --
 drivers/net/ethernet/sfc/rx.c                 |  9 +--
 drivers/net/ethernet/socionext/netsec.c       |  3 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +---
 drivers/net/ethernet/ti/cpsw_priv.c           | 10 +---
 include/linux/filter.h                        |  8 +--
 include/linux/rcupdate.h                      | 14 +++++
 include/net/xdp_sock.h                        |  2 +-
 kernel/bpf/cpumap.c                           | 13 +++--
 kernel/bpf/devmap.c                           | 49 +++++++----------
 kernel/bpf/hashtab.c                          | 21 ++++---
 kernel/bpf/helpers.c                          |  6 +-
 kernel/bpf/lpm_trie.c                         |  6 +-
 net/core/filter.c                             | 28 ++++++++++
 net/sched/act_bpf.c                           |  2 -
 net/sched/cls_bpf.c                           |  3 -
 net/xdp/xsk.c                                 |  4 +-
 net/xdp/xsk.h                                 |  4 +-
 net/xdp/xskmap.c                              | 29 ++++++----
 38 files changed, 164 insertions(+), 182 deletions(-)

-- 
2.32.0

