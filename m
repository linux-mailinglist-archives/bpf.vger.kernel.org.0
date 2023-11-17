Return-Path: <bpf+bounces-15269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D87EF8D6
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809901F22EAD
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125343AB0;
	Fri, 17 Nov 2023 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Fv7Q73MT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7330D6C
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:46:24 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5afa5dbc378so26090477b3.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700253984; x=1700858784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyZLgdoMVhVde2G47TENvulS187Zd3Km8zA2ZXmEY3A=;
        b=Fv7Q73MTN3oPyJARlLD47bNbHI+8Q2jMMsZpsttxm6gYd1z0zYlQVPZB0LyEVTEyln
         /sQo7/c8UzeE4km2Nv0N4sleZE6ux6PHW4Cf7lbfbfA5QhWSLLuEue04zSC8xT7VjHZp
         DYLax+xpQW1Yik7kdTY0srM8E7MlpaN51dP12CXw2/T3rSYXQ6nnRlfid50hUCU16BK3
         YuR05J/7CpNzVGcekUqVg+tuPw6DuSajjjfd/1jHqdfUM47bbA+iA1rSfjVco1AvZKFw
         CZuULrPoUd/Ociv18WaPWX55iAPaLrxWqzW2prGNb+sDm4dZbRv2FWTBGt6w51qrQBQz
         ftaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700253984; x=1700858784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyZLgdoMVhVde2G47TENvulS187Zd3Km8zA2ZXmEY3A=;
        b=Ocb0iO/+OCnOCCySecX0MoSPbUI3EELxuHZoGxuSnwy9KlOyOnvBCAacDAg4ccObvF
         wikmpNrQy1bSMNTimnvzC+/eiyvQ3+p2rlTb+U2Djgidk1r3vur4MH5jyB6NiXrB8asj
         HBWywjcEiOWxN/1IjlTn+uAgC/q/JEmUYcNvlq9Kslgx8aBuooWlwK+zgU5D/ncUoaKG
         X0+mTY2dDdfS7FYCulGFbQjILoSq9ghJusUG2z+KGBqn7tHBJBHX/HM0gm2PWgKTqMyz
         yZFBahVjNOyoefbJvXK2XT+35WbROsjbpRd5BPcT+Y3/NCvP1fI6WaKBy/wLqEjHMWk/
         Yejw==
X-Gm-Message-State: AOJu0YxV2BN4KankhxiyJKTmzCtbpOZQz2wbL+fZ8ElFSe0030j9dBN6
	/oreU9ToeG/GeGlko4u5GtqA2noXxEKLV2gcLwcooQ==
X-Google-Smtp-Source: AGHT+IF2OGIykeQR++1HttE8X0QKMm811upfiC/Q6i/iDPdnhJ5fk2M4LWwFYXWiBj/NEjreak7M+ZCD07J/kwmlmf0=
X-Received: by 2002:a81:8493:0:b0:5be:94a6:d84a with SMTP id
 u141-20020a818493000000b005be94a6d84amr888438ywf.20.1700253983469; Fri, 17
 Nov 2023 12:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com> <6557b2e5f3489_5ada920871@john.notmuch>
In-Reply-To: <6557b2e5f3489_5ada920871@john.notmuch>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 17 Nov 2023 15:46:11 -0500
Message-ID: <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
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

On Fri, Nov 17, 2023 at 1:37=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Jamal Hadi Salim wrote:
> > On Fri, Nov 17, 2023 at 1:27=E2=80=AFAM John Fastabend <john.fastabend@=
gmail.com> wrote:
> > >
> > > Jamal Hadi Salim wrote:
> > > > We are seeking community feedback on P4TC patches.
> > > >
> > >
> > > [...]
> > >
> > > >
> > > > What is P4?
> > > > -----------
> > >
> > > I read the cover letter here is my high level takeaway.
> > >
> >
> > At least you read the cover letter this time ;->
>
> I read it last time as well. About mid way down I tried to
> list the points (1-5) more concisely if folks want to get to the
> meat of my argument quickly.

You wrote an essay - i will just jump to your points further down the
text below and try and summarize it...

