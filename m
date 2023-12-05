Return-Path: <bpf+bounces-16814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FD48061C3
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0525B2117A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189556EB76;
	Tue,  5 Dec 2023 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="px6rC9z/"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82B1B2;
	Tue,  5 Dec 2023 14:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gJT1aWUGEvk00/7WOvJbIZVRbwWe4s/FmSIYsQruq0I=; b=px6rC9z/+AudRAvb1VuTwwAPt+
	iMovsP0+JodcdDCCE+2wfmEODj97OEm/XmCg1mvdNjVCxIngdt81/LuUHrYDhFIQhxINm7WjEWREp
	cD0IB1y1XtagZJcZsKyD/V1scdKRlvWLlyBf1Exf3Muyh6WQXvXTeqhcFULvdhsC6O3RIzflnRd14
	ujKo6rjqMwj6jUL4Uwa7ZWBK2kkv0c6Frh1p85joQLtU2FPvcoeQ43LD44JscJvTFBTfVcM1nbrLZ
	gqF35i6n+vX23Z2oEiPKuhKIeuUzNHYBgUPENUHCKP22+96WgUV7AOfO4YJ3hXYfXD9gbPw2tenie
	7SxaE6sA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAdxX-000Oa5-Db; Tue, 05 Dec 2023 23:32:07 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAdxW-0004QP-8Q; Tue, 05 Dec 2023 23:32:06 +0100
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
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <50b4dd0b-94fe-36b2-9a69-51847f8a7712@iogearbox.net>
Date: Tue, 5 Dec 2023 23:32:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoM=MJJH9zNdiEHYpkYYQ_7WqobGv_v8wp04R7HhdPW8TxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)

On 12/5/23 5:23 PM, Jamal Hadi Salim wrote:
> On Tue, Dec 5, 2023 at 8:43 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 12/5/23 1:32 AM, John Fastabend wrote:
>>> Jamal Hadi Salim wrote:
>>>> Introduce P4 tc classifier. A tc filter instantiated on this classifier
>>>> is used to bind a P4 pipeline to one or more netdev ports. To use P4
>>>> classifier you must specify a pipeline name that will be associated to
>>>> this filter, a s/w parser and datapath ebpf program. The pipeline must have
>>>> already been created via a template.
>>>> For example, if we were to add a filter to ingress of network interface
>>>> device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
>>>> following command:
>>>
>>> In addition to my comments from last iteration.
>>>
>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>>>       action bpf obj $PARSER.o section prog/tc-parser \
>>>>       action bpf obj $PROGNAME.o section prog/tc-ingress
>>>
>>> Having multiple object files is a mistake IMO and will cost
>>> performance. Have a single object file avoid stitching together
>>> metadata and run to completion. And then run entirely from XDP
>>> this is how we have been getting good performance numbers.
>>
>> +1, fully agree.
> 
> As I stated earlier: while performance is important it is not the
> highest priority for what we are doing, rather correctness is. We dont
> want to be wrestling with the verifier or some other limitation like
> tail call limits to gain some increase in a few kkps. We are taking a
> gamble with the parser which is not using any kfuncs at the moment.
> Putting them all in one program will increase the risk.

I don't think this is a good reason, this corners you into UAPI which
later on cannot be changed anymore. If you encounter such issues, then
why not bringing up actual concrete examples / limitations you run into
to the BPF community and help one way or another to get the verifier
improved instead? (Again, see sched_ext as one example improving verifier,
but also concrete example bug reports, etc could help.)

> As i responded to you earlier,  we just dont want to lose
> functionality, some sample space:
> - we could have multiple pipelines with different priorities - and
> each pipeline may have its own logic with many tables etc (and the
> choice to iterate the next one is essentially encoded in the tc action
> codes)
> - we want to be able to split the pipeline into parts that can run _in
> unison_ in h/w, xdp, and tc

So parser at XDP, but then you push it up the stack (instead of staying
only at XDP layer) just to reach into tc layer to perform a corresponding
action.. and this just to work around verifier as you say?

