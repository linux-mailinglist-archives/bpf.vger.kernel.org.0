Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005413DF698
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhHCUtS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Aug 2021 16:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhHCUtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Aug 2021 16:49:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F0A9600CD;
        Tue,  3 Aug 2021 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628023743;
        bh=L2qchuYbxOyp+fqlYH+GFJsXG7DrUHTwSWRLZdczBU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A+RmfSYvHE9P11/WJxmxViKPghkRtHhAHs0LjUnjSjnxkmVH2KPrPMiliYT1Bkfs8
         eVGh1fEYmTwW4iJl8tmCGV8VlS2/9c/cPG2sgHqZnFiJ9H4o7j3R4OKQEuXvF92pJD
         ps1GjONP5qzzLDf7Wta6mlOCKhAlOFSlSTsjKw4QmRMgGvTMoovnupuvPzKsvBPj7C
         DzxzKRUBT7eiWJWoe3bjWJhUYp2A0lzVFV82ceV6lRRQhj9BK2lelnV+g64cZMw89N
         uOBJqzTMbmKzM1Fnw2DDJGMONk2sl8G2c35MRZsvKlkzHmzuwa539Aow4rDCYRY0Lf
         FxTqvypFbSmVg==
Date:   Tue, 3 Aug 2021 13:49:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        Marcin Kubiak <marcin.kubiak@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Netanel Belgazal <netanel@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shay Agroskin <shayagr@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
        Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jian Shen <shenjian15@huawei.com>,
        Petr Vorel <petr.vorel@gmail.com>, Dan Murphy <dmurphy@ti.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/21] ethtool, stats: introduce standard XDP
 statistics
Message-ID: <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210803163641.3743-4-alexandr.lobakin@intel.com>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
        <20210803163641.3743-4-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  3 Aug 2021 18:36:23 +0200 Alexander Lobakin wrote:
> Most of the driver-side XDP enabled drivers provide some statistics
> on XDP programs runs and different actions taken (number of passes,
> drops, redirects etc.).

Could you please share the statistics to back that statement up?
Having uAPI for XDP stats is pretty much making the recommendation 
that drivers should implement such stats. The recommendation from
Alexei and others back in the day (IIRC) was that XDP programs should
implement stats, not the drivers, to avoid duplication.

> Regarding that it's almost pretty the same across all the drivers
> (which is obvious), we can implement some sort of "standardized"
> statistics using Ethtool standard stats infra to eliminate a lot
> of code and stringsets duplication, different approaches to count
> these stats and so on.

I'm not 100% sold on the fact that these should be ethtool stats. 
Why not rtnl_fill_statsinfo() stats? Current ethtool std stats are 
all pretty Ethernet specific, and all HW stats. Mixing HW and SW stats
is what we're trying to get away from.

> These new 12 fields provided by the standard XDP stats should cover
> most, if not all, stats that might be interesting for collecting and
> tracking.
> Note that most NIC drivers keep XDP statistics on a per-channel
> basis, so this also introduces a new callback for getting a number
> of channels which a driver will provide stats for. If it's not
> implemented or returns 0, it means stats are global/device-wide.

Per-channel stats via std ethtool stats are not a good idea. Per queue
stats must be via the queue netlink interface we keep talking about for
ever but which doesn't seem to materialize. When stats are reported via
a different interface than objects they pertain to matching stats,
objects and their lifetime becomes very murky.
