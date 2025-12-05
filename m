Return-Path: <bpf+bounces-76097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19863CA5D60
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 02:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26BF53182883
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422F1C8611;
	Fri,  5 Dec 2025 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Agi5P9RW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkMaMkPo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE31DA0E1
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898334; cv=none; b=IRyivWhghSIXjyjJNsWdhOxfzira0Yl/UkOok9DccoJD52n+55VYbY/W5u2zmOmVnG7lwdiqQ+B4j70vb1BwdJkliEuJ64rVGxK/rTXqQDStdxSRfUYGeGSS2NS2rrOJcUjDgex2asjk5Q1JhAfFjAs4Rt1a2BcI07s3w4WkIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898334; c=relaxed/simple;
	bh=b3Ez8+yWMkGA5gpAkQt7RdpyK0iRnQzdGVgQTEK2Zmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e06tM78o5OE7/eClfpMEv6aKmTzA+MPJdnLSPZRsY+5US4/BpH0lHuFN1tAQIgGYwKWdGOV6TLuFdgmyYNZ4dN9TQfgIrGwLn6eDTWyOPFNV1PmYXTIJCXAxiW9BoAgdkvE8RBfVKGTJpuX15PnVY1LoPJ6kEWmYVUftv7ToPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Agi5P9RW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkMaMkPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764898331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
	b=Agi5P9RWoLSpZcGnes0x50uX4S07a+Yg2ai2kFV+U5nOQHARTWaK71Qv8/Mc9VdbHn39gY
	Kz4vulQjWP/s4MK4t8ih+gCj1R1ECCI12teaGmI1obeCCa+0BQFO4MGRaASAmhld59dXGb
	T3Ii8Bu6+Nqi2tK+tbruhPRIqRLjNOw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-mqqa3feuPLmuM1BWs3sCVA-1; Thu, 04 Dec 2025 20:32:08 -0500
X-MC-Unique: mqqa3feuPLmuM1BWs3sCVA-1
X-Mimecast-MFC-AGG-ID: mqqa3feuPLmuM1BWs3sCVA_1764898328
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34943d156e4so4066585a91.3
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764898327; x=1765503127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
        b=HkMaMkPo6Y3tivdLLcw5ndraendKoHwAzZ00TauOmCKCR3Yc6bWYQ7l9D+pjSH7A4D
         HtepKZxCHbjwoIWS5bmT+Ebj55Ym+T3BXMXmE/w5XWH3pOulrs6NLHpoE4dc4w0vkm+y
         NpQ+fWS6CIdxrokmEPT/IxWEWlrS8DC8qg9pKnseWcQEjXFRKZbA6XTUW25o8FGD1C3+
         cgGWACswGgCtgiQ9cYZuyuJ4DOMoCoE6KSW284Oui3XiCEYnbxkn4HcN66c4euDWjtOT
         PEx0PwFcIAv4dde2i1YEKrj5ezWJfNYRrZBf9vSB/yg28e1jU8U31LwQ07qicKNfG5wv
         NGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764898327; x=1765503127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
        b=gaXGS6zp8m0fw++kqWPbAle9AcKtG6L9mOaIxIHYGMrdsyJ9+IuulFWu2zaJCzku4Q
         oCe+GFcEYNKj83JfrAcTNLxwChSOZUNpEZnCBF0r027uFqvrwEFPWFBoRrbCt/kREEW+
         3WhoklC7T3q5POjrCpP4JdmTnthxHirAWqQNyExbRNPYQ2R9Man3akE7SyVZf1qIa3o9
         omvuNKMW0p7WOLXrEO52mwOhLrw/mhn3iKWVZRBgeeKA+IcsjLfy9bfiV8WSWrkqugYd
         MdRyIrKjngxNfrpwstUjGElQhvZumBk7MAyiGtFWgEBOqk66JF17DyEU+AGTHtHAwFVm
         WnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjVWQm3Z/NyKs5TyCvbV8ySE6SSHN33AOFWEDtA7l5dU8mRt2Vluv/lF0jAwoRRuCJgCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpjYnMu3+kYysTKFmvWYlDbvUVj5n8VMOD7RSi3g9kIJuHyWp
	SJVXE1z0IECveDs2joGVAV2csHq/hlr/DaiTuPcQPbapPRN8ONzSLwwAwf26LIIiLOCiBfqt00K
	Yas2gUlM/7SBn6bMIh1hB2uqm1yo3gBdVr4OJ7+AyHtuhHd8BouyouHm0PDmOZcjc6zZ252gwRT
	6+OG4URoK/E4jlMUK3NbI+X28KrYIF
X-Gm-Gg: ASbGnctRmHUBjXSB5QyVQtNvFI0oEEw4t9mkIIzRyrvesZdfNskAfeSbGi7dyv8BD0q
	18mV5wMyEdY6/uT6zM8qfLE44hb0jY2AVj6iODimllClsJE9xcEeTZstu+aj/GzywU44dgOSGC2
	rBy7+8F1QNJCKJDiTvhMkWjGcCepg+Y/WiZhpySqEqrfODPo7blH+IsAT8WE+o3uYjiA==
