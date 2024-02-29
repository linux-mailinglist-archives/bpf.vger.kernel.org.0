Return-Path: <bpf+bounces-23074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688886D292
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0621282A33
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D3134436;
	Thu, 29 Feb 2024 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MhS1TQyI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C0134428
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232584; cv=none; b=hV3QwKyhtlhP0z5pO6Bz5lUQZ3wFu0JSDqWzu9djm82DCrB7AVPDB74/pFcBKXB+CfskJqc6eHCvAwpA4NFSFLsC/E/thOxDXjghYx8Tw8uH32QARx6QSsq1IlB0r+WdJBltOU/GENzjg1LcjQO6ISVWHR5I4Hi+LJT73NDl7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232584; c=relaxed/simple;
	bh=TmKq2kRIgSCZOsBrTdDUdLXzRBgsG//FGd3SwCjFrcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWmguvS8aQ2pJTU1qmv1fQvgDa21bewKhCCHJ9f9dcpCHqVvBXsfY7f0IIGMWI5IeJRNbp9w5vTbRPWl14F7JAPzq5bDWxmaO6bcQHq14VUD1RDT6X6GNHyU5k5sDIbSI0IvjZoN6WrC7dWIXXiIkSzDN32rYUEhmV585pE9Hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MhS1TQyI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6096ab005c0so9402357b3.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709232581; x=1709837381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kEsb7tnNYuxkUGeIF/c9V3pDXSu8Or3DkSl6Gv4PYk=;
        b=MhS1TQyIglDc3yH9qDg3WDWE8HxaEmONm2GA9MkzNmA6K4qHnhDL9c0WvD1uNARd7e
         Jd+EgUxXFEt23hzJxbaoZYLZc8gk2qtAc7REGQl6R65spXt38y2vvPrECGKNPdzqzpAy
         sVLxurpK48eJdGMW7L+lPPZP46gDurXPgxmkHpibyDuoxt/mUlXT6BHxZ4GJTgYMFQXy
         Xmb5EV0bjzF3RUGegRmQgVSK6rhMOvOiYl6P7pGjHzojrQRoF6a42dREBxwAIAtbY+2A
         0LKh1lUxj9GsjzOxCc7/FVFwwTzZtUIZqDl89tJ2AGOYmHBdEIm0qY8oV4Zy31DKoMzN
         KUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232581; x=1709837381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kEsb7tnNYuxkUGeIF/c9V3pDXSu8Or3DkSl6Gv4PYk=;
        b=SuOEKQSG0ox2PhAWbFvVf4A2b+SPak03Gl0OTx/PR5rCi+rTo4b/AbnsAq+/jJ3QHk
         oWg6QnamXvhkDdvm18YK8xaCQuF8Xh5RQXPg4w9vKLFhgh7tpr4nEW9VIuFyrACYDMWV
         NCpRT1WEmEuEpx6mEy6aYiosmGtRzr13f3iHzr3Kj0QHvFH8ivEy01eWchgnTg25pqTm
         GHqCDriJ9sBdgUP5bFUnVnXNd5G5gbB2Zlx2vPsPHqZ9p4BlphdjWh01CvqzW4HJvYcW
         pGJLzjGVNeLNLZ5IcysXz+tHPxibKe25w23bNKLTQ9pNzuHOoMV931ZGLbCqsCmovsPi
         dTRA==
X-Forwarded-Encrypted: i=1; AJvYcCWFZDvdmRnMgV4vrjZTJj6khcfZNU3J+V2KMbfl/+uSJnZfYixcM54AMSpW+ztRXryEikaxkLVOgwdkB8R76MuIQTyu
X-Gm-Message-State: AOJu0Yz8D9MpMgbNZXfA60q4tqB1YJNAFCBF/41Wc0+TymOuQpmMLH5u
	eKEZv4x+50FI129t67NyrloXvVhYc2rPoiWg+EhDsWMtnGsLxo4+OsIuq+r6ukFYcKg5Hzqy6nh
	9Tv8zM9cvzWBXKP5bRbkooCmICTVWw2Tw+pHP
