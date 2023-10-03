Return-Path: <bpf+bounces-11274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D27B6952
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 24998B209E9
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CD323758;
	Tue,  3 Oct 2023 12:47:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDB125D5
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 12:46:59 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD424B0
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 05:46:57 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d8164e661abso908138276.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696337217; x=1696942017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eY1hbA70WFNs6+o8zolvBU8UQiRaI/f1anzJ9//I6Q=;
        b=C5lWeUlrAKHlU+95H/BRSCAECvPNzzYqKoqSHTrn5C5h6oao48//5RTVElhJvzxNdH
         VbioJJbi0tob1cgpHfMUqW+ByNwX26q0Dqs1vDspCLJAby8zGNEeJIXOv4uJkT1xTXQr
         yBgDnteAxq1Np+hqdnK2R8U1GwUkYwVD6L09KWI1px81b+ShHOS+SDB/6PkbpziKHEes
         JNzR/GkLRqLs89sBZbCwe2K7u+0O4fGkOiNXOQlusxF23eHfjY/ed0Co7wFld5fEOyTd
         RH7CaWmKt1egNlDBu4iem3SNyWak2kkBJVkg+vJe6HLvHIGUI5glxJVDKGQHDwpofILF
         zTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337217; x=1696942017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eY1hbA70WFNs6+o8zolvBU8UQiRaI/f1anzJ9//I6Q=;
        b=tFN+3tvF6SgYdrCTgwYLzIXgD9fhAz3r+SHylfbLS/aeftXm9pJeFtpSnUht20oxHe
         DCtIXjSAGUFNii/XWf/62lHSwsDSc+EYGSgmxniyDDX0UhF/6n6Drq++xK3dBuvSb5UD
         Eg8HHK6xiCVmGNo5CwDH1jmwCQxvkE9FpAqBg4O0OKEQXrVoPHbgi1MeEWtQj6JOv4Gh
         GZuLib/f2Q0IpVidfVQgreIvkSxEtjdCPar26KZCqZTDfABmJ4xhpTv3PqPuNWFnKBdy
         I73vUqA6r7opCK5knXBObwtlfRlmQfCt6GICeJ14UzV9CDd0RKpRPe4zgL/fxKKB4XyS
         X4pg==
X-Gm-Message-State: AOJu0Yy6TR5YlclaU/Pt+gAxC2m5pcD6lOomOQb/GeumrgU2Hm7N0/aD
	7VjVh+DJYsxLz1NvAu6eKtFMrv/rBmre8KAFySI3NA==
X-Google-Smtp-Source: AGHT+IEZTmgDJtaVBhzBgpAuedmZqgvE7lZWHuajb5WvOK52B03Ro2zUkuyILosG5Z6CfMWPDcpl6Vpg9r5w6uJ0y1k=
X-Received: by 2002:a25:e806:0:b0:d4d:b6de:69bd with SMTP id
 k6-20020a25e806000000b00d4db6de69bdmr12512235ybd.23.1696337216854; Tue, 03
 Oct 2023 05:46:56 -0700 (PDT)
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
 <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
In-Reply-To: <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Oct 2023 08:46:45 -0400
Message-ID: <CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return code
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	martin.lau@linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 5:00=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 10/2/23 9:54 PM, Jamal Hadi Salim wrote:
> > On Fri, Sep 29, 2023 at 11:48=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >> On 9/26/23 1:01 AM, Jamal Hadi Salim wrote:
> >>> On Fri, Sep 22, 2023 at 4:12=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>>> On 9/20/23 1:20 AM, Jamal Hadi Salim wrote:
> >>>>> On Tue, Sep 19, 2023 at 6:15=E2=80=AFPM Daniel Borkmann <daniel@iog=
earbox.net> wrote:
> >>>>>> On 9/19/23 4:59 PM, Victor Nogueira wrote:
> >> [...]
> >>>>
> >>>> In the above case we don't have 'internal' errors which you want to =
trace, so I would
> >>>> also love to avoid the cost of zeroing struct tcf_result res which s=
hould be 3x 8b for
> >>>> every packet.
> >>>
> >>> We can move the zeroing inside tc_run() but we declare it in the same
> >>> spot as we do right now. You will still need to set res.verdict as
> >>> above.
> >>> Would that work for you?
> >>
> >> What I'm not following is that with the below you can avoid the unnece=
ssary
> >> fast path cost (which is only for corner case which is almost never hi=
t) and
> >> get even better visibility. Are you saying it doesn't work?
> >
> > I am probably missing something:
> > -1/UNSPEC is a legit errno. And the main motivation here for this
> > patch is to disambiguate if it was -EPERM vs UNSPEC
> > Maybe that is what you are calling a "corner case"?
>
> Yes, but what is the use-case to ever return a -EPERM from the fast-path?=
 This can
> be audited for the code in the tree and therefore avoided so that you nev=
er run into
> this problem.

I am sorry but i am not in favor of this approach.
You are suggesting audits are the way to go forward when in fact lack
of said audits is what got us in this trouble with syzkaller to begin
with. We cant rely on tribal knowledge to be able to spot these
discrepancies. The elder of the tribe may move to a different mountain
at some point and TheLinuxWay(tm) is cutnpaste, so i dont see this as
long term good for maintainance. We have a clear distinction between
an error vs verdict - lets use that.
We really dont want to make this a special case just for eBPF and how
to make it a happy world for eBPF at the cost of everyone else. I made
a suggestion of leaving tcx alone, you can do your own thing there;
but for tc_run my view is we should keep it generic.

