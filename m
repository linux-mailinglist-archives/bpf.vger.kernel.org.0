Return-Path: <bpf+bounces-41388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9B996832
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FD11F22E49
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8A01917FE;
	Wed,  9 Oct 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5H4412N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA858222;
	Wed,  9 Oct 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472542; cv=none; b=N1ETfV7SBp6HqixAaWIqvn6pSuc0qbTm1CwZgY3363FuKA7PUhKRwkPjwUAJdV9LW525iHQfpRLaWJ3VWytRV4QrT+BB2mB48YLz6VxsHzGc30uVQcPn+GJctNVcLE3Zu0wwBUJiCoy5SD09arlERILxywyWyDPQGENVr8yrjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472542; c=relaxed/simple;
	bh=m0xKUgHEvIVUK/qnUCpygel9Rvdh8uKIc4vzEqujkig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khzHLB1KBESnKHG4WrJ3Pg16OdVD68rnpAba4IlzC6fv/4fL2GzGQuFEMqShm15j7dXzCKN6xNCKLhsmD6zH8jSh+1k2NWS6np1iSf6e15iLf8by9Nu/lektW6wyZoEKlhq5cVc5yD8oPcJw0HHLXhYBjNRpa1bbP7/TJ7ubtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5H4412N; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a274ef3bdeso21455195ab.2;
        Wed, 09 Oct 2024 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728472540; x=1729077340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a/G7BymBowMkeVBPEvTWJU/cFi7dhqjMGPG2Xc5/nw=;
        b=V5H4412NX43K0Uki6P220cvC3fmh+cLEVjW4/deVNUkjnM98fEMqBJIZi6jptdGftY
         UTm2uCUSwqyG2lajpAr60j7Nm56XenLHIO27Fdn/IAc9d2YLTEu+Onb9uBGy8SbCEIsq
         uYOu6+kh9oxkBTSsGcKNBGMKX0yrA0q3p/YgxypI+NHIzXZSav05pmAR3sfdB+RV2GHw
         WS+ynKT7+af1sb4aHuJXl4YfTyRLNktodlLMGIlRhx1/F2xc9XwJm3NOud+ZMqmfZtHT
         ii1/jmqAHKyfmv7Ym5T2VS+Dllz5Cu0sPr07k2JVOcgceM//eO54OvRvZULeV0s/pST/
         4L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472540; x=1729077340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a/G7BymBowMkeVBPEvTWJU/cFi7dhqjMGPG2Xc5/nw=;
        b=btO9mpcYjPhtUB9af3D47aLxus/C+/pduo/nZIVueN6Oe++rHw39pl5guKhepePcA6
         jgquHWAa6naQgoXdlpv2zWdf9koKfx5qT0ATsfIsKV3f7ojwEbBW6tGFJ18XwFGzFcIM
         j8WU1ePzytt5hdo6Og6y8GYfJpWQjZE9loUGk8jz5mKKdxeRyl2DsLOx6WcJb78IfRE8
         v5SCcQSHhOde4rbhiEJCLm61iKIb1S22X7xwstTytLreaGeUzujUJ5Ao2LR8FwbCVFUL
         xQ5SEwFWjI9BEaeqCxhaWKFXGOu1DO8e8DnU1Je1ZNi2xGShapNS923OuyTS5+lTmkbf
         OA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvy90Qt6FRUj8jAS0hSJjQNVYMxw7a1iDh4GWNQAUYqHpuqEwJWAwmG7Qg3WTb7my5Qcc=@vger.kernel.org, AJvYcCX5SRHUS6qhbpRU2LKXYzAa1tiPwPf8Z9SZ1/307LgEn6ZpTKEUDQHNd6BEV94ru4GJEQILyKQ9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3DsbbCCE+//JlL8nUfOmIgriaGWgU6jStGGYtpSLhgbY1xqA
	Liuu+34UAdwAVXiSrR/PSxLW9QnyoBby2nPLJc2eB4ReyczMJtIbhXAgsDcKKWI0TkQmMnlg2WZ
	MXZ8za1n7h9Ygtw/O9KOdf7tvwTM=
X-Google-Smtp-Source: AGHT+IEqKzh+Di1lirHe0MSTL+mJsgTXED0pz2n50/Pq5xBCnQ+vL7EwEi9S8Oy+i/0kfR6lGVmndu3mjeAxMQyDvrk=
X-Received: by 2002:a05:6e02:1c05:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a397cee3d7mr17907535ab.12.1728472540102; Wed, 09 Oct 2024
 04:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-6-kerneljasonxing@gmail.com> <b82d7025-188d-41dc-a70c-06aa0fb26d24@linux.dev>
 <CAL+tcoAbYF2k88r84VW-3COU5W8dOQ2gFHBq3OiXig3Ze+reXg@mail.gmail.com> <842adc49-b75e-49b1-89ea-9c5229a44447@linux.dev>
