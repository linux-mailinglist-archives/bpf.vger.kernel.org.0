Return-Path: <bpf+bounces-42648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7919A6DA3
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179BC1C22931
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD61E884B;
	Mon, 21 Oct 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nACCaDFD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA96433BB;
	Mon, 21 Oct 2024 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523185; cv=none; b=IsdyvOf/TVAFdsKzeCcQ5kAyvoWJuQJ0ZTFZpAuIzfQB63WB5InAmZqFC+r98I5sbSS3RYZpQ5fa8kbTYvh9OPIZki4nFqCqj7M3qluFixs4W60kQFt8FyH//Zq8Xjhjk2HrMTiOVrdEJrHGlGCjZVgSrZ5ev74Panz/6VIKvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523185; c=relaxed/simple;
	bh=V13/+obv5LvCt5d9iEA9QL8fn6rmDWQcKKjiWDuQrzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX6BMMSnTHOeXOl4ha7XnVEuk+pGI9HNxSQFlwfipIU0XcsvMK+vLI7i/kTJDxlNofvXaeMR9Pdw2E+RoLZ0hfkoD9CQNdMTdQTQhrIN0WZ1/IrenWWkuYd9GCJ5dIHPHLLXRvLab5/+mvrqh9UtoMLoO/lq92hJpbuoDVf/c1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nACCaDFD; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83abe4524ccso120466739f.1;
        Mon, 21 Oct 2024 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729523183; x=1730127983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0vwS8TpTa7jxGqaCR9ZH5Z5mqMAXfgVdBA8IJC8KeM=;
        b=nACCaDFDHJPT13tqOlyZJcFon0f3TQX2Er+O7GIEewYsRTzjJz+u6u3iYMSbueRs11
         Q4d8STuIYx5HQgoqUkFtNHIZs/QjPreG+zb0rknt48fTzqHBhGcuVzYQ2m1WwZb0fDiD
         wtOx9Okt9HMZCXZO69Z14ooWz4N1oKryqnnwa8yPRkkx0tWUT76t/JQ0xs5o8wvMmjHY
         wF2nVTYyet+lUyVc3/ojdIJqCDRS0MLsLcrxN7a58eAJb7PeOzxQogHWwMbq+lIWgBwR
         gDUmz+D76MjcVU2UjH+DgdBiO2QJ0eEA1UMNYMKTV8islwOHuoY+gyAjsKjPi6g/LfYt
         b++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523183; x=1730127983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0vwS8TpTa7jxGqaCR9ZH5Z5mqMAXfgVdBA8IJC8KeM=;
        b=SyX0JcSJWTdimoyE9BB0MprhXQ1Ugsie4Xg/cDSUboMSrLrCqkkgv8CEgtIlIfuJmd
         tO9Zo4rIGcWR8KxLaqPFqOhRzRg+tuSGpEOzQIjtpej2/W9mJWsiP4PtianLf6Ds6Rnm
         +YvhBAl9gzn1lRdZeQHsKUWuGkjeNs05cAW0xmG2x/cB+EMomj2ewD2epeCSKKIha2lm
         ajd1A1B/vuvcgdeU5SjyxgoZp6WnQxPj1G6rVli9qlkzQ+E3q0kTCLAIgEqCniMkMDKi
         wNvfZ3ez89QJ7SJMvIgkXsbPi0N3E/288f7JzwnLngbws+xvMr136aPcef9pd9aVtAL2
         Y5+g==
X-Forwarded-Encrypted: i=1; AJvYcCUgIDR9Pz6AdS0Ysl3AmiW6/Mqmz6v3qTelY3KIAyC771JxGsgjtURUbEi4kr+qILQf0qE=@vger.kernel.org, AJvYcCUpSwf2DfglM2DQ1fZPTK5t+Voc9/jgoxyAgU7sTvjXDnMFRY+F+nFcRrPMfw7rhWpbcPvkV0iD@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvebEc/pAZk/El/+wDwq3GcN54UUw3oX5tJks6SBsvPj/ZP/R
	3AA3HQWNNe2Z/1pyzusU8bLETz/2X6qz545id871wpu5cLTpyUlL/WbuX3Igf4NQCyM2FmnjxhC
	nBrLzquVhGy6HvdXBRU1pQzQ8yIo=
X-Google-Smtp-Source: AGHT+IG0xzVL1nH4resXkL2n8I9TEFN6tXbVysu5Dp0bp21oCmQshX9KbwfvaBIs7+e39CUntO0f3wOzKpYIwJjf9B4=
X-Received: by 2002:a05:6e02:144c:b0:39f:60d7:813b with SMTP id
 e9e14a558f8ab-3a3f40bab4cmr102183565ab.22.1729523182390; Mon, 21 Oct 2024
 08:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
 <CAL+tcoD5TiaRZgW10tt8jc9srQTbaszs_o2z=Yf-bzO0Kp-vLA@mail.gmail.com> <67166a0997028_42f03294e7@willemb.c.googlers.com.notmuch>
