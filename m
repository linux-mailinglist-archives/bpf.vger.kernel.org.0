Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6A4FFED2
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbiDMTOZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiDMTM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 15:12:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C7A74846
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:08:24 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p135so3000067iod.2
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bAx65acNi9XbjWA7LzZxLSVUyzvncSUzsZZBOgbNA8=;
        b=jRr0fWinUibyOh7oj02jlJtC2dwNDv7xnlC0m5+WLS0sQ5xMVjrldmPY6L3W8giIeB
         eQ96bKn3Ny/wgyVIGiwb3RsTxO/e58Op2s2V0kMkYSSk0JwEJmDpKY245fob57JTGIKg
         IN6DAM+/kJZe3CVxfGa6RSstkFZevEdZf9RhNbE8XQDEhuzBTu2QSY+0wjH26SwO5vQX
         PCKK8f8JRyRWiHvFqxasyJY1PtXC3xgf4cAbzt02lzLHcx0jxPzz1YHWc/UaqYta6CXk
         anoXEhaKgithsww1K7ER8kJxlRzKrXBIhmLxs/6ZiaBjj3dNlrS1HTVIk/YvONSYg62r
         SaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bAx65acNi9XbjWA7LzZxLSVUyzvncSUzsZZBOgbNA8=;
        b=Q05Rbkcv5Nm0cyG/NtrMD1LEexXcyQn6ha3ZInYSveqxgR1tv7V/DqFrE8JZj81Pia
         QyiUXJqnjH9xHxPUMu6axzGXNnAcPkwou0mmyelAMzzDZRTSoiHC6MvztsC6336++HaA
         evUHXpVn9GR+Q7/tv5LPnvgpSSlFeK9/ms+Nr10ggNw1Ab1wH2GF5KbudxtbX1Jgiwp7
         ascMEikxsCowb9rd4Tx8fcPPoU8GIwtBnetcDwbOFnEOVBy+of+yX531uLqk1emLInc5
         QNYBDqO5ooVx+C+mD+OVddlKF3UNrcjzdgWC5u2hfUtW3Hbwk4XRpKG3i9//Tp/XV3lx
         vNuQ==
X-Gm-Message-State: AOAM532Dgo6xq6ELxGSOvU5nZau2r4G25REUIU1qPWSIjpIVN8llu9oD
        b5Op3U8LAWLWeJXVZwETqbSmjIxX7T3yI+ht2OoPyf+o
X-Google-Smtp-Source: ABdhPJwQsEygNCFbgvGHFmb6f/DlSWXIkTlXs0qD/LU6T1wYnbT00izjjU6Tl6QJPB2Ce0eEEMBPvJx+19aFEQ9gW7U=
X-Received: by 2002:a05:6602:735:b0:64c:adf1:ae09 with SMTP id
 g21-20020a056602073500b0064cadf1ae09mr18264150iox.79.1649876903250; Wed, 13
 Apr 2022 12:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220412165555.4146407-1-kuifeng@fb.com> <20220412165555.4146407-2-kuifeng@fb.com>
 <CAEf4BzapYFLns4iDiiRx9PpXftNDOc9jVswwcU_e3ncOeJSvMg@mail.gmail.com> <dfd67ec4f86552273a89a25f264dcb9e349f3898.camel@fb.com>
In-Reply-To: <dfd67ec4f86552273a89a25f264dcb9e349f3898.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Apr 2022 12:08:12 -0700
Message-ID: <CAEf4BzZ7j19ML21kDUPB8C5o1CySXhtBfQ=nco0DuJkbh8e7yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf, x86: Generate trampolines from bpf_tramp_links
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
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

