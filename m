Return-Path: <bpf+bounces-15965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1576F7FA983
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E77281881
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0563E3DBA3;
	Mon, 27 Nov 2023 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cB9jjSt3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0535D59
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:22 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ccf44b0423so58664157b3.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111802; x=1701716602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lU3G4rk+luvHLpEU8JIhFSL/F60CLPC8jZKTfFv2YrM=;
        b=cB9jjSt3eMWPXMMXJx3Qt5lL4JVkkxVOIsAsUBd4j++uJsk6lauF/Ri7gbaY9NqzTm
         2Z+8W8mQeh4w4l2C3TlfwVRwFtvsFMwi7LCEWWsmUp+zhnIDedlshITJbrhzSfcAEy1u
         LtvnhMKcnParAHamUk14v0+UejMZ45at2yJFcE0ouurkKNW8d1eUCwtXT4k6NQB62h2z
         gimzb6OuL0wQwVhgflvgN4wVi9I7Df8/XXI57bHEwG1rSVXoC1NqWXPChgA20hyTWtu/
         kylfLYjQFm+lnkKlwJIOV2rzlGLGx/CVijB4+AQlUprz4AAVvV+6ORpZzTpqQsvim4Ik
         kw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111802; x=1701716602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lU3G4rk+luvHLpEU8JIhFSL/F60CLPC8jZKTfFv2YrM=;
        b=UTVEbcdqietp7mnxb6Sc1eLVcTL2vgJcLtK7TeKKEVfj1bB6dol38EB01eXzUEr+Jw
         FdpXpwK1vWuDSIhIbpClYC11h0gUBVyOAyKwwNr1B1SCLESG8D8SfHh6Tg4/ogmXBV0n
         UQ5UWaoT6BS/3JUsCMUMU3b9Rzhx7WQ1BhbXSwVZx/Qjzn7g2cV4eI4foqNLmLtsJp7j
         imwa4fekwHg6kOZGJqHJMzzoaC17VCgCUo2+vzum+ho5so+SgykEkU/1tkhP1sqD2XaA
         6RtsAEqYJt2GTy4ZuJxZ6YyI7Ky49oun8TM/5+GkQ1UANLicZNoNbM+mzmx1WfzCP+RQ
         H66Q==
X-Gm-Message-State: AOJu0YynxBDFJKan4ZhqR2y8ZL73HQmp97djCGiIkwAZCym5ljIrV59L
	lfINp5blo8qdCf0/f+nnGkV2KdaS7/qJ6fEdJjGbHae3CteKbSqqLM76z/lgv3Z3SyIdjS7sDNY
	xW+A2uOK8bKPIhWmd0PuJW0Lm/wVQegp9CfpBe2cj5Ze1Og5s2w==
X-Google-Smtp-Source: AGHT+IFeByzxXLBxhw3aGO9csheT1p5jgyH0Bj9dQbhDEsILAceytCN4NNRS+GZoPw0XNlOYpJVnRHg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d157:0:b0:daf:be4f:489d with SMTP id
 i84-20020a25d157000000b00dafbe4f489dmr379298ybg.1.1701111801355; Mon, 27 Nov
 2023 11:03:21 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-1-sdf@google.com>
Subject: [PATCH bpf-next v6 00/13] xsk: TX metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

This series implements initial TX metadata (offloads) for AF_XDP.
See patch #2 for the main implementation and mlx5/stmmac ones for the
example on how to consume the metadata on the device side.

Starting with two types of offloads:
- request TX timestamp (and write it back into the metadata area)
- request TX checksum offload

Changes since v5:
- preserve xsk_tx_metadata flags across tx and completion by moving
  them out of 'request' union (Jesper)
- fix xdp_metadata checksum failure in big endian (Alexei)
- add SPDX to xdp-rx-metadata.rst (Simon)

v5: https://lore.kernel.org/bpf/20231102225837.1141915-1-sdf@google.com/

Performance (mlx5):

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

2. Adding single commit that supports reserving tx_metadata_len
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

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>

Song Yoong Siang (1):
  net: stmmac: Add Tx HWTS support to XDP ZC

Stanislav Fomichev (12):
  xsk: Support tx_metadata_len
  xsk: Add TX timestamp and TX checksum offload support
  tools: ynl: Print xsk-features from the sample
  net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
  xsk: Document tx_metadata_len layout
  xsk: Validate xsk_tx_metadata flags
  xsk: Add option to calculate TX checksum in SW
  selftests/xsk: Support tx_metadata_len
  selftests/bpf: Add csum helpers
  selftests/bpf: Add TX side to xdp_metadata
  selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
  selftests/bpf: Add TX side to xdp_hw_metadata

 Documentation/netlink/specs/netdev.yaml       |  19 +-
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/xdp-rx-metadata.rst  |   2 +
 Documentation/networking/xsk-tx-metadata.rst  |  79 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 +++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  11 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  17 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  12 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  64 ++++-
 include/linux/netdevice.h                     |   2 +
 include/linux/skbuff.h                        |  14 +-
 include/net/xdp_sock.h                        | 111 +++++++++
 include/net/xdp_sock_drv.h                    |  34 +++
 include/net/xsk_buff_pool.h                   |   8 +
 include/uapi/linux/if_xdp.h                   |  47 +++-
 include/uapi/linux/netdev.h                   |  16 ++
 net/core/netdev-genl.c                        |  13 +-
 net/xdp/xdp_umem.c                            |  11 +-
 net/xdp/xsk.c                                 |  56 ++++-
 net/xdp/xsk_buff_pool.c                       |   2 +
 net/xdp/xsk_queue.h                           |  19 +-
 tools/include/uapi/linux/if_xdp.h             |  61 ++++-
 tools/include/uapi/linux/netdev.h             |  16 ++
 tools/net/ynl/generated/netdev-user.c         |  19 ++
 tools/net/ynl/generated/netdev-user.h         |   3 +
 tools/net/ynl/samples/netdev.c                |  10 +-
 tools/testing/selftests/bpf/network_helpers.h |  43 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  33 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 235 ++++++++++++++++--
 tools/testing/selftests/bpf/xsk.c             |   3 +
 tools/testing/selftests/bpf/xsk.h             |   1 +
 33 files changed, 969 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

-- 
2.43.0.rc1.413.gea7ed67945-goog


