Return-Path: <bpf+bounces-50849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8654A2D454
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 07:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FC016C6A7
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B911AC43A;
	Sat,  8 Feb 2025 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmwxPUy4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448913D28F;
	Sat,  8 Feb 2025 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738997672; cv=none; b=UQ4klDmD83lBs2KHEWfXkea45Ct+MoXsKJINl/YyIQePk/nQZa1okCWQW+fmrRtcy2JQck93QzPMdwdX4PJ4rUQd4q04g0QB7ogkLg82QvcziDjUFzt9OjRiDVTB5lv3jFneMSphIrPQ4djToZmNX4pxZK5BJ5TktyY5bgHl6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738997672; c=relaxed/simple;
	bh=GOqFq08kb4mAjnpjZ7dY8tvP/9Sl5M2IAyaDMDSQ1mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntKa18UGdnl7pWJAE9RJL6XShby75jdAHKiDqNNEuRmnCJKEbAT9o1VJxdW4eKtT0uLORdDJtHmq1yX7aTa3pKSqZVxyql9pEyKhBOAznOPGzN0m7BiioMGF+yDT0WEcI7RH6PTwrF2mbS2aFKUUsE3zoj3I/6My/eVAeaku4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmwxPUy4; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d146df0afeso7314095ab.3;
        Fri, 07 Feb 2025 22:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738997669; x=1739602469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Z9VrVCWbmpLh+Hg7PlddvN+/xuMtc+jiEOiugtVTs=;
        b=jmwxPUy4DTJn+N0dftY0j44Mc0GgqIQnGrXtJgmQMkMBtTROL2Vsx0JePVO8w5UgHH
         KpNGHmEF27sdSAvsvo+iJFOoVt8zy1wGzap+SNCI9OVFsX/6vd8zYz6avqGdabMmGQF0
         2CM5UAiEj8NWAIdMjzGihf+k6tvd5GfaSilxRoUXZRqPPJF1w5HIqGeqvBiNwDDwadP2
         PF5q/nfEZxrouxtFiXSRJnFM+LIw41QQKYEyBe2rujWzfRjesoIZQcQGMnkPuCYqKQFy
         jVKpTLqN/rWCB+gX9R6l6/MI9zlzuyMJCanyhL6mcCG7XCGGMyfrJsdpNoDBSe2aP926
         qe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738997669; x=1739602469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9Z9VrVCWbmpLh+Hg7PlddvN+/xuMtc+jiEOiugtVTs=;
        b=lmYgAOuUqJfX4xcgapsn5t42b6ApWHrGn/McoEIKi7FoxF15EAzmubiPwvy0PWY3QW
         HR8n0yaurc0sRiksGjVYPkvXOM+ruyQxG3FZxIxTw0y7uLRrqkKBZugiDjjguyfm97LZ
         Sn7fH/161Ilml+GI+JUrQc/lORgc9OdK563MXEKGSuyhsK5sHhjgJtYQbo7IJOaj0dyY
         5PKabpBihayX2INxlrSjh5T2iYA5XbuQxJ90S2ruhstKNNDTXDK7Vgm1Dw2JNfZPVBvm
         eDC+xJQWJHmuzkvA2YY8ccbkE2nkcEIpT9VPwU3HNkleMLbs6od7MqOqXxh0NyrO5vOz
         6Naw==
X-Forwarded-Encrypted: i=1; AJvYcCVEl5Y4UZBDUHUAgeP5Gv/Lic5RKGJgreEIECPvEdeBGO+vUvOIOYmUxru45XcWo2GVFBKBsW60@vger.kernel.org, AJvYcCXr7TwGUg31bQOG+vwz5tknd4/q8VK19A0iJ34ZjY+fMDa3NHrUX/cGx0K1+HXS1vL/izY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX65qAzTi/cnFV3iq5q5v1Rx/hrjmfa1Fo8TtfUxHeZaym75fN
	QIeMJQEdJyr/ce8ntmwnW0iYseTAq4e8Pg3U00u1xcTs1qj9ivIUcRy8QDwRiQctbwNFGjf/AKE
	D1Wk4hxZDjLDxYjPYbiiqyMvBmWU=
X-Gm-Gg: ASbGncu/iF39zxeWRzApo59t7Aov5J2PK/sAaho29KokAp4IedOqhnu3F5CzZvGWEVy
	h9WJUWtWCgL1qdWYkqLgfWe9ajyzhkAzOIAD4bzibzE6l+zsS9JMnJsLIo0dWjiCIFjPUrQdE
