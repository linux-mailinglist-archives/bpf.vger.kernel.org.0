Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829B68996D
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 14:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBCNFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 08:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjBCNFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 08:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C1126C4
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 05:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675429456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjwAFbxSeKD02QWSUlCGldcfqotk0DEPoEnWcgdIBUE=;
        b=jDLuRBSJzSziQAN71TZUipyeFLQjeq+k1wpU2QmeZZmf6qNuwpRi5f3tMk5C71tvdjTIFL
        oWRvCD6z7Ol/SsMfkwHbeAxQlH7hGGv/m5nobzBn459WQFiqHqJ9a/h/U9AjwjPo2R1e0F
        Uvs9FGwMLvZfhrCWcBOprxubNbuF28Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-60-azUrpBSqP6ujLnlDvTUhPg-1; Fri, 03 Feb 2023 08:04:14 -0500
X-MC-Unique: azUrpBSqP6ujLnlDvTUhPg-1
Received: by mail-ed1-f71.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso3546520edc.7
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 05:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjwAFbxSeKD02QWSUlCGldcfqotk0DEPoEnWcgdIBUE=;
        b=gfpEICiSd270UBHyJSs10JekhSfivAUbIP5P+yGJw62s6wIt0XZPc03RJ5A+k15VtF
         mPEx9eX8iDCyQ1ez8/rog1SxcCJO45mnDIztAP83Zg55mEHUUfRbsSq3mgd1JeN5irRx
         sOpKTkxrbifBVLdGF1JngcUTMC/5WV3H8fvmHAXR883X/do2kVcmCsJndvoxtZM+uCic
         wPoS/Bm/f2VoLhIyNg8jyYgZqRUzrroqQ4t8hlLuqZQ/9bphpTuY9qAJJ3oDr+aUz5ts
         fEEsAH9Ko/B2UzI4eqETFBZsWO3ZISW2fNLzwx0AYHwbCL3dm9N5iV/qaOiZclD2ApUd
         WwNQ==
X-Gm-Message-State: AO0yUKUYRFLfPDgnyj1dZTUVV+0c8v+XnlXLvgLynVYZ+6K9Z84z/o6A
        uzM6v0Otjimk4DQXvM+Z9w9iISGBknuKRR0vr4aMeXXubL11HDgHUFuVkr87XNLfh3SKa1mR+Ce
        ZsvBEQoY49gCW
X-Received: by 2002:a05:6402:1779:b0:4a2:3bef:e000 with SMTP id da25-20020a056402177900b004a23befe000mr8474256edb.42.1675429453633;
        Fri, 03 Feb 2023 05:04:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+TpH/q4s2x3HXnoHfzlNjJgs2QpbiswU4vg2sNv4toO4IUzvjIzVSOGRZAfz8VGvJBXqePkA==
X-Received: by 2002:a05:6402:1779:b0:4a2:3bef:e000 with SMTP id da25-20020a056402177900b004a23befe000mr8474216edb.42.1675429453138;
        Fri, 03 Feb 2023 05:04:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c21-20020a056402101500b004a2440f0150sm1081437edu.97.2023.02.03.05.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 05:04:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B0AE0972DE1; Fri,  3 Feb 2023 14:04:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, brouer@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf/docs: Document kfunc lifecycle /
 stability expectations
In-Reply-To: <20230202223557.744110-2-void@manifault.com>
References: <20230202223557.744110-1-void@manifault.com>
 <20230202223557.744110-2-void@manifault.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 03 Feb 2023 14:04:10 +0100
Message-ID: <87cz6qew8l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> writes:

