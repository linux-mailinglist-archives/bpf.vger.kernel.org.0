Return-Path: <bpf+bounces-13434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B730B7D9EF1
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4D4B213F7
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4583B288;
	Fri, 27 Oct 2023 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Efp6Zd8u"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341C39848
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:37:36 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A25FE3
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:37:34 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5afbdbf3a19so6727717b3.2
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698428254; x=1699033054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzwrbRSi117CvOMZYUZQ9sYSBHMAxGiapRUuA5nZSuo=;
        b=Efp6Zd8uNeGi4H+sa1M2al0luItCE8t1y0ahfS583y8luiRLtdUgv5+iVAjEH/VBzY
         RW629F0Bbtq6czAy1NtpIlwzC4c4/x5DyAJYX/WJriyPo4yO7csfXap7CXhkpvaLuRI5
         UGVyIhtVlF50QOL3Bmjq4E399gqUI+sb6pDtCxnaoaOTTE6Ne0Yp95PrgjXs37OHeLf+
         8OKstOmt2pRz9fFm7ynvI7WHxXEOHnYChU6GgRdj3TxHok7FWr6lvmLYlYtTErX0URaK
         fMDTRD3bE+I5oq7L7Sk0BniEMBz9RvGtPKAB8q7l/nVLv1SEBd8xlPosxHkhmzhlv1in
         zQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698428254; x=1699033054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzwrbRSi117CvOMZYUZQ9sYSBHMAxGiapRUuA5nZSuo=;
        b=UBmHsRih6Zw6r7fwVcavWAst94OJ3ZM4GlqOHazacfPWmze45rf2pOPkeGn1OkCgi/
         Yt0Cz+HxNoa+TrzyIGoS+9UpvfP3byoRFr68kapooLHlrpWFfso4H+mXz6LIg7HPtZ7a
         jxPQg7ZdmkyBSUsZsAIjf66tTB16RTW1q1fJljORflFonABj1g0rIIclBuO+lE8pHuNv
         uSGCftJjSTCQzPZ769NbkryDD/0K3C3Q0SxvyRu+yPNtF5J1G88W17kPtMtwIr1TJisL
         VORBe96lw0tnh7lf5SXQYq2zWzlcFWQpYVy4e9BqHAuEx+d3lQPSC6Rg0Xt3qtOXzW5F
         gTxw==
X-Gm-Message-State: AOJu0YwtuSbKpKCni/wBMgCJUYF6VWg39oZktgBuAlA7kC1i8j91MeOA
	hQVErj4hKT/aceyFJwCymB2E20k8C/F3ResOq4PWrA==
X-Google-Smtp-Source: AGHT+IG0wAt09lu0h0Fr5SrUz/0nDYElxtGDDUccC0+TzlMD5ziEGwJ6T7OSgpuVYPmVzGYXeBGB++k+AL8vDp7aYP8=
X-Received: by 2002:a81:e20c:0:b0:5a7:c1f1:24b with SMTP id
 p12-20020a81e20c000000b005a7c1f1024bmr3245999ywl.22.1698428253713; Fri, 27
 Oct 2023 10:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009092655.22025-1-daniel@iogearbox.net> <ZTjY959R+AFXf3Xy@shredder>
 <726368f0-bbe9-6aeb-7007-6f974ed075f2@iogearbox.net> <CAM0EoM=L3ft1zuXhMsKq=Z+u7asbvpBL-KJBXLCmHBg=6BLHzQ@mail.gmail.com>
 <87dfbac5-695c-7582-cbb5-4d71b6698ab1@iogearbox.net> <CAM0EoMn-BDVbOvHEd0Pww5Hx5XD3UJnyipO+9h3HKzAVAp5n0A@mail.gmail.com>
 <dfb92d8a-60b4-cc01-996a-82ab7ddbe8f2@iogearbox.net> <CAM0EoMm85OCuOAj9b7cvyAvP7H2KGCu8W2FUDP9eDMLcEXy45A@mail.gmail.com>
 <b1b5ddab-f37c-d594-727e-a9d009bfa5be@iogearbox.net>
