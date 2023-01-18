Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E1671077
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 03:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjARCBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 21:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjARCBN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 21:01:13 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293951C7E
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 18:01:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 141so23465613pgc.0
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 18:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN1pmkFndHRvBHAdR9bHVXU9SN70a0douKZd4N9rhQs=;
        b=FwNwiXTlLoWeutbCdFiHr3Y2KPORms7l0Q5Tp+hH2uh5ASxwg9baWkbKmzyfQz7tLn
         JHHSI6hFzx7rfl5OFF8/aRazWboRGIEi0flcqSV91exyfQjmrsfm3lzF+G1hk4T82XI6
         YqTgLPSQfl+ZBxRbaxcs9BjFZBco/ECHvNWt7gxhSRD0TAjp6YKkpgtDygJ/pnFxedgC
         XpFhys628tgj6NUJDX9aO3NKYkkUO7JBx0YC0XsByHM1cXrfFOJLL/9Mik4LlC9XcSG8
         cd7RGoAaHnhb7EWqWILm6bs9QYNMbw3b/w4A75Nu1/l+bt5wyGhkfveemKhv4XG45Q9P
         uTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN1pmkFndHRvBHAdR9bHVXU9SN70a0douKZd4N9rhQs=;
        b=zv349FWEdRJogvtYwCV8fscJ8Qesctp1A2sEjzkzUOCPfUnA3qEg5MtRnKw8EktL5l
         5bYNs5uON+0rMU1U4HyB8VfqCtNPOfC3knxdoBmRmqjc6Z0u7355Axu2PeeapCrJDFp4
         s3Sr0IRMqeTp3v3gDxb+Y44e1dMKp0qBI54PoKtT99yAoR+MAYJkskQE7MyY4P4XcAn3
         Rf6a9UqM5KZvYbAm2DlB0v4Hy5kO4rNtf12+3nR11TSUo6iWrQBGhBuhi2a4BtqD2gmR
         3iYSmDnBuT0IhfzCkTH70BV2igk0Lss/4lCIOrgdcQefytdciR7a9SL3RVW1s6O2028r
         SBHQ==
X-Gm-Message-State: AFqh2kpzamETXVde95lJcQD99YFdjq1shbICjvPnseO0X1kRT4bXrj6c
        WHqMk9lLjMGKKJWrDQe9u54RF7aJF1+T9MoEMD3kHpne/fzy8g==
X-Google-Smtp-Source: AMrXdXtuMS+fu/yyqBM2OpDGq51WWXQrSvPz4kYK73pG9YS7tub5VgcJX7G2aA3pYCEeh90AyITfPyWxlqSHTJjpbfo=
X-Received: by 2002:a63:4047:0:b0:474:6739:6a09 with SMTP id
 n68-20020a634047000000b0047467396a09mr392834pga.292.1674007271674; Tue, 17
 Jan 2023 18:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20230117212731.442859-1-toke@redhat.com> <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk> <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
In-Reply-To: <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 17 Jan 2023 18:00:58 -0800
Message-ID: <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable kfuncs"
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 3:19 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 17, 2023 at 2:20 PM Stanislav Fomichev <sdf@google.com> wrote=
:
> >
> > On Tue, Jan 17, 2023 at 2:04 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> > >
> > > Stanislav Fomichev <sdf@google.com> writes:
> > >
> > > > On Tue, Jan 17, 2023 at 1:27 PM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
> > > >>
> > > >> Following up on the discussion at the BPF office hours, this patch=
 adds a
> > > >> description of the (new) concept of "stable kfuncs", which are kfu=
ncs that
> > > >> offer a "more stable" interface than what we have now, but is stil=
l not
> > > >> part of UAPI.
> > > >>
> > > >> This is mostly meant as a straw man proposal to focus discussions =
around
> > > >> stability guarantees. From the discussion, it seemed clear that th=
ere were
> > > >> at least some people (myself included) who felt that there needs t=
o be some
> > > >> way to export functionality that we consider "stable" (in the sens=
e of
> > > >> "applications can rely on its continuing existence").
> > > >>
> > > >> One option is to keep BPF helpers as the stable interface and impl=
ement
> > > >> some technical solution for moving functionality from kfuncs to he=
lpers
> > > >> once it has stood the test of time and we're comfortable committin=
g to it
> > > >> as a stable API. Another is to freeze the helper definitions, and =
instead
> > > >> use kfuncs for this purpose as well, by marking a subset of them a=
s
> > > >> "stable" in some way. Or we can do both and have multiple levels o=
f
> > > >> "stable", I suppose.
> > > >>
> > > >> This patch is an attempt to describe what the "stable kfuncs" idea=
 might
