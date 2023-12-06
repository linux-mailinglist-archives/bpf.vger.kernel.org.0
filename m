Return-Path: <bpf+bounces-16887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D22F80732E
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBBD1F21837
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCB3EA8B;
	Wed,  6 Dec 2023 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="13hkpvIC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C059A
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:59:27 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d3efc071e2so63637287b3.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701874767; x=1702479567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGSoMqUMkYvVS+AiSljh5y4/XTemq0cyBuGBsxoL0EI=;
        b=13hkpvICUtO5jmVS4Yj3Pq9xVXpk8y2a8Im7TYD0PQPUBF09L1dUHTvodDcRveW8RR
         7NtufWymCyyyJoci3rwMMK99zVw9XyjzWHWU6Z9alSHTkPrPPD8E1sBHLUo6wTDAPQGb
         O+/ODNFhZwDV2EA/N8Rm63bhFT04aTCljqyTml2r+sqsRFyLnzYTTdrbuupnBrPqWgsk
         OSIS8ilHTkjlxgj5qf5h3eKFP12/zitIXliCuHazEppjg1jlLHDIN4Cjg8Ik2p+ETqAQ
         0z0im+HcxXKHk7GoX0kmPvnuFfTUF7QKDTRp0rnG1JWJH2tuXrqP9uWXGa5JDu9bH6IN
         9Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874767; x=1702479567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGSoMqUMkYvVS+AiSljh5y4/XTemq0cyBuGBsxoL0EI=;
        b=qd1Bwc3Ir9LbQhmtnGisvcL55HRGobn3H1GgrxxXHpSi9kAlcFdlyJbq2mYIi6Yfde
         Y16paS346QDBwghjrOVd057KjpCr/BOFDioQuSv88QgtcIJyTdsnLdPBEi9L+uZQVWNy
         IYHuol5v+8uetUxJYzo+HENexsiRSiQ5JIj9AQVlBJoRfMaSxq04OKdzv+X3Lmyx4mPz
         WanEyw57h+YDq/6yYYDJw5eZlKb8ZrmH6B9V+R9gBm1CzSs/9NVdlZDMfMRcq/71MEop
         aiXA6pY3LOvxxcqUVt1sNRCCE52eQQaGcdmuhfKQ2sSJN0M9QWNyFFJSuCPx3lycRmKN
         Wriw==
X-Gm-Message-State: AOJu0YyPJKBWVicYvTIZClkcgIeV6E+NFUC3pG5ZOsOpY9/h/dE/igrh
	GezBdw15IYk3EVbaNnovNKJcbJONxqHl6ZipchBuAQ==
X-Google-Smtp-Source: AGHT+IFXVYHPaxbV+qR6B03/9foFUcebXO4Iz9RYl3YOiFIqtc7cvmWTL8KtguizFKFX4e6votQFujvkqgbLGT4d4eM=
X-Received: by 2002:a81:99d7:0:b0:5cd:c7a3:6cb3 with SMTP id
 q206-20020a8199d7000000b005cdc7a36cb3mr793295ywg.37.1701874766647; Wed, 06
 Dec 2023 06:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201182904.532825-1-jhs@mojatatu.com> <20231201182904.532825-16-jhs@mojatatu.com>
 <656e6f8d7c99f_207cb2087c@john.notmuch> <2eb488f9-af4a-4e28-0de0-d4dbc1e166f5@iogearbox.net>
 <CAM0EoM=MJJH9zNdiEHYpkYYQ_7WqobGv_v8wp04R7HhdPW8TxA@mail.gmail.com> <50b4dd0b-94fe-36b2-9a69-51847f8a7712@iogearbox.net>
In-Reply-To: <50b4dd0b-94fe-36b2-9a69-51847f8a7712@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 6 Dec 2023 09:59:15 -0500
Message-ID: <CAM0EoMmQpiiEZw_QfXMzWfbb=6_MkLTasjwjL1MVy0nBvMJCsg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 15/15] p4tc: add P4 classifier
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	deb.chatterjee@intel.com, anjali.singhai@intel.com, namrata.limaye@intel.com, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:32=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 12/5/23 5:23 PM, Jamal Hadi Salim wrote:
> > On Tue, Dec 5, 2023 at 8:43=E2=80=AFAM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >> On 12/5/23 1:32 AM, John Fastabend wrote:
> >>> Jamal Hadi Salim wrote:
> >>>> Introduce P4 tc classifier. A tc filter instantiated on this classif=
ier
> >>>> is used to bind a P4 pipeline to one or more netdev ports. To use P4
> >>>> classifier you must specify a pipeline name that will be associated =
to
> >>>> this filter, a s/w parser and datapath ebpf program. The pipeline mu=
st have
> >>>> already been created via a template.
> >>>> For example, if we were to add a filter to ingress of network interf=
ace
> >>>> device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
> >>>> following command:
> >>>
> >>> In addition to my comments from last iteration.
> >>>
> >>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simp=
le_l3 \
> >>>>       action bpf obj $PARSER.o section prog/tc-parser \
> >>>>       action bpf obj $PROGNAME.o section prog/tc-ingress
> >>>
> >>> Having multiple object files is a mistake IMO and will cost
> >>> performance. Have a single object file avoid stitching together
> >>> metadata and run to completion. And then run entirely from XDP
> >>> this is how we have been getting good performance numbers.
> >>
> >> +1, fully agree.
> >
> > As I stated earlier: while performance is important it is not the
> > highest priority for what we are doing, rather correctness is. We dont
> > want to be wrestling with the verifier or some other limitation like
> > tail call limits to gain some increase in a few kkps. We are taking a
> > gamble with the parser which is not using any kfuncs at the moment.
> > Putting them all in one program will increase the risk.
>
> I don't think this is a good reason, this corners you into UAPI which
> later on cannot be changed anymore. If you encounter such issues, then
> why not bringing up actual concrete examples / limitations you run into
> to the BPF community and help one way or another to get the verifier
> improved instead? (Again, see sched_ext as one example improving verifier=
,
> but also concrete example bug reports, etc could help.)
>

