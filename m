Return-Path: <bpf+bounces-41944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A684D99DC0E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99AE1C21837
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0630166F34;
	Tue, 15 Oct 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngDopwPe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250415B12A;
	Tue, 15 Oct 2024 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957989; cv=none; b=jFSXY4gTLfKtsJBEjw+bl7MNi7KfPt4svoU9kNwSdLVE0PozHo0U8E3eiLmN0HXd8/2sa0EJQBnt/F3MPTgHKlk9FF+f7yA5q9wUte7CoZ3UuGMYIMLLgE1fE5KRiaq2Lb3t3+cNXqNleAnILZltsSgbktD1ow2LIrFMuIIWpiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957989; c=relaxed/simple;
	bh=bpw+UaNi9oSJGBlaYKuc9Tp+SCHi+DTDy0Ntlq1akZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI3RpgUNWTZs4MxfqgDOp0kuqZ7Ng7YFsDorNaCNk90LnCTpTV8TyaHf3zDt5p9DVw0KU/RW91Fgv2m9ubvlqh1tqaIN7jYbLcGl0zhHYoOghmc58lXXnJfrT9Vk2aOO0/NS46eCQkrnz+D/nfhwuzjfKroLnO2Dv0V1q6qo6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngDopwPe; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8354599fd8aso192074239f.1;
        Mon, 14 Oct 2024 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728957985; x=1729562785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCaHc14mR6fjMmxbuVI284nP6+7/mEKhTdEF4u3miyo=;
        b=ngDopwPeapWFZ82wkn1wwL6MRMUeIlYokjd3iq8KWFsL598cW3g0u+9TQt5SvJBuzq
         ck8Ke8SXj21ukUygKA5yUScHs6q6XvZ4O7LBXugGy34CXnS7079D1NMODqn1vybE0WyU
         bntmlCGOyjbpnlrC8bnzdgWUDHEwF6bxegC4AiHKET+6azu8fZisktG7keqLrFeQ/+nA
         NHjNC61OuVtxVhTfEP2F5v/mGh0cuf7e+fgHyup1WNbuhNqbmZ+A5UsPiSt2cCeNBmd8
         2s2qelmqv6SDYOB+1XXMP1XXZYjksPEmUoNYmRMDNB+7JT1j0HggBizK9FCKVheY0gwj
         ri/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728957985; x=1729562785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCaHc14mR6fjMmxbuVI284nP6+7/mEKhTdEF4u3miyo=;
        b=brziFThlw4PwIDQYGlTL374l1CEkOqyw4mxziafv3kfCQMONWrZAzDO7Et8yXr6YIB
         7CMANMH0fuPS+CCqLMlkSwT6OumSeDbZuvHsGGgptl2F8PZjwjcB3zWU+Ab7gD2XMLtD
         dLzhBAdyW9on9OCIl9fN4X+yKL0LtKh8cUVrgN06ExYkaHHrKOwvQ7wytxMQY0qYrw4c
         1iDsNKfxoXjVMmGqQnwntADf5zval09yobQJlvMefJ1rZd0OlkcL6ygYyvz+P/HooYx0
         VH3F6HZIfk8JvY1FCjI1I6NYj76vmmC2a1cQULiUNdfgbzZPhlea7sEmG0NEXln2+6Rn
         nWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG6Cq+WdAyDFtNcgQH6bO+7J0viudLRv6rG4j33MzI8WKQ8L29EhnpfSvwdpE/6PXbDL60lLWc@vger.kernel.org, AJvYcCXEc4kS741yR2vvfbUIETd202jwKxHmFyAHX9K4Z6xOy0Zr7+fyB6wl18vNG3Gzfcqc7gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTEx8SIJO5E3c7Hxy1oD0DxNFXfwba/eWy0TLM3IKOIaKgpCJ
	e9/RryVXWkokuPrdA9vfL/WabZ8Y1BfV4F76MrlQ/yrDKkL42FHl3Zlr+4SvpDnALwXQPd/A4Ew
	EbwuOm1X9wdyNrWbJq1yZktZ57KM=
