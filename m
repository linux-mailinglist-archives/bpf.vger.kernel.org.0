Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCC597A1B
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 01:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiHQXUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 19:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHQXUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 19:20:16 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D254A50D8
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 16:20:15 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id i129so26427vke.3
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NNdlV2mmyUS67pXWXGXtYfqWbmO1uqYGNv+NMT5WO4U=;
        b=iDZ1nTE6WoIjlzeD/Sv3EgaLz+e3DE8jFiziXVYLbm28GAz8b/JoS54kJOD9/QE2Vg
         gU/H3I9/uym/p1NFM3GMRHgJpSp+70su+l+nfU8D++tiN9UYDGE7cY4g5nrVdWPJPNKo
         59OCRtv2Sw4Y+5NHqh3msrSb71pjGz573qWhMsuUdb9lkMBD+kNJLUb1ZxSUBR38sDD3
         B4QHe5WsbaHyWttQhgnqVEwJ9J60ADvyQDKc2WSqfSd+PG8rNcmD5ZhyrZjCo5yse1j4
         Wvsqdas2k0vFCNROFb2a5fvrBnOGtpevqiwcj/xbY73scNAwgfZwBo2xPywHtVeMWKo+
         i4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NNdlV2mmyUS67pXWXGXtYfqWbmO1uqYGNv+NMT5WO4U=;
        b=pEeLExHFo2+Mb7XSHNP5wM6OhNiR8YU8wh1vMht52uu2QbFSWsn6qIOuS2vBcnci8+
         5TGr2I2aejbVdGFRYQXHzfv4Kaqk2Uw5LzxVQzJpsHgmnlfAURBy9J5xqEueuTYxe34r
         9x+9ltHxaAY701gbYY0HgA8/nV0uhxj63bI053Ktom7E14XlDe5ZnMlhp4rdC/ZQdQWd
         P6N2NdkOyUffhRbJCx4x9ukHFPrlKlD7LA6+GJDLN5gdrVnSBjOwxD38KRrmjrvq34Sd
         RAYDlrFQO0tE0P9zn0RQfS55RPMRtMpwxYYDP2LR4fiGfuqWD8GnYRaOsDwl6QUeirtk
         PLzw==
X-Gm-Message-State: ACgBeo03p92GP+1w4YF87+wiaIMo/9SDL4UpDMCa9SuSK5FYS/pwyJtC
        cgrBDhcBS9SQqcoicKL1uLg2cno9CJpuFQXd+HvwLQ==
X-Google-Smtp-Source: AA6agR5tLQQbN8/Xtz9Y17XimLBm0Ouu0j8oV0g9paioklZMXV8LqxMOYYzOYsECHVgEInUSC6wtJXPZx5TiI7YJqlY=
X-Received: by 2002:a1f:adc7:0:b0:377:c12:78ef with SMTP id
 w190-20020a1fadc7000000b003770c1278efmr156683vke.19.1660778414543; Wed, 17
 Aug 2022 16:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220816205517.682470-1-zhuyifei@google.com> <20220816205517.682470-2-zhuyifei@google.com>
 <cd514394-7712-ee0d-5c85-c6c7f62cec8e@iogearbox.net>
In-Reply-To: <cd514394-7712-ee0d-5c85-c6c7f62cec8e@iogearbox.net>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Wed, 17 Aug 2022 16:20:03 -0700
Message-ID: <CAA-VZP=wFZqrqDVZEm765GR8SpjcAhAj+1XGJOgDpwDAXjrxpw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf: Add WARN_ON for recursive prog_run invocation
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jason Zhang <jdz@google.com>, Jann Horn <jannh@google.com>,
        mvle@us.ibm.com, zohar@linux.ibm.com, tyxu.uiuc@gmail.com,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 3:30 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/16/22 10:55 PM, YiFei Zhu wrote:
> > Recursive invocation should not happen after commit 86f44fcec22c
> > ("bpf: Disallow bpf programs call prog_run command."), unlike what
> > is suggested in the comment. The only way to I can see this
> > condition trigger is if userspace fetches an fd of a kernel-loaded
> > lskel and attempt to race the kernel to execute that lskel... which
> > also shouldn't happen under normal circumstances.
> >
> > To make this "should never happen" explicit, clarify this in the
> > comment and add a WARN_ON.
> >
> > Fixes: 86f44fcec22c ("bpf: Disallow bpf programs call prog_run command.")
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > ---
> >   kernel/bpf/syscall.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 27760627370d..9cac9402c0bf 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -5119,8 +5119,8 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
> >
> >               run_ctx.bpf_cookie = 0;
> >               run_ctx.saved_run_ctx = NULL;
> > -             if (!__bpf_prog_enter_sleepable(prog, &run_ctx)) {
> > -                     /* recursion detected */
> > +             if (WARN_ON(!__bpf_prog_enter_sleepable(prog, &run_ctx))) {
> > +                     /* recursion detected, should never happen */
>
> Pushed out commit 1/2, thanks! I think this one causes more confusion than value,
> imho, for example in your commit log you state that it could trigger when attempting
> to race, in the comment you state "should never happen". Which one is it? Also, if
> we can recover gracefully in this case, what should the user do with the warn (I
> guess worst case warn_on_once), but still?

I mean, why would anyone attempt to race this... smells more like an
exploitation attempt (though realistically only possible by someone
with root). I see the original comment talks about a BPF SYSCALL prog
invoking, directly or indirectly, itself (hence the "recursion
detected"), and this should be no longer possible at all after
86f44fcec22c.

As for "what should the user do with the warn", the direct result of
this is a module load failure, considering kern_sys_bpf is only used
by kernel lskels AFAIK. However, since the lskel loader has been
executed, the lskel loader may have successfully loaded whatever it
would load anyways, despite the apparent error code from module load,
depending on what stage in the lskel the race happened. I'm not sure
what the user should really do in this circumstance, but I think
something should be logged at least to tell the user something really
wrong is going on. I'm considering BUG_ON in this case but I think
that does more harm than good (since that'd kill the process in the
middle of a module load). Please correct me if I'm wrong.

This is assuming the kernel is working as it is expected to, no memory
corruption shenanigans.

YiFei Zhu

> Thanks,
> Daniel
