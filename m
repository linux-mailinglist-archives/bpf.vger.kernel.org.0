Return-Path: <bpf+bounces-15230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB997EF2F9
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 13:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E3D1C20AD8
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EEB30349;
	Fri, 17 Nov 2023 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pvXb/sHR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9BAD56
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 04:49:56 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7eef0b931so21422097b3.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 04:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700225395; x=1700830195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNAxIj0/yflYGUPdCd7AGcyBDkjbQtiWMLnIzQGxluU=;
        b=pvXb/sHRDorCVfCmbDrkQGyw2oBhBkzTO+/VzAKmImyOr2BtFaBO3gjUPblgX29gSQ
         4RpZjjoeunuO8YjBx97O4QLg6qj9Gdo2hAlnueie7hyx+qm+dR7Hemhr0pP7mGHNjNke
         EMZs5RnX83HHdScXshbvw7PcXuub4h+nvo7oehellRv7rh0Yv/DY7Jp6EfGtKlKO+3vv
         J5YfR/Vrlb4nqewYHSjGnU/Gl/CkTfYPwXmwAlWdnN1YDC8ymUmY0g1MiKv0gHaoPdIZ
         7J4SqI7bEsxg+3j8bCvxWjnAROboeXGvWlxqAfCgEwRDshaQxRcviFO5ejfYh4aKKgtK
         ogiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700225395; x=1700830195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNAxIj0/yflYGUPdCd7AGcyBDkjbQtiWMLnIzQGxluU=;
        b=RDfakKofowL4UkIpSbWNuIvVBv7RLejMBQQQ6iJx6qzpA+iBtFJxghabP1TT8Xv4fc
         6qtUHWvZy5AdDEc/O01+6zA2gxR5Y0DSK5qAm/3TgFgmTn4sEIS7JSqger2821ellN6Z
         zhswSm50657phtJp7KjcNg4dINNINJauMpWN6dGOmRAYZ5haEQfAVvlQBRkPprNGYYUY
         VMss7jp+cOsabFp+sM2CUDGLd/O4W2ji6XjtSPtrHRLtOMEc1fwQoNRNIp2k+PFB2Jt4
         Sv71yh3u/SqeqEKcEOEDlcSob7XSx0m1S2UxyHmXxYocBSISyoiYv3bsFoY22Zf9gZU5
         dduA==
X-Gm-Message-State: AOJu0Yx+GFjH/bK6p1rYyVaallgJ5U+rADDr8eaH7Zj1jc32NwNzvJpE
	HjpRyTAQTe4yXfjGhCgNJpDat6+sx/eY/pFu+n/4BA==
X-Google-Smtp-Source: AGHT+IEr+JU/6+XFmEPT0KKfBsZVkjxlpVba1nKZ2elVQ97ev99MWnPlR2FxQjam68ZF080qIGjJJa/C90DDS4UplFU=
X-Received: by 2002:a81:8306:0:b0:5b3:22f1:e42f with SMTP id
 t6-20020a818306000000b005b322f1e42fmr19391768ywf.26.1700225395108; Fri, 17
 Nov 2023 04:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <655707db8d55e_55d7320812@john.notmuch>
In-Reply-To: <655707db8d55e_55d7320812@john.notmuch>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 17 Nov 2023 07:49:43 -0500
Message-ID: <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	Vipin.Jain@amd.com, namrata.limaye@intel.com, tom@sipanda.io, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, dan.daly@intel.com, 
	chris.sommers@keysight.com, john.andy.fingerhut@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:27=E2=80=AFAM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Jamal Hadi Salim wrote:
> > We are seeking community feedback on P4TC patches.
> >
>
> [...]
>
> >
> > What is P4?
> > -----------
>
> I read the cover letter here is my high level takeaway.
>

At least you read the cover letter this time ;->

> P4c-bpf backend exists and I don't see why we wouldn't use that as a star=
ting
> point.

Are you familiar with P4 architectures? That code was for PSA (which
is essentially for switches) we are doing PNA (which is more nic
oriented).
And yes, we used that code as a starting point and made the necessary
changes needed to conform to PNA. We made it actually work better by
using kfuncs.

> At least the cover letter needs to explain why this path is not taken.

I thought we had a reference to that backend - but will add it for the
next update.

> From the cover letter there appears to be bpf pieces and non-bpf pieces, =
but
> I don't see any reason not to just land it all in BPF. Support exists and=
 if
> its missing some smaller things add them and everyone gets them vs niche =
P4
> backend.

