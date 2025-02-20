Return-Path: <bpf+bounces-52045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52002A3D07C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 05:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2430817B769
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 04:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163251E0B8A;
	Thu, 20 Feb 2025 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpJWnylv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DEF14B08A;
	Thu, 20 Feb 2025 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025957; cv=none; b=WrkrvNgDGP7kX4vdM0hCcGs7Wi38XpBter3/JFFTd0hAUnghrzltL0DGC/O/lHzoR/IhWPK7HHTQueaqLKIg4o+lQmqspOh8Q0CyLkuCdz3lIo4kCehf3OHbK5oWJ0+/efeE4CwAH/5YPGqhcNHSND4KO4dSzprUQfq9xCg1E6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025957; c=relaxed/simple;
	bh=SKZCxD50Jt76Ugfelk4OVMz+uujiqMTJJNB1qpthzB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdmmKjP1HFY0Cmn+EjoSNk0GCENmprZNBqfN2xgpakEg3/ffkkaickaHiwEJMbl13nARgRFuu018yA0YbbM4XYldYXVgwWEkJWNEvgMCMNITF5eVIo5FLaTC0kR1DvVpqKUpF7xoT7344kHvs288uwzXVDT9nS+kb07sy7mkNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpJWnylv; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce868498d3so1457035ab.3;
        Wed, 19 Feb 2025 20:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740025955; x=1740630755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlhrHRtnl6QVlg0XdKsn8okUll/GbqAn5N3acYVnDaM=;
        b=DpJWnylvfg4afv/WCcMyuJKCJdXsBvFGAwFci70R6EY6RYUH4/dyJHqa4jQp7LO0BU
         9JiGwSC7IjZjpLtM4Ua+lOSwchXuFSqHrgw7YCrN7gBZ1pRwDlJvuvnEHB7pKdad+pgV
         GgzPb8qbnrsBQNN4mfUx9xSq61RgiAS7PCv28iqQS1U8weZ2mp06YuADf+CSrV8BABya
         xEI/ofbSBKJQ+AtTvuk3WGXLJGl5rWwAHIBcHRRBx4aECMpjkWgdHDsrE0eC+b4jvqyE
         aIup2+k/wmkqa5pVaBY/NmasQOigDRUwpCYKhJnCCbBK0aTvbUHpexdrnQHOdNKgF0AI
         fp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740025955; x=1740630755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlhrHRtnl6QVlg0XdKsn8okUll/GbqAn5N3acYVnDaM=;
        b=aCWu7HG2zeCs0IOIv5/5YFgXZITxIdEWq5dObXnoAdhIgZayM1k7TCzw9PNjE/9gtQ
         Xhh1lrYmvoc52CXg/QOb7IjzNEnHFgU/f2xXwpuQFZlY+WZilsl1QlsuEaaPM4VRo1WW
         1corjp2Zt2nMqUmayvYQTRQ7Q4doJP4H05A9wfQSYz/wkiR/iQvyVe4XlkoZy4jC6ImX
         35pv6n8iPshOs90FMfqsI48Z1Ke6OiOvToPRmqwjQj8PD7NlHAC19Rp0/5c91DgnARoa
         7wHdhfequooReCPF1zBkcQxb3sQKmCEzvE4UFX08ivA8grwt+wRyDVZthyv2s342zMGj
         bTQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0cMA+nOWbuo9GsJhS5/cJQQxSnC6jXf5VZaJuFaZYDccI9/tdgRSuZye2gfWcc614Bzt5OAiw@vger.kernel.org, AJvYcCXW7Vzq9qZ5d4f0uQg81Qi+DoBf0bdPKHUJqPIKZZTpyb4JxKqn4PenBgGbtzYX+uRRlUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7BfyHa23KzLyFl//mj0JG3davvqHt8QyfSAn+/MyYkythGqI
	D37zZDIb2h875jltFfZg0jcMbFhC8DNwlhYFsMPcAq5xrV7F8vwNXAQhTkDIhdxWYcYrsjyHrGR
	uoeTEls8ZV/lhZLOd3sdQ5WD9gMs=
X-Gm-Gg: ASbGncuBHRO26S2GHa3nKdwhVvw6jVLQ8s8yCAeoOrMdqrpjA7rP0RNF/tO12mf6Go/
	AkP26gtHoWPlTxVHzhGyUbs18+iPILVknW3+dihnwG4yRCa8yaWoN2KfPQ6xymY61Ce+ndgB8