In-Reply-To: <b1b5ddab-f37c-d594-727e-a9d009bfa5be@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Oct 2023 13:37:22 -0400
Message-ID: <CAM0EoM=QqW9C+CJ00ZpZRGPX74wkup2AYyn+Tyq4vSFd5+cwdA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ido Schimmel <idosch@idosch.org>, kuba@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:01=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 10/26/23 1:13 AM, Jamal Hadi Salim wrote:
> > On Wed, Oct 25, 2023 at 9:46=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 10/25/23 3:21 PM, Jamal Hadi Salim wrote:
> >>> On Wed, Oct 25, 2023 at 7:52=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>>> On 10/25/23 1:05 PM, Jamal Hadi Salim wrote:
> >>>>> On Wed, Oct 25, 2023 at 6:01=E2=80=AFAM Daniel Borkmann <daniel@iog=
earbox.net> wrote:
> >>>>>> On 10/25/23 10:59 AM, Ido Schimmel wrote:
> >>>>>>> On Mon, Oct 09, 2023 at 11:26:54AM +0200, Daniel Borkmann wrote:
> >>>>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>>>>>> index 606a366cc209..664426285fa3 100644
> >>>>>>>> --- a/net/core/dev.c
> >>>>>>>> +++ b/net/core/dev.c
> >>>>>>>> @@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue=
);
> >>>>>>>>      #endif /* CONFIG_NET_EGRESS */
> >>>>>>>>
> >>>>>>>>      #ifdef CONFIG_NET_XGRESS
> >>>>>>>> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> >>>>>>>> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> >>>>>>>> +              enum skb_drop_reason *drop_reason)
> >>>>>>>>      {
> >>>>>>>>         int ret =3D TC_ACT_UNSPEC;
> >>>>>>>>      #ifdef CONFIG_NET_CLS_ACT
> >>>>>>>> @@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entr=
y, struct sk_buff *skb)
> >>>>>>>>
> >>>>>>>>         tc_skb_cb(skb)->mru =3D 0;
> >>>>>>>>         tc_skb_cb(skb)->post_ct =3D false;
> >>>>>>>> +    res.drop_reason =3D *drop_reason;
> >>>>>>>>
> >>>>>>>>         mini_qdisc_bstats_cpu_update(miniq, skb);
> >>>>>>>>         ret =3D tcf_classify(skb, miniq->block, miniq->filter_li=
st, &res, false);
> >>>>>>>>         /* Only tcf related quirks below. */
> >>>>>>>>         switch (ret) {
> >>>>>>>>         case TC_ACT_SHOT:
> >>>>>>>> +            *drop_reason =3D res.drop_reason;
> >>>>>>>
> >>>>>>> Daniel,
> >>>>>>>
> >>>>>>> Getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and thi=
s
> >>>>>>> reproducer [2]. Problem seems to be that classifiers clear 'struc=
t
> >>>>>>> tcf_result::drop_reason', thereby triggering the warning in
> >>>>>>> __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0=
).
> >>>>>>>
> >>>>>>> Fixed by maintaining the original drop reason if the one returned=
 from
