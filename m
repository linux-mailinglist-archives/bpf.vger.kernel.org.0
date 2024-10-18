Return-Path: <bpf+bounces-42366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182959A332C
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 05:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F948B23C1C
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E615573F;
	Fri, 18 Oct 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK6n/9SD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839514E2E8;
	Fri, 18 Oct 2024 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220757; cv=none; b=H8pebYS1hoOIRJH+g3l+aZ2SZiMjT2Iua8wCQU/mYIj+h8O64sj0uU4HWjcNgwMkpJO9HUxnFwJ9ELmvKGJVkzuw8o5ahUOQpvTLZ2fTut8FIDkmEY48pR7Kf+b8DWEvNw1tWesmcvmmwVvxHI0RIvezXxtAsidhqqfaln/jGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220757; c=relaxed/simple;
	bh=b20YIGrTHA4tFmR8fRZ2G7nFKchU1SWnx/98PLGp7IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsKi/zoTj0pFUZvPW5OYY0d6oSAnAJ1VTpbutl4TmWT9ipop734u1boAH5nnTRN/cCRhmtopVceRg/ultxx56QwIsntOgnyMyDx1uBdfREqct1eEarm7pGMRqwJANhb6mlLWsrQnxgFmZeSmyIKBsyNmyeiCZlbPlATQBLfB9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK6n/9SD; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3bd42955bso6787285ab.1;
        Thu, 17 Oct 2024 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729220755; x=1729825555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spveQX+K0J5pmWjsht13UcWbioupDfnlcow9XKgycMU=;
        b=fK6n/9SDwIyXRvQdf87bzDlu9IfH4Mrpq2QKH41WXW8slxDANEqZOGCgMC2TbBytiG
         hjUGi+RxSLr0p4Tj00jI+4G7Y+VSglZPs7zuYyN1K2KmGJ/25EMwXs2kFARgj6qLSsA7
         ViS17NCc0UhlnMz04zA7D6RP+m+HEGUcHp1rFOITkUpw73EH27+o7mwAa3/VUfwXWT3G
         ZPhFt5kB+gk9afm5ofkqaX0agH7XvKqFUgiK0EJMBWiRVtWWUVKxgqPSAtV9Ww5ohcb5
         Nn2BOWrdzkY2Ef110LZOQIyN9soR9Plts5Gf1QfpGGpJhkgWTMj+zFViSArGu8m5E9Vc
         LxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220755; x=1729825555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spveQX+K0J5pmWjsht13UcWbioupDfnlcow9XKgycMU=;
        b=dxQHB08ScBG94oTpHJX8YhboTqee2SPkWq9KYMxNhp1onW3JHu4yytsjpPw8hSF2fL
         JU6z5svmq9HhC4c9cJp23dDYqLFobvaLD21pCh4KgW+D/9ZCRLcTChUA8MkDzVM2F03Y
         GxdLHdk8bklNceB6gFp88+vL0VOi3RUnekUxbEUG+Rmnbou7Q8mJGpWLaczyVbu0vSw7
         5t41Tr327J0OuHr6ntGYjHoz2Mp85VgVL9kAQ0koRjAJg7MemPPrCXcPAJfalQsW2qyG
         CzYliqmB51q3QSianTsuY/rRDRFbXIv+Y5vI0TsEojtO8DN6SEgiTfo2kqJEy87Jjdak
         Og0w==
X-Forwarded-Encrypted: i=1; AJvYcCVNpWPaPAUW2mL9dg1GiAb6RQ6uLAS4aMAvhlqFnjN/udmE3lIVGHBzeXRv2LrdvzDfOQI=@vger.kernel.org, AJvYcCXTvjjZyCiRW7Gx89IfZJeOfH+GkxMYmXABA8m8MWAHqdz1EsD7gzBQr9voq4lqGQjw7ZWBJYJV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ex9PClAGHlNfmok5AIZm4WYEw4i1Lv52WeWv0A0REtCMmjuT
	WKQV3HWB8ayW51TqyeYSrL+BDSgNEo9Ryo7DbJ/mliiOgfHdSuDY2zqO/L0mHwXP9TuOxCa8nz0
	eRnzOmSL9e+ylj4E36Qpv3xzBOfEwFPrt
