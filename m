Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357BE670E64
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 01:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjARAHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjARAGp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 19:06:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062CC79E3
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 15:19:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v10so46113674edi.8
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 15:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMjh6szYGKVjkHMLas73EgVDtP8TFB7x+CARpSf61p0=;
        b=mGlnkq5APITUn1/KL8eE3cSYjqzfCDqNalXN+pfudh+5wddZm1xra7FfEexIDj5s9m
         ocXlUIzycoHl4COIjVZ9GwrpbD6+1lM4461sZWCyGMgOjO0IgH7tiGqulxHVPU5XFi6I
         AomhgmLhs2O1S8gmiPtX0Gz9dUzgVh2BcE6TjXF/nZEgXegsxP4S5YvbZpANSPJT1+c1
         h9WsmSlrL0PC3wczPS9Oa9D7rj1Y5AMHj17BS+TIRwsFHqMYXSdnGS2MWSSRFInQuNxb
         juBSUNstviJ1WvB08O6WR2F652oSTb2fXYfsPjJ2uOcftKsV0f4WG3eeWxBJXBZkIFsr
         KnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMjh6szYGKVjkHMLas73EgVDtP8TFB7x+CARpSf61p0=;
        b=7lp/feJtFhX+KbvVAdLOSw39mEO6QkJHONyADjaVKAgl3n6BJpidDwwYvuIpXsoKj0
         SHNcR9oxkLkQ1SnAeraOc8R+SyFmMRr4ifv1yYwn4UuPG/lxg2cwp/NeOJOEl2Ge1Sh9
         NAuTH+1Ap3gzrvEgK6rofq7jNkoFEFJAzcGAy+iBH2JXzqFVhsytgZF6ZAN+qu2YgDf/
         rRiVEE046ZnxowK+cCBvSFyQ1f6bSoprJxUrnyLoSWHPEO02mo0a7H27d42wDoKrxVEO
         XjpKVxa10UHaijYfkp+Fl5jD1BN3J/PCpL+up4zoGySZ0J6Sn4NNjpPWIKjbW+RQjCme
         4WJQ==
X-Gm-Message-State: AFqh2kp5B/vPS8c98INkow16YlnGRjC5Y1R9Sz7yB19BRp3Acasnofnu
        5keT7JJ6s+27Ewp1Sjp9DF8zyb7TiprCMggyMSI=
X-Google-Smtp-Source: AMrXdXtoIAi4OzZjd0Sbc69WU31vwgNY+Q8Ozn0Ax7e/CSR/87pyBFeqABOsrH7+NYVf1q21yBKjSOy4KJLuhwI6bY0=
X-Received: by 2002:aa7:c7c1:0:b0:486:9f80:8fbc with SMTP id
 o1-20020aa7c7c1000000b004869f808fbcmr636860eds.421.1673997574352; Tue, 17 Jan
 2023 15:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20230117212731.442859-1-toke@redhat.com> <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk> <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
In-Reply-To: <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Jan 2023 15:19:22 -0800
Message-ID: <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable kfuncs"
To:     Stanislav Fomichev <sdf@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 2:20 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Jan 17, 2023 at 2:04 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >
> > Stanislav Fomichev <sdf@google.com> writes:
> >
> > > On Tue, Jan 17, 2023 at 1:27 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> > >>
> > >> Following up on the discussion at the BPF office hours, this patch a=
dds a
> > >> description of the (new) concept of "stable kfuncs", which are kfunc=
s that
> > >> offer a "more stable" interface than what we have now, but is still =
not
> > >> part of UAPI.
> > >>
> > >> This is mostly meant as a straw man proposal to focus discussions ar=
ound
> > >> stability guarantees. From the discussion, it seemed clear that ther=
e were
> > >> at least some people (myself included) who felt that there needs to =
be some
> > >> way to export functionality that we consider "stable" (in the sense =
of
> > >> "applications can rely on its continuing existence").
> > >>
> > >> One option is to keep BPF helpers as the stable interface and implem=
ent
> > >> some technical solution for moving functionality from kfuncs to help=
ers
> > >> once it has stood the test of time and we're comfortable committing =
to it
> > >> as a stable API. Another is to freeze the helper definitions, and in=
stead
> > >> use kfuncs for this purpose as well, by marking a subset of them as
> > >> "stable" in some way. Or we can do both and have multiple levels of
> > >> "stable", I suppose.
> > >>
> > >> This patch is an attempt to describe what the "stable kfuncs" idea m=
ight
> > >> look like, as well as to formulate some criteria for what we mean by
> > >> "stable", and describe an explicit deprecation procedure. Feel free =
to
> > >> critique any part of this (including rejecting the notion entirely).
> > >>
> > >> Some people mentioned (in the office hours) that should we decide to=
 go in
