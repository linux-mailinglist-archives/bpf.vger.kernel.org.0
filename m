Return-Path: <bpf+bounces-42269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40049A18A1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EB81F2715A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65144C97;
	Thu, 17 Oct 2024 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpILMVNO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913B17580;
	Thu, 17 Oct 2024 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132122; cv=none; b=Oa2WCFAPex8bQiTI+ShpA0DGDIb40qCNg68i4nCKNEsa5f9DnAGqXzyl4jM84gNUSE9vBLtu33GXeKXvyACqQ0Lpr8taS0Ko9DRmguYtT9WHxGWLqilzfnFbrl3oWS8LNuR+8u9onGFCUUaEdBcMP1d42DW4zTEIM8FP6F33b5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132122; c=relaxed/simple;
	bh=aPtLzfh9TLmWViBXGo8AzdRoNwH4mBxoApH6bbkwMhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJAVTlCVlMY8y3v2Q3UsIqohltF7zeg5scLMnG7hOvC7lwqrhgOajbLHD6+d+xhtJlCEb6aZatZQpPFVV8bs11AVEZ+gFtHttbPcdotd7iJmET1ED87j/Yle/8qX+rWh8q5B2mu2IOXmlYO7b4L7AgJNFPYkplEkkpYkKZgmCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpILMVNO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3a380fd55so1979365ab.1;
        Wed, 16 Oct 2024 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729132118; x=1729736918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPlzsvcLDEkQf/MYM9StFUMUBdoAcxaGhxKBhMDBAk0=;
        b=VpILMVNONccA6bnbtp2U5jA9cFxgBm9bsvXN8QMJnQGn5zLRxePZspK0LpGbkzm9PM
         OWtVmKcXhdVAVbKc1vVxryNjiHvlDo4a1q0aEor+BonBOjueVvdYnySpF35lbg/z9ULX
         cSxhumrZ1V1ZffL6oAMRjnPGiWiegafzBcZOqj8/8GqmngnzGmuvf/RAprLdmc2Wrl57
         mUF6lb0iUf1g+r0J24C1cwk067YL1vhs+bCVydTqBBasD7g3h605h5Rb+N7DJl9Rxefh
         0ujiI9P/GRDV2ltakxVFiWj5fHNIw5nrsDHVArdBxXgvEZG89JScTP1353XhKLxcwtar
         BVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729132118; x=1729736918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPlzsvcLDEkQf/MYM9StFUMUBdoAcxaGhxKBhMDBAk0=;
        b=hWNaMKkMt0Zy+iCcLbShBEiwc7O7myvUjIGV1Oe/40gsfindNEYHyQX2tq1oe251n7
         md995HO7YiWxUGBlpD3dLRB/C7tJXjfh+/VXtzQl5J8ltS7WSW9YXyhj5A8AnO7G03OJ
         Hwco/r37Uc8wlNeC3lV+cu0dpDZHun5P6yqPPkxaHceO6v2NDV/IUeC1PBraNqwMyRFv
         ENdSK+SP3Q68qC1KFnWRbWLFN0Q/K7Uf9772Q2dBnluX+39UPXgZuvhgxQ6Z7sSJ5Jx1
         cnsfFQsKeA/aBQpOrWhba9EjjJDnSrXmi66g9DmPsukjmvpaDNaYN5q7vS6WWLmjl8Hk
         /MTA==
X-Forwarded-Encrypted: i=1; AJvYcCViG85FkhNt2C7URIoJhNAzNz7txvM+HBM1ITmRtnPRoQsEcQoxmBmQ/aE5wBKud0rG7a8=@vger.kernel.org, AJvYcCWslGiX99bpwW94gsdVKh9Hz1WjTlffYj0Bi9P1Ai7F7fuau278BNUPW2e/7cIMtsTIx0gl3Dfo@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzKriHQSt+8Uuw5hVyD3xncSvX8xZtsLAoFML7fNFhqCQrpHz
	eKN4nWwjOsLbhoe7MclIIAV6hNzNsnoBW6uA2vRnZLQl90vxkXPlPWeo7tA6IeqZxZ2wdidVSsD
	7VbJLOEmG33cyvBI/gg6VsRZVXBQ=
X-Google-Smtp-Source: AGHT+IF1Y/sbAkXhohUdvoofC1Smi7T4EQj/pKCyWqXfjKAe7Xq8P9lEYWdBqzM5iLObn9Mnzzte1gdQf4dJ8CkFOcM=
X-Received: by 2002:a05:6e02:1489:b0:3a3:af94:461f with SMTP id
 e9e14a558f8ab-3a3bcd95e9emr157391825ab.1.1729132118084; Wed, 16 Oct 2024
 19:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
 <CAL+tcoBXj=EO-sk-dS+dN-pCZf8OKeOZ4LXb9GZnja3EfOhXYg@mail.gmail.com>
 <9f050a5c-644f-4fbb-ac37-53edfd160edc@linux.dev> <CAL+tcoDyt=3hjwdx8Wk-abKg=qQsY=7UKu9=TU4iUAk5gMT2MQ@mail.gmail.com>
 <5398c020-e9b4-49d2-a5fa-dca047296ddd@linux.dev> <CAL+tcoDb84bgUUpK9PjijWDt+xw=u2nKkoWf1Gjvkjf--XJ6VA@mail.gmail.com>
 <c669769f-8437-46cc-95b4-d3f84c1c95b7@linux.dev> <CAL+tcoD-fzq7dSwkM4nRE8vF-y=+RO1y8X=95+D8Gv3QXTRWCA@mail.gmail.com>
 <095d241a-44d5-461f-8d64-356676a44e8b@linux.dev>
