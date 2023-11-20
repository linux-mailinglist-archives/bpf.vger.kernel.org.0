Return-Path: <bpf+bounces-15398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF227F1E16
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DBD281B31
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B272A1D691;
	Mon, 20 Nov 2023 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFhfc0p6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA9CF;
	Mon, 20 Nov 2023 12:41:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4948374b3a.0;
        Mon, 20 Nov 2023 12:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700512904; x=1701117704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSSrLMGlx1q1e+ofvk4heaQm6aCIvNx/xJP1uqrWpDM=;
        b=dFhfc0p629QI0lyCOy6yrvHOW5weCmGJCcPqyO0g8o1a1X2qk0fdS5594W5knEsMYS
         V1rBltKMmRzHK2C19S++4tbvF9lJLYltMVxbgQBxdcPMl///SoQCCpVTeGkI7FZt5eNb
         MKf2zYm5vUquhg2m6UCGxxnRrZDCSReqnRhTNVD+uZBKKaGHz3jhK2tjQRjCLkhvk2jb
         PydwyVjCnbQN+XeyssZsP8KAlKOOwn/cUYdO1Ks/0OAiF2+6YcO/DllsEGvnbFOYCmz5
         xz7v5xgIEUO2WN7iq4Y3v/Ov8gMlZFmKZH/YLCoACBb4tg1nOrGYLkI9OmfxLnAqoHA/
         P7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512904; x=1701117704;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rSSrLMGlx1q1e+ofvk4heaQm6aCIvNx/xJP1uqrWpDM=;
        b=ssJcY5v2/+cd9cCqgPCHZgYlgE+pVl3aLbaHpGb/b/nb62zg9JBKS91Mborodqy4Kd
         a3o/1ginP0QwrnUGLXA63gBiccVJEhlUzSEu/iSSZHI5q5v2MUB4FLI91WYVyZSl8j4L
         +cOFllw7LZHT95oq/vgTd0Kq1IMiBcQthFKrB8ySGgYBXfxDT3RXHQJccQ758kRRNcU9
         5EFLDBV0Huz2GN3J1JX+9M1JzqKFpCPFE5LuUjdoFndpRInma/wYkYMqZCOR+HZYsJPP
         eheZIiYw07qLpm15N0dyZuGYuyLO8L9EXJtJX5WOQELWvZ4aGyFfW9ba/uMGPouA6fG1
         aryQ==
X-Gm-Message-State: AOJu0Yyipc/6zysxtQc25uCwUy2/pd4mgbYssKX4KZoFW3OS1MgDxvaj
	ut8zNCLh5EEiidWj6bJj5KE=
X-Google-Smtp-Source: AGHT+IGCCBKfUyMnJlDOnlHncRscDbCBEwZ/uUUPRsjL+ffU4GrtzpSPg+NkzEdbdWhu6/hKEid3ow==
X-Received: by 2002:a05:6a00:a25:b0:6c6:b5ae:15a4 with SMTP id p37-20020a056a000a2500b006c6b5ae15a4mr10972930pfh.20.1700512904353;
        Mon, 20 Nov 2023 12:41:44 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id t33-20020a056a0013a100b006cbafd6996csm1719223pfg.123.2023.11.20.12.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:41:43 -0800 (PST)
Date: Mon, 20 Nov 2023 12:41:42 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 netdev@vger.kernel.org, 
 deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 Vipin.Jain@amd.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 tomasz.osinski@intel.com, 
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
Message-ID: <655bc4863bb98_54f420827@john.notmuch>
In-Reply-To: <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch>
 <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho>
 <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho>
 <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim wrote:
