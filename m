Return-Path: <bpf+bounces-11222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E87B5BA7
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 21:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B44C828246D
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D7200BC;
	Mon,  2 Oct 2023 19:55:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BD200B0
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 19:55:03 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB81AD
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 12:55:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d81afd5273eso147765276.3
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696276501; x=1696881301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c5SmVUfk8UVNXh3IvpbXD00ZBIgnAWYwZjqU+rvomA=;
        b=Qn5B6WL2cHO5czy+gvrc/6DRJKlLTE/hzSWE6nOpthBvZ2r1GKPEsG0z0M/drFXF2e
         JoYsjQkcfVBsd9NOYWa8PYGOFOB3mAkEiq4WCYDKKToagEmotH8rPTR5o5nWDq0FIMZx
         2gUUGlHuaZ73sAiDONyHW4qe7bgcxJY6lKrl1ckkFNdY6OJzZdBum9gbtPBVIH+LMd9N
         70K/OxdMl9HC1dlt21v8aNZyZk4R5aot4x0nqaa3AOQyUjx2BcGazMTVvGivZtruaTq6
         djZMK9mDRqfjZqBHhsjppjrcBo3Ni7WeYm2bdS0rAnEgtnulPusdHJS1bBxymMv3UJD0
         28UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696276501; x=1696881301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c5SmVUfk8UVNXh3IvpbXD00ZBIgnAWYwZjqU+rvomA=;
        b=h9lEgpg6wR1FMY0SV+KZNiE06+NnRui6QNAtjauFRRo+1cjqfK6BbjJEtksx+d6ZV6
         gfMqGKZfOT07smMPXfOZ+ckUF50FAXdDH/jolQSIfBKXfHZuCoqp4YP6aqEKjCIJueKr
         /2QpElCKHjyCvz3vOUiWGUwXBKfYocPT5A/rvB3SM9INoAJzPALZcXUqfrGmxWVVEMKp
         Y9XwzK+t91mVtNhc23tbmSGxWYtP0VCEgA0/wj75ZVBahKUfPdN4g+/ZVPw0JWxB3cnj
         skg2eMNfxK8H0fw2GM32muE9C+lWIYgvPwKL4YGux8VrFZhoBLd0jVuFJYDGVx6RAkeV
         yc7A==
X-Gm-Message-State: AOJu0Yy9hYAbyMkKZIlw4uuVYSbUxK3dBoUZfdWsKA6DVNVeCg9WBGCR
	i6qV8M4SC/3zgChYGF7CTpGsGkwC9pDgCmWmf5pqOA==
X-Google-Smtp-Source: AGHT+IGx+KEBoAXl/FjKczj5tSem9CeGfUbwQNvoMgjlGxEobzXIhuMiAKSAIehWIXWYmZpYEqtOEuP03VsMii5Z7ck=
X-Received: by 2002:a25:c58f:0:b0:d84:bf91:2cb1 with SMTP id
 v137-20020a25c58f000000b00d84bf912cb1mr10590733ybe.31.1696276501512; Mon, 02
 Oct 2023 12:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919145951.352548-1-victor@mojatatu.com> <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
 <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
 <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net> <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
 <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
In-Reply-To: <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 2 Oct 2023 15:54:50 -0400
Message-ID: <CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
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

Hi Daniel,
On Fri, Sep 29, 2023 at 11:48=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 9/26/23 1:01 AM, Jamal Hadi Salim wrote:
> > On Fri, Sep 22, 2023 at 4:12=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 9/20/23 1:20 AM, Jamal Hadi Salim wrote:
> >>> On Tue, Sep 19, 2023 at 6:15=E2=80=AFPM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>>> On 9/19/23 4:59 PM, Victor Nogueira wrote:
> [...]
> >>
> >> In the above case we don't have 'internal' errors which you want to tr=
ace, so I would
> >> also love to avoid the cost of zeroing struct tcf_result res which sho=
uld be 3x 8b for
> >> every packet.
> >
> > We can move the zeroing inside tc_run() but we declare it in the same
> > spot as we do right now. You will still need to set res.verdict as
> > above.
> > Would that work for you?
>
> What I'm not following is that with the below you can avoid the unnecessa=
ry
> fast path cost (which is only for corner case which is almost never hit) =
and
> get even better visibility. Are you saying it doesn't work?

