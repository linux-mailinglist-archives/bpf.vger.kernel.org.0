Return-Path: <bpf+bounces-21456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBF884D6EB
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EC4286DED
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2F84C70;
	Thu,  8 Feb 2024 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdSD1hcT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B34C84
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350744; cv=none; b=RFj4mPKyTGI/gBvFp9o6Gv2RWSMW5TztlLv3Lxe5ZlJCyzeBvDAfqCd5iPBmqmQ9uD490BurQS8RKB5EliwDbCLj+7uHdgt+wjskZLCi8QbZ+bg0lYrj+81rtG1AYWpJDT1t41ohQNJmiaZtNhAnOLzUR+hXghzrrosBTl/yWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350744; c=relaxed/simple;
	bh=bCjSUTyzpUffdghTWzZHBcjxQ5Ahgbh1u/z/cTHWEhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkFAPYBx7ps+YdppKsYJMpMXUH4g4xeMVjRksD9taQFc2dx0VbDOGuc04x6vsj69oXyrUgXlIs3rbZ7u1Mulbk7fz3LaJrjq/y+4YNeyR+2l4GZQSQFbLGJwy+3FpMRhY//d0SzieA5ZjQjQGadMeJs8yMEOkDPjDbUSoME3V5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdSD1hcT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e071953676so459343b3a.2
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 16:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707350742; x=1707955542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3ZDjwUN4SXd2KtKNqH0q3JMlANpgNCwNNJwkXTLV9M=;
        b=AdSD1hcTBFkpXmNi2V2vKehEp+MR1kn2qKqDrXsOCebBA2qMdumKyOi61sNCkntHst
         Es2oXVbKgTcs/yNDXz9T8rQJKLYB2TtI5s7DOjH7sgap3OTO/hFJH4FxPc9cvpvZ5MhN
         rsndEXCESH+DccfPAB2qkUD77o79PAgnAnVi6W0IC2bSaNTG0wAcpri8d9nUuy1L5y3L
         efDTw58BCVJk4tQR5/R7wICf30NL3bEuikkFsMj7EpRBVbpSMyse+93Kotb36Hne56sD
         y2bRgNqVvYle48Krat9Qnt43AdxEyhS+lhg6nofjr+Wv/jcMdwj5IWPt4dbG1dVMbRcu
         lp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707350742; x=1707955542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3ZDjwUN4SXd2KtKNqH0q3JMlANpgNCwNNJwkXTLV9M=;
        b=u619agLmhnQJ9j99cKnriBh9X+XNvpIvSbtuN75AgDxp7N9Dkd+bQfDNyhaw58NNVp
         8mMP9BSDce0yUwBsVs81PmiUeroVHPDM7jCoCzPK6W87xzVBaGsNCNuvsIwygapkcmXg
         n0N4eHOL89E5+ObHJitXU4g2HH2OtTSB7gTPuutCik2hDFjV43TuFzEmaXPOCojCssOC
         OBj3LnPtEb6FjerU0KO1/TY7m1R8J3njz4zdZ2y06IMU+8FoY+evwY24PdPsLch/Jb43
         S6WRaMxOD7DX3DionrhsrRTNAGY/B7IeK56bJViTny+xIMM9jMlgJdUvnG0jd2RcfCLS
         jWRg==
X-Gm-Message-State: AOJu0Yz5/FXn1lL5ptYa+NlHkGRHuGojFrVeSvuTxJkaIP/lE6mEsRp9
	v1Xuw2SpjtC+csSiH1K4sqdVzPWUWcPskIwiZ1cysPG5IIRo+ov/Pv6k56g/JvpnUZJjab93DTI
	x4u1SqlA+VNrPu6DZJM2pmAq9xZI=
