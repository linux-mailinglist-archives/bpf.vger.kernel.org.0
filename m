Return-Path: <bpf+bounces-62930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B53B00820
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3BB4804B0
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F62EF9C0;
	Thu, 10 Jul 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhMsCO8N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEF2857FF
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163695; cv=none; b=WRFcnAl/B8sriIGrT7ZXA7m/SzDIBN4AaQHqsx/S1l/179Ht0Wh+toaoEVyDx4O+ZH8Hjnf2NDPfeM/MgZvc2gcQTz19XN4eUtB8PtdXOmCAFH09ybco45lBXZZSpJ3OV6V3Gzu8wU9LqNvbmSrwJNKzIn7Lt5OE+8kKCArvxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163695; c=relaxed/simple;
	bh=m2M/XwpZi2Yz6FNNs1Tc/QI7BozHa1CEyrbKy+r3CBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoZrl5INCrQjMJQz3MDGqsKrJ77bL4P6TpBO9osapI33gOR7NDXUOq2JZa4xfyGu/d1q2nENWOV9AhT5xASSDgT6NGFzD/colgEBK4HEO5ETDArlPa/3T/B/iyuiuZPEOBxG6rJHRAG2dw4czX9fMTlKjR8R1+aSLcIVUUD3/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhMsCO8N; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4530921461aso8119515e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752163691; x=1752768491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJunfVMJkRJMZMLMlD+/Jnr7eiOBylGQJnru8pPRdcU=;
        b=MhMsCO8NZX+kmXweKIn0jx/k5XZvYkGmgrDVbNX4cuD7LJ1h4ewb7rUoxycF2k+05x
         zaUBtePYEqnT3UFrUuFgNy1mOGMqfKSu2OF0kqo0QHwRjo3OPcoou2ttLQ5aCHq8r5Ji
         LOtkxsITX8hJzQU0Su6jOUhNtf4ZFfapKtOMS+hCbgetGn0sbIiIPnF44CcMdOt+ngDr
         PF+e4TdYyr7/oK/f2JAiPld2XA9kNAjT9OwT0XmG85l7cbI+csAiZC5uz8Gn3iDV7Gyt
         S/rPpRRMBF/GyZbjrU477zqIWDovI7Na+hiX1atErzDa2wEj59btn+Ha99cKmBcJxJUK
         fNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163691; x=1752768491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJunfVMJkRJMZMLMlD+/Jnr7eiOBylGQJnru8pPRdcU=;
        b=LM9tf+Snor/Hd1zrmYkg82/xJjNx3f+Yt6D/Y8kKcle7p9SzHWma0G7W84j4SOO7UY
         GmVK6VwWYUCLhqihkYF9ObzizEALX4sanZlWAMj6Ps+CVoPZ3wCAzpzaELLzs0dbqMUA
         Wm2HnC7i2zyy3HAkqGhYxkJDzlhjlcUlDYpwfIs7q06JPTb7GYf7XvF4PBfjxAOWQjwB
         YWVw/AjEeJrVFezmPJGsVp49EhvelH/oeDyi+GSC9erNUcfZm/0IjJuLZDl6SlhaNc5P
         +Aobw9UfFHMcz1FEfjSbQ6zljPag2hc1nzJGiMyPSqInMxtXzIn/zDQpco2bdnHrezAi
         jRAA==
X-Gm-Message-State: AOJu0Ywz1KTAl8t+h8XhDyCxHQpkVdPV13cq/jlfYfuWJ5RiXfuxURhC
	vrsodoJVa8x68jonn1mSe3XUU0Y1m2YHDVbn76ci7TQ/ojwwmMpfq7cmPS4MjpQ1B5N/h8aJNLi
	NX6q20oAg3RB82lVyUQBzrbXlvZ9i4cU+iZX9
X-Gm-Gg: ASbGncsk2tdwze2Y7muO1bTfoeYmocNh7FosDfCr27ewAp55A8/lzyXsEkW4bB4QtGT
	c6HqJAhPs2uxL6MjJmsNBSHGcCKjceySMlVDeQgYPl8dLNhpi1U0NurtMQ9PQMPAKmLXrmkKXR8
	guGe1DrSXFq/tRE7aE4P3nrhMzDgTPGFE6TmY0nnaqlDM0EBJw9UzdREy9Ub9JSgypCpwm7Z3W
