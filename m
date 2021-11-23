Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5102D45A34E
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhKWMyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 07:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhKWMyq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 07:54:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57D3560F9F;
        Tue, 23 Nov 2021 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637671898;
        bh=wIrWQf7YDEFEE/QQ99FQt/AhMw3wdmvSFHVUP3uKPJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGkZLrvRZ8KTMwcjmn6QaI1qSGzu+DoXhu8PQwdm/+cC5pDtmTATs6POIbgvzvvxo
         dvx+KAr/Q+u+JS9xVPk6U+7MmUsBqP+41x4NGLkHYCxIDvlSTvBzSwwSfjybOfj2nq
         TWRsQoUsqmsGmFLBAmPGIX/fzXnDaxy9cZciaQXE+GdZ9Q0gggepiKZXZcNrbqfcrR
         nHkhXzC+DvQ0+sPze3evyAcW6a63+vYer0kxBjG7JGzCBaYsm5sgS1HDHOjsFSlWxO
         c9lRiHDTKp2sG2VkVB8n9OMhlpaRH11oqA5Gp/3+CBjyqqPEmeO+zBNBu7sa5kiK9F
         SG13871QjbYqQ==
Date:   Tue, 23 Nov 2021 20:51:08 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzysztof.kozlowski@canonical.com,
        mani@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sj@kernel.org, akpm@linux-foundation.org,
        thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
        colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH bpf] treewide: add missing includes masked by cgroup ->
 bpf dependency
Message-ID: <20211123125108.GA4453@Peter>
References: <20211120035253.72074-1-kuba@kernel.org>
 <20211120073011.GA36650@Peter>
 <20211120072602.22f9e722@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211120072602.22f9e722@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21-11-20 07:26:02, Jakub Kicinski wrote:
> On Sat, 20 Nov 2021 15:30:11 +0800 Peter Chen wrote:
> > > diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> > > index 84dadfa726aa..9643b905e2d8 100644
> > > --- a/drivers/usb/cdns3/host.c
> > > +++ b/drivers/usb/cdns3/host.c
> > > @@ -10,6 +10,7 @@
> > >   */
> > >  
> > >  #include <linux/platform_device.h>
> > > +#include <linux/slab.h>  
> > 
> > Should be "#include <linux/module.h>"?
> 
> Why? Different files are missing different includes, this one needs
> slab.h:
> 
> ../drivers/usb/cdns3/host.c: In function ‘__cdns_host_init’:
> ../drivers/usb/cdns3/host.c:86:2: error: implicit declaration of function ‘kfree’; did you mean ‘vfree’? [-Werror=implicit-function-declaration]
>   kfree(cdns->xhci_plat_data);
>   ^~~~~
>   vfree

Oh, my fault.

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen

