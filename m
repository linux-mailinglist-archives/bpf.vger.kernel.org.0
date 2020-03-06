Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F365A17DC9A
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 10:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgCIJmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 05:42:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26353 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbgCIJml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 05:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583746960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqIeFXSs2Zl2NDVKTxiSYgSso3t8lUiwADBPpfXPCPQ=;
        b=cXaMj+J+1RvYuMTz2b/K3FaGgP05o41K6ywZ3KmUFWBGlo3yIlcMJfJpDwqRZN++7psy/7
        X5cK/LJWsFQ8Map4ixPPZFP92oSYDE0igISAHAnOQvh2uU9U7oX5kUceYNoc46GsP+qkIh
        dtoX0yPYb9jF7pVL6BfYCWeK11te6pM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Z_4CofuVP-yW1S3HJTuqDg-1; Mon, 09 Mar 2020 05:42:37 -0400
X-MC-Unique: Z_4CofuVP-yW1S3HJTuqDg-1
Received: by mail-wr1-f72.google.com with SMTP id y5so4278309wrq.8
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 02:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EqIeFXSs2Zl2NDVKTxiSYgSso3t8lUiwADBPpfXPCPQ=;
        b=H22rIl6mGZjjjAATRorXMIZraWraON6d6GJ6Wh0zXNtCE98EpeLu7nw1oWvIw8yveb
         XsZ7znfbBUZAstbaMkmJIHX0fS3ZTAL9byzStLfZ351PBbSTSM9Bk4g6j5QdthJI9dVX
         t8WPuhwO86u0a1z8o4C1EHXIjfhmDzC4VEyUAdWZ7sHi+Q+0hDo3T8vqzKSrkfqy9rjc
         x4vAwzu2PgXOmExbNO39vKYXxNzcMktfHZ6L2+1x7+IvUdDPL0NV3nY8U2R3O3iVqNUS
         gJIodoefhklKdys5QoMNhKssaDhwO2cFVYsrk4PvWF2VsyQWYJ7I3Y5epgxyl/9T98GF
         9dAA==
X-Gm-Message-State: ANhLgQ1/2j/BU/6FpJncUrGptojqrpBL7tplxotQwUp4NIk7CiWJ1Tvl
        E1Qlloegf6mzPK3ShmOdrCzACzZJc1HFe3zr3kXAa8nKmKus16HO8GrBgTa0o72hEbIZrgNVMn+
        6BvdCNa1maqxG
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr18411960wmg.136.1583746956244;
        Mon, 09 Mar 2020 02:42:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtMUu8y0WNP43nmV5+Ur6NQjrwm+6xeymdFwjyvFUMBKDdL9vavWsyoYLn6bMKaRKvHNPLvYg==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr18411937wmg.136.1583746955903;
        Mon, 09 Mar 2020 02:42:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c11sm60362146wrp.51.2020.03.09.02.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 02:42:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9226218034F; Fri,  6 Mar 2020 11:42:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <374e23b6-572a-8dac-88cb-855069535917@iogearbox.net>
References: <87pndt4268.fsf@toke.dk> <ab2f98f6-c712-d8a2-1fd3-b39abbaa9f64@iogearbox.net> <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com> <87k1413whq.fsf@toke.dk> <20200304043643.nqd2kzvabkrzlolh@ast-mbp> <87h7z44l3z.fsf@toke.dk> <20200304154757.3tydkiteg3vekyth@ast-mbp> <874kv33x60.fsf@toke.dk> <20200305163444.6e3w3u3a5ufphwhp@ast-mbp> <473a3e8a-03ea-636c-f054-3c960bf0fdbd@iogearbox.net> <20200305225027.nazs3gtlcw3gjjvn@ast-mbp> <7b674384-1131-59d4-ee2f-5a17824c1eca@iogearbox.net> <878skd3mw4.fsf@toke.dk> <374e23b6-572a-8dac-88cb-855069535917@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 06 Mar 2020 11:42:31 +0100
Message-ID: <871rq53gtk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 3/6/20 9:31 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>> On 3/5/20 11:50 PM, Alexei Starovoitov wrote:
>>>> On Thu, Mar 05, 2020 at 11:34:18PM +0100, Daniel Borkmann wrote:
>>>>> On 3/5/20 5:34 PM, Alexei Starovoitov wrote:
>>>>>> On Thu, Mar 05, 2020 at 11:37:11AM +0100, Toke H=C3=B8iland-J=C3=B8r=
gensen wrote:
>>>>>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>>>>>>> On Wed, Mar 04, 2020 at 08:47:44AM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>>>>> [...]
>>>>>>> Anyway, what I was trying to express:
>>>>>>>
>>>>>>>> Still that doesn't mean that pinned link is 'immutable'.
>>>>>>>
>>>>>>> I don't mean 'immutable' in the sense that it cannot be removed eve=
r.
>>>>>>> Just that we may end up in a situation where an application can see=
 a
>>>>>>> netdev with an XDP program attached, has the right privileges to mo=
dify
>>>>>>> it, but can't because it can't find the pinned bpf_link. Right? Or =
am I
>>>>>>> misunderstanding your proposal?
>>>>>>>
>>>>>>> Amending my example from before, this could happen by:
>>>>>>>
>>>>>>> 1. Someone attaches a program to eth0, and pins the bpf_link to
>>>>>>>       /sys/fs/bpf/myprog
>>>>>>>
>>>>>>> 2. eth0 is moved to a different namespace which mounts a new sysfs =
at
>>>>>>>       /sys
>>>>>>>
>>>>>>> 3. Inside that namespace, /sys/fs/bpf/myprog is no longer accessibl=
e, so
>>>>>>>       xdp-loader can't get access to the original bpf_link; but the=
 XDP
