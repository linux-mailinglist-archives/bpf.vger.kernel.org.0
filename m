Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6556660BC5
	for <lists+bpf@lfdr.de>; Sat,  7 Jan 2023 03:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAGCJs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 21:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAGCJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 21:09:47 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18C63224F;
        Fri,  6 Jan 2023 18:09:45 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id p17so2252890qvn.1;
        Fri, 06 Jan 2023 18:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADJOnrT0to95tRJZIpNulRS9Rqms0FjnaYypouP2xC8=;
        b=PMQwBNt4iZk1UVn+kk6C2Lx+aVWaFHyp+35kScSFSILnX9XBXknauRHxgf5sVlQnNM
         9NsQ9lL2n+M8bpxQ+8+CPfp2hBO2KjgsHQDa67q/U+gLCyikzriZNEovjnbIjhHmrD53
         n/zysA4oQTcs/gGAQQTWyYGF2DaH2lrjsE4Zp3/n4JgQayvOCcq3VXn7SIB3xuX0C4n+
         md8OQTt3LuQaSvGwqPzUKH1LuhVQvqIvQrE08PNh7JbH2qkYKx/qlSF1k7E7bXjQDeFU
         BuIYpVaSJHkgUIf+QFyx/RQ7mtFFf1VETJlyHBQN7mCngaBNSUJvbE3BTMgSDzHTO+SQ
         G30A==
X-Gm-Message-State: AFqh2kr1iJBIK8uXgXtCl+jGp1uXi0pwe3xJKnbU0CkiuNz0jN1FS3ej
        z2FaA2IDxwJcqSkRZQ1/zJY=
X-Google-Smtp-Source: AMrXdXtH++oYwIKBplmbiV7cBYZqZQi7FYNZiFHoFt8wTlWpN2zDpRWCHJW4QMheAVDjwZQ+MCvthA==
X-Received: by 2002:a0c:bf03:0:b0:531:c5a5:6713 with SMTP id m3-20020a0cbf03000000b00531c5a56713mr26572538qvi.13.1673057384571;
        Fri, 06 Jan 2023 18:09:44 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:c7d8])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a034b00b006fa31bf2f3dsm1450503qkm.47.2023.01.06.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 18:09:44 -0800 (PST)
Date:   Fri, 6 Jan 2023 20:09:44 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add __bpf_kfunc tag for marking kernel
 functions as kfuncs
Message-ID: <Y7jUaDD9V556Px3b@maniforge.lan>
References: <20230106195130.1216841-1-void@manifault.com>
 <20230106195130.1216841-2-void@manifault.com>
 <CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 06, 2023 at 05:04:02PM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 6, 2023 at 11:51 AM David Vernet <void@manifault.com> wrote:
> >
> > kfuncs are functions defined in the kernel, which may be invoked by BPF
> > programs. They may or may not also be used as regular kernel functions,
> > implying that they may be static (in which case the compiler could e.g.
> > inline it away), or it could have external linkage, but potentially be
> > elided in an LTO build if a function is observed to never be used, and
> > is stripped from the final kernel binary.
> >
> > We therefore require some convenience macro that kfunc developers can
> > use just add to their kfuncs, and which will prevent all of the above
> > issues from happening. This is in contrast with what we have today,
> > where some kfunc definitions have "noinline", some have "__used", and
> > others are static and have neither.
> >
> > In addition to providing the obvious correctness benefits, having such a
> > macro / tag also provides the following advantages:
> >
> > - Giving an easy and intuitive thing to query for if people are looking
> >   for kfuncs, as Christoph suggested at the kernel maintainers summit
> >   (https://lwn.net/Articles/908464/). This is currently possible by
> >   grepping for BTF_ID_FLAGS(func, but having something more self
> >   describing would be useful as well.
> >
> > - In the future, the tag can be expanded with other useful things such
> >   as the ability to suppress -Wmissing-prototype for the kfuncs rather
> >   than requiring developers to surround the kfunc with __diags to
> >   suppress the warning (this requires compiler support that as far as I
> >   know currently does not exist).
> 
> Have you considered doing bpf_kfunc_start/bpf_kfunc_end ?
> The former would include:
> __diag_push(); __diag_ignore_all(); __used noinline

Yeah that's certainly an option. The downside is that all functions
within scope of the __diag_push() will be affected, and sometimes we mix
kfuncs with non-kfuncs (including e.g. static helper functions that are
used by the kfuncs themselves). -Wmissing-prototypes isn't a big deal,
but __used and noinline are kind of unfortunate. Not a big deal though,
it'll just result in a few extra __bpf_kfuncs_start() and
__bpf_kfuncs_end() sprinkled throughout to avoid them being included.
The upside is of course that we can get rid of the __diag_push()'es we
currently have to prevent -Wmissing-prototypes.

Wdyt? I do like the idea of getting rid of those ugly __diag_push()'es.
And we could always go back to using a __bpf_kfunc macro if and when
compilers ever support using attributes to ignore warnings for specific
functions.

> 
> Also how about using bpf_kfunc on the same line ?
> Then 'git grep' will be easier.

Sure, if we keep this approach I'll do this in v2.
