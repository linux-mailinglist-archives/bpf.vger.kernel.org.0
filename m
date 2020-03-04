Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7728E178BB2
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 08:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgCDHrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 02:47:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60739 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726920AbgCDHru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 02:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583308070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CNQZZzyik21Diixp1qqCgf0jKvTlEtpje08c+vEKWQ=;
        b=h42TPpkiI559RwVAds8w0PLQA0eV2JUNiZd/taiuxu9ta7kZDKeCRenZSmNs+7LRpOxtDM
        WEdIPoqs7exfC2LfCMmzYxF0FIg9ovTpgMUC7sEMOp/Hsi/tUQrt7BBA9mrXbAi16NJln8
        J5BslQX1FapA1OhH7cQ9AYd75P+Mn5I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-AKBYnHEVOHemX4zc4aZP_A-1; Wed, 04 Mar 2020 02:47:48 -0500
X-MC-Unique: AKBYnHEVOHemX4zc4aZP_A-1
Received: by mail-wr1-f70.google.com with SMTP id w18so514402wro.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 23:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/CNQZZzyik21Diixp1qqCgf0jKvTlEtpje08c+vEKWQ=;
        b=EDRXbHVK1tYNG7XDVwq5nPJPgI/A4Gce0g2e03AENwwZenlAKcci9yGAnjKNlBbMVY
         qhPZ0yuwsGwfxUKixe8fR8sDY3S8XWtMdkjOUyMRPLZbe5D0aoWxhJ9JnHGgPM4nu8rL
         oUutHbhehPuZMg4aBLeYdjQKQmbZFSR0vSIe+QYb+gYru2++TX2vJEOXCglELIo4o8GU
         SzdCWDg1iQ0N7F39iqMkUCIadpjs84wYeV8W+jfZ/PWd6jbpwtvBwnIi5GeW8oq+aGuD
         tlpQAMG0iqG3Gk/Bcu9ARfuoY2w5cNd8TDPMV7saPv/T2b3vZVoPDkRx1U4lIR21A2L6
         5bsg==
X-Gm-Message-State: ANhLgQ3eYBTcvTiFG9X5E2U4aJFnOqWLYTRLfbWkZuB6cnRdS03pYcqR
        ZlQ1pa04fSs28VQdg5emIVqB4EmqkkDZq9UQb+QCps5pAArs4isXsUOobrkdolhlytMxe2hxfXV
        h/Iu1toY2BCM8
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr2212567wmc.158.1583308067596;
        Tue, 03 Mar 2020 23:47:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuxU3J/8GEHOtYrPLsHOPMS9Uy4+5QcLgF3egV/k6stCpO/5eqRUVPxu5jc32EEXRLJyCov8g==
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr2212546wmc.158.1583308067352;
        Tue, 03 Mar 2020 23:47:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i8sm33085502wrq.10.2020.03.03.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:47:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0A842180331; Wed,  4 Mar 2020 08:47:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <20200304043643.nqd2kzvabkrzlolh@ast-mbp>
References: <CAEf4BzZGn9FcUdEOSR_ouqSNvzY2AdJA=8ffMV5mTmJQS-10VA@mail.gmail.com> <87imjms8cm.fsf@toke.dk> <094a8c0f-d781-d2a2-d4cd-721b20d75edd@iogearbox.net> <e9a4351a-4cf9-120a-1ae1-94a707a6217f@fb.com> <8083c916-ac2c-8ce0-2286-4ea40578c47f@iogearbox.net> <CAEf4BzbokCJN33Nw_kg82sO=xppXnKWEncGTWCTB9vGCmLB6pw@mail.gmail.com> <87pndt4268.fsf@toke.dk> <ab2f98f6-c712-d8a2-1fd3-b39abbaa9f64@iogearbox.net> <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com> <87k1413whq.fsf@toke.dk> <20200304043643.nqd2kzvabkrzlolh@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 04 Mar 2020 08:47:44 +0100
Message-ID: <87h7z44l3z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Mar 03, 2020 at 11:27:13PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Alexei Starovoitov <ast@fb.com> writes:
>> >
>> > Legacy api for tc, xdp, cgroup will not be able to override FD-based
>> > link. For TC it's easy. cls-bpf allows multi-prog, so netlink
>> > adding/removing progs will not be able to touch progs that are
>> > attached via FD-based link.
>> > Same thing for cgroups. FD-based link will be similar to 'multi' mode.
>> > The owner of the link has a guarantee that their program will
>> > stay attached to cgroup.
>> > XDP is also easy. Since it has only one prog. Attaching FD-based link
>> > will prevent netlink from overriding it.
>>=20
>> So what happens if the device goes away?
>
> I'm not sure yet whether it's cleaner to make netdev, qdisc, cgroup to be=
 held
> by the link or use notifier approach. There are pros and cons to both.
>
>> > This way the rootlet prog installed by libxdp (let's find a better name
>> > for it) will stay attached.
>>=20
>> Dispatcher prog?
>
> would be great, but 'bpf_dispatcher' name is already used in the kernel.
> I guess we can still call the library libdispatcher and dispatcher prog?
> Alternatives:
> libchainer and chainer prog
> libaggregator and aggregator prog?
> libpolicer kinda fits too, but could be misleading.

Of those, I like 'dispatcher' best.

> libxdp is very confusing. It's not xdp specific.

Presumably the parts that are generally useful will just end up in
libbpf (eventually)?

>> > libxdp can choose to pin it in some libxdp specific location, so other
>> > libxdp-enabled applications can find it in the same location, detach,
>> > replace, modify, but random app that wants to hack an xdp prog won't
>> > be able to mess with it.
>>=20
>> What if that "random app" comes first, and keeps holding on to the link
>> fd? Then the admin essentially has to start killing processes until they
>> find the one that has the device locked, no?
>
> Of course not. We have to provide an api to make it easy to discover
> what process holds that link and where it's pinned.
> But if we go with notifier approach none of it is an issue.
> Whether target obj is held or notifier is used everything I said before s=
till
> stands. "random app" that uses netlink after libdispatcher got its link F=
D will
> not be able to mess with carefully orchestrated setup done by
> libdispatcher.

Protecting things against random modification is fine. What I want to
avoid is XDP/tc programs locking the device so an admin needs to perform
extra steps if it is in use when (e.g.) shutting down a device. XDP
should be something any application can use as acceleration, and if it
becomes known as "that annoying thing that locks my netdev", then that
is not going to happen.

> Also either approach will guarantee that infamous message:
> "unregister_netdevice: waiting for %s to become free. Usage count"
> users will never see.
>
>> And what about the case where the link fd is pinned on a bpffs that is
>> no longer available? I.e., if a netdevice with an XDP program moves
>> namespaces and no longer has access to the original bpffs, that XDP
>> program would essentially become immutable?
>
> 'immutable' will not be possible.
> I'm not clear to me how bpffs is going to disappear. What do you mean
> exactly?

# stat /sys/fs/bpf | grep Device
Device: 1fh/31d	Inode: 1013963     Links: 2
# mkdir /sys/fs/bpf/test; ls /sys/fs/bpf
test
# ip netns add test
# ip netns exec test stat /sys/fs/bpf/test
stat: cannot stat '/sys/fs/bpf/test': No such file or directory
# ip netns exec test stat /sys/fs/bpf | grep Device
Device: 3fh/63d	Inode: 12242       Links: 2

It's a different bpffs instance inside the netns, so it won't have
access to anything pinned in the outer one...

-Toke

