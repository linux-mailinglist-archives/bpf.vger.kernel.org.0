Return-Path: <bpf+bounces-73752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AFBC386FF
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 01:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECFB189B870
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041D748F;
	Thu,  6 Nov 2025 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlAWx1f6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2DDF6C
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387724; cv=none; b=Wp17CaiCv1zts58OEQApT5VLv+WwfqSiv8gLtQR9uWYlVKiCOFre411C1F891Vrr0b3qha+92Ag5MfAiRvFlItQn2bDc/9hWFxDZnvbq2g9aUygTRRnozglnDFpZMqF4RLoZfLRBmIEw/9svyDY9SlOKxDjMH276LVwhaGqztK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387724; c=relaxed/simple;
	bh=+cgcBm3n8RexVBW5E4kKdqtUnr3KM9u/GagAJsA852U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJ/0mYl13Z+1wn1UqDIS2/A42aqRWbAU/PWmeYtYWvjPJLHxQUqRAjt0MNxnQdlUPpZKi0PTzk9afqaL84pnbradBjunxtt9FnOb7i0s5ivCrE00MsyNmYRXco+H2wZMalDVqIl9/qFKlksXnsx/kqHAqfXIINlwC72PwFmtkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlAWx1f6; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so478071a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762387722; x=1762992522; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eYbuX9MpRBmVXKzfauAaHPRqfM+qKBMR81zQl4uFDYI=;
        b=WlAWx1f6HlMTl6q3s3lqNWIuqaUXBDE7EzFBd7RXCAEnpm6Y2Lz1nZ1MSriEWfCEYR
         weCcVKOI9A3dauV8UgdYl0gMg23YKi+eIB47m9uYhNPc5Afl17P4klSvXxEjkNkBCX4L
         8xCD+Jxam0+SdMP2sEcFSXBgzfF6FdZ4pu5YFAh92g4c93mdI1MjfJA3S5mZBg2JD2Zm
         9FO2la6H8wnk1dISqR1P0oh7uPlqnJdIOyXzV6b1gc/xsdbC77SebJnSfXwtn6Y3un/b
         VWf7MUQUPPBZFW4qtucaul4buGrHyWAAEv1nSY01BsmBkPXf35yC6IZb0WGVURxS7/X0
         2cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762387722; x=1762992522;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYbuX9MpRBmVXKzfauAaHPRqfM+qKBMR81zQl4uFDYI=;
        b=LAqd3YRYLyP3tsqfr1I3a2wELTYHWa9hME369tRRbVnOIUqawCfv4dMabt8d2B78Cb
         hhtFzR5EwMumMOkpP64h4wQs+AyT3XGwvxOeH7d3/VXNSJL2XzIYWpgT4b8QzPqbJah1
         UDGG/nNn8qbfudGRmBG1QIu8w+W3eL4a4U0VwXHEjtUPIbSG/GHnsvBT4cPFICdrk0Et
         e5GlJie+RXoaR1W1heW8gSSHqug1Xmkm9OXe3ogKANNaRHrfxOUHYcLcrD9sks/hFPMT
         OZo0KJ4H9BSPaHewUBikEna8yfp9OeyawQmwBJPWule6yPqmLM8BZ34cKqAJA0BsXPO7
         AuHg==
X-Forwarded-Encrypted: i=1; AJvYcCV1gg4HsjXSLlEaq8HRV8qCZKdOZLOYcfKOzy/GUcDgFvZCS2UsC/f4fEHolHPiqMVDA0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0PH/gZgsT/9Z/+4V5MmQ3eY6mOCkbZTwYxDakPd6pdr8K5yoz
	vfTjTr+JynvCtbYXvLVzacrdZ1xWT1N8VmE9aPKC4OHMdcta5Ox92POc
X-Gm-Gg: ASbGnctW8fOYMuQhg/p6ft2eyoRa0/LIJnqKv3fG79IgMp6T7Atw6Lq+yaewbp+7a8z
	Q9nTyF3l0aa3RMV7usrG0qBhsS9nxjvPW5zCnEKvXkOqOSy0XDDRFD7wUZrqYxfuD2ZnOLOavjA
	yjx8fihPxGVeB8s5MB7CbrKL/B9LQuXLLYmoirwOJA1UUwyRrfeKDI/mPqOlpaVaFHDbfnNeBkr
	v4UvkspAsypxgHszhWpG3aWMBWLTPC6gYgqDoZ3To/bcWzAVEfQWsHyHr/M8P4KM+oDiPu3u+93
	x7q64P/364Zs/UylAK27ksuqkFXujTuHTvPE0XoICYfV67cLVnGnFvPbmyCdKyTM4/MT0/bQACk
	8kKA/1eIWdqMk7rV+KKJLahDlo1/Reh0jlOT9sLnQQLRZzvdf1JpMtWm95Kz+/54WRROZJEHpkN
	AHwRjRjziQyXTJ8L/OrlF3tC4XBaze7Q8SiHg=
