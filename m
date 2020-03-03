Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11F1785A0
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCCW1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:27:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727304AbgCCW1U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 17:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583274439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CC20LT4gr80OBqkXVh4lxEL7vGOkI1o+Imq0RomSfwc=;
        b=QwfWPrkUlt9jdUOM4iza46l4ZE03oG+H1nHnKY1M5niypzq42i+v+GumfVtBG0wk5eRFx2
        hG3AgBMuwOE0EyxDT04MAfQjxGrhVFOwMeMDPn2EZicgD/raiwJJe7pcVWsUVQmDIqKKYq
        wgZWmFWUsd5dxyPWIVGhx/cFRab4XoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-nnlwa4rDOgGzAXPJp65Chw-1; Tue, 03 Mar 2020 17:27:17 -0500
X-MC-Unique: nnlwa4rDOgGzAXPJp65Chw-1
Received: by mail-wm1-f72.google.com with SMTP id 7so27104wmo.7
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 14:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CC20LT4gr80OBqkXVh4lxEL7vGOkI1o+Imq0RomSfwc=;
        b=gPwV0DPtVzgJFX+YaY/cSjQogaF6u/mxMtXXst/LhchlLVdjlWm/UbrEt0F3v4gXGB
         yMkir9MEreJoKJ7bHllmNEBgg3d2UL6Ln2bdZdelh4HeVL4XptwP4gvWb1zfZEsVssRn
         PYkfcyHb/aT0FLafdtzuzAN36rvQD3c6W69cWxwATK0+1JSaXzVXtuURsVu9bWbBzHIo
         8+f1Pyp+Rcc1cDJ6J2CCZtCopGvOvxWynGnf9V1UPjjgpQP5dC1Zb9N2iRi0A5bbT2y9
         rJqegGMoZhLWfvhP/Mh8qBPWAA7Ow2booVsXEjBZ0mkxImCyV9qLrl4K5pkHuZRSpAK0
         j0Wg==
X-Gm-Message-State: ANhLgQ1PxShjwXPBLjgAm6uy/AOM2KZ+aRnGtFZcTkhY0DAUavbAOo1t
        PqLKHCtP7CDMQnuWjMfbQb9/byGUU2jtRmB70JK4IOL6uKzwhxszy4Gq+/Y5M8PbuxW28fwXRUH
        4fBudIaIYsvB3
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr600238wmc.71.1583274436144;
        Tue, 03 Mar 2020 14:27:16 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsbvpULOHdHx+tHskEmx01R65AAJkIgYQLYGgtpLfs6wgbIIEoW3/UrkNRu1IiZKcmpd7I5xQ==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr600224wmc.71.1583274435881;
        Tue, 03 Mar 2020 14:27:15 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o11sm24861430wrn.6.2020.03.03.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:27:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9C2AE180331; Tue,  3 Mar 2020 23:27:13 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com>
References: <20200228223948.360936-1-andriin@fb.com> <87mu8zt6a8.fsf@toke.dk> <CAEf4BzZGn9FcUdEOSR_ouqSNvzY2AdJA=8ffMV5mTmJQS-10VA@mail.gmail.com> <87imjms8cm.fsf@toke.dk> <094a8c0f-d781-d2a2-d4cd-721b20d75edd@iogearbox.net> <e9a4351a-4cf9-120a-1ae1-94a707a6217f@fb.com> <8083c916-ac2c-8ce0-2286-4ea40578c47f@iogearbox.net> <CAEf4BzbokCJN33Nw_kg82sO=xppXnKWEncGTWCTB9vGCmLB6pw@mail.gmail.com> <87pndt4268.fsf@toke.dk> <ab2f98f6-c712-d8a2-1fd3-b39abbaa9f64@iogearbox.net> <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 03 Mar 2020 23:27:13 +0100
Message-ID: <87k1413whq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@fb.com> writes:

> On 3/3/20 12:53 PM, Daniel Borkmann wrote:
>> 
>> I think it depends on the environment, and yes, whether the orchestrator
>> of those progs controls the host [networking] as in case of Cilium. We
>> actually had cases where a large user in prod was accidentally removing
>> the Cilium k8s daemon set (and hence the user space agent as well) and only
>> noticed 1hrs later since everything just kept running in the data path as
>> expected w/o causing them an outage. So I think both attachment semantics
>> have pros and cons. ;)
>
> of course. that's why there is pinning of FD-based links.
> There are cases where pinning is useful and there are cases where
> pinning will cause outages.
> During app restart temporary pinning might be useful too.
>
>> But then are you also expecting that netlink requests which drop that tc
>> filter that holds this BPF prog would get rejected given it has a bpf_link,
>> is active & pinned and traffic goes through? If not the case, then what
>> would be the point? If it is the case, then this seems rather complex to
>> realize for rather little gain given there are two uapi interfaces (bpf,
>> tc/netlink) which then mess around with the same underlying object in
>> different ways.
>
> Legacy api for tc, xdp, cgroup will not be able to override FD-based
> link. For TC it's easy. cls-bpf allows multi-prog, so netlink
> adding/removing progs will not be able to touch progs that are
> attached via FD-based link.
> Same thing for cgroups. FD-based link will be similar to 'multi' mode.
> The owner of the link has a guarantee that their program will
> stay attached to cgroup.
> XDP is also easy. Since it has only one prog. Attaching FD-based link
> will prevent netlink from overriding it.

So what happens if the device goes away?

> This way the rootlet prog installed by libxdp (let's find a better name
> for it) will stay attached.

Dispatcher prog?

> libxdp can choose to pin it in some libxdp specific location, so other
> libxdp-enabled applications can find it in the same location, detach,
> replace, modify, but random app that wants to hack an xdp prog won't
> be able to mess with it.

What if that "random app" comes first, and keeps holding on to the link
fd? Then the admin essentially has to start killing processes until they
find the one that has the device locked, no?

And what about the case where the link fd is pinned on a bpffs that is
no longer available? I.e., if a netdevice with an XDP program moves
namespaces and no longer has access to the original bpffs, that XDP
program would essentially become immutable?

> We didn't come up with these design choices overnight. It came from
> hard lessons learned while deploying xdp, tc and cgroup in production.
> Legacy apis will not be deprecated, of course.

Not deprecated, just less privileged?

-Toke

