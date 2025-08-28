Return-Path: <bpf+bounces-66762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B8B3902D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E3A3B1E53
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8F018BC0C;
	Thu, 28 Aug 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEwdA1+O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06D77111;
	Thu, 28 Aug 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341563; cv=none; b=JtvZgQ4WOP//jRfsKSqMEQ2gox4Janb9ME+26b4hNvi/AatEpwRw6Ghhc1IFmYqKxPCa+8SyW6Xmx00znbLqyVCoI1nRXl/JToAb9O8ei7dN00AAa6tx/U9KtCu4tdR5V9/djw40qB4nHGXKwlB5F+nVz11CyUpIymcI94KQEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341563; c=relaxed/simple;
	bh=l7OSUlIJtuqpZkyF0aREuwd9rQAbfy0n8Ats8l33wmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn4JC7E4IxKbfNqrQ6FgGHu5Dko8+TBc3A9Iy0ZZCKfNYL4f3TuMeFHGbQjVMWs6bGp4bRNt2HfBu+1P5a88lG6F0kr29dmEs+bod9v/vBmTPAW4TLhsISyEsF/R5rpADXU00tDFL8O+SVKPOlnQd56wuBDCd2Om/4ccZH0Lgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEwdA1+O; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88432e6ca05so39137339f.3;
        Wed, 27 Aug 2025 17:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341559; x=1756946359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqFTyz5LcENf+/1j2tvtLWmULFIuOikamyuSOXUUCUM=;
        b=QEwdA1+Ov3XvNVHdJ7g9egbwrhrKnV7tLvOUlLpaG97VprZKmrlELQFHFAlBOMjwOY
         LY0KPL/B2fdxiErK91RhGifkHAT6xIjqYG+ga56FfxZ3PiU1v0b28yjcHIJ4U/14Th1E
         ozqyQ9KdWfvZnYYWWHahtxld8oEsjChe4yI8YcGJZMUU0S4J5NwlJnb4cxeftYdpP2a+
         4kX/8qpGy1B8kWolxyxKHKkZZqLe/WzdfLNgDyE4XjxrPgfnzFhTwnd2pSUdbAc6KZt4
         BHsWfcNzXYwcAeDI33vI9wev//4seSFLyP8l1Y7T52MtMcMiUc1cGn+awehZ7xhEEyxl
         yTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341559; x=1756946359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqFTyz5LcENf+/1j2tvtLWmULFIuOikamyuSOXUUCUM=;
        b=tRbQX+Hfb5gx3TefeIpVoGMYr4CEPnORXI+pVhO9ABtidLR1VmleeZ8FumHJHLNWob
         Xwf9I+/I8Kb3CYSJjGw6IclNeZmP+W5G5q29zIqBchm0F9HxHh0MFm1NafbSUOHntD3R
         B6VPTqR/xThKhDLCiduILQRYXTbBHx1q/CtnvVa4DNwoY+3QVsTrocJpIOxnNdrtVBm+
         J1Jl8YvP4njV55kSqzBGOe8uxfyOECay3QbcB70B8Is0BtMDNbgGNe4h6amBxieuCq0o
         qSDgXrq7mj8X72qmBGig7vaVPCuiF2BbuAyuEioqvtdoci4Zc+wz0CEs1YfmMxqHrs56
         ScHw==
X-Forwarded-Encrypted: i=1; AJvYcCVYSC2GLB6jqE0r6vBiFCcEhP+5+mP386Qdhf1Lga87mHE4P+mKKwHRrndVaWThKGXHX6mnlIaG@vger.kernel.org, AJvYcCX/eXGr1hWDAlb6hyZ25n1NGZy5OtUT779iR1jLwLZp4IHhYO04DKfWOMaLoJFxsKI1+4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1fb2x0z+6jqB1K338iOfdZUUfAvdynbodiIJLFXTsVUOfddO
	0cF2bnKfPWhO8Pdu4DubuTbBotJNmMkPwfocwH/CbsjRL1qaQHC8hJzrmCDjFojUO4GeHhF7VUH
	fAY5PcOg60x3K2xTu5XdqNbQHOqdoGoY=
X-Gm-Gg: ASbGncvNUmzwnFmTWRh+XBmONPlvkAMozP1dxXrsqzdJ2DmSKxQ7H7E7iE2LCXYLU7U
	qrDxT/f0u1pkaQAg9O4OOv9IFFzs2Ng2h+Wv4Yz/NT36mcutdBsRUFN9dUbZjlG4+TrpUv39w6B
	xmsiWeVFRle5kWMBmw226CVadDC7MIjc8NnF3GWHnbi47yYY5sC+8Gh+5lFvGZfmPwTyHi/R62P
	Ca27w==
X-Google-Smtp-Source: AGHT+IEJq25QSnvBopl86OOn/sq53FLSG70uTvq2WgRd55z+CaPqj9fTQI+6fXkBtTI05Q4Bf8JGViEW0RRXutkp2WY=
X-Received: by 2002:a92:cda1:0:b0:3f1:6141:8a45 with SMTP id
 e9e14a558f8ab-3f161418c4amr5717285ab.1.1756341558956; Wed, 27 Aug 2025
 17:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-6-kerneljasonxing@gmail.com> <951bc347-0c33-4359-8d15-0e5e054b951c@intel.com>
In-Reply-To: <951bc347-0c33-4359-8d15-0e5e054b951c@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 Aug 2025 08:38:42 +0800
X-Gm-Features: Ac12FXw1Bc-yeekjcx4fijBbkYbUCHu6tXHCWDVebnczdxynAVrOS21xvXqrCxQ
Message-ID: <CAL+tcoCBTS0T-DNRjC0k2pH+qveM6=OHQ98eatp7nG5g1DA=bA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:33=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Mon, 25 Aug 2025 21:53:38 +0800
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Support allocating and building skbs in batch.
>
> [...]
>
> > +     base_len =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom=
));
> > +     if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> > +             base_len +=3D dev->needed_tailroom;
> > +
> > +     if (xs->skb_count >=3D nb_pkts)
> > +             goto build;
> > +
> > +     if (xs->skb) {
> > +             i =3D 1;
> > +             xs->skb_count++;
> > +     }
> > +
> > +     xs->skb_count +=3D kmem_cache_alloc_bulk(net_hotdata.skbuff_cache=
,
> > +                                            gfp_mask, nb_pkts - xs->sk=
b_count,
> > +                                            (void **)&skbs[xs->skb_cou=
nt]);
>
> Have you tried napi_skb_cache_get_bulk()? Depending on the workload, it
> may give better perf numbers.

Sure, my initial try is using this interface. But later I want to see
a standalone cache belonging to xsk. The whole xsk_alloc_batch_skb
function I added is quite similar to napi_skb_cache_get_bulk(), to
some extent.

And if using napi_xxx(), we need a lock to avoid the race between this
context and softirq context on the same core.

Thanks,
Jason

