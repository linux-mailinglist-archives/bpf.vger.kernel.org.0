Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294FC194ABB
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 22:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgCZVhV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 17:37:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37899 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZVhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 17:37:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id f6so3026312wmj.3;
        Thu, 26 Mar 2020 14:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2fD051k+ulTahDp0tMLHTO24Rc3qrQP7WCeSVwMIuU=;
        b=gh8eoRRSh1dCr7bS4meMKx697a1B5uT0vP18IyG84WoTgMYEYWoUQJ2QUQe45JRt+R
         6KISqmXXWrCfoY3qhpWkde66YBKSYi7auAXIB9gwpqLbRr2LvWIuJtuWPKPd0p9NGL+n
         0/5C4hbFMCgdDP5/f9fI9RIfZtJmyrBXpwA2oi0s96KxgaIxrs3wLPEuhOGpI++5G/Qr
         sFyMhYy9kb52gN7IBQbTsyTuRN6ykUMrrQJA0gax0Q7CXJety8VFf+PZmLVZ5TSb8tBV
         TpvI2pQyzIAdRRtvCXFJyJ48xCWQfcWDniNfaKLddwIme7p5py3Tft9WOq/W5gOL3xQc
         pQ6Q==
X-Gm-Message-State: ANhLgQ1gw7wJ5oou+SbRlXUrlLvAtVnjFbQLuDisj/vR4lFiQipqNOBa
        Nh3SIU8Qn/RDEsdyaBzknpkht4+LzFr5kzRKy6I=
X-Google-Smtp-Source: ADFU+vs/vpDTqgV4dEbX8RgIYGF16PbRUvlseKMGm2xCitnpXahfymI6vbnVY7gGNT71eBvb9eD+sIiJevPtEQO7Tes=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr11529048wro.415.1585258637992;
 Thu, 26 Mar 2020 14:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200325055745.10710-1-joe@wand.net.nz> <20200325055745.10710-5-joe@wand.net.nz>
 <CACAyw9_17E3TNCFsnXzQ4K2zSmwn8J+BcZqbjiK==WQH=zNzvg@mail.gmail.com>
 <CAOftzPipEjfy1p_98V+JmV3p_WJPzhE-_KfqC3UE3d-TYYxyww@mail.gmail.com> <CACAyw99SDN0U+VWi=WqS0V-M+riGehXfj3frTzSa6YcvOgWJtQ@mail.gmail.com>
