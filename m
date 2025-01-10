Return-Path: <bpf+bounces-48602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C9A09E50
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7E83A35E3
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B63218599;
	Fri, 10 Jan 2025 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zexqe7Yg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8602020A5FC;
	Fri, 10 Jan 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549225; cv=none; b=Zggc+DampCxx+qdOWZRtvO9xjSFYOxPOhGZgOcpw2wB4u5MRsw1SdspgwS8EuBweW5SWS/R07iSZsOeVVwamk7MBeXAYllZ9tn+MKxw2rxmtwMewK+Jz5d7nvU8x4O6rsvqX4WL+XPauh/FuxrPj09ghpzdGAt7gb8T9HqjdOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549225; c=relaxed/simple;
	bh=7Zfa14YDAbHV5wdyvtr+eysIaGFJ4+2IJWqdwhJDV/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BefFADBjz3zeKQ/4YB+3vr/a1pACZ/K8Bnfqn9oYfs9i64iNEQkSgfJGEITnYjHUQYWb5oFLzoqAGuRXyZMoryaJ25lwgnF3Z9Lj43/ym8o8qwQRwD+6u2k8QmicsRMuN3oUE6enHNYQ5zWVDfhqSUq1TUvxdrHovFKMukuwqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zexqe7Yg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cdce23f3e7so17234745ab.0;
        Fri, 10 Jan 2025 14:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736549222; x=1737154022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VdapTcc6EDaF6pFt9hTRwCHLb2LBe5Ce19xv3XW6gU=;
        b=Zexqe7YgNPFk7gfGAUvtUvOb+DPPvaOkqZYXsycQdQdrGqIDUZ52VGjeCSll1BKg7r
         2daEKaCeQXwiLwfXnemAfYXJf1Nlxcf7GQXI92dL9wtk0zvTNJJH/uzs8z+8Z1mTmi/i
         lnW6wo03cSsquAlDWxKEBB0VkhIa1sMdb//QVJo/CDFG/t3I0M5zdmgqYMaH4q0iyP64
         xNCQUWFv+raJeOhqdrkL3HrQ/XzZXjBmO7O9geVc24UXF9hiCvMJFJVeVBl4OUPPl8Iu
         zCIs55/1DXzwy9tb2Hh+leGLlIK9XXOo0yhpPfDxcboKzUGOEXPNBbaR5x5CRWZw7mOM
         Dc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549222; x=1737154022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VdapTcc6EDaF6pFt9hTRwCHLb2LBe5Ce19xv3XW6gU=;
        b=sPJqodZMyhP9vQ13//c/CB56u48ADW+su8Ruy3x5ttM2GoYZbtZc5gSZjkYQY/13ub
         /N9m0opzvPzlEeV79LTDef1gcbZXuEo1hRBkvEiI2MLcBqK1dv/yNPVGV7Y5GMAyz76x
         Q8IjtvHZip3SP2ZJ+65d/d8CSZsXNhGz0Cz5lxNv59uZsPGFgDexU0HALKa3e52qt8nL
         ffmy60DLaGcu7iNmBy+GaHP0INwAPAvN2gasS5VjkT+cSewKvfLwhDtyd7PdwL/6pOKF
         VrWQB7vBvGC5IgOKKTDco+3DsoESD1APc+nPjKxHRow9Uw5U8cPm20yHkINY3vyD5Sz3
         Vbow==
X-Forwarded-Encrypted: i=1; AJvYcCUlZ2vLW/g8jYQ/nijduSUVpFbSHyZqZqwqMReRqFvP69y+CjxUy/LzeGhoLbTHB6uLENoiTNh0@vger.kernel.org, AJvYcCXkCkO+1wOkWXZbjKGyCCzOoZPEfqihsjDxloFrxyGLFanuLlKPC7cy/obaGd99Z5xEcso=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkd0wfh+KDqGRcPUDd9nLMwnEuSptnGeXFOPZnJ1/N0/4sOkE3
	vc82OmdhCtlp8aaWlXlrv3alclgllqp7OlMhE3CRPxzhFP4ucRfiCtJxsnW8N3LiNyHAvesBoNy
	SxRAZa8U2naKE7VRJHd4kYSO+KHQ=
X-Gm-Gg: ASbGncvwmrzwg8o3y9nDohF9lS/QdHGV7l8AyUHI/zJ4ejSb63dLztWRAGBQjrzRoc0
	8GzFGhNgcGJDlFXXJ5wLOQ2vXASlaAuGwgKs0Dw==
X-Google-Smtp-Source: AGHT+IGI/XEyR9OclO6zyBVdXE3/UkYPmFl3bcyrv78rKAIavKHRIfwsDoOOLyCh8x4tF2pH5wbSmcLWnpOR4RL4UJY=
X-Received: by 2002:a05:6e02:13f0:b0:3ce:5af3:7845 with SMTP id
 e9e14a558f8ab-3ce5af37a91mr21557095ab.6.1736549222573; Fri, 10 Jan 2025
 14:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com> <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
 <CAL+tcoCSrBBaW3Rg1hD0mBAGu_ZTCTfjVBGe_7B=_JB+uJTuYA@mail.gmail.com> <13c5a76b-0635-42ed-8dfa-4f656a03a564@linux.dev>