> On Mon, Nov 20, 2023 at 1:10=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >
> > Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:
> > >On Mon, Nov 20, 2023 at 4:39=E2=80=AFAM Jiri Pirko <jiri@resnulli.us=
> wrote:
> > >>
> > >> Fri, Nov 17, 2023 at 09:46:11PM CET, jhs@mojatatu.com wrote:
> > >> >On Fri, Nov 17, 2023 at 1:37=E2=80=AFPM John Fastabend <john.fast=
abend@gmail.com> wrote:
> > >> >>
> > >> >> Jamal Hadi Salim wrote:
> > >> >> > On Fri, Nov 17, 2023 at 1:27=E2=80=AFAM John Fastabend <john.=
fastabend@gmail.com> wrote:
> > >> >> > >
> > >> >> > > Jamal Hadi Salim wrote:
> > >>
> > >> [...]
> > >>
> > >>
> > >> >>
> > >> >> I think I'm judging the technical work here. Bullet points.
> > >> >>
> > >> >> 1. p4c-tc implementation looks like it should be slower than a
> > >> >>    in terms of pkts/sec than a bpf implementation. Meaning
> > >> >>    I suspect pipeline and objects laid out like this will lose
> > >> >>    to a BPF program with an parser and single lookup. The p4c-e=
bpf
> > >> >>    compiler should look to create optimized EBPF code not some
> > >> >>    emulated switch topology.
> > >> >>
> > >> >
> > >> >The parser is ebpf based. The other objects which require control=

> > >> >plane interaction are not - those interact via netlink.
> > >> >We published perf data a while back - presented at the P4 worksho=
p
> > >> >back in April (was in the cover letter)
> > >> >https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/202=
3P4WorkshopP4TC.pdf
> > >> >But do note: the correct abstraction is the first priority.
> > >> >Optimization is something we can teach the compiler over time. Bu=
t
> > >> >even with the minimalist code generation you can see that our app=
roach
> > >> >always beats ebpf in LPM and ternary. The other ones I am pretty =
sure
> > >>
> > >> Any idea why? Perhaps the existing eBPF maps are not that suitable=
 for
> > >> this kinds of lookups? I mean in theory, eBPF should be always fas=
ter.
> > >
> > >We didnt look closely; however, that is not the point - the point is=

> > >the perf difference if there is one, is not big with the big win bei=
ng
> > >proper P4 abstraction. For LPM for sure our algorithmic approach is
> > >better. For ternary the compute intensity in looping is better done =
in
> > >C. And for exact i believe that ebpf uses better hashing.
> > >Again, that is not the point we were trying to validate in those exp=
eriments..

If you compared your implementation to the bpf lpm_trie its a bit
misleading. The data structure is a rhashtable vs a Trie doing LPM.

Also I can't see how __p4tc_table_entry_lookup() is going to scale?
That looks like a bucket per key? If so that wont scale well with
1000's of entries and lots of duplicate masks. I did a quick scan
of code, but would be nice to detail the algorithm in the commit
msg so we can disect it.

This doesn't look what we would want though for an LPM unless
I've dropped this out of context.

+static struct p4tc_table_entry *
+__p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_ke=
y *key)
+       __must_hold(RCU)
+{
+       struct p4tc_table_entry *entry =3D NULL;
+       struct rhlist_head *tmp, *bucket_list;
+       struct p4tc_table_entry *entry_curr;
+       u32 smallest_prio =3D U32_MAX;
+
+       bucket_list =3D
+               rhltable_lookup(&table->tbl_entries, key, entry_hlt_param=
s);
+       if (!bucket_list)
+               return NULL;
+
+       rhl_for_each_entry_rcu(entry_curr, tmp, bucket_list, ht_node) {
+               struct p4tc_table_entry_value *value =3D
+                       p4tc_table_entry_value(entry_curr);
+               if (value->prio <=3D smallest_prio) {
+                       smallest_prio =3D value->prio;
+                       entry =3D entry_curr;
+               }
+       }
+
+       return entry;
+}


Also I don't know what 'better done in C' matters the TCAM data structure=

can be written in C and used as a BPF map. At least that is how we would
normally approach it from BPF side.

> > >
> > >On your point of "maps are not that suitable" P4 tables tend to have=

> > >very specific attributes (examples associated meters, counters,
> > >default hit and miss actions, etc).

