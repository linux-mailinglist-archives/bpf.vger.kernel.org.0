Return-Path: <bpf+bounces-13285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08DC7D786B
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 01:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43E7B212D5
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367F374E9;
	Wed, 25 Oct 2023 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wxWxIIEO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A648339AE
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 23:13:26 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96AA3
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 16:13:25 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso184551fac.2
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698275604; x=1698880404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z/oHSoW8Iz40ylsDgWh9lzGI+0ROYDCt1lTpYwSXrE=;
        b=wxWxIIEOeblbhH5vzPj5lawNBcZquhmQK5q8SQhkrK10MY7sQHlvBMbuqqZ6EVoyPC
         n2474f+C5Oak++YSkpnhwwXTw23GqYW9epS5UrjcUQdgrgbZ7RKY2CiaVuskrQaP91kB
         mwX20elCzhAdIEHqaW9mvqBMq0Gxnp0XylmJe9L1IKF5kxaA1jHb8KcTm6CYN2pOK9mS
         I21U23bzbDFmfdbuBLbXVT+T715y/Wk2xOBeWP9loRXidQHxH4PXws3iyC7MfOepjRhF
         XBWBh1cIsjhAsAmu3TIn+cfHPhewTM0Mfkx5nbI6Fxg4jK+fsdsi9KUckNV22tyzxDXg
         NaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698275604; x=1698880404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z/oHSoW8Iz40ylsDgWh9lzGI+0ROYDCt1lTpYwSXrE=;
        b=ZFevvKUJe3uocICj049ytnSExCqsVyn1oCaiBiwfcDy//XnOHtJrIgzaiZKH0V/7Dv
         KVCmc1JFcEY0gAbDokSru3Y9Il29y/TkKqJ8UYc936GLxz4DYeHBX2kFOx3WcfkcSMX1
         J6Mg02x1BHOzvAjYoB29CkOOBmn9cvVyy8uxLLZIV4YVAobda1GeYnFLQbMYYjt3rJ0P
         oMptdjc0bjcuVUPypcw8FWS/u0RjYkUEUv8KxaG4++uwEzIjhKNHj3Rg7mJvcgFwCFyA
         NFRM0Zujygrox9nGNbYxS+A6fpuErt/zL1I9SZqd0ANBZxilRTFrXYkMlqtNSeacukCy
         z+fQ==
X-Gm-Message-State: AOJu0YxGldcLq3v+pWM4MENzzfOfOwiYo+3YuYB6AQIpOyMNZWMBMa2v
	R3uahxpvYup2+f/k/OHrYdvj2yp5AZ5OKU/uszjvAg==
X-Google-Smtp-Source: AGHT+IEXfHOA1xDV3AdebHGopTOpnYnWtVQNBLpk995XLkbWfWPnXQbVGF2LjYRsOInM2GIoFOKszHG3WVJyjqDminY=
X-Received: by 2002:a05:6870:15cb:b0:1c4:e139:33e with SMTP id
 k11-20020a05687015cb00b001c4e139033emr18656262oad.59.1698275604416; Wed, 25
 Oct 2023 16:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009092655.22025-1-daniel@iogearbox.net> <ZTjY959R+AFXf3Xy@shredder>
 <726368f0-bbe9-6aeb-7007-6f974ed075f2@iogearbox.net> <CAM0EoM=L3ft1zuXhMsKq=Z+u7asbvpBL-KJBXLCmHBg=6BLHzQ@mail.gmail.com>
 <87dfbac5-695c-7582-cbb5-4d71b6698ab1@iogearbox.net> <CAM0EoMn-BDVbOvHEd0Pww5Hx5XD3UJnyipO+9h3HKzAVAp5n0A@mail.gmail.com>
 <dfb92d8a-60b4-cc01-996a-82ab7ddbe8f2@iogearbox.net>
