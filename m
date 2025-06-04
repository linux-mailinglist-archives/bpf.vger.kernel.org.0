Return-Path: <bpf+bounces-59683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8892FACE617
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 23:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451BD1791AF
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89D1FC7D9;
	Wed,  4 Jun 2025 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hnylqOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABB111BF
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072078; cv=none; b=kCMP0GyOEmRfWzxbHhENyQV5py6IRV85LASiVMvxxCQq1A2zTikyqpa9FKZzZfA2JKo8cGfVDfGv7D4tBYl1Sbk+jaGQvLURZIxRAP9tFT4laUyVRj+Tg4GzLzKSrjoXjtM1sb28q0cfO+0XcMRbd024M+Sja0BaKff3JlX2q4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072078; c=relaxed/simple;
	bh=rjpqzt4R3oYeu+tvNTVmbYGOyQGFoCMslJ02r7kj47Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4310ezTdYSuLQDBNexYrwMZmUAgEmIHkOQxUZX/KbzRlvQk+5T+TFUeceKQwOqYKPYRy8u8ekOoXY5cpMALZVzkNa2/H9A5BSw0LCp4x5dNVbZuqOBjsgx1t811q6E6bvU5PaVYGrqBVedR/Qhk8jHmiu057afm6uQYBrR9+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hnylqOJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so15426a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749072074; x=1749676874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMmwWkOdm0NnS3axXJDkV5oIgU1XFIWHFal1PBq3aLY=;
        b=4hnylqOJpEkHHFlSGvTYhvicE0sUAMWWAKKpoQC7Qo8HQVtMy6g7YRys004rH/qS0R
         ZIFZ5mANB+sVsKrdElzeaTUtRwAoRHH9ZFG1lLgYQAq3QPD2CZowX065BEp5LeN5t/J8
         BLgxbh6IlkPGNcqEhpgMDvjkEF8ImhIVJiZDsqoSyPmO5eDwMbqUi3CTkvhkzFJYzFTJ
         w1jS0rhxJbYq2KFZR+G4EYM7tyNCagndRqsOGDM2raCsPp2ba1VuHryVjiEE5jMe79u5
         8eTY5JoNPD0X3vyjjtq2AxF9df1XO+LbZDmwHKSThhEeuXx3mtLtmIbHPNll8ijHj4Tb
         7Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072074; x=1749676874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMmwWkOdm0NnS3axXJDkV5oIgU1XFIWHFal1PBq3aLY=;
        b=lJ3XxKktErmE08co3wytIL3Ra4+Fw5Dl8ipaGNSLvfF6Ka1JwbWFebQFvtnvs4oSgB
         zW1U4Uy1I4d0Q/cXBUlWH2K4UuH6AHYn5zwOrLjYPFWKmgFuC/sL6qqqNCvn055z32y3
         2K5HBwoRotCCAQae6pkP6WSzOsZYoRACeIqmk9JEY+ih9RB7W7nwehctb4/vm8lH2+3I
         jEpJ9j3XT5WjaaMwlFiIvZsZXtcE9eHEE5OR1aJeiWHNFeunqd/Z9cfHrdxz5EebkwWq
         e+kyeRmWCvFIjZjznh8Zd4fmsRsg9+AmhG3tUHJRf0E65n3/4k2G0BAg0qmONSh//Pvl
         2yog==
X-Forwarded-Encrypted: i=1; AJvYcCVXpMw+ztlJVYM8wq56a2sIjvdbeRt4PeYj584tCirwY4a+npH36A15JJLjmhKMVby70Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhyM9IfGYjZjRvbgwrX+KNfyYj3w92j/12/vcL5evFR5i0IH8n
	v281kycD6uwGNRA7cqLHLd0qiBzmhB0oc8e3ogBIvvORfviD87PEeZJeHh8ZfBWRHVHp1TSsmVq
	I/VdYTNQsMZR8Jsf5+dGTSRuTyD7y/TA/yyqDx+BO
