Return-Path: <bpf+bounces-51675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C7A370D3
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 22:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5988D16FB12
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11FF1FC0FC;
	Sat, 15 Feb 2025 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1DMSe4k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CC1EA7C0;
	Sat, 15 Feb 2025 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739653910; cv=none; b=hnHKj5hi2wP55C/mDwdvZB8BBm1m4mxJF6V+Gy0aIZipmOOxPV1XbLQFa5D/qaFcjoL0Vq7esIMvw+hdBz1+FbVqOwew3/q/yFhu/LIMX+XM/NZ7HOvyJCpBmzved2JTQWTxYwSy6vNhaLaqUsTr6RUdwM7xIRu7Fw81r1H+dDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739653910; c=relaxed/simple;
	bh=nw81fQRTWtFHoZwaNiOMqnklz1cWx/vn28Qh6LB7fts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKoALG7I0keipnrUrUf3RVPhBW0Cd+A5WkbmXozHdUvqrBzhLsnKd+2Lp3UBkDoSRa5O775+su3O9YAx1uWdesATpIvqRmFKlYHJ3Fp7OcJnyxezp57wZMRo70oWo9HuJwGwIFM1843h8cY05hWFN96mavfCJNlo9KHyGRNHzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1DMSe4k; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d193fc345aso6945505ab.2;
        Sat, 15 Feb 2025 13:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739653907; x=1740258707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v78TMsOUIcQOvQE5LpJzgcK6y9xjwiFAdxmxf+5gej0=;
        b=I1DMSe4kJtcwlj+OOcYXwVlmybnvMY0MH1p5S79jwAEvaivtAAz8ka4J11BTijJl7/
         npA42T3tHpKQYwJ44wPYFYl+1esL6J1FsGDe7sL+EB1nYTs/Z5KtBm782dVjpSsmu3a1
         KebczvIVuVx7LQob4AlV8WFfArIpQCR7f92h1DOwgUUVWAORii1K34Jr9LzuMUx7NaiF
         4RAbwgcGpI+yQE+rzmcuihs8AuGD1Q5nJKkPvc+Y2NrPUGUdC/dxt//nyvcU9X4OTmtP
         XH0T2KUtSHlkG8qfaz3sppnHfQdXJ3QAWLsPi5ivVa26QhT+KokznxmI8RgIJm7Me4I7
         /aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739653907; x=1740258707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v78TMsOUIcQOvQE5LpJzgcK6y9xjwiFAdxmxf+5gej0=;
        b=FRixYE1RQjGOURbD9TGWeHIptTXfNXx5RWQwi7PErb7Pa1bDR/ZscF4ZnGvZmq0UDA
         pZsebwRY7xDkB1bmjwZ6Sw4YM5it/jb/iAbqEfPwdnYSZTJjgVwE0ETDhOjxJ/fuzJji
         ZKB/9TBcc7D3CQzc/eZogCNuHhc7BdJONJY8zE9PPMxR+MsGX3Z87QBhb/zi6E2X9Lve
         /xXNgcHwjk0yX6RQz1AIKHymRwrszi4BTfXx/a7ThdIHcUiAnSZN0pwD3B9912J7Ae/Q
         QGtlYRvud7MhGmxn4oldApAEUCBQnEoCxCULmJTS3ejEvTQ0IBAZdNp/kGYJ9MG5Lvc7
         +Yog==
X-Forwarded-Encrypted: i=1; AJvYcCVRh8E4K/Lb+1SWGDWd614/NvXgS/gPlY5IR3dmBZETPRyxXNawWf9DpkQCqCYPWd3eXbY=@vger.kernel.org, AJvYcCVh2CdhpvjP4/a4rCgdqYG04Y/36qmwhjKu1q0YgIFCDCTSS7HaQE1lj3y0AgMd188F6J2NHANP@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWQVRXNyid8+5fmGP1VN2s0AXyS2ADJJWSQ7n9Qk9LYQVqp4q
	KO1//cnpfhHkxowvINPIq9WkF0Zi4M3MYvYykztqClCilsyiC+wCg9CMqZsdSBMiRm2KSKAVBFW
	EyOlpaXpnPE0ZoTlY3mvIjsU+xkk=
X-Gm-Gg: ASbGnctPxHR0h2KpE7XA0zdWTlHSlcEpqsdQ2zhHUJNkgep3Z7skKEO/1gx9qrSIiVq
	0pKAAI3YoffsW2qa5rfX7k9mJ1mfs/Fyq9LSvnN/xKcmqdc60vbUOFpZHhq6Gexe/oRySo9A=
