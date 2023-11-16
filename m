Return-Path: <bpf+bounces-15178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00657EE394
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5E01F22DA3
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1280347B9;
	Thu, 16 Nov 2023 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="D8cLefXM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF9519D
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:54 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d33298f8fdso487552a34.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146793; x=1700751593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVJdgXoKBlhscaO5qbdyAMbFG5rO/fa18ZcEcWzcxaA=;
        b=D8cLefXMTPPInrC0dVky2kzc8a43JWJ50CNxsZ3Gqq1FwoI0dKjFC4g1l+zV4tQRAa
         p+AUI63CvFRTa80IZ7YnJ4di+eeJpxe1Ewjp/py0CULCsLB+JDgBYc8Pd0x69vL1Ogqk
         BFzrcR7oOK9f+vXkFA2JpTHQZaECjf7WIzUZzhsixC4tUrM4y3xz6rHmzNSyCurY326p
         a+pIsyj233IueWA5YkqcgMwfcgmtwq7DHX++5PCzZm6vXHv8bIKCXko+6ODsVVrBsG6g
         1UsiPATtMuI/NOXXTrZiumklsd+UuTBCHPH5wwGUbi6XMYnvBKOrar1LqD37aOqyib0e
         joow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146793; x=1700751593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVJdgXoKBlhscaO5qbdyAMbFG5rO/fa18ZcEcWzcxaA=;
        b=OigYMUEzJWS9WCa3siIPHJV1Q8HfiuAx837yDNxuU9zckTDXHO17vi0sWbF7aEDerU
         JABXBvMQ47sp5WbXcMuDqA69eT25bKJEnWof9VkP8X0WMNtHM5DTDQ9Re0duVXV4IFqN
         7IcVLhfOCQGiPKD4dvNDfB8Qbe53cj6iVCsHGkOZtijmxifObm//9FE7VtKTyNKNSGAZ
         6zBDkFZaJ3YV2kwnBm6jw7KkWYK1RliJOwvjTgoPwZi5sZ3E4ylQ1y5hPf5KksILBxAt
         WUZgZVjIgndDmaQKCyDVjW428t/PaKcVJgTwHMZKZFFI9PNGJaTMk6KT5Ebs3AuBZ796
         je0A==
X-Gm-Message-State: AOJu0YzxZXPy0BJBYbMOD/vjLJRX9PcDPiPc2ie5q8yRNSZkXTpnFJw8
	wKGa34qg03CpcAJL1JtOdVGPkQ==
X-Google-Smtp-Source: AGHT+IGnn6UBqR2NMjW7OQtHicdVLzu/ttRhRPs4qcE0Gp7WhsyTYCODNy+sFi6SK30x2dVNLZKs2g==
X-Received: by 2002:a05:6871:4509:b0:1f5:7e85:f812 with SMTP id nj9-20020a056871450900b001f57e85f812mr2506858oab.9.1700146793139;
        Thu, 16 Nov 2023 06:59:53 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:59:52 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	Vipin.Jain@amd.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	dan.daly@intel.com,
	chris.sommers@keysight.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH net-next v8 00/15] Introducing P4TC
Date: Thu, 16 Nov 2023 09:59:33 -0500
Message-Id: <20231116145948.203001-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are seeking community feedback on P4TC patches.

We have reduced the number of commits in this patchset including leaving out
all the testcases and secondary patches in order to ease review.

We feel we have completed the migration from the V1 scriptable version to eBPF
and now is a good time to remove the RFC tag.

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

Changes In RFC Version 4
-------------------------

1) More integration from scriptable to eBPF. Small bug fixes.

2) More streamlining support of externs via kfunc (one additional kfunc).

3) Removed per-cpu scratchpad per Toke's suggestion and instead use XDP metadata.

There is more eBPF integration coming. One thing we looked at but is not in this
patchset but should be in the next is use of eBPF link in our loading (see
"challenge #1" further below).

Changes In RFC Version 5
-------------------------

1) More integration from scriptable view to eBPF. Small bug fixes from last
   integration.

2) More streamlining support of externs via kfunc (create-on-miss, etc)

3) eBPF linking for XDP.

There is more eBPF integration/streamlining coming (we are getting close to
conversion from scriptable domain).

Changes In RFC Version 6
-------------------------

1) Completed integration from scriptable view to eBPF. Completed integration
   of externs integration.

