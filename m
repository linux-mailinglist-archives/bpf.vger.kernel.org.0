Return-Path: <bpf+bounces-23086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196086D58F
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC7E28B73F
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892536D523;
	Thu, 29 Feb 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFBpKDqT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251F6D505;
	Thu, 29 Feb 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239962; cv=none; b=ea5aH0DG5ajDNyShjT7r5Pb1pF2fwCDRFdgpk2gaPcpFi8Gytiuq9IO0TsKldH04kzgzTj1u+263JbcQxKxLP5EdA/OmqiLjAwRfYDp3reV0VKiv8ZhgPDEvcJfU5N/zlSSj8O6vOdDMdHk7gs+Gs1FQEQ0yzISdfd+jdGIwgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239962; c=relaxed/simple;
	bh=7xIWipJ1u7IgKUsAG4x/lhz8VWHwRplOG7EvQynAyfM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gXMN8lVdD1xXNqgm4zWrN7WLl8FZV7z8NIpFzvkvAIZvMgcDLHWrhwk2q+pqfOWKl6jorieQSJ9Y+MD7h9LXQiEnkJ3YOQZH975Q6K5hbGCoRx88mowMEeuFEkB+ag0sgiorZWRIYxgwKq4qp9qWjOz4qDGT6ZrZM3yBduLNmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFBpKDqT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5e152c757a5so977971a12.2;
        Thu, 29 Feb 2024 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709239959; x=1709844759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVcyemIJJXmq6MyiGedQg0JfPM86BVNH/8PxvJYinsE=;
        b=XFBpKDqTAqSn1ifbTLE1LgFIbkE0UZxwvJ5ZXv4PDGIR/xID1sh4qBBtmKl7Tjn0eb
         rRudHClD5HBnAM5U9P0Xxi+gpUGm9kjwcpikQgn19+/C/JSqXQJaMlq1cc6ddyE0qC/3
         iLiLAUXgFv/dZX8PNY+ZtVkRYX/Tm70PDCJq8QQxiU7MT1VQR3vJvlXpPLvvclPYY5+E
         Gjg45EDu9iVORj3r9Vms5zCfIvzJYiMS8VrHSbNnmQngl1+nEY6IUytmpMhEEFhO/SMY
         veeSZMOlhG2zrzxkTIQbuYjIClP5zMMtHKIyA2DQDkpKRC+btUdk/ciLX1pFA+0JRBn9
         hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709239959; x=1709844759;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sVcyemIJJXmq6MyiGedQg0JfPM86BVNH/8PxvJYinsE=;
        b=Uy2cWsDpuOV8z4sGB617HeK1HebT91Xl1n6oj8gLA+UhN8Vb2UKuUI7EjJ1oyNJ/Py
         0gaRs1NqAXRzVlyxF2BDm1er7UsrI8oTGGboEqmMgZIjvhlvZmoUZ7kEnjR5GUGNHycI
         W+Xb/DYG0VJgBRNyA163t/Rt4K4toSjdgds6DYSRiqf+HGVhvCgim8mgDyQZaSi7ZDQx
         JlPgOormZ7fnJngkMaH5UIIaicjHUo0hkcjdfnuyAiYU7Wdu9Y5drgUXXzDBrzIMu8rf
         EngywKrwBTmuG1yUDI0tVmKoARgMc/+icH7HpA0ofBWVQbLBkHCr0aXIAHgFiaGsICft
         o4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVKDWdluho6pIxABHGrYEppwgK/Nl0yt87wkijuzSfM+ZEMxQgy3n8H8AKltAukpCJeLljl6YsU/QBJaV+uVBozos3q
X-Gm-Message-State: AOJu0YyaLc6jQIAQ3BCVkP1J+bTL/GQuqJHpukM84VTJIOI8r9gOWySI
	OMzak2VbQIRpZO6EMOniSGqxrpQi/oBRepKdVMIXmhkRjWgF3BBh