In-Reply-To: <dfb92d8a-60b4-cc01-996a-82ab7ddbe8f2@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Oct 2023 19:13:12 -0400
Message-ID: <CAM0EoMm85OCuOAj9b7cvyAvP7H2KGCu8W2FUDP9eDMLcEXy45A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ido Schimmel <idosch@idosch.org>, kuba@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 9:46=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/25/23 3:21 PM, Jamal Hadi Salim wrote:
> > On Wed, Oct 25, 2023 at 7:52=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 10/25/23 1:05 PM, Jamal Hadi Salim wrote:
> >>> On Wed, Oct 25, 2023 at 6:01=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>>> On 10/25/23 10:59 AM, Ido Schimmel wrote:
> >>>>> On Mon, Oct 09, 2023 at 11:26:54AM +0200, Daniel Borkmann wrote:
> >>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>>>> index 606a366cc209..664426285fa3 100644
> >>>>>> --- a/net/core/dev.c
> >>>>>> +++ b/net/core/dev.c
> >>>>>> @@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> >>>>>>     #endif /* CONFIG_NET_EGRESS */
> >>>>>>
> >>>>>>     #ifdef CONFIG_NET_XGRESS
> >>>>>> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> >>>>>> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> >>>>>> +              enum skb_drop_reason *drop_reason)
> >>>>>>     {
> >>>>>>        int ret =3D TC_ACT_UNSPEC;
> >>>>>>     #ifdef CONFIG_NET_CLS_ACT
> >>>>>> @@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entry,=
 struct sk_buff *skb)
> >>>>>>
> >>>>>>        tc_skb_cb(skb)->mru =3D 0;
> >>>>>>        tc_skb_cb(skb)->post_ct =3D false;
> >>>>>> +    res.drop_reason =3D *drop_reason;
> >>>>>>
> >>>>>>        mini_qdisc_bstats_cpu_update(miniq, skb);
> >>>>>>        ret =3D tcf_classify(skb, miniq->block, miniq->filter_list,=
 &res, false);
