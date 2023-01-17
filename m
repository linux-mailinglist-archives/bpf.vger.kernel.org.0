Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3168E670BC4
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjAQWlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 17:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAQWk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 17:40:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B659565
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 13:54:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 20so7620050plo.3
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 13:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA5nGfSb05/+KgMMi2NPhYL9k+WFqw7TAMf42QWZw+s=;
        b=Msm7wjQ+mXKeJbh0LJLLyZRw9tR++DlBsq1FxIp2P+5GkK3tRxCO/VNpWjskYSuk5V
         c+h3LBXZ0BLhYaSZ3q+S62ibzS4B7+4NZ6vbFUxgpXGYZwvyOiw0NJwGUX8daP63Rb83
         Q7eSmQVjGYtWlAqgRdPQ2PtuB645f4jZsLOXDPwcvsJ3IbwWMMEDzy/9H8etwGKa5eyq
         MU4MQJ5vlcgL31GB0FaDZNhcFaSN9nr7FirjH6mM3K+Fd3gYdeIw/X951/5TxErQvo3O
         0zzH0NiWu9KJOpHQ5fuFUcuNYKKmX3isxLXOTJPyn9RwwAGkfpKy4BHiZczSJv1lnJ4I
         8MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA5nGfSb05/+KgMMi2NPhYL9k+WFqw7TAMf42QWZw+s=;
        b=LiUNYYPxhad7hVdpRicki+JLN5BRHS8Cn6XbmIQpz7owHKWIjLswc0k3wj/OuKM77a
         KEToh1mGLy8xHP42Zl8UQUQIvzAeAOiAzmRtj4t2qIO341j/tWKfRBtnbSCDaFGlK5B3
         Bl6IoZVjBr0kfqRyuCwPkSiYLFLRT7KrGEVGegp/xzA9CuIltH8dVCIz5VwOzPM7RrZ0
         4kF20bFSWZ2VJ3TeWdZhb2wJeZ7oWSOVmKDuiHy4uiqyWYWrQyzqTccKJQjVGPWvUa0F
         xXddl4BCkV2j7cuSyw2zd5+svABQ31ZG/fzgxXbvDVMoCAnNjAVFzyM94ISplfafWmf5
         myrg==
X-Gm-Message-State: AFqh2kr6UrLXMbR34MJ26JRns5+vyUb2heDf129o3FCWzWYEx4M/f2sm
        Zzc1c9Ct+1X/LE5Q2byMdw172YCfBVcZIhAtcA8rog==
X-Google-Smtp-Source: AMrXdXvS2PRk8JL58UuG98zgI6yr+Q3IDcUMYIvWwicLGFzWb3TdABpdREp/0zOlgVY9h98URGldf47qulmadNhBDM8=
X-Received: by 2002:a17:90a:2c4d:b0:229:2410:ef30 with SMTP id
 p13-20020a17090a2c4d00b002292410ef30mr408668pjm.66.1673992451224; Tue, 17 Jan
 2023 13:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20230117212731.442859-1-toke@redhat.com>
In-Reply-To: <20230117212731.442859-1-toke@redhat.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 17 Jan 2023 13:53:59 -0800
Message-ID: <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 1:27 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Following up on the discussion at the BPF office hours, this patch adds a
> description of the (new) concept of "stable kfuncs", which are kfuncs tha=
t
> offer a "more stable" interface than what we have now, but is still not
> part of UAPI.
>
> This is mostly meant as a straw man proposal to focus discussions around
> stability guarantees. From the discussion, it seemed clear that there wer=
e
> at least some people (myself included) who felt that there needs to be so=
me
> way to export functionality that we consider "stable" (in the sense of
> "applications can rely on its continuing existence").
>
> One option is to keep BPF helpers as the stable interface and implement
> some technical solution for moving functionality from kfuncs to helpers
> once it has stood the test of time and we're comfortable committing to it
> as a stable API. Another is to freeze the helper definitions, and instead
> use kfuncs for this purpose as well, by marking a subset of them as
> "stable" in some way. Or we can do both and have multiple levels of
> "stable", I suppose.
>
> This patch is an attempt to describe what the "stable kfuncs" idea might
> look like, as well as to formulate some criteria for what we mean by
> "stable", and describe an explicit deprecation procedure. Feel free to
> critique any part of this (including rejecting the notion entirely).
>
> Some people mentioned (in the office hours) that should we decide to go i=
n
> this direction, there's some work that needs to be done in libbpf (and
> probably the kernel too?) to bring the kfunc developer experience up to p=
ar
> with helpers. Things like exporting kfunc definitions to vmlinux.h (to ma=
ke
> them discoverable), and having CO-RE support for using them, etc. I kinda
> consider that orthogonal to what's described here, but I do think we shou=
ld
> fix those issues before implementing the procedures described here.
>
> v2:
> - Incorporate Daniel's changes
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 9fd7fb539f85..dd40a4ee35f2 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
>
>  BPF Kernel Functions or more commonly known as kfuncs are functions in t=
he Linux
>  kernel which are exposed for use by BPF programs. Unlike normal BPF help=
ers,
> -kfuncs do not have a stable interface and can change from one kernel rel=
ease to
> -another. Hence, BPF programs need to be updated in response to changes i=
n the
> -kernel.
> +kfuncs by default do not have a stable interface and can change from one=
 kernel
