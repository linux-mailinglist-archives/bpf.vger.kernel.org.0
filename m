Return-Path: <bpf+bounces-50530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E0A295DB
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825CF16824B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F861F8908;
	Wed,  5 Feb 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1QrQOmq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124351DF261;
	Wed,  5 Feb 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771761; cv=none; b=qFh9tmPRrn1NgoGj603dn/lH5SZQ4dnfBLgqe1tx/QyDSA0I8pMQi8Nfv/zskfR1WAiqfV+dSnc23TZgtg2zAGkZ/V7KHDoYqGaoTfQzwPx5pZR7J4gz3cz233DAUFMoo4wVj9vYWe0c6B+Mzr1JPR1iqhoFy76cPTnHw6AU/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771761; c=relaxed/simple;
	bh=4z+Di1r1J7zpgHoisQ4J5LX0FVp93ozyEBZen394zn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJmrcbjwz3kLjHG2KqXUCcYYMmFXMwTQkQ8jsvPhn7f442tsZci2hpfJ/3rvIlwZnic2TXIBJz8RRyd32bJrzq4c+6NHIloAJYeyV36v5altyfkXQ0D123DpXhTI0fCeA8skKTF0dxIVMDXay13tqsG7RF9pAcTvnQM/e9CgZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1QrQOmq; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so176425939f.2;
        Wed, 05 Feb 2025 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738771759; x=1739376559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5vnTWiNri/LpEFE5hI9oy1jcYaYo0TqCUzWHGmPdD0=;
        b=T1QrQOmq6kFGfJHxSBPaqPU8g+LgZ7O+mlFrRAjaSJxcueEGwO/nrNN/SN+ZqofNXR
         SrzzuEG9rixedSybnkXsJYgNL7AWKop7RzhnzNgeMt31my9oTMxXOuB422lMjRfO+Mmz
         KOreit4sY/wIkkEuL790jJB7WY0i61F/e0UDbjrs0db5RTQz6JQCalx3WFK01pjpNGqi
         gzw/ZqQ57Itme2f7padaFvD86vFrdB95AakRXJynzfPLvz0T9Jh/DozWq4ypS9meXQBe
         uCK0Pxx6VgbsDyuw2LFYYSD6e4n7Pe2sSm1lqIHO/N+ryKiUQJMBviNIy7eEI940Xszq
         9m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771759; x=1739376559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5vnTWiNri/LpEFE5hI9oy1jcYaYo0TqCUzWHGmPdD0=;
        b=lmbPfN+LKv8ajpIFh2YGa6mWRMwhwDeiwisZ68N8HlkLcV2jvdYsNwZlJ+l0rtNgYh
         JT3FXGHSfsg1PDH3LXeZy4skc9XSiYOiPOe4d7QcNcP/yqBfdhk6IjwheX+pAgrAGN4W
         9e+hRXlfgh/5wVgT7Y0hd5PHM6qXTt4GcVnFuyUeRRFmz4m5dirbBYwgdVCMHSOsLJQe
         EPHc2ewr/KJiSkXCgJ25TlEJPbPPjjhTScprNnrnTC235NrCinP8ovX8Z7XFDtG2ag1b
         7kJg0uevTXGQtss6ywG37LrGIdgSIXAy58v6YlAyy9sktfxk2Vrs4ZDGVODF5or2j0Qy
         GU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXEvkeislwCaICbNvggjoLDZlmfiTDkQ0f0ozPSIXUmPwU0YMspqzmzBqbIYatsg6M/75U=@vger.kernel.org, AJvYcCXheJhJ8gj6FqudnmxrTs6SBAYh0kWpVBrFkNudIIZFeqZNVq4cMNsYghLXakTugoeK9l26Ftht@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JCsXOR9D54+zEvvG7h+OY1LjJvFdmbhujloFwGqLvjHXRPvw
	0g/FXERGT8cYyNZZRlqa45piI7hEgGHBsMTYjsSg2v638ahQX/em2oXGtMS2eqqlmHKA0weIzhx
	xGaUF6tJ5hPiuZIaSkXoClcQMFQo=
X-Gm-Gg: ASbGncv5duGAhw4BtrnBdkuPJ1OAlA23DcOgp9cKlssaTJIYQOD/glaaQDvjebNnM4v
	x3LY3VPD5mK+YQo5+v6CpqMZiIGDKUlXcZDYfLTB2dydARXSzGi2m6Z+s8JgKL6MrbqR0Y64=
