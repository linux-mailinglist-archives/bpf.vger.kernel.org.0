Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581ECFC66D
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfKNMl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Nov 2019 07:41:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726142AbfKNMl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Nov 2019 07:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573735315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECkEGr+qK/Swn5pvZTdofi5qVIBtMcFqMAJiIYcc4/M=;
        b=UWKknVS4GXYzFqzpwIpYZkXjmuOFHTVJu7EKi+aXAtjE/M21sodbf3bQiDq4HK8U/zp00y
        fwDjUxzgcoB9imV9kJXRt3TVx3rl/ywR3EdPdmUanr0w5xvZP2xFqHnUWEabDQg+9AdZJW
        CXoxMNf0f53HtxZkVTxoZVgnK7WLZVQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-ctzJ2gbyPHG5Lkn1ff8Ugw-1; Thu, 14 Nov 2019 07:41:54 -0500
Received: by mail-lf1-f71.google.com with SMTP id y188so1923899lfc.6
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 04:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oCoCmtLjvAB1A9Ci8WMYETXnXg5EK2J/H0m9sYkk8N8=;
        b=a5/iHGDl93bwb1ZsSsPQSAS/oO0YYKk1J0PKuZdHUL3aWlwn16jeJtyHwujBuPI0Hv
         F0OLKQ1w1HF4A6GHFctwRmqrUeCXEsgDchcINc7RKehpFFXq4prjRaiZGRNv18+GnmAT
         KwhL+fHi0QaZezzRmhpMfuIR5KnmzGpU7fI3LbMw6N9VxodwMu4nMp4cqx4iGIuKPdbK
         +45/J7Q3LbutbDDdMtjjMPYc6FQZMuaYZcNgMaPCWc1NNvhbAklGl/PKwnd/ysahdawQ
         zwUv5OeFbC6hsh45LWVXiL4sphf2oeTnuA6zOgc/t0LvYMqs3fLX+90eRoC0Vxb3ewBt
         a5LA==
X-Gm-Message-State: APjAAAVzVCfku4aO48QwlGiznTxDY5MqI4O3DBwaG96/c9fXmxwGc09O
        A7MVNXAAXR1HUsxwp/nfI4h2Fe4+UJl0RsPA1F3mgbegxpUTe6IB2NiFvmKymTy0gT18WO+xjvS
        jZyIs6t6R4+sN
X-Received: by 2002:a2e:a175:: with SMTP id u21mr6417959ljl.198.1573735312375;
        Thu, 14 Nov 2019 04:41:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwriPN1T2ffOYhYkV7E3jw2yuImhjLaM93dJVjTYk+/jm//V5fvnNNDPgo7DkuLYqSaqj3xmQ==
X-Received: by 2002:a2e:a175:: with SMTP id u21mr6417943ljl.198.1573735312086;
        Thu, 14 Nov 2019 04:41:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o26sm2382557lfi.57.2019.11.14.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 04:41:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 592521803C7; Thu, 14 Nov 2019 13:41:50 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Pravin B Shelar <pshelar@ovn.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        William Tu <u9012063@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [RFC PATCH v2 bpf-next 00/15] xdp_flow: Flow offload to XDP
In-Reply-To: <c1b7ff64-6574-74c7-cd6b-5aa353ec80ce@gmail.com>
References: <20191018040748.30593-1-toshiaki.makita1@gmail.com> <5da9d8c125fd4_31cf2adc704105c456@john-XPS-13-9370.notmuch> <22e6652c-e635-4349-c863-255d6c1c548b@gmail.com> <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch> <87h840oese.fsf@toke.dk> <5db128153c75_549d2affde7825b85e@john-XPS-13-9370.notmuch> <87sgniladm.fsf@toke.dk> <a7f3d86b-c83c-7b0d-c426-684b8dfe4344@gmail.com> <87zhhmrz7w.fsf@toke.dk> <b2ecf3e6-a8f1-cfd9-0dd3-e5f4d5360c0b@gmail.com> <87zhhhnmg8.fsf@toke.dk> <640418c3-54ba-cd62-304f-fd9f73f25a42@gmail.com> <87blthox30.fsf@toke.dk> <c1b7ff64-6574-74c7-cd6b-5aa353ec80ce@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 14 Nov 2019 13:41:50 +0100
Message-ID: <87lfsiocj5.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ctzJ2gbyPHG5Lkn1ff8Ugw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toshiaki Makita <toshiaki.makita1@gmail.com> writes:

