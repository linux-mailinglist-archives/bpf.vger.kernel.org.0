Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE05824A896
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 23:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHSVhI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 17:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSVhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 17:37:05 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B53C061383
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 14:37:05 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k12so20331568otr.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CS+1467DMyFTqT+L2iSQMSr95xvUjx22mgQhPk7Fd0U=;
        b=Ta+g1ZgTNyWRyOadjtYmnLrqkRKTp1Yqu3v85C1PlgWit/t/GfBuyJrf7KkLtWIp5c
         obzIbdbmc69nlF0yFwItQxDewv3hhDIcu4hovzlskeqJwIK5mpzk6z3aUtqJgZ+DSflY
         89K5nsJMI1E2px6cL3lCPAuXNqy6alXpd5Y8B86lVTMT5axCkRcmg1r9PnfhQ5ysxkGw
         xuEboslpGgpoBK6kcsX6zimi7fbM/InmxLfMxBl2sylTbbrjYVKKzRv0miXc9y+CbO46
         JPua5bOPXgPoLuzKVJq2PfJRU09D5n/WRI+3dX0QohzqYTWhWbS5DQscx/5yGjUDXe5V
         X2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CS+1467DMyFTqT+L2iSQMSr95xvUjx22mgQhPk7Fd0U=;
        b=DoZIbunn4QqeMbmKmHkv2EsqlW4Q4r24PMxT/t+ccTm/9rMMWJ2Jkibf0Bwcb+jyQ9
         TYW+PzI1/3QfHNOYlP38/86zxEWjcobGZ1n9dOGOCWfz+FkQ8p56vnkgAF1yg5OGh7F8
         8r8doWa7Ym9PJja+x4deXNKZuU2TeB6typwNPwl1xdq7xcEaPUHCTtqTNbMxRm7sMdfF
         qdaI6KnKWhJAxdDmTbKSwV7pJAhCSP/1bfLgEO3ySAhjuwlAXMF/Tj4l0TUZSmjE3Gfz
         sUNX+u+7Xv1J58YjvEYDElWVnX4WH3ocE6pbqGJlfIrscF5Rqi9FicnuBIDvL/T5PvhL
         k6Rw==
X-Gm-Message-State: AOAM530VcIAw4t6adbZdhqa9XhVcXm5/KG9550Slon3vwsIqDWv9OeaE
        uFwO7HrOtTOFzrSBW3UMm8Ded4VoZkQMJDEeUQKAwg==
X-Google-Smtp-Source: ABdhPJxpl82rAqK2FHLd0zX7VnPn8+94l8zujbb1JUnY5F6i+DaLJ+lsZzhjUgUndjPKQh1QUFVxfaVx/wGs30VKOyU=
X-Received: by 2002:a05:6830:3196:: with SMTP id p22mr21167646ots.102.1597873024596;
 Wed, 19 Aug 2020 14:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Aug 2020 14:36:52 -0700
Message-ID: <CALAqxLU3bt6fT4nGHZFSnzyQq4xJo2On=c_Oa9ONED9-jhaFgw@mail.gmail.com>
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
        Xiubin Zhang <zhangxiubin1@huawei.com>,
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

On Wed, Aug 19, 2020 at 4:46 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> So, IMO, the best is to keep it on staging for a while, until those
> remaining bugs gets solved.
>
> I added this series, together with the regulator driver and
> a few other patches (including a hack to fix a Kernel 5.8
> regression at WiFi ) at:
>
>         https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master

Sorry, one more small request: Could you create a branch that only has
the DRM driver changes in it?

The reason I ask, is that since the HiKey960 isn't affected by the
majority of the problems you listed as motivation for going through
staging. So if we can validate that your tree works fine on HiKey960,
the series can be cleaned up and submitted properly upstream to enable
that SoC, and the outstanding 970 issues can be worked out afterwards
against mainline.

thanks
-john
