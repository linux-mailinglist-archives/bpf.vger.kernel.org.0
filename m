Return-Path: <bpf+bounces-12990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6D7D2EE8
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2731C20941
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01E13FF1;
	Mon, 23 Oct 2023 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKeTqRP/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EC134A6;
	Mon, 23 Oct 2023 09:52:25 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FA0C4;
	Mon, 23 Oct 2023 02:52:23 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49d428d89cdso285555e0c.1;
        Mon, 23 Oct 2023 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698054743; x=1698659543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UH47i0BQFdN1U9eAzdaKd7oOF6gd2ioYQqOsYKIl3tM=;
        b=BKeTqRP/RbcqfYaDGNHkCKxp8l72I10i6PbUyozAIhxvWRx7olL+FKYkbAnTn6Bm9W
         cRUDbTsAZTApgrRMlUjxRdmSy2KCAJGHiqr4Dc/kfTMPhv8CG1Q6UKfT/6ogiox1KXei
         6o9Vub6WpBQBSuFPTm1/wyxIpus7GpJPXmyFo2nSkKlWh18orYJDJUtYst0FhshK7mgH
         ippVK/YSzY51JjAQkW/pqxV3x5YeB2u19wFpPjcMLldskP2+y4L4iZc9cLEs+oYe/rQ+
         cAqtcwcvwGafSXa8p8mEEQVMGfXqNvD9A4LU+2nDYlEqGDhcDXU+/5/L+t0RjSB+tE80
         aPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054743; x=1698659543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH47i0BQFdN1U9eAzdaKd7oOF6gd2ioYQqOsYKIl3tM=;
        b=romf/z4Y9dD47YUNjhvAxu69wjby5wdkyDYN19lwLJek+WZ0cq2T6/DPIbKS9wE6vL
         q4I6udNJGFb4AxSSidU/zwo71DnNy1t6ZMmc9cNP36CwvLxl/qqMbk0/QBTdrBrl2LAU
         ztacEoM1J4pNO2fxrixdM91jW8KNPzO3Iu3TcITRlPKuVdoO3Gyf5tt0xQklYrj9Nq+g
         AazbYefF2sLrEBVOaPlAkM4OpufQO71XBhjYZ05y6YXoihK5nF9AsnXrmmtW2EH/N0fn
         QR1ZRcNNh99pFugAKZo3TyH1pRyxpzGFABnhTCph/3c4iAZou5Kn8wi4hTJHFeqjDCwl
         p7Ag==
X-Gm-Message-State: AOJu0YxGKVaKYjDBk8PUE5YvZJSN11ch3xCScZNLUIo+NQ57E0GyaPkG
	h+SJKNVR9ZFeemLblk4Hy2BbAv3g+6fKbP4AqTQ=
X-Google-Smtp-Source: AGHT+IGu9HoKzvlBBtwlovsuIOBqf0xB3Xoy/TWWpGWBoCl65y4dL7iT6QBz8PVg+RMCIy8971cw0ViZmV2DEQqYDwI=
X-Received: by 2002:a05:6102:5e90:b0:455:c309:720e with SMTP id
 ij16-20020a0561025e9000b00455c309720emr3791031vsb.3.1698054742773; Mon, 23
 Oct 2023 02:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Oct 2023 11:52:11 +0200
Message-ID: <CAJ8uoz26Q-8etBpgc25xFY8ZRcoJeAM5RFOWO-Q2_T1=xBfL9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/11] xsk: TX metadata
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 19:49, Stanislav Fomichev <sdf@google.com> wrote:
>
> This series implements initial TX metadata (offloads) for AF_XDP.
> See patch #2 for the main implementation and mlx5/stmmac ones for the
> example on how to consume the metadata on the device side.
>
> Starting with two types of offloads:
> - request TX timestamp (and write it back into the metadata area)
> - request TX checksum offload
>
> Changes since v3:
> - fix xsk_tx_metadata_ops kdoc (Song Yoong Siang)
> - add missing xsk_tx_metadata_to_compl for XDP_SOCKETS=n (Vinicius Costa Gomes and Intel bots)
> - add reference timestamps to the selftests + refactor existing ones (Jesper)
>
> v3: https://lore.kernel.org/bpf/20231003200522.1914523-1-sdf@google.com/

Thanks for working on this Stanislav. I went through the patch set and
it looks good to me. You have addressed all the feedback that Maciej
and I had on a previous version. Just had some small things in two of
the patches. Apart from that, you are good to go and you can add my
ack to the next version.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Again, really appreciate all your work with this!