X-Google-Smtp-Source: AGHT+IFCQnGfLXvf4VQDd8CGLo2O1uIObN12fZ+IDbpqGo94Vsoi5iOn1U2zApUCLI8bLOXMuMIvLiYT0eutAKjOzUU=
X-Received: by 2002:a05:600c:a08:b0:450:d3b9:a5fc with SMTP id
 5b1f17b1804b1-454d538f778mr68656125e9.27.1752163690824; Thu, 10 Jul 2025
 09:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710102607.12413-1-mahe.tardy@gmail.com> <20250710102607.12413-4-mahe.tardy@gmail.com>
In-Reply-To: <20250710102607.12413-4-mahe.tardy@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Jul 2025 09:07:59 -0700
X-Gm-Features: Ac12FXxT9lUriIPwZBe5r0qDR1MqAKwzjBqx63hcoAIllIc_h64BsTFCwSO2nMU
Message-ID: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 3:26=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs.
>
> This reuse concepts from netfilter reject target codepath with the
> differences that:
> * Packets are cloned since the BPF user can still return SK_PASS from
>   the cgroup_skb progs and the current skb need to stay untouched
>   (cgroup_skb hooks only allow read-only skb payload).
> * Since cgroup_skb programs are called late in the stack, checksums do
>   not need to be computed or verified, and IPv4 fragmentation does not
>   need to be checked (ip_local_deliver should take care of that
>   earlier).
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ab456bf1056e..9215f79e7690 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -85,6 +85,8 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmp.h>
> +#include <net/icmp.h>
>
>  #include "dev.h"
>
> @@ -12140,6 +12142,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(st=
ruct bpf_sock_ops_kern *skops,
>         return 0;
>  }
>
> +__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
> +{
> +       struct sk_buff *skb =3D (struct sk_buff *)__skb;
> +       struct sk_buff *nskb;
> +
> +       switch (skb->protocol) {
> +       case htons(ETH_P_IP):
> +               if (code < 0 || code > NR_ICMP_UNREACH)
> +                       return -EINVAL;
> +
> +               nskb =3D skb_clone(skb, GFP_ATOMIC);
> +               if (!nskb)
> +                       return -ENOMEM;
> +
> +               if (ip_route_reply_fetch_dst(nskb) < 0) {
> +                       kfree_skb(nskb);
> +                       return -EHOSTUNREACH;
> +               }
> +
> +               icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
> +               kfree_skb(nskb);
> +               break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       case htons(ETH_P_IPV6):
> +               if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +                       return -EINVAL;
> +
> +               nskb =3D skb_clone(skb, GFP_ATOMIC);
> +               if (!nskb)
> +                       return -ENOMEM;
> +
> +               if (ip6_route_reply_fetch_dst(nskb) < 0) {
> +                       kfree_skb(nskb);
> +                       return -EHOSTUNREACH;
> +               }
> +
> +               icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
> +               kfree_skb(nskb);
> +               break;
> +#endif
> +       default:
> +               return -EPROTONOSUPPORT;
> +       }
> +
> +       return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12177,6 +12226,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
>  BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
>
> +BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send_unreach)
> +BTF_ID_FLAGS(func, bpf_icmp_send_unreach, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send_unreach)
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
>         .owner =3D THIS_MODULE,
>         .set =3D &bpf_kfunc_check_set_skb,
> @@ -12202,6 +12255,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_s=
et_sock_ops =3D {
>         .set =3D &bpf_kfunc_check_set_sock_ops,
>  };
>
> +static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send_unreach =3D=
 {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &bpf_kfunc_check_set_icmp_send_unreach,
> +};
> +
>  static int __init bpf_kfunc_init(void)
>  {
>         int ret;
> @@ -12221,7 +12279,8 @@ static int __init bpf_kfunc_init(void)
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR,
>                                                &bpf_kfunc_set_sock_addr);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,=
 &bpf_kfunc_set_tcp_reqsk);
> -       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &=
bpf_kfunc_set_sock_ops);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, =
&bpf_kfunc_set_sock_ops);
> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB,=
 &bpf_kfunc_set_icmp_send_unreach);

Does it have to be restricted to BPF_PROG_TYPE_CGROUP_SKB ?
Can it be a part of bpf_kfunc_set_skb[] and used more generally ?

If restriction is necessary then I guess we can live with extra
bpf_kfunc_set_icmp_send_unreach, though it's odd to create a set
just for one kfunc.
Either way don't change the last 'return ...' line in this file.
Add 'ret =3D ret ?: register...' instead to reduce churn.

Also cc netdev and netfilter maintainers in v2.

--
pw-bot: cr

