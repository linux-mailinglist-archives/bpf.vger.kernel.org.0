Return-Path: <bpf+bounces-43359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A69B3FBD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087AA1C21F74
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B069D31;
	Tue, 29 Oct 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVrOQjgT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D472D268;
	Tue, 29 Oct 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165439; cv=none; b=bwHq1yaUEuidT5U903wU3fSndPiJ3Efh/XVD/0dwf7Hu34SVQaPDdOb9MA4EhWpkNOeHqkzNeENGU0ulPPhT9ZdWYaLdyBdMFnbhY1HAjVpMN99aeHLDhWk/wjavSRCVIx6f4Dsyc1PGJQ6AApbmMOLI7lpGCoiccbEkzFGB/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165439; c=relaxed/simple;
	bh=zx/lLIimrjADakyt5z4cjr6YX/VRcrUQTqU0XNBJ8W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekg/bd/qqKRxWgeafxdRShelB2r1O4VVEij8fZuGcuV7DTYSmmE7hTsz/C8LL1CTkg6vI1gGKk0Tn9BqYOPqN64xRZLxb7eMYf7/OZbk3jHBBv6/q19mEung/yY0/Qio1YyOZA1Dj5XIVhMhgk7dJM7Of2V28RWXaoJhR4qqJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVrOQjgT; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3c00f2c75so18678595ab.2;
        Mon, 28 Oct 2024 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730165436; x=1730770236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuorJQOgYHb6wOtLSgpuOH01iDW0mm5P6mp4e7T09yk=;
        b=JVrOQjgTlB4JE7SuhkNzUAqrr7AGn86pohlvMK1/Fywz/bSk9Ato9j4Einx/lzYmZi
         WxbV3wFWT2+k8ir62aVbz+g4VVVX0LpjkqmgQIYggyYZe/l5IouL66OhImDYzzjMEspb
         3BNy+HvrTIeBuuuDy3Qw8sg5su8PGbbhj9rNANrANxqjhN+aemEIubRV1CJoqVMKxV7Y
         93YiqO2KGbgovg7ur6w/APE1tenPH43CKhB416OncKIJRSQkvK6G/l9jo32E0i+JfNxY
         e8PHbTAJ3UhqssDFVw7ET6sB7zoWq2C+WoxIq7BXiiBDbf/N7B1A/pjqD/2Aquj6lD0b
         BfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165436; x=1730770236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuorJQOgYHb6wOtLSgpuOH01iDW0mm5P6mp4e7T09yk=;
        b=t7KIPa80Nmed42fma36n1tMIy0QWdAAAGQwEL25TILD6jTCQHOe+wJaWcab0EZXBSk
         0tFNcyXVEqqJw80Fy5/Z7iAbd+Oe25bE57kFzjyLieDM8tpN4auEY8yy29rbWX4lNHUQ
         kmyZbLWWjr1P524yT9zObBn3djhIsFN3QKqT6yQJMeFHba3tFGnfUWo99UnYLwVWlgc1
         u3RyVs1DiFe3jYpzEsZOesGBodEou+27+VVl1CraNxabwENlWKgseZxp0JKcFLQVlbkL
         ACYNxYAYKOjnmE+sfSchlzATon/S8/Tr11cgCbeBAJHSXwSoUhGKeWJv/gAtPSCQVSpP
         qODA==
X-Forwarded-Encrypted: i=1; AJvYcCWnxGB6wjnyc2dvgOhyAZ9yQEq9XWFdq18flA5+YHQPFn42CO2MRE8+p/nDmMiwzzk1+IA=@vger.kernel.org, AJvYcCWumtwd+dCK7uJb619H/MbPUswpSVmC47vwd78MoIDPOWPEax7VA7bl8u0AYixvmxwnMFS+NmTv@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfGGy5SPnd37qTosvkz0ONCvrduLrEjV1qwgNX53Vu/Y53pzD
	FnDw2lQlyh+y9i3FrXkVd3uh1eD5uEqqjfOVX1b9+29aI11ivG3kTzpOo6oMqGHiC7Ox33+al8U
	Z4V9VPTM2zx7nMUSblhyMfbnpgLU=
X-Google-Smtp-Source: AGHT+IHrNciNr8wSOoQ9+7QV8tSmgWDc2es7IRxHkLNxv6s6eDa+PTW8cjutfSM0Hlh7RvVyGg9AOhsvraKaVxelfew=
X-Received: by 2002:a05:6e02:1523:b0:3a0:bc39:2d8c with SMTP id
 e9e14a558f8ab-3a4ed307092mr97724065ab.25.1730165436597; Mon, 28 Oct 2024
 18:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-5-kerneljasonxing@gmail.com> <67203418aa886_24dce62949@willemb.c.googlers.com.notmuch>
In-Reply-To: <67203418aa886_24dce62949@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 09:30:00 +0800
Message-ID: <CAL+tcoCtg7Yu3dAWMM4EY4ARE-Lg33CKEoVned6G9MnA0QuVUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/14] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:02=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
> > print timestamps when the skb just passes the dev layer.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  net/core/skbuff.c              | 31 ++++++++++++++++++++++++++++++-
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index e8241b320c6d..324e9e40969c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7013,6 +7013,11 @@ enum {
> >                                        * by the kernel or the
> >                                        * earlier bpf-progs.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing thr=
ough
> > +                                      * dev layer when SO_TIMESTAMPING
> > +                                      * feature is on. It indicates th=
e
> > +                                      * recorded timestamp.
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 39309f75e105..e6a5c883bdc6 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -64,6 +64,7 @@
> >  #include <linux/mpls.h>
> >  #include <linux/kcov.h>
> >  #include <linux/iov_iter.h>
> > +#include <linux/bpf-cgroup.h>
> >
> >  #include <net/protocol.h>
> >  #include <net/dst.h>
> > @@ -5621,13 +5622,41 @@ static void skb_tstamp_tx_output(struct sk_buff=
 *orig_skb,
> >       __skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
> >  }
> >
> > +static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32=
 *args)
> > +{
> > +     struct bpf_sock_ops_kern sock_ops;
> > +
> > +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > +     if (sk_fullsock(sk)) {
> > +             sock_ops.is_fullsock =3D 1;
> > +             sock_owned_by_me(sk);
>
> Why this check?

I imitated the use of BPF_CGROUP_RUN_PROG_SOCK_OPS.

>
> This will usually be false, as timestamps are taken outside the
> protocol layers.

I will remove this if branch.

Thanks,
Jason

