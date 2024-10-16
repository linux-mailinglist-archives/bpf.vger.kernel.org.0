Return-Path: <bpf+bounces-42139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC699FE52
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1459B2857AD
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7A139D1B;
	Wed, 16 Oct 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFzI6Ehy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9192C282FA;
	Wed, 16 Oct 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042383; cv=none; b=KoKqkJT0c2KY+nx4dQzYsedgLi/+wSGYPRwqHzDH4fO05VgITKvOIQI2OUMG5tOS2o6QzcGhnTZ4erRwdMg4dHnLjk977269/7BjRy6YIbkcFZ/ibmSkbm/3kd/Lx3EYc2N8Ntwevdo6Nleq7hE2SjitOfw8lWk+2EG4h4A3rf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042383; c=relaxed/simple;
	bh=W2fr1TX7LJcn49wdK3DYG8G6igZTU4tvJP0/zdUS5tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTqPaqYdIo1DFhAejscxMKE65YC28F8irI3QmZWuNs+FLSs0lEeY0dCcBWyM10d3G0DhiVP1G17ng3mhq6LPN6WqNKrj94oYIibcRDiM8gSmbAC/NFSlGWwIJ/OplzQJlgGURqRY5j3jgriW6eqcKiwdngA5GU3Zk5EK/A+KRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFzI6Ehy; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83a9be2c028so8578139f.1;
        Tue, 15 Oct 2024 18:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729042380; x=1729647180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MEH9a/BEJEuADBHmx+CFJFiDhMAjiDXMmJhVq7VmC8=;
        b=VFzI6EhyFDgcETWDG9/96zrnQZ1NKlQT5RTA2F5pSyVhmYX/5RDDAPe3K5byQy4eZP
         5KBQO1His2Zf0qHL6fIi8Wt4pFNBPsjeui75WndnKykXI7719bbQzOhDeev26FxItrrQ
         J4CnuDi7om2exhsM4hk429poPnsHNTb+D/NpLxgWsK/Eag+8RP91O4Re9ArVDQYsO5ri
         0w5ERjxvzfml2Nx5pLCOvezrcST3DYjoYlqErMrrNgZMHhCR3Q76k5AscwtyYJeA41gw
         P/P9zQpaMdJ8kES1bBYbEYNTO0AxmAuzFf2Rd6VoXWEkY36/VxSTOK2CWFhn29qQr7en
         ibtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729042380; x=1729647180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MEH9a/BEJEuADBHmx+CFJFiDhMAjiDXMmJhVq7VmC8=;
        b=qlN0rZuf/GJxIESs+Osztn5Xt6lcTI2iSnNhCobZ1HvSxcspY2fXCR5JM2MS1r7Bi+
         CJgAqgh/8SB4cqq0coHg+j0896Ekw/wxO0KJ9FVM5Dg3OPfCDxCEbxpzPJBF6+d57eSP
         LMBA3S85MwIcHiHFHxJ9Q5qyJ1b68WMF2RfXaZVnNZQ7NnhpEe01gsrk0s6CkIhfWjKL
         +xT/uZJff0Ttvs+nvX3X39C9HAo430S3s/6pu1ayZx10jnaNSXcbqZNBrPRfsb54ZwJ6
         KRp3Ta4WA6kWxWUTt1ATldCrzEFGhQefJECWdBmQ6tiyy7G10ttCRsmjX77O357u2ELH
         Ftzg==
X-Forwarded-Encrypted: i=1; AJvYcCUOXN04fj7CXuMAGuZ1XCydY5N+abN1ir28g91kNgrBocpjNlHyPa0OdZgbkqlSTzZe6CA=@vger.kernel.org, AJvYcCXl3w9n8ae9g/UZx34OvbaTEEqHowa6N56zDltKT5JemrkArvuWUR8arL+78avWGOq5k5PPT50s@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxl39GeNLAFa7cd2atYQOqRG7T8C86Lm7J5lv7KZzAmKP+ItV
	T9avU/L8NF3NL5s2dCWzrW/onTYX14UxaiGVSeLuDugROSiB2EBvjA0QDl3cVFmSk5tYlOV+wuy
	yhLSr/5erHKw0JkV+Zys3pI/STyc=
X-Google-Smtp-Source: AGHT+IHYTtt01duLfGER9wko86APcijK3gE0J/O5kVMTQbuhp2GbBP4xSKZnk3Ltw7CgOIG8pNWpxzJhDqeo1xuRld0=
X-Received: by 2002:a05:6e02:b28:b0:3a0:8f99:5e00 with SMTP id
 e9e14a558f8ab-3a3bcd962cbmr109894435ab.4.1729042380511; Tue, 15 Oct 2024
 18:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
