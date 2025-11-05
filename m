Return-Path: <bpf+bounces-73740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E880AC3839B
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C0F3B8DB8
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82C2F1FD0;
	Wed,  5 Nov 2025 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ganiIBbi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29B82F39DA
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382677; cv=none; b=isui+hXxEmo62aDuhHZ24vB4WrUEmtgo2AesrUS64KVa/ihSi5SV42Z6lwIV9MnmSI1ZWo84ClZTSJqHgPTVWSppmsctDTAGmMoG4ZM1QdPTSqd8uJ6Cm15EOzff07JFsU6qKPun466CPhfKa13V5PANvOTLnHZjy8BlEJ+vd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382677; c=relaxed/simple;
	bh=WLzfimeh+A8BXQKkFsqmN+hYJATJ4LbMICZXminMhdo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CdiMRsr0Egxefeq9quKRUAZd+iHoOALKs8hX6SrhYhT+MYMbuduwHtv6pfEZUajKes2ZafFFZteNji8Ya0CDpF6L/DVSvhxLHOHveIP2rszmCwk7gmVZmtKg8mkyjkbQ8DMA2Vy69LUMj6P4nrJT2GGrVqwc42Hoi8lyjal5N7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ganiIBbi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso296582a91.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382675; x=1762987475; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9F3hFaMtkL3satTAl3jce6WMA/V5ZrNpG/JNLTagLT8=;
        b=ganiIBbiYuYZ9Iaog8iaKl2Tle/SVUGBaEGvBmtHNGWpKH+IEpeYWr5rr9qDkZq0w1
         rONxYq98WpjKaH2fmeZNAr4D87hc5qBV6FymLLW9ugYiZe2zmYInfybBCUx2UrejyEsN
         qLFiWM7Xr4VejlRL9j35jayzq4aPdE4q0YB4YdHxwKMShktHc/g3MhbU9Jh7+36UvD92
         NcW2Ap0RmZoQSoU3AwIrvuCEQnSSEsY/4/ymhpxsmW3hCS07DN23ZrxmxLWJtuHSIFJW
         PFMdree6qQMQ5CENdbki9SRc+btPv0qTTIizLWniZFKiZ73CD+fIszokfHVKK42cOvUq
         lbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382675; x=1762987475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9F3hFaMtkL3satTAl3jce6WMA/V5ZrNpG/JNLTagLT8=;
        b=XKoUbQO2YD7BPf7A0jeDR++fVOMcWCa/VlbvGj0mENH74fkLG63M9jqbelw7VswRCV
         9Ly8FG3o6Y886Ja/pVYmMo7IWHXJC7p5sp4uAhZU7ppeGZUYooaPK5NBoFOKG8r4WhqY
         uQkyWIzTGDeKZDtLFFNNtcq/VZjzSKmeI2HRGPqa+j/nF3CWcdl9+UID9koHUh3BboQ7
         1yYLxBCKeSlLNZix/DJi8QJ5pxV2vXvBbYk2A0XA2HvHqIYNDeVTgIXfvyyhTyRG8A9g
         evqxCNcHWCnzcMZ/5GhVGQ5RPbyJgRBllr8FaIFxIaWuz7/yEAbijo26gTSket+GEf2A
         kIcw==
X-Forwarded-Encrypted: i=1; AJvYcCX70/kMZvOAYTKHbywqExk7eVw/Gb/dzI7o1BuQOYs1MgLP8jeu+oKEpsZVqyWDj4ipBpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP86A8a15lIY0x5Vg71hK8nRKJcO4Tgdte+l2fdQLlUJT5mPXq
	IBuEiIYjKbQAJiZqsuyOOpDvWDeF3XhicODwJp3mbL7VuA6HAbi1IGio
X-Gm-Gg: ASbGncsOBHz8csG6py2hSKC7vbv9gM239ZucKrfNlkYyu3waXQlo3PoyS8+Epqvme/Z
	qVHPLOXVfmoAeHqoULcp28Lv0HiGq90xqFefURvPUzYUaZ8S7H+Z4PYl+/MSFBK6g/GCgeRMVbQ
	w3oiZOOyk4SkEQCQZQo6zVZCB+YjGbTJdbhSgqE/lPKcF3xXtRduw+874vubh9vpl4l5kW7caDV
	a+bbS8LBANZIB9qKujHicHwTiU6yCJwh143+oHBrfQ4iqFKFckuRVTxUtIMAQqJtlaMd4ASg0Lr
	+j1BqCy9HM2fgmCxvegluo4Le5O3sqKJ0SBSmSUiThAa1Ke12Dy4DFvQ2rXHjmUAVnudKkw9UKO
	4No+E39LtnpspyvvKeuegxl6lziNW5jTX8c5sZHt4gyWvYLF6Zx0yLe0IQoBkjqhIA2wG0l4mo5
	MYWFDcvXZDEmbUW3KzTFQCAU1mciV6Zr9A0pU=
