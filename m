Return-Path: <bpf+bounces-76458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA3CB4FBF
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 08:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F65300C2BB
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BE2D130C;
	Thu, 11 Dec 2025 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBq04m3E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Alowt+gc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86D29D29D
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765438099; cv=none; b=WxXNqnM6aTamBnfFCeIV/ruC/eIZRCiMzE8bIASXIKirWAc3aXjVamBFt32+sF3OGC0k7VIgnTspz7sKhORKGhhcIwczE+IASEE2eUIjdLIhtdba6fXFdRJjaZNUNalePnGRmrSmhbz1B9AVoFpwEON8Zb2WxaxozrhdsHo1ifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765438099; c=relaxed/simple;
	bh=3SFKWZlvhRrC7iSGMbPPmXQBtiNRdmj3/GXg76r1ayI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0kzYpxIdm4gGTJGPRQ4i3+GqfE7bVBUBFJY3rDOyDfpxZbNrnAMo+y3umywsf163co2N1bHSp1Ba0XPaokdw6JtQbRedtVBE48Yi5/IutKPipB7jtk3wHD4s1G1CifvqWuOsya+830Ag1q11XjjaWPtu+2dnD9B7wC0pE2WIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBq04m3E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Alowt+gc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765438096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHCIJW7AhVSt+a+Mu9deBkCzw0dY3AbSZpQzZPiSSxo=;
	b=MBq04m3EMZERF4+T4nb1/R85ekBgCYMhbxRXC/0yKPRV0zER5mYgMRvwUM8PnO3aqxiiEw
	0xYcmys18XjgSoi8cfkiDBTx5s6nYG59gYCnVgsxwqWWn1HHe4YaxpHfX3RBNY5s4TCyDk
	1Bi0GX/daTjbqMtwWt6OAGlAEwu5z9I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-yJwOvP_9N2i7Q7TmGAiNmQ-1; Thu, 11 Dec 2025 02:28:15 -0500
X-MC-Unique: yJwOvP_9N2i7Q7TmGAiNmQ-1
X-Mimecast-MFC-AGG-ID: yJwOvP_9N2i7Q7TmGAiNmQ_1765438094
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34a907477b3so1126791a91.2
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 23:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765438094; x=1766042894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHCIJW7AhVSt+a+Mu9deBkCzw0dY3AbSZpQzZPiSSxo=;
        b=Alowt+gcgaTJmOuKjdziKdKMVBNfHUuujSW8edRvd2EU7lQPl76AjTSduzk/WR0vxO
         DpVZQx4cO2khzV1kdkvbNGA0I/md2C4kjlT1/EDT/AleuawEG86l0SByqtTSd7EkM6eA
         ar0GJobfrNRUtI7Hphl/wRUXTdnfsyVC8zt39auDhNvz2l/ttm58+gVEPJAzf7PL8+UT
         6SCaVGM4wC47C1q8LH53Dj40Hp6T9eG1zusZOpArpluRIHl0Ju1/ioO3smadOMSx4j5u
         Cw75sY9usXJ3qq780V5xKJbks76onxlD6bTPfe8SIBibprwCubIc4yLganFnH4dLh7w4
         7f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765438094; x=1766042894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XHCIJW7AhVSt+a+Mu9deBkCzw0dY3AbSZpQzZPiSSxo=;
        b=DpF4rmLPxopFP8wMk+zKsnMKPefWe/2eTODKgH+rgGJHGNHUH5yNQKrbUPnXcU3/6P
         CO2rSuqDFvp7OGOGRAGUz1UJBg3KMXtr21uQyB+zpHO5DzpYo+fHxzF057s+FLiqBTCj
         kvKMJLD5A4CHcaG2e97IjZoRZW9QQJI3+9lXSY1uG/nTl9E5Shw+he+PvTdgV7znxXKa
         eUW/gkhFFUu9Tc6eGLqc13xCwLd7ps0MQE/2/VN22ByjOEUmB72332515ss5ZFBqnfSB
         +912jPfvAmU+TyOCmE6WQ3j6ogaXWRWSLSfrPW8TsbFcUS/p+wXPlB9Fb5jHYqAJGa59
         6/SA==
