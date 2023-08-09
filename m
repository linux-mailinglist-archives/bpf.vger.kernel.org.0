Return-Path: <bpf+bounces-7369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0277635C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 17:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F27E1C21228
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938619BDD;
	Wed,  9 Aug 2023 15:08:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA2372
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 15:08:45 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1ED1BDA
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:08:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so1566535a12.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691593722; x=1692198522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G6T3JCdCSjXcLmjmeNQXnmppiYdA5F1SZkXm/TxHpg=;
        b=AFMi7qSe9xi1nXJyOmj9Pf1I24OUvRB/WMsnyk7ANa4EJu5x3ixtwGAQ2DQvaklQEi
         CIIcnzvPZAvh0QFlqDA0IwQ+55nVG3EZQr4bWau7vG4fNJcPqbiYKGZWaqfAR4TrYoPm
         431MaydlkDgq9WWasTwku0JG9/tar21OVpVXWuM+11NWgISrYsTwj0JXBMlL+QqxREOz
         3dGOHQEXE9zzqEQubiZaY2AqyrBNwAQmd2ftY8WL2bQRboSI67n3l8r1wlEi8jj1tf/v
         zFWq5migteLX095kdcYSVWVG4aDyfxNZv8Z9JVf1CNkhvvZwLI8o6dQ1YyyDUwxJ+rSK
         DWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593722; x=1692198522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G6T3JCdCSjXcLmjmeNQXnmppiYdA5F1SZkXm/TxHpg=;
        b=bykPBcmkPNKBVutqIkQkTUT+LMydSxk1Y+GxmcNVRX6lkVodVlRZTZD4udha6mSVBe
         N1lYuwyZaEFwyFbWcooLZ9ezbMb6aEGTf9xj0KtfnyiYBsB6T4dBC9dAMXxeZYXoSKXJ
         Oe6bg0ezYB6N2zl34fOY5UR8PZFB7BqB+C+/aeLQ4r+ZP69Uxt8gKULqnopeMBBhzI3p
         7FSLfA0xuqntotP1RtLTbi6M58NbZ2qOrcYN2GpMCTLyQwJgGg2L9ZyDbQnWJIl/Y0ks
         /iGGaXht5+/xDEpcC0j3+eSQ8VkyCRvsVZhiwvBPwswpJC7mrpC3WDhGRPL3KV0u8HfW
         AeHQ==
X-Gm-Message-State: AOJu0YyupYWgTcMSxsg4y7/mvDukVXF4uGhO1sorZZdEFlShboXtpowT
	Pw8NiV3JVuj/XuES82qfKZz1r0PbRpJLkAq3OFbhyA==
X-Google-Smtp-Source: AGHT+IFJOmQaBG1yOZ2H7dcbIP6G4WTdTLU+oF9E60L/N6jLeiWxT1AzWslITS72T1ET4Iya7sJGmqsIkWYyudCliX8=
X-Received: by 2002:a17:907:a041:b0:993:f12a:39ce with SMTP id
 gz1-20020a170907a04100b00993f12a39cemr2327076ejc.15.1691593722582; Wed, 09
 Aug 2023 08:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809-bpf-next-v1-1-c1b80712e83b@isovalent.com> <6acbbf63-ba10-4a66-5e31-b9a499f79489@linux.dev>
