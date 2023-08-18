Return-Path: <bpf+bounces-8079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E3780F2A
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D31C2163C
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090EF1989B;
	Fri, 18 Aug 2023 15:27:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAF182BC
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:27:41 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD883C3D
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:27:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58f5f8f998bso9375677b3.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692372458; x=1692977258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oa7EvfC/NTM9UwAxBr3OFoWPBe6BPhRF3+szZCqePuA=;
        b=EukuX9e0/8UbtDbpgzgto9H0BhEbU2JF7qizFDx/8n7PEDLDo9ls3FcxuIjy6bMrWH
         Rp1YuhYLgcz6BJtlyLCk8VnB7A5svzsPTQTm4WfAC81moceV2/cr3NF3QO3gF6Te0vFe
         TgNt5snQb4Y7ByYswIbDVZjCWFuHlgdro608encigNEz1Cz/u6SarVoFwbURlQFay55p
         FzvzNbWhErWNSbb+PtTf/qzOogkTqXZZmOTQM6T8u7sRO2wzA9lUGgiVpFRh3C8CpoW/
         ba5i/mdcWdBQ+xJhrUQb43XxTmLRJwiN/zdctI3AjU4ug4sjjRA8PXGw3mawp0Ddmzoy
         TlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372458; x=1692977258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oa7EvfC/NTM9UwAxBr3OFoWPBe6BPhRF3+szZCqePuA=;
        b=Wr6hJMu3G/xHbNECrJjLvHGa5420ESJzxnpKBtlNUSQVfxoguQ/+axktyJpfd/1HCh
         4+aP6fQ8hWkTPDJee/jcBXUYmAlr8er8sOo7eFYHj4G1xi3Nz/KxClgeQMgeACED7Vdi
         7PhuObqHJDWBczbmeifihmUmdquc3k2i7PPYYMCDG7T5MUf2Rh9fbVLTYa9ko+lHS74C
         OJ9HDXIlZ+zSNsuBUIb2EMwoi1dUGpIhfL2fAP+/vRNtjUquVV6+ryhiej7QQ26iizg7
         Kmj6/avMVu/jitJ67kwgsoMno+qx9Xxf54wuh57qW2ouybXBxVHX+E9yElEXO8H3/Bls
         XGlw==
X-Gm-Message-State: AOJu0YxrtJTjE/P36EwU4LvEsyAHUyueLiGdxPXPbivWcUX3x2zWwXiu
	qQFQ5XqSBnYZIBNE2jZpCabAhSFFVSnqqPfVRWeW2A==
X-Google-Smtp-Source: AGHT+IHL82rldeicb0kGc+0ilDbo9yQsc65LsxNU0+RA7yu1YNzf3Da2QaiklVVE2kA+uRm8jcJCMgo7BYr7XJp4Pts=
X-Received: by 2002:a0d:d611:0:b0:586:9cbb:eef4 with SMTP id
 y17-20020a0dd611000000b005869cbbeef4mr3226329ywd.2.1692372458633; Fri, 18 Aug
 2023 08:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a1fbb0602d4088a@google.com> <20230814160303.41b383b0@kernel.org>
 <20230815112821.vs7nvsgmncv6zfbw@skbuf> <20230816225759.g25x76kmgzya2gei@skbuf>
 <CAM0EoMnux5JjmqYM_ErBZD4x3xkgYOEyn3R4oX6uBW-+OkE_sQ@mail.gmail.com>