X-Google-Smtp-Source: AGHT+IETM5eUX+Mc36jJh/HPLV5bCdv++TDdM6wxgrbSZP4F+Zk2pQHUfgeuB1AojRIfFpGo0NUu7GHut+HzQ9GLV/g=
X-Received: by 2002:a05:6e02:3785:b0:3d0:4e57:bbd9 with SMTP id
 e9e14a558f8ab-3d13dd4d375mr46814125ab.10.1738997669607; Fri, 07 Feb 2025
 22:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org> <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
 <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev> <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
 <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
 <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev> <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
 <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev> <CAL+tcoA14HKQmG9dtMdRVqgJJ87hcvynPjqVLkAbHnDcsq-RzQ@mail.gmail.com>
 <CAL+tcoD9qZvbo53QsUcC27Dp=tJshBFdjoM9RCHxHEsYjwaXWg@mail.gmail.com> <1ef7e85b-03b7-4baa-aca2-3c18bf1e16e2@linux.dev>
In-Reply-To: <1ef7e85b-03b7-4baa-aca2-3c18bf1e16e2@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Feb 2025 14:53:53 +0800
X-Gm-Features: AWEUYZl3FKcsSheniI0jLgCpjJA6LfsQQKBq81BqJz3BsKZDt6w5Nh2uauHRO6c
Message-ID: <CAL+tcoAQt0LYucAah_=Kighv9AcdBg4ZZFzwZx9q9=5NBXP21Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 10:11=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/7/25 4:07 AM, Jason Xing wrote:
> > On Fri, Feb 7, 2025 at 10:18=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >>
> >> On Fri, Feb 7, 2025 at 10:07=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>>
> >>> On 2/5/25 10:56 PM, Jason Xing wrote:
> >>>>>> I have to rephrase a bit in case Martin visits here soon: I will
> >>>>>> compare two approaches 1) reply value, 2) bpf kfunc and then see w=
hich
> >>>>>> way is better.
> >>>>>
> >>>>> I have already explained in details why the 1) reply value from the=
 bpf prog
> >>>>> won't work. Please go back to that reply which has the context.
> >>>>
> >>>> Yes, of course I saw this, but I said I need to implement and dig mo=
re
> >>>> into this on my own. One of my replies includes a little code snippe=
t
> >>>> regarding reply value approach. I didn't expect you to misunderstand
> >>>> that I would choose reply value, so I rephrase it like above :)
> >>>
> >>> I did see the code snippet which is incomplete, so I have to guess. a=
faik, it is
> >>> not going to work. I was hoping to save some time without detouring t=
o the
> >>> reply-value path in case my earlier message was missed. I will stay q=
uiet and
> >>> wait for v9 first then to avoid extending this long thread further.
> >>
> >> I see. I'm grateful that you point out the right path. I'm still
> >> investigating to find a good existing example in selftests and how to
> >> support kfunc.
> >
> > Martin, sorry to revive this thread.
> >
> > It's a little bit hard for me to find a proper example to follow. I
> > tried to call __bpf_kfunc in the BPF_SOCK_OPS_TS_SND_CB callback and
> > then failed because kfunc is not supported in the sock_ops case.
> > Later, I tried to kprobe to hook a function, say,
> > tcp_tx_timestamp_bpf(), passed the skb parameter to the kfunc and then
> > got an error.
> >
> > Here is code snippet:
> > 1) net/ipv4/tcp.c
> > +__bpf_kfunc static void tcp_init_tx_timestamp(struct sk_buff *skb)
> > +{
> > +       struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > +       struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> > +
> > +       printk(KERN_ERR "jason: %d, %d\n\n", tcb->txstamp_ack,
> > shinfo->tx_flags);
> > +       /*
> > +       tcb->txstamp_ack =3D 2;
> > +       shinfo->tx_flags |=3D SKBTX_BPF;
> > +       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> > +       */
> > +}
> > Note: I skipped copying some codes like BTF_ID_FLAGS...
>
> This part is missing, so I can only guess again. This BTF_ID_FLAGS
> and the kfunc registration part went wrong when trying to add the
> new kfunc for the sock_ops program. There are kfunc examples for
> netdev related bpf prog in filter.c. e.g. bpf_sock_addr_set_sun_path.
>
> [ The same goes for another later message where the changes in
>    bpf_skops_tx_timestamping is missing, so I won't comment there. ]
>
> >
> > 2) bpf prog
> > SEC("kprobe/tcp_tx_timestamp_bpf") // I wrote a new function/wrapper to=
 hook
