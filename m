Return-Path: <bpf+bounces-22580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A8586127B
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 14:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6D1B21322
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8B97E796;
	Fri, 23 Feb 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QtBLS5jX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC437E0E8
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694262; cv=none; b=phjBI6zwPbloj5jGMFRAdGWEO7kTUvDxUtVVzdbNGYj+IvrBpJh/jLLFIVDBtAoah8NeHRyL7ZWt/W3ui1ZHmsR/UMoaUpaFUXEfuDM6rB2mPlY0Kb1s+c3CtNQf498RyqVXFEJkmTNOEWAD6FCCcThI1HRcXlSvU53V+lo7jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694262; c=relaxed/simple;
	bh=8aEMLN6n2jQ341rgAfFFsW42jrQ1WBgcuzoOgGSQ93o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=heIHcBtoO2+DxpKLq5bQsloZ4ey+GAe+ExT1IBdO9VyJtdEQe6+sMc8VZYDOHeDOZiqizNkOjQ/axYkxlVIACJTBY7YFUiL3uQE+gFAod61XlWmkVy9F2sOtSTj0bljJhfUWo3sVgaLdbjybsHW3SuhSiUR8f2Yzun9fs+hD6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QtBLS5jX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78731e444daso45780485a.2
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708694259; x=1709299059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee4xEuCgDucqWMj50fyom/BWvazURfIC1KEjTIFVu5o=;
        b=QtBLS5jXssUlrAcr959SqYmWu358hUYETsUDDe+LSEYgJSyKNL/CEJYTsgggvTuyXe
         bz7KHLspfpccsw/ADIWXIWPCPJU5Ff8l1ts290maliusy6YQGsfdPJNmoqb7LzbG1uth
         o8ZtEyee64W9MSdeMfELS/KlP93yJKh7nl8but+i1Az4lGfdfGGqmvwvSEEuftfOhoVp
         HsFxv3yXYIHvxBqoymJ2dNCv1iJvXhljDiRlm642uthHRtptpd+5im36qYe7hz6T5GcW
         veWmQ6v4D2SuclfnjZhHwA3QuyFpOWJvX02dfzVMu5yLDzMVDZAhaYfZLIZg1nJ1i1l3
         7u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694259; x=1709299059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ee4xEuCgDucqWMj50fyom/BWvazURfIC1KEjTIFVu5o=;
        b=fLAEDAMiJvV/criuTgQtbJSwrhz69Rf6ylsm8CiiyCGFeoR85b9Hl6mYejO5crTLAu
         gEQisKBg+vsFiBDmrk9joAH5VRFwRXPYv2gXzse9QQ9rtOEPuIY8QAwDTsmg8QZlwMkg
         XmcYJ/QGa/87HbH5KP/zKAxQcx1kevdlUdyEMLtruDbuAVmQGjkFpIdFCrFV9jJupmlc
         qhFwWSOaE0tud+bI7rBOmRNf28kDEkB/nDaaC8Iglyxo+77Lm+0hNesMMT9CFR3RdCGr
         3iPx8DfrQ28pcurkOv20Wnkm3BhXG3dADNmy9rcXWrTZ/vZZtJbZu9u5F9W/hjJDcV4g
         VnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkBcPS121iUaqYCPWLhGSGcScDkY/7jNtRcZtP19puz6wgAVUamryleJqkoQgyBNA+aT+YqpziHenr8eFTszxx27aI
X-Gm-Message-State: AOJu0Yx6JVYtQbMrqRw1cgSYHw2NwqmHZqtVQbUqjQ50sKDUQgk4xHbe
	hZpqLkarHetxej/DqeqQOQ1ArhUM6aJcdCd8kNf6TEfU1+Fr1+W9IKqFg4IsGg==