> > > P4c-bpf backend exists and I don't see why we wouldn't use that as a =
starting
> > > point.
> >
> > Are you familiar with P4 architectures? That code was for PSA (which
> > is essentially for switches) we are doing PNA (which is more nic
> > oriented).
>
> Yes. But for folks that are not PSA is a switch architecture it
> looks roughly like this,
>
>    parser -> ingress -> deparser -> pkt replication -> parser
>                                                         -> egress
>                                                            -> deparser
>                                                              -> queueing
>
> The gist is ingress/egress blocks hold your p4 logic (match action
> tables usually) to xfrm headers, counters, registers, and so on. You
> get one on ingress and one on egress to build your logic up.
>
> And PNA is a roughly like this,
>
>    ingress -> parser -> control -> deparser -> accelerators -> host | net=
work
>
> An accelerators are externs more or less defined outside P4. Control has
> all your metrics, header transforms, registers, and so on. And parser
> well it parsers headers. Deparser is something we don't typically think
> about much on sw side but it serializes the object back into a packet.
> That is a rough couple line explanation.
>
> You can also define whatever architecture like and there are some
> ways to do that. But if you want to be a PSA or PNA you define those
> blocks in your P4. The key idea is to have architectures that map
> to a large set of different vendor hardware. Clearly sw and FPGAs
> can build mostly any architecture needed.
>
> As an editorial comment P4 is very much a hardware centric view of
> the world when looking at P4 architectures. SW never needed these
> because we mostly have general purpose CPUs.
>
> > And yes, we used that code as a starting point and made the necessary
> > changes needed to conform to PNA. We made it actually work better by
> > using kfuncs.
>
> Better performance? More P4 DSL program space implemented? The kfuncs
> added are equivelant to map ops already in BPF but over 'tc' map types.
> Or did I miss some kfuncs.
>
> The p4c-ebpf backend already supports two models we could have added
> the PNA model to it as well. Its actually simpler than PSA model
> in many ways at least its fewer blocks. I think all this infrastructure
> here could be unesseary with updates to p4c-ebpf.
>
> >
> > > At least the cover letter needs to explain why this path is not taken=
.
> >
> > I thought we had a reference to that backend - but will add it for the
> > next update.
> >
> > > From the cover letter there appears to be bpf pieces and non-bpf piec=
es, but
> > > I don't see any reason not to just land it all in BPF. Support exists=
 and if
> > > its missing some smaller things add them and everyone gets them vs ni=
che P4
> > > backend.
> >
> > Ok, i thought you said you read the cover letter. Reasons are well
> > stated, primarily that we need to make sure all P4 programs work.
>
> I don't think that is a very strong argument to use/build a p4c-tc
> architecture and implementation instead of p4c-ebpf. I can't think
> of any reason p4c-ebpf can't support all programs other than perhaps
> its missing a few items. From a design side though it should be
> capabable of any PSA, PNA, and many more architectures you come up
> with.
>
> And I'm genuinely curious what is missing so a list would be nice.
> The missing block perhaps is a perfomant software TCAM, but I'm
> not fully convinced that software should even bother to try and
> duplicate a TCAM. If you need a performant TCAM buy hw with a TCAM
> emulating one is always going to be slower. Have Intel/AMD/ARM
> glue a TCAM to the core if its so useful.
>
> To be clear p4c-tc is only targeting PNA programs not all P4 space.
>
> >
> > >
> > > Without hardware support for any of this its impossible to understand=
 how 'tc'
> > > would work as a hardware offload interface for a p4 device so we need=
 hardware
> > > support to evaluate. For example I'm not even sure how you would take=
 a BPF