In-Reply-To: <842adc49-b75e-49b1-89ea-9c5229a44447@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 19:15:03 +0800
Message-ID: <CAL+tcoBCFjbX3BvYqYDtH_339HjfgPLe3cUku=s2MNQCY_sk9w@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] net-timestamp: ready to turn on the button
 to generate tx timestamps
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:17=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 09/10/2024 00:48, Jason Xing wrote:
> > On Wed, Oct 9, 2024 at 3:18=E2=80=AFAM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 08/10/2024 10:51, Jason Xing wrote:
> >>> From: Jason Xing <kernelxing@tencent.com>
> >>>
> >>> Once we set BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB_FLAG flag here, there
> >>> are three points in the previous patches where generating timestamps
> >>> works. Let us make the basic bpf mechanism for timestamping feature
> >>>    work finally.
> >>>
> >>> We can use like this as a simple example in bpf program:
> >>> __section("sockops")
> >>>
> >>> case BPF_SOCK_OPS_TX_TIMESTAMP_OPT_CB:
> >>>        dport =3D bpf_ntohl(skops->remote_port);
> >>>        sport =3D skops->local_port;
> >>>        skops->reply =3D SOF_TIMESTAMPING_TX_SCHED;
> >>>        bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMP_OPT=
_CB_FLAG);
> >>> case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> >>>        bpf_printk(...);
> >>>
> >>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>> ---
> >>>    include/uapi/linux/bpf.h       |  8 ++++++++
> >>>    net/ipv4/tcp.c                 | 27 ++++++++++++++++++++++++++-
> >>>    tools/include/uapi/linux/bpf.h |  8 ++++++++
> >>>    3 files changed, 42 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index 1b478ec18ac2..6bf3f2892776 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -7034,6 +7034,14 @@ enum {
> >>>                                         * feature is on. It indicates=
 the
> >>>                                         * recorded timestamp.
> >>>                                         */
> >>> +     BPF_SOCK_OPS_TX_TS_OPT_CB,      /* Called when the last skb fro=
m
> >>> +                                      * sendmsg is going to push whe=
n
> >>> +                                      * SO_TIMESTAMPING feature is o=
n.
> >>> +                                      * Let user have a chance to sw=
itch
> >>> +                                      * on BPF_SOCK_OPS_TX_TIMESTAMP=
ING_OPT_CB_FLAG
> >>> +                                      * flag for other three tx time=
stamp
> >>> +                                      * use.
> >>> +                                      */
> >>>    };
> >>>
> >>>    /* List of TCP states. There is a build check in net/ipv4/tcp.c to=
 detect
> >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >>> index 82cc4a5633ce..ddf4089779b5 100644
> >>> --- a/net/ipv4/tcp.c
> >>> +++ b/net/ipv4/tcp.c
> >>> @@ -477,12 +477,37 @@ void tcp_init_sock(struct sock *sk)
> >>>    }
> >>>    EXPORT_SYMBOL(tcp_init_sock);
> >>>
> >>> +static u32 bpf_tcp_tx_timestamp(struct sock *sk)
> >>> +{
> >>> +     u32 flags;
> >>> +
> >>> +     flags =3D tcp_call_bpf(sk, BPF_SOCK_OPS_TX_TS_OPT_CB, 0, NULL);
> >>> +     if (flags <=3D 0)
> >>> +             return 0;
> >>> +
> >>> +     if (flags & ~SOF_TIMESTAMPING_MASK)
> >>> +             return 0;
> >>> +
> >>> +     if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> >>> +             return 0;
> >>> +
> >>> +     return flags;
> >>> +}
> >>> +
> >>>    static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie=
 *sockc)
> >>>    {
> >>>        struct sk_buff *skb =3D tcp_write_queue_tail(sk);
> >>>        u32 tsflags =3D sockc->tsflags;
> >>> +     u32 flags;
> >>> +
> >>> +     if (!skb)
> >>> +             return;
> >>> +
> >>> +     flags =3D bpf_tcp_tx_timestamp(sk);
> >>> +     if (flags)
> >>> +             tsflags =3D flags;
> >>
> >> In this case it's impossible to clear timestamping flags from bpf
> >
> > It cannot be cleared only from the last skb until the next round of
> > recvmsg. Since the last skb is generated and bpf program is attached,
> > I would like to know why we need to clear the related fields in the
> > skb? Please note that I didn't hack the sk_tstflags in struct sock :)
>
> >> program, but it may be very useful. Consider providing flags from
> >> socket cookie to the program or maybe add an option to combine them?
> >
> > Thanks for this idea. May I ask what the benefits are through adding
> > an option because the bpf test statement (BPF_SOCK_OPS_TEST_FLAG) is a
> > good option to take a whole control? Or could you provide more details
> > about how you expect to do so?
>
> Well, as Willem mentioned, you are overriding flags completely. But what
> if an application is waiting for some type of timestamp to arrive, but
> bpf program rewrites flags and disables this type of timestamp? It will
> confuse application.

Indeed, this series doesn't handle the conflict very well. Initially,
I tried so hard to avoid implementing the feature again. But now, it
seems inevitable. Let me dig into it more.

>
> Thinking twice, clearing flags might not be useful because of the very
> same issue though.

Yes.

Thanks,
Jason

