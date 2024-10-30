Return-Path: <bpf+bounces-43464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39B9B58FD
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5A11C22683
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C0184A3E;
	Wed, 30 Oct 2024 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE3PHcyX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE274437;
	Wed, 30 Oct 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250948; cv=none; b=sG/Uq/+WDPJ4dGo6dcfm0H+jFA5plTMjOtLTJBgtVR5kld5vnPYLwZoOQ9u5d2aI/wUsdJz/IGGLfm+09jzQhfmp7DA6q10jmE1yfQ1q05J38KEJkrY6TL//TJ0r+aF79tBxp4EdAwo2iaz44EWfQ/nOTRKoorJW9C11Z5Wq0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250948; c=relaxed/simple;
	bh=QgqUgcYGZkRlhU2FqTS9P781gKUtznP6nM1UW6ypGYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmSj+7D9BEtCb3eRIGtQxwlHnefIYRk+46fx7JxElpSmUwK28c90rMVJD32UDBxbeOdq/AzUg4sIq2Ban2Tp0t30lMHcEt5N5L6FcTIJpwXCMu5tDrSqlfSA6hHW/wUhcfstabC3m+Kyyx780dbryKCht3V9rmgxDFeu/RDVk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE3PHcyX; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83abcfb9fd4so228057139f.3;
        Tue, 29 Oct 2024 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730250945; x=1730855745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCe5NnDJ75DgpaC8JAhWP+T7vuUeHDxLd+JD+seGgm0=;
        b=bE3PHcyXk6P51/yigGp+e8r5EqQL/Cuv6x4x9U8JuPeF+TeALydGFAdSCWWqPqbSiE
         WjEnje+mrC3vCPyTTpzVnr1lp97HcvyvtgyeT74o6j1Iv9+Ter9g0ehfIqZ+2jz4ufH+
         eviDjEO7YmDcn4fkyR3YygvZwY5mU1iWDbQm/Rc1I8DHN3CMlsoiT+s6Agb0MvUQwSg5
         Iv4sGAkoRKYHNTA3pEmlW69L2I1veJIjsGhCIl1l9v3SjHE/EqNOKxm9rDPs7JV7FfdK
         DninrjC7TbfhG2Pd2mefQ1zDRgU/cGWv8LiKu35ogaSamN+R/IXZM2fTR1MfmALRWpX0
         rb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730250945; x=1730855745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCe5NnDJ75DgpaC8JAhWP+T7vuUeHDxLd+JD+seGgm0=;
        b=n0oBbLIjvlmE/u1ciZ/ORYtj2vL7bnUsSEHqUo1X/3NNSJh1V2fdOC9tMqctlcVL+e
         +B7gzXHU+3OxegoSAPwoTmlBNxc4yLW7QErnd17mPO+/UB6h4+7yrxHKhswi22S2eJ70
         Ry4ikLwwlPpeolk6u3fs/KMUhsI2cTgLBjy5Z2qWG3X8h6jp9XHEds2PEew+5rUiAQeJ
         wGXx2YkMAvPc8fvWy0t53U3BwJg9V/ey8H1dE+BDjuCziP/5vnuoAB9LOt0W+plbxuT2
         wWTQLO29QgkBv7O6FmvACXmbHytBV0bZd9BwgoSt+S3rXDp65PszC5t6rOJ+OtUBcyBx
         3xEg==
X-Forwarded-Encrypted: i=1; AJvYcCUnJwWf2dT2iqHOhGg5CLwPuDu5t78T6u9i4ddFGiIs229wokaboNVSqYU+Bd7hN3KEvl4=@vger.kernel.org, AJvYcCVn6sutYe+VSunsc6QMWVPzNBZCXft/EvpR0z7xYKGL6r84MUHUb1gdyZjhiEX+dSa/7yHJEfWH@vger.kernel.org
X-Gm-Message-State: AOJu0YzpH84dx9+ML3/J+AHOYrwM0jP7X9hRPk6XCD58yI+VvWG9TG/L
	Er7NQmTrFuGQTVHo1CoNdHRnyIpOMwfaJJxNgx4KyBVSfKId4gb22M/ITbbWBFC9iwoWjtfn/vu
	KpJd8GNfEcss9JynEB1c2/hpm4ws=
X-Google-Smtp-Source: AGHT+IFBD8rLgrxMvNJWCt1fxUXDc7WY9UbezqG6oe+8o7KRD8aPRbO8QyKV+sdvWm+z4WhaT+9adI7LvGg0kRtxI0Y=
X-Received: by 2002:a92:c544:0:b0:3a4:e62b:4e20 with SMTP id
 e9e14a558f8ab-3a4ed2e1ce8mr118376795ab.9.1730250944753; Tue, 29 Oct 2024
 18:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-4-kerneljasonxing@gmail.com> <9a821495-cac7-48d8-a2bc-1bd7ebeef23c@linux.dev>
