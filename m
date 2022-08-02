Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D758835A
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 23:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiHBVTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 17:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHBVTw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 17:19:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EACE3F
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 14:19:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e13so248789edj.12
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5eKmfeI5yvVu26IEzte6nhWK+/PzdEbCd6gfvfaJLhk=;
        b=WU6IaecZiymfx+DMSsDwQkoFs3I+3t/9tzBTA2JIkq+XguaQHNzZt+NNKFLyHdPfFI
         aN4djd22bdsCsiJQo6zBFh8GbYc9sFib4Wyn3d9DGjObusjBWNFODdrq7E4WYaJuVhBA
         Ff+rZbwQFd4Jm1a1K5q/0mILImXXzSN/zu5nL+xw9kON5kB/5IvVc8CIfCWrYfrDcuvS
         bYu3Hb62qJJVe16mGlO7UfQy94WcW0rfgD8vATmcrdp9OTL7u3R4Tp9f0yZgC2Z6c908
         NPUmya/3CneGkS/R05h2jRFLklChW6gg/w0wHG0EIpoN7gwa7MhxbzWHLXFISw6c6b8t
         s6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5eKmfeI5yvVu26IEzte6nhWK+/PzdEbCd6gfvfaJLhk=;
        b=BOwlOqTn7PmteeVGpJ/WI5Att/KaMhdV/YeaZGVxJJsx/xXBeN6T7yfD96h61OrG8X
         m2wbK14cmPhNOOO+Xb4fb+Z1+QW5z1gz0poNCNvKo66BDIE+9cCIy3C9W38cQJtj7xQA
         9k5qhyXaU0hoHNeHgI3uhOSU2M2kpJC0aXBbjaB8YwG4Nb9fVyyqzIKdVSHNS532olN6
         DItaTfVWpwBsVsiRR47gEaCUp/5M/WMuduHgBSSnae+1AAByIkMWy9qQlJ6Vv+33O+sq
         ajR2ugjJD+L17+TfITiyTh1YCom4J6rD1nSeFBetTHo2Mkt87p8XQkS1Mz0NyChdmXtM
         MTQA==
X-Gm-Message-State: ACgBeo1ywH2zygapXLzbJ7NyG7uclSYvl+cU8SaKrCsBBmrASCQEyBCY
        S3AkWM65JAIxV9ATHrsXIEBjWJ2DKQDmJa0DE+RkL2uY
X-Google-Smtp-Source: AA6agR5wHQPdB6nuoIs8CMzPGoKi1dfN3fdLYSlNL6RDmb4JSQel/lsHxUtCYkQBK381T2qwyK1vziJWaeSB9aFuhK4=
X-Received: by 2002:a50:ed82:0:b0:43d:5334:9d19 with SMTP id
 h2-20020a50ed82000000b0043d53349d19mr16724390edr.232.1659475190331; Tue, 02
 Aug 2022 14:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220801232649.2306614-1-kuifeng@fb.com> <20220801232649.2306614-2-kuifeng@fb.com>
 <CAADnVQJp3GDjFw9H8nez4z8zSYME3h_fL3cuhiVSOrMc11T5KA@mail.gmail.com> <abd48496db08b3f50df163267f37bb96616f355e.camel@fb.com>
In-Reply-To: <abd48496db08b3f50df163267f37bb96616f355e.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 14:19:38 -0700
Message-ID: <CAEf4BzZ=+CR=Y48_YpUpBZb93WrwdKdALu=1AnfJLi-5Htad3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Aug 2, 2022 at 9:48 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-08-01 at 18:49 -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 1, 2022 at 4:27 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Allow creating an iterator that loops through resources of one
> > > task/thread.
> > >
> > > People could only create iterators to loop through all resources of
> > > files, vma, and tasks in the system, even though they were
> > > interested
> > > in only the resources of a specific task or process.  Passing the
> > > additional parameters, people can now create an iterator to go
> > > through all resources or only the resources of a task.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  include/linux/bpf.h            |  4 ++
> > >  include/uapi/linux/bpf.h       | 23 +++++++++
> > >  kernel/bpf/task_iter.c         | 93 ++++++++++++++++++++++++++----
> > > ----
> > >  tools/include/uapi/linux/bpf.h | 23 +++++++++
> > >  4 files changed, 121 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 11950029284f..3c26dbfc9cef 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user
> > > *pathname, int flags);
> > >
> > >  struct bpf_iter_aux_info {
> > >         struct bpf_map *map;
> > > +       struct {
> > > +               u32     tid;
> > > +               u8      type;
> > > +       } task;
> > >  };
> > >
> > >  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index ffcbf79a556b..ed5ba501609f 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -87,10 +87,33 @@ struct bpf_cgroup_storage_key {
> > >         __u32   attach_type;            /* program attach type
> > > (enum bpf_attach_type) */
> > >  };
> > >
> > > +enum bpf_task_iter_type {
> > > +       BPF_TASK_ITER_ALL = 0,
> > > +       BPF_TASK_ITER_TID,
> > > +};
> > > +
> > >  union bpf_iter_link_info {
> > >         struct {
> > >                 __u32   map_fd;
> > >         } map;
> > > +       /*
> > > +        * Parameters of task iterators.
> > > +        */
> > > +       struct {
> > > +               __u32   pid_fd;
> > > +               /*
> > > +                * The type of the iterator.
> > > +                *
> > > +                * It can be one of enum bpf_task_iter_type.
> > > +                *
> > > +                * BPF_TASK_ITER_ALL (default)
> > > +                *      The iterator iterates over resources of
> > > everyprocess.
> > > +                *
> > > +                * BPF_TASK_ITER_TID
> > > +                *      You should also set *pid_fd* to iterate
> > > over one task.
> > > +                */
> > > +               __u8    type;   /* BPF_TASK_ITER_* */
> >
> > __u8 might be a pain for future extensibility.
>
> Do you mean the problem caused by padding?

Not Alexei, but I agree that there is no reason to try to save a few
bytes here. Let's use u32 or just plain 32-bit enum. Please also put
it in front of pid_fd (first field in this substruct), so that it's
easier to extend this with more information about "iteration target"
(e.g., if we later want to iterate tasks within cgroup, we might end
up specifying cgroup_id, which I believe is 64-bit, so it would be
nice to be able to just do a union across {pid_fd, pid, cgroup_fd,
cgroup_id}.

>
> > big vs little endian will be another potential issue.
>
> Do we need binary compatible for different platforms?
> I don't get the point of endian.  Could you explain it more?
>
> >
> > Maybe use enum bpf_task_iter_type type; here and
> > move the comment to enum def ?
> > Or rename it to '__u32 flags;' ?
>
