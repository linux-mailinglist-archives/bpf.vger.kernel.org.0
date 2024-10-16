Return-Path: <bpf+bounces-42177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03399A0786
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 12:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8ACA1C21831
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9F206975;
	Wed, 16 Oct 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJmhh8qZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBB206055;
	Wed, 16 Oct 2024 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075011; cv=none; b=cjtmgHJaA49fCbSABx9kidZX5Dp+vb94MLoHfRHErGohNWjHgg0eAAu+7DMl2Zu0epHbm9I1F063/CSU8/rinuCXeDqm9ywwxXCVb9BYPqXAe1l6WT4VHgoD7B2RGwN6MZwGhVu2osfWNgY0s7B6Tp514DNhUbfcBZydDRGvvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075011; c=relaxed/simple;
	bh=/sswPeyibPeDfeXisFDt+KRF0kja2MS8Y6Cy/qyfDho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0AG7Bt5ljfcYiBDTebEZ3ykJHJ7Tz0YgNENwJFCGrC335VyUCu3cLk07WY0qnjAfVyr30IabOPxFr8znHx2nRtu7thy8Ms4pDxLNT8q7C4mtnotY7VWR19v64hKWAzlrA2+N+Rs2Wi9qCy5xiOacGNDITGTL1f7CjUDM7L8PuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJmhh8qZ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8323b555a6aso382021539f.3;
        Wed, 16 Oct 2024 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729075009; x=1729679809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0T6BlPSMFJmQ84FkjThVuVkEQIR8mehjQ+Jtucqpd1Q=;
        b=bJmhh8qZ/qgqfttiKbnpYzEwSEVIeBHSbo+mInWTvWVp3hW4SlZdziTwEdII4pOf3k
         P+lNI3y097NFEn/pWa5L15ycW1sHub1QEX/nG3mSAm0gDMKfHskt2x3D49C4j1sadTuv
         8qAde+qEw9VVa5YfI6n/a26Xia6m84vgs0Ew3cYvGYRhpewxiAh6jXq+KeRuxpXQrW/m
         +4lI49PNJcX3MEzguVwXZsnpwi+r87cCDG7c5aICbquqWB7w4aLd9FVNGiparWGPqDiY
         /c9+cWl0pHCnHMHgOX9ZgLS85IqQNK3mux64rq7ZOvzfhNL9f8U6LUxB0MHiqrstH60B
         T4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075009; x=1729679809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0T6BlPSMFJmQ84FkjThVuVkEQIR8mehjQ+Jtucqpd1Q=;
        b=c3mo+jpbkHtWjhm0VebSlqlARi381Cgw5b5b454riB1GlEN4CuQjso21ddsMfe/MeV
         dcy+S65CFWxBDOH0M2rwcDwdYWDyqOZG4AdoqKI9eTAog4Ay3Lhfhysou0VhJ4vWGZ1p
         O2GOwUOB4ew8+X/BHR9+/CelTAAcQp65HwrQqJ2Npr5jmqsAB89L8gJcVQHhK0bT93ZR
         Jct4M/KIOuS6357Ewh5vnspX4mSXo1vxlGASzoiQkm4B4Qg+1jGVYbVv4Vt+Gy2HQMoA
         T8oZMM/VzBu+nkq6gWBDVEKF0ypd8GOxxf9Y+v0FIwMjJz6vAl7e7ZR//VwLrjCQ/xjk
         /TKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIKjmh0vfxhnVu7x0VPS8SIDg/ZYtf2E1jjtNdnkUGa0NuRXXJs0sX+5zQmdWq/MJEFhQ=@vger.kernel.org, AJvYcCXFgsC1ySb8FVAOfE9/S8Q0jDahlmCqHTQQa1g+UpCiIvNvBzUPG1cJ4ygNXjcaJFiOWWPFAcqi@vger.kernel.org
X-Gm-Message-State: AOJu0YwopSvI9SkgPtNO7VEMeiimhktuqg2cPb3IK09/WGVSUSKR5inc
	P6ALUnb1IEOSDeZ+T2spQ5qApXJ+AJEpi6iQJgm3QkCo+0qXyBqSqnhDBAMg4w7ryj5iaP1NGkH
	WDfe1jVgoN9nqctVut+S2Lxd+zM5ikt/R
X-Google-Smtp-Source: AGHT+IFIhr2QVDBOEepIDFjyDrDGrOaO1FfAAyoHFj+aQyMnY3qVoSpXVTkfzxovg/yDe318LigSEPVBmRBoKIjKsl0=
X-Received: by 2002:a05:6e02:1a0b:b0:3a3:b4dd:4db with SMTP id
 e9e14a558f8ab-3a3b5c73b7fmr192784755ab.0.1729075008502; Wed, 16 Oct 2024
 03:36:48 -0700 (PDT)
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
 <c669769f-8437-46cc-95b4-d3f84c1c95b7@linux.dev>
