Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB158689C1D
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 15:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjBCOr3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 09:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBCOr3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 09:47:29 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444469EE01;
        Fri,  3 Feb 2023 06:47:26 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id m26so5620744qtp.9;
        Fri, 03 Feb 2023 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkxQgPvEMAQ5FKcOo3AfzvomTIIU8VJwtaAmbYsni7g=;
        b=1qDYRf657IMpl+nht3VzaHI4cD636cbTb22KheFo+F+z9F/waTTMPKvrqpHHOrYfgg
         Cjzc1hZ6D3x3dG/gq9dpKWtvBRyPU6u50Lfkns2gQ0peZ3m9GfYMRicyiJfAkz1jv4LW
         cZfKNhZ+W1983Bn+ejagEHmwuJ9haXKGRimfvs3cM/9MuTC341rINm2pYLtMr+/EdywY
         +sdMls/M+G+r6tuZJPfuDsHQV7Lop9t0gZ07ou+sY9Zuv+EZsYho/z9pr8yx9TgF3gb8
         fO5Roa1E6jUL83OtaSvHXeykjSmSyMD+1dghlWTiRwZ87Grn5fylV1DIAqtmf/yVV0L6
         kKQw==
X-Gm-Message-State: AO0yUKVYYzdZm/0Xz8LZ1+sm5c/NaBmJbl0gwRyf0KYaD3Hbf9T9uK2s
        Ib0KS5gPfKYVH+AeTobaRyg=
X-Google-Smtp-Source: AK7set/7RDoL4XT+uvh39sEDDjBSO3R/gBxac5Us1IalPWrcjLv+so2RbJDcClIsf9eJGcnI9VZy0g==
X-Received: by 2002:a05:622a:15c5:b0:3b8:629e:afd9 with SMTP id d5-20020a05622a15c500b003b8629eafd9mr17984399qty.17.1675435644929;
        Fri, 03 Feb 2023 06:47:24 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:dd5a])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a455500b0071a02d712b0sm1993918qkp.99.2023.02.03.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:47:24 -0800 (PST)
Date:   Fri, 3 Feb 2023 08:47:21 -0600
From:   David Vernet <void@manifault.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        brouer@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf/docs: Document kfunc lifecycle /
 stability expectations
Message-ID: <Y90eeaT1W2cPYzMB@maniforge>
References: <20230202223557.744110-1-void@manifault.com>
 <20230202223557.744110-2-void@manifault.com>
 <87cz6qew8l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cz6qew8l.fsf@toke.dk>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 02:04:10PM +0100, Toke Høiland-Jørgensen wrote:
> David Vernet <void@manifault.com> writes:
> 
> > BPF kernel <-> kernel API stability has been discussed at length over
> > the last several weeks and months. Now that we've largely aligned over
> > kfuncs being the way forward, and BPF helpers being considered frozen,
> > it's time to document the expectations for kfunc lifecycles and
> > stability so that everyone (BPF users, kfunc developers, and
> > maintainers) are all aligned, and have a crystal-clear understanding of
> > the expectations surrounding kfuncs.
> >
> > To do that, this patch adds that documentation to the main kfuncs
> > documentation page via a new 'kfunc lifecycle expectations' section. The
> > patch describes how decisions are made in the kernel regarding whether
> > to include, keep, deprecate, or change / remove a kfunc. As described
> > very overtly in the patch itself, but likely worth highlighting here:
> >
> > "kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
> > development elsewhere in the kernel".
> >
> > Rather, the intention and expectation is for kfuncs to be treated like
> > EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
> > safe and valuable option for maintainers and kfunc developers to extend
> > the kernel, without tying anyone's hands, or imposing any kind of
> > restrictions on maintainers in the same way that UAPI changes do.
> >
> > In addition to the 'kfunc lifecycle expectations' section, this patch
> > also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
> > authors or maintainers can choose to add to kfuncs if and when they
> > decide to deprecate them. Note that as described in the patch itself, a
> > kfunc need not be deprecated before being changed or removed -- this
> > flag is simply provided as an available deprecation mechanism for those
> > that want to provide a deprecation story / timeline to their users.
> > When necessary, kfuncs may be changed or removed to accommodate changes
> > elsewhere in the kernel without any deprecation at all.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> 
> Some comments below, but otherwise please add my:
> 
> Co-developed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> should we Cc the next version to linux-api@vger as well just to get a
> bit more visibility in case others have comments?