In-Reply-To: <CAM0EoMnux5JjmqYM_ErBZD4x3xkgYOEyn3R4oX6uBW-+OkE_sQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 18 Aug 2023 11:27:27 -0400
Message-ID: <CAM0EoMk5USiuZ84JeJQYCDQQ5dV-jiuGRVVocqH2izi7xcZnkg@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>, bpf@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, edumazet@google.com, jiri@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: multipart/mixed; boundary="00000000000039c23e0603342ba8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000039c23e0603342ba8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 12:30=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Aug 16, 2023 at 6:58=E2=80=AFPM Vladimir Oltean <vladimir.oltean@=
nxp.com> wrote:
> >
> > Hi Jakub,
> >
> > On Tue, Aug 15, 2023 at 02:28:21PM +0300, Vladimir Oltean wrote:
> > > On Mon, Aug 14, 2023 at 04:03:03PM -0700, Jakub Kicinski wrote:
> > > > Hi Vladimir, any ideas for this one?
> > > > The bisection looks pooped, FWIW, looks like a taprio inf loop.
> > >
> > > I'm looking into it.
> >
> > Here's what I've found out and what help I'll need going forward.
> >
> > Indeed there is an infinite loop in taprio_dequeue() -> taprio_dequeue_=
tc_priority(),
> > leading to an RCU stall.
> >
> > Short description of taprio_dequeue_tc_priority(): it cycles
> > q->cur_txq[tc] in the range between [ offset, offset + count ), where:
> >
> >         int offset =3D dev->tc_to_txq[tc].offset;
> >         int count =3D dev->tc_to_txq[tc].count;
> >
> > with the initial q->cur_txq[tc], aka the "first_txq" variable, being se=
t
> > by the control path: taprio_change(), also called by taprio_init():
> >
> >         if (mqprio) {
> >                 (...)
> >                 for (i =3D 0; i < mqprio->num_tc; i++) {
> >                         (...)
> >                         q->cur_txq[i] =3D mqprio->offset[i];
> >                 }
> >         }
> >
> > In the buggy case that leads to the RCU stall, the line in taprio_chang=
e()
> > which sets q->cur_txq[i] never gets executed. So first_txq will be 0
> > (pre-initialized memory), and if that's outside of the [ offset, offset=
 + count )
