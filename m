Return-Path: <bpf+bounces-73507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7ABC331FE
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62A218C1341
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E6830CDB1;
	Tue,  4 Nov 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gatkr58B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5A1B81CA
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293671; cv=none; b=DspnGZaDcXecoA5VPQl4HC69S5AE4bxeTUoTSZYr97ukyyRg9ZDL50NNKx+x+LncPr28pyKxLWWYEcXJrPmGpByJgZSwf9Ouhp1V5p3/pW0NohfjbpgAF0RmsGMzIsmM+IOYuR0R4f4YQCrurxaoUNmh3bLXTeSCUD954O785PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293671; c=relaxed/simple;
	bh=UZsXbqOdCC9HN2DtPgP1KhRjelYOu6jpJhv/w2xJMMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUcA6b/QhTZpTzcrzxcof9i5NbO69/26rSpTq+N1yhj7ymAsG/H7zEoZM7CVKou+DMb2Ly2kS58pRXqYiZuk5O1P0IxCJboAILIJeDGG9Tt7LKPhODJUaOaQ9L6Fb1LEvKkfdxyA2dKYITek1tDVujxmj9wltgiTfEGOvWafZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gatkr58B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2956d816c10so36722785ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762293669; x=1762898469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TDEaYDf+tsiwa2hlBs3+fmiBZCj4jsc9EuOSE4Pno48=;
        b=Gatkr58Bfz7eOVhGo8bjSE9ckasuinBVpxD+6gKt66Laxqqt8s9EPQ++PKh/kuqdRV
         VZxFgBnb9SSBsUOSIDD3VepYfuyOuVd8hjrXpwHrx4ptllLNPS4QfT2IhH1vRxr1otz3
         BBcAKLna/edS5LcLLbZa+GlntZ31OexrcorI5M67P//qK6z0AIFivCxCzF1hBKkkZyEi
         tr5Est9fRLDa/JZGSgxNx1o85wac/Nwc8AOW595J/1pulpKCXa+j1U6kEK7dHizvI++y
         lbwOpg/YBsQmU815sXje2T7EU2OWvjqJuPevvS2ibpwuSg/MDP3gLWCPx6wPo/UvNJAz
         GBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293669; x=1762898469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDEaYDf+tsiwa2hlBs3+fmiBZCj4jsc9EuOSE4Pno48=;
        b=H/qmy+xneDaLgg+k03dU+195w9AVm+55mOro65rmVOgsc0jYCtCtxwxCjcmgTOEuWj
         Nl86Vfx5xhrpv7R4Gq5ymOpihO2NyA6JHe73PmDjSsJXJAQoZ7+Hamzrz/Rx1v/vNi9M
         JmlvZKoG/4NK1M1LWfO0Zn5a/k6sXy6tmM1ewJMgk15lkhnJnHkmHeGBurK5194AovTC
         tu76lFmxe8wzfLC3upme/OGpIiqezbzEO2OkFdcpeZKSCf2GlXWNQV9yK2pA3mSYfhfZ
         3mzyRCzJBMDxAjUa2j7hhQ1YnnQbi2qdf94hua4Ld1RLIzSLIM+C5s27RGmflwxrRODJ
         nwZg==
X-Forwarded-Encrypted: i=1; AJvYcCXsv5pUHm9JIrp4zpNEhn5l22+go8QxVgd5y9bZEY1F/MCq+7Eezbd8mgVz/DpecOwMdT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FaeOkLLiH7ObwuJsnqKJdFPAT2FGACrTHt1FR0k9yZVApV1e
	nBAMklauNMu0AfmLXlo+YKz2xl1ZFiopiYOBCXbj9hdnM74QPzU3s9M5
