Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803B24101A7
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 01:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbhIQXWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 19:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhIQXWt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 19:22:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE47C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 16:21:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y144so22494363qkb.6
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JzOI+A9QZ9erOfCl3dN24rNc+m8aU46AiHf6A+DSvMw=;
        b=QoWRRDUoyUZf2m+umB8mrq2bx5owc/6MydRj7ARwjtrPCMllHE/raZ8k15k+mcQx7Y
         s5OnV727LtT/3Qqckfl58xYRPV4FVCpeemBgtsN91p/91chUQzlzvFNICUq48wVEp9PH
         L6/weWuYvdNQfQbr0Nin8q0+1x+6tMPU47/VCejDF3pkVpBnxlwIV/NiASkYmIz3YopN
         O1Fx+K+iXji9W5K29PM0UYdcU7NIHIDhSwDsZqyajHxifm2rhQ4xQVguXcRRJjknGE5m
         EgFEkPSuWz9yqs09F5d4OxcazY53sivab2yuiZF1hxcrFT+4VZF7XvCgA3GwdNHOw2Z+
         I2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JzOI+A9QZ9erOfCl3dN24rNc+m8aU46AiHf6A+DSvMw=;
        b=AErPcaFQTOyvDyA7lT0PwxHTqzMrGSi99e5q6LruIiLUa8Mp2XwFkdmilsJBee8PsT
         lviDi69C9PZUBXljuPb+wkYvD1QGaKzOpKHyGnq06ANa4kOzaUDZzjD6jmSMu4MC3NdM
         oE26JwmdT5eDlaOhwAkgoB+pBF3+2YDBKf1n5Vx0ME3nCrjesQqMmXIcYtgTJQtmu4rt
         B5Fw2NeKcU5gODpxY/uRSysGwMU3lDv50PdGP8E+mhJP79KSKNO6LFC6cWMVVA/8FEBQ
         HTPr1xvr/RnAdRZN7YDLq4SALN+XB0ozy5MBZ0BQFrbYyFP1eUy9Sib1UPX1txWDRzG8
         mGeg==
X-Gm-Message-State: AOAM530yIM4mlcsUzCAaORPFG9wGG7h9dqOT+8ylkXg0N2LspWMJo37+
        PVASaWRk8VDr/HuxXTCHO5vsHsUItXik7XTHjII=
X-Google-Smtp-Source: ABdhPJwa6LOHnQlJGJpkpB6C2AxDmRd6kj9jEGTfwfMM7o8WBlGnUENnkEFdq+jTCFg5BqzQ0gA/LgWK3Um1L5Rkyzg=
X-Received: by 2002:a25:840d:: with SMTP id u13mr2829068ybk.455.1631920885920;
 Fri, 17 Sep 2021 16:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061020.821711-1-andrii@kernel.org> <20210917061020.821711-9-andrii@kernel.org>
 <YUTP20fF5wx0LbxQ@google.com> <CAEf4BzYV1YpYojN4STU=wB9G19n_JdXoMsxFeSkM43GeS6ATMg@mail.gmail.com>
 <YUUgj5kR1XA48Z3n@google.com>