In-Reply-To: <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 09:32:24 +0800
Message-ID: <CAL+tcoBXj=EO-sk-dS+dN-pCZf8OKeOZ4LXb9GZnja3EfOhXYg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 9:04=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Oct 16, 2024 at 8:10=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 10/11/24 9:06 PM, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Willem suggested that we use a static key to control. The advantage
> > > is that we will not affect the existing applications at all if we
> > > don't load BPF program.
> > >
> > > In this patch, except the static key, I also add one logic that is
> > > used to test if the socket has enabled its tsflags in order to
> > > support bpf logic to allow both cases to happen at the same time.
> > > Or else, the skb carring related timestamp flag doesn't know which
> > > way of printing is desirable.
> > >
> > > One thing important is this patch allows print from both applications
> > > and bpf program at the same time. Now we have three kinds of print:
> > > 1) only BPF program prints
> > > 2) only application program prints
> > > 3) both can print without side effect
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >   include/net/sock.h |  1 +
> > >   net/core/filter.c  |  3 +++
> > >   net/core/skbuff.c  | 38 ++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 42 insertions(+)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 66ecd78f1dfe..b7c51b95c92d 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(struct =
sock *sk, int dif)
> > >   void sock_def_readable(struct sock *sk);
> > >
> > >   int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
> > > +DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
> > >   void sock_set_timestamp(struct sock *sk, int optname, bool valbool)=
;
> > >   int sock_get_timestamping(struct so_timestamping *timestamping,
> > >                         sockptr_t optval, unsigned int optlen);
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 996426095bd9..08135f538c99 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get_sock=
et_uid_proto =3D {
> > >       .arg1_type      =3D ARG_PTR_TO_CTX,
> > >   };
> > >
> > > +DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
> > > +
> > >   static int bpf_sock_set_timestamping(struct sock *sk,
> > >                                    struct so_timestamping *timestampi=
ng)
> > >   {
> > > @@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struct soc=
k *sk,
> > >               return -EINVAL;
> > >
> > >       WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> > > +     static_branch_enable(&bpf_tstamp_control);
> >
> > Not sure when is a good time to do static_branch_disable().
>
> Thanks for the review.
>
> To be honest, I considered how to disable the static key. Like you
> said, I failed to find a good chance that I can accurately disable it.
>
> >
> > The bpf prog may be detached also. (IF) it ends up staying with the
> > cgroup/sockops interface, it should depend on the existing static key i=
n
> > cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.
>
> Are you suggesting that we need to remove the current static key? In
> the previous thread, the reason why Willem came up with this idea is,
> I think, to avoid affect the non-bpf timestamping feature.
>
> >
> > >
> > >       return 0;
> > >   }
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index f36eb9daa31a..d0f912f1ff7b 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_buff =
*skb,
> > >   }
> > >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> > >
> > > +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tst=
ype)
> >
> > sk is unused.
>
> Thanks for the careful check.
>
> >
> > > +{
> > > +     u32 testflag;
> > > +
> > > +     switch (tstype) {
> > > +     case SCM_TSTAMP_SCHED:
> >
> > Instead of doing this translation,
> > is it easier to directly store the bpf prog desired ts"type" (i.e. the
> > SCM_TSTAMP_*) in the sk->sk_tsflags_bpf?
> > or there is a specific need to keep the SOF_TIMESTAMPING_* value in
> > sk->sk_tsflags_bpf?
>
> We have to reuse SOF_TIMESTAMPING_* because there are more flags, say,
> SOF_TIMESTAMPING_OPT_ID, that we need to support.
>
> >
> > > +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> > > +             break;
> > > +     case SCM_TSTAMP_SND:
> > > +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > > +             break;
> > > +     case SCM_TSTAMP_ACK:
> > > +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> > > +             break;
> > > +     default:
> > > +             return false;
> > > +     }
> > > +     if (tsflags & testflag)
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > >                                const struct sk_buff *ack_skb,
> > >                                struct skb_shared_hwtstamps *hwtstamps=
,
> > > @@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk_buff=
 *orig_skb,
> > >       if (!skb_may_tx_timestamp(sk, tsonly))
> > >               return;
> > >
> > > +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> >
> > This is a new test. tsflags is the sk->sk_tsflags here if I read it cor=
rectly.
>
> This test will be used in bpf and non-bpf cases. Because of this, we
> can support BPF extension. In this function, if skb has tsflags but we
> don't know which approach the user expects, sk_tstamp_tx_flags() can
> help us.
>
> >
> > My understanding is the sendmsg can provide SOF_TIMESTAMPING_* for indi=
vidual
> > skb. Would it break?
>
> Oh, you're right. I didn't support cmsg mode...

I think I only need to test if it's in the bpf mode, or else let the
original way print the timestamp, which can solve the issue.

