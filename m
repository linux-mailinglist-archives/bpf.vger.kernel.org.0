Return-Path: <bpf+bounces-51381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD5A338D1
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 08:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC32D188C13B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385F20A5CE;
	Thu, 13 Feb 2025 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA0uauk4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE81208977;
	Thu, 13 Feb 2025 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431656; cv=none; b=aEHInfaUGaLQmYYxinZBGSnlAxmTkIyRWwWU9c68tZdB6k1SySSKO7lyZTQ5O4r8HAVCd/l2R1eo4DUFS0mYtqhaXSWQJ/ddhOscgu8g2XLhktQ3842JLc2b+mSjjv89bpKyA042XAFkjMsHYH8bKydg8C01IqZySj2WBEP4VVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431656; c=relaxed/simple;
	bh=fKzZlZ6u0HAfBmimgwpD4+oytBdpphnWXEvC8TgSgok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lK8GJZ0nDS+DkjOXBQ8FoisuQqVW6INzD6CqU6hWCfeH8b6FDXAArhTKeEbHxMJcxl74J0M3VSYCTvtR6cWre8ziDQjESPnUcmWUnAY2LJME7cK0EuQL4jlpld4ati9ribIKzBIHDQMBnkUqc+f3APfJ8U7zabxoli2+bNcSFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA0uauk4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d0558c61f4so4868595ab.0;
        Wed, 12 Feb 2025 23:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739431653; x=1740036453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6ROb/DtRS/RcEGqtauazqRPKKj1nEiQpgDageTyOEU=;
        b=bA0uauk4dgyPZYDUB0Rzu0IQdmZWkVwKuLezmn3LO58cQhn9PSKcXVK0vLFWJCiSmL
         29y9S6sTsDHz3MxJce5Q07wYrnhu3eRNugX47q1qD4gOjNaWRCVrK7Rk8C2snfdcnbGr
         R386fJpVyH386Rr6zUajy0tKrdVGhQJFo3rR4vgIhJQZA8p6Ki0JgCnqBBUF2EV3kAtJ
         nPRoZD2/Th9U3EVIMwCYMrgFTdf7YAzEBqg9j4mKgMskQdqt67bsIvRy1qeHAN7dt7mB
         K19IXs3xYP90a83p+38MALvD3RFcVgFNe6b5Fh6/ghBPM/HWWSU9sG3zY+lFPbuQoot3
         0gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431653; x=1740036453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6ROb/DtRS/RcEGqtauazqRPKKj1nEiQpgDageTyOEU=;
        b=XoeKqATlMgHs8DlM8+tN+7OOdt+uwSdMc29cmc/rh65Da68AGjABBOXLWdQCGu7TOX
         fD5uXoccEaEuyeWl2GhiE0/glFMN3XUTz5o437VamkztNEA0p6/16mqHnaABCwUqAiK3
         EpcufiNkrkFkTSk2atodfsL19dsT1heFXeFHYG8nfdydiDqRn8UhxdYFV0H2gjIFxTeV
         cdds3y9IQEwCgJB4Sitp+9I3RoRqH5zIvf7XBJw0U5ALtOIE68wssyWmB987BlObklQx
         chlOkBk6HnEy8Ji1F8V5dTCoK0okMmKkQU7B5gL/297HYL4Kh2+tYt/6hMaXUcx1mwAm
         2PnA==
X-Forwarded-Encrypted: i=1; AJvYcCWK1PoCK40Dv1PXKX0hUxtol1WL7lXoLFWwbxet5KPjceLq6UroDQ6ddPV2R+QqRr7SHo8=@vger.kernel.org, AJvYcCXOMivFpdDszaV9BWh0dyc1SF30cSt37ahDu7OWnvSkUbL2ljY4T5k59A80LtB1l/tFIo9k5hjp@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmOSfkIjSuvZfI2K2U2iLSu2DGvDdr7UcrKrYEbbMZa2NNEKE
	FLaeQcLtTgIISSG5sIbAf7VZoI/8MgpZBCp4cZykQ6g0tJINfh4tYG4T6h4HeR/A0+vonObEI5/
	sT7GW5e6Y2oKXkSN7rcOLYC1nDPA=
X-Gm-Gg: ASbGncsNAM+i4V7oHU+Jr8RghDrJTbZmMvlJ8jaflzUovTw7wj+Mdmqt/Z2pqEC5NFj
	eWkJpI67sOqbkeBwa+Voczc1+3hzXG7+9tUrWmYBLnqvFi/ZGnR0eTt5dXaxFJv5CQRGh36tS
