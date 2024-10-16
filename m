Return-Path: <bpf+bounces-42137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4C99FE0D
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3CB1F2746F
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F113B787;
	Wed, 16 Oct 2024 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhKxjuw8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BC81ADA;
	Wed, 16 Oct 2024 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040732; cv=none; b=AZV8Q9pINwrZDqZ3lw6rluv+2gcPzd18h/ezAST5Ae5fLl7i2qMf1e3OfAdwIvLbwyq87Mw489St8OltlwZvlw3y5Tb5d8UFMdzvMV0RUDQb78CSP2jo3WO4U5fg5F3Pny+RECN3qAi9cP2H5g6J+n6mZF1sIrBCP7rWRS91ogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040732; c=relaxed/simple;
	bh=eDIaoW5/UHrC/LEY+e5NiVTHYMW6YO6COH6LjsBK+CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qd/gY936PWzXpT0izeDI0isr3i4Jr4k6n8ZxeXgC2qgkFuz6Q0xctFzUK5KocyQJ16+AgyrM2UBna5Q09A/wNZv7wDm/l+LsERwmdNXR79d6T7neiKJhnVerzqlukI4A/TIlvag4SJJ/OtzrE5P1+vLf1VEjpsuIkmqWKIHGpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhKxjuw8; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8323b555a6aso362132839f.3;
        Tue, 15 Oct 2024 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729040729; x=1729645529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os3ZMA/PUK15f8da5pZ16yEM6ZdOgPR/3Z2HqD4xyl8=;
        b=OhKxjuw8qGR121vRJlN+JvLmmUO+w4RJmiWpPCDQdJT9QrUjbls/oikBD0yBuW343y
         wOiYuki3N6K8y6KD0b3cOXSpxPuB/d6JNWk19nJbbfUGxw++MzRWZZgKzoh2v07caanK
         boeDwFaEDZc6YpEoIGPm9TioSSnv0o5eGJvorg+CaqSXq086Vakw5PHHa6JQNX0A9E6r
         xoBjNKPWNZvu8iQxg+Gip1VQ5+KHC0o1CngNCtW5ZK7c2gCRoi/oh8tJzpdkZ+RSaqgw
         UL+b2pt0NUWeqfRHrN6xVbRHVyjaD3nfiJ0/wKKquTIsWNCqxVVHFzfZUv5g99Ttl5Vu
         Ujtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040729; x=1729645529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os3ZMA/PUK15f8da5pZ16yEM6ZdOgPR/3Z2HqD4xyl8=;
        b=YO6GIotHWq4lo59QFkvoDAbeLrtL8fBnJHtdiPuO361C6ArwGbsl1LcblMTf9dju4t
         nJss/kxSeJSvW4+0iY9tkkr4JPMnRdHOjUCHAWfdzvP8yic2n/iesJzhAj+q4ksXZFld
         NuO6A+QRFVZvm9OoMXeFbwyh+2iqcV4YJQJvMegneT8lLEvPH00JwfZJO60VNG2yG5nP
         psFpmDJO50TPZV+xSfGTI7yO34r65gBOvH3uauFfR6cqC3AlW6zEEEuC2qE3Fk28MMfl
         P5CVlLdgAZzI2d18pGlAZE65ec5jqkMCssuVuuSYErtvuL6zi9j0WvPqFS5qo6DviwQZ
         gKBw==
X-Forwarded-Encrypted: i=1; AJvYcCX8BG5g95enMR7bJ68hAre/phIs/lOEJxvoXRcNe9R6g6XE/1lOodsP1UShtJ4BAPb4uPc=@vger.kernel.org, AJvYcCXx6x7DK5uvcEQW/1bzowNbabzcSrGR/6K50XMHY0L1NvY3x3sejyu76yeKWPrtnc0npRDRlx/K@vger.kernel.org
X-Gm-Message-State: AOJu0YwRADXU6zynXvaMImpMXD+EcIJM1Ub8PhptYCE8JASwaPe1YO/z
	1pQXKbA7Eycw+P4RnNGxzkej0xmmUvtBMhFFU7Svx1yKJdQqFRR2+V4AP1g8oMsoZd+PGVMBu0W
	V++i7GBxeM8XnhWTXrh3j9yknDaI=
X-Google-Smtp-Source: AGHT+IH75/ttXOXs3vFio8ELvA0idfrJoNDjbPNz3oLKLGpgmcZ1RdZ8A0e0iM5clLPbPYxsvHjrfrLO/YNFPuXDSFU=
X-Received: by 2002:a05:6e02:180e:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a3b5f86635mr136078155ab.7.1729040729563; Tue, 15 Oct 2024
 18:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