In-Reply-To: <YUUgj5kR1XA48Z3n@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 16:21:14 -0700
Message-ID: <CAEf4BzYg3Tdv3KjmwNYu=81ig=KeLOGvqA+zH_nC_VmJ3M6hjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: add opt-in strict BPF program
 section name handling logic
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 4:11 PM <sdf@google.com> wrote:
>
> On 09/17, Andrii Nakryiko wrote:
> > On Fri, Sep 17, 2021 at 10:26 AM <sdf@google.com> wrote:
> > >
> > > On 09/16, Andrii Nakryiko wrote:
> > > > Implement strict ELF section name handling for BPF programs. It
> > utilizes
> > > > `libbpf_set_strict_mode()` framework and adds new flag:
> > > > LIBBPF_STRICT_SEC_NAME.
> > >
> > > > If this flag is set, libbpf will enforce exact section name matchin=
g
> > for
> > > > a lot of program types that previously allowed just partial prefix
> > > > match. E.g., if previously SEC("xdp_whatever_i_want") was allowed, =
now
> > > > in strict mode only SEC("xdp") will be accepted, which makes SEC(""=
)
> > > > definitions cleaner and more structured. SEC() now won't be used as
> > yet
> > > > another way to uniquely encode BPF program identifier (for that
> > > > C function name is better and is guaranteed to be unique within
> > > > bpf_object). Now SEC() is strictly BPF program type and, depending =
on
> > > > program type, extra load/attach parameter specification.
> > >
> > > > Libbpf completely supports multiple BPF programs in the same ELF
> > > > section, so multiple BPF programs of the same type/specification
> > easily
> > > > co-exist together within the same bpf_object scope.
> > >
> > > > Additionally, a new (for now internal) convention is introduced:
> > section
> > > > name that can be a stand-alone exact BPF program type specificator,
> > but
> > > > also could have extra parameters after '/' delimiter. An example of
> > such
> > > > section is "struct_ops", which can be specified by itself, but also
> > > > allows to specify the intended operation to be attached to, e.g.,
> > > > "struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not
> > allowed.
> > > > Such section definition is specified as "struct_ops+".
> > >
> > > > This change is part of libbpf 1.0 effort ([0], [1]).
> > >
> > > >    [0] Closes: https://github.com/libbpf/libbpf/issues/271
> > > >    [1]
> > > >
> > https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter=
-and-more-uniform-bpf-program-section-name-sec-handling
> > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >   tools/lib/bpf/libbpf.c        | 135
> > ++++++++++++++++++++++------------
> > > >   tools/lib/bpf/libbpf_legacy.h |   9 +++
> > > >   2 files changed, 98 insertions(+), 46 deletions(-)
> > >

[...]

> > > > +     /*
> > > > +      * Enforce strict BPF program section (SEC()) names.
> > > > +      * E.g., while prefiously SEC("xdp_whatever") or
> > SEC("perf_event_blah")
> > > > were
> > > > +      * allowed, with LIBBPF_STRICT_SEC_PREFIX this will become
> > > > +      * unrecognized by libbpf and would have to be just SEC("xdp"=
)
> > and
> > > > +      * SEC("xdp") and SEC("perf_event").
> > > > +      */
> > > > +     LIBBPF_STRICT_SEC_NAME =3D 0x04,
> > >
> > > To clarify: I'm assuming, as discussed, we'll still support that old,
> > > non-conforming naming in libbpf 1.0, right? It just won't be enabled
> > > by default.
>
> > No, we won't. All those opt-in strict flags will be turned on
> > permanently in libbpf 1.0. But I'm adding an ability to provide custom
> > callbacks to handle whatever (reasonable) BPF program section names.
> > So if someone has a real important case needing custom handling, it's
> > not a big problem to implement that logic on their own. If someone is
> > just resisting making their code conforming, well... Stay on the old
> > fixed version, write a callback, or just do the mechanical rename, how
> > hard can that be? We are dropping bpf_program__find_program_by_title()
> > in libbpf 1.0, that API is meaningless with multiple programs per
> > section, so you'd have to update your logic to either skeleton or
> > bpf_program__find_program_by_name() anyways.
>
> I see. I was assuming some of them would stay, iirc Toke also was asking
> for this one to stay (or was it the old maps format?). FTR, I'm not
> resisting any changes, I'm willing to invest some time to update our
> callers, just trying to understand what my options are. We do have some
> cases where we depend on the section names, so maybe I should just
> switch from bpf_program__title to bpf_program__name (and do appropriate
> renaming).

Switching to name over title (section name) is a good idea for sure.

>
> RE skeleton: I'm not too eager to adopt it, I'll wait for version 2 :-)

Honest curiosity, what's wrong with the current version of skeleton?
Can you please expand on this?

>
>
> > >
> > > Btw, forgot to update you, I've enabled LIBBPF_STRICT_DIRECT_ERRS and
> > > LIBBPF_STRICT_CLEAN_PTRS and everything seems to be working fine =F0=
=9F=A4=9E
>
> > Great! The problem is that you would see the difference only when
> > actual runtime failure happens. So I'd still recommend auditing the
> > code, if possible.