In-Reply-To: <095d241a-44d5-461f-8d64-356676a44e8b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Oct 2024 10:28:01 +0800
Message-ID: <CAL+tcoDKuomdJVYo6FVNH60NojYRNp3zjNyt8Tr8Od1Fp2BfWA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:48=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/16/24 3:36 AM, Jason Xing wrote:
> >>> If the skb carries the timestamp, there are three cases:
> >>> 1) non-bpf case and users uses setsockopt()
> >>> 2) cmsg case
> >>> 3) bpf case
>
> These should have tests in the selftests/bpf/ sooner than later. (More be=
low).
>
> >>>
> >>> #1 and #2 are already handled well before this patch. I only need to
> >>> test if sk_tsflags_bpf has those flags. If so, it means we hit #3, or
> >>> else it could be #1 or #2, then we will let the old way print
> >>> timestamps in __skb_tstamp_tx().
> >>
> >> hmm... I am still not sure I fully understand...but I think I may star=
t getting it.
> >
> > Sorry, my bad. I gave the wrong answer...
> >
> > It should be:
> > Testing if if sk_tsflags has SOF_TIMESTAMPING_SOFTWARE flag should
>
> You meant adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_flags=
()?

Yep.

>
> Before any bpf changes, if I read __skb_tstamp_tx() correctly, the curren=
t
> behavior is to just queue to the sk_error_queue as long as there is
> "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it is regardless of=
 the
> sk_tsflags. This will eventually get ignored when user read it from the e=
rror
> queue because the SOF_TIMESTAMPING_SOFTWARE is not set in sk_tsflags?

Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
read the skb from the errqueue but are not able to parse the
timestamps. Please see
tcp_recvmsg()->inet_recv_error()->ip_recv_error()->sock_recv_timestamp()->_=
_sock_recv_timestamp():
if ((tsflags & SOF_TIMESTAMPING_SOFTWARE...
       ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))

> I suspect
> the user space will still read something from the error queue unless ther=
e is
> SOF_TIMESTAMPING_OPT_TSONLY but it won't have the tstamp cmsg.

No, please see above.

>
> Adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_flags() will st=
op it
> from even queuing to the error queue? I think it is ok but I am not sure =
if
> anyone is depending on the above behavior.

SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING
features including cmsg mode. But it will not be used in bpf mode. So
the test statement is enough to divided those three cases into two
groups.

>
> > work fine. If it has the flag, we could use skb_tstamp_tx_output() to
> > print based on patch [4/12]; if not, we will use
> > bpf_skb_tstamp_tx_output() to print.
> >
> > If users use traditional ways of deploying SO_TIMESTAMPING, sk_tsflags
> > always has SOF_TIMESTAMPING_SOFTWARE which is a software report flag
> > (please see Documentation/networking/timestamping.rst). We can see a
> > good example on how to use in
> > tools/testing/selftests/net/txtimestamp.c:
> > do_test()
> > {
> >          sock_opt =3D SOF_TIMESTAMPING_SOFTWARE |
> >          ...
> >          if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
> >                                (char *) &sock_opt, sizeof(sock_opt)))
> > }
> >
> >>
> >> Is it the reason that the bpf_setsockopt() cannot clear the sk_tsflags=
_bpf once
> >> it is set in patch 2? It is not a usable api tbh. It will be a surpris=
e to many.
> >> It has to be able to set and clear.
> >
> > I cannot find a good time to clear all the sockets which are set
> > through the BPF program. If we detach the BPF program, it will not
> > print of course. Does it really matter if we don't clear the
> > sk_tsflags_bpf?
>
> Yes, it matters. The same reason goes for why the existing bpf prog can c=
lear
> the tp->bpf_sock_ops_cb_flags. Yes, detach will automatically not taking =
the
> timestamp. For sockops program that stays forever, not all usages expect =
to do
> timestamping for the whole lifetime of the connection. If there is a way =
for the
> prog to turn it on, it should have a way for the prog to turn it off.

I see what you meant here. If we don't clear sk_tsflags_bpf, after we
detach the bpf program, it will do nothing in __skb_tstamp_tx() and
return earlier. It is almost equal to the effect of turning off. It is
why I don't handle clearing the flag.

