Return-Path: <bpf+bounces-22739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F595868206
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 21:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98D11F22F12
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B94130E58;
	Mon, 26 Feb 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzHkKzZk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D691DFCD;
	Mon, 26 Feb 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980141; cv=none; b=BXCH6+R4WA3qpm6zWfxqEdX8LjMEZyDjv1MpJ2PsuiYUKR1+bWx3dOAZ5hlhcqio+d1b83bwxY+MI3JvvanegmevorMzo8btyGgnTmdw8lAt7mI8E7oE/Qls+gy8A+AMNPsoz7yXsXzPsU3j0rtoyLuLpxlh32jOjKDN3dGnOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980141; c=relaxed/simple;
	bh=OWpEILxNCGKi9UijO32jbCo3J5K197DN5nUkWLCXD3w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TnusNcdsIk2nVqiPcNQwtkx8V1hT0gptijh8AWUgfAQD617TNP//wLytE/uFqT6mJAzHb4MZZ/SRK8sU5u8Qsx7auZjS6KWwAF6n5cd3hIQwKO0dVdxO/xY8HHEZA+5BhRg5wbeMDdfjwIQ+Wvr+AmvMdhzYnTbinm6uJv8QE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzHkKzZk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc75972f25so28940275ad.1;
        Mon, 26 Feb 2024 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708980138; x=1709584938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/sZv9YSQN5VoeMFHC9Ppfxe4Q4sN12GRL5yh7nIDA=;
        b=BzHkKzZkgrvNUX3Kz7bIAuNb1WbnTRwnxGhpZ0Y5d5KVFiz30CSyTJbLKSMWbvEFER
         u4muabf7BuKeky77wqYn8ujy01lH9pHPCyK8grSZEXFtJCJj/HJfvpgp15Di+pIn6Oks
         ZeGIYggh/eqtVhdXfttXQzyRKDUnl3FO1Yzj+sI3FjyvzDlUB8c+tiYSpy2aKooleLSn
         0HKqGpJnV46vwLPMblzjeOYepxaMiX0/5CQrk3CWVRAKWDjIqtETMfcRiC+Bnuu0AT2j
         PF6GZRFVa8ETnpdM8IW+3N1ohbEW6WHHBHlxS4H5At/yJJzjyaFoqWgFJ/m8IUEbhG6E
         QEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708980138; x=1709584938;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8/sZv9YSQN5VoeMFHC9Ppfxe4Q4sN12GRL5yh7nIDA=;
        b=MBtdAzeT5tOcPEYZcuO/XywLhTxLGQhVt9uxVhCdFwyr88ooFgAP0vIVfETfxThp8N
         SkZ1VhhxeicXaIbs7c/7hdSAyba4L3FC7gketb2DajTYukAs483O7pX1T70dvCzeXf4Y
         QDh6ljGJybvjpfev14681/hZjVGoDczST5hbaH3ek8eI3qCIuBKGCQ/bv1nQrXAl/Ce7
         zFHgozNiRbmoi2Nc/nI39Mov4SrHvLXrITjuejpo6a6ebvVzQ6UCrRwF2NGllHg2b1ng
         ZG6m1YbQJGsBDxJtbS2N+XpUgrlF9abx4Opem5PczZS36e6iGDn9pHIDc34sE0StK5JN
         CYvg==
X-Forwarded-Encrypted: i=1; AJvYcCVeZ9L2pOVTq66PjkId8v+0EEMkhiMZkeqvrAmjurg31RuPVxhjvEkAxfsoemcjUnMwMfDa6k+yPVRheZqz7sokNUTKHhsYjD/2wfMuEcJa9AIx92llq305vV5rWD4nUPGco/a1hlhD+1mm03ULdXJuOJfV943EaeXn
X-Gm-Message-State: AOJu0Yy1cIUCfHibYDTBfuRC3hf7cklQkDec/PTeqn3ApaqgU4itg41/
	kbyxpnBnDeNwnc5WmdtI8MirPsQLUq4cIFD+9dO5a12c12lDd6VM
X-Google-Smtp-Source: AGHT+IGwekaX4Ei1fFfoNjzsX11nAcGMnXREGSlHn4sg62b/PqcMNxEWgMrzf2y7rtNSewGJei8qQg==
X-Received: by 2002:a17:902:b906:b0:1dc:3294:f09b with SMTP id bf6-20020a170902b90600b001dc3294f09bmr7490733plb.26.1708980137547;
        Mon, 26 Feb 2024 12:42:17 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id mh13-20020a17090309cd00b001dc9893b03bsm100695plb.272.2024.02.26.12.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 12:42:16 -0800 (PST)