> +release to another. Hence, BPF programs may need to be updated in respon=
se to
> +changes in the kernel. See :ref:`BPF_kfunc_stability`.
>
>  2. Defining a kfunc
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -223,14 +223,89 @@ type. An example is shown below::
>          }
>          late_initcall(init_subsystem);
>
> -3. Core kfuncs
> +
> +.. _BPF_kfunc_stability:
> +
> +3. API (in)stability of kfuncs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +By default, kfuncs exported to BPF programs are considered a kernel-inte=
rnal
> +interface that can change between kernel versions. This means that BPF p=
rograms
> +using kfuncs may need to adapt to changes between kernel versions. In th=
e
> +extreme case that could also include removal of a kfunc. In other words,=
 kfuncs
> +are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought o=
f as
> +being similar to internal kernel API functions exported using the

[..]

> +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionalit=
y must
> +initially start out as kfuncs.

To clarify, as part of this proposal, are we making a decision here
that we ban new helpers going forward?

(also left some spelling nits below)

> +
> +3.1 Promotion to "stable" kfuncs
> +--------------------------------
> +
> +While kfuncs are by default considered unstable as described above, some=
 kfuncs
> +may warrant a stronger stability guarantee and can be marked as *stable*=
. The
> +decision to move a kfunc to *stable* is taken on a case-by-case basis an=
d must
> +clear a high bar, taking into account the functions' usefulness under
> +longer-term production deployment without any unforeseen API issues or
> +limitations. In general, it is not expected that every kfunc will turn i=
nto a
> +stable one - think of it as an exception rather than the norm.
> +
> +Those kfuncs which have been promoted to stable are then marked using th=
e
> +``KF_STABLE`` tag. The process for requesting a kfunc be marked as stabl=
e
> +consists of submitting a patch to the bpf@vger.kernel.org mailing list a=
dding
> +the ``KF_STABLE`` tag to that kfunc's definition. The patch description =
must
> +include the rationale for why the kfunc should be promoted to stable, in=
cluding
> +references to existing production uses, etc. The patch will be considere=
d the
> +same was as any other patch, and ultimately the decision on whether a kf=
unc

nit: most likely s/same was/same way/ here?

> +should be promoted to stable is taken by the BPF maintainers.
> +
> +Stable kfuncs provide the following stability guarantees:
> +
> +1. Stable kfuncs will not change their function signature or functionali=
ty in a
> +   way that may cause incompatibilities for BPF programs calling the fun=
ction.
> +
> +2. The BPF community will make every reasonable effort to keep stable kf=
uncs
> +   around as long as they continue to be useful to real-world BPF applic=
ations.
> +
> +3. Should a stable kfunc turn out to be no longer useful, the BPF commun=
ity may
> +   decide to eventually remove it. In this case, before being removed th=
at kfunc
> +   will go through a deprecation procedure as outlined below.
> +
> +3.2 Deprecation of kfuncs
> +-------------------------
> +
> +As described above, the community will make every reasonable effort to k=
eep
> +kfuncs available through future kernel versions once they are marked as =
stable.
> +However, it may happen case that BPF development moves in an unforeseen

'may happen case' -> 'may happen in case' ?

> +direction so that even a stable kfunc ceases to be useful for program
> +development.
> +
> +In this case, stable kfuncs can be marked as *deprecated* using the
> +``KF_DEPRECATED`` tag. Such a deprecation request cannot be arbitrary an=
d must
> +explain why a given stable kfunc should be deprecated. Once a kfunc is m=
arked as
> +deprecated, the following procedure will be followed for removal:
> +
> +1. A kfunc marked as deprecated will be kept in the kernel for a conserv=
atively
> +   chosen period of time after it was first marked as deprecated (usuall=
y
> +   corresponding to a span of multiple years).
> +
> +2. Deprecated functions will be documented in the kernel docs along with=
 their
> +   remaining lifespan and including a recommendation for new functionali=
ty that
> +   can replace the usage of the deprecated function (or an explanation f=
or why
> +   no such replacement exists).
> +
> +3. After the deprecation period, the kfunc will be removed and the funct=
ion name
> +   will be marked as invalid inside the kernel (to ensure that no new kf=
unc is
> +   accidentally introduced with the same name in the future). After this
> +   happens, BPF programs calling the kfunc will be rejected by the verif=
ier.
> +
> +4. Core kfuncs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The BPF subsystem provides a number of "core" kfuncs that are potentiall=
y
>  applicable to a wide variety of different possible use cases and program=
s.
>  Those kfuncs are documented here.
>
> -3.1 struct task_struct * kfuncs
> +4.1 struct task_struct * kfuncs
>  -------------------------------
>
>  There are a number of kfuncs that allow ``struct task_struct *`` objects=
 to be
> @@ -306,7 +381,7 @@ Here is an example of it being used:
>                 return 0;
>         }
>
> -3.2 struct cgroup * kfuncs
> +4.2 struct cgroup * kfuncs
>  --------------------------
>
>  ``struct cgroup *`` objects also have acquire and release functions:
> --
> 2.39.0
>