Yes, good idea, will do.

> 
> > ---
> >  Documentation/bpf/kfuncs.rst | 138 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 133 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > index 0bd07b39c2a4..4135f3111b67 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -13,7 +13,7 @@ BPF Kernel Functions or more commonly known as kfuncs are functions in the Linux
> >  kernel which are exposed for use by BPF programs. Unlike normal BPF helpers,
> >  kfuncs do not have a stable interface and can change from one kernel release to
> >  another. Hence, BPF programs need to be updated in response to changes in the
> > -kernel.
> > +kernel. See :ref:`BPF_kfunc_lifecycle_expectations` for more information.
> >  
> >  2. Defining a kfunc
> >  ===================
> > @@ -238,6 +238,32 @@ single argument which must be a trusted argument or a MEM_RCU pointer.
> >  The argument may have reference count of 0 and the kfunc must take this
> >  into consideration.
> >  
> > +.. _KF_deprecated_flag:
> > +
> > +2.4.9 KF_DEPRECATED flag
> > +------------------------
> > +
> > +The KF_DEPRECATED flag is used for kfuncs which are expected to be changed or
> > +removed in a subsequent kernel release. Deprecated kfuncs may be removed at any
> > +time, though if possible (and when applicable), developers are encouraged to
> > +provide users with a deprecation window to ease the burden of migrating off of
> > +the kfunc.
> 
> 
> 
> I think the "may be removed at any time" is a bit odd here. If someone
> wants to just remove a kfunc, why bother with the deprecation flag at
> all? Besides, that whole "deprecation is optional" bit is explained

I definitely agree that the phrasing could be improved, but my intention
with that phrase was actually to answer the exact nuanced question you
posed. I think we need to clarify that KF_DEPRECATED is an optional tool
that developers can use to provide a softer deprecation story to their
users, rather than a flag that exists as part of a larger, strict
deprecation policy. Otherwise, I think it would be unclear to someone
reading this when and why they would need to use the flag. I liked your
suggestion below, and proposed a bit of extra text to try and capture
this point. Lmk what you think.

> below, in this section we're just explaining the flag. So I'd just drop
> this bit and combine the first two paragraphs as:
> 
> "The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
> changed or removed in a subsequent kernel release. A kfunc that is
> marked with KF_DEPRECATED should also have any relevant information
> captured in its kernel doc. Such information typically includes the
> kfunc's expected remaining lifespan, a recommendation for new
> functionality that can replace it if any is available, and possibly a
> rationale for why it is being removed."

I like this -- are you OK with adding this in a small subsequent
paragraph to address the point I made above?

Note that KF_DEPRECATED is simply a tool that developers can choose to
use to ease their users' burden of migrating off of a kfunc. While
developers are encouraged to use KF_DEPRECATED to provide a
transitionary deprecation period to users of their kfunc, doing so is
not strictly required, and the flag does not exist as part of any larger
kfunc deprecation policy.

> 
> > +Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
> > +supported and have its KF_DEPRECATED flag removed, it is likely to be far more
> > +difficult to remove a KF_DEPRECATED flag after it's been added than it is to
> > +prevent it from being added in the first place. As described in
> > +:ref:`BPF_kfunc_lifecycle_expectations`, users that rely on specific kfuncs are
> > +highly encouraged to make their use-cases known as early as possible, and
> 
> nit: "highly encouraged" reads a bit like overuse of "very" - just "encouraged"?

Agreed, I'll use "encouraged" here.

