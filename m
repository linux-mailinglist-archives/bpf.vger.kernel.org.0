Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1911B190B9C
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 11:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCXK5w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 06:57:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22599 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbgCXK5v (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Mar 2020 06:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585047470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LC9l7Li+aAiPkflXrEAqsPo4FFm0kCWfpVlh5oPxAo0=;
        b=GkHkATFGk5tb6lUAn+DpcnQHxmugOSfHH0K31TK/lnLT+eNoYwGX2o/A+FDQ9fiJqTKW01
        9iTAPmiMCDlUkfgrt5iBTRNegOGdXMOtGQ+l0xOiLkFb/4jIKBxjUWwOXInFXkJtDkkHq5
        /4DGwgLehEj3RhZN26nL+MgdjBgu4z4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-lzRBxjhTMLq4QNEOXj6Img-1; Tue, 24 Mar 2020 06:57:49 -0400
X-MC-Unique: lzRBxjhTMLq4QNEOXj6Img-1
Received: by mail-wm1-f70.google.com with SMTP id m4so1156390wme.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 03:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LC9l7Li+aAiPkflXrEAqsPo4FFm0kCWfpVlh5oPxAo0=;
        b=fgx5dTSxnbaM/HtapdSKbtn3n5VtbNVKhApzENh8h4u2ZHonnIv7HDP2VCgKA+BLtn
         GycvRbitOWtXrUygQJHYtjsbDda++O6X081Pn3b3oITsgZQkIjhoSoSApTrM3Yy/Y8iv
         jgSRhSIcIsWpgcLjxpuePE4rWFkXM6+CqXnSZThH470AVwSFyTXfXR6qnPvKJIOMUU6T
         /KOioX3uiBPohxv5wSkS4UyX/PMrmymgQ3Q84KQosqflhmd3c3iykoLFO+5BfFUr6KbI
         4KOukJt3eUv9AqnJGnyHWmgndTbB24T8S7Uk7eEDDSsJvOLxvqf3LY3NuLE9lT+RY3mT
         MHKw==
X-Gm-Message-State: ANhLgQ35O16MKKAm3PSybjFU1CWNAIxYwijyN5OoEjvwCIjVN2IoUjBQ
        xidfus6Bk+yOtlA11wq4dV2oOCXtOnKXnHkjed5zgLIpjV2riOXhoj7m1+r7HfX2Pb2wUyswNXS
        rfPAEjcMdmwTT
X-Received: by 2002:adf:efc2:: with SMTP id i2mr34116635wrp.420.1585047467876;
        Tue, 24 Mar 2020 03:57:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vttxUinZJhM+f7WrjTI7ebaW4vekUwZBwow5I1/zq6DtF1DLtWvC1oTo3JMfal4CeDaJ0f4bQ==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr34116597wrp.420.1585047467579;
        Tue, 24 Mar 2020 03:57:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d5sm18994540wrh.40.2020.03.24.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:57:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ACD89180371; Tue, 24 Mar 2020 11:57:45 +0100 (CET)
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
In-Reply-To: <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk> <158462359315.164779.13931660750493121404.stgit@toke.dk> <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN> <875zez76ph.fsf@toke.dk> <20200320103530.2853c573@kicinski-fedora-PC1C0HJN> <5e750bd4ebf8d_233f2ab4c81425c4ce@john-XPS-13-9370.notmuch> <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com> <87tv2f48lp.fsf@toke.dk> <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com> <87h7ye3mf3.fsf@toke.dk> <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 24 Mar 2020 11:57:45 +0100
Message-ID: <87tv2e10ly.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Mar 23, 2020 at 12:23 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Mon, Mar 23, 2020 at 4:24 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > On Fri, Mar 20, 2020 at 11:31 AM John Fastabend
>> >> > <john.fastabend@gmail.com> wrote:
>> >> >>
>> >> >> Jakub Kicinski wrote:
>> >> >> > On Fri, 20 Mar 2020 09:48:10 +0100 Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>> >> >> > > Jakub Kicinski <kuba@kernel.org> writes:
>> >> >> > > > On Thu, 19 Mar 2020 14:13:13 +0100 Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>> >> >> > > >> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> >> > > >>
>> >> >> > > >> While it is currently possible for userspace to specify tha=
t an existing
>> >> >> > > >> XDP program should not be replaced when attaching to an int=
erface, there is
>> >> >> > > >> no mechanism to safely replace a specific XDP program with =
another.
>> >> >> > > >>
>> >> >> > > >> This patch adds a new netlink attribute, IFLA_XDP_EXPECTED_=
FD, which can be
>> >> >> > > >> set along with IFLA_XDP_FD. If set, the kernel will check t=
hat the program
>> >> >> > > >> currently loaded on the interface matches the expected one,=
 and fail the
>> >> >> > > >> operation if it does not. This corresponds to a 'cmpxchg' m=
emory operation.
>> >> >> > > >>
>> >> >> > > >> A new companion flag, XDP_FLAGS_EXPECT_FD, is also added to=
 explicitly
>> >> >> > > >> request checking of the EXPECTED_FD attribute. This is need=
ed for userspace
>> >> >> > > >> to discover whether the kernel supports the new attribute.
>> >> >> > > >>
>> >> >> > > >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com>
>> >> >> > > >
>> >> >> > > > I didn't know we wanted to go ahead with this...
>> >> >> > >
>> >> >> > > Well, I'm aware of the bpf_link discussion, obviously. Not sur=
e what's
>> >> >> > > happening with that, though. So since this is a straight-forwa=
rd
>> >> >> > > extension of the existing API, that doesn't carry a high imple=
mentation
>> >> >> > > cost, I figured I'd just go ahead with this. Doesn't mean we c=
an't have
>> >> >> > > something similar in bpf_link as well, of course.
>> >> >> >
>> >> >> > I'm not really in the loop, but from what I overheard - I think =
the
>> >> >> > bpf_link may be targeting something non-networking first.
>> >> >>
>> >> >> My preference is to avoid building two different APIs one for XDP =
and another
>> >> >> for everything else. If we have userlands that already understand =
links and
>> >> >> pinning support is on the way imo lets use these APIs for networki=
ng as well.
>> >> >
>> >> > I agree here. And yes, I've been working on extending bpf_link into
>> >> > cgroup and then to XDP. We are still discussing some cgroup-specific
>> >> > details, but the patch is ready. I'm going to post it as an RFC to =
get
>> >> > the discussion started, before we do this for XDP.
>> >>
>> >> Well, my reason for being skeptic about bpf_link and proposing the
>> >> netlink-based API is actually exactly this, but in reverse: With
>> >> bpf_link we will be in the situation that everything related to a net=
dev
>> >> is configured over netlink *except* XDP.
>> >
>> > One can argue that everything related to use of BPF is going to be
>> > uniform and done through BPF syscall? Given variety of possible BPF
>> > hooks/targets, using custom ways to attach for all those many cases is
>> > really bad as well, so having a unifying concept and single entry to
>> > do this is good, no?
>>
>> Well, it depends on how you view the BPF subsystem's relation to the
>> rest of the kernel, I suppose. I tend to view it as a subsystem that
>> provides a bunch of functionality, which you can setup (using "internal"
>> BPF APIs), and then attach that object to a different subsystem
>> (networking) using that subsystem's configuration APIs.
>>
>> Seeing as this really boils down to a matter of taste, though, I'm not
>> sure we'll find agreement on this :)
>
> Yeah, seems like so. But then again, your view and reality don't seem
> to correlate completely. cgroup, a lot of tracing,
> flow_dissector/lirc_mode2 attachments all are done through BPF
> syscall.

Well, I wasn't talking about any of those subsystems, I was talking
about networking :)