X-Gm-Gg: ASbGncuIoM55ekpkHD0qCCXNhjZGGEEaeRtWUNvXztESTeOy2kAn/yhC0zBCN7Sp8Jd
	Ly712ZTcf7QTVCxeEqgnJFVYaSpoXA4ivDL1YDkWFizLmfjVqYRz4Y9HPx9a4nBedSI5BoGTQXz
	qjJJUi9JauorXF+ZvABGpC6BhrLNp7S3RB62i6InJ3IH4TI2BTzS3z2KgnAngsZNBegkZ5B8iCh
	hPtXqY2nlYtjSA6nV39hx3qFJjbOox1ixvc2h2rmxahp+sUyDUmLD0gmvXebcLCJ2AJMHHTT8oU
	Tm3hpax8EC75dYah6BeTx5Vvb2RCzZfJt7IqXHA+eEVAW7gxsGo/qH1qFX0DFpf0RUvBZDrfFT5
	RzbAFgMqXHg4lbwcpYgownIh5F9dMzJNNuRXWZouH7me8CvUZyCcdQ3c7zG9z4SY/EbQFs3+cNH
	7yeeTf1oVsPq87L9BriCo98kCMeAudRUue3A==
X-Google-Smtp-Source: AGHT+IHUz3GXu7CBUFynYAFN/6qs91ej8j4+ES+esuWXUyu2qHb8SEnSYg6FYbRIg92kjMIEi9FfzQ==
X-Received: by 2002:a17:902:b608:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-2962ad07981mr10447325ad.1.1762293669022;
        Tue, 04 Nov 2025 14:01:09 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019729dbsm38637835ad.4.2025.11.04.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:01:08 -0800 (PST)
Message-ID: <80b877f638eef0971bceeb2d4a4d9fd776483379.camel@gmail.com>
Subject: Re: [PATCH RFC v1 5/5] bpf: remove lock from bpf_async_cb
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 04 Nov 2025 14:01:06 -0800
In-Reply-To: <20251031-timer_nolock-v1-5-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
	 <20251031-timer_nolock-v1-5-bf8266d2fb20@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 21:58 +0000, Mykyta Yatsenko wrote:

[...]

