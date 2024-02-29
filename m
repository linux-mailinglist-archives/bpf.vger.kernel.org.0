Return-Path: <bpf+bounces-23061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314386D04A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0FD1F22B04
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C58692F6;
	Thu, 29 Feb 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D26JqGcT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D614AECD
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226849; cv=none; b=JyjSk1bRata979h96efRik9HczV77Q1heEYt979i0pL7iEwiSDbew017nkDgqAK0IxBYsSrfdTGAowXYOb7XZvtvVsTNHeC7XQP6gRRPGJGi3lPs+tl/Buu/Elk1ZlggRN7tLHdD36BiiWByiAZVvMWQlMgaZZQ6bzvJsRRtfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226849; c=relaxed/simple;
	bh=hEcpq9GpSHc+agWRDwsMsrTPJ3Q9M3SyxvROUonocIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEyXf0cOusjVxwVxdD7F1d9wpaQB5GwI9bNbqKv1xtOfIGSAlF6O1Lnc5p08V+B/RMKcxKK2y9S6IwTzbF38sQOTFixj+YW+MExU/OpDf8+V6sIE5Br1PX46KoTVYfn0MIhy8f43jVgJ1Xhv9h+pbbn4KFM+KLOV57veRO1AGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D26JqGcT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709226845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IjycMAwZ4TBgZUzsl0cp/M+mw7CNkhw3/QXm6DG5Pd0=;
	b=D26JqGcTuLb/PWidYJH/STzYnJSgsa0RlAR2Ve4hKAT7MYFdY/mDj2LGu9fsVt2kqms5P+
	sy5Mpf6QcC777ynlcvmmAcp+efgZRFXjNCi7i6fvqB/nsoswx/w7m2kN0jdBD5sufjhVIi
	7B6A+3KI3fH4K5fuxYOOijWgqiFKdxg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-EPT0_Es2M46ML1vILfFIzA-1; Thu, 29 Feb 2024 12:14:03 -0500
X-MC-Unique: EPT0_Es2M46ML1vILfFIzA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512fbbd8dfcso167822e87.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 09:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226842; x=1709831642;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjycMAwZ4TBgZUzsl0cp/M+mw7CNkhw3/QXm6DG5Pd0=;
        b=vojkcTquiRhTI6K8vHh1EP1S0UbojBW2mXFvOcLEgwLy2j+PWflor0ECuf+l6NGVQV
         /lK8Y9rdJix8nWBPH3MPA25611PItwQqYWmDNl0Y8vpIOXdgpbbdV8C/5uhlWZa9wO+Y
         M0wGM93UKBeR7WkxZTdiHwLPMAvDgx7Qo7KCVCQPvzT4yFqAD26jn4MznRJwKnyZklCD
         KD8dmjTgSisrsKRrOC7P1M0UCyGftghIyXWrG8DoayzyLcNzRvhZpPiiN4BLg+4SunZ7
         D+zZ5WzF8draxzVPARVsS/sFS8lMYza/pzfEHoBR7UtG9M7m/3WIxHeqPXnFMTZqAzVX
         Qosg==
X-Forwarded-Encrypted: i=1; AJvYcCUbySvkaBCRkUeGuo1fAQeJUr7fnGNaMT/m436vKoedg6fyw1jDXqUu/ORBjsqd1doTqTdfdYYoLqqO00zgQ9ETfPg5
X-Gm-Message-State: AOJu0YznDg6owE2Nt5rDv12yaNxk6xNk9wwuWZZqy41jiI1dNlpVE35v
	BGecT39kFzwHg5QZqoXhN89xdRb+DxVR3B+9HyVoHm+pAeKAs1GfYi+R4YUssTCl1QgIMAN8ODt
	Uo2X9PuheqVuB630iza3OJLFTmDyFEjJfORyiiMi0Q7vLvrT4kg==
X-Received: by 2002:a2e:9691:0:b0:2d2:3178:6b5b with SMTP id q17-20020a2e9691000000b002d231786b5bmr1721429lji.3.1709226842033;
        Thu, 29 Feb 2024 09:14:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBiVxr1dMecGZVx5wvxt1CI9By35I6oCMXZXGYDDzHdDWhiv9px6L8gA+0xMp9TpDOMH2Awg==