> > range that taprio_dequeue_tc_priority() -> taprio_next_tc_txq() expects
> > to cycle through, the kernel is toast.
> >
> > The nitty gritty of that is boring. What's not boring is how come the
> > control path skips the q->cur_txq[i] assignment. It's because "mqprio"
> > is NULL, and that's because taprio_change() (important: also tail-calle=
d
> > from taprio_init()) has this logic to detect a change in the traffic
> > class settings of the device, compared to the passed TCA_TAPRIO_ATTR_PR=
IOMAP
> > netlink attribute:
> >
> >         /* no changes - no new mqprio settings */
> >         if (!taprio_mqprio_cmp(q, dev, mqprio))
> >                 mqprio =3D NULL;
> >
> > And what happens is that:
> > - we go through taprio_init()
> > - a TCA_TAPRIO_ATTR_PRIOMAP gets passed to us
> > - taprio_mqprio_cmp() sees that there's no change compared to the
> >   netdev's existing traffic class config
> > - taprio_change() sets "mqprio" to NULL, ignoring the given
> >   TCA_TAPRIO_ATTR_PRIOMAP
> > - we skip modifying q->cur_txq[i], as if it was a taprio_change() call
> >   that came straight from Qdisc_ops :: change(), rather than what it
> >   really is: one from Qdisc_ops :: init()
> >
> > So the next question: why does taprio_mqprio_cmp() see that there's no
> > change? Because there is no change. When Qdisc_ops :: init() is called,
> > the netdev really has a non-zero dev->num_tc, prio_tc_map, tc_to_txq an=
d
> > all that.
> >
> > But why? A previous taprio, if that existed, will call taprio_destroy()
> > -> netdev_reset_tc(), so it won't leave state behind that will hinder
> > the current taprio. Checking for stuff in the netdev state is just so
> > that taprio_change() can distinguish between a direct Qdisc_ops :: chan=
ge()
> > call vs one coming from init().
> >
> > Finally, here's where the syzbot repro becomes relevant. It crafts the
> > RTM_NEWQDISC netlink message in such a way, that it makes tc_modify_qdi=
sc()
> > in sch_api.c call a Qdisc_ops sequence with which taprio wasn't written
> > in mind.
> >
> > With "tc qdisc replace && tc qdisc replace", tc_modify_qdisc() is
> > supposed to call init() the first time and replace() the second time.
> > What the repro does is make the above sequence call two init() methods
> > back to back.
> >
> > To create an iproute2-based reproducer rather than the C one provided b=
y
> > syzbot, we need this iproute2 change:
> >
> > diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
> > index 56086c43b7fa..20d9622b6bf3 100644
> > --- a/tc/tc_qdisc.c
> > +++ b/tc/tc_qdisc.c
> > @@ -448,6 +448,8 @@ int do_qdisc(int argc, char **argv)
> >                 return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_EXCL|NLM_F_C=
REATE, argc-1, argv+1);
> >         if (matches(*argv, "change") =3D=3D 0)
> >                 return tc_qdisc_modify(RTM_NEWQDISC, 0, argc-1, argv+1)=
;
> > +       if (strcmp(*argv, "replace-exclusive") =3D=3D 0)
> > +               return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_CREATE|NLM_F=
_REPLACE|NLM_F_EXCL, argc-1, argv+1);
> >         if (matches(*argv, "replace") =3D=3D 0)
> >                 return tc_qdisc_modify(RTM_NEWQDISC, NLM_F_CREATE|NLM_F=
_REPLACE, argc-1, argv+1);
> >         if (matches(*argv, "link") =3D=3D 0)
> >
> > which basically implements a crafted alternative of "tc qdisc replace"
> > which also sets the NLM_F_EXCL flag in n->nlmsg_flags.
> >
> > Then, the minimal repro script can simply be expressed as:
> >
> > #!/bin/bash
> >
> > ip link add veth0 numtxqueues 16 numrxqueues 16 type veth peer name vet=
h1
> > ip link set veth0 up && ip link set veth1 up
> >
> > for ((i =3D 0; i < 2; i++)); do
> >         tc qdisc replace-exclusive dev veth0 root stab overhead 24 tapr=
io \
> >                 num_tc 2 map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> >                 queues 8@0 4@8 \
> >                 clockid REALTIME \
> >                 base-time 0 \
> >                 cycle-time 61679 \
> >                 sched-entry S 0 54336 \
> >                 sched-entry S 0x8a27 7343 \
> >                 max-sdu 18343 18343 \
> >                 flags 0
> > done
> >
> > ip link del veth0
> >
> > Here's how things go sideways if sch_api.c goes through the Qdisc_ops :=
: init()
> > code path instead of change() for the second Qdisc.
> >
> > The first taprio_attach() (i=3D0) will attach the root taprio Qdisc (ak=
a itself)
> > to all netdev TX queues, and qdisc_put() the existing pfifo default Qdi=
scs.
> >
> > When the taprio_init() method executes for i=3D1, taprio_destroy() hasn=
't
> > been called yet. So neither has netdev_reset_tc() been called, and
> > that's part of the problem (the one that causes the infinite loop in
> > dequeue()).
> >
> > But, taprio_destroy() will finally get called for the initial taprio
> > created at i=3D0. The call trace looks like this:
> >
> >  rtnetlink_rcv_msg()
> >  -> tc_modify_qdisc()
> >     -> qdisc_graft()
> >        -> taprio_attach() for i=3D1
> >           -> qdisc_put() for the old Qdiscs attached to the TX queues, =
aka the taprio from i=3D0
> >              -> __qdisc_destroy()
> >                 -> taprio_destroy()
> >
> > What's more interesting is that the late taprio_destroy() for i=3D0
> > effectively destroys the netdev state - the netdev_reset_tc() call -
> > done by taprio_init() -> taprio_change() for i=3D1, and that can't be
> > too good, either. Even if there's no immediately observable hang, the
> > traffic classes are reset even though the Qdisc thinks they aren't.
> >
> > Taprio isn't the only one affected by this. Mqprio also has the pattern
> > of calling netdev_set_num_tc() from Qdisc_ops :: init() and destroy().
> > But with the possibility of destroy(i=3D0) not being serialized with
> > init(i=3D1), that's buggy.
> >
> > Sorry for the long message. This is where I'm at. For me, this is the
> > bottom of where things are intuitive. I don't understand what is
> > considered to be expected behavior from tc_modify_qdisc(), and what is
> > considered to be sane Qdisc-facing API, and I need help.
> >
> > I've completely stopped debugging when I saw that the code enters
> > through this path at i=3D1, so I really can't tell you more:
> >
> >                                 /* This magic test requires explanation=
.
> >                                  *
> >                                  *   We know, that some child q is alre=
ady
> >                                  *   attached to this parent and have c=
hoice:
> >                                  *   either to change it or to create/g=
raft new one.
> >                                  *
> >                                  *   1. We are allowed to create/graft =
only
> >                                  *   if CREATE and REPLACE flags are se=
t.
> >                                  *
> >                                  *   2. If EXCL is set, requestor wante=
d to say,
> >                                  *   that qdisc tcm_handle is not expec=
ted
> >                                  *   to exist, so that we choose create=
/graft too.
> >                                  *
> >                                  *   3. The last case is when no flags =
are set.
> >                                  *   Alas, it is sort of hole in API, w=
e
> >                                  *   cannot decide what to do unambiguo=
usly.
> >                                  *   For now we select create/graft, if
> >                                  *   user gave KIND, which does not mat=
ch existing.
> >                                  */
> >                                 if ((n->nlmsg_flags & NLM_F_CREATE) &&
> >                                     (n->nlmsg_flags & NLM_F_REPLACE) &&
> >                                     ((n->nlmsg_flags & NLM_F_EXCL) ||
> >                                      (tca[TCA_KIND] &&
> >                                       nla_strcmp(tca[TCA_KIND], q->ops-=
>id)))) {
> >                                         netdev_err(dev, "magic test\n")=
;
> >                                         goto create_n_graft;
> >                                 }
> >
> > I've added more Qdisc people to the discussion. The problem description
> > is pretty much self-contained in this email, and going to the original
> > syzbot report won't bring much else.
> >
>
> I will take a look tommorow.
>