In-Reply-To: <9a821495-cac7-48d8-a2bc-1bd7ebeef23c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 09:15:08 +0800
Message-ID: <CAL+tcoC41NwjMmjzHz+76-sLbBVRzEzECwFArSe3FFidMcmB=A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/14] net-timestamp: open gate for bpf_setsockopt/_getsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:32=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/28/24 4:05 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For now, we support bpf_setsockopt to set or clear timestamps flags.
> >
> > Users can use something like this in bpf program to turn on the feature=
:
> > flags =3D SOF_TIMESTAMPING_TX_SCHED;
> > bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags=
));
> > The specific use cases can be seen in the bpf selftest in this series.
> >
> > Later, I will support each flags one by one based on this.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/net/sock.h              |  4 ++--
> >   include/uapi/linux/net_tstamp.h |  7 +++++++
> >   net/core/filter.c               |  7 +++++--
> >   net/core/sock.c                 | 34 ++++++++++++++++++++++++++------=
-
> >   net/ipv4/udp.c                  |  2 +-
> >   net/mptcp/sockopt.c             |  2 +-
> >   net/socket.c                    |  2 +-
> >   7 files changed, 44 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 5384f1e49f5c..062f405c744e 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1775,7 +1775,7 @@ static inline void skb_set_owner_edemux(struct sk=
_buff *skb, struct sock *sk)
> >   #endif
> >
> >   int sk_setsockopt(struct sock *sk, int level, int optname,
> > -               sockptr_t optval, unsigned int optlen);
> > +               sockptr_t optval, unsigned int optlen, bool bpf_timetam=
ping);
> >   int sock_setsockopt(struct socket *sock, int level, int op,
> >                   sockptr_t optval, unsigned int optlen);
> >   int do_sock_setsockopt(struct socket *sock, bool compat, int level,
> > @@ -1784,7 +1784,7 @@ int do_sock_getsockopt(struct socket *sock, bool =
compat, int level,
> >                      int optname, sockptr_t optval, sockptr_t optlen);
> >
> >   int sk_getsockopt(struct sock *sk, int level, int optname,
> > -               sockptr_t optval, sockptr_t optlen);
> > +               sockptr_t optval, sockptr_t optlen, bool bpf_timetampin=
g);
> >   int sock_gettstamp(struct socket *sock, void __user *userstamp,
> >                  bool timeval, bool time32);
> >   struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long h=
eader_len,
> > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_t=
stamp.h
> > index 858339d1c1c4..0696699cf964 100644
> > --- a/include/uapi/linux/net_tstamp.h
> > +++ b/include/uapi/linux/net_tstamp.h
> > @@ -49,6 +49,13 @@ enum {
> >                                        SOF_TIMESTAMPING_TX_SCHED | \
> >                                        SOF_TIMESTAMPING_TX_ACK)
> >
> > +#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWAR=
E | \
>
> hmm... so we are allowing it but SOF_TIMESTAMPING_SOFTWARE won't do anyth=
ing
> (meaning set and not-set are both no-op) ?

I was thinking of writing a separate patch to control the output
function by using this flag. Apparently, I didn't do that, so I think
I can remove it from this series.

>
> > +                                           SOF_TIMESTAMPING_TX_SCHED |=
 \
> > +                                           SOF_TIMESTAMPING_TX_SOFTWAR=
E | \
> > +                                           SOF_TIMESTAMPING_TX_ACK | \
> > +                                           SOF_TIMESTAMPING_OPT_ID | \
> > +                                           SOF_TIMESTAMPING_OPT_ID_TCP=
)
> > +
> >   /**
> >    * struct so_timestamping - SO_TIMESTAMPING parameter
> >    *
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 58761263176c..dc8ecf899ced 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5238,6 +5238,9 @@ static int sol_socket_sockopt(struct sock *sk, in=
t optname,
> >               break;
> >       case SO_BINDTODEVICE:
> >               break;
> > +     case SO_TIMESTAMPING_NEW:
>
> How about only allow bpf_setsockopt(SO_TIMESTAMPING_NEW) instead of
> bpf_setsockopt(SO_TIMESTAMPING). Does it solve the issue reported in v2?

No, it doesn't. Sorry, I will handle it in a proper way.

>
> > +     case SO_TIMESTAMPING_OLD:
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -5247,11 +5250,11 @@ static int sol_socket_sockopt(struct sock *sk, =
int optname,
> >                       return -EINVAL;
> >               return sk_getsockopt(sk, SOL_SOCKET, optname,
> >                                    KERNEL_SOCKPTR(optval),
> > -                                  KERNEL_SOCKPTR(optlen));
> > +                                  KERNEL_SOCKPTR(optlen), true);
> >       }
> >
> >       return sk_setsockopt(sk, SOL_SOCKET, optname,
> > -                          KERNEL_SOCKPTR(optval), *optlen);
> > +                          KERNEL_SOCKPTR(optval), *optlen, true);
> >   }
> >
> >   static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 7f398bd07fb7..7e05748b1a06 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -941,6 +941,19 @@ int sock_set_timestamping(struct sock *sk, int opt=
name,
> >       return 0;
> >   }
> >
> > +static int sock_set_timestamping_bpf(struct sock *sk,
> > +                                  struct so_timestamping timestamping)
> > +{
> > +     u32 flags =3D timestamping.flags;
> > +
> > +     if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
> > +             return -EINVAL;
> > +
> > +     WRITE_ONCE(sk->sk_tsflags_bpf, flags);
>
> I think it is cleaner to directly "WRITE_ONCE(sk->sk_tsflags_bpf, flags);=
" in
> sol_socket_sockopt() instead of adding "bool bpf_timestamping" to sk_sets=
ockopt.
> sk_tsflags_bpf is a separate u32 anyway, so not a lot of code to share. T=
he same
> for getsockopt.

As I replied to Willem, I feel this way (that is also the same as v2)
[1] introduces more extra duplicated code and returns earlier compared
to other use cases of SO_xxx, which do you think is a bit weird?

[1]: https://lore.kernel.org/all/20241012040651.95616-3-kerneljasonxing@gma=
il.com/

Surely, I can write it like how v2 works. Which one would you prefer :) ?

>
> [ will continue the remaining patches a little later ]

Thanks!

Thanks,
Jason