In-Reply-To: <c669769f-8437-46cc-95b4-d3f84c1c95b7@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 18:36:12 +0800
Message-ID: <CAL+tcoD-fzq7dSwkM4nRE8vF-y=+RO1y8X=95+D8Gv3QXTRWCA@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 4:31=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/16/24 12:54 AM, Jason Xing wrote:
> > On Wed, Oct 16, 2024 at 3:01=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 10/15/24 11:30 PM, Jason Xing wrote:
> >>> On Wed, Oct 16, 2024 at 2:13=E2=80=AFPM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> >>>>
> >>>> On 10/15/24 6:32 PM, Jason Xing wrote:
> >>>>> On Wed, Oct 16, 2024 at 9:04=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> >>>>>>
> >>>>>> On Wed, Oct 16, 2024 at 8:10=E2=80=AFAM Martin KaFai Lau <martin.l=
au@linux.dev> wrote:
> >>>>>>>
> >>>>>>> On 10/11/24 9:06 PM, Jason Xing wrote:
> >>>>>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>>>>
> >>>>>>>> Willem suggested that we use a static key to control. The advant=
age
> >>>>>>>> is that we will not affect the existing applications at all if w=
e
> >>>>>>>> don't load BPF program.
> >>>>>>>>
> >>>>>>>> In this patch, except the static key, I also add one logic that =
is
> >>>>>>>> used to test if the socket has enabled its tsflags in order to
> >>>>>>>> support bpf logic to allow both cases to happen at the same time=
.
> >>>>>>>> Or else, the skb carring related timestamp flag doesn't know whi=
ch
> >>>>>>>> way of printing is desirable.
> >>>>>>>>
> >>>>>>>> One thing important is this patch allows print from both applica=
tions
> >>>>>>>> and bpf program at the same time. Now we have three kinds of pri=
nt:
> >>>>>>>> 1) only BPF program prints
> >>>>>>>> 2) only application program prints
> >>>>>>>> 3) both can print without side effect
> >>>>>>>>
> >>>>>>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>>>>>>> ---
> >>>>>>>>      include/net/sock.h |  1 +
> >>>>>>>>      net/core/filter.c  |  3 +++
> >>>>>>>>      net/core/skbuff.c  | 38 +++++++++++++++++++++++++++++++++++=
+++
> >>>>>>>>      3 files changed, 42 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/include/net/sock.h b/include/net/sock.h
> >>>>>>>> index 66ecd78f1dfe..b7c51b95c92d 100644
> >>>>>>>> --- a/include/net/sock.h
> >>>>>>>> +++ b/include/net/sock.h
> >>>>>>>> @@ -2889,6 +2889,7 @@ static inline bool sk_dev_equal_l3scope(st=
ruct sock *sk, int dif)
> >>>>>>>>      void sock_def_readable(struct sock *sk);
> >>>>>>>>
> >>>>>>>>      int sock_bindtoindex(struct sock *sk, int ifindex, bool loc=
k_sk);
> >>>>>>>> +DECLARE_STATIC_KEY_FALSE(bpf_tstamp_control);
> >>>>>>>>      void sock_set_timestamp(struct sock *sk, int optname, bool =
valbool);
> >>>>>>>>      int sock_get_timestamping(struct so_timestamping *timestamp=
ing,
> >>>>>>>>                            sockptr_t optval, unsigned int optlen=
);
> >>>>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>>>>>>> index 996426095bd9..08135f538c99 100644
> >>>>>>>> --- a/net/core/filter.c
> >>>>>>>> +++ b/net/core/filter.c
> >>>>>>>> @@ -5204,6 +5204,8 @@ static const struct bpf_func_proto bpf_get=
_socket_uid_proto =3D {
> >>>>>>>>          .arg1_type      =3D ARG_PTR_TO_CTX,
> >>>>>>>>      };
> >>>>>>>>
> >>>>>>>> +DEFINE_STATIC_KEY_FALSE(bpf_tstamp_control);
> >>>>>>>> +
> >>>>>>>>      static int bpf_sock_set_timestamping(struct sock *sk,
> >>>>>>>>                                       struct so_timestamping *ti=
mestamping)
> >>>>>>>>      {
> >>>>>>>> @@ -5217,6 +5219,7 @@ static int bpf_sock_set_timestamping(struc=
t sock *sk,
> >>>>>>>>                  return -EINVAL;
> >>>>>>>>
> >>>>>>>>          WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags)=
;
> >>>>>>>> +     static_branch_enable(&bpf_tstamp_control);
> >>>>>>>
> >>>>>>> Not sure when is a good time to do static_branch_disable().
> >>>>>>
> >>>>>> Thanks for the review.
> >>>>>>
> >>>>>> To be honest, I considered how to disable the static key. Like you
> >>>>>> said, I failed to find a good chance that I can accurately disable=
 it.
> >>>>>>
> >>>>>>>
> >>>>>>> The bpf prog may be detached also. (IF) it ends up staying with t=
he
> >>>>>>> cgroup/sockops interface, it should depend on the existing static=
 key in
> >>>>>>> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one=
.
> >>>>>>
> >>>>>> Are you suggesting that we need to remove the current static key? =
In
> >>>>>> the previous thread, the reason why Willem came up with this idea =
is,
> >>>>>> I think, to avoid affect the non-bpf timestamping feature.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>          return 0;
> >>>>>>>>      }
> >>>>>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>>>>>>> index f36eb9daa31a..d0f912f1ff7b 100644
> >>>>>>>> --- a/net/core/skbuff.c
> >>>>>>>> +++ b/net/core/skbuff.c
> >>>>>>>> @@ -5540,6 +5540,29 @@ void skb_complete_tx_timestamp(struct sk_=
buff *skb,
> >>>>>>>>      }
> >>>>>>>>      EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >>>>>>>>
> >>>>>>>> +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, in=
t tstype)
> >>>>>>>
> >>>>>>> sk is unused.
> >>>>>>
> >>>>>> Thanks for the careful check.
> >>>>>>
> >>>>>>>
> >>>>>>>> +{
> >>>>>>>> +     u32 testflag;
> >>>>>>>> +
> >>>>>>>> +     switch (tstype) {
> >>>>>>>> +     case SCM_TSTAMP_SCHED:
> >>>>>>>
> >>>>>>> Instead of doing this translation,
> >>>>>>> is it easier to directly store the bpf prog desired ts"type" (i.e=
. the
> >>>>>>> SCM_TSTAMP_*) in the sk->sk_tsflags_bpf?
> >>>>>>> or there is a specific need to keep the SOF_TIMESTAMPING_* value =
in
> >>>>>>> sk->sk_tsflags_bpf?
> >>>>>>
> >>>>>> We have to reuse SOF_TIMESTAMPING_* because there are more flags, =
say,
> >>>>>> SOF_TIMESTAMPING_OPT_ID, that we need to support.
> >>>>>>
> >>>>>>>
> >>>>>>>> +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> >>>>>>>> +             break;
> >>>>>>>> +     case SCM_TSTAMP_SND:
> >>>>>>>> +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> >>>>>>>> +             break;
> >>>>>>>> +     case SCM_TSTAMP_ACK:
> >>>>>>>> +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> >>>>>>>> +             break;
> >>>>>>>> +     default:
> >>>>>>>> +             return false;
> >>>>>>>> +     }
> >>>>>>>> +     if (tsflags & testflag)
> >>>>>>>> +             return true;
> >>>>>>>> +
> >>>>>>>> +     return false;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> >>>>>>>>                                   const struct sk_buff *ack_skb,
> >>>>>>>>                                   struct skb_shared_hwtstamps *h=
wtstamps,
> >>>>>>>> @@ -5558,6 +5581,9 @@ static void skb_tstamp_tx_output(struct sk=
_buff *orig_skb,
> >>>>>>>>          if (!skb_may_tx_timestamp(sk, tsonly))
> >>>>>>>>                  return;
> >>>>>>>>
> >>>>>>>> +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> >>>>>>>
> >>>>>>> This is a new test. tsflags is the sk->sk_tsflags here if I read =
it correctly.
> >>>>>>
> >>>>>> This test will be used in bpf and non-bpf cases. Because of this, =
we
> >>>>>> can support BPF extension. In this function, if skb has tsflags bu=
t we
> >>>>>> don't know which approach the user expects, sk_tstamp_tx_flags() c=
an
> >>>>>> help us.
> >>>>>>
> >>>>>>>
> >>>>>>> My understanding is the sendmsg can provide SOF_TIMESTAMPING_* fo=
r individual
> >>>>>>> skb. Would it break?
> >>>>>>
> >>>>>> Oh, you're right. I didn't support cmsg mode...
> >>>>>
> >>>>> I think I only need to test if it's in the bpf mode, or else let th=
e
> >>>>> original way print the timestamp, which can solve the issue.
> >>>>
> >>>>    From looking at the existing "__skb_tstamp_tx(skb, NULL, NULL, sk=
b->sk,
> >>>> SCM_TSTAMP_SCHED);":
> >>>>
> >>>> int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> >>>> {
> >>>>           /* ... */
> >>>>
> >>>>           if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAM=
P))
> >>>>                   __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTA=
MP_SCHED);
> >>>>
> >>>>           /* ... */
> >>>> }
> >>>>
> >>>> I am still puzzling how __skb_tstamp_tx() will be called if only bpf=
 has enabled
