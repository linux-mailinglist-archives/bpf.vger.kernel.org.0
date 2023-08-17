Return-Path: <bpf+bounces-8000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCC77FC1F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498711C214B9
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F9C154A5;
	Thu, 17 Aug 2023 16:30:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B1168B9
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:30:40 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24EA198E
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 09:30:38 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-589e4179fc7so16947b3.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692289838; x=1692894638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5Bls4+/C5LcDmAzNzwFWOesJHk+SqwnZsLNI1k6t3U=;
        b=r9z1uQuRVKGlWrlwQEKE9lwaImr6y0OQcOvqS5EkGLQF4kmq1ciZp9fRN83sscxyU7
         nyrZSW4Uf1lEiZWnnH1uaTEcmv2XoE7Htr+594gCAKMak1jacGxeaXMpOB/6Sik6c30e
         Tt+Fl1/hMj2voOspgrUtpEW6WYKkITHHJERne+hrZWSxEBdoqoeKxOCcPam/txxIc57O
         JIRtxwhfc0KptUs39Ve5bi8ev3sgphRgWSYGVeip5BNt5GGUpU+XuD4XylZ1PCBRgCKo
         cQasfEH/XIEBVFtePtEbGMXaMrQ1fWU9BC64FfMk0MCCX1vfAlPwzIEBY8ReLxKA+6cK
         H9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289838; x=1692894638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5Bls4+/C5LcDmAzNzwFWOesJHk+SqwnZsLNI1k6t3U=;
        b=DlWYC7yV+/oOfzww2TSQ+KDQcJPH3YQlcEGD4c22dqA78qNPVG3Tvcu8dfcDrtmDpD
         YucGOARoukMhMczkedfjVpQF0RULc8MzmqOTMGT9H7OIKx2cLaFt2Nugqkg5RoFUz1wj
         WTNQaCA43ptXNiW8tJC7jEO5EtKjmSRlyJ/Z2b9RnyioP/T/5+KZpTAf8a4PaqLKXPj8
         ESeT2N35Sjjd2YxY4Oba9W0PJCVp5zeUxuUGCR9AVdyleI9zUOGr4JmxBacQlU7yJO1X
         ylvmR49KdRQRjSzps9JmSY0hKbj70S53kA/T9s//j1tw5NtI9XDmgFFGV8cigDl5c8cb
         Mc9A==
X-Gm-Message-State: AOJu0YwiUk0TIjmJ1P9cIIMCKGTesXoexW1vpB4w47r/FVaSnzBpKPlJ
	BfDL7VD/LgnqjCQQIs8faXdYg3vM8Ec+8vEbM1rU1w==
X-Google-Smtp-Source: AGHT+IEmNIDuWgheKcDoBF4mUGmWuYhzGOF89AQHYMxXCDZVJ1lkiXWCK0Yn2afziUaa4tet+Kq/0I39ZjbVw81/3A8=
X-Received: by 2002:a0d:f502:0:b0:576:896a:dbc5 with SMTP id
 e2-20020a0df502000000b00576896adbc5mr4712419ywf.48.1692289837725; Thu, 17 Aug
 2023 09:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a1fbb0602d4088a@google.com> <20230814160303.41b383b0@kernel.org>
 <20230815112821.vs7nvsgmncv6zfbw@skbuf> <20230816225759.g25x76kmgzya2gei@skbuf>
In-Reply-To: <20230816225759.g25x76kmgzya2gei@skbuf>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 17 Aug 2023 12:30:26 -0400
Message-ID: <CAM0EoMnux5JjmqYM_ErBZD4x3xkgYOEyn3R4oX6uBW-+OkE_sQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>, bpf@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, edumazet@google.com, jiri@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 6:58=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> Hi Jakub,
>
> On Tue, Aug 15, 2023 at 02:28:21PM +0300, Vladimir Oltean wrote:
> > On Mon, Aug 14, 2023 at 04:03:03PM -0700, Jakub Kicinski wrote:
> > > Hi Vladimir, any ideas for this one?
> > > The bisection looks pooped, FWIW, looks like a taprio inf loop.
> >
> > I'm looking into it.
>
> Here's what I've found out and what help I'll need going forward.
>
> Indeed there is an infinite loop in taprio_dequeue() -> taprio_dequeue_tc=
_priority(),
> leading to an RCU stall.
>
> Short description of taprio_dequeue_tc_priority(): it cycles
> q->cur_txq[tc] in the range between [ offset, offset + count ), where:
>
>         int offset =3D dev->tc_to_txq[tc].offset;
>         int count =3D dev->tc_to_txq[tc].count;
>
> with the initial q->cur_txq[tc], aka the "first_txq" variable, being set
> by the control path: taprio_change(), also called by taprio_init():
>
>         if (mqprio) {
>                 (...)
>                 for (i =3D 0; i < mqprio->num_tc; i++) {
>                         (...)
>                         q->cur_txq[i] =3D mqprio->offset[i];
>                 }
>         }
>
> In the buggy case that leads to the RCU stall, the line in taprio_change(=
)
> which sets q->cur_txq[i] never gets executed. So first_txq will be 0
> (pre-initialized memory), and if that's outside of the [ offset, offset +=
 count )
