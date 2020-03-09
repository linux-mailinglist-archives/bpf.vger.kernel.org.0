Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF117DED9
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCILlV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 07:41:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgCILlV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Mar 2020 07:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583754080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2w+VmJgG5BBUTy1bolGQ0hlYPr2KMXXVP5PZpIcBd0=;
        b=gPT0+DWsrWYShXneYavgAyvcCB80dHqTsXZOl1U1WGTJGsvWi1NwIjnJl5bw/3/XLnTnCk
        wyLgVCP3zs2NUMBcM9MpIwTJtu/LX0H+cLHMFrBsTOku6MoMU/QxcfKARXIyRgtgAZLT1A
        cw0x2IdJzxyP17bZnWR1H4Osr+SmZ9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-0B60AtJgMB2hcOo97OKg3Q-1; Mon, 09 Mar 2020 07:41:19 -0400
X-MC-Unique: 0B60AtJgMB2hcOo97OKg3Q-1
Received: by mail-wm1-f72.google.com with SMTP id 20so370514wmk.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 04:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I2w+VmJgG5BBUTy1bolGQ0hlYPr2KMXXVP5PZpIcBd0=;
        b=fALflO56i4qZmrEpaapi5+4mVGTDJThARHgxEJKBBwyhClSqvXe65Zoy00Vxq6+4CT
         nDBe5PSjSwlDXc6t1W6mWS0iDJ9zkvz2c7Fne2VLt9QX74nD5an9JAqzTuzC09J8cp2T
         shwbzFmNGs2apwan0mX/OEj4dnukEdHhJWkV1qzFQ77MsBt4MjijQV0G0L6HCrRzTNDp
         9ge4aL0Z008txZLYb+tuoUXvIui/BYlVdPK62Uf1yULAC9FvUEyP6KfQ2I4YW39U8JKS
         KyLDFErToFp3AczbjZKhMe70kQt452SnIyhP5EznZMo0Y/HcRjeikcpAGti0EgluqMdg
         DLSA==
X-Gm-Message-State: ANhLgQ16+4ytUpYJnDbg2a3dBeyBdPsfdXb749GYRgJtvOb8JWeqoQU4
        9V2xY6fkX94e6dLH18ETcKLz1Pc1qzLUTRgEOr3wSX2WZ1gAONhvmYTf0SOA/anph/Ar0OX5SNw
        kwcuNfyTZ6wwa
X-Received: by 2002:a1c:f606:: with SMTP id w6mr19664826wmc.109.1583754077756;
        Mon, 09 Mar 2020 04:41:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsMUF0WKSS6DKKy5bdX0wrEuSWa78iFzLLPion/xNQnUsEXa8wViujbea5nsBVkSdJzl0i1ZQ==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr19664806wmc.109.1583754077536;
        Mon, 09 Mar 2020 04:41:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 61sm11265856wrd.58.2020.03.09.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:41:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0739318033D; Mon,  9 Mar 2020 12:41:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <20200305101342.01427a2a@kicinski-fedora-PC1C0HJN>
References: <8083c916-ac2c-8ce0-2286-4ea40578c47f@iogearbox.net> <CAEf4BzbokCJN33Nw_kg82sO=xppXnKWEncGTWCTB9vGCmLB6pw@mail.gmail.com> <87pndt4268.fsf@toke.dk> <ab2f98f6-c712-d8a2-1fd3-b39abbaa9f64@iogearbox.net> <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com> <87k1413whq.fsf@toke.dk> <20200304043643.nqd2kzvabkrzlolh@ast-mbp> <20200304114000.56888dac@kicinski-fedora-PC1C0HJN> <20200304204506.wli3enu5w25b35h7@ast-mbp> <20200304132439.6abadbe3@kicinski-fedora-PC1C0HJN> <20200305010706.dk7zedpyj5pb5jcv@ast-mbp> <20200305001620.204c292e@cakuba.hsd1.ca.comcast.net> <87tv332hak.fsf@toke.dk> <20200305101342.01427a2a@kicinski-fedora-PC1C0HJN>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Mar 2020 12:41:14 +0100
Message-ID: <87d09l21t1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 05 Mar 2020 12:05:23 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > On Wed, 4 Mar 2020 17:07:08 -0800, Alexei Starovoitov wrote:=20=20
>> >> > Maybe also the thief should not have CAP_ADMIN in the first place?
>> >> > And ask a daemon to perform its actions..=20=20=20=20
>> >>=20
>> >> a daemon idea keeps coming back in circles.
>> >> With FD-based kprobe/uprobe/tracepoint/fexit/fentry that problem is g=
one,
>> >> but xdp, tc, cgroup still don't have the owner concept.
>> >> Some people argued that these three need three separate daemons.
>> >> Especially since cgroups are mainly managed by systemd plus container
>> >> manager it's quite different from networking (xdp, tc) where something
>> >> like 'networkd' might makes sense.
>> >> But if you take this line of thought all the ways systemd should be t=
hat
>> >> single daemon to coordinate attaching to xdp, tc, cgroup because
>> >> in many cases cgroup and tc progs have to coordinate the work.=20=20
>> >
>> > The feature creep could happen, but Toke's proposal has a fairly simple
>> > feature set, which should be easy to cover by a stand alone daemon.
>> >
>> > Toke, I saw that in the library discussion there was no mention of=20
>> > a daemon, what makes a daemon solution unsuitable?=20=20
>>=20
>> Quoting from the last discussion[0]:
>>=20
>> > - Introducing a new, separate code base that we'll have to write, supp=
ort
>> >   and manage updates to.
>> >
>> > - Add a new dependency to using XDP (now you not only need the kernel
>> >   and libraries, you'll also need the daemon).
>> >
>> > - Have to duplicate or wrap functionality currently found in the kerne=
l;
>> >   at least:
>> >=20=20=20
>> >     - Keeping track of which XDP programs are loaded and attached to
>> >       each interface (as well as the "new state" of their attachment
>> >       order).
>> >
>> >     - Some kind of interface with the verifier; if an app does
>> >       xdpd_rpc_load(prog), how is the verifier result going to get back
>> >       to the caller?
>> >
>> > - Have to deal with state synchronisation issues (how does xdpd handle
>> >   kernel state changing from underneath it?).
>> >=20
>> > While these are issues that are (probably) all solvable, I think the
>> > cost of solving them is far higher than putting the support into the
>> > kernel. Which is why I think kernel support is the best solution :)=20=
=20
>>=20
>> The context was slightly different, since this was before we had
>> freplace support in the kernel. But apart from the point about the
>> verifier, I think the arguments still stand. In fact, now that we have
>> that, we don't even need userspace linking, so basically a daemon's only
>> task would be to arbitrate access to the XDP hook? In my book,
>> arbitrating access to resources is what the kernel is all about...
>
> You said that like the library doesn't arbitrate access and manage
> resources.. It does exactly the same work the daemon would do.

Sure, the logic is in the library, but the state (which programs are
loaded) and synchronisation primitives (atomic replace of attached
program) are provided by the kernel.=20

> Daemon just trades off the complexity of making calls for the
> complexity of the system and serializing/de-serializing the state.

What state are we serialising? I'm not sure I would consider just
pinning things in bpffs as "state serialisation"?

-Toke