X-Google-Smtp-Source: AGHT+IH8t2M2DMVwjLW4kXyGrb6A6dKbflECwb92r8/OA4742Y25rNlvsLh8zoe4Bh9Qu+yJPrq59bd7GQZlKHdk2sg=
X-Received: by 2002:a0d:c0c2:0:b0:5ff:4959:1da8 with SMTP id
 b185-20020a0dc0c2000000b005ff49591da8mr2853569ywd.50.1709232580410; Thu, 29
 Feb 2024 10:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
In-Reply-To: <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Feb 2024 13:49:29 -0500
Message-ID: <CAM0EoM=xk-hK7XCXQFcaDmMPkCcj+wba8JWKxWMF7M7B+tC6TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, dan.daly@intel.com, 
	andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:14=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> > This is the first patchset of two. In this patch we are submitting 15 w=
hich
> > cover the minimal viable P4 PNA architecture.
> >
> > __Description of these Patches__
> >
> > Patch #1 adds infrastructure for per-netns P4 actions that can be creat=
ed on
> > as need basis for the P4 program requirement. This patch makes a small =
incision
> > into act_api. Patches 2-4 are minimalist enablers for P4TC and have no
> > effect the classical tc action (example patch#2 just increases the size=
 of the
> > action names from 16->64B).
> > Patch 5 adds infrastructure support for preallocation of dynamic action=
s.
> >
> > The core P4TC code implements several P4 objects.
> > 1) Patch #6 introduces P4 data types which are consumed by the rest of =
the code
> > 2) Patch #7 introduces the templating API. i.e. CRUD commands for templ=
ates
> > 3) Patch #8 introduces the concept of templating Pipelines. i.e CRUD co=
mmands
> >    for P4 pipelines.
> > 4) Patch #9 introduces the action templates and associated CRUD command=
s.
> > 5) Patch #10 introduce the action runtime infrastructure.
> > 6) Patch #11 introduces the concept of P4 table templates and associate=
d
> >    CRUD commands for tables.
> > 7) Patch #12 introduces runtime table entry infra and associated CU com=
mands.
> > 8) Patch #13 introduces runtime table entry infra and associated RD com=
mands.
> > 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfunc.
> > 10) Patch #15 introduces the TC classifier P4 used at runtime.
> >
> > Daniel, please look again at patch #15.
> >
> > There are a few more patches (5) not in this patchset that deal with te=
st
> > cases, etc.
> >
> > What is P4?
> > -----------
> >
> > The Programming Protocol-independent Packet Processors (P4) is an open =
source,
> > domain-specific programming language for specifying data plane behavior=
.
> >
> > The current P4 landscape includes an extensive range of deployments, pr=
oducts,
> > projects and services, etc[9][12]. Two major NIC vendors, Intel[10] and=
 AMD[11]
> > currently offer P4-native NICs. P4 is currently curated by the Linux
> > Foundation[9].
> >
> > On why P4 - see small treatise here:[4].
> >
> > What is P4TC?
> > -------------
> >
> > P4TC is a net-namespace aware P4 implementation over TC; meaning, a P4 =
program
> > and its associated objects and state are attachend to a kernel _netns_ =
structure.
> > IOW, if we had two programs across netns' or within a netns they have n=
o
> > visibility to each others objects (unlike for example TC actions whose =
kinds are
> > "global" in nature or eBPF maps visavis bpftool).
> >
> > P4TC builds on top of many years of Linux TC experiences of a netlink c=
ontrol
> > path interface coupled with a software datapath with an equivalent offl=
oadable
> > hardware datapath. In this patch series we are focussing only on the s/=
w
> > datapath. The s/w and h/w path equivalence that TC provides is relevant
> > for a primary use case of P4 where some (currently) large consumers of =
NICs
> > provide vendors their datapath specs in P4. In such a case one could ge=
nerate
> > specified datapaths in s/w and test/validate the requirements before ha=
rdware
> > acquisition(example [12]).
> >
> > Unlike other approaches such as TC Flower which require kernel and user=
 space