Which uapi are you talking about? The eBPF code gets generated by the
compiler. Whether we generate one or 10 programs or where we place
them is up to the compiler.
We choose today to generate the parser separately - but we can change
it in a heartbeat with zero kernel changes.

> > As i responded to you earlier,  we just dont want to lose
> > functionality, some sample space:
> > - we could have multiple pipelines with different priorities - and
> > each pipeline may have its own logic with many tables etc (and the
> > choice to iterate the next one is essentially encoded in the tc action
> > codes)
> > - we want to be able to split the pipeline into parts that can run _in
> > unison_ in h/w, xdp, and tc
>
> So parser at XDP, but then you push it up the stack (instead of staying
> only at XDP layer) just to reach into tc layer to perform a corresponding
> action.. and this just to work around verifier as you say?
>

You are mixing things. The idea of being able to split a pipeline into
hw:xdp:tc is a requirement.  You can run the pipeline fully in XDP  or
fully in tc or split it when it makes sense.
The idea of splitting the parser from the main p4 control block is for
two reasons 1) someone else can generate or handcode the parser if
they need to - we feel this is an area that may need to take advantage
of features like dynptr etc in the future 2) as a precaution to ensure
all P4 programs load. We have no problem putting both in one ebpf prog
when we gain confidence that it will _always_ work - it is a mere
change to what the compiler generates.

> > - we use tc block to map groups of ports heavily
> > - we use netlink as our control API
> >
> >>>> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs gene=
rated
> >>>> by the P4 compiler and will be the representation of the P4 program.
> >>>> Note that filter understands that $PARSER.o is a parser to be loaded
> >>>> at the tc level. The datapath program is merely an eBPF action.
> >>>>
> >>>> Note we do support a distinct way of loading the parser as opposed t=
o
> >>>> making it be an action, the above example would be:
> >>>>
> >>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simp=
le_l3 \
> >>>>       prog type tc obj $PARSER.o ... \
> >>>>       action bpf obj $PROGNAME.o section prog/tc-ingress
> >>>>
> >>>> We support two types of loadings of these initial programs in the pi=
peline
> >>>> and differentiate between what gets loaded at tc vs xdp by using syn=
tax of
> >>>>
> >>>> either "prog type tc obj" or "prog type xdp obj"
> >>>>
> >>>> For XDP:
> >>>>
> >>>> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3=
 \
> >>>>       prog type xdp obj $PARSER.o section parser/xdp \
> >>>>       pinned_link /sys/fs/bpf/mylink \
> >>>>       action bpf obj $PROGNAME.o section prog/tc-ingress
> >>>
> >>> I don't think tc should be loading xdp programs. XDP is not 'tc'.
> >>
> >> For XDP, we do have a separate attach API, for BPF links we have bpf_x=
dp_link_attach()
> >> via bpf(2) and regular progs we have the classic way via dev_change_xd=
p_fd() with
> >> IFLA_XDP_* attributes. Mid-term we'll also add bpf_mprog support for X=
DP to allow
> >> multi-user attachment. tc kernel code should not add yet another way o=
f attaching XDP,
> >> this should just reuse existing uapi infra instead from userspace cont=
rol plane side.
> >
> > I am probably missing something. We are not loading the XDP program -
> > it is preloaded, the only thing the filter does above is grabbing a
> > reference to it. The P4 pipeline in this case is split into a piece
> > (the parser) that runs on XDP and some that runs on tc. And as i
> > mentioned earlier we could go further another piece which is part of
> > the pipeline may run in hw. And infact in the future a compiler will
> > be able to generate code that is split across machines. For our s/w
> > datapath on the same node the only split is between tc and XDP.
>
> So it is even worse from a design PoV.

So from a wild accusation that we are loading the program to now a
condescending remark we have a bad design.

> The kernel side allows XDP program
> to be passed to cls_p4, but then it's not doing anything but holding a
> reference to that BPF program. Iow, you need anyway to go the regular way
> of bpf_xdp_link_attach() or dev_change_xdp_fd() to install XDP. Why is th=
e
> reference even needed here, why it cannot be done in user space from your
> control plane? This again, feels like a shim layer which should live in
> user space instead.
>

