Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB07467264
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 08:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378733AbhLCHPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 02:15:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42888 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbhLCHPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 02:15:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3391B81DCB;
        Fri,  3 Dec 2021 07:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60916C53FC7;
        Fri,  3 Dec 2021 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638515512;
        bh=83CYGlqu4IxdxRASAP3V0vFTniV6uzw++7hL/O+6/M0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiBjhaMFMXTr8yUd30E6nsfplxjABvl7IKlFzvV5/HAjmRAL8iKhBGupVxzXNVTo0
         jOqXmxMQCMOYsoawohqAxNgqWtK8RkIGAkAAd+KR+iyEHiLsc/hRGO0eV1eTkv3oWR
         JEW4F8wU1v09/Sc0rHQwH87d6EWoTd7DtXn8fcak=
Date:   Fri, 3 Dec 2021 08:11:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Peter Chen <peter.chen@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@canonical.com, mani@kernel.org,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        akpm@linux-foundation.org, thomas.hellstrom@linux.intel.com,
        matthew.auld@intel.com, colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH bpf v2] treewide: add missing includes masked by cgroup
 -> bpf dependency
Message-ID: <YanDM7hD9KucIRq6@kroah.com>
References: <20211202203400.1208663-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211202203400.1208663-1-kuba@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 02, 2021 at 12:34:00PM -0800, Jakub Kicinski wrote:
> cgroup.h (therefore swap.h, therefore half of the universe)
> includes bpf.h which in turn includes module.h and slab.h.
> Since we're about to get rid of that dependency we need
> to clean things up.
> 
> v2: drop the cpu.h include from cacheinfo.h, it's not necessary
> and it makes riscv sensitive to ordering of include files.
> 
> Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.org/  # v1
> Link: https://lore.kernel.org/all/20211120165528.197359-1-kuba@kernel.org/ # cacheinfo discussion
> Acked-by: Krzysztof Wilczyński <kw@linux.com>
> Acked-by: Peter Chen <peter.chen@kernel.org>
> Acked-by: SeongJae Park <sj@kernel.org>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
