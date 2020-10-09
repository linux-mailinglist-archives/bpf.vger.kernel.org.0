Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F045028830E
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 08:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgJIG4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 02:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgJIG4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 02:56:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45340C0613D4
        for <bpf@vger.kernel.org>; Thu,  8 Oct 2020 23:56:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r10so3380799ilm.11
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tehnerd-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8pUYvln5zxuSrBTmW6kLW3slo+r2B+BX0KTL115qnI=;
        b=b32SygPOdO5Hlfoe5KJbuY2JncDeUvEjhq7kZLyCAG/GWqAK2X/qsSpfkrzarmZsjW
         CsWkaV/qk8NvHlEZ/GzVA7FIE3ySE+Tds3P54YZY8/uebvHHwJ9FVSROImvDRttE1Bel
         mtfkazrspzoA5Zvky3TfSNhsfSdE6HDKF087srpXnTm7UUBph024r/Qjw601HyzKSAIl
         b71sFy20DqpQBopyi2RiFQhUqUbiKjo784kKVDPu8h5K8y21JUQW9fC6GGm4sxZSUzQ0
         OMYM+9+LohMezgSKkItQiiLWQEEjpJ9hAzqpnOg3EgEHHD/KSqn2Q4cluo05apZgn2RW
         OsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8pUYvln5zxuSrBTmW6kLW3slo+r2B+BX0KTL115qnI=;
        b=o1YkcmTNZk+CnqgrUS+8EzlpS2XhgO+bVyVwQbzWsH9kdIqXoNTe7UXxivdU1hDXKR
         sxkIbM8sQ4h7c8l8f31tEBkjeAqvrwUDLjF3sjB5ZMeQhw+thzGyXmNPXMrKp/cAtMjx
         SbJ8KrvRd0VbZjBxTFA8UdNJNsKmrjvDbad9pqTxMYb5uVNIv26Mt1+2D8ZIKIcbGxJi
         EKEE4+w/fOHV1xyafeF4DdME9MonqB6nJ/gsZzudSEBWzG/1VBh2CdDEP8KUGK2aPnEZ
         RvryEhY0nHdAaS1/HVsmGVkaJz3Mxks/U2F+xqXzC75kl1jwkjMAdjTqH8KvCCBsUQ+R
         pO0A==
X-Gm-Message-State: AOAM533ANJf8UXtHr0zDymeu6IG65RoOVWAXip5ksmWyXUx7zI6oTdnM
        GXOCERl2c/mqGjvrEkjJ+YyP8gbGaX3kOV80Fom+CA==
X-Google-Smtp-Source: ABdhPJyfyN1alRwNkgA+RL7nMpl8bm0YxLbHm5LzC2VX1dF8yhUjDk+9TaHj3IyDsWPfctQiSW3/vZdVKkvCOsCGQg4=
X-Received: by 2002:a92:2602:: with SMTP id n2mr9886773ile.82.1602226576366;
 Thu, 08 Oct 2020 23:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201009050839.222847-1-tehnerd@tehnerd.com> <f32bfccf-c659-e82e-08c2-f863eb267610@fb.com>
In-Reply-To: <f32bfccf-c659-e82e-08c2-f863eb267610@fb.com>
From:   Nikita Shirokov <tehnerd@tehnerd.com>
Date:   Thu, 8 Oct 2020 23:56:05 -0700
Message-ID: <CAJ+=2gi1FFe9jB8epAgm2Pqhc1PMSxmXbAR_d9Qvy3qyD4UwKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add tcp_notsent_lowat bpf setsockopt
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=D1=87=D1=82, 8 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 23:27, Yonghong Son=
g <yhs@fb.com>:
>
>
>
> On 10/8/20 10:08 PM, Nikita V. Shirokov wrote:
> > Adding support for TCP_NOTSENT_LOWAT sockoption
> > (https://lwn.net/Articles/560082/ ) in tcpbpf
> >
> > Signed-off-by: Nikita V. Shirokov <tehnerd@tehnerd.com>
> > ---
> >   include/uapi/linux/bpf.h                          |  2 +-
> >   net/core/filter.c                                 |  4 ++++
> >   tools/testing/selftests/bpf/progs/connect4_prog.c | 15 ++++++++++++++=
+
> >   3 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index d83561e8cd2c..42d2df799397 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1698,7 +1698,7 @@ union bpf_attr {
> >    *            **TCP_CONGESTION**, **TCP_BPF_IW**,
> >    *            **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
> >    *            **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
> > - *             **TCP_SYNCNT**, **TCP_USER_TIMEOUT**.
> > + *             **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOW=
AT**.
> >    *          * **IPPROTO_IP**, which supports *optname* **IP_TOS**.
> >    *          * **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLAS=
S**.
> >    *  Return
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 05df73780dd3..5da44b11e1ec 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4827,6 +4827,10 @@ static int _bpf_setsockopt(struct sock *sk, int =
level, int optname,
> >                               else
> >                                       icsk->icsk_user_timeout =3D val;
> >                               break;
> > +                     case TCP_NOTSENT_LOWAT:
> > +                             tp->notsent_lowat =3D val;
> > +                             sk->sk_write_space(sk);
> > +                             break;
>
> This looks good to me. It is the same as in do_tcp_setsockopt().
>
> >                       default:
> >                               ret =3D -EINVAL;
> >                       }
> > diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/=
testing/selftests/bpf/progs/connect4_prog.c
> > index b1b2773c0b9d..b10e7fbace7b 100644
> > --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> > @@ -128,6 +128,18 @@ static __inline int set_keepalive(struct bpf_sock_=
addr *ctx)
> >       return 0;
> >   }
> >
> > +static __inline int set_notsent_lowat(struct bpf_sock_addr *ctx)
> > +{
> > +     int lowat =3D 65535;
> > +
> > +     if (ctx->type =3D=3D SOCK_STREAM) {
> > +             if (bpf_setsockopt(ctx, SOL_TCP, TCP_NOTSENT_LOWAT, &lowa=
t, sizeof(lowat)))
>
> In my build system, I hit a compilation error.
>
> progs/connect4_prog.c:137:36: error: use of undeclared identifier
> 'TCP_NOTSENT_LOWAT'
>                  if (bpf_setsockopt(ctx, SOL_TCP, TCP_NOTSENT_LOWAT,
> &lowat, sizeof(lowat)))
>
> TCP_NOTSENT_LOWAT is included in /usr/include/linux/tcp.h. But this file
> includes netinet/tcp.h and it contains some same symbol definitions as
> linux/tcp.h so I can include both.
>
> Adding the following can fix the issue
>
> #ifndef TCP_NOTSENT_LOWAT
> #define TCP_NOTSENT_LOWAT       25
> #endif
>
> Not sure where TCP_NOTSENT_LOWAT is defined in your system.

Hey, thanks for checking. will send v2 in a few. as for my system it
is defined here:

/usr/include/netinet/tcp.h
64:#define TCP_NOTSENT_LOWAT     25 /* Limit number of unsent bytes in


>
> > +                     return 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   SEC("cgroup/connect4")
> >   int connect_v4_prog(struct bpf_sock_addr *ctx)
> >   {
> > @@ -148,6 +160,9 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
> >       if (set_keepalive(ctx))
> >               return 0;
> >
> > +     if (set_notsent_lowat(ctx))
> > +             return 0;
> > +
> >       if (ctx->type !=3D SOCK_STREAM && ctx->type !=3D SOCK_DGRAM)
> >               return 0;
> >       else if (ctx->type =3D=3D SOCK_STREAM)
> >

--
Nikita
