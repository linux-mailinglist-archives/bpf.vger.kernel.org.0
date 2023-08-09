Return-Path: <bpf+bounces-7385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138957765AB
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C108C280D7E
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189731CA0B;
	Wed,  9 Aug 2023 16:54:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02BE1BB56
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:54:22 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903BB1FDE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:54:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584139b6b03so1077507b3.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600061; x=1692204861;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lrYAJjJfItRR6kM9NHw5X9w0SQzdn2dW2guFzH4UtUM=;
        b=dIQcwCKKLsJ+Chw2Z9hAHCvFwlACffk2gm1o4wFRg0+tzMpLgXfREePO07iqJG3Ymg
         gLpZvJiewnPaYeclZvJl3/vsW2z5jy1QVDHw5XE84xaBfUB3ywQDZxqXj2N9hO6L86fO
         SE9ZcaEiIDdcpxmbyOylm134w/i06ujtsZNv4r1BAZl5DRCk/kINmFXSRBIeWgq0sKyk
         IDbiqmUOMwr4M6FM6Hac5nG9KkJ+5PCzvrAywLDKXPyUMq5v2qWID7E5tg1Eows/lxde
         XM0l5fuda1MRR01H50TdgwrQ9vfuvt7rAnUMkEaWc9Q1GDLyuenrCPFFbWdh8bx/SQsZ
         wbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600061; x=1692204861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrYAJjJfItRR6kM9NHw5X9w0SQzdn2dW2guFzH4UtUM=;
        b=LZ44C0q6d4MOzgia8WEB9BG7mFhjJt9zvYps7Q9fnpdBRMsppeGrlOTHRPAdgvS3mK
         DT39ubkpvfxUpRvEGH/R0AWYaD7Ou974UUkyhEZXlfN4eH4yvVwLU6cYiPwfR6gMRgZG
         XU8f0VA9coSSinVUYjO35ikC+N94XEu5u9ULMNwB71hqk1kDuoK4lrJNOJUrK4UCZNEW
         Hru5XVjrsV6RHX3g9x8yNm5bCh+f5zLOZQm/HAtaBfyCKDw7jqyaS8hcGGcg92W1TBeC
         OGPnSN4gwPdkzoFRInNewNFL2yBKWMH4cIaEa/6B+x/+qNuB0ATmuLLMqvq8Zn5svHSk
         W6kA==
X-Gm-Message-State: AOJu0YznfyQPI+qNKmQmKYGYQ2gXmPCwCms1cfUUxAXllPF8Xh46Rn2L
	5Ilh3LeW64DLFefpTM2ULox4mP0RsTROBbC56j0dJYK87Zg70Sc+PK0C2AIc8DG+/d0dibu9p/P
	VRjFgz8fI4Nq1WZ8sHd64USIWJOZ/46aoX936wJZ6dgQdFHc2FA==
X-Google-Smtp-Source: AGHT+IHRMX32sJWyRrS+OceCEHOAUXBNbizvvNFKb85fr+5NCJl+YcXYA+0VSs55tM2jJvOm3Po9dMQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b710:0:b0:577:617b:f881 with SMTP id
 v16-20020a81b710000000b00577617bf881mr70887ywh.8.1691600060458; Wed, 09 Aug
 2023 09:54:20 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-1-sdf@google.com>
Subject: [PATCH bpf-next 0/9] xsk: TX metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net, 
	Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series implements initial TX metadata (offloads) for AF_XDP.
See patch #2 for the main implementation and mlx5-one for the
example on how to consume the metadata on the device side.

Starting with two types of offloads:
- request TX timestamp (and write it back into the metadata area)
- request TX checksum offload

Changes since last RFC:
- add /* private: */ comments to headers (Simon)
- handle metadata only in the first frag (Simon)
- rename xdp_hw_metadata flags (Willem)
- s/tmo_request_checksum/tmo_request_timestamp/ in xdp_metadata_ops
  comment (Willem)
- Documentation/networking/xsk-tx-metadata.rst

RFC v4: https://lore.kernel.org/bpf/20230724235957.1953861-1-sdf@google.com/

Performance:

I've implemented a small xskgen tool to try to saturate single tx queue:
https://github.com/fomichev/xskgen/tree/master

Here are the performance numbers with some analysis.

