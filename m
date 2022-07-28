Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957EA583A96
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 10:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiG1Is2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiG1Is1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 04:48:27 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE25245D
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 01:48:27 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p5so659752ilg.9
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bCAizqjoNI8glsY+oMrjLNupid9MZT6o0HMnTV/mBs=;
        b=d/Rosm9Z14KJebtjNaGJ1TH1IwDMGif+9y8L8witEGBeIsef2SzE5RRd/3kEZPxSYY
         2hrFP095PDmXKoThVaQmCjuuV3W1Uvgo7k2/0at7fII7BUNMasfWElOcxix/ZwEGWdRo
         6bp5EaBxzasWwW63XOhy3ZsD+qN9y1Wu9DeyZi23/UYTr6E6X+tuGfuExjOymmJUWR06
         Ts3bOZazSPGdnyuQbLd6olDY4Lxw6SZAjT5pHircECRm1doJwvDtINyVMQRYZINQevlu
         aytRrNVAk43z8KB+0HM+v3uOdVhu9fkFPLilAOZnZWmRoYkpD7FkCDa4gtc2EMQIcH5h
         twmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bCAizqjoNI8glsY+oMrjLNupid9MZT6o0HMnTV/mBs=;
        b=nB98x4O98VcOjLjxtH5nSh4ZvF1kNf7Y9q1LYqP3ukkH8ikPGxY9YJ9XsBhRteiFR7
         0pyr5PnwWYjs9pGktDNzY/Z4bZtHRsGDr2fElp/KclDxdCCmPfM0zsTfaTQPLyNF3MoX
         skOPjZu2TpHjTJBzL2Q4SHiXBZ7DcfvSgma1vLkqUUFkHudX9Gtq7upbhWT4XjXypRr+
         nE9n5PtZiFrb5Za8ljotox4fZyQjy2sp+p8lVnh/nlPT/npnfREp1QgGUqFqwJRbYchV
         RzIoEuE86wbWLgX31jPnzYBzQH0MAHyPlk84Rebi1KBQquqnNDn9pQX2dj2hTSqyoNqL
         oWlA==
X-Gm-Message-State: AJIora883m+tlZPVq14F6oyNDhcQQDFi/PPRn9m0oTl7/go0eGmg71ho
        NxXlTvDdzXw9kmPgir89dgVCKHHdjbwJVj5FXW8=
X-Google-Smtp-Source: AGRyM1uosWadvZk7nGEP0S17XjxIFH5OfshZncnE7HeP5S1llvJBpln/Tx+mdlU1xk+tqK2Cey1p+V/rqeDEaFe61Eg=
X-Received: by 2002:a05:6e02:2188:b0:2dd:f749:512d with SMTP id
 j8-20020a056e02218800b002ddf749512dmr683345ila.216.1658998106351; Thu, 28 Jul
 2022 01:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220726051713.840431-1-kuifeng@fb.com> <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava> <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com> <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
In-Reply-To: <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 28 Jul 2022 10:47:48 +0200
Message-ID: <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "brauner@kernel.org" <brauner@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
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

On Thu, 28 Jul 2022 at 07:25, Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Wed, 2022-07-27 at 10:19 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 27 Jul 2022 at 09:01, Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > On Tue, 2022-07-26 at 14:13 +0200, Jiri Olsa wrote:
> > > > On Mon, Jul 25, 2022 at 10:17:11PM -0700, Kui-Feng Lee wrote:
> > > > > Allow creating an iterator that loops through resources of one
> > > > > task/thread.
> > > > >
> > > > > People could only create iterators to loop through all
> > > > > resources of
> > > > > files, vma, and tasks in the system, even though they were
> > > > > interested
> > > > > in only the resources of a specific task or process.  Passing
> > > > > the
> > > > > additional parameters, people can now create an iterator to go
> > > > > through all resources or only the resources of a task.
> > > > >
> > > > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > > > ---
> > > > >  include/linux/bpf.h            |  4 ++
> > > > >  include/uapi/linux/bpf.h       | 23 ++++++++++
> > > > >  kernel/bpf/task_iter.c         | 81 +++++++++++++++++++++++++-
> > > > > ----
> > > > > ----
> > > > >  tools/include/uapi/linux/bpf.h | 23 ++++++++++
> > > > >  4 files changed, 109 insertions(+), 22 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 11950029284f..c8d164404e20 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user
> > > > > *pathname, int flags);
> > > > >
> > > > >  struct bpf_iter_aux_info {
> > > > >         struct bpf_map *map;
> > > > > +       struct {
> > > > > +               __u32   tid;
> > > >
> > > > should be just u32 ?
> > >
> > > Or, should change the following 'type' to __u8?
> >
> > Would it be better to use a pidfd instead of a tid here? Unset pidfd
> > would mean going over all tasks, and any fd > 0 implies attaching to
> > a
> > specific task (as is the convention in BPF land). Most of the new
> > UAPIs working on processes are using pidfds (to work with a stable
> > handle instead of a reusable ID).
> > The iterator taking an fd also gives an opportunity to BPF LSMs to
> > attach permissions/policies to it (once we have a file local storage
> > map) e.g. whether creating a task iterator for that specific pidfd
> > instance (backed by the struct file) would be allowed or not.
> > You are using getpid in the selftest and keeping track of last_tgid
> > in
> > the iterator, so I guess you don't even need to extend pidfd_open to
> > work on thread IDs right now for your use case (and fdtable and mm
> > are
> > shared for POSIX threads anyway, so for those two it won't make a
> > difference).
> >
> > What is your opinion?
>
> Do you mean removed both tid and type, and replace them with a pidfd?
> We can do that in uapi, struct bpf_link_info.  But, the interal types,
> ex. bpf_iter_aux_info, still need to use tid or struct file to avoid
> getting file from the per-process fdtable.  Is that what you mean?
>

Yes, just for the UAPI, it is similar to taking map_fd for map iter.
In bpf_link_info we should report just the tid, just like map iter
reports map_id.