X-Google-Smtp-Source: AGHT+IFTsqPJVKOdG9/COMT4+a7/dZLbK6kgAQd/x2P8JFWq4jfCEeZBDhnUVyRl7X9tM6QTqWNaRg==
X-Received: by 2002:a05:620a:127c:b0:785:da87:825b with SMTP id b28-20020a05620a127c00b00785da87825bmr1896740qkl.38.1708694258371;
        Fri, 23 Feb 2024 05:17:38 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a15a300b00787ae919d02sm844869qkk.17.2024.02.23.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:17:37 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
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
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	dan.daly@intel.com,
	andy.fingerhut@gmail.com,
	chris.sommers@keysight.com,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next v11 0/5] Introducing P4TC (series 1)
Date: Fri, 23 Feb 2024 08:17:23 -0500
Message-Id: <20240223131728.116717-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This is the first patchset of two. In this patch we are only submitting 5
patches which touch the general TC code given these are trivial. We will be
posting a second patchset which handles the P4 objects and associated infra
(which includes 10 patches that we have already been posting to hit the 15
limit).
One call that was hard to make was whether to include this cover letter which
talks about all of P4 and P4TC details or not. In the end we are putting a
slightly abbreviated version of the original cover letter and describe the P4
objects and associated infra further below.

__Description of these Patches__

Patch #1 adds infrastructure for per-netns P4 actions that can be created on
as need basis for the P4 program requirement. This patch makes a small incision
into act_api. Patches 2-4 are minimalist enablers for P4TC and have no
effect the classical tc action (example patch#2 just increases the size of the
action names from 16->64B).
Patch 5 adds infrastructure support for preallocation of dynamic actions.

None of these patches affect the performance (or functionality) of the
existing actions

What is P4?
-----------

The Programming Protocol-independent Packet Processors (P4) is an open source,
domain-specific programming language for specifying data plane behavior.

The current P4 landscape includes an extensive range of deployments, products,
projects and services, etc[9][12]. Two major NIC vendors, Intel[10] and AMD[11]
currently offer P4-native NICs. P4 is currently curated by the Linux
Foundation[9].

On why P4 - see small treatise here:[4].

What is P4TC?
-------------

P4TC is a net-namespace aware P4 implementation over TC; meaning, a P4 program
and its associated objects and state are attachend to a kernel _netns_ structure.
IOW, if we had two programs across netns' or within a netns they have no
visibility to each others objects (unlike for example TC actions whose kinds are
"global" in nature or eBPF maps visavis bpftool).

P4TC builds on top of many years of Linux TC experiences of a netlink control
path interface coupled with a software datapath with an equivalent offloadable
hardware datapath. In this patch series we are focussing only on the s/w
datapath. The s/w and h/w path equivalence that TC provides is relevant
for a primary use case of P4 where some (currently) large consumers of NICs
provide vendors their datapath specs in P4. In such a case one could generate
specified datapaths in s/w and test/validate the requirements before hardware
acquisition(example [12]).

Unlike other approaches such as TC Flower which require kernel and user space
changes when new datapath objects like packet headers are introduced P4TC, with
these patches, provides _kernel and user space code change independence_.
Meaning:
A P4 program describes headers, parsers, etc alongside the datapath processing;
the compiler uses the P4 program as input and generates several artifacts which
are then loaded into the kernel to manifest the intended datapath. In addition
to the generated datapath, control path constructs are generated. The process is
described further below in "P4TC Workflow".

There have been many discussions and meetings within the community since
about 2015 in regards to P4 over TC[2] and we are finally proving to the
naysayers that we do get stuff done!

A lot more of the P4TC motivation is captured at:
https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md

__P4TC Architecture__

The current architecture was described at netdevconf 0x17[14] and if you prefer
academic conference papers, a short paper is available here[15].

There are 4 parts:

1) A Template CRUD provisioning API for manifesting a P4 program and its
associated objects in the kernel. The template provisioning API uses netlink.
See patch in part 2.

2) A Runtime CRUD+ API code which is used for controlling the different runtime
behavior of the P4 objects. The runtime API uses netlink. See notes further
down. See patch description later..