> range that taprio_dequeue_tc_priority() -> taprio_next_tc_txq() expects
> to cycle through, the kernel is toast.
>
> The nitty gritty of that is boring. What's not boring is how come the
> control path skips the q->cur_txq[i] assignment. It's because "mqprio"
> is NULL, and that's because taprio_change() (important: also tail-called
> from taprio_init()) has this logic to detect a change in the traffic
> class settings of the device, compared to the passed TCA_TAPRIO_ATTR_PRIO=
MAP
> netlink attribute:
>
>         /* no changes - no new mqprio settings */
>         if (!taprio_mqprio_cmp(q, dev, mqprio))
>                 mqprio =3D NULL;
>
> And what happens is that:
> - we go through taprio_init()
> - a TCA_TAPRIO_ATTR_PRIOMAP gets passed to us
> - taprio_mqprio_cmp() sees that there's no change compared to the
>   netdev's existing traffic class config
> - taprio_change() sets "mqprio" to NULL, ignoring the given
>   TCA_TAPRIO_ATTR_PRIOMAP
> - we skip modifying q->cur_txq[i], as if it was a taprio_change() call
>   that came straight from Qdisc_ops :: change(), rather than what it
>   really is: one from Qdisc_ops :: init()
>
> So the next question: why does taprio_mqprio_cmp() see that there's no
> change? Because there is no change. When Qdisc_ops :: init() is called,
> the netdev really has a non-zero dev->num_tc, prio_tc_map, tc_to_txq and
> all that.
>
> But why? A previous taprio, if that existed, will call taprio_destroy()
> -> netdev_reset_tc(), so it won't leave state behind that will hinder
> the current taprio. Checking for stuff in the netdev state is just so
> that taprio_change() can distinguish between a direct Qdisc_ops :: change=
()
> call vs one coming from init().
>
> Finally, here's where the syzbot repro becomes relevant. It crafts the
> RTM_NEWQDISC netlink message in such a way, that it makes tc_modify_qdisc=
()
> in sch_api.c call a Qdisc_ops sequence with which taprio wasn't written
> in mind.
>
> With "tc qdisc replace && tc qdisc replace", tc_modify_qdisc() is
> supposed to call init() the first time and replace() the second time.
> What the repro does is make the above sequence call two init() methods
> back to back.
>
> To create an iproute2-based reproducer rather than the C one provided by
> syzbot, we need this iproute2 change:
>
> diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
> index 56086c43b7fa..20d9622b6bf3 100644
> --- a/tc/tc_qdisc.c
> +++ b/tc/tc_qdisc.c
> @@ -448,6 +448,8 @@ int do_qdisc(int argc, char **argv)
>                 return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_EXCL|NLM_F_CRE=
ATE, argc-1, argv+1);
>         if (matches(*argv, "change") =3D=3D 0)
>                 return tc_qdisc_modify(RTM_NEWQDISC, 0, argc-1, argv+1);
> +       if (strcmp(*argv, "replace-exclusive") =3D=3D 0)
> +               return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_CREATE|NLM_F_R=
EPLACE|NLM_F_EXCL, argc-1, argv+1);
>         if (matches(*argv, "replace") =3D=3D 0)
>                 return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_CREATE|NLM_F_R=
EPLACE, argc-1, argv+1);
>         if (matches(*argv, "link") =3D=3D 0)
>
> which basically implements a crafted alternative of "tc qdisc replace"
> which also sets the NLM_F_EXCL flag in n->nlmsg_flags.
>
> Then, the minimal repro script can simply be expressed as:
>
> #!/bin/bash
>
> ip link add veth0 numtxqueues 16 numrxqueues 16 type veth peer name veth1
> ip link set veth0 up && ip link set veth1 up
>
> for ((i =3D 0; i < 2; i++)); do
>         tc qdisc replace-exclusive dev veth0 root stab overhead 24 taprio=
 \