> > int BPF_KPROBE(kprobe__tcp_tx_timestamp_bpf, struct sock *sk, struct
> > sk_buff *skb)
> > {
> >          tcp_init_tx_timestamp(skb);
> >          return 0;
> > }
> >
> > Then running the bpf prog, I got the following message:
> > ; tcp_init_tx_timestamp(skb); @ so_timestamping.c:281
> > 1: (85) call tcp_init_tx_timestamp#120682
> > arg#0 pointer type STRUCT sk_buff must point to scalar, or struct with =
scalar
> > processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> > libbpf: prog 'kprobe__tcp_tx_timestamp_bpf': failed to load: -22
> > libbpf: failed to load object 'so_timestamping'
> > libbpf: failed to load BPF skeleton 'so_timestamping': -22
> > test_so_timestamping:FAIL:open and load skel unexpected error: -22
> >
> > If I don't pass any parameter in the kfunc, it can work.
> >
> > Should we support the sock_ops for __bpf_kfunc?
>
> sock_ops does support kfunc. The patch 12 selftest is using the
> bpf_cast_to_kern_ctx() and it is a kfunc:
>
> --------8<--------
> BTF_KFUNCS_START(common_btf_ids)
> BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
> -------->8--------
>
> It just the new kfunc is not registered at the right place, so the verifi=
er
> cannot find it.
>
> Untested code on top of your v8, so I don't have your latest
> changes on the txstamp_ack_bpf bits...etc.

Thanks for sharing your great understanding of BPF. And it's working!
Many thanks here.

>
> diff --git i/kernel/bpf/btf.c w/kernel/bpf/btf.c
> index 9433b6467bbe..740210f883dc 100644
> --- i/kernel/bpf/btf.c
> +++ w/kernel/bpf/btf.c
> @@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pro=
g_type prog_type)
>         case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>         case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>         case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +       case BPF_PROG_TYPE_SOCK_OPS:

The above line is exactly what I want (before this, I had no clue
about how to write this part), causing my whole kfunc feature not to
work.

>                 return BTF_KFUNC_HOOK_CGROUP;
>         case BPF_PROG_TYPE_SCHED_ACT:
>                 return BTF_KFUNC_HOOK_SCHED_ACT;
> diff --git i/net/core/filter.c w/net/core/filter.c
> index d3395ffe058e..3bad67eb5c9e 100644
> --- i/net/core/filter.c
> +++ w/net/core/filter.c
> @@ -12102,6 +12102,30 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct _=
_sk_buff *s, struct sock *sk,
>   #endif
>   }
>
> +enum {
> +       BPF_SOCK_OPS_TX_TSTAMP_TCP_ACK =3D 1 << 0,
> +};

Could I remove this flag since we have BPF_SOCK_OPS_TS_ACK_OPT_CB to
control whether to report or not?


> +
> +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *=
skops, int flags)
> +{
> +       struct sk_buff *skb;
> +
> +       if (skops->op !=3D BPF_SOCK_OPS_TS_SND_CB)
> +               return -EOPNOTSUPP;
> +
> +       if (flags & ~BPF_SOCK_OPS_TX_TSTAMP_TCP_ACK)
> +               return -EINVAL;
> +
> +       skb =3D skops->skb;
> +       /* [REMOVE THIS COMMENT]: sk_is_tcp check will be needed in the f=
uture */
> +       if (flags & BPF_SOCK_OPS_TX_TSTAMP_TCP_ACK)
> +               TCP_SKB_CB(skb)->txstamp_ack_bpf =3D 1;
> +       skb_shinfo(skb)->tx_flags |=3D SKBTX_BPF;
> +       skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> +
> +       return 0;
> +}
> +
>   __bpf_kfunc_end_defs();
>
>   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12135,6 +12159,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
>   BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
>   BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
>
> +BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
> +BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> +
>   static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
>         .owner =3D THIS_MODULE,
>         .set =3D &bpf_kfunc_check_set_skb,
> @@ -12155,6 +12183,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_s=
et_tcp_reqsk =3D {
>         .set =3D &bpf_kfunc_check_set_tcp_reqsk,
>   };
>
> +static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &bpf_kfunc_check_set_sock_ops,
> +};
> +
>   static int __init bpf_kfunc_init(void)
>   {
>         int ret;
> @@ -12173,6 +12206,7 @@ static int __init bpf_kfunc_init(void)
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_=
kfunc_set_xdp);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR,
>                                                &bpf_kfunc_set_sock_addr);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, =
&bpf_kfunc_set_sock_ops);
>         return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, =
&bpf_kfunc_set_tcp_reqsk);
>   }

