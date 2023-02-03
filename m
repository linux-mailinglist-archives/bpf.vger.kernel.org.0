Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D922B689748
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 11:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjBCKtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 05:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjBCKtS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 05:49:18 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4525B9B;
        Fri,  3 Feb 2023 02:49:16 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id w3so4950680qts.7;
        Fri, 03 Feb 2023 02:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y9z3O6hmPxvllUAJi6Cw55P9OWFlb2tAz45HxVwagE=;
        b=fVNudbaLCEDqNsSQgujvFXGKtDFcmgLdfjpbWErWJ4wmANyd9b/xwVHluLxwOL+cYs
         0egiJTAkfVS4L55x4tl5QR4+DVJgCrj+EduGhnSPbg7FhmamVjV9YiZVTB+rpEsmsyUM
         Tu1Cqu99ZMhyg8JiXv6+4qn2rhhVpcj9vZB0fRKil8byoFMoszSGOAi6XXLKDsWIJaxC
         GXj/GgXw+i+osqaYwvrx5Mevx60vyUBHS32RsFRKsIzoaBboQ3tuIiejxevAQR355Wbh
         Nj+gqya7w6npJvZI0lHFGDrXS1usHSVELafhvq3/4FLyp3OYnEoRo8G2BKjAfa7jlBjc
         Dokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y9z3O6hmPxvllUAJi6Cw55P9OWFlb2tAz45HxVwagE=;
        b=2xet5q/GZeBAEwgrAxQX4zkti/7MK60FbH0I1dWE1QT+R66nKrOxmBVUJ831Zliwkr
         OYIqUMTJOhqlWOopMvQCIPGoPpKbxGESSpi0R5PdeIV1rx89p8WN0hbZM2m29x/ez3R6
         5nSPf8Sw9Bi8qq2flSdjQTCKc/oqiqLuBEl38ggV0a4uXMoKJmTKTJ+JLijDtc+zCQb7
         cCFJa0GjqoZ7f7sT6kvNFXloKMncgz1a9wWYmfzUPApA7fylKDT/YZdiwAHjGJR/PFNR
         VxGpR+jY5fL1+Ba5gSct0h0/G+/IDqccR1Vvyi5UAO/JL3+nkfJbw8APc1U+dkYTXZBH
         6lcQ==
X-Gm-Message-State: AO0yUKW3OnoZ7GXME21dl/utMCFppSI2XD7Mcp4xb8mbq48QFoPOdtdx
        NWFeo7663MVhv+rxP/ZJUA4KXY1xOl4eUA==
X-Google-Smtp-Source: AK7set9h6PBoDuEdKSRkdIn8h2LCX4GITLthCWvvZUKJyC16Bm3bJK8TqDsRVtqJQgPGQvttxkViCA==
X-Received: by 2002:ac8:5c08:0:b0:3b8:2ea9:a09c with SMTP id i8-20020ac85c08000000b003b82ea9a09cmr17816066qti.1.1675421354717;
        Fri, 03 Feb 2023 02:49:14 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a444f00b007296805f607sm1654477qkp.17.2023.02.03.02.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:49:13 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        toke@redhat.com, brouer@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf/docs: Document kfunc lifecycle /
 stability expectations
In-Reply-To: <20230202223557.744110-2-void@manifault.com> (David Vernet's
        message of "Thu, 2 Feb 2023 16:35:57 -0600")
Date:   Fri, 03 Feb 2023 10:48:35 +0000
Message-ID: <m2sffnvxbw.fsf@gmail.com>
References: <20230202223557.744110-1-void@manifault.com>
        <20230202223557.744110-2-void@manifault.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> writes:

> +3. kfunc lifecycle expectations
> +===============================
> +
> +kfuncs provide a kernel <-> kernel API, and thus are not bound by any of the
> +strict stability restrictions associated with kernel <-> user UAPIs. Instead,
> +they're modeled more similarly to EXPORT_SYMBOL_GPL, and can therefore be
> +modified or removed by a maintainer of the subsystem they're defined in when
> +it's deemed necessary.
> +
> +Like any other change to the kernel, maintainers will not change or remove a
> +kfunc without having a reasonable justification.  Whether or not they'll choose
> +to change a kfunc will ultimately depend on a variety of factors, such as how
> +widely used the kfunc is, how long the kfunc has been in the kernel, whether an
> +alternative kfunc exists, what the norm is in terms of stability for the
> +subsystem in question, and of course what the technical cost is of continuing
> +to support the kfunc.
> +
> +There are several implications of this:
> +
> +a) kfuncs that are widely used or have been in the kernel for a long time will
> +   be more difficult to justify being changed or removed by a maintainer. Said
> +   in a different way, kfuncs that are known to have a lot of users and provide
> +   significant value provide stronger incentives for maintainers to invest the
> +   time and complexity in supporting them. It is therefore important for
> +   developers that are using kfuncs in their BPF programs to communicate and
> +   explain how and why those kfuncs are being used, and to participate in
> +   discussions regarding those kfuncs when they occur upstream.
> +
> +b) Because many BPF programs are not upstreamed as part of the kernel tree, it
> +   is often not possible to change them in-place when a kfunc changes, as it is
> +   for e.g. an upstreamed driver being updated in place when an
> +   EXPORT_SYMBOL_GPL symbol is changed. Distributions that bundle BPF programs
> +   that use kfuncs must therefore ensure that those BPF programs are linking
> +   against the kfuncs that are supported by the kernel version being used for
> +   any given release. Additionally, BPF developers are encouraged to upstream
> +   their BPF programs so they can enjoy the same benefits as upstreamed
> +   modules, and avoid code churn.

