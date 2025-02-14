Return-Path: <bpf+bounces-51620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF7A368A2
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3846417318A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDC21FCCF7;
	Fri, 14 Feb 2025 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zenFJUY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC401FC7F7
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573004; cv=none; b=KIAKQTeReRO6PxfEZiXtDILBPUK220MLebIQklKc0IS4mDMMMFyt4jh2LRbvt2PMUVhRlTB18DXNFtyCM++4KYD2cSxMBuOhKWk6e0NpUuq27c9c+uLckgGVfIVpz48vcCdxMfE7e6Be6G7tKpbX2zeNjwj1CAuoHjBC4loTCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573004; c=relaxed/simple;
	bh=fG4VEG9vUa1eYYGrVKUHwc8QSjhKAXFfO4zv39sxpVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLs/NLigdS3BxEBsPp3wsWjh74i0zNC0LBTyV8HVjklOqlXgVDmr4ILDHkI54eichP6hEmimUMxpTrAAIDafbx1l+O766j04DN39UnpFO6eXirqDL54JmtvYqsEfun0pkODZYfW/B9IfJ7auRFhfzrtrTEvCLCENVNh0EX1SfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zenFJUY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd43aa1558so23914166d6.0
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739573001; x=1740177801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0S7kDMXAD8gZoPUu13HV3B7jZz26znSFfxWBW/aLQ4=;
        b=2zenFJUYgPMbz8pI7ioAxSUXZyiDSkelXq8W2jZmPasG8vfCzP+OkA1Az3kkg7/3qu
         Zso2kj1PgUrDWJJWshxPuvhgS90rk8BueTTC0FyaI/mSRGIVbdnFHLUXrZSDBRLQjKXy
         I6tvx6LwzgmaDperMswSkmYGzOmlvqmicLvpqAJGh9yc4vOevJ2CQDxmXOp5HnDQJ4eg
         eC9D+pPz/SKzKADbrwSDhL3pjyjFBGvz2l5PqQtgEM0Unla1SutIx8Yhr2ORP4O7Cxw9
         UXK8kdGx/zyxwakAH5dHxgWNIT51eSr7HgrGwP7GIFzmvGCLla0Hj6gLMbhwq+Gx2kys
         1VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739573001; x=1740177801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0S7kDMXAD8gZoPUu13HV3B7jZz26znSFfxWBW/aLQ4=;
        b=skXgEACrKWcvwdOxXVhxmJjqQzqEYfM0T1fefwqTmifdCOAEG8B0HAI9RlwSNzIFFv
         1RVEdLc+9i/9LQXsFEzFSdcye0b1mFJS4erlkQTcubZvFnXjofTz7djvTHijmxbY0xUh
         Q0MiBFLSF+ABHA+pEx12CMzEqzxlc3836qu+vugxj4DG0GShtZyprgL/l9WRLYiXLWAT
         w4Rkyew+OmJ5WhP/GteDC5Skgh57Gxft9WlPlpwMI0vhOzVW8u5sPG7K+ccB734LpTlC
         9TRzyEwTjkNyLEw7oAfdQOTbbJgbruGuCtreY+AEgIEFTQboGszpUmjYEwSuiO3aoidM
         V/5w==
X-Forwarded-Encrypted: i=1; AJvYcCXBnH5xb68StFIFZy9t1F+ctFRgPu7Gs8N5r0CKp4uxPbb7KQeft/iyVuHXEEVKE1NrT5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0a+K5s2hlAJP3pzsKj7gy6vrJIKn7CJKOoJswCyPkdUPa6Do5
	cTxP2rSPP+v2uEzaaHaMnRMzOrF2xAxyOdtt/w7kzMDDLn6I8RUbB2YKLmB50tcYmDzs1rOvO8Z
	2OY12QS3wri8Ph4rZrNGYAkIMbZijLd3sune7
