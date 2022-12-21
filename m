Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB3F653774
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 21:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiLUUSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 15:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiLUUSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 15:18:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045681EC45
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 12:18:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u7so8457690plq.11
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 12:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cYnyNgioHqW+YyalrsuLbViTa7ofHL8P3cbVInZ4vMw=;
        b=H4AtwDoHmrDbQI3uVNotQSSH3qGcsSLKdHm3f4MxYefK8SWgbFz13cnTykEabP79dj
         52I+/gyeqDHx6UHqrMH9NgncBDx55Q1/+WdLnFaV7zwznuLdUlhIMam/8pBjx4L1vP4/
         B1QFl7yXCJwGGMisgkLN9hGNUSLIkXxoX+f2vF0xXbSgpj6XHvnYKjoT2slOTE+Bhwje
         GzM9UXcT85VTGUrUG1nK+hyenOKKINb6sQ/giYix7g7nR3yPsCJRm/jwcQqIGA2RvKHB
         I/PyjqNCHzADjo+TpEjzFarZLPz804w4gFRDWhScH+/xrKwHOm8JH6ggBt8KtWw9CJ7+
         CeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYnyNgioHqW+YyalrsuLbViTa7ofHL8P3cbVInZ4vMw=;
        b=qBMrR0GLqNoDYlVTo/X4QI1cmIeWGPsu42xhRnXK56aFj6dM/a/CAYmT5VEFmaxTdz
         Xr2AYPw42qa42AGv9/+2dWyg2U6ScDUhPwGv852Fqaiujjxn5FMy4yj52e8B5thrVxKc
         EzIxd7qx1haF6454xsthFuCNd4N0bCpm6IYXWBryAxr4KZzlSnWKAx8/n49gFnWAm2rs
         GdApk6TMatwiq4fnq7vkpkdIagW/8+YxL+Q0DqysjnfLHpWqHi8qlSBw26WfSSzR/+tJ
         yhMYgzhNsShbEj1zJd8pMQoEgFTjDjvIskdmHXoHHR6KwjHzpGHdu6C3lfNpLB3SV4UJ
         rCOA==
X-Gm-Message-State: AFqh2kpxZvCAYQT7mSRg/lHGgwsXbAzpJagQaCxpheBzwLIkOlBDUrJs
        3Fpa1/WmduIUBbwIpTqCBAUIg5LGMEjYe+/VRyT3aQ==
X-Google-Smtp-Source: AMrXdXv718hVhESIvi0jTJ7/DSgHb5rhUOx/aVT4c5nLV5EqfUjMQ+GHFrKhJQZ60vAuH0Z0kK1oR1aozeM3JzV6fEQ=
X-Received: by 2002:a17:902:b20d:b0:191:283d:612e with SMTP id
 t13-20020a170902b20d00b00191283d612emr152231plr.88.1671653894254; Wed, 21 Dec
 2022 12:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
 <CAKH8qBuLhZ+T9fvP=DXeYevdrNofTPpEiQqq2RenBUKVghPmtA@mail.gmail.com> <CANiDSCv0EObZHCL1D1CHBRaNf68Df4Ur9kFgaoGSGH=KYwgOPw@mail.gmail.com>
In-Reply-To: <CANiDSCv0EObZHCL1D1CHBRaNf68Df4Ur9kFgaoGSGH=KYwgOPw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 21 Dec 2022 12:18:02 -0800
Message-ID: <CAKH8qBu6B9VHGiqg152dGhybryKVv8OTavTy3PUpHXvM1_i1mQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove unused field initialization
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Dec 21, 2022 at 12:13 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Stanislav
>
> On Wed, 21 Dec 2022 at 21:10, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Wed, Dec 21, 2022 at 11:55 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> > >
> > > Maxlen is used by standard proc_handlers such as proc_dointvec(), but in this
> > > case we have our own proc_handler. Remove the initialization.
> >
> > Are you sure?
> >
> > bpf_stats_handler
> >   proc_dointvec_minmax
> >     do_proc_dointvec
> >       __do_proc_dointvec
> >         vleft = table->maxlen / sizeof(*i);
>
> I believe do_proc_dointvec is using the value from:
>
> struct ctl_table tmp = {
>   .maxlen=sixeof(val);
> }

Oh, you're right, I've missed that!

Acked-by: Stanislav Fomichev <sdf@google.com>

> >
> > Maybe we should really do the following instead?
> >
> > .maxlen: sizeof(int)
> >
> > ?
> >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > > bpf: Trivial remove of unitialised field.
> > >
> > > I have inspired myself in your code and heritaded this bug :). Fixing this
> > > here so none else makes the same mistake.
> > >
> > > To: Alexei Starovoitov <ast@kernel.org>
> > > To: Daniel Borkmann <daniel@iogearbox.net>
> > > To: John Fastabend <john.fastabend@gmail.com>
> > > To: Andrii Nakryiko <andrii@kernel.org>
> > > To: Martin KaFai Lau <martin.lau@linux.dev>
> > > To: Song Liu <song@kernel.org>
> > > To: Yonghong Song <yhs@fb.com>
> > > To: KP Singh <kpsingh@kernel.org>
> > > To: Stanislav Fomichev <sdf@google.com>
> > > To: Hao Luo <haoluo@google.com>
> > > To: Jiri Olsa <jolsa@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  kernel/bpf/syscall.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 35972afb6850..8e55456bd648 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -5319,7 +5319,6 @@ static struct ctl_table bpf_syscall_table[] = {
> > >         {
> > >                 .procname       = "bpf_stats_enabled",
> > >                 .data           = &bpf_stats_enabled_key.key,
> > > -               .maxlen         = sizeof(bpf_stats_enabled_key),
> > >                 .mode           = 0644,
> > >                 .proc_handler   = bpf_stats_handler,
> > >         },
> > >
> > > ---
> > > base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> > > change-id: 20221221-bpf-syscall-58d1ac3f817a
> > >
> > > Best regards,
> > > --
> > > Ricardo Ribalda <ribalda@chromium.org>
>
>
>
> --
> Ricardo Ribalda