The typical way we handle this from BPF is to either use the 0 entry
for stats, annotations, etc. or create a blob of memory (another map,
variables, global struct, ...) and stash the info there. If we care
about performance we make those per cpu and deal with it in user
land.

> > >
> > >> >we can optimize over time.
> > >> >Your view of "single lookup" is true for simple programs but if y=
ou
> > >> >have 10 tables trying to model a 5G function then it doesnt make =
sense
> > >> >(and i think the data we published was clear that you gain no
> > >> >advantage using ebpf - as a matter of fact there was no perf
> > >> >difference between XDP and tc in such cases).
> > >> >
> > >> >> 2. p4c-tc control plan looks slower than a directly mmaped bpf
> > >> >>    map. Doing a simple update vs a netlink msg. The argument
> > >> >>    that BPF can't do CRUD (which we had offlist) seems incorrec=
t
> > >> >>    to me. Correct me if I'm wrong with details about why.
> > >> >>
> > >> >
> > >> >So let me see....
> > >> >you want me to replace netlink and all its features and rewrite i=
t
> > >> >using the ebpf system calls? Congestion control, event handling,
> > >> >arbitrary message crafting, etc and the years of work that went i=
nto
> > >> >netlink? NO to the HELL.
> > >>
> > >> Wait, I don't think John suggests anything like that. He just sugg=
ests
> > >> to have the tables as eBPF maps.
> > >
> > >What's the difference? Unless maps can do netlink.
> > >

I'm going to argue map update time matters and we should use the fastest
updates possible. If it complicates user space side some I would prefer
that to slow updates. I don't think you can get much faster than a
mmaped block of memory. Or even syscall updates are probably faster than
netlink msgs.

> > >> Honestly, I don't understand the
> > >> fixation on netlink. Its socket messaging, memcpies, processing
> > >> overhead, etc can't keep up with mmaped memory access at scale. Me=
asure
> > >> that and I bet you'll get drastically different results.
> > >>
> > >> I mean, netlink is good for a lot of things, but does not mean it =
is an
> > >> universal answer to userspace<->kernel data passing.
> > >
> > >Here's a small sample of our requirements that are satisfied by
> > >netlink for P4 object hierarchy[1]:
> > >1. Msg construction/parsing
> > >2. Multi-user request/response messaging
> >
> > What is actually a usecase for having multiple users program p4 pipel=
ine
> > in parallel?
> =

> First of all - this is Linux, multiple users is a way of life, you
> shouldnt have to ask that question unless you are trying to be
> socratic. Meaning multiple control plane apps can be allowed to
> program different parts and even different tables - think multi-tier
> pipeline.

Linux is always been opinionated and rejects code all the time because
its not the "right" way. I've been on the reject your stuff side before.

Partitioning ownershiip of the pipeline is different than multiple
users of the same elements. From BPF side (to show its doable) is
done by pinning maps to files and giving that file to different
programs. The DDOS thing can own the DDOS map and the router can own
its router tables. BPF handles this using the file systems mostly.

> =

> > >3. Multi-user event subscribe/publish messaging
> >
> > Same here. What is the usecase for multiple users receiving p4 events=
?
> =

> Same thing.
> Note: Events are really not part of P4 but we added them for
> flexibility - and as you well know they are useful.

Per above I wouldn't sacrafice update perf for this. Also its doable
from userspace if you need to. Other thing I've come to dislike a bit
is teaching the kernel a specific DSL. P4 is my favorte, but still
going so far as to encode a specific P4 spec into the kernel seems
unnecessary. Also now will we have to have kernel X supports P4.16 and
kernel X+N supports P4.18 it seems like a pain.

> =

> >
> > >
> > >I dont think i need to provide an explanation on the differences her=
e
> > >visavis what ebpf system calls provide vs what netlink provides and
> > >how netlink is a clear fit. If it is not clear i can give more
> >
> > It is not :/
> =