X-Google-Smtp-Source: AGHT+IFuAwtN03VwLYf2QZqC4VE+Vmytw4fR3hV7wW0zLScVogoM/Kk/aZUSN7nTJL69c5hoSKfkINlnhRVIO3efuIU=
X-Received: by 2002:a05:6e02:3103:b0:3d1:9cee:3d11 with SMTP id
 e9e14a558f8ab-3d28076e0d3mr36244305ab.3.1739653907588; Sat, 15 Feb 2025
 13:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-12-kerneljasonxing@gmail.com> <67b0ae562fc79_36e344294ab@willemb.c.googlers.com.notmuch>
 <CAL+tcoC=PROxQfPoa_LGJZ0JAPW1XuqSnTTHwJssjsC7-MPV_A@mail.gmail.com> <67b0d6906ee9c_381893294da@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b0d6906ee9c_381893294da@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 05:11:11 +0800
X-Gm-Features: AWEUYZlUHkGz809iBMD1SA0e3lN1r-I-NHn6e1zkc6SEXypXN_p_FMfQvuvz2II
Message-ID: <CAL+tcoCoyFC=gCag+pLVeQ9tyiwzsjG-qedpUBNop4wxCQEw=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 11/12] bpf: support selective sampling for
 bpf timestamping
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 2:01=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Sat, Feb 15, 2025 at 11:10=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs t=
o
> > > > selectively enable TX timestamping on a skb during tcp_sendmsg().
> > > >
> > > > For example, BPF program will limit tracking X numbers of packets
> > > > and then will stop there instead of tracing all the sendmsgs of
> > > > matched flow all along. It would be helpful for users who cannot
> > > > afford to calculate latencies from every sendmsg call probably
> > > > due to the performance or storage space consideration.
> > > >
> > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > ---
> > > >  kernel/bpf/btf.c  |  1 +
> > > >  net/core/filter.c | 33 ++++++++++++++++++++++++++++++++-
> > > >  2 files changed, 33 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 9433b6467bbe..740210f883dc 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum b=
pf_prog_type prog_type)
> > > >       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> > > >       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> > > >       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> > > > +     case BPF_PROG_TYPE_SOCK_OPS:
> > > >               return BTF_KFUNC_HOOK_CGROUP;
> > > >       case BPF_PROG_TYPE_SCHED_ACT:
> > > >               return BTF_KFUNC_HOOK_SCHED_ACT;
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 7f56d0bbeb00..3b4c1e7b1470 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -12102,6 +12102,27 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(st=
ruct __sk_buff *s, struct sock *sk,
> > > >  #endif
> > > >  }
> > > >
> > > > +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_=
kern *skops,
> > > > +                                           u64 flags)
> > > > +{
> > > > +     struct sk_buff *skb;
> > > > +     struct sock *sk;
> > > > +
> > > > +     if (skops->op !=3D BPF_SOCK_OPS_TS_SND_CB)
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     if (flags)
> > > > +             return -EINVAL;
> > > > +
> > > > +     skb =3D skops->skb;
> > > > +     sk =3D skops->sk;
> > >
> > > nit: not used
> >
> > BPF programs can use this in the future if necessary whereas the
> > selftests don't reflect it.
>
> How does defining a local variable help there?

Sorry, I didn't state it clearly. I meant you're right, for now it is
useless, but for the future... Right, I will remove it.

>
> > >
> > > > +     skb_shinfo(skb)->tx_flags |=3D SKBTX_BPF;
> > > > +     TCP_SKB_CB(skb)->txstamp_ack |=3D TSTAMP_ACK_BPF;
> > > > +     skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - =
1;
> > >
> > > Can this overwrite the seqno previously calculated by tcp_tx_timestam=
p?
> >
> > seqno? If you are referring to seqno, I don't think the BPF program is
> > allowed to modify it because SOCK_OPS_GET_OR_SET_FIELD() only supports
> > overwriting sk_txhash only. Please see sock_ops_convert_ctx_access().
>
> I meant tskey

It 'overwrites' the tskey here if the socket timestamping feature is
also on. But the seqno and len would not change during the gap between
tcp_tx_timestamp() and bpf_sock_ops_enable_tx_tstamp(), I think? If
the seq and len doesn't change, then the tskey will not be truly
overwritten with a different value. Unless you probably expect to see
this:

if (!skb_shinfo(skb)->tskey)
        skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
?

From my perspective, the final result is the same :)

Thanks,
Jason

