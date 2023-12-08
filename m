Return-Path: <bpf+bounces-17125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B680A038
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D151E1C2096B
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03C13AC3;
	Fri,  8 Dec 2023 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CpBxuU6Y"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269A1720;
	Fri,  8 Dec 2023 02:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pk2WF+pQYD1I2cn2HTnDPyRhf3vFGA6EVnaKRf3TzsA=; b=CpBxuU6YlxpoqwBWwJDRHMFEa9
	99zu8DIOe4NCCUVo309mZwvh4NOh+l/AVZ76qUsu6dD1qPloPjnpbw0tDbFhzuge4qMv7NCY7aLM7
	GdJKTt3FCnWKzxrpeAn+OEMSgb5g1oDjc+zdrRNA0mkRahsKkKGZuc7qa9RDX4kWhwF3NvnT6/UL+
	vc5WaS0AQqDxmJycuWyAPUXQ4pkhOXCBCQ8020woU3zKUbc+d1siOBmlHhfSR3KDkwQBTMndFNP++
	L5d0RWpB+ar2ClZyzyvpR3PJDJBgFZj6xx2DIn+5bTv5XKaiVOnmylelwp21ODFJi6+A4wAU1/C2c
	Qa6akfOQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rBXkg-000Pvx-1F; Fri, 08 Dec 2023 11:06:34 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rBXke-000Ut5-QF; Fri, 08 Dec 2023 11:06:32 +0100
Subject: Re: [PATCH net-next v9 15/15] p4tc: add P4 classifier
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com,
 toke@redhat.com, bpf@vger.kernel.org
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-16-jhs@mojatatu.com>
 <656e6f8d7c99f_207cb2087c@john.notmuch>
 <2eb488f9-af4a-4e28-0de0-d4dbc1e166f5@iogearbox.net>
 <CAM0EoM=MJJH9zNdiEHYpkYYQ_7WqobGv_v8wp04R7HhdPW8TxA@mail.gmail.com>
 <50b4dd0b-94fe-36b2-9a69-51847f8a7712@iogearbox.net>
 <CAM0EoMmQpiiEZw_QfXMzWfbb=6_MkLTasjwjL1MVy0nBvMJCsg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c9a53369-b895-d79e-7cc4-ea5663de2d4b@iogearbox.net>
Date: Fri, 8 Dec 2023 11:06:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMmQpiiEZw_QfXMzWfbb=6_MkLTasjwjL1MVy0nBvMJCsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27116/Thu Dec  7 09:42:18 2023)

On 12/6/23 3:59 PM, Jamal Hadi Salim wrote:
> On Tue, Dec 5, 2023 at 5:32 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 12/5/23 5:23 PM, Jamal Hadi Salim wrote:
>>> On Tue, Dec 5, 2023 at 8:43 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> On 12/5/23 1:32 AM, John Fastabend wrote:
>>>>> Jamal Hadi Salim wrote:
>>>>>> Introduce P4 tc classifier. A tc filter instantiated on this classifier
>>>>>> is used to bind a P4 pipeline to one or more netdev ports. To use P4
>>>>>> classifier you must specify a pipeline name that will be associated to
>>>>>> this filter, a s/w parser and datapath ebpf program. The pipeline must have
>>>>>> already been created via a template.
>>>>>> For example, if we were to add a filter to ingress of network interface
>>>>>> device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
>>>>>> following command:
>>>>>
>>>>> In addition to my comments from last iteration.
>>>>>
>>>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>>>>>        action bpf obj $PARSER.o section prog/tc-parser \
>>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress
>>>>>
>>>>> Having multiple object files is a mistake IMO and will cost
>>>>> performance. Have a single object file avoid stitching together
>>>>> metadata and run to completion. And then run entirely from XDP
>>>>> this is how we have been getting good performance numbers.
>>>>
>>>> +1, fully agree.
>>>
>>> As I stated earlier: while performance is important it is not the
>>> highest priority for what we are doing, rather correctness is. We dont
>>> want to be wrestling with the verifier or some other limitation like
>>> tail call limits to gain some increase in a few kkps. We are taking a
>>> gamble with the parser which is not using any kfuncs at the moment.
>>> Putting them all in one program will increase the risk.
>>
>> I don't think this is a good reason, this corners you into UAPI which
>> later on cannot be changed anymore. If you encounter such issues, then
>> why not bringing up actual concrete examples / limitations you run into
>> to the BPF community and help one way or another to get the verifier
>> improved instead? (Again, see sched_ext as one example improving verifier,
>> but also concrete example bug reports, etc could help.)
> 
> Which uapi are you talking about? The eBPF code gets generated by the
> compiler. Whether we generate one or 10 programs or where we place
> them is up to the compiler.
> We choose today to generate the parser separately - but we can change
> it in a heartbeat with zero kernel changes.

