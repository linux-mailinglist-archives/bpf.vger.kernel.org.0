Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F321818FD8F
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCWTXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:23:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44180 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727479AbgCWTXw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 15:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584991429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sakKaflsLrDe24XNF6k9Vrs8VA+Mytggp7wb+pRxMUs=;
        b=FuM1ELHXs8O18pohgWH+HROpc1WdMgsJXz7NVkOID8vDG95qTvA7vIJVq2WzXoilHDLTJ/
        7DTSomWaLLUwZN0XMs8hKuwXsqQOmmnS92rNjGUvQt2Y58oGUsyGnUDrDIIccD7P/bO1cY
        ku9BrAb8bWPBx2TlnXOY1ATFFd64CIc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-4lVjpS0fPcW3EGHggBOdAg-1; Mon, 23 Mar 2020 15:23:48 -0400
X-MC-Unique: 4lVjpS0fPcW3EGHggBOdAg-1
Received: by mail-wr1-f71.google.com with SMTP id y1so2860937wrn.10
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 12:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sakKaflsLrDe24XNF6k9Vrs8VA+Mytggp7wb+pRxMUs=;
        b=f9Ci2txzWMi+YND9Zsf3noDhGn9N8ILSnd9sRuDipZkziZXJRDBrA/NYYviDJO9d6L
         CBQx9FZr/sHi7DHDam7dMX9oiWUvZyGynpHogQTwPYtnMv0rlEQDwj61EiTlQEd7W/96
         Dzb8FxnVmB5xXBtTiC2ftgdHuwvP3NU+EiB+VuUMzC1F1NlrhhBZ5WvlivhEDsTx9ZaJ
         WgfDNPz6N7j87MDDQzWFdNs1bqxx2it9geUWNjL9QQr0gPpw9O5HCwSCGwbt9A0iT9eo
         EPuBzgoLt7ZXbYU/j0XZTc75Ej8swblVYMRnlSGmNHnhMOjpOkJyHyhvD+zj0oTJoST5
         F+KQ==
X-Gm-Message-State: ANhLgQ3ExAFE9GPSuS1i5NwccIeKUfZWm3WjVW81VtOk3nYn9NP9n+/4
        k+qmFtE7l5z1wgP8RJaKUA8jKXYY6azzZLlA+z+jKD6WAN7sQP4UwAGAebfPbZKwZR9121sgTqy
        398H1hHLB0Uql
X-Received: by 2002:a5d:4705:: with SMTP id y5mr29656029wrq.288.1584991426875;
        Mon, 23 Mar 2020 12:23:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvvOtJGA5GrgcpIM3SSLXZJui62WMklTk7Rrc/XsL5ITD2a1EbhjCCy8b7bpJskKgJFEaRxYA==
X-Received: by 2002:a5d:4705:: with SMTP id y5mr29656001wrq.288.1584991426605;
        Mon, 23 Mar 2020 12:23:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c7sm13957904wrn.49.2020.03.23.12.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:23:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 56714180371; Mon, 23 Mar 2020 20:23:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
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
In-Reply-To: <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk> <158462359315.164779.13931660750493121404.stgit@toke.dk> <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN> <875zez76ph.fsf@toke.dk> <20200320103530.2853c573@kicinski-fedora-PC1C0HJN> <5e750bd4ebf8d_233f2ab4c81425c4ce@john-XPS-13-9370.notmuch> <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com> <87tv2f48lp.fsf@toke.dk> <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Mar 2020 20:23:44 +0100
Message-ID: <87h7ye3mf3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Mar 23, 2020 at 4:24 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Mar 20, 2020 at 11:31 AM John Fastabend
>> > <john.fastabend@gmail.com> wrote:
>> >>
>> >> Jakub Kicinski wrote:
>> >> > On Fri, 20 Mar 2020 09:48:10 +0100 Toke H=C3=B8iland-J=C3=B8rgensen=
 wrote:
