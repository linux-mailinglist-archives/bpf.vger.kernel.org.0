Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7246584570
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiG1SBy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 14:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiG1SBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 14:01:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357972EE6
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 11:01:48 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y9so1677617qtv.5
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywbVw65SNW3n07hcVSFVm2Ks6BraA3qbEooam5onPaw=;
        b=UeQB5MVfM07cmiCtcJXENryyWNKEcrAzbCyFzKTN+VOk8PpKymWMdEbnIROi1lbjWA
         zW6pE+E97j0vWzMJGpIhIUJW5UW0qz1KPpv7iT8hFuhORKsQnWmrej5uthDGAFE+VP1F
         rCXewv4y1RVMZzvOffAfBry/DnpE1/GKvMuqkIMfWdw1xuOgJrYX2gFCE+/KWBTBbsJI
         8UiecIudCSPh7EeLshr9A3WPCVo84KrPG4CdZThq/VlmQWLfsbTqylbyjovfL+FSZzAy
         qWWVTeT77G37KQ7fN3XgC3TEEOj/wx2y0kflAR2CxKKCGgKxlgM6+zyw1EcoHEBFiylB
         wE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywbVw65SNW3n07hcVSFVm2Ks6BraA3qbEooam5onPaw=;
        b=h2Aezs3oSEF81Z7oivyfy5Ze9WR01TNQdYGGF6pxW9z+9RIqNFtdjFT1mr2SoF8i/D
         uSLN12ZyE8R8a4x5YsIKIgjkNd2BdqPw4fFqFwbzT03mUE4juBvg/CwnV1akD16HIH6w
         0BI1eyxcjAPP1aJlFtpo/eAeRwFKQ8OB9H1ByGCNuZZcwVYAMSs1E10MMOo8evmCMYzO
         rfEd0e2542qiJkMQmfQ47YfaUr5kIb7U4pS2550E50SXjXLDPuHzL/F90APHa3yUSkKg
         vHzQs+FzBaqnAVgDKlhlRYk1AyJJmqgEZIGECEjSEIjBHUD1w9tBD8x/9menEdCQwWYg
         2g9g==
X-Gm-Message-State: AJIora8vWO4QqDXDcIxy6uwX0gYLOe9sSaH4Vx7Ho0r7nXRBcQJQLYCG
        Hn871uoxSdXO8VXE/U/20sFwPMSK4YQJ+nfCFZsX5g==
X-Google-Smtp-Source: AGRyM1tp53HUS/mJaIt6FCo3E7vWKbDGyUjFe6hcpYbsmC+b9rLDNb+GCAvVvj5tv/MzcLLBresSr7mOKtFc0L+6z5o=
X-Received: by 2002:a05:622a:8e:b0:31f:371f:e6a1 with SMTP id
 o14-20020a05622a008e00b0031f371fe6a1mr88196qtw.565.1659031307090; Thu, 28 Jul
 2022 11:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220726051713.840431-1-kuifeng@fb.com> <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava> <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com> <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com> <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
In-Reply-To: <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 28 Jul 2022 11:01:36 -0700
Message-ID: <CA+khW7iFRiUVDr9=QimTxnEbHoDEa1kEmvLzCtmpcW_viSNN2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
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