X-Google-Smtp-Source: AGHT+IFzAOFU0+0aHgSoCceV3KCrgnfBFcL/PXffcrAJoehguMFPySohBbQCCL+NsPmPWcxBdwZyjQ==
X-Received: by 2002:a17:902:9a04:b0:1dc:b48f:3c8d with SMTP id v4-20020a1709029a0400b001dcb48f3c8dmr2624929plp.52.1709239958693;
        Thu, 29 Feb 2024 12:52:38 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902708300b001dcc0d06959sm1932879plk.245.2024.02.29.12.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:52:38 -0800 (PST)
Date: Thu, 29 Feb 2024 12:52:36 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 Vipin.Jain@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 daniel@iogearbox.net, 
 victor@mojatatu.com, 
 pctammela@mojatatu.com, 
 dan.daly@intel.com, 
 andy.fingerhut@gmail.com, 
 chris.sommers@keysight.com, 
 mattyk@nvidia.com, 
 bpf@vger.kernel.org
Message-ID: <65e0ee94af3b4_33719208a5@john.notmuch>
In-Reply-To: <CAM0EoM=xk-hK7XCXQFcaDmMPkCcj+wba8JWKxWMF7M7B+tC6TQ@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
 <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CAM0EoM=xk-hK7XCXQFcaDmMPkCcj+wba8JWKxWMF7M7B+tC6TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim wrote:
> On Thu, Feb 29, 2024 at 12:14=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >
> > On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> > > This is the first patchset of two. In this patch we are submitting =
15 which
> > > cover the minimal viable P4 PNA architecture.
> > >
> > > __Description of these Patches__
> > >
> > > Patch #1 adds infrastructure for per-netns P4 actions that can be c=
reated on
> > > as need basis for the P4 program requirement. This patch makes a sm=
all incision
> > > into act_api. Patches 2-4 are minimalist enablers for P4TC and have=
 no
> > > effect the classical tc action (example patch#2 just increases the =
size of the
> > > action names from 16->64B).
> > > Patch 5 adds infrastructure support for preallocation of dynamic ac=
tions.
> > >
> > > The core P4TC code implements several P4 objects.
> > > 1) Patch #6 introduces P4 data types which are consumed by the rest=
 of the code
> > > 2) Patch #7 introduces the templating API. i.e. CRUD commands for t=
emplates
> > > 3) Patch #8 introduces the concept of templating Pipelines. i.e CRU=
D commands
> > >    for P4 pipelines.
> > > 4) Patch #9 introduces the action templates and associated CRUD com=
mands.
> > > 5) Patch #10 introduce the action runtime infrastructure.
> > > 6) Patch #11 introduces the concept of P4 table templates and assoc=
iated
> > >    CRUD commands for tables.
> > > 7) Patch #12 introduces runtime table entry infra and associated CU=
 commands.
> > > 8) Patch #13 introduces runtime table entry infra and associated RD=
 commands.
> > > 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfun=
c.
> > > 10) Patch #15 introduces the TC classifier P4 used at runtime.
> > >
> > > Daniel, please look again at patch #15.
> > >
> > > There are a few more patches (5) not in this patchset that deal wit=
h test
> > > cases, etc.
> > >
> > > What is P4?
> > > -----------
> > >
> > > The Programming Protocol-independent Packet Processors (P4) is an o=
pen source,
> > > domain-specific programming language for specifying data plane beha=
vior.
> > >
> > > The current P4 landscape includes an extensive range of deployments=
, products,
> > > projects and services, etc[9][12]. Two major NIC vendors, Intel[10]=
 and AMD[11]
> > > currently offer P4-native NICs. P4 is currently curated by the Linu=
x
> > > Foundation[9].
> > >
> > > On why P4 - see small treatise here:[4].
> > >
> > > What is P4TC?
> > > -------------
> > >
> > > P4TC is a net-namespace aware P4 implementation over TC; meaning, a=
 P4 program
