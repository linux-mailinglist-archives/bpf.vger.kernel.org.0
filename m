Return-Path: <bpf+bounces-72141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D34C07AF3
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 179274EB953
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C1261B64;
	Fri, 24 Oct 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1kkGTUn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A7C2E0
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329839; cv=none; b=VFbk7JHNHyg9YWbK00qCdvdZJHagEMu67xrtJ1vp3nwRqbHp8v/USqpsTZA+OUPoiKblwvgAE9dB1+vVrwDKVdIT1YI2x3Bw8X48k27fDnkyCf5iiQYO92xmTDe2K2+eQUKSZivuw/zI/Zl8sYlZbpy6yfCXotkLvwO7Yc4UBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329839; c=relaxed/simple;
	bh=DrTetYwXYnChgeufrcDQ2X9huG25jnVcdcsflx4+eh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfPKZM1pon1qpVERE8LF5dM/rgelkpwApY6rwRMNQkr/+FYNjQcipJG2QlDyf1zPiRNB7bqxD8S3j4D3SpbJRtq75TsKe/kpKCMCcvxLjwAI+ox/FSJPlgJ1jvQwcTBTVWgcBffs547WNYG5mfdRJhuXFaHFGnDUW4sbNSQdcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1kkGTUn; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63b710f276fso2412986d50.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761329837; x=1761934637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h/ElMh0No0vgq96kFlbqzJt3eEKJ2285EnfEz82Ydg=;
        b=J1kkGTUnTXpQ74o8T0Q1lGWtOP0oUF1WJhYxYZrSnxuKYXpWE03zauZ3w+BK4lCUPU
         L7XoURzZ3JH2qYsUZTIxhZg2n7gbFMQLKibqpLOUNiGM11nEB0I2ijM3dPD/azWlEkJd
         w5HhQsiQ+yoE6xGdjFWGoLRo7nnEHvatmBN0gxF8IMYgxitM6FYieKCQdBfsjX/S26y4
         FXh/EykkV1ZyhCeH8CGpUi7nlfVknEivViteRhR/gSHgVFvjVUMoD+LeiRQEFr2dPoZt
         LFCUqMs5+1xKgSxgjuVUi/3JKBVRFQuVFsCTPZR5AWFQ0ksC9YCyI3WnXTNBga3meGbA
         Oxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329837; x=1761934637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2h/ElMh0No0vgq96kFlbqzJt3eEKJ2285EnfEz82Ydg=;
        b=l+JVR3r7T/hoSOHxwu5OYJR4XlYTecDmFcZ6EqHcskMagh3/ZemLjFq3Lti/67ay01
         P6TKXrsE7qvreWG4Gt5nYxXBBgEjDatSJ4d2RFl4/6Pf6YFMjmcFXODnzN1Dc4NL5yH3
         v5C0wirSwJBiDPxMOGtUDYtk9eXMPioVDLoO9/0JCxi4AE2g+K6Uh+5rFzdqg0PRUkx6
         bPnUykAq6+/N09fT+HLiMZ6MdJldgbOipMvc+G0mgR3hqeOCUtYrrl0k9b+dpDQAJb3H
         eRQ7t7LC7rbksMpaY3VnAXxD6q/R9HC+aeKdsdtRFlx63DZ+ElaNLuOy/Wcpvz9+SsHg
         8oig==
X-Forwarded-Encrypted: i=1; AJvYcCUUfIpUXf/mdpoltd1AO0yJDD1GZbdd3MG9ki/7LSJSrKgjQlgEUbFDX7NEAyUQRFDx1Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPjy6O6LIdgMUaOt2F3gpQNbcPx+5wwT5UhmhooRfUcjjDlCu
	1Pkz86xJ9jMIw3YSn2mLf0xupaTSIYsUs7o5ga9JAYTQLslbI0x5zkTsFOYlUcVPKOJCUaKwozC
	Sj3qqfCeeHydR3ErDYtFpWEtPlzjBI8wylRAIbOUZ
