Return-Path: <bpf+bounces-41945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27199DC26
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA30628352B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319051662F4;
	Tue, 15 Oct 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvxw5NSK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A921364;
	Tue, 15 Oct 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958741; cv=none; b=rS2aOxI0Jcn8jGz0Vv4LMToen9phAfCay+wXUf+YQ+4xriRWAOWfZgAsbm8nwHhNsTJO5jcz7RY/CZk2I8PMQVGtniBbDWdZ7v3aIcYewIKwBqbFc8U7UuHNniJPLOiFk7SbRPDygyv/lLpiTQZeweVvVwEY7gZJAmHM/6wXqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958741; c=relaxed/simple;
	bh=Sk0192uJKEOGLQytSitcWLuiVRc8kIa+NEBGlqaFRbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaJDAtRNLAKjbOmMhBLIz6Fh9gl1L5j7CakIoIO5q3HTCSLvwjbie5iTLFMNNDwKb5Wsf9IHqPI5w5LWWMxAku6crO+s1NlrVbfJIHjWTL2VaPxJHkMoEjoPrGe2c5AKputyAaKHvspdYraqVJU/k3INdf2KdWzRzj10b247gMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvxw5NSK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b6b281d4so20060695ab.0;
        Mon, 14 Oct 2024 19:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728958739; x=1729563539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C3dkzkz2aFTjs3uyg9BRcPJO9JP2kh6wpuUteFpL+w=;
        b=jvxw5NSKP8C9p6sHX5H4malFYnUOdSMz0XnMYKmmoJV0HONk6ctGqRgCFc6nlAtPVO
         wlxUCSegpv+5+3GQ4YYO/CZFPy0m1L/TfT178czXkUFTlLqTQ1EJd3iR1sXr4xFLvXja
         tegNvp6k9EH+RBiSCFYM9VWouHuXn9MP4Z+UhoaWxI1O3CsW0w5vEFes+0rqBKXJoIu2
         Rluj1w5RE7R+uQoxwqqoQ5bd+I3QILyCxxj1zURxiKWLS5B1nHWeeg+j32nMfapFZDtX
         DSreXVuSXH3MjcIUn+UZ6RCLh1Ip7p5U/gghNV44rCQ7XhpSJQI6HDwR2fodlUMVsCVD
         jXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728958739; x=1729563539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C3dkzkz2aFTjs3uyg9BRcPJO9JP2kh6wpuUteFpL+w=;
        b=XbdgXadKFZqBaRQEe/23/kS5EnVN0sHSNCNHNXUZHr1iaVxntYhhUQKfcrli4Jg8hp
         JWZLfF255C30b9wmGiD1o2H1TYNZ7TzovCsADnzaokD4yVuu515IesQo4y4HzFerriUe
         TIKGToXdzfoDFlaCjYsVyJbe8vVfH77so/vbqMMrHDXuOIZ0X4WnC6E1BzRwDn4+C6ye
         DJ1t5mnjfRUoM+2XPY+bgRDc9erRQXKMBbS9jTVdFrPS0DFBCrnos8Vd2TySkgsMMQfa
         +ApquKED4Co6r5glWHFAkBxHDIAxypaeZNp69HoSPRLIyRcoBioNA0VxOdDjSj5zBLrd
         XF8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0ua6Rjgu30cyXHNxHry9rPuQjE7wQc984JhCZj+pi/5g4wnCBRxHz1qe/fUneqCxwtnw=@vger.kernel.org, AJvYcCVn0j7kJ6gdDYvzsAuIJHypqWEvYDnjEX8gyPdyFI9HlDfxQwRTNU0dh690rR70KugaCYSDo/ir@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHkAtK8YGbWVIhDGcbrTSoTMkMLCYXJm7H4grqoFeGcqWMgra
	MT5KEXaC2YCVM1YIbnB5OBoYT1fNR1Wae1H4QmOtraF+pCyMsoRrtCvCI8Y3PJliDETGPqD19Np
	axUH4IZXNVgAB+2WkoUdAiXwVf2w=
X-Google-Smtp-Source: AGHT+IG10V4BBG8By7/w0QtE95MLvaD9s9mfSGXoxt9uC7jIaDWwNnrbW4zV4ejS4VLf9iAWLGpNFYgyAsDliyuVHg0=
X-Received: by 2002:a05:6e02:1809:b0:3a0:8d60:8ba4 with SMTP id
 e9e14a558f8ab-3a3b603df81mr107543885ab.16.1728958739158; Mon, 14 Oct 2024
 19:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-12-kerneljasonxing@gmail.com> <670dc8f1c9e3d_2e1742294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dc8f1c9e3d_2e1742294ad@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 10:18:22 +0800
