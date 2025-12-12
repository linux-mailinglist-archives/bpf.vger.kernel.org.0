Return-Path: <bpf+bounces-76514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E8CB80DD
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 07:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188A730505B1
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0A2882B7;
	Fri, 12 Dec 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj0CtG2n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmrgoqSX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C6223708
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522143; cv=none; b=tBlkbMMM3nRkz09gIMtMC79R6OeAeoTc9aqIbz/cwFPpITW3eWx0K40UJrXTmaJpcG9XLpRyIxvJI2wIFGDZ630dlOPSF4bqk+ghMkNnI9oF9iF+6KRMwtloOBajkJv8164HfKuI7fj0WcGlV6UcDPQXNJ3B99GucedlpsI1EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522143; c=relaxed/simple;
	bh=yMMJzrx/CLeDl8CnB68WU8xwAqbKwNNDoi3GRfb5jRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF1ddHt+Hfw9Z6E5mExAcme20bqoaGnLmFVQjT2alVrvk7xmHTbcYlGrbgrDvB9eXh6q2cvu6RleHw5MyQF+oHeNG9LdtbL2m3F8R8Szu4XTLv/iIijE+A2OOX+oPfxMe6RJMOxCZCvso8SmzPJ5pp6O4ySY12tPeVjAhGcezDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hj0CtG2n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmrgoqSX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765522141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sUk3BDjilnvGHq4HGNbSRfLzgBvHyDLLs4qoxsjBjI=;
	b=hj0CtG2nNV3HTNM5CjbsUE26NyqTyYs9iG7Nn4JvbFoLm3hm1hyCraYOYcM8sv6uBLc/WM
	tY4sUt/KRYzqTuKtowUGC6OY3sPhJhaAdc6UBFPv2p7qWoXtTOwr3CeOyRROQrkR+AjWyD
	RaoTyaXB2v3ZYWimusS9JiKYqXykiLs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-U93y_KRYN92g7aD2DZd6mg-1; Fri, 12 Dec 2025 01:48:57 -0500
X-MC-Unique: U93y_KRYN92g7aD2DZd6mg-1
X-Mimecast-MFC-AGG-ID: U93y_KRYN92g7aD2DZd6mg_1765522136
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343e262230eso1114747a91.2
        for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 22:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765522136; x=1766126936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sUk3BDjilnvGHq4HGNbSRfLzgBvHyDLLs4qoxsjBjI=;
        b=BmrgoqSXJry9TYCDKH5HLhM6ZT8RC5Ui6HKe04OMo/3cfGr+4m/GbvS+qSV3iRa5Fn
         JktQPZnUuiQOYn/4OdXI1DJh2KAZecu47JFp3AznPluHafVXEQ3C5fJNmqpcAISBykVf
         IYN3jOoRdejhkfCual7RGQD2VqDgMu4WZ2NHyz9dyuf09SvQgLf2anONtJTrRrbG82U9
         UHZplv3xjb06xAlIpLT60RTXu6wMc6WYdKFLjz63rquQTAeWFbshZh4+ps2/AcAL00XO
         5Q6+6uUQEzg8ByUFupCJbXU30Q68XBbgmJ82werU1xRy3yebnueXNoTpuEW69+swPlEE
         1Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765522136; x=1766126936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0sUk3BDjilnvGHq4HGNbSRfLzgBvHyDLLs4qoxsjBjI=;
        b=R2AFIbTM/aFtVQzYz3k4yjSKMZIT12gWQz0ZBXWXHD4Gl9NJXq/Aa0GnKf5dKCILnH
         lcmRjkjRVtwtZa0JMTxqx4TYNtlnvw3p2yFxadihPTJlT1P9jJZy5yi7L59boXNz9h4c
         u0l0Rhgfo17lHVWhDkaPMnDTbvLVUKemMvDBkyzuif+FA3ftwR1Grfe43kkVTwoeuUfz
         cbKFkuZmosfMibeAqOhltRXbZvmPdG4ip9l5p4LNvuP9xZLYti/8/ioh1i/IvDt2Sarl
         hllNxwNUG9AgcmaQBz+8tpBCcn4/PYdyZ5hX7id1LMDMvWsPp6rkpM9aLvtwuAISgd+g
         YAUA==