In-Reply-To: <67166a0997028_42f03294e7@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 23:05:46 +0800
Message-ID: <CAL+tcoCfokXGfKN0fT8LMHY=+-bzJD=3nY2guPV=fjxGbiALEw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Mon, Oct 21, 2024 at 5:52=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Willem suggested that we use a static key to control. The advantage
> > > > is that we will not affect the existing applications at all if we
> > > > don't load BPF program.
> > > >
> > > > In this patch, except the static key, I also add one logic that is
> > > > used to test if the socket has enabled its tsflags in order to
> > > > support bpf logic to allow both cases to happen at the same time.
> > > > Or else, the skb carring related timestamp flag doesn't know which
> > > > way of printing is desirable.
> > > >
> > > > One thing important is this patch allows print from both applicatio=
ns
> > > > and bpf program at the same time. Now we have three kinds of print:
> > > > 1) only BPF program prints
> > > > 2) only application program prints
> > > > 3) both can print without side effect
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >
> > > Getting back to this thread. It is long, instead of responding to
> > > multiple messages, let me combine them in a single response.
> >
> > Thank you so much!
> >
> > >
> > >
> > > * On future extensions:
> > >
> > > +1 that the UDP case, and datagrams more broadly, must have a clear
> > > development path, before we can merge TCP.
> > >
> > > Similarly, hardware timestamps need not be supported from the start,
> > > but must clearly be supportable.
> >
> > Agreed. Using the standalone sk_tsflags_bpf and tskey_bpf and removing
> > the TCP bpf test logic(say, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)
> > could work well for both protos. Let me give it a try first.
>
> Great, thanks.
>
> > >
> > >
> > > * On queueing packets to userspace:
> > >
> > > > > the current behavior is to just queue to the sk_error_queue as lo=
ng
> > > > > as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and=
 it
> > > > > is regardless of the sk_tsflags. "
> > >
> > > > Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> > > > SOF_TIMESTAMPING_TX_* are generation flags. Without former, users c=
an
> > > > read the skb from the errqueue but are not able to parse the
> > > > timestamps
> >
> > Above is what I tried to explain how the application timestamping
> > feature works, not what I tried to implement for the BPF extension.
> >
> > >
> > > Before queuing a packet to userspace on the error queue, the relevant
> > > reporting flag is always tested. sock_recv_timestamp has:
> > >
> > >         /*
> > >          * generate control messages if
> > >          * - receive time stamping in software requested
> > >          * - software time stamp available and wanted
> > >          * - hardware time stamps available and wanted
> > >          */
> > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> > >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> > >             (hwtstamps->hwtstamp &&
> > >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> > >                 __sock_recv_timestamp(msg, sk, skb);
> > >
> > > Otherwise applications could get error messages queued, and
> > > epoll/poll/select would unexpectedly behave differently.
> >
> > Right. And I have no intention to use the SOF_TIMESTAMPING_SOFTWARE
> > flag for BPF.
>
> Can you elaborate on this? This sounds like it would go against the
> intent to have the two versions of the API (application and BPF) be
> equivalent.

Oh, I see what you mean here. I have no preference. Well, I can add
this report flag into the BPF extension like how application
timestamping works.

>
> > >
> > > > SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPI=
NG
> > > > features including cmsg mode. But it will not be used in bpf mode.
> > >
> > > For simplicity, the two uses of the API are best kept identical. If
> > > there is a technical reason why BPF has to diverge from established
> > > behavior, this needs to be explicitly called out in the commit
> > > message.
> > >
> > > Also, if you want to extend the API for BPF in the future, good to
> > > call this out now and ideally extensions will apply to both, to
> > > maintain a uniform API.
> >
> > As you said, I also agree on "two uses of the API are best kept identic=
al".
> >
> > >
> > >
> > > * On extra measurement points, at sendmsg or tcp_write_xmit:
> > >
> > > The first is interesting. For application timestamping, this was
> > > never needed, as the application can just call clock_gettime before
> > > sendmsg.
> >
> > Yes, we could add it after we finish the current series. I'm going to
> > write it down on my todo list.
> >
> > >
> > > In general, additional measurement points are not only useful if the
> > > interval between is not constant. So far, we have seen no need for
> > > any additional points.
> >
> > Taking a snapshot of tcp_write_xmit() could be useful especially when
> > the skb is not transmitted due to nagle algorithm.
> >
> > >
> > >
> > > * On skb state:
> > >
> > > > > For now, is there thing we can explore to share in the skb_shared=
_info?
> > >
> > > skb_shinfo space is at a premium. I don't think we can justify two
> > > extra fields just for this use case.
> > >
> > > > My initial thought is just to reuse these fields in skb. It can wor=
k
> > > > without interfering one another.
> > >
> > > I'm skeptical that two methods can work at the same time. If they are
> > > started at different times, their sk_tskey will be different, for one=
.
> >
> > Right, sk_tskey is the only special one that I will take care of.
> > Others like tx_flags or txstamp_ack from struct tcp_skb_cb can be
> > reused.
> >
> > >
> > > There may be workarounds. Maybe BPF can store its state in some BPF
> > > specific field, indeed. Or perhaps it can store per-sk shadow state
> > > that resolves the conflict. For instance, the offset between sk_tskey
> > > and bpf_tskey.
> >
> > Things could get complicated in the future if we want to unified the
> > final tskey value for all the cases. Since 1) the value of
> > shinfo->tskey depends on skb seq and len, 2) the final tskey output is
> > the diff between sk_tskey and shinfo->tskey, can I add a bpf_tskey in
> > struct sock and related output logic for bpf without caring if it's
> > the same as sk_tskey.
>
> I think we can add fields to struct sock without too much concern.
> Adding fields to sk_buff or skb_shared_info would be more difficult.

Got it:)

>
> > That said, the outputs from two methods differ. Do you think it is
> > acceptable? It could be simpler and easier if we keep them identical.
>
> Since we can only have one skb_shared_info.tskey, if both user and bpf
> request OPT_ID, starting at different times, then we will have two
> bases against which to compute the difference. Having two fields in
> struct sock should suffice.

Exactly! I will do it.

Thanks,
Jason

