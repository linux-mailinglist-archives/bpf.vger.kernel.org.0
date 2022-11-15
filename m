Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58E62AF75
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 00:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKOXfN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 18:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKOXfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 18:35:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722326566
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 15:35:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z18so24190307edb.9
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2XhsL+TLutl612sfb5ufCkLIxRN1AbVScbFBJ4V7q8=;
        b=BRfWRF3rU0MaPgY8cSOs4mck69LClvtKGSjpqJWz1WsJEb7UJcJ5IAERXVxXg+xbM/
         6m3wqcScFL64qLp/+yxkQ7FOIrDAHMvJy9BmfQKiPEOqyVUa5p/KJaN+fbAH8RNy9i/N
         utHxQDfYi5vMyq7tFPcqSWyuxs619/R7CKXa3Zo9OkMRJUfMdaVGd8tte14VA4A/eUrO
         HPQ0z+sdjgz4VC1GTCfafpJtLIGzNgQ05+KyUz+KMehb0orZeBAPuGnh5ThRa5rrJcHj
         rG4xXBQWCQNrsToXPpIZyiHIPSVKi01QwG4Dlh2QixQ6t+QG9wd8K76TrMF7uksZQ5sp
         ivOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2XhsL+TLutl612sfb5ufCkLIxRN1AbVScbFBJ4V7q8=;
        b=4t/Nbmpv7Gs9+3o7oELuwwdL3fUGoV+O2ODSfCUwsWm2XaHfAf7wVPL72OZvDFXh7N
         mj5hE1hKdEXIlF7dTSI9rzXw6s/vAGHiQH0qq9MknmfsPcia7Mybam89WxyeyomYWCym
         8qvZlxjJGcG3y5bOQtE3K0s8dF7Fg1R/KLUXXBLrFwv5QF76NrfYOAHcJvTzekoMmXvb
         RkE8OmAaNzM6Rjsgktckd93uWbIdSI5+vMXJwGm5x8rbyaJkOF80PwMe4ptkjaE2JIPk
         zqC7iGdXzwjsHDzL2+HHRHgyV50kM/I5N6ZfpYi9tgyu+thjOoGZCWFslD6OxkXB0s+N
         /lMA==
X-Gm-Message-State: ANoB5pm29TOQZrsTDH0R7qV71k2bUsU6cXwhZMAgBeHz5AoCwNCkbdKJ
        kGhInyyG82HfIbhYJoK34P+x95coJiTCrbiqPIg=
X-Google-Smtp-Source: AA0mqf5BPSxJjNaoUhK3DiqzMVXSrz2Ap0pEUTbdP00QAesXoquIS99T4I7J043/AjeI3aJUY7w4imX8xU7Sj+eZ+y4=
X-Received: by 2002:aa7:de92:0:b0:467:8fb6:d11 with SMTP id
 j18-20020aa7de92000000b004678fb60d11mr13954848edv.421.1668555306653; Tue, 15
 Nov 2022 15:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20221115095043.1249776-1-jolsa@kernel.org> <4d91b1d3-3ffc-11f9-50a6-bfb503e4b3cd@iogearbox.net>
 <Y3QgJMsknnAvvYqU@krava>
In-Reply-To: <Y3QgJMsknnAvvYqU@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Nov 2022 15:34:55 -0800
Message-ID: <CAADnVQLz4BWZM+74mjxeHpr=1-Nx3hnVts-4kxJ-UqtoD54yFw@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: Fix perf bpf event and audit prog id logging
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 3:26 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Nov 15, 2022 at 01:49:54PM +0100, Daniel Borkmann wrote:
> > On 11/15/22 10:50 AM, Jiri Olsa wrote:
> > > hi,
> > > perf_event_bpf_event and bpf_audit_prog calls currently report zero
> > > program id for unload path.
> > >
> > > It's because of the [1] change moved those audit calls into work queue
> > > and they are executed after the id is zeroed in bpf_prog_free_id.
> > >
> > > I originally made a change that added 'id_audit' field to struct
> > > bpf_prog, which would be initialized as id, untouched and used
> > > in audit callbacks.
> > >
> > > Then I realized we might actually not need to zero prog->aux->id
> > > in bpf_prog_free_id. It seems to be called just once on release
> > > paths. Tests seems ok with that.
> > >
> > > thoughts?
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > [1] d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> > > ---
> > >   kernel/bpf/syscall.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index fdbae52f463f..426529355c29 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -1991,7 +1991,6 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
> > >             __acquire(&prog_idr_lock);
> > >     idr_remove(&prog_idr, prog->aux->id);
> > > -   prog->aux->id = 0;
> >
> > This would trigger a race when offloaded progs are used, see also ad8ad79f4f60 ("bpf:
> > offload: free program id when device disappears"). __bpf_prog_offload_destroy() calls
> > it, and my read is that later bpf_prog_free_id() then hits the early !prog->aux->id
> > return path. Is there a reason for irq context to not defer the bpf_prog_free_id()?
>
> there's comment saying:
>   /* bpf_prog_free_id() must be called first */
>
> it was added together with the BPF_(PROG|MAP)_GET_NEXT_ID api:
>   34ad5580f8f9 bpf: Add BPF_(PROG|MAP)_GET_NEXT_ID command
>
> Martin, any idea?
>
> while looking on this I noticed we can remove the do_idr_lock argument
> (patch below) because it's always true and I think we need to upgrade
> all the prog_idr_lock locks to spin_lock_irqsave because bpf_prog_put
> could be called from irq context because of d809e134be7a

before we dive into rabbit hole let's understand
the severity of
"perf_event_bpf_event and bpf_audit_prog calls currently report zero
 program id for unload path"

and why we cannot leave it as-is.
