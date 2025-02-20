Return-Path: <bpf+bounces-52043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ACFA3D001
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 04:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5073A5476
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F771DE4D2;
	Thu, 20 Feb 2025 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKge7moJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9535958;
	Thu, 20 Feb 2025 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021375; cv=none; b=BdDlWAGCuAIpoxZhcsGtpblpkvaiGR3vq2Gtg63HoQPof/dTH1XVlkz/Kwl03B1Y2btCRukpvd3dqc7CRVU3DA5cW0PYdAjxh+0864rt9uETNwbyfkdNKkB4NfrC8lBMC+s+G+ZTIEde6CChebvz7UIgt9hI95+dUUJXaZaY4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021375; c=relaxed/simple;
	bh=LqjMOiy/ff2Sbq1m00+oXEGCLFal8dH/QhQqokcBRFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7RDvAJcup9tH8+56EM1dJn5ZAKZS4m+dsEXumc0UIfRTGi+Qk7ocQh99THK5LEnVdD4xRx5BK3JfgU2+rKPLeVc8dxlSDb/LGovVqBLWvYUNJpvtua3beHMq0Ji21OfIIAEwcFJVnXMO8q45dNNoRJw496bGTdB5WNy19LNE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKge7moJ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d2b3811513so4471725ab.1;
        Wed, 19 Feb 2025 19:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740021373; x=1740626173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ+9NLroRdqSnogSWpRmI9FM8BIDdEsyMNZjsjhAIuQ=;
        b=PKge7moJSWmPVLLqURxo1kpFWvm/LGHu/E8MIJySGkdbsRU6Dy3p4k/ghRmVhbpfWy
         TL552IHVQ6116Lh1j8pr4gjRipj+9BVq9mU+C+1JglR/Mmx287sgkDR6beCjapWdy5Im
         m1enoKvsjz96Ellj6xrDc+7sm3RJdqIxkNRLO6xtL8G/d72MzdfOcEkvpMW4aOeWj2+T
         qyaP0Nom2Q/m12sEECCLaB7aMIsJKdAEs7SFmk/vrRAKnAejam4JNC5pXbaeMutmJZH2
         Aapwti1JB++2ct3tFkQnYLdVYAOJcd6rtsaFt/31PQvx8t+h+nn5tO/29QkDnyupDV5U
         QERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740021373; x=1740626173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ+9NLroRdqSnogSWpRmI9FM8BIDdEsyMNZjsjhAIuQ=;
        b=pb3kYnauRt9+JdauomN8toLNUNDd3314JfBLTV6lk87Vji537LpAEWKHRbXK/dwrtY
         q+NdoDDeooSPMg2Y5q6Hj3n3+HyRGbl43Bngr7Yl+ucA/gprseCGkg8WHw2MasuV/gyC
         y+vs8VIYeJB0zGKxVhF9UR8NEVOXmytrWtdNRERn9B2D34B6J9tMYV0KDUXzmbIYk5RO
         LHSUaNCA1f0z566+j5ZKcQkvbMb2mtgDMHHzXeUaaw0Fk10PAB64LbpAJCNLO31bgypW
         kL2U0SHSM6uP8QKWQB+fizjG3jbY82ccQAt9BrB0xaOktyCmr32ZARjFOm3UJcDFGjNC
         MdUg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/N3c2HCZ0lOgvxKx3vbv+GzgMHDkgzNlKAZxat8U6+CVFjP7/QiqnLNDrj7p3p+P1yg=@vger.kernel.org, AJvYcCWnbcvUsD/eN3dSl/szAaxwlrje7NgYn2K+4HH8uyZvGt7I84e7WrKQP/4MhMtlIr6B1aTA3dXR@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYMC7IjDxBnehPuJUSjSLErs0ntL5CzzEUfAjQpCO4OTmB/2p
	E/l3VXucn/Fl1NeJmWCXx41ilfwsONY1rpPY2ZJvGM5novL2qNEi/1NIHDwdup0vZmVrLsqiOTX
	Rudn1s+H2lY7s6kJLGiuF4OZ7Jm4=
X-Gm-Gg: ASbGncsws6ytFWgJMjZeQeyyxgfWMKn7HSgdpXjgZzP4IVRFgDUFKKBe6i0bJvawj1o
	hOn5jagP6T5zYC7tuRLCQ+8sryvTJEgk41iyTQO10ittmw/7nAMYax/t8NEfo4N5X/T9p+fpX
