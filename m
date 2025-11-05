Return-Path: <bpf+bounces-73686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B8DC3750E
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F191A2052C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601328B407;
	Wed,  5 Nov 2025 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moYvwvA2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822CE25785D
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367508; cv=none; b=H+378p2FlY+hdhBZ3t8CLzu6Sv0hoGMUxSwpGfMvm2D7B9h6GA6OqQHqR8fdl99Zb+ddNUfDJPHNdICcyeo0j049r0sNKVS1/elOWbKcmY7SBjfERqSBEbtNv5GazaWoeW7llUkbVLc4JmBpwn392fTnJqey6dGL8LJ6m4Cv164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367508; c=relaxed/simple;
	bh=cSUvPFHauqZYS/CgsZ8XBajx3T1TWYSiO6rHtLaKjfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFS9bnep10r4h0DD+ZNKi3etRxoJwkJuB9d9O5iIqJSXnxCSNiIqabbeshDhcqb4ZWF1peZSM9Yi4vTpVPF+I2JKCc9fL3zHNTuw2awbZLasjBzVL0UeHFtgRbwxC7Em0pTW6ph/uLOd1//eeQbYnwuhSOOqAG7NskK29lIFVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=moYvwvA2; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63bc1aeb427so163191d50.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367505; x=1762972305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlbREYCC7hZZFYU/7VKZMqA+QAfKisdyFnGiY5+x3Ac=;
        b=moYvwvA27zXvENPapH0CaBNoJCOO2eyxO4MW9MSUXnxSYepCGfx5rRQ6FgVuG/lt2X
         45x4G+Ctsj8Hd0Sg2DAqgO2m2eBINFzXrXkUfARBiR+MH1y1hthM4QYAJ+EERt2F+Z0g
         wX/5Ev8R59JN71QtkO808CVEmEcRE+s7rVj237LHFL/lap/bLtD7Rgqgq7H/cNKNYQiR
         rOKj0LOmWWseMg8CnEPFyxf4Q3cGbn1yxP7CEYni0kG0XWZbLLRwzHOxcenHcWPP/ry5
         54ewXiBejpDc5AbWydwntAfQzC8b489rHVa2OhSvIoaJ4jI9xRCOGosICz6iRgRsD7+U
         XY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367505; x=1762972305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlbREYCC7hZZFYU/7VKZMqA+QAfKisdyFnGiY5+x3Ac=;
        b=WnRNIcZFeYh7j/yJ8sYvTg0qL8yGaJEfIja/5nv7AYW0nAhuu/9zwBQCEElPBaCwOD
         fF+Z25vXRXLxwWB3vHdYPXZ/LpC980NE0uqicWfNPAz3CK1Wn57fq2NQBSU7eMsEm2Mf
         vhM+CQqhKrFBlxHWA1tj9QjXtbP2wf9/GQUmwnK3C8ThNTiP/GnsuwQJEQlNQM7XSNHU
         rndcHWWKUvH++VOiZqyHsAUHqld3Lqz3oZx/BnzXuSewIlX5Fa3pft7hy3/XPVeiXi2X
         ImfSsuAVS4Hc9iRpb5hQIBTSVZ05VsGxTbBaeXkQUhzoiM2L1bFSuezaBJhX6MLk1l8o
         5VIA==
X-Forwarded-Encrypted: i=1; AJvYcCXEGUQQQSkST8TXZJLATNTlHUAw8QzonDFNOEvyVjryBkUgGhSJ5xw/digrrktisL+AJZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqNwJdZ9IM0nyaNg9HG3M2bVteszYNOWlMajub4N3pG4G+oRY
	HI8Rz8KA+OnxyZQPJ+gpho3NsqB3A9fT3d6i4+hBnJp7L5AONZG/laNQEron5xDmMbgHp0wPCTB
	dT2CeoGN4Xol4Lm4l2QBkfNxbjAaInmvMXhz7+7Is
X-Gm-Gg: ASbGncvESs+refoOE2hNx41RrID17bE2P3OvIFIFJ81IIsxjGOFqDBuZpLO3JTsz0ZJ
	H8gZ1AegPpu/Z/rvP1pM6puPly39Zt9+7JfJAuxO4aTkp69I/AuQzrKsu9F2jdxgCSQdJCYkF1b
	0R2KWE6rZY2TTN++EbK0TuekARwfMe5TMuQnfAHyeWkD8wWxsfTckaS57Ecme+JvrjNrzMGCJyB
	Lg1puNuD99m+CHE2JgOPbFehigaJgj01KOW1qn9MRkwrXgLlceRsqth8YmePzaWh0gssjQmPqmn
	mwonLKZCS0uXaApsidxlacp4a+v941NrqTJc