X-Google-Smtp-Source: AGHT+IGQ1Xn4umn2TlBKI3QGaaimOLmthuWxjTLCDU/flhBF/4PDXG5i5AdwqsSAQfpZ94Bg9+LtBw==
X-Received: by 2002:a17:90b:134e:b0:340:2a18:1536 with SMTP id 98e67ed59e1d1-341a6dec69amr4666985a91.25.1762382674810;
        Wed, 05 Nov 2025 14:44:34 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a696f15asm4001251a91.12.2025.11.05.14.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:44:34 -0800 (PST)
Message-ID: <e9a2c7fc68b5d69abeadf38350eae375f24c58bf.camel@gmail.com>
Subject: Re: [PATCH RFC v1 5/5] bpf: remove lock from bpf_async_cb
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 05 Nov 2025 14:44:33 -0800
In-Reply-To: <a85b3b32-57a7-4d0a-b925-27e6a59e7f67@gmail.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
	 <20251031-timer_nolock-v1-5-bf8266d2fb20@meta.com>
	 <80b877f638eef0971bceeb2d4a4d9fd776483379.camel@gmail.com>
	 <a85b3b32-57a7-4d0a-b925-27e6a59e7f67@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 15:30 +0000, Mykyta Yatsenko wrote:

[...]

> > > @@ -1472,12 +1489,19 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_=
kern *, timer, u64, nsecs, u64, fla
> > >   		return -EOPNOTSUPP;
> > >   	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> > >   		return -EINVAL;
> > > -	__bpf_spin_lock_irqsave(&timer->lock);
> > > -	t =3D timer->timer;
> > > -	if (!t || !t->cb.prog) {
> > > -		ret =3D -EINVAL;
> > > -		goto out;
> > > -	}
> > > +
> > > +	guard(rcu)();
> > > +
> > > +	t =3D READ_ONCE(async->timer);
> > > +	if (!t)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Hold ref while scheduling timer, to make sure, we only cancel an=
d free after
> > > +	 * hrtimer_start().
> > > +	 */
> > > +	if (!bpf_async_tryget(&t->cb))
> > > +		return -EINVAL;
> >
> > Could you please explain in a bit more detail why tryget/put pair is
> > needed here?
>
> Yeah, we need to hold the reference to make sure even if cancel_and_free(=
)
> go through, the underlying timer struct is not detached/freed, so we won'=
t
> get into the situation when we first free, then schedule, with refcnt hol=
d,
> we always first schedule and then free, this allows for cancellation run=
=20
> when
> the last ref is put.

Sorry, I still don't get it.
In bpf_timer_start() you added `guard(rcu)()`.
In bpf_timer_cancel_and_free():

 - bpf_timer_cancel_and_free
   - bpf_async_put(cb: &t->cb, type: BPF_ASYNC_TYPE_TIMER)
     - bpf_timer_delete(t: (struct bpf_hrtimer *)cb);
       - bpf_timer_delete_work(work: &t->cb.delete_work);
       	 - call_rcu(head: &t->cb.rcu, func: bpf_async_cb_rcu_free)

So, it looks like `t->cb` is protected by RCU and can't go away
between `guard(rcu)()` and bpf_timer_start() exit.
What will go wrong if tryget is removed?

> > >   	if (flags & BPF_F_TIMER_ABS)
> > >   		mode =3D HRTIMER_MODE_ABS_SOFT;
> > [...]
> >=20
> > > @@ -1587,22 +1598,17 @@ static struct bpf_async_cb *__bpf_async_cance=
l_and_free(struct bpf_async_kern *a
> > >   {
> > >   	struct bpf_async_cb *cb;
> > >  =20
> > > -	/* Performance optimization: read async->cb without lock first. */
> > > -	if (!READ_ONCE(async->cb))
> > > -		return NULL;
> > > -
> > > -	__bpf_spin_lock_irqsave(&async->lock);
> > > -	/* re-read it under lock */
> > > -	cb =3D async->cb;
> > > -	if (!cb)
> > > -		goto out;
> > > -	drop_prog_refcnt(cb);
> > > -	/* The subsequent bpf_timer_start/cancel() helpers won't be able to=
 use
> > > +	/*
> > > +	 * The subsequent bpf_timer_start/cancel() helpers won't be able to=
 use
> > >   	 * this timer, since it won't be initialized.
> > >   	 */
> > > -	WRITE_ONCE(async->cb, NULL);
> > > -out:
> > > -	__bpf_spin_unlock_irqrestore(&async->lock);
> > > +	cb =3D xchg(&async->cb, NULL);
> > > +	if (!cb)
> > > +		return NULL;
> > > +
> > > +	/* cb is detached, set state to FREED, so that concurrent users dro=
p it */
> > > +	xchg(&cb->state, BPF_ASYNC_FREED);
> > > +	bpf_async_update_callback(cb, NULL, NULL);
> > Calling bpf_async_update_callback() is a bit strange here.
> > That function protects 'cb' state by checking the 'cb->state',
> > but here that check is sidestepped.
> > Is this why you jump to drop for FREED state in bpf_async_update_callba=
ck()?
>
> yes, this is probably a bit ugly, but I find it handy to have all the
> tricky code that mutates callback and prog inside the single function
> bpf_async_update_callback().

Probably subjective, but it makes things more confusing for me.