> > changes when new datapath objects like packet headers are introduced P4=
TC, with
> > these patches, provides _kernel and user space code change independence=
_.
> > Meaning:
> > A P4 program describes headers, parsers, etc alongside the datapath pro=
cessing;
> > the compiler uses the P4 program as input and generates several artifac=
ts which
> > are then loaded into the kernel to manifest the intended datapath. In a=
ddition
> > to the generated datapath, control path constructs are generated. The p=
rocess is
> > described further below in "P4TC Workflow".
> >
> > There have been many discussions and meetings within the community sinc=
e
> > about 2015 in regards to P4 over TC[2] and we are finally proving to th=
e
> > naysayers that we do get stuff done!
> >
> > A lot more of the P4TC motivation is captured at:
> > https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
> >
> > __P4TC Architecture__
> >
> > The current architecture was described at netdevconf 0x17[14] and if yo=
u prefer
> > academic conference papers, a short paper is available here[15].
> >
> > There are 4 parts:
> >
> > 1) A Template CRUD provisioning API for manifesting a P4 program and it=
s
> > associated objects in the kernel. The template provisioning API uses ne=
tlink.
> > See patch in part 2.
> >
> > 2) A Runtime CRUD+ API code which is used for controlling the different=
 runtime
> > behavior of the P4 objects. The runtime API uses netlink. See notes fur=
ther
> > down. See patch description later..
> >
> > 3) P4 objects and their control interfaces: tables, actions, externs, e=
tc.
> > Any object that requires control plane interaction resides in the TC do=
main
> > and is subject to the CRUD runtime API.  The intended goal is to make u=
se of the
> > tc semantics of skip_sw/hw to target P4 program objects either in s/w o=
r h/w.
> >
> > 4) S/W Datapath code hooks. The s/w datapath is eBPF based and is gener=
ated
> > by a compiler based on the P4 spec. When accessing any P4 object that r=
equires
> > control plane interfaces, the eBPF code accesses the P4TC side from #3 =
above
> > using kfuncs.
> >
> > The generated eBPF code is derived from [13] with enhancements and fixe=
s to meet
> > our requirements.
> >
> > __P4TC Workflow__
> >
> > The Development and instantiation workflow for P4TC is as follows:
> >
> >   A) A developer writes a P4 program, "myprog"
> >
> >   B) Compiles it using the P4C compiler[8]. The compiler generates 3 ou=
tputs:
> >
> >      a) A shell script which form template definitions for the differen=
t P4
> >      objects "myprog" utilizes (tables, externs, actions etc). See #1 a=
bove..
> >
> >      b) the parser and the rest of the datapath are generated as eBPF a=
nd need
> >      to be compiled into binaries. At the moment the parser and the mai=
n control
> >      block are generated as separate eBPF program but this could change=
 in
> >      the future (without affecting any kernel code). See #4 above.
> >
> >      c) A json introspection file used for the control plane (by iprout=
e2/tc).
> >
> >   C) At this point the artifacts from #1,#4 could be handed to an opera=
tor
> >      (the operator could be the same person as the developer from #A, #=
B).
> >
> >      i) For the eBPF part, either the operator is handed an ebpf binary=
 or