> > > and its associated objects and state are attachend to a kernel _net=
ns_ structure.
> > > IOW, if we had two programs across netns' or within a netns they ha=
ve no
> > > visibility to each others objects (unlike for example TC actions wh=
ose kinds are
> > > "global" in nature or eBPF maps visavis bpftool).
> > >
> > > P4TC builds on top of many years of Linux TC experiences of a netli=
nk control
> > > path interface coupled with a software datapath with an equivalent =
offloadable
> > > hardware datapath. In this patch series we are focussing only on th=
e s/w
> > > datapath. The s/w and h/w path equivalence that TC provides is rele=
vant
> > > for a primary use case of P4 where some (currently) large consumers=
 of NICs
> > > provide vendors their datapath specs in P4. In such a case one coul=
d generate
> > > specified datapaths in s/w and test/validate the requirements befor=
e hardware
> > > acquisition(example [12]).
> > >
> > > Unlike other approaches such as TC Flower which require kernel and =
user space
> > > changes when new datapath objects like packet headers are introduce=
d P4TC, with
> > > these patches, provides _kernel and user space code change independ=
ence_.
> > > Meaning:
> > > A P4 program describes headers, parsers, etc alongside the datapath=
 processing;
> > > the compiler uses the P4 program as input and generates several art=
ifacts which
> > > are then loaded into the kernel to manifest the intended datapath. =
In addition
> > > to the generated datapath, control path constructs are generated. T=
he process is
> > > described further below in "P4TC Workflow".
> > >
> > > There have been many discussions and meetings within the community =
since
> > > about 2015 in regards to P4 over TC[2] and we are finally proving t=
o the
> > > naysayers that we do get stuff done!
> > >
> > > A lot more of the P4TC motivation is captured at:
> > > https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
> > >
> > > __P4TC Architecture__
> > >
> > > The current architecture was described at netdevconf 0x17[14] and i=
f you prefer
> > > academic conference papers, a short paper is available here[15].
> > >
> > > There are 4 parts:
> > >
> > > 1) A Template CRUD provisioning API for manifesting a P4 program an=
d its
> > > associated objects in the kernel. The template provisioning API use=
s netlink.
> > > See patch in part 2.
> > >
> > > 2) A Runtime CRUD+ API code which is used for controlling the diffe=
rent runtime
> > > behavior of the P4 objects. The runtime API uses netlink. See notes=
 further
> > > down. See patch description later..
> > >
> > > 3) P4 objects and their control interfaces: tables, actions, extern=
s, etc.
> > > Any object that requires control plane interaction resides in the T=
C domain
> > > and is subject to the CRUD runtime API.  The intended goal is to ma=
ke use of the
> > > tc semantics of skip_sw/hw to target P4 program objects either in s=
/w or h/w.
> > >
> > > 4) S/W Datapath code hooks. The s/w datapath is eBPF based and is g=
enerated
> > > by a compiler based on the P4 spec. When accessing any P4 object th=
at requires
> > > control plane interfaces, the eBPF code accesses the P4TC side from=
 #3 above
> > > using kfuncs.
> > >
> > > The generated eBPF code is derived from [13] with enhancements and =
fixes to meet
> > > our requirements.
> > >
> > > __P4TC Workflow__
> > >
> > > The Development and instantiation workflow for P4TC is as follows:
> > >
> > >   A) A developer writes a P4 program, "myprog"
> > >
> > >   B) Compiles it using the P4C compiler[8]. The compiler generates =
3 outputs:
> > >
> > >      a) A shell script which form template definitions for the diff=
erent P4
> > >      objects "myprog" utilizes (tables, externs, actions etc). See =
#1 above..
> > >
> > >      b) the parser and the rest of the datapath are generated as eB=
PF and need
> > >      to be compiled into binaries. At the moment the parser and the=
 main control
