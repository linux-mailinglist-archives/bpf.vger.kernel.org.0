Return-Path: <bpf+bounces-17417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A080780CFDC
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A92B21572
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C34BAA1;
	Mon, 11 Dec 2023 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pSIKgpOj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1DBD
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:44:04 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5df4993c25dso22181587b3.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702309443; x=1702914243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5KHiq4EycRpHs2tj/zpIOtz9qz6mDbZjykiPiWiWjw=;
        b=pSIKgpOjuTtDNJCjJFlbvdYeyuDH99eVfYCKtpyFWJbfOOYwdAJBg1+jORtW77kV8a
         C4gevzAbSd+62aH8dTuTrfBAb6DlWWwzp2FzdRmm1a5VRiHXAhd4Hyb3p57HdpFsrMoW
         VtCFuq4Q30Mj/AzsM4Vh9JuxH6H0TMREj3viUUH6D7DXnxxF1/N9cpAm75hNDL7GbSyw
         YMZy6g+9MqQnCSlx2fgFEHiUx3+OxKpZ8vVc92pj5LmyoCVan6OkRchPgMs7nAzO0o/1
         NFff17BOFDObjZa+QbEQn0RmCewqJdFZI6j31skj5eKZTBYTeUivaEZGe0W6uH6nlfyc
         S/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309443; x=1702914243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5KHiq4EycRpHs2tj/zpIOtz9qz6mDbZjykiPiWiWjw=;
        b=PiYJym7iVvVtCQtv8o5SZvhRGE1HkGwP43VuzLIuXlwh13P1bApJUJ2mqnuXtsLBx7
         mIU6pOnq9r5IlJfZ7dQu3q7UfAPLNqtFCJ5T92macMkHdC/uNS0rvwPsAyOatuxXVqXA
         qqt2Zi2fHEc066h/2mHDsXDayoZJO3krpq/XV9wI9+BtGE6e8rnxCeOW6bd7MnsHRD4f
         0g9PKbV1la5/1zVeBpX0A3U9l0DoavtPTm3AQJhT6KvQG5uSLqaE6Hi58TTK41raar9b
         DsVM/DSj/2wm3LBNvOde4R8bWbv47Y6P0VlruuCAaYfZjm3TYxaTFN6Vp2hJx9BpQ5tp
         HlBg==
X-Gm-Message-State: AOJu0Yx1c5/WQBcnpQ+ZCmRhiIQrXaord2tRDXOg6TK4TgiaIiUc02pY
	jhIvcwwMARtinXEDFXxxFWBBlfryaoGgweI9SQUKNbVpcO9wzQgE0dw5cw==
X-Google-Smtp-Source: AGHT+IHyG2pB49xAd8X1R7y7X3RMLyYfpnq5laUHNZQc7KB1TmMmX4oTwgnVPiT+ohg2zslIeu0yurFlFEL/hMkEW3A=
X-Received: by 2002:a0d:f9c1:0:b0:5d7:1940:f3dd with SMTP id
 j184-20020a0df9c1000000b005d71940f3ddmr3568957ywf.69.1702309443267; Mon, 11
 Dec 2023 07:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201182904.532825-1-jhs@mojatatu.com> <20231201182904.532825-16-jhs@mojatatu.com>
 <656e6f8d7c99f_207cb2087c@john.notmuch> <2eb488f9-af4a-4e28-0de0-d4dbc1e166f5@iogearbox.net>
 <CAM0EoM=MJJH9zNdiEHYpkYYQ_7WqobGv_v8wp04R7HhdPW8TxA@mail.gmail.com>
 <50b4dd0b-94fe-36b2-9a69-51847f8a7712@iogearbox.net> <CAM0EoMmQpiiEZw_QfXMzWfbb=6_MkLTasjwjL1MVy0nBvMJCsg@mail.gmail.com>
 <c9a53369-b895-d79e-7cc4-ea5663de2d4b@iogearbox.net>
