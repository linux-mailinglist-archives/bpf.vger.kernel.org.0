Return-Path: <bpf+bounces-5773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFF76036A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A7B2813E4
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF23913AD5;
	Tue, 25 Jul 2023 00:00:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50F134CC
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:00:01 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BD1729
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573d70da2dcso59674907b3.1
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243199; x=1690847999;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mb1j8LQVRs00LG4v/ZDtJyKdrYAUO/L1CQHpXM/CMbw=;
        b=JE/idUD1XwLgxZtdASbXBtVEWkJvBd7ZIW4j7n3sas8NWnjxxJ3YsmvpSub5z8hdYm
         +i0gfHcxDiPX5eIMV2V5DV++oTJZsKIEzKus3Tat962dZJcOhC9Yu6UApxtly9HBssdv
         0yBV3tN0zQIa0oQaR+QSuhTUtgBzk+yRH7VpQ5PyB0AHHqhVosMafKRGGpvX4ckg+dhE
         knf+uxIwYEU7rkxTm8lFqPAq1XZDTz9PAjzZ6FBCb1dNkHgJGQ0eKWH8URTjHcBXvVaY
         jIcmc6p3AwPhUrEvI8zntzgSe7QdoYGcr40ZENkr7eJtSC/aUPuWeQRUD73G6ibOhmgh
         kNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243199; x=1690847999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mb1j8LQVRs00LG4v/ZDtJyKdrYAUO/L1CQHpXM/CMbw=;
        b=CYfjR74Rzf7hnrOB0ExShEx2DyF/bYjExPrhH6afvj6eGDU2WVVeke2KoRW47CR2JA
         8iDR4HknJqt0ZD+JxU/oOAvDQnUyNy5KW2xMfTDx+lnEw9eL8rRkEJEsoBlKmoELN8yV
         5JD5u7CXJbos3m5U33qbzf1EgvyqhBV1MZAo5kef9BMNqInSw3TkFh9PQD/Wwhw+8cb0
         epWLhhhFmbKrUZChPSFZmfZel0tVAt+nQrtlF7j8eBWpez8jy5HCneDSfongvj8Vt2gn
         TFysOO+9kP7+Os/W3Co4oHqqX0VvFP2hRvrTCsI7oFgxAVODJjappYx0HTVZE1BlDJoa
         5hfg==
X-Gm-Message-State: ABy/qLYPnmKv1H36uEe7bmDiNYAHXF9TVfuor6Jdck6gDNyOmEMI+S1+
	aHugTEzbb2G7SBDv3qBAFlzpch4ZGV29UcjoIHU4JS0hl201qwIVVf++jdla7CyBN+RUp1lDJ53
	g0mCzOwd3SxRnXBiT8yScoaj+aBvYY0VqyNGCSNhMiHJ2C1HYjw==
X-Google-Smtp-Source: APBJJlGYebW0op/3iuEIh9lx2Hv4PKsRCDOc1Xco+8T07Ui5UtuoEVB82IkQQNytxac4RdcXFVeEz8Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:af5d:0:b0:583:a866:3450 with SMTP id
 x29-20020a81af5d000000b00583a8663450mr81469ywj.7.1690243199375; Mon, 24 Jul
 2023 16:59:59 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-1-sdf@google.com>
Subject: [RFC net-next v4 0/8] xsk: TX metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series implements initial TX metadata (offloads) for AF_XDP.
See patch #2 for the main implementation and mlx5-one for the
example on how to consume the metadata on the device side.

With v4, I'm switching from BPF hooks and kfuncs to a fixed TX
metadata/offload format: the metadata is passed with every tx
umem chunk and it's up to the device driver to interpret it.

Starting with two types of offloads:
- request TX timestamp (and write it back into the metadata area)
- request TX checksum offload

TODO for the non-RFC series:
- have some real device support to verify xdp_hw_metadata works
- Documentation/networking/xdp-rx-metadata.rst - like documentation

v3: https://lore.kernel.org/bpf/20230707193006.1309662-1-sdf@google.com/

Stanislav Fomichev (8):
  xsk: Support XDP_TX_METADATA_LEN
  xsk: add TX timestamp and TX checksum offload support
  net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
  tools: ynl: update netdev sample to dump xsk-features
  selftests/xsk: Support XDP_TX_METADATA_LEN
  selftests/bpf: Add csum helpers
  selftests/bpf: Add TX side to xdp_metadata
  selftests/bpf: Add TX side to xdp_hw_metadata

 Documentation/netlink/specs/netdev.yaml       |  25 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  71 ++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  10 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 include/linux/netdevice.h                     |  27 +++
 include/linux/skbuff.h                        |   5 +-
 include/net/xdp_sock.h                        |  61 ++++++
 include/net/xdp_sock_drv.h                    |  13 ++
 include/net/xsk_buff_pool.h                   |   1 +
 include/uapi/linux/if_xdp.h                   |  36 ++++
 include/uapi/linux/netdev.h                   |  15 ++
 net/core/netdev-genl.c                        |  12 +-
 net/xdp/xsk.c                                 |  58 +++++
 net/xdp/xsk_buff_pool.c                       |   1 +
 net/xdp/xsk_queue.h                           |  19 +-
 tools/include/uapi/linux/if_xdp.h             |  50 ++++-
 tools/include/uapi/linux/netdev.h             |  15 ++
 tools/net/ynl/generated/netdev-user.c         |  25 +++
 tools/net/ynl/generated/netdev-user.h         |   5 +
 tools/net/ynl/samples/netdev.c                |   8 +
 tools/testing/selftests/bpf/network_helpers.h |  43 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  31 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 201 +++++++++++++++++-
 tools/testing/selftests/bpf/xsk.c             |  17 ++
 tools/testing/selftests/bpf/xsk.h             |   1 +
 27 files changed, 718 insertions(+), 46 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog


