Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6362CEDF5
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgLDMUC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 07:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726988AbgLDMUC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 07:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607084315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yV0H2A32XwiwqiM7qlFKTRy4N5oGQUtMJTuq8qIDfa0=;
        b=a6QyE3Vazxrdh4hffs94dPZ9cyaHlmqd+IWESdLvMZY8PGaAqwO6UAJShpJ/ZMpJOIP6hw
        mM9xI2yRqOC6zgHc4VVCbOyyKU+qbVGWS+qtbwD4g2GEYK1BThYzi/yHQhkIXjLKHCdy6U
        FYoCl86wVoaGdk3cJ/J8IHW3GJUmMK4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-8vJawfk1PAyIRnJY-BbqGA-1; Fri, 04 Dec 2020 07:18:33 -0500
X-MC-Unique: 8vJawfk1PAyIRnJY-BbqGA-1
Received: by mail-ed1-f72.google.com with SMTP id g1so2275683edk.0
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 04:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yV0H2A32XwiwqiM7qlFKTRy4N5oGQUtMJTuq8qIDfa0=;
        b=Sb/uHWAjVyO3RWF4EJd+i0e61QukedohWRZQQYcYOrniOsljOm4yBxrHXzzO4M/z1p
         p5GF4fnhlRzIF5LcbfFS/TTE4AsusSRieHzYhwvS1eqAv3a6yIxE2LS5DX4Z7xxeJqXZ
         STyuMKiER7EeX/8sMeK0HfYKMd/zo/kpgH+nOl9OrV4T0UBVfC2WEJEo/vXBXG8unpkx
         AO5hJ6FD6vLSvEmN47O85alv/5IXRC8dPXKy0HHaFdOtl54poKDiBMLq/ZRRNdxzI3wT
         lAo6UBUQmVFrPISpFgSh7Nb6Of/cK8Ipi8cFZfbmoF/BSU2okDNnJRKoODtUcCRj2BN+
         TEOQ==
X-Gm-Message-State: AOAM530rqwVJNidaICA9JAF6IM1HGcul/ZMTGVFA6N9J6qJ2BLR5FrOf
        abbnbZBzlebEUg0I6wAWiL+snY6pQHBOWKfXKXKbo1GYzJsK9IHPGDajSGoeodbhfANP9CjusP8
        F2LKMvvLhcgTk
X-Received: by 2002:a17:906:2a19:: with SMTP id j25mr6525700eje.506.1607084312681;
        Fri, 04 Dec 2020 04:18:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRAf0vbCMukeVPRXqkdupoZEIIMS/2Tcc+wvNymxp+NDt3vnsz4rhmViHnLHdfGwYf7cxIAg==
X-Received: by 2002:a17:906:2a19:: with SMTP id j25mr6525675eje.506.1607084312401;
        Fri, 04 Dec 2020 04:18:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j20sm2905690ejy.124.2020.12.04.04.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:18:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 59331182EEA; Fri,  4 Dec 2020 13:18:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     alardam@gmail.com, magnus.karlsson@intel.com,
        bjorn.topel@intel.com, andrii.nakryiko@gmail.com, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        davem@davemloft.net, john.fastabend@gmail.com, hawk@kernel.org
Cc:     maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        maciejromanfijalkowski@gmail.com, intel-wired-lan@lists.osuosl.org,
        Marek Majtyka <marekx.majtyka@intel.com>
Subject: Re: [PATCH v2 bpf 1/5] net: ethtool: add xdp properties flag set
In-Reply-To: <20201204102901.109709-2-marekx.majtyka@intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Dec 2020 13:18:31 +0100
Message-ID: <878sad933c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

alardam@gmail.com writes:

> From: Marek Majtyka <marekx.majtyka@intel.com>
>
> Implement support for checking what kind of xdp functionality a netdev
> supports. Previously, there was no way to do this other than to try
> to create an AF_XDP socket on the interface or load an XDP program and see
> if it worked. This commit changes this by adding a new variable which
> describes all xdp supported functions on pretty detailed level:

I like the direction this is going! :)

>  - aborted
>  - drop
>  - pass
>  - tx
>  - redirect

Drivers can in principle implement support for the XDP_REDIRECT return
code (and calling xdp_do_redirect()) without implementing ndo_xdp_xmit()
for being the *target* of a redirect. While my quick grepping doesn't
turn up any drivers that do only one of these right now, I think we've
had examples of it in the past, so it would probably be better to split
the redirect feature flag in two.

This would also make it trivial to replace the check in __xdp_enqueue()
(in devmap.c) from looking at whether the ndo is defined, and just
checking the flag. It would be great if you could do this as part of
this series.

Maybe we could even make the 'redirect target' flag be set automatically
if a driver implements ndo_xdp_xmit?

>  - zero copy
>  - hardware offload.
>
> Zerocopy mode requires that redirect xdp operation is implemented
> in a driver and the driver supports also zero copy mode.
> Full mode requires that all xdp operation are implemented in the driver.
> Basic mode is just full mode without redirect operation.
>
> Initially, these new flags are disabled for all drivers by default.
>
> Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
> ---
>  .../networking/netdev-xdp-properties.rst      | 42 ++++++++
>  include/linux/netdevice.h                     |  2 +
>  include/linux/xdp_properties.h                | 53 +++++++++++
>  include/net/xdp.h                             | 95 +++++++++++++++++++
>  include/net/xdp_sock_drv.h                    | 10 ++
>  include/uapi/linux/ethtool.h                  |  1 +
>  include/uapi/linux/xdp_properties.h           | 32 +++++++
>  net/ethtool/common.c                          | 11 +++
>  net/ethtool/common.h                          |  4 +
>  net/ethtool/strset.c                          |  5 +
>  10 files changed, 255 insertions(+)
>  create mode 100644 Documentation/networking/netdev-xdp-properties.rst
>  create mode 100644 include/linux/xdp_properties.h
>  create mode 100644 include/uapi/linux/xdp_properties.h
>
> diff --git a/Documentation/networking/netdev-xdp-properties.rst b/Documentation/networking/netdev-xdp-properties.rst
> new file mode 100644
> index 000000000000..4a434a1c512b
> --- /dev/null
> +++ b/Documentation/networking/netdev-xdp-properties.rst
> @@ -0,0 +1,42 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Netdev XDP properties
> +=====================
> +
> + * XDP PROPERTIES FLAGS
> +
> +Following netdev xdp properties flags can be retrieve over netlink ethtool
> +interface the same way as netdev feature flags. These properties flags are
> +read only and cannot be change in the runtime.
> +
> +
> +*  XDP_ABORTED
> +
> +This property informs if netdev supports xdp aborted action.
> +
> +*  XDP_DROP
> +
> +This property informs if netdev supports xdp drop action.
> +
> +*  XDP_PASS
> +
> +This property informs if netdev supports xdp pass action.
> +
> +*  XDP_TX
> +
> +This property informs if netdev supports xdp tx action.
> +
> +*  XDP_REDIRECT
> +
> +This property informs if netdev supports xdp redirect action.
> +It assumes the all beforehand mentioned flags are enabled.
> +
> +*  XDP_ZEROCOPY
> +
> +This property informs if netdev driver supports xdp zero copy.
> +It assumes the all beforehand mentioned flags are enabled.

Nit: I think 'XDP_ZEROCOPY' can lead people to think that this is
zero-copy support for all XDP operations, which is obviously not the
case. So maybe 'XDP_SOCK_ZEROCOPY' (and update the description to
mention AF_XDP sockets explicitly)?

-Toke