Can you try the attached patchlet?

cheers,
jamal

> cheers,
> jamal
>
> > There are multiple workarounds that can be done in taprio (and mqprio)
> > depending on what is considered as being sane API. Though I don't want
> > to get ahead of myself. Maybe there is a way to fast-forward the
> > qdisc_destroy() of the previous taprio so it doesn't overlap with the
> > new one's qdisc_create().

--00000000000039c23e0603342ba8
Content-Type: application/octet-stream; name=patchlet-qdisc
Content-Disposition: attachment; filename=patchlet-qdisc
Content-Transfer-Encoding: base64
Content-ID: <f_llgqul5p0>
X-Attachment-Id: f_llgqul5p0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfYXBpLmMgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCmlu
ZGV4IGFhNmIxZmU2NTE1MS4uODQwOWI2MWQzMzEzIDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvc2No
X2FwaS5jCisrKyBiL25ldC9zY2hlZC9zY2hfYXBpLmMKQEAgLTE1NTEsNiArMTU1MSwyNSBAQCBz
dGF0aWMgaW50IHRjX2dldF9xZGlzYyhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2do
ZHIgKm4sCiAgKiBDcmVhdGUvY2hhbmdlIHFkaXNjLgogICovCiAKK3N0YXRpYyBpbmxpbmUgYm9v
bCBjbWRfY3JlYXRlX29yX3JlcGxhY2Uoc3RydWN0IG5sbXNnaGRyICpuKQoreworCXJldHVybiAo
bi0+bmxtc2dfZmxhZ3MgJiBOTE1fRl9DUkVBVEUgJiYKKwkJbi0+bmxtc2dfZmxhZ3MgJiBOTE1f
Rl9SRVBMQUNFKTsKK30KKworc3RhdGljIGlubGluZSBib29sIGNtZF9jcmVhdGVfZXhjbHVzaXZl
KHN0cnVjdCBubG1zZ2hkciAqbikKK3sKKwlyZXR1cm4gKG4tPm5sbXNnX2ZsYWdzICYgTkxNX0Zf
Q1JFQVRFICYmCisJCW4tPm5sbXNnX2ZsYWdzICYgTkxNX0ZfRVhDTCk7Cit9CisKK3N0YXRpYyBp
bmxpbmUgYm9vbCBjbWRfY2hhbmdlKHN0cnVjdCBubG1zZ2hkciAqbikKK3sKKwlyZXR1cm4gKCEo
bi0+bmxtc2dfZmxhZ3MgJiBOTE1fRl9DUkVBVEUpICYmCisJCSEobi0+bmxtc2dfZmxhZ3MgJiBO
TE1fRl9SRVBMQUNFKSAmJgorCQkhKG4tPm5sbXNnX2ZsYWdzICYgTkxNX0ZfRVhDTCkpOworfQor
CiBzdGF0aWMgaW50IHRjX21vZGlmeV9xZGlzYyhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qg
bmxtc2doZHIgKm4sCiAJCQkgICBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spCiB7CkBA
IC0xNjU5LDEyICsxNjc4LDE3IEBAIHN0YXRpYyBpbnQgdGNfbW9kaWZ5X3FkaXNjKHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBubG1zZ2hkciAqbiwKIAkJCQkgKiAgIEZvciBub3cgd2Ugc2Vs
ZWN0IGNyZWF0ZS9ncmFmdCwgaWYKIAkJCQkgKiAgIHVzZXIgZ2F2ZSBLSU5ELCB3aGljaCBkb2Vz
IG5vdCBtYXRjaCBleGlzdGluZy4KIAkJCQkgKi8KLQkJCQlpZiAoKG4tPm5sbXNnX2ZsYWdzICYg
TkxNX0ZfQ1JFQVRFKSAmJgotCQkJCSAgICAobi0+bmxtc2dfZmxhZ3MgJiBOTE1fRl9SRVBMQUNF
KSAmJgotCQkJCSAgICAoKG4tPm5sbXNnX2ZsYWdzICYgTkxNX0ZfRVhDTCkgfHwKLQkJCQkgICAg
ICh0Y2FbVENBX0tJTkRdICYmCi0JCQkJICAgICAgbmxhX3N0cmNtcCh0Y2FbVENBX0tJTkRdLCBx
LT5vcHMtPmlkKSkpKQotCQkJCQlnb3RvIGNyZWF0ZV9uX2dyYWZ0OworICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAodGNhW1RDQV9LSU5EXSAmJgorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbmxhX3N0cmNtcCh0Y2FbVENBX0tJTkRdLCBxLT5vcHMtPmlkKSkg
eworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChjbWRfY3JlYXRl
X29yX3JlcGxhY2UobikgfHwKKwkJCQkJICAgIGNtZF9jcmVhdGVfZXhjbHVzaXZlKG4pKSB7Cisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGNyZWF0
ZV9uX2dyYWZ0OworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxz
ZSB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
Y21kX2NoYW5nZShuKSkKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBjcmVhdGVfbl9ncmFmdDI7CisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9
CisKIAkJCX0KIAkJfQogCX0gZWxzZSB7CkBAIC0xNjk4LDYgKzE3MjIsNyBAQCBzdGF0aWMgaW50
IHRjX21vZGlmeV9xZGlzYyhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4s
CiAJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywgIlFkaXNjIG5vdCBmb3VuZC4gVG8gY3JlYXRlIHNw
ZWNpZnkgTkxNX0ZfQ1JFQVRFIGZsYWciKTsKIAkJcmV0dXJuIC1FTk9FTlQ7CiAJfQorY3JlYXRl
X25fZ3JhZnQyOgogCWlmIChjbGlkID09IFRDX0hfSU5HUkVTUykgewogCQlpZiAoZGV2X2luZ3Jl
c3NfcXVldWUoZGV2KSkgewogCQkJcSA9IHFkaXNjX2NyZWF0ZShkZXYsIGRldl9pbmdyZXNzX3F1
ZXVlKGRldiksCg==
--00000000000039c23e0603342ba8--