> >>>> the timestamping. I may have missed somewhere in the patch set that =
the skb's
> >>>> tx_flags is changed by sk->sk_tsflags_bpf alone?
> >>>
> >>> If sk_tsflags_bpf is set, tcp_sendmsg() -> tcp_tx_timestamp() will be
> >>> helpful, which initializes every last skb, please see patch [10/12].
> >>
> >> Ah. ok. It is the thing I missed. Thanks for the pointer.
> >>
> >>>>
> >>>> I think a skb tskey is still desired (?), so eventually we want some=
 spaces in
> >>>
> >>> tskey function is optional I think. It depends whether users want to
> >>> use it or not. It can controlled by SOF_TIMESTAMPING_OPT_ID flag.
> >>>
> >>>> the skb for bpf. Jakub Sitnicki (cc-ed) has presented in LPC about e=
xtending
> >>>> skb->data_meta usage outside of xdp and tc. I think here we want to =
have it
> >>>> available at the tx side to store the tx_flags and tskey but probabl=
y want them
> >>>> at a specific place/offset at the data_meta.
> >>>
> >>> If we have the plan to store extra information in data_meta, I can
> >>> give it a try:)
> >>>
> >>>>
> >>>> For now, is there thing we can explore to share in the skb_shared_in=
fo?
> >>>
> >>> My initial thought is just to reuse these fields in skb. It can work
> >>> without interfering one another.
> >>
> >> After reading closer to patch 10, I am likely still missing something.=
 How can