In-Reply-To: <c9a53369-b895-d79e-7cc4-ea5663de2d4b@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 11 Dec 2023 10:43:49 -0500
Message-ID: <CAM0EoMmm6SZawXy4wc=_LFKJFP6TFSKXQdCfRD4XrSON_AqDTA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 15/15] p4tc: add P4 classifier
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, Anjali Singhai Jain <anjali.singhai@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa <khalidm@nvidia.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 5:06=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 12/6/23 3:59 PM, Jamal Hadi Salim wrote:
> > On Tue, Dec 5, 2023 at 5:32=E2=80=AFPM Daniel Borkmann <daniel@iogearbo=
x.net> wrote:
> >> On 12/5/23 5:23 PM, Jamal Hadi Salim wrote:
> >>> On Tue, Dec 5, 2023 at 8:43=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>>> On 12/5/23 1:32 AM, John Fastabend wrote:
> >>>>> Jamal Hadi Salim wrote:
> >>>>>> Introduce P4 tc classifier. A tc filter instantiated on this class=
ifier
> >>>>>> is used to bind a P4 pipeline to one or more netdev ports. To use =
P4
> >>>>>> classifier you must specify a pipeline name that will be associate=
d to
> >>>>>> this filter, a s/w parser and datapath ebpf program. The pipeline =
must have
> >>>>>> already been created via a template.
> >>>>>> For example, if we were to add a filter to ingress of network inte=
rface
> >>>>>> device $P0 and associate it to P4 pipeline simple_l3 we'd issue th=
e
> >>>>>> following command:
> >>>>>
> >>>>> In addition to my comments from last iteration.
> >>>>>
> >>>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname si=
mple_l3 \
> >>>>>>        action bpf obj $PARSER.o section prog/tc-parser \
> >>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress
> >>>>>
> >>>>> Having multiple object files is a mistake IMO and will cost
> >>>>> performance. Have a single object file avoid stitching together
> >>>>> metadata and run to completion. And then run entirely from XDP
> >>>>> this is how we have been getting good performance numbers.
> >>>>
> >>>> +1, fully agree.
> >>>
> >>> As I stated earlier: while performance is important it is not the
> >>> highest priority for what we are doing, rather correctness is. We don=
t
> >>> want to be wrestling with the verifier or some other limitation like
> >>> tail call limits to gain some increase in a few kkps. We are taking a
> >>> gamble with the parser which is not using any kfuncs at the moment.
> >>> Putting them all in one program will increase the risk.
> >>
> >> I don't think this is a good reason, this corners you into UAPI which
> >> later on cannot be changed anymore. If you encounter such issues, then
> >> why not bringing up actual concrete examples / limitations you run int=
o
> >> to the BPF community and help one way or another to get the verifier
> >> improved instead? (Again, see sched_ext as one example improving verif=
ier,
> >> but also concrete example bug reports, etc could help.)
> >
> > Which uapi are you talking about? The eBPF code gets generated by the
> > compiler. Whether we generate one or 10 programs or where we place
> > them is up to the compiler.
> > We choose today to generate the parser separately - but we can change
> > it in a heartbeat with zero kernel changes.
>
> With UAPI I mean to even have this parser separation. Ideally, this shoul=
d
> just naturally be a single program as in XDP layer itself. You mentioned
> below you could run the pipeline just in XDP..
>

Yes we can - but it doesnt break uapi. The simplest thing to do is to
place the pipeline either at TC or XDP fully.  Caveat being not
everything can run on XDP.

Probably showing XDP running the parser was not a good example - and i
think we should remove it from the commit messages to avoid confusion.
The intent there was to show that  XDP,  given its speed advantages,
can do the parsing faster and infact reject anything early if thats
what the P4 programm deemed it do; if it likes something then the tc
layer handles the rest of the pipeline processing. It is really p4
program dependent. Consider another example which is more sensible:
XDP has a fast path  (pipeline branching based on runtime conditions
works well in P4) and if there were exceptions to the fast path (maybe
a cache miss) then processing in the tc layer, etc.

I think we'll just remove such examples in the commit.

For the multi-prog-per level: If for a given P4 program the compiler
(v1) generates two separate ebpf programs(as we do in this case) and
then the next version of the compiler(v2) puts all the logic in one
ebpf program at XDP only - nothing breaks. i.e both V1 and V2 output
continue to work; maybe the V2 output could end up being more
efficient, etc.