In-Reply-To: <6acbbf63-ba10-4a66-5e31-b9a499f79489@linux.dev>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 9 Aug 2023 16:08:31 +0100
Message-ID: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 3:39=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 8/9/23 1:33 AM, Lorenz Bauer wrote:
> > Kumar reported a KASAN splat in tcp_v6_rcv:
> >
> >    bash-5.2# ./test_progs -t btf_skc_cls_ingress
> >    ...
> >    [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0=
x3440
> >    [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_=
progs/226
> >
> > The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
> > accounting for request sockets. I added the check to ensure that we onl=
y
> > every try to perform a reuseport lookup on a supported socket.
> >
> > It turns out that this isn't necessary at all. struct sock_common conta=
ins
> > a skc_reuseport flag which indicates whether a socket is part of a
>
> Does it go back to the earlier discussion
> (https://lore.kernel.org/bpf/7188429a-c380-14c8-57bb-9d05d3ba4e5e@linux.d=
ev/)
> that the sk->sk_reuseport is 1 from sk_clone for TCP_ESTABLISHED? It work=
s
> because there is sk->sk_reuseport"_cb" check going deeper into
> reuseport_select_sock() but there is an extra inet6_ehashfn for all TCP_E=
STABLISHED.

Sigh, I'd forgotten about this...

For the TPROXY TCP replacement use case we sk_assign the SYN to the
listener, which creates the reqsk. We can let follow up packets pass
without sk_assign since they will match the reqsk and convert to a
fullsock via the usual route. At least that is what the test does. I'm
not even sure what it means to redirect a random packet into an
established TCP socket TBH. It'd probably be dropped?

For UDP, I'm not sure whether we even get into this situation? Doesn't
seem like UDP sockets are cloned from each other, so we also shouldn't
end up with a reuseport flag set erroneously.

Things we could do if necessary:
1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE
2. Duplicate the cb check into inet[6]_steal_sock

Best
Lorenz

>
> > reuseport group. inet[6]_lookup_reuseport already check this flag,
> > so we can't execute an erroneous reuseport lookup by definition.
> >
> > Remove the unnecessary assertions to fix the out of bounds access.
> >
> > Fixes: 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_s=
k_assign")
> > Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> > ---
> >   include/net/inet6_hashtables.h | 10 ----------
> >   include/net/inet_hashtables.h  | 10 ----------
> >   2 files changed, 20 deletions(-)
> >
> > diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtab=
les.h
> > index 284b5ce7205d..f9907ed36d54 100644
> > --- a/include/net/inet6_hashtables.h
> > +++ b/include/net/inet6_hashtables.h
> > @@ -119,16 +119,6 @@ struct sock *inet6_steal_sock(struct net *net, str=
uct sk_buff *skb, int doff,
> >       if (!prefetched)
> >               return sk;
> >
> > -     if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> > -             if (sk->sk_state !=3D TCP_LISTEN)
> > -                     return sk;
> > -     } else if (sk->sk_protocol =3D=3D IPPROTO_UDP) {
> > -             if (sk->sk_state !=3D TCP_CLOSE)
> > -                     return sk;
> > -     } else {
> > -             return sk;
> > -     }
> > -
> >       reuse_sk =3D inet6_lookup_reuseport(net, sk, skb, doff,
> >                                         saddr, sport, daddr, ntohs(dpor=
t),
> >                                         ehashfn);
> > diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtable=
s.h
> > index 1177effabed3..57a46993383a 100644
> > --- a/include/net/inet_hashtables.h
> > +++ b/include/net/inet_hashtables.h
> > @@ -465,16 +465,6 @@ struct sock *inet_steal_sock(struct net *net, stru=
ct sk_buff *skb, int doff,
> >       if (!prefetched)
> >               return sk;
> >
> > -     if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> > -             if (sk->sk_state !=3D TCP_LISTEN)
> > -                     return sk;
> > -     } else if (sk->sk_protocol =3D=3D IPPROTO_UDP) {
> > -             if (sk->sk_state !=3D TCP_CLOSE)
> > -                     return sk;
> > -     } else {
> > -             return sk;
> > -     }
> > -
> >       reuse_sk =3D inet_lookup_reuseport(net, sk, skb, doff,
> >                                        saddr, sport, daddr, ntohs(dport=
),
> >                                        ehashfn);
> >
> > ---
> > base-commit: eb62e6aef940fcb1879100130068369d4638088f
> > change-id: 20230808-bpf-next-a442a095562b
> >
> > Best regards,
>