Our control path goes through tc - where we instantiate the pipeline
on typically a tc block. Note: there could be many pipeline instances
of the same set of ebpf programs. We need to know which ebpf programs
are bound to which pipelines. When a pipeline is instantiated or
destroyed it sends (netlink) events to user space. It is only natural
to reference the programs which are part of the pipeline at that point
i.e loading for tc progs and referencing for xdp. The control is
already in user space to create bpf links etc.

Our concern was (if you looked at the RFC discussions earlier on) a)
we dont want anyone removing or replacing the XDP program that is part
of a P4 pipeline b) we wanted to ensure in the case of a split
pipeline that the XDP code that ran before tc part of the pipeline was
infact the one that we wanted to run. The original code (before Toke
made a suggestion to use bpf links) was passing a cookie from XDP to
tc which we would use to solve these concerns. By creating the link in
user space we can pass the fd - which is what you are seeing here.
That solves both #a and #b.
Granted we may be a little paranoid but operationally an important
detail is:  if one dumps the tc filter with this approach they know
what progs compose the pipeline.

> >>>> The theory of operations is as follows:
> >>>>
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D1. PARSING=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> The packet first encounters the parser.
> >>>> The parser is implemented in ebpf residing either at the TC or XDP
> >>>> level. The parsed header values are stored in a shared eBPF map.
> >>>> When the parser runs at XDP level, we load it into XDP using tc filt=
er
> >>>> command and pin it to a file.
> >>>>
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D2. ACTIONS=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> In the above example, the P4 program (minus the parser) is encoded i=
n an
> >>>> action($PROGNAME.o). It should be noted that classical tc actions
> >>>> continue to work:
> >>>> IOW, someone could decide to add a mirred action to mirror all packe=
ts
> >>>> after or before the ebpf action.
> >>>>
> >>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simp=
le_l3 \
> >>>>       prog type tc obj $PARSER.o section parser/tc-ingress \
> >>>>       action bpf obj $PROGNAME.o section prog/tc-ingress \
> >>>>       action mirred egress mirror index 1 dev $P1 \
> >>>>       action bpf obj $ANOTHERPROG.o section mysect/section-1
> >>>>
> >>>> It should also be noted that it is feasible to split some of the ing=
ress
> >>>> datapath into XDP first and more into TC later (as was shown above f=
or
> >>>> example where the parser runs at XDP level). YMMV.
> >>>
> >>> Is there any performance value in partial XDP and partial TC? The mai=
n
> >>> wins we see in XDP are when we can drop, redirect, etc the packet
> >>> entirely in XDP and avoid skb altogether.
> >>>
> >>>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> >>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >>>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>
> >> The cls_p4 is roughly a copy of {cls,act}_bpf, and from a BPF communit=
y side
> >> we moved away from this some time ago for the benefit of a better mana=
gement
> >> API for tc BPF programs via bpf(2) through bpf_mprog (see libbpf and B=
PF selftests
> >> around this), as mentioned earlier. Please use this instead for your u=
serspace
> >> control plane, otherwise we are repeating the same mistakes from the p=
ast again
> >> that were already fixed.
> >
> > Sorry, that is your use case for kubernetes and not ours. We want to
>
> There is nothing specific to k8s, it's generic infrastructure for tc BPF
> and also used outside of k8s scope; please double-check the selftests to
> get a picture of the API and libbpf integration.
>

I did and i couldnt see how we can do any of the tcx/mprog using tc to
meet our requirements. I may be missing something very obvious but it
was why i said it was for your use case not ours. I would be willing
to look again if you say it works with tc but do note that I am fine
with tc infra where i can add actions, all composed of different
programs if i wanted to; and add addendums to use other tc existing
(non-ebpf) actions if i needed to. We have what we need working fine,
so there has to be a compelling reason to change.
I asked you a question earlier whether in your view tc use of ebpf is
deprecated. I have seen you make a claim in the past that sched_act
was useless and that everyone needs to use sched_cls and you went on
to say nobody needs priorities. TBH, that is _your view for your use
case_.

> > use the tc infra. We want to use netlink. I could be misreading what
> > you are saying but it seems that you are suggesting that tc infra is
> > now obsolete as far as ebpf is concerned? Overall: It is a bit selfish
> > to say your use case dictates how other people use ebpf. ebpf is just
> > a means to an end for us and _is not the end goal_ - just an infra
> > toolset.
>
> Not really, the infrastructure is already there and ready to be used and
> it supports basic building blocks such as BPF links, relative prog/link
> dependency resolution, etc, where none of it can be found here. The
> problem is "we want to use netlink" which is even why you need to push
> down things like XDP prog, but it's broken by design, really. You are
> trying to push down a control plane into netlink which should have been
> a framework in user space.
>

The netlink part is not negotiable - the cover letter says why and i
have explained it 10K times in these threads. You are listing all
these tcx features like relativeness for which i have no use for.
OTOH, like i said if it works with tc then i would be willing to look
at it but there need to be compelling reasons to move to that shiny
new infra.

cheers,
jamal

