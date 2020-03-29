Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69CA196C8C
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 12:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgC2Kjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Mar 2020 06:39:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42627 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727984AbgC2Kjb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 29 Mar 2020 06:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585478369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Px227/tT3JOh0jsH5FoMkSh3t0mTOD9NE7V9s9sMig=;
        b=Uu6pc5QOKrEr/P87Ilu5gzPFfiSFDjmHMlotCu/0/BvplB6Mn1WoZmzSQniiI5GbG1CsmB
        9XFlNlIunFQftZ2a9rsv4+5pjpRiZ3cf6nAe6vGH+9Tl5V1/MwNSc54SgNKF8G/idkyD90
        wkRGSMSpAze7zyyt6S/ZJutwL/X9brI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-m4hlDdEwNcKE7IAr7mvrLQ-1; Sun, 29 Mar 2020 06:39:27 -0400
X-MC-Unique: m4hlDdEwNcKE7IAr7mvrLQ-1
Received: by mail-lj1-f197.google.com with SMTP id f11so1719219ljo.19
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2020 03:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/Px227/tT3JOh0jsH5FoMkSh3t0mTOD9NE7V9s9sMig=;
        b=uFg+bDX0xUFcSV7Ml5nxHBq4tpe+CBunor2+Gwrde0LB3IzeXomcZz8VH4EAQdtDck
         LqyBJq6z92CGfC3dBxN7aXxH53EeexQbyj/GjV6RppI52BsQza3jViUGE53YpfhuczES
         yZkvNwDocY6hTeKa5KAm4CTVMMOcrC8wY5MaDqyCMonttnAgP//2zVy+X96IfWRUbLo1
         eMGP/DDfaj/h0Cq2yWA9T8nDGFKyvZW2OS4bjhRRXxKhr5+xyN0QB9yc6+U2qgrPGjoo
         KXXTESLhf0TEMJGADOmwrVG3aJKvTTC3Re9HXlTc8T+/Uxruim0iDhF4J34zzlZQeDMo
         GFFQ==
X-Gm-Message-State: AGi0PuYzwvmzngdu8lFe7daRbtQcH9ja8Z009FPAOqPMC9ZzjhOejcpH
        okTGaOnuzfviMzcUnOoQqREMACmX53zuRwfxQk/bG8EO3sYerasQnOWaQJS491ZFQp0XTQAvY/T
        6OGFFZ5WgHcLD
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr5028776lfg.118.1585478366012;
        Sun, 29 Mar 2020 03:39:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypLh340MwvD7JAgzxUxs4FixRWTRk2T26s0J3yvtoO1YomX9n9iOa//jg+bbhR15sOLwvAhylg==
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr5028757lfg.118.1585478365668;
        Sun, 29 Mar 2020 03:39:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v79sm5929362lfa.21.2020.03.29.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 03:39:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9C84918158B; Sun, 29 Mar 2020 12:39:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <20200328233546.7ayswtraepw3ia2x@ast-mbp>