X-Forwarded-Encrypted: i=1; AJvYcCW4XqrvLMLoNaw2QaShqHimap8S3c/TPQMT6fQBlOvtby9CO7doQQnF0KhjGrd8qJB7F1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ13oDTFlrYloYn135S0e5ty1je0oNZqOClHJDp9WiX+wS3L9d
	Zz6U1EaZ/1c2Gst+Jm4eztPcRCtg2SmrTJLK/5NtLq9fw2Mf+ApUZfwH4yW06+dR0juf3JiMfjl
	bs33QlLv+sEz2t87XGMGhdHCdO5WBBUG8DRjJg6UkJSYPLHboWEu8ut4yd/N5JvpH2zYyLBcDb4
	nXMReEepz+FKZc2Oi2P8qxl+K2ziVV
X-Gm-Gg: AY/fxX5i2M7pFKUgz4EwB/vhEy9ehq7kvXRCG1iHovFLYZItXLU5U9hAMwC6728p2ol
	jMYc7gU5k+ULuj6vRJxDvpAWW8KISZOHEFCWA/GN6+lOX6yOz3x4E5dw9ZtO6xEKqM814Bun4DU
	XwUe7fLe5zdZcPVSyVD5YEU/lznK4TpPX0eGlLFImNjNAdTxhieti4e3WrgvfNkFZc7cWu
X-Received: by 2002:a17:90b:2fc7:b0:34a:b8fc:f1d1 with SMTP id 98e67ed59e1d1-34abd7615d9mr1147397a91.24.1765522136358;
        Thu, 11 Dec 2025 22:48:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjwBUsLPmppv2lCFh0MESIdRRbAVpkrizJWE6D5VbwH4ifoB+I83RqpCwIDr/JtzIx2D1rRAnnvzCL2YESxBk=
X-Received: by 2002:a17:90b:2fc7:b0:34a:b8fc:f1d1 with SMTP id
 98e67ed59e1d1-34abd7615d9mr1147382a91.24.1765522135861; Thu, 11 Dec 2025
 22:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
 <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com> <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
 <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com> <CACGkMEv7XpKsfN3soR9GijY-DLqwuOdYp+48ye5jweNpho8vow@mail.gmail.com>
 <6281cd92-10aa-4182-a456-81538cff822a@gmail.com>
In-Reply-To: <6281cd92-10aa-4182-a456-81538cff822a@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Dec 2025 14:48:44 +0800
X-Gm-Features: AQt7F2pyGCXCSW9_t28SDJCHinthQ4jR902GaH6zJFj_MCKjJBJ5Wq9Ts5kAumo
Message-ID: <CACGkMEvt2Fc274kysuPx4865RzBgu=TMNr1TwMQjRNeDp7D8VA@mail.gmail.com>
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

On Thu, Dec 11, 2025 at 11:04=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 12/11/25 14:27, Jason Wang wrote:
> > On Wed, Dec 10, 2025 at 11:33=E2=80=AFPM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> On 12/10/25 12:45, Jason Wang wrote:
> >>> On Tue, Dec 9, 2025 at 11:23=E2=80=AFPM Bui Quang Minh <minhquangbui9=
9@gmail.com> wrote:
> >>>> On 12/9/25 11:30, Jason Wang wrote:
> >>>>> On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbu=
i99@gmail.com> wrote:
> >>>>>> Calling napi_disable() on an already disabled napi can cause the
> >>>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed ref=
ill
> >>>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
> >>>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill=
 work.