> > >      block are generated as separate eBPF program but this could ch=
ange in
> > >      the future (without affecting any kernel code). See #4 above.
> > >
> > >      c) A json introspection file used for the control plane (by ip=
route2/tc).
> > >
> > >   C) At this point the artifacts from #1,#4 could be handed to an o=
perator
> > >      (the operator could be the same person as the developer from #=
A, #B).
> > >
> > >      i) For the eBPF part, either the operator is handed an ebpf bi=
nary or
> > >      source which they compile at this point into a binary.
> > >      The operator executes the shell script(s) to manifest the func=
tional
> > >      "myprog" into the kernel.
> > >
> > >      ii) The operator instantiates "myprog" pipeline via the tc P4 =
filter
> > >      to ingress/egress (depending on P4 arch) of one or more netdev=
s/ports
> > >      (illustrated below as "block 22").
> > >
> > >      Example instantion where the parser is a separate action:
> > >        "tc filter add block 22 ingress protocol all prio 10 p4 pnam=
e myprog \
> > >         action bpf obj $PARSER.o section p4tc/parse \
> > >         action bpf obj $PROGNAME.o section p4tc/main"
> > >
> > > See individual patches in partc for more examples tc vs xdp etc. Al=
so see
> > > section on "challenges" (further below on this cover letter).
> > >
> > > Once "myprog" P4 program is instantiated one can start performing o=
perations
> > > on table entries and/or actions at runtime as described below.
> > >
> > > __P4TC Runtime Control Path__
> > >
> > > The control interface builds on past tc experience and tries to get=
 things
> > > right from the beginning (example filtering is separated from depen=
ding
> > > on existing object TLVs and made generic); also the code is written=
 in
> > > such a way it is mostly lockless.
> > >
> > > The P4TC control interface, using netlink, provides what we call a =
CRUDPS
> > > abstraction which stands for: Create, Read(get), Update, Delete, Su=
bscribe,
> > > Publish.  From a high level PoV the following describes a conforman=
t high level
> > > API (both on netlink data model and code level):
> > >
> > >       Create(</path/to/object, DATA>+)
> > >       Read(</path/to/object>, [optional filter])
> > >       Update(</path/to/object>, DATA>+)
> > >       Delete(</path/to/object>, [optional filter])
> > >       Subscribe(</path/to/object>, [optional filter])
> > >
> > > Note, we _dont_ treat "dump" or "flush" as speacial. If "path/to/ob=
ject" points
> > > to a table then a "Delete" implies "flush" and a "Read" implies dum=
p but if
> > > it points to an entry (by specifying a key) then "Delete" implies d=
eleting
> > > and entry and "Read" implies reading that single entry. It should b=
e noted that
> > > both "Delete" and "Read" take an optional filter parameter. The fil=
ter can
> > > define further refinements to what the control plane wants read or =
deleted.
> > > "Subscribe" uses built in netlink event management. It, as well, ta=
kes a filter
> > > which can further refine what events get generated to the control p=
lane (taken
> > > out of this patchset, to be re-added with consideration of [16]).
> > >
> > > Lets show some runtime samples:
> > >
> > > ..create an entry, if we match ip address 10.0.1.2 send packet out =
eno1
> > >   tc p4ctrl create myprog/table/mytable \
> > >    dstAddr 10.0.1.2/32 action send_to_port param port eno1
> > >
> > > ..Batch create entries
> > >   tc p4ctrl create myprog/table/mytable \
> > >   entry dstAddr 10.1.1.2/32  action send_to_port param port eno1 \
> > >   entry dstAddr 10.1.10.2/32  action send_to_port param port eno10 =
\
> > >   entry dstAddr 10.0.2.2/32  action send_to_port param port eno2
> > >
> > > ..Get an entry (note "read" is interchangeably used as "get" which =
is a common
> > >               semantic in tc):
> > >   tc p4ctrl read myprog/table/mytable \
> > >    dstAddr 10.0.2.2/32
> > >
> > > ..dump mytable
> > >   tc p4ctrl read myprog/table/mytable
> > >
> > > ..dump mytable for all entries whose key fits within 10.1.0.0/16
> > >   tc p4ctrl read myprog/table/mytable \
> > >   filter key/myprog/mytable/dstAddr =3D 10.1.0.0/16
> > >
> > > ..dump all mytable entries which have an action send_to_port with p=
aram "eno1"
> > >   tc p4ctrl get myprog/table/mytable \
> > >   filter param/act/myprog/send_to_port/port =3D "eno1"
> > >
> > > The filter expression is powerful, f.e you could say:
> > >
> > >   tc p4ctrl get myprog/table/mytable \
> > >   filter param/act/myprog/send_to_port/port =3D "eno1" && \
> > >          key/myprog/mytable/dstAddr =3D 10.1.0.0/16
> > >
> > > It also works on built in metadata, example in the following case d=
umping
> > > entries from mytable that have seen activity in the last 10 secs:
> > >   tc p4ctrl get myprog/table/mytable \
> > >   filter msecs_since < 10000
> > >
> > > Delete follows the same syntax as get/read, so for sake of brevity =
we won't
> > > show more example than how to flush mytable:
> > >
> > >   tc p4ctrl delete myprog/table/mytable
> > >
> > > Mystery question: How do we achieve iproute2-kernel independence an=
d
> > > how does "tc p4ctrl" as a cli know how to program the kernel given =
an
> > > arbitrary command line as shown above? Answer(s): It queries the
> > > compiler generated json file in "P4TC Workflow" #B.c above. The jso=
n file has
> > > enough details to figure out that we have a program called "myprog"=
 which has a
