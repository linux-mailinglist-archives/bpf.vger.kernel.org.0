Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6B1A0A0A
	for <lists+bpf@lfdr.de>; Tue,  7 Apr 2020 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDGJ1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 05:27:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20482 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726562AbgDGJ1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 05:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586251623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHheQ4cXaiXVgGbo8v83Bgx9sbs24SZb8yrhs6z5g9c=;
        b=O78eZ7ml7yVIYH/2rkClDWjPgEXroQEXWxE/paNpKi4jttgpngSryoUQZb6pBoD5rsBGtj
        th4XtIpznAKj5jCheaBl2Umg/bAMLVeRh5hSizoDg8HHISbKXxAaZczlgn/GXFjQvlwE5x
        LTa4s4j2RBBWz7gq7GCXzmhKd9pnNX4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-czxLTU9tOFy1RckhEvwz9A-1; Tue, 07 Apr 2020 05:27:01 -0400
X-MC-Unique: czxLTU9tOFy1RckhEvwz9A-1
Received: by mail-ed1-f72.google.com with SMTP id n15so2593971edq.6
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2020 02:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zHheQ4cXaiXVgGbo8v83Bgx9sbs24SZb8yrhs6z5g9c=;
        b=fu1tSG9eFEgRky7BTyh09YYbJzZ7aVw6UrJVPdojuihNAW1NXexExl3Gj8QqXtfwCj
         j3hJKB5EqyaIUMyKzlJ7C/44ptThBagYAqukBa9fsXGjvztf+pcIDwA/fPUczT80kR2X
         zr29RSFFxRxoxuNA+Z6aBvYv1rmCS20sGjU12YuV4UT7kNy0g5izli0xoefHUoOnNaaF
         pY6oj0GF2qK+88giQSmrlAth9Rye0/3ns4vlwo9Pht48sB14XF9svzATi4Izpsgi5KKa
         CxLYMlf4YUWdqQNLTvdKawzJjorPrTN9wpjwdkSk1+oInE03ZAfx7p/nkTZ9NStP58yc
         O0ew==
X-Gm-Message-State: AGi0PuauONRhATA2k5B83xcgIgdxdyqGG+F8Ey4soXUoO4GykUYkHuvl
        pqoCSh8GIUrD/u5xjxkIyD+ssX9WbpHZ8k0oowA4MVeYuvrfvhUjTmh9DY4HYEnqi7jwH+X4D2h
        IO8Js87w2hhAG
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr1118146ljb.167.1586251242461;
        Tue, 07 Apr 2020 02:20:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJSBwRiwTlfH3R7I/88M5kzTyq71MYwQLlb/KbRH0EOaBB/nsLP1m3lQ1L0421ng6GvXDJV+A==
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr1118133ljb.167.1586251242217;
        Tue, 07 Apr 2020 02:20:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r2sm12883940lfn.35.2020.04.07.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:20:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2866D1804E7; Tue,  7 Apr 2020 11:20:39 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: bpf: ability to attach freplace to multiple parents
In-Reply-To: <20200407014455.u7x36kkfmxcllqa6@ast-mbp.dhcp.thefacebook.com>
References: <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <CACAyw9-FrwgBGjGT1CYrKJuyRJtwn0XUsifF_uR6LpRbcucN+A@mail.gmail.com> <20200326195340.dznktutm6yq763af@ast-mbp> <87o8sim4rw.fsf@toke.dk> <20200402202156.hq7wpz5vdoajpqp5@ast-mbp> <87o8s9eg5b.fsf@toke.dk> <20200402215452.dkkbbymnhzlcux7m@ast-mbp> <87ftdldkvl.fsf@toke.dk> <20200407014455.u7x36kkfmxcllqa6@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Apr 2020 11:20:39 +0200
Message-ID: <87r1wzabyw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Apr 03, 2020 at 10:38:38AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>=20
>> > It's a different link.
>> > For fentry/fexit/freplace the link is pair:
>> >   // target           ...         bpf_prog
>> > (target_prog_fd_or_vmlinux, fentry_exit_replace_prog_fd).
>> >
>> > So for xdp case we will have:
>> > root_link =3D (eth0_ifindex, dispatcher_prog_fd) // dispatcher prog at=
tached to eth0
>> > link1 =3D (dispatcher_prog_fd, xdp_firewall1_fd) // 1st extension prog=
 attached to dispatcher
>> > link2 =3D (dispatcher_prog_fd, xdp_firewall2_fd) // 2nd extension prog=
 attached to dispatcher
>> >
>> > Now libxdp wants to update the dispatcher prog.
>> > It generates new dispatcher prog with more placeholder entries or new =
policy:
>> > new_dispatcher_prog_fd.
>> > It's not attached anywhere.
>> > Then libxdp calls new bpf_raw_tp_open() api I'm proposing above to cre=
ate:
>> > link3 =3D (new_dispatcher_prog_fd, xdp_firewall1_fd)
>> > link4 =3D (new_dispatcher_prog_fd, xdp_firewall2_fd)
>> > Now we have two firewalls attached to both old dispatcher prog and new=
 dispatcher prog.
>> > Both firewalls are executing via old dispatcher prog that is active.
>> > Now libxdp calls:
>> > bpf_link_udpate(root_link, dispatcher_prog_fd, new_dispatcher_prog_fd)
>> > which atomically replaces old dispatcher prog with new dispatcher prog=
 in eth0.
>> > The traffic keeps flowing into both firewalls. No packets lost.
>> > But now it goes through new dipsatcher prog.
>> > libxdp can now:
>> > close(dispatcher_prog_fd);
>> > close(link1);
>> > close(link2);
>> > Closing (and destroying two links) will remove old dispatcher prog
>> > from linked list in xdp_firewall1_prog->aux->linked_prog_list and from
>> > xdp_firewall2_prog->aux->linked_prog_list.
>> > Notice that there is no need to explicitly detach old dispatcher prog =
from eth0.
>> > link_update() did it while replacing it with new dispatcher prog.
>>=20
>> Yeah, this was the flow I had in mind already. However, what I meant was
>> that *from the PoV of an application consuming the link fd*, this would
>> lead to dangling links.
>>=20
>> I.e., an application does:
>>=20
>> app1_link_fd =3D libxdp_install_prog(prog1);
>>=20
>> and stores link_fd somewhere (just holds on to it, or pins it
>> somewhere).
>>=20
>> Then later, another application does:
>>=20
>> app2_link_fd =3D libxdp_install_prog(prog2);
>>=20
>> but this has the side-effect of replacing the dispatcher, so
>> app1_link_fd is now no longer valid.
>>=20
>> This can be worked around, of course (e.g., just return the prog_fd and
>> hide any link_fd details inside the library), but if the point of
>> bpf_link is that the application could hold on to it and use it for
>> subsequent replacements, that would be nice to have for consumers of the
>> library as well, no?
>
> link is a pair of (hook, prog). I don't think that single bpf-link (FD)
> should represent (hook1, hook2, hook3, prog). It will be super confusing =
to the
> user space when single FD magically turns into multi attach.

I do agree with this, actually, and mostly brought it up as a point of
discussion to see if we could come up with something better. And I think
this:

> bpf_link_update_hook(app1_link1_fd, app1_link2_fd);
> here I'm proposing a new operation that will close 2nd link and will upda=
te
> hook of the first link with the hook of 2nd link if prog is the same.
> Conceptually it's a similar operation to bpf_link_update() which replaces=
 bpf
> prog in the hook. bpf_link_update_hook() can replace the hook while keepi=
ng the
> program the same.

will work for me, so great! :)

-Toke

