Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5150224ACCD
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 04:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHTCCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 22:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHTCCA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 22:02:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0243C061383
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 19:01:59 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z18so261576otk.6
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 19:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6AI5eeMLSnuHLbo6ZZjQDIfs8rhjaUq4nVIf2nIA4s=;
        b=YnPCB7GyyenNNj4m6DTSkuaI05qpfHVG/QgzwK6ZW5cfzjXcjHWN5LAYlS6/sxdjkz
         Q3B6OAL6VkfXwnio6GpcqFThGxYHL16LeanA7XHdVMfn26QoX0g+phi2xhTniJx/oG4b
         By+2BEurn0lcdeK0Stus91++uccTrtAGABYgjAbl+ipAdepdfWEyi3uEFSsTuQd5UZBx
         BRrztqVUVKEKekr/BYTkoCsnvAO2Pj7IHdqvtB+4JORdtJ9ivIHukRoFwzuDiHXHnEM+
         GW1diuJzzXcDmzpqOY7Sm35sNw8MEKZLt3qU+FvbRqjP0SgosGrMRbrNiWiPtlstFAhc
         xoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6AI5eeMLSnuHLbo6ZZjQDIfs8rhjaUq4nVIf2nIA4s=;
        b=bP5apP5ShjVTumfdvqbw1r/s+NTvhYmMpbGPDCtcXG7J3ocQL1GMZtGnKjxPTOLJVA
         gxi7VqymtHS9Fst/rwgtOC95BF1X6GdWdlW+R+atooNHfFKvBNltHZ0/RDbxo/ZgahoH
         5YsmAsrboEUH8AaMDhVXKg7CWzolcDn0SzIR3r+ymB9+oXGRQwDWgCFMmpt/y2vB/u0b
         xhQMD6wBJC/AH6TNkuG7jWrNICNaPxQpqmJi7VyjC1cAHyRLNcrWe4av1WRaPyLtcIOL
         E2hNW9bHyceho7Z+tr/PXEemlcv+SnXzJbLy9kXQdFU7aS8bt7QIEioW7u5s+vl5+gDt
         jCbg==
X-Gm-Message-State: AOAM533/9suATF0KdCNvN0a3L8aqOUUlopYR+rgcPIvgsibFarndFatE
        EssLMZQgotCvQjDitmHKrGM87vfkjQGzR5iFdicYkg==
X-Google-Smtp-Source: ABdhPJy4t5xNUInvTbrdNktpIEEwJa9WXJ3VbyfLmNGHa9Tlogcfk1xfE/pD2NZhBS1V2JSKNp49dZbkVm49zRPUArk=
X-Received: by 2002:a05:6830:237b:: with SMTP id r27mr528934oth.352.1597888918873;
 Wed, 19 Aug 2020 19:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org> <CALAqxLU3bt6fT4nGHZFSnzyQq4xJo2On=c_Oa9ONED9-jhaFgw@mail.gmail.com>
In-Reply-To: <CALAqxLU3bt6fT4nGHZFSnzyQq4xJo2On=c_Oa9ONED9-jhaFgw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Aug 2020 19:01:46 -0700
Message-ID: <CALAqxLW98nVc-=8Q6nx-wRP1z8pzkw1_zNc9M7V3GhnJQqM9rg@mail.gmail.com>
Subject: Re: [PATCH 00/49] DRM driver for Hikey 970
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Liuyao An <anliuyao@huawei.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Wei Xu <xuwei5@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Network Development <netdev@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 2:36 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Aug 19, 2020 at 4:46 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> > So, IMO, the best is to keep it on staging for a while, until those
> > remaining bugs gets solved.
> >
> > I added this series, together with the regulator driver and
> > a few other patches (including a hack to fix a Kernel 5.8
> > regression at WiFi ) at:
> >
> >         https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master
>
> Sorry, one more small request: Could you create a branch that only has
> the DRM driver changes in it?
>
> The reason I ask, is that since the HiKey960 isn't affected by the
> majority of the problems you listed as motivation for going through
> staging. So if we can validate that your tree works fine on HiKey960,
> the series can be cleaned up and submitted properly upstream to enable
> that SoC, and the outstanding 970 issues can be worked out afterwards
> against mainline.

Just as a heads up, I tried testing your tree with my HiKey960, and
after fixing the compat string inconsistency, the drivers seem to load
properly. However the drm_hwcomposer seems to have some trouble with
the driver:
01-01 00:12:41.456   345   345 E hwc-drm-display-compositor: Commit
test failed for display 0, FIXME
01-01 00:12:41.456   345   345 E hwc-drm-two: Failed to apply the
frame composition ret=-22
01-01 00:12:41.456   351   351 E HWComposer:
presentAndGetReleaseFences: present failed for display 0: BadParameter
(4)

I'll dig in a bit further as to why, but wanted to give you a heads up.

thanks
-john