> > > table "mytable" that has a key name "dstAddr" which happens to be t=
ype ipv4
> > > address prefix. The json file also provides details to show that th=
e table
> > > "mytable" supports an action called "send_to_port" which accepts a =
parameter
> > > "port" of type netdev (see the types patch for all supported P4 dat=
a types).
> > > All P4 components have names, IDs, and types - so this makes it ver=
y easy to map
> > > into netlink.
> > > Once user space tc/p4ctrl validates the human command input, it cre=
ates
> > > standard binary netlink structures (TLVs etc) which are sent to the=
 kernel.
> > > See the runtime table entry patch for more details.
> > >
> > > __P4TC Datapath__
> > >
> > > The P4TC s/w datapath execution is generated as eBPF. Any objects t=
hat require
> > > control interfacing reside in the "P4TC domain" and are controlled =
via netlink
> > > as described above. Per packet execution and state and even objects=
 that do not
> > > require control interfacing (like the P4 parser) are generated as e=
BPF.
> > >
> > > A packet arriving on s/w ingress of any of the ports on block 22 wi=
ll first be
> > > exercised via the (generated eBPF) parser component to extract the =
headers (the
> > > ip destination address in labelled "dstAddr" above).
> > > The datapath then proceeds to use "dstAddr", table ID and pipeline =
ID
> > > as a key to do a lookup in myprog's "mytable" which returns the act=
ion params
> > > which are then used to execute the action in the eBPF datapath (eve=
ntually
> > > sending out packets to eno1).
> > > On a table miss, mytable's default miss action (not described) is e=
xecuted.
> > >
> > > __Testing__
> > >
> > > Speaking of testing - we have 2-300 tdc test cases (which will be i=
n the
> > > second patchset).
> > > These tests are run on our CICD system on pull requests and after c=
ommits are
> > > approved. The CICD does a lot of other tests (more since v2, thanks=
 to Simon's
> > > input)including:
> > > checkpatch, sparse, smatch, coccinelle, 32 bit and 64 bit builds te=
sted on both
> > > X86, ARM 64 and emulated BE via qemu s390. We trigger performance t=
esting in the
> > > CICD to catch performance regressions (currently only on the contro=
l path, but
> > > in the future for the datapath).
> > > Syzkaller runs 24/7 on dedicated hardware, originally we focussed o=
nly on memory
> > > sanitizer but recently added support for concurrency sanitizer.
> > > Before main releases we ensure each patch will compile on its own t=
o help in
> > > git bisect and run the xmas tree tool. We eventually put the code v=
ia coverity.
> > >
> > > In addition we are working on enabling a tool that will take a P4 p=
rogram, run
> > > it through the compiler, and generate permutations of traffic patte=
rns via
> > > symbolic execution that will test both positive and negative datapa=
th code
> > > paths. The test generator tool integration is still work in progres=
s.
> > > Also: We have other code that test parallelization etc which we are=
 trying to