> On 2019/11/13 1:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toshiaki Makita <toshiaki.makita1@gmail.com> writes:
>>>
>>> Hi Toke,
>>>
>>> Sorry for the delay.
>>>
>>> On 2019/10/31 21:12, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Toshiaki Makita <toshiaki.makita1@gmail.com> writes:
>>>>
>>>>> On 2019/10/28 0:21, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Toshiaki Makita <toshiaki.makita1@gmail.com> writes:
>>>>>>>> Yeah, you are right that it's something we're thinking about. I'm =
not
>>>>>>>> sure we'll actually have the bandwidth to implement a complete sol=
ution
>>>>>>>> ourselves, but we are very much interested in helping others do th=
is,
>>>>>>>> including smoothing out any rough edges (or adding missing feature=
s) in
>>>>>>>> the core XDP feature set that is needed to achieve this :)
>>>>>>>
>>>>>>> I'm very interested in general usability solutions.
>>>>>>> I'd appreciate if you could join the discussion.
>>>>>>>
>>>>>>> Here the basic idea of my approach is to reuse HW-offload infrastru=
cture
>>>>>>> in kernel.
>>>>>>> Typical networking features in kernel have offload mechanism (TC fl=
ower,
>>>>>>> nftables, bridge, routing, and so on).
>>>>>>> In general these are what users want to accelerate, so easy XDP use=
 also
>>>>>>> should support these features IMO. With this idea, reusing existing
>>>>>>> HW-offload mechanism is a natural way to me. OVS uses TC to offload
>>>>>>> flows, then use TC for XDP as well...
>>>>>>
>>>>>> I agree that XDP should be able to accelerate existing kernel
>>>>>> functionality. However, this does not necessarily mean that the kern=
el
>>>>>> has to generate an XDP program and install it, like your patch does.
>>>>>> Rather, what we should be doing is exposing the functionality throug=
h
>>>>>> helpers so XDP can hook into the data structures already present in =
the
>>>>>> kernel and make decisions based on what is contained there. We alrea=
dy
>>>>>> have that for routing; L2 bridging, and some kind of connection
>>>>>> tracking, are obvious contenders for similar additions.
>>>>>
>>>>> Thanks, adding helpers itself should be good, but how does this let u=
sers
>>>>> start using XDP without having them write their own BPF code?
>>>>
>>>> It wouldn't in itself. But it would make it possible to write XDP
>>>> programs that could provide the same functionality; people would then
>>>> need to run those programs to actually opt-in to this.
>>>>
>>>> For some cases this would be a simple "on/off switch", e.g.,
>>>> "xdp-route-accel --load <dev>", which would install an XDP program tha=
t
>>>> uses the regular kernel routing table (and the same with bridging). We
>>>> are planning to collect such utilities in the xdp-tools repo - I am
>>>> currently working on a simple packet filter:
>>>> https://github.com/xdp-project/xdp-tools/tree/xdp-filter
>>>
>>> Let me confirm how this tool adds filter rules.
>>> Is this adding another commandline tool for firewall?
>>>
>>> If so, that is different from my goal.
>>> Introducing another commandline tool will require people to learn
>>> more.
>>>
>>> My proposal is to reuse kernel interface to minimize such need for
>>> learning.
>>=20
>> I wasn't proposing that this particular tool should be a replacement for
>> the kernel packet filter; it's deliberately fairly limited in
>> functionality. My point was that we could create other such tools for
>> specific use cases which could be more or less drop-in (similar to how
>> nftables has a command line tool that is compatible with the iptables
>> syntax).
>>=20
>> I'm all for exposing more of the existing kernel capabilities to XDP.
>> However, I think it's the wrong approach to do this by reimplementing
>> the functionality in eBPF program and replicating the state in maps;
>> instead, it's better to refactor the existing kernel functionality to it
>> can be called directly from an eBPF helper function. And then ship a
>> tool as part of xdp-tools that installs an XDP program to make use of
>> these helpers to accelerate the functionality.
>>=20
>> Take your example of TC rules: You were proposing a flow like this:
>>=20
>> Userspace TC rule -> kernel rule table -> eBPF map -> generated XDP
>> program
>>=20
>> Whereas what I mean is that we could do this instead:
>>=20
>> Userspace TC rule -> kernel rule table
>>=20
>> and separately
>>=20
>> XDP program -> bpf helper -> lookup in kernel rule table
>
> Thanks, now I see what you mean.
> You expect an XDP program like this, right?
>
> int xdp_tc(struct xdp_md *ctx)
> {
> =09int act =3D bpf_xdp_tc_filter(ctx);
> =09return act;
> }

Yes, basically, except that the XDP program would need to parse the
packet first, and bpf_xdp_tc_filter() would take a parameter struct with
the parsed values. See the usage of bpf_fib_lookup() in
bpf/samples/xdp_fwd_kern.c

> But doesn't this way lose a chance to reduce/minimize the program to
> only use necessary features for this device?

Not necessarily. Since the BPF program does the packet parsing and fills
in the TC filter lookup data structure, it can limit what features are
used that way (e.g., if I only want to do IPv6, I just parse the v6
header, ignore TCP/UDP, and drop everything that's not IPv6). The lookup
helper could also have a flag argument to disable some of the lookup
features.

It would probably require a bit of refactoring in the kernel data
structures so they can be used without being tied to an skb. David Ahern
did something similar for the fib. For the routing table case, that
resulted in a significant speedup: About 2.5x-3x the performance when
using it via XDP (depending on the number of routes in the table).

-Toke