3) P4 objects and their control interfaces: tables, actions, externs, etc.
Any object that requires control plane interaction resides in the TC domain
and is subject to the CRUD runtime API.  The intended goal is to make use of the
tc semantics of skip_sw/hw to target P4 program objects either in s/w or h/w.

4) S/W Datapath code hooks. The s/w datapath is eBPF based and is generated
by a compiler based on the P4 spec. When accessing any P4 object that requires
control plane interfaces, the eBPF code accesses the P4TC side from #3 above
using kfuncs.

The generated eBPF code is derived from [13] with enhancements and fixes to meet
our requirements.

__P4TC Workflow__

The Development and instantiation workflow for P4TC is as follows:

  A) A developer writes a P4 program, "myprog"

  B) Compiles it using the P4C compiler[8]. The compiler generates 3 outputs:

     a) A shell script which form template definitions for the different P4
     objects "myprog" utilizes (tables, externs, actions etc). See #1 above..

     b) the parser and the rest of the datapath are generated as eBPF and need
     to be compiled into binaries. At the moment the parser and the main control
     block are generated as separate eBPF program but this could change in
     the future (without affecting any kernel code). See #4 above.

     c) A json introspection file used for the control plane (by iproute2/tc).

  C) At this point the artifacts from #1,#4 could be handed to an operator
     (the operator could be the same person as the developer from #A, #B).

     i) For the eBPF part, either the operator is handed an ebpf binary or
     source which they compile at this point into a binary.
     The operator executes the shell script(s) to manifest the functional
     "myprog" into the kernel.

     ii) The operator instantiates "myprog" pipeline via the tc P4 filter
     to ingress/egress (depending on P4 arch) of one or more netdevs/ports
     (illustrated below as "block 22").

     Example instantion where the parser is a separate action:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        action bpf obj $PARSER.o section p4tc/parse \
        action bpf obj $PROGNAME.o section p4tc/main"

See individual patches in partc for more examples tc vs xdp etc. Also see
section on "challenges" (further below on this cover letter).

Once "myprog" P4 program is instantiated one can start performing operations
on table entries and/or actions at runtime as described below.

__P4TC Runtime Control Path__

The control interface builds on past tc experience and tries to get things
right from the beginning (example filtering is separated from depending
on existing object TLVs and made generic); also the code is written in
such a way it is mostly lockless.

The P4TC control interface, using netlink, provides what we call a CRUDPS
abstraction which stands for: Create, Read(get), Update, Delete, Subscribe,
Publish.  From a high level PoV the following describes a conformant high level
API (both on netlink data model and code level):

	Create(</path/to/object, DATA>+)
	Read(</path/to/object>, [optional filter])
	Update(</path/to/object>, DATA>+)
	Delete(</path/to/object>, [optional filter])
	Subscribe(</path/to/object>, [optional filter])

Note, we _dont_ treat "dump" or "flush" as speacial. If "path/to/object" points
to a table then a "Delete" implies "flush" and a "Read" implies dump but if
it points to an entry (by specifying a key) then "Delete" implies deleting
and entry and "Read" implies reading that single entry. It should be noted that
both "Delete" and "Read" take an optional filter parameter. The filter can
define further refinements to what the control plane wants read or deleted.
"Subscribe" uses built in netlink event management. It, as well, takes a filter
which can further refine what events get generated to the control plane (taken
out of this patchset, to be re-added with consideration of [16]).

Lets show some runtime samples:

..create an entry, if we match ip address 10.0.1.2 send packet out eno1
  tc p4ctrl create myprog/table/mytable \
   dstAddr 10.0.1.2/32 action send_to_port param port eno1

..Batch create entries
  tc p4ctrl create myprog/table/mytable \
  entry dstAddr 10.1.1.2/32  action send_to_port param port eno1 \
  entry dstAddr 10.1.10.2/32  action send_to_port param port eno10 \
  entry dstAddr 10.0.2.2/32  action send_to_port param port eno2