In-Reply-To: <CACAyw99SDN0U+VWi=WqS0V-M+riGehXfj3frTzSa6YcvOgWJtQ@mail.gmail.com>
From:   Joe Stringer <joe@wand.net.nz>
Date:   Thu, 26 Mar 2020 14:37:06 -0700
Message-ID: <CAOftzPiEkMqz5Kkps4AEO-ZsdW-ogK2xxoj3iytKwjr25_hw1w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/5] bpf: Don't refcount LISTEN sockets in sk_assign()
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Joe Stringer <joe@wand.net.nz>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 26, 2020 at 3:21 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Wed, 25 Mar 2020 at 20:47, Joe Stringer <joe@wand.net.nz> wrote:
> >
> > On Wed, Mar 25, 2020 at 3:29 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> > >
> > > On Wed, 25 Mar 2020 at 05:58, Joe Stringer <joe@wand.net.nz> wrote:
> > > >
> > > > Avoid taking a reference on listen sockets by checking the socket type
> > > > in the sk_assign and in the corresponding skb_steal_sock() code in the
> > > > the transport layer, and by ensuring that the prefetch free (sock_pfree)
> > > > function uses the same logic to check whether the socket is refcounted.
> > > >
> > > > Suggested-by: Martin KaFai Lau <kafai@fb.com>
> > > > Signed-off-by: Joe Stringer <joe@wand.net.nz>
> > > > ---
> > > > v2: Initial version
> > > > ---
> > > >  include/net/sock.h | 25 +++++++++++++++++--------
> > > >  net/core/filter.c  |  6 +++---
> > > >  net/core/sock.c    |  3 ++-
> > > >  3 files changed, 22 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index 1ca2e808cb8e..3ec1865f173e 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -2533,6 +2533,21 @@ skb_sk_is_prefetched(struct sk_buff *skb)
> > > >         return skb->destructor == sock_pfree;
> > > >  }
> > > >
> > > > +/* This helper checks if a socket is a full socket,
> > > > + * ie _not_ a timewait or request socket.
> > > > + */
> > > > +static inline bool sk_fullsock(const struct sock *sk)
> > > > +{
> > > > +       return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
> > > > +}
> > > > +
> > > > +static inline bool
> > > > +sk_is_refcounted(struct sock *sk)
> > > > +{
> > > > +       /* Only full sockets have sk->sk_flags. */
> > > > +       return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);
> > > > +}
> > > > +
> > > >  /**
> > > >   * skb_steal_sock
> > > >   * @skb to steal the socket from
> > > > @@ -2545,6 +2560,8 @@ skb_steal_sock(struct sk_buff *skb, bool *refcounted)
> > > >                 struct sock *sk = skb->sk;
> > > >
> > > >                 *refcounted = true;
> > > > +               if (skb_sk_is_prefetched(skb))
> > > > +                       *refcounted = sk_is_refcounted(sk);
> > > >                 skb->destructor = NULL;
> > > >                 skb->sk = NULL;
> > > >                 return sk;
> > > > @@ -2553,14 +2570,6 @@ skb_steal_sock(struct sk_buff *skb, bool *refcounted)
> > > >         return NULL;
> > > >  }
> > > >
> > > > -/* This helper checks if a socket is a full socket,
> > > > - * ie _not_ a timewait or request socket.
> > > > - */
> > > > -static inline bool sk_fullsock(const struct sock *sk)
> > > > -{
> > > > -       return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
> > > > -}
> > > > -
> > > >  /* Checks if this SKB belongs to an HW offloaded socket
> > > >   * and whether any SW fallbacks are required based on dev.
> > > >   * Check decrypted mark in case skb_orphan() cleared socket.
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 0fada7fe9b75..997b8606167e 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -5343,8 +5343,7 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
> > > >
> > > >  BPF_CALL_1(bpf_sk_release, struct sock *, sk)
> > > >  {
> > > > -       /* Only full sockets have sk->sk_flags. */
> > > > -       if (!sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE))
> > > > +       if (sk_is_refcounted(sk))
> > > >                 sock_gen_put(sk);
> > > >         return 0;
> > > >  }
> > > > @@ -5870,7 +5869,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
> > > >                 return -ESOCKTNOSUPPORT;
> > > >         if (unlikely(dev_net(skb->dev) != sock_net(sk)))
> > > >                 return -ENETUNREACH;
> > > > -       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > > > +       if (sk_is_refcounted(sk) &&
> > > > +           unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > > >                 return -ENOENT;
> > > >
> > > >         skb_orphan(skb);
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index cfaf60267360..a2ab79446f59 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -2076,7 +2076,8 @@ EXPORT_SYMBOL(sock_efree);
> > > >   */
> > > >  void sock_pfree(struct sk_buff *skb)
> > > >  {
> > > > -       sock_edemux(skb);
> > > > +       if (sk_is_refcounted(skb->sk))
> > > > +               sock_edemux(skb);
> > >
> > > sock_edemux calls sock_gen_put, which is also called by
> > > bpf_sk_release. Is it worth teaching sock_gen_put about
> > > sk_fullsock, and dropping the other helpers? I was considering this
> > > when fixing up sk_release, but then forgot
> > > about it.
> >
> > I like the idea, but I'm concerned about breaking things outside the
> > focus of this new helper if the skb_sk_is_prefetched() function from
> > patch 1 is allowed to return true for sockets other than the ones
> > assigned from the bpf_sk_assign() helper. At a glance there's users of
> > sock_efree (which sock_edemux can be defined to) like netem_enqueue()
> > which may inadvertently trigger unexpected paths here. I think it's
> > more explicit so more obviously correct if the destructor pointer used
> > in this series is unique compared to other paths, even if the
> > underlying code is the same.
>
> Sorry, I didn't mean to get rid of sock_pfree, I was referring to
> sk_fullsock and
> sk_is_refcounted. My point was that it's weird that sock_gen_put isn't
> actually generic because it doesn't properly handle SOCK_RCU_FREE.

I briefly looked into this, and I'm still not confident that all
existing usage of sock_gen_put() is handling SOCK_RCU_FREE in a way
that would be consistent with pushing this check into sock_gen_put().
I think it's something worth digging into, but I'd prefer to dig into
it separately from this series.