In-Reply-To: <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 09:04:53 +0800
Message-ID: <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 8:10=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/11/24 9:06 PM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Willem suggested that we use a static key to control. The advantage
> > is that we will not affect the existing applications at all if we
> > don't load BPF program.
> >
> > In this patch, except the static key, I also add one logic that is
> > used to test if the socket has enabled its tsflags in order to
> > support bpf logic to allow both cases to happen at the same time.
> > Or else, the skb carring related timestamp flag doesn't know which
> > way of printing is desirable.
> >
> > One thing important is this patch allows print from both applications
> > and bpf program at the same time. Now we have three kinds of print:
> > 1) only BPF program prints
> > 2) only application program prints
> > 3) both can print without side effect
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/net/sock.h |  1 +
> >   net/core/filter.c  |  3 +++
> >   net/core/skbuff.c  | 38 ++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 42 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 66ecd78f1dfe..b7c51b95c92d 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(struct so=
ck *sk, int dif)
> >   void sock_def_readable(struct sock *sk);
> >
> >   int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
> > +DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
> >   void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
> >   int sock_get_timestamping(struct so_timestamping *timestamping,
> >                         sockptr_t optval, unsigned int optlen);
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 996426095bd9..08135f538c99 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get_socket=
_uid_proto =3D {
> >       .arg1_type      =3D ARG_PTR_TO_CTX,
> >   };
> >
> > +DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
> > +
> >   static int bpf_sock_set_timestamping(struct sock *sk,
> >                                    struct so_timestamping *timestamping=
)
> >   {
> > @@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struct sock =
*sk,
> >               return -EINVAL;
> >
> >       WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> > +     static_branch_enable(&bpf_tstamp_control);
>
> Not sure when is a good time to do static_branch_disable().

Thanks for the review.

To be honest, I considered how to disable the static key. Like you
said, I failed to find a good chance that I can accurately disable it.

>
> The bpf prog may be detached also. (IF) it ends up staying with the
> cgroup/sockops interface, it should depend on the existing static key in
> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.

Are you suggesting that we need to remove the current static key? In
the previous thread, the reason why Willem came up with this idea is,
I think, to avoid affect the non-bpf timestamping feature.

>
> >
> >       return 0;
> >   }
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index f36eb9daa31a..d0f912f1ff7b 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_buff *s=
kb,
> >   }
> >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >
> > +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tstyp=
e)
>
> sk is unused.

Thanks for the careful check.

>
> > +{
> > +     u32 testflag;
> > +
> > +     switch (tstype) {
> > +     case SCM_TSTAMP_SCHED:
>
> Instead of doing this translation,
> is it easier to directly store the bpf prog desired ts"type" (i.e. the
> SCM_TSTAMP_*) in the sk->sk_tsflags_bpf?
> or there is a specific need to keep the SOF_TIMESTAMPING_* value in
> sk->sk_tsflags_bpf?

We have to reuse SOF_TIMESTAMPING_* because there are more flags, say,
SOF_TIMESTAMPING_OPT_ID, that we need to support.

>
> > +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> > +             break;
> > +     case SCM_TSTAMP_SND:
> > +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > +             break;
> > +     case SCM_TSTAMP_ACK:
> > +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> > +             break;
> > +     default:
> > +             return false;
> > +     }
> > +     if (tsflags & testflag)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> >                                const struct sk_buff *ack_skb,
> >                                struct skb_shared_hwtstamps *hwtstamps,
> > @@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk_buff *=
orig_skb,
> >       if (!skb_may_tx_timestamp(sk, tsonly))
> >               return;
> >
> > +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
>
> This is a new test. tsflags is the sk->sk_tsflags here if I read it corre=
ctly.

This test will be used in bpf and non-bpf cases. Because of this, we
can support BPF extension. In this function, if skb has tsflags but we
don't know which approach the user expects, sk_tstamp_tx_flags() can
help us.

>
> My understanding is the sendmsg can provide SOF_TIMESTAMPING_* for indivi=
dual
> skb. Would it break?

Oh, you're right. I didn't support cmsg mode...

> Is it the similar case on the skb tx_flags that Willem has
> mentioned in the patch 0's thread?

Yes, but am I supposed to add new a bpf tx_flags in the struct sk_buff?

Thanks,
Jason