It seems unrealistic to wish for BPF programs to be upstreamed, for
several reasons. A key benefit of BPF programs is that they are
decoupled from the kernel lifecycle and packaging. BPF programs are
often more tightly coupled with the application they are part of and
need to be maintained alongside those applications. There does not seem
to be any desire, process or incentive to maintain BPF programs in tree.

> +   On the other hand, while the hope is that it will become the norm to
> +   upstream BPF programs, the reality is that most BPF programs are still
> +   out-of-tree. This means that users with out-of-tree BPF programs that use
> +   kfuncs should be considered relevant to discussions and decisions around
> +   modifying and removing kfuncs, despite that not being the norm for
> +   out-of-tree kernel modules. The BPF community will take an active role in
> +   participating in upstream discussions when necessary to ensure that the
> +   perspectives of such users are taken into account.
> +
> +c) A kfunc will never have any hard stability guarantees. BPF APIs cannot and
> +   will not ever hard-block a change in the kernel purely for stability
> +   reasons. In other words, kfuncs have the same stability guarantees as any
> +   other kernel API, such as those provided by EXPORT_SYMBOL_GPL, though with
> +   perhaps less burden than EXPORT_SYMBOL_GPL changes thanks to BPF CO-RE.
> +
> +   That being said, kfuncs are features that are meant to solve problems and
> +   provide value to users. The decision of whether to change or remove a kfunc
> +   is a multivariate technical decision that is made on a case-by-case basis,
> +   and which is informed by data points such as those mentioned above. It is
> +   expected that a kfunc being removed or changed with no warning will not be a
> +   common occurrence or take place without sound justification, but it is a
> +   possibility that must be accepted if one is to use kfuncs.
> +
> +3.1 kfunc deprecation
> +---------------------
> +
> +As described above, while sometimes a maintainer may find that a kfunc must be
> +changed or removed immediately to accommodate some changes in their subsystem,
> +other kfuncs may be able to accommodate a longer and more measured deprecation

How about replacing 'other kfuncs may' with 'usually kfuncs will' to
re-emphasise that this would be the more common scenario.

> +process. For example, if a new kfunc comes along which provides superior
> +functionality to an existing kfunc, the existing kfunc may be deprecated for
> +some period of time to allow users to migrate their BPF programs to use the new
> +one. Or, if a kfunc has no known users, a decision may be made to remove the
> +kfunc (without providing an alternative API) after some deprecation period
> +period so as to provide users with a window to notify the kfunc maintainer if

Duplicate 'period'.

> +it turns out that the kfunc is actually being used.
> +
> +kfuncs being deprecated (rather than changed or removed with no warning) is
> +expected to be the common case, and as described in :ref:`KF_deprecated_flag`,
> +the kfunc framework provides the KF_DEPRECATED flag to kfunc developers to
> +signal to users that a kfunc has been deprecated. Once a kfunc has been marked
> +with KF_DEPRECATED, the following procedure is followed for removal:
> +
> +1. Any relevant information for deprecated kfuncs is documented in the kfunc's
> +   kernel docs. This documentation will typically include the kfunc's expected
> +   remaining lifespan,  a recommendation for new functionality that can replace
> +   the usage of the deprecated function (or an explanation as to why no such
> +   replacement exists), etc.
> +
> +2. The deprecated kfunc is kept in the kernel for some period of time after it
> +   was first marked as deprecated. This time period will be chosen on a
> +   case-by-case basis, and will typically depend on how widespread the use of
> +   the kfunc is, how long it has been in the kernel, and how hard it is to move
> +   to alternatives. This deprecation time period is "best effort", and as
> +   described :ref:`above<BPF_kfunc_lifecycle_expectations>`, circumstances may
> +   sometimes dictate that the kfunc be removed before the full intended
> +   deprecation period has elapsed.
> +
> +3. After the deprecation period, or sometimes earlier if necessary, the kfunc
> +   will be removed. At this point, BPF programs calling the kfunc will be
> +   rejected by the verifier.
> +