X-Gm-Gg: ASbGncusF6ETS3XwcKqBK9g2C6CuUGf3H1dSy3a+gQc+CkzCKwMCYnjEmROVXipguIA
	+9REPxydJGN88GCVsSMBED4fG75dRMq/3sTQpIgVzMAHYQ1JmeWB4g4EULBWujNnOJjZSVzg98+
	S8u+OnzoN9Rqf56b6ENmb5kdNx+ehPEd1RHPlXAWpOwryY94R91HC0pd3xR8iH52oEgezgzMM9B
	f+TJb55kl2BzEA=
X-Google-Smtp-Source: AGHT+IFfl1d+J4BANyHMvp7/aTeiFOH+AXyO1sMb+OCO/XbaKqvQU/ckvSmWDcIlDjJ2kSqtFDCNnrj5oV5BIZPsRsc=
X-Received: by 2002:a05:6402:2203:b0:607:2070:3a4 with SMTP id
 4fb4d7f45d1cf-607246b9997mr26314a12.2.1749072073812; Wed, 04 Jun 2025
 14:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604210604.257036-1-kuba@kernel.org>
In-Reply-To: <20250604210604.257036-1-kuba@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 4 Jun 2025 23:21:02 +0200
X-Gm-Features: AX0GCFsRtNpZ59bcCt3fkWHpuAtJa7H9-ZTkZRkgMD5Jq5gkOIf04zd96-6tapE
Message-ID: <CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com, 
	eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com, 
	william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 11:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> A not-so-careful NAT46 BPF program can crash the kernel
> if it indiscriminately flips ingress packets from v4 to v6:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>     ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
>     ipv6_rcv (net/ipv6/ip6_input.c:306:8)
>     process_backlog (net/core/dev.c:6186:4)
>     napi_poll (net/core/dev.c:6906:9)
>     net_rx_action (net/core/dev.c:7028:13)
>     do_softirq (kernel/softirq.c:462:3)
>     netif_rx (net/core/dev.c:5326:3)
>     dev_loopback_xmit (net/core/dev.c:4015:2)
>     ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
>     NF_HOOK (./include/linux/netfilter.h:314:9)
>     ip_mc_output (net/ipv4/ip_output.c:400:5)
>     dst_output (./include/net/dst.h:459:9)
>     ip_local_out (net/ipv4/ip_output.c:130:9)
>     ip_send_skb (net/ipv4/ip_output.c:1496:8)
>     udp_send_skb (net/ipv4/udp.c:1040:8)
>     udp_sendmsg (net/ipv4/udp.c:1328:10)
>
> The output interface has a 4->6 program attached at ingress.
> We try to loop the multicast skb back to the sending socket.
> Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
> and changes skb->protocol to v6. We enter ip6_rcv_core which
> tries to use skb_dst(). But the dst is still an IPv4 one left
> after IPv4 mcast output.
>
> Clear the dst in all BPF helpers which change the protcol.
> Try to preserve metadata dsts, those won't hurt.
>
> Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_=
adjust_room()")
> Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
> Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