> > > parser into hardware on most network devices that aren't processor ba=
sed.
> > >
> >
> > P4 has nothing to do with parsers in hardware. Where did you get this
> > requirement from?
>
> P4 is/was primarily developed as a DSL to program hardware. We've
> never figured out how to do a native Linux P4 controller for hardware.
> There are a couple blockers for that in my opinion. First no one
> has ever opened up the hardware to an OSS solution. Two its
> never been entirely clear what the big win for enough people would be.
> So we get targetted offloads, timestamp, vxlan, tso, ktls, even
> heard quic offload yesterday. And its easy enough to just program
> the hardware directly from user space.
>
> So yes I think P4 has a lot to do with hardware, its probably
> fair to say this p4c-tc thing isn't hardware. But, I think its
> very limiting and the value of any p4 implementation in kernel
> would be its ability to use hardware.
>
> I'm not even convinced P4 is a good DSL for SW implementations.
> I don't think its obvious how hw P4 and sw datapaths integrate
> effectively. My opinion is p4c-tc is not moving us forward
> here.
>
> >
> > > P4 has a P4Runtime I think most folks would prefer a P4 UI vs typing =
in 'tc'
> > > commands so arguing for 'tc' UI is nice is not going to be very compe=
lling.
> > > Best we can say is it works well enough and we use it.
> >
> >
> > The control plane interface is netlink. This part is not negotiable.
> > You can write whatever you want on top of it(for example P4runtime
> > using netlink as its southbound interface). We feel that tc - a well
>
> Sure we need a low level interface for p4runtime to use and I
> agree we don't need all blocks done at once.
>
> > understood utility - is one we should make publicly available for the
> > rest of the world to use. For example we have rust code that runs on
> > top of netlink to do performance testing.
>
> If updates/lookups from userspace is a performance vector you
> care about I can't see how netlink is more efficient than a
> mmapped bpf map. If you have data share it, but it seems
> highly unlikely.
>
> The argument I'm trying to make is netlink vs bpf maps vs
> some other goo shouldn't matter to users because we should
> build them higher level tooling to interact with the p4
> objects. Then it comes down to performance in my opinion.
> And if map updates matter I suspect netlink is relatively
> slow.
>
> >
> > > more commentary below.
> > >
> > > >
> > > > The Programming Protocol-independent Packet Processors (P4) is an o=
pen source,
> > > > domain-specific programming language for specifying data plane beha=
vior.
> > > >
> > > > The P4 ecosystem includes an extensive range of deployments, produc=
ts, projects
> > > > and services, etc[9][10][11][12].
> > > >
> > > > __What is P4TC?__
> > > >
> > > > P4TC is a net-namespace aware implementation, meaning multiple P4 p=
rograms can
> > > > run independently in different namespaces alongside their appropria=
te state. The
> > > > implementation builds on top of many years of Linux TC experiences.
> > > > On why P4 - see small treatise here:[4].
> > > >
> > > > There have been many discussions and meetings since about 2015 in r=
egards to
> > > > P4 over TC[2] and we are finally proving the naysayers that we do g=
et stuff
> > > > done!
> > > >
> > > > A lot more of the P4TC motivation is captured at:
> > > > https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
> > > >
> > > > **In this patch series we focus on s/w datapath only**.
> > >
> > > I don't see the value in adding 16676 lines of code for s/w only data=
path
> > > of something we already can do with p4c-ebpf backend.
> >
> > Please please stop this entitlement politics (which i frankly think
> > you guys have been getting away with for a few years now).
>
> I'm allowed to disagree with your architecture and propose what I think
> is a betteer way to translate P4 into software.
>
> Its common to argue against adding new code if it duplicates functionalit=
y
> we already support.
>
> > This code does not touch any core code - you guys constantly push code
> > that touches core code and it is not unusual we have to pick up the
> > pieces after but now you are going to call me out for the number of
> > lines of code? Is it ok for you to write lines of code in the kernel
> > but not me? Judge the technical work then we can have a meaningful
> > discussion.
>
> I think I'm judging the technical work here. Bullet points.
>
> 1. p4c-tc implementation looks like it should be slower than a
>    in terms of pkts/sec than a bpf implementation. Meaning
>    I suspect pipeline and objects laid out like this will lose
>    to a BPF program with an parser and single lookup. The p4c-ebpf
>    compiler should look to create optimized EBPF code not some
>    emulated switch topology.
>

The parser is ebpf based. The other objects which require control
plane interaction are not - those interact via netlink.
We published perf data a while back - presented at the P4 workshop
back in April (was in the cover letter)
https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4Worksho=
pP4TC.pdf
But do note: the correct abstraction is the first priority.
Optimization is something we can teach the compiler over time. But
even with the minimalist code generation you can see that our approach
always beats ebpf in LPM and ternary. The other ones I am pretty sure
we can optimize over time.
Your view of "single lookup" is true for simple programs but if you
have 10 tables trying to model a 5G function then it doesnt make sense
(and i think the data we published was clear that you gain no
advantage using ebpf - as a matter of fact there was no perf
difference between XDP and tc in such cases).