On Wed, Apr 13, 2022 at 10:53 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Tue, 2022-04-12 at 19:43 -0700, Andrii Nakryiko wrote:
> > On Tue, Apr 12, 2022 at 9:56 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Replace struct bpf_tramp_progs with struct bpf_tramp_links to
> > > collect
> > > struct bpf_tramp_link(s) for a trampoline.  struct bpf_tramp_link
> > > extends bpf_link to act as a linked list node.
> > >
> > > arch_prepare_bpf_trampoline() accepts a struct bpf_tramp_links to
> > > collects all bpf_tramp_link(s) that a trampoline should call.
> > >
> > > Change BPF trampoline and bpf_struct_ops to pass bpf_tramp_links
> > > instead of bpf_tramp_progs.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> >
> > Looks good, see two comments below.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > >  arch/x86/net/bpf_jit_comp.c    | 36 +++++++++--------
> > >  include/linux/bpf.h            | 38 ++++++++++++------
> > >  include/linux/bpf_types.h      |  1 +
> > >  include/uapi/linux/bpf.h       |  1 +
> > >  kernel/bpf/bpf_struct_ops.c    | 69 ++++++++++++++++++++++--------
> > > --
> > >  kernel/bpf/syscall.c           | 23 ++++-------
> > >  kernel/bpf/trampoline.c        | 73 +++++++++++++++++++-----------
> > > ----
> > >  net/bpf/bpf_dummy_struct_ops.c | 35 +++++++++++++---
> > >  tools/bpf/bpftool/link.c       |  1 +
> > >  tools/include/uapi/linux/bpf.h |  1 +
> > >  10 files changed, 175 insertions(+), 103 deletions(-)
> > >
> >
> > [...]
> >
> > >  /* Different use cases for BPF trampoline:
> > > @@ -704,7 +704,7 @@ struct bpf_tramp_progs {
> > >  struct bpf_tramp_image;
> > >  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void
> > > *image, void *image_end,
> > >                                 const struct btf_func_model *m, u32
> > > flags,
> > > -                               struct bpf_tramp_progs *tprogs,
> > > +                               struct bpf_tramp_links *tlinks,
> > >                                 void *orig_call);
> > >  /* these two functions are called from generated trampoline */
> > >  u64 notrace __bpf_prog_enter(struct bpf_prog *prog);
> > > @@ -803,9 +803,12 @@ static __always_inline __nocfi unsigned int
> > > bpf_dispatcher_nop_func(
> > >  {
> > >         return bpf_func(ctx, insnsi);
> > >  }
> > > +
> > > +struct bpf_link;
> > > +
> >
> > is this forward declaration still needed? was it supposed to be a
> > struct bpf_tramp_link instead? and also probably higher above, before
> > bpf_tramp_links?
>
> You are right, I should remvoe it.
>
> >
> > >  #ifdef CONFIG_BPF_JIT
> > > -int bpf_trampoline_link_prog(struct bpf_prog *prog, struct
> > > bpf_trampoline *tr);
> > > -int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct
> > > bpf_trampoline *tr);
> > > +int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct
> > > bpf_trampoline *tr);
> > > +int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct
> > > bpf_trampoline *tr);
> > >  struct bpf_trampoline *bpf_trampoline_get(u64 key,
> > >                                           struct
> > > bpf_attach_target_info *tgt_info);
> > >  void bpf_trampoline_put(struct bpf_trampoline *tr);
> > > @@ -856,12 +859,12 @@ int bpf_jit_charge_modmem(u32 size);
> > >  void bpf_jit_uncharge_modmem(u32 size);
> > >  bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
> > >  #else
> > > -static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
> > > +static inline int bpf_trampoline_link_prog(struct bpf_tramp_link
> > > *link,
> > >                                            struct bpf_trampoline
> > > *tr)
> > >  {
> > >         return -ENOTSUPP;
> > >  }
> > > -static inline int bpf_trampoline_unlink_prog(struct bpf_prog
> > > *prog,
> > > +static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link
> > > *link,
> > >                                              struct bpf_trampoline
> > > *tr)
> > >  {
> > >         return -ENOTSUPP;
> > > @@ -960,7 +963,6 @@ struct bpf_prog_aux {
> > >         bool tail_call_reachable;
> > >         bool xdp_has_frags;
> > >         bool use_bpf_prog_pack;
> > > -       struct hlist_node tramp_hlist;
> > >         /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
> > >         const struct btf_type *attach_func_proto;
> > >         /* function name for valid attach_btf_id */
> > > @@ -1047,6 +1049,18 @@ struct bpf_link_ops {
> > >                               struct bpf_link_info *info);
> > >  };
> > >
> > > +struct bpf_tramp_link {
> > > +       struct bpf_link link;
> > > +       struct hlist_node tramp_hlist;
> > > +};
> > > +
> > > https://docs.google.com/document/d/1FYYdi1Hw4pjulbkvI1VmG-kGqTJRCg7bh1vAF4bwjMc/edit?usp=sharing
> > > +struct bpf_tracing_link {
> > > +       struct bpf_tramp_link link;
> > > +       enum bpf_attach_type attach_type;
> > > +       struct bpf_trampoline *trampoline;
> > > +       struct bpf_prog *tgt_prog;
> > > +};
> >
> > struct bpf_tracing_link can stay in syscall.c, no? don't see anyone
> > needing it outside of syscall.c
>
> It will be used by invoke_bpf_prog() of bpf_jit_comp.c in the 3rd patch
> to get the cookie value.
>

Yep, saw it when I got to it, forgot to mention it here. Ignore this suggestion.

> >
> > > +
> > >  struct bpf_link_primer {
> > >         struct bpf_link *link;
> > >         struct file *file;
> > > @@ -1084,8 +1098,8 @@ bool bpf_struct_ops_get(const void *kdata);
> > >  void bpf_struct_ops_put(const void *kdata);
> > >  int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void
> > > *key,
> > >                                        void *value);
> > > -int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs
> > > *tprogs,
> > > -                                     struct bpf_prog *prog,
> > > +int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links
> > > *tlinks,
> > > +                                     struct bpf_tramp_link *link,
> > >                                       const struct btf_func_model
> > > *model,
> > >                                       void *image, void *image_end);
> >
> > [...]
>
