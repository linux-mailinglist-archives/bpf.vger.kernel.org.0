Return-Path: <bpf+bounces-43483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF79B59F6
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 03:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C2C1F232DD
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2D192D79;
	Wed, 30 Oct 2024 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1V6TdD6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF538C;
	Wed, 30 Oct 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730255575; cv=none; b=YxzQuoVl+Ljn593dL/QhCmDvirYHqI2Xs+7Y3qV8eRUGL1wmAIwna7jIDX7GiLZAPvpuJv+28MmWYILeqhl65wxdOXBGMJPlVdBBIpVdkk4zAtt7jvIe5iV9584knxaN7oP2vC+AvDVMIUA4Nm5KXcKIjegbl46f2Aqd+lo9wn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730255575; c=relaxed/simple;
	bh=y3tGIjvpyrZAsRZwS3KHsqRmnNnKmCpa2zmfQD283I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8HomOo9kLREed2M7VBhuvV5RBey8KYWZp5MpCNw6HOalZ0rAN4y41IdShL1q1ek7atSCtKPmld+RiMwLE6ErY9dZAoQRO/YR8u1J7HF9IdZBQxR/Bo9rpqLXY5gFKMXo51AhsYhvg38XmyUY4O84Z5wTVFjRoZiI1D1O9m/I58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1V6TdD6; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e5f07c8fso17942215ab.0;
        Tue, 29 Oct 2024 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730255572; x=1730860372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf3/537v6CvS5WNnu+KBmHeOA1NOvNi0+XInTvxne4g=;
        b=R1V6TdD6p8xtagXCCTojwQeLf547KPcXaQmbPd4FevdWbIwrJX7794fg+K8yNplhl+
         pXBeVz6P5buwyIqhFVA5KEJiFjEeQpNpw22bL/KEU4O2L+Odr1/fnud0Q7asCvvX4b77
         T4gWMGBMeQ/3Tsc2Wtnpmf8WhIw1px7TiQDskpt+y9xm9VLF4j936Y4o45cFd56gEQfV
         pI3zADsm8akkroZAwKVMKsMONBWWkoqADA8IuyrgFBBGRx6Ap9zSh+AFuG4N7SHrex7/
         jm6xa72VfDLwh2Vx2Lp6fTqBiHbxe3C3IqYW7HqKoDatu0t6Jgo/Gh2w4u1u36jNm/Al
         6tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730255572; x=1730860372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf3/537v6CvS5WNnu+KBmHeOA1NOvNi0+XInTvxne4g=;
        b=ITOLgUdLlIwsy7OUF9WacpgYZ6G9aqRu17k2q/o1Bdy9iJMqrvNTBIIHB5mGuazcQB
         Nvh81bmK23H3x1wLIq8qcCwCyqjyzrIg9R7hDirdnHrp74oGoXUG/wGIOvk4vZWJaQyn
         CWiL++88c7mwqtawAbUlt6Q5z56sdQNdUqQL514EtV7GEc6edgzJFA9DGfZEg6Map4f3
         gjWJvMREY+ghihfxZH2jYgsCVfpo7/xYjpikPrdMWxppwP1N5P3BIEfs0HiSta48xXin
         04k0qZn1mezGfFlEezsIhuYJj92MsuNDAoURGejhfoyY6QzmuFquE/xtO6C0WQWwcVrI
         I6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkv490nHojg+rYxHGHph8iGmHNnOSN+1W88fvOsLmFwmRnPG0InFKsKHXUBqm+jjCTJxA=@vger.kernel.org, AJvYcCXyrKF1GCCCGfltVvUDDPIxaodBjIbRj2Ejs+Zf+Z0FdOp6Vlxw8fkhwImcrG7G0K9ILuTZNjyu@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZjSNf3kdjsdBsakeGlU/FF90o5HplXa+tPBLWhqOPqLiW8je
	9rcXp/2v5zT/xSgZCzA5YLcV1zTOckbkbJjZs9jE8UHgxGxGgJ2jPSvUCrfXNzjOJ77bCWUC9m3
	3+LeB6Zm0GtIFfeuph4U1BG7oQVk=
X-Google-Smtp-Source: AGHT+IHry4ur+IXmp3tTTNPgCgTWB29f1Qf/HHLbTDqoVO5LecQSXTulDqr79vBdXfDXaUiIK6hQlLnfItc/RFW26ok=
X-Received: by 2002:a05:6e02:b2b:b0:3a3:a5c5:3915 with SMTP id
 e9e14a558f8ab-3a4ed32f502mr135735075ab.16.1730255571871; Tue, 29 Oct 2024
 19:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com> <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com> <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
