Return-Path: <bpf+bounces-42647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A729A6CAF
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34F01C227BD
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29601FA245;
	Mon, 21 Oct 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6wgFBJY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CC1F891E;
	Mon, 21 Oct 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522190; cv=none; b=BZjPTu8gXFZ7Tc7vQWWn9jGV6u3VyXFyihnHBPQSO0+15FULqtOBzFRq0OcmpQMXfSLGFn8Z+GRTeE5Ys3SmYBF38Cbc5DviJLd+jQYYLbNC14LZ5T6g1ZNmZkdvr8knLcUwE5Y7NeG2LKS16uBd/HYvQzQGSawjbCrO7F3bMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522190; c=relaxed/simple;
	bh=hRiJWkhCjaxIknTyGTSFGJY5nAxV3+531Mlfz5dkFE0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IX7+idN4+hxAkvI+6DG4OHu6okgUsIcqt1vatNzBdBHgRdtAO1jFb29BpuCUQRX78BfwJASJztCHVx2FIQNgpEvcSc5ajWTObABEQ/oPqgU1oq/lq2P8xzRI2BfcMWncOwdJ5HxOp/nSZfMaJatacNkN3BZ7uDn711uUG1V/OZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6wgFBJY; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb97afcec9so31319836d6.2;
        Mon, 21 Oct 2024 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729522186; x=1730126986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84lL9admtSqwLpg7VH6pZR2Jg/MCV+HcnAoSWzVcOks=;
        b=Y6wgFBJYKugF39mHrlpcGwLKJBsKtWI8Z182Ge9P02QwD29cPwuw8QJ2RyGFXL2N3B
         Wk0+/ees7f6zojjEIlh6X7eLVHaD2/GY6zBe1THhNttfMXkNjyuO0Bc9KZfap5qgV/+F
         atb58iyWxVPozoKH+qoVZE/fLH5n7fOGPI0ykYfSssAlS5Y3jXwyYMSbnn8jknFn+3Hw
         5f+xdwjRR/ZIqlPLrmPmbyjugVTkMEebdcb5U1VKWCh8dLu+2HOejy/GvUR9Id7vIcu4
         f/vdPHzbXGniq87P9dGW58hlTRZYARJmH5eorGIDNFCEglWNuAoHTGQqe70DQjwmRCBb
         osjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522186; x=1730126986;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=84lL9admtSqwLpg7VH6pZR2Jg/MCV+HcnAoSWzVcOks=;
        b=f7c44QRSKOTe7ZHwZpXdWK24eUjptm3qd1pVg+RalSzJFBdYa8wilPMatbjZT35u7s
         juVfkdk09t1X3Ljrqo/RMoABP4DGVlJWwnqvUBIwp/qG5Sk/VULIrN/ZJkO97PbeLMpN
         qHZCfRdTx3TTz+X5oyVGoCNK3K+0iWB0pKBzBYU6oiVm4C3f1R89+NKpSLxplNj7dr2V
         b7lwqiQKRQXaKyxnzSx23ygRGcLcsXsCoGZAGN4apFbFxUmdaDSn9fFTM9BGy2/dIcwG
         6qGlFV0KU2RplYmNDMxb7Zs/w4Q/kd7kVQgZ+77FQWvSGsGURmbyzo9cGSZsWH1qyy+w
         GEJA==
X-Forwarded-Encrypted: i=1; AJvYcCX3OECeYrnJ3nf+1RBMp8PSLD+ti38PFZNn0oMKreVEbnYvLFulJatoTn4K4BCXkNE8oPwwRKnq@vger.kernel.org, AJvYcCXVaGNtlgDlWrFghMIT6BBjn+eLLUb7xS4zRMZdQVGP+5Dltsfz3rjPQ2PJ5bOCAaVVzt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntA3ACELRsUc6DDiCjg37ouNdQDWrjSP5bPbmd47PQO+dKz0A
	eFcdO2WHVpApKSFAQsb9D+AM1ZUn5Scaylbh6yhJSLNeHByYvs0v
X-Google-Smtp-Source: AGHT+IFSAu4RiEwfz/Pzl76eMYM0Wt3Oe3iUs+8/4/lZxGzXvE3tYe/jH4LjsAj75B1uwcR5SKrVeA==
X-Received: by 2002:a05:6214:328e:b0:6cb:f40c:b868 with SMTP id 6a1803df08f44-6cde163399emr194619986d6.46.1729522186499;
        Mon, 21 Oct 2024 07:49:46 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0099a79fsm17697386d6.90.2024.10.21.07.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:49:45 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:49:45 -0400
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
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67166a0997028_42f03294e7@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoD5TiaRZgW10tt8jc9srQTbaszs_o2z=Yf-bzO0Kp-vLA@mail.gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
 <CAL+tcoD5TiaRZgW10tt8jc9srQTbaszs_o2z=Yf-bzO0Kp-vLA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
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
> On Mon, Oct 21, 2024 at 5:52=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Willem suggested that we use a static key to control. The advantage=

