Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A088B584411
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiG1QXj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG1QXi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 12:23:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5270E51
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 09:23:36 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z132so1786657iof.0
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tKqAm7sJj2/p4u2JLXe9uzoJeVSaQ6BXB5xIkjPJwQ=;
        b=Bz17P++gTQTovTiaSx7mO5zNF7161TVLxtNxm+bm78RifvPGmGNrUS9mT1ctNzVwFE
         6e1RuM1qiUmN5xgbLnWSTuXOnSwCCSK8vBhCp58w6lGLiokTJXv8UCEYF5e+RBnjIF2n
         PEhTokb5+aoL3iPo3V4lc8cF5nRcmI/I/lymu6/7BqjxZ6ud7nEB1xYgF/iE1fvFs743
         hWbzQ+wDmgKEsd58O9xRf0/QvG2e1kNHqXFyNpNDpssuguDv/PQ6sHRJruLNGQopGraD
         Tst0i72vPCfTTCw4XjYoB6a1AbkVzUFEF7FaAYNwCzM7Z3eH4Ynax3TfsrAQtfQUNTS5
         OF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tKqAm7sJj2/p4u2JLXe9uzoJeVSaQ6BXB5xIkjPJwQ=;
        b=Mhc+BizOlZw+YeYT9lsNt9QhG44cj2I5v52hhV4SKcOPHJ+9JYb0OE8wrmSdqBuriH
         bEZeJwX8UncqK5fq73RU0PviU0yF/nD2fkYttC9kurGk/Jj7wkV4J5j0qaHYTKgkBJ89
         8sYBqg4aqolrusLqfjZpeAZTdN7ia+4GOR+mzXJB1CDGSub8A9357mDYym6U+Le2vvcc
         zm7dBPOMa0n4J+d4oHZy2Fax331SGazrX9T18JPsLu7rBvN/rMPGZXGLpwmsC/kxQ3F5
         IKXskNI7p9cFE0tjgxxqyWN/aJqGX24kYLeGM4+pi2tUg2Ld1Jvx40ImPkEAt9xBIm+l
         BrGQ==
X-Gm-Message-State: AJIora9AR8i5b9Zrwe+KHTHhHaX5j8VDCUsC8We2X71nkYj8sfy55x6R
        piUsaOgqqV7ntYmLdTwq5x4rDfH/0cWGwYfKSr4=
X-Google-Smtp-Source: AGRyM1tJecE5or3C6+hEbs2qVgDcgJQpE67XaekPStC3/Rm9idkGc+usNfX4ySKb7ukB0p84QOa2rKnO6k5N2Gav8VY=
X-Received: by 2002:a02:c4c3:0:b0:33f:4fb4:834b with SMTP id
 h3-20020a02c4c3000000b0033f4fb4834bmr11363591jaj.231.1659025415826; Thu, 28
 Jul 2022 09:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220726051713.840431-1-kuifeng@fb.com> <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava> <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com> <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
In-Reply-To: <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 28 Jul 2022 18:22:58 +0200
Message-ID: <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
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

On Thu, 28 Jul 2022 at 17:16, Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Thu, 2022-07-28 at 10:47 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 28 Jul 2022 at 07:25, Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > On Wed, 2022-07-27 at 10:19 +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Wed, 27 Jul 2022 at 09:01, Kui-Feng Lee <kuifeng@fb.com>
> > > > wrote:
> > > > >
> > > > > On Tue, 2022-07-26 at 14:13 +0200, Jiri Olsa wrote:
> > > > > > On Mon, Jul 25, 2022 at 10:17:11PM -0700, Kui-Feng Lee wrote:
> > > > > > > Allow creating an iterator that loops through resources of
> > > > > > > one
> > > > > > > task/thread.
> > > > > > >
> > > > > > > People could only create iterators to loop through all
> > > > > > > resources of
> > > > > > > files, vma, and tasks in the system, even though they were
> > > > > > > interested
> > > > > > > in only the resources of a specific task or process.
> > > > > > > Passing
> > > > > > > the
> > > > > > > additional parameters, people can now create an iterator to
> > > > > > > go
> > > > > > > through all resources or only the resources of a task.
> > > > > > >
> > > > > > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > > > > > ---
> > > > > > >  include/linux/bpf.h            |  4 ++
> > > > > > >  include/uapi/linux/bpf.h       | 23 ++++++++++
> > > > > > >  kernel/bpf/task_iter.c         | 81
> > > > > > > +++++++++++++++++++++++++-
> > > > > > > ----
> > > > > > > ----
> > > > > > >  tools/include/uapi/linux/bpf.h | 23 ++++++++++
> > > > > > >  4 files changed, 109 insertions(+), 22 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > index 11950029284f..c8d164404e20 100644
> > > > > > > --- a/include/linux/bpf.h
> > > > > > > +++ b/include/linux/bpf.h
> > > > > > > @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char
> > > > > > > __user
> > > > > > > *pathname, int flags);
> > > > > > >
> > > > > > >  struct bpf_iter_aux_info {
> > > > > > >         struct bpf_map *map;
> > > > > > > +       struct {
> > > > > > > +               __u32   tid;
> > > > > >
> > > > > > should be just u32 ?
> > > > >
> > > > > Or, should change the following 'type' to __u8?
> > > >
> > > > Would it be better to use a pidfd instead of a tid here? Unset
> > > > pidfd
> > > > would mean going over all tasks, and any fd > 0 implies attaching
> > > > to
> > > > a
> > > > specific task (as is the convention in BPF land). Most of the new
> > > > UAPIs working on processes are using pidfds (to work with a
> > > > stable
> > > > handle instead of a reusable ID).
> > > > The iterator taking an fd also gives an opportunity to BPF LSMs
> > > > to
> > > > attach permissions/policies to it (once we have a file local
> > > > storage
> > > > map) e.g. whether creating a task iterator for that specific
> > > > pidfd
> > > > instance (backed by the struct file) would be allowed or not.
> > > > You are using getpid in the selftest and keeping track of
> > > > last_tgid
> > > > in
> > > > the iterator, so I guess you don't even need to extend pidfd_open
> > > > to
> > > > work on thread IDs right now for your use case (and fdtable and
> > > > mm
> > > > are
> > > > shared for POSIX threads anyway, so for those two it won't make a
> > > > difference).
> > > >
> > > > What is your opinion?
> > >
> > > Do you mean removed both tid and type, and replace them with a
> > > pidfd?
> > > We can do that in uapi, struct bpf_link_info.  But, the interal
> > > types,
> > > ex. bpf_iter_aux_info, still need to use tid or struct file to
> > > avoid
> > > getting file from the per-process fdtable.  Is that what you mean?
> > >
> >
> > Yes, just for the UAPI, it is similar to taking map_fd for map iter.
> > In bpf_link_info we should report just the tid, just like map iter
> > reports map_id.
>
> It sounds good to me.
>
> One thing I need a clarification. You mentioned that a fd > 0 implies
> attaching to a specific task, however fd can be 0. So, it should be fd
> >= 0. So, it forces the user to initialize the value of pidfd to -1.
> So, for convenience, we still need a field like 'type' to make it easy
> to create iterators without a filter.
>

Right, but in lots of BPF UAPI fields, fd 0 means fd is unset, so it
is fine to rely on that assumption. For e.g. even for map_fd,
bpf_map_elem iterator considers fd 0 to be unset. Then you don't need
the type field.

>
