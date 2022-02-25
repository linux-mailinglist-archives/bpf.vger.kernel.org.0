Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA64C3CEA
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 05:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiBYEKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 23:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiBYEKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 23:10:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5881D1E3F1
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1351B82A1D
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 04:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38DAC340E8
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 04:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645762213;
        bh=Vn3O9qUJt2fH+PCPGoGMLPxMHSNcgSuMvTXM6RrPFLU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oeC1yjkl9DEygmsvhXL9Zxr+oZOyK9zstX6x724BLKx1C2tTyYKLP4y2boh9Q4nUz
         UWjr9J2H9A92JRQpYGHphqTxpJqe9670EgBcn2RKneY/boBISTEFY950AQTpMuCCnK
         TBf63HfXu3RK7RK30jSwz+lQq0WHJy6Uy4378sQ11JBzfKmXm1A6OzSoiEiWLPXVld
         aUtpYRWGqgsJ1n+m5tVhybLO0aY+PHVs769ErMaprXmLRvRebLyPC3S+CmLFGGDRxX
         fW3akg1q7fWUfE8HXFgtBwkiW19/0LDonTD2PMse6v/VxGbBqV9aNY5KBTmTUUWcHt
         VYvjLOOei/Ilg==
Received: by mail-yb1-f176.google.com with SMTP id bt13so3542748ybb.2
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:10:13 -0800 (PST)
X-Gm-Message-State: AOAM530FQ8yBx/otj1a483vnw6CBAjUPi0NP4US3uEghGYesAARRXqdG
        p8a4/kWl9J9Lu/ktkcHcKizmFNjWIUlyX9ENQ/Q=
X-Google-Smtp-Source: ABdhPJyAzxxm2wJNRDqtBjm1ifoyIXF57a0vDNXvQ5YyOMs6epHAsHS4CyF/yMM8qwPS8i1HZBxhoJH0NcN/2BxmUDI=
X-Received: by 2002:a25:da87:0:b0:611:aa55:c37c with SMTP id
 n129-20020a25da87000000b00611aa55c37cmr5394135ybf.9.1645762212691; Thu, 24
 Feb 2022 20:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20220224214928.826717-1-fallentree@fb.com> <7bb7006a-9f2e-a41e-7fb9-e14438536b83@fb.com>
In-Reply-To: <7bb7006a-9f2e-a41e-7fb9-e14438536b83@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Feb 2022 20:10:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6aQv3RL2MHF7TZ7kv-8zQgZamqO2NGCtsXLZ5ZPWqx9w@mail.gmail.com>
Message-ID: <CAPhsuW6aQv3RL2MHF7TZ7kv-8zQgZamqO2NGCtsXLZ5ZPWqx9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
To:     Yonghong Song <yhs@fb.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        andrii@kernddddel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 24, 2022 at 8:04 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/24/22 1:49 PM, Yucong Sun wrote:
> > In a previous commit (1), BPF preload process was switched from user
> > mode process to use in-kernel light skeleton instead. However, in the
> > kernel context the available fd starts from 0, instead of normally 3 for
> > user mode process. and the preload process leaked two FDs, taking over
> > FD 0 and 1. This  which later caused issues when kernel trys to setup
> > stdin/stdout/stderr for init process, assuming fd 0,1,2 is available.
> >
> > As seen here:
> >
> > Before fix:
> > ls -lah /proc/1/fd/*
> >
> > lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
> > lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
> > lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
> > lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
> > lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console
> >
> > After Fix / Normal:
> >
> > ls -lah /proc/1/fd/*
> >
> > lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/0 -> /dev/console
> > lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/1 -> /dev/console
> > lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/2 -> /dev/console
> >
> > In this patch:
> >    - skel_closenz was changed to skel_closenez to correctly handle
> >      FD=0 case.
> >    - various places detecting FD > 0 was changed to FD >= 0.
> >    - Call iterators_skel__detach() funciton to release FDs after links
> >    are obtained.
> >
> > 1: https://github.com/kernel-patches/bpf/commit/cb80ddc67152e72f28ff6ea8517acdf875d7381d
> >
> > Signed-off-by: Yucong Sun <fallentree@fb.com>
> > ---
> >   kernel/bpf/preload/bpf_preload_kern.c          |  1 +
> >   kernel/bpf/preload/iterators/iterators.lskel.h | 16 +++++++++-------
> >   tools/bpf/bpftool/gen.c                        |  9 +++++----
> >   tools/lib/bpf/skel_internal.h                  |  8 ++++----
> >   4 files changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> > index 30207c048d36..c6bb1e72e0f1 100644
> > --- a/kernel/bpf/preload/bpf_preload_kern.c
> > +++ b/kernel/bpf/preload/bpf_preload_kern.c
> > @@ -54,6 +54,7 @@ static int load_skel(void)
> >               err = PTR_ERR(progs_link);
> >               goto out;
> >       }
> > +     iterators_bpf__detach(skel);
>
> In fini, we have:
>
> static void __exit fini(void)
> {
>          bpf_preload_ops = NULL;
>          free_links_and_skel();
> }
>
> static void free_links_and_skel(void)
> {
>          if (!IS_ERR_OR_NULL(maps_link))
>                  bpf_link_put(maps_link);
>          if (!IS_ERR_OR_NULL(progs_link))
>                  bpf_link_put(progs_link);
>          iterators_bpf__destroy(skel);
> }
>
> Since you did iterators_bpf__detach(skel) in load_skel(),
> in fini(), we don't need iterators_bpf__destroy(skel), right?

iterators_bpf__destroy() still cleans up some other things, so
I guess we should just keep it?

static void
iterators_bpf__destroy(struct iterators_bpf *skel)
{
        if (!skel)
                return;
        iterators_bpf__detach(skel);
        skel_closenz(skel->progs.dump_bpf_map.prog_fd);
        skel_closenz(skel->progs.dump_bpf_prog.prog_fd);
        skel_free_map_data(skel->rodata, skel->maps.rodata.initial_value, 4096);
        skel_closenz(skel->maps.rodata.map_fd);
        skel_free(skel);
}