> >      source which they compile at this point into a binary.
> >      The operator executes the shell script(s) to manifest the function=
al
> >      "myprog" into the kernel.
> >
> >      ii) The operator instantiates "myprog" pipeline via the tc P4 filt=
er
> >      to ingress/egress (depending on P4 arch) of one or more netdevs/po=
rts
> >      (illustrated below as "block 22").
> >
> >      Example instantion where the parser is a separate action:
> >        "tc filter add block 22 ingress protocol all prio 10 p4 pname my=
prog \
> >         action bpf obj $PARSER.o section p4tc/parse \
> >         action bpf obj $PROGNAME.o section p4tc/main"
> >
> > See individual patches in partc for more examples tc vs xdp etc. Also s=
ee
> > section on "challenges" (further below on this cover letter).
> >
> > Once "myprog" P4 program is instantiated one can start performing opera=
tions
> > on table entries and/or actions at runtime as described below.
> >
> > __P4TC Runtime Control Path__
> >
> > The control interface builds on past tc experience and tries to get thi=
ngs
> > right from the beginning (example filtering is separated from depending
> > on existing object TLVs and made generic); also the code is written in
> > such a way it is mostly lockless.
> >
> > The P4TC control interface, using netlink, provides what we call a CRUD=
PS
> > abstraction which stands for: Create, Read(get), Update, Delete, Subscr=
ibe,
> > Publish.  From a high level PoV the following describes a conformant hi=
gh level
> > API (both on netlink data model and code level):
> >
> >       Create(</path/to/object, DATA>+)
> >       Read(</path/to/object>, [optional filter])
> >       Update(</path/to/object>, DATA>+)
> >       Delete(</path/to/object>, [optional filter])
> >       Subscribe(</path/to/object>, [optional filter])
> >
> > Note, we _dont_ treat "dump" or "flush" as speacial. If "path/to/object=
" points
> > to a table then a "Delete" implies "flush" and a "Read" implies dump bu=
t if
> > it points to an entry (by specifying a key) then "Delete" implies delet=
ing
> > and entry and "Read" implies reading that single entry. It should be no=
ted that
> > both "Delete" and "Read" take an optional filter parameter. The filter =
can
> > define further refinements to what the control plane wants read or dele=
ted.
> > "Subscribe" uses built in netlink event management. It, as well, takes =
a filter
> > which can further refine what events get generated to the control plane=
 (taken
> > out of this patchset, to be re-added with consideration of [16]).
> >
> > Lets show some runtime samples:
> >
> > ..create an entry, if we match ip address 10.0.1.2 send packet out eno1
> >   tc p4ctrl create myprog/table/mytable \
> >    dstAddr 10.0.1.2/32 action send_to_port param port eno1
> >
> > ..Batch create entries
> >   tc p4ctrl create myprog/table/mytable \
> >   entry dstAddr 10.1.1.2/32  action send_to_port param port eno1 \
> >   entry dstAddr 10.1.10.2/32  action send_to_port param port eno10 \
> >   entry dstAddr 10.0.2.2/32  action send_to_port param port eno2
> >
> > ..Get an entry (note "read" is interchangeably used as "get" which is a=
 common
> >               semantic in tc):
> >   tc p4ctrl read myprog/table/mytable \
> >    dstAddr 10.0.2.2/32
> >
> > ..dump mytable
> >   tc p4ctrl read myprog/table/mytable
> >
> > ..dump mytable for all entries whose key fits within 10.1.0.0/16
> >   tc p4ctrl read myprog/table/mytable \
> >   filter key/myprog/mytable/dstAddr =3D 10.1.0.0/16
> >
> > ..dump all mytable entries which have an action send_to_port with param=
 "eno1"
> >   tc p4ctrl get myprog/table/mytable \
> >   filter param/act/myprog/send_to_port/port =3D "eno1"
> >
> > The filter expression is powerful, f.e you could say:
> >
> >   tc p4ctrl get myprog/table/mytable \
> >   filter param/act/myprog/send_to_port/port =3D "eno1" && \
> >          key/myprog/mytable/dstAddr =3D 10.1.0.0/16
> >
> > It also works on built in metadata, example in the following case dumpi=
ng
> > entries from mytable that have seen activity in the last 10 secs:
> >   tc p4ctrl get myprog/table/mytable \
> >   filter msecs_since < 10000
> >
> > Delete follows the same syntax as get/read, so for sake of brevity we w=
on't
> > show more example than how to flush mytable:
> >
> >   tc p4ctrl delete myprog/table/mytable
> >
> > Mystery question: How do we achieve iproute2-kernel independence and
> > how does "tc p4ctrl" as a cli know how to program the kernel given an
> > arbitrary command line as shown above? Answer(s): It queries the
> > compiler generated json file in "P4TC Workflow" #B.c above. The json fi=
le has
> > enough details to figure out that we have a program called "myprog" whi=
ch has a
> > table "mytable" that has a key name "dstAddr" which happens to be type =
ipv4
> > address prefix. The json file also provides details to show that the ta=
ble
> > "mytable" supports an action called "send_to_port" which accepts a para=
meter
> > "port" of type netdev (see the types patch for all supported P4 data ty=
pes).
> > All P4 components have names, IDs, and types - so this makes it very ea=
sy to map
> > into netlink.
> > Once user space tc/p4ctrl validates the human command input, it creates
> > standard binary netlink structures (TLVs etc) which are sent to the ker=
nel.
> > See the runtime table entry patch for more details.
> >
> > __P4TC Datapath__
> >
> > The P4TC s/w datapath execution is generated as eBPF. Any objects that =
require
> > control interfacing reside in the "P4TC domain" and are controlled via =
netlink
> > as described above. Per packet execution and state and even objects tha=
t do not
> > require control interfacing (like the P4 parser) are generated as eBPF.
> >
> > A packet arriving on s/w ingress of any of the ports on block 22 will f=
irst be
> > exercised via the (generated eBPF) parser component to extract the head=
ers (the
> > ip destination address in labelled "dstAddr" above).
> > The datapath then proceeds to use "dstAddr", table ID and pipeline ID
> > as a key to do a lookup in myprog's "mytable" which returns the action =
params
> > which are then used to execute the action in the eBPF datapath (eventua=
lly
> > sending out packets to eno1).
> > On a table miss, mytable's default miss action (not described) is execu=
ted.
> >
> > __Testing__
> >
> > Speaking of testing - we have 2-300 tdc test cases (which will be in th=
e
> > second patchset).
> > These tests are run on our CICD system on pull requests and after commi=
ts are
> > approved. The CICD does a lot of other tests (more since v2, thanks to =
Simon's
> > input)including:
> > checkpatch, sparse, smatch, coccinelle, 32 bit and 64 bit builds tested=
 on both
