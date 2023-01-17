Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE0670BBD
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 23:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAQWj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 17:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjAQWj2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 17:39:28 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49FA4E510
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:20:12 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i1so9666917pfk.3
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cvdHVdjxFASCnqUwFHUSI/UN6ZbudTaNhaBV/yxt1U=;
        b=lJxua6b8suVcVG9yjfITyLUY8rmZtvVUiYpr4dducRt583YJPOqb09tUaw+9gwWC62
         Y/phncOpAsi/CF+C95oJaS6ORw5fTu+IwmOJBXFW/M1rfqcJynakm/oRrSkYpu8toxNw
         DoNJ6DIZT+sGE/JYLFyIBDOqgASJheX60Ne3UHKa88SdN32HQctDLi4QCOaScODf1ve0
         aAEbpTF6gvLEH3yrdGTYpQl2Dy9dT9o1yZvrajmwrPd+EQmqO7A9ZwnTosLahQDcuYO4
         F9i0sYxI5FyGG/IkHLYpF6tefJvAtvi0DD28dH5T2z78WKX0wD6ubnWp9KzgqTyqHoBc
         CjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cvdHVdjxFASCnqUwFHUSI/UN6ZbudTaNhaBV/yxt1U=;
        b=LHbVQ0LEEQDBT92sS0dNR7FFinuEYgyDIsICmsMRpo561Fv1XZFa9rZjHx1KwoXu2t
         +1FWwQaStlhqzy5WGzR0nT9eZGl5vw34xhQPecpaEl/rpu/yDGnuyeIBgiRuweLwCchg
         hHWrYmwXBjf81S87uR+iLkLT8I3ik11uMzCm5F86/xeu3W8H08s9GAB7i7vhKMxnzZ6J
         PjhxWlEMk1zGEJY8MPC24KRqGNh/3wiiGS/UvdeMnjky5DkaZgtJAw/aq7RBD47GPUsE
         NRCMprFxStJxCAaW3DLufr5M+dicURlVkEX4H+E09vdM6U1LQyW/s4bnLTEk8dbJxt6x
         8n/A==
X-Gm-Message-State: AFqh2kq4hOuJ1mBrDVtqUB5Bw2YhdQjOkhG1ijiblHwBWQQ/e5Qf8Gi5
        XoDYVWEobPe+blsIZrq5ez1HG8uSYIcT8ZmcraWxxQ==
X-Google-Smtp-Source: AMrXdXuDkOQ1xnnuBk8M5HKcopUMlXt+uds6KzUhdCbI2D8Kj2QWbVMYK2HKnZdMb7TjyUEES7hyROCIzQZzZuBBP5Y=
X-Received: by 2002:a62:4e8e:0:b0:586:4e66:eadd with SMTP id
 c136-20020a624e8e000000b005864e66eaddmr448422pfb.71.1673994011821; Tue, 17
 Jan 2023 14:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20230117212731.442859-1-toke@redhat.com> <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk>
In-Reply-To: <87v8l4byyb.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 17 Jan 2023 14:20:00 -0800
Message-ID: <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable kfuncs"
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
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

On Tue, Jan 17, 2023 at 2:04 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > On Tue, Jan 17, 2023 at 1:27 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> >>
> >> Following up on the discussion at the BPF office hours, this patch add=
s a
> >> description of the (new) concept of "stable kfuncs", which are kfuncs =
that
> >> offer a "more stable" interface than what we have now, but is still no=
t
> >> part of UAPI.
> >>
> >> This is mostly meant as a straw man proposal to focus discussions arou=
nd
> >> stability guarantees. From the discussion, it seemed clear that there =
were
> >> at least some people (myself included) who felt that there needs to be=
 some
> >> way to export functionality that we consider "stable" (in the sense of
> >> "applications can rely on its continuing existence").
> >>
> >> One option is to keep BPF helpers as the stable interface and implemen=
t
> >> some technical solution for moving functionality from kfuncs to helper=
s
> >> once it has stood the test of time and we're comfortable committing to=
 it
