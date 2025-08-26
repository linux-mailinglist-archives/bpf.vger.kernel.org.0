Return-Path: <bpf+bounces-66486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B93B35034
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92884480726
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCA2264C0;
	Tue, 26 Aug 2025 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axJwq+L9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B06223301;
	Tue, 26 Aug 2025 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168088; cv=none; b=UdSHp7VIUxmoKAG0FUTOnkJDjG9YStOFXMUlJ6cKWsM1qtREVJeayhEj0Dg1ZHW2ZrvEEDlK/HJ9UiGFA2vJrE3HF3bYOB/3g4WWvWEqNAU77MxgJkMZw4iKaVIndMTZtUpxOVKNOmLEaKmEA1xWvG3pyq08GuQnPLwOMwkg0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168088; c=relaxed/simple;
	bh=aPKKd2yX/n+60cjFrmH3svXhGY077PKADt/p6WqA01M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV2ki8G+CPKrketiznMGHE6E8bP2PK/Z2sc5I/h4wOUdLqNQPogA/52M+DCq/CygCyzrA9dojdwBKrmNh8vtglI2Qbf7n0dRUrkN8XeQI7hUHVZOcJ1VcjkmQI9Vqd74LOPDUc+zswNm6cxYsAEmr408dAaU1ENel4Iniaaq69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axJwq+L9; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ea8b3a6426so34377425ab.2;
        Mon, 25 Aug 2025 17:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756168085; x=1756772885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLQYxf+Oy84yvuf+Wx+b3h9z4hTnFln8vwgEHLwU4kc=;
        b=axJwq+L9VKPA44FUa/AMTuOQjkgXUvEyuU321MzQTkQx1HckeG5CmAYe0rUpsWe8S4
         ynosySGker/pMDqCERy7st/lRh7TnWCgGwvT0p6eBF5GpzDQoXnsPfcV0PqpfaHwzkS2
         HIO9kcHhEUiLW4vQJlCCVjnvRlv7egE3okAPrQHK6EmMEkPKFXtCdWCazmcAgFo0bRRO
         1r0ci2K31bU9cn9IB05+KiZ/zmwLEsNH7P9+M1GwbglPqnl33nYF5o0L+EACmukJs2eD
         wUXpmr26pnJ4/3IgSfriD4NcOUsJZfleRbYKTigkDiq0o21t4gKPC29Pp/3kfSZ0SAyq
         M6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168085; x=1756772885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLQYxf+Oy84yvuf+Wx+b3h9z4hTnFln8vwgEHLwU4kc=;
        b=I87oS9NU+LnyWQ/I8UGRM7kDGRn/7Yu0dOmXnQ9KmHWFEo2vc/JTURSG0Nca1RBwN5
         pZFP1oBOg2sobIkn39wHTSC1qfpnSvt3CbnAOxCU7+6Mhhy74ZnOH1bBe+6x4jUrxYYs
         uNARQC2YXWTK3IlSKR3rpUxCgj9ifx9Z8ld70d/I9e2q/0h4J/v8tARgWKJjQgwJSZzt
         vHcC7eCodZ4+gNU5ypezB9CiZzS11uVPcBulUkREl+VZxrZPaAnZCogDnV4NSpa5BeAj
         Vzf+4K54roge3wDjwNhXVolY+PQDeTHlYu7cvZtoNoJoXTD8MoHadqknfC5e7x+aPXzh
         qbLA==
X-Forwarded-Encrypted: i=1; AJvYcCU/oqAvN/A4ky+sdCeNzMxfnFw5bQYtZuDrvrDZtrGjWKN6uxTaByxAmBhMwP2wQMMAHmgRrmnw@vger.kernel.org, AJvYcCVMtPwKdPi/eceJYUR1sWY9QFgh2Dg6ZgIcFJqycD4TCUo3TVr4fC89nCdmbUmoT8H5YLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLUZYWHczIrPiKl4hOhgC80vw1rOGtqZ6wH80KVskGD/b85gy
	ctbUHR8YFhnm+yqxH9eKo6a5OzIXhlQ6cPQQQSz4Ke1msAjKQfQYmxRzgg3zwLIxivkCmpE0TKx
	nejspC43Ll8eXNeDK9whUEjOYaxzTqI4=