..Get an entry (note "read" is interchangeably used as "get" which is a common
		semantic in tc):
  tc p4ctrl read myprog/table/mytable \
   dstAddr 10.0.2.2/32

..dump mytable
  tc p4ctrl read myprog/table/mytable

..dump mytable for all entries whose key fits within 10.1.0.0/16
  tc p4ctrl read myprog/table/mytable \
  filter key/myprog/mytable/dstAddr = 10.1.0.0/16

..dump all mytable entries which have an action send_to_port with param "eno1"
  tc p4ctrl get myprog/table/mytable \
  filter param/act/myprog/send_to_port/port = "eno1"

The filter expression is powerful, f.e you could say:

  tc p4ctrl get myprog/table/mytable \
  filter param/act/myprog/send_to_port/port = "eno1" && \
         key/myprog/mytable/dstAddr = 10.1.0.0/16

It also works on built in metadata, example in the following case dumping
entries from mytable that have seen activity in the last 10 secs:
  tc p4ctrl get myprog/table/mytable \
  filter msecs_since < 10000

Delete follows the same syntax as get/read, so for sake of brevity we won't
show more example than how to flush mytable:

  tc p4ctrl delete myprog/table/mytable

Mystery question: How do we achieve iproute2-kernel independence and
how does "tc p4ctrl" as a cli know how to program the kernel given an
arbitrary command line as shown above? Answer(s): It queries the
compiler generated json file in "P4TC Workflow" #B.c above. The json file has
enough details to figure out that we have a program called "myprog" which has a
table "mytable" that has a key name "dstAddr" which happens to be type ipv4
address prefix. The json file also provides details to show that the table
"mytable" supports an action called "send_to_port" which accepts a parameter
"port" of type netdev (see the types patch for all supported P4 data types).
All P4 components have names, IDs, and types - so this makes it very easy to map
into netlink.
Once user space tc/p4ctrl validates the human command input, it creates
standard binary netlink structures (TLVs etc) which are sent to the kernel.
See the runtime table entry patch for more details.

__P4TC Datapath__

The P4TC s/w datapath execution is generated as eBPF. Any objects that require
control interfacing reside in the "P4TC domain" and are controlled via netlink
as described above. Per packet execution and state and even objects that do not
require control interfacing (like the P4 parser) are generated as eBPF.

A packet arriving on s/w ingress of any of the ports on block 22 will first be
exercised via the (generated eBPF) parser component to extract the headers (the
ip destination address in labelled "dstAddr" above).
The datapath then proceeds to use "dstAddr", table ID and pipeline ID
as a key to do a lookup in myprog's "mytable" which returns the action params
which are then used to execute the action in the eBPF datapath (eventually
sending out packets to eno1).
On a table miss, mytable's default miss action (not described) is executed.

__Testing__

Speaking of testing - we have 2-300 tdc test cases (which will be in the
second patchset).
These tests are run on our CICD system on pull requests and after commits are
approved. The CICD does a lot of other tests (more since v2, thanks to Simon's
input)including:
checkpatch, sparse, smatch, coccinelle, 32 bit and 64 bit builds tested on both
X86, ARM 64 and emulated BE via qemu s390. We trigger performance testing in the
CICD to catch performance regressions (currently only on the control path, but
in the future for the datapath).
Syzkaller runs 24/7 on dedicated hardware, originally we focussed only on memory
sanitizer but recently added support for concurrency sanitizer.
Before main releases we ensure each patch will compile on its own to help in
git bisect and run the xmas tree tool. We eventually put the code via coverity.

In addition we are working on enabling a tool that will take a P4 program, run
it through the compiler, and generate permutations of traffic patterns via
symbolic execution that will test both positive and negative datapath code
paths. The test generator tool integration is still work in progress.
Also: We have other code that test parallelization etc which we are trying to
find a fit for in the kernel tree's testing infra.


__References__