X-Received: by 2002:a2e:9691:0:b0:2d2:3178:6b5b with SMTP id q17-20020a2e9691000000b002d231786b5bmr1721401lji.3.1709226841392;
        Thu, 29 Feb 2024 09:14:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b00410bca333b7sm5670546wmz.27.2024.02.29.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:14:00 -0800 (PST)
Message-ID: <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
 khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com,  pctammela@mojatatu.com, dan.daly@intel.com,
 andy.fingerhut@gmail.com,  chris.sommers@keysight.com, mattyk@nvidia.com,
 bpf@vger.kernel.org
Date: Thu, 29 Feb 2024 18:13:58 +0100
In-Reply-To: <20240225165447.156954-1-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> This is the first patchset of two. In this patch we are submitting 15 whi=
ch
> cover the minimal viable P4 PNA architecture.
>=20
> __Description of these Patches__
>=20
> Patch #1 adds infrastructure for per-netns P4 actions that can be created=
 on
> as need basis for the P4 program requirement. This patch makes a small in=
cision
> into act_api. Patches 2-4 are minimalist enablers for P4TC and have no
> effect the classical tc action (example patch#2 just increases the size o=
f the
> action names from 16->64B).
> Patch 5 adds infrastructure support for preallocation of dynamic actions.
>=20
> The core P4TC code implements several P4 objects.
> 1) Patch #6 introduces P4 data types which are consumed by the rest of th=
e code
> 2) Patch #7 introduces the templating API. i.e. CRUD commands for templat=
es
> 3) Patch #8 introduces the concept of templating Pipelines. i.e CRUD comm=
ands
>    for P4 pipelines.
> 4) Patch #9 introduces the action templates and associated CRUD commands.
> 5) Patch #10 introduce the action runtime infrastructure.
> 6) Patch #11 introduces the concept of P4 table templates and associated
>    CRUD commands for tables.
> 7) Patch #12 introduces runtime table entry infra and associated CU comma=
nds.
> 8) Patch #13 introduces runtime table entry infra and associated RD comma=
nds.
> 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfunc.
> 10) Patch #15 introduces the TC classifier P4 used at runtime.
>=20
> Daniel, please look again at patch #15.
>=20
> There are a few more patches (5) not in this patchset that deal with test
> cases, etc.
>=20
> What is P4?
> -----------
>=20
> The Programming Protocol-independent Packet Processors (P4) is an open so=
urce,
> domain-specific programming language for specifying data plane behavior.
>=20
> The current P4 landscape includes an extensive range of deployments, prod=
ucts,
> projects and services, etc[9][12]. Two major NIC vendors, Intel[10] and A=
MD[11]
> currently offer P4-native NICs. P4 is currently curated by the Linux
> Foundation[9].
>=20
> On why P4 - see small treatise here:[4].
>=20
> What is P4TC?
> -------------
>=20
> P4TC is a net-namespace aware P4 implementation over TC; meaning, a P4 pr=
ogram
> and its associated objects and state are attachend to a kernel _netns_ st=
ructure.
> IOW, if we had two programs across netns' or within a netns they have no
> visibility to each others objects (unlike for example TC actions whose ki=
nds are
> "global" in nature or eBPF maps visavis bpftool).
>=20
> P4TC builds on top of many years of Linux TC experiences of a netlink con=
trol
> path interface coupled with a software datapath with an equivalent offloa=
dable
> hardware datapath. In this patch series we are focussing only on the s/w
> datapath. The s/w and h/w path equivalence that TC provides is relevant
> for a primary use case of P4 where some (currently) large consumers of NI=
Cs
> provide vendors their datapath specs in P4. In such a case one could gene=
rate
> specified datapaths in s/w and test/validate the requirements before hard=
ware
> acquisition(example [12]).
>=20
> Unlike other approaches such as TC Flower which require kernel and user s=
pace
> changes when new datapath objects like packet headers are introduced P4TC=
, with
> these patches, provides _kernel and user space code change independence_.
> Meaning:
> A P4 program describes headers, parsers, etc alongside the datapath proce=
ssing;
> the compiler uses the P4 program as input and generates several artifacts=
 which