On Thu, Jul 28, 2022 at 9:24 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 28 Jul 2022 at 17:16, Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > On Thu, 2022-07-28 at 10:47 +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Thu, 28 Jul 2022 at 07:25, Kui-Feng Lee <kuifeng@fb.com> wrote:
> > > >
> > > > On Wed, 2022-07-27 at 10:19 +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > On Wed, 27 Jul 2022 at 09:01, Kui-Feng Lee <kuifeng@fb.com>
> > > > > wrote:
> > > > > >
> > > > > > On Tue, 2022-07-26 at 14:13 +0200, Jiri Olsa wrote:
> > > > > > > On Mon, Jul 25, 2022 at 10:17:11PM -0700, Kui-Feng Lee wrote:
> > > > > > > > Allow creating an iterator that loops through resources of
> > > > > > > > one
> > > > > > > > task/thread.
> > > > > > > >
> > > > > > > > People could only create iterators to loop through all
> > > > > > > > resources of
> > > > > > > > files, vma, and tasks in the system, even though they were
> > > > > > > > interested
> > > > > > > > in only the resources of a specific task or process.
> > > > > > > > Passing
> > > > > > > > the
> > > > > > > > additional parameters, people can now create an iterator to
> > > > > > > > go
> > > > > > > > through all resources or only the resources of a task.
> > > > > > > >
> > > > > > > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > > > > > > ---
> > > > > > > >  include/linux/bpf.h            |  4 ++
> > > > > > > >  include/uapi/linux/bpf.h       | 23 ++++++++++
> > > > > > > >  kernel/bpf/task_iter.c         | 81
> > > > > > > > +++++++++++++++++++++++++-
> > > > > > > > ----
> > > > > > > > ----
> > > > > > > >  tools/include/uapi/linux/bpf.h | 23 ++++++++++
> > > > > > > >  4 files changed, 109 insertions(+), 22 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > > index 11950029284f..c8d164404e20 100644
> > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char
> > > > > > > > __user
> > > > > > > > *pathname, int flags);
> > > > > > > >
> > > > > > > >  struct bpf_iter_aux_info {
> > > > > > > >         struct bpf_map *map;
> > > > > > > > +       struct {
> > > > > > > > +               __u32   tid;
> > > > > > >
> > > > > > > should be just u32 ?
> > > > > >
> > > > > > Or, should change the following 'type' to __u8?
> > > > >
> > > > > Would it be better to use a pidfd instead of a tid here? Unset
> > > > > pidfd
> > > > > would mean going over all tasks, and any fd > 0 implies attaching
> > > > > to
> > > > > a
> > > > > specific task (as is the convention in BPF land). Most of the new
> > > > > UAPIs working on processes are using pidfds (to work with a
> > > > > stable
> > > > > handle instead of a reusable ID).
> > > > > The iterator taking an fd also gives an opportunity to BPF LSMs
> > > > > to
> > > > > attach permissions/policies to it (once we have a file local
> > > > > storage
> > > > > map) e.g. whether creating a task iterator for that specific
> > > > > pidfd
> > > > > instance (backed by the struct file) would be allowed or not.
> > > > > You are using getpid in the selftest and keeping track of
> > > > > last_tgid
> > > > > in
> > > > > the iterator, so I guess you don't even need to extend pidfd_open
> > > > > to
> > > > > work on thread IDs right now for your use case (and fdtable and
> > > > > mm
> > > > > are
> > > > > shared for POSIX threads anyway, so for those two it won't make a
> > > > > difference).
> > > > >
> > > > > What is your opinion?
> > > >
> > > > Do you mean removed both tid and type, and replace them with a
> > > > pidfd?
> > > > We can do that in uapi, struct bpf_link_info.  But, the interal
> > > > types,
> > > > ex. bpf_iter_aux_info, still need to use tid or struct file to
> > > > avoid
> > > > getting file from the per-process fdtable.  Is that what you mean?
> > > >
> > >
> > > Yes, just for the UAPI, it is similar to taking map_fd for map iter.
> > > In bpf_link_info we should report just the tid, just like map iter
> > > reports map_id.
> >
> > It sounds good to me.
> >
> > One thing I need a clarification. You mentioned that a fd > 0 implies
> > attaching to a specific task, however fd can be 0. So, it should be fd
> > >= 0. So, it forces the user to initialize the value of pidfd to -1.
> > So, for convenience, we still need a field like 'type' to make it easy
> > to create iterators without a filter.
> >
>
> Right, but in lots of BPF UAPI fields, fd 0 means fd is unset, so it
> is fine to rely on that assumption. For e.g. even for map_fd,
> bpf_map_elem iterator considers fd 0 to be unset. Then you don't need
> the type field.
>

FD 0 is STDIN, unless someone explicitly close(0). IMO using fd 0 for
default behavior is fine.

Hao

> >
