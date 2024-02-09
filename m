Return-Path: <bpf+bounces-21606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1865084F39B
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38E8288365
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3228200AA;
	Fri,  9 Feb 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOJa1aQA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A71DA44;
	Fri,  9 Feb 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475189; cv=none; b=sSpZQ3dsqmcD8KAwzZNkEj2yCNXNE5BeCkUv3SSEBXvSwEEKyllU9Ja9YscRt+gbwP7Dy0IuHskB2frZvege60kGOgMOkvMMVIGNd+Akeg9DcjIsIV8PYGmuUx6sTyUJg6t//uIGE9geYLy0xSRt4oGqDrTCzJE0Omn+FO96ZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475189; c=relaxed/simple;
	bh=6JSed9WghJtQfys5PKUQxL5lBNUCn4xxXb2Iqm1mn0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2A6kkmgezydPEOmJ5TBzs5cjlOY3g3EZQ9Fjqqxi/KSPJePH2geI3pT4QonmpeWlmItT3Kjx6UmId9M/1d/rXfpZ942eR30JcVTN7zw5LjOXO9LjV17TIh8OxNYbe1Y4+QTEu+IdOVZlB3/fN9eiTTEgCwUQ7V9MZGWehNxXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOJa1aQA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a389ea940f1so89231466b.3;
        Fri, 09 Feb 2024 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707475186; x=1708079986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo4dnUNSo3H3+Ts+jrQPCY8fwThOM1DvpZ/VFX/5iBk=;
        b=YOJa1aQAmMdJfA0wT/0UDwonGW0fHgz66AGGMbmghvi+dEZXf4xUnA1ERhb/vrmCzI
         OXcgauZ/flmUyxoYqzO3VClN3w2lN/hiEHplkT+rJ40r3bOrS7qfw9h8SMT0wNmwzvIJ
         aL+W0oHjcjcx6jrhmBRuCL0V3E+lfYmrlDCBTwOiKGcjovLIvd7F/0G9CQ3+n3Ppn3f9
         97v1AplY+nCgKcXZa5aJukudwN4f6pOw+2J9TBldX+6z35Dsu/gamtCvSCBa7W6XvIRi
         DXKu5zny8Ez8+I/2UVfUHqNQKPm3d05ndxJr7mbYXksDL5LgBZF4+Tsb96Nf+0hWJ0sA
         jbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475186; x=1708079986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lo4dnUNSo3H3+Ts+jrQPCY8fwThOM1DvpZ/VFX/5iBk=;
        b=XbVEHI+DTOlCSRJczSituEo2R350+lqmISqCdlQIb1xJij8CYcm/zFDFsFzDKkfco+
         CkMsiRELeJg9gJ7qQ2otYoPlgPVINtl1SupyklupXs7hnSC58wsy0mnb0DFPrmEx8w4a
         9w0vnN+M3T7trXijYciYxmhOZaUoc6ELBwAMQsBNOWw/a8bZP3ERN7o7gnWN1/NUEG9g
         jbetFQMiTcpjNXtpPzj50nxSwg4Sbp/8krnC7R1PjEzPKuG5B7p5pPmmi69N5e5n8nT1
         8yOpUXY1wsb8HCZvBf73hwTuY8GlZT9NNivv3qFXTnB5zjvXzlJ0lEpOmceH3UXjhb10
         fV9w==
X-Forwarded-Encrypted: i=1; AJvYcCUhoTyZ5sjuJJf6WDEkIWW4ufL/gw+NHsWVBUvBKSIlGrpeYvGbHWAQjMdhnWXMfySlCfWlqKaAI6s1Ul57tRJs0oyNas3zokoGZmbF4aFaUVwMaF/h3Z/lbTHQd+eT/FlnF6bFszq2s9o+wJW7dUNxEp2QhDSVeW/3
X-Gm-Message-State: AOJu0YxCkCBz5FBwZfpa5NCseNtFHYK4fm+5LokCWVstpwMtvA3BU7zz
	v0zDeRkGsMRLRWU2pcVIrCK8ByS1W1QezFXFr86CiuKJh0z9oUmvWT6Mh76LWuFvObGIwpr5Af+
	RGdjWLbBetAwzamTTCjptLkL/vcY=
X-Google-Smtp-Source: AGHT+IFUK5AxhGByklr28zTpKRrQt9q1kxLKqg64jZ/i/mBwJE44NAngtOYMahNnaMPpzwR1AIyeJ8ulHoCfGKfp1bs=
X-Received: by 2002:a17:906:3b0b:b0:a3b:e8b7:9ff0 with SMTP id
 g11-20020a1709063b0b00b00a3be8b79ff0mr960923ejf.67.1707475185671; Fri, 09 Feb
 2024 02:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com> <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
In-Reply-To: <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 9 Feb 2024 18:39:33 +0800
Message-ID: <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer <haw=
k@kernel.org> wrote:
> > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > [...]
> > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buf=
f *xdp)
> > > > > >       }
> > > > > >   }
> > > > > >
> > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *=
virtnet_xdp,
> > > > > > +                                  struct net_device *dev,
> > > > > > +                                  struct virtio_net_hdr_v1_has=
h *hdr_hash)
> > > > > > +{
> > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_value;
> > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->hash_repor=
t;
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > >
> > > > > Would it be possible to store a pointer to hdr_hash in virtnet_xd=
p_buff,
> > > > > with the purpose of delaying extracting this, until and only if X=
DP
> > > > > bpf_prog calls the kfunc?
> > > > >
> > > >
> > > > That seems to be the way v1 works,
> > > > https://lore.kernel.org/all/20240122102256.261374-1-liangchen.linux=
@gmail.com/
> > > > . But it was pointed out that the inline header may be overwritten =
by
> > > > the xdp prog, so the hash is copied out to maintain its integrity.
> > >
> > > Why? isn't XDP supposed to get write access only to the pkt
> > > contents/buffer?
> > >
> >
> > Normally, an XDP program accesses only the packet data. However,
> > there's also an XDP RX Metadata area, referenced by the data_meta
> > pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
> > point somewhere ahead of the data buffer, thereby granting the XDP
> > program access to the virtio header located immediately before the
>
> AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_data before
> xdp->data_hard_start:
>
> https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4210
>
> and virtio net set such field after the virtio_net_hdr:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c#L=
1218
> https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c#L=
1420
>
> I don't see how the virtio hdr could be touched? Possibly even more
> important: if such thing is possible, I think is should be somewhat
> denied (for the same reason an H/W nic should prevent XDP from
> modifying its own buffer descriptor).

Thank you for highlighting this concern. The header layout differs
slightly between small and mergeable mode. Taking 'mergeable mode' as
an example, after calling xdp_prepare_buff the layout of xdp_buff
would be as depicted in the diagram below,

                      buf
                       |
                       v
        +--------------+--------------+-------------+
        | xdp headroom | virtio header| packet      |
        | (256 bytes)  | (20 bytes)   | content     |
        +--------------+--------------+-------------+
        ^                             ^
        |                             |
 data_hard_start                    data
                                  data_meta

If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a little
towards 'data_hard_start', it would point to the inline header, thus
potentially allowing the XDP program to access the inline header.

We will take a closer look on how to prevent the inline header from
being altered, possibly by borrowing some ideas from other
xdp_metadata_ops implementation.


Thanks,
Liang

>
> Cheers,
>
> Paolo
>