[1]https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4WorkshopP4TC.pdf
[2]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#historical-perspective-for-p4tc
[3]https://2023p4workshop.sched.com/event/1KsAe/p4tc-linux-kernel-p4-implementation-approaches-and-evaluation
[4]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#so-why-p4-and-how-does-p4-help-here
[5]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#mf59be7abc5df3473cff3879c8cc3e2369c0640a6
[6]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#m783cfd79e9d755cf0e7afc1a7d5404635a5b1919
[7]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#ma8c84df0f7043d17b98f3d67aab0f4904c600469
[8]https://github.com/p4lang/p4c/tree/main/backends/tc
[9]https://p4.org/
[10]https://www.intel.com/content/www/us/en/products/details/network-io/ipu/e2000-asic.html
[11]https://www.amd.com/en/accelerators/pensando
[12]https://github.com/sonic-net/DASH/tree/main
[13]https://github.com/p4lang/p4c/tree/main/backends/ebpf
[14]https://netdevconf.info/0x17/sessions/talk/integrating-ebpf-into-the-p4tc-datapath.html
[15]https://dl.acm.org/doi/10.1145/3630047.3630193
[16]https://lore.kernel.org/netdev/20231216123001.1293639-1-jiri@resnulli.us/
[17.a]https://netdevconf.info/0x13/session.html?talk-tc-u-classifier
[17.b]man tc-u32
[18]man tc-pedit
[19] https://lore.kernel.org/netdev/20231219181623.3845083-6-victor@mojatatu.com/T/#m86e71743d1d83b728bb29d5b877797cb4942e835
[20.a] https://netdevconf.info/0x16/sessions/talk/your-network-datapath-will-be-p4-scripted.html
[20.b] https://netdevconf.info/0x16/sessions/workshop/p4tc-workshop.html

--------
HISTORY
--------

Changes in Version 11
----------------------
1) Split the series into two. Original patches 1-5 in this patchset. The rest
   will go out after this is merged.

2) Change any references of IFNAMSIZ in the action code when referencing the
   action name size to ACTNAMSIZ. Thanks to Marcelo.

Changes in Version 10
----------------------
1) A couple of patches from the earlier version were clean enough to submit,
   so we did. This gave us room to split the two largest patches each into
   two. Even though the split is not git-bisactable and really some of it didn't
   make much sense (eg spliting a create, and update in one patch and delete and
   get into another) we made sure each of the split patches compiled
   independently. The idea is to reduce the number of lines of code to review
   and when we get sufficient reviews we will put the splits together again.
   See patch #12 and #13 as well as patches #7 and #8).

2) Add more context in patch 0. Please READ!

3) Added dump/delete filters back to the code - we had taken them out in the
   earlier patches to reduce the amount of code for review - but in retrospect
   we feel they are important enough to push earlier rather than later.


Changes In version 9
---------------------

1) Remove the largest patch (externs) to ease review.

2) Break up action patches into two to ease review bringing down the patches
   that need more scrutiny to 8 (the first 7 are almost trivial).

3) Fixup prefix naming convention to p4tc_xxx for uapi and p4a_xxx for actions
   to provide consistency(Jiri).

4) Silence sparse warning "was not declared. Should it be static?" for kfuncs
   by making them static. TBH, not sure if this is the right solution
   but it makes sparse happy and hopefully someone will comment.

Changes In Version 8
---------------------

1) Fix all the patchwork warnings and improve our ci to catch them in the future

2) Reduce the number of patches to basic max(15)  to ease review.

Changes In Version 7
-------------------------

0) First time removing the RFC tag!

1) Removed XDP cookie. It turns out as was pointed out by Toke(Thanks!) - that
using bpf links was sufficient to protect us from someone replacing or deleting
a eBPF program after it has been bound to a netdev.

2) Add some reviewed-bys from Vlad.

3) Small bug fixes from v6 based on testing for ebpf.