> >>> As i responded to you earlier,  we just dont want to lose
> >>> functionality, some sample space:
> >>> - we could have multiple pipelines with different priorities - and
> >>> each pipeline may have its own logic with many tables etc (and the
> >>> choice to iterate the next one is essentially encoded in the tc actio=
n
> >>> codes)
> >>> - we want to be able to split the pipeline into parts that can run _i=
n
> >>> unison_ in h/w, xdp, and tc
> >>
> >> So parser at XDP, but then you push it up the stack (instead of stayin=
g
> >> only at XDP layer) just to reach into tc layer to perform a correspond=
ing
> >> action.. and this just to work around verifier as you say?
> >
> > You are mixing things. The idea of being able to split a pipeline into
> > hw:xdp:tc is a requirement.  You can run the pipeline fully in XDP  or
> > fully in tc or split it when it makes sense.
> > The idea of splitting the parser from the main p4 control block is for
> > two reasons 1) someone else can generate or handcode the parser if
> > they need to - we feel this is an area that may need to take advantage
> > of features like dynptr etc in the future 2) as a precaution to ensure
> > all P4 programs load. We have no problem putting both in one ebpf prog
> > when we gain confidence that it will _always_ work - it is a mere
> > change to what the compiler generates.
>
> The cooperation between BPF progs at different layers (e.g. nfp allowed t=
hat
> nicely from a BPF offload PoV) makes sense, just less to split the action=
s
> within a given layer into multiple units where state needs to be transfer=
red,
>

For the parser split, one motivation was: there are other tools that
are very specialized on parsers (see Tom) and as long as that tool can
read P4 and conform to our expectations, we should be able to use that
parser as a replacement. Maybe that example is too specific and doesnt
apply in the larger picture but like i said we can change it with a
compiler mod. No rush - we'll see where this goes.

> packets reparsed, etc. When you say that "we have no problem putting both=
 in
> one ebpf prog when we gain confidence that it will _always_ work", then s=
hould
> this not be the goal to start with? How do you quantify "gain confidence"=
?
> Test/conformance suite? It would be better to start out with this in the =
first
> place and fix or collaborate with whatever limits get encountered along t=
he
> way. This would be the case for XDP anyway given you mention you want to
> support this layer.

It's just bad experience with the eBPF tooling that drove us in this
path (path explosions, pointer trickery, tail call limits, etc). Our
goal is to not require eBPF expertise for tc people (who are the main
consumers of this); things have to _just work_ after the compiler
emits them. We dont want to maintain a bag of tricks which may work
some of the time. For our audience a goal is to lower the barrier for
them and reduce dependence on "you must now be a guru at eBPF".
For now we are in a grace period with the compiler (even for the
parser separation, which we could end up removing) and over time
feedback for usability and optimization will keep improving generated
code and hopefully using new eBPF features more effectively. So i am
not very concerned about this.

> >>> - we use tc block to map groups of ports heavily
> >>> - we use netlink as our control API
> >>>
> >>>>>> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs ge=
nerated
> >>>>>> by the P4 compiler and will be the representation of the P4 progra=
m.
> >>>>>> Note that filter understands that $PARSER.o is a parser to be load=
ed
> >>>>>> at the tc level. The datapath program is merely an eBPF action.
> >>>>>>
> >>>>>> Note we do support a distinct way of loading the parser as opposed=
 to
> >>>>>> making it be an action, the above example would be:
> >>>>>>
> >>>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname si=
mple_l3 \
> >>>>>>        prog type tc obj $PARSER.o ... \
> >>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress
> >>>>>>
> >>>>>> We support two types of loadings of these initial programs in the =
pipeline
> >>>>>> and differentiate between what gets loaded at tc vs xdp by using s=
yntax of
> >>>>>>
> >>>>>> either "prog type tc obj" or "prog type xdp obj"
> >>>>>>
> >>>>>> For XDP:
> >>>>>>
> >>>>>> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_=
l3 \
> >>>>>>        prog type xdp obj $PARSER.o section parser/xdp \
> >>>>>>        pinned_link /sys/fs/bpf/mylink \
> >>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress
> >>>>>
> >>>>> I don't think tc should be loading xdp programs. XDP is not 'tc'.
> >>>>
> >>>> For XDP, we do have a separate attach API, for BPF links we have bpf=
_xdp_link_attach()
> >>>> via bpf(2) and regular progs we have the classic way via dev_change_=
xdp_fd() with
> >>>> IFLA_XDP_* attributes. Mid-term we'll also add bpf_mprog support for=
 XDP to allow
