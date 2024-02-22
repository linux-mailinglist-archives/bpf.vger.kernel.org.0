Return-Path: <bpf+bounces-22523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4A860343
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A7B282F60
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6F6AFB8;
	Thu, 22 Feb 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ci9Tw2o/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792F6AF8A
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631611; cv=none; b=ITltjR7+7Y9yWD9lQ4ICt+HJhLDHd5T0M/hI3MMwXDt25OSIa5yuEJKff9vBA7ATMBt6SXBw1CQfQtz3rKZXdzIjp7GOsiQ52WW3Na+6qImlyQKjRH7SJS0UEiOuh+uAAB/+uBbi86xhMW1QqRwAjWRakaD7EWwLN0FH1JF3Q/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631611; c=relaxed/simple;
	bh=v7Lvw1at5ToQVVbfg922jXBVHEWjc2/wWHZvRYkA7rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuLok98NcFDq+3ELscUpO+qvnN07IGeObMug4BibtgKac0e+YqB4Q8hGzDjMqmdN/39pGiV/gJYIDPmnF9ZE8WFsSI/9v9U/zM710p1gi23HsCGvyxwu5BtPgCKixGZ3TY1eO6SdN8f/C864ukTjTOYNv9DFp0hApMR48CesR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ci9Tw2o/; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4cb26623dc1so40738e0c.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708631608; x=1709236408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kozEGOJC/7xLH6aBy/2SvD0c9oKy8kT6TL2kXc3Klg=;
        b=ci9Tw2o/9nlr0pOl1j90xlI84177T1unyzEQNEBsNbwIZxRYI/+5WnVzDQpPZOK9Jb
         abU46ojoM/TPpDZ1P/VNK3gD3Fd/9YtZ+W3S3jo2eIopdJGN1vFUJ0vl7UiiW3XOF0kv
         6/yWvFJuUrtqJDAEjw+8T1dYO5GKIiZJc47Y+vBouikueL2Rj/RJuGeLoDgWjAxobxB1
         tq/VYTKplCSHztRZ30IsBgPpwL5xLIqreLnbRPTSHHMh7x9XinjowLtNkKafFPJCeluO
         /jR8zX1y8Kp4VMeCwxaoF+OX/nzrkK1q2szRsYHplIsE0dRU3ZAeamqSstItDVCR6i8k
         QgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631608; x=1709236408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kozEGOJC/7xLH6aBy/2SvD0c9oKy8kT6TL2kXc3Klg=;
        b=qzRXegPJ24toYuKomgXoy3EpfmUTVhMjdMQLCrFPmsmU1kn0YNIo4RQlSSomkZmYn2
         c2gKPYaHqZ2dleIuJL6cQ9Mp8wZuZ4cZDnnpAh7l1tW/vWcocfsFQNdr+4uTSLSNS/tc
         2/ZjSprORdR+aYrrmwxjn5MNKfXRFvpsO9sZtHg3Mbo4yEB0f87V0Z6GhMzqfR6M7Jjw
         jZN7IJRLyzXiM+CJYeLMj3GBlpXTAdmu6IRSb0f4ox9idvLabTsycVY+QL2UvOp5JVH7
         J0z6EFALVr7GpR0JoaAQBARqOwhukcvOXOv3ug/l9XGd0jPo5Jzw8jf5+M4Zzhpy8B/3
         YfGw==
X-Forwarded-Encrypted: i=1; AJvYcCUlDEux6AL+kc/cvzZUy2QyqZUN6tUFiLA+9dxLiqC1u1FadVaeJg+92vr5r/gRaKn2bQlb2MXOLH8UqwTfbHtSfzDy
X-Gm-Message-State: AOJu0Yx9W5+aY69QCqMQX8xizyQesDw8inzuChiHedoA/L6p/M0mZ8xk
	LooXlvdXziiK78Gl2wOkeGW9HlsTykm9qYyFB91Ojv1bQJsnZKgpm3etjuh41V8iV5WdAVVbLZ7
	yOQnCzqDFjtdP/Y8O1JH94x8JHMAMSFZVhDyL
X-Google-Smtp-Source: AGHT+IHd1fOHDrami1l/FXC8S9WReyWr/r16zMqJ++U2IMGyqdRRRkXy54yvZV6zhDuC7vRCY24PZbj2//w/q+ZxR8M=
X-Received: by 2002:a1f:e782:0:b0:4cd:1430:7834 with SMTP id
 e124-20020a1fe782000000b004cd14307834mr42201vkh.7.1708631608338; Thu, 22 Feb
 2024 11:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de>
In-Reply-To: <20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Feb 2024 11:53:14 -0800
Message-ID: <CAKH8qBsCrYuT+18CsydQ5TeauRzu0Hdz7mZQ2c0W7er0KrJnkg@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: Complete meta data only when enabled
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Song Yoong Siang <yoong.siang.song@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:45=E2=80=AFAM Kurt Kanzenbach <kurt@linutronix.de=
> wrote:
>
> Currently using XDP/ZC sockets on stmmac results in a kernel crash:
>
> |[  255.822584] Unable to handle kernel NULL pointer dereference at virtu=
al address 0000000000000000
> |[...]
> |[  255.822764] Call trace:
> |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>
> The program counter indicates xsk_tx_metadata_complete(). However, this
> function shouldn't be called unless metadata is actually enabled.
>
> Tested on imx93 without XDP, with XDP and with XDP/ZC.
>
> Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Link: https://lore.kernel.org/netdev/87r0h7wg8u.fsf@kurt.kurt.home/

Acked-by: Stanislav Fomichev <sdf@google.com>

LGTM, thanks!

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index e80d77bd9f1f..8b77c0952071 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2672,7 +2672,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv=
, int budget, u32 queue,
>                         }
>                         if (skb) {
>                                 stmmac_get_tx_hwtstamp(priv, p, skb);
> -                       } else {
> +                       } else if (tx_q->xsk_pool &&
> +                                  xp_tx_metadata_enabled(tx_q->xsk_pool)=
) {
>                                 struct stmmac_xsk_tx_complete tx_compl =
=3D {
>                                         .priv =3D priv,
>                                         .desc =3D p,
>
> ---
> base-commit: 603ead96582d85903baec2d55f021b8dac5c25d2
> change-id: 20240222-stmmac_xdp-585ebf1680b3
>
> Best regards,
> --
> Kurt Kanzenbach <kurt@linutronix.de>
>