Ok, i thought you said you read the cover letter. Reasons are well
stated, primarily that we need to make sure all P4 programs work.

>
> Without hardware support for any of this its impossible to understand how=
 'tc'
> would work as a hardware offload interface for a p4 device so we need har=
dware
> support to evaluate. For example I'm not even sure how you would take a B=
PF
> parser into hardware on most network devices that aren't processor based.
>

P4 has nothing to do with parsers in hardware. Where did you get this
requirement from?

> P4 has a P4Runtime I think most folks would prefer a P4 UI vs typing in '=
tc'
> commands so arguing for 'tc' UI is nice is not going to be very compellin=
g.
> Best we can say is it works well enough and we use it.


The control plane interface is netlink. This part is not negotiable.
You can write whatever you want on top of it(for example P4runtime
using netlink as its southbound interface). We feel that tc - a well
understood utility - is one we should make publicly available for the
rest of the world to use. For example we have rust code that runs on
top of netlink to do performance testing.

> more commentary below.
>
> >
> > The Programming Protocol-independent Packet Processors (P4) is an open =
source,
> > domain-specific programming language for specifying data plane behavior=
.
> >
> > The P4 ecosystem includes an extensive range of deployments, products, =
projects
> > and services, etc[9][10][11][12].
> >
> > __What is P4TC?__
> >
> > P4TC is a net-namespace aware implementation, meaning multiple P4 progr=
ams can
> > run independently in different namespaces alongside their appropriate s=
tate. The
> > implementation builds on top of many years of Linux TC experiences.
> > On why P4 - see small treatise here:[4].
> >
> > There have been many discussions and meetings since about 2015 in regar=
ds to
> > P4 over TC[2] and we are finally proving the naysayers that we do get s=
tuff
> > done!
> >
> > A lot more of the P4TC motivation is captured at:
> > https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
> >
> > **In this patch series we focus on s/w datapath only**.
>
> I don't see the value in adding 16676 lines of code for s/w only datapath
> of something we already can do with p4c-ebpf backend.

Please please stop this entitlement politics (which i frankly think
you guys have been getting away with for a few years now).
This code does not touch any core code - you guys constantly push code
that touches core code and it is not unusual we have to pick up the
pieces after but now you are going to call me out for the number of
lines of code? Is it ok for you to write lines of code in the kernel
but not me? Judge the technical work then we can have a meaningful
discussion.

TBH, I am trying very hard to see if i should respond to any more
comments from you. I was very happy with our original scriptable
approach and you came out and banged on the table that you want ebpf.
We spent 10 months of multiple people working on this code to make it
ebpf friendly and now you want more (actually i am not sure what the
hell you want).

> Or one of the other
> backends already there. Namely take P4 programs and run them on CPUs in L=
inux.
>
> Also I suspect a pipelined datapath is going to be slower than a O(1) loo=
kup
> datapath so I'm guessing its slower than most datapaths we have already.
>
> What do we gain here over existing p4c-ebpf?
>

see above.

> >
> > __P4TC Workflow__
> >
> > These patches enable kernel and user space code change _independence_ f=
or any
> > new P4 program that describes a new datapath. The workflow is as follow=
s:
> >
> >   1) A developer writes a P4 program, "myprog"
> >
> >   2) Compiles it using the P4C compiler[8]. The compiler generates 3 ou=
tputs:
> >      a) shell script(s) which form template definitions for the differe=
nt P4
> >      objects "myprog" utilizes (tables, externs, actions etc).
>
> This is odd to me. I think packing around shell scrips as a program is no=
t
> very usable. Why not just an object file.
>
> >      b) the parser and the rest of the datapath are generated
> >      in eBPF and need to be compiled into binaries.
> >      c) A json introspection file used for the control plane (by iprout=
e2/tc).
>
> Why split up the eBPF and control plane like this? eBPF has a control pla=
ne
> just use the existing one?
>

The cover letter clearly states that we are using netlink as the
control api. Does eBPF support netlink?

