Return-Path: <bpf+bounces-55488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B1A81857
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 00:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612A91BA649E
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 22:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0E225522E;
	Tue,  8 Apr 2025 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNZR50W7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA32222D4
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150525; cv=none; b=p+7glwPp5QdhEPy4huPddtf2+NkbolXsl6AFyAMm5to3tQCRsXWP6AJrXAxVvvTHxNsuLF1Zs4lIr0WG7ZUkiLg5gpgujaEOm0d2hHqg/FlRcZW7HDwMvmzNmJRWtNvzu3oYGJxCAzTSHA4zBYVrxWI0gxsPNZU3N6VsEQT0paI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150525; c=relaxed/simple;
	bh=ymX4dIRPic9zvrJACKLYLv1G02mB9g/rcSTLeciphJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/PJqKIX6Fv+2JvqwjXbPvILTGs9Z/0oNul/KTphCAU6J6LxDFazITZrOVgG6hl18Y/2xv6s5UOnVXgsXfR3yRnJUbZO5/G9TzUm5PhdAORWpo53ix9DKyuquR308tRO73k9IHLwhKgAkfvsg8DC+LtcsPpvsFtS0M0kyDvqIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNZR50W7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2242ac37caeso24115ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744150523; x=1744755323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R26j2r5S96z2OcbbsW34VxJDiG5NKr0WT7wRGF+QFDQ=;
        b=rNZR50W7a/7L39Fz8t6BJj0jUATGpxVHdvHyEE0/HJShqL9+fM/mP2lGlVbGvRO6hW
         i6XOY3g4wX6lf5gnb1JudJSXLwWMMOPHj1oqrV9tGNVhoDFGpb9kMo6s6RHrKFiTkzHQ
         06c8KBsImD7YJZiKYhS2KTek915SjynKttUuHk8bFR3aQi5QjAxfaf1BvK6EmlxVi/31
         YXg+XEou7FdobvXWKOSaqBydJLqvkSXOj74Ou66wKYrhDXimL+JqipsazQgWI3j78IEv
         weSEez+hHGwpfhVf7bNoqr/zvX6Kn9ElP1WOce8j/RpuWIfJ7Rs1N2BYoGcfcmBHovib
         iMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744150523; x=1744755323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R26j2r5S96z2OcbbsW34VxJDiG5NKr0WT7wRGF+QFDQ=;
        b=WYm7HEUDz4+HjlJ9z/n9jH0hN9+ffjrCAb7ZefxKLHHCAj4ibHM+7Rji8gONrxBJuS
         pztRXKFUjVda07kzuImrEKCfMb46CwPvhz9n1Abp+lWszLZD3YiifPf/VGxnrIz83Jo6
         JUo6G8kIXUIudmW59orvnYzO8hSUDkkFP2/LZRWtMpxRl6T86YbxxTBurUov64ZKf3NN
         zCp6gIPQA9of8PbuH7hwGL9IgQPFHQFMSKqZ8PeXw860pXxE6gwIT1uyebzWFTVs6l54
         lhm/YLoSeJ/k8WXiv8KmCzN6Xlt3F+hLy120qvuHRVB2oc4hjIT64xAw2Neb8OkS9fLl
         th8w==
X-Forwarded-Encrypted: i=1; AJvYcCWWAMdw6BvLI4SwaHw9KS3S0rPkgLl/PT1MfCHFrGI8Oe0ZGLo4qzKuyniMuiE7q+JnPQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTHO1hkcQWyWlzr0URflMF6Vz8lYchD4bycPSdDXsUg/vFYDY
	Ial+Bmjo4rbdl7ARMz/Kp8Qs5JSuCAHwJ3P/reGI5xwoe83nBfSCGlEArcBxkbMp6fvC+Rh5Sbo
	l5Fs7bSr53Nu9RkqXRQ3C+L33PWIxMpfRwQky
X-Gm-Gg: ASbGncvq7BXV1RTel7Jl51Wn2zJd/b4uHsJ4Bfa2pjWjjfvqkHQv0rObgmTlOD3kk2M
	shpDpnvFPCBf0S4RA03KTZlD2n/kULzyyMlw/gk1YgI4pLtFBJZAfxEQcki5wP/Ugn1q7d8Xbq+
	Q3JHu3jvVdYpNFMIaFynngH1Wl/1pv7stek5wNw8x3eYJGqnc0Kuoxv8lvGAg=
X-Google-Smtp-Source: AGHT+IG+GD1sHLOio8gHHG3tzHr9TSJKtxR8zCr6vFgKg2jgSG3XTHZ9peLGjGPw2DRtPzUvaHXE7kanOLr7rmSOeyA=
X-Received: by 2002:a17:903:2308:b0:223:5182:6246 with SMTP id
 d9443c01a7336-22ac4742f75mr347255ad.23.1744150522798; Tue, 08 Apr 2025
 15:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408195956.412733-1-kuba@kernel.org> <20250408195956.412733-6-kuba@kernel.org>
In-Reply-To: <20250408195956.412733-6-kuba@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 8 Apr 2025 15:15:11 -0700
X-Gm-Features: ATxdqUEdjiK0IWvoFzsP1Bcr3yzshtA1cru5eQcy4iyyuERPPzhSJe9eIUn48s0
Message-ID: <CAEAWyHcqNagO86fPe4TLVTU3XopRiNU1zcj7wTSf8bZH3Sg8YA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] xdp: double protect netdev->xdp_flags
 with netdev->lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@amazon.com, jdamato@fastly.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Protect xdp_features with netdev->lock. This way pure readers
