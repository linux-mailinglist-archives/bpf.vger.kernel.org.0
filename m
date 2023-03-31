Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196EB6D25A4
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjCaQea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjCaQdt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 12:33:49 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B384023B76
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:30:41 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ie21-20020a17090b401500b0023b4ba1e433so7375893pjb.0
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680280241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuU0X18NA2vfKqA+27nNi+qvFb7A+8NhIy9/ITvEFps=;
        b=eikErdC7IICJhhwmuS6mSRXF9PSaDCK6Hb502DIcMwEihqM3SSqInbY02vh2KRmxbw
         L1DPPI2JRFX2033gNwvIYJ6+uFY3/kUAG/pKGK9m4P76ZcYNz+LIbNzzjOi8Pft+M6eR
         ikfClExVxzr+Za2HW407xqBShUtz/gdVuzG9jQFeQPXIvrWVct4wiqYT8P8aiCMK8QyO
         v2+f5fwWFSlrbUe6TH2pN/7jDwaJR8vXFTuO/GGq+56r43sdlHzugjX3lXX7nH07I4Hm
         1nJq2+JVACzeE4/YfsjdKpyoPGU0YN/jMfdiXAs1vPLTsAWfTLTbZKHoNIbXKI7UuMLB
         VhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuU0X18NA2vfKqA+27nNi+qvFb7A+8NhIy9/ITvEFps=;
        b=DGnXxqR2Dh+t8ymr3toZiI4jEtDavKX7dUfRrA9tum1XA7vixJe1xj9CsQT/uw0eBU
         dXzEq3uW0ZVOMgQdJrWaMMVa8V79Y1gd53DawMjGOAtdavp/POBE3nqN8atCVz1UO+4z
         oIYdVXgwazNJXTlzkXhf8qHEB3tj/DzsoEFZS8VYyZO/1sarnXwqZUGQWkQveSzaXORb
         UkYrBoX291xcb9HBwdH6QTVkqigsVHyQA4zzFBd483g5JVVLra1JNYk3cSe+t7bN19Q0
         k+iArCWO4zyLSXBbn94owvCjOYgWC5+zhYKb6ByRs39X1u2TxIrGcSYWc6HUwXifx3pW
         NnKQ==
X-Gm-Message-State: AAQBX9d3EzRQauZHXJBe18aI69LmjGn2mWHl1aOv5/In8Xs/jCvctGw+
        bsvw2UKpsobN0jC2yz4syzNxe8w=
X-Google-Smtp-Source: AKy350YqrZGH7LT9CkWwnnCK5H2FURN0Q8DDSeBB4aSbUucJfZ3SItP8t85KLXk3UlddQxE5yS0f9b4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:d85:b0:240:d8d8:12c4 with SMTP id
 bg5-20020a17090b0d8500b00240d8d812c4mr1364835pjb.3.1680280241163; Fri, 31 Mar
 2023 09:30:41 -0700 (PDT)
Date:   Fri, 31 Mar 2023 09:30:39 -0700
In-Reply-To: <168027495947.3941176.6690238098903275241.stgit@firesoul>
Mime-Version: 1.0
References: <168027495947.3941176.6690238098903275241.stgit@firesoul>
Message-ID: <ZCcKr69B+HKJdFEl@google.com>
Subject: Re: [PATCH bpf V4 0/5] XDP-hints: API change for RX-hash kfunc bpf_xdp_metadata_rx_hash
From:   Stanislav Fomichev <sdf@google.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org,
        "Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=" <toke@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net,
        tariqt@nvidia.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/31, Jesper Dangaard Brouer wrote:
> Current API for bpf_xdp_metadata_rx_hash() returns the raw RSS hash value,
> but doesn't provide information on the RSS hash type (part of 6.3-rc).
> 
> This patchset proposal is to change the function call signature via adding
> a pointer value argument for providing the RSS hash type.

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
> 
> Jesper Dangaard Brouer (5):
>       xdp: rss hash types representation
>       mlx5: bpf_xdp_metadata_rx_hash add xdp rss hash type
>       veth: bpf_xdp_metadata_rx_hash add xdp rss hash type
>       mlx4: bpf_xdp_metadata_rx_hash add xdp rss hash type
>       selftests/bpf: Adjust bpf_xdp_metadata_rx_hash for new arg
> 
> 
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c    | 22 ++++++-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  3 +-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 63 ++++++++++++++++++-
>  drivers/net/veth.c                            | 11 +++-
>  include/linux/mlx5/device.h                   | 14 ++++-
>  include/linux/netdevice.h                     |  3 +-
>  include/net/xdp.h                             | 48 ++++++++++++++
>  net/core/xdp.c                                | 10 ++-
>  .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +
>  .../selftests/bpf/progs/xdp_hw_metadata.c     | 14 +++--
>  .../selftests/bpf/progs/xdp_metadata.c        |  6 +-
>  .../selftests/bpf/progs/xdp_metadata2.c       |  7 ++-
>  tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
>  tools/testing/selftests/bpf/xdp_metadata.h    |  1 +
>  14 files changed, 182 insertions(+), 24 deletions(-)
> 
> --
> 
