Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0ACDF964E
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2019 17:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKLQz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Nov 2019 11:55:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727491AbfKLQxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Nov 2019 11:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573577610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlBZRxaCwIO+hTHyP8BUM9r+6mIgfs4fxHHNl0Ll8uc=;
        b=fOPze3IFO+zr8mUGp5+88NpWG+qv6Bl7sGk8VopUbRHjZDSkSHDQZnDsi7g7Dnwba2lkyw
        XpblVbgiXU0z8ohLjRa9y3LFZDhqrpmWza/gQZdszOq0+SOTTqQDZmIjL+dnTLxmf2qnf8
        RH/tZfcNxRv4j8+dLGojONLuoDhfr38=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-MLtFqMvhOLmdOMMj49_NPg-1; Tue, 12 Nov 2019 11:53:27 -0500
Received: by mail-lf1-f72.google.com with SMTP id p4so4030989lfo.10
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2019 08:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ry4Bl8KYLo0XfHbbGqZyMrR799hLUGM4a2dGEPVW9jg=;
        b=S6MV6vl1bDbvx7ttD/5OfRMBeTlksiVwXM2X4EMY7ULEiECH8XxQFHmP9mSPS6dNw3
         0quviVn9l1Sujejf8NlES+bWC2G3e/o7+AmB4wh96qso+sMC895CjNnKkS6P4fM4lHC5
         4ATMPzKD1edP+3hfib/76yP+ohvCHNb8dLN7g41oRv5tsg0pGN6q/kwVYj85STGbS6/s
         Fj066FT4I6aLkdjkolkyWJ5jVJ+3CXrSTDxokNk14iZo5banL9PzuX47y3cy4WKvMkxJ
         MTP9Q1eL/xurLV7h9XQJe4WXcEepd3FgVWBcD6sevLsLvMPMM8Hv3i6UWWmNWz314lwv
         nVZA==
X-Gm-Message-State: APjAAAV6AK3cTrfidbDxif+J29Xh5ikcptu+a9cmFpZ97Fh4ytgXDeyx
        pFB6fVxzqbpHdEsOwcVJrPokEWiesjsy6wulqqgTBnIegLHjCqiBjeEztysrEZTSP6yeoi4cQZ8
        zNt4MNFz6MrgN
X-Received: by 2002:a19:c6d6:: with SMTP id w205mr18537443lff.17.1573577606067;
        Tue, 12 Nov 2019 08:53:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNEBDrDX8yF7qY9BBzUwmm4M1po+Iuw3FQvTB0eFuf1TWc2WSJI/9tseiVkKRC1WoS8oFvWg==
X-Received: by 2002:a19:c6d6:: with SMTP id w205mr18537422lff.17.1573577605798;
        Tue, 12 Nov 2019 08:53:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y6sm8443484ljm.95.2019.11.12.08.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:53:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E44F61803C7; Tue, 12 Nov 2019 17:53:23 +0100 (CET)
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
In-Reply-To: <640418c3-54ba-cd62-304f-fd9f73f25a42@gmail.com>
References: <20191018040748.30593-1-toshiaki.makita1@gmail.com> <5da9d8c125fd4_31cf2adc704105c456@john-XPS-13-9370.notmuch> <22e6652c-e635-4349-c863-255d6c1c548b@gmail.com> <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch> <87h840oese.fsf@toke.dk> <5db128153c75_549d2affde7825b85e@john-XPS-13-9370.notmuch> <87sgniladm.fsf@toke.dk> <a7f3d86b-c83c-7b0d-c426-684b8dfe4344@gmail.com> <87zhhmrz7w.fsf@toke.dk> <b2ecf3e6-a8f1-cfd9-0dd3-e5f4d5360c0b@gmail.com> <87zhhhnmg8.fsf@toke.dk> <640418c3-54ba-cd62-304f-fd9f73f25a42@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 12 Nov 2019 17:53:23 +0100
Message-ID: <87blthox30.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: MLtFqMvhOLmdOMMj49_NPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toshiaki Makita <toshiaki.makita1@gmail.com> writes:
>
> Hi Toke,
>
> Sorry for the delay.
>
> On 2019/10/31 21:12, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toshiaki Makita <toshiaki.makita1@gmail.com> writes:
>>=20
>>> On 2019/10/28 0:21, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Toshiaki Makita <toshiaki.makita1@gmail.com> writes:
>>>>>> Yeah, you are right that it's something we're thinking about. I'm no=
t
>>>>>> sure we'll actually have the bandwidth to implement a complete solut=
ion
>>>>>> ourselves, but we are very much interested in helping others do this=
,
>>>>>> including smoothing out any rough edges (or adding missing features)=
 in