> >>>>>>        /* Only tcf related quirks below. */
> >>>>>>        switch (ret) {
> >>>>>>        case TC_ACT_SHOT:
> >>>>>> +            *drop_reason =3D res.drop_reason;
> >>>>>
> >>>>> Daniel,
> >>>>>
> >>>>> Getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and this
> >>>>> reproducer [2]. Problem seems to be that classifiers clear 'struct
> >>>>> tcf_result::drop_reason', thereby triggering the warning in
> >>>>> __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).
> >>>>>
> >>>>> Fixed by maintaining the original drop reason if the one returned f=
rom
> >>>>> tcf_classify() is 'SKB_NOT_DROPPED_YET' [3]. I can submit this fix
> >>>>> unless you have a better idea.
> >>>>
> >>>> Thanks for catching this, looks reasonable to me as a fix.
> >>>>
> >>>>> [1]
> >>>>> WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason=
+0x38/0x130
> >>>>> Modules linked in:
> >>>>> CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6=
d9582e0 #682
> >>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-=
1.fc37 04/01/2014
> >>>>> RIP: 0010:kfree_skb_reason+0x38/0x130
> >>>>> [...]
> >>>>> Call Trace:
> >>>>>     <IRQ>
> >>>>>     __netif_receive_skb_core.constprop.0+0x837/0xdb0
> >>>>>     __netif_receive_skb_one_core+0x3c/0x70
> >>>>>     process_backlog+0x95/0x130
> >>>>>     __napi_poll+0x25/0x1b0
> >>>>>     net_rx_action+0x29b/0x310
> >>>>>     __do_softirq+0xc0/0x29b
> >>>>>     do_softirq+0x43/0x60
> >>>>>     </IRQ>
> >>>>>
> >>>>> [2]
> >>>>> #!/bin/bash
> >>>>>
> >>>>> ip link add name veth0 type veth peer name veth1
> >>>>> ip link set dev veth0 up
> >>>>> ip link set dev veth1 up
> >>>>> tc qdisc add dev veth1 clsact
> >>>>> tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:=
11:22:33:44:55 action drop
> >>>>> mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> >>>>
> >>>> I didn't know you're using mausezahn, nice :)
> >>>>
> >>>>> [3]
> >>>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>>> index a37a932a3e14..abd0b13f3f17 100644
> >>>>> --- a/net/core/dev.c
> >>>>> +++ b/net/core/dev.c
> >>>>> @@ -3929,7 +3929,8 @@ static int tc_run(struct tcx_entry *entry, st=
ruct sk_buff *skb,
> >>>>>            /* Only tcf related quirks below. */
> >>>>>            switch (ret) {
> >>>>>            case TC_ACT_SHOT:
> >>>>> -               *drop_reason =3D res.drop_reason;
> >>>>> +               if (res.drop_reason !=3D SKB_NOT_DROPPED_YET)
> >>>>> +                       *drop_reason =3D res.drop_reason;
> >>>>>                    mini_qdisc_qstats_cpu_drop(miniq);
> >>>>>                    break;
> >>>>>            case TC_ACT_OK:
> >>>>>
> >>>
> >>> Out of curiosity - how does the policy say "drop" but drop_reason doe=
s
> >>> not reflect it?
> >>
> >> Ido, Jamal, wdyt about this alternative approach - these were the loca=
tions I could
> >> find from an initial glance (compile-tested) :
> >>
> >>   From a3d46a55aac484372b60b783cb6a3c98a0fef75c Mon Sep 17 00:00:00 20=
01
> >> From: Daniel Borkmann <daniel@iogearbox.net>
> >> Date: Wed, 25 Oct 2023 11:43:44 +0000
> >> Subject: [PATCH] net, sched: fix..
> >>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>    include/net/pkt_cls.h    | 12 ++++++++++++
> >>    net/sched/cls_basic.c    |  2 +-
> >>    net/sched/cls_bpf.c      |  2 +-
> >>    net/sched/cls_flower.c   |  2 +-
> >>    net/sched/cls_fw.c       |  2 +-
> >>    net/sched/cls_matchall.c |  2 +-
> >>    net/sched/cls_route.c    |  4 ++--
> >>    net/sched/cls_u32.c      |  2 +-
> >>    8 files changed, 20 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >> index a76c9171db0e..31d8e8587824 100644
> >> --- a/include/net/pkt_cls.h
> >> +++ b/include/net/pkt_cls.h
> >> @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct tcf=
_result *res,
> >>          res->drop_reason =3D reason;
> >>    }
> >>
> >> +static inline void tcf_set_result(struct tcf_result *to,
> >> +                                 const struct tcf_result *from)
> >> +{
> >> +       /* tcf_result's drop_reason which is the last member must be
> >> +        * preserved and cannot be copied from the cls'es tcf_result
> >> +        * template given this is carried all the way and potentially
> >> +        * set to a concrete tc drop reason upon error or intentional
> >> +        * drop. See tcf_set_drop_reason() locations.
> >> +        */
> >> +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
> >> +}
> >> +
> >
> > Daniel, IMO, doing this at cls_api is best instead (like what Victors
> > or my original patch did). Iam ~30K feet right now with a lousy
> > keyboard - you can either do it, or i or Victor can send the patch by
> > end of day today. There are missing cases which were covered by Victor
> > and possibly something else will pop up next.
>
> Sure, if you have sth clean and simple for today, go for it. Otherwise I
> can cook a proper one out of this as a fix and ship it tomorrow AM, so we
> have a fix for the splat in CONFIG_DEBUG_NET kernels and you can still
> refactor later.
>

I was thinking something along these lines:

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1662,6 +1662,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
        const int max_reclassify_loop =3D 16;
        const struct tcf_proto *first_tp;
        int limit =3D 0;
+       u32 reason_code =3D res->drop_reason;

 reclassify:
 #endif
@@ -1712,8 +1713,11 @@ static inline int __tcf_classify(struct sk_buff *skb=
,
                        goto reset;
                }
 #endif
-               if (err >=3D 0)
+               if (err >=3D 0) {
+                       if (err =3D=3D TC_ACT_SHOT) /* policy drop */
+                               tcf_set_drop_reason(res, orig_reason);
                        return err;
+               }
        }

        if (unlikely(n)) {

But tbh, i am struggling with the whole approach you took in the
earlier patch - i.e setting the drop reason from cls_act and then
expecting it not to be changed on policy drops; while it works for
clsact, it is not going to work for the rest of the qdiscs - unless we
change all the qdisc enqueues to take an extra param for drop_reason.
Thoughts?

cheers,
jamal

> Thanks,
> Daniel