4) Added the counter extern as a sample extern. Illustrating this example because
   it is slightly complex since it is possible to invoke it directly from
   the P4TC domain (in case of direct counters) or from eBPF (indirect counters).
   It is not exactly the most efficient implementation (a reasonable counter impl
   should be per-cpu).

Changes In RFC Version 6
-------------------------

1) Completed integration from scriptable view to eBPF. Completed integration
   of externs integration.

2) Small bug fixes from v5 based on testing.

Changes In RFC Version 5
-------------------------

1) More integration from scriptable view to eBPF. Small bug fixes from last
   integration.

2) More streamlining support of externs via kfunc (create-on-miss, etc)

3) eBPF linking for XDP.

There is more eBPF integration/streamlining coming (we are getting close to
conversion from scriptable domain).

Changes In RFC Version 4
-------------------------

1) More integration from scriptable to eBPF. Small bug fixes.

2) More streamlining support of externs via kfunc (one additional kfunc).

3) Removed per-cpu scratchpad per Toke's suggestion and instead use XDP metadata.

There is more eBPF integration coming. One thing we looked at but is not in this
patchset but should be in the next is use of eBPF link in our loading (see
"challenge #1" further below).

Changes In RFC Version 3
-------------------------

These patches are still in a little bit of flux as we adjust to integrating
eBPF. So there are small constructs that are used in V1 and 2 but no longer
used in this version. We will make a V4 which will remove those.
The changes from V2 are as follows:

1) Feedback we got in V2 is to try stick to one of the two modes. In this version
we are taking one more step and going the path of mode2 vs v2 where we had 2 modes.

2) The P4 Register extern is no longer standalone. Instead, as part of integrating
into eBPF we introduce another kfunc which encapsulates Register as part of the
extern interface.

3) We have improved our CICD to include tools pointed to us by Simon. See
   "Testing" further below. Thanks to Simon for that and other issues he caught.
   Simon, we discussed on issue [7] but decided to keep that log since we think
   it is useful.

4) A lot of small cleanups. Thanks Marcelo. There are two things we need to
   re-discuss though; see: [5], [6].

5) We removed the need for a range of IDs for dynamic actions. Thanks Jakub.

6) Clarify ambiguity caused by smatch in an if(A) else if(B) condition. We are
   guaranteed that either A or B must exist; however, lets make smatch happy.
   Thanks to Simon and Dan Carpenter.

Changes In RFC Version 2
-------------------------

Version 2 is the initial integration of the eBPF datapath.
We took into consideration suggestions provided to use eBPF and put effort into
analyzing eBPF as datapath which involved extensive testing.
We implemented 6 approaches with eBPF and ran performance analysis and presented
our results at the P4 2023 workshop in Santa Clara[see: 1, 3] on each of the 6
vs the scriptable P4TC and concluded that 2 of the approaches are sensible (4 if
you account for XDP or TC separately).

Conclusions from the exercise: We lose the simple operational model we had
prior to integrating eBPF. We do gain performance in most cases when the
datapath is less compute-bound.
For more discussion on our requirements vs journeying the eBPF path please
scroll down to "Restating Our Requirements" and "Challenges".

This patch set presented two modes.
mode1: the parser is entirely based on eBPF - whereas the rest of the
SW datapath stays as _scriptable_ as in Version 1.
mode2: All of the kernel s/w datapath (including parser) is in eBPF.

The key ingredient for eBPF, that we did not have access to in the past, is
kfunc (it made a big difference for us to reconsider eBPF).

In V2 the two modes are mutually exclusive (IOW, you get to choose one
or the other via Kconfig).


