Return-Path: <bpf+bounces-26491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D28A0818
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 08:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94EF1C210DE
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 06:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCE13CA86;
	Thu, 11 Apr 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUiMJ6bK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA213CA97;
	Thu, 11 Apr 2024 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815788; cv=none; b=M4W8ar+1c/+zWgQGGEIAO+xd+eKC9j1auRcvsBKVMjmKmKxMAzaSJM711AOQ6MNmEXF1ee568q2bbYbT5zYSlW3GSo7cxiDZNQg85E7KuICja4EbeBQX5h7/+36B0CYOEdeKpNHkAaGcXCPx01hNt7qwJZFbJG9Unx+TKReJ0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815788; c=relaxed/simple;
	bh=FWUSveo+dWM3iC0sOk86XMUR7ID1oa3HzyOa8dgDTnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZ9pfGPPQTW7zAk61CXNBfYokJpDY1PgWVM65D/6x59VkDonGtrHFyql/gjp1Hrm98MZKwWiAD9P6rE+nO2gtzfT8hR5cDnO8+Taohx1RF/sq4Q19wzA8lJdUn+BZpJvT6BwBRQra+ZCDzd+uHT6Qsr4hbZexHbkS3gAQO3lQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUiMJ6bK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so5611198a12.1;
        Wed, 10 Apr 2024 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712815784; x=1713420584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+DUMnyo8N1x2pBygEtNB5/w8bPSQJje4iUoQiVIQIc=;
        b=IUiMJ6bK4IGDfS5T2TZstLjlT20WIdeM/ZSI6oWhl/RK6XEx98ixtZpsgxtrn75O6O
         /6xS3ACgRLUPlMYDGOoD+rm1BMTzwE8RgsqzYLvDkH8rorJ+1bByjLZcrjdyhLbxiRYQ
         iPFx99IIdBxbdxW5fu/Z+AG9iFMn6466ByRdJeryunK13HfPHANyEG03eiOePaM1USfU
         z4pUjfkT6ttyjOn7blKGC0RLfcr8lCZPo/BY7+1jGMc27wrafC4x5T2qeBT/MEWGeZ6a
         txgYwFAVA7QehUBq/bIMViugmb7TGwUYv24RM/9OiKTnS4eEyF2oWhMccQ6zwY+kKaCG
         3hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712815784; x=1713420584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+DUMnyo8N1x2pBygEtNB5/w8bPSQJje4iUoQiVIQIc=;
        b=itPBW0VR/rGZHHJqk67mnXib41D/wKKr92DxNcUtdlsSj+8Isiz0pfN1ZALa1iHZgv
         5p4C8lWIWjmXJ6Hrly177tnvwhB8TmT01R5+ifIxaaWrRxNpqI3ajgsfpvHKC27VQVVQ
         RBNfFWe+l27bHcr5rO4psfI97WotV+81sgJCnKvbmb9wY4yCOYjYg6lAoh4Nkbqsx5WL
         0hm67XAgk6QU/XE+DFsPjk+8nd0xeMp2qZqqUeHSJmLgExH51w3KVUd9ME+Eh4QQJxyD
         vnX72DpCYuxSvLy60U04x62TOnxzFgArVcgZIKrzZchvuaVlYFb1qrMIBi2qp28yTLLo
         rLMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+OgAnNG8Akt8KKxcGjFz8HtwSv8/9/4efQKb5wgMshxe48BAaLWG9SesQNkjSvtw1xB0TF04e336/3xqUHjLC2Ac0kRy5dh+MAr5nXRYRES5Y0SMlh5MOmM4MS1B+UtwDVcJKhS2dYE/pY+0xXHngmMrHJ4D//Fz0
X-Gm-Message-State: AOJu0Yx5iaUoq4uqZhrqA8NkoPnXlJR0rQII6vk4S5bFK61wo7fqiL1U
	PiHK+9NMEJxCK3bOo6wci6QrbAN1RLX9GR8HRPUNl2lgJ0pHIDBGUhUlzcrfrWY60TkABfB0Pkt
	u8CIknb/WzFbXY5NZp2kqDdsOiwU=
