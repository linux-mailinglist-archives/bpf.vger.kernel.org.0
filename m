Return-Path: <bpf+bounces-72654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D9C1772B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3476A3A5227
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94261CAA4;
	Wed, 29 Oct 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrID+pVC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01444A41
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696076; cv=none; b=rTc0VVIHFmKFsdDZHmKc/gBWB0h7fD6IGBuxBCM2qs2IlkEX+Q3wrJOvLkJusy3MACY/QaKH5t1yR97Orz6dYJsnKQjor02fcIMKFdAgg30BS6cGRjFBcb0DnPwPXNxayT+wuNPjr/OLE8Cse8WLac8T7nFvcCZ+8ZwRdUp0KE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696076; c=relaxed/simple;
	bh=KSsYzrOROHvpveELtj2P3rV5KHC8RF3TgZLr336dA44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idxtxS4spVonBBI4lAGXb8yeez0vs3sqqfhU1Wyey9Fq6Tx5Q+rC60frgqNwTv9iENJjFazo4lyaBzuw53caA3vxNcyHa7MrZA8p8Gp+0tALWV8vi/gVGwQITUT23+9zcwDZDjiZVJWgawHN1R2csTCPXVFFcZ6bRzwI0JK7QFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrID+pVC; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-945a4218f19so20796439f.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761696074; x=1762300874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKrUqAEKrt2jMEwY5jFnhV9CSrg3ZApnj6UHXbNZRz8=;
        b=RrID+pVCWCPAIACb78qHpH6TcrDqJKijYBuKIZosdngHuTXgN0lVOG1tjxbeyCa7SB
         PfEQCYoJjUyR3xeu+D+pRTyVoxr7zzKx+9J2ExADi8iF6eUWNmnmvYyiw+OtWnct/uEj
         GxsxQsIgIHGNmrY/gSNL10SMAM7B70hpWLav6D67HJGkO2DlOOqiuqKAZaJ9dRt8wgYv
         4NMQv73htvfJCUfnbGAOqK+KAfkZPqKPYZnuR0ynMDo7hy6qUUeSWik7X9FkQDeFuxj2
         fFHPfpcIwiKKwGKttHdVRqbRxkHft5uMJxfp827CiW6AXzNVesdY31EuiwtqGViMBzo+
         vyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696074; x=1762300874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKrUqAEKrt2jMEwY5jFnhV9CSrg3ZApnj6UHXbNZRz8=;
        b=djoiGZ7DdxO3byud2o7k02Lh3/4E1D+16zR3Xzc0Sn1Wdn4kFLBgfmTeLNKQpu2Tmx
         rdYYJ3pYTvB4bt8u+fAl7cPQfrcK71LYgs7RxHne6758uY7QNx6LfpkcCSXq4l4sUNRN
         QGjEkNr7NW2+2Q4Kul8TuPS1NDyNoSlYhqTvyRJKPxZlG9XsE2tuM67USBQagPbCUR7M
         KqlPoHSlUGdDK8i8jmey9WUFXBTrah3do84Rl+BcQkETtCPvqPM4C9YQHXSZx4ZtIlRD
         xn8NxvpWdT8yjtcCxl9aoVCajgPW2gHLl0tGtbW7efKfYs9e87ZO4vg6ZqgWHNoTpENK
         B7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrKOf4zN1L+qTD7CYHjnQDIbXkt0OlUviSxKRnfWywtM9ah/lg1fTeHuUjZNvS28XTlzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdR15d8xSAPnZnUJ4ULmKhcuxNmBmUSnJuWNUJfdzMCy5qJdzY
	nXFHEa0QtNTYbUkPlKI99ytAtmAAodnyvGg797qwGm1SvJHElgz+KXkyV+3rMkFQ4ZeN3c9tKUT
	/P4oIvR++wKw4OK2dgdkAfU13QjDNwJI=
X-Gm-Gg: ASbGncuKY3Ag95VMzlqIez9+M0Sho4nH/daF7U6oYSsWUR+V75xX+MnorDsIpRnlVC7
	/+S1Bbdjp7g/dxOuHKzO+vBJDAtHuR6+ccBFKajQ5JMwahy0qxHi0EZ+MwL+b7WYK144cHtDi0o
	/7fQ0tOOsCkbBIdCf2Tb+9Ye+M4qiwMMOUD9XrKmwJ4nodqXlhAm+brPWFWYBsDvdXZc8tLtqAg
	sJyPdLyHDfOn4GGbZsCSOLLPN6E4oUtCwGggsA+a7V9x+8psuz1TStj9Wk=