> @@ -1344,12 +1348,17 @@ static int __bpf_async_init(struct bpf_async_kern=
 *async, struct bpf_map *map, u
>  		/* maps with timers must be either held by user space
>  		 * or pinned in bpffs.
>  		 */
> -		WRITE_ONCE(async->cb, NULL);
> -		kfree_nolock(cb);
> -		ret =3D -EPERM;
> +		switch (type) {
> +		case BPF_ASYNC_TYPE_TIMER:
> +			bpf_timer_cancel_and_free(async);
> +			break;
> +		case BPF_ASYNC_TYPE_WQ:
> +			bpf_wq_cancel_and_free(async);
> +			break;
> +		}
> +		return -EPERM;

Just want to double-check my understanding, are below points correct?
- You need to call cancel_and_free() instead of kfree_nolock() because
  after cmpxchg() the map value is published and some other thread
  could have scheduled work/armed the timer.
- Previously this was not possible, because the other thread had to
  take the async->lock.

>  	}
> -out:
> -	__bpf_spin_unlock_irqrestore(&async->lock);
> +
>  	return ret;
>  }
> =20
> @@ -1398,41 +1407,42 @@ static int bpf_async_swap_prog(struct bpf_async_c=
b *cb, struct bpf_prog *prog)
>  		if (IS_ERR(prog))
>  			return PTR_ERR(prog);
>  	}
> +	/* Make sure only one thread runs bpf_prog_put() */
> +	prev =3D xchg(&cb->prog, prog);
>  	if (prev)
>  		/* Drop prev prog refcnt when swapping with new prog */
>  		bpf_prog_put(prev);
> =20
> -	cb->prog =3D prog;
>  	return 0;
>  }
> =20
> -static int bpf_async_update_callback(struct bpf_async_kern *async, void =
*callback_fn,
> +static int bpf_async_update_callback(struct bpf_async_cb *cb, void *call=
back_fn,
>  				     struct bpf_prog *prog)
>  {
> -	struct bpf_async_cb *cb;
> +	enum bpf_async_state state;
>  	int err =3D 0;
> =20
> -	__bpf_spin_lock_irqsave(&async->lock);
> -	cb =3D async->cb;
> -	if (!cb) {
> -		err =3D -EINVAL;
> -		goto out;
> -	}
> -	if (!atomic64_read(&cb->map->usercnt)) {
> -		/* maps with timers must be either held by user space
> -		 * or pinned in bpffs. Otherwise timer might still be
> -		 * running even when bpf prog is detached and user space
> -		 * is gone, since map_release_uref won't ever be called.
> -		 */
> -		err =3D -EPERM;
> -		goto out;
> -	}
> +	state =3D cmpxchg(&cb->state, BPF_ASYNC_READY, BPF_ASYNC_BUSY);
> +	if (state =3D=3D BPF_ASYNC_BUSY)
> +		return -EBUSY;
> +	if (state =3D=3D BPF_ASYNC_FREED)
> +		goto drop;

Why do you need to 'drop' at this point?
'cb' object had not been changed by current thread yet,
so it seems that something like:

  if (state =3D=3D BPF_ASYNC_FREED)
    return -EPERM;

Should suffice.

> =20
>  	err =3D bpf_async_swap_prog(cb, prog);
>  	if (!err)
>  		rcu_assign_pointer(cb->callback_fn, callback_fn);
> -out:
> -	__bpf_spin_unlock_irqrestore(&async->lock);
> +
> +	state =3D cmpxchg(&cb->state, BPF_ASYNC_BUSY, BPF_ASYNC_READY);
> +	if (state =3D=3D BPF_ASYNC_FREED) {
> +		/*
> +		 * cb is freed concurrently, we may have overwritten prog and callback=
,
> +		 * make sure to drop them
> +		 */
> +drop:
> +		bpf_async_swap_prog(cb, NULL);
> +		rcu_assign_pointer(cb->callback_fn, NULL);
> +		return -EPERM;
> +	}
>  	return err;
>  }

[...]

> @@ -1472,12 +1489,19 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern=
 *, timer, u64, nsecs, u64, fla
>  		return -EOPNOTSUPP;
>  	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
>  		return -EINVAL;
> -	__bpf_spin_lock_irqsave(&timer->lock);
> -	t =3D timer->timer;
> -	if (!t || !t->cb.prog) {
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> +
> +	guard(rcu)();
> +
> +	t =3D READ_ONCE(async->timer);
> +	if (!t)
> +		return -EINVAL;
> +
> +	/*
> +	 * Hold ref while scheduling timer, to make sure, we only cancel and fr=
ee after
> +	 * hrtimer_start().
> +	 */
> +	if (!bpf_async_tryget(&t->cb))
> +		return -EINVAL;

Could you please explain in a bit more detail why tryget/put pair is
needed here?

>  	if (flags & BPF_F_TIMER_ABS)
>  		mode =3D HRTIMER_MODE_ABS_SOFT;

[...]

> @@ -1587,22 +1598,17 @@ static struct bpf_async_cb *__bpf_async_cancel_an=
d_free(struct bpf_async_kern *a
>  {
>  	struct bpf_async_cb *cb;
> =20
> -	/* Performance optimization: read async->cb without lock first. */
> -	if (!READ_ONCE(async->cb))
> -		return NULL;
> -
> -	__bpf_spin_lock_irqsave(&async->lock);
> -	/* re-read it under lock */
> -	cb =3D async->cb;
> -	if (!cb)
> -		goto out;
> -	drop_prog_refcnt(cb);
> -	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
> +	/*
> +	 * The subsequent bpf_timer_start/cancel() helpers won't be able to use
>  	 * this timer, since it won't be initialized.
>  	 */
> -	WRITE_ONCE(async->cb, NULL);
> -out:
> -	__bpf_spin_unlock_irqrestore(&async->lock);
> +	cb =3D xchg(&async->cb, NULL);
> +	if (!cb)
> +		return NULL;
> +
> +	/* cb is detached, set state to FREED, so that concurrent users drop it=
 */
> +	xchg(&cb->state, BPF_ASYNC_FREED);
> +	bpf_async_update_callback(cb, NULL, NULL);

Calling bpf_async_update_callback() is a bit strange here.
That function protects 'cb' state by checking the 'cb->state',
but here that check is sidestepped.
Is this why you jump to drop for FREED state in bpf_async_update_callback()=
?

>  	return cb;
>  }

[...]