> >>>> multi-user attachment. tc kernel code should not add yet another way=
 of attaching XDP,
> >>>> this should just reuse existing uapi infra instead from userspace co=
ntrol plane side.
> >>>
> >>> I am probably missing something. We are not loading the XDP program -
> >>> it is preloaded, the only thing the filter does above is grabbing a
> >>> reference to it. The P4 pipeline in this case is split into a piece
> >>> (the parser) that runs on XDP and some that runs on tc. And as i
> >>> mentioned earlier we could go further another piece which is part of
> >>> the pipeline may run in hw. And infact in the future a compiler will
> >>> be able to generate code that is split across machines. For our s/w
> >>> datapath on the same node the only split is between tc and XDP.
> >>
> >> So it is even worse from a design PoV.
> >
> > So from a wild accusation that we are loading the program to now a
> > condescending remark we have a bad design.
>
> It's my opinion, yes, because all the pieces don't really fit naturally
> together. It's all centered around the netlink layer which you call out
> as 'non-negotiable', whereas this would have a better fit for a s/w-based
> solution where you provide a framework for developers from user space.
> Why do you even need an XDP reference in tc layer? Even though the XDP
> loading happens through the regular path anyway.. just to knit the
> different pieces artificially together despite the different existing
> layers & APIs.

The P4 abstraction is a pipeline - to give analogy with current tc
offloads (such as flower): the pipeline placement could be split
between h/w and s/w (or be entirely in one or other),
So the placement idea is already cooked in the TC psyche. And the
control to all that happens at the tc layer. I can send a netlink
message and it will tell me which part is in h/w and s/w. We are just
following a similar thought process here: The pipeline is owned by TC
and therefore its management and control (and source of truth) sits at
TC. True, XDP is a different layer - but from an engineering
perspective, I dont see this as this layer violation rather it is
something pragmatic to do.

> What should actually sit in user space and orchestrate
> the different generic pieces of the kernel toolbox together, you now try
> to artificially move one one layer down in a /non-generic/ way. Given thi=
s
> is trying to target a s/w datapath, I just don't follow why the building
> blocks of this work cannot be done in a /generic/ way. Meaning, generic
> extensions to the kernel infra in a p4-agnostic way, so they are also
> useful and consumable outside of it for tc BPF or XDP users, and then in
> user space the control plane picks all the necessary pieces it needs. (Th=
ink
> of an analogy to containers today.. there is no such notion in the kernel
> and the user space infra picks all the necessary pieces such as netns,
> cgroups, etc to flexibly assemble this higher level concept.)
>

If there are alternative ways to load the programs and define their
dependency that would work with tc, then it should be sufficient to
just feed the fds to the p4 classifier when we instantiate a p4
pipeline (or may not even be needed depending on what that stiching
infra is). I did look at tcx hard after my last response and i am
afraid, Daniel, that you divorced us and our status right now is we
are your "ex" ;-> (is that what x means in tcx?). But if such a scheme
exists, the eBPF progs can still call the exposed kfuncs meaning it
will continue to work in the TC realm...

> >> The kernel side allows XDP program
> >> to be passed to cls_p4, but then it's not doing anything but holding a
> >> reference to that BPF program. Iow, you need anyway to go the regular =
way
> >> of bpf_xdp_link_attach() or dev_change_xdp_fd() to install XDP. Why is=
 the
