Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1A58E457
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 03:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiHJBJP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 21:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiHJBI5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 21:08:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B165804A1
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 18:08:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gk3so25073137ejb.8
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 18:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1l08C67r4Lcofi01dbB4WeINslrb2hAcV/5t07rlDec=;
        b=kW+cnIsKWTSxKX+AKMk9eMpQ4ZsXqY7z4wB/Pls7P01IUqjA3uTRbXaqnN8U9RNIC8
         VGcmr9UL123XszS338PnDwq8v7QSe2O+zLcFUV1zm179y60xl7M7bls6qMS3rA4bufnQ
         iB2SoDKdEtlWOKdtrlqZI5i0Uoj82aH2i3yjcGWpSSeUx/G+QM2KcDpWUuPyCw6gX9+1
         SfSlBUDARxt5cEoFv7g+c2ixp1ybAKAFa2ph0s8qryhk132zvQMcqE7thnVFIBaEbNgk
         kna5KNFnmktU59JlhBx5Ulweergx8Z9UNhNioIPGqd5oV2U5LiJUN86j1xkIf0/C3e8U
         DNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1l08C67r4Lcofi01dbB4WeINslrb2hAcV/5t07rlDec=;
        b=xp59HGl8Q4XhBUHV2cupXi8JBwsrePFFK297w6VinQVSeLn2MJ1yUYfZ5lsuq8Jfi0
         5rWhBT4+Wf9tSKI7e21XtKgdrtOWGkmZLrVaXBykqRj5+hixv+13eFDXoGHSsIV3E52L
         LHhO91445m8YWMRvSiGxfVi3tiAchzl6c2xbKiBGfNvQFV363xGO+g2Pu24at7+XiKkw
         OGkYMvMTRT6xiWojeknqXYHYsWdlzNdthZrPAJp1W8m4ofnhKP6v1Vnuj1R7l23f5uYt
         BofzENbHUH638rlI50tFGnK7DzVeY/YFwJCZmPzpbWiITheg6lPL0Z4CtUaSBzJDSPom
         vArg==
X-Gm-Message-State: ACgBeo3JuLi0J9CLnzoC46bXMBy86YOvpGZHFuEXu9QPCiRIfLnzQl0m
        AeTfAKEhFAufybl/kUKJbcurP7P/o6MVPXTeIvw=
X-Google-Smtp-Source: AA6agR43Q5bh0kfMHfoLPtjGBrOmE9W6RNFimyC5ok9xDSlRvpsKmbaNP23y6NmIwgS8QhxM7UwIbwUxIodIUGMFjxU=
X-Received: by 2002:a17:907:e8d:b0:730:a4e8:27ed with SMTP id
 ho13-20020a1709070e8d00b00730a4e827edmr17851504ejc.58.1660093729645; Tue, 09
 Aug 2022 18:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220809195429.1043220-1-kuifeng@fb.com> <20220809195429.1043220-2-kuifeng@fb.com>
 <CAADnVQLjHpfFQDn_1mXj7+o6E8Dsmatr0jeozPAk5rV8hcLWfg@mail.gmail.com> <a667947bbd9da453017e2eb4b53b6523bdb110be.camel@fb.com>
