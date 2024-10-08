Return-Path: <bpf+bounces-41315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF06995BE0
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4269C1C213C5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9846216434;
	Tue,  8 Oct 2024 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEE5oSj5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBB1D0B8B;
	Tue,  8 Oct 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431356; cv=none; b=fsnTRncqZUvs0QxGRJDDYMUG83Eac+pjq6tkvd09d4QDIXXe/PvaKGtBzEPFcaX6LcrLJqJ0GhW+ulbtVJgS4clXwKcD9g18xH1X0z5OWBShcURsBikJ10fisbmU/eiDJBo+/5pCdLrPNyx8Nz7s9GEAEIeasZcONjzyYHY6NGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431356; c=relaxed/simple;
	bh=/u3ickRku3TjuRUcWBq6Oa/vobOnItvQ0Pex5HJRR10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t87tq1fIEavDNo6mNoolcWF0o7Ip8z+KRkIxR6P5t2bBUb5V3r1+C9A+SdugH/eF9goFfeXn7y3+MtevVtq9IbX1j5FZTOyPNI1g40O+SgjieHjsSY3XjHeECvhj+VQYyssnOzh0ahF944hQII9gpXLsnCeIpIU/+rLG2e0BGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEE5oSj5; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-831e62bfa98so257462739f.1;
        Tue, 08 Oct 2024 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728431354; x=1729036154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yoc4XK8A+MQ7oMet77oGKRReRfed4wSzRFfyL+Ci+0=;
        b=IEE5oSj5OigQ0Evu+9zmxhloMOjKdFRNWCMNKh9rf7NVvIsOnd0fZyJKlidIod9uLS
         CzrCHBtcxl3aaNpRjgT+YiXGgXiOzegfFNOvF5O+qEwNUCFukRYqrYUWpDe+8C+nWNGP
         PDBbqSaTIMw75y17jn+MVOp29VbPfrUv3twks9FuG9hQ5DBHIgCAwu8ISh57ScXB0UMz
         WNaCJ4Sau7FaiOy2ixFdfXE2JcLJhhL44DPkDxpxsHzKaQrK2eq7TFr5Xrb4NWtmoCV6
         iPScHcocaZAggkJ40I+NundA/77PEs3OJUUI8fKXKxycx6mxenziTLX2LvGxpOs72H7w
         x1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728431354; x=1729036154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yoc4XK8A+MQ7oMet77oGKRReRfed4wSzRFfyL+Ci+0=;
        b=dGPslts6ySSkLR6WITEMTRZKh+eZlijjuJM5wUzvLI9fPIBekUTKM2+cD+8hOBK/+t
         SC42GztUaA+HEkoLx6pc2VSp7O4CwyRbvMClLY16TyJy8rMsXRhsVrL6Fv7mrm7DHfy+
         TG8PGkrQ/yDoCRD9njabKJzdziMqY8/i66z+YQyECqChyI7EqiEOdjSqnQyxAgwQ635+
         w6Kh/ZS3fDWRBPNVlc24swHQq6++8CzBXCrE5/pj4Ow3ksOnA6fiHagXflvDYxTo99c2
         Psnw7f6u7IADwJlUaiauIZOkzvQKscRqQa3WrEHfIPUHfz/jHpPZZAcF81lufKop3ko4
         7hFA==
X-Forwarded-Encrypted: i=1; AJvYcCVIG9sikoboRPyRPmZfJOgqP9CCyKg66lGSRyk5fHlQ39+iEo/0vF5N3/a46OqgQTPHMyc=@vger.kernel.org, AJvYcCXeubnhulXmO3jOnSeVnWx9A8ukibxBQF4HkY3oghicHzbEllJlNmiVp1+fF5E9hZziW9jEGEHE@vger.kernel.org
X-Gm-Message-State: AOJu0YzKqChqpK0g6/tRBcxP0L4I6EU1sDo9NK6MS5XT84wx3nUbluSl
	7Y55A/DbHmZCYP2va8ObSaVKYL1gDYEgVVYRT8wKP05zj3xgWDXcLCAEjDi2Y43JXLEwEqnBPZf
	Pgnh5XO8UuvtVGYyo40ySV5vMt4g=
