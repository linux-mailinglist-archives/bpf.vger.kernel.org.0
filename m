Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B93660C8D
	for <lists+bpf@lfdr.de>; Sat,  7 Jan 2023 06:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjAGF1R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 Jan 2023 00:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAGF1Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Jan 2023 00:27:16 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5515530B;
        Fri,  6 Jan 2023 21:27:15 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id bp44so4047348qtb.0;
        Fri, 06 Jan 2023 21:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6PynqUW6l4kS1lyZqH/R8YKL1BlPuz4Tj3BtK4Od38=;
        b=rfBv17Pjz7e2dZYCgBo+07Pejt8JxeObkzEHJDzss7dIQltXvf919JyVI/n+EF1bpW
         tcqj2yS8ZNXGbeyu2uQDzdVmDX+IoFdQfcZvwMCsuheJ5OhPPbxrSkV7D5yjUv9z7HKH
         IdMpMJPPNW2Z5QZln5HX4z4r7P2QJSKz+09zuouGlULdig6FmbaxHN0+uZ9hbRHfsNcI
         5ujs5KUHNhhgtTmdf2PZadgjLp9nTjiXUgwORSitXuLccWuJJK8IBMutIuES4ySh37Ge
         YlPbAc03va/gKkpDFo+q5cXL75D45keV6d01uZS36nmSXgunlpUTcA0WTKNincB7tR41
         iWTw==
X-Gm-Message-State: AFqh2kqSbUwiXFh2vnGK6+blMcewVZsSKaRUha1l1j8QfaL/Xfv59dPG
        SjDjad3FNIasg45hfiG+fV0=
X-Google-Smtp-Source: AMrXdXvgXIUmalVwluvtioyOMwoumtB20yKUMWQY6rWB9kVHyfMj8kT4X4sSvpPZSSYd5d23sNKthw==
X-Received: by 2002:ac8:73c7:0:b0:3a7:f3e7:5149 with SMTP id v7-20020ac873c7000000b003a7f3e75149mr73224654qtp.61.1673069234169;
        Fri, 06 Jan 2023 21:27:14 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:c7d8])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0d8500b006eee3a09ff3sm1688602qkl.69.2023.01.06.21.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 21:27:13 -0800 (PST)
Date:   Fri, 6 Jan 2023 23:27:14 -0600
From:   David Vernet <void@manifault.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH bpf-next 0/3] Annotate kfuncs with new __bpf_kfunc macro
Message-ID: <Y7kCsjBZ/FrsWW/e@maniforge.lan>
References: <20230106195130.1216841-1-void@manifault.com>
 <CAKH8qBuakT6qtY5TZomWEAB=1ZJfdgXYt2A7WVOjtHAYsdbrVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBuakT6qtY5TZomWEAB=1ZJfdgXYt2A7WVOjtHAYsdbrVA@mail.gmail.com>
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

On Fri, Jan 06, 2023 at 04:47:35PM -0800, Stanislav Fomichev wrote:
> On Fri, Jan 6, 2023 at 11:51 AM David Vernet <void@manifault.com> wrote:
> >
> > BPF kfuncs are kernel functions that can be invoked by BPF programs.
> > kfuncs can be kernel functions which are also called elsewhere in the
> > main kernel (such as crash_kexec()), or may be functions that are only
> > meant to be used by BPF programs, such as bpf_task_acquire(), and which
> > are not called from anywhere else in the kernel.
> >
> > While thus far we haven't observed any issues such as kfuncs being
> > elided by the compiler, at some point we could easily run into problems
> > such as the following:
> >
> > - static kernel functions that are also used as kfuncs could be inlined
> >   and/or elided by the compiler.
> > - BPF-specific kfuncs with external linkage may at some point be elided
> >   by the compiler in LTO builds, when it's determined that they aren't
> >   called anywhere.
> >
> > To address this, this patch set introduces a new __bpf_kfunc macro which
> > should be added to all kfuncs, and which will protect kfuncs from such
> > problems. Note that some kfuncs kind of try to do this already by
> > specifying noinline or __used. We are inconsistent in how this is
> > applied. __bpf_kfunc should provide a uniform and more-future-proof way
> > to do this.
> 
> The series looks reasonable to me. Would be nice if we can somehow
> prevent (with a checkpatch?) adding new kfuncs without this new tag,
> but I don't see an easy way.
> I was waiting in case other would like to comment, but if nothing to discuss:

Thanks for the review, Stanislav. I agree that it would be nice to have
some automation to prevent forgetting the tag. I thought about ways to
possibly do it, including playing around with putting the kfuncs into a
separate section for post-processing which we could check against
.BTF_ids, but it felt like a lot of complexity / possibly controversial
changes that I'm hesitant to bring into the patch set which should be
pretty non-controversial otherwise.

With respect to validating the presence of kfunc "tags" (i.e. the
__diag_push() / __diag_pop() we were doing before), we're in the same
state after this patch as we were before, so my preference is to defer
improving that until a later time when we've fried some of the bigger
kfunc fish. Does that sound ok?

> Acked-by: Stanislav Fomichev <sdf@google.com>

Thanks! FYI, I'm planning on sending a v2 with Alexei's suggestion [0]

[0]: https://lore.kernel.org/all/CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com/

I'll go ahead and preemptively leave off your Acked-by for that, as the
patches will have changed enough that it probably warrants another
read through.

- David

> 
> 
> 
> 
> > David Vernet (3):
> >   bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
> >   bpf: Document usage of the new __bpf_kfunc macro
> >   bpf: Add __bpf_kfunc tag to all kfuncs
> >
> >  Documentation/bpf/kfuncs.rst                  | 18 +++++
> >  Documentation/conf.py                         |  3 +
> >  include/linux/btf.h                           |  9 +++
> >  kernel/bpf/helpers.c                          | 19 +++++
> >  kernel/cgroup/rstat.c                         |  2 +
> >  kernel/kexec_core.c                           |  2 +
> >  kernel/trace/bpf_trace.c                      |  4 +
> >  net/bpf/test_run.c                            | 76 ++++++++++++-------
> >  net/ipv4/tcp_bbr.c                            |  8 ++
> >  net/ipv4/tcp_cong.c                           |  5 ++
> >  net/ipv4/tcp_cubic.c                          |  6 ++
> >  net/ipv4/tcp_dctcp.c                          |  6 ++
> >  net/netfilter/nf_conntrack_bpf.c              | 14 +++-
> >  net/netfilter/nf_nat_bpf.c                    |  1 +
> >  net/xfrm/xfrm_interface_bpf.c                 |  4 +-
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +-
> >  16 files changed, 146 insertions(+), 33 deletions(-)
> >
> > --
> > 2.39.0
> >