With UAPI I mean to even have this parser separation. Ideally, this should
just naturally be a single program as in XDP layer itself. You mentioned
below you could run the pipeline just in XDP..

>>> As i responded to you earlier,  we just dont want to lose
>>> functionality, some sample space:
>>> - we could have multiple pipelines with different priorities - and
>>> each pipeline may have its own logic with many tables etc (and the
>>> choice to iterate the next one is essentially encoded in the tc action
>>> codes)
>>> - we want to be able to split the pipeline into parts that can run _in
>>> unison_ in h/w, xdp, and tc
>>
>> So parser at XDP, but then you push it up the stack (instead of staying
>> only at XDP layer) just to reach into tc layer to perform a corresponding
>> action.. and this just to work around verifier as you say?
> 
> You are mixing things. The idea of being able to split a pipeline into
> hw:xdp:tc is a requirement.  You can run the pipeline fully in XDP  or
> fully in tc or split it when it makes sense.
> The idea of splitting the parser from the main p4 control block is for
> two reasons 1) someone else can generate or handcode the parser if
> they need to - we feel this is an area that may need to take advantage
> of features like dynptr etc in the future 2) as a precaution to ensure
> all P4 programs load. We have no problem putting both in one ebpf prog
> when we gain confidence that it will _always_ work - it is a mere
> change to what the compiler generates.

The cooperation between BPF progs at different layers (e.g. nfp allowed that
nicely from a BPF offload PoV) makes sense, just less to split the actions
within a given layer into multiple units where state needs to be transferred,
packets reparsed, etc. When you say that "we have no problem putting both in
one ebpf prog when we gain confidence that it will _always_ work", then should
this not be the goal to start with? How do you quantify "gain confidence"?
Test/conformance suite? It would be better to start out with this in the first
place and fix or collaborate with whatever limits get encountered along the
way. This would be the case for XDP anyway given you mention you want to
support this layer.

>>> - we use tc block to map groups of ports heavily
>>> - we use netlink as our control API
>>>
>>>>>> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs generated
>>>>>> by the P4 compiler and will be the representation of the P4 program.
>>>>>> Note that filter understands that $PARSER.o is a parser to be loaded
>>>>>> at the tc level. The datapath program is merely an eBPF action.
>>>>>>
>>>>>> Note we do support a distinct way of loading the parser as opposed to
>>>>>> making it be an action, the above example would be:
>>>>>>
>>>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>>>>>        prog type tc obj $PARSER.o ... \
>>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress
>>>>>>
>>>>>> We support two types of loadings of these initial programs in the pipeline
>>>>>> and differentiate between what gets loaded at tc vs xdp by using syntax of
>>>>>>
>>>>>> either "prog type tc obj" or "prog type xdp obj"
>>>>>>
>>>>>> For XDP:
>>>>>>
>>>>>> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
>>>>>>        prog type xdp obj $PARSER.o section parser/xdp \
>>>>>>        pinned_link /sys/fs/bpf/mylink \
>>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress
>>>>>
>>>>> I don't think tc should be loading xdp programs. XDP is not 'tc'.
>>>>
>>>> For XDP, we do have a separate attach API, for BPF links we have bpf_xdp_link_attach()
>>>> via bpf(2) and regular progs we have the classic way via dev_change_xdp_fd() with
>>>> IFLA_XDP_* attributes. Mid-term we'll also add bpf_mprog support for XDP to allow
>>>> multi-user attachment. tc kernel code should not add yet another way of attaching XDP,
>>>> this should just reuse existing uapi infra instead from userspace control plane side.
>>>
>>> I am probably missing something. We are not loading the XDP program -
>>> it is preloaded, the only thing the filter does above is grabbing a
>>> reference to it. The P4 pipeline in this case is split into a piece
>>> (the parser) that runs on XDP and some that runs on tc. And as i
>>> mentioned earlier we could go further another piece which is part of
>>> the pipeline may run in hw. And infact in the future a compiler will
>>> be able to generate code that is split across machines. For our s/w
>>> datapath on the same node the only split is between tc and XDP.
>>
>> So it is even worse from a design PoV.
> 
> So from a wild accusation that we are loading the program to now a
> condescending remark we have a bad design.

