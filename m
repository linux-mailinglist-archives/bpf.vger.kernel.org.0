Return-Path: <bpf+bounces-46862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A938B9F1095
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F39161838
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916FB1E22EF;
	Fri, 13 Dec 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A88Myh5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB581E1A33;
	Fri, 13 Dec 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102873; cv=none; b=RJ9Nc/c4LWVlcOTUlFl9emmMkPEq3xoQnyUaaQW8Whn4Tj4SCmgflsBn7po4hV9BhZkue9h4jhC1ima04POxrdY+4YEoXXyvhPpbbIvjrj/xqj4yYi86d7aziZAN+GnZyMV7RPW6s+4r7R0uIQOT6i/sXGpSUKocgwBFN3pg+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102873; c=relaxed/simple;
	bh=L/6bt2zuZBjuuxbl9MEknRwy3TqcGrAlQ87M7h2xAlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBVhV319pFUlwuCQ/7qnMRRRqpfBSPGpWC3Jr2ANWucZ4jRh/O4ePVwVnDfmsOl2ldPaaDMoDs+W/NWVK8BWQ/tWsYEQflBZ9BizcNaxbD70P4Z05p6Xxx3w5soYHka7+ZWgcKxax/XUUnNziPW+j9ImWTRVXiDspAZzbBqWGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A88Myh5V; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so12753795ab.2;
        Fri, 13 Dec 2024 07:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734102870; x=1734707670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+f/HxZGUZDanH3LBibTxLyZbTgAZQyGycgYH/BQoKI=;
        b=A88Myh5V/+4JdYsMH93VfyP8H2KTmqYpazkCsTMOKYYe1kMO0JHZSzK8PVCmsygHte
         2bSKzy64vtu0i9NcXXHgdPYRFdzy8hWHQAqOKbw3ekqxA5LU/kH5ei92kyNzKw3D/Cdd
         pa++jzVM/Y7dSSPaWDmM+H9k1sLEj/+KQJcj492hSJpOukwwu+eSGvHBgi1UMHanzEU6
         EuveYirBsDFXpJZeFqflvD2eqQ1K3YTaz5WUdrioK2K43BpSfaUqMwdP8S/N5rILWna3
         K97kyqIuCMENClMl7tuEnbrvXmG08g3fLm1eobf9NlstY6d6X6EGxkdRWO4tQSV+8987
         EjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102870; x=1734707670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+f/HxZGUZDanH3LBibTxLyZbTgAZQyGycgYH/BQoKI=;
        b=VIqbv0z6DUtno98ev2nvZRMGFf/aMrHYkS8P0xtf5r00ZYbg0yPuU56WWBXkD1i6Qb
         CZ40OTUKizw3dGpPdOWDcQa+lcY599ey855b7ykNhSYCly9cMw8oLb5Ozpy/qC0x2y4v
         Jy0wCy7uuFPcbZBmXCrsthZRUD5jhkGVE7kcZme8WPVeV5z+pXmuqy/BJTIT0hjQmre4
         +mvA8cQYSm8YuN+/tHVAyZzhDvZOjmuPban11FJ2i11BqWCXudkj/X8U7LplssLGnXcm
         9flYtPAC6iIqCOgmaUmQJYrCN+bR4shSCznNTr65bTO6irTUGEmPGPFscG3A5m5b+mhH
         knfA==
X-Forwarded-Encrypted: i=1; AJvYcCW7DIbRsCYBa58msPPPiKgfr4GJmb4zf/E6nfGGJ2xUnQH0jzYGWp8KNxSrnXKPmOmpb44JwqfE@vger.kernel.org, AJvYcCXmYefCmH2B5XNhusrkum0nRFYUH0mfrbFOxraQzF4e0qtdqEQBcjTCHZx2fjVVnqi+qak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HpU2YC9Jq3s6ioy8IgmF4KhQpzj12Sjx0BFz525L11WmVzsu
	lWkGPcvS2bLqZmlu64DunzBKjV4FKRCBd9Zn8jkMJ9pt2uycgKtXJJxx8ddxR46q5J2rseQyWZG
	ku7bdRcmwCzDwb8bI1nuaTm78VW0=
