Return-Path: <bpf+bounces-15220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820C17EEC3C
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 07:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BF82811E1
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 06:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C015D52C;
	Fri, 17 Nov 2023 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGmseOeW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7279D49;
	Thu, 16 Nov 2023 22:27:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5be30d543c4so1240127a12.2;
        Thu, 16 Nov 2023 22:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700202462; x=1700807262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqBO4pmA+GV+jyR/4/YRJhn+XphNA9J0Ov4UoqlwplU=;
        b=YGmseOeW7pJbK2LU5yWD1YYCXoSwMiIWugBhbw+04B2y8oj+wqqBGWbpTT1gYoSiDa
         jv8Ogllm5JY+eyzUINtGAWMiGN8NPxCd1nq47ZYc6lDIQKXBRV505lJSrf/RMcgMkjTZ
         OqZ8vQm/tHWwoep/9Xk1mBJjEpWXEARxr5dcNOvORFWq+iq6+1euzTXBRswxD2yXirzu
         BmbLNrAmgN2ZiprWSvoJVhQToPNp/1+BGK3mICdyXdL+pTwCTxj1arneU9eAfM4tAsQ9
         LVXAwuTMNQu2JdhDZQcgZkavGupkCNw1NjmBHjdKnvzMCHg05WQCXKwOS1z24fzFgDsf
         h63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700202462; x=1700807262;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqBO4pmA+GV+jyR/4/YRJhn+XphNA9J0Ov4UoqlwplU=;
        b=ius7tvroan7IpE2c9FKYBtOcm95pOxWsrVB/4+bQphmOi/tRmEx9DY1H+uBF67K58b
         PnT0zi7ZCEg43Dz5DwIE3uSLxE79wi2SuB3GzUoHUY805T/us21c2Uf+F9ltfDUG0RWc
         YqDS5rgNLwL9eAenoZXmNIwHm8x7NPwB2PN/hJoIKILRBnkXw4X/WKO2mGbeAp9ORnUS
         F+9VOMt4Dr0DkcEbTIXM+Rco+C4tX/3pRmHtZBeHOGmhuOVi9iPLF7BySkGYVuOfvAWz
         spYb3LCs3T5Lz2ppc1Tmj4JpW4m84TnFXBjeh1C3g1JQLZrwm8FzJwUfBUuDba6QRGzF
         /RFQ==
X-Gm-Message-State: AOJu0YwjUs8F7pbMn8QKnfvBSmNt4/idRZlbtWC16fIxfy/XcUC+P4RE
	SCgpqG8el3SBsSpwV0XnI90=
X-Google-Smtp-Source: AGHT+IHFcz/r8fcvmbBGw0DBzBF9anAQLstehQd+BRsqALj3ZcPKa51+1v1mFu7r0QVezcEeqSV8jQ==
X-Received: by 2002:a05:6a20:1455:b0:187:d28d:bd92 with SMTP id a21-20020a056a20145500b00187d28dbd92mr3382478pzi.11.1700202461975;
        Thu, 16 Nov 2023 22:27:41 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:377e:7905:3027:d8fd])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001c8836a3795sm645075plw.271.2023.11.16.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 22:27:41 -0800 (PST)
Date: Thu, 16 Nov 2023 22:27:39 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
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
Message-ID: <655707db8d55e_55d7320812@john.notmuch>
In-Reply-To: <20231116145948.203001-1-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
Subject: RE: [PATCH net-next v8 00/15] Introducing P4TC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> We are seeking community feedback on P4TC patches.
> 

[...]

> 
> What is P4?
> -----------

I read the cover letter here is my high level takeaway.

P4c-bpf backend exists and I don't see why we wouldn't use that as a starting
point. At least the cover letter needs to explain why this path is not taken.
From the cover letter there appears to be bpf pieces and non-bpf pieces, but
I don't see any reason not to just land it all in BPF. Support exists and if
its missing some smaller things add them and everyone gets them vs niche P4
backend.

Without hardware support for any of this its impossible to understand how 'tc'
would work as a hardware offload interface for a p4 device so we need hardware
support to evaluate. For example I'm not even sure how you would take a BPF
parser into hardware on most network devices that aren't processor based.

P4 has a P4Runtime I think most folks would prefer a P4 UI vs typing in 'tc'
commands so arguing for 'tc' UI is nice is not going to be very compelling.
Best we can say is it works well enough and we use it. 

more commentary below.