It's my opinion, yes, because all the pieces don't really fit naturally
together. It's all centered around the netlink layer which you call out
as 'non-negotiable', whereas this would have a better fit for a s/w-based
solution where you provide a framework for developers from user space.
Why do you even need an XDP reference in tc layer? Even though the XDP
loading happens through the regular path anyway.. just to knit the
different pieces artificially together despite the different existing
layers & APIs. What should actually sit in user space and orchestrate
the different generic pieces of the kernel toolbox together, you now try
to artificially move one one layer down in a /non-generic/ way. Given this
is trying to target a s/w datapath, I just don't follow why the building
blocks of this work cannot be done in a /generic/ way. Meaning, generic
extensions to the kernel infra in a p4-agnostic way, so they are also
useful and consumable outside of it for tc BPF or XDP users, and then in
user space the control plane picks all the necessary pieces it needs. (Think
of an analogy to containers today.. there is no such notion in the kernel
and the user space infra picks all the necessary pieces such as netns,
cgroups, etc to flexibly assemble this higher level concept.)

>> The kernel side allows XDP program
>> to be passed to cls_p4, but then it's not doing anything but holding a
>> reference to that BPF program. Iow, you need anyway to go the regular way
>> of bpf_xdp_link_attach() or dev_change_xdp_fd() to install XDP. Why is the
>> reference even needed here, why it cannot be done in user space from your
>> control plane? This again, feels like a shim layer which should live in
>> user space instead.
> 
> Our control path goes through tc - where we instantiate the pipeline
> on typically a tc block. Note: there could be many pipeline instances
> of the same set of ebpf programs. We need to know which ebpf programs
> are bound to which pipelines. When a pipeline is instantiated or
> destroyed it sends (netlink) events to user space. It is only natural
> to reference the programs which are part of the pipeline at that point
> i.e loading for tc progs and referencing for xdp. The control is
> already in user space to create bpf links etc.
> 
> Our concern was (if you looked at the RFC discussions earlier on) a)
> we dont want anyone removing or replacing the XDP program that is part
> of a P4 pipeline b) we wanted to ensure in the case of a split
> pipeline that the XDP code that ran before tc part of the pipeline was
> infact the one that we wanted to run. The original code (before Toke
> made a suggestion to use bpf links) was passing a cookie from XDP to
> tc which we would use to solve these concerns. By creating the link in
> user space we can pass the fd - which is what you are seeing here.
> That solves both #a and #b.
> Granted we may be a little paranoid but operationally an important
> detail is:  if one dumps the tc filter with this approach they know
> what progs compose the pipeline.

But just holding the reference in the tc cls_p4 code on the XDP program
doesn't automatically mean that this blocks anything else from happening.
You still need a user space control plane which creates the link, maybe
pins it somewhere, and when you need to update the program at the XDP
layer, then that user space control plane updates the prog @ XDP link. At
that point the dump in tc has a window of inconsistency given this is
non-atomic, and given this two-step approach.. what happens when the
control plane crashesin the middle in the worst case, then would you
take the XDP link info as source of truth or the cls_p4 dump? Just
operating on the XDP link without this two-step detour is a much more
robust approach given you avoid this race altogether.