In particular, networking already has a consistent and fairly
well-designed configuration mechanism (i.e., netlink) that we are
generally trying to move more functionality *towards* not *away from*
(see, e.g., converting ethtool to use netlink).

> LINK_CREATE provides an opportunity to finally unify all those
> different ways to achieve the same "attach my BPF program to some
> target object" semantics.

Well I also happen to think that "attach a BPF program to an object" is
the wrong way to think about XDP. Rather, in my mind the model is
"instruct the netdevice to execute this piece of BPF code".

>> >> Other than that, I don't see any reason why the bpf_link API won't wo=
rk.
>> >> So I guess that if no one else has any problem with BPF insisting on
>> >> being a special snowflake, I guess I can live with it as well... *shr=
ugs* :)
>> >
>> > Apart from derogatory remark,
>>
>> Yeah, should have left out the 'snowflake' bit, sorry about that...
>>
>> > BPF is a bit special here, because it requires every potential BPF
>> > hook (be it cgroups, xdp, perf_event, etc) to be aware of BPF
>> > program(s) and execute them with special macro. So like it or not, it
>> > is special and each driver supporting BPF needs to implement this BPF
>> > wiring.
>>
>> All that is about internal implementation, though. I'm bothered by the
>> API discrepancy (i.e., from the user PoV we'll end up with: "netlink is
>> what you use to configure your netdev except if you want to attach an
>> XDP program to it").
>>
>
> See my reply to David. Depends on where you define user API. Is it
> libbpf API, which is what most users are using? Or kernel API?

Well I'm talking about the kernel<->userspace API, obviously :)

> If everyone is using libbpf, does kernel system (bpf syscall vs
> netlink) matter all that much?

This argument works the other way as well, though: If libbpf can
abstract the subsystem differences and provide a consistent interface to
"the BPF world", why does BPF need to impose its own syscall API on the
networking subsystem?

-Toke