X-Gm-Gg: ASbGncte75sAtO4K65qwkovyc7d59e9WGqdvYsjmbYHAPd0Jqvmqj+Dt90ymdE4rNw9
	REsMTq5m4xU2EKR7/iMSC1eBRd2xm8f7ajhfoeW1NFbDNsx9FyisvDRBRIkAfbZd7fDtVlZg10q
	q/vC4idI3YeE8LWOW5BS3Jk+eb8nDjw++Bd+w4Og/1OdqYL0fTAfuv2i0LNyvJH5SwJ0mezg5z8
	tmCTjtXpKQwo+WLOw==
X-Google-Smtp-Source: AGHT+IFpeOdINyRL21CcfuLJKxkvs8jYlgQqvido+nbZTjVVKEVqkZFXkBjAHsb85RRNgd/Jjeaa4Icc6jte/N7IwCM=
X-Received: by 2002:a05:6e02:17cc:b0:3e5:8249:e973 with SMTP id
 e9e14a558f8ab-3e921a601e6mr201004605ab.16.1756168085558; Mon, 25 Aug 2025
 17:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-7-kerneljasonxing@gmail.com> <aKyev6DadDuL3Xlo@mini-arch>
In-Reply-To: <aKyev6DadDuL3Xlo@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 08:27:29 +0800
X-Gm-Features: Ac12FXzQcX3jozaiAWGF4xgDDf2KQyQ64UtpcLyRWTJF18KMMehSDe58hl3CA8A
Message-ID: <CAL+tcoBv3+uTx3A9=7kBnCzTgsDXUjtg7s9UJTpmxXneX3qigQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/9] xsk: add direct xmit in batch function
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:34=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 08/25, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add batch xmit logic.
> >
> > Only grabbing the lock and disable bottom half once and sent all
> > the aggregated packets in one loop.
> >
> > Since previous patch puts descriptors in xs->skb_cache in a reversed
> > order, this patch sends each skb out from start to end when 'start' is
> > not smaller than 'end'.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/linux/netdevice.h |  3 +++
> >  net/core/dev.c            | 19 +++++++++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 5e5de4b0a433..8e2688e3f2e4 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3352,6 +3352,9 @@ u16 dev_pick_tx_zero(struct net_device *dev, stru=
ct sk_buff *skb,
> >
> >  int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
> >  int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > +int xsk_direct_xmit_batch(struct sk_buff **skbs, struct net_device *de=
v,
> > +                       struct netdev_queue *txq, int *cur,
> > +                       int start, int end);
> >
> >  static inline int dev_queue_xmit(struct sk_buff *skb)
> >  {
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 68dc47d7e700..a5a6b9a199e9 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4742,6 +4742,25 @@ int __dev_queue_xmit(struct sk_buff *skb, struct=
 net_device *sb_dev)
> >  }
> >  EXPORT_SYMBOL(__dev_queue_xmit);
> >
> > +int xsk_direct_xmit_batch(struct sk_buff **skbs, struct net_device *de=
v,
> > +                       struct netdev_queue *txq, int *cur,
> > +                       int start, int end)
> > +{
> > +     int ret =3D NETDEV_TX_BUSY;
> > +
> > +     local_bh_disable();
> > +     HARD_TX_LOCK(dev, txq, smp_processor_id());
> > +     for (*cur =3D start; *cur >=3D end; (*cur)--) {
>
> skbs support chaining (via list member), any reason not to use that for
> batching purposes?

Good point, let me dig into it :)

Thanks,
Jason