X-Google-Smtp-Source: AGHT+IFpCpaVXTZ5gDwsvuqTR1eTG7TGW0qVpoMdNZka7LYSAJFh2ZU8fUcSArj1uphjGEmQWaWq0VGSBU4kjePSv0E=
X-Received: by 2002:a05:6e02:b4e:b0:3a0:bc89:612 with SMTP id
 e9e14a558f8ab-3a3f4059d50mr10026695ab.8.1729220754826; Thu, 17 Oct 2024
 20:05:54 -0700 (PDT)
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
 <095d241a-44d5-461f-8d64-356676a44e8b@linux.dev> <CAL+tcoDKuomdJVYo6FVNH60NojYRNp3zjNyt8Tr8Od1Fp2BfWA@mail.gmail.com>
 <95f10d3d-8bed-46ea-852c-791592e67070@linux.dev> <CAL+tcoAkUELFL15A6SPtqE31E84DzjXG=mH4JgXJRJ1mMLW60A@mail.gmail.com>
In-Reply-To: <CAL+tcoAkUELFL15A6SPtqE31E84DzjXG=mH4JgXJRJ1mMLW60A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 18 Oct 2024 11:05:18 +0800
Message-ID: <CAL+tcoBs_cO-BaZX0jMB9EqQOvWyek4QzuHcyo6_3JJsaxNC=Q@mail.gmail.com>
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

On Fri, Oct 18, 2024 at 10:52=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Fri, Oct 18, 2024 at 4:43=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 10/16/24 7:28 PM, Jason Xing wrote:
> > > On Thu, Oct 17, 2024 at 8:48=E2=80=AFAM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> > >>
> > >> On 10/16/24 3:36 AM, Jason Xing wrote:
> > >>>>> If the skb carries the timestamp, there are three cases:
> > >>>>> 1) non-bpf case and users uses setsockopt()
> > >>>>> 2) cmsg case
> > >>>>> 3) bpf case
> > >>
> > >> These should have tests in the selftests/bpf/ sooner than later. (Mo=
re below).
> > >>
> > >>>>>
> > >>>>> #1 and #2 are already handled well before this patch. I only need=
 to
> > >>>>> test if sk_tsflags_bpf has those flags. If so, it means we hit #3=
, or
> > >>>>> else it could be #1 or #2, then we will let the old way print
> > >>>>> timestamps in __skb_tstamp_tx().
> > >>>>
> > >>>> hmm... I am still not sure I fully understand...but I think I may =
start getting it.
> > >>>
> > >>> Sorry, my bad. I gave the wrong answer...
> > >>>
> > >>> It should be:
> > >>> Testing if if sk_tsflags has SOF_TIMESTAMPING_SOFTWARE flag should
> > >>
> > >> You meant adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_=
flags()?
> > >
> > > Yep.
> > >
> > >>
> > >> Before any bpf changes, if I read __skb_tstamp_tx() correctly, the c=
urrent
> > >> behavior is to just queue to the sk_error_queue as long as there is
> > >> "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it is regardle=
ss of the
> > >> sk_tsflags. This will eventually get ignored when user read it from =
the error
> > >> queue because the SOF_TIMESTAMPING_SOFTWARE is not set in sk_tsflags=
?
> > >
> > > Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> > > SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
> > > read the skb from the errqueue but are not able to parse the
> > > timestamps. Please see
> > > tcp_recvmsg()->inet_recv_error()->ip_recv_error()->sock_recv_timestam=
p()->__sock_recv_timestamp():
> > > if ((tsflags & SOF_TIMESTAMPING_SOFTWARE...
> > >         ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
> >
> > afaict, __sock_recv_timestamp does not put the timestamp cmsg but ip_re=
cv_error
> > still returns the skb to the user.
> >
> > I suspect we are talking the same thing. When SOF_TIMESTAMPING_SOFTWARE=
 is not
> > set in sk and SOF_TIMESTAMPING_TX_* is set in cmsg, the existing (aka
> > traditional) way is that the generated skb will still be queued in the =
error
> > queue. The user space can still read it but just won't have the timesta=
mp cmsg.
>
> Apparently, we're on the same page. What you were saying is right, of cou=
rse :)
>
> >
> > If I understand how the v3 may look like, the skb will not be queued in=
 the
> > error queue at all because the sk has no SOF_TIMESTAMPING_SOFTWARE. The=
 user
>
> Right, skb will not even be cloned or generated, let alone queue it in
> the error queue. For bpf extension, preventing skb to be queued in the
> error queue is a very vital thing.
>
> > space won't get it from the error queue which is a change of behavior. =
I was
> > saying I am fine but not sure if someone depends on this behavior.
>
> For bpf part, it's okay to bypass the queuing skb into the errqueue
> logic, which has been discussed at netconf before this series with
> Willem also.
> For non-bpf part, I will not touch and modify their prior behaviour.
>
> >
> > I think we start talking pass each other on this. I will wait for the c=
ode on
> > this part and the selftest first.
>
> I will keep this code snippets in V3 so that three kinds of printing
> could work parallelly:
> @@ -5601,6 +5636,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>         if (!sk)
>                 return;
>
> +       if (static_branch_unlikely(&bpf_tstamp_control))
> +               bpf_skb_tstamp_tx_output(sk, tstype);
> +
>         skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
>  }
>
> So please forget what we've talked about testing the
> SOF_TIMESTAMPING_SOFTWARE flag thing.
>
> >
> > >
> > >> I suspect
> > >> the user space will still read something from the error queue unless=
 there is