> >>>>>> However, in the virtnet_rx_resume_all(), we enable the delayed ref=
ill
> >>>>>> work too early before enabling all the receive queue napis.
> >>>>>>
> >>>>>> The deadlock can be reproduced by running
> >>>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-ne=
t
> >>>>>> device and inserting a cond_resched() inside the for loop in
> >>>>>> virtnet_rx_resume_all() to increase the success rate. Because the =
worker
> >>>>>> processing the delayed refilled work runs on the same CPU as
> >>>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadl=
ock.
> >>>>>> In real scenario, the contention on netdev_lock can cause the
> >>>>>> reschedule.
> >>>>>>
> >>>>>> This fixes the deadlock by ensuring all receive queue's napis are
> >>>>>> enabled before we enable the delayed refill work in
> >>>>>> virtnet_rx_resume_all() and virtnet_open().
> >>>>>>
> >>>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when paus=
ing rx")
> >>>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
> >>>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/=
results/400961/3-xdp-py/stderr
> >>>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >>>>>> ---
> >>>>>>     drivers/net/virtio_net.c | 59 +++++++++++++++++++-------------=
--------
> >>>>>>     1 file changed, 28 insertions(+), 31 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>> index 8e04adb57f52..f2b1ea65767d 100644
> >>>>>> --- a/drivers/net/virtio_net.c
> >>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_in=
fo *vi, struct receive_queue *rq,
> >>>>>>            return err !=3D -ENOMEM;
> >>>>>>     }
> >>>>>>
> >>>>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> >>>>>> +{
> >>>>>> +       bool schedule_refill =3D false;
> >>>>>> +       int i;
> >>>>>> +
> >>>>>> +       enable_delayed_refill(vi);
> >>>>> This seems to be still racy?
> >>>>>
> >>>>> For example, in virtnet_open() we had:
> >>>>>
> >>>>> static int virtnet_open(struct net_device *dev)
> >>>>> {
> >>>>>            struct virtnet_info *vi =3D netdev_priv(dev);
> >>>>>            int i, err;
> >>>>>
> >>>>>            for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >>>>>                    err =3D virtnet_enable_queue_pair(vi, i);
> >>>>>                    if (err < 0)
> >>>>>                            goto err_enable_qp;
> >>>>>            }
> >>>>>
> >>>>>            virtnet_rx_refill_all(vi);
> >>>>>
> >>>>> So NAPI and refill work is enabled in this case, so the refill work
> >>>>> could be scheduled and run at the same time?
> >>>> Yes, that's what we expect. We must ensure that refill work is sched=
uled
> >>>> only when all NAPIs are enabled. The deadlock happens when refill wo=
rk
> >>>> is scheduled but there are still disabled RX NAPIs.
> >>> Just to make sure we are on the same page, I meant, after refill work
> >>> is enabled, rq0 is NAPI is enabled, in this case the refill work coul=
d
> >>> be triggered by the rq0's NAPI so we may end up in the refill work
> >>> that it tries to disable rq1's NAPI while holding the netdev lock.
> >> I don't quite get your point. The current deadlock scenario is this
> >>
> >> virtnet_rx_resume_all
> >> napi_enable(rq0) (the rq1 napi is still disabled)
> >> enable_refill_work
> >>
> >> refill_work
> >> napi_disable(rq0) -> still okay
> >> napi_enable(rq0) -> still okay
> >> napi_disable(rq1)
> >> -> hold netdev_lock
> >>       -> stuck inside the while loop in napi_disable_locked
> >>               while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> >>                   usleep_range(20, 200);
> >>                   val =3D READ_ONCE(n->state);
> >>               }
> >>
> >>
> >> napi_enable(rq1)
> >> -> stuck while trying to acquire the netdev_lock
> >>
> >> The problem is that we must not call napi_disable() on an already
> >> disabled NAPI (rq1's NAPI in the example).
> >>
> >> In the new virtnet_open
> >>
> >> static int virtnet_open(struct net_device *dev)
> >> {
> >>            struct virtnet_info *vi =3D netdev_priv(dev);
> >>            int i, err;
> >>
> >>            // Note that at this point, refill work is still disabled, =
vi->refill_enabled =3D=3D false,
> >>            // so even if virtnet_receive is called, the refill_work wi=
ll not be scheduled.
> >>            for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >>                    err =3D virtnet_enable_queue_pair(vi, i);
> >>                    if (err < 0)
> >>                            goto err_enable_qp;
> >>            }
> >>
> >>            // Here all RX NAPIs are enabled so it's safe to enable ref=
ill work again
> >>            virtnet_rx_refill_all(vi);
> >>
> > I meant this part:
> >
> > +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> > +{
> > +       bool schedule_refill =3D false;
> > +       int i;
> > +
> > +       enable_delayed_refill(vi);
> >
> > refill_work could run here.
>
> I don't see how this can trigger the current deadlock race. However, I
> see that this code is racy, the try_fill_recv function is not safe to
> concurrently executed on the same receive queue. So there is a
> requirement that we need to call try_fill_recv before enabling napi. Is
> it what you mean?

Exactly, I meant it's racy.

>
> >
> > +       for (i =3D 0; i < vi->curr_queue_pairs; i++)
> > +               if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > +                       schedule_refill =3D true;
> > +
> >
> > I think it can be fixed by moving enable_delayed_refill() here.
> >
> > +       if (schedule_refill)
> > +               schedule_delayed_work(&vi->refill, 0);
> > +}
>
> Thanks,
> Quang Minh.
>

Thanks

>