> 2. p4c-tc control plan looks slower than a directly mmaped bpf
>    map. Doing a simple update vs a netlink msg. The argument
>    that BPF can't do CRUD (which we had offlist) seems incorrect
>    to me. Correct me if I'm wrong with details about why.
>

So let me see....
you want me to replace netlink and all its features and rewrite it
using the ebpf system calls? Congestion control, event handling,
arbitrary message crafting, etc and the years of work that went into
netlink? NO to the HELL.
I should note: that there was an interesting talk at netdevconf 0x17
where the speaker showed the challenges of dealing with ebpf on "day
two" - slides or videos are not up yet, but link is:
https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-yet-a-small=
-step-to-one-server-but-giant-leap-to-distributed-network.html
The point the speaker was making is it's always easy to whip an ebpf
program that can slice and dice packets and maybe even flush LEDs but
the real work and challenge is in the control plane. I agree with the
speaker based on my experiences. This discussion of replacing netlink
with ebpf system calls is absolutely a non-starter. Let's just end the
discussion and agree to disagree if you are going to keep insisting on
that.

> 2. I don't see why ebpf can not support all P4 programs. Because
>    the DSL compiler side doesn't support the nic architecture
>    side to me indicates fixing the compiler is the direction
>    not pushing on the kernel.
>

Wrestling with the verifier, different version of toolchains, etc.
This is not just a problem we are facing, but about everyone out there
that tries to do something serious with ebpf  eventually hits these
issues. Kfuncs really opened the door for us (i think it improved
usability of ebpf by probably orders of magnitude). Without kfuncs i
would not have even considered ebpf - and did i say i was fine with
u32 and pedit approach we had.

> 3. Working in BPF framework will benefit more folks than a tc
>    framework. I just don't see a large user base of P4 software
>    running on Linux. It doesn't mean we can't have it in linux,
>    but worth considering. We have lots of niche stuff in the
>    kernel, but usually the niche thing doesn't have another
>    more common way to run it.
>

To each their itch - that's what open source is about. This is our
itch. You dont have to like it nor use it.  There are a lot of things
i dont like in the kernel and would never use. Saying you dont see a
"large user base of P4 software on Linux" is handwaving at best. Under
what metric do you reach such a conclusion? The fact that i can
describe something in a _simple_ high level language like P4 and get
low level ebpf for free is of great value. I dont need to go and look
for an ebpf expert to hand code things for me.

> 4. The win for P4 is not sw implementation. Its about getting
>    programmable hardware and this doesn't advance that goal
>    in any meaningful way as far as I can see.

And all the s/w incarnations of P4 out there would disagree with you.
The fact that P4 has use in h/w doesnt disqualify it from being useful
in s/w.

> 5. By pushing the P4 model so low in the stack of tooling
>    you lose ability for compiler to do interesting things.
>    Combining match action tables, converting them to
>    switch statements or jumps, finding inverse operations
>    and removing them. I still think there is lots of unexplored
>    work on compiling P4 that has not been done.
>

And that can be done over time unless you are saying it is impossible.
ebpf !=3D P4, they are two different levels of expression. eBPF is just
a tool to get us there and nothing more.

cheers,
jamal

> >
> > TBH, I am trying very hard to see if i should respond to any more
> > comments from you. I was very happy with our original scriptable
> > approach and you came out and banged on the table that you want ebpf.
> > We spent 10 months of multiple people working on this code to make it
> > ebpf friendly and now you want more (actually i am not sure what the
> > hell you want).
>
> I've made the above arguments on early versions of the code,
> and when we talked, and even offered it in p4 working group.
> It shouldn't be surprising I've not changed my opinion.
>
> Its a argument against duplicating existing functionality with
> something that is slower and doesn't give us HW P4 support. The
> bullets above.
>
>
> >
> > > Or one of the other
> > > backends already there. Namely take P4 programs and run them on CPUs =
in Linux.
> > >
> > > Also I suspect a pipelined datapath is going to be slower than a O(1)=
 lookup
