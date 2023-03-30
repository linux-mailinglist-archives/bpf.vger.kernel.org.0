Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD69B6D0DDB
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjC3Sia (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjC3Si3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:38:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376EBB91
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:38:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5411f21f849so197585507b3.16
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GkwAWkFeGOoqs9hRwF96vtUzcfuETanmtHhAqfhjYY=;
        b=tFwe1yaHBDRUAQZeC2CyOVnO1GFnmf/+FwndqdvRzobvAL2/m1XwhS37YkNmRK/CiF
         XEk2LQpML633tC9qr9hkLZBnDe4W6Az0r772FRUXkiH+OapgCsWD2snqlNOarsBKRyU3
         ffpS0HAH7nEKpXNj1iv4jhCC2LJIioUmj2yna7Ji4tIFmj96gHEvCoOD5ASvdUS8eQ5U
         KuRCtF1dbEivxLJUOL+oEKkez5lEVQUTe72P5Xx3SBPwYGj21AffgYXkMZQDGtAb7vLF
         wcM3oUgMiWZhsuLsEVyLEH2QiRLm8cO3RTSfqkcKI9gg9e1+6Q+BN0vAcJTIu1xT7akZ
         Vn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GkwAWkFeGOoqs9hRwF96vtUzcfuETanmtHhAqfhjYY=;
        b=yDlzA1OR4Rhdyjc4P6/wq+n/N4qqtgDbUPIWW0rXqJpDKFk4YOhJ+vyhebMa4BTfTO
         GThcxMT3DeuebRC0L7yG06aS/0t1KNaDIbxtXLwLHNmoM7CApRVUUCW+p3TsFSnz7YCe
         7RMv6YrbydQH27/hQFFL7Imbntv+ggQ+vn8JxK+AvhxYTbvHv03SdN05dhPbziB6B3Ef
         tvp3E4olx4AuAp6gKbi2O11sXAhXmsWcWYY8tlngJa5NiVgasGN9poixnaKofZyon+Uo
         Tx/EglGR14VgeevKF/kL+P+YS+xke8uRHfDUs1tbrow9uY2OdS7ZOU2+dNku2f1eVCPh
         3+8g==
X-Gm-Message-State: AAQBX9dPBQEnkdhg6Aut9QOMuKIq+vAoWOlUcGyBV2EKv5h4JFzGuimU
        Xp+PKAOUN2FLzAcYAnyavXzunZ0=
X-Google-Smtp-Source: AKy350YtshKMp46RHnx3xTtU6bgWkHllXfaEC32Tne8v1zqOX5qgfnkZuLdugYZ2+srYbQSUQtgl+mA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1586:b0:b76:ae61:b68c with SMTP id
 k6-20020a056902158600b00b76ae61b68cmr12753744ybu.10.1680201507899; Thu, 30
 Mar 2023 11:38:27 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:38:26 -0700
In-Reply-To: <168019602958.3557870.9960387532660882277.stgit@firesoul>
Mime-Version: 1.0
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
Message-ID: <ZCXXIvvnTBch/0Oz@google.com>
Subject: Re: [PATCH bpf RFC-V3 0/5] XDP-hints: API change for RX-hash kfunc bpf_xdp_metadata_rx_hash
From:   Stanislav Fomichev <sdf@google.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/30, Jesper Dangaard Brouer wrote:
> Notice targeted 6.3-rc kernel via bpf git tree.

> Current API for bpf_xdp_metadata_rx_hash() returns the raw RSS hash value,
> but doesn't provide information on the RSS hash type (part of 6.3-rc).

> This patchset proposal is to change the function call signature via adding
> a pointer value argument for provide the RSS hash type.

> Alternatively we disable bpf_xdp_metadata_rx_hash() in 6.3-rc, and have
> more time to nitpick the RSS hash-type bits.

LGTM with one nit about EMIT_BTF.

> ---

> Jesper Dangaard Brouer (5):
>        xdp: rss hash types representation
>        mlx5: bpf_xdp_metadata_rx_hash add xdp rss hash type
>        veth: bpf_xdp_metadata_rx_hash add xdp rss hash type
>        mlx4: bpf_xdp_metadata_rx_hash add xdp rss hash type
>        selftests/bpf: Adjust bpf_xdp_metadata_rx_hash for new arg


>   drivers/net/ethernet/mellanox/mlx4/en_rx.c    | 22 ++++++-
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  3 +-
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 63 ++++++++++++++++++-
>   drivers/net/veth.c                            | 11 +++-
>   include/linux/mlx5/device.h                   | 14 ++++-
>   include/linux/netdevice.h                     |  3 +-
>   include/net/xdp.h                             | 49 +++++++++++++++
>   net/core/xdp.c                                | 10 ++-
>   .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +
>   .../selftests/bpf/progs/xdp_hw_metadata.c     | 14 +++--
>   .../selftests/bpf/progs/xdp_metadata.c        |  6 +-
>   .../selftests/bpf/progs/xdp_metadata2.c       |  7 ++-
>   tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
>   tools/testing/selftests/bpf/xdp_metadata.h    |  1 +
>   14 files changed, 183 insertions(+), 24 deletions(-)

> --