>
> What is the concern of allowing the bpf prog to disable something that it=
 has
> enabled before?

Let me give one instance:
If one socket is established and stays idle, how can the bpf program
clear the tsflags from that socket? I have no idea.

>
> While we are on bpf_sock_ops_cb_flags, the
> BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG addition is mostly a dup of what=
ever in
> the new sk_tsflags_bpf. It is something we need to clean up later when we=
 decide
> what interface to use for bpf timestamping.

I'm not sure if I understand correctly. I mimicked the use of
BPF_SOCK_OPS_RTO_CB_FLAG. Do you mean we can remove the use of
bpf_sock_ops_cb_flags_set() in BPF program?

>
> >
> >>
> >> Does it also mean either the bpf or the user space can enable the time=
tstamping
> >> but not both? I don't think we can assume this also. It will be hard t=
o deploy
> >> the bpf prog in production to collect continuous data. The user space =
may have
> >> some timestamping enabled but the bpf may want to do its parallel inve=
stigation
> >> also. The user space may rollout timestamping in the future and sudden=
ly break
> >> the bpf prog.
> >
> > Well, IIUC, it's also the basic idea from the current series which
> > allows both happening at the same time. Let us put it in a simple way,
> > I hope that if the app uses the SO_TIMESTAMPING feature already, then
> > one admin deploys the BPF program, that app should be traced both in
> > bpf and non-bpf ways.
> >
> > But Willem doesn't agree about this approach[1] because of hard to debu=
g.
> >
> > [1]: https://lore.kernel.org/all/670dda9437147_2e6c4029461@willemb.c.go=
oglers.com.notmuch/
> > Regarding to this link, I have a few more words to say: the socket
> > could be set through bpf_setsockopt() in different phases not like
> > setsockopt(), so in some cases we cannot make setsockopt hard failed.
> >
> > After rethinking this point more, I still reckon that letting BPF
> > program trace timestamping parallelly without caring whether the
> > socket is set to the SO_TIMESTAMPING feature through setsockopt()
>
> I am afraid having both work in parallel is needed. Otherwise, it will be=
 very
> hard to deploy a bpf prog to run continuously in scale. Being able to col=
lect
> timestamp without worrying about application changes/updates/downgrades i=
s
> important. e.g. App changes from no time stamping to time stamping

Sorry, I didn't make myself clear. Yesterday, I said I agreed with you
:) So let me keep the current logic of printing (see the
__skb_tstamp_tx() function in patch [04/12]) in the next version. Then
I don't need to add some test statements to distinguish which way of
printing.

>
> Please help to add selftests to show how the above cases (1), (2), (3), a=
nd
> other tsflags/txflags sharing cases will work. This should not be delayed=
 until
> the discussion is done. It is needed sooner or later to prove both bpf an=
d
> non-bpf ways can work at the same time. It will help the reviewer and als=
o help
> to think about the design with a real use case in bpf prog.

Got it. But I'm not sure where I should put those test cases? Could
you help me point out a good example that I can follow?

>
> The example in patch 0 only prints the reported tstamp, can you share how=
 it
> will be used to investigate issue?

No problem. Please see chapter 3 about "goal" in
https://netdev.bots.linux.dev/netconf/2024/jason_xing.pdf.

> Is it also useful to know when the skb is
> written to the kernel during sendmsg()?

You are right. Before this patch, normally applications will record an
accurate timestamp before do sendmsg().

After you remind me of this, I feel that we can add the timestamp
print in the future for bpf use.

>
> Regarding the bpf_setsockopt() can be called in different phase,
> bpf_setsockopt() is not limited to sockops program. e.g. it can also be c=
alled
> from a bpf-tcp-cc (congestion control). Not a tcp-cc expert but I won't b=
e
> surprised people will try to trigger some on-and-off timestamping from
> bpf-tcp-cc to measure some delay.
>
>
> More about bpf_setsockopt() in different phase, understand that UDP is no=
t your
> priority. However, it needs to have some clarity on how UDP will work and=
 how to
> enable it. UDP usually has no connect/established phase.

For now, I don't expect an extension for UDP because it will bring too
much extra work. Could we discuss this later? I mean, after we finish
the basic bpf extension :)

>
> Regarding the SOF_TIMESTAMPING_* support, can you list out what else you =
are
> planning to support in the future. You mentioned the SOF_TIMESTAMPING_TX_=
ACK in
> another thread. What else?

In this patch series, I support
SOF_TIMESTAMPING_TX_SCHED|SOF_TIMESTAMPING_TX_ACK|SOF_TIMESTAMPING_TX_SOFTW=
ARE,
which you've already noticed from the BPF example in patch [0/12].
They all come from the original design of SO_TIMESTAMPING feature.

The question you proposed is what I am willing to implement in the
future, like adding one hook in tcp_write_xmit()? It's part of my
plans to extend in the future, not be included in this series.

Thanks for your review.

Thanks,
Jason