X-Received: by 2002:a17:90b:2784:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-34947b5ffbfmr5314765a91.3.1764898327391;
        Thu, 04 Dec 2025 17:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZVUUVrZNrU9zy5VVS63ijjPseuKARttg+oAzFaelLxvIi3gh6iAM+h+okddgsxpg98PrIp9rap3jAvrqXnNY=
X-Received: by 2002:a17:90b:2784:b0:340:dd2c:a3f5 with SMTP id
 98e67ed59e1d1-34947b5ffbfmr5314736a91.3.1764898326948; Thu, 04 Dec 2025
 17:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com> <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com> <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
 <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com> <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
 <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
In-Reply-To: <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 09:31:55 +0800
X-Gm-Features: AWmQ_blh1owa4VZkxcTchqi8uqZ8bw7WQqwN7uDSrgQCemeKCLZrFSD0qqwYA5A
Message-ID: <CACGkMEtJ-jErjFQgBcEPVeUo4rHejTZ0cuCCVzHSjzk8S80W5A@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 11:08=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 12/3/25 13:37, Jason Wang wrote:
> > On Tue, Dec 2, 2025 at 11:29=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> On 12/2/25 13:03, Jason Wang wrote:
> >>> On Mon, Dec 1, 2025 at 11:04=E2=80=AFPM Bui Quang Minh <minhquangbui9=
9@gmail.com> wrote:
> >>>> On 11/28/25 09:20, Jason Wang wrote:
> >>>>> On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbu=
i99@gmail.com> wrote:
> >>>>>> I think the the requeue in refill_work is not the problem here. In
> >>>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe =
to
> >>>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync(=
)
> >>>>>> will disable work -> flush work -> enable again. So if the work re=
queue
> >>>>>> itself in flush work, the requeue will fail because the work is al=
ready
> >>>>>> disabled.
> >>>>> Right.
> >>>>>
> >>>>>> I think what triggers the deadlock here is a bug in
> >>>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> >>>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
> >>>>>> refill. It schedules the refill work right after napi_enable the f=
irst
> >>>>>> receive queue. The correct way must be napi_enable all receive que=
ues
> >>>>>> before scheduling refill work.
> >>>>> So what you meant is that the napi_disable() is called for a queue
> >>>>> whose NAPI has been disabled?
> >>>>>
> >>>>> cpu0] enable_delayed_refill()
> >>>>> cpu0] napi_enable(queue0)
> >>>>> cpu0] schedule_delayed_work(&vi->refill)
> >>>>> cpu1] napi_disable(queue0)
> >>>>> cpu1] napi_enable(queue0)
> >>>>> cpu1] napi_disable(queue1)
> >>>>>
> >>>>> In this case cpu1 waits forever while holding the netdev lock. This
> >>>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
> >>>>> NAPI enablement with netdev_lock()")?
> >>>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable dela=
yed
> >>>> refill when pausing rx"), but it has flaws.
> >>> I wonder if a simplified version is just restoring the behaviour
> >>> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
> >>> something.
> >> As far as I understand, before 413f0271f3966 ("net: protect NAPI
> >> enablement with netdev_lock()"), the napi is protected by the
> > I guess you meant napi enable/disable actually.
> >
> >> rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(),
> > Any reason we need to hold rtnl_lock() there?
>
> Correct me if I'm wrong here. Before 413f0271f3966 ("net: protect NAPI
> enablement with netdev_lock()"), napi_disable and napi_enable are not
> safe to be called concurrently.
>
> The example race is
>
> napi_disable -> napi_save_config -> write to n->config->defer_hard_irqs
> napi_enable -> napi_restore_config -> read n->config->defer_hard_irqs
>
> In refill_work, we don't hold any locks so the race scenario can happen.

Ok, I get you, so it occurs after we introduced the NAPI config to virtio-n=
et.

>
> Maybe I misunderstand what you mean by restoring the behavior before
> 413f0271f3966. Do you mean that we use this pattern
>
>      In virtnet_xdp_se;
>
>      netdev_lock(dev);
>      virtnet_rx_pause_all()
>          -> napi_disable_locked
>
>      virtnet_rx_resume_all()
>          -> napi_disable_locked
>      netdev_unlock(dev);
>
> And in other places where we pause the rx too. It will hold the
> netdev_lock during the time napi is disabled so that even when
> refill_work happens concurrently, napi_disable cannot acquire the
> netdev_lock and gets stuck inside.

It might work but I think it would be easy to either

1) use locked version everywhere

or

2) use the unlocked version everywhere

Mix using locked and unlocked may cause the code hard to be maintained

Thanks

>
>
> >
> >> so it seems like we will have race condition before 413f0271f3966 ("ne=
t:
> >> protect NAPI enablement with netdev_lock()").
> >>
> >> Thanks,
> >> Quang Minh.
> >>
> > Thanks
> >
>
> Thanks,
> Quang Minh.
>