Date: Mon, 26 Feb 2024 12:42:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 mst@redhat.com, 
 hengqi@linux.alibaba.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 john.fastabend@gmail.com, 
 daniel@iogearbox.net, 
 ast@kernel.org, 
 Liang Chen <liangchen.linux@gmail.com>
Message-ID: <65dcf7a775437_20e0a2087f@john.notmuch>
In-Reply-To: <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
 <1708652254.1517398-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> >
> > On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.com> w=
rote:
> > > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redha=
t.com> wrote:
> > > > >
> > > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard B=
rouer <hawk@kernel.org> wrote:
> > > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > > [...]
> > > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(stru=
ct xdp_buff *xdp)
> > > > > > > > > >       }
> > > > > > > > > >   }
> > > > > > > > > >
> > > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_=
xdp_buff *virtnet_xdp,
> > > > > > > > > > +                                  struct net_device =
*dev,
> > > > > > > > > > +                                  struct virtio_net_=
hdr_v1_hash *hdr_hash)
> > > > > > > > > > +{
> > > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->h=
ash_value;
> > > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->=
hash_report;
> > > > > > > > > > +     }
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > Would it be possible to store a pointer to hdr_hash in =
virtnet_xdp_buff,
> > > > > > > > > with the purpose of delaying extracting this, until and=
 only if XDP
> > > > > > > > > bpf_prog calls the kfunc?
> > > > > > > > >
> > > > > > > >
> > > > > > > > That seems to be the way v1 works,
> > > > > > > > https://lore.kernel.org/all/20240122102256.261374-1-liang=
chen.linux@gmail.com/
> > > > > > > > . But it was pointed out that the inline header may be ov=
erwritten by
> > > > > > > > the xdp prog, so the hash is copied out to maintain its i=
ntegrity.
> > > > > > >
> > > > > > > Why? isn't XDP supposed to get write access only to the pkt=

> > > > > > > contents/buffer?
> > > > > > >
> > > > > >
> > > > > > Normally, an XDP program accesses only the packet data. Howev=
er,
> > > > > > there's also an XDP RX Metadata area, referenced by the data_=
meta
> > > > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_met=
a to
> > > > > > point somewhere ahead of the data buffer, thereby granting th=
e XDP
> > > > > > program access to the virtio header located immediately befor=
e the
> > > > >
> > > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_dat=
a before
> > > > > xdp->data_hard_start:
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/net/core/filter.=
c#L4210
> > > > >
> > > > > and virtio net set such field after the virtio_net_hdr:
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virt=
io_net.c#L1218
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virt=
io_net.c#L1420
> > > > >
> > > > > I don't see how the virtio hdr could be touched? Possibly even =
more
> > > > > important: if such thing is possible, I think is should be some=
what
> > > > > denied (for the same reason an H/W nic should prevent XDP from
> > > > > modifying its own buffer descriptor).
> > > >
> > > > Thank you for highlighting this concern. The header layout differ=
s
> > > > slightly between small and mergeable mode. Taking 'mergeable mode=
' as
> > > > an example, after calling xdp_prepare_buff the layout of xdp_buff=

> > > > would be as depicted in the diagram below,
> > > >
> > > >                       buf
> > > >                        |
> > > >                        v
> > > >         +--------------+--------------+-------------+
> > > >         | xdp headroom | virtio header| packet      |
> > > >         | (256 bytes)  | (20 bytes)   | content     |
> > > >         +--------------+--------------+-------------+
> > > >         ^                             ^
> > > >         |                             |
> > > >  data_hard_start                    data
> > > >                                   data_meta
> > > >
> > > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a li=
ttle
> > > > towards 'data_hard_start', it would point to the inline header, t=
hus
> > > > potentially allowing the XDP program to access the inline header.=


Fairly late to the thread sorry. Given above layout does it make sense to=

just delay extraction to the kfunc as suggested above? Sure the XDP progr=
am
could smash the entry in virtio header, but this is already the case for
anything else there. A program writing over the virtio header is likely
buggy anyways. Worse that might happen is bad rss values and mappings?

I like seeing more use cases for the hints though.

Thanks!
John=