X-Google-Smtp-Source: AGHT+IGWJqoerE+Cl6bEhvVKv1sk0xVvpxNn1El5Uo0ZdcUzcpqOUhFunUkDwz60DStYQbAkF0K1hkxvjavQyCxl5BI=
X-Received: by 2002:a05:6a00:1788:b0:6e0:503f:f506 with SMTP id
 s8-20020a056a00178800b006e0503ff506mr5604022pfg.7.1707350741895; Wed, 07 Feb
 2024 16:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131162003.962665-1-alan.maguire@oracle.com>
 <CAEf4BzbeBiNj2GHJkDBAWASwLMy6nDNMbmqtQGOABZsRGAEytQ@mail.gmail.com> <bd4d548a-0f41-4086-bb34-ac2a7384157a@oracle.com>
In-Reply-To: <bd4d548a-0f41-4086-bb34-ac2a7384157a@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 16:05:30 -0800
Message-ID: <CAEf4BzZkrZ1toBE11-utYZEk6fajF7ewtWNsr8bXC8YwFub8cg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing (URDT)
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:49=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 02/02/2024 21:39, Andrii Nakryiko wrote:
> > On Wed, Jan 31, 2024 at 8:20=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Adding userspace tracepoints in other languages like python and
> >> go is a very useful for observability.  libstapsdt [1]
> >> and language bindings like python-stapsdt [2] that rely on it
> >> use a clever scheme of emulating static (USDT) userspace tracepoints
> >> at runtime.  This involves (as I understand it):
> >>
> >> - fabricating a shared library
> >> - annotating it with ELF notes that describe its tracepoints
> >> - dlopen()ing it and calling the appropriate probe fire function
> >>   to trigger probe firing.
> >>
> >> bcc already supports this mechanism (the examples in [2] use
> >> bcc to list/trigger the tracepoints), so it seems like it
> >> would be a good candidate for adding support to libbpf.
> >>
> >> However, before doing that, it's worth considering if there
> >> are simpler ways to support runtime probe firing.  This
> >> small series demonstrates a simple method based on USDT
> >> probes added to libbpf itself.
> >>
> >> The suggested solution comprises 3 parts
> >>
> >> 1. functions to fire dynamic probes are added to libbpf itself
> >>    bpf_urdt__probeN(), where N is the number of probe arguemnts.
> >>    A sample usage would be
> >>         bpf_urdt__probe3("myprovider", "myprobe", 1, 2, 3);
> >>
> >>    Under the hood these correspond to USDT probes with an
> >>    additional argument for uniquely identifying the probe
> >>    (a hash of provider/probe name).
> >>
> >> 2. we attach to the appropriate USDT probe for the specified
> >>    number of arguments urdt/probe0 for none, urdt/probe1 for
> >>    1, etc.  We utilize the high-order 32 bits of the attach
> >>    cookie to store the hash of the provider/probe name.
> >>
> >> 3. when urdt/probeN fires, the BPF_URDT() macro (which
> >>    is similar to BPF_USDT()) checks if the hash passed
> >>    in (identifying provider/probe) matches the attach
> >>    cookie high-order 32 bits; if not it must be a firing
> >>    for a different dynamic probe and we exit early.
> >
> > I'm sorry Alan, but I don't see this being added to libbpf. This is
> > nothing else than USDT with a bunch of extra conventions bolted on.
> > And those conventions might not work for many environments. It is
> > completely arbitrary that libbpf is a) assumed to be a dynamic library
> > and b) provides USDT hooks that will be triggered. Just because it
> > will be libbpf that will be used to trace those USDT hooks doesn't
> > mean that libbpf has to define those hooks.
>
> Right - that came up with the discussion with Daniel also. Adding
> probes in libbpf was just a means of providing a method of last resort
> for runtime probe firing, it's not strictly necessary.
>

Ok, glad we agree on not putting this into libbpf.

> > Just because libbpf can
> > trace USDTs it doesn't mean that libbpf should provide those
> > STAP_PROBEx() macros to define and trigger USDTs within some
> > application. Applications that define USDTs and applications that
> > attach to those USDTs are completely separate and independent. Same
> > here, there might be an overlap in some cases, but conceptually it's
> > two separate sides of the solution.
> >
>
> I think the point is though that USDT got its start by establishing a
> shared set of conventions between the to-be-traced side and the tracer,
> and built upon existing uprobe support to make that work. Is there a
> similar approach that we could apply for dynamic probes? libbpf isn't
> necessarily the right vehicle for establishing those conventions and I'm
> far from wedded to the specifics of this approach, but I do think it's a
> question we should explore a bit.