> > > datapath so I'm guessing its slower than most datapaths we have alrea=
dy.
> > >
> > > What do we gain here over existing p4c-ebpf?
> > >
> >
> > see above.
>
> We are talking past eachother becaus here I argue it looks like a slow
> datapath and you say 'see above' but what above was I meant to see?
> That it doesn't have PNA support? Compared to PSA doing a PNA support
> should be straightforward.
>
> I disagree that software should try to emulate hardware to closely.
> They are fundamentally different platforms. One has CAMs, TCAMs,
> and LPMs and obscure instruction sets to make all this work. The other
> is working on a general purpose CPU. I think slamming a hardware
> architecture into software with emulated TCAMs and what not,
> will be a losing performance proposition. Experience shows you can
> either go SIMD direction and parrallize everything with these instruction=
s
> or you reduce the datapath to a single (or minimal set) of lookups.
> Find a counter-example.
>
> >
> > > >
> > > > __P4TC Workflow__
> > > >
> > > > These patches enable kernel and user space code change _independenc=
e_ for any
> > > > new P4 program that describes a new datapath. The workflow is as fo=
llows:
> > > >
> > > >   1) A developer writes a P4 program, "myprog"
> > > >
> > > >   2) Compiles it using the P4C compiler[8]. The compiler generates =
3 outputs:
> > > >      a) shell script(s) which form template definitions for the dif=
ferent P4
> > > >      objects "myprog" utilizes (tables, externs, actions etc).
> > >
> > > This is odd to me. I think packing around shell scrips as a program i=
s not
> > > very usable. Why not just an object file.
> > >
> > > >      b) the parser and the rest of the datapath are generated
> > > >      in eBPF and need to be compiled into binaries.
> > > >      c) A json introspection file used for the control plane (by ip=
route2/tc).
> > >
> > > Why split up the eBPF and control plane like this? eBPF has a control=
 plane
> > > just use the existing one?
> > >
> >
> > The cover letter clearly states that we are using netlink as the
> > control api. Does eBPF support netlink?
>
> But why? The statement is there but no rational is given. People are
> used to it was maybe stated, but my argument is users of P4 shouldn't
> be crafting netlink messages they need tooling if its netlink or BPF
> or some new thing. So pick the most efficient tool for the job. Why
> is netlink the most efficient option here.
>
> >
> > > >
> > > >   3) The developer (or operator) executes the shell script(s) to ma=
nifest the
> > > >      functional "myprog" into the kernel.
> > > >
> > > >   4) The developer (or operator) instantiates "myprog" via the tc P=
4 filter
> > > >      to ingress/egress (depending on P4 arch) of one or more netdev=
s/ports.
> > > >
> > > >      Example1: parser is an action:
> > > >        "tc filter add block 22 ingress protocol all prio 10 p4 pnam=
e myprog \
> > > >         action bpf obj $PARSER.o section parser/tc-ingress \
> > > >         action bpf obj $PROGNAME.o section p4prog/tc"
> > > >
> > > >      Example2: parser explicitly bound and rest of dpath as an acti=
on:
> > > >        "tc filter add block 22 ingress protocol all prio 10 p4 pnam=
e myprog \
> > > >         prog tc obj $PARSER.o section parser/tc-ingress \
> > > >         action bpf obj $PROGNAME.o section p4prog/tc"
> > > >
> > > >      Example3: parser is at XDP, rest of dpath as an action:
> > > >        "tc filter add block 22 ingress protocol all prio 10 p4 pnam=
e myprog \
> > > >         prog type xdp obj $PARSER.o section parser/xdp-ingress \
> > > >       pinned_link /path/to/xdp-prog-link \
> > > >         action bpf obj $PROGNAME.o section p4prog/tc"
> > > >
> > > >      Example4: parser+prog at XDP:
> > > >        "tc filter add block 22 ingress protocol all prio 10 p4 pnam=
e myprog \
> > > >         prog type xdp obj $PROGNAME.o section p4prog/xdp \
> > > >       pinned_link /path/to/xdp-prog-link"
> > > >
> > > >     see individual patches for more examples tc vs xdp etc. Also se=
e section on
> > > >     "challenges" (on this cover letter).
> > > >
> > > > Once "myprog" P4 program is instantiated one can start updating tab=
le entries
> > > > that are associated with myprog's table named "mytable". Example:
> > > >
> > > >   tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
> > > >     action send_to_port param port eno1
> > >
> > > As a UI above is entirely cryptic to most folks I bet.
> > >
> >
> > But ebpf is not?
>
> We don't need everything out the gate but my point is that the UI
> should be abstracted away from the P4 programmer and operator at
> this level. My observation that 'tc' is cryptic was just an off-hand
> comment I don't think its relevant to the overall argument for or against=
,
> what we should understand is how to map p4runtime or at least a
> operator friendly UI onto the semantics.
>
> >
> > > myprog table is a BPF map? If so then I don't see any need for this j=
ust
> > > interact with it like a BPF map. I suspect its some other object, but
> > > I don't see any ratoinal for that.
> >
> > All the P4 objects sit in the TC domain. The datapath program is ebpf.
> > Control is via netlink.
>
> I'm missing something fundamental. What do we gain from this TC domain.
> There are some TC maps for LPM and TCAMs we have LPM already in BPF
> and TCAM you have could easily be added if you want to. Then entire
> program runs to completion. Surely this is more performant. Throw in
> XDP and the redirect never leaves the NIC, no skb, etc.
>
> From the architecture side I don't think we need kernel objects
> for pipelines and some P4 notion of match action tables those
> can all be mapped into the BPF program. The packet never leaves
> XDP. Performance is good on datapath and performance is good
> on map update side. It looks like noise to me teaching the kernel
> about P4 objects and types. More importantly you are constraining
> the optimizations the compiler can make. Perhaps the compiler
> wants no map at all and implements it as a switch stmt for
> example. Maybe the compiler can find inverse operations and
> fastpaths to short circuit. By forcing the model so low in
> the stack you remove this ability.
>
> >
> >
> > > >
> > > > A packet arriving on ingress of any of the ports on block 22 will f=
irst be
> > > > exercised via the (eBPF) parser to find the headers pointing to the=
 ip