>                 num_tc 2 map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
>                 queues 8@0 4@8 \
>                 clockid REALTIME \
>                 base-time 0 \
>                 cycle-time 61679 \
>                 sched-entry S 0 54336 \
>                 sched-entry S 0x8a27 7343 \
>                 max-sdu 18343 18343 \
>                 flags 0
> done
>
> ip link del veth0
>
> Here's how things go sideways if sch_api.c goes through the Qdisc_ops :: =
init()
> code path instead of change() for the second Qdisc.
>
> The first taprio_attach() (i=3D0) will attach the root taprio Qdisc (aka =
itself)
> to all netdev TX queues, and qdisc_put() the existing pfifo default Qdisc=
s.
>
> When the taprio_init() method executes for i=3D1, taprio_destroy() hasn't
> been called yet. So neither has netdev_reset_tc() been called, and
> that's part of the problem (the one that causes the infinite loop in
> dequeue()).
>
> But, taprio_destroy() will finally get called for the initial taprio
> created at i=3D0. The call trace looks like this:
>
>  rtnetlink_rcv_msg()
>  -> tc_modify_qdisc()
>     -> qdisc_graft()
>        -> taprio_attach() for i=3D1
>           -> qdisc_put() for the old Qdiscs attached to the TX queues, ak=
a the taprio from i=3D0
>              -> __qdisc_destroy()
>                 -> taprio_destroy()
>
> What's more interesting is that the late taprio_destroy() for i=3D0
> effectively destroys the netdev state - the netdev_reset_tc() call -
> done by taprio_init() -> taprio_change() for i=3D1, and that can't be
> too good, either. Even if there's no immediately observable hang, the
> traffic classes are reset even though the Qdisc thinks they aren't.
>
> Taprio isn't the only one affected by this. Mqprio also has the pattern
> of calling netdev_set_num_tc() from Qdisc_ops :: init() and destroy().
> But with the possibility of destroy(i=3D0) not being serialized with
> init(i=3D1), that's buggy.
>
> Sorry for the long message. This is where I'm at. For me, this is the
> bottom of where things are intuitive. I don't understand what is
> considered to be expected behavior from tc_modify_qdisc(), and what is
> considered to be sane Qdisc-facing API, and I need help.
>
> I've completely stopped debugging when I saw that the code enters
> through this path at i=3D1, so I really can't tell you more:
>
>                                 /* This magic test requires explanation.
>                                  *
>                                  *   We know, that some child q is alread=
y
>                                  *   attached to this parent and have cho=
ice:
>                                  *   either to change it or to create/gra=
ft new one.
>                                  *
>                                  *   1. We are allowed to create/graft on=
ly
>                                  *   if CREATE and REPLACE flags are set.
>                                  *
>                                  *   2. If EXCL is set, requestor wanted =
to say,
>                                  *   that qdisc tcm_handle is not expecte=
d
>                                  *   to exist, so that we choose create/g=
raft too.
>                                  *
>                                  *   3. The last case is when no flags ar=
e set.
>                                  *   Alas, it is sort of hole in API, we
>                                  *   cannot decide what to do unambiguous=
ly.
>                                  *   For now we select create/graft, if
>                                  *   user gave KIND, which does not match=
 existing.
>                                  */
>                                 if ((n->nlmsg_flags & NLM_F_CREATE) &&
>                                     (n->nlmsg_flags & NLM_F_REPLACE) &&
>                                     ((n->nlmsg_flags & NLM_F_EXCL) ||
>                                      (tca[TCA_KIND] &&
>                                       nla_strcmp(tca[TCA_KIND], q->ops->i=
d)))) {
>                                         netdev_err(dev, "magic test\n");
>                                         goto create_n_graft;
>                                 }
>
> I've added more Qdisc people to the discussion. The problem description
> is pretty much self-contained in this email, and going to the original
> syzbot report won't bring much else.
>

I will take a look tommorow.

cheers,
jamal

> There are multiple workarounds that can be done in taprio (and mqprio)
> depending on what is considered as being sane API. Though I don't want
> to get ahead of myself. Maybe there is a way to fast-forward the
> qdisc_destroy() of the previous taprio so it doesn't overlap with the
> new one's qdisc_create().