X-Google-Smtp-Source: AGHT+IE9IF/6vKJAI6GK6gE/5GSc/Clc3joG+RrH+lwkotpYUs0yv5gMBnOeYyF6TbEqUvMHw5AjQZyAcENtAsR/yos=
X-Received: by 2002:a05:6e02:1aa1:b0:3cf:ba90:6ad9 with SMTP id
 e9e14a558f8ab-3d18d05b3b3mr12162635ab.9.1739431653451; Wed, 12 Feb 2025
 23:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-12-kerneljasonxing@gmail.com> <eb579932-e85e-4241-bfe7-6e0d780ee9d6@linux.dev>
In-Reply-To: <eb579932-e85e-4241-bfe7-6e0d780ee9d6@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 15:26:55 +0800
X-Gm-Features: AWEUYZnjS7Abnqe0oVFKIEDy5nLyP73ntVRFFca-XJpIS0eiccfXjDeDwSW2dxA
Message-ID: <CAL+tcoBJ0JEKBZUf-vzPCdkAXPb+PEB8FBYb5T6AoV3Hy-vjiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/12] bpf: support selective sampling for
 bpf timestamping
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:49=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/11/25 10:18 PM, Jason Xing wrote:
> > Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs to
> > selectively enable TX timestamping on a skb during tcp_sendmsg().
> >
> > For example, BPF program will limit tracking X numbers of packets
> > and then will stop there instead of tracing all the sendmsgs of
> > matched flow all along. It would be helpful for users who cannot
> > afford to calculate latencies from every sendmsg call probably
> > due to the performance or storage space consideration.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   kernel/bpf/btf.c  |  1 +
> >   net/core/filter.c | 32 +++++++++++++++++++++++++++++++-
> >   2 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 9433b6467bbe..740210f883dc 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_p=
rog_type prog_type)
> >       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> >       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> >       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> > +     case BPF_PROG_TYPE_SOCK_OPS:
> >               return BTF_KFUNC_HOOK_CGROUP;
> >       case BPF_PROG_TYPE_SCHED_ACT:
> >               return BTF_KFUNC_HOOK_SCHED_ACT;
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 7f56d0bbeb00..36793c68b125 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12102,6 +12102,26 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct=
 __sk_buff *s, struct sock *sk,
> >   #endif
> >   }
> >
> > +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern=
 *skops,
> > +                                           u64 flags)
> > +{
> > +     struct sk_buff *skb;
> > +     struct sock *sk;
> > +
> > +     if (skops->op !=3D BPF_SOCK_OPS_TS_SND_CB)
> > +             return -EOPNOTSUPP;
>
> It still needs to test the "flags" such that it can be used in the future=
....
>
>         if (flags)
>                 return -EINVAL;

Will add it.

> > +
> > +     skb =3D skops->skb;
> > +     sk =3D skops->sk;
> > +     skb_shinfo(skb)->tx_flags |=3D SKBTX_BPF;
> > +     if (sk_is_tcp(sk)) {
>
> Unnecessary check like this will only confuse reader. Remove it and revis=
it when
> UDP will be supported.

Okay.

Thanks,
Jason

>
> > +             TCP_SKB_CB(skb)->txstamp_ack |=3D TSTAMP_ACK_BPF;
> > +             skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->le=
n - 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   __bpf_kfunc_end_defs();
> >
> >   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> > @@ -12135,6 +12155,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk=
)
> >   BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
> >   BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
> >
> > +BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
> > +BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
> > +BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> > +
> >   static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
> >       .owner =3D THIS_MODULE,
> >       .set =3D &bpf_kfunc_check_set_skb,
> > @@ -12155,6 +12179,11 @@ static const struct btf_kfunc_id_set bpf_kfunc=
_set_tcp_reqsk =3D {
> >       .set =3D &bpf_kfunc_check_set_tcp_reqsk,
> >   };
> >
> > +static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set =3D &bpf_kfunc_check_set_sock_ops,
> > +};
> > +
> >   static int __init bpf_kfunc_init(void)
> >   {
> >       int ret;
> > @@ -12173,7 +12202,8 @@ static int __init bpf_kfunc_init(void)
> >       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_=
kfunc_set_xdp);
> >       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR,
> >                                              &bpf_kfunc_set_sock_addr);
> > -     return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, =
&bpf_kfunc_set_tcp_reqsk);
> > +     ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,=
 &bpf_kfunc_set_tcp_reqsk);
> > +     return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &=
bpf_kfunc_set_sock_ops);
> >   }
> >   late_initcall(bpf_kfunc_init);
> >
>