Message-ID: <CAL+tcoAVeo5XCwcO6SDywU-2_c-dRRNo8U5no4nhNnQ6n4PTUA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net-timestamp: add bpf framework for rx timestamps
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 9:44=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Prepare for later changes in this series. Here I use u32 for
> > bpf_sock_ops_cb_flags for better extension and introduce a new
> > rx bpf flag to control separately.
> >
> > Main change is let userside set through bpf_setsockopt() for
> > SO_TIMESTAMPING feature.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/linux/tcp.h            |  2 +-
> >  include/net/tcp.h              |  2 +-
> >  include/uapi/linux/bpf.h       |  5 ++++-
> >  net/core/filter.c              |  6 +++++-
> >  net/ipv4/tcp.c                 | 13 ++++++++++++-
> >  tools/include/uapi/linux/bpf.h |  5 ++++-
> >  6 files changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index 6a5e08b937b3..e21fd3035962 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -446,7 +446,7 @@ struct tcp_sock {
> >
> >  /* Sock_ops bpf program related variables */
> >  #ifdef CONFIG_BPF
> > -     u8      bpf_sock_ops_cb_flags;  /* Control calling BPF programs
> > +     u32     bpf_sock_ops_cb_flags;  /* Control calling BPF programs
> >                                        * values defined in uapi/linux/t=
cp.h
> >                                        */
> >       u8      bpf_chg_cc_inprogress:1; /* In the middle of
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 739a9fb83d0c..728db7107074 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -423,7 +423,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val);
> >  int tcp_set_window_clamp(struct sock *sk, int val);
> >  void tcp_update_recv_tstamps(struct sk_buff *skb,
> >                            struct scm_timestamping_internal *tss);
> > -void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
> > +void tcp_recv_timestamp(struct msghdr *msg, struct sock *sk,
> >                       struct scm_timestamping_internal *tss);
> >  void tcp_data_ready(struct sock *sk);
> >  #ifdef CONFIG_MMU
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1b478ec18ac2..d2754f155cf7 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6903,8 +6903,11 @@ enum {
> >       /* Call bpf when the kernel is generating tx timestamps.
> >        */
> >       BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG =3D (1<<7),
> > +     /* Call bpf when the kernel is generating rx timestamps.
> > +      */
> > +     BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG =3D (1<<8),
> >  /* Mask of all currently supported cb flags */
> > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
> > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x1FF,
> >  };
> >
> >  /* List of known BPF sock_ops operators.
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 3b4afaa273d9..36b357b76f4a 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5216,14 +5216,18 @@ static int bpf_sock_set_timestamping(struct soc=
k *sk,
> >               return -EINVAL;
> >
> >       if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SO=
FTWARE |
> > -           SOF_TIMESTAMPING_TX_ACK)))
> > +           SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_RX_SOFTWARE)))
> >               return -EINVAL;
> >
> >       ret =3D sock_set_tskey(sk, flags, BPFPROG_TS_REQUESTOR);
> >       if (ret)
> >               return ret;
> >
> > +     if (flags & SOF_TIMESTAMPING_RX_SOFTWARE)
> > +             sock_enable_timestamp(sk, SOCK_TIMESTAMPING_RX_SOFTWARE);
> > +
> >       WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> > +
> >       static_branch_enable(&bpf_tstamp_control);
> >
> >       return 0;
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index d37e231b2737..0891b41bc745 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2260,14 +2260,25 @@ static int tcp_zerocopy_receive(struct sock *sk=
,
> >  }
> >  #endif
> >
> > +static void tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timesta=
mping_internal *tss)
> > +{
> > +     struct tcp_sock *tp =3D tcp_sk(sk);
> > +
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_C=
B_FLAG))
> > +             return;
> > +}
> > +
> >  /* Similar to __sock_recv_timestamp, but does not require an skb */
> > -void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
> > +void tcp_recv_timestamp(struct msghdr *msg, struct sock *sk,
> >                       struct scm_timestamping_internal *tss)
> >  {
> >       int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> >       u32 tsflags =3D READ_ONCE(sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR])=
;
> >       bool has_timestamping =3D false;
> >
> > +     if (static_branch_unlikely(&bpf_tstamp_control))
> > +             tcp_bpf_recv_timestamp(sk, tss);
> > +
> >       if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> >               if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> >                       if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>
> tcp_recv_timestamp is called from tcp_recvmsg only conditionally:
>
>         if ((cmsg_flags || msg->msg_get_inq) && ret >=3D 0) {
>                 if (cmsg_flags & TCP_CMSG_TS)
>                         tcp_recv_timestamp(msg, sk, &tss);
>
> How do you get this triggered for your BPF program?

When users use BPF SO_TIMESTAMPING to print rx timestamp, it will use
bpf_setsockopt() to call sock_enable_timestamp() (see this patch), so
the skb will carry a timestamp. In tcp_recvmsg_locked(), cmsg_flags
will be initialized, so tcp_recv_timestamp() will get called.

>
> And also check the other caller, tcp_zc_finalize_rx_tstamp.

Got it, thanks for pointing it out.