X-Google-Smtp-Source: AGHT+IEOY8cyE6iEXUXwkiFxfgFzq5OVSEUXJFxiV5kaSFWjZNeby5wEMszhmBL8q+8wcQrvfgB84R8XK2eZFBODVvM=
X-Received: by 2002:a53:c05a:0:10b0:636:d4ab:a507 with SMTP id
 956f58d0204a3-63fd34ccd13mr3319244d50.16.1762367505139; Wed, 05 Nov 2025
 10:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251022182301.1005777-3-joshwash@google.com>
 <20251023171445.2d470bb3@kernel.org> <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
In-Reply-To: <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
From: Ankit Garg <nktgrg@google.com>
Date: Wed, 5 Nov 2025 10:31:32 -0800
X-Gm-Features: AWmQ_bkub-0DPZQYHW6NWgclx5Hi6PlhiC9qH2yVCOKIyjJd37QVjH-PxzZDmqc
Message-ID: <CAJcM6BE7qg464oLOJZtVEdYjaki422fxvUWFsA_=CjOAJeqZ_g@mail.gmail.com>
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

On Fri, Oct 24, 2025 at 11:17=E2=80=AFAM Ankit Garg <nktgrg@google.com> wro=
te:
>
> On Thu, Oct 23, 2025 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 22 Oct 2025 11:22:24 -0700 Joshua Washington wrote:
> > > +     if (priv->rx_cfg.packet_buffer_size !=3D SZ_2K) {
> > > +             netdev_warn(dev,
> > > +                         "XDP is not supported for Rx buf len %d. Se=
t Rx buf len to %d before using XDP.\n",
> > > +                         priv->rx_cfg.packet_buffer_size, SZ_2K);
> > > +             return -EOPNOTSUPP;
> > > +     }
> >
> > Please plumb extack thru to here. It's inside struct netdev_bpf
> >
>
> Using extack just for this log will make it inconsistent with other
> logs in this method. Would it be okay if I send a fast follow patch to
> use exstack in this method and others?
>
> > >       max_xdp_mtu =3D priv->rx_cfg.packet_buffer_size - sizeof(struct=
 ethhdr);
> > >       if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT)
> > >               max_xdp_mtu -=3D GVE_RX_PAD;
> > > @@ -2050,6 +2057,44 @@ bool gve_header_split_supported(const struct g=
ve_priv *priv)
> > >               priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT && !priv->=
xdp_prog;
> > >  }
> > >
> > > +int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
> > > +                           struct netlink_ext_ack *extack,
> > > +                           struct gve_rx_alloc_rings_cfg *rx_alloc_c=
fg)
> > > +{
> > > +     u32 old_rx_buf_len =3D rx_alloc_cfg->packet_buffer_size;
> > > +
> > > +     if (rx_buf_len =3D=3D old_rx_buf_len)
> > > +             return 0;
> > > +
> > > +     if (!gve_is_dqo(priv)) {
> > > +             NL_SET_ERR_MSG_MOD(extack,
> > > +                                "Modifying Rx buf len is only suppor=
ted with DQO format");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     if (priv->xdp_prog && rx_buf_len !=3D SZ_2K) {
> > > +             NL_SET_ERR_MSG_MOD(extack,
> > > +                                "Rx buf len can only be 2048 when XD=
P is on");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (rx_buf_len > priv->max_rx_buffer_size) {
> >
> > This check looks kinda pointless given the check right below against
> > the exact sizes?
> >
>
> My intent was to code defensively against device accidently advertising
> anything in [2k+1,4k) as max buffer size. I will remove this check.
>

After taking another look, an additional check is still needed to
handle scenario when device doesn't advertise support for 4k buffers.
I reworked this check (and added a comment) in v2 which hopefully
conveys the intent better.


> > > +             NL_SET_ERR_MSG_FMT_MOD(extack,
> > > +                                    "Rx buf len exceeds the max supp=
orted value of %u",
> > > +                                    priv->max_rx_buffer_size);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (rx_buf_len !=3D SZ_2K && rx_buf_len !=3D SZ_4K) {
> > > +             NL_SET_ERR_MSG_MOD(extack,
> > > +                                "Rx buf len can only be 2048 or 4096=
");
> > > +             return -EINVAL;
> > > +     }
> > > +     rx_alloc_cfg->packet_buffer_size =3D rx_buf_len;
> > > +
> > > +     return 0;
> > > +}