X-Google-Smtp-Source: AGHT+IGmgOLTxwofxMxj+rIe5xSeDyGPjF0GAzKxQ3KLYUz9LZOZYHPbq5Utr6uytIY1FLBAvcbu5g==
X-Received: by 2002:a17:902:f60b:b0:295:6a9:cb62 with SMTP id d9443c01a7336-2962ad877c9mr60097145ad.35.1762387721755;
        Wed, 05 Nov 2025 16:08:41 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd2423sm7088065ad.110.2025.11.05.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:08:41 -0800 (PST)
Message-ID: <405f8893435d47badc66920b9e8e22b40be469a1.camel@gmail.com>
Subject: Re: [PATCH RFC v1 5/5] bpf: remove lock from bpf_async_cb
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 05 Nov 2025 16:08:40 -0800
In-Reply-To: <0ee6e906-6bba-4145-8e06-f1c47ab19af3@gmail.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
	 <20251031-timer_nolock-v1-5-bf8266d2fb20@meta.com>
	 <80b877f638eef0971bceeb2d4a4d9fd776483379.camel@gmail.com>
	 <a85b3b32-57a7-4d0a-b925-27e6a59e7f67@gmail.com>
	 <e9a2c7fc68b5d69abeadf38350eae375f24c58bf.camel@gmail.com>
	 <0ee6e906-6bba-4145-8e06-f1c47ab19af3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 23:39 +0000, Mykyta Yatsenko wrote:
> On 11/5/25 22:44, Eduard Zingerman wrote:
> > On Wed, 2025-11-05 at 15:30 +0000, Mykyta Yatsenko wrote:
> >=20
> > [...]
> >=20
> > > > > @@ -1472,12 +1489,19 @@ BPF_CALL_3(bpf_timer_start, struct bpf_as=
ync_kern *, timer, u64, nsecs, u64, fla
> > > > >    		return -EOPNOTSUPP;
> > > > >    	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> > > > >    		return -EINVAL;
> > > > > -	__bpf_spin_lock_irqsave(&timer->lock);
> > > > > -	t =3D timer->timer;
> > > > > -	if (!t || !t->cb.prog) {
> > > > > -		ret =3D -EINVAL;
> > > > > -		goto out;
> > > > > -	}
> > > > > +
> > > > > +	guard(rcu)();
> > > > > +
> > > > > +	t =3D READ_ONCE(async->timer);
> > > > > +	if (!t)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/*
> > > > > +	 * Hold ref while scheduling timer, to make sure, we only cance=
l and free after
> > > > > +	 * hrtimer_start().
> > > > > +	 */
> > > > > +	if (!bpf_async_tryget(&t->cb))
> > > > > +		return -EINVAL;
> > > > Could you please explain in a bit more detail why tryget/put pair i=
s
> > > > needed here?
> > > Yeah, we need to hold the reference to make sure even if cancel_and_f=
ree()
> > > go through, the underlying timer struct is not detached/freed, so we =
won't
> > > get into the situation when we first free, then schedule, with refcnt=
 hold,
> > > we always first schedule and then free, this allows for cancellation =
run
> > > when
> > > the last ref is put.
> >
> > Sorry, I still don't get it.
> > In bpf_timer_start() you added `guard(rcu)()`.
> > In bpf_timer_cancel_and_free():
> >=20
> >   - bpf_timer_cancel_and_free
> >     - bpf_async_put(cb: &t->cb, type: BPF_ASYNC_TYPE_TIMER)
> >       - bpf_timer_delete(t: (struct bpf_hrtimer *)cb);
> >         - bpf_timer_delete_work(work: &t->cb.delete_work);
> >         	 - call_rcu(head: &t->cb.rcu, func: bpf_async_cb_rcu_free)
> >=20
> > So, it looks like `t->cb` is protected by RCU and can't go away
> > between `guard(rcu)()` and bpf_timer_start() exit.
> > What will go wrong if tryget is removed?
>
> bpf_timer_delete() also calls hrtimer_cancel(). If bpf_timer_start()
> does not hold refcnt, we may run into the situation when hrtimer_cancel()
> runs before hrtimer_start(). The timer is going to be deleted after the
> grace period but it is not cancelled, and the timer callback may read=20
> after free.
> Holding refcnt makes sure hrtimer_cancel() will be called after=20
> hrtimer_start()
> (or way before it, and we error out).

Ok, so the following path is possible:
- bpf_timer_cancel_and_free
  - bpf_async_put
    - bpf_timer_delete (if refcount_dec_and_test(r: &cb->refcnt) returns tr=
ue)
      - queue_work
      	- bpf_timer_delete_work
	  - hrtimer_cancel
	  - call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free)

And thus, the following sequence of events would be possible w/o the
tryget:

  Thread A                      Thread B
  --------------------------    ------------------------------
  enter bpf_timer_start
  enter RCU protected region
                                bpf_timer_cancel_and_free call
				hrtimer_cancel()
				call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free)
  hrtimer_start()
  exit RCU protected region

                     ... some thread ...
		     bpf_async_cb_rcu_free()
		     timer is popped from the queue, use after free
=20
Makes sense, thank you for explaining.

[...]