X-Google-Smtp-Source: AGHT+IGVuDArn/RnQZOx2EfnfhWx4/R35xX0Fy45rLlXaHdR96mD/DiTk0q0gKIGQJG5wm9VoiTvkTD4EJVTZGeazlU=
X-Received: by 2002:a05:6e02:214f:b0:3cf:f844:68eb with SMTP id
 e9e14a558f8ab-3d04f404763mr27484115ab.4.1738771759034; Wed, 05 Feb 2025
 08:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-13-kerneljasonxing@gmail.com> <67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 00:08:41 +0800
X-Gm-Features: AWEUYZnhENJIPw_6V2OAx7oPg15RiKxR_gtEY1wI748l-l_-ygExgK0sp0vhOfE
Message-ID: <CAL+tcoC6egv7dTqESYy8Z80OoacvjgxLvsTXukUZZDgbLxH8AA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:54=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Bpf prog calculates a couple of latency delta between each tx points
> > which SO_TIMESTAMPING feature has already implemented. It can be used
> > in the real world to diagnose the behaviour in the tx path.
> >
> > Also, check the safety issues by accessing a few bpf calls in
> > bpf_test_access_bpf_calls().
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>
> > +static bool bpf_test_delay(struct bpf_sock_ops *skops, const struct so=
ck *sk)
> > +{
> > +     struct bpf_sock_ops_kern *skops_kern;
> > +     u64 timestamp =3D bpf_ktime_get_ns();
> > +     struct skb_shared_info *shinfo;
> > +     struct delay_info dinfo =3D {0};
> > +     struct sk_tskey key =3D {0};
> > +     struct delay_info *val;
> > +     struct sk_buff *skb;
> > +     struct sk_stg *stg;
> > +     u64 prior_ts, delay;
> > +
> > +     if (bpf_test_access_bpf_calls(skops, sk))
> > +             return false;
> > +
> > +     skops_kern =3D bpf_cast_to_kern_ctx(skops);
> > +     skb =3D skops_kern->skb;
> > +     shinfo =3D bpf_core_cast(skb->head + skb->end, struct skb_shared_=
info);
> > +     key.tskey =3D shinfo->tskey;
> > +     if (!key.tskey)
> > +             return false;
> > +
> > +     key.cookie =3D bpf_get_socket_cookie(skops);
> > +     if (!key.cookie)
> > +             return false;
> > +
> > +     if (skops->op =3D=3D BPF_SOCK_OPS_TS_SND_CB) {
> > +             stg =3D bpf_sk_storage_get(&sk_stg_map, (void *)sk, 0, 0)=
;
> > +             if (!stg)
> > +                     return false;
> > +             dinfo.sendmsg_ns =3D stg->sendmsg_ns;
> > +             bpf_map_update_elem(&time_map, &key, &dinfo, BPF_ANY);
> > +             goto out;
> > +     }
> > +
> > +     val =3D bpf_map_lookup_elem(&time_map, &key);
> > +     if (!val)
> > +             return false;
> > +
> > +     switch (skops->op) {
> > +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> > +             delay =3D val->sched_delay =3D timestamp - val->sendmsg_n=
s;
> > +             break;
>
> For a test this is fine. But just a reminder that in general a packet
> may pass through multiple qdiscs. For instance with bonding or tunnel
> virtual devices in the egress path.

Right, I've seen this in production (two times qdisc timestamps
because of bonding).

>
> > +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
> > +             prior_ts =3D val->sched_delay + val->sendmsg_ns;
> > +             delay =3D val->sw_snd_delay =3D timestamp - prior_ts;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> > +             prior_ts =3D val->sw_snd_delay + val->sched_delay + val->=
sendmsg_ns;
> > +             delay =3D val->ack_delay =3D timestamp - prior_ts;
> > +             break;
>
> Similar to the above: fine for a test, but in practice be aware that
> packets may be resent, in which case an ACK might precede a repeat
> SCHED and SND. And erroneous or malicious peers may also just never
> send an ACK. So this can never be relied on in production settings,
> e.g., as the only signal to clear an entry from a map (as done in the
> branch below).

Agreed. In production, actually what we do is print all the timestamps
and let an agent parse them.

>
> > +     }
> > +
> > +     if (delay >=3D delay_tolerance_nsec)
> > +             return false;
> > +
> > +     /* Since it's the last one, remove from the map after latency che=
ck */
> > +     if (skops->op =3D=3D BPF_SOCK_OPS_TS_ACK_OPT_CB)
> > +             bpf_map_delete_elem(&time_map, &key);
> > +
> > +out:
> > +     return true;
> > +}
> > +