X-Google-Smtp-Source: AGHT+IERwUOwQ3bqZkyjVdXCkKDRzx5fYRfZZCSUonMIrU4kIrsGJubGfZU+BFWNFVEVyN1N6linnjI+qB7qn9oDyOg=
X-Received: by 2002:a50:cc86:0:b0:56d:f075:72f6 with SMTP id
 q6-20020a50cc86000000b0056df07572f6mr2402155edi.40.1712815784003; Wed, 10 Apr
 2024 23:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
 <1708652254.1517398-1-xuanzhuo@linux.alibaba.com> <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
 <65dcf7a775437_20e0a2087f@john.notmuch> <CAKhg4t+dzRPjyRXAifS_TCGPv3SfMMm1CF3pCs18OR+o9v+S_Q@mail.gmail.com>
 <CAKhg4tLO7vG5jEYZ3xnzm=xKDHO0SNgDw=JT-j7gb5bjiQOqsw@mail.gmail.com> <CACGkMEsfW-j=W8fdTofUsF2a9rRujCs8TH6wkFvZkpLc68ZEEg@mail.gmail.com>
In-Reply-To: <CACGkMEsfW-j=W8fdTofUsF2a9rRujCs8TH6wkFvZkpLc68ZEEg@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 11 Apr 2024 14:09:30 +0800
Message-ID: <CAKhg4tJZ5FePt+UfcEvDoYtKCUVAX=vo_XUJkF4bzYBhiKmjgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: Jason Wang <jasowang@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 2:41=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Apr 1, 2024 at 11:38=E2=80=AFAM Liang Chen <liangchen.linux@gmail=
.com> wrote:
> >
> > On Thu, Feb 29, 2024 at 4:37=E2=80=AFPM Liang Chen <liangchen.linux@gma=
il.com> wrote:
> > >
> > > On Tue, Feb 27, 2024 at 4:42=E2=80=AFAM John Fastabend <john.fastaben=
d@gmail.com> wrote:
> > > >
> > > > Jason Wang wrote:
> > > > > On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.=
com> wrote:
> > > > > > > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > > > > > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > > > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pab=
eni@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dang=
aard Brouer <hawk@kernel.org> wrote:
> > > > > > > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > > > > > > [...]
> > > > > > > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frag=
s(struct xdp_buff *xdp)
> > > > > > > > > > > > > >       }
> > > > > > > > > > > > > >   }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct vi=
rtnet_xdp_buff *virtnet_xdp,
> > > > > > > > > > > > > > +                                  struct net_d=
evice *dev,
> > > > > > > > > > > > > > +                                  struct virti=
o_net_hdr_v1_hash *hdr_hash)
> > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_h=
ash->hash_value;
> > > > > > > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_=
hash->hash_report;
> > > > > > > > > > > > > > +     }
> > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > +
> > > > > > > > > > > > >
> > > > > > > > > > > > > Would it be possible to store a pointer to hdr_ha=
sh in virtnet_xdp_buff,
> > > > > > > > > > > > > with the purpose of delaying extracting this, unt=
il and only if XDP
> > > > > > > > > > > > > bpf_prog calls the kfunc?
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > That seems to be the way v1 works,
> > > > > > > > > > > > https://lore.kernel.org/all/20240122102256.261374-1=
-liangchen.linux@gmail.com/
> > > > > > > > > > > > . But it was pointed out that the inline header may=
 be overwritten by
> > > > > > > > > > > > the xdp prog, so the hash is copied out to maintain=
 its integrity.
> > > > > > > > > > >
> > > > > > > > > > > Why? isn't XDP supposed to get write access only to t=
he pkt
> > > > > > > > > > > contents/buffer?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Normally, an XDP program accesses only the packet data.=
 However,
> > > > > > > > > > there's also an XDP RX Metadata area, referenced by the=
 data_meta