> >> reference even needed here, why it cannot be done in user space from y=
our
> >> control plane? This again, feels like a shim layer which should live i=
n
> >> user space instead.
> >
> > Our control path goes through tc - where we instantiate the pipeline
> > on typically a tc block. Note: there could be many pipeline instances
> > of the same set of ebpf programs. We need to know which ebpf programs
> > are bound to which pipelines. When a pipeline is instantiated or
> > destroyed it sends (netlink) events to user space. It is only natural
> > to reference the programs which are part of the pipeline at that point
> > i.e loading for tc progs and referencing for xdp. The control is
> > already in user space to create bpf links etc.
> >
> > Our concern was (if you looked at the RFC discussions earlier on) a)
> > we dont want anyone removing or replacing the XDP program that is part
> > of a P4 pipeline b) we wanted to ensure in the case of a split
> > pipeline that the XDP code that ran before tc part of the pipeline was
> > infact the one that we wanted to run. The original code (before Toke
> > made a suggestion to use bpf links) was passing a cookie from XDP to
> > tc which we would use to solve these concerns. By creating the link in
> > user space we can pass the fd - which is what you are seeing here.
> > That solves both #a and #b.
> > Granted we may be a little paranoid but operationally an important
> > detail is:  if one dumps the tc filter with this approach they know
> > what progs compose the pipeline.
>
> But just holding the reference in the tc cls_p4 code on the XDP program
> doesn't automatically mean that this blocks anything else from happening.
> You still need a user space control plane which creates the link, maybe
> pins it somewhere, and when you need to update the program at the XDP
> layer, then that user space control plane updates the prog @ XDP link. At
> that point the dump in tc has a window of inconsistency given this is
> non-atomic, and given this two-step approach.. what happens when the
> control plane crashesin the middle in the worst case, then would you
> take the XDP link info as source of truth or the cls_p4 dump? Just
> operating on the XDP link without this two-step detour is a much more
> robust approach given you avoid this race altogether.

See my comment above on tcx on splitting the loading from tc runtime.
My experience in SDN is that you want the kernel to be the source of
truth. i.e.  if i want to know which progs are running for a given p4
pipeline, at what level, putting this info on some user space daemon
which - as you point out may crush - is not the most robust. I should
be able to just use a cli to find out the truth.
I didnt quiet follow your comment above on the XDP prog being replaced
which a dump is going on... Am i mistaken in thinking that as long as
i hold the refcount, you cant just swap things out from underneath me?

> >>>>>> The theory of operations is as follows:
> >>>>>>
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D1. PARSING=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>
> >>>>>> The packet first encounters the parser.
> >>>>>> The parser is implemented in ebpf residing either at the TC or XDP
> >>>>>> level. The parsed header values are stored in a shared eBPF map.
> >>>>>> When the parser runs at XDP level, we load it into XDP using tc fi=
lter
> >>>>>> command and pin it to a file.
> >>>>>>
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D2. ACTIONS=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>
> >>>>>> In the above example, the P4 program (minus the parser) is encoded=
 in an
> >>>>>> action($PROGNAME.o). It should be noted that classical tc actions
> >>>>>> continue to work:
> >>>>>> IOW, someone could decide to add a mirred action to mirror all pac=
kets
> >>>>>> after or before the ebpf action.
> >>>>>>
> >>>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname si=
mple_l3 \
> >>>>>>        prog type tc obj $PARSER.o section parser/tc-ingress \
> >>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress \
> >>>>>>        action mirred egress mirror index 1 dev $P1 \
> >>>>>>        action bpf obj $ANOTHERPROG.o section mysect/section-1
> >>>>>>
> >>>>>> It should also be noted that it is feasible to split some of the i=
ngress
> >>>>>> datapath into XDP first and more into TC later (as was shown above=
 for
> >>>>>> example where the parser runs at XDP level). YMMV.
> >>>>>
> >>>>> Is there any performance value in partial XDP and partial TC? The m=
ain
> >>>>> wins we see in XDP are when we can drop, redirect, etc the packet
> >>>>> entirely in XDP and avoid skb altogether.
> >>>>>
> >>>>>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> >>>>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >>>>>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >>>>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >>>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>>
> >>>> The cls_p4 is roughly a copy of {cls,act}_bpf, and from a BPF commun=
ity side
> >>>> we moved away from this some time ago for the benefit of a better ma=
nagement
> >>>> API for tc BPF programs via bpf(2) through bpf_mprog (see libbpf and=
 BPF selftests
> >>>> around this), as mentioned earlier. Please use this instead for your=
 userspace
> >>>> control plane, otherwise we are repeating the same mistakes from the=
 past again
