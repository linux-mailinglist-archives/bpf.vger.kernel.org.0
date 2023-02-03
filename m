Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E441689B53
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 15:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjBCOQP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 09:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjBCOPm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 09:15:42 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E412C10436;
        Fri,  3 Feb 2023 06:14:48 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id f10so5543466qtv.1;
        Fri, 03 Feb 2023 06:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8Yzpnt8nduV5q46/kI+D/6W6pPEk+IXknaFd6D41b0=;
        b=1Qba2Poo3Kx5c/EsKayWDyA7rqOAZEEWUqq1lIShc4ONzwYAivvW9DNKOQEX/tP4pV
         dObk1QKpMUA6iVCY1DFeqvLsx3GWbar2knh9wJfayFzjkvbq8mI3Z2XddzVXxbqWwHwr
         XVqQ0swN83C/RCLQtghpBhmNj7X7v7fTnl49ZOIHi/ouBgI3cM/5FpOWpA0KSsEBHv67
         ODDB0vxrdT4OeER0IL5R4vfxoqYBJqWewatOBIv1IJKO0RkW70Xgh1W3MU4nabquPmZT
         qZ0BB6WAHm/tAU4pUVZ+y+QIu1aGspWxYEwK8IS+JwOLb9KvEv2SuKC8QY8/T6uz76xI
         aJ+w==
X-Gm-Message-State: AO0yUKVqe3PoCIcm0+pF/iRU/8uZiAf/flYJo20ACQDRExg2FETpTtdF
        OGWRVNWc/sKhtfxX3BQEpTs=
X-Google-Smtp-Source: AK7set/TCEb+BZe1Ot/eEP4ZVlcBuTrq1jCus8+pq4QhU/GEHxUHRQQcTgIrNP+jhpwEIX4fjPGejw==
X-Received: by 2002:ac8:7f16:0:b0:3b8:6a20:675e with SMTP id f22-20020ac87f16000000b003b86a20675emr19778349qtk.29.1675433687668;
        Fri, 03 Feb 2023 06:14:47 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:dd5a])
        by smtp.gmail.com with ESMTPSA id h67-20020a376c46000000b0070495934152sm1900397qkc.48.2023.02.03.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:14:47 -0800 (PST)
Date:   Fri, 3 Feb 2023 08:14:45 -0600
From:   David Vernet <void@manifault.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        toke@redhat.com, brouer@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf/docs: Document kfunc lifecycle /
 stability expectations
Message-ID: <Y90W1Zw2JAsb8XNO@maniforge>
References: <20230202223557.744110-1-void@manifault.com>
 <20230202223557.744110-2-void@manifault.com>
 <m2sffnvxbw.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2sffnvxbw.fsf@gmail.com>
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

On Fri, Feb 03, 2023 at 10:48:35AM +0000, Donald Hunter wrote:
> David Vernet <void@manifault.com> writes:
> 
> > +3. kfunc lifecycle expectations
> > +===============================
> > +
> > +kfuncs provide a kernel <-> kernel API, and thus are not bound by any of the
> > +strict stability restrictions associated with kernel <-> user UAPIs. Instead,
> > +they're modeled more similarly to EXPORT_SYMBOL_GPL, and can therefore be
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
> 
> It seems unrealistic to wish for BPF programs to be upstreamed, for
> several reasons. A key benefit of BPF programs is that they are
> decoupled from the kernel lifecycle and packaging. BPF programs are
> often more tightly coupled with the application they are part of and
> need to be maintained alongside those applications. There does not seem
> to be any desire, process or incentive to maintain BPF programs in tree.

I think this is slowly becoming less true with the "modern BPF"
described by Alexei in [0], but I agree that it's certainly the vast
majority of cases now, and I'm fine with removing this from the doc to
decouple it from the larger kfunc lifecycle discussion. Toke mentioned
something similar in [1], so I'll remove this in v3.

[0]: https://lwn.net/Articles/909095/
[1]: https://lore.kernel.org/all/87cz6qew8l.fsf@toke.dk/

> 
> > +   On the other hand, while the hope is that it will become the norm to
> > +   upstream BPF programs, the reality is that most BPF programs are still
> > +   out-of-tree. This means that users with out-of-tree BPF programs that use
> > +   kfuncs should be considered relevant to discussions and decisions around
> > +   modifying and removing kfuncs, despite that not being the norm for
> > +   out-of-tree kernel modules. The BPF community will take an active role in
> > +   participating in upstream discussions when necessary to ensure that the
> > +   perspectives of such users are taken into account.
> > +
> > +c) A kfunc will never have any hard stability guarantees. BPF APIs cannot and
> > +   will not ever hard-block a change in the kernel purely for stability
> > +   reasons. In other words, kfuncs have the same stability guarantees as any
> > +   other kernel API, such as those provided by EXPORT_SYMBOL_GPL, though with
> > +   perhaps less burden than EXPORT_SYMBOL_GPL changes thanks to BPF CO-RE.
> > +
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
> 
> How about replacing 'other kfuncs may' with 'usually kfuncs will' to
> re-emphasise that this would be the more common scenario.

Good suggestion, will do.

> 
> > +process. For example, if a new kfunc comes along which provides superior
> > +functionality to an existing kfunc, the existing kfunc may be deprecated for
> > +some period of time to allow users to migrate their BPF programs to use the new
> > +one. Or, if a kfunc has no known users, a decision may be made to remove the
> > +kfunc (without providing an alternative API) after some deprecation period
> > +period so as to provide users with a window to notify the kfunc maintainer if
> 
> Duplicate 'period'.

Ack, good catch.

> 
> > +it turns out that the kfunc is actually being used.
> > +
> > +kfuncs being deprecated (rather than changed or removed with no warning) is
> > +expected to be the common case, and as described in :ref:`KF_deprecated_flag`,
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
> > +   will be removed. At this point, BPF programs calling the kfunc will be
> > +   rejected by the verifier.
> > +
