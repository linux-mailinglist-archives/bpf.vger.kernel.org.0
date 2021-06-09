Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1EA3A1119
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhFIKf3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234179AbhFIKf3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BrObvSYupYh6qyBf2GV1ZSOskI6VA5gZ5J5abwVvhBw=;
        b=Wud7oJ5xwhkiEbWeReWXz5sU3QbY+mbdPoLp9+O2/6R4LymuZ/AeTbSF1iVI6JlgI/6wUl
        v9rpU9tqeQ8ocOYy0YgspFcaUVfHStL8yB+30w3NQX6YXc5s6DjOv41BD7xmhv5sQ6nzFo
        Fa8HoSrzwir1DVdYfmpCtieRP/sRc1E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221--MfotYkFOx-YJOaMwDx_5w-1; Wed, 09 Jun 2021 06:33:33 -0400
X-MC-Unique: -MfotYkFOx-YJOaMwDx_5w-1
Received: by mail-ej1-f71.google.com with SMTP id w1-20020a1709064a01b02903f1e4e947c9so6372189eju.16
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrObvSYupYh6qyBf2GV1ZSOskI6VA5gZ5J5abwVvhBw=;
        b=t/9uUuyqZamwzXXNX6FNzOT41aQce+zuyPjtitwLerZ4HTULnzhgq7NdC5muLORw+F
         JwiTtIA14YwnV1lb5H4DeLqI2dFXD823kIzWZQE1ZH3iHjiY1B/V5AOqdNRot2SfYWHP
         f2TcsBwc2cBSqntG38j8QYDkg06d5xTmUqpiCt+SiwHaT0dIgMuRP4m/9lqtISNBPznK
         zYimtUNAOazI1klHXgNJ831cmEFFOoFRfTv4feNQSUVO88umRV/45Y9+yRgkV6ZvFQWi
         EYPLnMQdNbLWHwxEPDVRidMngLzUCgVXjZgmvAw7Il9TO8R0ui7DK+zZsZhGjlW5EUgl
         Lnag==
X-Gm-Message-State: AOAM532EPcNaKYgariwtIX3zJZex/t4yspazuGB8JMs9QFBWBsYrnzP/
        CRylgeqi2Xlt+LmWzSeiHbX2Bd4u5py7y9Abvcm5YEBTT5fa0zme46hpwGemGMtAV9Z7yZLLg7T
        jx+bcQovYPMkC
X-Received: by 2002:aa7:c9ce:: with SMTP id i14mr29983872edt.148.1623234811963;
        Wed, 09 Jun 2021 03:33:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyqDm/l3QgRMbGJvrFjaLDbXtKnR0CrFHvo+w5NyHk7473MTiGLqVu7POym5G1im71jelelg==
X-Received: by 2002:aa7:c9ce:: with SMTP id i14mr29983847edt.148.1623234811527;
        Wed, 09 Jun 2021 03:33:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bd3sm974496edb.34.2021.06.09.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:33:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 54B031802A4; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next 00/17] Clean up and document RCU-based object protection for XDP_REDIRECT
Date:   Wed,  9 Jun 2021 12:33:09 +0200
Message-Id: <20210609103326.278782-1-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
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

This is mostly a documentation exercise, clearing up the description of the
lifetime expectations and adding __rcu annotations so sparse and lockdep can
help verify it.

Patches 1-2 are prepatory: Patch 1 adds Paul's unrcu_pointer() helper (which has
already been added to his tree) and patch 2 is a small fix for
dev_get_by_index_rcu() so lockdep understands _bh-disabled access to it. Patch 3
is the main bit that adds the __rcu annotations and updates documentation
comments, and the rest are patches updating the drivers, with one patch per
distinct maintainer.

Unfortunately I don't have any hardware to test any of the driver patches;
Jesper helpfully verified that it doesn't break anything on i40e, but the rest
of the driver patches are only compile-tested.

[0] https://lore.kernel.org/bpf/20210415173551.7ma4slcbqeyiba2r@kafai-mbp.dhcp.thefacebook.com/

Paul E. McKenney (1):
  rcu: Create an unrcu_pointer() to remove __rcu from a pointer

Toke Høiland-Jørgensen (16):
  bpf: allow RCU-protected lookups to happen from bh context
  dev: add rcu_read_lock_bh_held() as a valid check when getting a RCU
    dev ref
  xdp: add proper __rcu annotations to redirect map entries
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

 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  3 --
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  2 -
 .../net/ethernet/cavium/thunder/nicvf_main.c  |  2 -
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  8 +--
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  3 --
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  2 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  6 +--
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 +--
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 +--
 drivers/net/ethernet/intel/igb/igb_main.c     |  2 -
 drivers/net/ethernet/intel/igc/igc_main.c     |  7 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  6 +--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 -
 drivers/net/ethernet/marvell/mvneta.c         |  2 -
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 --
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  8 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  2 -
 drivers/net/ethernet/qlogic/qede/qede_fp.c    |  6 ---
 drivers/net/ethernet/sfc/rx.c                 |  9 +---
 drivers/net/ethernet/socionext/netsec.c       |  3 --
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +---
 drivers/net/ethernet/ti/cpsw_priv.c           | 10 +---
 include/linux/rcupdate.h                      | 14 +++++
 include/net/xdp_sock.h                        |  2 +-
 kernel/bpf/cpumap.c                           | 14 +++--
 kernel/bpf/devmap.c                           | 52 ++++++++-----------
 kernel/bpf/hashtab.c                          | 21 +++++---
 kernel/bpf/helpers.c                          |  6 +--
 kernel/bpf/lpm_trie.c                         |  6 ++-
 net/core/dev.c                                |  2 +-
 net/core/filter.c                             | 28 ++++++++++
 net/xdp/xsk.c                                 |  4 +-
 net/xdp/xsk.h                                 |  4 +-
 net/xdp/xskmap.c                              | 29 ++++++-----
 35 files changed, 134 insertions(+), 159 deletions(-)

-- 
2.31.1

