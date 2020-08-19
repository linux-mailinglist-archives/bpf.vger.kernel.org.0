Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC624A73D
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHSTw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 15:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHSTwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 15:52:19 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B696C061344
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 12:52:19 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h16so20049268oti.7
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20eRCPt9U7XROuUscJl4o9bl5XBe7/+hwEOIYHyciSM=;
        b=TDvGe73fi0mYFcu8gy0zyv7nAwTvj7LZXmceDEUKPP8XfBtwIw8eDnhZKXXW/8lOST
         i3mwXYbXDDRyFBEBUEFYWxYynj8XahsSAx/k6lpaNmRyovcJDE7Y/1Us5/lAXLoB+fny
         MXwugodqdfXUpnDdV+YqwtDPcrU39IcwaELeeOIEfQVGHH8qMEJzhHrmfsPm50dMtK8D
         E2hgWNg9hTGAkp/gDSRS2/SFCteSIRgMdFhm92/90JvBoxi1tgk0nM350xbrUY9djJu/
         Vayz78+1GIbV3JXLHBbEvqxWVmcLvT6HCup7VhLEysHQgvZVLA6bXvrYb7L+4t8Mxya5
         O2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20eRCPt9U7XROuUscJl4o9bl5XBe7/+hwEOIYHyciSM=;
        b=JsYPL0RgVCBNgREbSnZ8OSUguU9l2bYKXSmzO5EWDAXYtPKF9aQAaY2fw6El6xY964
         TLnnxg5yYY2cXGCZq6brw+ltmt8VeRS8lEtsHk7Rq9yit/cGc4MBix35yFDagzH4+ckh
         Al1GjWs2pTZqcRyE0tVIY9G5FM+/XttceBT/6vESvdwjMbrZDyFQh4F28liS6q/a4Z+B
         2W8LwktW4Ysa/yr0CRgXHeonAWCwRjqd2/zkXntQYk0uro4LJe9VVwYbTL/1qlJTS88H
         A4jToy/jwdwam6XRxKcYBp/XL9LHfuiuizhqeqX7cxz1T771fSU0OZ/WPtEiSeP+4TOi
         rxjQ==
X-Gm-Message-State: AOAM533TbIL2TswT8pB/NYoo3KXWJutbx+FFiyoTzv6xqMXB55pwAj/O
        H1IVJ7tX9/+0QZQZp3ZTX7gajnELkLdRVJyHJ5+xzg==
X-Google-Smtp-Source: ABdhPJziBBPPuDZCBcZoysAn7wtSqkMtfGL35ZZB/FJ/a7yXT1Ut5k0YtYAU8hIkSuF0vuVhhtyHAco3tq76syVzuqI=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr18795170otq.221.1597866737290;
 Wed, 19 Aug 2020 12:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
 <20200819152120.GA106437@ravnborg.org> <20200819153045.GA18469@pendragon.ideasonboard.com>
In-Reply-To: <20200819153045.GA18469@pendragon.ideasonboard.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Aug 2020 12:52:06 -0700
Message-ID: <CALAqxLUXnPRec3UYbMKge8yNKBagLOatOeRCagF=JEyPEfWeKA@mail.gmail.com>
Subject: Re: [PATCH 00/49] DRM driver for Hikey 970
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        linuxarm@huawei.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liwei Cai <cailiwei@hisilicon.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Rob Herring <robh+dt@kernel.org>,
        mauro.chehab@huawei.com, Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Liuyao An <anliuyao@huawei.com>,
        Network Development <netdev@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 8:31 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Aug 19, 2020 at 05:21:20PM +0200, Sam Ravnborg wrote:
> > On Wed, Aug 19, 2020 at 01:45:28PM +0200, Mauro Carvalho Chehab wrote:
> > > This patch series port the out-of-tree driver for Hikey 970 (which
> > > should also support Hikey 960) from the official 96boards tree:
> > >
> > >    https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> > >
> > > Based on his history, this driver seems to be originally written
> > > for Kernel 4.4, and was later ported to Kernel 4.9. The original
> > > driver used to depend on ION (from Kernel 4.4) and had its own
> > > implementation for FB dev API.
> > >
> > > As I need to preserve the original history (with has patches from
> > > both HiSilicon and from Linaro),  I'm starting from the original
> > > patch applied there. The remaining patches are incremental,
> > > and port this driver to work with upstream Kernel.
> > >
...
> > > - Due to legal reasons, I need to preserve the authorship of
> > >   each one responsbile for each patch. So, I need to start from
> > >   the original patch from Kernel 4.4;
...
> > I do acknowledge you need to preserve history and all -
> > but this patchset is not easy to review.
>
> Why do we need to preserve history ? Adding relevant Signed-off-by and
> Co-developed-by should be enough, shouldn't it ? Having a public branch
> that contains the history is useful if anyone is interested, but I don't
> think it's required in mainline.

Yea. I concur with Laurent here. I'm not sure what legal reasoning you
have on this but preserving the "absolute" history here is actively
detrimental for review and understanding of the patch set.

Preserving Authorship, Signed-off-by lines and adding Co-developed-by
lines should be sufficient to provide both atribution credit and DCO
history.

thanks
-john