> >>>>>>> tcf_classify() is 'SKB_NOT_DROPPED_YET' [3]. I can submit this fi=
x
> >>>>>>> unless you have a better idea.
> >>>>>>
> >>>>>> Thanks for catching this, looks reasonable to me as a fix.
> >>>>>>
> >>>>>>> [1]
> >>>>>>> WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reas=
on+0x38/0x130
> >>>>>>> Modules linked in:
> >>>>>>> CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43=
e6d9582e0 #682
> >>>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.=
2-1.fc37 04/01/2014
> >>>>>>> RIP: 0010:kfree_skb_reason+0x38/0x130
> >>>>>>> [...]
> >>>>>>> Call Trace:
> >>>>>>>      <IRQ>
> >>>>>>>      __netif_receive_skb_core.constprop.0+0x837/0xdb0
> >>>>>>>      __netif_receive_skb_one_core+0x3c/0x70
> >>>>>>>      process_backlog+0x95/0x130
> >>>>>>>      __napi_poll+0x25/0x1b0
> >>>>>>>      net_rx_action+0x29b/0x310
> >>>>>>>      __do_softirq+0xc0/0x29b
> >>>>>>>      do_softirq+0x43/0x60
> >>>>>>>      </IRQ>
> >>>>>>>
> >>>>>>> [2]
> >>>>>>> #!/bin/bash
> >>>>>>>
> >>>>>>> ip link add name veth0 type veth peer name veth1
> >>>>>>> ip link set dev veth0 up
> >>>>>>> ip link set dev veth1 up
> >>>>>>> tc qdisc add dev veth1 clsact
> >>>>>>> tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 0=
0:11:22:33:44:55 action drop
> >>>>>>> mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> >>>>>>
> >>>>>> I didn't know you're using mausezahn, nice :)
> >>>>>>
> >>>>>>> [3]
> >>>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>>>>> index a37a932a3e14..abd0b13f3f17 100644
> >>>>>>> --- a/net/core/dev.c
> >>>>>>> +++ b/net/core/dev.c
> >>>>>>> @@ -3929,7 +3929,8 @@ static int tc_run(struct tcx_entry *entry, =
struct sk_buff *skb,
> >>>>>>>             /* Only tcf related quirks below. */
> >>>>>>>             switch (ret) {
> >>>>>>>             case TC_ACT_SHOT:
> >>>>>>> -               *drop_reason =3D res.drop_reason;
> >>>>>>> +               if (res.drop_reason !=3D SKB_NOT_DROPPED_YET)
> >>>>>>> +                       *drop_reason =3D res.drop_reason;
> >>>>>>>                     mini_qdisc_qstats_cpu_drop(miniq);
> >>>>>>>                     break;
> >>>>>>>             case TC_ACT_OK:
> >>>>>>>
> >>>>>
> >>>>> Out of curiosity - how does the policy say "drop" but drop_reason d=
oes
> >>>>> not reflect it?
> >>>>
> >>>> Ido, Jamal, wdyt about this alternative approach - these were the lo=
cations I could
> >>>> find from an initial glance (compile-tested) :
> >>>>
> >>>>    From a3d46a55aac484372b60b783cb6a3c98a0fef75c Mon Sep 17 00:00:00=
 2001
> >>>> From: Daniel Borkmann <daniel@iogearbox.net>
> >>>> Date: Wed, 25 Oct 2023 11:43:44 +0000
> >>>> Subject: [PATCH] net, sched: fix..
> >>>>
> >>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >>>> ---
> >>>>     include/net/pkt_cls.h    | 12 ++++++++++++
> >>>>     net/sched/cls_basic.c    |  2 +-
> >>>>     net/sched/cls_bpf.c      |  2 +-
> >>>>     net/sched/cls_flower.c   |  2 +-
> >>>>     net/sched/cls_fw.c       |  2 +-
> >>>>     net/sched/cls_matchall.c |  2 +-
> >>>>     net/sched/cls_route.c    |  4 ++--
> >>>>     net/sched/cls_u32.c      |  2 +-
> >>>>     8 files changed, 20 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >>>> index a76c9171db0e..31d8e8587824 100644
> >>>> --- a/include/net/pkt_cls.h
> >>>> +++ b/include/net/pkt_cls.h
> >>>> @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct t=
cf_result *res,
> >>>>           res->drop_reason =3D reason;
> >>>>     }
> >>>>
> >>>> +static inline void tcf_set_result(struct tcf_result *to,
> >>>> +                                 const struct tcf_result *from)
> >>>> +{
> >>>> +       /* tcf_result's drop_reason which is the last member must be
> >>>> +        * preserved and cannot be copied from the cls'es tcf_result
> >>>> +        * template given this is carried all the way and potentiall=
y
> >>>> +        * set to a concrete tc drop reason upon error or intentiona=
l
> >>>> +        * drop. See tcf_set_drop_reason() locations.
> >>>> +        */
> >>>> +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
> >>>> +}
> >>>> +
> >>>
> >>> Daniel, IMO, doing this at cls_api is best instead (like what Victors
> >>> or my original patch did). Iam ~30K feet right now with a lousy
> >>> keyboard - you can either do it, or i or Victor can send the patch by
> >>> end of day today. There are missing cases which were covered by Victo=
r
> >>> and possibly something else will pop up next.
> >>
> >> Sure, if you have sth clean and simple for today, go for it. Otherwise=
 I
> >> can cook a proper one out of this as a fix and ship it tomorrow AM, so=
 we
> >> have a fix for the splat in CONFIG_DEBUG_NET kernels and you can still
> >> refactor later.
> >
> > I was thinking something along these lines:
> >
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -1662,6 +1662,7 @@ static inline int __tcf_classify(struct sk_buff *=
skb,
> >          const int max_reclassify_loop =3D 16;
> >          const struct tcf_proto *first_tp;
> >          int limit =3D 0;
> > +       u32 reason_code =3D res->drop_reason;
> >
> >   reclassify:
> >   #endif
> > @@ -1712,8 +1713,11 @@ static inline int __tcf_classify(struct sk_buff =
*skb,
> >                          goto reset;
> >                  }
> >   #endif
> > -               if (err >=3D 0)
> > +               if (err >=3D 0) {
> > +                       if (err =3D=3D TC_ACT_SHOT) /* policy drop */
> > +                               tcf_set_drop_reason(res, orig_reason);
> >                          return err;
> > +               }
> >          }
> >
> >          if (unlikely(n)) {
> >
> > But tbh, i am struggling with the whole approach you took in the
> > earlier patch - i.e setting the drop reason from cls_act and then
> > expecting it not to be changed on policy drops; while it works for
> > clsact, it is not going to work for the rest of the qdiscs - unless we
> > change all the qdisc enqueues to take an extra param for drop_reason.
> > Thoughts?
>
> The downside of the above would be that you then cannot make use of
> tcf_set_drop_reason() further down the tc engine, for example, within
> classifiers/actions, e.g. tcf_action_exec() where you also have drops
> like:
>
> [...]
>                  } else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
>                          if (unlikely(!rcu_access_pointer(a->goto_chain))=
) {
>                                  net_warn_ratelimited("can't go to NULL c=
hain!\n");
>                                  return TC_ACT_SHOT;
>                          }
>                          tcf_action_goto_chain_exec(a, res);
>                  }
> [...]

Unless i misread your approach it is what you are doing? i.e set a
drop reason you dont expect to be changed on policy decision..

> If I spot this correctly, qdiscs also use tcf_classify() as well, and
> so far none of them have kfree_skb_reason() support, but if you plan to
> add it you can just set a default res.drop_reason from there as well
> since tcf_classify() already takes the res param.
>

The issue is the calling code starting at the dev_queue_xmit will
overwrite the code. You dont have this problem because ingress and
clsact both are self contained. A better solution is to also set it in
some skb->metadata (tc_cb should be enough); i note that looking at
the calling code it is done per batch of skbs with exactly the same
code reason for the whole batch instead per skb (git says Eric added
this change as an optimization)

cheers,
jamal
> Thanks,
> Daniel