X-Forwarded-Encrypted: i=1; AJvYcCV0MDBGlJXgrkHJKkfwHprgxn2C71S6RLnYjeCK60oR06y8wHSUaRxyvswtEJTjYcO9tgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+Wkl7dXjucmvAuBUJqnSlvVs1YM1bJKJy9CXtEw32lW5tusX
	zL268tt4Hosj5YoPkAaY6X/FoJMrDB5PQWPN7vd7BLhQHAoe1Nh6eEBSH8X4LES1ifBuSQIZ3VU
	2UsR9YkTNK+ho28zjv1rDJe7aWvRzklKWBQHs/Dodjm908inLVcLRfNsZgM7V9ThSdNj5vhP1qR
	4um639Bvwd7pcCm3fybOyobJAKpoFy
X-Gm-Gg: AY/fxX5o2LBMOdBl7h4xLldsAS36ZfZNMFpK+Sh/ae43h5csC5oUlhkcm5uaf1SETcY
	Z7Zhwz94TcYaFrErBj/9QIvaDvIdnkkqzK6fxDRKZU1bYzai1VdaSDQuovdLWuoCbaWbSjFDyAL
	2sZoHRHDQARHpQPxSy1COzKtL7sVGNHcPm0vLh13zPB3UMKUKkMEiM9abBvdPdG9c=
X-Received: by 2002:a17:90b:1d8e:b0:343:c3d1:8bb1 with SMTP id 98e67ed59e1d1-34a7284b8d7mr4383529a91.28.1765438093878;
        Wed, 10 Dec 2025 23:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELINkGynuwtzVKkcWlVxC8J0Dzt1KgqNSoAz4jGSHqhXx8+ooJmx8RXmQcY2tKZTGXlYUUo662HiiiU1r5OJM=
X-Received: by 2002:a17:90b:1d8e:b0:343:c3d1:8bb1 with SMTP id
 98e67ed59e1d1-34a7284b8d7mr4383506a91.28.1765438093474; Wed, 10 Dec 2025
 23:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
 <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com> <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
 <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com>
In-Reply-To: <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Dec 2025 15:27:59 +0800
X-Gm-Features: AQt7F2rLvC7ySJ95rN-wRh0PT6Sw4J9BPwFDPgo9IQ9hEPNH8-1shZUI4pCKaVk
Message-ID: <CACGkMEv7XpKsfN3soR9GijY-DLqwuOdYp+48ye5jweNpho8vow@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 11:33=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 12/10/25 12:45, Jason Wang wrote:
> > On Tue, Dec 9, 2025 at 11:23=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> On 12/9/25 11:30, Jason Wang wrote:
> >>> On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbui9=
9@gmail.com> wrote:
> >>>> Calling napi_disable() on an already disabled napi can cause the
> >>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refil=
l
> >>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
> >>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill w=
ork.
> >>>> However, in the virtnet_rx_resume_all(), we enable the delayed refil=
l
> >>>> work too early before enabling all the receive queue napis.
> >>>>
> >>>> The deadlock can be reproduced by running
> >>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> >>>> device and inserting a cond_resched() inside the for loop in
> >>>> virtnet_rx_resume_all() to increase the success rate. Because the wo=
rker
> >>>> processing the delayed refilled work runs on the same CPU as
> >>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadloc=
k.
> >>>> In real scenario, the contention on netdev_lock can cause the
> >>>> reschedule.
> >>>>
> >>>> This fixes the deadlock by ensuring all receive queue's napis are
> >>>> enabled before we enable the delayed refill work in
> >>>> virtnet_rx_resume_all() and virtnet_open().
> >>>>
> >>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausin=
g rx")
> >>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
> >>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/re=
sults/400961/3-xdp-py/stderr
> >>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >>>> ---
> >>>>    drivers/net/virtio_net.c | 59 +++++++++++++++++++----------------=
-----
> >>>>    1 file changed, 28 insertions(+), 31 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>> index 8e04adb57f52..f2b1ea65767d 100644
> >>>> --- a/drivers/net/virtio_net.c
> >>>> +++ b/drivers/net/virtio_net.c
> >>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info=
 *vi, struct receive_queue *rq,
