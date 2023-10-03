Return-Path: <bpf+bounces-11313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164627B736E
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 23:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E7C3A2815EB
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193D3D98C;
	Tue,  3 Oct 2023 21:36:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41F3D974
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 21:36:48 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F579E
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 14:36:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d84d883c1b6so268192276.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696369005; x=1696973805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0mJ3IHM8Yjc4xcZDToFg2+jf4wsXO7IZrU1MLYvRto=;
        b=T7k6MnnHlIp9Htu6DSKjOFrG9a+m3aDgVlVDm1ZxDh624YVup65gxsgtr4/zJMqhSu
         sUMcfxptAcCDdZIipwlgc7O08/VgXKu4Pw/Dh29tkHHCvs7HUmqUnZbq2bc0SNQCGVsY
         k/xD9YJgr0EShyTGSp5eLbRVizveCq16BPz7vbktWVexltEnU+Tb3wZttnklsOe4P4qA
         RcdJFlOiVi95r4WdcHzgPshEmj3VreeolxzasDIH3nR8Er3+bbJnooIQNq4aTUHswm7u
         AUhWvSQduzNHjrhp6PPUMnVBlpWt6BI/z3buJCaI2bl8mUqW+uUtsJXMuVu2DcqPONx0
         n1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369005; x=1696973805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0mJ3IHM8Yjc4xcZDToFg2+jf4wsXO7IZrU1MLYvRto=;
        b=EEO14vdEOXq9F2zf8pfj7rigjN1kKIyzzeJqDz3g69Bc1OIjI8Ox3NRq3Pc/42SYl1
         Sqerx0xqGBz46LX5vd72Ab0i/WPntDkEyLVIV5Lo3ITVLB+NC70J3Ue9NkHYbvyxWoa5
         KN78ZpGtOEBIEdTizOyFwQWiQNsIrjIrPMGHuYxqrzRio/+jYhyU9mCdbDmyzMds0kkq
         qAc6Et4AyQxyY1nUve+k5gMEkk6EHotrAwuzXwy2swOT54WcKSMtgYNT/mhsd7vs5rVV
         aB9fkWO8D85kXfnWUSgxlTbWYxeiWYLJ5ZKLuEPNF25ZArSyevJuTEF6jyy54v/qwIDh
         3aFg==
X-Gm-Message-State: AOJu0YwwVANYSWo+/d2QZvBRyx1rzOUHM5T98v/1wM3/Kecuv7Qtd5nd
	PDhjK4kkMbgy/1aU86yeZO/pYsy9KM0+QtscbXhunA==
X-Google-Smtp-Source: AGHT+IGEJCzz4naJCJ70efJt/yefLN0e2PznczrFBd7G7+5B+1/T0y/jV20IuuX/3H/2eZ3/HlDOKVK3eNJK6xx6R6o=
X-Received: by 2002:a25:b20d:0:b0:d71:c79c:86c1 with SMTP id
 i13-20020a25b20d000000b00d71c79c86c1mr2726260ybj.32.1696369005137; Tue, 03
 Oct 2023 14:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919145951.352548-1-victor@mojatatu.com> <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
 <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
 <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net> <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
 <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net> <CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
 <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net> <CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
 <96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net>
In-Reply-To: <96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Oct 2023 17:36:33 -0400
Message-ID: <CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return code
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	martin.lau@linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 9:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 10/3/23 2:46 PM, Jamal Hadi Salim wrote:
> > On Tue, Oct 3, 2023 at 5:00=E2=80=AFAM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >> On 10/2/23 9:54 PM, Jamal Hadi Salim wrote:
> >>> On Fri, Sep 29, 2023 at 11:48=E2=80=AFAM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> >>>> On 9/26/23 1:01 AM, Jamal Hadi Salim wrote:
> >>>>> On Fri, Sep 22, 2023 at 4:12=E2=80=AFAM Daniel Borkmann <daniel@iog=
earbox.net> wrote:
> >>>>>> On 9/20/23 1:20 AM, Jamal Hadi Salim wrote:
> >>>>>>> On Tue, Sep 19, 2023 at 6:15=E2=80=AFPM Daniel Borkmann <daniel@i=
ogearbox.net> wrote:
> >>>>>>>> On 9/19/23 4:59 PM, Victor Nogueira wrote:
> >>>> [...]
> >>>>>>
> >>>>>> In the above case we don't have 'internal' errors which you want t=
o trace, so I would
> >>>>>> also love to avoid the cost of zeroing struct tcf_result res which=
 should be 3x 8b for