> BPF kernel <-> kernel API stability has been discussed at length over
> the last several weeks and months. Now that we've largely aligned over
> kfuncs being the way forward, and BPF helpers being considered frozen,
> it's time to document the expectations for kfunc lifecycles and
> stability so that everyone (BPF users, kfunc developers, and
> maintainers) are all aligned, and have a crystal-clear understanding of
> the expectations surrounding kfuncs.
>
> To do that, this patch adds that documentation to the main kfuncs
> documentation page via a new 'kfunc lifecycle expectations' section. The
> patch describes how decisions are made in the kernel regarding whether
> to include, keep, deprecate, or change / remove a kfunc. As described
> very overtly in the patch itself, but likely worth highlighting here:
>
> "kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
> development elsewhere in the kernel".
>
> Rather, the intention and expectation is for kfuncs to be treated like
> EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
> safe and valuable option for maintainers and kfunc developers to extend
> the kernel, without tying anyone's hands, or imposing any kind of
> restrictions on maintainers in the same way that UAPI changes do.
>
> In addition to the 'kfunc lifecycle expectations' section, this patch
> also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
> authors or maintainers can choose to add to kfuncs if and when they
> decide to deprecate them. Note that as described in the patch itself, a
> kfunc need not be deprecated before being changed or removed -- this
> flag is simply provided as an available deprecation mechanism for those
> that want to provide a deprecation story / timeline to their users.
> When necessary, kfuncs may be changed or removed to accommodate changes
> elsewhere in the kernel without any deprecation at all.
>
> Signed-off-by: David Vernet <void@manifault.com>

Some comments below, but otherwise please add my:

Co-developed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

should we Cc the next version to linux-api@vger as well just to get a
bit more visibility in case others have comments?

> ---
>  Documentation/bpf/kfuncs.rst | 138 +++++++++++++++++++++++++++++++++--
>  1 file changed, 133 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 0bd07b39c2a4..4135f3111b67 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -13,7 +13,7 @@ BPF Kernel Functions or more commonly known as kfuncs a=
re functions in the Linux
>  kernel which are exposed for use by BPF programs. Unlike normal BPF help=
ers,
>  kfuncs do not have a stable interface and can change from one kernel rel=
ease to
>  another. Hence, BPF programs need to be updated in response to changes i=
n the
> -kernel.
> +kernel. See :ref:`BPF_kfunc_lifecycle_expectations` for more information.
>=20=20
>  2. Defining a kfunc
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -238,6 +238,32 @@ single argument which must be a trusted argument or =
a MEM_RCU pointer.
>  The argument may have reference count of 0 and the kfunc must take this
>  into consideration.
>=20=20
> +.. _KF_deprecated_flag:
> +
> +2.4.9 KF_DEPRECATED flag
> +------------------------
> +
> +The KF_DEPRECATED flag is used for kfuncs which are expected to be chang=
ed or
> +removed in a subsequent kernel release. Deprecated kfuncs may be removed=
 at any
> +time, though if possible (and when applicable), developers are encourage=
d to
> +provide users with a deprecation window to ease the burden of migrating =
off of
> +the kfunc.



I think the "may be removed at any time" is a bit odd here. If someone
wants to just remove a kfunc, why bother with the deprecation flag at
all? Besides, that whole "deprecation is optional" bit is explained
below, in this section we're just explaining the flag. So I'd just drop
this bit and combine the first two paragraphs as:

"The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
changed or removed in a subsequent kernel release. A kfunc that is
marked with KF_DEPRECATED should also have any relevant information
captured in its kernel doc. Such information typically includes the
kfunc's expected remaining lifespan, a recommendation for new
functionality that can replace it if any is available, and possibly a
rationale for why it is being removed."

> +Note that while on some occasions, a KF_DEPRECATED kfunc may continue to=
 be
> +supported and have its KF_DEPRECATED flag removed, it is likely to be fa=
r more
> +difficult to remove a KF_DEPRECATED flag after it's been added than it i=
s to
> +prevent it from being added in the first place. As described in
> +:ref:`BPF_kfunc_lifecycle_expectations`, users that rely on specific kfu=
ncs are
> +highly encouraged to make their use-cases known as early as possible, and

nit: "highly encouraged" reads a bit like overuse of "very" - just "encoura=
ged"?

