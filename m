Return-Path: <bpf+bounces-21412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05D84CCBE
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590A41C246FA
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9DA7E58F;
	Wed,  7 Feb 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKsIpxkJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8D7CF0E
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316056; cv=none; b=YmUAxIl7AQxLRgTkpIJWoO8zfeaOFa/fv+MteQd+aBfr/LczbYEuXpHm7E3ABqGugdMMbWrox7q7oTqv13wp2VPQjMJE8fU5NljamT8gm/pD9Fs+ranba2ksgCGhqt/S8MqrVq2qG6inAnr1D9HnTNgKdcT+EwPfA7Ih3FC/dq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316056; c=relaxed/simple;
	bh=yBzdRotDsu2uLYW01rsj5xMm0bJQ0Ta5k0F4nltJjcg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttD33hdFqJJDo1kF2KwRNtewFwEVVvVMKR+Sj5QO6Qas1oGJy8I/mo9JwgZxQdxCjaTv8sqods3nwNU/2ZOs5LbTjxdgo3ZvRG7BoDYSnWOuIKBPXj7p2/tQdOGZ9V5GuVNZGfUQ43BvhWLS1XQFFlvYxaeMy/8mywDPExzgVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKsIpxkJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707316052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kA9x0KZxPyQe30v0cEiEhUCZiJbL0SKf8vP7UqzfcZg=;
	b=GKsIpxkJf0QgsrAu6Ef4VSFvAqDePBNBCa5PscAln/htSNilLfeWd0OV2JneDYmQZR9JPe
	VPfOVGcZwhmXaxJe7vr7Orl3tf+NyaopFMu1J9aVZwmxP8BhWRlOZC2ax+7L0sLmJX2RFz
	0U0nfKWcupSl4MyQn1cN8Az8ScUlFfQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-hXekrz-NOxSEZKxIrFQoXA-1; Wed, 07 Feb 2024 09:27:31 -0500
X-MC-Unique: hXekrz-NOxSEZKxIrFQoXA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ef88ff82aso1674455e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 06:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316050; x=1707920850;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA9x0KZxPyQe30v0cEiEhUCZiJbL0SKf8vP7UqzfcZg=;
        b=nwOF41VzYsaRUM/vwQfcq/D96X6rSfmyKqDIXbncYkBSISDt6ykag5B/kLqn15hkGf
         hsKeV/L1NlzZ+DSlmRdvZ5zjrmTLnKcJ/ffdNG2gCq6mLoo7QFBYsD+lf1OL0jdPcEzA
         kPnFBOaKti4+y9e6O/V91rwRPBrR39Z7eHjlzrfWt6bo2ptI+sjEF+rKgpD8c4K3mtlP
         APIHZn3vcfgk/A2NomlglrPbYHLZN30eoa5pNlTSsHExkbi/nrHi7fjimDVtevK8c0TE
         C17xF6gnksuNor+WTMAx7ugX5KgXm1RQEEJu5ocKW8U8zdI2VNPiNX87QeQZwd5O2rCQ
         mqYA==
X-Forwarded-Encrypted: i=1; AJvYcCUc1ZreNbvXNziURKYXBoKrVfwjTLzKsGyhaDZLg22RMlCgeeAiPE/tY8Q4PWyJxpDX/K6Aa99AsMOwwmdTteXgUvFb
X-Gm-Message-State: AOJu0YzirkaXWUQFZP3YUQP3NWbLAP1k69fCWp1qbG0/rOicYdSwyF24
	944un9a2KWzPFfJ2HARSU5wGCvh4e7otEcNMYcTePJiA8+/Em00tb5W1oENoxeaTKz7rs/5XuWJ
	dyvRatUKbgk+W8omeo6q/9F8bozFEUODZtCQq+7RWKl4WP487jg==