> are then loaded into the kernel to manifest the intended datapath. In add=
ition
> to the generated datapath, control path constructs are generated. The pro=
cess is
> described further below in "P4TC Workflow".
>=20
> There have been many discussions and meetings within the community since
> about 2015 in regards to P4 over TC[2] and we are finally proving to the
> naysayers that we do get stuff done!
>=20
> A lot more of the P4TC motivation is captured at:
> https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
>=20
> __P4TC Architecture__
>=20
> The current architecture was described at netdevconf 0x17[14] and if you =
prefer
> academic conference papers, a short paper is available here[15].
>=20
> There are 4 parts:
>=20
> 1) A Template CRUD provisioning API for manifesting a P4 program and its
> associated objects in the kernel. The template provisioning API uses netl=
ink.
> See patch in part 2.
>=20
> 2) A Runtime CRUD+ API code which is used for controlling the different r=
untime
> behavior of the P4 objects. The runtime API uses netlink. See notes furth=
er
> down. See patch description later..
>=20
> 3) P4 objects and their control interfaces: tables, actions, externs, etc=
.
> Any object that requires control plane interaction resides in the TC doma=
in
> and is subject to the CRUD runtime API.  The intended goal is to make use=
 of the
> tc semantics of skip_sw/hw to target P4 program objects either in s/w or =
h/w.
>=20
> 4) S/W Datapath code hooks. The s/w datapath is eBPF based and is generat=
ed
> by a compiler based on the P4 spec. When accessing any P4 object that req=
uires
> control plane interfaces, the eBPF code accesses the P4TC side from #3 ab=
ove
> using kfuncs.
>=20
> The generated eBPF code is derived from [13] with enhancements and fixes =
to meet
> our requirements.
>=20
> __P4TC Workflow__
>=20
> The Development and instantiation workflow for P4TC is as follows:
>=20
>   A) A developer writes a P4 program, "myprog"
>=20
>   B) Compiles it using the P4C compiler[8]. The compiler generates 3 outp=
uts:
>=20
>      a) A shell script which form template definitions for the different =
P4
>      objects "myprog" utilizes (tables, externs, actions etc). See #1 abo=
ve..
>=20
>      b) the parser and the rest of the datapath are generated as eBPF and=
 need
>      to be compiled into binaries. At the moment the parser and the main =
control
>      block are generated as separate eBPF program but this could change i=
n
>      the future (without affecting any kernel code). See #4 above.
>=20
>      c) A json introspection file used for the control plane (by iproute2=
/tc).
>=20
>   C) At this point the artifacts from #1,#4 could be handed to an operato=
r
>      (the operator could be the same person as the developer from #A, #B)=
.
>=20
>      i) For the eBPF part, either the operator is handed an ebpf binary o=
r
>      source which they compile at this point into a binary.
>      The operator executes the shell script(s) to manifest the functional
>      "myprog" into the kernel.
>=20
>      ii) The operator instantiates "myprog" pipeline via the tc P4 filter
>      to ingress/egress (depending on P4 arch) of one or more netdevs/port=
s
>      (illustrated below as "block 22").
>=20
>      Example instantion where the parser is a separate action:
>        "tc filter add block 22 ingress protocol all prio 10 p4 pname mypr=
og \
>         action bpf obj $PARSER.o section p4tc/parse \
>         action bpf obj $PROGNAME.o section p4tc/main"
>=20
> See individual patches in partc for more examples tc vs xdp etc. Also see
> section on "challenges" (further below on this cover letter).
>=20
> Once "myprog" P4 program is instantiated one can start performing operati=
ons
> on table entries and/or actions at runtime as described below.
>=20
> __P4TC Runtime Control Path__
>=20
> The control interface builds on past tc experience and tries to get thing=
s
> right from the beginning (example filtering is separated from depending
> on existing object TLVs and made generic); also the code is written in
> such a way it is mostly lockless.
>=20
> The P4TC control interface, using netlink, provides what we call a CRUDPS
> abstraction which stands for: Create, Read(get), Update, Delete, Subscrib=
e,
> Publish.  From a high level PoV the following describes a conformant high=
 level
