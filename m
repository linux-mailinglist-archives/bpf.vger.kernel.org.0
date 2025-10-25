Return-Path: <bpf+bounces-72186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB86C08E6E
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 11:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31C673500E5
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE482E040E;
	Sat, 25 Oct 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/SX9Tzg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638C2DF138
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761384430; cv=none; b=Xt5j6AyjsFBmZ5HBPXHW3BDi42inqJDKtG+kvCzQsXvd1h99l9xSTs0jnp3f5udO0OoL2f5KnJ2W10J5TpnfLW/0mQOkelpRdBoT+bT+BKXTsKK6x653gpRcDB9yHay5ACh1uOBb7474b4GXLvVdLXzDN69THT5U98kwd1tLa2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761384430; c=relaxed/simple;
	bh=+yhvxANQQYMZd+THRWHrQvK32ymSHEL7AFquatZ8/s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDKQSwTsiyjhuaROV57gETLfPiWtfhfb59aF0EJGM8MHi5NfqzC7NA7smOawhSMaAK31KjbLYM46hu5fy0t1lAyKKX+CwRlKhYgfgZbZyswdeWVivCOWnXRwTzFY/PI1si/a2ZMZ8OM7FB0bzJJh5AViyOLYe7J871aJDicS+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/SX9Tzg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so117650039f.2
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761384428; x=1761989228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG1gV01eQTrH5+0JToPnmHZQ7nQS9WMCwhx85si3Z0Y=;
        b=j/SX9Tzg2rg/LWrwfSV9DaQ0wrcQaPzByk1Z5LAJ2JBYT8Y4Q5Vbf/sFvi8jKv6WLI
         2MPug4zI2nY0eTwvreaiROfc4kD1fOFctt5gV+M4arzc47CZyDQB86rRExhFovwPeJqA
         6gy3LjcDluCuiTv4h7JPlxJljqmHj7VhxFXAO7zs6iPpIne5taw4vnERdt/GEI44UTLq
         3Ws2U5XkYPZpu51nQer2nu/j7tjxuxpPaZgchXyrMvAy6AZAk9+9ng4uEu3QMeT0RN1Y
         J9L+EJPgAo744czdpFz6aMxg3P4JMaL7f8dbg14nnOcpglwSYE/z/CxOQed2X0Hb4fFJ
         AYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761384428; x=1761989228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG1gV01eQTrH5+0JToPnmHZQ7nQS9WMCwhx85si3Z0Y=;
        b=B1va+CtBfrpsV6+RlxkzcofN3t8OJjfMkNhNW+Y8dPHDt8LrMn/4XSCPNjNXs1f9ct
         0yJUD/469idbOD9XcknlxfUm6Wxx9OQ3Gzxbz0icd0+O0Xsr3zc5V6thi8/liLHWrIjZ
         HGkkzKkizSf4ECtsmWAbHDEVL7h7+yGsivYVnOepsl6PlJ6iCZ0UwEetdSjE/GbbNM+6
         VnJVPJxoI7Gp0g4HEycuCRpAhFgSejYBC8TZHANnQqE9TkdAZ6r+ukVA38XRlX3VTQmz
         fDX/rAv5W6gh/vZDE9eAhufC0npvrCQCxDTCXnuSZjOw6pUzyEzA6yxTuXApFYweSTAL
         TyfA==
X-Forwarded-Encrypted: i=1; AJvYcCUtZUxeNcYKpXfzxyqFQv3E/xLuQk3ckX7HgzNJGcamZWi3IKx6l7PbKjBzf01EIxFFAds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfnI3jvdI4TXJ/r5Sz3kFsj4CPIm486kGU7IYxQxvS+2vRF+c
	nzuSHJYv/guJAnvkHX9AVqneukzM0d/a3OZ9ueKbVqdJb6MpdEF2qVLDy+wnEKnuHCEVfFJOTPY
	XzIBeJIxYTUX8S7ksVM3hPdEkyYq4efY=
X-Gm-Gg: ASbGncs4cfLfaGbTruYyCYqIxBBakqEGBFQBwd7b4m6Me3/grtvL+YMweHYH9bjBh9Y
	r4TIND4p36kJtPuJnXPq6a3ByLESIg/88oaTWT2V43DHC6eUoNh0QjF4CS0TnPskQitgfOC7exo
	lXNs0MyInkQN1t8Uu2ofLuRe2SK5gvYeRd0XGovVvLdeEeGK4mnbjKURf/Vsb6Z4RHpZ+vRmCTZ
	10Urq32iNKUlFsJyauqGCBlHVhZGDW0rO1WfA9iRwJWBghP9CFyQrn+5Ak=
X-Google-Smtp-Source: AGHT+IEetEMwamsAlW0y061WquijFhU4ai/j0rDYzriqZ5aMsmOlxzol7OSUEDJ2dBjghU1CIUuB9xbIuq0/M2whFUQ=
X-Received: by 2002:a05:6e02:1aae:b0:430:9fde:33d5 with SMTP id
 e9e14a558f8ab-430c525f0c7mr473570665ab.11.1761384428322; Sat, 25 Oct 2025
 02:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-4-kerneljasonxing@gmail.com> <aPuANsZ6_xj8YY3D@horms.kernel.org>