> > >> SOF_TIMESTAMPING_OPT_TSONLY but it won't have the tstamp cmsg.
> > >
> > > No, please see above.
> > >
> > >>
> > >> Adding SOF_TIMESTAMPING_SOFTWARE test to the sk_tstamp_tx_flags() wi=
ll stop it
> > >> from even queuing to the error queue? I think it is ok but I am not =
sure if
> > >> anyone is depending on the above behavior.
> > >
> > > SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING
> >
> > Got it. This part is now understood.
> >
> > It is one of the reasons for my earlier question on which SOF_* that bp=
f needs
> > to support. I want to simplify the naming part of the SOF_* in bpf_seso=
ckopt but
> > lets leave these nits for a little later.
> >
> > However, it will be very useful to highlight which SOF_* will never be =
used in
> > bpf in v3.
>
> Got it. Will do that.
>
> >
> > > features including cmsg mode. But it will not be used in bpf mode. So
> > > the test statement is enough to divided those three cases into two
> > > groups.
> >
> > >
> > >>
> > >>> work fine. If it has the flag, we could use skb_tstamp_tx_output() =
to
> > >>> print based on patch [4/12]; if not, we will use
> > >>> bpf_skb_tstamp_tx_output() to print.
> > >>>
> > >>> If users use traditional ways of deploying SO_TIMESTAMPING, sk_tsfl=
ags
> > >>> always has SOF_TIMESTAMPING_SOFTWARE which is a software report fla=
g
> > >>> (please see Documentation/networking/timestamping.rst). We can see =
a
> > >>> good example on how to use in
> > >>> tools/testing/selftests/net/txtimestamp.c:
> > >>> do_test()
> > >>> {
> > >>>           sock_opt =3D SOF_TIMESTAMPING_SOFTWARE |
> > >>>           ...
> > >>>           if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
> > >>>                                 (char *) &sock_opt, sizeof(sock_opt=
)))
> > >>> }
> > >>>
> > >>>>
> > >>>> Is it the reason that the bpf_setsockopt() cannot clear the sk_tsf=
lags_bpf once
> > >>>> it is set in patch 2? It is not a usable api tbh. It will be a sur=
prise to many.
> > >>>> It has to be able to set and clear.
> > >>>
> > >>> I cannot find a good time to clear all the sockets which are set
> > >>> through the BPF program. If we detach the BPF program, it will not
> > >>> print of course. Does it really matter if we don't clear the
> > >>> sk_tsflags_bpf?
> > >>
> > >> Yes, it matters. The same reason goes for why the existing bpf prog =
can clear
> > >> the tp->bpf_sock_ops_cb_flags. Yes, detach will automatically not ta=
king the
> > >> timestamp. For sockops program that stays forever, not all usages ex=
pect to do
> > >> timestamping for the whole lifetime of the connection. If there is a=
 way for the