> +participate in upstream discussions regarding whether to keep, change,
> +deprecate, or remove those kfuncs if and when such discussions occur.
> +
>  2.5 Registering the kfuncs
>  --------------------------
>=20=20
> @@ -304,14 +330,116 @@ In order to accommodate such requirements, the ver=
ifier will enforce strict
>  PTR_TO_BTF_ID type matching if two types have the exact same name, with =
one
>  being suffixed with ``___init``.
>=20=20
> -3. Core kfuncs
> +.. _BPF_kfunc_lifecycle_expectations:
> +
> +3. kfunc lifecycle expectations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +kfuncs provide a kernel <-> kernel API, and thus are not bound by any of=
 the
> +strict stability restrictions associated with kernel <-> user UAPIs. Ins=
tead,
> +they're modeled more similarly to EXPORT_SYMBOL_GPL, and can therefore be

nit: "Instead, they're modeled more similarly to" -> "This means they
can be thought of as similar to" ? ("more similarly" is terrible :P)

> +modified or removed by a maintainer of the subsystem they're defined in =
when
> +it's deemed necessary.
> +
> +Like any other change to the kernel, maintainers will not change or remo=
ve a
> +kfunc without having a reasonable justification.  Whether or not they'll=
 choose
> +to change a kfunc will ultimately depend on a variety of factors, such a=
s how
> +widely used the kfunc is, how long the kfunc has been in the kernel, whe=
ther an
> +alternative kfunc exists, what the norm is in terms of stability for the
> +subsystem in question, and of course what the technical cost is of conti=
nuing
> +to support the kfunc.
> +
> +There are several implications of this:
> +
> +a) kfuncs that are widely used or have been in the kernel for a long tim=
e will
> +   be more difficult to justify being changed or removed by a maintainer=
. Said
> +   in a different way, kfuncs that are known to have a lot of users and =
provide

nit: "said in a different way" -> "in other words" ?

> +   significant value provide stronger incentives for maintainers to inve=
st the
> +   time and complexity in supporting them. It is therefore important for
> +   developers that are using kfuncs in their BPF programs to communicate=
 and
> +   explain how and why those kfuncs are being used, and to participate in
> +   discussions regarding those kfuncs when they occur upstream.
> +
> +b) Because many BPF programs are not upstreamed as part of the kernel tr=
ee, it
> +   is often not possible to change them in-place when a kfunc changes, a=
s it is
> +   for e.g. an upstreamed driver being updated in place when an
> +   EXPORT_SYMBOL_GPL symbol is changed. Distributions that bundle BPF pr=
ograms
> +   that use kfuncs must therefore ensure that those BPF programs are lin=
king
> +   against the kfuncs that are supported by the kernel version being use=
d for
> +   any given release. Additionally, BPF developers are encouraged to ups=
tream
> +   their BPF programs so they can enjoy the same benefits as upstreamed
> +   modules, and avoid code churn.
> +
> +   On the other hand, while the hope is that it will become the norm to
> +   upstream BPF programs, the reality is that most BPF programs are still
> +   out-of-tree. This means that users with out-of-tree BPF programs that=
 use
> +   kfuncs should be considered relevant to discussions and decisions aro=
und
> +   modifying and removing kfuncs, despite that not being the norm for
> +   out-of-tree kernel modules. The BPF community will take an active rol=
e in
> +   participating in upstream discussions when necessary to ensure that t=
he
> +   perspectives of such users are taken into account.

As I said in a previous email, I really don't think encouraging people
to upstream BPF programs are either realistic of desirable. I think we
should drop that and change this point to something like:

b) Unlike regular kernel symbols marked with EXPORT_SYMBOL_GPL, BPF
   programs that call kfuncs are generally not part of the kernel tree.
   This means that refactoring can not generally change callers in-place
   when a kfunc changes, as it is done for e.g. an upstreamed driver being
   updated in place when kernel symbol is changed.

   Unlike with regular kernel symbols, this is expected behaviour for
   BPF symbols, and out-of-tree BPF programs that use kfuncs should be
   considered relevant to discussions and decisions around modifying and
   removing kfuncs. The BPF community will take an active role in
   participating in upstream discussions when necessary to ensure that
   the perspectives of such users are taken into account.