> >> it tell if the tx_flags is set by the bpf or by the user space cmsg?
> >
> > If the skb carries the timestamp, there are three cases:
> > 1) non-bpf case and users uses setsockopt()
> > 2) cmsg case
> > 3) bpf case
> >
> > #1 and #2 are already handled well before this patch. I only need to
> > test if sk_tsflags_bpf has those flags. If so, it means we hit #3, or
> > else it could be #1 or #2, then we will let the old way print
> > timestamps in __skb_tstamp_tx().
>
> hmm... I am still not sure I fully understand...but I think I may start g=
etting it.

Sorry, my bad. I gave the wrong answer...

It should be:
Testing if if sk_tsflags has SOF_TIMESTAMPING_SOFTWARE flag should
work fine. If it has the flag, we could use skb_tstamp_tx_output() to
print based on patch [4/12]; if not, we will use
bpf_skb_tstamp_tx_output() to print.

If users use traditional ways of deploying SO_TIMESTAMPING, sk_tsflags
always has SOF_TIMESTAMPING_SOFTWARE which is a software report flag
(please see Documentation/networking/timestamping.rst). We can see a
good example on how to use in
tools/testing/selftests/net/txtimestamp.c:
do_test()
{
        sock_opt =3D SOF_TIMESTAMPING_SOFTWARE |
        ...
        if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
                              (char *) &sock_opt, sizeof(sock_opt)))
}

>
> Is it the reason that the bpf_setsockopt() cannot clear the sk_tsflags_bp=
f once
> it is set in patch 2? It is not a usable api tbh. It will be a surprise t=
o many.
> It has to be able to set and clear.

I cannot find a good time to clear all the sockets which are set
through the BPF program. If we detach the BPF program, it will not
print of course. Does it really matter if we don't clear the
sk_tsflags_bpf?

>
> Does it also mean either the bpf or the user space can enable the timetst=
amping
> but not both? I don't think we can assume this also. It will be hard to d=
eploy
> the bpf prog in production to collect continuous data. The user space may=
 have
> some timestamping enabled but the bpf may want to do its parallel investi=
gation
> also. The user space may rollout timestamping in the future and suddenly =
break
> the bpf prog.

Well, IIUC, it's also the basic idea from the current series which
allows both happening at the same time. Let us put it in a simple way,
I hope that if the app uses the SO_TIMESTAMPING feature already, then
one admin deploys the BPF program, that app should be traced both in
bpf and non-bpf ways.

But Willem doesn't agree about this approach[1] because of hard to debug.

[1]: https://lore.kernel.org/all/670dda9437147_2e6c4029461@willemb.c.google=
rs.com.notmuch/
Regarding to this link, I have a few more words to say: the socket
could be set through bpf_setsockopt() in different phases not like
setsockopt(), so in some cases we cannot make setsockopt hard failed.

After rethinking this point more, I still reckon that letting BPF
program trace timestamping parallelly without caring whether the
socket is set to the SO_TIMESTAMPING feature through setsockopt()
method. It means I would like to keep this part in patch [04/12]:
@@ -5601,6 +5636,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
        if (!sk)
                return;

+       if (static_branch_unlikely(&bpf_tstamp_control))
+               bpf_skb_tstamp_tx_output(sk, tstype);
+
        skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk,
tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);

>
> [ getting late here. will continue later. ]

Thanks for your effort :)

Thanks,
Jason