> ---
> I wonder if we should not skip ingress (tc_skip_classify?)
> for looped back packets in the first place. But that doesn't
> seem robust enough vs multiple redirections to solve the crash.
>
> Ignoring LOOPBACK packets (like the NAT46 prog should) doesn't
> work either, since BPF can change pkt_type arbitrarily.
>
> CC: martin.lau@linux.dev
> CC: daniel@iogearbox.net
> CC: john.fastabend@gmail.com
> CC: eddyz87@gmail.com
> CC: sdf@fomichev.me
> CC: haoluo@google.com
> CC: willemb@google.com
> CC: william.xuanziyang@huawei.com
> CC: alan.maguire@oracle.com
> CC: bpf@vger.kernel.org
> CC: edumazet@google.com
> CC: maze@google.com
> ---
>  net/core/filter.c                      | 19 +++++++++++++------
>  tools/testing/selftests/net/nat6to4.sh | 15 +++++++++++++++
>  2 files changed, 28 insertions(+), 6 deletions(-)
>  create mode 100755 tools/testing/selftests/net/nat6to4.sh
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 327ca73f9cd7..7a72f766aacf 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3233,6 +3233,13 @@ static const struct bpf_func_proto bpf_skb_vlan_po=
p_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>  };
>
> +static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
> +{
> +       skb->protocol =3D htons(proto);
> +       if (skb_valid_dst(skb))
> +               skb_dst_drop(skb);
> +}
> +
>  static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>  {
>         /* Caller already did skb_cow() with len as headroom,
> @@ -3329,7 +3336,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb=
)
>                 }
>         }
>
> -       skb->protocol =3D htons(ETH_P_IPV6);
> +       bpf_skb_change_protocol(skb, ETH_P_IPV6);
>         skb_clear_hash(skb);
>
>         return 0;
> @@ -3359,7 +3366,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb=
)
>                 }
>         }
>
> -       skb->protocol =3D htons(ETH_P_IP);
> +       bpf_skb_change_protocol(skb, ETH_P_IP);
>         skb_clear_hash(skb);
>
>         return 0;
> @@ -3550,10 +3557,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, =
u32 off, u32 len_diff,
>                 /* Match skb->protocol to new outer l3 protocol */
>                 if (skb->protocol =3D=3D htons(ETH_P_IP) &&
>                     flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
> -                       skb->protocol =3D htons(ETH_P_IPV6);
> +                       bpf_skb_change_protocol(skb, ETH_P_IPV6);
>                 else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>                          flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
> -                       skb->protocol =3D htons(ETH_P_IP);
> +                       bpf_skb_change_protocol(skb, ETH_P_IP);

I wonder if this shouldn't drop dst even when doing ipv4->ipv4 or
ipv6->ipv6 -- it's encapping, presumably old dst is irrelevant...

>         }
>
>         if (skb_is_gso(skb)) {
> @@ -3606,10 +3613,10 @@ static int bpf_skb_net_shrink(struct sk_buff *skb=
, u32 off, u32 len_diff,
>         /* Match skb->protocol to new outer l3 protocol */
>         if (skb->protocol =3D=3D htons(ETH_P_IP) &&
>             flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> -               skb->protocol =3D htons(ETH_P_IPV6);
> +               bpf_skb_change_protocol(skb, ETH_P_IPV6);
>         else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>                  flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> -               skb->protocol =3D htons(ETH_P_IP);
> +               bpf_skb_change_protocol(skb, ETH_P_IP);

ditto for decap
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> diff --git a/tools/testing/selftests/net/nat6to4.sh b/tools/testing/selft=
ests/net/nat6to4.sh
> new file mode 100755
> index 000000000000..0ee859b622a4
> --- /dev/null
> +++ b/tools/testing/selftests/net/nat6to4.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +NS=3D"ns-peer-$(mktemp -u XXXXXX)"
> +
> +ip netns add "${NS}"
> +ip -netns "${NS}" link set lo up
> +ip -netns "${NS}" route add default via 127.0.0.2 dev lo
> +
> +tc -n "${NS}" qdisc add dev lo ingress
> +tc -n "${NS}" filter add dev lo ingress prio 4 protocol ip \
> +   bpf object-file nat6to4.bpf.o section schedcls/egress4/snat4 direct-a=
ction
> +
> +ip netns exec "${NS}" \
> +   bash -c 'echo 0123456789012345678901234567890123456789012345678901234=
56789012345678901234567890123456789012345678901234567890123456789abc | soca=
t - UDP4-DATAGRAM:224.1.0.1:6666,ip-multicast-loop=3D1'
> --
> 2.49.0
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