> > X86, ARM 64 and emulated BE via qemu s390. We trigger performance testi=
ng in the
> > CICD to catch performance regressions (currently only on the control pa=
th, but
> > in the future for the datapath).
> > Syzkaller runs 24/7 on dedicated hardware, originally we focussed only =
on memory
> > sanitizer but recently added support for concurrency sanitizer.
> > Before main releases we ensure each patch will compile on its own to he=
lp in
> > git bisect and run the xmas tree tool. We eventually put the code via c=
overity.
> >
> > In addition we are working on enabling a tool that will take a P4 progr=
am, run
> > it through the compiler, and generate permutations of traffic patterns =
via
> > symbolic execution that will test both positive and negative datapath c=
ode
> > paths. The test generator tool integration is still work in progress.
> > Also: We have other code that test parallelization etc which we are try=
ing to
> > find a fit for in the kernel tree's testing infra.
> >
> >
> > __References__
> >
> > [1]https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4=
WorkshopP4TC.pdf
> > [2]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#historical-pe=
rspective-for-p4tc
> > [3]https://2023p4workshop.sched.com/event/1KsAe/p4tc-linux-kernel-p4-im=
plementation-approaches-and-evaluation
> > [4]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#so-why-p4-and=
-how-does-p4-help-here
> > [5]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.c=
om/T/#mf59be7abc5df3473cff3879c8cc3e2369c0640a6
> > [6]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.c=
om/T/#m783cfd79e9d755cf0e7afc1a7d5404635a5b1919
> > [7]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.c=
om/T/#ma8c84df0f7043d17b98f3d67aab0f4904c600469
> > [8]https://github.com/p4lang/p4c/tree/main/backends/tc
> > [9]https://p4.org/
> > [10]https://www.intel.com/content/www/us/en/products/details/network-io=
/ipu/e2000-asic.html
> > [11]https://www.amd.com/en/accelerators/pensando
> > [12]https://github.com/sonic-net/DASH/tree/main
> > [13]https://github.com/p4lang/p4c/tree/main/backends/ebpf
> > [14]https://netdevconf.info/0x17/sessions/talk/integrating-ebpf-into-th=
e-p4tc-datapath.html
> > [15]https://dl.acm.org/doi/10.1145/3630047.3630193
> > [16]https://lore.kernel.org/netdev/20231216123001.1293639-1-jiri@resnul=
li.us/
> > [17.a]https://netdevconf.info/0x13/session.html?talk-tc-u-classifier
> > [17.b]man tc-u32
> > [18]man tc-pedit
> > [19] https://lore.kernel.org/netdev/20231219181623.3845083-6-victor@moj=
atatu.com/T/#m86e71743d1d83b728bb29d5b877797cb4942e835
> > [20.a] https://netdevconf.info/0x16/sessions/talk/your-network-datapath=
-will-be-p4-scripted.html
> > [20.b] https://netdevconf.info/0x16/sessions/workshop/p4tc-workshop.htm=
l
> >
> > --------
> > HISTORY
> > --------
> >
> > Changes in Version 12
> > ----------------------
> >
> > 0) Introduce back 15 patches (v11 had 5)
> >
> > 1) From discussions with Daniel:
> >    i) Remove the XDP programs association alltogether. No refcounting. =
nothing.
> >    ii) Remove prog type tc - everything is now an ebpf tc action.
> >
> > 2) s/PAD0/__pad0/g. Thanks to Marcelo.
> >
> > 3) Add extack to specify how many entries (N of M) specified in a batch=
 for