I am probably missing something:
-1/UNSPEC is a legit errno. And the main motivation here for this
patch is to disambiguate if it was -EPERM vs UNSPEC
Maybe that is what you are calling a "corner case"?

There are two options in my mind right now (since you are guaranteed
in tcx_run you will never return anything below UNSPEC):
1) we just have the switch statement invocation inside an inline
function and you can pass it sch_ret (for tcx case) and we'll pass it
res.verdit for tc_run() case.
2) is something is we leave tcx_run alone and we have something along
the lines of:

--------------
diff --git a/net/core/dev.c b/net/core/dev.c
index 1450f4741d9b..93613bce647c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3985,7 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct
packet_type **pt_prev, int *ret,
                   struct net_device *orig_dev, bool *another)
 {
        struct bpf_mprog_entry *entry =3D
rcu_dereference_bh(skb->dev->tcx_ingress);
-       struct tcf_result res =3D {0};
+       struct tcf_result res;
        int sch_ret;

        if (!entry)
@@ -4003,14 +4003,16 @@ sch_handle_ingress(struct sk_buff *skb, struct
packet_type **pt_prev, int *ret,
                if (sch_ret !=3D TC_ACT_UNSPEC)
                        goto ingress_verdict;
        }
+
+       res.verdict =3D 0;
        sch_ret =3D tc_run(tcx_entry(entry), skb, &res);
        if (sch_ret < 0) {
                kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR);
                *ret =3D NET_RX_DROP;
                return NULL;
        }
+       sch_ret =3D res.verdict;
 ingress_verdict:
-       switch (res.verdict) {
+       switch (sch_ret) {
        case TC_ACT_REDIRECT:
                /* skb_mac_header check was done by BPF, so we can
safely
                 * push the L2 header back before redirecting to another
-----------

on the drop reason - our thinking is to support drop_watch alongside
tracepoint given kfree_skb_reason exists already; if i am not mistaken
what you suggested would require us to create a new tracepoint?

cheers,
jamal

> >> I was more thinking like something below could be a better choice. I p=
resume your main
> >> goal is to trace where these errors originated in the first place, so =
it might even be
> >> useful to capture the actual return code as well.
> >
> > The main motivation is a few syzkaller bugs which resulted in not
> > disambiguating between errors being returned and sometimes
> > TC_ACT_SHOT.
> >
> >> Then you can use perf script, bpf and whatnot to gather further insigh=
ts into what
> >> happened while being less invasive and avoiding the need to extend str=
uct tcf_result.
> >
> > We could use trace instead - the reason we have the skb reason is
> > being used in the other spots (does this trace require ebpf to be
> > usable?).
>
> No you can just use regular perf by attaching to the tracepoint, no need =
for using
> bpf at all here.
>
> >> This would be quite similar to trace_xdp_exception() as well, and I th=
ink you can guarantee
> >> that in fast path all errors are < TC_ACT_UNSPEC anyway.
> >
> > I am not sure i followed. 0 means success, result codes are returned in=
 res now.
>
> What I was saying is that you don't need the struct change from the patch=
, but only
> the changes where you rework TC_ACT_SHOT into one of the -E<errors>, and =
then with
> the below you can pass this through an exception tracepoint.
>
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index 85df22f05c38..4089d195144d 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -3925,6 +3925,10 @@ static int tc_run(struct tcx_entry *entry, stru=
ct sk_buff *skb)
> >>
> >>          mini_qdisc_bstats_cpu_update(miniq, skb);
> >>          ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &=
res, false);
> >> +       if (unlikely(ret < TC_ACT_UNSPEC)) {
> >> +               trace_tc_exception(skb->dev, skb->tc_at_ingress, ret);
> >> +               ret =3D TC_ACT_SHOT;
> >> +       }
> >>          /* Only tcf related quirks below. */
> >>          switch (ret) {
> >>          case TC_ACT_SHOT:
>
> Thanks,
> Daniel