I'm a bit skeptical about "standardizing" this approach so early.
Let's see how and whether this gets used in practice widely enough,
before adding SEC("urdt") as a standard feature into libbpf.


>
> > Overall, this is definitely a useful overall approach, to have a
> > single system-wide .so library that can be attached to trace some
> > USDTs, and we've explored this approach internally at Meta as well.
> > But I don't believe it should be part of libbpf. From libbpf's
> > standpoint it's just a standard USDT probe to attach to.
> >
> >
>
> For now we can pursue the approach of adding a static probe - triggered
> when a dynamic probe firing is requested - to libstapsdt, and this would
> give us libbpf support via USDT tracing of libstapsdt.

Exactly. And I suspect big companies like Meta, Google and whatnot
might have their own small system-wide shared library, developed and
maintained internally, deployed using whatever deployment strategy
they see fit, with their own USDT name and convention about naming and
namespacing these dynamic USDTs, etc, etc.

As I said, the idea is sound and neat, I'm just not sure that assuming
libstapsdt (or whatever other predefined library) is going to work in
practice.

If anything, maybe making the kernel provide something like this as a
standard functionality is the right way to go. Something along the
VDSO lines, which doesn't trigger a context switch, but can be
centralized through the kernel? Have you considered such options?

>
> >>
> >> Auto-attach support is also added, for example the following
> >> would add a dynamic probe for provider:myprobe:
> >>
> >> SEC("udrt/libbpf.so:2:myprovider:myprobe")
> >> int BPF_URDT(myprobe, int arg1, char *arg2)
> >> {
> >>  ...
> >> }
> >>
> >> (Note the "2" above specifies the number of arguments to
> >> the probe, otherwise it is identical to USDT).
> >>
> >> The above program can then be triggered by a call to
> >>
> >>  BPF_URDT_PROBE2("myprovider", "myprobe", 1, "hi");
> >>
> >> The useful thing about this is that by attaching to
> >> libbpf.so (and firing probes using that library) we
> >> can get system-wide dynamic probe firing.  It is also
> >> easy to fire a dynamic probe - no setup is required.
> >>
> >> More examples of auto and manual attach can be found in
> >> the selftests (patch 2).
> >>
> >> If this approach appears to be worth pursing, we could
> >> also look at adding support to libstapsdt for it.
> >>
> >> Alan Maguire (2):
> >>   libbpf: add support for Userspace Runtime Dynamic Tracing (URDT)
> >>   selftests/bpf: add tests for Userspace Runtime Defined Tracepoints
> >>     (URDT)
> >>
> >>  tools/lib/bpf/Build                           |   2 +-
> >>  tools/lib/bpf/Makefile                        |   2 +-
> >>  tools/lib/bpf/libbpf.c                        |  94 ++++++++++
> >>  tools/lib/bpf/libbpf.h                        |  94 ++++++++++
> >>  tools/lib/bpf/libbpf.map                      |  13 ++
> >>  tools/lib/bpf/libbpf_internal.h               |   2 +
> >>  tools/lib/bpf/urdt.bpf.h                      | 103 +++++++++++
> >>  tools/lib/bpf/urdt.c                          | 145 +++++++++++++++
> >>  tools/testing/selftests/bpf/Makefile          |   2 +-
> >>  tools/testing/selftests/bpf/prog_tests/urdt.c | 173 +++++++++++++++++=
+
> >>  tools/testing/selftests/bpf/progs/test_urdt.c | 100 ++++++++++
> >>  .../selftests/bpf/progs/test_urdt_shared.c    |  59 ++++++
> >>  12 files changed, 786 insertions(+), 3 deletions(-)
> >>  create mode 100644 tools/lib/bpf/urdt.bpf.h
> >>  create mode 100644 tools/lib/bpf/urdt.c
> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/urdt.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt_shared=
.c
> >>
> >> --
> >> 2.39.3
> >>
> >