> >    any of requested Create/Update/Delete succeeded. Prior to this it wo=
uld
> >    only tell us the batch failed to complete without giving us details =
of
> >    which of M failed. Added as a debug aid.
> >
> > Changes in Version 11
> > ----------------------
> > 1) Split the series into two. Original patches 1-5 in this patchset. Th=
e rest
> >    will go out after this is merged.
> >
> > 2) Change any references of IFNAMSIZ in the action code when referencin=
g the
> >    action name size to ACTNAMSIZ. Thanks to Marcelo.
> >
> > Changes in Version 10
> > ----------------------
> > 1) A couple of patches from the earlier version were clean enough to su=
bmit,
> >    so we did. This gave us room to split the two largest patches each i=
nto
> >    two. Even though the split is not git-bisactable and really some of =
it didn't
> >    make much sense (eg spliting a create, and update in one patch and d=
elete and
> >    get into another) we made sure each of the split patches compiled
> >    independently. The idea is to reduce the number of lines of code to =
review
> >    and when we get sufficient reviews we will put the splits together a=
gain.
> >    See patch #12 and #13 as well as patches #7 and #8).
> >
> > 2) Add more context in patch 0. Please READ!
> >
> > 3) Added dump/delete filters back to the code - we had taken them out i=
n the
> >    earlier patches to reduce the amount of code for review - but in ret=
rospect
> >    we feel they are important enough to push earlier rather than later.
> >
> >
> > Changes In version 9
> > ---------------------
> >
> > 1) Remove the largest patch (externs) to ease review.
> >
> > 2) Break up action patches into two to ease review bringing down the pa=
tches
> >    that need more scrutiny to 8 (the first 7 are almost trivial).
> >
> > 3) Fixup prefix naming convention to p4tc_xxx for uapi and p4a_xxx for =
actions
> >    to provide consistency(Jiri).
> >
> > 4) Silence sparse warning "was not declared. Should it be static?" for =
kfuncs
> >    by making them static. TBH, not sure if this is the right solution
> >    but it makes sparse happy and hopefully someone will comment.
> >
> > Changes In Version 8
> > ---------------------
> >
> > 1) Fix all the patchwork warnings and improve our ci to catch them in t=
he future
> >
> > 2) Reduce the number of patches to basic max(15)  to ease review.
> >
> > Changes In Version 7
> > -------------------------
> >
> > 0) First time removing the RFC tag!
> >
> > 1) Removed XDP cookie. It turns out as was pointed out by Toke(Thanks!)=
 - that
> > using bpf links was sufficient to protect us from someone replacing or =
deleting
> > a eBPF program after it has been bound to a netdev.
> >
> > 2) Add some reviewed-bys from Vlad.
> >
> > 3) Small bug fixes from v6 based on testing for ebpf.
> >
> > 4) Added the counter extern as a sample extern. Illustrating this examp=
le because
> >    it is slightly complex since it is possible to invoke it directly fr=
om
> >    the P4TC domain (in case of direct counters) or from eBPF (indirect =
counters).
> >    It is not exactly the most efficient implementation (a reasonable co=
unter impl
> >    should be per-cpu).
> >
> > Changes In RFC Version 6
> > -------------------------
> >
> > 1) Completed integration from scriptable view to eBPF. Completed integr=
ation
> >    of externs integration.
> >
> > 2) Small bug fixes from v5 based on testing.
> >
> > Changes In RFC Version 5
> > -------------------------
> >
> > 1) More integration from scriptable view to eBPF. Small bug fixes from =
last
> >    integration.
> >
> > 2) More streamlining support of externs via kfunc (create-on-miss, etc)
> >
> > 3) eBPF linking for XDP.
> >
> > There is more eBPF integration/streamlining coming (we are getting clos=
e to
> > conversion from scriptable domain).
> >
> > Changes In RFC Version 4
> > -------------------------
> >
> > 1) More integration from scriptable to eBPF. Small bug fixes.
> >
> > 2) More streamlining support of externs via kfunc (one additional kfunc=
).
> >
> > 3) Removed per-cpu scratchpad per Toke's suggestion and instead use XDP=
 metadata.