2) Small bug fixes from v5 based on testing.

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

Changes In Version 8
---------------------
1) Fix all the patchwork warnings and improve our ci to catch them in the future

2) Reduce the number of patches to basic max(15)  to ease review.

What is P4?
-----------

The Programming Protocol-independent Packet Processors (P4) is an open source,
domain-specific programming language for specifying data plane behavior.

The P4 ecosystem includes an extensive range of deployments, products, projects
and services, etc[9][10][11][12].

__What is P4TC?__

P4TC is a net-namespace aware implementation, meaning multiple P4 programs can
run independently in different namespaces alongside their appropriate state. The
implementation builds on top of many years of Linux TC experiences.
On why P4 - see small treatise here:[4].

There have been many discussions and meetings since about 2015 in regards to
P4 over TC[2] and we are finally proving the naysayers that we do get stuff
done!

A lot more of the P4TC motivation is captured at:
https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md

**In this patch series we focus on s/w datapath only**.

__P4TC Workflow__

These patches enable kernel and user space code change _independence_ for any
new P4 program that describes a new datapath. The workflow is as follows:

  1) A developer writes a P4 program, "myprog"

  2) Compiles it using the P4C compiler[8]. The compiler generates 3 outputs:
     a) shell script(s) which form template definitions for the different P4
     objects "myprog" utilizes (tables, externs, actions etc).
     b) the parser and the rest of the datapath are generated
     in eBPF and need to be compiled into binaries.
     c) A json introspection file used for the control plane (by iproute2/tc).

  3) The developer (or operator) executes the shell script(s) to manifest the
     functional "myprog" into the kernel.

  4) The developer (or operator) instantiates "myprog" via the tc P4 filter
     to ingress/egress (depending on P4 arch) of one or more netdevs/ports.

     Example1: parser is an action:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        action bpf obj $PARSER.o section parser/tc-ingress \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example2: parser explicitly bound and rest of dpath as an action:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        prog tc obj $PARSER.o section parser/tc-ingress \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example3: parser is at XDP, rest of dpath as an action:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        prog type xdp obj $PARSER.o section parser/xdp-ingress \
	pinned_link /path/to/xdp-prog-link \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example4: parser+prog at XDP:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        prog type xdp obj $PROGNAME.o section p4prog/xdp \
	pinned_link /path/to/xdp-prog-link"

    see individual patches for more examples tc vs xdp etc. Also see section on
    "challenges" (on this cover letter).

Once "myprog" P4 program is instantiated one can start updating table entries
that are associated with myprog's table named "mytable". Example:

  tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
    action send_to_port param port eno1

A packet arriving on ingress of any of the ports on block 22 will first be
exercised via the (eBPF) parser to find the headers pointing to the ip
destination address.
The remainder eBPF datapath uses the result dstAddr as a key to do a lookup in
myprog's mytable which returns the action params which are then used to execute
the action in the eBPF datapath (eventually sending out packets to eno1).
On a table miss, mytable's default miss action is executed.

__Description of Patches__

P4TC is designed to have no impact on the core code for other users
of TC. IOW, you can compile it out but even if it compiled in and you dont use
it there should be no impact on your performance.

We do make core kernel changes. Patch #1 adds infrastructure for "dynamic"
actions that can be created on "the fly" based on the P4 program requirement.
This patch makes a small incision into act_api which shouldn't affect the
performance (or functionality) of the existing actions. Patches 2-4,6-7 are
minimalist enablers for P4TC and have no effect the classical tc action.
Patch 5 adds infrastructure support for preallocation of dynamic actions.

The core P4TC code implements several P4 objects.

1) Patch #8 introduces P4 data types which are consumed by the rest of the code
2) Patch #9 introduces the concept of templating Pipelines. i.e CRUD commands
   for P4 pipelines.
3) Patch #10 introduces the concept of action templates and associated
   CRUD commands.
4) Patch #11 introduces the concept of P4 table templates and associated
   CRUD commands for tables
5) Patch #12 introduces table entries and associated CRUD commands.
6) Patch #13 introduces interaction of eBPF to P4TC tables via kfunc.
7) Patch #14 introduces the TC classifier P4 used at runtime.
8) Patch #15 introduces extern interfacing (both template and runtime).

__Testing__

Speaking of testing - we have ~300 tdc test cases. This number is growing as
we are adjusting to accommodate for eBPF.
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