X-Gm-Gg: ASbGncte63cydiL/nE0e4BKkXTc53uTFtDR7RjfNWS+YjijEQKkKqTck95tpFGI+Qfi
	aXnV8B5LmiAfg0TZr6mg9SGw5nlm3eUBBFhIHMg==
X-Google-Smtp-Source: AGHT+IGLo2YwU/bo5x/0oaht8wS5GlYfG6j1MkC4wQMRi5Rhuq/SfZpNX3QPI3BHm38s5/+Z6H5ZHJB7HPySh6AmH58=
X-Received: by 2002:a92:cd83:0:b0:3a7:6e97:9877 with SMTP id
 e9e14a558f8ab-3aff1303cd1mr37865915ab.24.1734102870525; Fri, 13 Dec 2024
 07:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-8-kerneljasonxing@gmail.com> <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
In-Reply-To: <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 13 Dec 2024 23:13:53 +0800
Message-ID: <CAL+tcoCyu6w=O5y2fRSfrzDVm04SB2ycXB06uYn2+r2jSRhehA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 07/11] net-timestamp: support hwtstamp print
 for bpf extension
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

On Fri, Dec 13, 2024 at 7:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/7/24 9:37 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Passing the hwtstamp to bpf prog which can print.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/net/sock.h |  6 ++++--
> >   net/core/skbuff.c  | 17 +++++++++++++----
> >   net/core/sock.c    |  4 +++-
> >   3 files changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index f88a00108a2f..9bc883573208 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2921,9 +2921,11 @@ int sock_set_timestamping(struct sock *sk, int o=
ptname,
> >
> >   void sock_enable_timestamps(struct sock *sk);
> >   #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > -void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op);
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op,
> > +                            u32 nargs, u32 *args);
> >   #else
> > -static inline void bpf_skops_tx_timestamping(struct sock *sk, struct s=
k_buff *skb, int op)
> > +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct s=
k_buff *skb, int op,
> > +                                          u32 nargs, u32 *args)
> >   {
> >   }
> >   #endif
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 48b0c71e9522..182a44815630 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5539,8 +5539,12 @@ void skb_complete_tx_timestamp(struct sk_buff *s=
kb,
> >   }
> >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >
> > -static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, =
int tstype)
> > +static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
> > +                             struct skb_shared_hwtstamps *hwtstamps,
> > +                             int tstype)
> >   {
> > +     struct timespec64 tstamp;
> > +     u32 args[2] =3D {0, 0};
> >       int op;
> >
> >       if (!sk)
> > @@ -5552,6 +5556,11 @@ static void __skb_tstamp_tx_bpf(struct sock *sk,=
 struct sk_buff *skb, int tstype
> >               break;
> >       case SCM_TSTAMP_SND:
> >               op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
>
> > +             if (hwtstamps) {
> > +                     tstamp =3D ktime_to_timespec64(hwtstamps->hwtstam=
p);
>
> Avoid this conversion which is likely not useful to the bpf prog. Directl=
y pass
> hwtstamps->hwtstamp (in ns?) to the bpf prog. Put lower 32bits in args[0]=
 and
> higher 32bits in args[1].

It makes sense.

>
> Also, how about adding a BPF_SOCK_OPS_TS_"HW"_OPT_CB for the "hwtstamps !=
=3D NULL"
> case instead of reusing the BPF_SOCK_OPS_TS_"SW"_OPT_CB?

Good suggestion. Will do that.

>
> A more subtle thing for the hwtstamps case is, afaik the bpf prog will no=
t be
> called. All drivers are still only testing SKBTX_HW_TSTAMP instead of tes=
ting
> (SKBTX_HW_TSTAMP | SKBTX_BPF).

Ah, I didn't realize that!!

>
> There are a lot of drivers to change though. A quick thought is to rename=
 the
> existing SKBTX_HW_TSTAMP (e.g. __SKBTX_HW_TSTAMP =3D 1 << 0) and define
> SKBTX_HW_TSTAMP like:
>
> #define SKBTX_HW_TSTAMP (__SKBTX_HW_TSTAMP | SKBTX_BPF)

I will take it, thanks!

>
> Then change some of the existing skb_shinfo(skb)->tx_flags "setting" site=
 to use
> __SKBTX_HW_TSTAMP instead. e.g. in __sock_tx_timestamp(). Not very pretty=
 but
> may be still better than changing many drivers. May be there is a better =
way...

I agree with your approach. Changing so many drivers would be a head-ache t=
hing.

>
> While talking about where to test the SKBTX_BPF bit, I wonder if the new
> skb_tstamp_is_set() is needed. For the non SKBTX_HW_TSTAMP case, the numb=
er of
> tx_flags testing sites should be limited, so should be easy to add the SK=
BTX_BPF
> bit test. e.g. at the __dev_queue_xmit, test "if
> (unlikely(skb_shinfo(skb)->tx_flags & (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))"=
. Patch
> 6 has also tested the bpf specific bit at tcp_ack_tstamp() before calling=
 the
> __skb_tstamp_tx().
>
> At the beginning of __skb_tstamp_tx(), do something like this:
>
> void __skb_tstamp_tx(struct sk_buff *orig_skb,
>                      const struct sk_buff *ack_skb,
>                      struct skb_shared_hwtstamps *hwtstamps,
>                      struct sock *sk, int tstype)
> {
>         if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>             unlikely(skb_shinfo(skb)->tx_flags & SKBTX_BPF))
>                 __skb_tstamp_tx_bpf(sk, orig_skb, hwtstamps, tstype);
>
>         if (unlikely(!(skb_shinfo(skb)->tx_flags & ~SKBTX_BPF)))
>                 return;
>
> Then the new skb_tstamp_tx_output() shuffle is probably not be needed als=
o.
>
> > +                     args[0] =3D tstamp.tv_sec;
> > +                     args[1] =3D tstamp.tv_nsec;
> > +             }
> >               break;
> >       case SCM_TSTAMP_ACK:
> >               op =3D BPF_SOCK_OPS_TS_ACK_OPT_CB;
> > @@ -5560,7 +5569,7 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, =
struct sk_buff *skb, int tstype
> >               return;
> >       }
> >
> > -     bpf_skops_tx_timestamping(sk, skb, op);
> > +     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
> >   }
> >
> >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> > @@ -5651,7 +5660,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >       if (unlikely(skb_tstamp_is_set(orig_skb, tstype, false)))
> >               skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, ts=
type);
> >       if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
> > -             __skb_tstamp_tx_bpf(sk, orig_skb, tstype);
> > +             __skb_tstamp_tx_bpf(sk, orig_skb, hwtstamps, tstype);
> >   }
> >   EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
> >
> > @@ -5662,7 +5671,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
> >
> >       skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk, tst=
ype);
> >       if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
> > -             __skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, tstype);
> > +             __skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, hwtstamps, ts=
type);
> >   }
> >   EXPORT_SYMBOL_GPL(skb_tstamp_tx);
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 79cb5c74c76c..504939bafe0c 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -942,7 +942,8 @@ int sock_set_timestamping(struct sock *sk, int optn=
ame,
> >   }
> >
> >   #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > -void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op)
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op,
> > +                            u32 nargs, u32 *args)
>
> Directly pass hwtstamps->hwtstamp instead of args and nargs. Save a memcp=
y below.
>
> >   {
> >       struct bpf_sock_ops_kern sock_ops;
> >
> > @@ -952,6 +953,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, str=
uct sk_buff *skb, int op)
> >       sock_ops.op =3D op;
> >       sock_ops.is_fullsock =3D 1;
> >       sock_ops.sk =3D sk;
> > +     memcpy(sock_ops.args, args, nargs * sizeof(*args));
> >       __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
> >   }
> >   #endif
>

