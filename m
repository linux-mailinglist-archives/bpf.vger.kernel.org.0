Return-Path: <bpf+bounces-10514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B47A9099
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C631C20BDF
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261217C4;
	Thu, 21 Sep 2023 01:42:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB9A5C;
	Thu, 21 Sep 2023 01:42:16 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FB8A9;
	Wed, 20 Sep 2023 18:42:15 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45274236ef6so228622137.3;
        Wed, 20 Sep 2023 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695260534; x=1695865334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6KMWbUCoc8DexqhlNXXHeZryH/GRdUKaDnFHjWc3FE=;
        b=ZG+uxVGTNoec2F1DRYV+KAFSq8gvUvWhkGt7jwsk1LXbvsuS7aqhfIFdWwR8JHieG8
         CDZSVq4NEFGj0K3T8d7DXT/RdTmiCH85dIt3zBxfh9/07qgmusLkaM66Ar56p7PKUBtP
         u6miHIkAUp1Cjwd1J6h9MnXZ6EhGulqsND5PG885KCHeQ78mwKu4dzItyBdF8dEyhj4K
         yBezvWoL3kdlMAyptBYuqEg2WRDD4b5p38qDs7ERgJVPXNs3iDFKzqBVdbgdeWOBRTcf
         KU9aE0oInpnprV5p0dZIWwj6lpimJByOCN6rG6z4dRN9XLtXMxkeimo+mUm1dat5A3aN
         OG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695260534; x=1695865334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6KMWbUCoc8DexqhlNXXHeZryH/GRdUKaDnFHjWc3FE=;
        b=oLMCqhperk5GHFH4OeE883EIJT33i6PJGCaV4jXbNRtYcYcXz3+clvEo1g/BtwuZdM
         F+d67qFTbgaE45uDIr6+l+7xzqjPl8/h5AWm0fnhe1eQ5F61P6+Ii0XWxNRcEGgM9+N6
         8tlbgWYXSqhqJ84d59HAjJep0G59vGfR8f5yEJBPA/AOafcus47nTEIazgwan4UhAWxe
         ABoyouyr2RmAdPceJK+LXGFCAsSC6OjzRqsI4ei8jaK1xF8+qYdTrtwCwZeReJmDi6Kp
         W0msuTLRm79mpCgo8uFLf0cG+YiWR79Sauh+5346fv7aYm7W086n5obPWG3N+VzOHdp6
         0WTQ==
X-Gm-Message-State: AOJu0YyxEDJquWEfKEliTy102b3zOsgU7zms5LvZ1XOIheoVZ5YsM7mz
	nEdYlawnVn/HOtK1YI+GuW4Gh36cuWGFmSVYkH6kP+4lUjc=
X-Google-Smtp-Source: AGHT+IGhUv2dofXRRvk+v04KQPgPqGj0mSgPd7rUNFQSwkimFZX6QPpBdNLjU73ehVmIVd3ohLqREmv57V1ivXknYh4=
X-Received: by 2002:a67:bc09:0:b0:44e:d6c3:51d4 with SMTP id
 t9-20020a67bc09000000b0044ed6c351d4mr4625646vsn.18.1695260534071; Wed, 20 Sep
 2023 18:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <108791.1695199151@warthog.procyon.org.uk> <650af9a2aa74_37bf362941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <650af9a2aa74_37bf362941f@willemb.c.googlers.com.notmuch>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 20 Sep 2023 21:41:38 -0400