> > > find a fit for in the kernel tree's testing infra.
> > >
> > >
> > > __References__
> > >
> > > [1]https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/20=
23P4WorkshopP4TC.pdf
> > > [2]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#historica=
l-perspective-for-p4tc
> > > [3]https://2023p4workshop.sched.com/event/1KsAe/p4tc-linux-kernel-p=
4-implementation-approaches-and-evaluation
> > > [4]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#so-why-p4=
-and-how-does-p4-help-here
> > > [5]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojata=
tu.com/T/#mf59be7abc5df3473cff3879c8cc3e2369c0640a6
> > > [6]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojata=
tu.com/T/#m783cfd79e9d755cf0e7afc1a7d5404635a5b1919
> > > [7]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojata=
tu.com/T/#ma8c84df0f7043d17b98f3d67aab0f4904c600469
> > > [8]https://github.com/p4lang/p4c/tree/main/backends/tc
> > > [9]https://p4.org/
> > > [10]https://www.intel.com/content/www/us/en/products/details/networ=
k-io/ipu/e2000-asic.html
> > > [11]https://www.amd.com/en/accelerators/pensando
> > > [12]https://github.com/sonic-net/DASH/tree/main
> > > [13]https://github.com/p4lang/p4c/tree/main/backends/ebpf
> > > [14]https://netdevconf.info/0x17/sessions/talk/integrating-ebpf-int=
o-the-p4tc-datapath.html
> > > [15]https://dl.acm.org/doi/10.1145/3630047.3630193
> > > [16]https://lore.kernel.org/netdev/20231216123001.1293639-1-jiri@re=
snulli.us/
> > > [17.a]https://netdevconf.info/0x13/session.html?talk-tc-u-classifie=
r
> > > [17.b]man tc-u32
> > > [18]man tc-pedit
> > > [19] https://lore.kernel.org/netdev/20231219181623.3845083-6-victor=
@mojatatu.com/T/#m86e71743d1d83b728bb29d5b877797cb4942e835
> > > [20.a] https://netdevconf.info/0x16/sessions/talk/your-network-data=
path-will-be-p4-scripted.html
> > > [20.b] https://netdevconf.info/0x16/sessions/workshop/p4tc-workshop=
.html
> > >
> > > --------
> > > HISTORY
> > > --------
> > >
> > > Changes in Version 12
> > > ----------------------
> > >
> > > 0) Introduce back 15 patches (v11 had 5)
> > >
> > > 1) From discussions with Daniel:
> > >    i) Remove the XDP programs association alltogether. No refcounti=
ng. nothing.
> > >    ii) Remove prog type tc - everything is now an ebpf tc action.
> > >
> > > 2) s/PAD0/__pad0/g. Thanks to Marcelo.
> > >
> > > 3) Add extack to specify how many entries (N of M) specified in a b=
atch for
> > >    any of requested Create/Update/Delete succeeded. Prior to this i=
t would
> > >    only tell us the batch failed to complete without giving us deta=
ils of
> > >    which of M failed. Added as a debug aid.
> > >
> > > Changes in Version 11
> > > ----------------------
> > > 1) Split the series into two. Original patches 1-5 in this patchset=
. The rest
> > >    will go out after this is merged.
> > >
> > > 2) Change any references of IFNAMSIZ in the action code when refere=
ncing the
> > >    action name size to ACTNAMSIZ. Thanks to Marcelo.
> > >
> > > Changes in Version 10
> > > ----------------------
> > > 1) A couple of patches from the earlier version were clean enough t=
o submit,
> > >    so we did. This gave us room to split the two largest patches ea=
ch into
> > >    two. Even though the split is not git-bisactable and really some=
 of it didn't