> 
> The Programming Protocol-independent Packet Processors (P4) is an open source,
> domain-specific programming language for specifying data plane behavior.
> 
> The P4 ecosystem includes an extensive range of deployments, products, projects
> and services, etc[9][10][11][12].
> 
> __What is P4TC?__
> 
> P4TC is a net-namespace aware implementation, meaning multiple P4 programs can
> run independently in different namespaces alongside their appropriate state. The
> implementation builds on top of many years of Linux TC experiences.
> On why P4 - see small treatise here:[4].
> 
> There have been many discussions and meetings since about 2015 in regards to
> P4 over TC[2] and we are finally proving the naysayers that we do get stuff
> done!
> 
> A lot more of the P4TC motivation is captured at:
> https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
> 
> **In this patch series we focus on s/w datapath only**.

I don't see the value in adding 16676 lines of code for s/w only datapath
of something we already can do with p4c-ebpf backend. Or one of the other
backends already there. Namely take P4 programs and run them on CPUs in Linux.

Also I suspect a pipelined datapath is going to be slower than a O(1) lookup
datapath so I'm guessing its slower than most datapaths we have already.

What do we gain here over existing p4c-ebpf?

> 
> __P4TC Workflow__
> 
> These patches enable kernel and user space code change _independence_ for any
> new P4 program that describes a new datapath. The workflow is as follows:
> 
>   1) A developer writes a P4 program, "myprog"
> 
>   2) Compiles it using the P4C compiler[8]. The compiler generates 3 outputs:
>      a) shell script(s) which form template definitions for the different P4
>      objects "myprog" utilizes (tables, externs, actions etc).

This is odd to me. I think packing around shell scrips as a program is not
very usable. Why not just an object file.

>      b) the parser and the rest of the datapath are generated
>      in eBPF and need to be compiled into binaries.
>      c) A json introspection file used for the control plane (by iproute2/tc).

Why split up the eBPF and control plane like this? eBPF has a control plane
just use the existing one?

> 
>   3) The developer (or operator) executes the shell script(s) to manifest the
>      functional "myprog" into the kernel.
> 
>   4) The developer (or operator) instantiates "myprog" via the tc P4 filter
>      to ingress/egress (depending on P4 arch) of one or more netdevs/ports.
> 
>      Example1: parser is an action:
>        "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
>         action bpf obj $PARSER.o section parser/tc-ingress \
>         action bpf obj $PROGNAME.o section p4prog/tc"
> 
>      Example2: parser explicitly bound and rest of dpath as an action:
>        "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
>         prog tc obj $PARSER.o section parser/tc-ingress \
>         action bpf obj $PROGNAME.o section p4prog/tc"
> 
>      Example3: parser is at XDP, rest of dpath as an action:
>        "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
>         prog type xdp obj $PARSER.o section parser/xdp-ingress \
> 	pinned_link /path/to/xdp-prog-link \
>         action bpf obj $PROGNAME.o section p4prog/tc"
> 
>      Example4: parser+prog at XDP:
>        "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
>         prog type xdp obj $PROGNAME.o section p4prog/xdp \
> 	pinned_link /path/to/xdp-prog-link"
> 
>     see individual patches for more examples tc vs xdp etc. Also see section on
>     "challenges" (on this cover letter).
> 
> Once "myprog" P4 program is instantiated one can start updating table entries
> that are associated with myprog's table named "mytable". Example:
> 
>   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
>     action send_to_port param port eno1

As a UI above is entirely cryptic to most folks I bet.

myprog table is a BPF map? If so then I don't see any need for this just
interact with it like a BPF map. I suspect its some other object, but
I don't see any ratoinal for that.

> 
> A packet arriving on ingress of any of the ports on block 22 will first be
> exercised via the (eBPF) parser to find the headers pointing to the ip
> destination address.
> The remainder eBPF datapath uses the result dstAddr as a key to do a lookup in
> myprog's mytable which returns the action params which are then used to execute
> the action in the eBPF datapath (eventually sending out packets to eno1).
> On a table miss, mytable's default miss action is executed.

This chunk looks like standard BPF program. Parse pkt, lookup an action,
do the action.

> 
> __Description of Patches__
> 
> P4TC is designed to have no impact on the core code for other users
> of TC. IOW, you can compile it out but even if it compiled in and you dont use
> it there should be no impact on your performance.
> 
> We do make core kernel changes. Patch #1 adds infrastructure for "dynamic"
> actions that can be created on "the fly" based on the P4 program requirement.

the common pattern in bpf for this is to use a tail call map and populate
it at runtime and/or just compile your program with the actions. Here
the actions came from the p4 back up at step 1 so no reason we can't
just compile them with p4c.

