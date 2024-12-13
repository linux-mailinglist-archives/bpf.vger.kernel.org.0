Return-Path: <bpf+bounces-46867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA59F1139
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99423282BE7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBF11E0DE3;
	Fri, 13 Dec 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll7rrHzJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C0158D80;
	Fri, 13 Dec 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104712; cv=none; b=rb275vOjWvFsRQNoJfLiuw6LmBE1ZRnxzvdUghqyhzcWkTc6pATy0bRCVMQ3p2Guylqo5wqbrszdDczv7xF6EZc+5PmsO1Izrc6LxrFaxmgQkfJIPTGdtjHtsx0SIY34x5xlHWBhJ9cB54T2gBxzEqwTXcpUVRMs/xcZblNMh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104712; c=relaxed/simple;
	bh=pQV04T28yKXyB45MBWGS+eAwnSvswfhwmRhvCl6hBsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/cSQBsIJr8uT3iKonZ41Pn5yZScW6nDCPvcS/Ajn48R6QGHP63Cjs4/J8Nng0pg2ByslLsUr9xi6nGT6NpmUmCcGeXWA5VY4rpxcYI+/h/s5aD0WbCuFD/FT3ub5Pvekbf3zk2N8T5cLzX76hSHAZ7vbpYKK6Bf5Ke9dKme72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll7rrHzJ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a7d7c1b190so6557545ab.3;
        Fri, 13 Dec 2024 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734104710; x=1734709510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdLCryXHVXWdUEQGqJUqoTPzEG99j9zrpJMlLFpm9+8=;
        b=ll7rrHzJcTw7R4n+NevdHTXVqh/VpmcLhqezhf0KRXAPGaW3on8do/Vbk4YscE0Dyo
         KYCkVbciYysFw4pfvO6knStukqGMEaOmngNxGbs1oHHmWIzmpr9zRzz9eaDAmddc+kDJ
         QRdHxrDmzhsvF5hjiVFPahjBCdcgPQ39NiOIWa4X3YCQWZJfJKpxoyEXyINrZde499SW
         R3/tM5kksFURRbq2iTz5AQk3+XrKfgA5/s3/MFdbDw30gtLJ7CfkU8YVs3FlMp+U9+Wy
         oLINnL2h7NYMbq77sKCJtjrtAgObeqeMTWgeLUf4FC2nN1ivSpF04pF4e1NbHAg6KsCA
         VzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104710; x=1734709510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdLCryXHVXWdUEQGqJUqoTPzEG99j9zrpJMlLFpm9+8=;
        b=ilAkUP2qnEihBr50khfArZa2e3l11EodNaeqV+xTcM4cWasMnqJserkK1bqyV2L040
         G3SI5Gmz3aI+O4Kn6iYgfqMPACBu7lqSo48/nwaUn2d+R7U8k0dRc+h4P3LRC7GlEiYl
         9sOBedy1jnRNyRK9gyPa53A0pP1LS8pUvZoYqWjM2eQN+s1vlsujLP5RKbAM7mO2VGXx
         3QsyP4SigetkBqc5tue0opaBxiKwNIJOjCks88CWdI4qXHzmc/lZsR5RwpHx+RyvWAJV
         EBaVxRp6itPz9f2mti8FsCaYV9l91bUHkkJQbsqPBJfg5P8eKTn824q7PeOM90gJjY2x
         tggA==
X-Forwarded-Encrypted: i=1; AJvYcCWpqfV4sZU2o2ittk85zV7WD76IdToD7tEVUniz1Bt/tMYKWneMW/FaRLfcj1udqF/wyYc=@vger.kernel.org, AJvYcCXDsN4/3GtklW0t+0kjEl5FyBHGN1Nd0q3PYnsZK+9jsCyNToDdgKd8fQJsvBWsxHQ2dJLcTsDX@vger.kernel.org
X-Gm-Message-State: AOJu0YweO8HlZEz4mJYU/6ZLGjs90CrlaxdOhqo2ntYICuXzjpwEeX/O
	RvxtWkbGky1cRAbxMPeN5Zxa6sL5ghlCPazU+r8EUxVfHSZDQzHJpGf09od90xYUPpldjmZo7P+
	/fTWS1YejeNSxCtI1GWpwCul8oZc=