> - we use tc block to map groups of ports heavily
> - we use netlink as our control API
> 
>>>> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs generated
>>>> by the P4 compiler and will be the representation of the P4 program.
>>>> Note that filter understands that $PARSER.o is a parser to be loaded
>>>> at the tc level. The datapath program is merely an eBPF action.
>>>>
>>>> Note we do support a distinct way of loading the parser as opposed to
>>>> making it be an action, the above example would be:
>>>>
>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>>>       prog type tc obj $PARSER.o ... \
>>>>       action bpf obj $PROGNAME.o section prog/tc-ingress
>>>>
>>>> We support two types of loadings of these initial programs in the pipeline
>>>> and differentiate between what gets loaded at tc vs xdp by using syntax of
>>>>
>>>> either "prog type tc obj" or "prog type xdp obj"
>>>>
>>>> For XDP:
>>>>
>>>> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
>>>>       prog type xdp obj $PARSER.o section parser/xdp \
>>>>       pinned_link /sys/fs/bpf/mylink \
>>>>       action bpf obj $PROGNAME.o section prog/tc-ingress
>>>
>>> I don't think tc should be loading xdp programs. XDP is not 'tc'.
>>
>> For XDP, we do have a separate attach API, for BPF links we have bpf_xdp_link_attach()
>> via bpf(2) and regular progs we have the classic way via dev_change_xdp_fd() with
>> IFLA_XDP_* attributes. Mid-term we'll also add bpf_mprog support for XDP to allow
>> multi-user attachment. tc kernel code should not add yet another way of attaching XDP,
>> this should just reuse existing uapi infra instead from userspace control plane side.
> 
> I am probably missing something. We are not loading the XDP program -
> it is preloaded, the only thing the filter does above is grabbing a
> reference to it. The P4 pipeline in this case is split into a piece
> (the parser) that runs on XDP and some that runs on tc. And as i
> mentioned earlier we could go further another piece which is part of
> the pipeline may run in hw. And infact in the future a compiler will
> be able to generate code that is split across machines. For our s/w
> datapath on the same node the only split is between tc and XDP.

So it is even worse from a design PoV. The kernel side allows XDP program
to be passed to cls_p4, but then it's not doing anything but holding a
reference to that BPF program. Iow, you need anyway to go the regular way
of bpf_xdp_link_attach() or dev_change_xdp_fd() to install XDP. Why is the
reference even needed here, why it cannot be done in user space from your
control plane? This again, feels like a shim layer which should live in
user space instead.

>>>> The theory of operations is as follows:
>>>>
>>>> ================================1. PARSING================================
>>>>
>>>> The packet first encounters the parser.
>>>> The parser is implemented in ebpf residing either at the TC or XDP
>>>> level. The parsed header values are stored in a shared eBPF map.
>>>> When the parser runs at XDP level, we load it into XDP using tc filter
>>>> command and pin it to a file.
>>>>
>>>> =============================2. ACTIONS=============================
>>>>
>>>> In the above example, the P4 program (minus the parser) is encoded in an
>>>> action($PROGNAME.o). It should be noted that classical tc actions
>>>> continue to work:
>>>> IOW, someone could decide to add a mirred action to mirror all packets
>>>> after or before the ebpf action.
>>>>
>>>> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>>>>       prog type tc obj $PARSER.o section parser/tc-ingress \
>>>>       action bpf obj $PROGNAME.o section prog/tc-ingress \
>>>>       action mirred egress mirror index 1 dev $P1 \
>>>>       action bpf obj $ANOTHERPROG.o section mysect/section-1
>>>>
>>>> It should also be noted that it is feasible to split some of the ingress
>>>> datapath into XDP first and more into TC later (as was shown above for
>>>> example where the parser runs at XDP level). YMMV.
>>>
>>> Is there any performance value in partial XDP and partial TC? The main
>>> wins we see in XDP are when we can drop, redirect, etc the packet
>>> entirely in XDP and avoid skb altogether.
>>>
>>>> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
>>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>>>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>
>> The cls_p4 is roughly a copy of {cls,act}_bpf, and from a BPF community side
>> we moved away from this some time ago for the benefit of a better management
>> API for tc BPF programs via bpf(2) through bpf_mprog (see libbpf and BPF selftests
>> around this), as mentioned earlier. Please use this instead for your userspace
>> control plane, otherwise we are repeating the same mistakes from the past again
>> that were already fixed.
> 
> Sorry, that is your use case for kubernetes and not ours. We want to

There is nothing specific to k8s, it's generic infrastructure for tc BPF
and also used outside of k8s scope; please double-check the selftests to
get a picture of the API and libbpf integration.

> use the tc infra. We want to use netlink. I could be misreading what
> you are saying but it seems that you are suggesting that tc infra is
> now obsolete as far as ebpf is concerned? Overall: It is a bit selfish
> to say your use case dictates how other people use ebpf. ebpf is just
> a means to an end for us and _is not the end goal_ - just an infra
> toolset.

Not really, the infrastructure is already there and ready to be used and
it supports basic building blocks such as BPF links, relative prog/link
dependency resolution, etc, where none of it can be found here. The
problem is "we want to use netlink" which is even why you need to push
down things like XDP prog, but it's broken by design, really. You are
trying to push down a control plane into netlink which should have been
a framework in user space.

> If you feel we should unify the P4 classifier with the tc ebpf
> classifier etc then we are going to need some changes that are not
> going to be useful for other people. And i dont see the point in that.
> 
> cheers,
> jamal
> 
>> Therefore, from BPF side:
>>
>> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
>>
>> Cheers,
>> Daniel