> API (both on netlink data model and code level):
>=20
> 	Create(</path/to/object, DATA>+)
> 	Read(</path/to/object>, [optional filter])
> 	Update(</path/to/object>, DATA>+)
> 	Delete(</path/to/object>, [optional filter])
> 	Subscribe(</path/to/object>, [optional filter])
>=20
> Note, we _dont_ treat "dump" or "flush" as speacial. If "path/to/object" =
points
> to a table then a "Delete" implies "flush" and a "Read" implies dump but =
if
> it points to an entry (by specifying a key) then "Delete" implies deletin=
g
> and entry and "Read" implies reading that single entry. It should be note=
d that
> both "Delete" and "Read" take an optional filter parameter. The filter ca=
n
> define further refinements to what the control plane wants read or delete=
d.
> "Subscribe" uses built in netlink event management. It, as well, takes a =
filter
> which can further refine what events get generated to the control plane (=
taken
> out of this patchset, to be re-added with consideration of [16]).
>=20
> Lets show some runtime samples:
>=20
> ..create an entry, if we match ip address 10.0.1.2 send packet out eno1
>   tc p4ctrl create myprog/table/mytable \
>    dstAddr 10.0.1.2/32 action send_to_port param port eno1
>=20
> ..Batch create entries
>   tc p4ctrl create myprog/table/mytable \
>   entry dstAddr 10.1.1.2/32  action send_to_port param port eno1 \
>   entry dstAddr 10.1.10.2/32  action send_to_port param port eno10 \
>   entry dstAddr 10.0.2.2/32  action send_to_port param port eno2
>=20
> ..Get an entry (note "read" is interchangeably used as "get" which is a c=
ommon
> 		semantic in tc):
>   tc p4ctrl read myprog/table/mytable \
>    dstAddr 10.0.2.2/32
>=20
> ..dump mytable
>   tc p4ctrl read myprog/table/mytable
>=20
> ..dump mytable for all entries whose key fits within 10.1.0.0/16
>   tc p4ctrl read myprog/table/mytable \
>   filter key/myprog/mytable/dstAddr =3D 10.1.0.0/16
>=20
> ..dump all mytable entries which have an action send_to_port with param "=
eno1"
>   tc p4ctrl get myprog/table/mytable \
>   filter param/act/myprog/send_to_port/port =3D "eno1"
>=20
> The filter expression is powerful, f.e you could say:
>=20
>   tc p4ctrl get myprog/table/mytable \
>   filter param/act/myprog/send_to_port/port =3D "eno1" && \
>          key/myprog/mytable/dstAddr =3D 10.1.0.0/16
>=20
> It also works on built in metadata, example in the following case dumping
> entries from mytable that have seen activity in the last 10 secs:
>   tc p4ctrl get myprog/table/mytable \
>   filter msecs_since < 10000
>=20
> Delete follows the same syntax as get/read, so for sake of brevity we won=
't
> show more example than how to flush mytable:
>=20
>   tc p4ctrl delete myprog/table/mytable
>=20
> Mystery question: How do we achieve iproute2-kernel independence and
> how does "tc p4ctrl" as a cli know how to program the kernel given an
> arbitrary command line as shown above? Answer(s): It queries the
> compiler generated json file in "P4TC Workflow" #B.c above. The json file=
 has
> enough details to figure out that we have a program called "myprog" which=
 has a
> table "mytable" that has a key name "dstAddr" which happens to be type ip=
v4
> address prefix. The json file also provides details to show that the tabl=
e
> "mytable" supports an action called "send_to_port" which accepts a parame=
ter
> "port" of type netdev (see the types patch for all supported P4 data type=
s).
> All P4 components have names, IDs, and types - so this makes it very easy=
 to map