X-Gm-Gg: ASbGnctBe1oV29oyRd27KYGPhxKiBkw4pljvv+Ks13BC7Tlw9u+mwBY5kMtgpa8QAhr
	4ONh4SGI0qBXISC264Kj0u2rEcqqcHgoX84YQ3A==
X-Google-Smtp-Source: AGHT+IEO8bMjZqEqfBdyT4Z2IPeiay/Z1DSYQEJKaduztZhZmFlZbHIBnArrJ+4wGNQuZx9ekLBJIGSrmHGUGleWPF8=
X-Received: by 2002:a05:6e02:156f:b0:3a7:e452:db5 with SMTP id
 e9e14a558f8ab-3aff800ffcfmr30340235ab.15.1734104710017; Fri, 13 Dec 2024
 07:45:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com> <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
In-Reply-To: <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 13 Dec 2024 23:44:34 +0800
Message-ID: <CAL+tcoCCvKapSQ8N48iKh83YxYskDkPyM+bpT5=m8cE_YrCovg@mail.gmail.com>
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

On Fri, Dec 13, 2024 at 8:28=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/7/24 9:38 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For now, there are three phases where we are not able to fetch
> > the right seqno from the skops->skb_data, because:
> > 1) in __dev_queue_xmit(), the skb->data doesn't point to the start
> > offset in tcp header.
> > 2) in tcp_ack_tstamp(), the skb doesn't have the tcp header.
> >
> > In the long run, we may add other trace points for bpf extension.
> > And the shinfo->tskey is always the same value for both bpf and
> > non-bpf cases. With that said, let's directly use shinfo->tskey
> > for TCP protocol.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   net/core/skbuff.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 7c59ef501c74..2e13643f791c 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5544,7 +5544,7 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, =
struct sk_buff *skb,
> >                               int tstype)
> >   {
> >       struct timespec64 tstamp;
> > -     u32 args[2] =3D {0, 0};
> > +     u32 args[3] =3D {0, 0, 0};
> >       int op;
> >
> >       if (!sk)
> > @@ -5569,7 +5569,10 @@ static void __skb_tstamp_tx_bpf(struct sock *sk,=
 struct sk_buff *skb,
> >               return;
> >       }
> >
> > -     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
> > +     if (sk_is_tcp(sk))
> > +             args[2] =3D skb_shinfo(skb)->tskey;
>
> Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pass =
the
> whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets st=
art
> with end_offset =3D 0 for now so that the bpf prog won't use it to read t=
he
> skb->data. It can be revisited later.
>
>         bpf_skops_init_skb(&sock_ops, skb, 0);
>
> The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get to=
 the
> skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.

Sorry, I didn't give it much thought on getting to the shinfo. That's
why I quickly gave up using bpf_skops_init_skb() after I noticed the
seq of skb is always zero :(

I will test it tomorrow. Thanks.

>
> Then it needs to add a bpf_sock->op check to the existing
> bpf_sock_ops_{load,store}_hdr_opt() helpers to ensure these helpers can o=
nly be
> used by the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, BPF_SOCK_OPS_HDR_OPT_LEN_CB, a=
nd
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB callback.

Forgive me. I cannot see how the bpf_sock_ops_load_hdr_opt helper has
something to do with the current thread? Could you enlighten me?

>
> btw, how is the ack_skb used for the SCM_TSTAMP_ACK by the user space now=
?

To be honest, I hardly use the ack_skb[1] under this circumstance... I
think if someone offers a suggestion to use it, then we can support
it?

[1]
commit e7ed11ee945438b737e2ae2370e35591e16ec371
Author: Yousuk Seung <ysseung@google.com>
Date:   Wed Jan 20 12:41:55 2021 -0800

    tcp: add TTL to SCM_TIMESTAMPING_OPT_STATS

    This patch adds TCP_NLA_TTL to SCM_TIMESTAMPING_OPT_STATS that exports
    the time-to-live or hop limit of the latest incoming packet with
    SCM_TSTAMP_ACK. The value exported may not be from the packet that acks
    the sequence when incoming packets are aggregated. Exporting the
    time-to-live or hop limit value of incoming packets helps to estimate
    the hop count of the path of the flow that may change over time.