Message-ID: <CAF=yD-K07q_ygjRrsau3fPWX4==WPjEtZN1y3eZUTABYaG0vWg@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:54=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> David Howells wrote:
> > Including the transhdrlen in length is a problem when the packet is
> > partially filled (e.g. something like send(MSG_MORE) happened previousl=
y)
> > when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> > transport header or account for it twice.  This can happen under some
> > circumstances, such as splicing into an L2TP socket.
> >
> > The symptom observed is a warning in __ip6_append_data():
> >
> >     WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_appen=
d_data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
> >
> > that occurs when MSG_SPLICE_PAGES is used to append more data to an alr=
eady
> > partially occupied skbuff.  The warning occurs when 'copy' is larger th=
an
> > the amount of data in the message iterator.  This is because the reques=
ted
> > length includes the transport header length when it shouldn't.  This ca=
n be
> > triggered by, for example:
> >
> >         sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
> >         bind(sfd, ...); // ::1
> >         connect(sfd, ...); // ::1 port 7
> >         send(sfd, buffer, 4100, MSG_MORE);
> >         sendfile(sfd, dfd, NULL, 1024);
> >
> > Fix this by deducting transhdrlen from length in ip{,6}_append_data() r=
ight
> > before we clear transhdrlen if there is already a packet that we're goi=
ng
> > to try appending to.
> >
> > Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com=
/
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Eric Dumazet <edumazet@google.com>
> > cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: David Ahern <dsahern@kernel.org>
> > cc: Paolo Abeni <pabeni@redhat.com>
> > cc: Jakub Kicinski <kuba@kernel.org>
> > cc: netdev@vger.kernel.org
> > cc: bpf@vger.kernel.org
> > cc: syzkaller-bugs@googlegroups.com
> > Link: https://lore.kernel.org/r/75315.1695139973@warthog.procyon.org.uk=
/ # v1
> > ---
> >  net/ipv4/ip_output.c  |    1 +
> >  net/ipv6/ip6_output.c |    1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > index 4ab877cf6d35..9646f2d9afcf 100644
> > --- a/net/ipv4/ip_output.c
> > +++ b/net/ipv4/ip_output.c
> > @@ -1354,6 +1354,7 @@ int ip_append_data(struct sock *sk, struct flowi4=
 *fl4,
> >               if (err)
> >                       return err;
> >       } else {
> > +             length -=3D transhdrlen;
> >               transhdrlen =3D 0;
> >       }
> >
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index 54fc4c711f2c..6a4ce7f622e9 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -1888,6 +1888,7 @@ int ip6_append_data(struct sock *sk,
> >               length +=3D exthdrlen;
> >               transhdrlen +=3D exthdrlen;
> >       } else {
> > +             length -=3D transhdrlen;
> >               transhdrlen =3D 0;
> >       }
> >
>
> Definitely a much simpler patch, thanks.
>
> So the current model is that callers with non-zero transhdrlen always
> pass to __ip_append_data payload length + transhdrlen.
>
> I do see that udp does this: ulen +=3D sizeof(struct udphdr); This calls
> ip_make_skb if not corked, but directly ip_append_data if corked.
>
> Then __ip_append_data will use transhdrlen in its packet calculations,
> and reset that to zero after allocating the first new skb.
>
> So if corked *and* fragmentation, which would cause a new skb to be
> allocated, the next skb would incorrectly reserve udp header space,
> because the second __ip_append_data call will again pass transhdrlen.
> If so, then this patch fixes that. But that has never been reported,
> so I'm most likely misreading some part..

This works today because udp only includes transhdrlen if not corked.
In udpv6_sendmsg:

        if (up->pending) {
                       ...
                       goto do_append_data;
        }
        ulen +=3D sizeof(struct udphdr);

So ip6_append_data is called with ulen =3D=3D len once data is pending, so
subtracting transhdrlen (which is still sizeof(udphdr)) would not be
correct.

l2tp_ip6_sendmsg more or less follows udpv6_sendmsg, but it
unconditionally sets ulen =3D len + transhdrlen. So maybe the fix is in
L2TP:

+++ b/net/l2tp/l2tp_ip6.c
@@ -507,7 +507,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk,
struct msghdr *msg, size_t len)
         */
        if (len > INT_MAX - transhdrlen)
                return -EMSGSIZE;
-       ulen =3D len + transhdrlen;

        /* Mirror BSD error message compatibility */
        if (msg->msg_flags & MSG_OOB)
@@ -628,6 +627,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk,
struct msghdr *msg, size_t len)

 back_from_confirm:
        lock_sock(sk);
+       ulen =3D len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen :=
 0;

As said, only raw, udp and l2p can possibly pass MSG_MORE and so cause
secondary invocations of ip6_append_data for the same send. With raw
passing transhdrlen 0, and udp as discussed above, we only have to
consider l2tp.

