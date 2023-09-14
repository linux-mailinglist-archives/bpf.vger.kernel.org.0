Return-Path: <bpf+bounces-10077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7107A0F75
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC81C20AD8
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15726E20;
	Thu, 14 Sep 2023 21:04:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DE26E0F
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:04:56 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB1B2700
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:04:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf4cb742715so1713301276.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725495; x=1695330295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zJvyBO3Te8NNwAzPIWarqP43OTSbA2TQxDf8pmoNBSA=;
        b=mwmTmr6uEpOatFeneNOuxWi7e/HXlTOOM1s/aDLqcENABFRFYEt0wJ/fzqClfknc00
         iT/wsx2loGRsQnOKTAQtGOgq5BeF0sIZg1Y4DT0q2jhXcTfh20ZXnikfyxcByDUbgTFp
         dAOlkcC9zO8SfyKPlZLU58dho/TyNKd6RGhrG7mORIkDUArTvaSblL2LW1S8KAVNJ+ZZ
         iLcfENiwIorwDAmfDnext1h7svufOZ6UQqYSPmJqBcKTLvUDJu9IfoQu0owPZrc8/ogn
         /LYNesMWVh4msIkAg8CpTxkwgj2ygQYdTMIoLYozBuj7jfctrQYUQtkMe7gSOZv/GuPS
         14xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725495; x=1695330295;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJvyBO3Te8NNwAzPIWarqP43OTSbA2TQxDf8pmoNBSA=;
        b=QsMt61+3U5eCaIcsawBvnD+whqVdDvy0AcVyO/xFilbcwxcrdAG5LBbl3Yqu05PZRx
         ZSAIouEqzopawcOhWy/+OHDaO8L0IX0HM4Xo4/rotOyOsIn9tvEVWClz+3NLG/GXNO4+
         VPqtM5GiKWL1o8eIC1XsJUe1RO97Kdg6Pbjo5zfGYxbaMCkwbrGTUGWcmx+MTt/JChXc
         p6eGBpuRt8zCEg47DpI1ol02V8GdjjKZSs26D/6BHkIUshoDmvViysjMgQxoJPT+WxTm
         WDcKfWP4OKJVPVGAJhBZjJqMsSMV/JxlTY7x8TcpLf3LlHheLGdW4cFXgUpTfNsoM6/3
         sHgg==
X-Gm-Message-State: AOJu0YzEXxEcBCcDILIpP4i2XHoZ0D1SqcjBAk8h3KlKpUUOfCXHcvT0
	0jbromF+kw/grnsfgfxqdXiCY8Ws0d1I8OgQThynsAnNO7X2/rhKmLiydPWemUifhYEeIBZGVxB
	kKYQ1LHguEWiSTOp1WEsVwesuvZFaUgrRa+O5PxO/m0uImtA0wQ==
X-Google-Smtp-Source: AGHT+IGgeUdxlwN37ZfLi36wuzFL1iUtuwduz2tDD5Vw0iVaYfSvBm/18ryiAh9o+jvjXeSkeBSD+Iw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:aa83:0:b0:d77:f4f5:9e4 with SMTP id
 t3-20020a25aa83000000b00d77f4f509e4mr152429ybi.2.1694725494666; Thu, 14 Sep
 2023 14:04:54 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-1-sdf@google.com>
Subject: [PATCH bpf-next v2 0/9] xsk: TX metadata
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net, Saeed Mahameed <saeedm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

This series implements initial TX metadata (offloads) for AF_XDP.
See patch #2 for the main implementation and mlx5-one for the
example on how to consume the metadata on the device side.

Starting with two types of offloads:
- request TX timestamp (and write it back into the metadata area)
- request TX checksum offload

Changes since v1:
- fix obviously broken xp_tx_metadata_enabled (Jesper)
- update xsk_tx_metadata to be a union of tx and completion sides
  (Willem, offline)
- update the doc to mention that metadata padding area is ignored
  by the kernel and doesn't have to be zeroed-out (Willem, offline)
- move tx_metadata_len to umem (Maciej, Magnus)
- store and pass tx_timestamp separately instead of relying on
  the metadata been unchanged between tx and completion evetns (Maciej)

Note that I still only have mlx5 support here. Posting a respin
to let Intel folks play with the latest state of the patches.

v1: https://lore.kernel.org/all/20230809165418.2831456-1-sdf@google.com/

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

Cc: Saeed Mahameed <saeedm@nvidia.com>

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

 Documentation/netlink/specs/netdev.yaml       |  20 ++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/xsk-tx-metadata.rst  |  77 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 ++++++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  11 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  17 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
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
 tools/include/uapi/linux/netdev.h             |  15 ++
 tools/net/ynl/generated/netdev-user.c         |  19 ++
 tools/net/ynl/generated/netdev-user.h         |   3 +
 tools/net/ynl/samples/netdev.c                |   6 +
 tools/testing/selftests/bpf/network_helpers.h |  43 ++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  31 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 202 +++++++++++++++++-
 tools/testing/selftests/bpf/xsk.c             |   3 +
 tools/testing/selftests/bpf/xsk.h             |   1 +
 30 files changed, 822 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

-- 
2.42.0.459.ge4e396fd5e-goog