> into netlink.
> Once user space tc/p4ctrl validates the human command input, it creates
> standard binary netlink structures (TLVs etc) which are sent to the kerne=
l.
> See the runtime table entry patch for more details.
>=20
> __P4TC Datapath__
>=20
> The P4TC s/w datapath execution is generated as eBPF. Any objects that re=
quire
> control interfacing reside in the "P4TC domain" and are controlled via ne=
tlink
> as described above. Per packet execution and state and even objects that =
do not
> require control interfacing (like the P4 parser) are generated as eBPF.
>=20
> A packet arriving on s/w ingress of any of the ports on block 22 will fir=
st be
> exercised via the (generated eBPF) parser component to extract the header=
s (the
> ip destination address in labelled "dstAddr" above).
> The datapath then proceeds to use "dstAddr", table ID and pipeline ID
> as a key to do a lookup in myprog's "mytable" which returns the action pa=
rams
> which are then used to execute the action in the eBPF datapath (eventuall=
y
> sending out packets to eno1).
> On a table miss, mytable's default miss action (not described) is execute=
d.
>=20
> __Testing__
>=20
> Speaking of testing - we have 2-300 tdc test cases (which will be in the
> second patchset).
> These tests are run on our CICD system on pull requests and after commits=
 are
> approved. The CICD does a lot of other tests (more since v2, thanks to Si=
mon's
> input)including:
> checkpatch, sparse, smatch, coccinelle, 32 bit and 64 bit builds tested o=
n both
> X86, ARM 64 and emulated BE via qemu s390. We trigger performance testing=
 in the
> CICD to catch performance regressions (currently only on the control path=
, but
> in the future for the datapath).
> Syzkaller runs 24/7 on dedicated hardware, originally we focussed only on=
 memory
> sanitizer but recently added support for concurrency sanitizer.
> Before main releases we ensure each patch will compile on its own to help=
 in
> git bisect and run the xmas tree tool. We eventually put the code via cov=
erity.
>=20
> In addition we are working on enabling a tool that will take a P4 program=
, run
> it through the compiler, and generate permutations of traffic patterns vi=
a
> symbolic execution that will test both positive and negative datapath cod=
e
> paths. The test generator tool integration is still work in progress.
> Also: We have other code that test parallelization etc which we are tryin=
g to
> find a fit for in the kernel tree's testing infra.
>=20
>=20
> __References__
>=20
> [1]https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4Wo=
rkshopP4TC.pdf
> [2]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#historical-pers=
pective-for-p4tc
> [3]https://2023p4workshop.sched.com/event/1KsAe/p4tc-linux-kernel-p4-impl=
ementation-approaches-and-evaluation
> [4]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#so-why-p4-and-h=
ow-does-p4-help-here
> [5]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com=
/T/#mf59be7abc5df3473cff3879c8cc3e2369c0640a6
> [6]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com=
/T/#m783cfd79e9d755cf0e7afc1a7d5404635a5b1919
> [7]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com=
/T/#ma8c84df0f7043d17b98f3d67aab0f4904c600469
> [8]https://github.com/p4lang/p4c/tree/main/backends/tc
> [9]https://p4.org/
> [10]https://www.intel.com/content/www/us/en/products/details/network-io/i=
pu/e2000-asic.html
> [11]https://www.amd.com/en/accelerators/pensando
> [12]https://github.com/sonic-net/DASH/tree/main
> [13]https://github.com/p4lang/p4c/tree/main/backends/ebpf
> [14]https://netdevconf.info/0x17/sessions/talk/integrating-ebpf-into-the-=
p4tc-datapath.html
> [15]https://dl.acm.org/doi/10.1145/3630047.3630193
> [16]https://lore.kernel.org/netdev/20231216123001.1293639-1-jiri@resnulli=
.us/
> [17.a]https://netdevconf.info/0x13/session.html?talk-tc-u-classifier
> [17.b]man tc-u32
> [18]man tc-pedit
> [19] https://lore.kernel.org/netdev/20231219181623.3845083-6-victor@mojat=
atu.com/T/#m86e71743d1d83b728bb29d5b877797cb4942e835
> [20.a] https://netdevconf.info/0x16/sessions/talk/your-network-datapath-w=
ill-be-p4-scripted.html
> [20.b] https://netdevconf.info/0x16/sessions/workshop/p4tc-workshop.html
>=20
> --------
> HISTORY
> --------
>=20
> Changes in Version 12
> ----------------------
>=20
> 0) Introduce back 15 patches (v11 had 5)
>=20
> 1) From discussions with Daniel:
>    i) Remove the XDP programs association alltogether. No refcounting. no=
thing.
>    ii) Remove prog type tc - everything is now an ebpf tc action.
>=20
> 2) s/PAD0/__pad0/g. Thanks to Marcelo.
>=20
> 3) Add extack to specify how many entries (N of M) specified in a batch f=
or
>    any of requested Create/Update/Delete succeeded. Prior to this it woul=
d
>    only tell us the batch failed to complete without giving us details of
>    which of M failed. Added as a debug aid.
>=20
> Changes in Version 11
> ----------------------
> 1) Split the series into two. Original patches 1-5 in this patchset. The =
rest
>    will go out after this is merged.
>=20
> 2) Change any references of IFNAMSIZ in the action code when referencing =
the
>    action name size to ACTNAMSIZ. Thanks to Marcelo.
>=20
> Changes in Version 10
> ----------------------
> 1) A couple of patches from the earlier version were clean enough to subm=
it,
>    so we did. This gave us room to split the two largest patches each int=
o
>    two. Even though the split is not git-bisactable and really some of it=
 didn't