> > >    make much sense (eg spliting a create, and update in one patch a=
nd delete and
> > >    get into another) we made sure each of the split patches compile=
d
> > >    independently. The idea is to reduce the number of lines of code=
 to review
> > >    and when we get sufficient reviews we will put the splits togeth=
er again.
> > >    See patch #12 and #13 as well as patches #7 and #8).
> > >
> > > 2) Add more context in patch 0. Please READ!
> > >
> > > 3) Added dump/delete filters back to the code - we had taken them o=
ut in the
> > >    earlier patches to reduce the amount of code for review - but in=
 retrospect
> > >    we feel they are important enough to push earlier rather than la=
ter.
> > >
> > >
> > > Changes In version 9
> > > ---------------------
> > >
> > > 1) Remove the largest patch (externs) to ease review.
> > >
> > > 2) Break up action patches into two to ease review bringing down th=
e patches
> > >    that need more scrutiny to 8 (the first 7 are almost trivial).
> > >
> > > 3) Fixup prefix naming convention to p4tc_xxx for uapi and p4a_xxx =
for actions
> > >    to provide consistency(Jiri).
> > >
> > > 4) Silence sparse warning "was not declared. Should it be static?" =
for kfuncs
> > >    by making them static. TBH, not sure if this is the right soluti=
on
> > >    but it makes sparse happy and hopefully someone will comment.
> > >
> > > Changes In Version 8
> > > ---------------------
> > >
> > > 1) Fix all the patchwork warnings and improve our ci to catch them =
in the future
> > >
> > > 2) Reduce the number of patches to basic max(15)  to ease review.
> > >
> > > Changes In Version 7
> > > -------------------------
> > >
> > > 0) First time removing the RFC tag!
> > >
> > > 1) Removed XDP cookie. It turns out as was pointed out by Toke(Than=
ks!) - that
> > > using bpf links was sufficient to protect us from someone replacing=
 or deleting
> > > a eBPF program after it has been bound to a netdev.
> > >
> > > 2) Add some reviewed-bys from Vlad.
> > >
> > > 3) Small bug fixes from v6 based on testing for ebpf.
> > >
> > > 4) Added the counter extern as a sample extern. Illustrating this e=
xample because
> > >    it is slightly complex since it is possible to invoke it directl=
y from
> > >    the P4TC domain (in case of direct counters) or from eBPF (indir=
ect counters).
> > >    It is not exactly the most efficient implementation (a reasonabl=
e counter impl
> > >    should be per-cpu).
> > >
> > > Changes In RFC Version 6
> > > -------------------------
> > >
> > > 1) Completed integration from scriptable view to eBPF. Completed in=
tegration
> > >    of externs integration.
> > >
> > > 2) Small bug fixes from v5 based on testing.
> > >
> > > Changes In RFC Version 5
> > > -------------------------
> > >
> > > 1) More integration from scriptable view to eBPF. Small bug fixes f=
rom last
> > >    integration.
> > >
> > > 2) More streamlining support of externs via kfunc (create-on-miss, =
etc)
> > >
> > > 3) eBPF linking for XDP.
> > >
> > > There is more eBPF integration/streamlining coming (we are getting =
close to
> > > conversion from scriptable domain).
> > >
> > > Changes In RFC Version 4
> > > -------------------------
> > >
> > > 1) More integration from scriptable to eBPF. Small bug fixes.
> > >
> > > 2) More streamlining support of externs via kfunc (one additional k=
func).
> > >
> > > 3) Removed per-cpu scratchpad per Toke's suggestion and instead use=
 XDP metadata.
