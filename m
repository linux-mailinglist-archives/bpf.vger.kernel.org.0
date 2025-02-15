Return-Path: <bpf+bounces-51670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A287A3700F
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9CC16ACA4
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8031EA7F8;
	Sat, 15 Feb 2025 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8UeBscu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C9197A87;
	Sat, 15 Feb 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642516; cv=none; b=d+Hnl/6VGR0ZYc3TMH4vKsj6WMSqEhzw51ziF4QwLmlrNPvCfj5OoBTMqWzV5mbqUdWHdaEk44WcHGOS/l8scuBUBFufFzM+F7sl46yrL2wmpAx5PtmEEegxoguDnuwF1AN2DL0bfE6mTJX49XTVusIzpfmn7duBjU9Hbomsrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642516; c=relaxed/simple;
	bh=CRu8qdMMAr2/jto8DQG8XacUOrRi06FLL6dM4M3Zs78=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i1gVF8S20tNpk1hSEVZOa4XzDjBJI/EVEvn0SWNl7BJKtycS8+6vZYRl4jLwnBxLcG6BlqAMFN91yr6O0FulfY1kLdvwSMjf8EZf2pTtq4OyU5UfoY9bHnd6qrV/2iXJhEXzoszPB9PmktqGrnz+hPH/Dob5bG8yCrBix15wIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8UeBscu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6df83fd01cbso15076866d6.2;
        Sat, 15 Feb 2025 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739642513; x=1740247313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3cFRLo43GGdCsmyQP/7i7TCGb3Lm0Df2Bbv8+YsFOU=;
        b=J8UeBscu0DMPNjNHDfnWA9R+Aj1/GRU7gK5IAzVVhleeIfjoBkxB0lPoRkvwOHsxk8
         AdqrHuuBYvCG5hAW8/zMcnt8WmqoyxF2JR/AYpNYVV+GpscwP4SP7P2Wq812FKaM+D8u
         CRtdqn3PTi8JWucmbTwEz8XZ11f3DFcuV3uOEMRN2ZjYuFR+itYbRn/U24iZ8I17awLu
         mnVFSfO6X+H6Z0Fiub8jBF+j9jPjIScyNxrEIqJbSnSLrpze0Tu1BYDGwu2GDcq3SJlZ
         QQT9junOv3TtIn4VCl6zZ7J42NX9EE+OsY+iIUn5/KcLHgNlLs3EQtMXdrp1h2WgHidh
         GCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739642513; x=1740247313;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R3cFRLo43GGdCsmyQP/7i7TCGb3Lm0Df2Bbv8+YsFOU=;
        b=lo/ZYmjDb0tVFjMmTOBbO5taMxVnphadAhk/RI5FcBh2ZnpGYnSM0Vaukd0fmvee2/
         YFD0CIbdLucgxIpbl6SudGLdiCNFuxO9nuTz0G30/JUz6f3ZDNREBLDpmUr8mwD25rvS
         466HfWzYRATEIengR06jtcdYb0TxyXyBEzJeEj5wpadpX77VYZUl2nINt/ATfB1mjRMk
         poMveOCMV9Ef1dqAkuRgnQLqhc/cFveAKiZ6t6wEx4BXCk9eYjaDdzK4QFF686L33c3q
         qsMX2GI0ydowO0+j/u4pyBEPSHPvUvcMgKmXlJ/n0WKJ1vpUgZPxt/aCXhlQLTV/KVfu
         jiTA==
X-Forwarded-Encrypted: i=1; AJvYcCVMwiIT4ZLNlBvX09aaxLdXbrUWG5Y/DqFwNml0kwOB8gGC5ABgGHBJfENUQXwu7uvvRiU=@vger.kernel.org, AJvYcCWY0+V2tp8eiDUjhWG/tGIYiaz5UfVuJm3iFZUxO9rC56myK89CrwCtaetJv1eOWUjvWgbDcxey@vger.kernel.org
X-Gm-Message-State: AOJu0YypzAJT+AJkx3rMLo+XzYi8dLYqmHUeuBeH6cxwouPTvlmdAo9f
	PUwNZIVrKodzOhQJFd19SqjvLwy/KePdqpftp7wBdYxU5r543UVo