> This patch makes a small incision into act_api which shouldn't affect the
> performance (or functionality) of the existing actions. Patches 2-4,6-7 are
> minimalist enablers for P4TC and have no effect the classical tc action.
> Patch 5 adds infrastructure support for preallocation of dynamic actions.
> 
> The core P4TC code implements several P4 objects.

[...]

> 
> __Restating Our Requirements__
> 
> The initial release made in January/2023 had a "scriptable" datapath (think u32
> classifier and pedit action). In this section we review the scriptable version
> against the current implementation we are pushing upstream which uses eBPF.
> 
> Our intention is to target the TC crowd.
> Essentially developers and ops people deploying TC based infra.
> More importantly the original intent for P4TC was to enable _ops folks_ more than
> devs (given code is being generated and doesn't need humans to write it).

I don't follow. humans wrote the p4.

I think the intent should be to enable P4 to run on Linux. Ideally efficiently.
If the _ops folks are writing P4 great as long as we give them an efficient
way to run their p4 I don't think they care about what executes it.

> 
> With TC, we get whole "familiar" package of match-action pipeline abstraction++,
> meaning from the control plane all the way to the tooling infra, i.e
> iproute2/tc cli, netlink infra(request/resp, event subscribe/multicast-publish,
> congestion control etc), s/w and h/w symbiosis, the autonomous kernel control,
> etc.
> The main advantage is that we have a singular vendor-neutral interface via the
> kernel using well understood mechanisms based on deployment experience (and
> at least this part doesnt need retraining).

A seemless p4 experience would be great. That looks like a tooling problem
at the p4c-backend and p4c-frontend problem. Rather than a bunch of 'tc' glue
I would aim for,

  $ p4c-* myprog.p4
  $ p4cRun ./myprog

And maybe some options like,

  $ p4cRun -i eth0 ./myprog

Then use the p4runtime to interface with the system. If you don't like the
runtime then it should be brought up in that working group.

> 
> 1) Supporting expressibility of the universe set of P4 progs
> 
> It is a must to support 100% of all possible P4 programs. In the past the eBPF
> verifier had to be worked around and even then there are cases where we couldnt
> avoid path explosion when branching is involved. Kfunc-ing solves these issues
> for us. Note, there are still challenges running all potential P4 programs at
> the XDP level - the solution to that is to have the compiler generate XDP based
> code only if it possible to map it to that layer.

Examples and we can fix it.

> 
> 2) Support for P4 HW and SW equivalence.
> 
> This feature continues to work even in the presence of eBPF as the s/w
> datapath. There are cases of square-hole-round-peg scenarios but
> those are implementation issues we can live with.

But no hw support.

> 
> 3) Operational usability
> 
> By maintaining the TC control plane (even in presence of eBPF datapath)
> runtime aspects remain unchanged. So for our target audience of folks
> who have deployed tc including offloads - the comfort zone is unchanged.
> There is also the comfort zone of continuing to use the true-and-tried netlink
> interfacing.

The P4 control plane should be P4Runtime.

> 
> There is some loss in operational usability because we now have more knobs:
> the extra compilation, loading and syncing of ebpf binaries, etc.
> IOW, I can no longer just ship someone a shell script in an email to
> say go run this and "myprog" will just work.
> 
> 4) Operational and development Debuggability
> 
> If something goes wrong, the tc craftsperson is now required to have additional
> knowledge of eBPF code and process. This applies to both the operational person
> as well as someone who wrote a driver. We dont believe this is solvable.
> 
> 5) Opportunity for rapid prototyping of new ideas

[...]

> 6) Supporting per namespace program
> 
> This requirement is still met (by virtue of keeping P4 control objects within the
> TC domain).

BPF can also be network namespaced I'm not sure I understand comment.

> 
> __Challenges__
> 
> 1) Concept of tc block in XDP is _very tedious_ to implement. It would be nice
>    if we can use concept there as well, since we expect P4 to work with many
>    ports. It will likely require some core patches to fix this.
> 
> 2) Right now we are using "packed" construct to enforce alignment in kfunc data
>    exchange; but we're wondering if there is potential to use BTF to understand
>    parameters and their offsets and encode this information at the compiler
>    level.
> 
> 3) At the moment we are creating a static buffer of 128B to retrieve the action
>    parameters. If you have a lot of table entries and individual(non-shared)
>    action instances with actions that require very little (or no) param space
>    a lot of memory is wasted. There may also be cases where 128B may not be
>    enough; (likely this is something we can teach the P4C compiler). If we can
>    have dynamic pointers instead for kfunc fixed length parameterization then
>    this issue is resolvable.
> 
> 4) See "Restating Our Requirements" #5.
>    We would really appreciate ideas/suggestions, etc.
> 
> __References__

Thanks,
John