X-Google-Smtp-Source: AGHT+IGgLc96ZMr6l+/NUQL1N7IsFmNZTxHwZhGsXXdYttZwvnG2iOf3+nncQ6djkp1cF/5AZXtX8idEXUBgTmL2Y14=
X-Received: by 2002:a92:cda5:0:b0:42f:a6b7:922b with SMTP id
 e9e14a558f8ab-432103d8780mr67405685ab.7.1761696073792; Tue, 28 Oct 2025
 17:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-2-kerneljasonxing@gmail.com> <aPt_WLQXPDOcmd1M@horms.kernel.org>
 <CAL+tcoDnAv7+kG4WdAh1ELP0=bj_1og+DdD-JS4YuWzZC+9OhA@mail.gmail.com> <aQDW3HK6bx2LgfBY@horms.kernel.org>
In-Reply-To: <aQDW3HK6bx2LgfBY@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Oct 2025 08:00:37 +0800
X-Gm-Features: AWmQ_bnfQud7JTOfOAs9f495lJaHp_F0FO0O7ztnBuAzpwXum4nybDK_Fz258Do
Message-ID: <CAL+tcoC6AAB3Ag_LpNUp6_WLoNziK4Du0=wtPWN8hm_SbdRSaA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
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

On Tue, Oct 28, 2025 at 10:44=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sat, Oct 25, 2025 at 05:08:39PM +0800, Jason Xing wrote:
> > Hi Simon,
> >
> > On Fri, Oct 24, 2025 at 9:30=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > On Tue, Oct 21, 2025 at 09:12:01PM +0800, Jason Xing wrote:
> > >
> > > ...
> > >
> > > > index 7b0c68a70888..ace91800c447 100644
> > >
> > > ...
> > >
> > > > @@ -1544,6 +1546,55 @@ static int xsk_setsockopt(struct socket *soc=
k, int level, int optname,
> > > >               WRITE_ONCE(xs->max_tx_budget, budget);
> > > >               return 0;
> > > >       }
> > > > +     case XDP_GENERIC_XMIT_BATCH:
> > > > +     {
> > > > +             struct xsk_buff_pool *pool =3D xs->pool;
> > > > +             struct xsk_batch *batch =3D &xs->batch;
> > > > +             struct xdp_desc *descs;
> > > > +             struct sk_buff **skbs;
> > > > +             unsigned int size;
> > > > +             int ret =3D 0;
> > > > +
> > > > +             if (optlen !=3D sizeof(size))
> > > > +                     return -EINVAL;
> > > > +             if (copy_from_sockptr(&size, optval, sizeof(size)))
> > > > +                     return -EFAULT;
> > > > +             if (size =3D=3D batch->generic_xmit_batch)
> > > > +                     return 0;
> > > > +             if (size > xs->max_tx_budget || !pool)
> > > > +                     return -EACCES;
> > > > +
> > > > +             mutex_lock(&xs->mutex);
> > > > +             if (!size) {
> > > > +                     kfree(batch->skb_cache);
> > > > +                     kvfree(batch->desc_cache);
> > > > +                     batch->generic_xmit_batch =3D 0;
> > > > +                     goto out;
> > > > +             }
> > > > +
> > > > +             skbs =3D kmalloc(size * sizeof(struct sk_buff *), GFP=
_KERNEL);
> > > > +             if (!skbs) {
> > > > +                     ret =3D -ENOMEM;
> > > > +                     goto out;
> > > > +             }
> > > > +             descs =3D kvcalloc(size, sizeof(struct xdp_desc), GFP=
_KERNEL);
> > > > +             if (!descs) {
> > > > +                     kfree(skbs);
> > > > +                     ret =3D -ENOMEM;
> > > > +                     goto out;
> > > > +             }
> > > > +             if (batch->skb_cache)
> > > > +                     kfree(batch->skb_cache);
> > > > +             if (batch->desc_cache)
> > > > +                     kvfree(batch->desc_cache);
> > >
> > > Hi Jason,
> > >
> > > nit: kfree and kvfree are no-ops when passed NULL,
> > >      so the conditions above seem unnecessary.
> >
> > Yep, but the checkpatch complains. I thought it might be good to keep
> > it because normally we need to check the validation of the pointer
> > first and then free it. WDYT?
>
> I don't feel particularly strongly about this.
> But I would lean to wards removing the if() conditions
> because they are unnecessary: less is more.

I see. I will do it :)

Thanks,
Jason