Jamal Hadi Salim (15):
  net: sched: act_api: Introduce P4 actions list
  net/sched: act_api: increase action kind string length
  net/sched: act_api: Update tc_action_ops to account for P4 actions
  net/sched: act_api: add struct p4tc_action_ops as a parameter to
    lookup callback
  net: sched: act_api: Add support for preallocated P4 action instances
  p4tc: add P4 data types
  p4tc: add template API
  p4tc: add template pipeline create, get, update, delete
  p4tc: add template action create, update, delete, get, flush and dump
  p4tc: add runtime action support
  p4tc: add template table create, update, delete, get, flush and dump
  p4tc: add runtime table entry create and update
  p4tc: add runtime table entry get, delete, flush and dump
  p4tc: add set of P4TC table kfuncs
  p4tc: add P4 classifier

 include/linux/bitops.h            |    1 +
 include/net/act_api.h             |   23 +-
 include/net/p4tc.h                |  642 ++++++
 include/net/p4tc_types.h          |   91 +
 include/net/tc_act/p4tc.h         |   52 +
 include/uapi/linux/p4tc.h         |  433 ++++
 include/uapi/linux/pkt_cls.h      |   19 +
 include/uapi/linux/rtnetlink.h    |   18 +
 include/uapi/linux/tc_act/tc_p4.h |   11 +
 net/sched/Kconfig                 |   23 +
 net/sched/Makefile                |    3 +
 net/sched/act_api.c               |  190 +-
 net/sched/cls_api.c               |    2 +-
 net/sched/cls_p4.c                |  450 +++++
 net/sched/p4tc/Makefile           |    8 +
 net/sched/p4tc/p4tc_action.c      | 2305 ++++++++++++++++++++++
 net/sched/p4tc/p4tc_bpf.c         |  338 ++++
 net/sched/p4tc/p4tc_filter.c      |  872 +++++++++
 net/sched/p4tc/p4tc_pipeline.c    |  678 +++++++
 net/sched/p4tc/p4tc_runtime_api.c |  145 ++
 net/sched/p4tc/p4tc_table.c       | 1779 +++++++++++++++++
 net/sched/p4tc/p4tc_tbl_entry.c   | 3044 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c    |  609 ++++++
 net/sched/p4tc/p4tc_types.c       | 1287 ++++++++++++
 net/sched/p4tc/trace.c            |   10 +
 net/sched/p4tc/trace.h            |   44 +
 security/selinux/nlmsgtab.c       |   10 +-
 27 files changed, 13052 insertions(+), 35 deletions(-)
 create mode 100644 include/net/p4tc.h
 create mode 100644 include/net/p4tc_types.h
 create mode 100644 include/net/tc_act/p4tc.h
 create mode 100644 include/uapi/linux/p4tc.h
 create mode 100644 include/uapi/linux/tc_act/tc_p4.h
 create mode 100644 net/sched/cls_p4.c
 create mode 100644 net/sched/p4tc/Makefile
 create mode 100644 net/sched/p4tc/p4tc_action.c
 create mode 100644 net/sched/p4tc/p4tc_bpf.c
 create mode 100644 net/sched/p4tc/p4tc_filter.c
 create mode 100644 net/sched/p4tc/p4tc_pipeline.c
 create mode 100644 net/sched/p4tc/p4tc_runtime_api.c
 create mode 100644 net/sched/p4tc/p4tc_table.c
 create mode 100644 net/sched/p4tc/p4tc_tbl_entry.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_api.c
 create mode 100644 net/sched/p4tc/p4tc_types.c
 create mode 100644 net/sched/p4tc/trace.c
 create mode 100644 net/sched/p4tc/trace.h

-- 
2.34.1


Jamal Hadi Salim (5):
  net: sched: act_api: Introduce P4 actions list
  net/sched: act_api: increase action kind string length
  net/sched: act_api: Update tc_action_ops to account for P4 actions
  net/sched: act_api: add struct p4tc_action_ops as a parameter to
    lookup callback
  net: sched: act_api: Add support for preallocated P4 action instances

 include/net/act_api.h        |  22 +++-
 include/uapi/linux/pkt_cls.h |   1 +
 net/sched/act_api.c          | 192 +++++++++++++++++++++++++++++------
 net/sched/cls_api.c          |   2 +-
 4 files changed, 182 insertions(+), 35 deletions(-)

-- 
2.34.1