>    make much sense (eg spliting a create, and update in one patch and del=
ete and
>    get into another) we made sure each of the split patches compiled
>    independently. The idea is to reduce the number of lines of code to re=
view
>    and when we get sufficient reviews we will put the splits together aga=
in.
>    See patch #12 and #13 as well as patches #7 and #8).
>=20
> 2) Add more context in patch 0. Please READ!
>=20
> 3) Added dump/delete filters back to the code - we had taken them out in =
the
>    earlier patches to reduce the amount of code for review - but in retro=
spect
>    we feel they are important enough to push earlier rather than later.
>=20
>=20
> Changes In version 9
> ---------------------
>=20
> 1) Remove the largest patch (externs) to ease review.
>=20
> 2) Break up action patches into two to ease review bringing down the patc=
hes
>    that need more scrutiny to 8 (the first 7 are almost trivial).
>=20
> 3) Fixup prefix naming convention to p4tc_xxx for uapi and p4a_xxx for ac=
tions
>    to provide consistency(Jiri).
>=20
> 4) Silence sparse warning "was not declared. Should it be static?" for kf=
uncs
>    by making them static. TBH, not sure if this is the right solution
>    but it makes sparse happy and hopefully someone will comment.
>=20
> Changes In Version 8
> ---------------------
>=20
> 1) Fix all the patchwork warnings and improve our ci to catch them in the=
 future
>=20
> 2) Reduce the number of patches to basic max(15)  to ease review.
>=20
> Changes In Version 7
> -------------------------
>=20
> 0) First time removing the RFC tag!
>=20
> 1) Removed XDP cookie. It turns out as was pointed out by Toke(Thanks!) -=
 that
> using bpf links was sufficient to protect us from someone replacing or de=
leting
> a eBPF program after it has been bound to a netdev.
>=20
> 2) Add some reviewed-bys from Vlad.
>=20
> 3) Small bug fixes from v6 based on testing for ebpf.
>=20
> 4) Added the counter extern as a sample extern. Illustrating this example=
 because
