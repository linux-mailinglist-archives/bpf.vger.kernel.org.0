Return-Path: <bpf+bounces-35247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602AB93937D
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF719B2152F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2DC16F900;
	Mon, 22 Jul 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V//GGZ91"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FC16DC06;
	Mon, 22 Jul 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721671460; cv=none; b=g6hcSoYkS0mHmRx3kj6OEOdyCWpmBPkEKzBpxQ91XqBUAg4apRmUOjsg/L8wFP7hvErzfJUb74+W3RsrmfYKs9dhhPXRQHxrysxB5SD4IBFUeFxPtLIUKmWv9rSFxPkSDlXwlPDsSmYSNHlVNWpZ/5ZStIzjtqHATwm9MShlTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721671460; c=relaxed/simple;
	bh=gBs5SHmm67OnvAktfjpwCiy9xFFpMESnJqk6fB4T/74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Dj3bS+mowHbaImmxgn5ahakMbgp8cV0Av2z070aJXXCHtiZ2VUSC9AgFpYuyo09dpEqJLhm0QJmjib6WppptotYIMia6iDOUmVPuMOtbHITw2VfDOe7muZlPH+GlbOgKVScBzjcHp44/gmNSi0zXCltSvcrCQBNVtgtPL0R0RlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V//GGZ91; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so39890915e9.2;
        Mon, 22 Jul 2024 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721671458; x=1722276258; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLVIduvSyccDga4xJI9V3U/42Lv/6UsR4iyO6Z8QOb4=;
        b=V//GGZ91kxwRtYyjiiZkEA4t2c+aqShVOlDmlMqhTyixYRcARlQSZO5C7PnndeHgSs
         Oqo+ICHmO9byLPkFbG3zGiqFor38q5HNKRRtE7cYB751H7w8pCWmn7DBPVPertfRN68R
         ZejdCn+sCh2LhuWRtCz1F+5PQ4Bt87FZmNQloAmvj6qkuDhm+WQgwnToexuBijuup/1M
         kk0TLLdW0h06GL06MHLYLBYTYFe5F2Btj/zdvqu8P8Iy39W6l0KOg3FAKIPXxoRWsyJL
         8xgQVL3uuBX079pUvmVTEtFnA5sE4xNQGTRZfNiDnPil5SvuPWxZUc4UQR2gNxm1/Pvq
         +Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721671458; x=1722276258;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLVIduvSyccDga4xJI9V3U/42Lv/6UsR4iyO6Z8QOb4=;
        b=EBx4oBAp2lv/lU0ts8ronEzAjZ9LOIMBz6wPXV9z3eUEXF4Q/Vs/do9NGnr8OMyX5L
         rm2D7VhNZr7Z9bdqzjlrexD79RTIFhAAJb2lGsfq+sBaEo/DCLnM6ZiNHYsn45nzPDuQ
         emtwbxLT3voftgeRXvFhdNDjFLAUDyHIPj7pir8uXWc81AOuwhKHzKDu5ZkoxdN1FKHw
         4EKBzl/TwSreTB1OphupaNseLzTn5sJS89+QnU5NX4TtiaTV397hIk9TXFTXTDbV55pC
         7FTYRs42dQE8Rh+sUUXTqvo548Haav1DajhHQXpYvG/psah6x3Tp/F/v7KR2+ibw1XHi
         UIVA==
X-Forwarded-Encrypted: i=1; AJvYcCVvVOWjdYo2uSpXYFRwGmomGUcKMbRdNvbxgyQzEkTDoSmsuWrzcuL8f2jQ/oqPd6/OM+DwJO12UlPyp5eSXM9eGde33Zh/qEo4igz/0jezlYVUzLuY79/Vn3igL55KnKhvM0L5jls9gHiIxhe0JQZjDcGwbsft3zF1
X-Gm-Message-State: AOJu0Yw2PcKk0cHw1vFalCVnjKdKehv23cULqS8UY5S5bJ1r66tzX45G
	G1YdG44v4Udjc7iieGW+/SheiNxemqDrRToTBSOXeiPz/+KCVLXgr1/hPwRM7awoRLjuyOfD4HV
	jm3SmrQZGVPu7qbj0sFMWsQPQCWk=
X-Google-Smtp-Source: AGHT+IE4vI9A8GBpVSPi+BnMQiSe4a0uGFG/x/jx2/SR+6iulB+qLxDUN2RaS5XLm90zL8I76Ptwz9BU/GV0ix7UadY=
X-Received: by 2002:adf:f303:0:b0:368:3ef7:3929 with SMTP id
 ffacd0b85a97d-369bae4cfdbmr5402428f8f.22.1721671457404; Mon, 22 Jul 2024
 11:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720164621.1983-1-eladwf@gmail.com> <Zp6GGzaJXhBcnGkC@LQ3V64L9R2>
In-Reply-To: <Zp6GGzaJXhBcnGkC@LQ3V64L9R2>
From: Elad Yifee <eladwf@gmail.com>
Date: Mon, 22 Jul 2024 21:04:06 +0300
Message-ID: <CA+SN3soUH9dxAkKD8AB64Ay48T=Dj-QFftMoMLZfVGH+Q1mjzA@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: use prefetch methods
To: Joe Damato <jdamato@fastly.com>, Elad Yifee <eladwf@gmail.com>, daniel@makrotopia.org, 
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 7:17=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Sat, Jul 20, 2024 at 07:46:18PM +0300, Elad Yifee wrote:
> > Utilize kernel prefetch methods for faster cache line access.
> > This change boosts driver performance,
> > allowing the CPU to handle about 5% more packets/sec.
>
> Nit: It'd be great to see before/after numbers and/or an explanation of
> how you measured this in the commit message.
Sure, I'll add iperf3 results in the next version.

> Is there any reason to mix net_prefetch (as you have below) with
> prefetch and prefetchw ?
>
> IMHO: you should consider using net_prefetch and net_prefetchw
> everywhere instead of using both in your code.
You are right, honestly I didn't notice it exists.
I'll replace all prefetchw with net_prefetchw.

> > @@ -2039,7 +2040,7 @@ static int mtk_poll_rx(struct napi_struct *napi, =
int budget,
> >               idx =3D NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
> >               rxd =3D ring->dma + idx * eth->soc->rx.desc_size;
> >               data =3D ring->data[idx];
> > -
> > +             prefetch(rxd);
>
> Maybe net_prefetch instead, as mentioned above?
This is the only case where I think prefetch should be used since it's
only the descriptor.

Thank you for your suggestions