In-Reply-To: <13c5a76b-0635-42ed-8dfa-4f656a03a564@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 11 Jan 2025 06:46:26 +0800
X-Gm-Features: AbW1kvaZa5tfpQvmeNH8au3AepFWQvcwd9RAkxELt9z8Rpgaf1jrLmbl24z3tZM
Message-ID: <CAL+tcoDkFvWmt+GE43sK2pw345hhnVhSv=2+89Wc=s52DHeA1g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP
 bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 4:36=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/7/25 8:21 PM, Jason Xing wrote:
> > Hi Martin,
> >
> >>> -     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
> >>> +     if (sk_is_tcp(sk))
> >>> +             args[2] =3D skb_shinfo(skb)->tskey;
> >>
> >> Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pa=
ss the
> >> whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets=
 start
> >> with end_offset =3D 0 for now so that the bpf prog won't use it to rea=
d the
> >> skb->data. It can be revisited later.
> >>
> >>          bpf_skops_init_skb(&sock_ops, skb, 0);
> >>
> >> The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get=
 to the
> >> skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.
> >
> > In recent days, I've been working on this part. It turns out to be
> > infeasible to pass "struct __sk_buff *skb" as the second parameter in
> > skops_sockopt() in patch [11/11]. I cannot find a way to acquire the
> > skb itself
>
> I didn't mean to pass skb in sock_ops_kern->args[] or pass skb to the bpf=
 prog
> "SEC("sockops") skops_sockopt(struct bpf_sock_ops *skops, struct sk_buff =
*skb)".
> The bpf prog can only take one ctx argument which is
> "struct bpf_sock_ops *skops" here.
>
> I meant to have kernel initializing the sock_ops_kern->skb by doing
> "bpf_skops_init_skb(&sock_ops, skb, 0);" before running the bpf prog.
>
> The bpf prog can read the skb by using bpf_cast_to_kern_ctx() and bpf_cor=
e_cast().
>
> Something like the following. I directly change the existing test_tcp_hdr=
_options.c.
> It has not been changed to use the vmlinux.h, so I need to redefine some =
parts of
> the sk_buff, skb_shared_info, and bpf_sock_ops_kern. Your new test should=
 directly
> include <vmlinux.h> and no need to redefine them.
>
> Untested code:
>
> diff --git i/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c w/t=
ools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
> index 5f4e87ee949a..c98ebe71f6ba 100644
> --- i/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
> +++ w/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
> @@ -12,8 +12,10 @@
>   #include <linux/types.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_core_read.h>
>   #define BPF_PROG_TEST_TCP_HDR_OPTIONS
>   #include "test_tcp_hdr_options.h"
> +#include "bpf_kfuncs.h"
>
>   #ifndef sizeof_field
>   #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> @@ -348,9 +350,63 @@ static int current_mss_opt_len(struct bpf_sock_ops *=
skops)
>         return CG_OK;
>   }
>
> +struct sk_buff {
> +       unsigned int            end;
> +       unsigned char           *head;
> +} __attribute__((preserve_access_index));
> +
> +struct skb_shared_info {
> +       __u8            flags;
> +       __u8            meta_len;
> +       __u8            nr_frags;
> +       __u8            tx_flags;
> +       unsigned short  gso_size;
> +       unsigned short  gso_segs;
> +       unsigned int    gso_type;
> +       __u32           tskey;
> +} __attribute__((preserve_access_index));
> +
> +struct bpf_sock_ops_kern {
> +       struct  sock *sk;
> +       union {
> +               __u32 args[4];
> +               __u32 reply;
> +               __u32 replylong[4];
> +       };
> +       struct sk_buff  *syn_skb;
> +       struct sk_buff  *skb;
> +       void    *skb_data_end;
> +       __u8    op;
> +       __u8    is_fullsock;
> +       __u8    remaining_opt_len;
> +       __u64   temp;                   /* temp and everything after is n=
ot
> +                                        * initialized to 0 before callin=
g
> +                                        * the BPF program. New fields th=
at
> +                                        * should be initialized to 0 sho=
uld
> +                                        * be inserted before temp.
> +                                        * temp is scratch storage used b=
y
> +                                        * sock_ops_convert_ctx_access
> +                                        * as temporary storage of a regi=
ster.
> +                                        */
> +} __attribute__((preserve_access_index));
> +
>   static int handle_hdr_opt_len(struct bpf_sock_ops *skops)
>   {
>         __u8 tcp_flags =3D skops_tcp_flags(skops);
> +       struct bpf_sock_ops_kern *skops_kern;
> +       struct skb_shared_info *shared_info;
> +       struct sk_buff *skb;
> +
> +       skops_kern =3D bpf_cast_to_kern_ctx(skops);

Oh, I misunderstood the use of bpf_cast_to_kern_ctx() function and
failed/struggled to fetch the "struct bpf_sock_ops_kern".

Now I realized. Thanks so much for your detailed codes! I will try
this in a few hours.

> +       skb =3D skops_kern->skb;
> +
> +       if (skb) {
> +               shared_info =3D bpf_core_cast(skb->head + skb->end, struc=
t skb_shared_info);
> +               /* printk as an example. don't do that in selftests. */
> +               bpf_printk("tskey %u gso_size %u gso_segs %u gso_type %u =
flags %x\n",
> +                          shared_info->tskey, shared_info->gso_size,
> +                          shared_info->gso_segs, shared_info->gso_type, =
shared_info->flags);
> +       }
>
>         if ((tcp_flags & TCPHDR_SYNACK) =3D=3D TCPHDR_SYNACK)
>                 return synack_opt_len(skops);
>
>