> > >
> > > There is more eBPF integration coming. One thing we looked at but i=
s not in this
> > > patchset but should be in the next is use of eBPF link in our loadi=
ng (see
> > > "challenge #1" further below).
> > >
> > > Changes In RFC Version 3
> > > -------------------------
> > >
> > > These patches are still in a little bit of flux as we adjust to int=
egrating
> > > eBPF. So there are small constructs that are used in V1 and 2 but n=
o longer
> > > used in this version. We will make a V4 which will remove those.
> > > The changes from V2 are as follows:
> > >
> > > 1) Feedback we got in V2 is to try stick to one of the two modes. I=
n this version
> > > we are taking one more step and going the path of mode2 vs v2 where=
 we had 2 modes.
> > >
> > > 2) The P4 Register extern is no longer standalone. Instead, as part=
 of integrating
> > > into eBPF we introduce another kfunc which encapsulates Register as=
 part of the
> > > extern interface.
> > >
> > > 3) We have improved our CICD to include tools pointed to us by Simo=
n. See
> > >    "Testing" further below. Thanks to Simon for that and other issu=
es he caught.
> > >    Simon, we discussed on issue [7] but decided to keep that log si=
nce we think
> > >    it is useful.
> > >
> > > 4) A lot of small cleanups. Thanks Marcelo. There are two things we=
 need to
> > >    re-discuss though; see: [5], [6].
> > >
> > > 5) We removed the need for a range of IDs for dynamic actions. Than=
ks Jakub.
> > >
> > > 6) Clarify ambiguity caused by smatch in an if(A) else if(B) condit=
ion. We are
> > >    guaranteed that either A or B must exist; however, lets make sma=
tch happy.
> > >    Thanks to Simon and Dan Carpenter.
> > >
> > > Changes In RFC Version 2
> > > -------------------------
> > >
> > > Version 2 is the initial integration of the eBPF datapath.
> > > We took into consideration suggestions provided to use eBPF and put=
 effort into
> > > analyzing eBPF as datapath which involved extensive testing.
> > > We implemented 6 approaches with eBPF and ran performance analysis =
and presented
> > > our results at the P4 2023 workshop in Santa Clara[see: 1, 3] on ea=
ch of the 6
> > > vs the scriptable P4TC and concluded that 2 of the approaches are s=
ensible (4 if
> > > you account for XDP or TC separately).
> > >
> > > Conclusions from the exercise: We lose the simple operational model=
 we had
> > > prior to integrating eBPF. We do gain performance in most cases whe=
n the
> > > datapath is less compute-bound.
> > > For more discussion on our requirements vs journeying the eBPF path=
 please
> > > scroll down to "Restating Our Requirements" and "Challenges".
> > >
> > > This patch set presented two modes.
> > > mode1: the parser is entirely based on eBPF - whereas the rest of t=
he
> > > SW datapath stays as _scriptable_ as in Version 1.
> > > mode2: All of the kernel s/w datapath (including parser) is in eBPF=
.
> > >
> > > The key ingredient for eBPF, that we did not have access to in the =
past, is
> > > kfunc (it made a big difference for us to reconsider eBPF).
> > >
> > > In V2 the two modes are mutually exclusive (IOW, you get to choose =
one
> > > or the other via Kconfig).
> >
> > I think/fear that this series has a "quorum" problem: different voice=
s
> > raises opposition, and nobody (?) outside the authors supported the
> > code and the feature.
> >
> > Could be the missing of H/W offload support in the current form the
> > root cause for such lack support? Or there are parties interested tha=
t
> > have been quite so far?

Yeah agree with h/w comment would be interested to hear these folks that
have h/w. For me to get on board obvious things that would be interesting=
.
(a) hardware offload (b) some fundamental problem with exisiing p4c
backend we already have or (c) significant performance improvement.

> =

> Some of the people who attend our meetings and have vested interest in
> this are on Cc.  But the cover letter is clear on this (right at the
> top under "What is P4" and "what is P4TC").
> =

> cheers,
> jamal
> =

> =

> > Thanks,
> >
> > Paolo
> >
> >
> =