> > > >> look like, as well as to formulate some criteria for what we mean =
by
> > > >> "stable", and describe an explicit deprecation procedure. Feel fre=
e to
> > > >> critique any part of this (including rejecting the notion entirely=
).
> > > >>
> > > >> Some people mentioned (in the office hours) that should we decide =
to go in
> > > >> this direction, there's some work that needs to be done in libbpf =
(and
> > > >> probably the kernel too?) to bring the kfunc developer experience =
up to par
> > > >> with helpers. Things like exporting kfunc definitions to vmlinux.h=
 (to make
> > > >> them discoverable), and having CO-RE support for using them, etc. =
I kinda
> > > >> consider that orthogonal to what's described here, but I do think =
we should
> > > >> fix those issues before implementing the procedures described here=
.
> > > >>
> > > >> v2:
> > > >> - Incorporate Daniel's changes
> > > >>
> > > >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > >> ---
> > > >>  Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++=
++---
> > > >>  1 file changed, 81 insertions(+), 6 deletions(-)
> > > >>
> > > >> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfun=
cs.rst
> > > >> index 9fd7fb539f85..dd40a4ee35f2 100644
> > > >> --- a/Documentation/bpf/kfuncs.rst
> > > >> +++ b/Documentation/bpf/kfuncs.rst
> > > >> @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
> > > >>
> > > >>  BPF Kernel Functions or more commonly known as kfuncs are functio=
ns in the Linux
> > > >>  kernel which are exposed for use by BPF programs. Unlike normal B=
PF helpers,
> > > >> -kfuncs do not have a stable interface and can change from one ker=
nel release to
> > > >> -another. Hence, BPF programs need to be updated in response to ch=
anges in the
> > > >> -kernel.
> > > >> +kfuncs by default do not have a stable interface and can change f=
rom one kernel
> > > >> +release to another. Hence, BPF programs may need to be updated in=
 response to
> > > >> +changes in the kernel. See :ref:`BPF_kfunc_stability`.
> > > >>
> > > >>  2. Defining a kfunc
> > > >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >> @@ -223,14 +223,89 @@ type. An example is shown below::
> > > >>          }
> > > >>          late_initcall(init_subsystem);
> > > >>
> > > >> -3. Core kfuncs
> > > >> +
> > > >> +.. _BPF_kfunc_stability:
> > > >> +
> > > >> +3. API (in)stability of kfuncs
> > > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >> +
> > > >> +By default, kfuncs exported to BPF programs are considered a kern=
el-internal
> > > >> +interface that can change between kernel versions. This means tha=
t BPF programs
> > > >> +using kfuncs may need to adapt to changes between kernel versions=
. In the
> > > >> +extreme case that could also include removal of a kfunc. In other=
 words, kfuncs
> > > >> +are _not_ part of the kernel UAPI! Rather, these kfuncs can be th=
ought of as
> > > >> +being similar to internal kernel API functions exported using the
> > > >
> > > > [..]
> > > >
> > > >> +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like funct=
ionality must
> > > >> +initially start out as kfuncs.
> > > >
> > > > To clarify, as part of this proposal, are we making a decision here
> > > > that we ban new helpers going forward?
> > >
> > > Good question! That is one of the things I'm hoping we can clear up b=
y
> > > this discussing. I don't have a strong opinion on the matter myself, =
as
> > > long as there is *some* way to mark a subset of helpers/kfuncs as
> > > "stable"...
> >
> > Might be worth it to capitalize in this case to indicate that it's a
> > MUST from the RFC world? (or go with SHOULD otherwise).
> > I'm fine either way. The only thing that stops me from fully embracing
> > MUST is the kfunc requirement on the explicit jit support; I'm not
> > sure why it exists and at this point I'm too afraid to ask. But having
> > MUST here might give us motivation to address the shortcomings...
>
> Did you do:
> git grep bpf_jit_supports_kfunc_call
> and didn't find your favorite architecture there and
> didn't find it in the upcoming patches for riscv and arm32?
> If you care about kfuncs on arm32 please help reviewing posted patches.

Exactly why I'm going to support whatever decision is being made here.
Just trying to clarify what that decision is.