1. Baseline. Running with commit eb62e6aef940 ("Merge branch 'bpf:
Support bpf_get_func_ip helper in uprobes'"), nothing from this series:

- with 1400 bytes of payload: 98 gbps, 8 mpps
./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189130 sec, 98.357623 gbps 8.409509 mpps

- with 200 bytes of payload: 49 gbps, 23 mpps
./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000064 packets 20960134144 bits, took 0.422235 sec, 49.640921 gbps 23.683645 mpps

2. Adding single commit that supports reserving XDP_TX_METADATA_LEN
   changes nothing numbers-wise.

- baseline for 1400
./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189247 sec, 98.347946 gbps 8.408682 mpps

- baseline for 200
./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 20960000000 bits, took 0.421248 sec, 49.756913 gbps 23.738985 mpps

3. Adding -M flag causes xskgen to reserve the metadata and fill it, but
   doesn't set XDP_TX_METADATA descriptor option.

- new baseline for 1400 (with only filling the metadata)
./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.188767 sec, 98.387657 gbps 8.412077 mpps

- new baseline for 200 (with only filling the metadata)
./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 20960000000 bits, took 0.410213 sec, 51.095407 gbps 24.377579 mpps
(the numbers go sligtly up here, not really sure why, maybe some cache-related
side-effects?

4. Next, I'm running the same test but with the commit that adds actual
   general infra to parse XDP_TX_METADATA (but no driver support).
   Essentially applying "xsk: add TX timestamp and TX checksum offload support"
   from this series. Numbers are the same.

- fill metadata for 1400
./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.188430 sec, 98.415557 gbps 8.414463 mpps

- fill metadata for 200
./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 20960000000 bits, took 0.411559 sec, 50.928299 gbps 24.297853 mpps

- request metadata for 1400
./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.188723 sec, 98.391299 gbps 8.412389 mpps

- request metadata for 200
./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000064 packets 20960134144 bits, took 0.411240 sec, 50.968131 gbps 24.316856 mpps

5. Now, for the most interesting part, I'm adding mlx5 driver support.
   The mpps for 200 bytes case goes down from 23 mpps to 19 mpps, but
   _only_ when I enable the metadata. This looks like a side effect
   of me pushing extra metadata pointer via mlx5e_xdpi_fifo_push.
   Hence, this part is wrapped into 'if (xp_tx_metadata_enabled)'
   to not affect the existing non-metadata use-cases. Since this is not
   regressing existing workloads, I'm not spending any time trying to
   optimize it more (and leaving it up to mlx owners to purse if
   they see any good way to do it).

- same baseline
./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189434 sec, 98.332484 gbps 8.407360 mpps

./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000128 packets 20960268288 bits, took 0.425254 sec, 49.288821 gbps 23.515659 mpps

- fill metadata for 1400
./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189528 sec, 98.324714 gbps 8.406696 mpps

- fill metadata for 200
./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000128 packets 20960268288 bits, took 0.519085 sec, 40.379260 gbps 19.264914 mpps

- request metadata for 1400
./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000000 packets 116960000000 bits, took 1.189329 sec, 98.341165 gbps 8.408102 mpps

- request metadata for 200
./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
sent 10000128 packets 20960268288 bits, took 0.519929 sec, 40.313713 gbps 19.233642 mpps

Cc: Saeed Mahameed <saeedm@nvidia.com>

Stanislav Fomichev (9):
  xsk: Support XDP_TX_METADATA_LEN
  xsk: add TX timestamp and TX checksum offload support
  tools: ynl: print xsk-features from the sample
  net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
  selftests/xsk: Support XDP_TX_METADATA_LEN
  selftests/bpf: Add csum helpers
  selftests/bpf: Add TX side to xdp_metadata
  selftests/bpf: Add TX side to xdp_hw_metadata
  xsk: document XDP_TX_METADATA_LEN layout

 Documentation/netlink/specs/netdev.yaml       |  20 ++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/xsk-tx-metadata.rst  |  75 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 ++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  10 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 include/linux/netdevice.h                     |  27 +++
 include/linux/skbuff.h                        |   5 +-
 include/net/xdp_sock.h                        |  61 ++++++
 include/net/xdp_sock_drv.h                    |  13 ++
 include/net/xsk_buff_pool.h                   |   6 +
 include/uapi/linux/if_xdp.h                   |  36 ++++
 include/uapi/linux/netdev.h                   |  16 ++
 net/core/netdev-genl.c                        |  12 +-
 net/xdp/xsk.c                                 |  61 ++++++
 net/xdp/xsk_buff_pool.c                       |   1 +
 net/xdp/xsk_queue.h                           |  19 +-
 tools/include/uapi/linux/if_xdp.h             |  50 ++++-
 tools/include/uapi/linux/netdev.h             |  15 ++
 tools/net/ynl/generated/netdev-user.c         |  19 ++
 tools/net/ynl/generated/netdev-user.h         |   3 +
 tools/net/ynl/samples/netdev.c                |   6 +
 tools/testing/selftests/bpf/network_helpers.h |  43 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  31 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 201 +++++++++++++++++-
 tools/testing/selftests/bpf/xsk.c             |  17 ++
 tools/testing/selftests/bpf/xsk.h             |   1 +
 29 files changed, 793 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

-- 
2.41.0.640.ga95def55d0-goog


