Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB1457EE8
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbhKTP3I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 10:29:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhKTP3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 10:29:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5B5B60EB6;
        Sat, 20 Nov 2021 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637421964;
        bh=sL04+7/Tziaw15CHiE2bty/Bv6qeql7yB4oQSwHL8Rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N35/MX+Bk5IfQeZQiu16BeV4YuD31Ephij5WJvzDmZ2G+K+MjYa+HWqb1ahmMn5Hb
         8nTHe95BsmdqkyFWylC9DLYJd5w68+maTSegSteQm994SJN2V2euBCo7o5awfS7MX1
         1EqL1r1uDdGsdYVLkB0LepzAMd/DMg1DnO37cYnq/TOnx6T6gg4l1tr4VYZFrfdNBr
         fu07uKG0PLQcKTAn5J7IOkR76pmhpIN6NdZJHm5NPKAY2SAGobyGEmgVfnmJURZZPl
         Ncx/4o043Jc/OWEbZSwAM5dDl3KRkS71kl4wzNRFF/bIFRAmgFMC+aeEM6/O5rxXi9
         UVuYgRSm1FojA==
Date:   Sat, 20 Nov 2021 07:26:02 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Peter Chen <peter.chen@kernel.org>
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
Message-ID: <20211120072602.22f9e722@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211120073011.GA36650@Peter>
References: <20211120035253.72074-1-kuba@kernel.org>
        <20211120073011.GA36650@Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 20 Nov 2021 15:30:11 +0800 Peter Chen wrote:
> > diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> > index 84dadfa726aa..9643b905e2d8 100644
> > --- a/drivers/usb/cdns3/host.c
> > +++ b/drivers/usb/cdns3/host.c
> > @@ -10,6 +10,7 @@
> >   */
> > =20
> >  #include <linux/platform_device.h>
> > +#include <linux/slab.h> =20
>=20
> Should be "#include <linux/module.h>"?

Why? Different files are missing different includes, this one needs
slab.h:

../drivers/usb/cdns3/host.c: In function =E2=80=98__cdns_host_init=E2=80=99:
../drivers/usb/cdns3/host.c:86:2: error: implicit declaration of function =
=E2=80=98kfree=E2=80=99; did you mean =E2=80=98vfree=E2=80=99? [-Werror=3Di=
mplicit-function-declaration]
  kfree(cdns->xhci_plat_data);
  ^~~~~
  vfree