> >>>> that were already fixed.
> >>>
> >>> Sorry, that is your use case for kubernetes and not ours. We want to
> >>
> >> There is nothing specific to k8s, it's generic infrastructure for tc B=
PF
> >> and also used outside of k8s scope; please double-check the selftests =
to
> >> get a picture of the API and libbpf integration.
> >
> > I did and i couldnt see how we can do any of the tcx/mprog using tc to
> > meet our requirements. I may be missing something very obvious but it
> > was why i said it was for your use case not ours. I would be willing
> > to look again if you say it works with tc but do note that I am fine
> > with tc infra where i can add actions, all composed of different
> > programs if i wanted to; and add addendums to use other tc existing
> > (non-ebpf) actions if i needed to. We have what we need working fine,
> > so there has to be a compelling reason to change.
> > I asked you a question earlier whether in your view tc use of ebpf is
> > deprecated. I have seen you make a claim in the past that sched_act
> > was useless and that everyone needs to use sched_cls and you went on
> > to say nobody needs priorities. TBH, that is _your view for your use
> > case_.
>
> I do see act_bpf as redundant given the cls_bpf with the direct
> action mode can do everything that is needed with BPF, and whenever
> something was needed, extensions to verifier/helpers/kfuncs/etc were
> sufficient. We've been using this for years this way in production
> with complex programs and never saw a need to utilize any of the
> remaining actions outside of BPF or to have a split of parser/action
> as mentioned above.

When you have a very specific use case you can fix things as needed as
you described a lot easier;  we have a large permutation of potential
progs and pipeline flows to be dictated by P4 progs. We want to make
sure things work all the time without someone calling us to say "how
come this doesnt load?". For that we are willing to sacrifice some
performance and i am sure we'll get better over time. So if it is
multi-action so be it, at least for now. Definitely, we would not have
wanted to go the eBPF path without kfuncs (and XDP plays a nice role)
- so i feel we are in a good place.
My thinking process has been converted from prioritizing "let me
squeeze those cycles by skipping a memset" to "lets make this thing
usable by other people" and if  i loose a few kpps because i have two
actions instead of one, no big deal - we'll get better over time.

> The additional machinery would also add overhead
> in s/w fast path which can be avoided (if it were e.g. cls_matchall +
> act_bpf). That said, people use cls_bpf in multi-user mode where
> different progs get attached. The priorities was collective BPF
> community feedback that these are hard to use due to the seen
> collisions in practice which led to various hard to debug incidents.
> While this was not my view initially, I agree that the new design
> with before/after and relative prog/link reference is a better ux.
>

I empathize with the situation you faced (i note that motivation was a
multi user food fight). We dont have that "collision" problem in our
use cases. TBH, TC priorities and chains (which i can jump to) are
sufficient for what we do. Note: I am also not objecting to getting
better performance  (which i am sure we'll get better over time) or
finding a common ground for how to specify the collection of programs
(as long as it serves our needs as well i.e tc, netlink).

cheers,
jamal


> >>> use the tc infra. We want to use netlink. I could be misreading what
> >>> you are saying but it seems that you are suggesting that tc infra is
> >>> now obsolete as far as ebpf is concerned? Overall: It is a bit selfis=
h
> >>> to say your use case dictates how other people use ebpf. ebpf is just
> >>> a means to an end for us and _is not the end goal_ - just an infra
> >>> toolset.
> >>
> >> Not really, the infrastructure is already there and ready to be used a=
nd
> >> it supports basic building blocks such as BPF links, relative prog/lin=
k
> >> dependency resolution, etc, where none of it can be found here. The
> >> problem is "we want to use netlink" which is even why you need to push
> >> down things like XDP prog, but it's broken by design, really. You are
> >> trying to push down a control plane into netlink which should have bee=
n
> >> a framework in user space.
> >
> > The netlink part is not negotiable - the cover letter says why and i
> > have explained it 10K times in these threads. You are listing all
> > these tcx features like relativeness for which i have no use for.
> > OTOH, like i said if it works with tc then i would be willing to look
> > at it but there need to be compelling reasons to move to that shiny
> > new infra.
>
> If you don't have a particular case for multi-prog, that is totally
> fine. You mentioned earlier on "we dont want anyone removing or replacing
> the XDP program that is part of a P4 pipeline", and that you are using
> BPF links to solve it, so I presume it would be equally important case
> for the tc BPF program of your P4 pipeline. I presume you use libbpf, so
> here the controller would do exact similar steps on tcx that you do for
> XDP to set up BPF links. But again, my overall comment comes down to
> why it cannot be broken into generic extensions as mentioned above given
> XDP/tc infra is in place.


> Thanks,
> Daniel