X-Received: by 2002:a05:600c:3541:b0:40f:d0a2:e9e4 with SMTP id i1-20020a05600c354100b0040fd0a2e9e4mr4579768wmq.4.1707316050043;
        Wed, 07 Feb 2024 06:27:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8vz/tQqhJQ3xxhGqPmok+16YGsmMwGFMn64mfbMvepHWXvFPiam8wq1DErqH73rKrwGmdWA==
X-Received: by 2002:a05:600c:3541:b0:40f:d0a2:e9e4 with SMTP id i1-20020a05600c354100b0040fd0a2e9e4mr4579758wmq.4.1707316049719;
        Wed, 07 Feb 2024 06:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfiEGA+aMhrIBWHRf0TImQkULnMz2pVfrgxv3BK7Hu8da41SNEnMsGliTdnW4XKwLDWG8inGQLPCYAWjhwnpLxzu2swkv4tp60/nAaObaVSAdj/8wv3hTBs880qWVFB95O3p/dPp4L3YoQSWsh8jsP3ojWE1GsHHJb5ZGN4QRxvjqFbibFW1yopG7yZwMLQ78sXyTrgT98gssDX8IhP0wiSLgUcSYclVLlNotMg3//QDrbYWCD4DtyILo3Yyn/VimS3Qtbe99tmrtc0mxT9P88jq4z50u7ByM8NcUuFjyGe1P4D7KqvQ/36BRaC+Hwmbgn00aGGa3kWABqJbNdwlfVygSZgtaTI7qCTaozhkqeIVBqzWkCvxBARvVFwEeJJMQQTmkWZ9E4XO1nTr+m654iWQxmO+z1qR2J+g3x3dCAbNYFxJGzVRW8TfLTEg3Ha9oPWNCvFAeXZnV3OK/SfkZUJcT9Oa84z+WwlvbAz9gJ
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b004101bdae3a0sm1092591wmr.38.2024.02.07.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:27:29 -0800 (PST)
Message-ID: <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
From: Paolo Abeni <pabeni@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
 john.fastabend@gmail.com, daniel@iogearbox.net,  ast@kernel.org
Date: Wed, 07 Feb 2024 15:27:27 +0100
In-Reply-To: <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
	 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
	 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
	 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
	 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer <hawk@=
kernel.org> wrote:
> > > > On 02/02/2024 13.11, Liang Chen wrote:
> > [...]
> > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff =
*xdp)
> > > > >       }
> > > > >   }
> > > > >=20
> > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *vi=
rtnet_xdp,
> > > > > +                                  struct net_device *dev,
> > > > > +                                  struct virtio_net_hdr_v1_hash =
*hdr_hash)
> > > > > +{
> > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_value;
> > > > > +             virtnet_xdp->hash_report =3D hdr_hash->hash_report;
> > > > > +     }
> > > > > +}
> > > > > +
> > > >=20
> > > > Would it be possible to store a pointer to hdr_hash in virtnet_xdp_=
buff,
> > > > with the purpose of delaying extracting this, until and only if XDP
> > > > bpf_prog calls the kfunc?
> > > >=20
> > >=20
> > > That seems to be the way v1 works,
> > > https://lore.kernel.org/all/20240122102256.261374-1-liangchen.linux@g=
mail.com/
> > > . But it was pointed out that the inline header may be overwritten by
> > > the xdp prog, so the hash is copied out to maintain its integrity.
> >=20
> > Why? isn't XDP supposed to get write access only to the pkt
> > contents/buffer?
> >=20
>=20
> Normally, an XDP program accesses only the packet data. However,
> there's also an XDP RX Metadata area, referenced by the data_meta
> pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
> point somewhere ahead of the data buffer, thereby granting the XDP
> program access to the virtio header located immediately before the

AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_data before
xdp->data_hard_start:

https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4210

and virtio net set such field after the virtio_net_hdr:

https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c#L12=
18
https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c#L14=
20

I don't see how the virtio hdr could be touched? Possibly even more
important: if such thing is possible, I think is should be somewhat
denied (for the same reason an H/W nic should prevent XDP from
modifying its own buffer descriptor).

Cheers,

Paolo