> > >> prog to turn it on, it should have a way for the prog to turn it off=
.
> > >
> > > I see what you meant here. If we don't clear sk_tsflags_bpf, after we
> > > detach the bpf program, it will do nothing in __skb_tstamp_tx() and
> > > return earlier. It is almost equal to the effect of turning off. It i=
s
> > > why I don't handle clearing the flag.
> > >
> > >>
> > >> What is the concern of allowing the bpf prog to disable something th=
at it has
> > >> enabled before?
> > >
> > > Let me give one instance:
> > > If one socket is established and stays idle, how can the bpf program
> > > clear the tsflags from that socket? I have no idea.
> >
> > bpf_tcp_iter prog can. That said, the idle connection example is too ca=
rry away
> > as an excuse that bpf_setsockopt does not need to support turning-off. =
Sure,
> > idle connection is as good as off. and yes, detach is as good as off al=
so.
>
> Thanks, I see.
>
> >
> > I am now acting as a broken clock repeating myself that not all use cas=
es run
> > for 5 mins and then detach, so I need to be specific here that bpf_sets=
ockopt
> > not supporting off is a nack. There are many use cases in production th=
at the
> > bpf prog runs forever and wants to turn it on-and-off.
> >
> > Again, bpf sockops prog is not the only one can bpf_setsockopt(). bpf-t=
cp-cc
> > that runs forever can also bpf_setsockopt to ask the sockops bpf prog t=
o do
> > periodic timestamping when needed. bpf_tcp_iter can also bpf_setsockopt=
 to turn
> > it off if needed.
>
> I'm not insisting not to support this. Just curious why. Now I get it.
>
> >
> > I am not asking to clear the sk_tsflags_bpf when the bpf prog is detach=
ed. I am
> > asking to support clearing the sk_tsflags_bpf in bpf_setsockopt().
>
> Yeah, I know that.
>
> >
> > I have still yet heard a technical reason why bpf_setsockopt cannot cle=
ar the bits.
>
> It's easy for me to support the function clearing the sk_tsflags_bpf
> in the bpf_setsockopt() function. Will do that :)
>
> >
> > >
> > >>
> > >> While we are on bpf_sock_ops_cb_flags, the
> > >> BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG addition is mostly a dup of=
 whatever in