In-Reply-To: <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 10:32:15 +0800
Message-ID: <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:45=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 30, 2024 at 7:00=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 10/28/24 4:05 AM, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This patch has introduced a separate sk_tsflags_bpf for bpf
> > > > extension, which helps us let two feature work nearly at the
> > > > same time.
> > > >
> > > > Each feature will finally take effect on skb_shinfo(skb)->tx_flags,
> > > > say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
> > > > other types, so in __skb_tstamp_tx() we are unable to know which
> > > > feature is turned on, unless we check each feature's own socket
> > > > flag field.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >   include/net/sock.h |  1 +
> > > >   net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++++
> > > >   2 files changed, 40 insertions(+)
> > > >
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index 7464e9f9f47c..5384f1e49f5c 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -445,6 +445,7 @@ struct sock {
> > > >       u32                     sk_reserved_mem;
> > > >       int                     sk_forward_alloc;
> > > >       u32                     sk_tsflags;
> > > > +     u32                     sk_tsflags_bpf;
> > > >       __cacheline_group_end(sock_write_rxtx);
> > > >
> > > >       __cacheline_group_begin(sock_write_tx);
> > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > index 1cf8416f4123..39309f75e105 100644
> > > > --- a/net/core/skbuff.c
> > > > +++ b/net/core/skbuff.c
> > > > @@ -5539,6 +5539,32 @@ void skb_complete_tx_timestamp(struct sk_buf=
f *skb,
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> > > >
> > > > +/* This function is used to test if application SO_TIMESTAMPING fe=
ature
> > > > + * or bpf SO_TIMESTAMPING feature is loaded by checking its own so=
cket flags.
> > > > + */
> > > > +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int t=
stype)
> > > > +{
> > > > +     u32 testflag;
> > > > +
> > > > +     switch (tstype) {
> > > > +     case SCM_TSTAMP_SCHED:
> > > > +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> > > > +             break;
> > > > +     case SCM_TSTAMP_SND:
> > > > +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > > > +             break;
> > > > +     case SCM_TSTAMP_ACK:
> > > > +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> > > > +             break;
> > > > +     default:
> > > > +             return false;
> > > > +     }
> > > > +     if (tsflags & testflag)
> > > > +             return true;
> > > > +
> > > > +     return false;
> > > > +}
> > > > +
> > > >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > > >                                const struct sk_buff *ack_skb,
> > > >                                struct skb_shared_hwtstamps *hwtstam=
ps,
> > > > @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct sk_bu=
ff *orig_skb,
> > > >       u32 tsflags;
> > > >
> > > >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> > >
> > > I still don't get this part since v2. How does it work with cmsg only
> > > SOF_TIMESTAMPING_TX_*?
> > >
> > > I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not ret=
urn any tx
> > > time stamp after this patch.
> > >
> > > I am likely missing something
> > > or v2 concluded that this behavior change is acceptable?
> >
> > Sorry, I submitted this series accidentally removing one important
> > thing which is similar to what Vadim Fedorenko mentioned in the v1
> > [1]:
> > adding another member like sk_flags_bpf to handle the cmsg case.
> >
> > Willem, would it be acceptable to add another field in struct sock to
> > help us recognise the case where BPF and cmsg works parallelly?
> >
> > [1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf01363c3b2@l=
inux.dev/
>
> The current timestamp flags don't need a u32. Maybe just reserve a bit
> for this purpose?

Sure. Good suggestion.

But I think only using one bit to reflect whether the sk->sk_tsflags
is used by normal or cmsg features is not enough. The existing
implementation in tcp_sendmsg_locked() doesn't override the
sk->sk_tsflags even the normal and cmsg features enabled parallelly.
It only overrides sockc.tsflags in tcp_sendmsg_locked(). Based on
that, even if at some point users suddenly remove the cmsg use and
then the prior normal SO_TIMESTAMPING continues to work.

How about this, please see below:
For now, sk->sk_tsflags only uses 17 bits (see the last one
SOF_TIMESTAMPING_OPT_RX_FILTER). The cmsg feature only uses 4 flags
(see SOF_TIMESTAMPING_TX_RECORD_MASK in __sock_cmsg_send()). With that
said, we could reserve the highest four bits for cmsg use for the
moment. Four bits represents four points where we can record the
timestamp in the tx case.

Do you agree on this point?

Thanks,
Jason