>    it is slightly complex since it is possible to invoke it directly from
>    the P4TC domain (in case of direct counters) or from eBPF (indirect co=
unters).
>    It is not exactly the most efficient implementation (a reasonable coun=
ter impl
>    should be per-cpu).
>=20
> Changes In RFC Version 6
> -------------------------
>=20
> 1) Completed integration from scriptable view to eBPF. Completed integrat=
ion
>    of externs integration.
>=20
> 2) Small bug fixes from v5 based on testing.
>=20
> Changes In RFC Version 5
> -------------------------
>=20
> 1) More integration from scriptable view to eBPF. Small bug fixes from la=
st
>    integration.
>=20
> 2) More streamlining support of externs via kfunc (create-on-miss, etc)
>=20
> 3) eBPF linking for XDP.
>=20
> There is more eBPF integration/streamlining coming (we are getting close =
to
> conversion from scriptable domain).
>=20
> Changes In RFC Version 4
> -------------------------
>=20
> 1) More integration from scriptable to eBPF. Small bug fixes.
>=20
> 2) More streamlining support of externs via kfunc (one additional kfunc).
>=20
> 3) Removed per-cpu scratchpad per Toke's suggestion and instead use XDP m=
etadata.
>=20
> There is more eBPF integration coming. One thing we looked at but is not =
in this
> patchset but should be in the next is use of eBPF link in our loading (se=
e
> "challenge #1" further below).
>=20
> Changes In RFC Version 3
> -------------------------
>=20
> These patches are still in a little bit of flux as we adjust to integrati=
ng
> eBPF. So there are small constructs that are used in V1 and 2 but no long=
er
> used in this version. We will make a V4 which will remove those.
> The changes from V2 are as follows:
>=20
> 1) Feedback we got in V2 is to try stick to one of the two modes. In this=
 version
> we are taking one more step and going the path of mode2 vs v2 where we ha=
d 2 modes.
>=20
> 2) The P4 Register extern is no longer standalone. Instead, as part of in=
tegrating
> into eBPF we introduce another kfunc which encapsulates Register as part =
of the
> extern interface.
>=20
> 3) We have improved our CICD to include tools pointed to us by Simon. See
>    "Testing" further below. Thanks to Simon for that and other issues he =
caught.
>    Simon, we discussed on issue [7] but decided to keep that log since we=
 think
>    it is useful.
>=20
> 4) A lot of small cleanups. Thanks Marcelo. There are two things we need =
to
>    re-discuss though; see: [5], [6].
>=20
> 5) We removed the need for a range of IDs for dynamic actions. Thanks Jak=
ub.
>=20
> 6) Clarify ambiguity caused by smatch in an if(A) else if(B) condition. W=
e are
>    guaranteed that either A or B must exist; however, lets make smatch ha=
ppy.
>    Thanks to Simon and Dan Carpenter.
>=20
> Changes In RFC Version 2
> -------------------------
>=20
> Version 2 is the initial integration of the eBPF datapath.
> We took into consideration suggestions provided to use eBPF and put effor=
t into
> analyzing eBPF as datapath which involved extensive testing.
> We implemented 6 approaches with eBPF and ran performance analysis and pr=
esented
> our results at the P4 2023 workshop in Santa Clara[see: 1, 3] on each of =
the 6
> vs the scriptable P4TC and concluded that 2 of the approaches are sensibl=
e (4 if
> you account for XDP or TC separately).
>=20
> Conclusions from the exercise: We lose the simple operational model we ha=
d
> prior to integrating eBPF. We do gain performance in most cases when the
> datapath is less compute-bound.
> For more discussion on our requirements vs journeying the eBPF path pleas=
e
> scroll down to "Restating Our Requirements" and "Challenges".
>=20
> This patch set presented two modes.
> mode1: the parser is entirely based on eBPF - whereas the rest of the
> SW datapath stays as _scriptable_ as in Version 1.
> mode2: All of the kernel s/w datapath (including parser) is in eBPF.
>=20
> The key ingredient for eBPF, that we did not have access to in the past, =
is
> kfunc (it made a big difference for us to reconsider eBPF).
>=20
> In V2 the two modes are mutually exclusive (IOW, you get to choose one
> or the other via Kconfig).

I think/fear that this series has a "quorum" problem: different voices
raises opposition, and nobody (?) outside the authors supported the
code and the feature.=20

Could be the missing of H/W offload support in the current form the
root cause for such lack support? Or there are parties interested that
have been quite so far?

Thanks,

Paolo