> no longer have to take rtnl_lock to access the field.
>
> This includes calling NETDEV_XDP_FEAT_CHANGE under the lock.
> Looks like that's fine for bonding, the only "real" listener,
> it's the same as ethtool feature change.
>
> In terms of normal drivers - only GVE need special consideration
> (other drivers don't use instance lock or don't support XDP).
> It calls xdp_set_features_flag() helper from gve_init_priv() which
> in turn is called from gve_reset_recovery() (locked), or prior
> to netdev registration. So switch to _locked.
>
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
> CC: bpf@vger.kernel.org
> ---
>  Documentation/networking/netdevices.rst    |  1 +
>  include/linux/netdevice.h                  |  2 +-
>  include/net/xdp.h                          |  1 +
>  drivers/net/ethernet/google/gve/gve_main.c |  2 +-
>  net/core/lock_debug.c                      |  2 +-
>  net/core/xdp.c                             | 12 +++++++++++-
>  6 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/netw=
orking/netdevices.rst
> index 6c2d8945f597..d6357472d3f1 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -354,6 +354,7 @@ For devices with locked ops, currently only the follo=
wing notifiers are
>  running under the lock:
>  * ``NETDEV_REGISTER``
>  * ``NETDEV_UP``
> +* ``NETDEV_XDP_FEAT_CHANGE``
>
>  The following notifiers are running without the lock:
>  * ``NETDEV_UNREGISTER``
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7242fb8a22fc..dece2ae396a1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2526,7 +2526,7 @@ struct net_device {
>          *      @net_shaper_hierarchy, @reg_state, @threaded
>          *
>          * Double protects:
> -        *      @up, @moving_ns, @nd_net
> +        *      @up, @moving_ns, @nd_net, @xdp_flags
>          *
>          * Double ops protects:
>          *      @real_num_rx_queues, @real_num_tx_queues
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 48efacbaa35d..20e41b5ff319 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -616,6 +616,7 @@ struct xdp_metadata_ops {
>  u32 bpf_xdp_metadata_kfunc_id(int id);
>  bool bpf_dev_bound_kfunc_id(u32 btf_id);
>  void xdp_set_features_flag(struct net_device *dev, xdp_features_t val);
> +void xdp_set_features_flag_locked(struct net_device *dev, xdp_features_t=
 val);
>  void xdp_features_set_redirect_target(struct net_device *dev, bool suppo=
rt_sg);
>  void xdp_features_clear_redirect_target(struct net_device *dev);
>  #else
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index f9a73c956861..7a249baee316 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2185,7 +2185,7 @@ static void gve_set_netdev_xdp_features(struct gve_=
priv *priv)
>                 xdp_features =3D 0;
>         }
>
> -       xdp_set_features_flag(priv->dev, xdp_features);
> +       xdp_set_features_flag_locked(priv->dev, xdp_features);
>  }
>
>  static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
> index b7f22dc92a6f..598c443ef2f3 100644
> --- a/net/core/lock_debug.c
> +++ b/net/core/lock_debug.c
> @@ -20,6 +20,7 @@ int netdev_debug_event(struct notifier_block *nb, unsig=
ned long event,
>         switch (cmd) {
>         case NETDEV_REGISTER:
>         case NETDEV_UP:
> +       case NETDEV_XDP_FEAT_CHANGE:
>                 netdev_ops_assert_locked(dev);
>                 fallthrough;
>         case NETDEV_DOWN:
> @@ -58,7 +59,6 @@ int netdev_debug_event(struct notifier_block *nb, unsig=
ned long event,
>         case NETDEV_OFFLOAD_XSTATS_DISABLE:
>         case NETDEV_OFFLOAD_XSTATS_REPORT_USED:
>         case NETDEV_OFFLOAD_XSTATS_REPORT_DELTA:
> -       case NETDEV_XDP_FEAT_CHANGE:
>                 ASSERT_RTNL();
>                 break;
>
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a..3cd0db9c9d2d 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -17,6 +17,7 @@
>  #include <net/page_pool/helpers.h>
>
>  #include <net/hotdata.h>
> +#include <net/netdev_lock.h>
>  #include <net/xdp.h>
>  #include <net/xdp_priv.h> /* struct xdp_mem_allocator */
>  #include <trace/events/xdp.h>
> @@ -991,17 +992,26 @@ static int __init xdp_metadata_init(void)
>  }
>  late_initcall(xdp_metadata_init);
>
> -void xdp_set_features_flag(struct net_device *dev, xdp_features_t val)
> +void xdp_set_features_flag_locked(struct net_device *dev, xdp_features_t=
 val)
>  {
>         val &=3D NETDEV_XDP_ACT_MASK;
>         if (dev->xdp_features =3D=3D val)
>                 return;
>
> +       netdev_assert_locked_or_invisible(dev);
>         dev->xdp_features =3D val;
>
>         if (dev->reg_state =3D=3D NETREG_REGISTERED)
>                 call_netdevice_notifiers(NETDEV_XDP_FEAT_CHANGE, dev);
>  }
> +EXPORT_SYMBOL_GPL(xdp_set_features_flag_locked);
> +
> +void xdp_set_features_flag(struct net_device *dev, xdp_features_t val)
> +{
> +       netdev_lock(dev);
> +       xdp_set_features_flag_locked(dev, val);
> +       netdev_unlock(dev);
> +}
>  EXPORT_SYMBOL_GPL(xdp_set_features_flag);
>
>  void xdp_features_set_redirect_target(struct net_device *dev, bool suppo=
rt_sg)
> --
> 2.49.0
>