>>>>>> The theory of operations is as follows:
>>>>>>
>>>>>> ================================1. PARSING================================
>>>>>>
>>>>>> The packet first encounters the parser.
>>>>>> The parser is implemented in ebpf residing either at the TC or XDP
>>>>>> level. The parsed header values are stored in a shared eBPF map.
>>>>>> When the parser runs at XDP level, we load it into XDP using tc filter
>>>>>> command and pin it to a file.
>>>>>>
>>>>>> =============================2. ACTIONS=============================
>>>>>>
>>>>>> In the above example, the P4 program (minus the parser) is encoded in an
>>>>>> action($PROGNAME.o). It should be noted that classical tc actions
>>>>>> continue to work:
>>>>>> IOW, someone could decide to add a mirred action to mirror all packets
>>>>>> after or before the ebpf action.
>>>>>>
>>>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>>>>>        prog type tc obj $PARSER.o section parser/tc-ingress \
>>>>>>        action bpf obj $PROGNAME.o section prog/tc-ingress \
>>>>>>        action mirred egress mirror index 1 dev $P1 \
>>>>>>        action bpf obj $ANOTHERPROG.o section mysect/section-1
>>>>>>
>>>>>> It should also be noted that it is feasible to split some of the ingress
>>>>>> datapath into XDP first and more into TC later (as was shown above for
>>>>>> example where the parser runs at XDP level). YMMV.
>>>>>
>>>>> Is there any performance value in partial XDP and partial TC? The main
>>>>> wins we see in XDP are when we can drop, redirect, etc the packet
>>>>> entirely in XDP and avoid skb altogether.
>>>>>
>>>>>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
>>>>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>>>>>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>>>>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>>>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>>>
>>>> The cls_p4 is roughly a copy of {cls,act}_bpf, and from a BPF community side
>>>> we moved away from this some time ago for the benefit of a better management
>>>> API for tc BPF programs via bpf(2) through bpf_mprog (see libbpf and BPF selftests
>>>> around this), as mentioned earlier. Please use this instead for your userspace
>>>> control plane, otherwise we are repeating the same mistakes from the past again
>>>> that were already fixed.
>>>
>>> Sorry, that is your use case for kubernetes and not ours. We want to
>>
>> There is nothing specific to k8s, it's generic infrastructure for tc BPF
>> and also used outside of k8s scope; please double-check the selftests to
>> get a picture of the API and libbpf integration.
> 
> I did and i couldnt see how we can do any of the tcx/mprog using tc to
> meet our requirements. I may be missing something very obvious but it
> was why i said it was for your use case not ours. I would be willing
> to look again if you say it works with tc but do note that I am fine
> with tc infra where i can add actions, all composed of different
> programs if i wanted to; and add addendums to use other tc existing
> (non-ebpf) actions if i needed to. We have what we need working fine,
> so there has to be a compelling reason to change.
> I asked you a question earlier whether in your view tc use of ebpf is
> deprecated. I have seen you make a claim in the past that sched_act
> was useless and that everyone needs to use sched_cls and you went on
> to say nobody needs priorities. TBH, that is _your view for your use
> case_.

I do see act_bpf as redundant given the cls_bpf with the direct
action mode can do everything that is needed with BPF, and whenever
something was needed, extensions to verifier/helpers/kfuncs/etc were
sufficient. We've been using this for years this way in production
with complex programs and never saw a need to utilize any of the
remaining actions outside of BPF or to have a split of parser/action
as mentioned above. The additional machinery would also add overhead
in s/w fast path which can be avoided (if it were e.g. cls_matchall +
act_bpf). That said, people use cls_bpf in multi-user mode where
different progs get attached. The priorities was collective BPF
community feedback that these are hard to use due to the seen
collisions in practice which led to various hard to debug incidents.
While this was not my view initially, I agree that the new design
with before/after and relative prog/link reference is a better ux.

>>> use the tc infra. We want to use netlink. I could be misreading what
>>> you are saying but it seems that you are suggesting that tc infra is
>>> now obsolete as far as ebpf is concerned? Overall: It is a bit selfish
>>> to say your use case dictates how other people use ebpf. ebpf is just
>>> a means to an end for us and _is not the end goal_ - just an infra
>>> toolset.
>>
>> Not really, the infrastructure is already there and ready to be used and
>> it supports basic building blocks such as BPF links, relative prog/link
>> dependency resolution, etc, where none of it can be found here. The
>> problem is "we want to use netlink" which is even why you need to push
>> down things like XDP prog, but it's broken by design, really. You are
>> trying to push down a control plane into netlink which should have been
>> a framework in user space.
> 
> The netlink part is not negotiable - the cover letter says why and i
> have explained it 10K times in these threads. You are listing all
> these tcx features like relativeness for which i have no use for.
> OTOH, like i said if it works with tc then i would be willing to look
> at it but there need to be compelling reasons to move to that shiny
> new infra.

If you don't have a particular case for multi-prog, that is totally
fine. You mentioned earlier on "we dont want anyone removing or replacing
the XDP program that is part of a P4 pipeline", and that you are using
BPF links to solve it, so I presume it would be equally important case
for the tc BPF program of your P4 pipeline. I presume you use libbpf, so
here the controller would do exact similar steps on tcx that you do for
XDP to set up BPF links. But again, my overall comment comes down to
why it cannot be broken into generic extensions as mentioned above given
XDP/tc infra is in place.

Thanks,
Daniel