> > > is that we will not affect the existing applications at all if we
> > > don't load BPF program.
> > >
> > > In this patch, except the static key, I also add one logic that is
> > > used to test if the socket has enabled its tsflags in order to
> > > support bpf logic to allow both cases to happen at the same time.
> > > Or else, the skb carring related timestamp flag doesn't know which
> > > way of printing is desirable.
> > >
> > > One thing important is this patch allows print from both applicatio=
ns
> > > and bpf program at the same time. Now we have three kinds of print:=

> > > 1) only BPF program prints
> > > 2) only application program prints
> > > 3) both can print without side effect
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > Getting back to this thread. It is long, instead of responding to
> > multiple messages, let me combine them in a single response.
> =

> Thank you so much!
> =

> >
> >
> > * On future extensions:
> >
> > +1 that the UDP case, and datagrams more broadly, must have a clear
> > development path, before we can merge TCP.
> >
> > Similarly, hardware timestamps need not be supported from the start,
> > but must clearly be supportable.
> =

> Agreed. Using the standalone sk_tsflags_bpf and tskey_bpf and removing
> the TCP bpf test logic(say, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)
> could work well for both protos. Let me give it a try first.

Great, thanks.

> >
> >
> > * On queueing packets to userspace:
> >
> > > > the current behavior is to just queue to the sk_error_queue as lo=
ng
> > > > as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and=
 it
> > > > is regardless of the sk_tsflags. "
> >
> > > Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> > > SOF_TIMESTAMPING_TX_* are generation flags. Without former, users c=
an
> > > read the skb from the errqueue but are not able to parse the
> > > timestamps
> =

> Above is what I tried to explain how the application timestamping
> feature works, not what I tried to implement for the BPF extension.
> =

> >
> > Before queuing a packet to userspace on the error queue, the relevant=

> > reporting flag is always tested. sock_recv_timestamp has:
> >
> >         /*
> >          * generate control messages if
> >          * - receive time stamping in software requested
> >          * - software time stamp available and wanted
> >          * - hardware time stamps available and wanted
> >          */
> >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> >             (hwtstamps->hwtstamp &&
> >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> >                 __sock_recv_timestamp(msg, sk, skb);
> >
> > Otherwise applications could get error messages queued, and
> > epoll/poll/select would unexpectedly behave differently.
> =

> Right. And I have no intention to use the SOF_TIMESTAMPING_SOFTWARE
> flag for BPF.

Can you elaborate on this? This sounds like it would go against the
intent to have the two versions of the API (application and BPF) be
equivalent.
 =

> >
> > > SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPI=
NG
> > > features including cmsg mode. But it will not be used in bpf mode.
> >
> > For simplicity, the two uses of the API are best kept identical. If
> > there is a technical reason why BPF has to diverge from established
> > behavior, this needs to be explicitly called out in the commit
> > message.
> >
> > Also, if you want to extend the API for BPF in the future, good to
> > call this out now and ideally extensions will apply to both, to
> > maintain a uniform API.
> =

> As you said, I also agree on "two uses of the API are best kept identic=
al".
> =

> >
> >
> > * On extra measurement points, at sendmsg or tcp_write_xmit:
> >
> > The first is interesting. For application timestamping, this was
> > never needed, as the application can just call clock_gettime before
> > sendmsg.
> =

> Yes, we could add it after we finish the current series. I'm going to
> write it down on my todo list.
> =

> >
> > In general, additional measurement points are not only useful if the
> > interval between is not constant. So far, we have seen no need for
> > any additional points.
> =

> Taking a snapshot of tcp_write_xmit() could be useful especially when
> the skb is not transmitted due to nagle algorithm.
> =

> >
> >
> > * On skb state:
> >
> > > > For now, is there thing we can explore to share in the skb_shared=
_info?
> >
> > skb_shinfo space is at a premium. I don't think we can justify two
> > extra fields just for this use case.
> >
> > > My initial thought is just to reuse these fields in skb. It can wor=
k
> > > without interfering one another.
> >
> > I'm skeptical that two methods can work at the same time. If they are=

> > started at different times, their sk_tskey will be different, for one=
.
> =

> Right, sk_tskey is the only special one that I will take care of.
> Others like tx_flags or txstamp_ack from struct tcp_skb_cb can be
> reused.
> =

> >
> > There may be workarounds. Maybe BPF can store its state in some BPF
> > specific field, indeed. Or perhaps it can store per-sk shadow state
> > that resolves the conflict. For instance, the offset between sk_tskey=

> > and bpf_tskey.
> =

> Things could get complicated in the future if we want to unified the
> final tskey value for all the cases. Since 1) the value of
> shinfo->tskey depends on skb seq and len, 2) the final tskey output is
> the diff between sk_tskey and shinfo->tskey, can I add a bpf_tskey in
> struct sock and related output logic for bpf without caring if it's
> the same as sk_tskey.

I think we can add fields to struct sock without too much concern.
Adding fields to sk_buff or skb_shared_info would be more difficult.

> That said, the outputs from two methods differ. Do you think it is
> acceptable? It could be simpler and easier if we keep them identical.

Since we can only have one skb_shared_info.tskey, if both user and bpf
request OPT_ID, starting at different times, then we will have two
bases against which to compute the difference. Having two fields in
struct sock should suffice.=