X-Google-Smtp-Source: AGHT+IHM+E/JYze3IhaRrPrII1VMkUwl3OuY0ANFTeYG+MbWObq+SBy8BHEpYyClocFSn26rqcc5Ew2iztTqHXU6ZXc=
X-Received: by 2002:a92:cd87:0:b0:3a0:9aff:5047 with SMTP id
 e9e14a558f8ab-3a397d17aeamr6141805ab.22.1728431353887; Tue, 08 Oct 2024
 16:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-6-kerneljasonxing@gmail.com> <b82d7025-188d-41dc-a70c-06aa0fb26d24@linux.dev>
In-Reply-To: <b82d7025-188d-41dc-a70c-06aa0fb26d24@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 07:48:37 +0800
Message-ID: <CAL+tcoAbYF2k88r84VW-3COU5W8dOQ2gFHBq3OiXig3Ze+reXg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] net-timestamp: ready to turn on the button
 to generate tx timestamps
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:18=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 08/10/2024 10:51, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Once we set BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG flag here, there
> > are three points in the previous patches where generating timestamps
> > works. Let us make the basic bpf mechanism for timestamping feature
> >   work finally.
> >
> > We can use like this as a simple example in bpf program:
> > __section("sockops")
> >
> > case BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB:
> >       dport =3D bpf_ntohl(skops->remote_port);
> >       sport =3D skops->local_port;
> >       skops->reply =3D SOF_TIMESTAMPING_TX_SCHED;
> >       bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB=
_FLAG);
> > case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> >       bpf_printk(...);
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/uapi/linux/bpf.h       |  8 ++++++++
> >   net/ipv4/tcp.c                 | 27 ++++++++++++++++++++++++++-
> >   tools/include/uapi/linux/bpf.h |  8 ++++++++
> >   3 files changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1b478ec18ac2..6bf3f2892776 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7034,6 +7034,14 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TX_TS_OPT_CB,      /* Called when the last skb from
> > +                                      * sendmsg is going to push when
> > +                                      * SO_TIMESTAMPING feature is on.
> > +                                      * Let user have a chance to swit=
ch
> > +                                      * on BPF_SOCK_OPS_TX_TIMESTAMPIN=
G_OPT_CB_FLAG
> > +                                      * flag for other three tx timest=
amp
> > +                                      * use.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 82cc4a5633ce..ddf4089779b5 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -477,12 +477,37 @@ void tcp_init_sock(struct sock *sk)
> >   }
> >   EXPORT_SYMBOL(tcp_init_sock);
> >
> > +static u32 bpf_tcp_tx_timestamp(struct sock *sk)
> > +{
> > +     u32 flags;
> > +
> > +     flags =3D tcp_call_bpf(sk, BPF_SOCK_OPS_TX_TS_OPT_CB, 0, NULL);
> > +     if (flags <=3D 0)
> > +             return 0;
> > +
> > +     if (flags & ~SOF_TIMESTAMPING_MASK)
> > +             return 0;
> > +
> > +     if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> > +             return 0;
> > +
> > +     return flags;
> > +}
> > +
> >   static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *s=
ockc)
> >   {
> >       struct sk_buff *skb =3D tcp_write_queue_tail(sk);
> >       u32 tsflags =3D sockc->tsflags;
> > +     u32 flags;
> > +
> > +     if (!skb)
> > +             return;
> > +
> > +     flags =3D bpf_tcp_tx_timestamp(sk);
> > +     if (flags)
> > +             tsflags =3D flags;
>
> In this case it's impossible to clear timestamping flags from bpf

It cannot be cleared only from the last skb until the next round of
recvmsg. Since the last skb is generated and bpf program is attached,
I would like to know why we need to clear the related fields in the
skb? Please note that I didn't hack the sk_tstflags in struct sock :)

> program, but it may be very useful. Consider providing flags from
> socket cookie to the program or maybe add an option to combine them?

Thanks for this idea. May I ask what the benefits are through adding
an option because the bpf test statement (BPF_SOCK_OPS_TEST_FLAG) is a
good option to take a whole control? Or could you provide more details
about how you expect to do so?

Thanks,
Jason