X-Google-Smtp-Source: AGHT+IFab3VbgpmuxGbWBT/npABgNbH5SAqIQG+XUAZCWYI6fa0OCN2NqC47Snb7TRkLo2TXJCA9wSTmFjtkfGRw2Ao=
X-Received: by 2002:a05:6e02:12e8:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d2c01cbd32mr13805675ab.8.1740021373354; Wed, 19 Feb 2025
 19:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-11-kerneljasonxing@gmail.com> <67b699ab81a9_20efb029441@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b699ab81a9_20efb029441@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 11:15:36 +0800
X-Gm-Features: AWEUYZm-upRx47ha6YEJg3UMSjyYrhTnzeJcs8vy7p4Ml5_LTNv-WmGThzIhqCg
Message-ID: <CAL+tcoDqqt3QScTHAjWGownjc8-gcMCGq=rYqB9eu=rCwoCLiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:55=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > This patch introduces a new callback in tcp_tx_timestamp() to correlate
> > tcp_sendmsg timestamp with timestamps from other tx timestamping
> > callbacks (e.g., SND/SW/ACK).
> >
> > Without this patch, BPF program wouldn't know which timestamps belong
> > to which flow because of no socket lock protection. This new callback
> > is inserted in tcp_tx_timestamp() to address this issue because
> > tcp_tx_timestamp() still owns the same socket lock with
> > tcp_sendmsg_locked() in the meanwhile tcp_tx_timestamp() initializes
> > the timestamping related fields for the skb, especially tskey. The
> > tskey is the bridge to do the correlation.
> >
> > For TCP, BPF program hooks the beginning of tcp_sendmsg_locked() and
> > then stores the sendmsg timestamp at the bpf_sk_storage, correlating
> > this timestamp with its tskey that are later used in other sending
> > timestamping callbacks.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       | 5 +++++
> >  net/ipv4/tcp.c                 | 4 ++++
> >  tools/include/uapi/linux/bpf.h | 5 +++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 9355d617767f..86fca729fbd8 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7052,6 +7052,11 @@ enum {
> >                                        * when SK_BPF_CB_TX_TIMESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg sysc=
all
> > +                                      * is triggered. It's used to cor=
relate
> > +                                      * sendmsg timestamp with corresp=
onding
> > +                                      * tskey.
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 12b9c4f9c151..4b9739cd3bc5 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -492,6 +492,10 @@ static void tcp_tx_timestamp(struct sock *sk, stru=
ct sockcm_cookie *sockc)
> >               if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> >                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> >       }
> > +
> > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
> > +             bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB=
);
> >  }
> >
> >  static bool tcp_stream_is_readable(struct sock *sk, int target)
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index d3e2988b3b4c..2739ee0154a0 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7042,6 +7042,11 @@ enum {
> >                                        * when SK_BPF_CB_TX_TIMESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg sysc=
all
> > +                                      * is triggered. It's used to cor=
relate
> > +                                      * sendmsg timestamp with corresp=
onding
> > +                                      * tskey.
> > +                                      */
>
> Feel free to decline this late in the review process, but a bit more
> bikeshedding..
>
> Can we spell out TSTAMP instead of TS in these definitions? Within
> the context of this series it is self-explanatory, but when reading
> kernel code the meaning of a two letter acronym is not that clear.

Even though I feel reluctant to change across the whole series because
if so, I will adjust in many places. Of course, you're right about the
new name being clearer :)

>
> And instead of SND can we use SENDMSG or something like that?
> SND here confused me as the software timestamp is SCM_TSTAMP_SND.

I'm not sure about this. For TCP, it's not implemented in the
tcp_sendmsg_locked but tcp_tx_timestamp. Well, I have no strong
preference.

You can make the final call :)

Thanks,
Jason

>
> For instance:
>
>     BPF_SOCK_OPS_TSTAMP_SENDMSG_CB,
>     BPF_SOCK_OPS_TSTAMP_SCHED_CB,
>     BPF_SOCK_OPS_TSTAMP_SND_SW_CB,
>     BPF_SOCK_OPS_TSTAMP_SND_HW_CB,
>    (BPF_SOCK_OPS_TSTAMP_TX_COMPLETION_CB,)
>     BPF_SOCK_OPS_TSTAMP_ACK_CB,
>
> (not sure what the OPT in OPT_CB added).
>
>