X-Gm-Gg: ASbGncu+o0t35WB89tujCGvtEEeYbXWeJchQNVXgpShnr+1J3vOiHCtC+/Q9+inE4ui
	PqZMcoX3q2AsKcp+RQMz7uXLgiPm6wfDIYlcxV0IU6cAQT4muJUvEffHAo13pTYjb/jftwWzzID
	GZJM1Wn/9TCp+lR8I8j0+t4AC0zhM=
X-Google-Smtp-Source: AGHT+IHYqfptmmKo8lT6PBWLeXoXId9NyT+ZtdLFcjFAi7Rl22vhTrLDj37vJjqU8TkMj7zaYOm83pLPCt+oQryKieM=
X-Received: by 2002:a05:6214:5019:b0:6e4:3de6:e67a with SMTP id
 6a1803df08f44-6e66cd1a6a1mr15910146d6.30.1739573001346; Fri, 14 Feb 2025
 14:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214223829.1195855-1-joshwash@google.com>
In-Reply-To: <20250214223829.1195855-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 14 Feb 2025 14:43:10 -0800
X-Gm-Features: AWEUYZki233-dvPVdAXEocTl6XJ7iKCHeu9CVkeYzMPq5AFv9Ux386N4VE9mzTg
Message-ID: <CALuQH+XN5VBc3kMyWCRg8-=01gXWWkYbYEJLvCX==nhqSXxsCA@mail.gmail.com>
Subject: Re: [PATCH] gve: set xdp redirect target only when it is available
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	stable@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Shailend Chand <shailend@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This patch is meant to be destined to the net tree, I forgot to add
the prefix when generating the patch. Please disregard this patch; I
will post a new version soon.

My apologies,
Josh Washington

On Fri, Feb 14, 2025 at 2:38=E2=80=AFPM <joshwash@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> Before this patch the NETDEV_XDP_ACT_NDO_XMIT XDP feature flag is set by
> default as part of driver initialization, and is never cleared. However,
> this flag differs from others in that it is used as an indicator for
> whether the driver is ready to perform the ndo_xdp_xmit operation as
> part of an XDP_REDIRECT. Kernel helpers
> xdp_features_(set|clear)_redirect_target exist to convey this meaning.
>
> This patch ensures that the netdev is only reported as a redirect target
> when XDP queues exist to forward traffic.
>
> Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
> Cc: stable@vger.kernel.org
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h      | 10 ++++++++++
>  drivers/net/ethernet/google/gve/gve_main.c |  6 +++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 8167cc5fb0df..78d2a19593d1 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1116,6 +1116,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct=
 gve_priv *priv)
>         return gve_xdp_tx_queue_id(priv, 0);
>  }
>
> +static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
> +{
> +       switch (priv->queue_format) {
> +       case GVE_GQI_QPL_FORMAT:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  /* gqi napi handler defined in gve_main.c */
>  int gve_napi_poll(struct napi_struct *napi, int budget);
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 533e659b15b3..92237fb0b60c 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1903,6 +1903,8 @@ static void gve_turndown(struct gve_priv *priv)
>         /* Stop tx queues */
>         netif_tx_disable(priv->dev);
>
> +       xdp_features_clear_redirect_target(priv->dev);
> +
>         gve_clear_napi_enabled(priv);
>         gve_clear_report_stats(priv);
>
> @@ -1972,6 +1974,9 @@ static void gve_turnup(struct gve_priv *priv)
>                 napi_schedule(&block->napi);
>         }
>
> +       if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
> +               xdp_features_set_redirect_target(priv->dev, false);
> +
>         gve_set_napi_enabled(priv);
>  }
>
> @@ -2246,7 +2251,6 @@ static void gve_set_netdev_xdp_features(struct gve_=
priv *priv)
>         if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT) {
>                 xdp_features =3D NETDEV_XDP_ACT_BASIC;
>                 xdp_features |=3D NETDEV_XDP_ACT_REDIRECT;
> -               xdp_features |=3D NETDEV_XDP_ACT_NDO_XMIT;
>                 xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
>         } else {
>                 xdp_features =3D 0;
> --
> 2.48.1.601.g30ceb7b040-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