> +c) A kfunc will never have any hard stability guarantees. BPF APIs canno=
t and
> +   will not ever hard-block a change in the kernel purely for stability
> +   reasons. In other words, kfuncs have the same stability guarantees as=
 any
> +   other kernel API, such as those provided by EXPORT_SYMBOL_GPL, though=
 with
> +   perhaps less burden than EXPORT_SYMBOL_GPL changes thanks to BPF CO-R=
E.

I'd drop the last sentence (from "In other words..."). It's not true
that kfuncs have "the same stability guarantees", we just said above
that out-of-tree BPF programs are relevant. Also, other than that I
don't think having this sentence here adds anything that's not already
explained below, so I'd just drop it and merge the below paragraph into
the above.

> +   That being said, kfuncs are features that are meant to solve problems=
 and
> +   provide value to users. The decision of whether to change or remove a=
 kfunc
> +   is a multivariate technical decision that is made on a case-by-case b=
asis,
> +   and which is informed by data points such as those mentioned above. I=
t is
> +   expected that a kfunc being removed or changed with no warning will n=
ot be a
> +   common occurrence or take place without sound justification, but it i=
s a
> +   possibility that must be accepted if one is to use kfuncs.
> +
> +3.1 kfunc deprecation
> +---------------------
> +
> +As described above, while sometimes a maintainer may find that a kfunc m=
ust be
> +changed or removed immediately to accommodate some changes in their subs=
ystem,
> +other kfuncs may be able to accommodate a longer and more measured depre=
cation
> +process. For example, if a new kfunc comes along which provides superior
> +functionality to an existing kfunc, the existing kfunc may be deprecated=
 for
> +some period of time to allow users to migrate their BPF programs to use =
the new
> +one. Or, if a kfunc has no known users, a decision may be made to remove=
 the
> +kfunc (without providing an alternative API) after some deprecation peri=
od
> +period so as to provide users with a window to notify the kfunc maintain=
er if
> +it turns out that the kfunc is actually being used.
> +
> +kfuncs being deprecated (rather than changed or removed with no warning)=
 is
> +expected to be the common case, and as described in :ref:`KF_deprecated_=
flag`,

reword as: "It's expected that the common case will be that kfuncs will
go through a deprecation period rather than being changed or removed
with not warning. As described in..."

> +the kfunc framework provides the KF_DEPRECATED flag to kfunc developers =
to
> +signal to users that a kfunc has been deprecated. Once a kfunc has been =
marked
> +with KF_DEPRECATED, the following procedure is followed for removal:
> +
> +1. Any relevant information for deprecated kfuncs is documented in the k=
func's
> +   kernel docs. This documentation will typically include the kfunc's ex=
pected
> +   remaining lifespan,  a recommendation for new functionality that can =
replace
> +   the usage of the deprecated function (or an explanation as to why no =
such
> +   replacement exists), etc.
> +
> +2. The deprecated kfunc is kept in the kernel for some period of time af=
ter it
> +   was first marked as deprecated. This time period will be chosen on a
> +   case-by-case basis, and will typically depend on how widespread the u=
se of
> +   the kfunc is, how long it has been in the kernel, and how hard it is =
to move
> +   to alternatives. This deprecation time period is "best effort", and as
> +   described :ref:`above<BPF_kfunc_lifecycle_expectations>`, circumstanc=
es may
> +   sometimes dictate that the kfunc be removed before the full intended
> +   deprecation period has elapsed.
> +
> +3. After the deprecation period, or sometimes earlier if necessary, the =
kfunc

drop "or sometimes earlier if necessary" - the deprecation period ends
when the kfunc is removed, that's what a deprecation period means. If
some factor means that the deprecation period is shortened, that's still
the end of the deprecation period, by definition :)



-Toke