> >>>>>> every packet.
> >>>>>
> >>>>> We can move the zeroing inside tc_run() but we declare it in the sa=
me
> >>>>> spot as we do right now. You will still need to set res.verdict as
> >>>>> above.
> >>>>> Would that work for you?
> >>>>
> >>>> What I'm not following is that with the below you can avoid the unne=
cessary
> >>>> fast path cost (which is only for corner case which is almost never =
hit) and
> >>>> get even better visibility. Are you saying it doesn't work?
> >>>
> >>> I am probably missing something:
> >>> -1/UNSPEC is a legit errno. And the main motivation here for this
> >>> patch is to disambiguate if it was -EPERM vs UNSPEC
> >>> Maybe that is what you are calling a "corner case"?
> >>
> >> Yes, but what is the use-case to ever return a -EPERM from the fast-pa=
th? This can
> >> be audited for the code in the tree and therefore avoided so that you =
never run into
> >> this problem.
> >
> > I am sorry but i am not in favor of this approach.
> > You are suggesting audits are the way to go forward when in fact lack
> > of said audits is what got us in this trouble with syzkaller to begin
> > with. We cant rely on tribal knowledge to be able to spot these
> > discrepancies. The elder of the tribe may move to a different mountain
> > at some point and TheLinuxWay(tm) is cutnpaste, so i dont see this as
> > long term good for maintainance. We have a clear distinction between
> > an error vs verdict - lets use that.
> > We really dont want to make this a special case just for eBPF and how
> > to make it a happy world for eBPF at the cost of everyone else. I made
> > a suggestion of leaving tcx alone, you can do your own thing there;
> > but for tc_run my view is we should keep it generic.
>
> Jamal, before you come to early conclusions, it would be great if you als=
o
> read until the end of the email, because what I suggested below *is* gene=
ric
> and with less churn throughout the code base.
>

I did look, Daniel. You are lumping all the error codes into one -
which doesnt change my view on disambiguation. If i was to debug
closely and run kprobe now i am seeing only one error code
TC_ACT_ABORT instead of -EINVAL vs -ENOMEM, etc. Easier for me to find
the source manually (and possibly even better with Andrii's tool i saw
once if it would work in the datapath - iirc, i think it prints return
codes on the code paths).

cheers,
jamal