> > > > > > > > > > pointer. This pointer can be adjusted with bpf_xdp_adju=
st_meta to
> > > > > > > > > > point somewhere ahead of the data buffer, thereby grant=
ing the XDP
> > > > > > > > > > program access to the virtio header located immediately=
 before the
> > > > > > > > >
> > > > > > > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the me=
ta_data before
> > > > > > > > > xdp->data_hard_start:
> > > > > > > > >
> > > > > > > > > https://elixir.bootlin.com/linux/latest/source/net/core/f=
ilter.c#L4210
> > > > > > > > >
> > > > > > > > > and virtio net set such field after the virtio_net_hdr:
> > > > > > > > >
> > > > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/ne=
t/virtio_net.c#L1218
> > > > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/ne=
t/virtio_net.c#L1420
> > > > > > > > >
> > > > > > > > > I don't see how the virtio hdr could be touched? Possibly=
 even more
> > > > > > > > > important: if such thing is possible, I think is should b=
e somewhat
> > > > > > > > > denied (for the same reason an H/W nic should prevent XDP=
 from
> > > > > > > > > modifying its own buffer descriptor).
> > > > > > > >
> > > > > > > > Thank you for highlighting this concern. The header layout =
differs
> > > > > > > > slightly between small and mergeable mode. Taking 'mergeabl=
e mode' as
> > > > > > > > an example, after calling xdp_prepare_buff the layout of xd=
p_buff
> > > > > > > > would be as depicted in the diagram below,
> > > > > > > >
> > > > > > > >                       buf
> > > > > > > >                        |
> > > > > > > >                        v
> > > > > > > >         +--------------+--------------+-------------+
> > > > > > > >         | xdp headroom | virtio header| packet      |
> > > > > > > >         | (256 bytes)  | (20 bytes)   | content     |
> > > > > > > >         +--------------+--------------+-------------+
> > > > > > > >         ^                             ^
> > > > > > > >         |                             |
> > > > > > > >  data_hard_start                    data
> > > > > > > >                                   data_meta
> > > > > > > >
> > > > > > > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointe=
r a little
> > > > > > > > towards 'data_hard_start', it would point to the inline hea=
der, thus
> > > > > > > > potentially allowing the XDP program to access the inline h=
eader.
> > > >
> > > > Fairly late to the thread sorry. Given above layout does it make se=
nse to
> > > > just delay extraction to the kfunc as suggested above? Sure the XDP=
 program
> > > > could smash the entry in virtio header, but this is already the cas=
e for
> > > > anything else there. A program writing over the virtio header is li=
kely
> > > > buggy anyways. Worse that might happen is bad rss values and mappin=
gs?
> > >
> > > Thank you for raising the concern. I am not quite sure if the XDP
> > > program is considered buggy, as it is agnostic to the layout of the
> > > inline header.
> > > Let's say an XDP program calls bpf_xdp_adjust_meta to adjust data_met=
a
> > > to point to the inline header and overwrites it without even knowing
> > > of its existence. Later, when the XDP program invokes the kfunc to
> > > retrieve the hash, incorrect data would be returned. In this case, th=
e
> > > XDP program seems to be doing everything legally but ends up with the
> > > wrong hash data.
> > >
> > > Thanks,
> > > Liang
> > >
> >
> > I haven=E2=80=99t received any feedback yet, so I=E2=80=99m under the i=
mpression that
> > the XDP program is still considered buggy in the scenario mentioned
> > above, and the overall behavior is as designed from XDP perspective.
> > Looking up the intel igc driver, it also does not bother with this
> > particular aspect.
>
> So let's post a new version with all the detailed explanations as above a=
nd see?

Sure. Thanks!
>
> >
> > Given this context, we don't need to be concerned about the hash value
> > being overwritten. So if there aren't any objections, I plan to remove
> > the preservation of the hash value in the next iteration.
> >
> > Thanks,
> > Liang
>
> Thanks
>
> >
> > > >
> > > > I like seeing more use cases for the hints though.
> > > >
> > > > Thanks!
> > > > John
> >
>