> >
> >   3) The developer (or operator) executes the shell script(s) to manife=
st the
> >      functional "myprog" into the kernel.
> >
> >   4) The developer (or operator) instantiates "myprog" via the tc P4 fi=
lter
> >      to ingress/egress (depending on P4 arch) of one or more netdevs/po=
rts.
> >
> >      Example1: parser is an action:
> >        "tc filter add block 22 ingress protocol all prio 10 p4 pname my=
prog \
> >         action bpf obj $PARSER.o section parser/tc-ingress \
> >         action bpf obj $PROGNAME.o section p4prog/tc"
> >
> >      Example2: parser explicitly bound and rest of dpath as an action:
> >        "tc filter add block 22 ingress protocol all prio 10 p4 pname my=
prog \
> >         prog tc obj $PARSER.o section parser/tc-ingress \
> >         action bpf obj $PROGNAME.o section p4prog/tc"
> >
> >      Example3: parser is at XDP, rest of dpath as an action:
> >        "tc filter add block 22 ingress protocol all prio 10 p4 pname my=
prog \
> >         prog type xdp obj $PARSER.o section parser/xdp-ingress \
> >       pinned_link /path/to/xdp-prog-link \
> >         action bpf obj $PROGNAME.o section p4prog/tc"
> >
> >      Example4: parser+prog at XDP:
> >        "tc filter add block 22 ingress protocol all prio 10 p4 pname my=
prog \
> >         prog type xdp obj $PROGNAME.o section p4prog/xdp \
> >       pinned_link /path/to/xdp-prog-link"
> >
> >     see individual patches for more examples tc vs xdp etc. Also see se=
ction on
> >     "challenges" (on this cover letter).
> >
> > Once "myprog" P4 program is instantiated one can start updating table e=
ntries
> > that are associated with myprog's table named "mytable". Example:
> >
> >   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> >     action send_to_port param port eno1
>
> As a UI above is entirely cryptic to most folks I bet.
>

But ebpf is not?

> myprog table is a BPF map? If so then I don't see any need for this just
> interact with it like a BPF map. I suspect its some other object, but
> I don't see any ratoinal for that.

All the P4 objects sit in the TC domain. The datapath program is ebpf.
Control is via netlink.


> >
> > A packet arriving on ingress of any of the ports on block 22 will first=
 be
> > exercised via the (eBPF) parser to find the headers pointing to the ip
> > destination address.
> > The remainder eBPF datapath uses the result dstAddr as a key to do a lo=
okup in
> > myprog's mytable which returns the action params which are then used to=
 execute
> > the action in the eBPF datapath (eventually sending out packets to eno1=
).
> > On a table miss, mytable's default miss action is executed.
>
> This chunk looks like standard BPF program. Parse pkt, lookup an action,
> do the action.
>

Yes, the ebpf datapath does the parsing, and then interacts with
kfuncs to the tc world before it (the ebpf datapath) executes the
action.
Note: ebpf did not invent any of that (parse, lookup, action). It has
existed in tc for 20 years before ebpf existed.

> > __Description of Patches__
> >
> > P4TC is designed to have no impact on the core code for other users
> > of TC. IOW, you can compile it out but even if it compiled in and you d=
ont use
> > it there should be no impact on your performance.
> >
> > We do make core kernel changes. Patch #1 adds infrastructure for "dynam=
ic"
> > actions that can be created on "the fly" based on the P4 program requir=
ement.
>
> the common pattern in bpf for this is to use a tail call map and populate
> it at runtime and/or just compile your program with the actions. Here
> the actions came from the p4 back up at step 1 so no reason we can't
> just compile them with p4c.
>
> > This patch makes a small incision into act_api which shouldn't affect t=
he
> > performance (or functionality) of the existing actions. Patches 2-4,6-7=
 are
> > minimalist enablers for P4TC and have no effect the classical tc action=
.
> > Patch 5 adds infrastructure support for preallocation of dynamic action=
s.
> >
> > The core P4TC code implements several P4 objects.
>
> [...]
>
> >
> > __Restating Our Requirements__
> >
> > The initial release made in January/2023 had a "scriptable" datapath (t=
hink u32
> > classifier and pedit action). In this section we review the scriptable =
version
> > against the current implementation we are pushing upstream which uses e=
BPF.
> >
> > Our intention is to target the TC crowd.
> > Essentially developers and ops people deploying TC based infra.
> > More importantly the original intent for P4TC was to enable _ops folks_=
 more than
> > devs (given code is being generated and doesn't need humans to write it=
).
>
> I don't follow. humans wrote the p4.
>

But not the ebpf code, that is compiler generated. P4 is a higher
level Domain specific language and ebpf is just one backend (others
s/w variants include DPDK, Rust, C, etc)