> >> as a stable API. Another is to freeze the helper definitions, and inst=
ead
> >> use kfuncs for this purpose as well, by marking a subset of them as
> >> "stable" in some way. Or we can do both and have multiple levels of
> >> "stable", I suppose.
> >>
> >> This patch is an attempt to describe what the "stable kfuncs" idea mig=
ht
> >> look like, as well as to formulate some criteria for what we mean by
> >> "stable", and describe an explicit deprecation procedure. Feel free to
> >> critique any part of this (including rejecting the notion entirely).
> >>
> >> Some people mentioned (in the office hours) that should we decide to g=
o in
> >> this direction, there's some work that needs to be done in libbpf (and
> >> probably the kernel too?) to bring the kfunc developer experience up t=
o par
> >> with helpers. Things like exporting kfunc definitions to vmlinux.h (to=
 make
> >> them discoverable), and having CO-RE support for using them, etc. I ki=
nda
> >> consider that orthogonal to what's described here, but I do think we s=
hould
> >> fix those issues before implementing the procedures described here.
> >>
> >> v2:
> >> - Incorporate Daniel's changes
> >>
> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> ---
> >>  Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++--=
-
> >>  1 file changed, 81 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.r=
st
> >> index 9fd7fb539f85..dd40a4ee35f2 100644
> >> --- a/Documentation/bpf/kfuncs.rst
> >> +++ b/Documentation/bpf/kfuncs.rst
> >> @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
> >>
> >>  BPF Kernel Functions or more commonly known as kfuncs are functions i=
n the Linux
> >>  kernel which are exposed for use by BPF programs. Unlike normal BPF h=
elpers,
> >> -kfuncs do not have a stable interface and can change from one kernel =
release to
> >> -another. Hence, BPF programs need to be updated in response to change=
s in the
> >> -kernel.
> >> +kfuncs by default do not have a stable interface and can change from =
one kernel
> >> +release to another. Hence, BPF programs may need to be updated in res=
ponse to
> >> +changes in the kernel. See :ref:`BPF_kfunc_stability`.
> >>
> >>  2. Defining a kfunc
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> @@ -223,14 +223,89 @@ type. An example is shown below::
> >>          }
> >>          late_initcall(init_subsystem);
> >>
> >> -3. Core kfuncs
> >> +
> >> +.. _BPF_kfunc_stability:
> >> +
> >> +3. API (in)stability of kfuncs
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +By default, kfuncs exported to BPF programs are considered a kernel-i=
nternal
> >> +interface that can change between kernel versions. This means that BP=
F programs
> >> +using kfuncs may need to adapt to changes between kernel versions. In=
 the
> >> +extreme case that could also include removal of a kfunc. In other wor=
ds, kfuncs
> >> +are _not_ part of the kernel UAPI! Rather, these kfuncs can be though=
t of as
> >> +being similar to internal kernel API functions exported using the
> >
> > [..]
> >
> >> +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functiona=
lity must
> >> +initially start out as kfuncs.
> >
> > To clarify, as part of this proposal, are we making a decision here
> > that we ban new helpers going forward?
>
> Good question! That is one of the things I'm hoping we can clear up by
> this discussing. I don't have a strong opinion on the matter myself, as
> long as there is *some* way to mark a subset of helpers/kfuncs as
> "stable"...

Might be worth it to capitalize in this case to indicate that it's a
MUST from the RFC world? (or go with SHOULD otherwise).
I'm fine either way. The only thing that stops me from fully embracing
MUST is the kfunc requirement on the explicit jit support; I'm not
sure why it exists and at this point I'm too afraid to ask. But having
MUST here might give us motivation to address the shortcomings...

> > (also left some spelling nits below)
> >
> >> +
> >> +3.1 Promotion to "stable" kfuncs
> >> +--------------------------------
> >> +
> >> +While kfuncs are by default considered unstable as described above, s=
ome kfuncs
> >> +may warrant a stronger stability guarantee and can be marked as *stab=
le*. The
> >> +decision to move a kfunc to *stable* is taken on a case-by-case basis=
 and must
> >> +clear a high bar, taking into account the functions' usefulness under
> >> +longer-term production deployment without any unforeseen API issues o=
r
> >> +limitations. In general, it is not expected that every kfunc will tur=
n into a
> >> +stable one - think of it as an exception rather than the norm.
> >> +
> >> +Those kfuncs which have been promoted to stable are then marked using=
 the
> >> +``KF_STABLE`` tag. The process for requesting a kfunc be marked as st=
able
> >> +consists of submitting a patch to the bpf@vger.kernel.org mailing lis=
t adding
> >> +the ``KF_STABLE`` tag to that kfunc's definition. The patch descripti=
on must
> >> +include the rationale for why the kfunc should be promoted to stable,=
 including
> >> +references to existing production uses, etc. The patch will be consid=
ered the
> >> +same was as any other patch, and ultimately the decision on whether a=
 kfunc
> >
> > nit: most likely s/same was/same way/ here?
>
> Yup!
>
> >> +should be promoted to stable is taken by the BPF maintainers.
> >> +
> >> +Stable kfuncs provide the following stability guarantees:
> >> +
> >> +1. Stable kfuncs will not change their function signature or function=
ality in a
> >> +   way that may cause incompatibilities for BPF programs calling the =
function.
> >> +
> >> +2. The BPF community will make every reasonable effort to keep stable=
 kfuncs
> >> +   around as long as they continue to be useful to real-world BPF app=
lications.
> >> +
> >> +3. Should a stable kfunc turn out to be no longer useful, the BPF com=
munity may
> >> +   decide to eventually remove it. In this case, before being removed=
 that kfunc
> >> +   will go through a deprecation procedure as outlined below.
> >> +
> >> +3.2 Deprecation of kfuncs
> >> +-------------------------
> >> +
> >> +As described above, the community will make every reasonable effort t=
o keep
> >> +kfuncs available through future kernel versions once they are marked =
as stable.
> >> +However, it may happen case that BPF development moves in an unforese=
en
> >
> > 'may happen case' -> 'may happen in case' ?
>
> Think I actually meant to drop 'case' entirely; thanks for spotting!
>
> -Toke
>