In addition we are working on a tool that will take a P4 program, run it through
the compiler, and generate permutations of traffic patterns via symbolic
execution that will test both positive and negative datapath code paths. The
test generator tool is still work in progress and will be generated by the P4
compiler.
Note: We have other code that test parallelization etc which we are trying to
find a fit for in the kernel tree's testing infra.

__Restating Our Requirements__

The initial release made in January/2023 had a "scriptable" datapath (think u32
classifier and pedit action). In this section we review the scriptable version
against the current implementation we are pushing upstream which uses eBPF.

Our intention is to target the TC crowd.
Essentially developers and ops people deploying TC based infra.
More importantly the original intent for P4TC was to enable _ops folks_ more than
devs (given code is being generated and doesn't need humans to write it).

With TC, we get whole "familiar" package of match-action pipeline abstraction++,
meaning from the control plane all the way to the tooling infra, i.e
iproute2/tc cli, netlink infra(request/resp, event subscribe/multicast-publish,
congestion control etc), s/w and h/w symbiosis, the autonomous kernel control,
etc.
The main advantage is that we have a singular vendor-neutral interface via the
kernel using well understood mechanisms based on deployment experience (and
at least this part doesnt need retraining).

1) Supporting expressibility of the universe set of P4 progs

It is a must to support 100% of all possible P4 programs. In the past the eBPF
verifier had to be worked around and even then there are cases where we couldnt
avoid path explosion when branching is involved. Kfunc-ing solves these issues
for us. Note, there are still challenges running all potential P4 programs at
the XDP level - the solution to that is to have the compiler generate XDP based
code only if it possible to map it to that layer.

2) Support for P4 HW and SW equivalence.

This feature continues to work even in the presence of eBPF as the s/w
datapath. There are cases of square-hole-round-peg scenarios but
those are implementation issues we can live with.

3) Operational usability

By maintaining the TC control plane (even in presence of eBPF datapath)
runtime aspects remain unchanged. So for our target audience of folks
who have deployed tc including offloads - the comfort zone is unchanged.
There is also the comfort zone of continuing to use the true-and-tried netlink
interfacing.

There is some loss in operational usability because we now have more knobs:
the extra compilation, loading and syncing of ebpf binaries, etc.
IOW, I can no longer just ship someone a shell script in an email to
say go run this and "myprog" will just work.

4) Operational and development Debuggability

If something goes wrong, the tc craftsperson is now required to have additional
knowledge of eBPF code and process. This applies to both the operational person
as well as someone who wrote a driver. We dont believe this is solvable.

5) Opportunity for rapid prototyping of new ideas

During the P4TC development phase something that came naturally was to often
handcode the template scripts because the compiler backend (which is P4 arch
specific) wasnt ready to generate certain things. Then you would read back the
template and diff to ensure the kernel didn't get something wrong. So this
started as a debug feature. During development, we wrote scripts that
covered a range of P4 architectures(PSA, V1, etc) which required no kernel code
changes.

Over time the debug feature morphed into: a) start by handcoding scripts then
b) read it back and then c) generate the P4 code.
It means one could start with the template scripts outside of the constraints
of a P4 architecture spec(PNA/PSA) or even within a P4 architecture then test
some ideas and eventually feed back the concepts to the compiler authors or
modify or create a new P4 architecture and share with the P4 standards folks.

To summarize in presence of eBPF: The debugging idea is probably still alive.
One could dump, with proper tooling(bpftool for example), the loaded eBPF code
and be able to check for differences. But this is not the interesting part.
The concept of going back from whats in the kernel to P4 is a lot more difficult
to implement mostly due to scoping of DSL vs general purpose. It may be lost.
We have been thinking of ways to use BTF and embedding annotations in the eBPF
code and binary but more thought is required and we welcome suggestions.

6) Supporting per namespace program

This requirement is still met (by virtue of keeping P4 control objects within the
TC domain).

__Challenges__

1) Concept of tc block in XDP is _very tedious_ to implement. It would be nice
   if we can use concept there as well, since we expect P4 to work with many
   ports. It will likely require some core patches to fix this.

2) Right now we are using "packed" construct to enforce alignment in kfunc data
   exchange; but we're wondering if there is potential to use BTF to understand
   parameters and their offsets and encode this information at the compiler
   level.

