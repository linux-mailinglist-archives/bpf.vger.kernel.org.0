Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8542B3228
	for <lists+bpf@lfdr.de>; Sun, 15 Nov 2020 05:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKOEsk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Nov 2020 23:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgKOEsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Nov 2020 23:48:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A594C0613D2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2020 20:48:38 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so14679878wrb.9
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2020 20:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1z3Klgi+UNsQizX/jU8tNiP98p7LLCRbWM8W3amBWTU=;
        b=NjCu6ZFdG/CJ9fFsRmipIdWI0ni4uC3GyZRSgX+1K7hSTy4+5o8eORYTtrGtNfFUPB
         taBUrC6vXhPN6bcbvB0ntjP8kOjRqIP9d8klPPSdZYKyjcDk84PwsokaFz50vAdL/+wo
         4W7+OWxTtpwW1Q8eA1XLwXZcfECHNl6SrTsHlR2DGTzZbZAb915ttxEwbw82YzdK75G4
         coCx4pcr/9c1ldM/pYBdTsJ6iVa6Tl2oT5R5mCe3HCcemeMg/RmVVDQG1zACqrKo5hT7
         DOr2UoICYF6XCVJwO22VXJWHvcCEbB6ypSEYhWSvHUxK/f3j3nNybHgUeXiiMsmrLOf5
         VghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1z3Klgi+UNsQizX/jU8tNiP98p7LLCRbWM8W3amBWTU=;
        b=RoMVkVY5D+fRr6zDNEjf9WZPKmnqbT4YNP3sH7//BkaX0Cog+hZLHUUfd/KmB7kETe
         VYxM/nudzh3QSVyE0SsgCH7W8VXtfLvvAitSzDBNeHJgF3DkwNWN+cZDcJdxKca7JegW
         4V/SBBAArfQ6C7sfvKvaZ3gieWb8RnLnkzs7iuTUbIpEwtt6UTZtl6M660cm+GKZbiSI
         tunxEWvsT84nzPE5jqD0UyIqmZ+/iWgzHiNPyvPmUUtXUOzY1o2RjhEcUOxusYpAc87H
         FeGbJSu0oCHv3hlq0R9LRfO43qNPw91YjyyktnQ8x1qskLoP+KARqHqf7Fixatvl74dn
         7l2g==
X-Gm-Message-State: AOAM532lcLGEe3QehEKgbhx2L7M8rZZTkhuJOtY64xP0qfUDCM79Ghh5
        r/XDn0EzFPm5DpVKr/hLl3lUqg==
X-Google-Smtp-Source: ABdhPJwpDd4WM6FwdwodUf2sRoeinFwrmGTHLWZnsRKj9w9luXNPQbO+J0nfwEIen5oBgqAJPcavgA==
X-Received: by 2002:adf:e551:: with SMTP id z17mr12558344wrm.374.1605415716935;
        Sat, 14 Nov 2020 20:48:36 -0800 (PST)
Received: from apalos.home (ppp-94-64-112-220.home.otenet.gr. [94.64.112.220])
        by smtp.gmail.com with ESMTPSA id 89sm17673023wrp.58.2020.11.14.20.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 20:48:36 -0800 (PST)
Date:   Sun, 15 Nov 2020 06:48:31 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
        jesse.brandeburg@intel.com, qi.z.zhang@intel.com, kuba@kernel.org,
        edumazet@google.com, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        intel-wired-lan@lists.osuosl.org, netanel@amazon.com,
        akiyano@amazon.com, michael.chan@broadcom.com,
        sgoutham@marvell.com, ioana.ciornei@nxp.com,
        ruxandra.radulescu@nxp.com, thomas.petazzoni@bootlin.com,
        mcroce@microsoft.com, saeedm@nvidia.com, tariqt@nvidia.com,
        aelior@marvell.com, ecree@solarflare.com, grygorii.strashko@ti.com,
        sthemmin@microsoft.com, mst@redhat.com, kda@linux-powerpc.org
Subject: Re: [PATCH bpf-next 6/9] xsk: propagate napi_id to XDP socket Rx path
Message-ID: <20201115044831.GA1304196@apalos.home>
References: <20201112114041.131998-1-bjorn.topel@gmail.com>
 <20201112114041.131998-7-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112114041.131998-7-bjorn.topel@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 12:40:38PM +0100, Bj�rn T�pel wrote:
> From: Bj�rn T�pel <bjorn.topel@intel.com>
> 
> Add napi_id to the xdp_rxq_info structure, and make sure the XDP
> socket pick up the napi_id in the Rx path. The napi_id is used to find
> the corresponding NAPI structure for socket busy polling.
> 
> Signed-off-by: Bj�rn T�pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
>  .../ethernet/cavium/thunder/nicvf_queues.c    |  2 +-
>  .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  2 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c     |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
>  drivers/net/ethernet/marvell/mvneta.c         |  2 +-
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 ++--
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
>  .../ethernet/netronome/nfp/nfp_net_common.c   |  2 +-
>  drivers/net/ethernet/qlogic/qede/qede_main.c  |  2 +-
>  drivers/net/ethernet/sfc/rx_common.c          |  2 +-
>  drivers/net/ethernet/socionext/netsec.c       |  2 +-
>  drivers/net/ethernet/ti/cpsw_priv.c           |  2 +-
>  drivers/net/hyperv/netvsc.c                   |  2 +-
>  drivers/net/tun.c                             |  2 +-
>  drivers/net/veth.c                            |  2 +-
>  drivers/net/virtio_net.c                      |  2 +-
>  drivers/net/xen-netfront.c                    |  2 +-
>  include/net/busy_poll.h                       | 19 +++++++++++++++----
>  include/net/xdp.h                             |  3 ++-
>  net/core/dev.c                                |  2 +-
>  net/core/xdp.c                                |  3 ++-
>  net/xdp/xsk.c                                 |  1 +
>  29 files changed, 47 insertions(+), 33 deletions(-)
> 
 
For the socionext driver

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