X-Google-Smtp-Source: AGHT+IGdiYkNkchThG3OjSrMP/7EMmV93VaNdcXH2UlbYg65Jgf8nH+m7RV+Zx9BDe0GQ7tY2WxEd3vfr/WKi+C+Z/I=
X-Received: by 2002:a05:6e02:20e1:b0:3d2:5a0a:7227 with SMTP id
 e9e14a558f8ab-3d2807b098fmr163795315ab.13.1740025954925; Wed, 19 Feb 2025
 20:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-11-kerneljasonxing@gmail.com> <67b699ab81a9_20efb029441@willemb.c.googlers.com.notmuch>
 <CAL+tcoDqqt3QScTHAjWGownjc8-gcMCGq=rYqB9eu=rCwoCLiQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDqqt3QScTHAjWGownjc8-gcMCGq=rYqB9eu=rCwoCLiQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 12:31:58 +0800
X-Gm-Features: AWEUYZktyVQKFt3mBXWXxdM232rlWzho5BRbNUgXXh4fk3S2zwrViReAOam2GRg
Message-ID: <CAL+tcoCpGowFrRrTFSXXWL6OirR6TmCYm6Eu=b9ZyRNqrVfgpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:15=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Thu, Feb 20, 2025 at 10:55=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > This patch introduces a new callback in tcp_tx_timestamp() to correla=
te
> > > tcp_sendmsg timestamp with timestamps from other tx timestamping
> > > callbacks (e.g., SND/SW/ACK).
> > >
> > > Without this patch, BPF program wouldn't know which timestamps belong
> > > to which flow because of no socket lock protection. This new callback
> > > is inserted in tcp_tx_timestamp() to address this issue because
> > > tcp_tx_timestamp() still owns the same socket lock with
> > > tcp_sendmsg_locked() in the meanwhile tcp_tx_timestamp() initializes
> > > the timestamping related fields for the skb, especially tskey. The
> > > tskey is the bridge to do the correlation.
> > >
> > > For TCP, BPF program hooks the beginning of tcp_sendmsg_locked() and
> > > then stores the sendmsg timestamp at the bpf_sk_storage, correlating
> > > this timestamp with its tskey that are later used in other sending
> > > timestamping callbacks.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 5 +++++
> > >  net/ipv4/tcp.c                 | 4 ++++
> > >  tools/include/uapi/linux/bpf.h | 5 +++++
> > >  3 files changed, 14 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 9355d617767f..86fca729fbd8 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -7052,6 +7052,11 @@ enum {
> > >                                        * when SK_BPF_CB_TX_TIMESTAMPI=
NG
> > >                                        * feature is on.
> > >                                        */
> > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg sy=
scall
> > > +                                      * is triggered. It's used to c=
orrelate
> > > +                                      * sendmsg timestamp with corre=
sponding
> > > +                                      * tskey.
> > > +                                      */
> > >  };
> > >
> > >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to d=
etect
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 12b9c4f9c151..4b9739cd3bc5 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -492,6 +492,10 @@ static void tcp_tx_timestamp(struct sock *sk, st=
ruct sockcm_cookie *sockc)
> > >               if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> > >                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->l=
en - 1;
> > >       }
> > > +
> > > +     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > > +         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
> > > +             bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_=
CB);
> > >  }
> > >
> > >  static bool tcp_stream_is_readable(struct sock *sk, int target)
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linu=
x/bpf.h
> > > index d3e2988b3b4c..2739ee0154a0 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -7042,6 +7042,11 @@ enum {
> > >                                        * when SK_BPF_CB_TX_TIMESTAMPI=
NG
> > >                                        * feature is on.
> > >                                        */
> > > +     BPF_SOCK_OPS_TS_SND_CB,         /* Called when every sendmsg sy=
scall
> > > +                                      * is triggered. It's used to c=
orrelate
> > > +                                      * sendmsg timestamp with corre=
sponding
> > > +                                      * tskey.
> > > +                                      */
> >
> > Feel free to decline this late in the review process, but a bit more
> > bikeshedding..
> >
> > Can we spell out TSTAMP instead of TS in these definitions? Within
> > the context of this series it is self-explanatory, but when reading
> > kernel code the meaning of a two letter acronym is not that clear.
>
> Even though I feel reluctant to change across the whole series because
> if so, I will adjust in many places. Of course, you're right about the
> new name being clearer :)
>
> >
> > And instead of SND can we use SENDMSG or something like that?
> > SND here confused me as the software timestamp is SCM_TSTAMP_SND.
>
> I'm not sure about this. For TCP, it's not implemented in the
> tcp_sendmsg_locked but tcp_tx_timestamp. Well, I have no strong
> preference.
>
> You can make the final call :)

After taking a break, I feel full of energy and I will update them all
as you requested :)

Thanks,
Jason

