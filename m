Return-Path: <bpf+bounces-11302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC47B7233
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4AE942816D0
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F983D39A;
	Tue,  3 Oct 2023 20:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06B3CCED
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:28 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893CA9
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so1584776276.3
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363525; x=1696968325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wzii/XGlnCUqoUPaEZp693o+gtORvdevSmAqdWobuPM=;
        b=yqRewkqTVRDdB8T/98350ooWb1GQcvKYoUqSaInXc13C6RSUvTyN31ol2NMU0XdjQk
         tjpPrB/pOyCiKFmrhlEyuTYOViul3TkHbMlvaYkB8E6QZCELZ5UNQIuvHhSFEAH+FKFm
         yLe7t3Hn4Wv7S6jOCdFHmB9d9zP7IW/soaDCesQ22AvWm+psRb/6TM3RVBIIQHStJpAj
         Z61CmXyH4i84rVjv4cn/pUdRZK9x7MEx93lMqOAyKmVkr3NGjqMvgPudRFwEKccdKa+D
         6j+nyYeXytJ7TAq7C31jxamMBwfHguQHOJRgfZd4Ihy3atexD2Br2KpPMPrU3dDa/DPJ
         PusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363525; x=1696968325;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzii/XGlnCUqoUPaEZp693o+gtORvdevSmAqdWobuPM=;
        b=bNBQ2IEQMhK+JYoguaewItf3j9CmpzwBZDRVjNYILwNUUguiKgYqXhrChPnSXo4r7i
         j6KnN3JafYyS1FVDiizzsoAVXVr5KZAHW6rmHMj2syTDwvKNibxeEb1D/T428wX0MJX9
         JssJlTYa1MoNw9HD71MidYyCEmevkuhZ9RE83FH4BrWA7bM8OklzIzlNO0Ur7cX7fgFJ
         L+PqZhjdRMH2xEhYvOm04OYlp4chXJHQLw3ye4etowRt2O1P9JabebCnnqupjboferMy
         VOhLMMBwKSH4cTSeURRBoSMCjqL11rj7xaqTdGRPCeWII5loTgkVip8f0lfUZqP52jgT
         IDJQ==
X-Gm-Message-State: AOJu0Yx6Seel6ev5Ae0t/XX9tq46tirMLIEc/bwGLVAnNrbiWtL6wnkG
	w2i1+7t8SkYJ3U8gA2/eac7kT5hxlHeB2cIYwhDle9+hZMvZaaj9lYPqWxUS+TGpKwOq0MDq6uu
	vKlBbUbd03qt3w/pO6dplNf5rjSbNW48s8CISAxsxJaHXLNohYw==
X-Google-Smtp-Source: AGHT+IGyHEV0Ugn16vcTpyOw213Dg4gbytqlFmvjWy5Dt3qj7bFnGUW0hEbgPBERtdoJIV5I9Qf/AaY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d510:0:b0:d89:4247:4191 with SMTP id
 r16-20020a25d510000000b00d8942474191mr4356ybe.3.1696363524411; Tue, 03 Oct
 2023 13:05:24 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-1-sdf@google.com>
Subject: [PATCH bpf-next v3 00/10] xsk: TX metadata
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series implements initial TX metadata (offloads) for AF_XDP.
See patch #2 for the main implementation and mlx5/stmmac ones for the
example on how to consume the metadata on the device side.

Starting with two types of offloads:
- request TX timestamp (and write it back into the metadata area)
- request TX checksum offload

Changes since v2:
- fix compile issue with XDP_SOCKETS=n (Vinicius Costa Gomes and Intel bots)
- include stmmac support by Song Yoong Siang

v2: https://lore.kernel.org/bpf/20230914210452.2588884-1-sdf@google.com/T/#t

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

Song Yoong Siang (1):
  net: stmmac: Add Tx HWTS support to XDP ZC

Stanislav Fomichev (9):
  xsk: Support tx_metadata_len
  xsk: add TX timestamp and TX checksum offload support
  tools: ynl: print xsk-features from the sample
  net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
  selftests/xsk: Support tx_metadata_len
  selftests/bpf: Add csum helpers
  selftests/bpf: Add TX side to xdp_metadata
  selftests/bpf: Add TX side to xdp_hw_metadata
  xsk: document tx_metadata_len layout

 Documentation/netlink/specs/netdev.yaml       |  19 ++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/xsk-tx-metadata.rst  |  77 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 ++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  11 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  17 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  12 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  63 +++++-
 include/linux/netdevice.h                     |  27 +++
 include/linux/skbuff.h                        |  14 +-
 include/net/xdp_sock.h                        |  81 +++++++
 include/net/xdp_sock_drv.h                    |  13 ++
 include/net/xsk_buff_pool.h                   |   7 +
 include/uapi/linux/if_xdp.h                   |  41 ++++
 include/uapi/linux/netdev.h                   |  16 ++
 net/core/netdev-genl.c                        |  12 +-
 net/xdp/xdp_umem.c                            |   4 +
 net/xdp/xsk.c                                 |  51 ++++-
 net/xdp/xsk_buff_pool.c                       |   1 +
 net/xdp/xsk_queue.h                           |  19 +-
 tools/include/uapi/linux/if_xdp.h             |  55 ++++-
 tools/include/uapi/linux/netdev.h             |  16 ++
 tools/net/ynl/generated/netdev-user.c         |  19 ++
 tools/net/ynl/generated/netdev-user.h         |   3 +
 tools/net/ynl/samples/netdev.c                |   6 +
 tools/testing/selftests/bpf/network_helpers.h |  43 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  31 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 202 +++++++++++++++++-
 tools/testing/selftests/bpf/xsk.c             |   3 +
 tools/testing/selftests/bpf/xsk.h             |   1 +
 32 files changed, 896 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

-- 
2.42.0.582.g8ccd20d70d-goog