> 
> > +participate in upstream discussions regarding whether to keep, change,
> > +deprecate, or remove those kfuncs if and when such discussions occur.
> > +
> >  2.5 Registering the kfuncs
> >  --------------------------
> >  
> > @@ -304,14 +330,116 @@ In order to accommodate such requirements, the verifier will enforce strict
> >  PTR_TO_BTF_ID type matching if two types have the exact same name, with one
> >  being suffixed with ``___init``.
> >  
> > -3. Core kfuncs
> > +.. _BPF_kfunc_lifecycle_expectations:
> > +
> > +3. kfunc lifecycle expectations
> > +===============================
> > +
> > +kfuncs provide a kernel <-> kernel API, and thus are not bound by any of the
> > +strict stability restrictions associated with kernel <-> user UAPIs. Instead,
> > +they're modeled more similarly to EXPORT_SYMBOL_GPL, and can therefore be
> 
> nit: "Instead, they're modeled more similarly to" -> "This means they
> can be thought of as similar to" ? ("more similarly" is terrible :P)

Heh, I agree that it doesn't sound right, so much so that I googled it
because of how odd it sounded in my head after repeating it a few times:
[1]. Even though it's apparently correct grammar, I'll still apply your
suggestion to v3 because I think it reads more clearly.

[1]: https://english.stackexchange.com/questions/253073/is-using-more-similar-incorrect

> 
> > +modified or removed by a maintainer of the subsystem they're defined in when
> > +it's deemed necessary.
> > +
> > +Like any other change to the kernel, maintainers will not change or remove a
> > +kfunc without having a reasonable justification.  Whether or not they'll choose
> > +to change a kfunc will ultimately depend on a variety of factors, such as how
> > +widely used the kfunc is, how long the kfunc has been in the kernel, whether an
> > +alternative kfunc exists, what the norm is in terms of stability for the
> > +subsystem in question, and of course what the technical cost is of continuing
> > +to support the kfunc.
> > +
> > +There are several implications of this:
> > +
> > +a) kfuncs that are widely used or have been in the kernel for a long time will
> > +   be more difficult to justify being changed or removed by a maintainer. Said
> > +   in a different way, kfuncs that are known to have a lot of users and provide
> 
> nit: "said in a different way" -> "in other words" ?

Ack

> 
> > +   significant value provide stronger incentives for maintainers to invest the
> > +   time and complexity in supporting them. It is therefore important for
> > +   developers that are using kfuncs in their BPF programs to communicate and
> > +   explain how and why those kfuncs are being used, and to participate in
> > +   discussions regarding those kfuncs when they occur upstream.
> > +
> > +b) Because many BPF programs are not upstreamed as part of the kernel tree, it
> > +   is often not possible to change them in-place when a kfunc changes, as it is
> > +   for e.g. an upstreamed driver being updated in place when an
> > +   EXPORT_SYMBOL_GPL symbol is changed. Distributions that bundle BPF programs
> > +   that use kfuncs must therefore ensure that those BPF programs are linking
> > +   against the kfuncs that are supported by the kernel version being used for
> > +   any given release. Additionally, BPF developers are encouraged to upstream
> > +   their BPF programs so they can enjoy the same benefits as upstreamed
> > +   modules, and avoid code churn.
> > +
> > +   On the other hand, while the hope is that it will become the norm to
> > +   upstream BPF programs, the reality is that most BPF programs are still
> > +   out-of-tree. This means that users with out-of-tree BPF programs that use
> > +   kfuncs should be considered relevant to discussions and decisions around
> > +   modifying and removing kfuncs, despite that not being the norm for
> > +   out-of-tree kernel modules. The BPF community will take an active role in
> > +   participating in upstream discussions when necessary to ensure that the
> > +   perspectives of such users are taken into account.
> 
> As I said in a previous email, I really don't think encouraging people
> to upstream BPF programs are either realistic of desirable. I think we
> should drop that and change this point to something like:

Fair enough. Donald said something similar in [2] as well. I'd like to
see us eventually change this paradigm over time, but we can (and
probably should) certainly decouple that from this patch.

[2]: https://lore.kernel.org/all/m2sffnvxbw.fsf@gmail.com/

> 
> b) Unlike regular kernel symbols marked with EXPORT_SYMBOL_GPL, BPF
>    programs that call kfuncs are generally not part of the kernel tree.
>    This means that refactoring can not generally change callers in-place
>    when a kfunc changes, as it is done for e.g. an upstreamed driver being
>    updated in place when kernel symbol is changed.
> 
>    Unlike with regular kernel symbols, this is expected behaviour for
>    BPF symbols, and out-of-tree BPF programs that use kfuncs should be
>    considered relevant to discussions and decisions around modifying and
>    removing kfuncs. The BPF community will take an active role in
>    participating in upstream discussions when necessary to ensure that
>    the perspectives of such users are taken into account.