cheers,
jamal

> > There are two options in my mind right now (since you are guaranteed
> > in tcx_run you will never return anything below UNSPEC):
> > 1) we just have the switch statement invocation inside an inline
> > function and you can pass it sch_ret (for tcx case) and we'll pass it
> > res.verdit for tc_run() case.
> > 2) is something is we leave tcx_run alone and we have something along
> > the lines of:
> >
> > --------------
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1450f4741d9b..93613bce647c 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3985,7 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct
> > packet_type **pt_prev, int *ret,
> >                     struct net_device *orig_dev, bool *another)
> >   {
> >          struct bpf_mprog_entry *entry =3D
> > rcu_dereference_bh(skb->dev->tcx_ingress);
> > -       struct tcf_result res =3D {0};
> > +       struct tcf_result res;
> >          int sch_ret;
> >
> >          if (!entry)
> > @@ -4003,14 +4003,16 @@ sch_handle_ingress(struct sk_buff *skb, struct
> > packet_type **pt_prev, int *ret,
> >                  if (sch_ret !=3D TC_ACT_UNSPEC)
> >                          goto ingress_verdict;
> >          }
> > +
> > +       res.verdict =3D 0;
> >          sch_ret =3D tc_run(tcx_entry(entry), skb, &res);
> >          if (sch_ret < 0) {
> >                  kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR=
);
> >                  *ret =3D NET_RX_DROP;
> >                  return NULL;
> >          }
> > +       sch_ret =3D res.verdict;
> >   ingress_verdict:
> > -       switch (res.verdict) {
> > +       switch (sch_ret) {
> >          case TC_ACT_REDIRECT:
> >                  /* skb_mac_header check was done by BPF, so we can
> > safely
> >                   * push the L2 header back before redirecting to anoth=
er
> > -----------
> >
> > on the drop reason - our thinking is to support drop_watch alongside
> > tracepoint given kfree_skb_reason exists already; if i am not mistaken
> > what you suggested would require us to create a new tracepoint?
>
> So if the only thing you really care about is the different drop reason f=
or
> kfree_skb_reason, then I still don't follow why you need to drag this int=
o
> struct tcf_result. This can be done in a much simpler and more efficient =
way
> like the following:
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index a587e83fc169..b1c069c8e7f2 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -80,6 +80,8 @@
>         FN(IPV6_NDISC_BAD_OPTIONS)      \
>         FN(IPV6_NDISC_NS_OTHERHOST)     \
>         FN(QUEUE_PURGE)                 \
> +       FN(TC_EGRESS_ERROR)             \
> +       FN(TC_INGRESS_ERROR)            \
>         FNe(MAX)
>
>   /**
> @@ -345,6 +347,10 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
>         /** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
>         SKB_DROP_REASON_QUEUE_PURGE,
> +       /** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOOK d=
ue to error */
> +       SKB_DROP_REASON_TC_EGRESS_ERROR,
> +       /** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress HOOK=
 due to error */
> +       SKB_DROP_REASON_TC_INGRESS_ERROR,
>         /**
>          * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>          * shouldn't be used as a real 'reason' - only for tracing code g=
en
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index f308e8268651..cd2444dd3745 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -10,6 +10,7 @@
>
>   /* TC action not accessible from user space */
>   #define TC_ACT_CONSUMED               (TC_ACT_VALUE_MAX + 1)
> +#define TC_ACT_ABORT           (TC_ACT_VALUE_MAX + 2)
>
>   /* Basic packet classifier frontend definitions. */
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 85df22f05c38..3abb4d71c170 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4011,7 +4011,10 @@ sch_handle_ingress(struct sk_buff *skb, struct pac=
ket_type **pt_prev, int *ret,
>                 *ret =3D NET_RX_SUCCESS;
>                 return NULL;
>         case TC_ACT_SHOT:
> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
> +       case TC_ACT_ABORT:
> +               kfree_skb_reason(skb, likely(sch_ret =3D=3D TC_ACT_SHOT) =
?
> +                                SKB_DROP_REASON_TC_INGRESS :
> +                                SKB_DROP_REASON_TC_INGRESS_ERROR);
>                 *ret =3D NET_RX_DROP;
>                 return NULL;
>         /* used by tc_run */
> @@ -4054,7 +4057,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, s=
truct net_device *dev)
>                 *ret =3D NET_XMIT_SUCCESS;
>                 return NULL;
>         case TC_ACT_SHOT:
> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
> +       case TC_ACT_ABORT:
> +               kfree_skb_reason(skb, likely(sch_ret =3D=3D TC_ACT_SHOT) =
?
> +                                SKB_DROP_REASON_TC_EGRESS :
> +                                SKB_DROP_REASON_TC_EGRESS_ERROR);
>                 *ret =3D NET_XMIT_DROP;
>                 return NULL;
>         /* used by tc_run */
>
> Then you just return the internal TC_ACT_ABORT code for internal 'excepti=
ons',
> and you'll get the same result to make it observable for dropwatch.
>
> Thanks,
> Daniel