X-Gm-Gg: ASbGncshk/FqEEySNq1dQVt1qwIRhk4ON+tRt2uZPPfNJFSGXGadpylKvdAjCiuSE1K
	o07eFjxTB7IwyGizoVbu0/pzfsxiFocIC9BElF6jbNo/Lt3+kf2agGJDUdcYLdDj7nt4QVsAnqQ
	PqiZAfxXKppqMWRvB+gytwz+cQ/8BNq/pQqUvXZKsYLWmeJKlZteGCPyXE+jTJOxhTGLgitHlhH
	IF35eIvbQAQLT+2q8yg9HmpPmiG1RIMFDxBhh95x8O1pm0SUfj10wZDQRMNCpKovyD3v75+5bnl
	AtZd9WfvKuf+bqED/gzP2nw7VLQndNbJ5u6C+NQBQDa45rSjgjsR+wYjucoAGnw=
X-Google-Smtp-Source: AGHT+IHakoDgwoQiCgGcpxANcnRWxZKzksOUdSpd3tx8JkUX6HgxYLoxX+lnp6asqxMGvWgoOl71Cg==
X-Received: by 2002:a05:6214:518d:b0:6e4:3f59:56c9 with SMTP id 6a1803df08f44-6e66cce1d1amr47976146d6.17.1739642513086;
        Sat, 15 Feb 2025 10:01:53 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7793f5sm34088676d6.5.2025.02.15.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 10:01:52 -0800 (PST)
Date: Sat, 15 Feb 2025 13:01:52 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67b0d6906ee9c_381893294da@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC=PROxQfPoa_LGJZ0JAPW1XuqSnTTHwJssjsC7-MPV_A@mail.gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-12-kerneljasonxing@gmail.com>
 <67b0ae562fc79_36e344294ab@willemb.c.googlers.com.notmuch>
 <CAL+tcoC=PROxQfPoa_LGJZ0JAPW1XuqSnTTHwJssjsC7-MPV_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 11/12] bpf: support selective sampling for
 bpf timestamping
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Sat, Feb 15, 2025 at 11:10=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Add the bpf_sock_ops_enable_tx_tstamp kfunc to allow BPF programs t=
o
> > > selectively enable TX timestamping on a skb during tcp_sendmsg().
> > >
> > > For example, BPF program will limit tracking X numbers of packets
> > > and then will stop there instead of tracing all the sendmsgs of
> > > matched flow all along. It would be helpful for users who cannot
> > > afford to calculate latencies from every sendmsg call probably
> > > due to the performance or storage space consideration.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >  kernel/bpf/btf.c  |  1 +
> > >  net/core/filter.c | 33 ++++++++++++++++++++++++++++++++-
> > >  2 files changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 9433b6467bbe..740210f883dc 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -8522,6 +8522,7 @@ static int bpf_prog_type_to_kfunc_hook(enum b=
pf_prog_type prog_type)
> > >       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> > >       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> > >       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> > > +     case BPF_PROG_TYPE_SOCK_OPS:
> > >               return BTF_KFUNC_HOOK_CGROUP;
> > >       case BPF_PROG_TYPE_SCHED_ACT:
> > >               return BTF_KFUNC_HOOK_SCHED_ACT;
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 7f56d0bbeb00..3b4c1e7b1470 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -12102,6 +12102,27 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(st=
ruct __sk_buff *s, struct sock *sk,
> > >  #endif
> > >  }
> > >
> > > +__bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_=
kern *skops,
> > > +                                           u64 flags)
> > > +{
> > > +     struct sk_buff *skb;
> > > +     struct sock *sk;
> > > +
> > > +     if (skops->op !=3D BPF_SOCK_OPS_TS_SND_CB)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     if (flags)
> > > +             return -EINVAL;
> > > +
> > > +     skb =3D skops->skb;
> > > +     sk =3D skops->sk;
> >
> > nit: not used
> =

> BPF programs can use this in the future if necessary whereas the
> selftests don't reflect it.

How does defining a local variable help there?
 =

> >
> > > +     skb_shinfo(skb)->tx_flags |=3D SKBTX_BPF;
> > > +     TCP_SKB_CB(skb)->txstamp_ack |=3D TSTAMP_ACK_BPF;
> > > +     skb_shinfo(skb)->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - =
1;
> >
> > Can this overwrite the seqno previously calculated by tcp_tx_timestam=
p?
> =

> seqno? If you are referring to seqno, I don't think the BPF program is
> allowed to modify it because SOCK_OPS_GET_OR_SET_FIELD() only supports
> overwriting sk_txhash only. Please see sock_ops_convert_ctx_access().

I meant tskey=