> > >> the new sk_tsflags_bpf. It is something we need to clean up later wh=
en we decide
> > >> what interface to use for bpf timestamping.
> > >
> > > I'm not sure if I understand correctly. I mimicked the use of
> > > BPF_SOCK_OPS_RTO_CB_FLAG. Do you mean we can remove the use of
> > > bpf_sock_ops_cb_flags_set() in BPF program?
> >
> > In patch 5, I meant the BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG is red=
undant.
> > It is as good as testing and setting sk_tsflags_bpf alone.
>
> I will remove it, then the code will be simplified.
>
> >
> > This could be some cleanup for the later stage of the set.
> >
> >  > >>
> > >>>
> > >>>>
> > >>>> Does it also mean either the bpf or the user space can enable the =
timetstamping
> > >>>> but not both? I don't think we can assume this also. It will be ha=
rd to deploy
> > >>>> the bpf prog in production to collect continuous data. The user sp=
ace may have
> > >>>> some timestamping enabled but the bpf may want to do its parallel =
investigation
> > >>>> also. The user space may rollout timestamping in the future and su=
ddenly break
> > >>>> the bpf prog.
> > >>>
> > >>> Well, IIUC, it's also the basic idea from the current series which
> > >>> allows both happening at the same time. Let us put it in a simple w=
ay,
> > >>> I hope that if the app uses the SO_TIMESTAMPING feature already, th=
en
> > >>> one admin deploys the BPF program, that app should be traced both i=
n
> > >>> bpf and non-bpf ways.
> > >>>
> > >>> But Willem doesn't agree about this approach[1] because of hard to =
debug.
> > >>>
> > >>> [1]: https://lore.kernel.org/all/670dda9437147_2e6c4029461@willemb.=
c.googlers.com.notmuch/
> > >>> Regarding to this link, I have a few more words to say: the socket
> > >>> could be set through bpf_setsockopt() in different phases not like
> > >>> setsockopt(), so in some cases we cannot make setsockopt hard faile=
d.
> > >>>
> > >>> After rethinking this point more, I still reckon that letting BPF
> > >>> program trace timestamping parallelly without caring whether the
> > >>> socket is set to the SO_TIMESTAMPING feature through setsockopt()
> > >>
> > >> I am afraid having both work in parallel is needed. Otherwise, it wi=
ll be very
> > >> hard to deploy a bpf prog to run continuously in scale. Being able t=
o collect
> > >> timestamp without worrying about application changes/updates/downgra=
des is
> > >> important. e.g. App changes from no time stamping to time stamping
> > >
> > > Sorry, I didn't make myself clear. Yesterday, I said I agreed with yo=
u
> > > :) So let me keep the current logic of printing (see the
> > > __skb_tstamp_tx() function in patch [04/12]) in the next version. The=
n
> > > I don't need to add some test statements to distinguish which way of
> > > printing.
> > >
> > >>
> > >> Please help to add selftests to show how the above cases (1), (2), (=
3), and
> > >> other tsflags/txflags sharing cases will work. This should not be de=
layed until
> > >> the discussion is done. It is needed sooner or later to prove both b=
pf and
> > >> non-bpf ways can work at the same time. It will help the reviewer an=
d also help
> > >> to think about the design with a real use case in bpf prog.
> > >
> > > Got it. But I'm not sure where I should put those test cases? Could
> > > you help me point out a good example that I can follow?
> >
> > Have you looked at the selftests/bpf directory?
>
> Sure, the full bpf program was written based on the examples in
> selftests/bpf. But I remembered that selftests/bpf is already
> deprecated?
>
> >
> > prog_tests/setget_sockopt.c may be something closer to what you need.
> >
> > There is a recent one in the mailing list also:
> >
> > https://lore.kernel.org/all/20241016-syncookie-v1-0-3b7a0de12153@bootli=
n.com/
> >
> > The expectation is to be able to run the test like this: ./test_progs -=
t
> > setget_sockopt
>
> Thanks for the pointer. I will spend some time studying it.
>
> >
> > >
> > >>
> > >> The example in patch 0 only prints the reported tstamp, can you shar=
e how it
> > >> will be used to investigate issue?
> > >
> > > No problem. Please see chapter 3 about "goal" in
> > > https://netdev.bots.linux.dev/netconf/2024/jason_xing.pdf.
> >
> > Thanks.
> >
> > >
> > >> Is it also useful to know when the skb is
> > >> written to the kernel during sendmsg()?
> > >
> > > You are right. Before this patch, normally applications will record a=
n
> > > accurate timestamp before do sendmsg().
> > >
> > > After you remind me of this, I feel that we can add the timestamp
> > > print in the future for bpf use.
> >
> > Yes, please add the sendmsg timestamp capturing in the selftest. It is =
useful.
> >
> > >
> > >>
> > >> Regarding the bpf_setsockopt() can be called in different phase,
> > >> bpf_setsockopt() is not limited to sockops program. e.g. it can also=
 be called
> > >> from a bpf-tcp-cc (congestion control). Not a tcp-cc expert but I wo=
n't be
> > >> surprised people will try to trigger some on-and-off timestamping fr=
om
> > >> bpf-tcp-cc to measure some delay.
> > >>
> > >>
> > >> More about bpf_setsockopt() in different phase, understand that UDP =
is not your
> > >> priority. However, it needs to have some clarity on how UDP will wor=
k and how to
> > >> enable it. UDP usually has no connect/established phase.
> > >
> > > For now, I don't expect an extension for UDP because it will bring to=
o
> > > much extra work. Could we discuss this later? I mean, after we finish
> > > the basic bpf extension :)
> >
> > Later is fine but before this set lands. I am not asking a full UDP
> > implementation but need ideas on how that may look like. We need some c=
larity on
> > how UDP will work and also how much new sockops API extension will be n=
eeded to
> > decide if sockops is the correct one going forward. I don't want to end=
 up tcp
> > is in sockops and UDP (and others) is non sockops.

The differences between TCP and UDP are:
1) TCP supports SOF_TIMESTAMPING_TX_ACK, SOF_TIMESTAMPING_OPT_ID_TCP,
while UDP does not.
2) the tskey works in different ways.
We have a good example to run and test:
tools/testing/selftests/net/txtimestamp.c

If that arouses your interesting, you could try:
1) for UDP, ./txtimestamp -4 -L 127.0.0.1 -l 1000  -c 2 -u
2) for TCP, ./txtimestamp -4 -L 127.0.0.1 -l 1000  -c 2

I think the V3 series could easily support the UDP protocol. Let me
try, then we could discuss more based on V3.

Thanks,
Jason