> >
> > There is more eBPF integration coming. One thing we looked at but is no=
t in this
> > patchset but should be in the next is use of eBPF link in our loading (=
see
> > "challenge #1" further below).
> >
> > Changes In RFC Version 3
> > -------------------------
> >
> > These patches are still in a little bit of flux as we adjust to integra=
ting
> > eBPF. So there are small constructs that are used in V1 and 2 but no lo=
nger
> > used in this version. We will make a V4 which will remove those.
> > The changes from V2 are as follows:
> >
> > 1) Feedback we got in V2 is to try stick to one of the two modes. In th=
is version
> > we are taking one more step and going the path of mode2 vs v2 where we =
had 2 modes.
> >
> > 2) The P4 Register extern is no longer standalone. Instead, as part of =
integrating
> > into eBPF we introduce another kfunc which encapsulates Register as par=
t of the
> > extern interface.
> >
> > 3) We have improved our CICD to include tools pointed to us by Simon. S=
ee
> >    "Testing" further below. Thanks to Simon for that and other issues h=
e caught.
> >    Simon, we discussed on issue [7] but decided to keep that log since =
we think
> >    it is useful.
> >
> > 4) A lot of small cleanups. Thanks Marcelo. There are two things we nee=
d to
> >    re-discuss though; see: [5], [6].
> >
> > 5) We removed the need for a range of IDs for dynamic actions. Thanks J=
akub.
> >
> > 6) Clarify ambiguity caused by smatch in an if(A) else if(B) condition.=
 We are
> >    guaranteed that either A or B must exist; however, lets make smatch =
happy.
> >    Thanks to Simon and Dan Carpenter.
> >
> > Changes In RFC Version 2
> > -------------------------
> >
> > Version 2 is the initial integration of the eBPF datapath.
> > We took into consideration suggestions provided to use eBPF and put eff=
ort into
> > analyzing eBPF as datapath which involved extensive testing.
> > We implemented 6 approaches with eBPF and ran performance analysis and =
presented
> > our results at the P4 2023 workshop in Santa Clara[see: 1, 3] on each o=
f the 6
> > vs the scriptable P4TC and concluded that 2 of the approaches are sensi=
ble (4 if
> > you account for XDP or TC separately).
> >
> > Conclusions from the exercise: We lose the simple operational model we =
had
> > prior to integrating eBPF. We do gain performance in most cases when th=
e
> > datapath is less compute-bound.
> > For more discussion on our requirements vs journeying the eBPF path ple=
ase
> > scroll down to "Restating Our Requirements" and "Challenges".
> >
> > This patch set presented two modes.
> > mode1: the parser is entirely based on eBPF - whereas the rest of the
> > SW datapath stays as _scriptable_ as in Version 1.
> > mode2: All of the kernel s/w datapath (including parser) is in eBPF.
> >
> > The key ingredient for eBPF, that we did not have access to in the past=
, is
> > kfunc (it made a big difference for us to reconsider eBPF).
> >
> > In V2 the two modes are mutually exclusive (IOW, you get to choose one
> > or the other via Kconfig).
>
> I think/fear that this series has a "quorum" problem: different voices
> raises opposition, and nobody (?) outside the authors supported the
> code and the feature.
>
> Could be the missing of H/W offload support in the current form the
> root cause for such lack support? Or there are parties interested that
> have been quite so far?

Some of the people who attend our meetings and have vested interest in
this are on Cc.  But the cover letter is clear on this (right at the
top under "What is P4" and "what is P4TC").

cheers,
jamal


> Thanks,
>
> Paolo
>
>