>>>>>>>       program is still attached to eth0.
>>>>>>
>>>>>> The key to decide is whether moving netdev across netns should be al=
lowed
>>>>>> when xdp attached. I think it should be denied. Even when legacy xdp
>>>>>> program is attached, since it will confuse user space managing part.
>>>>>
>>>>> There are perfectly valid use cases where this is done already today =
(minus
>>>>> bpf_link), for example, consider an orchestrator that is setting up t=
he BPF
>>>>> program on the device, moving to the newly created application pod du=
ring
>>>>> the CNI call in k8s, such that the new pod does not have the /sys/fs/=
bpf/
>>>>> mount instance and if unprivileged cannot remove the BPF prog from th=
e dev
>>>>> either. We do something like this in case of ipvlan, meaning, we atta=
ch a
>>>>> rootlet prog that calls into single slot of a tail call map, move it =
to the
>>>>> application pod, and only out of Cilium's own pod and it's pod-local =
bpf fs
>>>>> instance we manage the pinned tail call map to update the main progra=
ms in
>>>>> that single slot w/o having to switch any netns later on.
>>>>
>>>> Right. You mentioned this use case before, but I managed to forget abo=
ut it.
>>>> Totally makes sense for prog to stay attached to netdev when it's move=
d.
>>>> I think pod manager would also prefer that pod is not able to replace
>>>> xdp prog from inside the container. It sounds to me that steps 1,2,3 a=
bove
>>>> is exactly the desired behavior. Otherwise what stops some application
>>>> that started in a pod to override it?
>>>
>>> Generally, yes, and it shouldn't need to care nor see what is happening=
 in
>>> /sys/fs/bpf/ from the orchestrator at least (or could potentially have =
its
>>> own private mount under /sys/fs/bpf/ or elsewhere). Ideally, the behavi=
or
>>> should be that orchestrator does all the setup out of its own namespace,
>>> then moves everything over to the newly created target namespace and e.=
g.
>>> only if the pod has the capable(cap_sys_admin) permissions, it could me=
ss
>>> around with anything attached there, or via similar model as done in [0]
>>> when there is a master device.
>>=20
>> Yup, I can see how this can be a reasonable use case where you *would*
>> want the locking. However, my concern is that there should be a way for
>> an admin to recover from this (say, if it happens by mistake, or a
>> misbehaving application). Otherwise, I fear we'll end up with support
>> cases where the only answer is "try rebooting", which is obviously not
>> ideal.
>
> I'm not quite sure I follow the concern, if you're an admin and have
> the right permissions, then you should be able to introspect and
> change settings like with anything else there is today.

Well, that's what I want to make sure of :)

However, I don't think such introspection is possible today? Or at least
there's no API exposed to do this, you'll have to go write drgn scripts
or something. But I expect an admin will want a command like 'xdp unload
eth0 --yes-i-really-really-mean-this', which would override any locking
done by bpf_link. So how to implement that? It's not enough to learn
'this bpf_link is pinned at links/id-123 on bpffs', you'll also need to
learn on *which* bpffs, and where to find that mountpoint. So how do you
do that?

Whereas an API that says 'return the bpf_link currently attached to
ifindex X' would sidestep this issue; but then, that is basically the
netlink API we have already, except it doesn't have the bpf_link
abstraction... So why do we need bpf_link?

>>> Last time I looked, there is a down/up cycle on the dev upon netns
>>> migration and it flushes e.g. attached qdiscs afaik, so there are
>>> limitations that still need to be addressed. Not sure atm if same is
>>> happening to XDP right now.
>>=20
>> XDP programs will stay attached. devmaps (for redirect) have a notifier
>> that will remove devices when they move out of a namespace. Not sure if
>> there are any other issues with netns moves somewhere.
>>=20
>>> In this regards veth devices are a bit nicer to work with since
>>> everything can be attached on hostns ingress w/o needing to worry on
>>> the peer dev in the pod's netns.
>>=20
>> Presumably the XDP EGRESS hook that David Ahern is working on will make
>> this doable for XDP on veth as well?
>
> I'm not sure I see a use-case for XDP egress for Cilium yet, but maybe
> I'm still lacking a clear picture on why one should use it. We
> currently use various layers where we orchestrate our BPF programs
> from the agent. XDP/rx on the phys nic on the one end, BPF sock progs
> attached to cgroups on the other end of the spectrum. The processing
> in between on virtual devices is mainly tc/BPF-based since everything
> is skb based anyway and more flexible also with interaction with the
> rest of the stack. There is also not this pain of having to linearize
> all the skbs, but at least there's a path to tackle that.

I agree that there's not really any reason to use XDP on veth as long as
you'll end up with an skb eventually anyway. The only reason to do
something different I can think of is if you have an application inside
a container using AF_XDP, and you want to carry XDP frames all the way
through to that without ever building an skb. Not really sure this is a
good deployment model, but I kinda suspect that the NFV guys will want
to do this eventually...

-Toke