> > >> this direction, there's some work that needs to be done in libbpf (a=
nd
> > >> probably the kernel too?) to bring the kfunc developer experience up=
 to par
> > >> with helpers. Things like exporting kfunc definitions to vmlinux.h (=
to make
> > >> them discoverable), and having CO-RE support for using them, etc. I =
kinda
> > >> consider that orthogonal to what's described here, but I do think we=
 should
> > >> fix those issues before implementing the procedures described here.
> > >>
> > >> v2:
> > >> - Incorporate Daniel's changes
> > >>
> > >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > >> ---
> > >>  Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++=
---
> > >>  1 file changed, 81 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs=
.rst
> > >> index 9fd7fb539f85..dd40a4ee35f2 100644
> > >> --- a/Documentation/bpf/kfuncs.rst
> > >> +++ b/Documentation/bpf/kfuncs.rst
> > >> @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
> > >>
> > >>  BPF Kernel Functions or more commonly known as kfuncs are functions=
 in the Linux
> > >>  kernel which are exposed for use by BPF programs. Unlike normal BPF=
 helpers,
> > >> -kfuncs do not have a stable interface and can change from one kerne=
l release to
> > >> -another. Hence, BPF programs need to be updated in response to chan=
ges in the
> > >> -kernel.
> > >> +kfuncs by default do not have a stable interface and can change fro=
m one kernel
> > >> +release to another. Hence, BPF programs may need to be updated in r=
esponse to
> > >> +changes in the kernel. See :ref:`BPF_kfunc_stability`.
> > >>
> > >>  2. Defining a kfunc
> > >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> @@ -223,14 +223,89 @@ type. An example is shown below::
> > >>          }
> > >>          late_initcall(init_subsystem);
> > >>
> > >> -3. Core kfuncs
> > >> +
> > >> +.. _BPF_kfunc_stability:
> > >> +
> > >> +3. API (in)stability of kfuncs
> > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >> +
> > >> +By default, kfuncs exported to BPF programs are considered a kernel=
-internal
> > >> +interface that can change between kernel versions. This means that =
BPF programs
> > >> +using kfuncs may need to adapt to changes between kernel versions. =
In the
> > >> +extreme case that could also include removal of a kfunc. In other w=
ords, kfuncs
> > >> +are _not_ part of the kernel UAPI! Rather, these kfuncs can be thou=
ght of as
> > >> +being similar to internal kernel API functions exported using the
> > >
> > > [..]
> > >
> > >> +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functio=
nality must
> > >> +initially start out as kfuncs.
> > >
> > > To clarify, as part of this proposal, are we making a decision here
> > > that we ban new helpers going forward?
> >
> > Good question! That is one of the things I'm hoping we can clear up by
> > this discussing. I don't have a strong opinion on the matter myself, as
> > long as there is *some* way to mark a subset of helpers/kfuncs as
> > "stable"...
>
> Might be worth it to capitalize in this case to indicate that it's a
> MUST from the RFC world? (or go with SHOULD otherwise).
> I'm fine either way. The only thing that stops me from fully embracing
> MUST is the kfunc requirement on the explicit jit support; I'm not
> sure why it exists and at this point I'm too afraid to ask. But having
> MUST here might give us motivation to address the shortcomings...

Did you do:
git grep bpf_jit_supports_kfunc_call
and didn't find your favorite architecture there and
didn't find it in the upcoming patches for riscv and arm32?
If you care about kfuncs on arm32 please help reviewing posted patches.