Well put, will apply in v3.

> 
> > +c) A kfunc will never have any hard stability guarantees. BPF APIs cannot and
> > +   will not ever hard-block a change in the kernel purely for stability
> > +   reasons. In other words, kfuncs have the same stability guarantees as any
> > +   other kernel API, such as those provided by EXPORT_SYMBOL_GPL, though with
> > +   perhaps less burden than EXPORT_SYMBOL_GPL changes thanks to BPF CO-RE.
> 
> I'd drop the last sentence (from "In other words..."). It's not true
> that kfuncs have "the same stability guarantees", we just said above
> that out-of-tree BPF programs are relevant. Also, other than that I
> don't think having this sentence here adds anything that's not already
> explained below, so I'd just drop it and merge the below paragraph into
> the above.

Ack, will do.

> 
> > +   That being said, kfuncs are features that are meant to solve problems and
> > +   provide value to users. The decision of whether to change or remove a kfunc
> > +   is a multivariate technical decision that is made on a case-by-case basis,
> > +   and which is informed by data points such as those mentioned above. It is
> > +   expected that a kfunc being removed or changed with no warning will not be a
> > +   common occurrence or take place without sound justification, but it is a
> > +   possibility that must be accepted if one is to use kfuncs.
> > +
> > +3.1 kfunc deprecation
> > +---------------------
> > +
> > +As described above, while sometimes a maintainer may find that a kfunc must be
> > +changed or removed immediately to accommodate some changes in their subsystem,
> > +other kfuncs may be able to accommodate a longer and more measured deprecation
> > +process. For example, if a new kfunc comes along which provides superior
> > +functionality to an existing kfunc, the existing kfunc may be deprecated for
> > +some period of time to allow users to migrate their BPF programs to use the new
> > +one. Or, if a kfunc has no known users, a decision may be made to remove the
> > +kfunc (without providing an alternative API) after some deprecation period
> > +period so as to provide users with a window to notify the kfunc maintainer if
> > +it turns out that the kfunc is actually being used.
> > +
> > +kfuncs being deprecated (rather than changed or removed with no warning) is
> > +expected to be the common case, and as described in :ref:`KF_deprecated_flag`,
> 
> reword as: "It's expected that the common case will be that kfuncs will
> go through a deprecation period rather than being changed or removed
> with not warning. As described in..."

Ack

> 
> > +the kfunc framework provides the KF_DEPRECATED flag to kfunc developers to
> > +signal to users that a kfunc has been deprecated. Once a kfunc has been marked
> > +with KF_DEPRECATED, the following procedure is followed for removal:
> > +
> > +1. Any relevant information for deprecated kfuncs is documented in the kfunc's
> > +   kernel docs. This documentation will typically include the kfunc's expected
> > +   remaining lifespan,  a recommendation for new functionality that can replace
> > +   the usage of the deprecated function (or an explanation as to why no such
> > +   replacement exists), etc.
> > +
> > +2. The deprecated kfunc is kept in the kernel for some period of time after it
> > +   was first marked as deprecated. This time period will be chosen on a
> > +   case-by-case basis, and will typically depend on how widespread the use of
> > +   the kfunc is, how long it has been in the kernel, and how hard it is to move
> > +   to alternatives. This deprecation time period is "best effort", and as
> > +   described :ref:`above<BPF_kfunc_lifecycle_expectations>`, circumstances may
> > +   sometimes dictate that the kfunc be removed before the full intended
> > +   deprecation period has elapsed.
> > +
> > +3. After the deprecation period, or sometimes earlier if necessary, the kfunc
> 
> drop "or sometimes earlier if necessary" - the deprecation period ends
> when the kfunc is removed, that's what a deprecation period means. If
> some factor means that the deprecation period is shortened, that's still
> the end of the deprecation period, by definition :)

Fair enough, will change in v3.

Thanks for all of the suggestions. I'll send out v3 later today, along
with your edits and Co-developed-by tag.

- David