> > > > destination address.
> > > > The remainder eBPF datapath uses the result dstAddr as a key to do =
a lookup in
> > > > myprog's mytable which returns the action params which are then use=
d to execute
> > > > the action in the eBPF datapath (eventually sending out packets to =
eno1).
> > > > On a table miss, mytable's default miss action is executed.
> > >
> > > This chunk looks like standard BPF program. Parse pkt, lookup an acti=
on,
> > > do the action.
> > >
> >
> > Yes, the ebpf datapath does the parsing, and then interacts with
> > kfuncs to the tc world before it (the ebpf datapath) executes the
> > action.
> > Note: ebpf did not invent any of that (parse, lookup, action). It has
> > existed in tc for 20 years before ebpf existed.
>
> Its not about who invented what. All this goes way back.
>
> My point is the 'tc' world here looks unnecessary. It can be managed
> from outside the kernel entirely.
>
> >
> > > > __Description of Patches__
> > > >
> > > > P4TC is designed to have no impact on the core code for other users
> > > > of TC. IOW, you can compile it out but even if it compiled in and y=
ou dont use
> > > > it there should be no impact on your performance.
> > > >
> > > > We do make core kernel changes. Patch #1 adds infrastructure for "d=
ynamic"
> > > > actions that can be created on "the fly" based on the P4 program re=
quirement.
> > >
> > > the common pattern in bpf for this is to use a tail call map and popu=
late
> > > it at runtime and/or just compile your program with the actions. Here
> > > the actions came from the p4 back up at step 1 so no reason we can't
> > > just compile them with p4c.
> > >
> > > > This patch makes a small incision into act_api which shouldn't affe=
ct the
> > > > performance (or functionality) of the existing actions. Patches 2-4=
,6-7 are
> > > > minimalist enablers for P4TC and have no effect the classical tc ac=
tion.
> > > > Patch 5 adds infrastructure support for preallocation of dynamic ac=
tions.
> > > >
> > > > The core P4TC code implements several P4 objects.
> > >
> > > [...]
> > >
> > > >
> > > > __Restating Our Requirements__
> > > >
> > > > The initial release made in January/2023 had a "scriptable" datapat=
h (think u32
> > > > classifier and pedit action). In this section we review the scripta=
ble version
> > > > against the current implementation we are pushing upstream which us=
es eBPF.
> > > >
> > > > Our intention is to target the TC crowd.
> > > > Essentially developers and ops people deploying TC based infra.
> > > > More importantly the original intent for P4TC was to enable _ops fo=
lks_ more than
> > > > devs (given code is being generated and doesn't need humans to writ=
e it).
> > >
> > > I don't follow. humans wrote the p4.
> > >
> >
> > But not the ebpf code, that is compiler generated. P4 is a higher
> > level Domain specific language and ebpf is just one backend (others
> > s/w variants include DPDK, Rust, C, etc)
>
> Yes. I still don't follow. Of course ebpf is just one backend.
>
> >
> > > I think the intent should be to enable P4 to run on Linux. Ideally ef=
ficiently.
> > > If the _ops folks are writing P4 great as long as we give them an eff=
icient
> > > way to run their p4 I don't think they care about what executes it.
> > >
> > > >
> > > > With TC, we get whole "familiar" package of match-action pipeline a=
bstraction++,
> > > > meaning from the control plane all the way to the tooling infra, i.=
e
> > > > iproute2/tc cli, netlink infra(request/resp, event subscribe/multic=
ast-publish,
> > > > congestion control etc), s/w and h/w symbiosis, the autonomous kern=
el control,
> > > > etc.
> > > > The main advantage is that we have a singular vendor-neutral interf=
ace via the
> > > > kernel using well understood mechanisms based on deployment experie=
nce (and
> > > > at least this part doesnt need retraining).
> > >
> > > A seemless p4 experience would be great. That looks like a tooling pr=
oblem
> > > at the p4c-backend and p4c-frontend problem. Rather than a bunch of '=
tc' glue
> > > I would aim for,
> > >
> > >   $ p4c-* myprog.p4
> > >   $ p4cRun ./myprog
> > >
> > > And maybe some options like,
> > >
> > >   $ p4cRun -i eth0 ./myprog
> >
> > Armchair lawyering and classical ML bikesheding
>
> It was just an example of what I think the end goal should be.
>
> >
> > > Then use the p4runtime to interface with the system. If you don't lik=
e the
> > > runtime then it should be brought up in that working group.
> > >
> > > >
> > > > 1) Supporting expressibility of the universe set of P4 progs
> > > >
> > > > It is a must to support 100% of all possible P4 programs. In the pa=
st the eBPF
> > > > verifier had to be worked around and even then there are cases wher=
e we couldnt
> > > > avoid path explosion when branching is involved. Kfunc-ing solves t=
hese issues
> > > > for us. Note, there are still challenges running all potential P4 p=
rograms at
> > > > the XDP level - the solution to that is to have the compiler genera=
te XDP based
> > > > code only if it possible to map it to that layer.
> > >
> > > Examples and we can fix it.
> >
> > Right. Let me wait for you to fix something 5 years from now. I would
> > never have used eBPF at all but the kfunc is what changed my mind.
> >
> > > >
> > > > 2) Support for P4 HW and SW equivalence.
> > > >
> > > > This feature continues to work even in the presence of eBPF as the =
s/w
> > > > datapath. There are cases of square-hole-round-peg scenarios but
> > > > those are implementation issues we can live with.
> > >
> > > But no hw support.
> > >
> >
> > This patcheset has nothing to do with offload (you read the cover
> > letter?). All above is saying is that by virtue of using TC we have a
> > path to a proven offload approach.
>
> I'm arguing P4 is in a big part about programmable HW. If we merge
> a P4 into the kernel all the way down to the p4 types and don't
> consider how it works with hardware that is a non starter for me.
>
> >
> >
> > > >
> > > > 3) Operational usability
> > > >
> > > > By maintaining the TC control plane (even in presence of eBPF datap=
ath)
> > > > runtime aspects remain unchanged. So for our target audience of fol=
ks
> > > > who have deployed tc including offloads - the comfort zone is uncha=
nged.
> > > > There is also the comfort zone of continuing to use the true-and-tr=
ied netlink
> > > > interfacing.
> > >
> > > The P4 control plane should be P4Runtime.
> > >
> >
> > And be my guest and write it on top of netlink.
>
> But I would prefer it was a BPF map and gave my reasons above.
>
> >
> > cheers,
> > jamal