X-Google-Smtp-Source: AGHT+IHkV89IMqI2etSzRDXLOf8eCzNumMqEgahvITZyCdfTJ89BhF4l2fbxdw3nbFjcRC+ItKfg6yAUkUqMu0Xivhs=
X-Received: by 2002:a05:6e02:1ca7:b0:3a2:5b:7065 with SMTP id
 e9e14a558f8ab-3a3b5fb2f71mr97008455ab.18.1728957984700; Mon, 14 Oct 2024
 19:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com> <670dc6b7a1cea_2e174229441@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dc6b7a1cea_2e174229441@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 10:05:48 +0800
Message-ID: <CAL+tcoBthsjnr7PCc8TgMxCXO5xOQmLLJ6-ujLGNAu4nSQDeGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for bpf_setsockopt
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

On Tue, Oct 15, 2024 at 9:34=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For now, we support bpf_setsockopt only TX timestamps flags. Users
> > can use something like this in bpf program to turn on the feature:
> >
> > flags =3D SOF_TIMESTAMPING_TX_SCHED;
> > bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags=
));
> >
> > Later, I will support each Tx flags one by one based on this.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/sock.h |  2 ++
> >  net/core/filter.c  | 27 +++++++++++++++++++++++++++
> >  net/core/sock.c    | 35 ++++++++++++++++++++++++-----------
> >  3 files changed, 53 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8cf278c957b3..66ecd78f1dfe 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2890,6 +2890,8 @@ void sock_def_readable(struct sock *sk);
> >
> >  int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
> >  void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
> > +int sock_get_timestamping(struct so_timestamping *timestamping,
> > +                       sockptr_t optval, unsigned int optlen);
> >  int sock_set_timestamping(struct sock *sk, int optname,
> >                         struct so_timestamping timestamping);
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bd0d08bf76bb..996426095bd9 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5204,10 +5204,30 @@ static const struct bpf_func_proto bpf_get_sock=
et_uid_proto =3D {
> >       .arg1_type      =3D ARG_PTR_TO_CTX,
> >  };
> >
> > +static int bpf_sock_set_timestamping(struct sock *sk,
> > +                                  struct so_timestamping *timestamping=
)
> > +{
> > +     u32 flags =3D timestamping->flags;
> > +
> > +     if (flags & ~SOF_TIMESTAMPING_MASK)
> > +             return -EINVAL;
> > +
> > +     if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SO=
FTWARE |
> > +           SOF_TIMESTAMPING_TX_ACK)))
> > +             return -EINVAL;
> > +
> > +     WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
> > +
> > +     return 0;
> > +}
> > +
> >  static int sol_socket_sockopt(struct sock *sk, int optname,
> >                             char *optval, int *optlen,
> >                             bool getopt)
> >  {
> > +     struct so_timestamping ts;
> > +     int ret =3D 0;
> > +
> >       switch (optname) {
> >       case SO_REUSEADDR:
> >       case SO_SNDBUF:
> > @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock *sk, i=
nt optname,
> >               break;
> >       case SO_BINDTODEVICE:
> >               break;
> > +     case SO_TIMESTAMPING_NEW:
> > +     case SO_TIMESTAMPING_OLD:
> > +             ret =3D sock_get_timestamping(&ts, KERNEL_SOCKPTR(optval)=
,
> > +                                         *optlen);
> > +             if (!ret)
> > +                     ret =3D bpf_sock_set_timestamping(sk, &ts);
> > +             return ret;
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 52c8c5a5ba27..a6e0d51a5f72 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -894,6 +894,27 @@ static int sock_timestamping_bind_phc(struct sock =
*sk, int phc_index)
> >       return 0;
> >  }
> >
> > +int sock_get_timestamping(struct so_timestamping *timestamping,
> > +                       sockptr_t optval, unsigned int optlen)
> > +{
> > +     int val;
> > +
> > +     if (copy_from_sockptr(&val, optval, sizeof(val)))
> > +             return -EFAULT;
>
> Ideally don't read this again.
>
> If you do, then move it in the else clause.

Thanks, I will do that.