3) At the moment we are creating a static buffer of 128B to retrieve the action
   parameters. If you have a lot of table entries and individual(non-shared)
   action instances with actions that require very little (or no) param space
   a lot of memory is wasted. There may also be cases where 128B may not be
   enough; (likely this is something we can teach the P4C compiler). If we can
   have dynamic pointers instead for kfunc fixed length parameterization then
   this issue is resolvable.

4) See "Restating Our Requirements" #5.
   We would really appreciate ideas/suggestions, etc.

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

Jamal Hadi Salim (15):
  net: sched: act_api: Introduce dynamic actions list
  net/sched: act_api: increase action kind string length
  net/sched: act_api: Update tc_action_ops to account for dynamic
    actions
  net/sched: act_api: add struct p4tc_action_ops as a parameter to
    lookup callback
  net: sched: act_api: Add support for preallocated dynamic action
    instances
  net: introduce rcu_replace_pointer_rtnl
  rtnl: add helper to check if group has listeners
  p4tc: add P4 data types
  p4tc: add template pipeline create, get, update, delete
  p4tc: add action template create, update, delete, get, flush and dump
  p4tc: add template table create, update, delete, get, flush and dump
  p4tc: add runtime table entry create, update, get, delete, flush and
    dump
  p4tc: add set of P4TC table kfuncs
  p4tc: add P4 classifier
  p4tc: Add P4 extern interface

 include/linux/bitops.h            |    1 +
 include/linux/rtnetlink.h         |   19 +
 include/net/act_api.h             |   22 +-
 include/net/p4tc.h                |  744 ++++++++
 include/net/p4tc_ext_api.h        |  199 ++
 include/net/p4tc_types.h          |   88 +
 include/net/tc_act/p4tc.h         |   52 +
 include/uapi/linux/p4tc.h         |  406 ++++
 include/uapi/linux/p4tc_ext.h     |   36 +
 include/uapi/linux/pkt_cls.h      |   19 +
 include/uapi/linux/rtnetlink.h    |   18 +
 net/sched/Kconfig                 |   23 +
 net/sched/Makefile                |    3 +
 net/sched/act_api.c               |  195 +-
 net/sched/cls_api.c               |    2 +-
 net/sched/cls_p4.c                |  447 +++++
 net/sched/p4tc/Makefile           |    8 +
 net/sched/p4tc/p4tc_action.c      | 2308 +++++++++++++++++++++++
 net/sched/p4tc/p4tc_bpf.c         |  414 +++++
 net/sched/p4tc/p4tc_ext.c         | 2204 ++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c    |  707 +++++++
 net/sched/p4tc/p4tc_runtime_api.c |  153 ++
 net/sched/p4tc/p4tc_table.c       | 1634 ++++++++++++++++
 net/sched/p4tc/p4tc_tbl_entry.c   | 2870 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c    |  611 ++++++
 net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 ++++++++++++++++++++++
 net/sched/p4tc/p4tc_types.c       | 1247 +++++++++++++
 net/sched/p4tc/trace.c            |   10 +
 net/sched/p4tc/trace.h            |   44 +
 security/selinux/nlmsgtab.c       |   10 +-
 30 files changed, 16676 insertions(+), 39 deletions(-)
 create mode 100644 include/net/p4tc.h
 create mode 100644 include/net/p4tc_ext_api.h
 create mode 100644 include/net/p4tc_types.h
 create mode 100644 include/net/tc_act/p4tc.h
 create mode 100644 include/uapi/linux/p4tc.h
 create mode 100644 include/uapi/linux/p4tc_ext.h
 create mode 100644 net/sched/cls_p4.c
 create mode 100644 net/sched/p4tc/Makefile
 create mode 100644 net/sched/p4tc/p4tc_action.c
 create mode 100644 net/sched/p4tc/p4tc_bpf.c
 create mode 100644 net/sched/p4tc/p4tc_ext.c
 create mode 100644 net/sched/p4tc/p4tc_pipeline.c
 create mode 100644 net/sched/p4tc/p4tc_runtime_api.c
 create mode 100644 net/sched/p4tc/p4tc_table.c
 create mode 100644 net/sched/p4tc/p4tc_tbl_entry.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_api.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_ext.c
 create mode 100644 net/sched/p4tc/p4tc_types.c
 create mode 100644 net/sched/p4tc/trace.c
 create mode 100644 net/sched/p4tc/trace.h

-- 
2.34.1