In-Reply-To: <aPuANsZ6_xj8YY3D@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Oct 2025 17:26:32 +0800
X-Gm-Features: AWmQ_bmoZIWxxMzBpS54VdnI5d80uf7cF5jM16h0qCwFZyNtTl4EHvFk3JzIgj8
Message-ID: <CAL+tcoBQfRJ=O5F3ii4LxhxZVZm3YT1pafM63DUdzOdwXdimjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:33=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 21, 2025 at 09:12:03PM +0800, Jason Xing wrote:
>
> ...
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>
> ...
>
> > @@ -615,6 +617,105 @@ static void *kmalloc_reserve(unsigned int *size, =
gfp_t flags, int node,
> >       return obj;
> >  }
> >
> > +int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs=
, int *err)
> > +{
> > +     struct xsk_batch *batch =3D &xs->batch;
> > +     struct xdp_desc *descs =3D batch->desc_cache;
> > +     struct sk_buff **skbs =3D batch->skb_cache;
> > +     gfp_t gfp_mask =3D xs->sk.sk_allocation;
> > +     struct net_device *dev =3D xs->dev;
> > +     int node =3D NUMA_NO_NODE;
> > +     struct sk_buff *skb;
> > +     u32 i =3D 0, j =3D 0;
> > +     bool pfmemalloc;
> > +     u32 base_len;
> > +     u8 *data;
> > +
> > +     base_len =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom=
));
> > +     if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> > +             base_len +=3D dev->needed_tailroom;
> > +
> > +     if (batch->skb_count >=3D nb_pkts)
> > +             goto build;
> > +
> > +     if (xs->skb) {
> > +             i =3D 1;
> > +             batch->skb_count++;
> > +     }
> > +
> > +     batch->skb_count +=3D kmem_cache_alloc_bulk(net_hotdata.skbuff_ca=
che,
> > +                                               gfp_mask, nb_pkts - bat=
ch->skb_count,
> > +                                               (void **)&skbs[batch->s=
kb_count]);
> > +     if (batch->skb_count < nb_pkts)
> > +             nb_pkts =3D batch->skb_count;
> > +
> > +build:
> > +     for (i =3D 0, j =3D 0; j < nb_descs; j++) {
> > +             if (!xs->skb) {
> > +                     u32 size =3D base_len + descs[j].len;
> > +
> > +                     /* In case we don't have enough allocated skbs */
> > +                     if (i >=3D nb_pkts) {
> > +                             *err =3D -EAGAIN;
> > +                             break;
> > +                     }
> > +
> > +                     if (sk_wmem_alloc_get(&xs->sk) > READ_ONCE(xs->sk=
.sk_sndbuf)) {
> > +                             *err =3D -EAGAIN;
> > +                             break;
> > +                     }
> > +
> > +                     skb =3D skbs[batch->skb_count - 1 - i];
> > +
> > +                     prefetchw(skb);
> > +                     /* We do our best to align skb_shared_info on a s=
eparate cache
> > +                      * line. It usually works because kmalloc(X > SMP=
_CACHE_BYTES) gives
> > +                      * aligned memory blocks, unless SLUB/SLAB debug =
is enabled.
> > +                      * Both skb->head and skb_shared_info are cache l=
ine aligned.
> > +                      */
> > +                     data =3D kmalloc_reserve(&size, gfp_mask, node, &=
pfmemalloc);
> > +                     if (unlikely(!data)) {
> > +                             *err =3D -ENOBUFS;
> > +                             break;
> > +                     }
> > +                     /* kmalloc_size_roundup() might give us more room=
 than requested.
> > +                      * Put skb_shared_info exactly at the end of allo=
cated zone,
> > +                      * to allow max possible filling before reallocat=
ion.
> > +                      */
> > +                     prefetchw(data + SKB_WITH_OVERHEAD(size));
> > +
> > +                     memset(skb, 0, offsetof(struct sk_buff, tail));
> > +                     __build_skb_around(skb, data, size);
> > +                     skb->pfmemalloc =3D pfmemalloc;
> > +                     skb_set_owner_w(skb, &xs->sk);
> > +             } else if (unlikely(i =3D=3D 0)) {
> > +                     /* We have a skb in cache that is left last time =
*/
> > +                     kmem_cache_free(net_hotdata.skbuff_cache,
> > +                                     skbs[batch->skb_count - 1]);
> > +                     skbs[batch->skb_count - 1] =3D xs->skb;
> > +             }
> > +
> > +             skb =3D xsk_build_skb(xs, skb, &descs[j]);
>
> Hi Jason,
>
> Perhaps it cannot occur, but if we reach this line
> without the if (!xs->skb) condition having been met for
> any iteration of there loop this code sits inside,
> then skb will be uninitialised here.
>
> Also, assuming the above doesn't occur, and perhaps this
> next case is intentional, but if the same condition is
> not met for any iteration of the loop, then skb will have
> its value from a prior iteration.

Thank you. You spotted one big mistake I've made. I will handle this in V4.

>
> Flagged by Smatch.

Cool, I noticed that this tool you have used for a long time has found
various issues!

Thanks,
Jason