> Performance (mlx5):
>
> I've implemented a small xskgen tool to try to saturate single tx queue:
> https://github.com/fomichev/xskgen/tree/master
>
> Here are the performance numbers with some analysis.
>
> 1. Baseline. Running with commit eb62e6aef940 ("Merge branch 'bpf:
> Support bpf_get_func_ip helper in uprobes'"), nothing from this series:
>
> - with 1400 bytes of payload: 98 gbps, 8 mpps
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189130 sec, 98.357623 gbps 8.409509 mpps
>
> - with 200 bytes of payload: 49 gbps, 23 mpps
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000064 packets 20960134144 bits, took 0.422235 sec, 49.640921 gbps 23.683645 mpps
>
> 2. Adding single commit that supports reserving tx_metadata_len
>    changes nothing numbers-wise.
>
> - baseline for 1400
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189247 sec, 98.347946 gbps 8.408682 mpps
>
> - baseline for 200
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.421248 sec, 49.756913 gbps 23.738985 mpps
>
> 3. Adding -M flag causes xskgen to reserve the metadata and fill it, but
>    doesn't set XDP_TX_METADATA descriptor option.
>
> - new baseline for 1400 (with only filling the metadata)
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188767 sec, 98.387657 gbps 8.412077 mpps
>
> - new baseline for 200 (with only filling the metadata)
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.410213 sec, 51.095407 gbps 24.377579 mpps
> (the numbers go sligtly up here, not really sure why, maybe some cache-related
> side-effects?
>
> 4. Next, I'm running the same test but with the commit that adds actual
>    general infra to parse XDP_TX_METADATA (but no driver support).
>    Essentially applying "xsk: add TX timestamp and TX checksum offload support"
>    from this series. Numbers are the same.
>
> - fill metadata for 1400
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188430 sec, 98.415557 gbps 8.414463 mpps
>
> - fill metadata for 200
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.411559 sec, 50.928299 gbps 24.297853 mpps
>
> - request metadata for 1400
> ./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188723 sec, 98.391299 gbps 8.412389 mpps
>
> - request metadata for 200
> ./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000064 packets 20960134144 bits, took 0.411240 sec, 50.968131 gbps 24.316856 mpps
>
> 5. Now, for the most interesting part, I'm adding mlx5 driver support.
>    The mpps for 200 bytes case goes down from 23 mpps to 19 mpps, but
>    _only_ when I enable the metadata. This looks like a side effect
>    of me pushing extra metadata pointer via mlx5e_xdpi_fifo_push.
>    Hence, this part is wrapped into 'if (xp_tx_metadata_enabled)'
>    to not affect the existing non-metadata use-cases. Since this is not
>    regressing existing workloads, I'm not spending any time trying to
>    optimize it more (and leaving it up to mlx owners to purse if
>    they see any good way to do it).
>
> - same baseline
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189434 sec, 98.332484 gbps 8.407360 mpps
>
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.425254 sec, 49.288821 gbps 23.515659 mpps
>
> - fill metadata for 1400
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189528 sec, 98.324714 gbps 8.406696 mpps
>
> - fill metadata for 200
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.519085 sec, 40.379260 gbps 19.264914 mpps
>
> - request metadata for 1400
> ./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189329 sec, 98.341165 gbps 8.408102 mpps
>
> - request metadata for 200
> ./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.519929 sec, 40.313713 gbps 19.233642 mpps
>
> Song Yoong Siang (1):
>   net: stmmac: Add Tx HWTS support to XDP ZC
>
> Stanislav Fomichev (10):
>   xsk: Support tx_metadata_len
>   xsk: Add TX timestamp and TX checksum offload support
>   tools: ynl: Print xsk-features from the sample
>   net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
>   selftests/xsk: Support tx_metadata_len
>   selftests/bpf: Add csum helpers
>   selftests/bpf: Add TX side to xdp_metadata
>   selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
>   selftests/bpf: Add TX side to xdp_hw_metadata
>   xsk: Document tx_metadata_len layout
>
>  Documentation/netlink/specs/netdev.yaml       |  19 ++
>  Documentation/networking/index.rst            |   1 +
>  Documentation/networking/xsk-tx-metadata.rst  |  77 ++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 +++++-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  11 +-
>  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  17 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  12 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  63 ++++-
>  include/linux/netdevice.h                     |  27 ++
>  include/linux/skbuff.h                        |  14 +-
>  include/net/xdp_sock.h                        |  86 +++++++
>  include/net/xdp_sock_drv.h                    |  13 +
>  include/net/xsk_buff_pool.h                   |   7 +
>  include/uapi/linux/if_xdp.h                   |  41 ++++
>  include/uapi/linux/netdev.h                   |  16 ++
>  net/core/netdev-genl.c                        |  12 +-
>  net/xdp/xdp_umem.c                            |   4 +
>  net/xdp/xsk.c                                 |  51 +++-
>  net/xdp/xsk_buff_pool.c                       |   1 +
>  net/xdp/xsk_queue.h                           |  19 +-
>  tools/include/uapi/linux/if_xdp.h             |  55 ++++-
>  tools/include/uapi/linux/netdev.h             |  16 ++
>  tools/net/ynl/generated/netdev-user.c         |  19 ++
>  tools/net/ynl/generated/netdev-user.h         |   3 +
>  tools/net/ynl/samples/netdev.c                |   6 +
>  tools/testing/selftests/bpf/network_helpers.h |  43 ++++
>  .../selftests/bpf/prog_tests/xdp_metadata.c   |  31 ++-
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 230 ++++++++++++++++--
>  tools/testing/selftests/bpf/xsk.c             |   3 +
>  tools/testing/selftests/bpf/xsk.h             |   1 +
>  32 files changed, 914 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/networking/xsk-tx-metadata.rst
>
> --
> 2.42.0.655.g421f12c284-goog
>
>