In-Reply-To: <a667947bbd9da453017e2eb4b53b6523bdb110be.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 18:08:38 -0700
Message-ID: <CAADnVQLKExnPXWaCEuvTME6=VLUaQA52t_9NFTsXyrPj+213_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Aug 9, 2022 at 3:35 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Tue, 2022-08-09 at 15:12 -0700, Alexei Starovoitov wrote:
> > On Tue, Aug 9, 2022 at 12:54 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
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
> > >  include/linux/bpf.h            |   8 ++
> > >  include/uapi/linux/bpf.h       |  36 +++++++++
> > >  kernel/bpf/task_iter.c         | 134 +++++++++++++++++++++++++++--
> > > ----
> > >  tools/include/uapi/linux/bpf.h |  36 +++++++++
> > >  4 files changed, 190 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 11950029284f..bef81324e5f1 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1718,6 +1718,14 @@ int bpf_obj_get_user(const char __user
> > > *pathname, int flags);
> > >
> > >  struct bpf_iter_aux_info {
> > >         struct bpf_map *map;
> > > +       struct {
> > > +               enum bpf_iter_task_type type;
> > > +               union {
> > > +                       u32 tid;
> > > +                       u32 tgid;
> > > +                       u32 pid_fd;
> > > +               };
> > > +       } task;
> > >  };
> > >
> > >  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index ffcbf79a556b..3d0b9e34089f 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -87,10 +87,46 @@ struct bpf_cgroup_storage_key {
> > >         __u32   attach_type;            /* program attach type
> > > (enum bpf_attach_type) */
> > >  };
> > >
> > > +/*
> > > + * The task type of iterators.
> > > + *
> > > + * For BPF task iterators, they can be parameterized with various
> > > + * parameters to visit only some of tasks.
> > > + *
> > > + * BPF_TASK_ITER_ALL (default)
> > > + *     Iterate over resources of every task.
> > > + *
> > > + * BPF_TASK_ITER_TID
> > > + *     Iterate over resources of a task/tid.
> > > + *
> > > + * BPF_TASK_ITER_TGID
> > > + *     Iterate over reosurces of evevry task of a process / task
> > > group.
> > > + *
> > > + * BPF_TASK_ITER_PIDFD
> > > + *     Iterate over resources of every task of a process /task
> > > group specified by a pidfd.
> > > + */
> > > +enum bpf_iter_task_type {
> > > +       BPF_TASK_ITER_ALL = 0,
> > > +       BPF_TASK_ITER_TID,
> > > +       BPF_TASK_ITER_TGID,
> > > +       BPF_TASK_ITER_PIDFD,
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
> > > +               enum bpf_iter_task_type type;
> > > +               union {
> > > +                       __u32 tid;
> > > +                       __u32 tgid;
> > > +                       __u32 pid_fd;
> > > +               };
> >
> > Sorry I'm late to this discussion, but
> > with enum and with union we kinda tell
> > the kernel the same information twice.
> > Here is how the selftest looks:
> > +       linfo.task.tid = getpid();
> > +       linfo.task.type = BPF_TASK_ITER_TID;
> >
> > first line -> use tid.
> > second line -> yeah. I really meant the tid.
> >
> > Instead of union and type can we do:
> > > +                       __u32 tid;
> > > +                       __u32 tgid;
> > > +                       __u32 pid_fd;
> >
> > as 3 separate fields?
> > The kernel would have to check that only one
> > of them is set.
> >
> > I could have missed an earlier discussion on this subj.
>
> We may have other parameter types later, for example, cgroups.
> Unfortunately, we don't have tagged enum or tagged union, like what
> Rust or Haskell has, in C.  A separated 'type' field would be easier
> and clear to distinguish them.  With 3 separated fields, people may
> wonder if they can be set them all, or just one of them, in my opinion.
> With an union, people should know only one of them should be set.

What stops us adding new fields to the end in such a case?
Some combinations will not be meaningful and the kernel
would have to check and error regardless.
Imagine extending union:
struct {
  enum bpf_iter_task_type type;
  union {
     struct {
        __u32 tid;
        __u64 something_else;
     };
     __u32 tgid;
     __u32 pid_fd;
  };
};

and now we're suddenly hitting the same issue we discussed
with struct bpf_link_info in the other thread due to alignment
increasing from 4 to 8 bytes.
We might even need bpf_iter_link_info _v2.

If 'something_else' is u32 the kernel still needs to check
that it's zero in the tgid and pid_fd cases.
If we're extending fields we can add a comment:
struct {
  __u32 tid;
  __u32 tgid;
  __u32 pid_fd;
  __u32 something_else; /* useful in combination with tid */
};
and it's obvious what is used with what.

It still feels that 3 different fields are easier to use.