> >>> There are two options in my mind right now (since you are guaranteed
> >>> in tcx_run you will never return anything below UNSPEC):
> >>> 1) we just have the switch statement invocation inside an inline
> >>> function and you can pass it sch_ret (for tcx case) and we'll pass it
> >>> res.verdit for tc_run() case.
> >>> 2) is something is we leave tcx_run alone and we have something along
> >>> the lines of:
> >>>
> >>> --------------
> >>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>> index 1450f4741d9b..93613bce647c 100644
> >>> --- a/net/core/dev.c
> >>> +++ b/net/core/dev.c
> >>> @@ -3985,7 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct
> >>> packet_type **pt_prev, int *ret,
> >>>                      struct net_device *orig_dev, bool *another)
> >>>    {
> >>>           struct bpf_mprog_entry *entry =3D
> >>> rcu_dereference_bh(skb->dev->tcx_ingress);
> >>> -       struct tcf_result res =3D {0};
> >>> +       struct tcf_result res;
> >>>           int sch_ret;
> >>>
> >>>           if (!entry)
> >>> @@ -4003,14 +4003,16 @@ sch_handle_ingress(struct sk_buff *skb, struc=
t
> >>> packet_type **pt_prev, int *ret,
> >>>                   if (sch_ret !=3D TC_ACT_UNSPEC)
> >>>                           goto ingress_verdict;
> >>>           }
> >>> +
> >>> +       res.verdict =3D 0;
> >>>           sch_ret =3D tc_run(tcx_entry(entry), skb, &res);
> >>>           if (sch_ret < 0) {
> >>>                   kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ER=
ROR);
> >>>                   *ret =3D NET_RX_DROP;
> >>>                   return NULL;
> >>>           }
> >>> +       sch_ret =3D res.verdict;
> >>>    ingress_verdict:
> >>> -       switch (res.verdict) {
> >>> +       switch (sch_ret) {
> >>>           case TC_ACT_REDIRECT:
> >>>                   /* skb_mac_header check was done by BPF, so we can
> >>> safely
> >>>                    * push the L2 header back before redirecting to an=
other
> >>> -----------
> >>>
> >>> on the drop reason - our thinking is to support drop_watch alongside
> >>> tracepoint given kfree_skb_reason exists already; if i am not mistake=
n
> >>> what you suggested would require us to create a new tracepoint?
> >>
> >> So if the only thing you really care about is the different drop reaso=
n for
> >> kfree_skb_reason, then I still don't follow why you need to drag this =
into
> >> struct tcf_result. This can be done in a much simpler and more efficie=
nt way
> >> like the following:
> >>
> >> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-co=
re.h
> >> index a587e83fc169..b1c069c8e7f2 100644
> >> --- a/include/net/dropreason-core.h
> >> +++ b/include/net/dropreason-core.h
> >> @@ -80,6 +80,8 @@
> >>          FN(IPV6_NDISC_BAD_OPTIONS)      \
> >>          FN(IPV6_NDISC_NS_OTHERHOST)     \
> >>          FN(QUEUE_PURGE)                 \
> >> +       FN(TC_EGRESS_ERROR)             \
> >> +       FN(TC_INGRESS_ERROR)            \
> >>          FNe(MAX)
> >>
> >>    /**
> >> @@ -345,6 +347,10 @@ enum skb_drop_reason {
> >>          SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
> >>          /** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
> >>          SKB_DROP_REASON_QUEUE_PURGE,
> >> +       /** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOO=
K due to error */
> >> +       SKB_DROP_REASON_TC_EGRESS_ERROR,
> >> +       /** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress H=
OOK due to error */
> >> +       SKB_DROP_REASON_TC_INGRESS_ERROR,
> >>          /**
> >>           * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, wh=
ich
> >>           * shouldn't be used as a real 'reason' - only for tracing co=
de gen
> >> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >> index f308e8268651..cd2444dd3745 100644
> >> --- a/include/net/pkt_cls.h
> >> +++ b/include/net/pkt_cls.h
> >> @@ -10,6 +10,7 @@
> >>
> >>    /* TC action not accessible from user space */
> >>    #define TC_ACT_CONSUMED               (TC_ACT_VALUE_MAX + 1)
> >> +#define TC_ACT_ABORT           (TC_ACT_VALUE_MAX + 2)
> >>
> >>    /* Basic packet classifier frontend definitions. */
> >>
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index 85df22f05c38..3abb4d71c170 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -4011,7 +4011,10 @@ sch_handle_ingress(struct sk_buff *skb, struct =
packet_type **pt_prev, int *ret,
> >>                  *ret =3D NET_RX_SUCCESS;
> >>                  return NULL;
> >>          case TC_ACT_SHOT:
> >> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
> >> +       case TC_ACT_ABORT:
> >> +               kfree_skb_reason(skb, likely(sch_ret =3D=3D TC_ACT_SHO=
T) ?
> >> +                                SKB_DROP_REASON_TC_INGRESS :
> >> +                                SKB_DROP_REASON_TC_INGRESS_ERROR);
> >>                  *ret =3D NET_RX_DROP;
> >>                  return NULL;
> >>          /* used by tc_run */
> >> @@ -4054,7 +4057,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret=
, struct net_device *dev)
> >>                  *ret =3D NET_XMIT_SUCCESS;
> >>                  return NULL;
> >>          case TC_ACT_SHOT:
> >> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
> >> +       case TC_ACT_ABORT:
> >> +               kfree_skb_reason(skb, likely(sch_ret =3D=3D TC_ACT_SHO=
T) ?
> >> +                                SKB_DROP_REASON_TC_EGRESS :
> >> +                                SKB_DROP_REASON_TC_EGRESS_ERROR);
> >>                  *ret =3D NET_XMIT_DROP;
> >>                  return NULL;
> >>          /* used by tc_run */
> >>
> >> Then you just return the internal TC_ACT_ABORT code for internal 'exce=
ptions',
> >> and you'll get the same result to make it observable for dropwatch.
> >>
> >> Thanks,
> >> Daniel
>

