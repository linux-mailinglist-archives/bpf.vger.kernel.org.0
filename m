Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8758DA70
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbiHIOjB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiHIOjA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 10:39:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EB419C04;
        Tue,  9 Aug 2022 07:38:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id uj29so22704084ejc.0;
        Tue, 09 Aug 2022 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZWzu7y9cZ515G8p3adab/2sdQH4tG+7zriZfn5G1uM=;
        b=JqvgdF3PLdiGIlyld/3xKQfIV0pyoOxPGZ47eRx/jY2qe0pDbO9E0mRlpjDQvtO5qb
         ldoUevusjaC85SdjMTKL//GcZsPv2QN7HdKN+k1Rx4egd6YO9AWza7ufYt/Zf9d0NDXJ
         Uzz7JU2GmVyVJJVQGDkAKzkU28y2B/Ldb8xRhVTHQlohSjHZyoYezjFhPGdq4nKEFkhs
         gpD6T6KaEpTE3bAik8AWRF3l8UcSUXZ55rSMHNLjH5IjkjYup5G7DJRlw/kN2WAhWRgM
         vyvrdHd3DfRuID6DIGqadtMt62wATkGbXuxQ8E+RoFlyjjf25clBqeZtZmGaVRWYpdGK
         RBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZWzu7y9cZ515G8p3adab/2sdQH4tG+7zriZfn5G1uM=;
        b=EClFY7/YT4FMG8xU+hrDV6buc4thFXW5uzakiuYUtScmImeP41i70O0RaGAxxi6Akf
         axqQPalfl+xOT3MjF3TvNxiELzoNFpIzd7tp2UnuHVam4FQRoJt0PgQMHMkSstoDWMbf
         t8rWaPE1zOhbBZF+gunGXZ6SLr6K//RggV0G9pgJLnC7DP18Mz81FKm37Zu9ZXkH6JA1
         LmW1V85S+5r1cRTbfwQLitEP5J985La+3duBCsX1Kd1ZaB6/b/YC+sevbWHH0umzTd7D
         HKiGwt5M5tXtxjokXmCIaakbSTQyNf7nuw8oLN01OQD/Ez3aOGL6yOsPbhnWoTQ5VOqS
         ofLg==
X-Gm-Message-State: ACgBeo2fUhqiwLgCa2Wf/8VOCDTX0K6W5xP6+1RP736UF2KRiVxfjTXp
        8KcADS61/hVRXrxn1ZtQpLWGADTpQWKB5EKN7A8=
X-Google-Smtp-Source: AA6agR74zaY6yPM1wjRSufdOHpy3nlQuDeT0UJtBqbtC7ZHI4IpyZUm2vW9DFIC1NZJ9M/OJgl8qHTxHP+Pc+94lwAk=
X-Received: by 2002:a17:907:e8d:b0:730:a4e8:27ed with SMTP id
 ho13-20020a1709070e8d00b00730a4e827edmr16528349ejc.58.1660055938238; Tue, 09
 Aug 2022 07:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220803134821.425334-1-lee@kernel.org> <CAADnVQ+X_B4LC6CtYM1PXPA4BBprWLj5Qip--Eeu32Zti==Ydw@mail.gmail.com>
 <YvIDmku4us2SSBKu@google.com>
In-Reply-To: <YvIDmku4us2SSBKu@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 07:38:46 -0700
Message-ID: <CAADnVQ+5eq3qQTgHH6nDdVM-n1i4TWkZ35Ou8TDMi3MqGzm63w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of find_get_pid()
To:     Lee Jones <lee@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 11:50 PM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 04 Aug 2022, Alexei Starovoitov wrote:
>
> > On Wed, Aug 3, 2022 at 6:48 AM Lee Jones <lee@kernel.org> wrote:
> > >
> > > The documentation for find_pid() clearly states:
> > >
> > >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> > >
> > > Presently we do neither.
> > >
> > > Let's use find_get_pid() which searches for the vpid, then takes a
> > > reference to it preventing early free, all within the safety of
> > > rcu_read_lock().  Once we have our reference we can safely make use of
> > > it up until the point it is put.
> > >
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yhs@fb.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@google.com>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >
> > > v1 => v2:
> > >   * Commit log update - no code differences
> > >
> > >  kernel/bpf/syscall.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 83c7136c5788d..c20cff30581c4 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > >         const struct perf_event *event;
> > >         struct task_struct *task;
> > >         struct file *file;
> > > +       struct pid *ppid;
> > >         int err;
> > >
> > >         if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> > > @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > >         if (attr->task_fd_query.flags != 0)
> > >                 return -EINVAL;
> > >
> > > -       task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> > > +       ppid = find_get_pid(pid);
> > > +       task = get_pid_task(ppid, PIDTYPE_PID);
> > > +       put_pid(ppid);
> >
> > rcu_read_lock/unlock around this line
> > would be a cheaper and faster alternative than pid's
> > refcount inc/dec.
>
> This was already discussed here:
>
> https://lore.kernel.org/all/YtsFT1yFtb7UW2Xu@krava/

Since several people thought about rcu_read_lock instead of your
approach it means that it's preferred.
Sooner or later somebody will send a patch to optimize
refcnt into rcu_read_lock.
So let's avoid the churn and do it now.