X-Gm-Gg: ASbGnct4yM6FmEp+f+4yvwEPuQ9+BS+HEbC1ZRH/TQWix8LtEiwul9LxM2xxDpOMdOl
	tJZSKnUltW0bMhKBpY+YKNmPO6OY/Mb5HG9W1f1awZAyIvzNcemK6r2GDhqKFfEznXmrA6Fs1om
	BR5BjrXFQl7fyL+iT/BCVQ5dkHr0+BspKMrVsOlrfbH4b2XrQzuzOT6UaJsRKZxUCromzqaAcnl
	SH58i+IywiPV+YwXR/uy2mC+GR7m8qPPOF+/oFsdSidxB59C0N1n9qBT19MsL8OzRrxxfiEvXFc
	OKlnl3iBfkXA/HW5hWAXO6VcpM4c3z+JP/Mf
X-Google-Smtp-Source: AGHT+IH7fLaxmQPiHVCyIFuVlkCG7QU1A/wthZwwqQkRRKGlnH5+qz2v1xZpkL3rChyG1ByYzAe4TaJtZZ5aJ7l0xXQ=
X-Received: by 2002:a05:690e:1243:b0:63e:2a71:83b9 with SMTP id
 956f58d0204a3-63e2a7189f5mr17754554d50.65.1761329836370; Fri, 24 Oct 2025
 11:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251022182301.1005777-3-joshwash@google.com>
 <20251023171445.2d470bb3@kernel.org>
In-Reply-To: <20251023171445.2d470bb3@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Fri, 24 Oct 2025 11:17:04 -0700
X-Gm-Features: AWmQ_bkOcEz5vk4of_aFjLMcVnCbAUnvZuNnSpX91lCMUqEeQToL2-tc3L6UKxI
Message-ID: <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 22 Oct 2025 11:22:24 -0700 Joshua Washington wrote:
> > +     if (priv->rx_cfg.packet_buffer_size !=3D SZ_2K) {
> > +             netdev_warn(dev,
> > +                         "XDP is not supported for Rx buf len %d. Set =
Rx buf len to %d before using XDP.\n",
> > +                         priv->rx_cfg.packet_buffer_size, SZ_2K);
> > +             return -EOPNOTSUPP;
> > +     }
>
> Please plumb extack thru to here. It's inside struct netdev_bpf
>

Using extack just for this log will make it inconsistent with other
logs in this method. Would it be okay if I send a fast follow patch to
use exstack in this method and others?

> >       max_xdp_mtu =3D priv->rx_cfg.packet_buffer_size - sizeof(struct e=
thhdr);
> >       if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT)
> >               max_xdp_mtu -=3D GVE_RX_PAD;
> > @@ -2050,6 +2057,44 @@ bool gve_header_split_supported(const struct gve=
_priv *priv)
> >               priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT && !priv->xd=
p_prog;
> >  }
> >
> > +int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
> > +                           struct netlink_ext_ack *extack,
> > +                           struct gve_rx_alloc_rings_cfg *rx_alloc_cfg=
)
> > +{
> > +     u32 old_rx_buf_len =3D rx_alloc_cfg->packet_buffer_size;
> > +
> > +     if (rx_buf_len =3D=3D old_rx_buf_len)
> > +             return 0;
> > +
> > +     if (!gve_is_dqo(priv)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Modifying Rx buf len is only supporte=
d with DQO format");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (priv->xdp_prog && rx_buf_len !=3D SZ_2K) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Rx buf len can only be 2048 when XDP =
is on");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (rx_buf_len > priv->max_rx_buffer_size) {
>
> This check looks kinda pointless given the check right below against
> the exact sizes?
>

My intent was to code defensively against device accidently advertising
anything in [2k+1,4k) as max buffer size. I will remove this check.

> > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > +                                    "Rx buf len exceeds the max suppor=
ted value of %u",
> > +                                    priv->max_rx_buffer_size);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (rx_buf_len !=3D SZ_2K && rx_buf_len !=3D SZ_4K) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Rx buf len can only be 2048 or 4096")=
;
> > +             return -EINVAL;
> > +     }
> > +     rx_alloc_cfg->packet_buffer_size =3D rx_buf_len;
> > +
> > +     return 0;
> > +}