> I think the intent should be to enable P4 to run on Linux. Ideally effici=
ently.
> If the _ops folks are writing P4 great as long as we give them an efficie=
nt
> way to run their p4 I don't think they care about what executes it.
>
> >
> > With TC, we get whole "familiar" package of match-action pipeline abstr=
action++,
> > meaning from the control plane all the way to the tooling infra, i.e
> > iproute2/tc cli, netlink infra(request/resp, event subscribe/multicast-=
publish,
> > congestion control etc), s/w and h/w symbiosis, the autonomous kernel c=
ontrol,
> > etc.
> > The main advantage is that we have a singular vendor-neutral interface =
via the
> > kernel using well understood mechanisms based on deployment experience =
(and
> > at least this part doesnt need retraining).
>
> A seemless p4 experience would be great. That looks like a tooling proble=
m
> at the p4c-backend and p4c-frontend problem. Rather than a bunch of 'tc' =
glue
> I would aim for,
>
>   $ p4c-* myprog.p4
>   $ p4cRun ./myprog
>
> And maybe some options like,
>
>   $ p4cRun -i eth0 ./myprog

Armchair lawyering and classical ML bikesheding

> Then use the p4runtime to interface with the system. If you don't like th=
e
> runtime then it should be brought up in that working group.
>
> >
> > 1) Supporting expressibility of the universe set of P4 progs
> >
> > It is a must to support 100% of all possible P4 programs. In the past t=
he eBPF
> > verifier had to be worked around and even then there are cases where we=
 couldnt
> > avoid path explosion when branching is involved. Kfunc-ing solves these=
 issues
> > for us. Note, there are still challenges running all potential P4 progr=
ams at
> > the XDP level - the solution to that is to have the compiler generate X=
DP based
> > code only if it possible to map it to that layer.
>
> Examples and we can fix it.

Right. Let me wait for you to fix something 5 years from now. I would
never have used eBPF at all but the kfunc is what changed my mind.

> >
> > 2) Support for P4 HW and SW equivalence.
> >
> > This feature continues to work even in the presence of eBPF as the s/w
> > datapath. There are cases of square-hole-round-peg scenarios but
> > those are implementation issues we can live with.
>
> But no hw support.
>

This patcheset has nothing to do with offload (you read the cover
letter?). All above is saying is that by virtue of using TC we have a
path to a proven offload approach.


> >
> > 3) Operational usability
> >
> > By maintaining the TC control plane (even in presence of eBPF datapath)
> > runtime aspects remain unchanged. So for our target audience of folks
> > who have deployed tc including offloads - the comfort zone is unchanged=
.
> > There is also the comfort zone of continuing to use the true-and-tried =
netlink
> > interfacing.
>
> The P4 control plane should be P4Runtime.
>

And be my guest and write it on top of netlink.

cheers,
jamal

> >
> > There is some loss in operational usability because we now have more kn=
obs:
> > the extra compilation, loading and syncing of ebpf binaries, etc.
> > IOW, I can no longer just ship someone a shell script in an email to
> > say go run this and "myprog" will just work.
> >
> > 4) Operational and development Debuggability
> >
> > If something goes wrong, the tc craftsperson is now required to have ad=
ditional
> > knowledge of eBPF code and process. This applies to both the operationa=
l person
> > as well as someone who wrote a driver. We dont believe this is solvable=
.
> >
> > 5) Opportunity for rapid prototyping of new ideas
>
> [...]
>
> > 6) Supporting per namespace program
> >
> > This requirement is still met (by virtue of keeping P4 control objects =
within the
> > TC domain).
>
> BPF can also be network namespaced I'm not sure I understand comment.
>
> >
> > __Challenges__
> >
> > 1) Concept of tc block in XDP is _very tedious_ to implement. It would =
be nice
> >    if we can use concept there as well, since we expect P4 to work with=
 many
> >    ports. It will likely require some core patches to fix this.
> >
> > 2) Right now we are using "packed" construct to enforce alignment in kf=
unc data
> >    exchange; but we're wondering if there is potential to use BTF to un=
derstand
> >    parameters and their offsets and encode this information at the comp=
iler
> >    level.
> >
> > 3) At the moment we are creating a static buffer of 128B to retrieve th=
e action
> >    parameters. If you have a lot of table entries and individual(non-sh=
ared)
> >    action instances with actions that require very little (or no) param=
 space
> >    a lot of memory is wasted. There may also be cases where 128B may no=
t be
> >    enough; (likely this is something we can teach the P4C compiler). If=
 we can
> >    have dynamic pointers instead for kfunc fixed length parameterizatio=
n then
> >    this issue is resolvable.
> >
> > 4) See "Restating Our Requirements" #5.
> >    We would really appreciate ideas/suggestions, etc.
> >
> > __References__
>
> Thanks,
> John