> I thought it was obvious for someone like you, but fine - here goes for=
 those 3:
> =

> 1. Msg construction/parsing: A lot of infra for sending attributes
> back and forth is already built into netlink. I would have to create
> mine from scratch for ebpf.  This will include not just the
> construction/parsing but all the detailed attribute content policy
> validations(even in the presence of hierarchies) that comes with it.
> And not to forget the state transform between kernel and user space.

But the series here does that as well probably could reuse that on
top of BPF. We have lots of libraries to deal with ebpf to help.
I don't see anything problematic here for BPF.

> =

> 2. Multi-user request/response messaging
> If you can write all the code for #1 above then this should work fine f=
or ebpf
> =

> 3. Event publish subscribe
> You would have to create mechanisms for ebpf which either are non
> trivial or non complete: Example 1: you can put surgeries in the ebpf
> code to look at map manipulations and then interface it to some event
> management scheme which checks for subscribed users. Example 2: It may
> also be feasible to create your own map for subscription vs something
> like perf ring for event publication(something i have done in the
> past), but that is also limited in many ways.

I would just push them out over a single perf ring and build the
subscription on top of GRPC (pick your protocol of choice).

> =

> >
> > >breakdown. And of course there's more but above is a good sample.
> > >
> > >The part that is taken for granted is the control plane code and
> > >interaction which is an extremely important detail. P4 Abstraction
> > >requires hierarchies with different compiler generated encoded path
> > >ids etc. This ID mapping gets exacerbated by having multitudes of  P=
4
> >
> > Why the actual eBFP mapping does not serve the same purpose as ID?
> > ID:mapping 1 :1
> =

> An identification of an object requires hierarchical IDs: A
> pipeline/program ID, A table id, a table entry Identification, an
> action identification and for each individual action content
> parameter, an ID etc. These same IDs would be what hardware would
> recognize as well (in case of offload).  Given the dynamic nature of
> these IDs it is essentially up to the compiler to define them. These
> hierarchies  are much easier to validate in netlink.

I'm on board for offloads, but this series says no offloads and we
have no one with hardware in Linux for offloads yet. If we have a
series with a P4 driver and NIC I can get my hands on now we have
an entirely different conversation.

None of this above is a problem in eBPF. Its just mapping ids around.

> =

> We dont want to be constrained to a generic infra like eBPF for these
> objects. Again eBPF is a means to an end (and not the goal here!).

I don't see any constraints from eBPF above just a list of things
that of course you would have to code up. But none of that doesn't
already exist in other projects.

> =

> cheers,
> jamal
> >
> >
> > >programs which have different requirements. Netlink is a natural fit=

> > >for this P4 abstraction. Not to mention the netlink/tc path (and in
> > >particular the ID mapping) provides a conduit for offload when that =
is
> > >needed.
> > >eBPF is just a tool - and the objects are intended to be generic - a=
nd
> > >i dont see how any of this could be achieved without retooling to ma=
ke
> > >it more specific to P4.
> > >
> > >cheers,
> > >jamal
> > >
> > >
> > >
> > >>
> > >> >I should note: that there was an interesting talk at netdevconf 0=
x17
> > >> >where the speaker showed the challenges of dealing with ebpf on "=
day
> > >> >two" - slides or videos are not up yet, but link is:
> > >> >https://netdevconf.info/0x17/sessions/talk/is-scaling-ebpf-easy-y=
et-a-small-step-to-one-server-but-giant-leap-to-distributed-network.html
> > >> >The point the speaker was making is it's always easy to whip an e=
bpf
> > >> >program that can slice and dice packets and maybe even flush LEDs=
 but
> > >> >the real work and challenge is in the control plane. I agree with=
 the
> > >> >speaker based on my experiences. This discussion of replacing net=
link
> > >> >with ebpf system calls is absolutely a non-starter. Let's just en=
d the
> > >> >discussion and agree to disagree if you are going to keep insisti=
ng on
> > >> >that.
> > >>
> > >>
> > >> [...]



