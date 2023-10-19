Return-Path: <bpf+bounces-12660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548327CEFE1
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B7EB21233
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95120FD;
	Thu, 19 Oct 2023 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccwRWMPl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880046699
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:10:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361DAFE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697695836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UhCiLXC3GKhC7LBn7PFGeNEM6rzFh/63mwCf1MnfRg=;
	b=ccwRWMPl9l/tbGNxjKa2dp4tpZ3Pd118DR/29VYnMCTP131bG5sf3/kF9ZQSR6/UNXYKVW
	ftbY60YEMCVELaRbveGghsVl+l5uOPfNgRIYO/LfjrrHp+rEmexpXbs0waJYzwMEpORDyB
	15HPubN0RvSSyG4L/AbVlbCqmqF6p2g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-DLLVCi6KN5iLIy0qceUlkQ-1; Thu, 19 Oct 2023 02:10:34 -0400
X-MC-Unique: DLLVCi6KN5iLIy0qceUlkQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50483ed1172so7450699e87.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697695833; x=1698300633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UhCiLXC3GKhC7LBn7PFGeNEM6rzFh/63mwCf1MnfRg=;
        b=hiKDK9UjJGLPJtlHa5gooJkox4C6/K2LZqF0ZWozHCxJbL/nuoHPg3syEoLJMtWU7i
         Z5jpL5TGIV1lVlteY9VoAsoAzRNytA97tSDwfttnk2iipRA+gj8yX1Gr6Jap+1TJzYJV
         y9XYyi76gBgXHmx6v2VKSwvJ/MFJh8lY3NPH2cqvCn6vuygbS0RmqFRICYhcDJ2haGKi
         BgxpJMjZLamZos0B0Ve68O2DcieV8psf3VgzQq0oFdel5pItmwEiOVydOsKSgLIYftgs
         X/8zWhvTKx9v+UjkPDPoAjuXhoga8RsifBy6mXS/G+uFpib+pFpoVdepp8jENNF/aECB
         5vGQ==
X-Gm-Message-State: AOJu0YzQiNpmoAsrNoU133KIuDpQWD3YUcnWUiI02TR3RSEpnb6cyua+
	vdF8oQM1185fi/WWCMHbRVU1W6VHkofq1g1l4zwBgcU5A6pbMYy82nlww4uVfJ0lVqRr/nrVwWN
	addEEpC/lk3nLLkyii0X4mAVHngf/
X-Received: by 2002:a05:6512:15a2:b0:507:ce49:81bd with SMTP id bp34-20020a05651215a200b00507ce4981bdmr896112lfb.61.1697695832954;
        Wed, 18 Oct 2023 23:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8sj9k9xpWrn8oW1b/1IrnZYzb/HZkAuesmJBQStjDAxGGfZvTonP0LgNbiePQysfQCChTXRtGf1G0Iwe7dDw=
X-Received: by 2002:a05:6512:15a2:b0:507:ce49:81bd with SMTP id
 bp34-20020a05651215a200b00507ce4981bdmr896094lfb.61.1697695832620; Wed, 18
 Oct 2023 23:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:10:21 +0800
Message-ID: <CACGkMEtR_OKWQC03HY-pnBGXsMqnD92uS3qHC+DwZy38tDKnwg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 03/19] virtio_net: independent directory
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Create a separate directory for virtio-net. AF_XDP support will be added
> later, then a separate xsk.c file will be added, so we should create a
> directory for virtio-net.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  MAINTAINERS                                 |  2 +-
>  drivers/net/Kconfig                         |  8 +-------
>  drivers/net/Makefile                        |  2 +-
>  drivers/net/virtio/Kconfig                  | 13 +++++++++++++
>  drivers/net/virtio/Makefile                 |  8 ++++++++
>  drivers/net/{virtio_net.c =3D> virtio/main.c} |  0
>  6 files changed, 24 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c186c214c54..e4fbcbc100e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22768,7 +22768,7 @@ F:      Documentation/devicetree/bindings/virtio/
>  F:     Documentation/driver-api/virtio/
>  F:     drivers/block/virtio_blk.c
>  F:     drivers/crypto/virtio/
> -F:     drivers/net/virtio_net.c
> +F:     drivers/net/virtio/
>  F:     drivers/vdpa/
>  F:     drivers/virtio/
>  F:     include/linux/vdpa.h
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 44eeb5d61ba9..54ee6fa4f4a6 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -430,13 +430,7 @@ config VETH
>           When one end receives the packet it appears on its pair and vic=
e
>           versa.
>
> -config VIRTIO_NET
> -       tristate "Virtio network driver"
> -       depends on VIRTIO
> -       select NET_FAILOVER
> -       help
> -         This is the virtual network driver for virtio.  It can be used =
with
> -         QEMU based VMMs (like KVM or Xen).  Say Y or M.
> +source "drivers/net/virtio/Kconfig"
>
>  config NLMON
>         tristate "Virtual netlink monitoring device"
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index e26f98f897c5..47537dd0f120 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -31,7 +31,7 @@ obj-$(CONFIG_NET_TEAM) +=3D team/
>  obj-$(CONFIG_TUN) +=3D tun.o
>  obj-$(CONFIG_TAP) +=3D tap.o
>  obj-$(CONFIG_VETH) +=3D veth.o
> -obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> +obj-$(CONFIG_VIRTIO_NET) +=3D virtio/
>  obj-$(CONFIG_VXLAN) +=3D vxlan/
>  obj-$(CONFIG_GENEVE) +=3D geneve.o
>  obj-$(CONFIG_BAREUDP) +=3D bareudp.o
> diff --git a/drivers/net/virtio/Kconfig b/drivers/net/virtio/Kconfig
> new file mode 100644
> index 000000000000..d8ccb3ac49df
> --- /dev/null
> +++ b/drivers/net/virtio/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# virtio-net device configuration
> +#
> +config VIRTIO_NET
> +       tristate "Virtio network driver"
> +       depends on VIRTIO
> +       select NET_FAILOVER
> +       help
> +         This is the virtual network driver for virtio.  It can be used =
with
> +         QEMU based VMMs (like KVM or Xen).
> +
> +         Say Y or M.
> diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
> new file mode 100644
> index 000000000000..15ed7c97fd4f
> --- /dev/null
> +++ b/drivers/net/virtio/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the virtio network device drivers.
> +#
> +
> +obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> +
> +virtio_net-y :=3D main.o
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio/main.c
> similarity index 100%
> rename from drivers/net/virtio_net.c
> rename to drivers/net/virtio/main.c
> --
> 2.32.0.3.g01195cf9f
>