>>>>>> the core XDP feature set that is needed to achieve this :)
>>>>>
>>>>> I'm very interested in general usability solutions.
>>>>> I'd appreciate if you could join the discussion.
>>>>>
>>>>> Here the basic idea of my approach is to reuse HW-offload infrastruct=
ure
>>>>> in kernel.
>>>>> Typical networking features in kernel have offload mechanism (TC flow=
er,
>>>>> nftables, bridge, routing, and so on).
>>>>> In general these are what users want to accelerate, so easy XDP use a=
lso
>>>>> should support these features IMO. With this idea, reusing existing
>>>>> HW-offload mechanism is a natural way to me. OVS uses TC to offload
>>>>> flows, then use TC for XDP as well...
>>>>
>>>> I agree that XDP should be able to accelerate existing kernel
>>>> functionality. However, this does not necessarily mean that the kernel
>>>> has to generate an XDP program and install it, like your patch does.
>>>> Rather, what we should be doing is exposing the functionality through
>>>> helpers so XDP can hook into the data structures already present in th=
e
>>>> kernel and make decisions based on what is contained there. We already
>>>> have that for routing; L2 bridging, and some kind of connection
>>>> tracking, are obvious contenders for similar additions.
>>>
>>> Thanks, adding helpers itself should be good, but how does this let use=
rs
>>> start using XDP without having them write their own BPF code?
>>=20
>> It wouldn't in itself. But it would make it possible to write XDP
>> programs that could provide the same functionality; people would then
>> need to run those programs to actually opt-in to this.
>>=20
>> For some cases this would be a simple "on/off switch", e.g.,
>> "xdp-route-accel --load <dev>", which would install an XDP program that
>> uses the regular kernel routing table (and the same with bridging). We
>> are planning to collect such utilities in the xdp-tools repo - I am
>> currently working on a simple packet filter:
>> https://github.com/xdp-project/xdp-tools/tree/xdp-filter
>
> Let me confirm how this tool adds filter rules.
> Is this adding another commandline tool for firewall?
>
> If so, that is different from my goal.
> Introducing another commandline tool will require people to learn
> more.
>
> My proposal is to reuse kernel interface to minimize such need for
> learning.

I wasn't proposing that this particular tool should be a replacement for
the kernel packet filter; it's deliberately fairly limited in
functionality. My point was that we could create other such tools for
specific use cases which could be more or less drop-in (similar to how
nftables has a command line tool that is compatible with the iptables
syntax).

I'm all for exposing more of the existing kernel capabilities to XDP.
However, I think it's the wrong approach to do this by reimplementing
the functionality in eBPF program and replicating the state in maps;
instead, it's better to refactor the existing kernel functionality to it
can be called directly from an eBPF helper function. And then ship a
tool as part of xdp-tools that installs an XDP program to make use of
these helpers to accelerate the functionality.

Take your example of TC rules: You were proposing a flow like this:

Userspace TC rule -> kernel rule table -> eBPF map -> generated XDP
program

Whereas what I mean is that we could do this instead:

Userspace TC rule -> kernel rule table

and separately

XDP program -> bpf helper -> lookup in kernel rule table


-Toke

