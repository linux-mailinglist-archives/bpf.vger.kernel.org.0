Return-Path: <bpf+bounces-39899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E7979092
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779CD28430E
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D31CF2B5;
	Sat, 14 Sep 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7LOwWqh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC41CEEAD
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314040; cv=none; b=QoW80kTieb3XdikZPwwycbBLBTKlFCKsC/bN/R3ao/WRGWtgisOcXJxRFNkX4tYYOWBY3MQF4z+1CrS2OaFVTfpGvh8Pjwnf/NHkoYzCl1RG347iN50b/cJBkUhS7uRaaoobg096/fSNrX0RMB/sLszX9u+hMt1uanQvjyKLicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314040; c=relaxed/simple;
	bh=OliFemtXeDZo4vD+OP4k39Ufhz7CchYl6D9v8NP18dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hw1YG3b+9eK0tv02HNGKPKdZjHHp2NG5D8+04BVZOjZts1WykodFdJ0YRjDFUa1GBw+msK/osU2V19X+65d3cvICJBgrQwM0OHWJWfCe++ZFDHLiPIaMFuqlxW3vJvFBu8ch4m2KWoAkfsUYYlh9YsjWRB8CWTt4PcLQqe/PwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7LOwWqh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a81bd549eso347473766b.3
        for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726314037; x=1726918837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTkLG8de2K3rf81s1PsLPTq2s3oVCmWApdSccSo/4uo=;
        b=F7LOwWqhYia0T2AXIEDf3RLBUeKbrbkTHLqxsBtkvPEvvqnqcWY5lQMQAouWXv3mLg
         b6m9WOvtHOt3GL0w68t+CjVTLaPdcoPOamJcRe4hjz7VFrespc2ZpkE2EfztwZ7rAUtN
         P9H+Yfp7EbnSb9GxkajoXV9FGtfMv7SyvTkQz7yr6FzKCcnWeJVc53mU0IEg5h2VKutb
         nQD7aphoM8qyQ+4MqJ7Zae+1riWyzJcNk/b6ItIsvUuQ5iaTiUDUd9/r20xbTUu1/Mod
         eChUB8mCCO4FBVOJJ5q3Rnn2NDv9suv+XEDGgTJX5Q5CRo+nCRpXuD+8acr7Nw8EIQWe
         8U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726314037; x=1726918837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTkLG8de2K3rf81s1PsLPTq2s3oVCmWApdSccSo/4uo=;
        b=H9ao82NGijbZCo72332fzQGO3XdiUyJEthECZl/UaoKZe5o58/rhCNAeRXe+KYy93e
         yiZ8NtYjIkAOtdIK505IyYblLtDAGTYTyidmnjtBGvK7e3TD2JRoA1e2nEUYFqUYmswN
         Cuzh9uQZnVMRnXt7AWM8rfkSfo/Ew/fz/5Hm12gFKUcF+7SsEqfEYDPC8hLskJvtazyy
         zFHzgkCqm/IesudtdYxeq2jkkTpdtLtS+7zKonhN135/rRbr6NkVl30RsB2yFz4gB/9n
         c7KZWoVukP4Ln0V/NHZ7awmg26tYuuc4FI8ecVaoAmgK/SLG8/QIrFcTkZ0+hHUcB12Y
         Fxqg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Mptfy6/pc7lnu5DKOWJSscaznQZj7H7x9QYdoRTTJYcdMUZixavHQvg+akCb81LBKiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgpnrrM2AOiW1cFBQRE2zxpa3j1xVShTCwJ/Zuh53TrKfy1wi
	sXl8QFiM9Wh5DUuY6uXZQqDhkUk26xG04eMJGwE1bHwYNNoPmmSk2PyvXKMy7ZqGATtWAkK1Ybt
	/Ice3G9SaH92iuAE/cz58v2YnnnRYfWkf0iIe
X-Google-Smtp-Source: AGHT+IEmBCh34zGD/eul+h3Hcgm77RBe6Yt2fL6Odd5ZSfFbD0sGnwkBimqh7AkIF2q/23UUh1yBQmO8u3Q9uAivp60=
X-Received: by 2002:a17:907:d590:b0:a8d:470e:1793 with SMTP id
 a640c23a62f3a-a902950525emr882387166b.21.1726314036614; Sat, 14 Sep 2024
 04:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com> <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
In-Reply-To: <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Sep 2024 13:40:25 +0200
Message-ID: <CANn89iLE8zgX2U5+3YmBoPgsDAV8xGOcfZcd7Pzd_4MSFs64BA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:39=E2=80=AFAM Tiago Lam <tiagolam@cloudflare.com=
> wrote:
>
> This follows the same rationale provided for the ipv4 counterpart, where
> it now runs a reverse socket lookup when source addresses and/or ports
> are changed, on sendmsg, to check whether egress traffic should be
> allowed to go through or not.
>
> As with ipv4, the ipv6 sendmsg path is also extended here to support the
> IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
> address/port.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> ---
>  net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  net/ipv6/udp.c      |  8 ++++--
>  2 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..4214dda1c320 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct m=
sghdr *msg,
>  }
>  EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
>
> +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk=
,
> +                                    struct in6_addr *saddr, __be16 sport=
)
> +{
> +       if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +           (saddr && sport) &&
> +           (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->i=
net_sport !=3D sport)) {
> +               struct sock *sk_egress;
> +
> +               bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->dad=
dr, fl6->fl6_dport,
> +                                    saddr, ntohs(sport), 0, &sk_egress);
> +               if (!IS_ERR_OR_NULL(sk_egress) &&
> +                   atomic64_read(&sk_egress->sk_cookie) =3D=3D atomic64_=
read(&sk->sk_cookie))