References: <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <87pncznvjy.fsf@toke.dk> <20200326195859.u6inotgrm3ubw5bx@ast-mbp> <87imiqm27d.fsf@toke.dk> <20200327230047.ois5esl35s63qorj@ast-mbp> <87lfnll0eh.fsf@toke.dk> <20200328022609.zfupojim7see5cqx@ast-mbp> <87eetcl1e3.fsf@toke.dk> <20200328233546.7ayswtraepw3ia2x@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 29 Mar 2020 12:39:21 +0200
Message-ID: <87369rla1y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Mar 28, 2020 at 08:34:12PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>=20
>> > On Sat, Mar 28, 2020 at 02:43:18AM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >>=20
>> >> No, I was certainly not planning to use that to teach libxdp to just
>> >> nuke any bpf_link it finds attached to an interface. Quite the contra=
ry,
>> >> the point of this series is to allow libxdp to *avoid* replacing
>> >> something on the interface that it didn't put there itself.
>> >
>> > Exactly! "that it didn't put there itself".
>> > How are you going to do that?
>> > I really hope you thought it through and came up with magic.
>> > Because I tried and couldn't figure out how to do that with IFLA_XDP*
>> > Please walk me step by step how do you think it's possible.
>>=20
>> I'm inspecting the BPF program itself to make sure it's compatible.
>> Specifically, I'm embedding a piece of metadata into the program BTF,
>> using Andrii's encoding trick that we also use for defining maps. So
>> xdp-dispatcher.c contains this[0]:
>>=20
>> __uint(dispatcher_version, XDP_DISPATCHER_VERSION) SEC(XDP_METADATA_SECT=
ION);
>>=20
>> and libxdp will refuse to touch any program that it finds loaded on an
>> iface which doesn't have this, or which has a version number that is
>> higher than what the library understands.
>
> so libxdp will do:
> ifindex -> id of currently attached prog -> fd -> prog_info -> btf -> rea=
d map
> -> find "dispatcher_version"
> and then it will do replace_fd with new version of the dispatcher ?
> I see how this approach helps the second set of races (from fd into "disp=
atcher_version")
> when another libxdp is doing the same.
> But there is still a race in query->id->fd. Much smaller though.

You mean the program can disappear before the ID can be turned into an
fd? Yeah, I guess that can happen, but that can just be treated as a
failure that triggers the retry logic.

> In that sense replace_fd is a better behaved prog replacement than
> just calling bpf_set_link_xdp_fd() without XDP_FLAGS_UPDATE_IF_NOEXIST.
> But not much. The libxdp doesn't own the attachment.
> If replace_fd fails what libxdp is going to do?
> Try the whole thing from the beginning?
> ifindex -> id2 -> fd2 ...

Yes, this is predicated on a "retry on failure" logic.

> Say it succeeded.
> But the libxdp1 that won the first race has no clue that libxdp2
> retried and there is a different dispatcher prog there.
> So you'll add netlink notifiers for libxdp to watch ?

No, the idea is that the dispatchers are compatible. So app1 installs
dispatcher1 with sequence (prog1), then app2 installs dispatcher2 with
sequence (prog1,prog2) - or (prog2,prog1) depending on ordering.

> That would mean that some user space process has to be always running
> while typical firewall doesn't need any user space. The firewall.rpm can=
=20
> install its prog with all firewall rules, permanently link it to
> the interface and exit.
> But let's continue. So single libxdp daemon is now waiting for notificati=
ons
> or both libxdp1 and libxdp2 that are part of two firewalls that are
> being 'yum installed' are waiting for notifications?
> How fight between libxdp1 and libxdp2 to install what they want going
> to be resolved?
> If their versions are the same I think they will settle quickly
> since both libraries will see dispatcher prog with expected version numbe=
r, right?
> What if versions are different? Older libxdp or newer libxdp suppose to g=
ive up?
> If libxdp2 is newer it will still be able to use older dispatcher prog
> that was installed by libxdp1, but it would need to disable all new
> user facing library features?

It will depend on what changes between versions, I guess. But yeah, I
don't think we can completely rule out that a "compatibility mode" may
be necessary at some point. This is orthogonal to how the programs are
being attached, though.

> I guess all that is acceptable behavior to some libxdp users.

I believe so.

>> > I'm saying that without bpf_link for xdp libxdp has no ability to
>> > identify an attachment that is theirs.
>>=20
>> Ah, so *that* was what you meant with "unique attachment". It never
>> occurred to me that answering this question ("is it my program?") was to
>> be a feature of bpf_link; I always assumed that would be a property of
>> the bpf_prog itself.
>>=20
>> Any reason what I'm describing above wouldn't work for you?
>
> I don't see how this is even apples to apples comparison.
> Racy query via id with sort-of "atomic" replacement and no ownership
> vs guaranteed attachment with exact ownership and no races.

No, I guess in your "management daemon" case the kernel-enforced
exclusivity does come in handy. And as I said, I can live with there
being two APIs as long as there's a reasonable way to override the
bpf_link "lock" :)

>> > I see two ways out of this stalemate:
>> > 1. assume that replace_fd extension landed and develop libxdp further
>> >    into fully fledged library. May be not a complete library, but at l=
east
>> >    for few more weeks. If then you still think replace_fd is enough
>> >    I'll land it.
>> > 2. I can land replace_fd now, but please don't be surprised that
>> >    I will revert it several weeks from now when it's clear that
>> >    it's not enough.
>> >=20=20
>> > Which one do you prefer?
>>=20
>> I prefer 2. Reverting if it does turn out that I'm wrong is fine. Heck,
>> in that case I'll even send the revert myself :)
>
> Ok. Applied.

Great, thanks!

-Toke