> >>>>           return err !=3D -ENOMEM;
> >>>>    }
> >>>>
> >>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> >>>> +{
> >>>> +       bool schedule_refill =3D false;
> >>>> +       int i;
> >>>> +
> >>>> +       enable_delayed_refill(vi);
> >>> This seems to be still racy?
> >>>
> >>> For example, in virtnet_open() we had:
> >>>
> >>> static int virtnet_open(struct net_device *dev)
> >>> {
> >>>           struct virtnet_info *vi =3D netdev_priv(dev);
> >>>           int i, err;
> >>>
> >>>           for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >>>                   err =3D virtnet_enable_queue_pair(vi, i);
> >>>                   if (err < 0)
> >>>                           goto err_enable_qp;
> >>>           }
> >>>
> >>>           virtnet_rx_refill_all(vi);
> >>>
> >>> So NAPI and refill work is enabled in this case, so the refill work
> >>> could be scheduled and run at the same time?
> >> Yes, that's what we expect. We must ensure that refill work is schedul=
ed
> >> only when all NAPIs are enabled. The deadlock happens when refill work
> >> is scheduled but there are still disabled RX NAPIs.
> > Just to make sure we are on the same page, I meant, after refill work
> > is enabled, rq0 is NAPI is enabled, in this case the refill work could
> > be triggered by the rq0's NAPI so we may end up in the refill work
> > that it tries to disable rq1's NAPI while holding the netdev lock.
>
> I don't quite get your point. The current deadlock scenario is this
>
> virtnet_rx_resume_all
> napi_enable(rq0) (the rq1 napi is still disabled)
> enable_refill_work
>
> refill_work
> napi_disable(rq0) -> still okay
> napi_enable(rq0) -> still okay
> napi_disable(rq1)
> -> hold netdev_lock
>      -> stuck inside the while loop in napi_disable_locked
>              while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
>                  usleep_range(20, 200);
>                  val =3D READ_ONCE(n->state);
>              }
>
>
> napi_enable(rq1)
> -> stuck while trying to acquire the netdev_lock
>
> The problem is that we must not call napi_disable() on an already
> disabled NAPI (rq1's NAPI in the example).
>
> In the new virtnet_open
>
> static int virtnet_open(struct net_device *dev)
> {
>           struct virtnet_info *vi =3D netdev_priv(dev);
>           int i, err;
>
>           // Note that at this point, refill work is still disabled, vi->=
refill_enabled =3D=3D false,
>           // so even if virtnet_receive is called, the refill_work will n=
ot be scheduled.
>           for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                   err =3D virtnet_enable_queue_pair(vi, i);
>                   if (err < 0)
>                           goto err_enable_qp;
>           }
>
>           // Here all RX NAPIs are enabled so it's safe to enable refill =
work again
>           virtnet_rx_refill_all(vi);
>

I meant this part:

+static void virtnet_rx_refill_all(struct virtnet_info *vi)
+{
+       bool schedule_refill =3D false;
+       int i;
+
+       enable_delayed_refill(vi);

refill_work could run here.

+       for (i =3D 0; i < vi->curr_queue_pairs; i++)
+               if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+                       schedule_refill =3D true;
+

I think it can be fixed by moving enable_delayed_refill() here.

+       if (schedule_refill)
+               schedule_delayed_work(&vi->refill, 0);
+}

Thanks

>
> Thanks,
> Quang Minh.
>