I do not understand this.

1) sk_cookie is not always initialized. It is done on demand, when/if
__sock_gen_cookie() was called.

2) if sk1 and sk2 share the same sk_cookie, then sk1 =3D=3D sk2 ???

So why not simply testing sk_egress =3D=3D sk ?

> +                       return true;
> +
> +               net_info_ratelimited("No reverse socket lookup match for =
local addr %pI6:%d remote addr %pI6:%d\n",
> +                                    &saddr, ntohs(sport), &fl6->daddr, n=
tohs(fl6->fl6_dport));
> +       }
> +
> +       return false;
> +}
> +
>  int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>                           struct msghdr *msg, struct flowi6 *fl6,
>                           struct ipcm6_cookie *ipc6)
> @@ -844,7 +865,62 @@ int ip6_datagram_send_ctl(struct net *net, struct so=
ck *sk,
>
>                         break;
>                     }
> +               case IPV6_ORIGDSTADDR:
> +                       {
> +                       struct sockaddr_in6 *sockaddr_in;
> +                       struct net_device *dev =3D NULL;
> +
> +                       if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct socka=
ddr_in6))) {
> +                               err =3D -EINVAL;
> +                               goto exit_f;
> +                       }
> +
> +                       sockaddr_in =3D (struct sockaddr_in6 *)CMSG_DATA(=
cmsg);
> +
> +                       addr_type =3D __ipv6_addr_type(&sockaddr_in->sin6=
_addr);
> +
> +                       if (addr_type & IPV6_ADDR_LINKLOCAL)
> +                               return -EINVAL;
> +
> +                       /* If we're egressing with a different source add=
ress and/or port, we
> +                        * perform a reverse socket lookup.  The rational=
e behind this is that we
> +                        * can allow return UDP traffic that has ingresse=
d through sk_lookup to
> +                        * also egress correctly. In case the reverse loo=
kup fails, we
> +                        * continue with the normal path.
> +                        *
> +                        * The lookup is performed if either source addre=
ss and/or port changed, and
> +                        * neither is "0".
> +                        */
> +                       if (reverse_sk_lookup(fl6, sk, &sockaddr_in->sin6=
_addr,
> +                                             sockaddr_in->sin6_port)) {
> +                               /* Override the source port and address t=
o use with the one we
> +                                * got in cmsg and bail early.
> +                                */
> +                               fl6->saddr =3D sockaddr_in->sin6_addr;
> +                               fl6->fl6_sport =3D sockaddr_in->sin6_port=
;
> +                               break;
> +                       }
>
> +                       if (addr_type !=3D IPV6_ADDR_ANY) {
> +                               int strict =3D __ipv6_addr_src_scope(addr=
_type) <=3D IPV6_ADDR_SCOPE_LINKLOCAL;
> +
> +                               if (!ipv6_can_nonlocal_bind(net, inet_sk(=
sk)) &&
> +                                   !ipv6_chk_addr_and_flags(net,
> +                                                            &sockaddr_in=
->sin6_addr,
> +                                                            dev, !strict=
, 0,
> +                                                            IFA_F_TENTAT=
IVE) &&
> +                                   !ipv6_chk_acast_addr_src(net, dev,
> +                                                            &sockaddr_in=
->sin6_addr))
> +                                       err =3D -EINVAL;
> +                               else
> +                                       fl6->saddr =3D sockaddr_in->sin6_=
addr;
> +                       }
> +
> +                       if (err)
> +                               goto exit_f;
> +
> +                       break;
> +                       }
>                 case IPV6_FLOWINFO:
>                         if (cmsg->cmsg_len < CMSG_LEN(4)) {
>                                 err =3D -EINVAL;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 6602a2e9cdb5..6121cbb71ad3 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1476,6 +1476,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t len)
>
>         fl6->flowi6_uid =3D sk->sk_uid;
>
> +       /* We use fl6's daddr and fl6_sport in the reverse sk_lookup done
> +        * within ip6_datagram_send_ctl() now.
> +        */
> +       fl6->daddr =3D *daddr;
> +       fl6->fl6_sport =3D inet->inet_sport;
> +
>         if (msg->msg_controllen) {
>                 opt =3D &opt_space;
>                 memset(opt, 0, sizeof(struct ipv6_txoptions));
> @@ -1511,10 +1517,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t len)
>
>         fl6->flowi6_proto =3D sk->sk_protocol;
>         fl6->flowi6_mark =3D ipc6.sockc.mark;
> -       fl6->daddr =3D *daddr;
>         if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
>                 fl6->saddr =3D np->saddr;
> -       fl6->fl6_sport =3D inet->inet_sport;
>
>         if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
>                 err =3D BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
>
> --
> 2.34.1
>

