Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61187450950
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 17:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKOQOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 11:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231428AbhKOQOk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 11:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636992704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sdPNsUt5ET11fnQU5zA7SZiidRIb9KqsblL/TZmoJ+E=;
        b=gOthx3+xsnhGFKiYmi4TE0DCLJSykzrrl7+i58E0+3YEzgre1pGDbrmOu7KGreSe+CoNEm
        /qGSqeaXoXWAVW/fWY8cFg1ArvX+LXGf+6ba9Dr7ExKxILJGp//QmfarKUSTo5SC9gr2sK
        H6Lk3sgK0rJsBgjeOaqLmX32rxSiWf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-GZsYOxVYP1-B-u12Ah4NPw-1; Mon, 15 Nov 2021 11:11:41 -0500
X-MC-Unique: GZsYOxVYP1-B-u12Ah4NPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22D42802C8F;
        Mon, 15 Nov 2021 16:11:40 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A11B1100EBBE;
        Mon, 15 Nov 2021 16:11:29 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [RFC PATCH 0/2] bpf: do not WARN in bpf_warn_invalid_xdp_action()
Date:   Mon, 15 Nov 2021 17:10:42 +0100
Message-Id: <cover.1636987322.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The mentioned WARN is quite noisy, especially vs fuzzers and
apparently used only to track the relevant BPF program and/or
involved driver.

The first patch replace it with a pr_warn_once(), and the 2nd
patch allow dumps relevant info to track the reported issue.

This is quite invasive, but the mentioned WARN makes the hunt
for some bugs reported by syzkaller quite difficult.

Paolo Abeni (2):
  bpf: do not WARN in bpf_warn_invalid_xdp_action()
  bpf: let bpf_warn_invalid_xdp_action() report more info

 drivers/net/ethernet/amazon/ena/ena_netdev.c           | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c          | 2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c       | 2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c         | 2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c       | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c           | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c            | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c             | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c              | 2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c               | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c              | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c              | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c          | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c           | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c      | 2 +-
 drivers/net/ethernet/marvell/mvneta.c                  | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c        | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c             | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c       | 2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c    | 2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c             | 2 +-
 drivers/net/ethernet/sfc/rx.c                          | 2 +-
 drivers/net/ethernet/socionext/netsec.c                | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      | 2 +-
 drivers/net/ethernet/ti/cpsw_priv.c                    | 2 +-
 drivers/net/hyperv/netvsc_bpf.c                        | 2 +-
 drivers/net/tun.c                                      | 2 +-
 drivers/net/veth.c                                     | 4 ++--
 drivers/net/virtio_net.c                               | 4 ++--
 drivers/net/xen-netfront.c                             | 2 +-
 include/linux/filter.h                                 | 2 +-
 kernel/bpf/cpumap.c                                    | 4 ++--
 kernel/bpf/devmap.c                                    | 4 ++--
 net/core/dev.c                                         | 2 +-
 net/core/filter.c                                      | 8 ++++----
 36 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.33.1