>> >> > > Jakub Kicinski <kuba@kernel.org> writes:
>> >> > > > On Thu, 19 Mar 2020 14:13:13 +0100 Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> > > >> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> > > >>
>> >> > > >> While it is currently possible for userspace to specify that a=
n existing
>> >> > > >> XDP program should not be replaced when attaching to an interf=
ace, there is
>> >> > > >> no mechanism to safely replace a specific XDP program with ano=
ther.
>> >> > > >>
>> >> > > >> This patch adds a new netlink attribute, IFLA_XDP_EXPECTED_FD,=
 which can be
>> >> > > >> set along with IFLA_XDP_FD. If set, the kernel will check that=
 the program
>> >> > > >> currently loaded on the interface matches the expected one, an=
d fail the
>> >> > > >> operation if it does not. This corresponds to a 'cmpxchg' memo=
ry operation.
>> >> > > >>
>> >> > > >> A new companion flag, XDP_FLAGS_EXPECT_FD, is also added to ex=
plicitly
>> >> > > >> request checking of the EXPECTED_FD attribute. This is needed =
for userspace
>> >> > > >> to discover whether the kernel supports the new attribute.
>> >> > > >>
>> >> > > >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.c=
om>
>> >> > > >
>> >> > > > I didn't know we wanted to go ahead with this...
>> >> > >
>> >> > > Well, I'm aware of the bpf_link discussion, obviously. Not sure w=
hat's
>> >> > > happening with that, though. So since this is a straight-forward
>> >> > > extension of the existing API, that doesn't carry a high implemen=
tation
>> >> > > cost, I figured I'd just go ahead with this. Doesn't mean we can'=
t have
>> >> > > something similar in bpf_link as well, of course.
>> >> >
>> >> > I'm not really in the loop, but from what I overheard - I think the
>> >> > bpf_link may be targeting something non-networking first.
>> >>
>> >> My preference is to avoid building two different APIs one for XDP and=
 another
>> >> for everything else. If we have userlands that already understand lin=
ks and
>> >> pinning support is on the way imo lets use these APIs for networking =
as well.
>> >
>> > I agree here. And yes, I've been working on extending bpf_link into
>> > cgroup and then to XDP. We are still discussing some cgroup-specific
>> > details, but the patch is ready. I'm going to post it as an RFC to get
>> > the discussion started, before we do this for XDP.
>>
>> Well, my reason for being skeptic about bpf_link and proposing the
>> netlink-based API is actually exactly this, but in reverse: With
>> bpf_link we will be in the situation that everything related to a netdev
>> is configured over netlink *except* XDP.
>
> One can argue that everything related to use of BPF is going to be
> uniform and done through BPF syscall? Given variety of possible BPF
> hooks/targets, using custom ways to attach for all those many cases is
> really bad as well, so having a unifying concept and single entry to
> do this is good, no?

Well, it depends on how you view the BPF subsystem's relation to the
rest of the kernel, I suppose. I tend to view it as a subsystem that
provides a bunch of functionality, which you can setup (using "internal"
BPF APIs), and then attach that object to a different subsystem
(networking) using that subsystem's configuration APIs.

Seeing as this really boils down to a matter of taste, though, I'm not
sure we'll find agreement on this :)

>> Other than that, I don't see any reason why the bpf_link API won't work.
>> So I guess that if no one else has any problem with BPF insisting on
>> being a special snowflake, I guess I can live with it as well... *shrugs=
* :)
>
> Apart from derogatory remark,

Yeah, should have left out the 'snowflake' bit, sorry about that...

> BPF is a bit special here, because it requires every potential BPF
> hook (be it cgroups, xdp, perf_event, etc) to be aware of BPF
> program(s) and execute them with special macro. So like it or not, it
> is special and each driver supporting BPF needs to implement this BPF
> wiring.

All that is about internal implementation, though. I'm bothered by the
API discrepancy (i.e., from the user PoV we'll end up with: "netlink is
what you use to configure your netdev except if you want to attach an
XDP program to it").

-Toke

